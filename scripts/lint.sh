#!/usr/bin/env bash
# scripts/lint.sh: meta-linter for the ready-suite (monorepo layout).
#
# Mechanically enforces the suite's discipline rules. Replaces "the rule
# says X" with "CI fails if X is violated."
#
# Checks (run with --all, default):
#
#   suite-md-sync          SUITE.md byte-identical between hub and each
#                          skills/<skill>/ subdir
#   frontmatter-version    SKILL.md version matches CHANGELOG top entry
#   suite-release          root VERSION matches every skill and meta plugin
#   unicode-clean          no em-dashes / arrows / box drawing in
#                          suite-authored files (SUITE.md whole-file,
#                          hub policy docs, top CHANGELOG entry,
#                          hub scripts, install/uninstall/ORCHESTRATORS)
#   compatible-with        compatible_with frontmatter contains the
#                          expected standards-level values
#   plugin-sync            plugin manifests and vendored skill files match
#                          the canonical skills/<skill>/ sources
#   trigger-overlap        cross-skill substring overlaps in description
#                          trigger phrases (advisory; warns but does
#                          not fail unless --strict-triggers)
#
# Usage:
#   bash scripts/lint.sh [check-name | --all] [--verbose] [--fail-fast]
#
# Bash 3.2 compatible (macOS default). No associative arrays, no mapfile.

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HUB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="$HUB_DIR/skills"
PLUGINS_DIR="$HUB_DIR/plugins"

SKILLS="kickoff-ready prd-ready architecture-ready roadmap-ready stack-ready repo-ready production-ready deploy-ready observe-ready launch-ready harden-ready"
ALL_REPOS="$SKILLS ready-suite"

# Standards-level compatible_with values every skill must declare.
# antigravity is allowed-but-not-required (kickoff-ready has it).
EXPECTED_COMPAT="claude-code codex cursor windsurf pi openclaw any-agentskills-compatible-harness"

# Forbidden unicode in suite-authored files.
# Byte escapes cover U+2014, U+2013, U+2015, U+2010, U+2012,
# U+2212, U+2192, U+2190, U+2191, and U+2193.
FORBIDDEN_PATTERN="$(printf '\342\200\224|\342\200\223|\342\200\225|\342\200\220|\342\200\222|\342\210\222|\342\206\222|\342\206\220|\342\206\221|\342\206\223')"

VERBOSE=0
FAIL_FAST=0
STRICT_TRIGGERS=0
SELECTED="--all"

# Stopword tokens stripped from trigger phrases before overlap detection.
# Generic English connectives and common verbs that do not carry the
# domain signal we care about. Keep concrete domain words (pipeline,
# database, monitoring, etc.) OUT of this list - they ARE the signal.
TRIGGER_STOPWORDS=" set up add make use this that the and or for new what when where which who how why a an of in on it is be by from to with vs versus or pick choose write build define your my our any all do does not no yes if as also "

if [ -t 1 ]; then
  C_RESET="$(printf '\033[0m')"
  C_BOLD="$(printf '\033[1m')"
  C_DIM="$(printf '\033[2m')"
  C_GREEN="$(printf '\033[32m')"
  C_YELLOW="$(printf '\033[33m')"
  C_RED="$(printf '\033[31m')"
  C_CYAN="$(printf '\033[36m')"
else
  C_RESET=""; C_BOLD=""; C_DIM=""; C_GREEN=""; C_YELLOW=""; C_RED=""; C_CYAN=""
fi

usage() {
  cat <<EOF
ready-suite-lint: meta-linter for the ready-suite (monorepo)

Usage: bash scripts/lint.sh [check | --all] [--verbose] [--fail-fast]

Checks:
  suite-md-sync         SUITE.md byte-identical hub vs skills/<skill>/
  frontmatter-version   SKILL.md version matches CHANGELOG top entry
  suite-release         root VERSION matches every skill and meta plugin
  unicode-clean         no em-dashes / arrows / box drawing in suite-authored files
  compatible-with       compatible_with frontmatter standards-level values
  plugin-sync           plugin manifests and vendored skill files match canonical sources
  trigger-overlap       cross-skill trigger-phrase substring overlaps (advisory)

Flags:
  --all                run every check (default)
  --verbose            show ok lines, not just failures
  --fail-fast          stop at the first failing check
  --strict-triggers    fail (non-zero exit) on trigger-overlap warnings
                       (default: advisory only)
  -h, --help           this help
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --all|--verbose|--fail-fast|--strict-triggers) ;;
    -h|--help) usage; exit 0 ;;
    --*) printf "%sunknown flag: %s%s\n" "$C_RED" "$1" "$C_RESET" >&2; usage >&2; exit 2 ;;
    *) ;;
  esac
  case "$1" in
    --verbose) VERBOSE=1 ;;
    --fail-fast) FAIL_FAST=1 ;;
    --strict-triggers) STRICT_TRIGGERS=1 ;;
    --all) SELECTED="--all" ;;
    suite-md-sync|frontmatter-version|suite-release|unicode-clean|compatible-with|plugin-sync|trigger-overlap) SELECTED="$1" ;;
  esac
  shift
done

ok()    { printf "  %sok%s    %s\n" "$C_GREEN" "$C_RESET" "$*"; }
warn()  { printf "  %swarn%s  %s\n" "$C_YELLOW" "$C_RESET" "$*"; }
err()   { printf "  %sfail%s  %s\n" "$C_RED" "$C_RESET" "$*"; }
info()  { printf "%s%s%s\n" "$C_DIM" "$*" "$C_RESET"; }
section() { printf "\n%s%s%s\n" "$C_BOLD" "$*" "$C_RESET"; }
vok()   { [ "$VERBOSE" = "1" ] && ok "$@" || true; }

repo_dir_for() {
  local skill="$1"
  if [ "$skill" = "ready-suite" ]; then
    printf "%s" "$HUB_DIR"
  else
    printf "%s/%s" "$SKILLS_DIR" "$skill"
  fi
}

# Extract version from SKILL.md frontmatter.
skill_version() {
  awk '/^version:/{print $2; exit}' "$1/SKILL.md"
}

# Extract top CHANGELOG version (the first "## v<x.y.z>" entry).
changelog_top_version() {
  awk '/^## v/ {sub(/^## v/, ""); sub(/ .*/, ""); print; exit}' "$1/CHANGELOG.md"
}

# Extract compatible_with values from SKILL.md.
compatible_with_values() {
  awk '
    /^compatible_with:/ {flag=1; next}
    flag && /^[a-z_]+:/ {flag=0}
    flag && /^---$/ {flag=0}
    flag && /^  - / {sub(/^  - /, ""); print}
  ' "$1/SKILL.md"
}

# Extract one JSON string value from a simple manifest file.
json_string_value() {
  awk -v k="$2" -F'"' '$2 == k {print $4; exit}' "$1"
}

# Extract the suite release-train version from root VERSION.
suite_version() {
  if [ -f "$HUB_DIR/VERSION" ]; then
    sed -n '1p' "$HUB_DIR/VERSION" | tr -d '[:space:]'
  fi
}

# Top CHANGELOG entry as text (first "## v" block, exclusive of next).
changelog_top_entry() {
  awk '/^## v/{c++} c==1{print} c==2{exit}' "$1/CHANGELOG.md"
}

# -----------------------------------------------------------------------
# Check: suite-md-sync
# -----------------------------------------------------------------------
check_suite_md_sync() {
  section "suite-md-sync"
  local hub_md skill sib_md fail
  hub_md="$HUB_DIR/SUITE.md"
  fail=0
  if [ ! -f "$hub_md" ]; then
    err "hub SUITE.md missing at $hub_md"
    return 1
  fi
  for skill in $SKILLS; do
    sib_md="$(repo_dir_for "$skill")/SUITE.md"
    if [ ! -f "$sib_md" ]; then
      err "$skill: SUITE.md missing"
      fail=$((fail + 1))
      continue
    fi
    if cmp -s "$hub_md" "$sib_md"; then
      vok "$skill: byte-identical"
    else
      err "$skill: SUITE.md differs from hub"
      fail=$((fail + 1))
    fi
  done
  return "$fail"
}

# -----------------------------------------------------------------------
# Check: frontmatter-version
# -----------------------------------------------------------------------
check_frontmatter_version() {
  section "frontmatter-version"
  local skill s_dir ver cl_ver fail
  fail=0
  for skill in $SKILLS; do
    s_dir="$(repo_dir_for "$skill")"
    if [ ! -f "$s_dir/SKILL.md" ]; then
      err "$skill: SKILL.md missing"
      fail=$((fail + 1))
      continue
    fi
    if [ ! -f "$s_dir/CHANGELOG.md" ]; then
      err "$skill: CHANGELOG.md missing"
      fail=$((fail + 1))
      continue
    fi
    ver="$(skill_version "$s_dir")"
    cl_ver="$(changelog_top_version "$s_dir")"
    if [ -z "$ver" ]; then
      err "$skill: version not parseable from SKILL.md frontmatter"
      fail=$((fail + 1))
      continue
    fi
    if [ -z "$cl_ver" ]; then
      err "$skill: top CHANGELOG entry not parseable"
      fail=$((fail + 1))
      continue
    fi
    if [ "$ver" = "$cl_ver" ]; then
      vok "$skill: v$ver matches"
    else
      err "$skill: frontmatter v$ver != CHANGELOG v$cl_ver"
      fail=$((fail + 1))
    fi
  done
  return "$fail"
}

# -----------------------------------------------------------------------
# Check: suite-release
# -----------------------------------------------------------------------
check_suite_release() {
  section "suite-release"
  local version skill s_dir meta_plugin marketplace meta_version market_version fail
  fail=0
  version="$(suite_version)"
  if [ -z "$version" ]; then
    err "VERSION missing or empty"
    return 1
  fi
  if ! printf "%s" "$version" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'; then
    err "VERSION is not semver: $version"
    return 1
  fi

  for skill in $SKILLS; do
    s_dir="$(repo_dir_for "$skill")"
    if [ "$(skill_version "$s_dir")" != "$version" ]; then
      err "$skill: SKILL.md version does not match suite VERSION $version"
      fail=$((fail + 1))
    elif [ "$(changelog_top_version "$s_dir")" != "$version" ]; then
      err "$skill: CHANGELOG.md top entry does not match suite VERSION $version"
      fail=$((fail + 1))
    else
      vok "$skill: release-train v$version"
    fi
  done

  meta_plugin="$PLUGINS_DIR/ready-suite/.claude-plugin/plugin.json"
  marketplace="$HUB_DIR/.claude-plugin/marketplace.json"
  if [ ! -f "$meta_plugin" ]; then
    err "ready-suite meta plugin manifest missing"
    fail=$((fail + 1))
  else
    meta_version="$(json_string_value "$meta_plugin" version)"
    if [ "$meta_version" != "$version" ]; then
      err "ready-suite meta plugin v$meta_version != suite VERSION $version"
      fail=$((fail + 1))
    else
      vok "ready-suite meta plugin v$version"
    fi
  fi
  if [ ! -f "$marketplace" ]; then
    err "marketplace manifest missing"
    fail=$((fail + 1))
  else
    market_version="$(json_string_value "$marketplace" version)"
    if [ "$market_version" != "$version" ]; then
      err "marketplace metadata v$market_version != suite VERSION $version"
      fail=$((fail + 1))
    else
      vok "marketplace metadata v$version"
    fi
  fi
  return "$fail"
}

# -----------------------------------------------------------------------
# Check: unicode-clean
# -----------------------------------------------------------------------
# SUITE.md whole-file: byte-identical across 12 repos; must stay clean.
# Hub policy docs whole-file: hub canonical; sibling READMEs are out of
#   scope (legacy em-dashes pre-date the rule).
# Top CHANGELOG entry only: legacy entries below the top may have
#   pre-existing em-dashes from before the rule landed.
# Hub-only files: install.sh, uninstall.sh, ORCHESTRATORS.md.
check_unicode_clean() {
  section "unicode-clean"
  local fail bad skill s_dir f content
  fail=0
  # SUITE.md (any repo, since they're identical, but check all so we
  # catch a sibling that drifted from a clean hub).
  for skill in $ALL_REPOS; do
    s_dir="$(repo_dir_for "$skill")"
    f="$s_dir/SUITE.md"
    if [ -f "$f" ]; then
      bad="$(grep -nE "$FORBIDDEN_PATTERN" "$f" 2>/dev/null || true)"
      if [ -n "$bad" ]; then
        err "$skill: SUITE.md has forbidden unicode"
        echo "$bad" | head -3 | sed 's/^/        /'
        fail=$((fail + 1))
      else
        vok "$skill: SUITE.md clean"
      fi
    fi
  done
  # Hub policy docs and high-blast-radius files.
  for f in README.md MAINTAINING.md CONTRIBUTING.md AGENTS.md SECURITY.md RELEASE-CHECKLIST.md VERSION install.sh uninstall.sh ORCHESTRATORS.md scripts/lint.sh scripts/refresh-plugin-skills.sh scripts/bump-suite-version.sh; do
    if [ -f "$HUB_DIR/$f" ]; then
      bad="$(grep -nE "$FORBIDDEN_PATTERN" "$HUB_DIR/$f" 2>/dev/null || true)"
      if [ -n "$bad" ]; then
        err "ready-suite: $f has forbidden unicode"
        echo "$bad" | head -3 | sed 's/^/        /'
        fail=$((fail + 1))
      else
        vok "ready-suite: $f clean"
      fi
    fi
  done
  # Top CHANGELOG entry per skill.
  for skill in $SKILLS; do
    s_dir="$(repo_dir_for "$skill")"
    if [ -f "$s_dir/CHANGELOG.md" ]; then
      content="$(changelog_top_entry "$s_dir")"
      if printf "%s" "$content" | grep -qE "$FORBIDDEN_PATTERN"; then
        err "$skill: top CHANGELOG entry has forbidden unicode"
        printf "%s" "$content" | grep -nE "$FORBIDDEN_PATTERN" | head -3 | sed 's/^/        /'
        fail=$((fail + 1))
      else
        vok "$skill: top CHANGELOG entry clean"
      fi
    fi
  done
  return "$fail"
}

# -----------------------------------------------------------------------
# Check: compatible-with
# -----------------------------------------------------------------------
check_compatible_with() {
  section "compatible-with"
  local skill s_dir values ex fail
  fail=0
  for skill in $SKILLS; do
    s_dir="$(repo_dir_for "$skill")"
    values="$(compatible_with_values "$s_dir")"
    if [ -z "$values" ]; then
      err "$skill: compatible_with frontmatter empty or missing"
      fail=$((fail + 1))
      continue
    fi
    local skill_fail=0
    for ex in $EXPECTED_COMPAT; do
      if ! printf "%s\n" "$values" | grep -qx "$ex"; then
        err "$skill: compatible_with missing '$ex'"
        fail=$((fail + 1))
        skill_fail=1
      fi
    done
    if [ "$skill_fail" = "0" ]; then
      vok "$skill: all standards-level values present"
    fi
  done
  return "$fail"
}

# -----------------------------------------------------------------------
# Check: plugin-sync
# -----------------------------------------------------------------------
check_plugin_sync() {
  section "plugin-sync"
  local skill s_dir p_dir manifest vendored version plugin_version fail
  local homepage repository expected_url skill_fail
  local meta_plugin marketplace
  fail=0
  for skill in $SKILLS; do
    s_dir="$(repo_dir_for "$skill")"
    p_dir="$PLUGINS_DIR/$skill"
    manifest="$p_dir/.claude-plugin/plugin.json"
    vendored="$p_dir/skills/$skill"
    skill_fail=0

    if [ ! -f "$manifest" ]; then
      err "$skill: plugin manifest missing"
      fail=$((fail + 1))
      continue
    fi
    if [ ! -f "$vendored/SKILL.md" ]; then
      err "$skill: vendored SKILL.md missing"
      fail=$((fail + 1))
      continue
    fi

    version="$(skill_version "$s_dir")"
    plugin_version="$(json_string_value "$manifest" version)"
    if [ "$version" != "$plugin_version" ]; then
      err "$skill: plugin manifest v$plugin_version != SKILL.md v$version"
      fail=$((fail + 1))
      skill_fail=1
    fi

    expected_url="https://github.com/aihxp/ready-suite/tree/main/skills/$skill"
    homepage="$(json_string_value "$manifest" homepage)"
    repository="$(json_string_value "$manifest" repository)"
    if [ "$homepage" != "$expected_url" ]; then
      err "$skill: plugin homepage does not point at monorepo skill path"
      fail=$((fail + 1))
      skill_fail=1
    fi
    if [ "$repository" != "$expected_url" ]; then
      err "$skill: plugin repository does not point at monorepo skill path"
      fail=$((fail + 1))
      skill_fail=1
    fi

    if ! cmp -s "$s_dir/SKILL.md" "$vendored/SKILL.md"; then
      err "$skill: vendored SKILL.md differs from canonical SKILL.md"
      fail=$((fail + 1))
      skill_fail=1
    fi

    if [ -d "$s_dir/references" ]; then
      if [ ! -d "$vendored/references" ]; then
        err "$skill: vendored references/ missing"
        fail=$((fail + 1))
        skill_fail=1
      elif ! diff -qr "$s_dir/references" "$vendored/references" >/dev/null; then
        err "$skill: vendored references/ differs from canonical references/"
        fail=$((fail + 1))
        skill_fail=1
      fi
    elif [ -e "$vendored/references" ]; then
      err "$skill: vendored references/ exists but canonical references/ is absent"
      fail=$((fail + 1))
      skill_fail=1
    fi

    if [ "$skill_fail" = "0" ]; then
      vok "$skill: manifest and vendored files match"
    fi
  done

  meta_plugin="$PLUGINS_DIR/ready-suite/.claude-plugin/plugin.json"
  marketplace="$HUB_DIR/.claude-plugin/marketplace.json"
  if [ ! -f "$meta_plugin" ]; then
    err "ready-suite: meta plugin manifest missing"
    fail=$((fail + 1))
  else
    for skill in $SKILLS; do
      if ! grep -q "\"$skill\"" "$meta_plugin"; then
        err "ready-suite: meta plugin dependency missing $skill"
        fail=$((fail + 1))
      fi
    done
    vok "ready-suite: meta plugin dependencies present"
  fi
  if [ ! -f "$marketplace" ]; then
    err "ready-suite: marketplace manifest missing"
    fail=$((fail + 1))
  else
    if ! grep -q '"source": "./plugins/ready-suite"' "$marketplace"; then
      err "ready-suite: marketplace missing meta plugin source"
      fail=$((fail + 1))
    fi
    for skill in $SKILLS; do
      if ! grep -q "\"source\": \"./plugins/$skill\"" "$marketplace"; then
        err "ready-suite: marketplace source missing $skill"
        fail=$((fail + 1))
      fi
    done
    vok "ready-suite: marketplace sources present"
  fi
  return "$fail"
}

# -----------------------------------------------------------------------
# Check: trigger-overlap
# -----------------------------------------------------------------------
# Extracts trigger phrases from each skill's description frontmatter
# (single-quoted strings inside the description) and reports cross-skill
# substring overlaps for phrases of significant length.
#
# Scope rules:
# - Phrase length >= 8 characters after normalization (lowercase + strip
#   non-alphanumeric except spaces). Filters generic short tokens.
# - Phrases consisting entirely of stopwords (TRIGGER_STOPWORDS) are
#   excluded.
# - The longer phrase contains the shorter as a whole-word substring.
# - Same-skill overlaps are ignored (a skill can have related triggers).
#
# Advisory only by default; --strict-triggers makes failures non-zero.
# Surfacing a new overlap is a prompt to add a row to
# references/TRIGGER-DISAMBIGUATION.md, not necessarily a real bug.
# Strip stopwords from a normalized phrase. Echoes the result.
strip_stopwords() {
  local phrase="$1"
  local out="" word
  for word in $phrase; do
    case "$TRIGGER_STOPWORDS" in
      *" $word "*) ;;
      *) out="$out $word" ;;
    esac
  done
  printf "%s" "$out" | sed 's/^ //; s/ $//'
}

check_trigger_overlap() {
  section "trigger-overlap"
  local fail tmp_index skill s_dir desc q phrase norm core
  fail=0
  tmp_index="$(mktemp)"

  for skill in $SKILLS; do
    s_dir="$(repo_dir_for "$skill")"
    if [ ! -f "$s_dir/SKILL.md" ]; then continue; fi
    desc="$(awk '/^description:/{flag=1} flag{print; if (/"$/) exit}' "$s_dir/SKILL.md")"
    printf "%s" "$desc" | grep -oE "'[^']+'" | while read -r q; do
      phrase="$(printf "%s" "$q" | sed "s/^'//; s/'\$//")"
      norm="$(printf "%s" "$phrase" | tr '[:upper:]' '[:lower:]' | tr -c '[:alnum:] ' ' ' | tr -s ' ' | sed 's/^ //; s/ $//')"
      if [ -z "$norm" ]; then continue; fi
      core="$(strip_stopwords "$norm")"
      # Require >= 2 signal tokens to avoid spurious single-token matches.
      local toks=0 t
      for t in $core; do toks=$((toks + 1)); done
      if [ "$toks" -lt 2 ]; then continue; fi
      printf "%s\t%s\t%s\n" "$skill" "$core" "$phrase" >> "$tmp_index"
    done
  done

  local found=0
  # For each (skill, core_phrase) pair, check whole-word substring
  # containment against every other skill's core phrases. Sort skills
  # lexicographically so we report each pair at most once.
  while IFS="$(printf '\t')" read -r s1 p1 orig1; do
    while IFS="$(printf '\t')" read -r s2 p2 orig2; do
      if [ "$s1" = "$s2" ]; then continue; fi
      if [ "$s1" \> "$s2" ]; then continue; fi
      if [ "$p1" = "$p2" ]; then
        warn "$s1 / $s2: shared core \"$p1\" (\"$orig1\" vs \"$orig2\")"
        found=$((found + 1))
        continue
      fi
      case " $p2 " in
        *" $p1 "*)
          warn "$s1 / $s2: \"$p1\" inside \"$p2\" (\"$orig1\" vs \"$orig2\")"
          found=$((found + 1))
          continue ;;
      esac
      case " $p1 " in
        *" $p2 "*)
          warn "$s1 / $s2: \"$p2\" inside \"$p1\" (\"$orig2\" vs \"$orig1\")"
          found=$((found + 1))
          continue ;;
      esac
    done < "$tmp_index"
  done < "$tmp_index"

  rm -f "$tmp_index"

  if [ "$found" = "0" ]; then
    ok "no cross-skill trigger substring overlaps detected"
  else
    info "  $found overlap(s). Each is advisory; verify a row exists in references/TRIGGER-DISAMBIGUATION.md or that the overlap is genuinely tier-distinct."
    if [ "$STRICT_TRIGGERS" = "1" ]; then
      fail="$found"
    fi
  fi
  return "$fail"
}

# -----------------------------------------------------------------------
# Runner
# -----------------------------------------------------------------------
run_check() {
  local name="$1"
  local result=0
  case "$name" in
    suite-md-sync)        check_suite_md_sync;        result=$? ;;
    frontmatter-version)  check_frontmatter_version;  result=$? ;;
    suite-release)        check_suite_release;        result=$? ;;
    unicode-clean)        check_unicode_clean;        result=$? ;;
    compatible-with)      check_compatible_with;      result=$? ;;
    plugin-sync)          check_plugin_sync;          result=$? ;;
    trigger-overlap)      check_trigger_overlap;      result=$? ;;
    *) err "unknown check: $name"; return 1 ;;
  esac
  if [ "$result" = "0" ]; then
    return 0
  else
    return "$result"
  fi
}

ALL_CHECKS="suite-md-sync frontmatter-version suite-release unicode-clean compatible-with plugin-sync trigger-overlap"

printf "\n%sready-suite-lint%s\n" "$C_BOLD" "$C_RESET"
info "  hub:    $HUB_DIR"
info "  skills: $SKILLS_DIR"

OVERALL_FAIL=0
TOTAL_CHECKS=0
FAILED_CHECKS=""

if [ "$SELECTED" = "--all" ]; then
  for c in $ALL_CHECKS; do
    set +e
    run_check "$c"
    cr=$?
    set -e
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [ "$cr" != "0" ]; then
      OVERALL_FAIL=$((OVERALL_FAIL + cr))
      FAILED_CHECKS="$FAILED_CHECKS $c"
      if [ "$FAIL_FAST" = "1" ]; then
        break
      fi
    fi
  done
else
  set +e
  run_check "$SELECTED"
  cr=$?
  set -e
  TOTAL_CHECKS=1
  if [ "$cr" != "0" ]; then
    OVERALL_FAIL="$cr"
    FAILED_CHECKS="$SELECTED"
  fi
fi

section "summary"
if [ "$OVERALL_FAIL" = "0" ]; then
  printf "  %sall checks passed%s (%d / %d)\n\n" "$C_GREEN" "$C_RESET" "$TOTAL_CHECKS" "$TOTAL_CHECKS"
  exit 0
else
  printf "  %s%d failures%s across:%s\n\n" "$C_RED" "$OVERALL_FAIL" "$C_RESET" "$FAILED_CHECKS"
  exit 1
fi

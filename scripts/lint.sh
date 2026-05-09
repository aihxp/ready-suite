#!/usr/bin/env bash
# scripts/lint.sh: meta-linter for the ready-suite.
#
# Mechanically enforces the suite's discipline rules. Replaces "the rule
# says X" with "CI fails if X is violated."
#
# Checks (run with --all, default):
#
#   suite-md-sync          SUITE.md byte-identical across all 12 repos
#   frontmatter-version    SKILL.md version matches CHANGELOG top entry
#   tag-release-parity     every git tag has a matching GitHub Release
#   unicode-clean          no em-dashes / arrows / box drawing in
#                          suite-authored files (SUITE.md whole-file,
#                          README.md whole-file, top CHANGELOG entry,
#                          hub install/uninstall/ORCHESTRATORS)
#   compatible-with        compatible_with frontmatter contains the
#                          expected standards-level values
#
# Usage:
#   bash scripts/lint.sh [check-name | --all] [--verbose] [--fail-fast]
#
# Env:
#   READY_SUITE_REPOS_DIR   where sibling repos live (default ~/Projects)
#
# Bash 3.2 compatible (macOS default). No associative arrays, no mapfile.

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HUB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REPOS_DIR="${READY_SUITE_REPOS_DIR:-${HOME}/Projects}"

SKILLS="kickoff-ready prd-ready architecture-ready roadmap-ready stack-ready repo-ready production-ready deploy-ready observe-ready launch-ready harden-ready"
ALL_REPOS="$SKILLS ready-suite"

# Standards-level compatible_with values every skill must declare.
# antigravity is allowed-but-not-required (kickoff-ready has it).
EXPECTED_COMPAT="claude-code codex cursor windsurf pi openclaw any-agentskills-compatible-harness"

# Forbidden unicode in suite-authored files.
# Em-dash, en-dash, horizontal-bar, hyphen, figure-dash, minus, arrows.
FORBIDDEN_PATTERN='—|–|―|‐|‒|−|→|←|↑|↓'

VERBOSE=0
FAIL_FAST=0
SELECTED="--all"

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
ready-suite-lint: meta-linter for the ready-suite

Usage: bash scripts/lint.sh [check | --all] [--verbose] [--fail-fast]

Checks:
  suite-md-sync         SUITE.md byte-identical across 12 repos
  frontmatter-version   SKILL.md version matches CHANGELOG top entry
  tag-release-parity    every git tag has a matching GitHub Release
  unicode-clean         no em-dashes / arrows / box drawing in suite-authored files
  compatible-with       compatible_with frontmatter standards-level values

Flags:
  --all          run every check (default)
  --verbose      show ok lines, not just failures
  --fail-fast    stop at the first failing check
  -h, --help     this help

Env:
  READY_SUITE_REPOS_DIR    where sibling repos live (default ~/Projects)
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --all|--verbose|--fail-fast) ;;
    -h|--help) usage; exit 0 ;;
    --*) printf "%sunknown flag: %s%s\n" "$C_RED" "$1" "$C_RESET" >&2; usage >&2; exit 2 ;;
    *) ;;
  esac
  case "$1" in
    --verbose) VERBOSE=1 ;;
    --fail-fast) FAIL_FAST=1 ;;
    --all) SELECTED="--all" ;;
    suite-md-sync|frontmatter-version|tag-release-parity|unicode-clean|compatible-with) SELECTED="$1" ;;
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
    printf "%s/%s" "$REPOS_DIR" "$skill"
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
# Check: tag-release-parity
# -----------------------------------------------------------------------
check_tag_release_parity() {
  section "tag-release-parity"
  local skill s_dir releases tag fail
  if ! command -v gh >/dev/null 2>&1; then
    warn "gh CLI not available; skipping tag-release-parity"
    return 0
  fi
  if ! gh auth status >/dev/null 2>&1; then
    warn "gh CLI not authenticated; skipping tag-release-parity"
    return 0
  fi
  fail=0
  for skill in $SKILLS; do
    s_dir="$(repo_dir_for "$skill")"
    if [ ! -d "$s_dir/.git" ]; then
      vok "$skill: not a git repo, skipping"
      continue
    fi
    releases="$(gh release list --repo "aihxp/$skill" --limit 200 --json tagName -q '.[].tagName' 2>/dev/null || true)"
    for tag in $(cd "$s_dir" && git tag -l); do
      if ! echo "$releases" | grep -qx "$tag"; then
        err "$skill: tag $tag has no GitHub Release"
        fail=$((fail + 1))
      fi
    done
    if [ "$fail" = "0" ] || [ "$VERBOSE" = "1" ]; then
      vok "$skill: every tag has a release"
    fi
  done
  return "$fail"
}

# -----------------------------------------------------------------------
# Check: unicode-clean
# -----------------------------------------------------------------------
# SUITE.md whole-file: byte-identical across 12 repos; must stay clean.
# README.md whole-file: hub canonical; sibling READMEs are out of scope
#   (legacy em-dashes pre-date the rule).
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
  # Hub README.md whole file.
  bad="$(grep -nE "$FORBIDDEN_PATTERN" "$HUB_DIR/README.md" 2>/dev/null || true)"
  if [ -n "$bad" ]; then
    err "ready-suite: README.md has forbidden unicode"
    echo "$bad" | head -3 | sed 's/^/        /'
    fail=$((fail + 1))
  else
    vok "ready-suite: README.md clean"
  fi
  # Hub install.sh, uninstall.sh, ORCHESTRATORS.md.
  for f in install.sh uninstall.sh ORCHESTRATORS.md; do
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
# Runner
# -----------------------------------------------------------------------
run_check() {
  local name="$1"
  local result=0
  case "$name" in
    suite-md-sync)        check_suite_md_sync;        result=$? ;;
    frontmatter-version)  check_frontmatter_version;  result=$? ;;
    tag-release-parity)   check_tag_release_parity;   result=$? ;;
    unicode-clean)        check_unicode_clean;        result=$? ;;
    compatible-with)      check_compatible_with;      result=$? ;;
    *) err "unknown check: $name"; return 1 ;;
  esac
  if [ "$result" = "0" ]; then
    return 0
  else
    return "$result"
  fi
}

ALL_CHECKS="suite-md-sync frontmatter-version tag-release-parity unicode-clean compatible-with"

printf "\n%sready-suite-lint%s\n" "$C_BOLD" "$C_RESET"
info "  hub:   $HUB_DIR"
info "  repos: $REPOS_DIR"

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

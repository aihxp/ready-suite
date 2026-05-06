#!/usr/bin/env bash
# refresh-plugin-skills.sh: re-vendor the eleven sibling skills into
# the Claude Code plugin tree. Regenerates each specialist plugin's
# manifest from upstream SKILL.md frontmatter, then re-copies SKILL.md
# and references/ into plugins/<skill>/skills/<skill>/.
#
# Run from the hub repo root. Reads dev copies from ~/Projects/<skill>/.
# After running, commit the changes and bump plugins/ready-suite/.claude-plugin/plugin.json
# manually if the meta plugin needs a new version.
#
# Bash 3.2 compatible.

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECTS_DIR="${HOME}/Projects"
PLUGINS_DIR="$REPO_ROOT/plugins"

SKILLS="kickoff-ready prd-ready architecture-ready roadmap-ready stack-ready repo-ready production-ready deploy-ready observe-ready launch-ready harden-ready"

if [ -t 1 ]; then
  C_RESET="$(printf '\033[0m')"; C_BOLD="$(printf '\033[1m')"
  C_GREEN="$(printf '\033[32m')"; C_RED="$(printf '\033[31m')"; C_YELLOW="$(printf '\033[33m')"
else
  C_RESET=""; C_BOLD=""; C_GREEN=""; C_RED=""; C_YELLOW=""
fi

ok()   { printf "  %sok%s    %s\n" "$C_GREEN" "$C_RESET" "$*"; }
warn() { printf "  %swarn%s  %s\n" "$C_YELLOW" "$C_RESET" "$*"; }
err()  { printf "  %sfail%s  %s\n" "$C_RED" "$C_RESET" "$*"; }

# Read a top-level frontmatter scalar from a SKILL.md. Returns empty if missing.
# Only handles simple `key: value` lines in the YAML head; intentionally not
# a full YAML parser.
read_frontmatter() {
  local path key
  path="$1"; key="$2"
  awk -v k="$key" '
    /^---$/ { count++; next }
    count == 1 {
      if (match($0, "^" k ":[[:space:]]*")) {
        v = substr($0, RLENGTH + 1)
        gsub(/^"|"$/, "", v)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", v)
        print v
        exit
      }
    }
  ' "$path"
}

# JSON-escape a string for embedding in a JSON string literal.
json_escape() {
  awk 'BEGIN { ORS="" } {
    gsub(/\\/, "\\\\", $0)
    gsub(/"/, "\\\"", $0)
    gsub(/\t/, "\\t", $0)
    gsub(/\r/, "\\r", $0)
    if (NR > 1) printf "\\n"
    printf "%s", $0
  }' <<<"$1"
}

write_specialist_manifest() {
  local skill version description plugin_dir manifest desc_escaped
  skill="$1"
  version="$2"
  description="$3"
  plugin_dir="$PLUGINS_DIR/$skill"
  manifest="$plugin_dir/.claude-plugin/plugin.json"
  desc_escaped="$(json_escape "$description")"
  mkdir -p "$plugin_dir/.claude-plugin"
  cat >"$manifest" <<EOF
{
  "name": "$skill",
  "description": "$desc_escaped",
  "version": "$version",
  "author": { "name": "aihxp", "url": "https://github.com/aihxp" },
  "homepage": "https://github.com/aihxp/$skill",
  "repository": "https://github.com/aihxp/$skill",
  "license": "MIT",
  "keywords": ["ready-suite", "ai-skill"]
}
EOF
}

vendor_skill_files() {
  local skill src dst
  skill="$1"
  src="$PROJECTS_DIR/$skill"
  dst="$PLUGINS_DIR/$skill/skills/$skill"
  if [ ! -f "$src/SKILL.md" ]; then
    err "$skill: missing $src/SKILL.md"
    return 1
  fi
  rm -rf "$dst"
  mkdir -p "$dst"
  cp "$src/SKILL.md" "$dst/SKILL.md"
  if [ -d "$src/references" ]; then
    cp -R "$src/references" "$dst/references"
  fi
  return 0
}

write_meta_marketplace() {
  local out entries first plugin desc desc_raw version skill
  out="$REPO_ROOT/.claude-plugin/marketplace.json"
  mkdir -p "$REPO_ROOT/.claude-plugin"
  {
    printf '{\n'
    printf '  "name": "ready-suite",\n'
    printf '  "description": "Eleven AI skills covering the full arc from idea to launch, plus a meta plugin that bundles them all.",\n'
    printf '  "owner": { "name": "aihxp", "url": "https://github.com/aihxp" },\n'
    printf '  "metadata": {\n'
    printf '    "version": "1.0.0",\n'
    printf '    "homepage": "https://github.com/aihxp/ready-suite"\n'
    printf '  },\n'
    printf '  "plugins": [\n'
    first=1
    # Meta plugin first.
    cat <<MARK
    {
      "name": "ready-suite",
      "source": "./plugins/ready-suite",
      "description": "Install all eleven ready-suite skills in one shot. Pulls every specialist via plugin dependencies."
    }
MARK
    # Specialist plugins after.
    for skill in $SKILLS; do
      desc_raw="$(read_frontmatter "$PROJECTS_DIR/$skill/SKILL.md" description)"
      desc="$(json_escape "$desc_raw")"
      printf ',\n    {\n'
      printf '      "name": "%s",\n' "$skill"
      printf '      "source": "./plugins/%s",\n' "$skill"
      printf '      "description": "%s"\n' "$desc"
      printf '    }'
    done
    printf '\n  ]\n'
    printf '}\n'
  } >"$out"
}

write_meta_plugin() {
  local out deps_block skill first
  out="$REPO_ROOT/plugins/ready-suite/.claude-plugin/plugin.json"
  mkdir -p "$(dirname "$out")"
  {
    printf '{\n'
    printf '  "name": "ready-suite",\n'
    printf '  "description": "Bundle of all eleven ready-suite specialist skills. Installing this plugin pulls every specialist via dependencies; install one of the specialists directly if you want only that skill.",\n'
    printf '  "version": "1.0.0",\n'
    printf '  "author": { "name": "aihxp", "url": "https://github.com/aihxp" },\n'
    printf '  "homepage": "https://github.com/aihxp/ready-suite",\n'
    printf '  "repository": "https://github.com/aihxp/ready-suite",\n'
    printf '  "license": "MIT",\n'
    printf '  "keywords": ["ready-suite", "meta", "bundle"],\n'
    printf '  "dependencies": [\n'
    first=1
    for skill in $SKILLS; do
      if [ "$first" = "1" ]; then
        first=0
      else
        printf ',\n'
      fi
      printf '    "%s"' "$skill"
    done
    printf '\n  ]\n'
    printf '}\n'
  } >"$out"
}

printf "\n%sready-suite plugin refresh%s\n\n" "$C_BOLD" "$C_RESET"
printf "  hub repo : %s\n" "$REPO_ROOT"
printf "  sources  : %s/<skill>\n\n" "$PROJECTS_DIR"

for skill in $SKILLS; do
  printf "%s%s%s\n" "$C_BOLD" "$skill" "$C_RESET"
  src_skill_md="$PROJECTS_DIR/$skill/SKILL.md"
  if [ ! -f "$src_skill_md" ]; then
    err "missing dev copy at $PROJECTS_DIR/$skill"
    continue
  fi
  version="$(read_frontmatter "$src_skill_md" version)"
  description="$(read_frontmatter "$src_skill_md" description)"
  if [ -z "$version" ]; then
    warn "no version in frontmatter; using 0.0.0"
    version="0.0.0"
  fi
  if [ -z "$description" ]; then
    warn "no description in frontmatter"
    description="$skill"
  fi
  if vendor_skill_files "$skill"; then
    ok "vendored SKILL.md + references/"
  fi
  write_specialist_manifest "$skill" "$version" "$description"
  ok "manifest v$version"
  printf "\n"
done

write_meta_plugin
ok "wrote plugins/ready-suite/.claude-plugin/plugin.json"
write_meta_marketplace
ok "wrote .claude-plugin/marketplace.json"

printf "\n%sdone%s\n" "$C_GREEN" "$C_RESET"
printf "Review with: git status; git diff --stat\n"
printf "If the bundle composition changed, bump plugins/ready-suite/.claude-plugin/plugin.json version.\n\n"

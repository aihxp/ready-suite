#!/usr/bin/env bash
# install.sh: install the ready-suite into every detected harness.
#
# - Reads skills from this repo's skills/<skill>/ directory (in-tree;
#   no per-skill clone needed).
# - Detects native-skill harnesses by their config directories:
#     Claude Code  -> ~/.claude        -> writes ~/.claude/skills/<skill>/
#     Codex        -> ~/.codex         -> writes ~/.codex/skills/<skill>/
#     Cursor       -> ~/.cursor        -> writes ~/.cursor/skills/<skill>/
#     pi           -> ~/.pi            -> via the neutral Agent Skills path
#     OpenClaw     -> ~/.openclaw      -> via the neutral Agent Skills path
# - When pi or OpenClaw is detected, writes to the neutral
#   ~/.agents/skills/<skill>/ path. Both harnesses read this path
#   natively per the Agent Skills standard at agentskills.io. Future
#   AgentSkills-compatible harnesses inherit support for free.
# - For each of the eleven skills, symlinks SKILL.md and references/
#   from skills/<skill>/ into every detected harness.
# - Idempotent. Re-run anytime.
# - Bash 3.2 compatible (macOS default). No associative arrays.
#
# Usage:
#   git clone https://github.com/aihxp/ready-suite && bash ready-suite/install.sh
#   or run from inside an existing clone: bash install.sh
#
# Flags:
#   -v   verbose (show skipped-because-correct steps)
#   -h   help

set -eu

VERBOSE=0
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HUB_DIR="$SCRIPT_DIR"
SKILLS_DIR="$HUB_DIR/skills"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

# Eleven skills, in suite-tier order.
SKILLS="kickoff-ready prd-ready architecture-ready roadmap-ready stack-ready repo-ready production-ready deploy-ready observe-ready launch-ready harden-ready"

# Platforms: name and skills-dir path. Parallel lists keep bash 3.2 compat.
# Agent_Skills is the neutral Agent Skills standard path read by pi,
# OpenClaw, and any future AgentSkills-compatible harness.
PLATFORM_NAMES="Claude_Code Codex Cursor Agent_Skills"
PLATFORM_DIRS="${HOME}/.claude/skills ${HOME}/.codex/skills ${HOME}/.cursor/skills ${HOME}/.agents/skills"

# ANSI colors only when stdout is a TTY.
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
ready-suite installer

Usage: install.sh [-v] [-h]

  -v   verbose output
  -h   show this help

Detects Claude Code, Codex, Cursor, pi, and OpenClaw; installs the
eleven ready-suite skills into every detected harness via file-level
symlinks from this repo's skills/<skill>/ directory. pi and OpenClaw
are served via the neutral Agent Skills path at ~/.agents/skills/.
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    -v|--verbose) VERBOSE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) printf "%sunknown flag: %s%s\n" "$C_RED" "$1" "$C_RESET" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

log()   { printf "%s\n" "$*"; }
info()  { printf "%s%s%s\n" "$C_DIM" "$*" "$C_RESET"; }
ok()    { printf "  %sok%s    %s\n" "$C_GREEN" "$C_RESET" "$*"; }
warn()  { printf "  %swarn%s  %s\n" "$C_YELLOW" "$C_RESET" "$*"; }
err()   { printf "  %sfail%s  %s\n" "$C_RED" "$C_RESET" "$*"; }
step()  { printf "  %s..%s    %s\n" "$C_CYAN" "$C_RESET" "$*"; }
vstep() { [ "$VERBOSE" = "1" ] && printf "  %s..%s    %s\n" "$C_DIM" "$C_RESET" "$*" || true; }

# Look up the skills-dir for a platform name. Returns "" if not detected.
platform_dir_for() {
  local name i j n d
  name="$1"
  i=1
  for n in $PLATFORM_NAMES; do
    if [ "$n" = "$name" ]; then
      j=1
      for d in $PLATFORM_DIRS; do
        if [ "$j" = "$i" ]; then
          printf "%s" "$d"
          return 0
        fi
        j=$((j + 1))
      done
    fi
    i=$((i + 1))
  done
  return 1
}

# Human label for a platform name.
platform_label_for() {
  local name markers
  name="$1"
  case "$name" in
    Agent_Skills)
      markers=""
      [ -d "${HOME}/.pi" ] && markers="pi"
      if [ -d "${HOME}/.openclaw" ]; then
        if [ -n "$markers" ]; then markers="$markers, OpenClaw"; else markers="OpenClaw"; fi
      fi
      if [ -n "$markers" ]; then
        printf "Agent Skills (%s)" "$markers"
      else
        printf "Agent Skills"
      fi
      ;;
    *)
      printf '%s' "$name" | tr '_' ' '
      ;;
  esac
}

# Detection.
DETECTED_PLATFORMS=""
for name in $PLATFORM_NAMES; do
  dir="$(platform_dir_for "$name")"
  parent="$(dirname "$dir")"
  case "$name" in
    Agent_Skills)
      if [ -d "${HOME}/.pi" ] || [ -d "${HOME}/.openclaw" ]; then
        DETECTED_PLATFORMS="$DETECTED_PLATFORMS $name"
      fi
      ;;
    *)
      if [ -d "$parent" ]; then
        DETECTED_PLATFORMS="$DETECTED_PLATFORMS $name"
      fi
      ;;
  esac
done

if [ -z "$DETECTED_PLATFORMS" ]; then
  printf "%sNo Claude Code, Codex, Cursor, pi, or OpenClaw install detected.%s\n" "$C_RED" "$C_RESET" >&2
  printf "Expected one of ~/.claude, ~/.codex, ~/.cursor, ~/.pi, ~/.openclaw.\n" >&2
  exit 1
fi

if [ ! -d "$SKILLS_DIR" ]; then
  printf "%sskills/ directory not found at %s%s\n" "$C_RED" "$SKILLS_DIR" "$C_RESET" >&2
  printf "Run install.sh from inside a ready-suite clone.\n" >&2
  exit 1
fi

log ""
printf "%sready-suite installer%s\n" "$C_BOLD" "$C_RESET"
log ""
info "skills dir   : $SKILLS_DIR"
detected_label=""
for n in $DETECTED_PLATFORMS; do
  detected_label="$detected_label, $(platform_label_for "$n")"
done
detected_label="${detected_label#, }"
info "platforms    : $detected_label"
log ""

INSTALLED_COUNT=0
SKIPPED_COUNT=0
PLATFORM_LINK_COUNT=0

# Symlink one item from src to dst, backing up any non-symlink target.
link_item() {
  local src dst label current backup
  src="$1"
  dst="$2"
  label="$3"
  if [ ! -e "$src" ]; then
    err "missing source: $src"
    return 1
  fi
  if [ -L "$dst" ]; then
    current="$(readlink "$dst" 2>/dev/null || true)"
    if [ "$current" = "$src" ]; then
      vstep "$label already linked"
      return 0
    fi
    rm -f "$dst"
  elif [ -e "$dst" ]; then
    backup="$(dirname "$dst").backup-$TIMESTAMP"
    mkdir -p "$backup"
    mv "$dst" "$backup/"
    warn "backed up existing $label -> $backup/"
  fi
  ln -s "$src" "$dst"
  return 0
}

install_skill_into_platform() {
  local skill platform_name platform_dir src_skill_md src_refs dst_dir
  skill="$1"
  platform_name="$2"
  platform_dir="$3"
  src_skill_md="$SKILLS_DIR/$skill/SKILL.md"
  src_refs="$SKILLS_DIR/$skill/references"
  dst_dir="$platform_dir/$skill"

  if [ ! -f "$src_skill_md" ]; then
    err "$skill: SKILL.md missing at $src_skill_md"
    return 1
  fi

  mkdir -p "$dst_dir"
  if ! link_item "$src_skill_md" "$dst_dir/SKILL.md" "SKILL.md"; then
    return 1
  fi
  if [ -d "$src_refs" ]; then
    if ! link_item "$src_refs" "$dst_dir/references" "references/"; then
      return 1
    fi
  fi
  PLATFORM_LINK_COUNT=$((PLATFORM_LINK_COUNT + 1))
  return 0
}

for skill in $SKILLS; do
  log ""
  printf "%s%s%s\n" "$C_BOLD" "$skill" "$C_RESET"
  if [ ! -d "$SKILLS_DIR/$skill" ]; then
    err "$skill: missing at $SKILLS_DIR/$skill"
    SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
    continue
  fi
  any_ok=0
  for name in $DETECTED_PLATFORMS; do
    pdir="$(platform_dir_for "$name")"
    label="$(platform_label_for "$name")"
    if install_skill_into_platform "$skill" "$name" "$pdir"; then
      ok "$label"
      any_ok=1
    fi
  done
  if [ "$any_ok" = "1" ]; then
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
  else
    SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
  fi
done

PLATFORM_COUNT=0
for n in $DETECTED_PLATFORMS; do
  PLATFORM_COUNT=$((PLATFORM_COUNT + 1))
done

log ""
printf "%ssummary%s\n" "$C_BOLD" "$C_RESET"
printf "  %s%d skills installed%s across %d platforms\n" "$C_GREEN" "$INSTALLED_COUNT" "$C_RESET" "$PLATFORM_COUNT"
if [ "$SKIPPED_COUNT" -gt 0 ]; then
  printf "  %s%d skipped%s\n" "$C_YELLOW" "$SKIPPED_COUNT" "$C_RESET"
fi
log ""
info "Re-run anytime; install.sh is idempotent."
info "Uninstall: bash uninstall.sh"
log ""

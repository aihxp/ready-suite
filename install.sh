#!/usr/bin/env bash
# install.sh: install the ready-suite into every detected harness.
#
# - Detects native-skill harnesses by their config directories:
#     Claude Code  -> ~/.claude        -> writes ~/.claude/skills/<skill>/
#     Codex        -> ~/.codex         -> writes ~/.codex/skills/<skill>/
#     Cursor       -> ~/.cursor        -> writes ~/.cursor/skills/<skill>/
#     pi           -> ~/.pi            -> via the neutral Agent Skills path
#     OpenClaw     -> ~/.openclaw      -> via the neutral Agent Skills path
# - When pi or OpenClaw is detected, writes to the neutral
#   ~/.agents/skills/<skill>/ path. Both harnesses read this path
#   natively per the Agent Skills standard at agentskills.io. Future
#   AgentSkills-compatible harnesses inherit support for free. We
#   deliberately do NOT write to ~/.pi/agent/skills/ or
#   ~/.openclaw/skills/ in addition: those are redundant given the
#   neutral path and only add maintenance surface.
# - For each of the eleven skills, ensures a dev copy at
#   ~/Projects/<skill>/, then symlinks SKILL.md and references/
#   into every detected harness.
# - Idempotent. Re-run anytime.
# - Bash 3.2 compatible (macOS default). No associative arrays.
#
# Usage:
#   curl -sSL https://raw.githubusercontent.com/aihxp/ready-suite/main/install.sh | bash
#   or: git clone https://github.com/aihxp/ready-suite && bash ready-suite/install.sh
#
# Flags:
#   -v   verbose (show skipped-because-correct steps)
#   -h   help

set -eu

VERBOSE=0
GH_ORG="aihxp"
PROJECTS_DIR="${HOME}/Projects"
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
symlinks from ~/Projects/<skill>/. pi and OpenClaw are served via
the neutral Agent Skills path at ~/.agents/skills/.
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

# Human label for a platform name. Agent_Skills shows the markers
# that triggered detection so the user sees why ~/.agents/skills/ is
# in the install set.
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

# Detection: parent-dir presence for first three; pi or OpenClaw
# marker for the neutral Agent Skills path.
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

log ""
printf "%sready-suite installer%s\n" "$C_BOLD" "$C_RESET"
log ""
info "projects dir : $PROJECTS_DIR"
detected_label=""
for n in $DETECTED_PLATFORMS; do
  detected_label="$detected_label, $(platform_label_for "$n")"
done
detected_label="${detected_label#, }"
info "platforms    : $detected_label"
log ""

mkdir -p "$PROJECTS_DIR"

INSTALLED_COUNT=0
SKIPPED_COUNT=0
PLATFORM_LINK_COUNT=0

# Ensure a dev copy at ~/Projects/<skill>/. Echoes "ok|skip|fail" + reason.
# Returns 0 on ok or skip-but-usable, 1 on fail.
ensure_dev_copy() {
  local skill dir
  skill="$1"
  dir="$PROJECTS_DIR/$skill"
  if [ -d "$dir/.git" ]; then
    # Existing repo. Refuse to touch if dirty; otherwise reuse.
    if (cd "$dir" && git diff --quiet --ignore-submodules 2>/dev/null && git diff --cached --quiet --ignore-submodules 2>/dev/null); then
      vstep "dev copy clean: $dir"
      return 0
    else
      warn "dev copy has uncommitted changes; skipping clone (using as-is): $dir"
      return 0
    fi
  elif [ -e "$dir" ]; then
    err "$dir exists but is not a git repo; refusing to overwrite"
    return 1
  fi
  step "cloning $skill"
  if git clone --depth 1 --quiet "https://github.com/$GH_ORG/$skill.git" "$dir" 2>/dev/null; then
    ok "cloned $GH_ORG/$skill"
    return 0
  else
    err "clone failed: $GH_ORG/$skill"
    return 1
  fi
}

# Symlink one item (SKILL.md or references) from src to dst, backing up
# any non-symlink target. Echoes ok/skip/fail.
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
  src_skill_md="$PROJECTS_DIR/$skill/SKILL.md"
  src_refs="$PROJECTS_DIR/$skill/references"
  dst_dir="$platform_dir/$skill"

  if [ ! -f "$src_skill_md" ]; then
    err "$skill: SKILL.md missing in $PROJECTS_DIR/$skill"
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
  if ! ensure_dev_copy "$skill"; then
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

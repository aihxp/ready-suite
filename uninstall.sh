#!/usr/bin/env bash
# uninstall.sh: remove ready-suite symlinks from every detected harness.
#
# - Removes only symlinks that point into ~/Projects/<skill>/.
# - Leaves dev copies in ~/Projects/ untouched.
# - Leaves any *.backup-<timestamp>/ directories alone.
# - Covers Claude Code, Codex, Cursor, plus the neutral Agent Skills
#   path at ~/.agents/skills/ used by pi and OpenClaw.
# - Bash 3.2 compatible.

set -eu

VERBOSE=0
PROJECTS_DIR="${HOME}/Projects"

SKILLS="kickoff-ready prd-ready architecture-ready roadmap-ready stack-ready repo-ready production-ready deploy-ready observe-ready launch-ready harden-ready"
PLATFORM_NAMES="Claude_Code Codex Cursor Agent_Skills"
PLATFORM_DIRS="${HOME}/.claude/skills ${HOME}/.codex/skills ${HOME}/.cursor/skills ${HOME}/.agents/skills"

if [ -t 1 ]; then
  C_RESET="$(printf '\033[0m')"; C_BOLD="$(printf '\033[1m')"; C_DIM="$(printf '\033[2m')"
  C_GREEN="$(printf '\033[32m')"; C_YELLOW="$(printf '\033[33m')"; C_RED="$(printf '\033[31m')"
else
  C_RESET=""; C_BOLD=""; C_DIM=""; C_GREEN=""; C_YELLOW=""; C_RED=""
fi

usage() {
  cat <<EOF
ready-suite uninstaller

Usage: uninstall.sh [-v] [-h]

Removes ready-suite symlinks from Claude Code, Codex, Cursor, and the
neutral Agent Skills path (~/.agents/skills/) read by pi and OpenClaw.
Does not delete dev copies in ~/Projects/ or any backup directories.
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    -v|--verbose) VERBOSE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) printf "%sunknown flag: %s%s\n" "$C_RED" "$1" "$C_RESET" >&2; exit 2 ;;
  esac
  shift
done

ok()    { printf "  %sok%s    %s\n" "$C_GREEN" "$C_RESET" "$*"; }
warn()  { printf "  %swarn%s  %s\n" "$C_YELLOW" "$C_RESET" "$*"; }
vstep() { [ "$VERBOSE" = "1" ] && printf "  %s..%s    %s\n" "$C_DIM" "$C_RESET" "$*" || true; }

platform_dir_for() {
  local name i j n d
  name="$1"; i=1
  for n in $PLATFORM_NAMES; do
    if [ "$n" = "$name" ]; then
      j=1
      for d in $PLATFORM_DIRS; do
        if [ "$j" = "$i" ]; then printf "%s" "$d"; return 0; fi
        j=$((j + 1))
      done
    fi
    i=$((i + 1))
  done
  return 1
}

platform_label_for() {
  local name
  name="$1"
  case "$name" in
    Agent_Skills) printf "Agent Skills" ;;
    *) printf '%s' "$name" | tr '_' ' ' ;;
  esac
}

# Detect a platform as present if its skills dir exists. For Agent_Skills,
# also detect when ~/.pi or ~/.openclaw exists (so we still walk the
# skills dir to clean it if the harness markers are present).
platform_present() {
  local name pdir
  name="$1"
  pdir="$(platform_dir_for "$name")"
  case "$name" in
    Agent_Skills)
      if [ -d "$pdir" ] || [ -d "${HOME}/.pi" ] || [ -d "${HOME}/.openclaw" ]; then
        return 0
      fi
      return 1
      ;;
    *)
      if [ -d "$(dirname "$pdir")" ]; then
        return 0
      fi
      return 1
      ;;
  esac
}

REMOVED=0
KEPT=0
EMPTY_DIRS=0

remove_link() {
  local path target
  path="$1"
  if [ -L "$path" ]; then
    target="$(readlink "$path" 2>/dev/null || true)"
    case "$target" in
      "$PROJECTS_DIR"/*)
        rm -f "$path"
        REMOVED=$((REMOVED + 1))
        return 0 ;;
      *)
        warn "skipped (foreign symlink): $path -> $target"
        KEPT=$((KEPT + 1))
        return 1 ;;
    esac
  elif [ -e "$path" ]; then
    warn "skipped (not a symlink): $path"
    KEPT=$((KEPT + 1))
    return 1
  fi
  return 0
}

printf "\n%sready-suite uninstaller%s\n\n" "$C_BOLD" "$C_RESET"

for name in $PLATFORM_NAMES; do
  if ! platform_present "$name"; then
    vstep "$name not detected; skipping"
    continue
  fi
  pdir="$(platform_dir_for "$name")"
  label="$(platform_label_for "$name")"
  printf "%s%s%s\n" "$C_BOLD" "$label" "$C_RESET"
  for skill in $SKILLS; do
    sdir="$pdir/$skill"
    if [ ! -d "$sdir" ] && [ ! -L "$sdir" ]; then
      vstep "$skill: nothing to remove"
      continue
    fi
    remove_link "$sdir/SKILL.md" || true
    remove_link "$sdir/references" || true
    # If the skill dir is now empty, remove it. Otherwise leave it.
    if [ -d "$sdir" ]; then
      if [ -z "$(ls -A "$sdir" 2>/dev/null)" ]; then
        rmdir "$sdir"
        EMPTY_DIRS=$((EMPTY_DIRS + 1))
        ok "$skill removed"
      else
        warn "$skill: directory not empty, kept"
      fi
    fi
  done
  printf "\n"
done

printf "%ssummary%s\n" "$C_BOLD" "$C_RESET"
printf "  %s%d symlinks removed%s, %d skill dirs cleaned\n" "$C_GREEN" "$REMOVED" "$C_RESET" "$EMPTY_DIRS"
if [ "$KEPT" -gt 0 ]; then
  printf "  %s%d items kept%s (foreign symlinks or non-symlinks)\n" "$C_YELLOW" "$KEPT" "$C_RESET"
fi
printf "\nDev copies in %s and any *.backup-*/ dirs are untouched.\n\n" "$PROJECTS_DIR"

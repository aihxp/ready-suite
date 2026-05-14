#!/usr/bin/env bash
# bump-suite-version.sh: align the ready-suite release train.
#
# Usage:
#   bash scripts/bump-suite-version.sh 3.0.0 [YYYY-MM-DD]
#
# Bash 3.2 compatible.

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS="kickoff-ready prd-ready architecture-ready roadmap-ready stack-ready repo-ready production-ready deploy-ready observe-ready launch-ready harden-ready"

version="${1:-}"
release_date="${2:-$(date +%F)}"

if [ -z "$version" ]; then
  printf "usage: bash scripts/bump-suite-version.sh <x.y.z> [YYYY-MM-DD]\n" >&2
  exit 2
fi

case "$version" in
  *[!0-9.]*|*.*.*.*|.*|*.) printf "version must be semver x.y.z: %s\n" "$version" >&2; exit 2 ;;
esac
if ! printf "%s" "$version" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'; then
  printf "version must be semver x.y.z: %s\n" "$version" >&2
  exit 2
fi
if ! printf "%s" "$release_date" | grep -Eq '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'; then
  printf "date must be YYYY-MM-DD: %s\n" "$release_date" >&2
  exit 2
fi

prepend_changelog() {
  local skill changelog top tmp
  skill="$1"
  changelog="$REPO_ROOT/skills/$skill/CHANGELOG.md"
  top="$(awk '/^## v/ {sub(/^## v/, ""); sub(/ .*/, ""); print; exit}' "$changelog")"
  if [ "$top" = "$version" ]; then
    return 0
  fi
  tmp="$(mktemp)"
  {
    printf "## v%s (%s)\n\n" "$version" "$release_date"
    printf "Suite-wide release train alignment. This major release stabilizes the monorepo distribution model, synchronized Claude plugin packaging, strict trigger routing, Pillars project-context integration, and release hygiene for the eleven-skill suite.\n\n"
    printf "### Changed\n"
    printf -- "- Aligns this skill with the ready-suite %s release train.\n" "$version"
    printf -- "- Keeps the skill's existing artifact paths and trigger ownership intact while publishing the shared major version.\n\n"
    printf "### Why a major\n"
    printf "This is a coordinated suite release: all eleven skills, the ready-suite meta plugin, and the marketplace metadata now move together for the %s train.\n\n" "$version"
    printf -- "---\n\n"
    cat "$changelog"
  } > "$tmp"
  mv "$tmp" "$changelog"
}

update_skill_frontmatter() {
  local skill skill_md
  skill="$1"
  skill_md="$REPO_ROOT/skills/$skill/SKILL.md"
  VERSION_VALUE="$version" RELEASE_DATE="$release_date" perl -0pi -e '
    s/^version: .*/version: $ENV{VERSION_VALUE}/m;
    s/^updated: .*/updated: $ENV{RELEASE_DATE}/m;
  ' "$skill_md"
}

update_version_tables() {
  local skill
  for skill in $SKILLS; do
    SKILL_NAME="$skill" VERSION_VALUE="$version" perl -0pi -e '
      my $s = $ENV{SKILL_NAME};
      my $v = $ENV{VERSION_VALUE};
      s/(\| \*\*\Q$s\E\*\* \| [^\n]*? \| )[0-9]+\.[0-9]+\.[0-9]+( \| \[skills\/\Q$s\E\])/$1$v$2/g;
    ' "$REPO_ROOT/README.md"
    SKILL_NAME="$skill" VERSION_VALUE="$version" perl -0pi -e '
      my $s = $ENV{SKILL_NAME};
      my $v = $ENV{VERSION_VALUE};
      s/(\| \*\*\Q$s\E\*\* \| )[0-9]+\.[0-9]+\.[0-9]+( \| \[skills\/\Q$s\E\])/$1$v$2/g;
    ' "$REPO_ROOT/SUITE.md"
  done
}

sync_suite_md() {
  local skill
  for skill in $SKILLS; do
    cp "$REPO_ROOT/SUITE.md" "$REPO_ROOT/skills/$skill/SUITE.md"
  done
}

printf "%s\n" "$version" > "$REPO_ROOT/VERSION"

for skill in $SKILLS; do
  update_skill_frontmatter "$skill"
  prepend_changelog "$skill"
done

update_version_tables
sync_suite_md
bash "$REPO_ROOT/scripts/refresh-plugin-skills.sh"

printf "ready-suite release train is now %s (%s)\n" "$version" "$release_date"

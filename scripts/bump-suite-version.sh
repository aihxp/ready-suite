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

# Classify a bump as major|minor|patch by comparing old to new semver.
# Falls back to "coordinated" when the prior version is unknown.
bump_type() {
  local old="$1" new="$2" o1 o2 o3 n1 n2 n3
  if [ -z "$old" ]; then printf "coordinated"; return; fi
  o1="${old%%.*}"; o3="${old##*.}"; o2="${old#*.}"; o2="${o2%.*}"
  n1="${new%%.*}"; n3="${new##*.}"; n2="${new#*.}"; n2="${n2%.*}"
  if [ "$n1" != "$o1" ]; then printf "major"
  elif [ "$n2" != "$o2" ]; then printf "minor"
  elif [ "$n3" != "$o3" ]; then printf "patch"
  else printf "coordinated"; fi
}

prepend_changelog() {
  local skill changelog top tmp btype heading
  skill="$1"
  changelog="$REPO_ROOT/skills/$skill/CHANGELOG.md"
  top="$(awk '/^## v/ {sub(/^## v/, ""); sub(/ .*/, ""); print; exit}' "$changelog")"
  if [ "$top" = "$version" ]; then
    return 0
  fi
  btype="$(bump_type "$top" "$version")"
  if [ "$btype" = "coordinated" ]; then heading="Why this release"; else heading="Why a $btype"; fi
  tmp="$(mktemp)"
  {
    printf "## v%s (%s)\n\n" "$version" "$release_date"
    printf "Suite-wide release train alignment. This %s release moves every skill, the ready-suite meta plugin, and the marketplace metadata to the %s train together, keeping each skill's artifact paths and trigger ownership intact.\n\n" "$btype" "$version"
    printf "### Changed\n"
    printf -- "- Aligns this skill with the ready-suite %s release train.\n" "$version"
    printf -- "- Keeps the skill's existing artifact paths and trigger ownership intact while publishing the shared version.\n\n"
    printf "### %s\n" "$heading"
    printf "This is a coordinated suite release: all eleven skills, the ready-suite meta plugin, and the marketplace metadata move together for the %s train.\n\n" "$version"
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

# Update the README status badges (release-tag link + version shields).
update_readme_badges() {
  VERSION_VALUE="$version" perl -0pi -e '
    s{badge/release-v[0-9]+\.[0-9]+\.[0-9]+-blue}{badge/release-v$ENV{VERSION_VALUE}-blue}g;
    s{releases/tag/v[0-9]+\.[0-9]+\.[0-9]+}{releases/tag/v$ENV{VERSION_VALUE}}g;
    s{badge/version-[0-9]+\.[0-9]+\.[0-9]+-blue}{badge/version-$ENV{VERSION_VALUE}-blue}g;
  ' "$REPO_ROOT/README.md"
}

printf "%s\n" "$version" > "$REPO_ROOT/VERSION"

for skill in $SKILLS; do
  update_skill_frontmatter "$skill"
  prepend_changelog "$skill"
done

update_version_tables
update_readme_badges
sync_suite_md
bash "$REPO_ROOT/scripts/refresh-plugin-skills.sh"

printf "ready-suite release train is now %s (%s)\n" "$version" "$release_date"

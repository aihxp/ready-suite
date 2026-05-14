# Agent instructions for ready-suite

## Project shape

This repository is the ready-suite monorepo. The canonical skill sources live under `skills/<skill-name>/`. The `plugins/<skill-name>/` tree is vendored packaging for Claude Code plugin installs and must stay synchronized with the canonical skill sources.

The suite has eleven skills:

- `kickoff-ready`
- `prd-ready`
- `architecture-ready`
- `roadmap-ready`
- `stack-ready`
- `repo-ready`
- `production-ready`
- `deploy-ready`
- `observe-ready`
- `launch-ready`
- `harden-ready`

## Required checks

Run the suite linter before handing off repo changes:

```bash
bash scripts/lint.sh --verbose
```

For a faster local reproduction of CI failures:

```bash
bash scripts/lint.sh --fail-fast
```

## Edit rules

- Do not introduce em dashes, en dashes, decorative unicode arrows, box-drawing characters, or emojis.
- Keep shell scripts compatible with bash 3.2, the default bash on macOS. Do not use associative arrays, `mapfile`, `${var,,}`, or `[[ ]]`.
- Keep `SUITE.md` byte-identical at the hub root and in every `skills/<skill-name>/SUITE.md`.
- When a skill behavior changes, update that skill's `SKILL.md` frontmatter version and top `CHANGELOG.md` entry together.
- Treat `skills/<skill-name>/` as source of truth. After canonical skill changes, run `bash scripts/refresh-plugin-skills.sh` if plugin vendoring needs to be refreshed.
- Do not commit local harness worktrees or session state under `.claude/`.

## Maintenance references

- `README.md`: user-facing overview and install paths.
- `MAINTAINING.md`: maintainer rituals and version-bump rules.
- `CONTRIBUTING.md`: contributor workflow and PR standards.
- `ORCHESTRATORS.md`: integration patterns for GSD, BMAD, Spec Kit, and plain harnesses.
- `references/TRIGGER-DISAMBIGUATION.md`: canonical routing table for ambiguous trigger phrases.

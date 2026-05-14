# Release Checklist

Use this checklist for every coordinated ready-suite release train.

## Before the bump

- Confirm the intended release version and date.
- Review `git status --short` and make sure every dirty file is expected.
- Run `bash scripts/lint.sh --strict-triggers --verbose` before changing versions so trigger drift is caught early.
- Review `references/TRIGGER-DISAMBIGUATION.md` if any trigger phrase changed.

## Bump the train

```bash
bash scripts/bump-suite-version.sh <x.y.z> <YYYY-MM-DD>
```

The script updates root `VERSION`, every skill `SKILL.md`, every top `CHANGELOG.md` entry, the README and SUITE version tables, every copied `skills/<skill>/SUITE.md`, specialist plugin manifests, vendored plugin skill copies, the ready-suite meta plugin, and marketplace metadata.

## Verify

```bash
bash scripts/lint.sh --verbose
bash scripts/lint.sh --strict-triggers --verbose
git diff --check
bash -n scripts/lint.sh scripts/refresh-plugin-skills.sh scripts/bump-suite-version.sh install.sh uninstall.sh
```

For plugin packaging changes, also validate JSON if `jq` is available:

```bash
find .claude-plugin plugins -path '*/.claude-plugin/plugin.json' -o -name marketplace.json | xargs jq empty
```

## Review

- Confirm root `VERSION` matches every `skills/<skill>/SKILL.md`.
- Confirm every skill top changelog entry matches the release train.
- Confirm `plugins/ready-suite/.claude-plugin/plugin.json` has every specialist under `dependencies`.
- Confirm `.claude-plugin/marketplace.json` lists the meta plugin and every specialist plugin.
- Confirm no `.claude/` worktree or local session state is staged.

## Publish

- Commit all intended release files together.
- Tag the monorepo release with the same version, for example `v3.0.0`.
- If publishing Claude plugin marketplace updates, publish from the committed tree after lint passes.

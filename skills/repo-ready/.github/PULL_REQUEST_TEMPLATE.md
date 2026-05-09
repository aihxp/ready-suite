<!-- Thanks for contributing to repo-ready. Please fill in every section below. -->

## What does this PR do?

<!-- Describe the change in 1-3 sentences. Link the issue it addresses. -->

Closes #

## Type of change

- [ ] New reference file (under `references/`)
- [ ] Expansion of an existing reference file
- [ ] Bug fix in a generated template or reference
- [ ] New stack coverage (repo-structure / quality-tooling / ci-cd-workflows)
- [ ] New platform coverage (GitHub / GitLab / Bitbucket)
- [ ] `SKILL.md` change
- [ ] Documentation, meta, or infrastructure

## Checklist

- [ ] **Byte ceilings respected.** `SKILL.md` ≤ 40KB and every touched `references/*.md` ≤ 80KB. Verified via `wc -c SKILL.md references/*.md` (or `make check-sizes` once Phase 3 lands).
- [ ] **No placeholders in generated content.** No `{{variables}}`, `TODO:`/`FIXME:` markers, `example.com` addresses (except in meta-commentary like `CONTRIBUTING.md`), `lorem ipsum`, or "your description here" stubs.
- [ ] **CHANGELOG updated** under the `[Unreleased]` block for any user-facing change.
- [ ] **Cross-references resolve.** Every `references/FILE.md` link I added or touched points at a file that exists in this PR.
- [ ] **`make audit` ran locally** (once Phase 3 ships the target) and the delta against the previous `AUDIT-REPORT.md` was reviewed.
- [ ] **Commits follow Conventional Commits.** Format: `type(scope): description`. Valid types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`.

## Additional notes

<!-- Screenshots, before/after diffs of generated output, related PRs, anything a reviewer should know before reading the diff. -->

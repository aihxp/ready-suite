# Contributing to repo-ready

Thanks for helping improve **repo-ready**. This repository is a Claude Code skill -- pure Markdown, no runtime -- so contributing is mostly about tightening prose, keeping cross-references valid, and staying under the byte ceilings that make the skill usable inside a model's context window.

## Issues and Discussions

- **Use issue templates.** Bug reports and feature requests have dedicated YAML forms under `.github/ISSUE_TEMPLATE/`. The form fields exist because they reduce triage time -- please fill them out.
- **General questions go to [Discussions](https://github.com/aihxp/ready-suite/discussions),** not issues. "How do I use this with X?" or "Does this support stack Y?" belongs there.
- **Security concerns go through GitHub's Security tab** -- see [SECURITY.md](SECURITY.md).

## Pull Requests

### Before you open a PR

- **Conventional Commits are required** for commit messages: `type(scope): description`. Valid types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`. Example: `feat(ci-cd): add GitLab pipeline reference`. Pre-commit enforcement lands in Phase 2 of v1.5 -- until then, self-enforce.
- **Byte ceilings are hard constraints, not suggestions.**
  - `SKILL.md` must stay **≤ 40,000 bytes**
  - Each file under `references/` must stay **≤ 80,000 bytes**
  - Run `make check-sizes` before opening a PR (target lands in Phase 3). Until then: `wc -c SKILL.md references/*.md` and eyeball it.
- **Run `make audit` locally** (once Phase 3 ships the Makefile target) to regenerate the self-audit scorecard and review the delta against the previous `AUDIT-REPORT.md`.
- **Cross-references must resolve.** If you add or touch a link to `references/FILE.md`, open the target and confirm it exists.

### No placeholders rule

This is a skill that teaches other projects to avoid placeholders. We hold ourselves to the same rule. **A PR will be rejected if generated content contains any of:**

- Handlebars/Mustache template variables: `{{author}}`, `{{repo_name}}`, `{{year}}`
- Literal TODO markers in shipped content: `TODO: fill this in`, `FIXME`, `XXX`
- Example/placeholder addresses where a real one is needed: `security@example.com`, `maintainer@example.com`
- Lorem ipsum or stub copy: `lorem ipsum`, `sample text`, `your description here`

Meta-mentions of these strings are fine (this file mentions them by design to explain the rule). Treat the rule as: **generated-for-users content must be real content**.

### What we accept

- New reference files under `references/` (≤ 80KB, Tier-appropriate, paste-ready content)
- Expansions to existing references that don't break cross-refs elsewhere
- New stack coverage in `references/repo-structure.md`, `references/quality-tooling.md`, `references/ci-cd-workflows.md`
- Bug fixes in generated templates (incorrect syntax, broken YAML, wrong file paths)
- New platform coverage (GitLab-specific or Bitbucket-specific refinements)

### What we don't accept

- Features that push `SKILL.md` over 40KB -- that's what `references/` is for
- Framework-specific reference files (Next.js-specific, Django-specific, etc.) unless 3+ users have asked for that framework specifically
- Runtime dependencies of any kind -- the skill is pure Markdown on purpose
- Content that adds placeholders, template variables, or "fill this in later" stubs

## Dev setup

Clone the repo, open in any Markdown-aware editor, edit, push. There's no build step, no install, no test runner to configure. A Markdown preview pane helps; [markdownlint](https://github.com/DavidAnson/markdownlint) is recommended once you're committing often.

```bash
git clone https://github.com/aihxp/ready-suite.git
cd repo-ready
# edit files
git checkout -b your-branch
git commit -m "feat(scope): your change"
git push
```

---

**See also:**

- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) -- community expectations
- [SECURITY.md](SECURITY.md) -- reporting vulnerabilities

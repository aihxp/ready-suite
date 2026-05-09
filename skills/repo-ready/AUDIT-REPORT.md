---
audit_date: 2026-05-09
audit_version: v1.4
overall_score: 33/35
tier: "Tier 4 -- Excellent"
scores:
  essentials: 7/7
  community: 7/7
  quality: 5/5  # 2 items N/A (REPO-3.6 no typed code, REPO-3.7 no test runner)
  security: 2/2  # 4 items N/A (REPO-4.1 Dependabot for actions only, REPO-4.2 no SAST needed for Markdown, REPO-4.4 no deps, REPO-4.6 no deps)
  dx: 5/5  # 1 item N/A (REPO-5.4 no env vars)
  release: 4/5  # 1 item N/A (REPO-6.4 not a publishable package)
  agent_safety: 3/3
na_items: 8
agent_runtime_concerns:
  - slopsquatting
  - bypass_by_fallback
  - session_startup_reconciliation
prior_audits:
  - { date: 2026-04-22, score: 33/35, version: v1.4, milestone: "v1.5 Phase 3 close" }
---

# Repo Audit Report -- 2026-05-09 (re-audit)

Self-audit of `aihxp/repo-ready` re-run on 2026-05-09 against the same v1.4 audit-mode rubric used at the prior audit (2026-04-22). The prior audit closed the v1.5 "Dogfood: Apply Skill to Itself" milestone at 33/35 (Tier 4); this re-audit confirms that score is unchanged after six patch releases (v1.6.9 through v1.6.14) of suite-wide SUITE.md syncs, version-frontmatter bumps, and minor `.gitignore` additions.

## Re-audit delta (2026-04-22 -> 2026-05-09)

```
Prior score:    33/35 (Tier 4 -- Excellent)
Current score:  33/35 (Tier 4 -- Excellent)
Delta:          0
```

**No scored items closed or opened.** Six patches landed in the interval (v1.6.9 through v1.6.14):

- v1.6.9 (2026-05-06): pi + OpenClaw via Agent Skills standard. No repo-hygiene impact; `compatible_with` frontmatter expanded.
- v1.6.10 (2026-05-06): AGENTS.md canonicality flip per Linux Foundation Agentic AI Foundation. Documentation update to `references/onboarding-dx.md` §9; no repo-hygiene impact on this repo's own scaffold.
- v1.6.11 (2026-05-09): suite-wide SUITE.md sync for DESIGN.md compatibility.
- v1.6.12 (2026-05-09): suite-wide SUITE.md sync for planning-tier worked examples.
- v1.6.13 (2026-05-09): suite-wide SUITE.md sync for the repo-hygiene cleanup sweep across the eleven specialist repos.
- v1.6.14 (2026-05-09): hygiene -- added `.claude/settings.local.json` and `.planning/` patterns to `.gitignore` to prevent accidental commits in fresh clones; SUITE.md sync.

**Open items still open (no change since prior audit):**

- **REPO-6.2** -- Release automation. Releases remain manual via `git tag` + `gh release create`. Same trade-off rationale as the prior audit: a Markdown skill with human-curated release notes does not benefit from semantic-release / release-please overhead.
- **Implicit follow-up -- CI on `main`.** The hub's lint workflow (`aihxp/ready-suite/.github/workflows/lint.yml`) now runs on every push to the hub, on PRs to the hub, and daily at 06:00 UTC; it covers SUITE.md sync, frontmatter-version match, tag-release parity, unicode-clean, compatible_with, and trigger-overlap across all 12 repos. This **reduces** the load-bearing-ness of repo-ready's own per-repo CI; it does not eliminate it (the hub lint is suite-meta, not repo-internal). The ruleset on `main` here still has registered status checks not yet exercised; opening a trivial PR remains the 2-minute follow-up. Same disposition as the prior audit.

**New material since prior audit (informational):**

- Hub-level `scripts/lint.sh` (in `aihxp/ready-suite`) mechanically enforces several repo-ready disciplines as a meta-check across the suite: byte-identical `SUITE.md`, frontmatter-version-matches-CHANGELOG, every-tag-has-a-release, no-em-dashes-in-suite-files, `compatible_with` standards-level values. This does not change repo-ready's own audit score but it is a load-bearing discipline layer that applies to repo-ready alongside its own CI.
- New `.gitignore` entries (`.claude/settings.local.json`, `.planning/`) prevent a class of accidental commits that the prior audit did not flag (because the prior audit's `.gitignore` shipped before the hub lint surfaced these patterns as drift in sister repos).

## Audit delta (v1.5 Phase 3 close)

```
Previous score: 11/35 (Tier 1 -- Needs Work)
Current score:  33/35 (Tier 4 -- Excellent)
Delta:          +22
```

**Closed this cycle (21 items across three phases):**

- **v1.5 Phase 1 (DOG-01..DOG-08) -- Essentials + Community + Agent Safety:** REPO-1.3 (.gitignore), REPO-1.4 (.gitattributes), REPO-1.5 (.editorconfig), REPO-2.1 (CONTRIBUTING), REPO-2.2 (CODE_OF_CONDUCT), REPO-2.3 (SECURITY), REPO-2.4 (issue templates), REPO-2.5 (PR template), REPO-6.6 (CODEOWNERS), AGENT-01 (.claude/settings.json denylist), AGENT-02 (.githooks/pre-push), AGENT-03 (.gitleaks.toml)
- **v1.5 Phase 2 (DOG-10..DOG-17) -- CI + Quality:** REPO-3.1 (CI on PR+push), REPO-3.2 (real CI commands -- byte-ceilings, no-placeholders, no-example-com, xref-check, markdownlint), REPO-3.3 (markdownlint config), REPO-3.4 (Prettier for Markdown), REPO-3.5 (pre-commit hooks), REPO-4.5 (secret scanning -- gitleaks via pre-commit)
- **v1.5 Phase 3 (DOG-18..DOG-23) -- DX + Release Hygiene:** REPO-4.3 (branch protection on `main` via ruleset), REPO-5.2 (Makefile task runner), REPO-5.5 (README badges), REPO-6.5 (GitHub Release backfilled for v1.2)

**Still open (2 items):**

- **REPO-6.2** -- Release automation (semantic-release / release-please / changesets). Cutting releases remains manual via `gh release create`. Acceptable trade-off for a Markdown skill with human-curated release notes; revisit if release cadence grows.
- **Implicit gap -- CI has not yet executed on `main`.** The branch-protection ruleset lists five status checks by name, but until the first PR runs them on `main`, those gates only exist on paper. Opening a trivial PR to trigger CI is a 2-minute follow-up; not a scored failure.

**New gaps introduced this cycle:** none.

## Executive summary

**Score: 33/35 (94%). Tier 4 -- Excellent.**

The v1.5 dogfood milestone closed the gap the baseline called out: "**the repository that ships the skill does not follow its own skill's advice.**" It now does. All 7 essentials pass, all 7 community items pass, all 5 applicable quality items pass, both applicable security items pass (branch protection + secret scanning), all 5 applicable DX items pass, 4 of 5 applicable release items pass, and all 3 agent-safety checks pass. The repo now exemplifies its own skill -- generated `.gitignore`, `.gitattributes`, `.editorconfig`, community-standards pack, CI pipeline, Markdown tooling, pinned GitHub Actions, Dependabot, `.claude/settings.json` denylist, pre-push force-push hook, and gitleaks config, all in one tree.

The remaining two items (REPO-6.2 release automation, plus the unscored "CI hasn't executed on main yet" follow-up) are deliberate, documented scope trade-offs, not oversights. Shipping a Tier 4 repo that audits itself at 33/35 meets v1.5's "dogfood" success bar decisively.

## Critical gaps (must-fix before next milestone)

No critical gaps.

## High priority (strongly recommended)

No high-priority gaps.

## Medium priority (nice to have)

No medium-priority gaps.

## Low priority (cosmetic / edge-case)

### REPO-6.2 Release automation not configured

**Current state:** No semantic-release, release-please, changesets, or tag-push workflow. Releases are cut manually via `git tag` + `gh release create --notes-file`.

**Target state:** Either (a) a `release-please` workflow that auto-opens a release PR on each CHANGELOG update, or (b) a manual-trigger workflow that on tag push creates a GitHub Release from the matching `## [X.Y.Z]` CHANGELOG block.

**Fix:** `references/release-distribution.md` covers release-please, semantic-release, and changesets. For a Markdown skill with infrequent releases, option (b) is lighter-weight -- roughly 25 lines of YAML invoking `awk` + `gh release create`.

**Effort:** small (30 minutes).

### Follow-up (unscored) -- CI has not executed on `main`

**Current state:** `gh run list --workflow ci.yml` returns HTTP 404 because the workflow was added on a branch and hasn't completed a run on `main`. The branch-protection ruleset references `byte-ceilings`, `no-placeholders`, `no-example-com`, `xref-check`, and `markdownlint` by name; until CI runs on `main` those contexts aren't registered in GitHub's status-check index and the ruleset won't match them on incoming PRs (status-check rules only enforce once the named checks exist in the repo's check history).

**Target state:** At least one completed CI run on `main` so every named status check is registered.

**Fix:** Open any trivial PR against `main` (a typo fix or a comment tweak), let CI complete, merge. All five checks then become selectable and the ruleset begins enforcing.

**Effort:** trivial (2 minutes + CI wall-clock).

## Agent runtime concerns (informational -- not scored)

Per `references/agent-safety.md §6`, three behavior classes are documented as agent-runtime concerns and excluded from the 35-point denominator. Repo-ready cannot fix these by generating files:

- **Slopsquatting** -- AI agents hallucinating package names in install commands. Mitigated at the agent layer, not the repo layer. Not counted in score. See `references/agent-safety.md §6`.
- **Bypass-by-fallback** -- AI agents switching to MCP commit tools when direct `git commit` is denied. Agent-runtime responsibility. Not counted in score. See `references/agent-safety.md §6`.
- **Session-startup reconciliation** -- AI agents running `git reset --hard` on session init to "sync" with origin. Agent-runtime responsibility. Not counted in score. See `references/agent-safety.md §6`.

These are informational for any user running AI agents on this repo, not score-docking gaps.

## N/A items (excluded from denominator)

Eight checks are marked N/A for this repo -- Markdown-only skill, no runtime code, no packaged artifacts, no env vars:

- **REPO-3.6** Type checker -- no typed source code.
- **REPO-3.7** Test files runnable in CI -- no test runner; CI exercises Markdown validators instead (byte-ceilings, no-placeholders, no-example-com, xref-check, markdownlint).
- **REPO-4.1** Dependabot for runtime deps -- the repo has no runtime dependencies. Dependabot IS configured for `github-actions` ecosystem (pinning CI actions by SHA); counted under `.github/dependabot.yml` as a quality-tooling signal, not scored here.
- **REPO-4.2** SAST (CodeQL/Semgrep) -- no source code to analyze.
- **REPO-4.4** Zero high/critical CVEs in production deps -- no production deps.
- **REPO-4.6** Dependencies current -- no dependencies.
- **REPO-5.4** `.env.example` present -- no env vars read.
- **REPO-6.4** Package publishing automation -- not a publishable package (the skill is distributed as a git repository of Markdown files).

## What's verified vs what's claimed

Being explicit about verification state so this audit can be re-checked:

| Check | Evidence |
|-------|----------|
| REPO-4.3 Branch protection | `gh api repos/aihxp/repo-ready/rulesets` returns ruleset id 15403655 on `~DEFAULT_BRANCH` with 5 status checks + PR review + deletion/non-fast-forward blocks, enforcement=active |
| REPO-6.5 GitHub Releases | `gh release list` shows v1.0.0, v1.2, v1.3, v1.4 -- all with non-empty notes (v1.2 backfilled from CHANGELOG.md §1.2.0 block) |
| REPO-5.5 Badges | `head -6 README.md` shows 4 shields.io badges (CI, License, Release, AI Skill) |
| REPO-5.2 Task runner | `make check-sizes` executes and prints per-file byte counts; `make audit` prints usage guidance |
| AGENT-01/02/03 | `.claude/settings.json` present with `Bash(git reset --hard *)` in `permissions.deny`; `.githooks/pre-push` executable; `.gitleaks.toml` present and wired into `.pre-commit-config.yaml` |

The branch-protection ruleset is **registered but not yet exercising** its status checks because no CI run has completed on `main` -- see the follow-up item above. Everything else is live-and-firing.

## How to re-audit

Re-run the skill in Mode C. The new report is written in place at `AUDIT-REPORT.md`; diff with `git diff AUDIT-REPORT.md` to see the score-delta. No state file beyond this report -- git versions every audit for free.

---

*Generated by repo-ready v1.4 audit mode. Initial audit 2026-04-22 (v1.5 Phase 3 close); re-audit 2026-05-09 (no score delta).*
*See `references/audit-mode.md` for the workflow, scorecard, and template that produced this report.*

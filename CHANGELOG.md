# Hub changelog

Curated change history for the [aihxp/ready-suite](https://github.com/aihxp/ready-suite) hub. The hub is not versioned (no `version` frontmatter; the suite's collective version table lives in `SUITE.md`); this file is a narrative layer above `git log` for readers who want the hub's evolution at a glance.

For per-skill changelogs, see each specialist's `CHANGELOG.md` (e.g., [`prd-ready/CHANGELOG.md`](https://github.com/aihxp/prd-ready/blob/main/CHANGELOG.md)). For the audit trail of every coordinated patch and version bump, see the suite's tag-and-release pages.

## 2026-05-09 - Hub CHANGELOG + repo-ready audit refresh + v2.5.12 precedent retired

### Added

- This file (`CHANGELOG.md` at the hub root). Curated narrative layer above `git log` for the hub. Reverse-chronological by ship date, grouped by patch theme. Entries are dated, not numbered (the hub does not version itself; no `version` frontmatter; no `SKILL.md`).

### Changed

- `repo-ready/AUDIT-REPORT.md`: re-audit dated 2026-05-09 (prior 2026-04-22). Confirms 33/35 score unchanged after six patch releases (v1.6.9 through v1.6.14); none of those touched the scaffolding scored in the audit. New `prior_audits` history field. Informational note that hub `scripts/lint.sh` now mechanically enforces several repo-ready disciplines as a suite-meta check. repo-ready bumped to v1.6.15 in lockstep.
- `MAINTAINING.md`: **the v2.5.12 precedent has been retired.** That precedent allowed single-specialist patches to skip the full SUITE.md sync; the daily `scripts/lint.sh` workflow caught the resulting drift in CI on this very release. The new rule is uniform: any version bump in any specialist triggers byte-identical SUITE.md sync across all 12 repos and a sync-only patch bump on the other 10 specialists. Ritual 3a (hub + one-specialist patch) section in MAINTAINING.md rewritten to reflect this.
- All 10 non-repo-ready specialists bumped sync-only (kickoff 1.1.5, prd 1.0.13, architecture 1.0.12, roadmap 1.0.11, stack 1.1.18, production 2.6.5, deploy 1.0.17, observe 1.0.16, launch 1.0.14, harden 1.0.10) so the SUITE.md known-good versions table is byte-identical across all 12 repos. SUITE.md table updated.

### Why this was the cleanest move

The CI failure on the first attempt at this patch (lint flagged 10 SUITE.md drift hits) was the discipline working as designed: prose ("the precedent allows single-specialist drift") got contradicted by mechanical enforcement ("the lint demands byte-identical"). Trusting the lint over the precedent retired one and ratified the other. Going forward, every specialist patch ships with full sync.

## 2026-05-09 - Layout cleanup + maintainer doc

Audited file/folder structure across the 12 repos. Three real findings, all addressed.

### Removed

- Three accidentally-committed `settings.local.json` files in `roadmap-ready`, `deploy-ready`, `observe-ready`. The `.local` suffix is the Claude Code convention for personal-machine overrides; some had hardcoded local paths to `/Users/hprincivil`.

### Changed

- `kickoff-ready/references/antipatterns.md` renamed to `kickoff-antipatterns.md` to match the `<skill>-antipatterns.md` convention used by prd-ready, architecture-ready, roadmap-ready.
- `.gitignore` in all 11 specialists updated to ignore future `.claude/settings.local.json` and `.planning/` commits.
- `SUITE.md` known-good versions table caught up on `production-ready` (2.6.0 -> 2.6.4) and `repo-ready` (1.6.11 -> 1.6.14) drift from prior single-skill patches that did not trigger the byte-identical sync.

### Added

- `MAINTAINING.md` "File and folder layout per skill repo" section. Documents standard top-level files, `references/` naming conventions, hub repo layout (different shape, intentional), intentional drift (named and explained), and known-but-not-fixed inconsistencies (six skills lack dedicated antipatterns files; hub lacks elaborate scaffolding; production-ready alone carries `ORCHESTRATORS.md` among shipping-tier specialists).

## 2026-05-09 - Repo-hygiene cleanup sweep

Audit run via repo-ready audit-mode against all 12 suite repos. The eleven specialist repos uniformly missed `SECURITY.md`, `.github/CODEOWNERS`, `CONTRIBUTING.md`, and (in 6 of them) `.gitignore`. repo-ready itself was the gold-standard reference; no scaffolding additions there.

### Added (across all 11 specialists)

- `SECURITY.md`: private vulnerability disclosure policy with severity-tied response SLAs, GitHub Security Advisories preferred channel, named realistic security surface for markdown-only skills.
- `.github/CODEOWNERS`: default `* @aihxp` rule with comment block explaining the second-maintainer addition path.
- `CONTRIBUTING.md`: thin pointer to the hub canonical contributor guide. No content duplication.
- `.gitignore`: minimal OS / editor / install-backup ignores in the 6 specialists that lacked the file.

### Deliberately not added

`CODE_OF_CONDUCT.md`, issue templates, PR template, CI workflows, Dependabot, SAST, gitleaks, `.editorconfig` / `.gitattributes`. The skill repos are markdown-only documentation with no users today; bureaucratic scaffolding without a community to enforce it is theatre. When traction arrives, these get a follow-up patch.

## 2026-05-09 - See it end-to-end: dogfood pointer

Added a `See it end-to-end: ready-suite-example` section near the top of the hub README pointing at the new [`aihxp/ready-suite-example`](https://github.com/aihxp/ready-suite-example) dogfood repository.

The dogfood is the canonical end-to-end output of running the suite on a fictional B2B SaaS product (Pulse, a Customer Success ops platform). All eleven artifacts at canonical `.{skill}-ready/` paths, plus an `AGENTS.md` (kickoff-ready emit), a `DESIGN.md` (Google Labs format scaffolded by production-ready), and a `DOGFOOD.md` reflection on what the suite caught and missed.

## 2026-05-09 - Bus-factor mitigation: governance docs

The bus factor remains at 1, but the procedural blockers to adding a co-maintainer are now removed.

### Added

- `.github/CODEOWNERS`: routes PR review automatically. Default `* @aihxp` plus path-specific rules calling out high-blast-radius surfaces (SUITE.md, ORCHESTRATORS.md, install.sh, scripts/, .github/workflows, TRIGGER-DISAMBIGUATION.md, plugin marketplace manifest).
- `CONTRIBUTING.md`: contributor-facing guide. Covers what kinds of contributions land, what gets refused, the unicode rule, the bash 3.2 rule, the SUITE.md byte-identical rule, the `frontmatter-version` matches `CHANGELOG.md` rule, the `compatible_with` standards-level values, the trigger-overlap advisory, lint mechanics, single-skill vs. coordinated cross-suite change protocols, commit-message style.
- `MAINTAINING.md`: maintainer-facing how-to. Documents the five rituals (single-skill patch, coordinated cross-suite patch, hub-only patch, lint regression recovery, new-specialist release), version-bump rules with examples, tag-release parity discipline with backfill recipe, SUITE.md sync mechanics, em-dash rule, and a clean-coordinated-patch checklist.

## 2026-05-09 - Worked example chain across the planning tier

Four `EXAMPLE-*.md` reference files added across the planning-tier skills. Each demonstrates what a real artifact looks like:

- `prd-ready/references/EXAMPLE-PRD.md`
- `architecture-ready/references/EXAMPLE-ARCH.md`
- `roadmap-ready/references/EXAMPLE-ROADMAP.md`
- `stack-ready/references/EXAMPLE-STACK.md`

The four files use a single fictional product, Pulse (a Customer Success ops platform for B2B SaaS account managers, 14-week paying-pilot scope, 5-person team, $400/mo cost ceiling). Each example cross-references the upstream and downstream examples so the four together demonstrate the suite's compose-by-artifact principle: PRD -> ARCH consumes -> ROADMAP consumes -> STACK consumes.

Each example passes its own skill's grep tests for the named failure modes. The PRD has no hollow / invisible / feature-laundry / solution-first / assumption-soup / moving-target violations. The architecture has no architecture-theater / paper-tiger / cargo-cult / stackitecture / scalable-without-numbers violations. Roadmap, similar pattern. Stack decision, similar pattern.

## 2026-05-09 - Trigger disambiguation table + lint check

### Added

- `references/TRIGGER-DISAMBIGUATION.md`: ~40-row canonical resolution table for ambiguous user phrases that plausibly match more than one of the eleven skills. Covers real overlap cases (set up CI, GitHub Actions, release automation, SECURITY.md, dependency scanning, branch protection, ADR, runbook, audit, performance, "make this production-ready," "we need to launch," post-mortem), an out-of-scope phrase table, and a one-question-two-options clarification protocol.
- `scripts/lint.sh` `trigger-overlap` check: extracts trigger phrases from each skill's description frontmatter, normalizes, strips stopwords, requires >= 2 signal tokens, does whole-word substring matching across distinct skill pairs. Advisory by default; `--strict-triggers` makes overlaps fail the lint.

## 2026-05-09 - ready-suite-lint: mechanical enforcement of suite discipline

The single biggest move: prose discipline becomes mechanical enforcement.

### Added

- `scripts/lint.sh` (bash 3.2 compatible): five checks against the hub plus the eleven sibling repos:
  - `suite-md-sync`: SUITE.md byte-identical across 12 repos
  - `frontmatter-version`: SKILL.md `version` matches CHANGELOG top entry
  - `tag-release-parity`: every git tag has a matching GitHub Release
  - `unicode-clean`: no em-dashes / arrows / box-drawing in suite-authored files
  - `compatible-with`: standards-level values present in frontmatter
- `.github/workflows/lint.yml`: runs the same lint on push to main, on pull requests, and daily at 06:00 UTC. The schedule catches drift from sibling pushes that do not trigger the hub workflow.

## 2026-05-09 - ORCHESTRATORS.md: Pattern Spec Kit

Added a "Pattern: Spec Kit as orchestrator" section to `ORCHESTRATORS.md`. Documents the interop story between Spec Kit (GitHub spec-driven development framework with `constitution.md` + per-feature `spec.md` / `plan.md` / `tasks.md`) and the ready-suite. Two integration shapes (Shape A: both running; Shape B: pick one). The `constitution.md` slot the suite leaves empty is named explicitly: ready-suite reads it as standing have-nots when present, never writes to it.

Mirrored to production-ready (the only specialist that carries `ORCHESTRATORS.md`). production-ready bumped to v2.6.1 in lockstep, per the v2.5.12 precedent that introduced `ORCHESTRATORS.md` as a patch.

## 2026-05-09 - DESIGN.md (Google Labs) consumption

production-ready v2.6.0 now detects a project-root `DESIGN.md` (the Google Labs format, Apache 2.0; `github.com/google-labs-code/design.md`) and consumes it as the canonical design-system token source for dashboards.

Three consumption paths in priority order: DTCG export (preferred), Tailwind v4 export, direct YAML read. The linter (`npx @google/design.md lint`) runs before component code so WCAG and token-resolution failures block the slice deterministically. The Agent Prompt Guide section is read as load-bearing have-nots.

When no `DESIGN.md` is present, production-ready falls back to its archetype + 5-decision derivation and optionally scaffolds a `DESIGN.md` from the chosen tokens before Step 4, so the next agent on the project starts at sub-step 3a, not 3b.

## 2026-05-09 - AGENTS.md cross-tool standard

The suite now meets the `AGENTS.md` cross-tool agent-brief standard (governed by the Linux Foundation's Agentic AI Foundation, the project-root brief read natively by Codex CLI, GitHub Copilot, Cursor, Windsurf, Aider, Zed, Warp, Roo Code, Jules, Factory, Amp, Devin, others).

- **kickoff-ready** v1.1.0: emits a project-root `AGENTS.md` mapping the suite's artifact paths when none exists (Step 6 sub-step 6a).
- **repo-ready** v1.6.10: scaffolds `AGENTS.md` as the canonical agent brief with `CLAUDE.md` as a thin overlay or symlink. Tier placements, anti-patterns, and per-tool deltas updated to match.

Both specialists respect any user-authored `AGENTS.md` already on disk.

## 2026-05-06 - Standards-compliant positioning: pi + OpenClaw

`install.sh` and `uninstall.sh` now detect [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) (`~/.pi/`) and [OpenClaw](https://github.com/openclaw/openclaw) (`~/.openclaw/`), writing to the neutral `~/.agents/skills/` path defined by the [Agent Skills standard](https://agentskills.io). Both harnesses read this path natively; future AgentSkills-compatible harnesses inherit support without per-tool integration.

`SUITE.md`: install-locations table adds rows for pi, OpenClaw, and the neutral path. New "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).

`compatible_with` frontmatter on all 11 skills: replaces `any-agent-with-skill-loading` with `any-agentskills-compatible-harness`; adds `pi` and `openclaw` as named verified harnesses.

Hub README: tagline rewritten as agentskills.io-compatible (no longer Claude-Code-centric); install sections add pi/OpenClaw via the neutral path; per-skill manual install gains a `~/.agents/skills` entry.

## 2026-04-29 - Claude Code plugin marketplace

Added a Claude Code plugin marketplace at `.claude-plugin/marketplace.json` bundling all eleven skills. One install command (`/plugin marketplace add aihxp/ready-suite` followed by `/plugin install ready-suite@ready-suite`) installs the meta plugin which depends on every specialist. Each plugin is vendored under `plugins/<skill>/` with its own manifest. The vendored copies are refreshed via `bash scripts/refresh-plugin-skills.sh` whenever a sibling cuts a release.

## 2026-04-25 - One-command install scripts

Added `install.sh` and `uninstall.sh`. Bash 3.2 compatible (macOS default). The installer detects which harnesses are present (`~/.claude`, `~/.codex`, `~/.cursor`), ensures a dev copy of each skill at `~/Projects/<skill>/`, and symlinks `SKILL.md` and `references/` into every detected platform's skills directory. Idempotent; re-run anytime. Edits to dev copies propagate live without re-install.

## 2026-04-22 - Suite-wide SUITE.md sync for kickoff-ready v1.0.0

Suite-wide `SUITE.md` refresh introducing the new **orchestration** tier and the eleventh sibling, kickoff-ready v1.0.0. New tier added as the first column of the four-tier diagram; new kickoff-ready row in the per-skill table; updated dependency-flow text; new composition principle 8 ("Orchestration is one-way: kickoff-ready knows about specialists; specialists do not know about kickoff-ready").

## 2026-04-15 - Initial hub

The discovery hub for the ready-suite. README with the eleven-skill table, install instructions, composition principles, license. The byte-identical `SUITE.md` ships in every skill repo so the suite map is visible from any entry point.

---

For the suite's collective version table at any given moment, see [`SUITE.md`](SUITE.md). For tag-release parity (every git tag in every skill repo has a matching GitHub Release), see [`MAINTAINING.md`](MAINTAINING.md) §"Tag-release parity."

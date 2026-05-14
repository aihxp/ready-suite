## v3.0.0 (2026-05-14)

Suite-wide release train alignment. This major release stabilizes the monorepo distribution model, synchronized Claude plugin packaging, strict trigger routing, Pillars project-context integration, and release hygiene for the eleven-skill suite.

### Changed
- Aligns this skill with the ready-suite 3.0.0 release train.
- Keeps the skill's existing artifact paths and trigger ownership intact while publishing the shared major version.

### Why a major
This is a coordinated suite release: all eleven skills, the ready-suite meta plugin, and the marketplace metadata now move together for the 3.0.0 train.

---

# Changelog

## v1.8.0 (2026-05-14)

Minor release. Adds first-class Pillars adoption and preservation to repo-ready. Pillars is treated as an optional project-context standard under `AGENTS.md`: repo-ready detects existing `agents/*.md` pillar files, preserves their loading protocol, and can scaffold the minimal `AGENTS.md` plus `agents/context.md` and `agents/repo.md` shape when the user explicitly asks to adopt Pillars.

### Added

- **SKILL.md Step 2a**: detects Pillars via root `AGENTS.md`, `agents/` frontmatter, or explicit user request.
- **Pillars scaffold rule**: creates only the always-loaded stubs (`context.md`, `repo.md`) and records unknowns as Gaps instead of inventing decisions.

### Why a minor, not a patch

The workflow gains observable behavior for a new project-context standard. The change is backward-compatible but not documentation-only.

---

## v1.7.0 (2026-05-09)

Minor release. Adds **Mode D (Multi-repo suite)** to the workflow. Mode D applies when the user is building or maintaining a coordinated collection of repos that ship together (a skill suite, a multi-package library, a meta-framework with separate plugin repos, an org-wide reference implementation across N services). Wraps per-unit scaffolding (Modes A/B) AND adds the cross-unit invariants: byte-identical collection map, coordinated version-table discipline, tag-release parity, the meta-linter pattern, the five maintenance rituals.

The pattern is generalized from the [aihxp/ready-suite](https://github.com/aihxp/ready-suite) suite (12 repos: 11 specialist skills + 1 hub) but applies to any multi-repo collection where: (a) the repos ship together as a logical unit, (b) at least one cross-repo invariant exists, (c) the maintainer wants the discipline mechanically enforced rather than documented-and-hoped-for.

### Added

- **`references/multi-repo-suite-layout.md`** (~410 lines): the canonical pattern. Documents when Mode D applies (3-of-6 detection criteria); top-level structure for hub vs specialist repos; what does NOT belong in a unit repo; the cross-repo invariants (six default checks the meta-linter enforces); the five rituals (single-unit patch, coordinated cross-collection patch, hub-only patch, hub + one-specialist patch, lint regression recovery, adding a new unit); version-bump rules (major / minor / patch flavored to the work shapes); tag-release parity with a backfill recipe; anti-patterns (documenting-without-enforcing, one-off-precedent-that-breaks-invariant, hub-without-meta-linter, duplicated-CONTRIBUTING, personal-local-config-committed, unsynced-version-table, tag-without-release); cross-references to other repo-ready references.
- **SKILL.md Step 0 mode detection**: Mode D entry with the 3-of-6 detection criteria and the load-on-demand pointer.
- **SKILL.md reference table**: new row for `references/multi-repo-suite-layout.md`.

### Why a minor, not a patch

The skill gains a new mode + a new substantial reference. Mode D is observable to users (the agent will detect multi-repo-suite shape and route to the new reference). Minor is the honest bucket.

### Cross-references

The canonical example of Mode D is the ready-suite hub itself. The pattern in `references/multi-repo-suite-layout.md` is generalized from `aihxp/ready-suite`. The aihxp/ready-suite/MAINTAINING.md now cross-references this new reference as the canonical source; the suite-specific MAINTAINING.md becomes the worked-example overlay above the generic pattern.

---


## v1.6.17 (2026-05-09)

Documentation patch. Adds `references/repo-antipatterns.md`, the named-failure-mode catalog this skill refuses, with grep tests, severity ladder, and per-skill guards. Closes one of the seven gaps named in MAINTAINING.md \"known-but-not-fixed inconsistencies\" (six skills lacked dedicated antipatterns files; this patch addresses the seventh in the same coordinated sweep).\n\n### Added\n\n- **`references/repo-antipatterns.md`** (~150 lines): named patterns extracted from the skill SKILL.md \"have-nots\" section, formatted with shape (concrete example), grep test (mechanical detection), severity (Critical / High / Medium / Low), guard (where the workflow catches it). Loaded on demand at every tier-gate check and during Mode C audits.\n- **Reference table row**: SKILL.md gains the new entry.\n\n### Changed\n\n- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.\n\n### Why a patch, not a minor\n\nAdditive reference content; SKILL.md body and frontmatter contract unchanged.\n\n---\n\n

## v1.6.16 (2026-05-09)

Documentation-only patch. Recovery sync after the just-retired v2.5.12 precedent. The repo-ready v1.6.15 release (which itself triggered the precedent retirement in MAINTAINING.md) shipped with the OLD SUITE.md committed; the catch-up sync to the other 10 siblings happened afterward in a separate hub commit, but the lint workflow correctly flagged the resulting drift. This patch lands the byte-identical SUITE.md across all 12 repos with the full version table current to all 11 specialists.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to the post-retirement state across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking; mechanical recovery from the lint-caught drift.

---


## v1.6.15 (2026-05-09)

Documentation patch. Refreshes `AUDIT-REPORT.md` with a 2026-05-09 re-audit confirming no score delta since the prior 2026-04-22 audit. Six patches landed in the interval (v1.6.9 through v1.6.14); none touched the scaffolding scored in the audit. Score remains 33/35 (Tier 4 -- Excellent).

### Changed

- **`AUDIT-REPORT.md`**: re-audit dated 2026-05-09; YAML frontmatter `audit_date` updated; `prior_audits` history field added; per-patch summary of what changed in v1.6.9 through v1.6.14 (none of it scored); informational note that the hub-level `scripts/lint.sh` now mechanically enforces several repo-ready disciplines as a suite-meta check.

### Why a patch, not a minor

Documentation refresh; no behavior change in the skill workflow.

---


## v1.6.14 (2026-05-09)

Hygiene cleanup. Updates `.gitignore` to prevent accidental commits of `.claude/settings.local.json` (Claude Code personal local-override files; the `.local` suffix is the convention for "do not commit") and `.planning/` (GSD development artifacts). SUITE.md sync.

### Changed

- **`.gitignore`**: added `.claude/settings.local.json` and `.planning/` patterns.
- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Gitignore additions + SUITE.md sync; no behavior change.

---


## v1.6.13 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the coordinated repo-hygiene cleanup landing across the ten other specialist repos: each gains `SECURITY.md` (private vulnerability disclosure policy with response-time SLAs), `.github/CODEOWNERS` (PR-review auto-routing), `CONTRIBUTING.md` (pointer to the hub canonical contributor guide), and `.gitignore` (where missing). repo-ready itself was the gold-standard reference for the audit; no scaffolding additions land here. This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.6.12 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the four planning-tier skill releases (prd-ready v1.0.10, architecture-ready v1.0.9, roadmap-ready v1.0.8, stack-ready v1.1.15) which add worked-example reference files for a single fictional B2B SaaS product (Pulse, a Customer Success ops platform). The four examples cross-reference each other to demonstrate the suite's compose-by-artifact principle: each downstream artifact reads from the prior one and refines, never duplicates. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.6.11 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v2.6.0 release of [production-ready](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready), which adds first-class consumption of the [Google Labs `DESIGN.md`](https://github.com/google-labs-code/design.md) format as the canonical design-system token source for dashboards. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `DESIGN.md` format and the consumption flow (production-ready Step 3 sub-step 3a). Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.6.10 (2026-05-09)

Documentation-only patch. Flips the `AGENTS.md` / `CLAUDE.md` canonicality recommendation in `references/onboarding-dx.md` Section 9 to track the [agents.md open standard](https://agents.md/) (now governed by the Linux Foundation's Agentic AI Foundation). `AGENTS.md` is the cross-tool canonical agent brief; `CLAUDE.md` is best treated as a thin Claude-Code-specific overlay (or a symlink: `ln -s AGENTS.md CLAUDE.md`).

### Changed

- **`references/onboarding-dx.md` §9 table**: `AGENTS.md` row promoted to "Official (Linux Foundation Agentic AI Foundation)" status; agent list expanded to name Codex CLI, GitHub Copilot, Cursor, Windsurf, Aider, Zed, Warp, Roo Code, Jules, Factory, Amp, Devin, and others. `CLAUDE.md` row reframed as the tool-specific overlay.
- **`AGENTS.md` and `CLAUDE.md` per-file sections**: order swapped so `AGENTS.md` leads. `CLAUDE.md` section rewritten to recommend symlink-or-`@AGENTS.md`-overlay shapes.
- **Tier placement**: `AGENTS.md` is now the default canonical at every tier. Tier 3 promotes `AGENTS.md` from "or" to mandatory; Tier 2 default canonical flipped.
- **Canonical template heading**: "Use this as `AGENTS.md`; mirror or symlink to `CLAUDE.md`".
- **Per-tool deltas**: `CLAUDE.md` entry rewritten to describe the symlink / overlay pattern.
- **Anti-pattern 1**: fix recommendation now defaults to `AGENTS.md` as canonical.

### Why a patch, not a minor

The scaffolding output the skill produces does not change; only the recommendation about which agent-brief file is canonical and which is the overlay flips. This is a documentation update to a reference file. Patch-level is the honest bucket.

---


## v1.6.9 (2026-05-06)

Documentation-only patch. Adds first-class support for [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) and [OpenClaw](https://github.com/openclaw/openclaw) via the [Agent Skills standard](https://agentskills.io). The suite now positions explicitly as agentskills.io-compatible: any harness that parses `SKILL.md` frontmatter natively runs every ready-suite skill first-class, with no per-tool integration. pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support for free.

### Changed

- **Frontmatter**: `compatible_with` now lists `pi`, `openclaw`, and `any-agentskills-compatible-harness` (the latter replaces the older `any-agent-with-skill-loading` value for tighter standards-level signaling).
- **SUITE.md**: install-locations table adds rows for pi, OpenClaw, and the neutral Agent Skills path; new "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).
- **Hub install.sh / uninstall.sh** (in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)): detect pi (`~/.pi/`) and OpenClaw (`~/.openclaw/`), write to the neutral `~/.agents/skills/` path. No regressions on the existing Claude Code / Codex / Cursor flow.

### Why a patch, not a minor

The skill's behavior, references, and workflow are unchanged. Only the frontmatter `compatible_with` list, `SUITE.md`, and the README install section move; the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only standards-compliance signaling.

---


## v1.6.8 (2026-05-06)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the new **orchestration** tier and the eleventh sibling, [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) v1.0.0. kickoff-ready sequences the ten core-suite specialists for greenfield projects from raw user intent: it triggers from a fresh idea ("kickoff," "I have an idea help me ship it") and invokes prd-ready -> architecture-ready -> roadmap-ready -> stack-ready -> repo-ready -> production-ready -> deploy-ready -> observe-ready -> (launch-ready || harden-ready), verifying each artifact on disk before advancing. It produces only `.kickoff-ready/PROGRESS.md`; it never produces specialist content. No behavioral changes to this skill.

### Changed

- **SUITE.md**: new "orchestration" tier introduced as the first column of the four-tier diagram; new kickoff-ready row in the per-skill table; updated dependency-flow text; new composition principle 8 ("Orchestration is one-way: kickoff-ready knows about specialists; specialists do not know about kickoff-ready"); known-good versions table now lists eleven skills.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.6.7 (2026-04-24)

Documentation-only patch. Removes the Mirror Box dogfood track from the ready-suite. The aihxp/mirror-box repo has been archived; the canonical-dogfood section in SUITE.md is gone; per-skill dogfood/ folders are deleted.

### Changed

- **SUITE.md** no longer carries the "Canonical dogfood target: Mirror Box" section. Byte-identical sync across all ten siblings.
- **dogfood/** folder removed from this repo.

### Why

The Mirror Box reference implementation required real infrastructure (Fastify + OTel + Fly.io + Honeycomb account) to fully exercise. The user wanted a skill suite, not a project that demands a particular hosted stack. Removing Mirror Box restores that posture: every skill stands on its own SKILL.md plus references; downstream consumers compose via the artifact contracts the skills describe, without depending on a shared hosted exemplar.

The interop standard is unchanged. Skills still produce `.{skill}-ready/*.md` artifacts; downstream siblings still read them. The contract holds without a canonical demo.

---


## v1.6.6 (2026-04-24)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the canonical dogfood target: [aihxp/mirror-box](https://github.com/aihxp/mirror-box). Adds a new "Canonical dogfood target" section to SUITE.md with links to the ten per-skill dogfood artifacts. Adds composition principle #7 codifying the byte-identical-SUITE.md invariant across siblings. No behavioral changes to the skill.

### Changed

- **SUITE.md**: new "Canonical dogfood target: Mirror Box" section with artifact links.
- **SUITE.md**: composition principles now include #7 (byte-identical SUITE.md across siblings).
- **SUITE.md**: version table bumped; all ten skills reflect the coordinated sync.

### Why a patch, not a minor

Same rationale as prior x.y.z patches: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.6.5 (2026-04-23)

Documentation-only patch. Reflects the arrival of `harden-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/harden-ready) as a live sibling in the ready-suite. harden-ready is the tenth and final core-suite skill; its v1.0.0 release completes the shipping tier alongside deploy-ready, observe-ready, and launch-ready, and completes the ready-suite across planning (four), building (two), and shipping (four) tiers. harden-ready owns post-deploy adversarial review, OWASP Top 10 walkthroughs (Web / API / LLM), compliance control-to-code mapping (SOC 2 / HIPAA / PCI-DSS / GDPR), pen-test preparation and retest discipline, responsible-disclosure program design beyond SECURITY.md, and class-not-instance post-incident hardening. No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `harden-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.6.5. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.6.4 (2026-04-23)

Documentation-only patch. Reflects the arrival of `roadmap-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/roadmap-ready) as a live sibling in the ready-suite. This release completes the nine-skill suite: `prd-ready` (what), `architecture-ready` (how), `roadmap-ready` (when), `stack-ready` (with what tools), `repo-ready` (the repo), `production-ready` (the app), `deploy-ready` (ship it), `observe-ready` (keep it healthy), `launch-ready` (tell the world). No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `roadmap-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.6.4. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.6.3 (2026-04-23)

Documentation-only patch. Reflects the arrival of `architecture-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/architecture-ready) as a live sibling in the ready-suite. architecture-ready is a new planning-tier sibling; repo-ready's stack-detection step may also read architecture-ready's service-count signal when choosing monorepo vs. polyrepo. No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list architecture-ready at 1.0.0. Every sibling's recorded version is bumped one patch to track the release. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.6.3. No content change beyond the version tag.

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [1.6.2] - 2026-04-23

Documentation-only patch. Reflects the arrival of `prd-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/prd-ready) as a live sibling in the ready-suite. This release completes the top of the planning tier: prd-ready defines WHAT we are building, upstream of architecture-ready (HOW), roadmap-ready (WHEN), and stack-ready (WITH WHAT TOOLS). No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list prd-ready at 1.0.0 alongside production-ready 2.5.6, repo-ready 1.6.2, stack-ready 1.1.5, deploy-ready 1.0.4, observe-ready 1.0.3, and launch-ready 1.0.1. Copy remains byte-identical across every live sibling.

## [1.6.1] - 2026-04-23

Documentation-only patch. Reflects the arrival of launch-ready v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/launch-ready) as a live sibling in the ready-suite. This release completes the shipping tier: deploy-ready ships it, observe-ready keeps it healthy, launch-ready tells the world. No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list launch-ready at 1.0.0 alongside production-ready 2.5.5, repo-ready 1.6.1, stack-ready 1.1.4, deploy-ready 1.0.3, and observe-ready 1.0.2. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.6.1. No content change beyond the version tag.

## [1.6.0] - 2026-04-23

### Changed

Suite-membership retrofit. No behavior change; repo-ready is brought into alignment with the ready-suite interop standard introduced in production-ready v2.5.0.

Three drift fixes landed:

- **Unicode cleanup (346 substitutions across 8 files).** Every em dash, en dash, horizontal bar, figure dash, non-breaking hyphen, minus sign, right arrow, and box-drawing horizontal replaced with ASCII equivalents. Distribution: SKILL.md (141), CHANGELOG.md (84), DOCS.md (33), AUDIT-REPORT.md (31), README.md (31), SECURITY.md (13), CONTRIBUTING.md (9), CLAUDE.md (4). Scan returns 0 remaining hits across those files.
- **SUITE.md added at repo root.** Byte-identical to production-ready's canonical copy, modulo the known-good versions table: repo-ready now lists as 1.6.0. The other four live siblings (production-ready 2.5.3, stack-ready 1.1.2, deploy-ready 1.0.1, observe-ready 1.0.0) will land matching patches so the byte-identical invariant holds across the suite.
- **SKILL.md frontmatter extended with nine interop standard fields.** `version`, `updated`, `changelog`, `suite`, `tier`, `upstream`, `downstream`, `pairs_with`, `compatible_with` added alongside the pre-existing `name` and `description`. Tier is "building." Downstream is `[production-ready]` (production-ready consumes repo conventions). Pairs with production-ready. Compatible with Claude Code, Codex, Cursor, Windsurf, and any agent that can load Markdown skill files.

### Known debt (explicitly deferred)

- **Reference-file Unicode pass.** The 21 files in `references/` still contain Unicode dashes and arrows. Deferred to v1.7 or later because the retrofit scope was strictly SKILL.md and the eight root docs.
- **Six required SKILL.md sections from the interop standard** (Suite membership, Consumes from upstream, Produces for downstream, and others). Not added in this retrofit; follow-up pass tracked under v1.7+.
- **SKILL.md audit.** This file is 50-90% larger than the other siblings' SKILL.md files. Some of that surface is legitimate (repo hygiene covers a big domain), some may be bloat. That is its own conversation, not this retrofit. Tracked under v1.7+.

### Not changed

SKILL.md behavior. The workflow, rules, have-nots, reference list, and load patterns stay exactly as in v1.5. Only Unicode and frontmatter changed.

References directory. 21 files untouched.

Dev tooling. `.github/`, `.pre-commit-config.yaml`, `.markdownlint.json`, `Makefile` unchanged.

Commit history. Prior commits with Unicode characters in their messages remain as they are. Going forward, new commits follow the Unicode rule.

## [1.5.0] - 2026-04-22

### Added

**Dogfood -- applied repo-ready to its own repository.** The v1.4 self-audit scored this repo at 11/35 Tier 1 Needs Work. v1.5 closed that gap: the new score is **33/35 Tier 4 Excellent (+22)**. The repository that ships the skill now follows its own skill's advice.

**Phase 1 -- Essentials + Community Pack:**
- `.gitignore`, `.gitattributes`, `.editorconfig` at repo root (Tier 1 essentials)
- `CONTRIBUTING.md` documenting the real workflow -- Conventional Commits, byte-ceilings (SKILL.md ≤ 40KB, references ≤ 80KB), no-placeholder doctrine, `make audit` pre-PR
- `CODE_OF_CONDUCT.md` -- Contributor Covenant v2.1 with GitHub Discussions as enforcement channel
- `SECURITY.md` -- GitHub Private Vulnerability Reporting per v1.2 SEC-01, 72h ack / 7d triage / 90d disclosure
- `.github/ISSUE_TEMPLATE/bug_report.yml`, `feature_request.yml`, `config.yml` -- YAML forms with which-AI-agent triage field
- `.github/PULL_REQUEST_TEMPLATE.md` -- 6-item checklist including byte-ceiling verification and placeholder grep
- `.github/CODEOWNERS` -- maintainer ownership

**Phase 2 -- Quality Tooling + CI + Agent Safety:**
- `.markdownlintrc.json`, `.prettierrc.json`, `.prettierignore`, `.pre-commit-config.yaml` -- Markdown quality tooling
- `.github/workflows/ci.yml` -- 5-job CI dogfooding the skill's own rules: byte-ceilings (SKILL.md ≤ 40KB, references ≤ 80KB), no-placeholders (grep for `{{` outside allowlist), no-example-com (grep in SECURITY.md + CONTRIBUTING.md), xref-check (every `references/FILE.md` link resolves), markdownlint. Every Action pinned by 40-char commit SHA per SAFE-06.
- `.github/dependabot.yml` -- `github-actions` ecosystem, daily, grouped minor+patch
- `.claude/settings.json` -- v1.3 agent-safety denylist (14 deny rules + 3 allow rules) copied verbatim from `references/agent-safety.md` (AGENT-01)
- `.githooks/pre-push`, `.githooks/install.sh` -- POSIX force-push blocker copied verbatim (AGENT-02)
- `.gitleaks.toml` -- secret scanning with allowlist for reference files (which contain API-key-shaped strings as documentation) (AGENT-03)

**Phase 3 -- DX + Release Hygiene + Re-audit:**
- `Makefile` with 6 targets: `lint`, `format`, `check-sizes`, `hooks`, `audit`, `release`
- 4 shields.io badges in README.md (CI status, MIT license, latest release, AI skill)
- GitHub repo description updated: "12 stacks" -> "16 stacks"
- Branch protection ruleset active on `main` -- require 1 PR review, require 5 CI status checks pass (`byte-ceilings`, `no-placeholders`, `no-example-com`, `xref-check`, `markdownlint`), prevent branch deletion, prevent non-fast-forward pushes
- GitHub Release backfilled for `v1.2` tag
- `AUDIT-REPORT.md` at repo root with 33/35 audit delta

### Self-audit scoreboard

| Category | Before | After | Delta |
|---|---|---|---|
| Essentials | 4/7 | 7/7 | +3 |
| Community | 2/7 | 7/7 | +5 |
| Quality | 0/5 | 5/5 | +5 |
| Security | 0/2 | 2/2 | +2 |
| DX | 2/5 | 5/5 | +3 |
| Release | 3/5 | 4/5 | +1 |
| Agent Safety | 0/3 | 3/3 | +3 |
| **Overall** | **11/35** | **33/35** | **+22** |

Tier: **Tier 1 Needs Work -> Tier 4 Excellent**

### Tech debt (accepted)

- **REPO-6.2 release automation** -- manual `gh release create` is acceptable for a Markdown skill with infrequent releases
- **CI hasn't run on `main` yet** -- trivial PR needed to register status checks so the branch-protection ruleset begins enforcing (2-minute follow-up, not a blocker)

## [1.4.0] - 2026-04-22

### Added

**Phase 1 -- Interactive Audit Mode:**
- `references/audit-mode.md` -- new Tier 2 reference (~28K bytes, ~9K tokens) with 11 H2 sections covering Mode C (Audit) workflow
- 42-point scorecard: 39 from `repo-audit.md` + 3 new checks (AGENT-01 denylist present, AGENT-02 pre-push hook present, AGENT-03 gitleaks configured)
- Revised tier mapping for 42-point scale: 0-14 Needs Work / 15-24 Basic / 25-33 Good / 34-38 Excellent / 39-42 Exemplary
- Paste-ready `AUDIT-REPORT.md` template -- skill writes this into audited repo's root with YAML frontmatter (score object, tier, gaps by severity, agent_runtime_concerns list) + Markdown sections for critical/high/medium/low gaps with per-gap fix instructions
- Re-audit loop: score-delta one-liner format comparing current run against previous AUDIT-REPORT.md. No state file beyond the report itself.
- Score adjustment (AUDIT-04): v1.3's three unfixable behaviors (slopsquatting, bypass-by-fallback, session-startup reconciliation) appear in `agent_runtime_concerns` section but are NOT counted against the 42-point denominator -- v1.3 honesty-over-coverage principle applied to scoring
- Worked example: fictional `acme-dashboard` Node.js project at 28/42 (Tier 2 -- Basic) showing the full AUDIT-REPORT.md output structure
- SKILL.md load-table row for audit-mode.md + Step 0 Mode C cross-reference (+192 bytes)

**Phase 2 -- Stack Expansion:**
- **Zig support** (`references/repo-structure.md`, `quality-tooling.md`, `ci-cd-workflows.md`, `project-profiles.md`) -- `build.zig`/`build.zig.zon`, zig fmt, zig build test, `goto-bus-stop/setup-zig@v2` pinned to 0.13.0
- **Gleam support** -- gleam.toml/manifest.toml, gleam format/check, gleam test, `erlef/setup-beam@v1` pinned to Gleam 1.4 + Erlang 27.0
- **Deno support** -- deno.json/deno.lock, deno fmt/lint/check/test, `denoland/setup-deno@v2` pinned to v2.0.x, JSR publishing job
- **Bun support** -- bun.lockb, bun install/test + Biome, `oven-sh/setup-bun@v2` pinned to 1.1.x. Bun-first vs Bun-drop-in decision rubric documented.
- Stack count bumped **12 -> 16** across SKILL.md stack-detection table (+4 rows: `build.zig`, `gleam.toml`, `deno.json`, `bun.lockb`), README.md ("12 stacks. One skill." -> "16 stacks. One skill." + 4 new table rows), DOCS.md
- `references/quality-tooling.md` Decision Matrix extended with 4 new rows

### Summary

- **Interactive audit capability live** -- ADV-01 (open since v1.1, 4 milestones deep) finally closed
- **16 supported stacks** (was 12 at v1.3 close)
- **21 reference files** (was 20 at v1.3; `audit-mode.md` added)
- SKILL.md 38,890 -> 39,372 bytes (+482, stayed under 40K ceiling, 628 bytes headroom preserved)
- 2 phases, 8 requirements, 9 atomic task commits, zero tech debt
- `references/quality-tooling.md` now 66,162 bytes (83% of 80K reference ceiling -- largest reference file)

## [1.3.0] - 2026-04-22

### Added

**Phase 1 -- Agent Safety Contract:**
- `references/agent-safety.md` -- new Tier 3 reference (~41K bytes, ~13K tokens) with 11 sections covering the enforceable contract against destructive AI-agent operations
- Paste-ready `.claude/settings.json` denylist template with 14 `permissions.deny` rules (blocks `git reset --hard`, `git push --force*`, `git clean -fd`, `git filter-repo`, `rm -rf ~`, `rm -rf /`, `git commit --no-verify`, and short-form variants) and 3 `permissions.allow` safer alternatives (`--force-with-lease`, `reset --mixed`, `reset --soft`)
- Paste-ready POSIX `.githooks/pre-push` hook blocking force-push unless `--force-with-lease` is used OR `ALLOW_FORCE_PUSH=1` sentinel is set, with companion `.githooks/install.sh` and Makefile target
- Agent-agnostic equivalents for 4 coding agents (Cline, Copilot, Cursor, Windsurf) with paste-ready rules-file snippets
- CLAUDE.md / AGENTS.md "Destructive Operations Policy" clauses users can add to lock agent behavior
- Three documented-but-unfixable agent behaviors (slopsquatting, bypass-by-fallback, session-startup reconciliation) with honest Problem / Example-incident / Why-unfixable / What-needs schema -- cited to 6 real GitHub incidents on `anthropics/claude-code` plus external research sources
- SKILL.md cross-references: Step 0 Mode B rollback paragraph, Step 7 security, Tier 3 load-table row (+501 bytes; SKILL.md 38,389 -> 38,890 under 40K ceiling)

**Phase 2 -- Reference Hardening:**
- Secret-scanning (pre-commit) section in `references/quality-tooling.md` (+3,932 bytes) with paste-ready `.gitleaks.toml`, pre-commit.com integration, manual git-hook alternative, and CI backstop pointer. Cites Snyk's 28.65M-secrets-in-2025 figure and the 2× leak rate in AI-assisted commits.
- Atomic-commit protocol in `references/git-workflows.md` (+3,349 bytes) -- 5-step protocol (one concern per commit, intent-describing messages, `git add -p` hunk staging, `--fixup` + autosquash, pre-push audit), interactive `git add -p` example, anti-patterns, and the causal link between commit size and secret-leak rate
- README-as-attack-surface section in `references/security-setup.md` (+3,361 bytes) opening with the Comment-and-Control (CVSS 9.4) prompt-injection incident affecting Claude Code, Gemini CLI, and GitHub Copilot; 5 mitigation patterns; anti-patterns including unpinned Actions and `curl | bash`; back-reference to `agent-safety.md` denylist
- Updated `references/agent-safety.md` §§7/8/9 adjacency pointers from "Phase 2 will add…" to "covered in [target file]"

### Summary

- Real-world complaint coverage (measured against post-v1.2 research):
  - Destructive git operations: **2/10 -> 9/10**
  - Commit hygiene: **4/10 -> 8/10**
  - Security: **6/10 -> 9/10**
  - Quality tooling: **9/10 -> 10/10**
  - Existing repo handling: **4/10 -> 7/10**
  - Overall 10-category average: **6.1/10 -> 7.9/10**
  - Top-5 complaint-theme coverage: **4/10 -> 6.8/10**
- Reference library grows to **20 files** (19 + `agent-safety.md`)
- SKILL.md stayed under 40KB without a compression pass; 1,110 bytes headroom preserved

## [1.2.0] - 2026-04-22

### Added

**Phase 1 -- Platform Expansion:**
- `references/platform-bitbucket.md` -- complete Bitbucket Cloud reference (~44K bytes) covering Pipelines 2.0 YAML for all 12 supported stacks (Node, Python, Go, Rust, Java Maven/Gradle, Ruby, .NET, Swift Linux/macOS, PHP, Elixir, C/C++, Dart/Flutter/iOS), Pipes, self-hosted runners, deployment environments with variable precedence, build status API, branch permissions + REST API, merge strategies and merge checks, native vs Jira issue tracker, and a "migrating from GitHub -- five biggest differences" diff
- Platform-neutral fallback callout in `SKILL.md` Step 4 (PLAT-02) -- explicitly names Azure DevOps, Gitea, Forgejo, Codeberg, and SourceHut; draws the line between platform-neutral Tier 1 community standards + Tier 3 docs (which transfer unchanged) and platform-specific CI syntax, template locations, and branch protection (which require per-platform adjustment)

**Phase 2 -- Deep References:**
- `references/monorepo-patterns.md` -- deep coverage (~42K bytes) of 7 workspace tools (Nx, Turborepo, pnpm workspaces, yarn workspaces, moon, Cargo workspaces, Go workspaces) with decision matrix, per-tool affected-only CI patterns, per-package changelog strategy (Changesets, release-plz, release-please, manual), root-vs-package boundary rules, and anti-patterns. Satisfies ADV-02 (previously future-scope)
- Polyglot subsection in `SKILL.md` -- four rules for layering tools across languages: primary vs secondary language detection, no unifying linter/formatter/test-runner across stacks, CI matrix with one job per language (FastAPI + Next.js TS example), language-boundary rules with contract tests and generated types
- AI coding agent config files section in `references/onboarding-dx.md` (§9, ~11.6K bytes added) -- canonical template and per-tool deltas for `CLAUDE.md`, `AGENTS.md`, `.cursorrules`, `.windsurfrules`, `.github/copilot-instructions.md`, with tier placement (Tier 1 meta / Tier 2 team / Tier 3 public / Tier 4 reviewed) and anti-patterns

**Phase 3 -- Skill Hardening & Launch Deck:**
- Reference count drift resolved (SKILL-01) -- `SKILL.md`, `README.md`, and `DOCS.md` all reference "19 reference files"; `SKILL.md` load table now contains 19 rows matching `references/*.md` exactly (added missing `questioning.md` on-demand row)
- Mode B rollback protocol in `SKILL.md` Step 0 (SKILL-02) -- explicit stop/describe/propose flow when stack detection is low-confidence or a generated file would conflict with a non-obvious existing config; forbids silent overwrite and destructive git state changes (`git reset`, `git checkout --`, `git clean`, `rm`); applies only to Mode B (Greenfield has nothing to roll back; Audit is read-only)
- Solo-dev enforcement contact subsection in `references/security-setup.md` (SEC-01) -- GitHub Private Vulnerability Reporting (PVR) as default, Tidelift for funded projects, security.txt per RFC 9116 as redirector, personal email with dedicated alias as fallback; anti-patterns list rejects `security@example.com`, main personal email, Discord/Slack-for-security, and public issue trackers
- `DOCS.md` at repo root (LAUNCH-04, deferred from v1.1) -- reader-facing 10-minute overview with 9-step workflow table, 4-tier completion table, 19-row reference library table, key principles, and further reading pointers
- `README.md` refreshed -- reference count 17 -> 19, added `platform-bitbucket.md` and `monorepo-patterns.md` rows to the reference library table, new Documentation section linking `DOCS.md`

### Changed

- `SKILL.md` compressed (Phase 3 Task 1) from 39,997 to 37,459 bytes via prose tightening across workflow step intros, dos/don'ts deduplication against have-nots, Stack detection preamble, Core principle paragraph, and tier-practice bullets -- reclaimed 2,538 bytes to make room for SKILL-01 count fixes and SKILL-02 rollback protocol under the 40KB ceiling. No sections, tables, or reference rows removed.

## [1.1.0] - 2026-04-16

### Added
- Behavioral questioning reference (`references/questioning.md`) for adaptive project detection when auto-detection is insufficient
- Context budget guidance in SKILL.md -- load at most 2-4 reference files per session
- Approximate token counts for all 16 reference files in the load table
- Cross-reference map documenting which generated files reference each other, organized by tier
- Inline execution guidance for Tier 1 -- generate 5-7 files directly without subagent overhead
- Tier-aware generation rules in `references/community-standards.md` -- templates adapt based on which files exist at the current tier

## [1.0.0] - 2026-04-16

### Added
- Core `SKILL.md` with 9-step workflow, 4 completion tiers (Essentials, Team Ready, Mature, Hardened), 30 requirements
- 16 reference files loaded on demand:
  - `repo-structure.md` -- folder conventions and naming for 12 stacks
  - `community-standards.md` -- README, LICENSE, CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, CHANGELOG templates
  - `readme-craft.md` -- README anatomy, badges, demos, dark mode logos, SEO
  - `platform-github.md` -- issue forms, PR templates, dependabot, releases, CODEOWNERS, FUNDING.yml
  - `platform-gitlab.md` -- CI/CD, MR templates, container/package registry, Pages
  - `ci-cd-workflows.md` -- GitHub Actions and GitLab CI templates for all stacks
  - `quality-tooling.md` -- linters, formatters, git hooks per stack (Biome, Ruff, golangci-lint, clippy, etc.)
  - `security-setup.md` -- Dependabot/Renovate, CodeQL, secret scanning, SBOM, signed commits, supply chain
  - `release-distribution.md` -- SemVer, Keep a Changelog, semantic-release/release-please/changesets, npm/PyPI/crates.io/Docker publishing
  - `licensing-legal.md` -- license selection flowchart, CLAs/DCOs, compliance docs, SPDX
  - `git-workflows.md` -- trunk-based/GitHub Flow/GitFlow, bots, label taxonomy, merge strategies
  - `technical-docs.md` -- ADRs (MADR 4.0), whitepapers, RFCs, API docs, runbooks, post-mortems, diagrams-as-code
  - `community-governance.md` -- GOVERNANCE.md, MAINTAINERS, Discussions, funding, deprecation, contributor recognition
  - `onboarding-dx.md` -- Makefile/Justfile/Taskfile, devcontainers, setup scripts, IDE config, deployment configs
  - `project-profiles.md` -- 11 project types x 3 stages master matrix with stack tool recommendations
  - `repo-audit.md` -- 39-point health scorecard across 6 categories with automated scan script
- Stack detection for 12 ecosystems: JS/TS, Python, Go, Rust, Java/Kotlin, Ruby, C#/.NET, Swift, PHP, Elixir, C/C++, Dart/Flutter
- 11 project type profiles: Library, CLI, SaaS, API, Mobile, Desktop, DevOps, Data/ML, Monorepo, Doc site, Framework
- 3 entry modes: Greenfield, Enhancement, Audit
- Have-nots list (disqualifiers), dos, and don'ts
- Naming conventions per ecosystem (files, directories, branches, commits, tags)
- README.md and LICENSE (MIT)

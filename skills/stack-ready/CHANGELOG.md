## v3.0.0 (2026-05-14)

Suite-wide release train alignment. This major release stabilizes the monorepo distribution model, synchronized Claude plugin packaging, strict trigger routing, Pillars project-context integration, and release hygiene for the eleven-skill suite.

### Changed
- Aligns this skill with the ready-suite 3.0.0 release train.
- Keeps the skill's existing artifact paths and trigger ownership intact while publishing the shared major version.

### Why a major
This is a coordinated suite release: all eleven skills, the ready-suite meta plugin, and the marketplace metadata now move together for the 3.0.0 train.

---

# Changelog

## v1.1.21 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.7.0 release that adds Mode D (Multi-repo suite) to repo-ready workflow. This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.1.20 (2026-05-09)

Documentation patch. Adds `references/stack-antipatterns.md`, the named-failure-mode catalog this skill refuses, with grep tests, severity ladder, and per-skill guards. Closes one of the seven gaps named in MAINTAINING.md \"known-but-not-fixed inconsistencies\" (six skills lacked dedicated antipatterns files; this patch addresses the seventh in the same coordinated sweep).\n\n### Added\n\n- **`references/stack-antipatterns.md`** (~150 lines): named patterns extracted from the skill SKILL.md \"have-nots\" section, formatted with shape (concrete example), grep test (mechanical detection), severity (Critical / High / Medium / Low), guard (where the workflow catches it). Loaded on demand at every tier-gate check and during Mode C audits.\n- **Reference table row**: SKILL.md gains the new entry.\n\n### Changed\n\n- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.\n\n### Why a patch, not a minor\n\nAdditive reference content; SKILL.md body and frontmatter contract unchanged.\n\n---\n\n

## v1.1.19 (2026-05-09)

Documentation-only patch. Recovery sync after the just-retired v2.5.12 precedent. The repo-ready v1.6.15 release (which itself triggered the precedent retirement in MAINTAINING.md) shipped with the OLD SUITE.md committed; the catch-up sync to the other 10 siblings happened afterward in a separate hub commit, but the lint workflow correctly flagged the resulting drift. This patch lands the byte-identical SUITE.md across all 12 repos with the full version table current to all 11 specialists.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to the post-retirement state across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking; mechanical recovery from the lint-caught drift.

---


## v1.1.18 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.6.15 audit-refresh release. The v2.5.12 precedent (single-specialist patches do not trigger full SUITE.md sync) is retired effective this patch: the hub `scripts/lint.sh` `suite-md-sync` check enforces byte-identical `SUITE.md` across all 12 repos, so every specialist version bump (including audit-report refreshes that bump only one specialist) now triggers a full coordinated sync.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to repo-ready 1.6.15 across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.1.17 (2026-05-09)

Hygiene cleanup. Updates `.gitignore` to prevent accidental commits of `.claude/settings.local.json` (Claude Code personal local-override files; the `.local` suffix is the convention for "do not commit") and `.planning/` (GSD development artifacts). SUITE.md sync.

### Changed

- **`.gitignore`**: added `.claude/settings.local.json` and `.planning/` patterns.
- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Gitignore additions + SUITE.md sync; no behavior change.

---


## v1.1.16 (2026-05-09)

Documentation-only patch. Repo-hygiene cleanup landing as a coordinated sweep across the ten specialist skill repos. Adds `SECURITY.md`, `.github/CODEOWNERS`, `CONTRIBUTING.md`, and `.gitignore` (where missing). The audit was run via repo-ready audit-mode against all 12 suite repos; the gaps surfaced uniformly across the ten specialists (repo-ready was the gold-standard reference and needed no additions).

### Added

- **`SECURITY.md`**: private vulnerability disclosure policy. Two reporting channels (GitHub Security Advisories preferred; email fallback). Response-time SLAs by severity (Critical: 24h triage / 7d fix; High: 3d triage / 14d fix; Medium/Low: 7d triage). Names the realistic security surface for a markdown-only skill (prompt-injection, supply-chain tamper, malicious PR with hidden instructions); names known non-issues so reports are well-shaped. Cross-references the hub suite-wide policy.
- **`.github/CODEOWNERS`**: default `* @aihxp` rule. Comment block explains the second-maintainer addition path (replace the line with `@aihxp @second-handle` once a co-maintainer joins) and points at the hub cross-suite governance.
- **`CONTRIBUTING.md`**: thin pointer to the hub canonical contributor guide and the maintainer guide. Lists what the hub guide covers (unicode rule, bash 3.2 rule, SUITE.md byte-identical rule, frontmatter-version rule, compatible_with values, trigger-overlap advisory, lint mechanics, single-skill vs. coordinated-patch protocols, commit-message style). Avoids duplicating the canonical content here (one source of truth; eleven pointers).
- **`.gitignore`** (where missing): minimal OS / editor / install-backup ignores.

### What was deliberately NOT added

The audit also surfaced gaps for `CODE_OF_CONDUCT.md`, `.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md`, CI workflows, Dependabot, SAST, gitleaks, and `.editorconfig` / `.gitattributes`. These were rejected for skill repos because the repos are markdown-only documentation and have no users today. Adding bureaucratic scaffolding without a community to enforce it is theatre. When traction arrives, these get added in a follow-up patch; until then, the absence is honest.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill SKILL.md, references library, and frontmatter contract are unchanged. Only repo-hygiene scaffolding files added at project root and under `.github/`.

---


## v1.1.15 (2026-05-09)

Documentation patch. Adds `references/EXAMPLE-STACK.md`, a complete worked example stack decision for the same fictional B2B SaaS pilot (Pulse). Demonstrates a constraint map sourced from upstream PRD and architecture, nine ranked-shortlist categories with scoring rationale per candidate (web framework, database, auth library, frontend, CSS / design system, job runner, email transactional, hosting, observability), pairing compatibility checks, an itemized bundle summary against the cost ceiling ($50/mo of a $400/mo cap), and eight stack-level ADRs naming alternatives and migration paths. Passes the skill's grep tests for vibe-stack / resume-driven / premature-scale / decoupled-from-architecture / cost-blind failure modes.

### Added

- **`references/EXAMPLE-STACK.md`** (~410 lines): the worked stack decision. Includes constraint map, nine per-category shortlists with verdicts, pairing compatibility checks, bundle summary, eight ADRs with migration paths, pre-flight checklist for production-ready handoff.
- **Reference table row**: SKILL.md gains the EXAMPLE-STACK.md row.
- **SUITE.md**: known-good versions table bumped.

### Why a patch, not a minor

Additive reference content; SKILL.md body unchanged.

---


## v1.1.14 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v2.6.0 release of [production-ready](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready), which adds first-class consumption of the [Google Labs `DESIGN.md`](https://github.com/google-labs-code/design.md) format as the canonical design-system token source for dashboards. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `DESIGN.md` format and the consumption flow (production-ready Step 3 sub-step 3a). Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.1.13 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v1.1.0 release of [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) and the v1.6.10 release of [repo-ready](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready), both of which add first-class support for the [`AGENTS.md`](https://agents.md/) cross-tool agent-brief standard (Linux Foundation Agentic AI Foundation). kickoff-ready now emits a project-root `AGENTS.md` mapping the suite's artifact paths when none exists; repo-ready scaffolds `AGENTS.md` as the canonical agent brief with `CLAUDE.md` as a thin overlay or symlink. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `AGENTS.md` standard, the harnesses that read it, and the two specialists (kickoff-ready, repo-ready) that meet that surface. Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.1.12 (2026-05-06)

Documentation-only patch. Adds first-class support for [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) and [OpenClaw](https://github.com/openclaw/openclaw) via the [Agent Skills standard](https://agentskills.io). The suite now positions explicitly as agentskills.io-compatible: any harness that parses `SKILL.md` frontmatter natively runs every ready-suite skill first-class, with no per-tool integration. pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support for free.

### Changed

- **Frontmatter**: `compatible_with` now lists `pi`, `openclaw`, and `any-agentskills-compatible-harness` (the latter replaces the older `any-agent-with-skill-loading` value for tighter standards-level signaling).
- **SUITE.md**: install-locations table adds rows for pi, OpenClaw, and the neutral Agent Skills path; new "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).
- **Hub install.sh / uninstall.sh** (in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)): detect pi (`~/.pi/`) and OpenClaw (`~/.openclaw/`), write to the neutral `~/.agents/skills/` path. No regressions on the existing Claude Code / Codex / Cursor flow.

### Why a patch, not a minor

The skill's behavior, references, and workflow are unchanged. Only the frontmatter `compatible_with` list, `SUITE.md`, and the README install section move; the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only standards-compliance signaling.

---


## v1.1.11 (2026-05-06)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the new **orchestration** tier and the eleventh sibling, [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) v1.0.0. kickoff-ready sequences the ten core-suite specialists for greenfield projects from raw user intent: it triggers from a fresh idea ("kickoff," "I have an idea help me ship it") and invokes prd-ready -> architecture-ready -> roadmap-ready -> stack-ready -> repo-ready -> production-ready -> deploy-ready -> observe-ready -> (launch-ready || harden-ready), verifying each artifact on disk before advancing. It produces only `.kickoff-ready/PROGRESS.md`; it never produces specialist content. No behavioral changes to this skill.

### Changed

- **SUITE.md**: new "orchestration" tier introduced as the first column of the four-tier diagram; new kickoff-ready row in the per-skill table; updated dependency-flow text; new composition principle 8 ("Orchestration is one-way: kickoff-ready knows about specialists; specialists do not know about kickoff-ready"); known-good versions table now lists eleven skills.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.1.10 (2026-04-24)

Documentation-only patch. Removes the Mirror Box dogfood track from the ready-suite. The aihxp/mirror-box repo has been archived; the canonical-dogfood section in SUITE.md is gone; per-skill dogfood/ folders are deleted.

### Changed

- **SUITE.md** no longer carries the "Canonical dogfood target: Mirror Box" section. Byte-identical sync across all ten siblings.
- **dogfood/** folder removed from this repo.

### Why

The Mirror Box reference implementation required real infrastructure (Fastify + OTel + Fly.io + Honeycomb account) to fully exercise. The user wanted a skill suite, not a project that demands a particular hosted stack. Removing Mirror Box restores that posture: every skill stands on its own SKILL.md plus references; downstream consumers compose via the artifact contracts the skills describe, without depending on a shared hosted exemplar.

The interop standard is unchanged. Skills still produce `.{skill}-ready/*.md` artifacts; downstream siblings still read them. The contract holds without a canonical demo.

---


## v1.1.9 (2026-04-24)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the canonical dogfood target: [aihxp/mirror-box](https://github.com/aihxp/mirror-box). Adds a new "Canonical dogfood target" section to SUITE.md with links to the ten per-skill dogfood artifacts. Adds composition principle #7 codifying the byte-identical-SUITE.md invariant across siblings. No behavioral changes to the skill.

### Changed

- **SUITE.md**: new "Canonical dogfood target: Mirror Box" section with artifact links.
- **SUITE.md**: composition principles now include #7 (byte-identical SUITE.md across siblings).
- **SUITE.md**: version table bumped; all ten skills reflect the coordinated sync.

### Why a patch, not a minor

Same rationale as prior x.y.z patches: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.1.8 (2026-04-23)

Documentation-only patch. Reflects the arrival of `harden-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/harden-ready) as a live sibling in the ready-suite. harden-ready is the tenth and final core-suite skill; its v1.0.0 release completes the shipping tier alongside deploy-ready, observe-ready, and launch-ready, and completes the ready-suite across planning (four), building (two), and shipping (four) tiers. harden-ready owns post-deploy adversarial review, OWASP Top 10 walkthroughs (Web / API / LLM), compliance control-to-code mapping (SOC 2 / HIPAA / PCI-DSS / GDPR), pen-test preparation and retest discipline, responsible-disclosure program design beyond SECURITY.md, and class-not-instance post-incident hardening. No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `harden-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.1.8. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.1.7 (2026-04-23)

Documentation-only patch. Reflects the arrival of `roadmap-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/roadmap-ready) as a live sibling in the ready-suite. This release completes the nine-skill suite: `prd-ready` (what), `architecture-ready` (how), `roadmap-ready` (when), `stack-ready` (with what tools), `repo-ready` (the repo), `production-ready` (the app), `deploy-ready` (ship it), `observe-ready` (keep it healthy), `launch-ready` (tell the world). No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `roadmap-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.1.7. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.1.6 (2026-04-23)

Documentation-only patch. Reflects the arrival of `architecture-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/architecture-ready) as a live sibling in the ready-suite. architecture-ready is a new upstream planning-tier sibling; stack-ready's Step 1 pre-flight and Step 2 constraint map now pre-fill from `.architecture-ready/HANDOFF.md`. No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list architecture-ready at 1.0.0. Every sibling's recorded version is bumped one patch to track the release. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.1.6. No content change beyond the version tag.

## v1.1.5 (2026-04-23)

Documentation-only patch. Reflects the arrival of `prd-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/prd-ready) as a live sibling in the ready-suite. This release completes the top of the planning tier: prd-ready defines WHAT we are building, upstream of architecture-ready (HOW), roadmap-ready (WHEN), and stack-ready (WITH WHAT TOOLS). No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list prd-ready at 1.0.0 alongside production-ready 2.5.6, repo-ready 1.6.2, stack-ready 1.1.5, deploy-ready 1.0.4, observe-ready 1.0.3, and launch-ready 1.0.1. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.1.5. No content change beyond the version tag.

## v1.1.4 (2026-04-23)

Documentation-only patch. Reflects the arrival of launch-ready v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/launch-ready) as a live sibling in the ready-suite. The shipping tier is now complete. No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list launch-ready at 1.0.0 alongside production-ready 2.5.5, repo-ready 1.6.0, deploy-ready 1.0.3, and observe-ready 1.0.2. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.1.4. No content change beyond the version tag.

## v1.1.3 (2026-04-23)

Documentation-only patch. Reflects the arrival of repo-ready v1.6.0 as a live sibling in the ready-suite with its suite-membership retrofit (frontmatter interop fields, SUITE.md, Unicode cleanup). No behavioral changes to the skill.

### Changed

- **SUITE.md known-good versions table** updated: repo-ready now shows version 1.6.0 and its repo URL instead of "See its CHANGELOG."
- **SKILL.md frontmatter version** bumped to 1.1.3. No content change beyond the version tag.

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.1.2] - 2026-04-22

Documentation-only patch. Reflects the arrival of observe-ready v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/observe-ready) as a live sibling in the ready-suite. No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list observe-ready at 1.0.0 alongside production-ready 2.5.3, stack-ready 1.1.2, and deploy-ready 1.0.1. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.1.2. No content change beyond the version tag.

### Why a patch

Same rationale as 1.1.1: only the cross-sibling SUITE.md and the version stamps are touched. The skill's behavior, references, and scoring contract are unchanged.

---

## [1.1.1] - 2026-04-22

Documentation-only patch. Reflects the arrival of deploy-ready v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/deploy-ready) as a live sibling in the ready-suite. No behavioral changes to the skill.

### Added

- **`SUITE.md` at repo root.** Byte-identical copy of the suite map shared across every ready-suite sibling. Stack-ready did not previously ship one; this patch closes that gap so the byte-identical invariant holds across all live siblings (production-ready 2.5.2, stack-ready 1.1.1, deploy-ready 1.0.0).

### Changed

- **SKILL.md frontmatter version** bumped to 1.1.1. Template version stamps in DECISION.md, STATE.md, and the staleness-check output updated to match. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, references, and scoring contract are unchanged. Only the cross-sibling SUITE.md and the version stamps are touched. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---

## [1.1.0] - 2026-04-22

Research-driven refresh. Six parallel research threads (framework, data, auth/payments/email, hosting/observability/queues, decision methodology, cross-language) produced a consolidated dossier and surgical updates across every reference file. No architectural changes; all edits are evidence-backed against primary sources captured in `references/RESEARCH-2026-04.md`.

### Added

- **`references/RESEARCH-2026-04.md`** - the single source-of-truth dossier for 1.1.0's refresh. ~30K tokens. ~150 verified URLs across Stack Overflow, State of JS, Rising Stars, DB-Engines, ThoughtWorks Radar, vendor release notes, and migration postmortems. Structured per-dimension findings, meta-findings on scoring methodology, compliance snapshot, cross-dimension migration signal table.
- **Scoring framework: split `Ecosystem / maturity (15%)` into two axes** - `Ecosystem depth (8%)` and `Ecosystem trajectory (7%)`. Motivated by State of JS's distinct retention vs interest axes; Prisma/Drizzle is the canonical test case (depth vs trajectory diverge).
- **Scoring framework: new `Exit cost / reversibility (7%)` dimension**, redistributed from Ops and Cost. Convex/Firebase high DX but higher exit cost; Postgres + thin ORM scores high on exit cost. Used to be tradeoff-narrative-only; now a first-class score.
- **Scoring framework: "When to skip the scoring pass entirely" section** acknowledging the McKinley/DHH/Levels anti-scoring camp. Experience-backed, reversible, low-stakes decisions by small teams should run compact pre-flight only; formal scoring applied where it's cost not value is itself a failure mode.
- **Pre-flight: question 7 (Reversibility posture)** - Exploratory / Committed / Foundational. Includes per-dimension reversibility defaults (DB foundational, ORM committed, email exploratory, etc.).
- **SKILL.md: "team already knows" exit valve** in "When this skill does NOT apply." Routes stated-preference + reversible + no-constraint-change cases to compact-pre-flight-only.
- **SKILL.md DECISION.md template: `Prior art and analogous picks` section** (Rust RFC influence). Three real deployments with comparable stack at comparable scale; the strongest defense against horoscope-shaped recommendations.
- **5 new cross-domain bundle archetypes in `stack-bundles.md`**: Cloudflare-native (Workers + D1 + R2 + Durable Objects), Post-Cloud Rails (Rails 8 + Kamal 2 + Hetzner + Solid Queue), Phoenix LiveView, Django + HTMX + Alpine, TALL / Laravel + Livewire. Non-React alternatives promoted from Fast-to-Ship-only to first-class patterns.
- **Pairing rules: sync-engine anti-pairing** (Convex + Liveblocks over same state, Supabase Realtime + Convex).
- **Pairing rules: Auth.js + Better Auth anti-pairing** for new projects (Auth.js now in security-patch mode post September 2025 merge).
- **Pairing rules: extensive staleness refresh** covering Auth.js/Better Auth merger (Sept 2025), Remix v2 to React Router v7 (Nov 2024), Stripe + Lemon Squeezy acquisition (July 2024), Stripe Managed Payments (April 2025), Prisma 7 Rust-engine removal (late 2025), Neon + Databricks (May 2025), PlanetScale Postgres on Neki (Sept 2025), Redis fragmentation (2024, Valkey/DragonflyDB/Upstash), Highlight.io EOL (Feb 2026), Bun + Anthropic (Dec 2025), Vercel Fluid Compute (April 2025), Cloudflare Dev Platform GA.
- **Dimension deep-dives: LLM observability subsection** (Braintrust, Langfuse, Helicone, LangSmith, Phoenix).
- **Dimension deep-dives: TypeScript backend subsection** (Hono as edge/multi-runtime leader, Fastify Node-native, Elysia Bun-specific, NestJS enterprise, Express declining, tRPC as typed RPC layer).
- **Dimension deep-dives: JS runtime sub-axis** (Node 24 LTS / Node 22 LTS / Bun / Deno 2 production posture).
- **Dimension deep-dives: session replay as a separate lane** (Sentry Replay default, OpenReplay OSS, Highlight.io EOL).

### Changed

- **Default weight vector** rebalanced: DX 20 / Scale 13 / Cost 13 / EcoDepth 8 / EcoTraj 7 / Exit 7 / Ops 12 / Compliance 10 / Hireability 10 (sums to 100). Replaces the 1.0.0 7-dimension weight.
- **`Remix v2+`** references updated to `React Router v7 (formerly Remix v2)` across domain-stacks.md (merger was November 2024; Remix v3 forks Preact and is a separate product).
- **`Auth.js (7)`** references downgraded to `Auth.js (5, now in security-patch mode; for new projects use Better Auth)` across domain-stacks.md. Reflects the September 2025 Auth.js folding into Better Auth.
- **`Lemon Squeezy (7)`** references updated to `Polar (8, low-fee MoR) / Lemon Squeezy (6, acquired by Stripe, absorbing into SMP)` across domain-stacks.md.
- **Prisma scoring rationale updated** in dimension-deep-dives.md: historical penalties for bundle size and serverless cold start are stale as of Prisma 7 (late 2025). Prisma remains behind Drizzle on SQL transparency / bundle floor; parity on edge / cold start.
- **SendGrid scoring dropped from 7 to 6** in dimension-deep-dives.md: free tier removed in 2025; new accounts get 60-day trial then $19.95/mo minimum.
- **Grafana Cloud scoring bumped from 7 to 8** in dimension-deep-dives.md: primary migration target from Datadog with ~40% typical savings (50+ migrations per Grafana Labs).
- **Cloudflare scoring bumped from 7 to 8-9** in dimension-deep-dives.md: D1/Queues/Hyperdrive/Workflows GA since April 2024; Durable Objects with SQLite on free tier; Containers launched mid-2025.
- **Vercel scoring nuanced** in dimension-deep-dives.md: still 8 general, 9 for AI-agent apps post Fluid Compute (April 2025), 7 for content-heavy or high-egress workloads.
- **Frontmatter: version bumped to 1.1.0.** Session state and decision artifact templates updated to reference 1.1.0.
- **Reference library manifest extended** with `RESEARCH-2026-04.md`.

### Refreshed evidence base

All 1.1.0 scoring shifts are traceable to primary sources captured in `references/RESEARCH-2026-04.md`. Notable evidence underpinning the scoring shifts:

- Stack Overflow Developer Survey 2024 (Postgres #1 admired; Rust 72% admired for 10 consecutive years).
- State of JS 2024 (Astro + 39 pts satisfaction over Next.js; Next.js retention softening).
- JavaScript Rising Stars 2024 and 2025 (Hono #2 backend 2024; Bun #1 build tool 2025; htmx #1 frontend 2024).
- DB-Engines ranking trends Q1 2025 (Postgres top climber in 4 of 6 months).
- ThoughtWorks Tech Radar Vol 31 and 34 (Svelte moved to Adopt Oct 2024; TanStack Start on Trial).
- State of Django 2025 (HTMX 24% / Alpine 14% adoption among Django devs).
- State of Laravel 2025 (Livewire 62% / Inertia 48%).
- Grafana Labs migration case studies (50+ Datadog to Grafana moves with ~40% savings).
- 37signals cloud exit savings updated from $7M to $10M+ over five years.
- Convex public migration of its own infra from Aurora MySQL to PlanetScale Postgres (2025).

### Did not change (explicitly)

- The 9-step workflow, 4-tier completion structure, and Mode A/B/C/D detection are unchanged.
- The have-nots list is unchanged; 1.1.0 additions would overlap existing disqualifiers.
- No new hard anti-pairings beyond sync-engine overlap; existing anti-pairings remain accurate.
- The compliance-as-filter principle is unchanged.

## [1.0.0] - 2026-04-22

Initial release. Third skill in the ready-suite alongside `production-ready` and `repo-ready`. Scope: stack selection. Does not build apps (that's `production-ready`) or configure repos (that's `repo-ready`).

### Added

- **Core `SKILL.md` with 10-step workflow** (Steps 0 through 9), 4 completion tiers (Shortlist, Scored, Justified, Decided), 18 requirements, per-step "Passes when" acceptance gates.
- **Four entry modes**: Greenfield (A), Assessment (B), Audit (C), Migration (D).
- **12 scoring dimensions** across framework, language, database, ORM, auth, UI, client state, hosting, observability, payments, email, and background jobs.
- **12 domain profiles** with full per-dimension picks: SaaS Multi-tenant, E-commerce / Retail, CMS / Content, Fintech / Financial, Healthcare / Medical, Education / LMS, CRM / Sales / Marketing, Customer Support / Helpdesk, Marketplace / Two-sided, AI / ML / LLM products, Analytics / BI, Internal Tools / Back-office.
- **Three bundle archetypes per domain**: Safe Default, Fast-to-Ship, Enterprise. 36 total pre-combined bundles.
- **Pairing compatibility rules** covering the most common anti-pairings (Convex + Prisma, Supabase + Firebase, multiple auth providers, multiple ORMs, multiple UI libraries, etc.).
- **Scoring framework** with published default weights, override mechanics, and per-score discipline rules (no 10/10 without consensus, no 1/10 without documented failure mode).
- **Tradeoff narrative discipline**: every shortlisted bundle ships with flip point, scale ceiling, and switching cost in engineer-weeks.
- **Migration path protocol** (Mode D) covering blast radius, sequencing, rollback checkpoints, data migration strategy, and honest team cost.
- **`.stack-ready/DECISION.md` artifact template** that slots directly into `production-ready`'s Step 2 architecture note.
- **`.stack-ready/STATE.md` session handoff template** for multi-session decisions (common in Mode C and Mode D).
- **Staleness protocol**: Step 9 prints skill version, last-updated date, current date, and warns if the skill is older than 6 months.
- **Have-nots list** of disqualifying anti-patterns (scores without stated weights, flip-point-free recommendations, ghost libraries, undisclosed commercial ties, etc.).
- **Reference library** loaded on demand:
  - `references/stack-research.md` - mode detection and codebase inventory protocol
  - `references/preflight-and-constraints.md` - 6 pre-flight questions and the constraint map
  - `references/domain-stacks.md` - 12 domain profiles with per-dimension picks
  - `references/stack-bundles.md` - 36 pre-combined bundles (3 archetypes x 12 domains)
  - `references/pairing-rules.md` - anti-pairings, overlap detection, substitution chains
  - `references/scoring-framework.md` - 12 dimensions, default weights, override mechanics
  - `references/dimension-deep-dives.md` - per-dimension analysis for close-call decisions
  - `references/tradeoff-narratives.md` - flip points, scale ceilings, switching costs per candidate
  - `references/migration-paths.md` - X-to-Y sequences for common migrations

### Principles

- **Score for this job, not this year.** Every score is opinionated under stated weights. Change the weights, the score changes. Weights are always surfaced.
- **No recommendation without a flip point.** Every shortlisted bundle names the failure mode that would reverse the choice.
- **No vendor capture.** No paid placement, no undisclosed commercial ties, no scores inflated by relationships.
- **Stops at the decision.** Does not build apps or configure repos. Composes with `production-ready` and `repo-ready`.

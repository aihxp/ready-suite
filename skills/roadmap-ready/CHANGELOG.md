# Changelog

## v1.0.14 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.7.0 release that adds Mode D (Multi-repo suite) to repo-ready workflow. This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.13 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the coordinated antipattern-catalog sweep landing across stack-ready, repo-ready, production-ready, deploy-ready, observe-ready, launch-ready, and harden-ready. Each of those seven skills gains a dedicated `references/<skill>-antipatterns.md` file (named-failure-mode catalog with grep tests). This skill already had its own `<skill>-antipatterns.md` (or equivalent) and is unchanged in content; only frontmatter version + updated and SUITE.md tick.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.12 (2026-05-09)

Documentation-only patch. Recovery sync after the just-retired v2.5.12 precedent. The repo-ready v1.6.15 release (which itself triggered the precedent retirement in MAINTAINING.md) shipped with the OLD SUITE.md committed; the catch-up sync to the other 10 siblings happened afterward in a separate hub commit, but the lint workflow correctly flagged the resulting drift. This patch lands the byte-identical SUITE.md across all 12 repos with the full version table current to all 11 specialists.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to the post-retirement state across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking; mechanical recovery from the lint-caught drift.

---


## v1.0.11 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.6.15 audit-refresh release. The v2.5.12 precedent (single-specialist patches do not trigger full SUITE.md sync) is retired effective this patch: the hub `scripts/lint.sh` `suite-md-sync` check enforces byte-identical `SUITE.md` across all 12 repos, so every specialist version bump (including audit-report refreshes that bump only one specialist) now triggers a full coordinated sync.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to repo-ready 1.6.15 across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.10 (2026-05-09)

Hygiene cleanup. Removes `.claude/settings.local.json` (a personal local-override file accidentally committed; the `.local` suffix is the convention for "do not commit"). Updates `.gitignore` to prevent future accidental commits. SUITE.md sync.

### Removed

- **`.claude/settings.local.json`**: deleted. The file contained personal-machine-specific permission grants (hardcoded local paths in some cases) that were never intended to be committed. Project-level `.claude/settings.json` (without `.local`) is the canonical committed form when a repo needs project-level Claude Code settings; this skill does not have one and does not need one at v1.

### Changed

- **`.gitignore`**: added `.claude/settings.local.json` and `.planning/` patterns.
- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

File cleanup + gitignore tweak; no behavior change.

---


## v1.0.9 (2026-05-09)

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


## v1.0.8 (2026-05-09)

Documentation patch. Adds `references/EXAMPLE-ROADMAP.md`, a complete worked example roadmap for the same fictional B2B SaaS pilot (Pulse, 14-week paying-pilot, 5-person team, $400/mo cost ceiling). Demonstrates a named capacity input (140 eng-days, 42 design-days, 14 AE-days), Now-Next-Later horizons, three milestones with binary completion gates, a topologically-sorted slice queue feeding production-ready, a cutover cadence feeding deploy-ready, a KPI handoff feeding observe-ready, an explicit launch-milestone gate, and a risk register with named owners. Passes the skill's grep tests for fictional-precision / fictional-parallelism / quarter-stuffing / speculative-features / feature-factory / shelf-roadmap / roadmap-theater failure modes.

### Added

- **`references/EXAMPLE-ROADMAP.md`** (~480 lines): the worked roadmap. Includes capacity input table, Now-Next-Later horizons, three milestones with binary gates, week-by-week slice queue, capacity reconciliation, cutover cadence for deploy-ready, KPI handoff for observe-ready, launch-milestone gate, active risk register.
- **Reference table row**: SKILL.md gains the EXAMPLE-ROADMAP.md row.
- **SUITE.md**: known-good versions table bumped.

### Why a patch, not a minor

Additive reference content; SKILL.md body unchanged.

---


## v1.0.7 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v2.6.0 release of [production-ready](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready), which adds first-class consumption of the [Google Labs `DESIGN.md`](https://github.com/google-labs-code/design.md) format as the canonical design-system token source for dashboards. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `DESIGN.md` format and the consumption flow (production-ready Step 3 sub-step 3a). Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.6 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v1.1.0 release of [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) and the v1.6.10 release of [repo-ready](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready), both of which add first-class support for the [`AGENTS.md`](https://agents.md/) cross-tool agent-brief standard (Linux Foundation Agentic AI Foundation). kickoff-ready now emits a project-root `AGENTS.md` mapping the suite's artifact paths when none exists; repo-ready scaffolds `AGENTS.md` as the canonical agent brief with `CLAUDE.md` as a thin overlay or symlink. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `AGENTS.md` standard, the harnesses that read it, and the two specialists (kickoff-ready, repo-ready) that meet that surface. Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.5 (2026-05-06)

Documentation-only patch. Adds first-class support for [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) and [OpenClaw](https://github.com/openclaw/openclaw) via the [Agent Skills standard](https://agentskills.io). The suite now positions explicitly as agentskills.io-compatible: any harness that parses `SKILL.md` frontmatter natively runs every ready-suite skill first-class, with no per-tool integration. pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support for free.

### Changed

- **Frontmatter**: `compatible_with` now lists `pi`, `openclaw`, and `any-agentskills-compatible-harness` (the latter replaces the older `any-agent-with-skill-loading` value for tighter standards-level signaling).
- **SUITE.md**: install-locations table adds rows for pi, OpenClaw, and the neutral Agent Skills path; new "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).
- **Hub install.sh / uninstall.sh** (in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)): detect pi (`~/.pi/`) and OpenClaw (`~/.openclaw/`), write to the neutral `~/.agents/skills/` path. No regressions on the existing Claude Code / Codex / Cursor flow.

### Why a patch, not a minor

The skill's behavior, references, and workflow are unchanged. Only the frontmatter `compatible_with` list, `SUITE.md`, and the README install section move; the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only standards-compliance signaling.

---


## v1.0.4 (2026-05-06)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the new **orchestration** tier and the eleventh sibling, [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) v1.0.0. kickoff-ready sequences the ten core-suite specialists for greenfield projects from raw user intent: it triggers from a fresh idea ("kickoff," "I have an idea help me ship it") and invokes prd-ready -> architecture-ready -> roadmap-ready -> stack-ready -> repo-ready -> production-ready -> deploy-ready -> observe-ready -> (launch-ready || harden-ready), verifying each artifact on disk before advancing. It produces only `.kickoff-ready/PROGRESS.md`; it never produces specialist content. No behavioral changes to this skill.

### Changed

- **SUITE.md**: new "orchestration" tier introduced as the first column of the four-tier diagram; new kickoff-ready row in the per-skill table; updated dependency-flow text; new composition principle 8 ("Orchestration is one-way: kickoff-ready knows about specialists; specialists do not know about kickoff-ready"); known-good versions table now lists eleven skills.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.3 (2026-04-24)

Documentation-only patch. Removes the Mirror Box dogfood track from the ready-suite. The aihxp/mirror-box repo has been archived; the canonical-dogfood section in SUITE.md is gone; per-skill dogfood/ folders are deleted.

### Changed

- **SUITE.md** no longer carries the "Canonical dogfood target: Mirror Box" section. Byte-identical sync across all ten siblings.
- **dogfood/** folder removed from this repo.

### Why

The Mirror Box reference implementation required real infrastructure (Fastify + OTel + Fly.io + Honeycomb account) to fully exercise. The user wanted a skill suite, not a project that demands a particular hosted stack. Removing Mirror Box restores that posture: every skill stands on its own SKILL.md plus references; downstream consumers compose via the artifact contracts the skills describe, without depending on a shared hosted exemplar.

The interop standard is unchanged. Skills still produce `.{skill}-ready/*.md` artifacts; downstream siblings still read them. The contract holds without a canonical demo.

---


## v1.0.2 (2026-04-24)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the canonical dogfood target: [aihxp/mirror-box](https://github.com/aihxp/mirror-box). Adds a new "Canonical dogfood target" section to SUITE.md with links to the ten per-skill dogfood artifacts. Adds composition principle #7 codifying the byte-identical-SUITE.md invariant across siblings. No behavioral changes to the skill.

### Changed

- **SUITE.md**: new "Canonical dogfood target: Mirror Box" section with artifact links.
- **SUITE.md**: composition principles now include #7 (byte-identical SUITE.md across siblings).
- **SUITE.md**: version table bumped; all ten skills reflect the coordinated sync.

### Why a patch, not a minor

Same rationale as prior x.y.z patches: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

All notable changes to this skill are documented here. Format loosely follows [Keep a Changelog](https://keepachangelog.com/). Version numbers follow the ready-suite discipline: major for breaking skill-contract changes, minor for additive behavior changes, patch for documentation-only updates (including sibling-ship tracking in SUITE.md).

## v1.0.1 (2026-04-23)

Documentation-only patch. Reflects the arrival of `harden-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/harden-ready) as a live sibling in the ready-suite. harden-ready is the tenth and final core-suite skill; its v1.0.0 release completes the shipping tier alongside deploy-ready, observe-ready, and launch-ready, and completes the ready-suite across planning (four), building (two), and shipping (four) tiers. harden-ready owns post-deploy adversarial review, OWASP Top 10 walkthroughs (Web / API / LLM), compliance control-to-code mapping (SOC 2 / HIPAA / PCI-DSS / GDPR), pen-test preparation and retest discipline, responsible-disclosure program design beyond SECURITY.md, and class-not-instance post-incident hardening. No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `harden-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.1. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.0 (2026-04-23)

First stable release of roadmap-ready, the planning-tier skill that owns "sequence software work over time" in the [ready-suite](SUITE.md). This release completes the nine-skill suite: prd-ready (what), architecture-ready (how), roadmap-ready (when, this skill), stack-ready (with what tools), repo-ready (the repo), production-ready (the app), deploy-ready (ship it), observe-ready (keep it healthy), launch-ready (tell the world).

Ships with the full SKILL.md contract, eleven dense reference files, a 9,600-word research report with 267 citations backing every guardrail, and full interop-standard frontmatter. Walked against the Mirror Box dogfood project (traced-echo service shared with prd-ready, architecture-ready, deploy-ready, observe-ready, and launch-ready) before cut; rough edges surfaced during the walk are addressed below.

### The skill's fifteen named failure modes

roadmap-ready adopts, coins, and refuses a catalog of roadmap failures. Each maps to a specific class of AI-generated or AI-shaped roadmap output the skill refuses (citations in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md)).

- **Feature factory** (Cutler, 2016). Features listed with no outcome or measurement plan.
- **Build trap** (Perri, 2018). Output metrics as proxy for value; outcome metrics absent.
- **Roadmap theater.** Gantt-chart aesthetics with dates pulled from thin air. Industry term; adopted.
- **Fictional precision.** Day-level dates with no capacity input.
- **Fictional parallelism.** More concurrent tracks than engineers.
- **Invisible parallelism.** Parallel tracks with shared-service bottlenecks unacknowledged.
- **Quarter-stuffing.** Q1/Q2/Q3/Q4 filled to identical density and precision; no Now-Next-Later gradient.
- **Speculative roadmap.** Items not in the PRD, architecture, or any external constraint.
- **Shelf roadmap.** Written once, filed, never consulted; last-reviewed date older than a cadence cycle.
- **Polish-indefinitely.** Cycles extended past appetite by default; no circuit-breaker.
- **Perpetual-now.** All items in Now; no forward view. Inverse: Later stuffed, Now empty.
- **Linear (single-track) roadmap.** No parallelism despite capacity and DAG support.
- **Date-driven without appetite.** Fixed dates with no scope-flex mechanism.
- **Scope-driven disguised as date-driven.** Fixed both, no high-integrity commitment label.
- **Launch milestone without readiness gates.** Observability/rollback/runbooks dates absent.

### Core principle: grounded commitment, outcome-framed direction, or named open question

The skill's load-bearing discipline is the three-label test applied row by row to every roadmap item:

> Every item on the roadmap is exactly one of three things: a grounded commitment (fixed date and fixed scope, with a named reason and signed off), an outcome-framed direction (target outcome with appetite or confidence band), or a named open question (explicit "we do not yet know" with an owner and a due date). Nothing else.

The test is grep-testable. The have-nots in SKILL.md enforce it at every tier gate.

### What ships

- **SKILL.md** with the ready-suite interop standard: eleven frontmatter fields populated, seven required sections present. Twelve-step workflow (Step 0 through Step 11), four completion tiers (Sketch, Plan, Committed, Public-ready) totaling 26 requirements, a 20-item grep-testable have-nots list, a session state template, explicit consume/produce contracts with all five downstream siblings.
- **Eleven reference files** under `references/`. Load-on-demand table annotates each with the step or tier that loads it.
  - `roadmap-research.md`. Step 0 six-mode detection protocol (A greenfield, B AI-slop audit, C iteration, D pivot, E rescue, F freeze), named-failure-mode shortlist, upstream-signal checklist, resume protocol, one-sentence-user fallback, edge cases.
  - `sequencing-principles.md`. Step 1 pre-flight procedure, four-layer sequencing framework (topological + risk + appetite + capacity), grounding corollary, risk-first vs. easy-wins-first, when sequencing proves impossible.
  - `roadmap-anatomy.md`. Full ROADMAP.md template with annotations, eight-field milestone anatomy, Now-Next-Later precision gradient, format choices, public-derivative redaction rules, archive pattern.
  - `cadence-models.md`. Seven cadences (Shape Up 6+2, quarterly themes, SAFe PI, continuous delivery, milestone-based, two hybrids), selection matrix across seven axes, rationale template, cadence-adjacent practices (OKRs, Scrum, #NoEstimates), signals the cadence is wrong.
  - `dependency-graph.md`. Reading the architecture DAG, topological sort procedure, slice-level vs. component-level dependencies, capacity matching math with worked examples, Amdahl's law sanity check with formulas, shared-service bottlenecks.
  - `risk-driven-prioritization.md`. Eight frameworks (RICE, ICE, WSJF, MoSCoW, Kano, Opportunity Scoring, Riskiest-First, Appetite) with strengths/failures per framework, compatibility matrix, framework-per-cadence fit.
  - `scope-vs-time.md`. Appetite-xor-estimate rule, MoSCoW at milestone level, cut-scope-vs-move-date tradeoff with named exceptions, rabbit-hole anatomy, polish-indefinitely, scope cut procedure.
  - `handoff-to-execution.md`. HANDOFF.md structure with five sub-sections (stack-ready, production-ready, deploy-ready, observe-ready, launch-ready), slice queue schema, cutover cadence template, KPI table per milestone, launch summary pointer, cross-sibling consistency checks.
  - `launch-sequencing.md`. Launch modes catalog, seven launch-milestone fields, D-calendar template with D-30 through D+7, slip protocol with named exceptions, Mode F (freeze) discipline, post-launch D+7 transition, common launch-sequencing failures.
  - `review-cadence.md`. Review frequency by cadence, Mode C iteration pattern, authority map, re-plan triggers, freeze conditions, freshness indicators, archive rule, changelog discipline, broadcast discipline, retrospective cadence, Mode E recovery.
  - `roadmap-antipatterns.md`. 21 named antipatterns with source, shape, example, fix, grep marker, and summary disposition matrix linking each antipattern to the fix step.
- **RESEARCH-2026-04.md** (~36K tokens, 9,614 words, 267 unique URLs). Source citations behind every guardrail, antipattern attribution, and cadence choice. Ten sections covering named failure modes, AI-generated roadmap failure patterns, canonical roadmap literature, outcome-vs-output debate, cadence models, sequencing frameworks, dependency graphs and Amdahl, launch sequencing, downstream reads, state of the art in 2026.

### Mirror Box dogfood results

The skill was walked against the Mirror Box project (traced-echo service used as the dogfood target across prd-ready, architecture-ready, deploy-ready, observe-ready, and launch-ready). Inputs: `.prd-ready/PRD.md` (Tier 2 Spec) and `.architecture-ready/ARCH.md` (Tier 1 Sketch). Output: `.roadmap-ready/ROADMAP.md` and `HANDOFF.md`.

- **Mode detected:** Mode A (Greenfield, retroactive), single-milestone trivial case.
- **Cadence selected:** Shape Up small-batch (2 weeks), solo-dogfood variant.
- **Capacity input:** 1 engineer; ~6 engineer-weeks for the full milestone.
- **Topological sort:** trivial (single component, mirror-box).
- **Slice queue:** 3 slices; all shipped; archive-ready.
- **Launch:** not applicable (dogfood target, not a public product). Handoff sub-section explicitly "not applicable with reason."
- **Downstream handoff verification:** production-ready can read the slice queue directly. deploy-ready reads the single cutover date. launch-ready sub-section is correctly "not applicable."

The dogfood surfaced one rough edge: the initial HANDOFF.md template required every sub-section to be populated, even when the sibling was not in scope. Fixed in v1.0.0 by allowing explicit "not applicable" with a reason as a valid state.

### Ready-suite sync

This release is the largest cross-sibling sync in the suite's history. SUITE.md is updated to list roadmap-ready at v1.0.0 and to bump every sibling by one patch as part of the coordinated release:

- prd-ready: 1.0.1 -> 1.0.2 (doc-only patch)
- architecture-ready: 1.0.0 -> 1.0.1 (doc-only patch)
- stack-ready: 1.1.6 -> 1.1.7 (doc-only patch)
- production-ready: 2.5.7 -> 2.5.8 (doc-only patch)
- repo-ready: 1.6.3 -> 1.6.4 (doc-only patch)
- deploy-ready: 1.0.5 -> 1.0.6 (doc-only patch)
- observe-ready: 1.0.4 -> 1.0.5 (doc-only patch)
- launch-ready: 1.0.2 -> 1.0.3 (doc-only patch)

The suite is complete.

### Unicode hygiene

Every file in this release is ASCII-dash-clean: no em dashes (U+2014), no en dashes (U+2013), no right-arrow glyphs, no non-breaking hyphens, no figure dashes, no box-drawing characters. ASCII hyphens and `->` only. Scanned before commit; scan will be re-run at every release.

### License

MIT, matching the suite.

# Changelog

## v1.0.15 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.7.0 release that adds Mode D (Multi-repo suite) to repo-ready workflow. This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.14 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the coordinated antipattern-catalog sweep landing across stack-ready, repo-ready, production-ready, deploy-ready, observe-ready, launch-ready, and harden-ready. Each of those seven skills gains a dedicated `references/<skill>-antipatterns.md` file (named-failure-mode catalog with grep tests). This skill already had its own `<skill>-antipatterns.md` (or equivalent) and is unchanged in content; only frontmatter version + updated and SUITE.md tick.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.13 (2026-05-09)

Documentation-only patch. Recovery sync after the just-retired v2.5.12 precedent. The repo-ready v1.6.15 release (which itself triggered the precedent retirement in MAINTAINING.md) shipped with the OLD SUITE.md committed; the catch-up sync to the other 10 siblings happened afterward in a separate hub commit, but the lint workflow correctly flagged the resulting drift. This patch lands the byte-identical SUITE.md across all 12 repos with the full version table current to all 11 specialists.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to the post-retirement state across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking; mechanical recovery from the lint-caught drift.

---


## v1.0.12 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.6.15 audit-refresh release. The v2.5.12 precedent (single-specialist patches do not trigger full SUITE.md sync) is retired effective this patch: the hub `scripts/lint.sh` `suite-md-sync` check enforces byte-identical `SUITE.md` across all 12 repos, so every specialist version bump (including audit-report refreshes that bump only one specialist) now triggers a full coordinated sync.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to repo-ready 1.6.15 across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.11 (2026-05-09)

Hygiene cleanup. Updates `.gitignore` to prevent accidental commits of `.claude/settings.local.json` (Claude Code personal local-override files; the `.local` suffix is the convention for "do not commit") and `.planning/` (GSD development artifacts). SUITE.md sync.

### Changed

- **`.gitignore`**: added `.claude/settings.local.json` and `.planning/` patterns.
- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Gitignore additions + SUITE.md sync; no behavior change.

---


## v1.0.10 (2026-05-09)

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


## v1.0.9 (2026-05-09)

Documentation patch. Adds `references/EXAMPLE-ARCH.md`, a complete worked example architecture for the same fictional B2B SaaS product (Pulse). Demonstrates C4 context + container diagrams in ASCII, component breakdown, multi-tenant data architecture with single-schema + tenant-id discipline, named trust boundaries each carrying a code path, NFR-to-mechanism mapping, three ADRs with named alternatives. Passes the skill's grep tests for architecture-theater / paper-tiger / cargo-cult / stackitecture / scalable-without-numbers failure modes. Consumes the worked PRD; feeds the worked roadmap and stack-decision examples in their sibling repos.

### Added

- **`references/EXAMPLE-ARCH.md`** (~530 lines): the worked architecture. Includes context, container, component diagrams; data architecture with entity model and sync semantics; trust boundaries section with code-path attribution; NFR mapping; three ADRs; explicit out-of-scope section.
- **Reference table row**: SKILL.md gains the EXAMPLE-ARCH.md row.
- **SUITE.md**: known-good versions table bumped.

### Why a patch, not a minor

Additive reference content; SKILL.md body unchanged.

---


## v1.0.8 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v2.6.0 release of [production-ready](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready), which adds first-class consumption of the [Google Labs `DESIGN.md`](https://github.com/google-labs-code/design.md) format as the canonical design-system token source for dashboards. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `DESIGN.md` format and the consumption flow (production-ready Step 3 sub-step 3a). Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.7 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v1.1.0 release of [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) and the v1.6.10 release of [repo-ready](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready), both of which add first-class support for the [`AGENTS.md`](https://agents.md/) cross-tool agent-brief standard (Linux Foundation Agentic AI Foundation). kickoff-ready now emits a project-root `AGENTS.md` mapping the suite's artifact paths when none exists; repo-ready scaffolds `AGENTS.md` as the canonical agent brief with `CLAUDE.md` as a thin overlay or symlink. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `AGENTS.md` standard, the harnesses that read it, and the two specialists (kickoff-ready, repo-ready) that meet that surface. Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.6 (2026-05-06)

Documentation-only patch. Adds first-class support for [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) and [OpenClaw](https://github.com/openclaw/openclaw) via the [Agent Skills standard](https://agentskills.io). The suite now positions explicitly as agentskills.io-compatible: any harness that parses `SKILL.md` frontmatter natively runs every ready-suite skill first-class, with no per-tool integration. pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support for free.

### Changed

- **Frontmatter**: `compatible_with` now lists `pi`, `openclaw`, and `any-agentskills-compatible-harness` (the latter replaces the older `any-agent-with-skill-loading` value for tighter standards-level signaling).
- **SUITE.md**: install-locations table adds rows for pi, OpenClaw, and the neutral Agent Skills path; new "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).
- **Hub install.sh / uninstall.sh** (in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)): detect pi (`~/.pi/`) and OpenClaw (`~/.openclaw/`), write to the neutral `~/.agents/skills/` path. No regressions on the existing Claude Code / Codex / Cursor flow.

### Why a patch, not a minor

The skill's behavior, references, and workflow are unchanged. Only the frontmatter `compatible_with` list, `SUITE.md`, and the README install section move; the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only standards-compliance signaling.

---


## v1.0.5 (2026-05-06)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the new **orchestration** tier and the eleventh sibling, [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) v1.0.0. kickoff-ready sequences the ten core-suite specialists for greenfield projects from raw user intent: it triggers from a fresh idea ("kickoff," "I have an idea help me ship it") and invokes prd-ready -> architecture-ready -> roadmap-ready -> stack-ready -> repo-ready -> production-ready -> deploy-ready -> observe-ready -> (launch-ready || harden-ready), verifying each artifact on disk before advancing. It produces only `.kickoff-ready/PROGRESS.md`; it never produces specialist content. No behavioral changes to this skill.

### Changed

- **SUITE.md**: new "orchestration" tier introduced as the first column of the four-tier diagram; new kickoff-ready row in the per-skill table; updated dependency-flow text; new composition principle 8 ("Orchestration is one-way: kickoff-ready knows about specialists; specialists do not know about kickoff-ready"); known-good versions table now lists eleven skills.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.4 (2026-04-24)

Documentation-only patch. Removes the Mirror Box dogfood track from the ready-suite. The aihxp/mirror-box repo has been archived; the canonical-dogfood section in SUITE.md is gone; per-skill dogfood/ folders are deleted.

### Changed

- **SUITE.md** no longer carries the "Canonical dogfood target: Mirror Box" section. Byte-identical sync across all ten siblings.
- **dogfood/** folder removed from this repo.

### Why

The Mirror Box reference implementation required real infrastructure (Fastify + OTel + Fly.io + Honeycomb account) to fully exercise. The user wanted a skill suite, not a project that demands a particular hosted stack. Removing Mirror Box restores that posture: every skill stands on its own SKILL.md plus references; downstream consumers compose via the artifact contracts the skills describe, without depending on a shared hosted exemplar.

The interop standard is unchanged. Skills still produce `.{skill}-ready/*.md` artifacts; downstream siblings still read them. The contract holds without a canonical demo.

---


## v1.0.3 (2026-04-24)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the canonical dogfood target: [aihxp/mirror-box](https://github.com/aihxp/mirror-box). Adds a new "Canonical dogfood target" section to SUITE.md with links to the ten per-skill dogfood artifacts. Adds composition principle #7 codifying the byte-identical-SUITE.md invariant across siblings. No behavioral changes to the skill.

### Changed

- **SUITE.md**: new "Canonical dogfood target: Mirror Box" section with artifact links.
- **SUITE.md**: composition principles now include #7 (byte-identical SUITE.md across siblings).
- **SUITE.md**: version table bumped; all ten skills reflect the coordinated sync.

### Why a patch, not a minor

Same rationale as prior x.y.z patches: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

All notable changes to this skill are documented here. Format loosely follows [Keep a Changelog](https://keepachangelog.com/). Version numbers follow the ready-suite discipline: major for breaking skill-contract changes, minor for additive behavior changes, patch for documentation-only updates (including sibling-ship tracking in SUITE.md).

## v1.0.2 (2026-04-23)

Documentation-only patch. Reflects the arrival of `harden-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/harden-ready) as a live sibling in the ready-suite. harden-ready is the tenth and final core-suite skill; its v1.0.0 release completes the shipping tier alongside deploy-ready, observe-ready, and launch-ready, and completes the ready-suite across planning (four), building (two), and shipping (four) tiers. harden-ready owns post-deploy adversarial review, OWASP Top 10 walkthroughs (Web / API / LLM), compliance control-to-code mapping (SOC 2 / HIPAA / PCI-DSS / GDPR), pen-test preparation and retest discipline, responsible-disclosure program design beyond SECURITY.md, and class-not-instance post-incident hardening. No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `harden-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.2. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.1 (2026-04-23)

Documentation-only patch. Reflects the arrival of `roadmap-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/roadmap-ready) as a live sibling in the ready-suite. This release completes the nine-skill suite: `prd-ready` (what), `architecture-ready` (how), `roadmap-ready` (when), `stack-ready` (with what tools), `repo-ready` (the repo), `production-ready` (the app), `deploy-ready` (ship it), `observe-ready` (keep it healthy), `launch-ready` (tell the world). No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `roadmap-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.1. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.0 (2026-04-23)

Initial public release. Research-backed, dogfooded against the Mirror Box PRD, downstream-verified against stack-ready's handoff.

### Added

- **SKILL.md** with all 11 required frontmatter fields (`name`, `description`, `version`, `updated`, `changelog`, `suite`, `tier`, `upstream`, `downstream`, `pairs_with`, `compatible_with`), the six required ready-suite sections, plus the body: core principle, scope-fence negative triggers, 15-step workflow with per-step Passes-when gates, three completion tiers (Sketch / Contract / Living), the have-nots disqualifier list, reference library table, session state protocol, downstream handoff protocol.
- **Workflow steps** (Step 0 through Step 14): mode detection (A-F), architecture-load-bearing check, pre-flight, Mode C theater audit, system shape, component breakdown, data architecture, integration architecture, non-functional architecture, trust boundaries, ADR discipline, diagrams (C4 default), evolutionary architecture and fitness functions, downstream handoff block, alignment and sign-off, iterate-vs-freeze lifecycle, staleness check.
- **Reference library** (11 files): `architecture-research.md`, `system-shape.md`, `component-breakdown.md`, `data-architecture.md`, `integration-architecture.md`, `non-functional-architecture.md`, `trust-boundaries.md`, `adr-discipline.md`, `diagrams.md`, `evolutionary-architecture.md`, `architecture-antipatterns.md`. Each dense and opinionated; none placeholder.
- **RESEARCH-2026-04.md**: 78KB / ~9200-word research dossier with full citations from Richards/Ford, Ford/Parsons/Kua, Nygard, Brown (C4), Evans (DDD), Kleppmann (DDIA), Helland, Skelton/Pais, Shostack, ThoughtWorks Tech Radar, and public postmortems from Amazon Prime Video 2023, Segment 2018, Istio 2020, Shopify Packwerk, Facebook BGP 2021, Knight Capital 2012, Cloudflare 2019, Amazon S3 2017, Atlassian 2022, Roblox 2021.
- **Coined terms** documented and defined: "architecture theater," "paper-tiger architecture," "horoscope architecture," "ghost architecture," "stackitecture." SEO-availability verdicts captured in RESEARCH-2026-04.md section 2.
- **Cited terms** preserved with origin: "distributed monolith" (Newman), "resume-driven development" (Fritzsch et al., ICSE 2021), "big ball of mud" (Foote/Yoder 1997), "cargo-cult cloud-native" (Korokithakis 2015, Portainer 2024), "Cover Your Assets" (Brown/Malveau/McCormick/Mowbray 1998), "speculative generality" (Fowler).
- **README.md** with install instructions for Claude Code / Codex / Cursor / Windsurf / other agents, full trigger surface, prevention table mapping 24 named incidents/findings to enforced rules, and the reference-library guide.
- **SUITE.md** byte-identical to siblings; architecture-ready moved from "Not yet released" to "1.0.0."
- **Dogfood artifacts** at `dogfood/ARCH.md` and `dogfood/HANDOFF.md`, generated retroactively against the Mirror Box PRD from prd-ready v1.0.0. Verifies the stack-ready handshake: stack-ready can start from the HANDOFF.md without asking additional pre-flight questions.
- **LICENSE** (MIT).

### Design decisions (the opinionated parts)

- **Three tiers, not four.** prd-ready, stack-ready, and production-ready each use four tiers. architecture-ready uses three (Sketch / Contract / Living) because architecture's natural stopping points are "unblocks downstream" / "signed off" / "conformance running." A fourth tier would be arbitrary.
- **Load-bearing check as Step 1.** Not every project needs architecture-ready. The skill explicitly permits "skip architecture-ready entirely" for single-file CLIs, one-off scripts, static sites, and toy projects. Over-architecting is itself a failure mode.
- **Storage shape precedes database pick.** The data-architecture section names shapes (relational, document, event log, time-series, graph, etc.), not products. Stack-ready owns the product pick.
- **Trust boundaries are the output for production-ready's threat model.** The four canonical boundaries (network edge, authentication, authorization, tenant isolation) plus the fifth (regulatory/compliance) are the direct input to production-ready's Step 2 threat model. No duplication.
- **C4 as default, arc42 and 4+1 as alternatives.** Brown's C4 is the most widely adopted diagram discipline. The skill refuses C4 misuses that Brown himself catalogs (GOTO 2024 talk): mixed abstraction levels, missing technology on containers, unlabeled arrows.
- **Fitness functions are Tier 3 mandatory.** Named-but-not-wired fitness functions disqualify Tier 3. Ford/Parsons/Kua codified this; Shopify's Packwerk proves it scales to 2.8M-line monoliths.
- **ADR template extends Nygard.** Nygard's 2011 canonical format has Title/Status/Context/Decision/Consequences. This skill requires Date, Rationale, Alternatives rejected, Flip point, and Blast radius in addition. These extensions exist because AI-generated ADRs routinely omit rationale and alternatives.
- **Microservices default refused.** Default to modular monolith; microservices require one of three forcing functions. Rooted in ThoughtWorks Tech Radar 2018-2026 posture, Fowler's MonolithFirst, and public consolidation cases (Prime Video 2023, Segment 2018, Istio 2020).
- **Amazon Prime Video cited accurately.** The 2023 consolidation was one internal team's monitoring pipeline, not "Amazon abandoned microservices." Skill cites it with the clarification to avoid looking naive to engineers who know the detail.
- **Coined terms are load-bearing, not catchy.** "Architecture theater," "paper-tiger architecture," "horoscope architecture," "ghost architecture," and "stackitecture" are defined with specific detection criteria, not just evocative labels.

### Handshake contracts

- **Consumes** `.prd-ready/PRD.md` and `.prd-ready/HANDOFF.md` (architecture-ready sub-section, if present) as primary input. Degrades gracefully to warning plus explicit PRD-equivalent assumptions if absent.
- **Produces** `.architecture-ready/ARCH.md`, `.architecture-ready/HANDOFF.md` (three sub-sections: stack-ready, roadmap-ready, production-ready), `.architecture-ready/adr/NNNN-slug.md`, `.architecture-ready/diagrams/`, `.architecture-ready/STATE.md`.
- **Pairs with** prd-ready (upstream), roadmap-ready (downstream, not yet released), stack-ready (downstream, live).

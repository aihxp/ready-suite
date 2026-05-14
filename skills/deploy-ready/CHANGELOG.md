## v3.0.0 (2026-05-14)

Suite-wide release train alignment. This major release stabilizes the monorepo distribution model, synchronized Claude plugin packaging, strict trigger routing, Pillars project-context integration, and release hygiene for the eleven-skill suite.

### Changed
- Aligns this skill with the ready-suite 3.0.0 release train.
- Keeps the skill's existing artifact paths and trigger ownership intact while publishing the shared major version.

### Why a major
This is a coordinated suite release: all eleven skills, the ready-suite meta plugin, and the marketplace metadata now move together for the 3.0.0 train.

---

# Changelog

## v1.0.21 (2026-05-14)

Patch release. Tightens the deploy-ready trigger wording that overlapped repo-ready's GitHub Actions scaffolding trigger. Deploy-ready now uses the promotion-specific phrase `promote through Actions`, while repo-ready keeps ownership of "set up GitHub Actions" as repo hygiene.

### Changed

- **SKILL.md description**: replaced `GitHub Actions pipeline` with `promote through Actions` to make `trigger-overlap --strict-triggers` pass without changing deploy-ready's ownership of promotion pipelines.

### Why a patch, not a minor

Trigger disambiguation cleanup only; behavior and artifact contract are unchanged.

---

## v1.0.20 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.7.0 release that adds Mode D (Multi-repo suite) to repo-ready workflow. This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.19 (2026-05-09)

Documentation patch. Adds `references/deploy-antipatterns.md`, the named-failure-mode catalog this skill refuses, with grep tests, severity ladder, and per-skill guards. Closes one of the seven gaps named in MAINTAINING.md \"known-but-not-fixed inconsistencies\" (six skills lacked dedicated antipatterns files; this patch addresses the seventh in the same coordinated sweep).\n\n### Added\n\n- **`references/deploy-antipatterns.md`** (~150 lines): named patterns extracted from the skill SKILL.md \"have-nots\" section, formatted with shape (concrete example), grep test (mechanical detection), severity (Critical / High / Medium / Low), guard (where the workflow catches it). Loaded on demand at every tier-gate check and during Mode C audits.\n- **Reference table row**: SKILL.md gains the new entry.\n\n### Changed\n\n- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.\n\n### Why a patch, not a minor\n\nAdditive reference content; SKILL.md body and frontmatter contract unchanged.\n\n---\n\n

## v1.0.18 (2026-05-09)

Documentation-only patch. Recovery sync after the just-retired v2.5.12 precedent. The repo-ready v1.6.15 release (which itself triggered the precedent retirement in MAINTAINING.md) shipped with the OLD SUITE.md committed; the catch-up sync to the other 10 siblings happened afterward in a separate hub commit, but the lint workflow correctly flagged the resulting drift. This patch lands the byte-identical SUITE.md across all 12 repos with the full version table current to all 11 specialists.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to the post-retirement state across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking; mechanical recovery from the lint-caught drift.

---


## v1.0.17 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.6.15 audit-refresh release. The v2.5.12 precedent (single-specialist patches do not trigger full SUITE.md sync) is retired effective this patch: the hub `scripts/lint.sh` `suite-md-sync` check enforces byte-identical `SUITE.md` across all 12 repos, so every specialist version bump (including audit-report refreshes that bump only one specialist) now triggers a full coordinated sync.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to repo-ready 1.6.15 across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.16 (2026-05-09)

Hygiene cleanup. Removes `.claude/settings.local.json` (a personal local-override file accidentally committed; the `.local` suffix is the convention for "do not commit"). Updates `.gitignore` to prevent future accidental commits. SUITE.md sync.

### Removed

- **`.claude/settings.local.json`**: deleted. The file contained personal-machine-specific permission grants (hardcoded local paths in some cases) that were never intended to be committed. Project-level `.claude/settings.json` (without `.local`) is the canonical committed form when a repo needs project-level Claude Code settings; this skill does not have one and does not need one at v1.

### Changed

- **`.gitignore`**: added `.claude/settings.local.json` and `.planning/` patterns.
- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

File cleanup + gitignore tweak; no behavior change.

---


## v1.0.15 (2026-05-09)

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


## v1.0.14 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the four planning-tier skill releases (prd-ready v1.0.10, architecture-ready v1.0.9, roadmap-ready v1.0.8, stack-ready v1.1.15) which add worked-example reference files for a single fictional B2B SaaS product (Pulse, a Customer Success ops platform). The four examples cross-reference each other to demonstrate the suite's compose-by-artifact principle: each downstream artifact reads from the prior one and refines, never duplicates. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.13 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v2.6.0 release of [production-ready](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready), which adds first-class consumption of the [Google Labs `DESIGN.md`](https://github.com/google-labs-code/design.md) format as the canonical design-system token source for dashboards. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `DESIGN.md` format and the consumption flow (production-ready Step 3 sub-step 3a). Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.12 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v1.1.0 release of [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) and the v1.6.10 release of [repo-ready](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready), both of which add first-class support for the [`AGENTS.md`](https://agents.md/) cross-tool agent-brief standard (Linux Foundation Agentic AI Foundation). kickoff-ready now emits a project-root `AGENTS.md` mapping the suite's artifact paths when none exists; repo-ready scaffolds `AGENTS.md` as the canonical agent brief with `CLAUDE.md` as a thin overlay or symlink. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `AGENTS.md` standard, the harnesses that read it, and the two specialists (kickoff-ready, repo-ready) that meet that surface. Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.11 (2026-05-06)

Documentation-only patch. Adds first-class support for [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) and [OpenClaw](https://github.com/openclaw/openclaw) via the [Agent Skills standard](https://agentskills.io). The suite now positions explicitly as agentskills.io-compatible: any harness that parses `SKILL.md` frontmatter natively runs every ready-suite skill first-class, with no per-tool integration. pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support for free.

### Changed

- **Frontmatter**: `compatible_with` now lists `pi`, `openclaw`, and `any-agentskills-compatible-harness` (the latter replaces the older `any-agent-with-skill-loading` value for tighter standards-level signaling).
- **SUITE.md**: install-locations table adds rows for pi, OpenClaw, and the neutral Agent Skills path; new "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).
- **Hub install.sh / uninstall.sh** (in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)): detect pi (`~/.pi/`) and OpenClaw (`~/.openclaw/`), write to the neutral `~/.agents/skills/` path. No regressions on the existing Claude Code / Codex / Cursor flow.

### Why a patch, not a minor

The skill's behavior, references, and workflow are unchanged. Only the frontmatter `compatible_with` list, `SUITE.md`, and the README install section move; the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only standards-compliance signaling.

---


## v1.0.10 (2026-05-06)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the new **orchestration** tier and the eleventh sibling, [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) v1.0.0. kickoff-ready sequences the ten core-suite specialists for greenfield projects from raw user intent: it triggers from a fresh idea ("kickoff," "I have an idea help me ship it") and invokes prd-ready -> architecture-ready -> roadmap-ready -> stack-ready -> repo-ready -> production-ready -> deploy-ready -> observe-ready -> (launch-ready || harden-ready), verifying each artifact on disk before advancing. It produces only `.kickoff-ready/PROGRESS.md`; it never produces specialist content. No behavioral changes to this skill.

### Changed

- **SUITE.md**: new "orchestration" tier introduced as the first column of the four-tier diagram; new kickoff-ready row in the per-skill table; updated dependency-flow text; new composition principle 8 ("Orchestration is one-way: kickoff-ready knows about specialists; specialists do not know about kickoff-ready"); known-good versions table now lists eleven skills.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.9 (2026-04-24)

Documentation-only patch. Removes the Mirror Box dogfood track from the ready-suite. The aihxp/mirror-box repo has been archived; the canonical-dogfood section in SUITE.md is gone; per-skill dogfood/ folders are deleted.

### Changed

- **SUITE.md** no longer carries the "Canonical dogfood target: Mirror Box" section. Byte-identical sync across all ten siblings.
- **dogfood/** folder removed from this repo.

### Why

The Mirror Box reference implementation required real infrastructure (Fastify + OTel + Fly.io + Honeycomb account) to fully exercise. The user wanted a skill suite, not a project that demands a particular hosted stack. Removing Mirror Box restores that posture: every skill stands on its own SKILL.md plus references; downstream consumers compose via the artifact contracts the skills describe, without depending on a shared hosted exemplar.

The interop standard is unchanged. Skills still produce `.{skill}-ready/*.md` artifacts; downstream siblings still read them. The contract holds without a canonical demo.

---


## v1.0.8 (2026-04-24)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the canonical dogfood target: [aihxp/mirror-box](https://github.com/aihxp/mirror-box). Adds a new "Canonical dogfood target" section to SUITE.md with links to the ten per-skill dogfood artifacts. Adds composition principle #7 codifying the byte-identical-SUITE.md invariant across siblings. No behavioral changes to the skill.

### Changed

- **SUITE.md**: new "Canonical dogfood target: Mirror Box" section with artifact links.
- **SUITE.md**: composition principles now include #7 (byte-identical SUITE.md across siblings).
- **SUITE.md**: version table bumped; all ten skills reflect the coordinated sync.

### Why a patch, not a minor

Same rationale as prior x.y.z patches: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.7 (2026-04-23)

Documentation-only patch. Reflects the arrival of `harden-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/harden-ready) as a live sibling in the ready-suite. harden-ready is the tenth and final core-suite skill; its v1.0.0 release completes the shipping tier alongside deploy-ready, observe-ready, and launch-ready, and completes the ready-suite across planning (four), building (two), and shipping (four) tiers. harden-ready owns post-deploy adversarial review, OWASP Top 10 walkthroughs (Web / API / LLM), compliance control-to-code mapping (SOC 2 / HIPAA / PCI-DSS / GDPR), pen-test preparation and retest discipline, responsible-disclosure program design beyond SECURITY.md, and class-not-instance post-incident hardening. No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `harden-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.7. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.6 (2026-04-23)

Documentation-only patch. Reflects the arrival of `roadmap-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/roadmap-ready) as a live sibling in the ready-suite. This release completes the nine-skill suite: `prd-ready` (what), `architecture-ready` (how), `roadmap-ready` (when), `stack-ready` (with what tools), `repo-ready` (the repo), `production-ready` (the app), `deploy-ready` (ship it), `observe-ready` (keep it healthy), `launch-ready` (tell the world). No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `roadmap-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.6. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.5 (2026-04-23)

Documentation-only patch. Reflects the arrival of `architecture-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/architecture-ready) as a live sibling in the ready-suite. architecture-ready is a new planning-tier sibling; deploy-ready now reads architecture-ready's deployment topology and system-shape signals upstream via production-ready. No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list architecture-ready at 1.0.0. Every sibling's recorded version is bumped one patch to track the release. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.5. No content change beyond the version tag.

## v1.0.4 (2026-04-23)

Documentation-only patch. Reflects the arrival of `prd-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/prd-ready) as a live sibling in the ready-suite. This release completes the top of the planning tier: prd-ready defines WHAT we are building, upstream of architecture-ready (HOW), roadmap-ready (WHEN), and stack-ready (WITH WHAT TOOLS). No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list prd-ready at 1.0.0 alongside production-ready 2.5.6, repo-ready 1.6.2, stack-ready 1.1.5, deploy-ready 1.0.4, observe-ready 1.0.3, and launch-ready 1.0.1. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.4. No content change beyond the version tag.

## v1.0.3 (2026-04-23)

Documentation-only patch. SUITE.md updated to reflect the v1.0.0 release of sibling skill `launch-ready`, the shipping-tier skill that owns "tell the world the product exists." This release completes the shipping tier. No behavioral changes to deploy-ready itself. The coupling with launch-ready: a launch should not ship on top of an in-progress expand/contract migration, so launch-ready reads `.deploy-ready/STATE.md` and blocks the launch-day drop on a non-green deploy state. deploy-ready's existing artifact contract (STATE.md, TOPOLOGY.md, healthchecks.md) is unchanged. See [launch-ready](https://github.com/aihxp/ready-suite/tree/main/skills/launch-ready) for the sibling.

## v1.0.2 (2026-04-23)

Documentation-only patch. Reflects the arrival of repo-ready v1.6.0 as a live sibling in the ready-suite with its suite-membership retrofit (frontmatter interop fields, SUITE.md, Unicode cleanup). No behavioral changes to the skill.

### Changed

- **SUITE.md known-good versions table** updated: repo-ready now shows version 1.6.0 and its repo URL instead of "See its CHANGELOG."
- **SKILL.md frontmatter version** bumped to 1.0.2. No content change beyond the version tag.

## v1.0.1 (2026-04-22)

Documentation-only patch. SUITE.md updated to reflect the v1.0.0 release of sibling skill `observe-ready`, the shipping-tier skill that owns "keep the app healthy once it is live." No behavioral changes to deploy-ready itself. The tight coupling between the two is unchanged: deploy-ready's paper-canary rule still refuses canaries without a metric from observe-ready, and observe-ready's "uniform rollouts defeat symptom-based alerts" rule refers back to deploy-ready's rollout-strategy discipline. See [observe-ready](https://github.com/aihxp/ready-suite/tree/main/skills/observe-ready) for the sibling.

## v1.0.0 (2026-04-22)

First stable release of deploy-ready, the shipping-tier skill that owns the pre-prod-to-prod handoff in the [ready-suite](SUITE.md). Ships with the full SKILL.md contract, ten reference files, a ~5000-word research report backing every guardrail, and full interop-standard frontmatter. Dogfooded against a realistic solo-dev Fly.io deploy before cut; the rough edges surfaced are reflected in the refinements below.

### The skill's three named failure modes

deploy-ready introduces three terms the ecosystem did not already have a clean name for. Each maps to a specific class of real-world incident (citations in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md)).

- **Paper canary.** A canary without a named success metric, a numeric threshold, a time or request window, and an automated rollback trigger. Appears green because nothing is looking. Refused by the skill; not called a canary.
- **Expand-only migration trap.** The state where the expand phase of an expand/contract migration shipped and the contract phase never did, leaving permanent dual-schema liability that compounds across future migrations. The deploy calendar and the in-progress-cycles block of `.deploy-ready/STATE.md` are the defense.
- **First-deploy blindness.** The class of failures that happens only on the first promotion to a new environment: missing env var, unset framework prefix, IAM role that does not exist, `.env` not read at build time, platform-specific gotchas. Distinct from "works on my machine" because it affects shipping, not development.

### What ships

- **SKILL.md** with the ready-suite interop standard: eleven frontmatter fields populated, six required sections present. Eleven-step workflow, four completion tiers (Pipelined, Promotable, Reversible, Hardened) totaling 20 requirements, a grep-testable have-nots list, a session state template, and explicit consume/produce contracts with sibling skills.
- **Ten reference files** under `references/`. Load-on-demand table annotates each with the step or tier that loads it.
  - `deploy-research.md`. Step 0 mode detection (A first deploy, B subsequent, C incident, D pipeline construction, E migration-dominated), destructive-command alert, expand-only migration trap detection procedure.
  - `preflight-and-gating.md`. 10 pre-flight questions expanded, Mode B subsequent-deploy checklist, the four gate types (build, test, security, approval) with pipeline-enforcement patterns across GitHub Actions, GitLab CI, Argo CD, Flux, Jenkins.
  - `deployment-topologies.md`. Seven topologies, per-topology first-deploy hazards and rollback characteristics, mixed-topology worked examples (Vercel + Neon, Fly.io, Cloud Run, Lambda + DynamoDB + CloudFront).
  - `pipeline-patterns.md`. The 8 pipeline gates with good and bad GitHub Actions YAML, same-artifact enforcement via content hashing and registry-tag promotion, the supply-chain pitfalls including `pull_request_target` fork-RCE.
  - `environment-parity.md`. The four parity gaps (time, personnel, tooling, fidelity), per-rung parity table, pre-prod parity gap as a named concept, quarterly drift audit.
  - `first-deploy-checklist.md`. Eleven cold-start gates, per-platform gotchas for Vercel, Netlify, Fly.io, Cloud Run, Lambda, Kubernetes; dry-run rollback procedure.
  - `zero-downtime-migrations.md`. Expand/migrate/cutover/contract calendar, 10-pattern guardrail catalog with unsafe and safe SQL per pattern, worked 3-deploy column rename across 2 weeks, expand-only migration trap deep dive.
  - `rollback-playbook.md`. Code-vs-data rollback asymmetry, compensating-forward patterns with worked examples, Knight Capital flag-lineage discipline, destructive-command gate grounded in the Replit 2025 and DataTalks.Club 2025 incidents, incident log template.
  - `progressive-delivery.md`. Five rollout strategies, paper-canary rule with four required fields, blast-radius rule citing CrowdStrike 2024, Cloudflare 2019, Facebook BGP 2021, readiness probe discipline, `preStop` graceful-shutdown pattern.
  - `secrets-injection.md`. Per-topology injection patterns, Docker layer leak class (Truffle Security, GitGuardian, Intrinsec citations), `pull_request_target` surface, build-time vs runtime split, artifact-level audit commands.
- **Research report** (`references/RESEARCH-2026-04.md`, ~5000 words). Named incidents: Knight Capital 2012, GitLab 2017, AWS S3 us-east-1 2017, Cloudflare WAF 2019, Facebook BGP 2021, CrowdStrike Channel File 291 2024, Replit 2025, DataTalks.Club 2025, timescale/pgai 2025, Docker Hub 10k-image secret-leak class. Tool gap analysis across GitHub Actions, GitLab CI, Argo CD, Flux, Argo Rollouts, LaunchDarkly, Vercel, Netlify, Fly.io. Zero-downtime migration literature survey. Naming-lane analysis. DORA 2024 (7.2% stability drop from AI-assisted delivery), Stack Overflow 2024-2025 (trust-gap framing), GitGuardian 2026 (2x AI-commit secret-leak rate) quantitative framing.
- **SUITE.md** at repo root listing deploy-ready at 1.0.0 alongside production-ready 2.5.2 and stack-ready 1.1.1 (sibling copies bumped as patches on this release).
- **README.md** with install paths for Claude Code, Codex, Cursor, Windsurf; the "what this skill prevents" incident-to-enforcement mapping across 12 incidents and findings; reference-library index; named-terms section.

### Refinements from the dogfood walk

A pre-release paper walk against a realistic solo-dev Fly.io deploy scenario (Node API with a `deleted_at` column add) surfaced four rough edges. All addressed in v1.0.0:

- **Same-artifact promotion scope clarified.** The invariant applies to *logical* environments (dev, staging, canary, prod). Platform-native region replication and per-region image rebuilds (Fly.io, Cloud Run, Vercel edge) are not drift if the source commit and build configuration are pinned; the artifact-path note records the pin.
- **Compact ladder profile named.** The skill does not force a staging rung where one does not exist. A dev-to-prod or dev-to-preview-to-prod ladder is declared as a "compact ladder" and the parity compensations are documented in Step 3. What is forced is that the parity gap is visible, not that a particular rung exists.
- **Solo-dev approval exception.** On single-maintainer projects, the approval gate is a distinct second action (signed tag push, deploy command invocation, deploy-marker commit merge) separate from the build step. A pipeline that auto-deploys on push to main with no distinct second action fails the gate even solo, because the whole point of the gate is that shipping is a choice.
- **Expand-only-by-design recognized.** Some changes are legitimately expand-only (permanent nullable columns, never-removed enum values, coexisting-forever tables). The calendar records "expand: v1.x. contract: none, by design. reason: <one line>." An absent contract phase is a trap only when deferred and forgotten, not when designed out.
- **Blast-radius exemption for all-at-once prod.** All-at-once is acceptable for low-traffic prod services with a named blast-radius justification (user count under threshold, internal-only audience, solo-maintained). Broad user-facing changes still require a non-uniform strategy; the difference is the plan now has to name which context applies.

### Compatibility

- Claude Code (primary)
- Codex
- Cursor
- Windsurf (manual SKILL.md upload)
- Any agent with skill loading

### Suite siblings at release

- production-ready 2.5.2 (patch bumped for SUITE.md table update)
- stack-ready 1.1.1 (patch bumped for SUITE.md table update)
- repo-ready (live, see its own CHANGELOG)

Planned siblings (not yet released): prd-ready, architecture-ready, roadmap-ready, observe-ready, launch-ready.

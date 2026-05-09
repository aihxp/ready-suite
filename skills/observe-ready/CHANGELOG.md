# Changelog

## v1.0.19 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.7.0 release that adds Mode D (Multi-repo suite) to repo-ready workflow. This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.18 (2026-05-09)

Documentation patch. Adds `references/observe-antipatterns.md`, the named-failure-mode catalog this skill refuses, with grep tests, severity ladder, and per-skill guards. Closes one of the seven gaps named in MAINTAINING.md \"known-but-not-fixed inconsistencies\" (six skills lacked dedicated antipatterns files; this patch addresses the seventh in the same coordinated sweep).\n\n### Added\n\n- **`references/observe-antipatterns.md`** (~150 lines): named patterns extracted from the skill SKILL.md \"have-nots\" section, formatted with shape (concrete example), grep test (mechanical detection), severity (Critical / High / Medium / Low), guard (where the workflow catches it). Loaded on demand at every tier-gate check and during Mode C audits.\n- **Reference table row**: SKILL.md gains the new entry.\n\n### Changed\n\n- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.\n\n### Why a patch, not a minor\n\nAdditive reference content; SKILL.md body and frontmatter contract unchanged.\n\n---\n\n

## v1.0.17 (2026-05-09)

Documentation-only patch. Recovery sync after the just-retired v2.5.12 precedent. The repo-ready v1.6.15 release (which itself triggered the precedent retirement in MAINTAINING.md) shipped with the OLD SUITE.md committed; the catch-up sync to the other 10 siblings happened afterward in a separate hub commit, but the lint workflow correctly flagged the resulting drift. This patch lands the byte-identical SUITE.md across all 12 repos with the full version table current to all 11 specialists.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to the post-retirement state across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking; mechanical recovery from the lint-caught drift.

---


## v1.0.16 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.6.15 audit-refresh release. The v2.5.12 precedent (single-specialist patches do not trigger full SUITE.md sync) is retired effective this patch: the hub `scripts/lint.sh` `suite-md-sync` check enforces byte-identical `SUITE.md` across all 12 repos, so every specialist version bump (including audit-report refreshes that bump only one specialist) now triggers a full coordinated sync.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to repo-ready 1.6.15 across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.15 (2026-05-09)

Hygiene cleanup. Removes `.claude/settings.local.json` (a personal local-override file accidentally committed; the `.local` suffix is the convention for "do not commit"). Updates `.gitignore` to prevent future accidental commits. SUITE.md sync.

### Removed

- **`.claude/settings.local.json`**: deleted. The file contained personal-machine-specific permission grants (hardcoded local paths in some cases) that were never intended to be committed. Project-level `.claude/settings.json` (without `.local`) is the canonical committed form when a repo needs project-level Claude Code settings; this skill does not have one and does not need one at v1.

### Changed

- **`.gitignore`**: added `.claude/settings.local.json` and `.planning/` patterns.
- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

File cleanup + gitignore tweak; no behavior change.

---


## v1.0.14 (2026-05-09)

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


## v1.0.13 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the four planning-tier skill releases (prd-ready v1.0.10, architecture-ready v1.0.9, roadmap-ready v1.0.8, stack-ready v1.1.15) which add worked-example reference files for a single fictional B2B SaaS product (Pulse, a Customer Success ops platform). The four examples cross-reference each other to demonstrate the suite's compose-by-artifact principle: each downstream artifact reads from the prior one and refines, never duplicates. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.12 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v2.6.0 release of [production-ready](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready), which adds first-class consumption of the [Google Labs `DESIGN.md`](https://github.com/google-labs-code/design.md) format as the canonical design-system token source for dashboards. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `DESIGN.md` format and the consumption flow (production-ready Step 3 sub-step 3a). Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.11 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v1.1.0 release of [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) and the v1.6.10 release of [repo-ready](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready), both of which add first-class support for the [`AGENTS.md`](https://agents.md/) cross-tool agent-brief standard (Linux Foundation Agentic AI Foundation). kickoff-ready now emits a project-root `AGENTS.md` mapping the suite's artifact paths when none exists; repo-ready scaffolds `AGENTS.md` as the canonical agent brief with `CLAUDE.md` as a thin overlay or symlink. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `AGENTS.md` standard, the harnesses that read it, and the two specialists (kickoff-ready, repo-ready) that meet that surface. Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.10 (2026-05-06)

Documentation-only patch. Adds first-class support for [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) and [OpenClaw](https://github.com/openclaw/openclaw) via the [Agent Skills standard](https://agentskills.io). The suite now positions explicitly as agentskills.io-compatible: any harness that parses `SKILL.md` frontmatter natively runs every ready-suite skill first-class, with no per-tool integration. pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support for free.

### Changed

- **Frontmatter**: `compatible_with` now lists `pi`, `openclaw`, and `any-agentskills-compatible-harness` (the latter replaces the older `any-agent-with-skill-loading` value for tighter standards-level signaling).
- **SUITE.md**: install-locations table adds rows for pi, OpenClaw, and the neutral Agent Skills path; new "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).
- **Hub install.sh / uninstall.sh** (in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)): detect pi (`~/.pi/`) and OpenClaw (`~/.openclaw/`), write to the neutral `~/.agents/skills/` path. No regressions on the existing Claude Code / Codex / Cursor flow.

### Why a patch, not a minor

The skill's behavior, references, and workflow are unchanged. Only the frontmatter `compatible_with` list, `SUITE.md`, and the README install section move; the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only standards-compliance signaling.

---


## v1.0.9 (2026-05-06)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the new **orchestration** tier and the eleventh sibling, [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) v1.0.0. kickoff-ready sequences the ten core-suite specialists for greenfield projects from raw user intent: it triggers from a fresh idea ("kickoff," "I have an idea help me ship it") and invokes prd-ready -> architecture-ready -> roadmap-ready -> stack-ready -> repo-ready -> production-ready -> deploy-ready -> observe-ready -> (launch-ready || harden-ready), verifying each artifact on disk before advancing. It produces only `.kickoff-ready/PROGRESS.md`; it never produces specialist content. No behavioral changes to this skill.

### Changed

- **SUITE.md**: new "orchestration" tier introduced as the first column of the four-tier diagram; new kickoff-ready row in the per-skill table; updated dependency-flow text; new composition principle 8 ("Orchestration is one-way: kickoff-ready knows about specialists; specialists do not know about kickoff-ready"); known-good versions table now lists eleven skills.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.8 (2026-04-24)

Documentation-only patch. Removes the Mirror Box dogfood track from the ready-suite. The aihxp/mirror-box repo has been archived; the canonical-dogfood section in SUITE.md is gone; per-skill dogfood/ folders are deleted.

### Changed

- **SUITE.md** no longer carries the "Canonical dogfood target: Mirror Box" section. Byte-identical sync across all ten siblings.
- **dogfood/** folder removed from this repo.

### Why

The Mirror Box reference implementation required real infrastructure (Fastify + OTel + Fly.io + Honeycomb account) to fully exercise. The user wanted a skill suite, not a project that demands a particular hosted stack. Removing Mirror Box restores that posture: every skill stands on its own SKILL.md plus references; downstream consumers compose via the artifact contracts the skills describe, without depending on a shared hosted exemplar.

The interop standard is unchanged. Skills still produce `.{skill}-ready/*.md` artifacts; downstream siblings still read them. The contract holds without a canonical demo.

---


## v1.0.7 (2026-04-24)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the canonical dogfood target: [aihxp/mirror-box](https://github.com/aihxp/mirror-box). Adds a new "Canonical dogfood target" section to SUITE.md with links to the ten per-skill dogfood artifacts. Adds composition principle #7 codifying the byte-identical-SUITE.md invariant across siblings. No behavioral changes to the skill.

### Changed

- **SUITE.md**: new "Canonical dogfood target: Mirror Box" section with artifact links.
- **SUITE.md**: composition principles now include #7 (byte-identical SUITE.md across siblings).
- **SUITE.md**: version table bumped; all ten skills reflect the coordinated sync.

### Why a patch, not a minor

Same rationale as prior x.y.z patches: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.6 (2026-04-23)

Documentation-only patch. Reflects the arrival of `harden-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/harden-ready) as a live sibling in the ready-suite. harden-ready is the tenth and final core-suite skill; its v1.0.0 release completes the shipping tier alongside deploy-ready, observe-ready, and launch-ready, and completes the ready-suite across planning (four), building (two), and shipping (four) tiers. harden-ready owns post-deploy adversarial review, OWASP Top 10 walkthroughs (Web / API / LLM), compliance control-to-code mapping (SOC 2 / HIPAA / PCI-DSS / GDPR), pen-test preparation and retest discipline, responsible-disclosure program design beyond SECURITY.md, and class-not-instance post-incident hardening. No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `harden-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.6. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.5 (2026-04-23)

Documentation-only patch. Reflects the arrival of `roadmap-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/roadmap-ready) as a live sibling in the ready-suite. This release completes the nine-skill suite: `prd-ready` (what), `architecture-ready` (how), `roadmap-ready` (when), `stack-ready` (with what tools), `repo-ready` (the repo), `production-ready` (the app), `deploy-ready` (ship it), `observe-ready` (keep it healthy), `launch-ready` (tell the world). No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `roadmap-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.5. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.4 (2026-04-23)

Documentation-only patch. Reflects the arrival of `architecture-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/architecture-ready) as a live sibling in the ready-suite. architecture-ready is a new planning-tier sibling; observe-ready reads architecture-ready's trust boundaries, component dependency graph, and NFR targets for SLO wiring. No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list architecture-ready at 1.0.0. Every sibling's recorded version is bumped one patch to track the release. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.4. No content change beyond the version tag.

## v1.0.3 (2026-04-23)

Documentation-only patch. Reflects the arrival of `prd-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/prd-ready) as a live sibling in the ready-suite. This release completes the top of the planning tier: prd-ready defines WHAT we are building, upstream of architecture-ready (HOW), roadmap-ready (WHEN), and stack-ready (WITH WHAT TOOLS). No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list prd-ready at 1.0.0 alongside production-ready 2.5.6, repo-ready 1.6.2, stack-ready 1.1.5, deploy-ready 1.0.4, observe-ready 1.0.3, and launch-ready 1.0.1. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.3. No content change beyond the version tag.

## v1.0.2 (2026-04-23)

Documentation-only patch. SUITE.md updated to reflect the v1.0.0 release of sibling skill `launch-ready`, the shipping-tier skill that owns "tell the world the product exists." The shipping tier is now complete. No behavioral changes to observe-ready itself. The coupling with launch-ready: a launch generates a traffic spike; launch-ready reads `.observe-ready/SLOs.md` to surface any at-risk SLO in the launch runbook, and reads `.observe-ready/INDEPENDENCE.md` to know whether the status page is already out-of-band. observe-ready's existing artifact contract is unchanged. See [launch-ready](https://github.com/aihxp/ready-suite/tree/main/skills/launch-ready) for the sibling.

## v1.0.1 (2026-04-23)

Documentation-only patch. Reflects the arrival of repo-ready v1.6.0 as a live sibling in the ready-suite with its suite-membership retrofit (frontmatter interop fields, SUITE.md, Unicode cleanup). No behavioral changes to the skill.

### Changed

- **SUITE.md known-good versions table** updated: repo-ready now shows version 1.6.0 and its repo URL instead of "See its CHANGELOG."
- **SKILL.md frontmatter version** bumped to 1.0.1. No content change beyond the version tag.

## v1.0.0 (2026-04-22)

First stable release of observe-ready, the shipping-tier skill that owns "keep the app healthy once it is live" in the [ready-suite](SUITE.md). Ships with the full SKILL.md contract, eleven reference files, a ~7,500-word research report backing every guardrail, and full interop-standard frontmatter. Walked against a realistic solo-dev Fly.io scenario (Node API with login and signup journeys) before cut; rough edges surfaced during the walk are addressed below.

### The skill's three named failure modes

observe-ready introduces three terms the ecosystem did not already have a clean name for. Each maps to a specific class of real-world incident (citations in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md)).

- **Paper SLO.** An SLO with no error-budget policy, no alert wired to it, no review cadence, and no stakeholder who knows its number. The cousin of deploy-ready's "paper canary" across shipping-tier siblings: both name the "artifact present, mechanism absent" pattern that dominates AI-generated systems-engineering output. Refused by the skill.
- **Blind dashboard.** A dashboard above the fold with metrics that have no SLO behind them and nobody watched during the last incident. Distinct from generic "dashboard sprawl" because it names the artifact's binding, not its count.
- **Paper runbook.** A runbook written once, attached to an alert, and never executed. Commands reference renamed log fields; URLs 404. Distinct from "runbook drift" because the term names the artifact, not the process.

Related corollary: **unreachable runbook** (hosted on the infrastructure it documents). Facebook 2021 and Roblox 2021 are the citations.

### What ships

- **SKILL.md** with the ready-suite interop standard: eleven frontmatter fields populated, six required sections present. Twelve-step workflow (Step 0 to Step 11), four completion tiers (Instrumented, Promised, Traceable, Rehearsed) totaling 20 requirements, a grep-testable have-nots list, a session state template, explicit consume/produce contracts with sibling skills.
- **Eleven reference files** under `references/`. Load-on-demand table annotates each with the step or tier that loads it.
  - `observe-research.md`. Step 0 mode detection (A greenfield, B instrumented-but-unbound, C mature-with-sprawl, D incident-reactive, E cost-driven), paper-SLO detection procedure, observability-surface reachability question.
  - `logging-patterns.md`. Structured JSON format, required fields (timestamp, level, service, env, trace_id, span_id, event), level discipline, correlation ID propagation across HTTP/gRPC/async/cron, PII scrubbing at the OTel Collector with working attribute-processor config, sampling, aligned retention.
  - `metrics-taxonomy.md`. RED / USE / golden signals; per-topology catalogs for request/response, worker, batch, edge, data pipeline, database, cache, broker; cardinality discipline with per-backend pricing-model awareness; deadman-switch patterns.
  - `slo-design.md`. One SLI per journey rule, target selection against dependency ceiling, window choice, error-budget math, error-budget policy template with trigger/action/stakeholder/exit/escalation, multi-burn-rate math, low-traffic strategies (extended windows, synthetic, aggregation, uptime-based), SLO composition across dependency chains, quarterly review cadence.
  - `alert-patterns.md`. Three-tier severity ladder (PAGE / TICKET / LOG-ONLY), symptom-based pages vs. cause-based diagnostics, four-tier multi-burn-rate matrix with PromQL examples, runbook-URL-in-payload contract, alert-routing independence, deadman switches, correlation and suppression, quarterly pruning, the incident.io 2025 false-positive baseline citations.
  - `dashboards.md`. Above-the-fold rule (seven or fewer), four canonical charts (error budget, burn rate, SLI trend, top diagnostic), chart semantics (p99 not avg, rate as events/sec, error rate as ratio, deploy annotations), per-service-type catalog, sprawl budget of three dashboards per service, ownership metadata, independence check.
  - `tracing.md`. OpenTelemetry at graduated CNCF status (2024-2025), W3C Trace Context and tracestate and Baggage, propagation traps (async queues, long-lived gRPC streams, serverless cold starts, fan-out), head vs. tail sampling with buffer math, retention alignment to SLO window, span hygiene (low-cardinality names, semantic-conventions attributes, no PII), span-to-metric pipeline.
  - `error-tracking.md`. Sentry / Rollbar / Bugsnag / Honeycomb differences, release tagging via the deploy pipeline, grouping tuning on top-20 signatures, metrics-vs-errors complementary roles, PII scrubbing, frontend-specific notes (source-map upload, session replay, browser-console noise), regression detection, error-tracker independence.
  - `incident-response.md`. Runbook template with alert context, diagnose (with executable commands), act (decision tree), communicate (cadences), escalation, post-incident; runbook execution cadence (quarterly tabletop or real incident); out-of-band hosting; three-tier severity ladder (SEV-1, SEV-2, SEV-3); incident commander role; war-room protocol; status-page discipline; customer communication templates; on-call ergonomics.
  - `post-mortem.md`. Blameless format, causal analysis beyond Five Whys (contributing-factors tree, Swiss cheese model, learning-from-incidents), action-item tracking with owner/due/verification, the observability-gap action-item loop, alert pruning tied to post-mortem, public post-mortem discipline with examples, the "no incidents this quarter" note.
  - `vendor-landscape.md`. Datadog / Grafana Cloud / Honeycomb / New Relic / Splunk / Dynatrace / open-source OTel / Sentry / PagerDuty / incident.io / FireHydrant / Rootly / Blameless / Better Stack / Checkly / Cribl / Chronosphere / SigNoz / ServiceNow Cloud Observability / Groundcover. Pricing traps (Datadog custom-metric cardinality, New Relic CCU opacity), SLO support gaps, retention alignment, independence considerations per vendor, portability via OpenTelemetry.
- **Research report** (`references/RESEARCH-2026-04.md`, ~7,500 words). Named incidents: Slack 2021, Roblox 2021, Facebook 2021, AWS us-east-1 2021, Cloudflare 2019 and 2022, Datadog 2023, GitHub 2018, CrowdStrike 2024, AWS DynamoDB 2025, Checkly 2024. Tool landscape across Datadog, Grafana Cloud, Honeycomb, New Relic, Splunk, Dynatrace, Chronosphere, Cribl, Prometheus/Jaeger/OTel Collector, Sentry/Rollbar/Bugsnag, PagerDuty/incident.io/FireHydrant/Rootly/Blameless, Better Stack/Checkly, Lightstep/Groundcover, ClickHouse-based stacks. OpenTelemetry adoption state including 2025 stability notes, semantic-conventions status, propagation pitfalls, sampling tradeoffs with collector buffer math. Alert-fatigue literature from Rob Ewaschuk, the SRE workbook multi-burn-rate chapter, Charity Majors and Liz Fong-Jones on actionable alerts, incident.io and Runframe 2025-2026 data. Honeycomb Observability-2.0 framing, three-pillars debate, cardinality economics. SLO design canon (Hidalgo, Nobl9, SRE book and workbook), error-budget policy template. Naming-lane analysis concluding on paper SLO / blind dashboard / paper runbook / unreachable runbook with search-evidence. Frequency data: 85% false-positive alerts, 67% alert ignoring, 73% outage correlation, 70% log-spend never queried, DORA 2024 7.2% stability drop for AI-assisted delivery.
- **SUITE.md** at repo root listing observe-ready at 1.0.0 alongside production-ready 2.5.3, stack-ready 1.1.2, and deploy-ready 1.0.1 (sibling copies bumped as patches on this release).
- **README.md** with install paths for Claude Code, Codex, Cursor, Windsurf; the "what this skill prevents" incident-to-enforcement mapping across 14 incidents and findings; reference-library index; named-terms section.

### Refinements from the dogfood walk

A pre-release paper walk against a realistic solo-dev Fly.io scenario (Node API with login and signup journeys, 1K-5K daily actives) surfaced the following, addressed in v1.0.0:

- **Low-traffic SLO strategy documented inline.** Services with too few events for burn-rate math are common (most early apps). `slo-design.md` section 8 covers extended windows, synthetic traffic, service aggregation, and uptime-based SLI as named alternatives rather than forcing a request-ratio SLI onto a service that cannot support it.
- **Mode E (cost-driven) recognized as distinct and often co-occurring.** Teams in Mode C (sprawl) often arrive because they are also in Mode E (bill shock). The mode matrix in `observe-research.md` acknowledges the overlap; Step 3 cardinality and Step 7 sampling get mode-specific emphasis under Mode E.
- **Paper-SLO watchlist surfaces in STATE.md.** Agents mid-configuration often need to write a partial SLO (the policy is not yet agreed). Rather than block, the skill writes the SLO with `POLICY: TBD` and records it in the paper-SLO watchlist in STATE.md, so the gap is visible and prioritized.
- **Runbook-last-executed cadence split into soft (90 days) and hard (180 days) floors.** A quarterly tabletop cadence is the target; 180 days is the point past which the runbook is treated as paper regardless of justification.
- **Three-tier severity ladder instead of five.** PagerDuty and incident.io default UIs offer P1/P2/P3/P4/P5. Three tiers (PAGE / TICKET / LOG-ONLY for alerts; SEV-1 / SEV-2 / SEV-3 for incidents) force behavioral clarity and reduce ambiguity under stress.
- **Rollout-and-observability coupling as a first-class rule.** The deploy-ready paper-canary rule and the observe-ready "uniform rollouts defeat symptom-based alerts" rule are the same coupling from two sides. Surfaced explicitly in the SKILL.md synthesis and in `alert-patterns.md` section 9 correlation discipline.

### Compatibility

- Claude Code (primary)
- Codex
- Cursor
- Windsurf (manual SKILL.md upload)
- Any agent with skill loading

### Suite siblings at release

- production-ready 2.5.3 (patch bumped for SUITE.md table update)
- stack-ready 1.1.2 (patch bumped for SUITE.md table update)
- deploy-ready 1.0.1 (patch bumped for SUITE.md table update)
- repo-ready (live, see its own CHANGELOG)

Planned siblings (not yet released): prd-ready, architecture-ready, roadmap-ready, launch-ready.

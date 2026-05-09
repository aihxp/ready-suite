# Changelog

## v2.6.8 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.7.0 release that adds Mode D (Multi-repo suite) to repo-ready workflow. This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v2.6.7 (2026-05-09)

Documentation patch. Adds `references/production-antipatterns.md`, the named-failure-mode catalog this skill refuses, with grep tests, severity ladder, and per-skill guards. Closes one of the seven gaps named in MAINTAINING.md \"known-but-not-fixed inconsistencies\" (six skills lacked dedicated antipatterns files; this patch addresses the seventh in the same coordinated sweep).\n\n### Added\n\n- **`references/production-antipatterns.md`** (~150 lines): named patterns extracted from the skill SKILL.md \"have-nots\" section, formatted with shape (concrete example), grep test (mechanical detection), severity (Critical / High / Medium / Low), guard (where the workflow catches it). Loaded on demand at every tier-gate check and during Mode C audits.\n- **Reference table row**: SKILL.md gains the new entry.\n\n### Changed\n\n- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.\n\n### Why a patch, not a minor\n\nAdditive reference content; SKILL.md body and frontmatter contract unchanged.\n\n---\n\n

## v2.6.6 (2026-05-09)

Documentation-only patch. Recovery sync after the just-retired v2.5.12 precedent. The repo-ready v1.6.15 release (which itself triggered the precedent retirement in MAINTAINING.md) shipped with the OLD SUITE.md committed; the catch-up sync to the other 10 siblings happened afterward in a separate hub commit, but the lint workflow correctly flagged the resulting drift. This patch lands the byte-identical SUITE.md across all 12 repos with the full version table current to all 11 specialists.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to the post-retirement state across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking; mechanical recovery from the lint-caught drift.

---


## v2.6.5 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.6.15 audit-refresh release. The v2.5.12 precedent (single-specialist patches do not trigger full SUITE.md sync) is retired effective this patch: the hub `scripts/lint.sh` `suite-md-sync` check enforces byte-identical `SUITE.md` across all 12 repos, so every specialist version bump (including audit-report refreshes that bump only one specialist) now triggers a full coordinated sync.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to repo-ready 1.6.15 across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v2.6.4 (2026-05-09)

Hygiene cleanup. Updates `.gitignore` to prevent accidental commits of `.claude/settings.local.json` (Claude Code personal local-override files; the `.local` suffix is the convention for "do not commit") and `.planning/` (GSD development artifacts). SUITE.md sync.

### Changed

- **`.gitignore`**: added `.claude/settings.local.json` and `.planning/` patterns.
- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Gitignore additions + SUITE.md sync; no behavior change.

---


## v2.6.3 (2026-05-09)

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


## v2.6.2 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the four planning-tier skill releases (prd-ready v1.0.10, architecture-ready v1.0.9, roadmap-ready v1.0.8, stack-ready v1.1.15) which add worked-example reference files for a single fictional B2B SaaS product (Pulse, a Customer Success ops platform). The four examples cross-reference each other to demonstrate the suite's compose-by-artifact principle: each downstream artifact reads from the prior one and refines, never duplicates. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v2.6.1 (2026-05-09)

Documentation-only patch. Adds a "Pattern: Spec Kit as orchestrator" section to `ORCHESTRATORS.md` covering the interop story between [Spec Kit](https://github.com/github/spec-kit) (GitHub's spec-driven development framework) and the ready-suite. Spec Kit owns governance via `constitution.md` and feature-grained `spec/plan/tasks` triples; ready-suite owns project-grained planning, building, and shipping. The two layer cleanly via the artifact-as-contract principle: ready-suite's project-wide `PRD.md` and `ARCH.md` inform Spec Kit's per-feature `spec.md` and `plan.md`; ROADMAP slice queues compose with Spec Kit's per-feature `tasks.md`.

### Added

- **`ORCHESTRATORS.md` Pattern: Spec Kit**: documents the grain difference (project-wide vs per-feature), the `constitution.md` slot the suite leaves empty (Spec Kit fills it), and two integration shapes (Shape A: both running; Shape B: pick one). Notes the kickoff-ready import-detection routing for projects that arrive with `.specify/` already on disk.
- **`constitution.md` consumption note**: every ready-suite skill reads project-root context including `constitution.md` when present, treating its content as standing have-nots. The interaction is pull-only; ready-suite never writes to `constitution.md`.

### Why a patch, not a minor

The skill's SKILL.md, references library, and frontmatter contract are unchanged; only `ORCHESTRATORS.md` (the cross-cutting composition doc) is touched. Per the v2.5.12 precedent (which introduced `ORCHESTRATORS.md` itself as a patch), updates to `ORCHESTRATORS.md` are patch-level on this repo and do not trigger a suite-wide SUITE.md sync.

---


## v2.6.0 (2026-05-09)

Minor release. production-ready now consumes a project-root [`DESIGN.md`](https://github.com/google-labs-code/design.md) (Google Labs format, Apache 2.0) as the canonical token source when one exists. Step 3 splits into sub-step 3a (detect and consume DESIGN.md) and sub-step 3b (derive from scratch when absent). The linter (`npx @google/design.md lint`) runs before component code so WCAG and token-resolution failures block the slice deterministically. New reference file `references/design-md-integration.md` documents the three consumption paths (DTCG export, Tailwind v4 export, direct YAML read), the seven linter rules, the Agent Prompt Guide consumption rules, and the scaffold-when-absent guidance.

### Added

- **SKILL.md Step 3 sub-step 3a**: detect `DESIGN.md` at project root, consume via DTCG / Tailwind v4 / direct YAML, lint before any component code, read the Agent Prompt Guide section as load-bearing have-nots.
- **SKILL.md Step 3 sub-step 3b**: the existing archetype + 5-decision derivation kept as the fallback path, with a recommended scaffold-`DESIGN.md`-from-tokens move before Step 4.
- **`references/design-md-integration.md`**: the integration recipe (detection rules, three consumption paths in priority order, the linter's seven rules, the Agent Prompt Guide consumption rules, practical caveats on model token discipline, scaffold-when-absent paths via `npx @google/design.md init`, [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md), or [Stitch](https://stitch.google.com)).
- **Reference table**: new row for `design-md-integration.md` (Tier 1, Step 3 sub-step 3a). The `ui-design-patterns.md` row reframed as Tier 1 sub-step 3b (the scaffold-from-scratch path).

### Changed

- **`references/ui-design-patterns.md`** preamble: precedence note added stating that `DESIGN.md` (when present) is the canonical token source and supersedes the archetype + 5-decision derivation in this file.
- **SUITE.md** Standards section: adds a `DESIGN.md` compatibility paragraph naming the format and the consumption flow.

### Why a minor, not a patch

Step 3 gains a new sub-step with a behavior gate (consume `DESIGN.md` when present, skip the archetype derivation). This is observable to users (the architecture note now records the chosen consumption path; the slice may not start without a clean linter run). Minor is the honest bucket.

---


## v2.5.15 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v1.1.0 release of [kickoff-ready](https://github.com/aihxp/kickoff-ready) and the v1.6.10 release of [repo-ready](https://github.com/aihxp/repo-ready), both of which add first-class support for the [`AGENTS.md`](https://agents.md/) cross-tool agent-brief standard (Linux Foundation Agentic AI Foundation). kickoff-ready now emits a project-root `AGENTS.md` mapping the suite's artifact paths when none exists; repo-ready scaffolds `AGENTS.md` as the canonical agent brief with `CLAUDE.md` as a thin overlay or symlink. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `AGENTS.md` standard, the harnesses that read it, and the two specialists (kickoff-ready, repo-ready) that meet that surface. Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v2.5.14 (2026-05-06)

Documentation-only patch. Adds first-class support for [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) and [OpenClaw](https://github.com/openclaw/openclaw) via the [Agent Skills standard](https://agentskills.io). The suite now positions explicitly as agentskills.io-compatible: any harness that parses `SKILL.md` frontmatter natively runs every ready-suite skill first-class, with no per-tool integration. pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support for free.

### Changed

- **Frontmatter**: `compatible_with` now lists `pi`, `openclaw`, and `any-agentskills-compatible-harness` (the latter replaces the older `any-agent-with-skill-loading` value for tighter standards-level signaling).
- **SUITE.md**: install-locations table adds rows for pi, OpenClaw, and the neutral Agent Skills path; new "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).
- **Hub install.sh / uninstall.sh** (in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)): detect pi (`~/.pi/`) and OpenClaw (`~/.openclaw/`), write to the neutral `~/.agents/skills/` path. No regressions on the existing Claude Code / Codex / Cursor flow.

### Why a patch, not a minor

The skill's behavior, references, and workflow are unchanged. Only the frontmatter `compatible_with` list, `SUITE.md`, and the README install section move; the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only standards-compliance signaling.

---


## v2.5.13 (2026-05-06)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the new **orchestration** tier and the eleventh sibling, [kickoff-ready](https://github.com/aihxp/kickoff-ready) v1.0.0. kickoff-ready sequences the ten core-suite specialists for greenfield projects from raw user intent: it triggers from a fresh idea ("kickoff," "I have an idea help me ship it") and invokes prd-ready -> architecture-ready -> roadmap-ready -> stack-ready -> repo-ready -> production-ready -> deploy-ready -> observe-ready -> (launch-ready || harden-ready), verifying each artifact on disk before advancing. It produces only `.kickoff-ready/PROGRESS.md`; it never produces specialist content. No behavioral changes to this skill.

### Changed

- **SUITE.md**: new "orchestration" tier introduced as the first column of the four-tier diagram; new kickoff-ready row in the per-skill table; updated dependency-flow text; new composition principle 8 ("Orchestration is one-way: kickoff-ready knows about specialists; specialists do not know about kickoff-ready"); known-good versions table now lists eleven skills.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking. ORCHESTRATORS.md (introduced in v2.5.12) is unchanged; kickoff-ready inherits its principles and refines them at the meta-tier.

---


## v2.5.12 (2026-04-24)

Documentation-only patch. Adds `ORCHESTRATORS.md` at the repo root, documenting how ready-suite composes with GSD, BMAD, Superpowers, and plain Claude Code / Codex / Cursor / Windsurf harnesses. The composition principles section in SUITE.md already named the orchestrator-agnostic stance; ORCHESTRATORS.md makes the integration patterns concrete.

### Added

- `ORCHESTRATORS.md`: composition-with-orchestrators reference. Covers GSD (with a phase-by-phase command-to-skill mapping table), BMAD (two integration shapes), Superpowers (orthogonal layer, zero integration), and plain harnesses (the default). States what ready-suite refuses to do and what it welcomes.

### Why

The interop standard from v2.5.0 declared "the harness is the router" but did not document what specific orchestrators look like in practice. This file closes that gap without coupling ready-suite to any particular orchestrator. The integration cost stays one-directional: orchestrators can document how they invoke ready-suite skills, ready-suite stays unchanged.

This is a production-ready-only patch; SUITE.md is unchanged, no sibling sync needed.

---


## v2.5.11 (2026-04-24)

Documentation-only patch. Removes the Mirror Box dogfood track from the ready-suite. The aihxp/mirror-box repo has been archived; the canonical-dogfood section in SUITE.md is gone; per-skill dogfood/ folders are deleted.

### Changed

- **SUITE.md** no longer carries the "Canonical dogfood target: Mirror Box" section. Byte-identical sync across all ten siblings.
- **dogfood/** folder removed from this repo.

### Why

The Mirror Box reference implementation required real infrastructure (Fastify + OTel + Fly.io + Honeycomb account) to fully exercise. The user wanted a skill suite, not a project that demands a particular hosted stack. Removing Mirror Box restores that posture: every skill stands on its own SKILL.md plus references; downstream consumers compose via the artifact contracts the skills describe, without depending on a shared hosted exemplar.

The interop standard is unchanged. Skills still produce `.{skill}-ready/*.md` artifacts; downstream siblings still read them. The contract holds without a canonical demo.

---


## v2.5.10 (2026-04-24)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the canonical dogfood target: [aihxp/mirror-box](https://github.com/aihxp/mirror-box). Adds a new "Canonical dogfood target" section to SUITE.md with links to the ten per-skill dogfood artifacts. Adds composition principle #7 codifying the byte-identical-SUITE.md invariant across siblings. No behavioral changes to the skill.

### Changed

- **SUITE.md**: new "Canonical dogfood target: Mirror Box" section with artifact links.
- **SUITE.md**: composition principles now include #7 (byte-identical SUITE.md across siblings).
- **SUITE.md**: version table bumped; all ten skills reflect the coordinated sync.

### Why a patch, not a minor

Same rationale as prior x.y.z patches: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v2.5.9 (2026-04-23)

Documentation-only patch. Reflects the arrival of `harden-ready` v1.0.0 (https://github.com/aihxp/harden-ready) as a live sibling in the ready-suite. harden-ready is the tenth and final core-suite skill; its v1.0.0 release completes the shipping tier alongside deploy-ready, observe-ready, and launch-ready, and completes the ready-suite across planning (four), building (two), and shipping (four) tiers. harden-ready owns post-deploy adversarial review, OWASP Top 10 walkthroughs (Web / API / LLM), compliance control-to-code mapping (SOC 2 / HIPAA / PCI-DSS / GDPR), pen-test preparation and retest discipline, responsible-disclosure program design beyond SECURITY.md, and class-not-instance post-incident hardening. No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `harden-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 2.5.9. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v2.5.8 (2026-04-23)

Documentation-only patch. Reflects the arrival of `roadmap-ready` v1.0.0 (https://github.com/aihxp/roadmap-ready) as a live sibling in the ready-suite. This release completes the nine-skill suite: `prd-ready` (what), `architecture-ready` (how), `roadmap-ready` (when), `stack-ready` (with what tools), `repo-ready` (the repo), `production-ready` (the app), `deploy-ready` (ship it), `observe-ready` (keep it healthy), `launch-ready` (tell the world). No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `roadmap-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 2.5.8. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v2.5.7 (2026-04-23)

Documentation-only patch. Reflects the arrival of `architecture-ready` v1.0.0 (https://github.com/aihxp/architecture-ready) as a live sibling in the ready-suite. architecture-ready is a new upstream planning-tier sibling; production-ready's Step 2 architecture note and threat model now pre-fill from `.architecture-ready/HANDOFF.md`. No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list architecture-ready at 1.0.0. Every sibling's recorded version is bumped one patch to track the release. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 2.5.7. No content change beyond the version tag.

## v2.5.6 (2026-04-23)

Documentation-only patch. Reflects the arrival of `prd-ready` v1.0.0 (https://github.com/aihxp/prd-ready) as a live sibling in the ready-suite. This release completes the top of the planning tier: prd-ready defines WHAT we are building, upstream of architecture-ready (HOW), roadmap-ready (WHEN), and stack-ready (WITH WHAT TOOLS). No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list prd-ready at 1.0.0 alongside production-ready 2.5.6, repo-ready 1.6.2, stack-ready 1.1.5, deploy-ready 1.0.4, observe-ready 1.0.3, and launch-ready 1.0.1. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 2.5.6. No content change beyond the version tag.

## v2.5.5 (2026-04-23)

Documentation-only patch. Reflects the arrival of launch-ready v1.0.0 (https://github.com/aihxp/launch-ready) as a live sibling in the ready-suite. This release completes the shipping tier: deploy-ready ships it, observe-ready keeps it healthy, launch-ready tells the world. No behavioral changes to production-ready itself.

### Changed

- **SUITE.md known-good versions table** updated: launch-ready now shows version 1.0.0 and the live repo URL instead of "Not yet released." stack-ready bumped to 1.1.4, deploy-ready to 1.0.3, and observe-ready to 1.0.2 alongside this release for the same byte-identical sync.
- **SKILL.md frontmatter version** bumped to 2.5.5. No content change beyond the version tag.

### Why a patch, not a minor

Same rationale as prior x.y.z patches: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v2.5.4 (2026-04-23)

Documentation-only patch. Reflects the arrival of repo-ready v1.6.0 as a live sibling in the ready-suite with its suite-membership retrofit (frontmatter interop fields, SUITE.md, Unicode cleanup). No behavioral changes to the skill.

### Changed

- **SUITE.md known-good versions table** updated: repo-ready now shows version 1.6.0 and its repo URL instead of "See its CHANGELOG."
- **SKILL.md frontmatter version** bumped to 2.5.4. No content change beyond the version tag.

## v2.5.3 (2026-04-22)

Documentation-only patch. Reflects the arrival of observe-ready v1.0.0 (https://github.com/aihxp/observe-ready) as a live sibling in the ready-suite. No behavioral changes to the skill.

### Changed

- **SUITE.md known-good versions table** updated: observe-ready now shows version 1.0.0 and the live repo URL instead of "Not yet released." deploy-ready bumped to 1.0.1 and stack-ready to 1.1.2 alongside this release for the same byte-identical sync.
- **SKILL.md frontmatter version** bumped to 2.5.3. No content change beyond the version tag.

### Why a patch, not a minor

Same rationale as 2.5.2: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---

## v2.5.2 (2026-04-22)

Documentation-only patch. Reflects the arrival of deploy-ready v1.0.0 (https://github.com/aihxp/deploy-ready) as a live sibling in the ready-suite. No behavioral changes to the skill.

### Changed

- **SUITE.md known-good versions table** updated: deploy-ready now shows version 1.0.0 and the live repo URL instead of "Not yet released." stack-ready bumped to 1.1.1 alongside this release for the same byte-identical sync.
- **SUITE.md Unicode hygiene.** The tier-diagram box-drawing horizontals and arrow glyphs were replaced with ASCII hyphens and `->` to satisfy the suite's Unicode-dash-clean convention. The content of the table is unchanged; only the glyphs are normalized. Same change applied to every sibling's copy so the byte-identical invariant holds.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched, to track a new sibling's release and normalize Unicode. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---

## v2.5.1 (2026-04-22)

Documentation-only patch. Reflects the arrival of stack-ready v1.1.0 (https://github.com/aihxp/stack-ready) as a live sibling in the ready-suite. No behavioral changes to the skill.

### Changed

- **SUITE.md known-good versions table** updated: stack-ready now shows version 1.1.0 and the live repo URL instead of "Not yet released." This file is intended to stay byte-identical across suite siblings, so the update will ship to every suite repo as each one releases.
- **README.md suite callout** extended to name stack-ready alongside repo-ready as live siblings today, with a one-line scope statement for each (stack-ready owns the decision about what to build with; repo-ready owns the repo; production-ready owns the app).

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only outward-facing documentation references a new sibling's existence. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---

## v2.5.0 (2026-04-22)

Retrofits production-ready to the **ready-suite interop standard**. Declares suite membership, wires upstream and downstream artifact handshakes, and ships `SUITE.md` at repo root that is byte-identical across every skill in the suite. No breaking changes; all additions. Positions production-ready as the building-tier core of a nine-skill suite spanning planning, building, and shipping.

### Added

- **Frontmatter suite fields.** New required fields: `suite: ready-suite`, `tier: building`, `upstream: [prd-ready, architecture-ready, roadmap-ready, stack-ready]`, `downstream: [deploy-ready, observe-ready]`. `pairs_with` retained for same-tier siblings (`repo-ready`). Makes the skill's suite position machine-readable for skill-aware harnesses.
- **Suite membership section in SKILL.md.** One-line summary of all nine sibling skills organized by tier. Same content in every skill (loosely, via `SUITE.md`) so any entry point into the suite surfaces the whole map.
- **Consumes from upstream section.** Documents which upstream artifacts production-ready reads and where: `.prd-ready/PRD.md` at Step 1, `.architecture-ready/ARCH.md` at Step 2, `.roadmap-ready/ROADMAP.md` at Steps 1 and 5, `.stack-ready/STACK.md` at Step 2. Absence is fine; the skill falls back to its own defaults.
- **Produces for downstream section.** Documents the artifacts production-ready emits that deploy-ready and observe-ready consume: `.production-ready/STATE.md`, ADRs, route map, audit log schema, deferred-cta.md, open-questions block. Produced whether or not downstream skills are installed. Makes the suite extensible: install a downstream skill later and it already has its inputs.
- **`SUITE.md` at repo root.** Single-page map of the nine-skill ready-suite: tier organization, dependency flow, install locations, composition principles, known-good version table. Intended to be byte-identical across every skill in the suite so users discover the whole suite through any entry point.

### Changed

- **README.md top paragraph** now frames production-ready as part of the ready-suite and links to `SUITE.md`, rather than only naming the repo-ready pairing.

### Rationale

The anti-pattern the suite must prevent is scope creep inside individual skills. The only way to prevent it at scale is to give the suite a minimal interop standard: declared membership, declared contracts between skills, identical cross-references. v2.5.0 establishes that standard in production-ready. Sibling skills (repo-ready today; stack-ready, deploy-ready, observe-ready, launch-ready, prd-ready, architecture-ready, roadmap-ready when built) will adopt the same standard, so every skill in the suite is visibly part of the same architecture.

---

## v2.4.0 (2026-04-22)

Closes the three remaining graveyard risks surfaced when auditing the deferred-CTA lifecycle work from v2.3.0. Every escape-hatch or deferred-work mechanism in the skill now has an entry schema, a tier-boundary review, and a Tier 4 closure gate. No more silent accumulation of unfinished work.

### Added

- **STATE.md open-questions lifecycle.** The `Open questions blocking work` block now requires the same three-field schema (status, target slice, specific blocker) as `.production-ready/deferred-cta.md`. Vague blockers like "later" fail the slice's Passes-when gate. Answered questions get promoted to the architectural-decisions block or an ADR. Tier 4 cannot be declared while any question is `open`.
- **Mode D migration closure gate** (`codebase-research.md`). The disposition inventory now requires per-item status (`planned`, `in-progress`, `shipped`, `reclassified-as-dropped`). Every reclassification requires an ADR. Tier 4 cannot be declared while any `rewrite` item is `planned` or `in-progress`. Inventories starting with more than 25 `rewrite` items are a signal the project is a rewrite dressed as a migration and should restart as Mode A greenfield.

### Changed

- **Hollow-check rule tightened to zero hits at any severity.** The prior rule accepted "zero high-severity hits" with an implicit low-severity tolerance that agents could use as an escape hatch. The rule is now "zero hits" with a single narrow exclusion: legitimate `console.error` or structured logger calls in catch blocks. Everything else blocks the slice.
- **Tier 4 requirement #24 expanded** from "no hollow indicators" to "no hollow indicators and no open work." Now explicitly disqualifies: zero `open` questions in STATE.md, zero unshipped `rewrite` items in the Mode D migration inventory, plus the existing TODOs, raw debug output, hardcoded data, empty handlers, and live `deferred-cta.md` entries.
- **STATE.md template example** updated to demonstrate the open-questions entry schema in practice.

### Why this matters

Before v2.4.0, a project could reach Tier 4 with:
- A pile of "we'll decide later" questions sitting in STATE.md.
- A pile of low-severity hollow-check hits "batched for cleanup."
- A pile of unshipped `rewrite` items in a Mode D migration inventory.

All three looked like progress (the file was tidy, the build was green, the tier tests passed) while actually masking unfinished work. v2.4.0 closes those loops.

---

## v2.3.0 (2026-04-22)

Closes the lifecycle loop for the v2.2.0 half-wired CTA rule. v2.2.0 defined the *entry* into `.production-ready/deferred-cta.md` (one of three escape hatches when a chain cannot ship in the current slice) but did not define the *exit*. Left as-is, the deferred list accumulates as a junk drawer of forgotten buttons. This release adds a strict entry schema, a tier-boundary review rule, a Tier 4 closure gate, parallel tracking for disabled-with-reason CTAs, and an audit cadence that keeps the file honest over time.

### Added

- **New "Deferred CTA lifecycle" section in SKILL.md.** Placed immediately after the have-nots, before the reference files. Covers five rules: entry schema, tier-boundary review, Tier 4 closure gate, disabled-parallel tracking, and removal exception.
- **Entry schema** (five required fields per row: location, intended chain, specific blocker, target slice or milestone, status). Entries missing any field, or naming a vague blocker, fail the slice's Passes-when gate.
- **Status vocabulary** (`deferred`, `in-progress`, `resolved`, `dropped`). Drop-with-reason entries stay in the file for audit history.
- **Tier-boundary review rule.** At every tier boundary, walk the file entry by entry. Ship resolved-blocker items in the current tier cycle. Append check dates for items whose blocker is still real. An entry that sits `deferred` across two tier boundaries without progress is a scope signal and should be rescoped or dropped.
- **Tier 4 closure gate.** Tier 4 (Hardened) cannot be declared complete while any entry is `deferred` or `in-progress`. Every entry must be `resolved` or `dropped` before declaring ship-ready. Same discipline as "zero TODOs at Tier 4": deferred CTAs are TODOs the user can see.
- **Disabled-parallel rule.** A disabled-with-visible-reason CTA that is pending future work must also have a `deferred-cta.md` entry. Feature-gates (plan tier, subscription, flag) are a separate permanent pattern and do not require tracking.
- **Removal exception.** Removed CTAs do not need tracking, with one exception: a CTA visible in a prior *released* version should prefer disable-plus-track over silent removal to avoid UX regression surprise.
- **File-growth audit signal.** More than 10 live `deferred` entries is a signal the slice scope is drifting; the slice should be broken up or features cut.

### Changed

- **Step 5 item 9 escape hatch (iii)** now references the Deferred CTA lifecycle section by name rather than inlining the fields. This keeps the recipe tight and gives the lifecycle rules a single canonical home.
- **Tier 4 requirement #24** now explicitly includes "zero live entries in `.production-ready/deferred-cta.md` (every entry must be `resolved` or `dropped`)" alongside the existing TODO, console.log, hardcoded-data, and empty-handler disqualifiers.

---

## v2.2.0 (2026-04-22)

Names and catches a failure mode that existing linters miss: the **half-wired CTA**. A button, link, form, or drawer trigger whose leaf handler is non-empty but whose chain dead-ends one or two hops in (navigation to an unregistered route, empty modal bodies, mutations that never invalidate caches or toast, dispatched actions with no handler, forms that submit into the void). Research-backed: no existing term owned the naming lane (Smashing, CXL, UX Planet own "ghost button" for the visual term; "Potemkin UI" is too generic), and no linter currently catches chain-level failures (the closest is `next-type-safe-routes` at compile time). Repair-as-a-service businesses (VibeCheetah, FixBrokenAIApps) have emerged specifically around this failure pattern, confirming the market signal.

### Added

- **Step 5 recipe item 9: CTA flow completeness audit.** Every interactive element the slice adds must have its full chain walked, not just its leaf handler. The chain must end at a real user-visible outcome: a rendered page, a persisted record, a confirmation toast, a refreshed list, a drawer with real content. Five half-wired shapes called out explicitly. Defines three and only three escape hatches when the chain cannot ship in the current slice: remove the CTA, disable with a visible reason, or log as deferred in `.production-ready/deferred-cta.md`.
- **Tier 1 proof test extension.** "Click every primary and secondary CTA on every page the slice touches, including drawer triggers, menu items, and form submits. Each must complete its chain to a real user-visible outcome. A 404 on navigation, an empty modal or drawer, a silent mutation with no cache invalidation or toast, or a form that submits into the void is a Tier 1 failure."
- **New have-not: half-wired CTA.** Explicit disqualifier at any tier. Leaf handler non-empty is not sufficient.
- **Hollow-check protocol extended with CTA chain grep.** Four new patterns: navigation destinations for route-map cross-checking, empty dialog/drawer/sheet shells, mutations without `onSuccess` or cache invalidation, and forms without `onSubmit` or `action`. Flagged as heuristic (manual audit against the route map), not automatic failures, to avoid false positives on legitimate late-binding patterns.

### Changed

- **Step 5 "Passes when" gate** now requires the CTA flow completeness audit to return zero half-wired CTAs (or every exception logged in `.production-ready/deferred-cta.md`).
- Hollow-check `Rule:` paragraph clarifies that CTA flow hits are heuristic and produce a manual-audit list, distinct from automatic high-severity hits like ghost packages or TODOs.

---

## v2.1.0 (2026-04-22)

Incident-aligned rollup. Closes the dominant AI-coding complaint gaps surfaced by industry research (METR 2025, Veracode 2025, Socket slopsquatting, Stack Overflow 2025, and the 2025 incidents at Moltbook, Lovable, Base44, Replit) and adds the operational discipline for multi-session, multi-slice, multi-domain work. No breaking changes; existing workflows continue to work and inherit stricter gates.

This release consolidates all work since v2.0.0.

### Defense-in-depth additions

- **Threat model bullet in Step 2 architecture note.** Three required answers: attacker gain, highest-blast-radius mutation, trust boundaries. Compliance blast radius for regulated domains.
- **Slopsquatting defense in Step 4.** Pre-install verification of every unfamiliar dependency (publisher, registry presence, download count). Hollow check now scans `package.json`, `requirements.txt`, and `Gemfile` for ghost names; any `GHOST:` hit is always high-severity.
- **Cross-stack hollow check.** Python, Ruby, PHP, and universal markers added to the grep protocol (was JS/TS only).
- **Tier 1 proof test now verifies design-token application.** "Inspect one button and verify its color traces to `--color-primary`, not a library default."

### Handoff and continuity additions

- **ADR-per-slice in Step 5.** Three-line decision record in `.production-ready/adr/NNN-slug.md` for any non-obvious choice a future maintainer would have to reverse-engineer.
- **Session state and handoff section with `.production-ready/STATE.md` template.** Updated at every tier boundary and context compaction; read first on resume. Template now records the skill version the project was built under.
- **Frontmatter metadata.** `version`, `updated`, `changelog`, `compatible_with`, `pairs_with` for machine-readable version legibility and STATE.md cross-check.
- **Repo-ready companion skill pairing.** Explicit handoff section in SKILL.md for repo hygiene (README, LICENSE, CI, release automation). Harness-aware instructions for skill-invocation tools.

### Workflow auditability additions

- **Per-step acceptance tests in SKILL.md.** Every workflow step (0 through 9) ends with a one-line "Passes when" gate that makes step completion auditable.
- **Mode D: Migration** in `codebase-research.md` and SKILL.md Step 0. Detects off-the-shelf templates (Retool, Appsmith, shadcn admin kit), prior-agent work, and cross-framework ports. Produces a keep/rewrite/discard disposition inventory and a phased migration plan. Prevents the "preserve hollow patterns because they're already there" failure mode.
- **Graduated contract tests in Step 7 and Tier 4.** Any public API signature, server action, or exported type that crosses slice boundaries gets a schema-level contract test. Mandatory the moment a second slice consumes the signature.

### Domain and compliance additions

- **Tier remap for regulated domains** (`domain-considerations.md`). Healthcare, government, education, finance, legal, HR, gaming with minors, and cybersecurity remap specific Tier 3 items to Tier 1 legal obligations. Includes seed-data compliance guardrails.

### Structural additions

- **`naming.md` reference file.** Cross-layer naming conventions extracted from SKILL.md. Tables for code, navigation, casing boundary rule, and anti-patterns.
- **Canonical-scope headers on 11 overlapping reference files.** Each file now states its owned scope and cross-references related files. Kills the split-brain between `auth-and-rbac.md` and `login-and-auth-pages.md`, `security-deep-dive.md` and `performance-and-security.md`, `data-layer.md` and `api-and-integrations.md`, `information-architecture.md` and `headers-and-navigation.md`, and others.
- **"When this skill does NOT apply" routing section in SKILL.md.** Explicit scope fence against single-component requests, repo hygiene, marketing sites, and greenfield scaffolding.
- **"When Production Ready should trigger" section in README.** Full trigger surface moved out of frontmatter: positive triggers, implied triggers, mode triggers, negative triggers, and the repo-ready pairing rule.

### Positioning additions

- **Vibe coding vs. vibe engineering framing in README.** Cites real 2025 incidents (Moltbook, Lovable CVE-2025-48757, Base44, Replit production-DB wipe, Veracode 45%, Socket 20% slopsquatting, METR 19% slowdown, Stack Overflow 66% "almost right"). Adopts Willison's vibe-engineering framing.
- **"What this skill prevents" incident table in README.** Every prevention maps to a documented incident or research finding.

### Changed

- **SKILL.md trimmed from 643 to approximately 400 lines.** Visual identity framework moved into `ui-design-patterns.md`. Naming conventions moved into `naming.md`. "How to interpret a vague request" table moved into `domain-considerations.md`.
- **Visual identity decision framework now single-sourced** in `ui-design-patterns.md` (archetype table, 5 decisions, token block, anti-patterns) immediately above the existing 10 token sets.
- **Frontmatter description trimmed** from approximately 1,100 to approximately 620 characters. Retains core trigger signal, enforcement rule, and repo-ready pairing. Full trigger list now lives in README.
- **"Rules for working with existing codebases"** in `codebase-research.md` now applies to Modes B, C, and D (was B and C only), with a Mode D caveat: rules govern only "keep" items; "rewrite" and "discard" items are re-decided per the migration plan.
- **Documentation rewritten without em dashes** across SKILL.md, README.md, CHANGELOG.md, `naming.md`, and the new sections of `ui-design-patterns.md`, `domain-considerations.md`, and `codebase-research.md`.
- **GitHub repo description** updated to mention the repo-ready pairing.
- **Reference file count** updated from 36 to 37.

### Added to have-nots

- Installing a package without confirming it exists on the registry with a real publisher (slopsquatting protection).
- A non-obvious architectural decision made with no corresponding ADR in `.production-ready/adr/`.
- Running a destructive command (`rm -rf`, `DROP TABLE`, `git push --force`, `prisma migrate reset`) without an explicit confirmation step and a known backup.

### Migration notes

- Projects built under v2.0.0 will pass v2.1.0 unchanged for anything already completed, but new slices under v2.1.0 will be held to the stricter gates (threat model in architecture note, ADR when non-obvious, contract tests at cross-slice boundaries, STATE.md maintained across sessions). Recommended path: record the current tier in `.production-ready/STATE.md`, then proceed under the new rules for subsequent slices.
- The regulated-domain tier remap applies prospectively. If an existing project is in a regulated domain and has not yet shipped the remapped Tier 1 items (accessibility or audit log), treat those as gaps to close before the next tier boundary rather than as a v2.0.0 breakage.

---

## v1.2.0 — 2026-04-12

### Added

- **Mid-build hollow check protocol** (Step 5.1 in SKILL.md) — automated grep-based scan that runs after every feature slice and at every tier checkpoint. Catches TODOs, empty handlers, hardcoded data, and console.logs while they're cheap to fix, not at the end.

- **Decision trees added to 6 reference files** — each file now opens with actionable routing guidance before the deep content:
  - `auth-and-rbac.md` — "Which auth method?" decision tree (internal/SaaS/sensitive → method)
  - `data-layer.md` — Concrete Next.js App Router pattern (server component + server action + client component)
  - `information-architecture.md` — "Which layout?" table (page count × task → layout type)
  - `testing-and-quality.md` — Test prioritization table (priority 1–4 by regression damage)
  - `settings-and-configuration.md` — Default hybrid architecture + auto-save vs explicit save rule
  - `domain-considerations.md` — Top 13 domain gotchas frequency table

### Changed

- **Reference table is now tier-annotated** — each file tagged with when to load it (Always / Tier 1 / Tier 2 / Tier 3 / Tier 4 / On demand) instead of vague descriptions
- **Hollow check reminders** added to all tier checkpoint annotations
- **"Haves" section condensed** — replaced vestigial header with one-line note pointing to tiers (the tiers ARE the requirements list)
- **Tier 4 checkpoint** now explicitly requires zero hollow check hits at any severity

---

## v1.1.0 — 2026-04-12

### Added

- **Codebase research phase** (`references/codebase-research.md`) — New Step 0 in the workflow that runs before the pre-flight. Detects whether the project is greenfield, an existing codebase, or an audit request, then produces a structured assessment any agent's planner can consume.
  - **Mode A (Greenfield):** 60-second scan for external constraints (deployment config, pre-installed deps, design docs, existing APIs)
  - **Mode B (Assessment):** Full 7-part codebase scan — stack inventory, route/page map, data layer state, auth state, UI inventory, conventions scan, hollow indicators — produces a tier-tagged gap analysis
  - **Mode C (Audit):** Assessment + verification checklist walkthrough, produces a severity-sorted fix-it list

- **Completion tiers** — 4-tier system (Foundation → Functional → Polished → Hardened) that defines shippable checkpoints throughout the build. Each tier has concrete requirements, a proof test, and a checkpoint annotation in the workflow steps.
  - Tier 1 (Foundation): Auth + real data + shell + one CRUD entity + visual identity
  - Tier 2 (Functional): + RBAC + all states + validation + settings + profile
  - Tier 3 (Polished): + audit log + accessibility + responsive + cross-cutting
  - Tier 4 (Hardened): + tests + security headers + verification green + zero hollows

- **Decision tree** — Visual routing logic at the top of the tiers section that directs the agent based on project state (greenfield vs. existing codebase vs. audit) and current tier

- **Tier-aware research outputs** — Assessment gap analysis and audit fix-it lists now tag every item with its tier, so planners build todos in the correct order

### Changed

- **Workflow steps renumbered 0–9** (was 1–8 with duplicate step 4). Step 0 is the new research phase.
- **Step 1 (pre-flight)** now consumes research output to pre-fill answers for existing codebases
- **Step 2 (architecture)** branches: in assessment mode, document existing conventions instead of deciding fresh
- **Reference file count** updated from 35 to 36

### Fixed

- Duplicate step numbering (two "### 4" headings) corrected to sequential 0–9

---

## v1.0.0 — 2026-04-11

Initial release as Production Ready (renamed from Dashboard Design Skill).

- 10-step vertical-slice workflow
- 12-question pre-flight
- 33 industry vertical domain knowledge
- Visual identity derivation system (10 aesthetic archetypes)
- 35 reference files covering auth, data, UI, testing, security, and more
- 20-point verification checklist
- Naming conventions guide
- Works with any stack (React/Next/Vue/Svelte/Rails/Django/Laravel)

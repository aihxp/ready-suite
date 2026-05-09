# Changelog

## v1.1.8 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.7.0 release that adds Mode D (Multi-repo suite) to repo-ready workflow. This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.1.7 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the coordinated antipattern-catalog sweep landing across stack-ready, repo-ready, production-ready, deploy-ready, observe-ready, launch-ready, and harden-ready. Each of those seven skills gains a dedicated `references/<skill>-antipatterns.md` file (named-failure-mode catalog with grep tests). This skill already had its own `<skill>-antipatterns.md` (or equivalent) and is unchanged in content; only frontmatter version + updated and SUITE.md tick.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.1.6 (2026-05-09)

Documentation-only patch. Recovery sync after the just-retired v2.5.12 precedent. The repo-ready v1.6.15 release (which itself triggered the precedent retirement in MAINTAINING.md) shipped with the OLD SUITE.md committed; the catch-up sync to the other 10 siblings happened afterward in a separate hub commit, but the lint workflow correctly flagged the resulting drift. This patch lands the byte-identical SUITE.md across all 12 repos with the full version table current to all 11 specialists.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to the post-retirement state across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking; mechanical recovery from the lint-caught drift.

---


## v1.1.5 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.6.15 audit-refresh release. The v2.5.12 precedent (single-specialist patches do not trigger full SUITE.md sync) is retired effective this patch: the hub `scripts/lint.sh` `suite-md-sync` check enforces byte-identical `SUITE.md` across all 12 repos, so every specialist version bump (including audit-report refreshes that bump only one specialist) now triggers a full coordinated sync.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to repo-ready 1.6.15 across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.1.4 (2026-05-09)

Documentation patch + naming-consistency rename. Renames `references/antipatterns.md` to `references/kickoff-antipatterns.md` to match the `<skill>-antipatterns.md` convention used by prd-ready, architecture-ready, and roadmap-ready. The four planning-tier antipattern files now follow the same naming pattern. SKILL.md and README.md cross-references updated.

### Changed

- **`references/antipatterns.md`** -> **`references/kickoff-antipatterns.md`**: rename for naming consistency with sibling planning-tier skills.
- **SKILL.md**: reference table row + body cross-references updated to the new filename.
- **README.md**: reference list label + link updated.
- **`.gitignore`**: added `.claude/settings.local.json` and `.planning/` patterns to prevent accidental commits of personal local config and GSD planning artifacts.
- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

File rename + cross-reference fixes; no behavior change in the skill workflow.

---


## v1.1.3 (2026-05-09)

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


## v1.1.2 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the four planning-tier skill releases (prd-ready v1.0.10, architecture-ready v1.0.9, roadmap-ready v1.0.8, stack-ready v1.1.15) which add worked-example reference files for a single fictional B2B SaaS product (Pulse, a Customer Success ops platform). The four examples cross-reference each other to demonstrate the suite's compose-by-artifact principle: each downstream artifact reads from the prior one and refines, never duplicates. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.1.1 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v2.6.0 release of [production-ready](https://github.com/aihxp/production-ready), which adds first-class consumption of the [Google Labs `DESIGN.md`](https://github.com/google-labs-code/design.md) format as the canonical design-system token source for dashboards. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `DESIGN.md` format and the consumption flow (production-ready Step 3 sub-step 3a). Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.1.0 (2026-05-09)

Minor release. kickoff-ready now emits a project-root `AGENTS.md` mapping the suite's artifact paths in Step 6 sub-step 6a, when no `AGENTS.md` exists. This makes the ready-suite visible to non-Claude harnesses arriving at the project cold (Codex CLI, GitHub Copilot, Cursor, Windsurf, Aider, Zed, Warp, Roo Code, Jules, Factory, Amp, Devin, and others that read the [agents.md open standard](https://agents.md/) governed by the Linux Foundation's Agentic AI Foundation).

### Added

- **Step 6 sub-step 6a**: emit minimal `AGENTS.md` at project root (only if absent). The emitted file lists the per-sibling artifact map; it does not contain stack, commands, conventions, or forbidden actions (those belong to repo-ready or to the user). The emit decision is recorded in `PROGRESS.md` as `agents_md_emitted: <path | existing-respected | guidance-text>`.
- **`references/agents-md-template.md`**: the substitution-driven template, the emit conditions, the kickoff-ready / repo-ready handshake on a shared file, and the cross-references.
- **Reference table row** in SKILL.md for the new template.

### Changed

- **`references/handoff-protocols.md`** §AGENTS.md: rewritten to reflect the new emit policy. Names the cross-tool standard, the harnesses that read it, and the `existing-respected` rule. Surfaces the template as a guidance string on chat-only harnesses.
- **SUITE.md** Standards section: adds an `AGENTS.md` compatibility paragraph naming the two specialists that meet the cross-tool agent-brief surface (kickoff-ready emits artifact metadata when absent; repo-ready scaffolds the conventions side).

### Why a minor, not a patch

The skill now writes a file outside `.kickoff-ready/`. This is a deliberate scope expansion (artifact metadata, not specialist content), but it is a behavior change observable by users; minor is the honest bucket.

---


## v1.0.1 (2026-05-06)

Documentation-only patch. Adds first-class support for [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) and [OpenClaw](https://github.com/openclaw/openclaw) via the [Agent Skills standard](https://agentskills.io). The suite now positions explicitly as agentskills.io-compatible: any harness that parses `SKILL.md` frontmatter natively runs every ready-suite skill first-class, with no per-tool integration. pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support for free.

### Changed

- **Frontmatter**: `compatible_with` now lists `pi`, `openclaw`, and `any-agentskills-compatible-harness` (the latter replaces the older `any-agent-with-skill-loading` value for tighter standards-level signaling).
- **SUITE.md**: install-locations table adds rows for pi, OpenClaw, and the neutral Agent Skills path; new "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).
- **Hub install.sh / uninstall.sh** (in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)): detect pi (`~/.pi/`) and OpenClaw (`~/.openclaw/`), write to the neutral `~/.agents/skills/` path. No regressions on the existing Claude Code / Codex / Cursor flow.

### Why a patch, not a minor

The skill's behavior, references, and workflow are unchanged. Only the frontmatter `compatible_with` list, `SUITE.md`, and the README install section move; the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only standards-compliance signaling.

---



All notable changes to this skill are documented here. Format loosely follows [Keep a Changelog](https://keepachangelog.com/). Version numbers follow the ready-suite discipline: major for breaking skill-contract changes, minor for additive behavior changes, patch for documentation-only updates (including sibling-ship tracking in SUITE.md).

## v1.0.0 (2026-05-06)

First stable release of kickoff-ready, the eleventh skill in the [ready-suite](SUITE.md) and the only one in the orchestration tier. kickoff-ready sequences the ten core-suite specialists for a greenfield project: planning tier (prd-ready, architecture-ready, roadmap-ready, stack-ready), building tier (repo-ready, production-ready), and shipping tier (deploy-ready, observe-ready, launch-ready, harden-ready). It is the meta-tier conductor; every other ready-suite sibling is downstream from it in the orchestration sense.

The skill is deliberately small. Its only outputs are sequence metadata: a per-step record in `.kickoff-ready/PROGRESS.md`, a Skill-tool invocation per specialist, and a verification gate confirming the sibling actually wrote its artifact to disk. It does not produce specialist content. The single load-bearing principle is that kickoff-ready calls siblings; it never impersonates them.

### Behavior

- **Eight-step workflow.** Step 0 detects harness, mode, and install state. Step 1 runs the resume protocol every turn. Step 2 captures kickoff intent. Step 3 invokes the planning tier. Step 4 invokes the building tier. Step 5 invokes the shipping tier with the harden-ready / launch-ready parallel branch and critical-finding gate. Step 6 produces the final ledger and hands off to a phase orchestrator. Step 7 refuses-and-routes any out-of-scope request mid-arc.
- **Seven-status PROGRESS.md schema.** `pending`, `in-flight`, `done`, `skipped`, `imported`, `failed`, `re-invoked`. Every sibling has exactly one row; silence is not a status. The Shape Up no-gos discipline applied to orchestration.
- **Two-check verification gate.** Artifact exists AND non-empty. Mtime later than invocation. The Just / Make discipline of file-system-as-truth.
- **Resume protocol every turn.** Read PROGRESS.md, `ls` every claimed-complete sibling directory, re-derive current step from disk. Defends against the phantom-resume class of failures cited in Anthropic claude-code issues #42338, #42260, #42309, NousResearch hermes-agent#17344, and paperclipai#635.
- **Critical-finding gate.** harden-ready emits a Critical finding while launch-ready is in-flight or pending: launch-ready halts until the finding moves to Closed or the user records an explicit risk acceptance with named owner, justification, and dated acceptance.
- **Skip / re-invoke / import semantics.** All recorded explicitly in PROGRESS.md. Pre-existing artifacts at known paths are detected at Step 0 (Yeoman-style conflict resolution: ask before overwriting).
- **Per-harness handoff.** Programmatic invocation on Claude Code (`/skill-name`), Codex (`$skill-name`), Antigravity (Agent Skills standard). Guidance-text fallback on Cursor and Windsurf. Degraded mode on chat-only frontends with PROGRESS.md inside the conversation.

### Have-nots (the teeth)

The skill refuses, by name:

- **Scope leak.** kickoff-ready writes specialist content (a PRD, an architecture, a roadmap, launch copy, security findings, etc.) instead of invoking the specialist.
- **Rubber-stamp orchestration.** PROGRESS.md says step done with no artifact on disk.
- **Phantom resume.** Resume that does not re-derive state from disk.
- **Ghost handoff.** Sibling invoked before its declared upstream artifact exists.
- **Happy-path orchestration.** No status code in PROGRESS.md for failure / skip / import / re-invoke cases.
- **Critical-finding gate bypass.** launch-ready advances to done while harden-ready has an open Critical and PROGRESS.md has no risk acceptance entry.
- **Out-of-scope inline answer.** The user asks for a PRD / architecture / launch copy / etc. mid-arc and kickoff-ready produces it instead of refusing and routing.
- **Skip-as-silence.** A sibling absent from PROGRESS.md entirely (neither done nor skipped).

The full have-nots catalog with grep tests, severity classifications, and citation back to the research report is in [`references/antipatterns.md`](references/antipatterns.md).

### Reference library

Six reference files. Six is enough; the skill does not pad.

- [`RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md) (489 lines, 46 inline citations). The evidence base behind every refusal name, every sequencing decision, and every harness-landscape claim.
- [`sequencing-rules.md`](references/sequencing-rules.md). The DAG, parallelism rules, gate logic, skip cascade, re-invocation discipline.
- [`handoff-protocols.md`](references/handoff-protocols.md). Per-harness invocation patterns; guidance-text fallback; on-disk artifact-handoff baseline.
- [`progress-tracking.md`](references/progress-tracking.md). PROGRESS.md schema and resume protocol.
- [`scope-fence.md`](references/scope-fence.md). The boundary catalog. Eleven canonical refusals plus three invariants.
- [`antipatterns.md`](references/antipatterns.md). Twelve named failure modes with grep tests, guards, citations, severities.

### Frontmatter

- `tier: orchestration` (new tier value introduced with this skill).
- `upstream: []` (kickoff-ready triggers from raw user intent).
- `downstream: [prd-ready, architecture-ready, roadmap-ready, stack-ready, repo-ready, production-ready, deploy-ready, observe-ready, launch-ready, harden-ready]` (all ten core-suite siblings are downstream in the orchestration sense).
- `pairs_with: []` (kickoff-ready is the only orchestration-tier skill; no peer).
- `compatible_with: [claude-code, codex, cursor, windsurf, antigravity, any-agent-with-skill-loading]`.

### Suite changes

- **SUITE.md introduces a new "orchestration" tier.** Coordinated byte-identical sync across all eleven repos: the ten core-suite siblings plus the ready-suite hub at aihxp/ready-suite. Each sibling's SUITE.md `Known-good versions` table gains a `kickoff-ready` row. Each sibling repo bumps its own version as a documentation-only patch to track the eleventh-sibling release.
- The composition-with-orchestrators principle in production-ready/ORCHESTRATORS.md is unchanged: ready-suite skills are orchestrator-agnostic by design. kickoff-ready is itself an orchestrator (the meta-tier) but does not couple to any other orchestrator. Phase orchestrators (GSD, BMAD) compose with kickoff-ready at the boundary; kickoff-ready hands off PROGRESS.md and gets out of the way.

### Dogfood

Walked against a hypothetical greenfield project intent ("I have an idea for a small SaaS that helps me track reading goals; help me ship it") through the full eleven-step orchestration arc before cut. The dogfood walk surfaced:

- **repo-ready verification is multi-file, not single-file.** The most load-bearing dogfood finding. Initial draft of SKILL.md, sequencing-rules.md, and progress-tracking.md claimed `.repo-ready/STATE.md` was repo-ready's canonical primary artifact. Walking the building tier against the actual repo-ready convention exposed that repo-ready does not produce a STATE.md; it writes top-level repo files (README.md, .github/workflows/, .editorconfig, etc.) and `.repo-ready/SECURITY.md` (the file harden-ready consumes per harden-ready's "Consumes from upstream" table). Fixed by introducing a multi-file scaffolding-presence check for repo-ready in the per-sibling upstream contract (`references/sequencing-rules.md` "Per-sibling upstream contract" table row 5 and "Post-invocation checks" section), the import-detection table (`references/progress-tracking.md` "Canonical primary artifact paths per sibling" table), and the SKILL.md "Consumes from upstream" import table. PROGRESS.md `artifact_path` field stores the multi-file expression as a string; verification walks each component. This is the kind of bug the rubber-stamp-orchestration guard would itself catch in production (the file would not exist, so the verification would fail), but documenting the right path up front is cheaper than relying on the failure path.
- **Cleaner skip-cascade rules.** Initial draft had skip and refuse-to-run conflated; revised to make refusal-on-required-upstream and proceed-with-degradation explicit per pair (`references/sequencing-rules.md` Section "Skip cascade rules"). Most siblings have downstream consumers that are robust to the skip; production-ready and deploy-ready downstream are the strict-required cases.
- **Explicit harden-ready / launch-ready gate algorithm.** Initial draft was prose; revised to a numbered algorithm with the four gate states (clean, Critical-with-acceptance, Critical-without-acceptance, override-modes) per `references/sequencing-rules.md` Section "Critical-finding gate logic."
- **Resume protocol stated as mandatory every turn**, not just on `/resume`. The dogfood pass on a hypothetical multi-day kickoff exposed that "every turn" must be the discipline, because the LLM cannot reliably distinguish between "first turn after compaction" and "explicit resume request" without re-reading disk.

### Known limits at v1.0.0

- **Verification depth is existence-only.** kickoff-ready cannot detect that a sibling produced semantically wrong content (a PRD that is shallow, an architecture that is paper, a roadmap that is fictional). Each sibling owns its own correctness through its own have-nots; kickoff-ready verifies only that artifacts exist and are non-empty. This is a deliberate scope choice, not a bug.
- **Building-tier parallelism is opt-in.** repo-ready and production-ready can run concurrently in two harness sessions, but the default is sequential. Concurrent mode requires the user to handle a small package.json merge.
- **Phase orchestrator hand-off is one-way.** Once kickoff-ready hands off to GSD or BMAD or no orchestrator, it does not get called back. Re-invoking a sibling later (a roadmap revision, a hardening pass) does not require kickoff-ready; the user invokes the sibling directly.
- **Chat-only frontends are degraded.** PROGRESS.md exists only inside the conversation; resume requires the user to copy PROGRESS.md back. The skill is honest about this and recommends Claude Code, Codex, Cursor, or Windsurf for a multi-day kickoff.

### Acknowledgments

The research pass cites 46 sources. Notable load-bearing citations:

- Praetorian's [Deterministic AI Orchestration: A Platform Architecture for Autonomous Development](https://www.praetorian.com/blog/deterministic-ai-orchestration-a-platform-architecture-for-autonomous-development/) (the scope-leak refusal name).
- Cogent's [When AI Agents Collide: Multi-Agent Orchestration Failure Playbook for 2026](https://cogentinfo.com/resources/when-ai-agents-collide-multi-agent-orchestration-failure-playbook-for-2026) (rubber-stamp orchestration).
- The Anthropic claude-code issue tracker (phantom resume; issues #42338, #42260, #42309).
- Galileo's [Multi-Agent Coordination Failure Mitigation](https://galileo.ai/blog/multi-agent-coordination-failure-mitigation) (ghost handoff; goal drift).
- The [just.systems](https://just.systems/man/en/) manual (the file-system-as-truth discipline).
- production-ready's ORCHESTRATORS.md and SUITE.md (the suite-internal interop contract that kickoff-ready obeys).

The full citation list is in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md).

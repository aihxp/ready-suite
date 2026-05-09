# Kickoff Ready

> **Sequence the ten ready-suite specialists for a greenfield project. Refuses scope leak, rubber-stamp orchestration, phantom resume, ghost handoff, and happy-path orchestration.**

> **Part of the [ready-suite](SUITE.md)**, a composable set of AI skills covering the full arc from idea to launch. kickoff-ready is the eleventh skill and the only one in the orchestration tier. See [`SUITE.md`](SUITE.md) for the full map.

A user types "I have an idea for a SaaS, help me ship it." A general-purpose agent, faced with a blank page and ten installed specialist skills, does the easiest thing an LLM can do: it fills the blank page. It writes a PRD inline. It sketches an architecture in the same response. It dashes off a roadmap as a bulleted list. It picks a stack from training-data familiarity. It gestures at a launch plan. None of the ten specialist skills (prd-ready, architecture-ready, roadmap-ready, stack-ready, repo-ready, production-ready, deploy-ready, observe-ready, launch-ready, harden-ready) ever fires. The user gets a one-message project-in-miniature that fails every specialist's have-nots simultaneously.

kickoff-ready refuses to fill the blank page. Its only outputs are sequence metadata: a per-step record in `.kickoff-ready/PROGRESS.md`, an invocation per specialist (via the harness's Skill tool, or guidance text on harnesses without one), and a verification gate after each invocation that confirms the sibling actually wrote its artifact to disk. The skill is small by construction; if it grows, it has drifted into a sibling's lane.

This is the eleventh skill in the ready-suite and the only one in the meta-tier. The other ten are specialists; kickoff-ready is the conductor. The single load-bearing principle: **kickoff-ready calls siblings; it never impersonates them.** Research citations for every refusal name and every sequencing decision are in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md).

## Install

This skill ships as part of the [ready-suite](https://github.com/aihxp/ready-suite) monorepo. The hub installer symlinks `SKILL.md` and `references/` for all eleven skills into every detected harness (Claude Code, Codex, Cursor, pi, OpenClaw, any Agent Skills harness):

```bash
git clone https://github.com/aihxp/ready-suite.git ~/Projects/ready-suite
bash ~/Projects/ready-suite/install.sh
```

Re-run anytime after `git pull` to pick up updates. To remove all symlinks, run `bash ~/Projects/ready-suite/uninstall.sh`.

**Windsurf or other agents without a programmatic Skill tool:** add this skill's `SKILL.md` to your project rules or system prompt. Load reference files as needed.

## The problem this solves

AI-generated multi-step orchestration fails in predictable, citation-backed ways. The pattern is consistent across LangChain / CrewAI / AutoGen / custom-supervisor-agent orchestrators. kickoff-ready catches each:

- **Scope leak.** The orchestrator drifts into producing the specialist's content rather than invoking the specialist. Praetorian on deterministic AI orchestration: "the moment the orchestrator starts 'helping,' you're back in a world where one agent is planning, executing, and judging its own work, which is exactly where drift loves to hide." Refused.
- **Rubber-stamp orchestration.** The orchestrator advances PROGRESS.md to "done" without verifying the specialist produced its artifact on disk. Cogent's 2026 multi-agent orchestration playbook: "the orchestrator only checks whether an agent ran successfully rather than reading verification verdicts." Refused.
- **Phantom resume.** Resume claims to pick up from a saved point but actually starts fresh. Cited from six Anthropic claude-code issues (#42338, #42260, #42309, NousResearch hermes-agent#17344, paperclipai#635, plus stale-tool-result reports). Refused.
- **Ghost handoff.** A sibling is invoked before its upstream artifact exists; the sibling hallucinates the upstream and the chain proceeds on a fictional foundation. Galileo on multi-agent coordination failure where handoffs lack verifiable pointers. Refused.
- **Happy-path orchestration.** The orchestrator handles only the success branch. No policy for skip, re-invoke, import-from-existing, sibling failure. Refused.

Every failure mode in kickoff-ready's research traces to a citation in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md). The skill refuses each by name.

## When this skill should trigger

The short frontmatter description is tight on purpose. The full trigger surface:

**Positive triggers (greenfield kickoff):**
- "kickoff" / "kick this off" / "new project from scratch"
- "I have an idea, help me ship it" / "walk me through everything from idea to launch"
- "end-to-end" / "the whole arc" / "orchestrate the suite for me"
- "what should I do first" (in the context of a fresh project)
- "let's start a new SaaS / app / tool" with no existing code
- "use the ready-suite to take this from idea to launch"

**Implied triggers (the thesis word is never spoken):**
- "I have this idea for X..." with no follow-up specialist invocation
- "help me think through how to build this"
- "what's the right sequence of steps for a greenfield project"
- "I want to use prd-ready, architecture-ready, etc., but I don't know the order"

**Mode triggers (see [`SKILL.md`](SKILL.md) Step 0):**
- New kickoff: no `.kickoff-ready/PROGRESS.md` on disk
- Resume: PROGRESS.md exists; pick up where the prior session stopped
- Import: PROGRESS.md absent but one or more `.{skill}-ready/` directories already exist; the user is bringing prior work into the chain

**Negative triggers (route elsewhere):**
- Writing the PRD -> [`prd-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/prd-ready)
- Designing the architecture -> [`architecture-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/architecture-ready)
- Sequencing a roadmap -> [`roadmap-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/roadmap-ready)
- Picking a stack -> [`stack-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/stack-ready)
- Setting up the repo -> [`repo-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready)
- Building the app -> [`production-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready)
- Deploying -> [`deploy-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/deploy-ready)
- Wiring monitoring -> [`observe-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/observe-ready)
- Producing launch materials -> [`launch-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/launch-ready)
- Adversarial review -> [`harden-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/harden-ready)
- Existing-codebase migration ("we have a half-built thing; help us finish") -> the specific specialist that fills the gap. kickoff-ready is greenfield-only.
- Ongoing phase / milestone work after the kickoff arc completes -> a phase orchestrator (GSD, BMAD, etc.) per `production-ready/ORCHESTRATORS.md`.
- Non-suite work (blog posts, debugging, refactoring, hiring, branding) -> surface to the harness for general routing.

**Pairing:** kickoff-ready has no peer (it is the only orchestration-tier skill). Every other ready-suite skill is downstream from kickoff-ready in the orchestration sense. Composes with phase orchestrators (GSD, BMAD) at the boundary; does not couple internally to any specific orchestrator.

## How it works

Eight steps. One persistent artifact (`.kickoff-ready/PROGRESS.md`). Two-check verification per sibling.

1. **Step 0.** Detect harness, mode, and invocation context. Determine whether handoff is programmatic (Claude Code, Codex, Antigravity) or guidance-text (Cursor, Windsurf, chat).
2. **Step 1.** Resume protocol. Re-derive state from disk every turn. Never trust cached conversation memory.
3. **Step 2.** Confirm or capture the kickoff intent. One paragraph of orchestration metadata. Not a PRD.
4. **Step 3.** Invoke planning tier in dependency order: prd-ready, architecture-ready, roadmap-ready, stack-ready.
5. **Step 4.** Invoke building tier: repo-ready, then production-ready (sequential by default).
6. **Step 5.** Invoke shipping tier: deploy-ready, observe-ready, then launch-ready and harden-ready (parallel by default; critical-finding gate halts launch if harden-ready emits Critical).
7. **Step 6.** Final ledger. PROGRESS.md becomes the durable kickoff record. Hand off to a phase orchestrator if the user wants ongoing iteration.
8. **Step 7.** Refuse-and-surface for any out-of-scope request. Mid-arc, if the user asks kickoff-ready to do something a specialist owns, the response is refusal, named failure mode, route, resume.

See [`SKILL.md`](SKILL.md) for the full workflow with per-step acceptance gates.

## What this skill prevents

Mapped against named 2024-2026 AI-orchestration failure modes and research findings:

| Real failure mode or research finding | What this skill enforces |
|---|---|
| **AI agent fills the blank page with specialist content.** When asked to "kick off a project," the agent writes a PRD, an architecture, and a launch plan inline instead of invoking the specialists. ([Praetorian on deterministic orchestration](https://www.praetorian.com/blog/deterministic-ai-orchestration-a-platform-architecture-for-autonomous-development/)) | Step 7 refuse-and-route protocol. Eleven canonical refusals in [`references/scope-fence.md`](references/scope-fence.md). |
| **Cogent 2026 orchestration playbook on rubber-stamp risk.** "The orchestrator only checks whether an agent ran successfully rather than reading verification verdicts; it creates false confidence and reports success when it shouldn't have." ([Cogent](https://cogentinfo.com/resources/when-ai-agents-collide-multi-agent-orchestration-failure-playbook-for-2026)) | Step 3, 4, 5 verification gate: artifact exists AND non-empty. PROGRESS.md row only marks `done` after both checks pass. |
| **Anthropic claude-code resume failures #42338 / #42260 / #42309.** Cache invalidation; token overhead from opaque thinking signatures; undocumented resume cache behavior. ([anthropics/claude-code#42338](https://github.com/anthropics/claude-code/issues/42338); [#42260](https://github.com/anthropics/claude-code/issues/42260); [#42309](https://github.com/anthropics/claude-code/issues/42309)) | Step 1 resume protocol. Every turn re-reads PROGRESS.md and `ls`'s every claimed-complete sibling directory. Never trust cached conversation. |
| **NousResearch hermes-agent#17344.** Context compression on resume causes the model to re-execute the original first task. ([NousResearch/hermes-agent#17344](https://github.com/NousResearch/hermes-agent/issues/17344)) | Same defense; the disk-as-truth protocol does not relitigate completed steps because completion is verified on disk, not from compressed state. |
| **paperclipai#635.** Failed-run resume inherits stale state because the session ID was saved despite the run failing. ([paperclipai/paperclip#635](https://github.com/paperclipai/paperclip/issues/635)) | The `failed` status in PROGRESS.md handles this explicitly. A failed step is recorded as failed; the next session's resume protocol does not assume success. |
| **Galileo on multi-agent coordination failure.** Handoffs without verifiable pointers cause the recipient to "infer system state instead of querying it." ([Galileo](https://galileo.ai/blog/multi-agent-coordination-failure-mitigation)) | Pre-invocation upstream-artifact-exists check. The ghost-handoff guard in [`references/sequencing-rules.md`](references/sequencing-rules.md) per-sibling upstream contract. |
| **LangGraph supervisor pattern goal drift.** "Edge cases not covered; cyclic execution requires careful termination." ([DEV / focused.io](https://dev.to/focused_dot_io/multi-agent-orchestration-in-langgraph-supervisor-vs-swarm-tradeoffs-and-architecture-1b7e)) | Static error checks (Just-style, per [Just docs](https://just.systems/man/en/)). Pre-flight DAG integrity check. Mid-arc upstream verification. |
| **Yeoman scaffolding-tool gap.** Scaffolds optimize for "first ten minutes," not "first six weeks"; resume and skip semantics are afterthoughts. ([yeoman/yo#599](https://github.com/yeoman/yo/issues/599)) | Skip and import statuses in PROGRESS.md schema. Pre-existing artifact detection at Step 0. Yeoman conflict-resolution semantic for "user already has a PRD." |
| **GitHub Actions matrix-output limitation.** "If a job runs multiple times with strategy.matrix, only the latest iteration's output is available." ([community/community#26639](https://github.com/orgs/community/discussions/26639)) | PROGRESS.md records artifact paths, not artifact contents. Each sibling reads the upstream from disk. Pass artifacts, not outputs. |
| **Praetorian "monolithic agents."** 1,200+ line agent bodies suffering attention dilution and context starvation. ([Praetorian](https://www.praetorian.com/blog/deterministic-ai-orchestration-a-platform-architecture-for-autonomous-development/)) | kickoff-ready is small by construction. SKILL.md is shorter than every sibling. New features must be orchestration-tier metadata; specialist content is refused. |
| **Cybermaniacs rubber-stamp risk.** "Human oversight" becomes false confidence when the checklist is the artifact. ([Cybermaniacs](https://cybermaniacs.com/cm-blog/rubber-stamp-risk-why-human-oversight-can-become-false-confidence)) | Disk-as-truth principle. PROGRESS.md is a view, not a database. The Just / Make discipline applied to an AI orchestrator. |

## Reference library

Load each reference *when the workflow step says to*, not at session start. Full annotations in [`SKILL.md`](SKILL.md).

- [`RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md). The evidence base. 489 lines, 46 inline citations. Cited from this README's "What this skill prevents" table.
- [`sequencing-rules.md`](references/sequencing-rules.md). The DAG of sibling dependencies, parallelism rules, harden-ready critical-finding gate logic, skip-cascade rules, re-invocation discipline.
- [`handoff-protocols.md`](references/handoff-protocols.md). Per-harness Skill-tool invocation patterns. Guidance-text fallback for Cursor, Windsurf, chat-only frontends. The on-disk artifact-handoff baseline that works everywhere.
- [`progress-tracking.md`](references/progress-tracking.md). PROGRESS.md schema, status vocabulary (the seven statuses), resume protocol, skip-when-artifact-exists logic, audit-ledger view.
- [`scope-fence.md`](references/scope-fence.md). The boundary catalog. Eleven canonical refusals plus three invariants that keep kickoff-ready from becoming the god-skill the suite was decomposed to prevent.
- [`kickoff-antipatterns.md`](references/kickoff-antipatterns.md). Twelve named failure modes from the research pass with grep tests, kickoff-ready guards, and severity classifications.

## The skill's named failure modes

kickoff-ready adopts five primary refusals plus two secondary vocabulary tags. Each maps to a specific class of AI-orchestrator output the skill refuses.

- **Scope leak.** The orchestrator drifts into producing specialist content. Flagship refusal. Cited: Praetorian, AgentOrchestra, production-ready/ORCHESTRATORS.md.
- **Rubber-stamp orchestration.** PROGRESS.md advances without verification. Cited: Cogent 2026 playbook, Cybermaniacs, AWS / DEV multi-agent validation piece.
- **Phantom resume.** Resume that does not re-derive state from disk. Cited: six Anthropic / NousResearch / paperclipai issues directly.
- **Ghost handoff.** Sibling invoked before its upstream artifact exists. Cited: Galileo coordination failure analysis, arXiv 2509.18970.
- **Happy-path orchestration.** No policy for failure / skip / re-invoke / import. Cited: Wikipedia happy-path entry, LangGraph supervisor-vs-swarm tradeoffs.

Vocabulary used but not claimed: **state-vs-artifact drift** (the visible symptom of rubber-stamp orchestration), **god-skill** (the cautionary endpoint, not a refusal name), **ouroboros progress** (the secondary metaphor for state-vs-artifact drift).

See [`RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md) Section 2 for the full naming-lane survey, including failure-mode candidates rejected as redundant (god-skill, monolithic kickoff, compliance theater for orchestrators, CVE-of-the-week analog, checklist-driven amnesia).

## Pairing with phase orchestrators

kickoff-ready ends when the kickoff arc completes. Ongoing phase / milestone work is a different orchestration pattern. Composing options:

- **GSD** ([get-shit-done](https://github.com/aihxp/gsd) or equivalent). The phase / milestone orchestrator. kickoff-ready hands off PROGRESS.md; GSD picks up at the next phase. Per [production-ready/ORCHESTRATORS.md](https://github.com/aihxp/ready-suite/blob/main/skills/production-ready/ORCHESTRATORS.md).
- **BMAD** ([Breakthrough Method](https://github.com/bmad-code-org/BMAD-METHOD)). Persona-driven. Not recommended in the same project as kickoff-ready, since BMAD has its own kickoff path. If you want both, run kickoff-ready first, then transition cleanly per the BMAD-as-orchestrator pattern documented in production-ready/ORCHESTRATORS.md.
- **No phase orchestrator.** The user invokes individual siblings as needed (a roadmap revision, a hardening pass, a launch follow-up). PROGRESS.md remains the kickoff record but does not track ongoing work.

kickoff-ready is one-shot per project. The composition is one-way: kickoff-ready knows about the suite, hands off to phase orchestrators, and gets out of the way. Phase orchestrators do not call kickoff-ready back.

## Contributing

Gaps, missing cases, outdated guidance, new named failure modes, new harness landscapes, new orchestration anti-patterns: contributions welcome. Open an issue or PR. The harness landscape moves (new Skill-tool APIs, new programmatic-invocation forms); the suite is additive (the eleventh sibling will become the twelfth, eventually). Versioned accordingly.

## License

[MIT](LICENSE)

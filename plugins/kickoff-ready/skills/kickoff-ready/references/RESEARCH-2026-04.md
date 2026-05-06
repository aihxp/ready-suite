# kickoff-ready research report

Prepared: April 2026. This file is the evidence base for the kickoff-ready skill, the eleventh skill in the ready-suite and the first that lives in the meta-tier. It is not a neutral literature review. It is opinionated research, citation-heavy, biased toward primary sources, written so every have-not in SKILL.md traces back to a cited failure mode here.

kickoff-ready's job begins where raw user intent ends. When a user says "I have an idea, help me ship it end-to-end," ten specialist skills already exist in the ready-suite that can do the work: prd-ready, architecture-ready, roadmap-ready, stack-ready (planning); repo-ready, production-ready (building); deploy-ready, observe-ready, launch-ready, harden-ready (shipping). None of them know about the others. None of them know about each other's order. kickoff-ready is the only skill in the suite whose product is sequence and handoff metadata, not a specialist deliverable. Its scope fence is the most important thing about it. Every line of content kickoff-ready produces is orchestration metadata; not a PRD, not an architecture, not a launch plan.

The failure mode this skill exists to refuse, stated plainly: an agent that takes a one-paragraph project idea, claims to "kick off the project," and proceeds to write a PRD, a roadmap, and a launch plan inline (badly, all at once, with no scope fence) because the easiest thing for an LLM to do with a blank page is to fill the blank page. kickoff-ready refuses to fill the blank page. Its only outputs are: a sequence ledger (`.kickoff-ready/PROGRESS.md`), an invocation per specialist (via the harness's Skill tool, or guidance text where unavailable), and a verification gate after each specialist returns that confirms the sibling actually wrote its artifact to disk.

The report runs six sections in the order requested. Section 2 (named failure modes) is the longest because it carries the most load: every refusal in SKILL.md must trace back to a cited or invented-with-justification failure name here. Every cited URL was reachable as of May 2026. Paywalled sources are marked explicitly.

---

## Section 1: Framing

### 1.1 What kickoff-ready owns

Three deliverables, all metadata:

1. **Sequence decision.** Given the ten siblings and a project intent, kickoff-ready picks the order, picks which siblings to skip (e.g., harden-ready may be deferred for a one-day prototype), and picks which siblings can run in parallel (Section 5 walks the chain).
2. **Handoff invocation.** On harnesses with a programmatic Skill tool (Claude Code, Codex, Antigravity), kickoff-ready calls the Skill tool with the sibling's name and the project's running context. On harnesses without one (chat.openai.com, claude.ai, plain Cursor chat), kickoff-ready surfaces guidance text the user copies to the next session.
3. **Progress ledger.** A markdown file at `.kickoff-ready/PROGRESS.md` that records, per step: which sibling was invoked, when, with what input, what artifact path the sibling produced, and the verification result (artifact-exists check on disk). The ledger is the resume-point and the auditor view.

### 1.2 What kickoff-ready refuses

It does not write any content the specialists produce. Not a PRD. Not an architecture. Not a roadmap. Not a launch plan. Not a runbook. The temptation to "just sketch one" is the failure mode this skill is named to refuse. If the user asks kickoff-ready to write the PRD inline, the correct response is to invoke prd-ready (or surface the guidance to do so) and stop talking. Section 2 names this **scope leak** and recommends adopting it.

It does not own project-level state outside `.kickoff-ready/`. The siblings each manage their own `.{skill}-ready/` artifacts. kickoff-ready reads them (to verify they exist) but never writes inside them.

It does not assume one specific harness. The skill exposes the same shape to every harness it can run inside; the only difference is whether the handoff is a Skill-tool call or a printed instruction. Section 4 documents the harness landscape.

---

## Section 2: Named failure modes for AI multi-step orchestration

The ready-suite leans heavily on named failure modes. Each sibling skill earns its teeth by giving a sloppy pattern a specific name the agent can refuse. kickoff-ready inherits that convention. This section catalogs the candidate names, checks prior use, checks the SEO lane, and recommends adopt / use-as-vocabulary / rename.

### 2.1 "Rubber-stamp orchestration" (adopt with definition)

**Prior use.** "Rubber stamp" as a label for false oversight is well-established outside AI. Cybermaniacs published a 2024-2025 series titled "Rubber Stamp Risk: Why 'Human Oversight' Can Become False Confidence," framing it as the failure where checkbox approval substitutes for judgment ([Cybermaniacs](https://cybermaniacs.com/cm-blog/rubber-stamp-risk-why-human-oversight-can-become-false-confidence)). Cogent's "When AI Agents Collide: Multi-Agent Orchestration Failure Playbook for 2026" describes the agent-side analog: an orchestrator that "only checks whether an agent ran successfully (rather than reading verification verdicts)" and as a result "creates false confidence, with the orchestrator reporting success and closing issues when it shouldn't have" ([Cogent](https://cogentinfo.com/resources/when-ai-agents-collide-multi-agent-orchestration-failure-playbook-for-2026)). The DEV Community piece "How to Stop AI Agents from Hallucinating Silently with Multi-Agent Validation" is blunt: "AI agents fail silently; they confirm operations that never completed, return success when tools returned errors, and fabricate responses with full confidence" ([DEV / AWS](https://dev.to/aws/how-to-stop-ai-agents-from-hallucinating-silently-with-multi-agent-validation-3f7e)).

**SEO lane.** "Rubber-stamp orchestration" returns no definitional pages in May 2026. The hyphenated form "rubber-stamp" plus "AI orchestration" is open. The general phrase "rubber stamp" is dominated by office-supply listings and political reporting; the AI-specific compound is unclaimed.

**Recommendation.** Adopt with a hyphenated, definitional form. Working definition: "the orchestrator advances PROGRESS.md to 'done' for a step without verifying the specialist actually produced its declared artifact on disk." The grep test: for each sibling kickoff-ready invokes, the verification gate is a two-line check: (a) does `.{skill}-ready/<expected-artifact>.md` exist, (b) is its size non-trivial (not the empty template). If either check fails, the step is not done; PROGRESS.md does not advance. This is the kickoff-ready analog of harden-ready's "shallow-audit trap": both name the failure where a pass-marker is granted without contact with reality.

### 2.2 "Ouroboros progress" (use the vocabulary, do not claim)

**Prior use.** The pattern of "state file says done, disk says nothing happened" is well-described but not under that exact name. Galileo's "Multi-Agent AI Gone Wrong" piece names the underlying mechanism: "many multi-agent frameworks lack robust mechanisms for maintaining shared context across agents, creating situations where each agent operates with a different understanding of the current state. Failures in one agent can silently corrupt the state of others, leading to subtle hallucinations rather than obvious failures" ([Galileo](https://galileo.ai/blog/multi-agent-coordination-failure-mitigation)). The Cleanlab and Maxim-AI hallucination-detection literature names the behavior of "agents asked to infer system state instead of querying it" as a known production failure mode ([Cleanlab](https://cleanlab.ai/blog/prevent-hallucinated-responses/); [Maxim AI](https://www.getmaxim.ai/articles/top-5-tools-to-monitor-and-detect-hallucinations-in-ai-agents/)). The arxiv survey "LLM-based Agents Suffer from Hallucinations" formalizes the taxonomy ([arXiv 2509.18970](https://arxiv.org/html/2509.18970v1)).

GSD's own discipline (visible in its `gsd-validate-phase`, `gsd-audit-milestone`, and the explicit `state-vs-artifact` check) treats this as a first-class concern. The fix it converges on is the same one kickoff-ready will adopt: never trust the tracker; always re-derive completion from disk.

**SEO lane.** "Ouroboros progress" is unclaimed but also unfamiliar. The metaphor (snake eating its tail) suggests "the tracker reads from itself, never from disk" which is exactly the failure. The risk is that the metaphor is too cute to land in a single read.

**Recommendation.** Use as **secondary vocabulary, do not claim as the flagship name**. Prefer the bluntly-descriptive **"state-vs-artifact drift"** as the primary term in SKILL.md, and reach for "ouroboros progress" once when introducing the section. The flagship name should pair with rubber-stamp orchestration (the cause) and state-vs-artifact drift (the visible symptom). Definition: "PROGRESS.md says step N is done; `.{skill-N}-ready/` either does not exist on disk, exists empty, or contains only the unmodified template scaffold."

### 2.3 "Phantom resume" (adopt with caution; cite Anthropic issues directly)

**Prior use.** "Phantom resume" as an exact phrase is unclaimed. The underlying failure modes are named and well-documented in the Claude Code issue tracker:

- **Cache invalidation on resume.** Issue #42338, "Session resume (--continue) invalidates entire prompt cache, causes massive rate limit consumption" ([anthropics/claude-code#42338](https://github.com/anthropics/claude-code/issues/42338)). Resume drops `cache_read` to zero and re-caches the entire prompt from scratch. The `deferred_tools_delta` reordering since v2.1.69 is the cited reason: it changes the prefix bytes, breaking the cache prefix match.
- **Context-compression confusion on resume.** NousResearch hermes-agent issue #17344, "Context compression + session resume causes model to re-execute the original first task instead of continuing from compressed state" ([NousResearch/hermes-agent#17344](https://github.com/NousResearch/hermes-agent/issues/17344)). The compressed summary is ignored; the model relitigates step one.
- **Stale-state inheritance on failed-run resume.** paperclipai issue #635, "agent resumes stale Claude session after failed run, carries incorrect state" ([paperclipai/paperclip#635](https://github.com/paperclipai/paperclip/issues/635)). When a run fails (rate limit, process_lost, encoding error), the session ID is saved anyway; the next `--resume` inherits the broken state.
- **Stale tool results.** Documented in Anthropic's own issue tracker and in the Medium / rigel-computer.com post "Claude Code: Resume Sessions Without Context Loss" ([Medium / rigel-computer.com](https://medium.com/rigel-computer-com/you-close-claude-code-the-context-is-gone-or-is-it-3ebc5c1c379d)). Old `git log` or `npm test` outputs from a previous session are still in context after resume; the model decides based on yesterday's reality.
- **Token overhead on long-session resume.** Issue #42260, "Resume of long sessions loads disproportionate tokens from opaque thinking signatures" ([anthropics/claude-code#42260](https://github.com/anthropics/claude-code/issues/42260)). Prior thinking-block signatures replay as input tokens, making resume "impractical for exactly the kind of long sessions where it is most valuable."
- **Undocumented resume behavior.** Issue #42309, "[DOCS] --resume prompt cache behavior with deferred tools, MCP servers, and custom agents is undocumented" ([anthropics/claude-code#42309](https://github.com/anthropics/claude-code/issues/42309)).

A separate but related class of failure: bug(research) issue #812 in danielmiessler's Personal_AI_Infrastructure: "Stale references, orphaned agent, and phantom file paths in Research skill" ([Personal_AI_Infrastructure#812](https://github.com/danielmiessler/Personal_AI_Infrastructure/issues/812)). This is exactly the shape kickoff-ready risks: a resumed session refers to artifacts at paths that do not exist on the resumed disk.

**SEO lane.** "Phantom resume" returns nothing definitional in May 2026.

**Recommendation.** Adopt. Definition: "kickoff-ready claims to resume from `.kickoff-ready/PROGRESS.md` step N, but starts fresh because (a) the prompt cache was invalidated and the agent did not re-read PROGRESS.md, (b) the agent re-ran step 1 because of compression-summary loss, or (c) the agent inherited stale tool-result state from a previous session and made decisions on yesterday's truth." The kickoff-ready guard: every resume must begin with a literal `Read .kickoff-ready/PROGRESS.md`, an `ls .{skill}-ready/` per claimed-complete sibling, and a re-derivation of the current step from disk before any further work. Never trust the cached conversation about resume state.

### 2.4 "Scope leak" (adopt; cite production-ready ORCHESTRATORS.md)

**Prior use.** "Scope leak" is in general software-engineering vocabulary as a synonym for scope creep; the agent-orchestration specialization is unclaimed. The closest named precedents:

- Praetorian's "Deterministic AI Orchestration" piece states the principle: "the orchestrator shouldn't implement or fix things silently; the moment it starts 'helping,' you're back in a world where one agent is planning, executing, and judging its own work, which is exactly where drift loves to hide" ([Praetorian](https://www.praetorian.com/blog/deterministic-ai-orchestration-a-platform-architecture-for-autonomous-development/)).
- The "AgentOrchestra" piece (DEV Community) describes the inverse failure: "supervisors do not generate final answers themselves, which prevents a common failure mode where supervisors become silent co-authors of the output" ([DEV / naresh_007](https://dev.to/naresh_007/agentorchestra-explained-a-mental-model-for-hierarchical-multi-agent-systems-43af)).
- Praetorian's "Monolithic Agents" critique describes the visible symptom: "1,200+ line agent bodies that suffered from Attention Dilution (ignoring instructions late in the prompt) and Context Starvation (insufficient space for code analysis)" ([Praetorian](https://www.praetorian.com/blog/deterministic-ai-orchestration-a-platform-architecture-for-autonomous-development/)).
- Ronie Uliana's "Orchestrator Pattern" Medium piece names the specialist-versus-generalist trap: "if a specialist agent exists, use it not because it is more 'clever,' but because specialists are simply better at the task they were designed for than a generic subagent" ([Medium / Ronie Uliana](https://ronie.medium.com/the-orchestrator-pattern-managing-ai-work-at-scale-a0f798d7d0fb)).

The ready-suite's own ORCHESTRATORS.md (in production-ready, lines 9-13) names the four invariants kickoff-ready must obey: "the harness is the router. No ready-suite skill calls another. The harness or the orchestrator chooses which skill fires when. Artifacts are the contract. Skills do not pass arguments; they read and write files at known paths." That document already documents the principle that scope-leak violates.

**SEO lane.** "Scope leak" returns mostly software-engineering glossary entries and Reddit threads; the agent-specific definition is open.

**Recommendation.** Adopt as the flagship refusal name. Definition: "the orchestrator drifts into producing the specialist's content rather than invoking the specialist. kickoff-ready writes a PRD inline instead of calling prd-ready; writes a launch checklist inline instead of calling launch-ready; produces 'a sketch of the architecture' instead of invoking architecture-ready." The grep test for SKILL.md: any kickoff-ready output that is not (a) sequence metadata, (b) a Skill-tool invocation, (c) PROGRESS.md update, or (d) a one-paragraph guidance string for harnesses without Skill-tool support, is a scope-leak violation. Pairs with ORCHESTRATORS.md invariant 1 ("the harness is the router; no ready-suite skill calls another"). When kickoff-ready is the orchestrator, the principle becomes: kickoff-ready calls siblings; it does not impersonate them.

### 2.5 "God-skill" (use as vocabulary, do not claim; reject for kickoff-ready's name)

**Prior use.** "God object" is a 30-year-old OO anti-pattern. "God skill" is the natural translation but is not consistently claimed in 2026. The Praetorian "Monolithic Agents" critique is the closest: agents whose body-size grew until the prompt itself caused attention dilution and context starvation ([Praetorian](https://www.praetorian.com/blog/deterministic-ai-orchestration-a-platform-architecture-for-autonomous-development/)). The phrase "god skill" appears in Antigravity / Claude Code skill-design conversations on DEV Community and in the Medium "Antigravity Skills" series ([Medium / Shir Meir Lador](https://medium.com/google-cloud/my-first-experience-creating-antigravity-skills-7154031fe115)) but is used loosely.

**Recommendation.** Use the term as vocabulary in passing, do not name a kickoff-ready failure mode after it. The reason: the god-skill anti-pattern is what kickoff-ready could become if scope-leak is not refused. It is the worst-case symptom, not the named refusal. Prefer "scope leak" as the refusal trigger; use "god skill" only as the cautionary endpoint.

### 2.6 "Happy-path orchestrator" (adopt as secondary)

**Prior use.** "Happy path" is established UX/QA vocabulary; the orchestration-specific compound is open. Wikipedia's "Happy path" entry frames it precisely: "a default scenario featuring no exceptional or error conditions" ([Wikipedia](https://en.wikipedia.org/wiki/Happy_path)). The Synthesized post on balancing happy-path and negative testing describes the failure shape: a flow that works perfectly under ideal conditions and falls apart on the first deviation ([Synthesized](https://www.synthesized.io/post/balancing-happy-path-negative-testing)). For agents specifically, the "Multi-Agent Orchestration in LangGraph: Supervisor vs Swarm" piece names the failure mode: "graph complexity grows fast; edge cases not covered; cyclic execution requires careful termination" ([DEV / focused.io](https://dev.to/focused_dot_io/multi-agent-orchestration-in-langgraph-supervisor-vs-swarm-tradeoffs-and-architecture-1b7e)).

**SEO lane.** "Happy-path orchestrator" is unclaimed.

**Recommendation.** Adopt as a secondary refusal name, subordinate to scope leak. Definition: "kickoff-ready handles the case where every sibling succeeds and writes its artifact, but has no policy for: (a) sibling X failed, (b) sibling X claimed success but artifact is missing, (c) the user wants to skip sibling X entirely, (d) the user already has a PRD from before kickoff-ready started and wants to import it instead of running prd-ready, (e) the user wants to re-run sibling X because the input changed." A happy-path orchestrator is an orchestrator that ships only the success branch and crashes on every branch reality offers.

### 2.7 "Ghost handoff" (adopt as specialty term)

**Prior use.** Not claimed. The Galileo "Multi-Agent AI Gone Wrong" piece describes the underlying mechanism: when one agent hands work to another and the recipient does not know "the handoff happened," because the orchestrator's reference to upstream state did not include a verifiable pointer to the upstream artifact ([Galileo](https://galileo.ai/blog/multi-agent-coordination-failure-mitigation)). The arxiv survey on LLM-agent hallucinations frames the same pattern as "agents asked to infer system state instead of querying it" ([arXiv 2509.18970](https://arxiv.org/html/2509.18970v1)). The agent-sh observability work (MLflow's multi-agent observability series) documents what good handoffs look like: every sub-agent invocation carries an explicit pointer to upstream artifacts; the supervisor never "implies" upstream context ([MLflow blog](https://mlflow.org/blog/observability-multi-agent-part-1)).

**SEO lane.** "Ghost handoff" is open. The metaphor is sharp: a handoff that "looks like" it happened but did not.

**Recommendation.** Adopt as the name for the specific failure where kickoff-ready invokes a sibling without first verifying the upstream artifact exists. Definition: "kickoff-ready invokes architecture-ready before prd-ready has produced `.prd-ready/PRD.md`. The architect agent runs anyway, hallucinates a PRD-equivalent from the user's one-paragraph idea, and the downstream chain proceeds on a fictional foundation." The kickoff-ready guard: every sibling invocation is preceded by an upstream-artifact-exists check derived from the sibling's documented upstream consumes (Section 5 walks the chain). If upstream is missing, the handoff is refused; PROGRESS.md is rolled back; the prior step is re-invoked.

### 2.8 "Compliance theater for orchestrators" (reject as name; cite the parallel)

**Prior use.** "Compliance theater" is owned by Kelly Shortridge and Anton Chuvakin and used in harden-ready's research. Bruce Schneier's "security theater" is the prior origin ([Schneier on Security](https://www.schneier.com/tag/security-theater/)). The orchestration-specific compound "compliance theater for orchestrators" is unclaimed but adds nothing the existing harden-ready vocabulary does not already carry.

**Recommendation.** Reject as a kickoff-ready coinage. The orchestration-flavored failure (PROGRESS.md is green, no specialist artifacts on disk) is already covered by rubber-stamp orchestration plus state-vs-artifact drift. Adding "compliance theater for orchestrators" as a third name dilutes the vocabulary. Cite Shortridge and harden-ready in passing, do not adopt a sibling term.

### 2.9 "Monolithic kickoff" (reject; subsumed by scope leak)

**Prior use.** Not claimed. Praetorian's "Monolithic Agents" frames the underlying problem ([Praetorian](https://www.praetorian.com/blog/deterministic-ai-orchestration-a-platform-architecture-for-autonomous-development/)).

**Recommendation.** Reject as a kickoff-ready coinage. The failure mode it would name (a single 1,200-line skill that tries to be PRD plus architecture plus roadmap plus everything) is what the ten siblings exist precisely to prevent. Scope leak names the dynamic version; "monolithic kickoff" would name the static one, but kickoff-ready is small by construction (it does not grow, because it does not produce specialist content). Listing it as a refusal is unnecessary.

### 2.10 "Checklist-driven amnesia" (adopt with caution)

**Prior use.** Not a definitional term in the literature. "Checklist-based testing" is established QA vocabulary (see Testsigma's overview, [Testsigma](https://testsigma.com/blog/checklist-based-testing/)) and is positively framed. The negative version, where the checklist becomes the work product instead of a guide, is described in the Empowered Humans piece "Checklist Automation": "full automation is not always possible; manual input and judgment is still required, such as when a check has failed and further inspection may be required to get evidence for a green light" ([Empowered Humans](https://www.empoweredhumans.net/post/checklist-automation)).

The Mario Hayashi piece "The Factory Must Grow (Part III): Stopping the AI Agent Production Line Toyota-style" treats the agent-checklist anti-pattern explicitly: when an agent line marks every step "done" without producing the verifiable evidence, the line keeps moving and the defects pile up downstream ([Mario Hayashi blog](https://blog.mariohayashi.com/p/the-factory-must-grow-part-iii-stopping)).

**SEO lane.** "Checklist-driven amnesia" is open and unfamiliar. "Checklist amnesia" alone is also unclaimed.

**Recommendation.** Adopt with caution as a tertiary name, primarily as a vocabulary tag in the SKILL.md framing rather than a flagship refusal. Definition: "the orchestrator's checklist (PROGRESS.md) becomes the artifact; the actual specialist artifacts on disk are forgotten." This is rubber-stamp orchestration's organizational analog. Use it once in the skill body; do not use it as a primary refusal name. The flagship pair is **scope leak** (the orchestrator does the wrong job) plus **rubber-stamp orchestration** (the orchestrator skips verification of the right job).

### 2.11 "CVE-of-the-week" analog: "skill-of-the-week kickoff" (reject)

**Prior use.** harden-ready's "CVE-of-the-week" names reactive patching of named CVEs without investing in the class. The orchestration analog would be: kickoff-ready picks the order based on the sibling that was most-recently mentioned in the user's prompt rather than the dependency graph. This is unclaimed and unnecessary as a name; the failure mode is just "ignoring the dependency graph," which is a special case of happy-path orchestration.

**Recommendation.** Reject as a coinage. Mention only if a reader asks how kickoff-ready interacts with harden-ready's vocabulary.

### 2.12 Failure modes named in the canonical writers

Reviewed: Galileo's multi-agent observability blog, Cogent's orchestration-failure playbook, Praetorian's deterministic-orchestration paper, the LangGraph supervisor-versus-swarm DEV piece, MLflow's multi-agent observability series, Cleanlab's hallucination-prevention writeup, the arxiv LLM-agent hallucination survey, ARMOSec's threat-detection writeup on LangChain/CrewAI/AutoGPT, the Maxim AI top-5 hallucination-monitoring tools post, agent-sh's open-source agentsys distribution.

Named patterns worth citing or carrying forward:

- **Goal drift without supervisor anchor** (LangGraph supervisor pattern, [DEV / focused.io](https://dev.to/focused_dot_io/multi-agent-orchestration-in-langgraph-supervisor-vs-swarm-tradeoffs-and-architecture-1b7e)). The supervisor's anchor for kickoff-ready is the dependency graph plus the per-sibling consumes list. Cite in framing.
- **Coordination deadlocks** (same source). The kickoff-ready analog is a circular handoff (sibling A waits for sibling B's artifact while B waits for A's). Avoidable by enforcing the pre-checked DAG in Section 5; not a named failure mode for the SKILL.md have-nots.
- **Split-brain state from concurrent writes** ([armosec](https://www.armosec.io/blog/threat-detection-multi-agent-orchestration/)). kickoff-ready avoids this by being single-threaded by construction; concurrent siblings only run when artifact paths do not collide. Cite in Section 5 parallelism discussion.
- **Silent timeout on tool calls** (also Galileo). The orchestrator waits for a specialist whose tool silently timed out. The kickoff-ready guard is the verification gate: a step is not done because the sibling returned, only because the artifact appeared. This is rubber-stamp orchestration's mitigation.
- **Tool proliferation / context starvation** (Praetorian). Not relevant to kickoff-ready directly; relevant to the siblings, which is why they are separated.
- **Cascading errors through specialist boundaries** ([arXiv 2605.02801](https://arxiv.org/html/2605.02801)). When sibling A produces a wrong-but-plausible artifact, sibling B consumes it and compounds the error. kickoff-ready cannot detect semantic wrongness; it can only detect existence. This is a known limit; the SKILL.md should state it (kickoff-ready verifies that artifacts exist, not that they are correct; correctness is the sibling's own have-nots discipline).

### 2.13 Recommended set for SKILL.md have-nots

The flagship four to adopt as named refusals:

1. **Scope leak** (primary). kickoff-ready writes specialist content instead of invoking specialists.
2. **Rubber-stamp orchestration** (primary). PROGRESS.md advances without the verification gate.
3. **Phantom resume** (primary). Resume that does not re-derive state from disk.
4. **Ghost handoff** (primary). Sibling invoked without verifying upstream artifact.

The supporting two as secondary vocabulary:

5. **Happy-path orchestrator** (secondary). No policy for failure, skip, re-run, import-from-existing.
6. **State-vs-artifact drift** / **ouroboros progress** (secondary). The visible symptom of rubber-stamp orchestration; useful as a grep target during verification.

Cited but not adopted as names: god-skill (cautionary endpoint), monolithic kickoff (subsumed), compliance theater for orchestrators (subsumed), CVE-of-the-week analog (subsumed), checklist-driven amnesia (vocabulary only).

---

## Section 3: Prior art for command-driven kickoff orchestration

### 3.1 GSD (get-shit-done) and `/gsd-new-project`

Note on availability: the user's local copy at `/Users/hprincivil/Projects/gsd/` was empty at the time of this research. The analysis below is drawn from the GSD skill set installed in this environment (`gsd-new-project`, `gsd-new-milestone`, `gsd-plan-phase`, `gsd-execute-phase`, `gsd-resume-work`, `gsd-validate-phase`, `gsd-audit-milestone`, `gsd-forensics`, plus thirty-plus siblings) and from production-ready's ORCHESTRATORS.md, which documents the GSD-as-orchestrator integration explicitly.

**How it sequences work.** GSD is project-and-phase-and-milestone-shaped, not skill-shaped. `/gsd-new-project` performs deep context gathering and writes a `PROJECT.md`; `/gsd-new-milestone` opens a milestone cycle and routes to requirements; `/gsd-discuss-phase` gathers phase context through adaptive questioning; `/gsd-plan-phase` produces a `PLAN.md` with verification loop; `/gsd-execute-phase` runs the plan with wave-based parallelization; `/gsd-validate-phase` retroactively audits Nyquist validation gaps; `/gsd-audit-milestone` checks completion against original intent before archiving. The sequence is enforced by a state machine inside `.planning/`, not by the skill's self-description.

**How it handles handoffs.** GSD's handoff is "the next command on the same project state." There is no inter-skill API; the next skill reads the project state. Production-ready's ORCHESTRATORS.md documents the optional ready-suite invocation: GSD can call `prd-ready`, `architecture-ready`, `roadmap-ready`, `stack-ready` from within `/gsd-new-project` ([production-ready/ORCHESTRATORS.md, lines 17-29](file:///Users/hprincivil/Projects/production-ready/ORCHESTRATORS.md)). The integration cost is "entirely in GSD: each command's prompt gets a few additional lines describing when to invoke which sibling skill. Ready-suite is consumed, not modified."

**How it tracks progress.** Through `.planning/` files (PROJECT.md, ROADMAP.md, per-phase manifests). `/gsd-progress` shows current state and routes to next action. `/gsd-stats` displays project statistics. `/gsd-health` diagnoses planning-directory health. `/gsd-forensics` is post-mortem investigation for failed workflows.

**What it does on resume.** `/gsd-resume-work` reads the last session and reconstructs context. The discipline is: never trust the conversation; re-read the manifest from disk. This is the same posture kickoff-ready needs.

**Trade-offs.** GSD is project-shaped, not idea-shaped. The user runs `/gsd-new-project` after they already have a sense of the project; GSD is not designed to take "I have an idea" raw and route through ten specialists. GSD sits one level deeper than kickoff-ready; the natural composition (stated in production-ready's ORCHESTRATORS.md) is: kickoff-ready owns the first invocation when the user has only an idea; once the planning-tier siblings have produced PRD / ARCH / ROADMAP, GSD takes over for the iterative phase-and-milestone work.

**Lesson for kickoff-ready.** The state-on-disk discipline is correct. Re-derive completion from disk every turn. Do not run a phase based on a conversation memory of "we already did that." The shape of `.kickoff-ready/PROGRESS.md` should mirror `.planning/PROJECT.md`'s philosophy: a small canonical record that the next command rebuilds from.

### 3.2 BMAD (Breakthrough Method for Agile AI-Driven Development)

**How it sequences work.** BMAD is persona-shaped. Each step is assigned to a specific AI persona: Analyst, PM, Architect, Developer, UX, Scrum Master, QA, Technical Writer, plus more ([Medium / Vishal Mysore](https://medium.com/@visrow/what-is-bmad-method-a-simple-guide-to-the-future-of-ai-driven-development-412274f91419); [BMAD-METHOD GitHub](https://github.com/bmad-code-org/BMAD-METHOD)). The greenfield flow is documented as: analyst creates a project brief, PM consumes the brief and produces a PRD, architect consumes the PRD and designs the system architecture ([Medium / Vishal Mysore on Greenfield](https://medium.com/@visrow/greenfield-vs-brownfield-in-bmad-method-step-by-step-guide-89521351d81b)). Each handoff is encoded in a YAML workflow file that names the step, the persona, the input artifacts, and the output artifacts.

**How it handles handoffs.** Through declared dependencies in the YAML workflow. The workflow is the contract: "PM agent takes the brief as a dependency to create a PRD" is a literal YAML clause, not a convention. This is closer to a Make-style target graph than to a conversational handoff.

**How it tracks progress.** Through the artifacts named in each step. The completion check is "did the PRD file get created in the expected location," which is the same posture kickoff-ready needs.

**What it does on resume.** BMAD relies on the workflow YAML being the source of truth; resume re-reads the YAML and the artifacts on disk. There is no separate progress ledger.

**Trade-offs and where it differs from ready-suite.** Ready-suite is harness-routed (the harness's skill-trigger picks the next skill); BMAD is workflow-routed (the YAML picks the next persona). They compose at boundaries, not within a single feature. Production-ready's ORCHESTRATORS.md is explicit on this: "Mixing BMAD personas with ready-suite skills inside the same session creates a fragmented workflow. The persona-driven model (BMAD) and the harness-routed model (ready-suite) can compose at boundaries but should not compose within a single feature build" ([production-ready/ORCHESTRATORS.md](file:///Users/hprincivil/Projects/production-ready/ORCHESTRATORS.md)).

The two valid integrations are: (a) BMAD owns planning, ready-suite owns building and shipping, with a one-time path translation at the boundary; or (b) BMAD off for ready-suite projects.

**Lesson for kickoff-ready.** BMAD is the closest prior art. The ten ready-suite siblings map cleanly to BMAD's personas (prd-ready ~ PM, architecture-ready ~ Architect, production-ready ~ Developer, etc.). The major BMAD lesson: declare the dependency graph as data, not as prose. kickoff-ready's PROGRESS.md should encode dependencies declaratively (Section 5 walks the graph kickoff-ready will use).

### 3.3 Shape Up (Basecamp): pitches as kickoff orchestration

**How it sequences work.** Shape Up's six-week cycle and betting table are the kickoff layer. A pitch contains five ingredients: problem, appetite, solution, rabbit holes, no-gos ([Basecamp Shape Up: Write the Pitch](https://basecamp.com/shapeup/1.5-chapter-06)). The betting table picks which pitches enter the next cycle ([Basecamp Shape Up: Bets, Not Backlogs](https://basecamp.com/shapeup/2.1-chapter-07); [Basecamp Shape Up: The Betting Table](https://basecamp.com/shapeup/2.2-chapter-08); [Basecamp Shape Up: Place Your Bets](https://basecamp.com/shapeup/2.3-chapter-09)). The kickoff is "describing to the rest of the company the projects that were chosen, who is planning on working on them, and how much time we are going to give them" ([Basecamp Shape Up: How to Begin](https://basecamp.com/shapeup/4.2-appendix-03)).

**How it handles handoffs.** Shape Up's handoff is between the shaping team (which writes the pitch and bounds the appetite) and the building team (which runs the six-week cycle). The pitch is the handoff artifact. Inside the cycle, Shape Up explicitly avoids prescriptive sequencing; the building team owns its own work breakdown.

**How it tracks progress.** Hill charts and scope mapping during the cycle, not a sequential progress ledger.

**What it does on resume.** Cycles are atomic; resume is "open the hill chart and the scope map." Shape Up does not have a resume mechanic at the kickoff layer; the kickoff is a one-time meeting whose output is the kickoff document.

**Trade-offs.** Shape Up is opinionated about appetite (time as the constraint, not scope), which is the right discipline for the building tier (roadmap-ready inherits Shape Up vocabulary in its frontmatter). For the kickoff layer, Shape Up's key lesson is the no-gos field: the pitch lists what is explicitly out. kickoff-ready should mirror this. PROGRESS.md should record skipped siblings (not silently absent ones) so the next read knows the user opted out, not that the orchestrator forgot.

**Lesson for kickoff-ready.** The kickoff document model is the right shape: a small artifact that names what is in, what is out, who runs which step, and the appetite (time budget). PROGRESS.md is the kickoff document plus the running ledger.

### 3.4 Just (justfile) and Make: target-graph orchestration

**How they sequence work.** Both encode dependencies as a target graph. Just's documentation states the discipline plainly: "errors are resolved statically, with unknown recipes and circular dependencies reported before anything runs" ([just.systems manual](https://just.systems/man/en/); [casey/just GitHub](https://github.com/casey/just)). Just additionally enforces idempotency: "in a given invocation of just, a recipe with the same arguments will only run once, regardless of how many times it appears in the command-line invocation or how many times it appears as a dependency" ([just.systems Dependencies page](https://just.systems/man/en/dependencies.html)).

**How they handle handoffs.** File timestamps (Make) or explicit recipe order (Just). Both treat the file system as the truth: a target is "done" if its output file exists and is newer than its inputs. This is exactly the discipline kickoff-ready needs.

**How they track progress.** Implicitly, through the file system. There is no separate progress ledger; the artifacts on disk are the ledger. This is the strongest argument that kickoff-ready's PROGRESS.md should be a redundant view, not the source of truth. The source of truth is the union of the ten `.{skill}-ready/` directories; PROGRESS.md is a denormalized read-cache for the auditor.

**What they do on resume / re-run.** Re-run is idempotent: if the artifact exists and inputs have not changed, the recipe is skipped. If inputs have changed (file mtime is newer than artifact mtime), the recipe re-runs.

**Trade-offs.** Just is dependency-graph-pure but does not handle "I want to re-run this with a different conversational input" without recipe-level parameterization. Make has the same shape with worse ergonomics ("make idiosyncrasies include the difference between = and := in assignments, confusing error messages, needing $$ to use environment variables in recipes" ([just.systems README](https://github.com/casey/just))).

**Lesson for kickoff-ready.** Two lessons. First, errors are resolved statically: kickoff-ready should refuse to start the run if the sibling DAG is misconfigured (e.g., circular reference, sibling listed but not installed). Second, the file system is the truth: PROGRESS.md is a view, not a database. If PROGRESS.md and the file system disagree, the file system wins and PROGRESS.md is rebuilt from it.

### 3.5 Yeoman, create-* generators, npm init, cargo new, rails new

**How they sequence work.** Through generator scripts that prompt for inputs, copy templates, transform them, install dependencies, and initialize git ([DEV / chengyixu](https://dev.to/chengyixu/build-a-project-scaffolding-cli-like-create-next-app-3agn)). The pattern is fixed: prompt, copy, transform, install, init.

**How they handle handoffs.** They do not. Each generator is one-shot. There is no concept of "next step" beyond the README the generator drops in.

**How they track progress.** They do not. The generated project is the artifact; no progress ledger.

**What they do on resume.** Yeoman is the most interesting case. Yeoman explicitly supports re-running on existing projects via the file-conflict resolution loop: "every write happening on a pre-existing file will go through a conflict resolution process; this process requires that the user validate every file write that overwrites content" ([yeoman.io File System docs](https://yeoman.io/authoring/file-system.html)). The known gap: non-interactive mode has only `--force` (overwrite everything) or no flag (prompt-and-stop), with no `--skip-existing` middle ground. This was filed as yo issue #599: "Add command line option to skip existing files" ([yeoman/yo#599](https://github.com/yeoman/yo/issues/599)).

The `npm init <initializer>` pattern, `create-next-app`, `cargo new`, `rails new` follow the same shape ([create-next-app on npm](https://www.npmjs.com/package/create-next-app); [Rails Getting Started](https://guides.rubyonrails.org/v3.2/getting_started.html)). All are one-shot; the resume story is "git init was already run and you cannot easily re-run."

**Trade-offs.** The scaffolding tradition optimizes for "first ten minutes" not "first six weeks." Resume and skip semantics are an afterthought.

**Lesson for kickoff-ready.** The scaffolding tradition's gap is exactly what kickoff-ready needs to fix. kickoff-ready is multi-step (eleven invocations, not one), idempotent (re-running a step that already produced its artifact is a skip, not an overwrite), and resumable (PROGRESS.md plus on-disk artifacts let the next session pick up). The Yeoman conflict-resolution loop is the right semantic for "user already has a PRD before kickoff-ready starts": ask before overwriting, never silently clobber.

### 3.6 GitHub Actions reusable workflows and matrix jobs

**How they sequence work.** Through `needs:` declarations between jobs. A reusable workflow is invoked via `uses:` from a calling workflow ([GitHub Docs: Reuse workflows](https://docs.github.com/en/actions/how-tos/reuse-automations/reuse-workflows)). Matrix jobs run multiple variants in parallel.

**How they handle handoffs.** Two ways: outputs (small string values) and artifacts (files uploaded between jobs via `actions/upload-artifact` and `actions/download-artifact`). Outputs are useful for "what version did the build job produce" ([CICube: GitHub Actions Outputs](https://cicube.io/blog/github-actions-outputs/)). Artifacts are useful for "what files did the build job produce" and are necessary "to share something other than a variable (such as a build artifact) between workflows" ([GitHub skills/reusable-workflows tutorial](https://github.com/skills/reusable-workflows)).

**Known limitation in matrix jobs.** "If a job runs multiple times with strategy.matrix, only the latest iteration's output is available for reference in other jobs" ([community discussion #26639](https://github.com/orgs/community/discussions/26639)). The workaround is: pass outputs via artifacts. This is a strong argument that artifact-passing-as-files is more reliable than reference-by-output. Reusable-workflow output behavior with matrices has additional surprises ([actions/runner#2475](https://github.com/actions/runner/issues/2475)).

**How they track progress.** The workflow run UI is the ledger. There is no separate progress file.

**What they do on resume.** Re-run-failed-jobs. Jobs that succeeded retain their outputs and artifacts; only failed jobs and their downstreams re-run. This is the discipline kickoff-ready needs: a verified successful step is not re-run on resume; only failed and not-yet-run steps execute.

**Trade-offs.** The matrix output limitation is a real thorn for orchestrators. Reusable workflow scope rules ("re-using outputs between matrix legs is brittle") translate directly to a kickoff-ready warning: do not encode results as small strings in PROGRESS.md; encode them as artifact paths and read the artifacts.

**Lesson for kickoff-ready.** Pass artifacts, not outputs. PROGRESS.md should record "sibling X produced `.X-ready/X.md` at timestamp T, verified at timestamp U"; it should not embed the contents of `.X-ready/X.md` inline. The next sibling reads the file from disk; PROGRESS.md only points.

### 3.7 LangGraph supervisor pattern, AutoGen, CrewAI

**How they sequence work.** LangGraph encodes work as a graph with explicit nodes and edges; AutoGen as message-passing between agents; CrewAI as tasks assigned to roles ([CrewAI GitHub](https://github.com/crewaiinc/crewai); [LangGraph supervisor reference](https://reference.langchain.com/python/langgraph-supervisor); [DataCamp: CrewAI vs LangGraph vs AutoGen](https://www.datacamp.com/tutorial/crewai-vs-langgraph-vs-autogen)). The supervisor pattern in LangGraph names a single node as the orchestrator; the supervisor decides which worker to invoke next based on the current state.

**How they handle handoffs.** LangGraph supervisor uses state-graph transitions; CrewAI uses task assignments; AutoGen uses message turns. The DEV piece "Multi-Agent Orchestration in LangGraph" frames the choice between Supervisor (centralized) and Swarm (decentralized) as the most important architectural question, with Supervisor preferred when "you need clear ownership and auditability" and Swarm preferred when "agents are peer specialists with no obvious hierarchy" ([DEV / focused.io](https://dev.to/focused_dot_io/multi-agent-orchestration-in-langgraph-supervisor-vs-swarm-tradeoffs-and-architecture-1b7e); [focused.io / lab post](https://focused.io/lab/multi-agent-orchestration-in-langgraph-supervisor-vs-swarm-tradeoffs-and-architecture)).

**How they track progress.** LangGraph stores state in a checkpointer; AutoGen stores conversation history; CrewAI stores task outputs.

**What they do on resume.** LangGraph's checkpointer is the closest analog to kickoff-ready's PROGRESS.md. The discipline is the same: re-load the checkpoint, reconstruct state, continue from the last completed node.

**Trade-offs.** All three have well-documented failure modes: goal drift (the supervisor anchors to its own conversation rather than ground truth), coordination deadlocks, agent looping ("autonomous agents are prone to infinite reasoning loops and 'democratic' indecision"), graph complexity blowup, edge-case coverage gaps ([DEV / agdex_ai](https://dev.to/agdex_ai/crewai-vs-autogen-vs-langgraph-which-multi-agent-framework-in-2026-51m6); [Digital Applied: Multi-Agent Orchestration Patterns](https://www.digitalapplied.com/blog/multi-agent-orchestration-patterns-producer-consumer); [Digital Applied: Agent Architecture Taxonomy](https://www.digitalapplied.com/blog/agent-architecture-patterns-taxonomy-2026)). Galileo's evaluation work emphasizes that the supervisor must not "become a silent co-author" of the worker's output ([Galileo: Evaluate LangGraph Multi-Agent](https://galileo.ai/blog/evaluate-langgraph-multi-agent-telecom)).

**Lesson for kickoff-ready.** The supervisor pattern is the right shape; the failure modes (goal drift, silent co-authorship) are the named refusals (scope leak). kickoff-ready is a deterministic supervisor: the order is data-driven (the dependency graph) not LLM-decided. The LLM's only decision per step is "should we skip this sibling for this specific project?" The order itself is fixed by Section 5's chain.

---

## Section 4: Harness Skill-tool landscape in 2026

### 4.1 Claude Code

**API surface (May 2026).** From the Skills documentation at code.claude.com ([Claude Code: Extend Claude with skills](https://code.claude.com/docs/en/skills)):

- A skill is a directory containing `SKILL.md` plus optional supporting files (templates, scripts, reference docs).
- Frontmatter fields include `name`, `description`, `argument-hint`, `arguments`, `disable-model-invocation`, `user-invocable`, `allowed-tools`, `model`, `effort`, `context` (set to `fork` for subagent execution), `agent`, `hooks`, `paths`, `shell`.
- Invocation: a user types `/skill-name [arguments]`. The model can also load a skill automatically when the user's request matches the description (unless `disable-model-invocation: true`).
- String substitution: `$ARGUMENTS`, `$ARGUMENTS[N]`, `$N`, `$name` (from named `arguments` list), `${CLAUDE_SESSION_ID}`, `${CLAUDE_EFFORT}`, `${CLAUDE_SKILL_DIR}`.
- Dynamic context injection: `` !`<command>` `` syntax runs shell commands at skill load time, before the SKILL.md content is sent to the model. The output replaces the placeholder.
- Permission control: `Skill(name)` for exact match in permission rules; `Skill(name *)` for prefix match; `Skill` alone in deny rules disables all skills.

**Nested invocation.** Claude Code 2026 supports nested skill invocation. The `claude_code.skill_activated` OpenTelemetry event "fires for user-typed slash commands and carries a new invocation_trigger attribute ('user-slash', 'claude-proactive', or 'nested-skill')" ([Releasebot: Claude Code Updates - May 2026](https://releasebot.io/updates/anthropic/claude-code)). This means kickoff-ready can invoke prd-ready directly via the Skill tool from within its own SKILL.md flow.

**Caveat: forked subagents do not nest further.** From the docs: "subagents cannot nest, as a skill running in a forked subagent cannot spawn another subagent" ([Claude Code Skills docs](https://code.claude.com/docs/en/skills)). This means kickoff-ready cannot use `context: fork` if it intends to invoke other skills inside; the orchestrator runs in the main context, and each invoked sibling is a regular skill load (not a forked subagent), unless the sibling itself is configured to fork.

**Failure modes.**
- Skill not installed: the Skill tool errors. kickoff-ready must list its sibling dependencies in README and detect-and-degrade gracefully.
- Skill description budget: total skill descriptions are budgeted at 1% of the context window with an 8,000-character fallback ([Claude Code Skills docs](https://code.claude.com/docs/en/skills)). With many skills installed, descriptions get truncated; kickoff-ready's description must put its key use case first (the 1,536-character per-entry cap).
- Resume issues: the resume / cache-invalidation issues in Section 2.3 apply.
- Circular invocation: no documented protection. kickoff-ready must self-detect (do not call kickoff-ready from inside kickoff-ready).
- Permission gates: if `.claude/settings.json` denies `Skill(prd-ready *)`, the invocation fails. kickoff-ready must surface a clean error message.

**Invocation shape.** The user invokes a skill by typing `/skill-name args` in chat. From inside another skill, the same form is used; the harness (not the skill author) decides whether to spawn a subagent or load inline. Because Claude Code's invocation is conversational (the model emits the slash command into the conversation), kickoff-ready's invocation pattern is to instruct the agent to "invoke /prd-ready now" at the appropriate point in PROGRESS.md, not to programmatically spawn the sibling. The Skill tool listed as available in the harness's tool list is used by the agent when it decides to load the skill.

### 4.2 OpenAI Codex CLI

**API surface (May 2026).** From the Codex Skills documentation ([OpenAI Codex Agent Skills](https://developers.openai.com/codex/skills); [ITECS Codex CLI Agent Skills 2026 guide](https://itecsonline.com/post/codex-cli-agent-skills-guide-install-usage-cross-platform-resources-2026)):

- Skills are reusable bundles of instructions, scripts, and resources, available in Codex CLI, IDE extension, and Codex app.
- Two invocation forms: explicit, by typing `$skill-name` (the dollar-sign form is the Codex equivalent of Claude's slash); and implicit, where Codex selects a skill matching the task description.
- Slash commands (`/review`, `/fork`, `/side`) are a separate facility for "specialized workflows" and reusable prompts ([OpenAI Codex slash commands](https://developers.openai.com/codex/cli/slash-commands)).
- AGENTS.md is the Codex equivalent of CLAUDE.md ([OpenAI Codex AGENTS.md guide](https://developers.openai.com/codex/guides/agents-md)).
- Curated skills install via `$skill-installer linear` and similar.

**Nested invocation.** The Codex docs as of May 2026 do not explicitly document skill-to-skill invocation. The `$skill-name` form is invocable from any conversation context, including inside another skill, but the docs are silent on whether this is officially supported or what the failure modes are.

**Practical implication.** kickoff-ready on Codex emits text instructions: "next, run `$prd-ready <project name>`." The user (or the agent, if the agent treats the instruction as actionable) types the command. This is the same shape as Claude Code's invocation in practice; the syntactic difference (`$` versus `/`) is the only change.

### 4.3 Cursor and Windsurf

Both ship rules-and-workflow systems, not Skill tools.

**Cursor.** Notepads and `.cursorrules` are the closest equivalent ([Builder.io: Windsurf vs Cursor](https://www.builder.io/blog/windsurf-vs-cursor); [Blott.com: Cursor vs Windsurf 2025](https://www.blott.com/blog/post/cursor-vs-windsurf-which-code-editor-fits-your-workflow)). Notepads are searchable and includable in context; rules apply automatically based on file matching. There is no programmatic skill-invocation API.

**Windsurf.** `.windsurf/` directory committed to source, with workflows and global rules ([Paul Duvall: Windsurf Rules and Workflows](https://www.paulmduvall.com/using-windsurf-rules-workflows-and-memories/); [Vibecoding: Cursor vs Windsurf 2026](https://vibecoding.app/blog/cursor-vs-windsurf)). Workflows are reusable prompts; rules provide project-specific context. No programmatic invocation API documented.

**kickoff-ready posture.** On both Cursor and Windsurf, kickoff-ready surfaces guidance text. The user copies the text to the next prompt. The progress ledger (`.kickoff-ready/PROGRESS.md`) is still the source of truth and is committed to the repo. Cursor and Windsurf both pick up project-level config files automatically, so the next session starts with the ledger in context.

### 4.4 Generic LLM frontends (chat.openai.com, claude.ai)

No skill tool, no project file system, no `.kickoff-ready/` directory possible. The user works in a single conversation thread.

**kickoff-ready posture.** Surface the full sequence in the response: "Step 1 is to run prd-ready. Here is what prd-ready owns and what it produces. After you have the PRD, paste it back and we will move to step 2." This is a degraded mode. PROGRESS.md exists only inside the conversation as a markdown block the user copies. The skill is honest about this: "this harness has no file system; resume requires you to paste the prior PROGRESS.md back."

### 4.5 Antigravity (Google's coding harness)

Mentioned in passing because Antigravity skills follow the same `SKILL.md` standard (the Agent Skills open standard at agentskills.io, referenced in the Claude Code docs ([Claude Code Skills docs](https://code.claude.com/docs/en/skills); [Antigravity Skills Directory](https://antigravityskills.directory/))). For kickoff-ready, Antigravity behaves like Claude Code: a Skill tool exists, the invocation form may differ slightly, the underlying contract is the same.

### 4.6 Harness landscape table

| Harness | Skill tool | Invocation form | Nested skill calls | kickoff-ready posture |
|---|---|---|---|---|
| Claude Code 2026 | Yes | `/skill-name args` | Supported (since 2026 update); subagents do not nest | Programmatic invocation; verification gate per step |
| OpenAI Codex CLI 2026 | Yes | `$skill-name args` | Not explicitly documented; emit text instructions | Emit text; agent or user types command |
| Antigravity | Yes (Agent Skills standard) | Per-harness | Per-harness | Same as Claude Code |
| Cursor | No (rules + notepads) | Manual | N/A | Surface guidance text; ledger in repo |
| Windsurf | No (rules + workflows) | Manual | N/A | Surface guidance text; ledger in repo |
| chat.openai.com | No | N/A | N/A | Single-conversation degraded mode; ledger in chat |
| claude.ai | No | N/A | N/A | Single-conversation degraded mode; ledger in chat |

---

## Section 5: Downstream chain verification

This section walks the documented `upstream:` lists from each sibling's SKILL.md frontmatter and verifies that, at the moment kickoff-ready hands off to a sibling, the upstream artifacts will exist on disk.

### 5.1 The chain, from frontmatter

From each sibling's SKILL.md (read directly):

- **prd-ready**: `upstream: []`. Top of the planning tier.
- **architecture-ready**: `upstream: [prd-ready]`.
- **roadmap-ready**: `upstream: [prd-ready, architecture-ready]`.
- **stack-ready**: no `upstream` field declared in frontmatter. The skill's description states it consumes the PRD and architecture: "Outputs a ranked, scored shortlist with tradeoffs, pairing compatibility checks, and bundle recommendations tailored to domain, team size, budget, and time-to-ship."
- **repo-ready**: `upstream: []`. The skill is stack-agnostic by construction; it can run before or after stack-ready. Pairs with production-ready.
- **production-ready**: `upstream: [prd-ready, architecture-ready, roadmap-ready, stack-ready]`.
- **deploy-ready**: `upstream: [production-ready, stack-ready, repo-ready]`.
- **observe-ready**: `upstream: [production-ready, stack-ready, deploy-ready, repo-ready]`.
- **launch-ready**: `upstream: [production-ready, stack-ready, deploy-ready, observe-ready]`.
- **harden-ready**: `upstream: [architecture-ready, production-ready, deploy-ready, observe-ready, repo-ready]`.

### 5.2 Linear walk

The proposed kickoff-ready order:

```
prd-ready
  -> architecture-ready
  -> roadmap-ready
  -> stack-ready
  -> (repo-ready || production-ready)
  -> deploy-ready
  -> observe-ready
  -> launch-ready
  -> harden-ready (parallel with shipping or after)
```

Walking:

1. **prd-ready first.** No upstream. Produces `.prd-ready/PRD.md`. Verified.
2. **architecture-ready second.** Upstream: prd-ready. After step 1, `.prd-ready/PRD.md` exists. Verified.
3. **roadmap-ready third.** Upstream: prd-ready, architecture-ready. After steps 1 and 2, both upstream artifacts exist. Verified.
4. **stack-ready fourth.** No declared upstream in frontmatter, but description implies PRD and architecture are inputs. After steps 1 and 2, both exist. Verified.
5. **repo-ready and production-ready in the building tier.** repo-ready has empty upstream. production-ready upstream is prd-ready, architecture-ready, roadmap-ready, stack-ready. After step 4 all four exist; production-ready's upstream is satisfied. repo-ready can run any time but benefits from stack-ready being done first (so the repo is configured for the chosen stack). Verified.
6. **deploy-ready sixth.** Upstream: production-ready, stack-ready, repo-ready. Satisfied after step 5.
7. **observe-ready seventh.** Upstream: production-ready, stack-ready, deploy-ready, repo-ready. Satisfied after step 6.
8. **launch-ready eighth.** Upstream: production-ready, stack-ready, deploy-ready, observe-ready. Satisfied after step 7.
9. **harden-ready last.** Upstream: architecture-ready, production-ready, deploy-ready, observe-ready, repo-ready. Earliest fire-time is after observe-ready (step 7). The launch-ready dependency is not in harden-ready's upstream list; harden-ready can fire before, parallel with, or after launch-ready.

The chain holds. Every sibling's documented upstream is available at hand-off.

### 5.3 Where the upstream is empty: graceful-degradation versus interop bug

**stack-ready with no `upstream:` field.** This is intentional graceful degradation. Stack-ready's description explicitly handles "any request to evaluate tech choices for a specific job," with or without a PRD/architecture in hand. A user can ask "Postgres or Mongo for this project" with only a one-paragraph description; stack-ready does not require formal upstream artifacts. When kickoff-ready invokes it, it does benefit from PRD and architecture being present, but the absence of an `upstream:` declaration is the skill saying "I work standalone too." This is the orchestrator-agnostic principle from production-ready's ORCHESTRATORS.md (line 12: "Skills work standalone. Every skill runs without an orchestrator present"). Not an interop bug.

**repo-ready with `upstream: []`.** Same reasoning. Repo-ready's strength is that it works on any project, with or without prior planning artifacts. Within kickoff-ready's chain, repo-ready will benefit from stack-ready being done first (so the repo's tooling is configured for the chosen stack), but repo-ready does not require it. Also intentional, also graceful degradation.

**Recommendation.** kickoff-ready should still pre-fire stack-ready before repo-ready when running the full chain, because the repo configuration is meaningfully better when stack is decided. The order is "stack-ready then repo-ready" even though repo-ready's frontmatter does not require it.

### 5.4 Building-tier parallelism: repo-ready and production-ready

**Both list `pairs_with` each other.** repo-ready: `pairs_with: [production-ready]`. production-ready: `pairs_with: [repo-ready]`.

**Are they parallelizable?** In principle, yes. They write to different paths: repo-ready writes top-level files (README, CHANGELOG, .github/workflows, .editorconfig, package.json scripts, LICENSE, etc.); production-ready writes app code (typically under `src/`, `app/`, or framework-specific paths) plus its own `.production-ready/` artifacts. Path collisions are minimal. The exception: both touch `package.json` (repo-ready manages devDependencies and scripts; production-ready may add runtime dependencies). This is a real coordination point.

**Production reality.** Most users run them sequentially because the cognitive load of "two agents writing to my repo simultaneously" is high. The package.json overlap, while small, is a non-trivial merge problem if two writes happen in the same minute.

**Recommendation.** kickoff-ready should run repo-ready first, then production-ready. Reason: repo-ready is fast (it scaffolds; it does not build features), and production-ready running on a properly-scaffolded repo produces better results (correct lint config, correct CI pipeline already present, correct test runner installed). Running them strictly sequentially also avoids the package.json merge problem and the "two AI sessions racing" cognitive load. Document the parallelism as available for advanced users who want to run two harness sessions concurrently and accept the merge risk; default to sequential.

### 5.5 Where in the shipping tier should harden-ready fire?

**The constraint, from frontmatter.** harden-ready's upstream is architecture, production, deploy, observe, repo. Earliest fire-time is after observe-ready completes.

**The three options:**

1. **Before launch-ready (gate launch on hardening).** Harden the deployed app, then launch publicly. Pro: no public exposure of exploitable code. Con: hardening can take days to weeks; many kickoffs will not actually run harden-ready before first launch (especially private alpha or invite-only beta).
2. **In parallel with launch-ready.** Both consume the same upstream (deployed, monitored app); they touch different surfaces (harden writes `.harden-ready/`, launch writes landing page and channel posts). No path collision. Pro: faster to public launch with security work happening concurrently. Con: the launch happens before the security review completes; if harden-ready finds a critical issue mid-launch, the launch may need to halt.
3. **After launch-ready (post-public-launch hardening).** Launch publicly, then harden. Pro: real users provide signal for hardening priorities (which paths matter). Con: real users may also be on the wrong end of unhardened code.

**The skill's description hints at the answer.** harden-ready's description says: "Pairs with deploy-ready, observe-ready, launch-ready." The pairs_with list (`[deploy-ready, observe-ready, launch-ready]`) is the strongest signal: harden-ready is designed to run alongside the shipping tier, not as a gate before it. The description's trigger list also includes "security review before launch," which says harden-ready is invocable before launch when the user asks for it; but the default pairing is concurrent.

**Recommendation.** Default to parallel-with launch-ready, with a hard gate: any **critical** finding from harden-ready halts launch-ready until the finding is resolved. Provide an explicit user-controlled override "I want harden-ready to gate launch" for security-sensitive projects (healthcare, finance, anything PCI/HIPAA/SOC-2 in-scope). Provide an explicit "skip harden-ready" for one-day prototypes that have no real user surface to harden (and document this skip in PROGRESS.md so it shows up in the audit ledger). This preserves harden-ready's pairs_with declaration while honoring the seriousness of its refusals.

### 5.6 Visualizing the DAG

```
prd-ready
   |
   v
architecture-ready
   |
   +-> roadmap-ready
   |
   +-> stack-ready
                |
                v
            repo-ready (pairs production-ready)
                |
                v
            production-ready
                |
                v
            deploy-ready
                |
                v
            observe-ready
                |
                +-> launch-ready --+
                |                  |
                +-> harden-ready --+ (parallel; harden-ready critical findings gate launch-ready)
```

This is the DAG kickoff-ready should encode in its sequencing logic. Topological order: prd, architecture, (roadmap || stack), repo, production, deploy, observe, then (launch || harden) with critical-finding gate.

### 5.7 Skip and re-invocation rules

The DAG is the optimistic path. kickoff-ready also needs to handle:

- **Skip.** User explicitly opts out of a step. PROGRESS.md records the skip with a reason. Downstream steps that depend on the skipped step's artifact must either (a) refuse to run, or (b) accept that the artifact will be implicit (e.g., skipping stack-ready means production-ready uses whatever stack the user already chose).
- **Re-invoke.** User wants to re-run a completed step (the PRD changed; the architecture changed). PROGRESS.md is rolled back from that step forward; the artifact is overwritten with confirmation; downstream steps are marked as needing re-validation.
- **Import.** User has a pre-existing PRD or architecture from before kickoff-ready started. PROGRESS.md records "imported" rather than "produced"; the verification gate confirms the file exists at the expected path; downstream steps proceed normally.

These three are the "happy-path orchestrator" antidote (Section 2.6). Any kickoff-ready that does not handle skip / re-invoke / import handles only the success branch.

---

## Section 6: Recommendations for SKILL.md

A short list of decisions this research makes on the skill author's behalf:

1. **Adopt four flagship refusals: scope leak, rubber-stamp orchestration, phantom resume, ghost handoff.** Add happy-path orchestrator and state-vs-artifact drift as secondary vocabulary. Reject god-skill, monolithic kickoff, compliance-theater-for-orchestrators, and the CVE-of-the-week analog as redundant.
2. **PROGRESS.md is a view, not a database.** The source of truth is the union of `.{skill}-ready/` directories. Every kickoff-ready turn begins with a fresh re-derivation from disk. This is the just/Make discipline (Section 3.4) and the only defense against phantom resume.
3. **Verification gate is two checks: artifact-exists and not-empty-template.** A step is "done" only when both pass. This is the rubber-stamp-orchestration mitigation (Section 2.1).
4. **Encode the DAG declaratively in the skill body.** The sequence is data, not prose. This is BMAD's lesson (Section 3.2) and Just's lesson (Section 3.4). When the user adds an eleventh sibling later, the DAG entry is the diff; the rest of the skill is unchanged.
5. **Default order: prd, architecture, roadmap, stack, repo, production, deploy, observe, then launch and harden in parallel with a critical-finding gate.** Document skip and re-invocation paths explicitly. Surface harden-ready's gate-launch override for security-sensitive projects.
6. **Skill-tool invocation by harness:** Claude Code uses `/skill-name`; Codex uses `$skill-name`; Cursor / Windsurf / chat frontends get guidance text. The kickoff-ready body should branch on harness presence, not on a hardcoded assumption that the Skill tool exists.
7. **Refuse to write specialist content. Period.** The single most important have-not. If the user asks kickoff-ready to "just sketch the PRD," the answer is to invoke prd-ready and stop typing. Scope leak is the failure mode that kills the entire suite if it slips through.
8. **Single-threaded by default.** Building-tier parallelism (repo-ready and production-ready concurrent) is documented but not the default. Sequential avoids the package.json merge problem and the cognitive cost of two concurrent agent sessions on the same repo.
9. **Skip is a recorded event, not silence.** PROGRESS.md must distinguish "step skipped, with reason" from "step never reached." The Shape Up no-gos field (Section 3.3) is the model.
10. **Resume protocol is mandatory: read PROGRESS.md, ls every claimed-complete `.{skill}-ready/`, re-derive current step before any further action.** This is non-optional and must run every turn, not just on explicit /resume. The phantom-resume failure mode (Section 2.3) cited in Anthropic's own issue tracker is the load-bearing reason.

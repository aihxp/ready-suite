# Roadmap Ready

> **Sequence software work over time. Every item on the roadmap is a grounded commitment, an outcome-framed direction, or a named open question. Nothing else. No invented dates. No fictional parallelism. No features absent from the PRD.**

> **Part of the [ready-suite](SUITE.md)**, a composable set of AI skills covering the full arc from idea to launch (planning, building, shipping). See [`SUITE.md`](SUITE.md) for the full map and the live sibling skills.

A founder, PM, or engineering lead opens a new Notion doc, types "build a roadmap for the next 6 months" into ChatGPT, Claude, or Productboard AI, and pastes the output. What ships is a grid with four columns labeled Q1, Q2, Q3, Q4, each stuffed with feature titles, each with a date to the day, half of which name features not in the PRD and the other half lack any outcome framing. Three parallel tracks are assumed for a team of two engineers. Dependencies between features are visible in the architecture doc but encoded nowhere in the roadmap. The launch milestone has no observability-live date, no rollback-tested date, no runbook-reviewed date underneath it. The document is printed, signed off, filed. Six weeks later it is stale. Engineering works from the sprint backlog. The roadmap becomes an artifact for investor decks.

roadmap-ready is the skill that catches the roadmap shape before it ships to engineering. It ingests the PRD (from prd-ready) and the architecture dependency graph (from architecture-ready). It requires a team-capacity input. It refuses to commit dates without capacity. It refuses to sequence without a DAG. It refuses to include features absent from the PRD. It refuses to emit launch milestones with no readiness gates. It produces a Markdown `ROADMAP.md` with Now-Next-Later horizons, topologically-sorted slice queues for production-ready, cutover cadence for deploy-ready, KPI handoffs for observe-ready, and explicit launch-milestone gate dates for launch-ready.

The AI-tooling landscape is full of roadmap generators (Productboard AI, Aha! AI, Atlassian Rovo, Linear's AI features, ChatPRD, Notion AI). The gap is a refuser. This skill is not a smarter generator; it is a stricter one.

## Install

This skill ships as part of the [ready-suite](https://github.com/aihxp/ready-suite) monorepo. The hub installer symlinks `SKILL.md` and `references/` for all eleven skills into every detected harness (Claude Code, Codex, Cursor, pi, OpenClaw, any Agent Skills harness):

```bash
git clone https://github.com/aihxp/ready-suite.git ~/Projects/ready-suite
bash ~/Projects/ready-suite/install.sh
```

Re-run anytime after `git pull` to pick up updates. To remove all symlinks, run `bash ~/Projects/ready-suite/uninstall.sh`.

**Windsurf or other agents without a programmatic Skill tool:** add this skill's `SKILL.md` to your project rules or system prompt. Load reference files as needed.

## The problem this solves

Roadmaps fail in a narrow band that looks like success. LLM-generated roadmaps fill every cell; precision is visually high; stakeholders nod. The industry converges on the same failure modes under slightly different names: John Cutler's feature factory (2016), Melissa Perri's build trap (2018), Marty Cagan's feature-roadmap critique (SVPG 2015), Janna Bastow's Now-Next-Later (ProdPad 2012), Ryan Singer's fixed-time-variable-scope (Shape Up 2019), plus the emerging-but-unowned terms (roadmap theater, fictional parallelism, quarter-stuffing, speculative roadmap, shelf roadmap).

Existing tools do not catch these. Productboard, Aha!, Linear, Jira, ChatPRD, and Notion AI will render any roadmap you hand them. None will tell you the parallelism exceeds your team size, or that two Q2 items depend on a Q3 item, or that the launch milestone has no observability-live date underneath it. The skill is the layer above the tool that catches the roadmap shape before it ships.

Full research with 267 source citations is in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md).

## When this skill should trigger

The short frontmatter description is tight on purpose, to speed up skill-routing decisions. The full trigger surface lives here.

**Positive triggers (build or refresh a roadmap):**
- "Build a roadmap."
- "Plan the next quarter."
- "Sequence these features."
- "What ships first?"
- "When does the beta happen?"
- "Give me a Shape Up cycle plan."
- "PI planning input."
- "Milestone plan."
- "Roadmap for [horizon]."
- "Now-Next-Later for [project]."
- "Public roadmap for [customers / investors]."

**Implied triggers (roadmap is the word, not always spoken):**
- "When will X ship?"
- "Can this fit in Q2?"
- "What's on deck after launch?"
- "Are these items in order?"
- "Have we committed to a date yet?"
- "Where's the launch in our plan?"

**Mode triggers (specific roadmap states):**
- "Fix this AI-generated roadmap." (Mode B audit)
- "Re-plan for next cycle." (Mode C iteration)
- "We're pivoting; re-build the roadmap." (Mode D)
- "Build is stalled; re-sequence." (Mode E rescue)
- "Pre-launch freeze." (Mode F)

**Negative triggers (route elsewhere):**
- "Write a PRD." -> [`prd-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/prd-ready).
- "Design the architecture." -> [`architecture-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/architecture-ready).
- "Pick the stack." -> [`stack-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/stack-ready).
- "Build the feature." -> [`production-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready).
- "Set up the repo." -> [`repo-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready).
- "Deploy it." -> [`deploy-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/deploy-ready).
- "Monitor it." -> [`observe-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/observe-ready).
- "Launch it." -> [`launch-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/launch-ready).

**Pairing:** roadmap-ready pairs most often with [`prd-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/prd-ready) (upstream; WHAT the product is), [`architecture-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/architecture-ready) (upstream; the component DAG), and [`stack-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/stack-ready) (same-tier; with what tools). The boundary with each is strict: prd-ready decides what belongs in the product; architecture-ready decides how the pieces fit; stack-ready decides the tools; roadmap-ready decides the sequence over time.

## How it works

1. **Step 0.** Detect roadmap state and mode (A through F).
2. **Step 1.** Pre-flight: capacity, cadence, horizon, external dates, audience, risk tolerance, existing commitments, upstream artifact state.
3. **Step 1.5.** Mode B audit (if an AI-slop roadmap exists).
4. **Step 2.** Cadence selection (Shape Up, quarterly, SAFe PI, continuous, milestone, or hybrid).
5. **Step 3.** Ingest upstream: PRD priorities and architecture DAG.
6. **Step 4.** Sequencing: topological order + risk + appetite + capacity.
7. **Step 5.** Milestone anatomy: name, date, gate, in-scope, out-of-scope, rabbit holes, dependencies, cutover.
8. **Step 6.** Horizon-appropriate precision (Now > Next > Later).
9. **Step 7.** Launch milestone (if in scope) with D-calendar and readiness gates.
10. **Step 8.** Downstream handoff block for stack-ready, production-ready, deploy-ready, observe-ready, launch-ready.
11. **Step 9.** Review cadence, freshness indicators, archive rule.
12. **Step 10.** Public-facing derivative (if mixed audience).
13. **Step 11.** Staleness check.

Four completion tiers (Sketch, Plan, Committed, Public-ready), each independently shippable. Full workflow in [`SKILL.md`](SKILL.md).

## What this skill prevents

Mapping real research findings and named failure modes to the specific disciplines the skill enforces. Citations in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md).

| Real incident / research finding | What this skill enforces |
|---|---|
| John Cutler's feature factory (2016): roadmaps listed as features, not outcomes. https://cutle.fish/blog/12-signs-youre-working-in-a-feature-factory/ | Every item has an outcome-framed direction OR a high-integrity commitment label. Bare feature names are disqualified. |
| Melissa Perri's build trap (2018): output metrics as proxy for value. | At least one outcome metric per theme, with measurement source. |
| Roadmap theater: Gantt-chart aesthetics with dates pulled from thin air. https://theaipoweredprojectmanager.substack.com/p/your-project-roadmap-is-a-lie-you | Day-level dates outside Now require either confidence bands or high-integrity commitment labels. |
| Ryan Singer, Shape Up: "Fixed time, variable scope." https://basecamp.com/shapeup/1.2-chapter-03 | Every item has an appetite OR an estimate with a confidence band. Neither-nor is disqualified. |
| Janna Bastow, Now-Next-Later (2012): decreasing precision across horizons. https://www.prodpad.com/blog/outcome-based-roadmaps/ | Equal precision across horizons is flagged as quarter-stuffing. |
| Marty Cagan: "95% of roadmaps are output roadmaps." https://www.svpg.com/the-alternative-to-roadmaps/ | Every item references a PRD section or architecture component; no invented features. |
| Goldratt's Critical Chain (1997): resource contention collapses parallel tracks. https://en.wikipedia.org/wiki/Critical_chain_project_management | Concurrent-track count cannot exceed team-capacity input. Fictional parallelism is refused. |
| Amdahl's law (1967): serial fraction caps speedup. https://en.wikipedia.org/wiki/Amdahl's_law | Parallelism claims require a serial-fraction allowance in capacity math. |
| Hofstadter's law (1979): tasks take longer than expected even after accounting for the law. https://en.wikipedia.org/wiki/Hofstadter's_law | Dated commitments outside Now require confidence bands, not single-point dates. |
| Kahneman-Tversky planning fallacy (1979): systematic optimism bias in duration estimation. https://en.wikipedia.org/wiki/Planning_fallacy | Confidence bands mandatory; classical estimation with no band is disqualified. |
| AI-generated roadmap pattern: fictional dates with no capacity input. https://blog.buildbetter.ai/12-best-ai-product-management-tools-for-2025/ | No dated commitment emitted when capacity pre-flight answer is null. |
| AI-generated roadmap pattern: speculative features not in the PRD. | Every row checked against `.prd-ready/PRD.md`; unsupported rows routed back to prd-ready. |
| Cortex / DX / LaunchDarkly production-readiness writing: observability + rollback + runbooks gate launches. https://getdx.com/blog/production-readiness-checklist/ | Launch milestones require dated observability-live, rollback-tested, runbooks-reviewed sub-items. |
| Facebook 2021 / Slack 2021: status-page hosted on same infra as app. | Launch readiness checks independence of status page (via launch-ready handoff). |
| ProductPlan "reasons roadmaps fail": shelved roadmaps. https://www.productplan.com/learn/reasons-product-roadmaps-fail/ | Freshness indicators on every Now / Next item; items stale past one cadence cycle flagged. |
| Basecamp "Options, Not Roadmaps": no public roadmap is a legitimate choice. https://basecamp.com/articles/options-not-roadmaps | Public derivative is a Step 10 decision with explicit audience answer; no default. |
| Lenny Rachitsky, "One Team, One Roadmap": single canonical artifact with audience-specific derivatives. https://www.lennysnewsletter.com/p/one-team-one-roadmap-issue-27 | Public ROADMAP is always a redacted derivative of the internal canonical; never the same file. |
| Shape Up circuit-breaker: at appetite boundary, cut or re-bet, do not auto-extend. https://basecamp.com/shapeup/3.5-chapter-14 | Polish-indefinitely pattern flagged: extensions require explicit decision, not default. |
| Cagan's high-integrity commitments: a small number of items are explicit date commits with named rationale. | High-integrity commitment label required for any fixed-date-and-fixed-scope item; Tier 3 sign-off. |

## Reference library

Twelve files, each dense and opinionated. Load on demand per the table in `SKILL.md`.

- **`roadmap-research.md`** - Step 0 six-mode detection protocol; named-failure-mode shortlist; upstream-signal checklist; resume protocol.
- **`sequencing-principles.md`** - Eight pre-flight questions; four-layer sequencing framework (topological + risk + appetite + capacity); grounding corollary.
- **`roadmap-anatomy.md`** - Full ROADMAP.md template with annotations; eight-field milestone anatomy; Now-Next-Later precision gradient; public-derivative redaction.
- **`cadence-models.md`** - Seven cadences (Shape Up, quarterly, SAFe PI, continuous, milestone, two hybrids) with selection matrix.
- **`dependency-graph.md`** - DAG traversal, topological sort, capacity matching math with worked examples, Amdahl's law check.
- **`risk-driven-prioritization.md`** - Eight frameworks (RICE, ICE, WSJF, MoSCoW, Kano, Opportunity Scoring, Riskiest-First, Appetite) with compatibility matrix.
- **`scope-vs-time.md`** - Appetite-xor-estimate; MoSCoW at milestone; cut-scope-vs-move-date; rabbit-hole anatomy; polish-indefinitely.
- **`handoff-to-execution.md`** - HANDOFF.md structure with five sub-sections (stack, production, deploy, observe, launch).
- **`launch-sequencing.md`** - Launch modes; seven launch-milestone fields; D-calendar; slip protocol; Mode F freeze.
- **`review-cadence.md`** - Review frequency; Mode C iteration; authority map; re-plan triggers; freshness; archive rule.
- **`roadmap-antipatterns.md`** - 21 named antipatterns with source, shape, example, fix, grep marker.
- **`RESEARCH-2026-04.md`** - Source citations (267 URLs, 10 sections, 9,614 words) backing every guardrail.

## Contributing

Gaps, missing cases, outdated guidance: contributions welcome. Open an issue or PR. The skill's vocabulary (the named failure modes, the antipattern catalog) will drift as AI-generated-roadmap tells evolve; pull requests that catalogue new tells are especially appreciated.

## License

[MIT](LICENSE)

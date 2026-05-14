# PRD Ready

[![ready-suite](https://img.shields.io/badge/ready--suite-v3.0.0-blue)](../../README.md)
[![skill](https://img.shields.io/badge/skill-prd--ready-2f6fed)](SKILL.md)
[![agent skills](https://img.shields.io/badge/Agent%20Skills-compatible-2f6fed)](SKILL.md)
[![aihxp/pillars](https://img.shields.io/badge/aihxp%2Fpillars-standard-0f766e)](https://github.com/aihxp/pillars)
[![license](https://img.shields.io/badge/license-MIT-yellow)](LICENSE)

> **Write a PRD that engineering, design, QA, and downstream planning skills can consume without a clarification meeting. Refuses hollow PRDs, invisible PRDs, feature laundry lists, solution-first PRDs, assumption-soup PRDs, and moving-target PRDs.**

> **Part of the [ready-suite](SUITE.md)**, a composable set of AI skills covering the full arc from idea to launch (planning, building, shipping). See [`SUITE.md`](SUITE.md) for the full map and the live sibling skills.

> **Current version:** 3.0.0 (ready-suite release train).

A founder or PM opens a new Notion page, types "Write a PRD for X" into ChatGPT, Claude, ChatPRD, or Gemini, and pastes the output back. What ships has an Executive Summary, a Problem Statement, five Personas, a Functional Requirements list, a Success Metrics table, a Risks table, and a Timeline. Every section is filled. The target user is "users who need productivity tools." The success metric is "increased engagement and retention." The problem statement reads "users currently struggle with inefficient workflows." The functional requirements are twelve bullets of the form "the system must allow users to..." and the non-functional requirements include "the system must be fast" and "the system must be secure." The out-of-scope section says "features beyond v1 scope." The risks table lists "adoption risk" with mitigation "strong go-to-market." The PRD is twelve pages long. The engineer reads it, asks the PM eight questions, and does not start building.

None of this is a formatting bug. It is a decision-making failure, and the tooling that exists today (Google Docs, Notion, Confluence, Coda) has no opinion about it. Google Docs will render any PRD you type; none of them will tell you the Problem section names the solution, or that the four personas read like the same person, or that the MoSCoW ranks are all Must. This skill closes that gap. It refuses to call a sentence a decision if it survives the substitution test against two competitors. It refuses to call a list of features requirements if there is no MoSCoW tier. It refuses to call an assumption validated if there is no evidence. It refuses to call a PRD signed if no named stakeholder has attested in writing to a specific thing.

## Install

This skill ships as part of the [ready-suite](https://github.com/aihxp/ready-suite) monorepo. The hub installer symlinks `SKILL.md` and `references/` for all eleven skills into every detected harness (Claude Code, Codex, Cursor, pi, OpenClaw, any Agent Skills harness):

```bash
git clone https://github.com/aihxp/ready-suite.git ~/Projects/ready-suite
bash ~/Projects/ready-suite/install.sh
```

Re-run anytime after `git pull` to pick up updates. To remove all symlinks, run `bash ~/Projects/ready-suite/uninstall.sh`.

**Windsurf or other agents without a programmatic Skill tool:** add this skill's `SKILL.md` to your project rules or system prompt. Load reference files as needed.

## The problem this solves

AI-generated PRDs fail in a narrow, predictable band. The research pass ([RESEARCH-2026-04.md](references/RESEARCH-2026-04.md)) catalogs ten recurring failure modes drawn from Tom Leung (Fireside PM), Product-Led Alliance, ProductPlan, Plane, Figr Design, Developex, Aakash Gupta (Mind the Product), Chris Warren, Intercom, Marty Cagan, Ben Horowitz, Adam Fishman, Reforge, Shape Up, Amazon Working Backwards, and Atlassian. The failures cluster into six named patterns:

- **Hollow PRD.** Sections filled, decisions absent. "TBD," "TODO," "coming soon" throughout. Passes visual review; collapses on reading.
- **Invisible PRD.** Reads the same across any product in the category. Target users are "small business owners," success metrics are "increased engagement and retention." Fails the substitution test against two competitors.
- **Feature laundry list.** A flat, un-prioritized list of features or requirements. Every item is Must-ranked or none are ranked. The Out-of-Scope section is three lines long. No cut line.
- **Solution-first PRD.** The Problem section names the product's solution ("our users need a central dashboard that..."). The solution is assumed; the problem is backfilled. Intercom's "Start with the problem" discipline is violated.
- **Assumption-soup PRD.** User-behavior claims stated as facts without evidence or validation plan. "Users will love this," "customers want," "the market demands." Decisions disguised as confidence.
- **Moving-target PRD.** Edits happen silently; engineers stop trusting the document; the team reverts to hallway conversations. The primary cause of the "PRD exists but the team doesn't use it" failure. Ben Horowitz named the pattern in 1998.

The research pass also names three secondary antipatterns: the **theater PRD** (exists for ritual, not decision), the **quill-and-inkwell PRD** (40 pages, zero decisions), and the **superficial-completion PRD** (vacuous tautologies in every section). All three are reserved as rhetorical flourishes in the skill; the primary six are the load-bearing vocabulary.

prd-ready exists because none of the PRD-authoring tools refuse any of these shapes. Notion will render whatever you type. ChatGPT will generate whatever you ask. Confluence will approve whatever you submit. The skill is the layer above the tool that catches the document shape before sign-off.

## When this skill should trigger

The short frontmatter description is tight on purpose, to speed up skill-routing decisions. The full trigger surface lives here.

**Positive triggers (build or revise the PRD):**
- "write a PRD" / "draft a PRD for..." / "PRD for the X feature"
- "product requirements document" / "product spec" / "requirements doc"
- "product brief" / "1-pager" / "one-pager" / "product one-pager"
- "pitch for this feature" / "proposal for..."
- "problem statement" / "define the problem" / "what are we building"
- "target user" / "who is this for" / "user persona"
- "success metrics" / "what does success look like" / "how do we measure"
- "out of scope" / "non-goals" / "no-gos"
- "acceptance criteria" / "given-when-then"
- "rabbit holes" / "appetite" (Shape Up)
- "PR-FAQ" / "working backwards" / "press release" (Amazon)
- "fix this AI-generated PRD" / "this PRD doesn't say anything"
- "sign-off" / "approve the spec" / "review the PRD"
- "living PRD" / "change-control" / "PRD update"

**Implied triggers (the thesis word is never spoken):**
- "the engineers keep asking me clarification questions"
- "we don't know what we're building"
- "the stakeholders all want different things"
- "we shipped v1 and nobody used it"
- "the scope keeps changing"
- "we thought we agreed but clearly we didn't"

**Mode triggers (see [SKILL.md](SKILL.md) Step 0):**
- Mode A: greenfield product, net-new
- Mode B: greenfield feature inside an existing product
- Mode C: AI-slop PRD exists; fix before sign-off
- Mode D: existing PRD refresh for a new cycle
- Mode E: pivot (new user / problem / metric / appetite >50% delta)
- Mode F: rescue (build stalled on an underspecified PRD)

**Negative triggers (route elsewhere):**
- Designing the architecture ("draw the system diagram," "component breakdown") -> `architecture-ready` (not yet released)
- Sequencing the roadmap ("quarterly plan," "milestone schedule") -> `roadmap-ready` (not yet released)
- Picking the stack ("Next.js vs. Remix," "which database") -> [`stack-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/stack-ready)
- Building the app ("wire the dashboard," "implement RBAC") -> [`production-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready)
- Setting up the repo ("CI config," "CONTRIBUTING.md") -> [`repo-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready)
- Deploying ("pipeline," "canary," "rollback") -> [`deploy-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/deploy-ready)
- Monitoring ("SLO," "alerts," "runbook") -> [`observe-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/observe-ready)
- Writing launch copy ("landing page," "hero," "Product Hunt post") -> [`launch-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/launch-ready)
- Pricing strategy ("what to charge") -> business decision, not in scope
- Competitive analysis as a discipline (feature matrix, market share) -> separate product-research practice
- Go-to-market planning -> `launch-ready`
- Marketing positioning and copy -> `launch-ready`
- Technical spike or proof-of-concept code -> `production-ready` in research mode
- Acceptance tests and test plans -> `production-ready` (Tier 1 and Tier 4 proof tests)
- User research methodology (interviews, surveys) -> separate research practice; prd-ready consumes output only
- Design mockups and wireframes -> `production-ready` Step 3 visual identity

**Pairing:** prd-ready pairs with its planning-tier siblings -- `architecture-ready`, `roadmap-ready`, `stack-ready`. The four compose: prd-ready defines WHAT we are building, architecture-ready defines HOW the pieces fit, roadmap-ready defines WHEN it ships, stack-ready defines WITH WHAT TOOLS. Each consumes `.prd-ready/HANDOFF.md`'s relevant sub-section without re-interrogating the user. prd-ready sits at the top of the planning tier; nothing upstream feeds into it.

## How it works

Thirteen steps, four completion tiers, one artifact family under `.prd-ready/`.

1. **Step 0.** Detect PRD state and mode (greenfield product, greenfield feature, AI-slop rewrite, iteration, pivot, rescue).
2. **Step 1.** Pre-flight: seven questions answered in writing or flagged as open questions.
3. **Step 1.5.** Mode C audit (only if a prior AI-slop PRD exists): quote failing sentences, name dominant antipattern, decide rewrite scope.
4. **Step 2.** Problem framing: friction + who + workaround, problem-first discipline, no solution in the Problem section.
5. **Step 3.** Target user: role + context + constraint + workaround + cited quote. Five bullets, not five paragraphs.
6. **Step 4.** Success criteria: leading + lagging indicators, each with number + deadline + outcome frame + source.
7. **Step 5.** Functional requirements: user-observable behavior + MoSCoW rank + acceptance criteria + dependencies.
8. **Step 6.** Non-functional requirements: performance, scale, availability, security, privacy, compliance, accessibility, i18n, observability, retention, browser, ops.
9. **Step 7.** Scope and no-gos: explicit no-gos + deferrals + non-ownership + rabbit holes with smallest-version alternatives.
10. **Step 8.** Risks, assumptions, open questions: three separate lists; every item owned and dated.
11. **Step 9.** Downstream handoff block: `.prd-ready/HANDOFF.md` pre-fills architecture-ready, roadmap-ready, stack-ready, production-ready.
12. **Step 10.** Alignment and sign-off: named signers, specific attestations, per-role.
13. **Step 11.** Iterate-vs-freeze lifecycle: four states (Draft, Living, Soft-frozen, Archived), change-control protocol, broadcast discipline.
14. **Step 12.** Staleness check: skill version, last updated, current date.

Tiers: **Brief** (Tier 1, one-page, mandatory default), **Spec** (Tier 2, lean PRD for solution-space alignment), **Full PRD** (Tier 3, build-ready with full sign-off), **Launch-Ready** (Tier 4, with measurement instrumentation and support runbook). See [SKILL.md](SKILL.md) for per-tier requirements.

## What this skill prevents

Mapped against documented PRD-shaped failures from the research pass:

| Real incident / research finding | What this skill enforces that prevents it |
|---|---|
| **Tom Leung's "invisible" PRD test** ([Fireside PM](https://firesidepm.substack.com/p/i-tested-5-ai-tools-to-write-a-prdheres)): ChatGPT, Gemini, Claude, ChatPRD all produced PRDs "that could have been written for literally any product." | Step 1 substitution test against two competitors; Step 3 target-user specificity rule; banned-phrase audit in have-nots. |
| **ProductPlan, "feature laundry list"**: PRDs with too many features and no priority obscure main value. | Step 5 MoSCoW forced distribution; cap on Must ranks (<=50%); Won't tier required; cross-link to Out-of-Scope. |
| **prodmgmt.world PRD template guide on non-goals**: "explicit out-of-scope definitions prevent scope creep, the single most destructive force." | Step 7 three-part Out-of-Scope section (no-gos + deferrals + non-ownership); length rule (longer than Won't tier). |
| **Intercom, "Start with the problem"**: solution-first PRDs violate the problem-first discipline. | Step 2 Problem section cannot begin with "Our product," "The system," "Users need a solution that"; three-paragraph format. |
| **Aakash Gupta on superficial completion** (Modern PRD Guide): "all sections present but with vacuous content." | Three-label audit at every tier gate; hollow-PRD check in have-nots; Tier 2+ NFR silence blocked. |
| **Ben Horowitz / David Weiden, 1998 memo**: bad PMs update the PRD without broadcasting. | Step 11 broadcast discipline mandatory; Living and Soft-frozen states require changelog + Slack/Linear/Discord announcement; silent edits rejected. |
| **Plane Blog**: "engineers refuse to estimate from vague PRDs." | Step 5 functional requirements require user-observable behavior + acceptance criteria; Step 6 NFR dimensions cannot be silent at Tier 3; "can an engineer estimate this" is the load-bearing audit. |
| **Figr Design**: "every question an engineer has to ask you after kickoff is a tax on your team's time." | Step 9 downstream handoff block; engineers can read `.prd-ready/HANDOFF.md` and start planning without clarification meetings. |
| **Shape Up (Singer)**: appetite is fixed, scope is variable; rabbit holes must be named. | Step 1 appetite required as duration, not estimate; Step 7 rabbit holes with smallest-version alternatives; Tier 2 gate blocked without at least one rabbit hole. |
| **April Dunford, *Obviously Awesome***: competitive-alternative framing beats feature framing. | Step 2 Problem section requires the workaround (the Notion page, the cron job, the five-tab Friday workflow) explicitly named. |
| **Kevin Yien (Square) template** and Reforge: non-goals as a first-class section. | Step 7 three-bullet minimum at Tier 1, five-bullet at Tier 2, ten-bullet minimum at Tier 3. |
| **Amazon Working Backwards (PR-FAQ)**: write the press release first to test whether the product is worth building. | PR-FAQ optional mode in prd-anatomy section 18 for greenfield-product (Mode A) cases. |
| **HashiCorp PRD template**: "Problem Requirements Document," PM owns the problem, engineering owns the design. | Scope fence: prd-ready stops at entities and flows; architecture-ready starts at system design. |
| **Reforge staged-artifact model**: Brief -> Spec -> Full PRD, expand only when scope justifies. | Four tiers; Tier 1 default; tier discipline applied at each gate. |
| **Adam Fishman, "PRDs are the worst way to drive product progress"**: many PRDs should be Product Briefs, not full PRDs. | Iterate-vs-freeze section 5 "When Tier 1 is enough" checklist; skill surfaces the tier mismatch rather than forcing a full PRD. |
| **Horowitz 1998 memo**: PRD is a living ongoing process; daily-or-weekly updates with broadcast. | Step 11 living-document principle; changelog at top of PRD; broadcast mandatory in Living and Soft-frozen states. |

## The skill's named terms

prd-ready adopts six primary failure-mode terms and three secondary rhetorical flourishes, each mapped to a specific class of PRD the skill refuses.

- **Hollow PRD.** Sections filled; decisions absent. Suite-consistent with production-ready's "hollow dashboard" and "hollow button" vocabulary. Reusing the shape across the suite builds a coherent mental model: a hollow artifact has structure without function.
- **Invisible PRD.** Tom Leung's term (Fireside PM, 2024). The PRD reads the same across any product in the category; the substitution test fails. Adopted with attribution.
- **Feature laundry list.** ProductPlan's term. In the wild; adopted verbatim.
- **Solution-first PRD** (or "solution-in-search-of-a-problem"). Intercom's framing (Product Principles, 2017). The Problem section names the product's solution.
- **Moving-target PRD.** Ben Horowitz's 1998 pattern, formalized here. Silent edits; engineer whiplash.
- **Assumption-soup PRD.** Coined for prd-ready. The failure of "we assume users will love it" claims stated as facts without evidence or validation plan.

Secondary (rhetorical, sparingly): **theater PRD**, **quill-and-inkwell PRD**, **superficial-completion PRD** (Aakash Gupta's phrase).

See [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md) section 2 for the naming-lane survey and the coinage recommendations.

## Reference library

Load each reference *before* the step that uses it, not after. Full tier annotations in [SKILL.md](SKILL.md).

- [`prd-research.md`](references/prd-research.md). Step 0 mode detection protocol; the six-mode research-block format.
- [`problem-framing.md`](references/problem-framing.md). Step 1 pre-flight seven questions; Step 2 problem-first discipline, substitution test, competitive-alternative framing, cost-of-friction rule.
- [`user-personas.md`](references/user-personas.md). Step 3 five-bullet user description; anti-personas; research inputs the PRD consumes.
- [`success-criteria.md`](references/success-criteria.md). Step 4 four-property rule; leading vs. lagging; vanity-metric traps; HEART framework lens; success-metric handoff to observe-ready.
- [`requirements.md`](references/requirements.md). Step 5 functional requirements; Step 6 non-functional requirements dimensions; MoSCoW discipline; acceptance-criteria Given-When-Then format; requirements traceability.
- [`scope-and-out-of-scope.md`](references/scope-and-out-of-scope.md). Step 7 three-part Out-of-Scope section; rabbit holes with smallest-version alternatives; appetite discipline; change-control protocol.
- [`risks-and-assumptions.md`](references/risks-and-assumptions.md). Step 8 three-way boundary (risk vs. assumption vs. open question); owner/due/blocking discipline; assumption-validation tracker.
- [`prd-anatomy.md`](references/prd-anatomy.md). Full annotated PRD template; section order; length conventions; downstream handoff block full template; PR-FAQ / Working Backwards optional mode.
- [`prd-antipatterns.md`](references/prd-antipatterns.md). The named antipatterns; Mode C audit procedure; tier-gate audit; banned-phrase grep list.
- [`stakeholder-alignment.md`](references/stakeholder-alignment.md). Step 10 sign-off roster by tier; per-role attestations; pre-sign-off walkthrough; async sign-off; common disagreements.
- [`iterate-vs-freeze.md`](references/iterate-vs-freeze.md). Step 11 four lifecycle states; change-control protocol; in-scope vs. new-PRD thresholds; broadcast discipline; when Tier 1 is enough.
- [`RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md). Source citations behind every rule, failure mode, and have-not; canonical literature from Cagan, Horowitz, Lenny Rachitsky, Intercom, Shape Up, Amazon Working Backwards, Biddle DHM, Reforge, Atlassian, HashiCorp, Fishman, Aakash Gupta.

## Contributing

Gaps, missing cases, outdated guidance, new banned phrases, new incident citations: contributions welcome. Open an issue or PR. The banned-phrase list is especially alive; new AI-slop tells emerge with each model generation, and the list is versioned accordingly.

## License

[MIT](LICENSE)

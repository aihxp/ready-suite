# DOGFOOD.md: what running the ready-suite end-to-end taught us

This document is the reflection that closes the dogfood exercise. The eleven artifacts in this repo are the output; this file is the meta-output: what running the suite end-to-end on a fictional but rigorously-specified product surfaces about the suite's discipline.

The shape of this document follows the suite's own honesty discipline: name what worked, name what didn't, name what would change in a v1.x of the suite based on the friction observed.

## What worked

### The artifact-as-contract principle pays for itself

The downstream artifacts are written by a different agent context than the upstream ones. When `architecture-ready` reads `.prd-ready/PRD.md`, it has zero conversational memory of the prd-ready session; it has only what's on disk. This forces the PRD to be self-sufficient: every reference architecture-ready needs (the threat model, the persona names, the Must / Should / Could ranks, the no-gos, the appetite) is present without re-derivation.

The same applies down the chain: roadmap-ready reads PRD + ARCH; stack-ready reads PRD + ARCH + ROADMAP; production-ready reads all four planning artifacts. Each agent picks up cold. The artifacts are the entire contract.

The friction point this prevents: an agent that has been in-session for the planning tier might "remember" decisions that were never written down, then make architecture choices that depend on those un-written decisions. Six weeks later the engineer is debugging a feature whose rationale is "the agent decided this in some earlier session that we don't have a record of." Artifact-as-contract makes this impossible at the cost of artifact density.

### Named failure modes are mechanically catchable

Every artifact in this repo has a "what this skill refused" section that lists the failure modes the skill exists to prevent. The grep tests are concrete:

- The PRD is not "hollow" because every R-NN entry has acceptance criteria. (Grep test: `grep -E "^- \*\*R-[0-9]+ \(Must\)" .prd-ready/PRD.md` yields rows; each row has an acceptance line within 3 lines.)
- The architecture is not "paper-tiger" because every NFR maps to a mechanism with named code path.
- The roadmap's parallelism is not "fictional" because the slice queue lists at most one primary owner per week per engineer.
- The stack picks are not "vibe-stack" because every category has a scored shortlist with rationale.

The friction point this catches: AI-generated planning that uses the right vocabulary without the underlying rigor. ChatGPT can produce a document with section headers labeled "Problem," "Personas," "Success Metrics," "Requirements" - and fill each one with prose that fails every grep test. The named-failure-mode discipline is what makes the difference between filling sections and making decisions.

### The compose-by-artifact narrative is real, not theatrical

You can read the artifacts in dependency order and watch the decisions accumulate. The PRD says "multi-tenant from day 1, HubSpot at v1.0, magic-link auth, $400/mo cap." The architecture answers "single-schema with tenant-id discipline (ADR-001), Auth.js v5 with OIDC migration path (ADR-002), single deployable + worker (ADR-003)." The roadmap sequences the slices in the order the architecture's dependency graph requires. The stack picks the technologies that satisfy each architecture constraint. The deploy plan, observability plan, and pen-test scope all reference the trust boundaries declared in `.architecture-ready/ARCH.md` §6.

A reader who walks the artifacts top-to-bottom can say: at each step, the choice was constrained by the prior artifact, and the next artifact carries the choice forward. Nothing is invented; nothing is contradicted; nothing is silently re-decided.

This is the suite's strongest claim, and it survives end-to-end on Pulse.

### Standards-tracking pays off in unexpected ways

The suite's recent moves to track agentskills.io, AGENTS.md, and DESIGN.md (Google Labs) all show up here:

- The `compatible_with` frontmatter in each skill repo lets any AgentSkills-compatible harness run the skill first-class. This dogfood would work on Codex, Cursor, Windsurf, pi, OpenClaw, etc., not just Claude Code.
- The `AGENTS.md` at project root mirrors the artifact map; any non-Claude harness arriving at this repo cold sees the suite's output.
- The `DESIGN.md` at project root in the Google Labs format means the design system is shareable beyond the suite. A future component-library tool, a shadcn/ui re-skinner, a Stitch-style design renderer can consume the same `DESIGN.md` and produce consistent UI.

The friction point this prevents: a private skill format that locks the suite's value into one harness. The suite is a thin layer over open standards; consumers can swap harnesses without rebuilding.

## What didn't work (or worked with friction)

### `launch-ready` doesn't fit the pilot model cleanly

Pulse's PRD says "the pilot is private; no public launch v1.0." `launch-ready` was recorded as `skipped (v1.1 scope)` in the kickoff PROGRESS.md. But `launch-ready` is a Tier-1 sibling in the shipping tier; recording it as skipped feels like a workaround.

The suite's Pattern is "every pilot product needs every shipping-tier sibling." This pattern doesn't quite fit Pulse:

- `deploy-ready` runs (cutover to DartLogic prod).
- `observe-ready` runs (operations during pilot).
- `harden-ready` runs (week-12 pen-test).
- `launch-ready` doesn't run. Pilot is private.

The kickoff-ready discipline accommodates skips with named reasons, which is correct. But it surfaces a pattern in the suite: `launch-ready` assumes a public-facing launch. Many B2B SaaS products have a private pilot phase before public launch. The suite's tier model implicitly equates "shipping" with "launching publicly," which is wrong for the pilot phase.

**What would change in v1.x of the suite:** consider splitting `launch-ready` into two skills, or adding a "private-pilot" mode to `launch-ready` that handles pilot-marketing artifacts (the joint case-study post DartLogic and Pulse will publish at week 14 is real launch-marketing work; right now it has nowhere to live in the suite). Alternative: leave `launch-ready` scoped to public launches and accept that pilot products skip it.

### The PRD's appetite is hard to keep honest under fictional conditions

The PRD's appetite says "14 weeks fixed; scope is the variable." The roadmap reconciles capacity (140 eng-days) against a plan that uses 70 eng-days, leaving 50% slack. That slack is named for risk mitigation and Should/Could items.

In a real project, the slack always disappears. Unanticipated work eats it. Half the team gets sick for a week. The HubSpot integration takes 8 days instead of 5. By week 10 the slack is gone and someone is asking which Should drops.

The fictional dogfood doesn't surface this friction because nothing real is happening. The roadmap's slack reconciliation looks healthy because no real schedule pressure exists. **A real dogfood would discover that the slack column is the most important number on the roadmap, and that the roadmap's discipline pays for itself when the slack is being spent (not when it's being protected).**

The artifact passes its own grep tests. But the artifact's value isn't in passing grep tests; it's in catching the reality that fiction can't simulate. This is a limitation of the dogfood-without-real-users format, and it's why the user originally said "real adoption proof requires a real project."

### Some skills produce thinner artifacts than others

Looking across the eleven artifacts:

- **production-ready/STATE.md** (~120 lines): mid-build snapshot. Lighter because the artifact is a state ledger, not a design document. This is correct.
- **deploy-ready/DEPLOY.md** (~250 lines): meaty. Cutover playbook + rollback policy + cost guardrails + named failure-mode refusals.
- **observe-ready/OBSERVE.md** (~280 lines): meaty. SLOs + alert routing + four runbooks + structured-logging discipline + dashboard catalog + on-call rotation.
- **harden-ready/FINDINGS.md** (~290 lines): meaty. Eight findings with root-cause + remediation + evidence + sign-off.
- **kickoff-ready/PROGRESS.md** (~180 lines): meta-artifact. The audit ledger. Length is right for what it does.
- **prd-ready/PRD.md** (~200 lines): tight. Could be longer; in real projects PRDs run 2-5x this length.
- **architecture-ready/ARCH.md** (~230 lines): tight. ADRs are concise; could go deeper on each.
- **roadmap-ready/ROADMAP.md** (~180 lines): about right.
- **stack-ready/STACK.md** (~290 lines): meaty. Nine categories + ADRs.
- **repo-ready/SCAFFOLD.md** (~95 lines): on the lighter side, but this is appropriate; repo-ready's output is the scaffold itself, not a description of it.

The PRD and ARCH could go deeper. In a real project, the PRD would have user-research evidence, prior-art research, persona interview transcripts, competitive analysis. The ARCH would have more ADRs (10-15 vs. the 3 here), data-flow diagrams, capacity-planning math. The fictional version is rigorous but compressed.

**What would change in v1.x of the suite:** maybe nothing. The compression is a feature of the dogfood format; real projects would expand naturally.

### The suite asks the agent to write a lot of meta-content

Every artifact in this repo has a "What this skill refused" or "Why this is not a [hollow / paper / theater] artifact" or "Failure modes refused" section. These sections are useful for verification but they are also a real word-count tax.

In a real project, an engineer reading the PRD doesn't need the "Why this is not a hollow PRD" section; they're either an engineer who can tell, or they're someone whose hollow-ness detection is at the substitution-test level (where the section adds value). The middle ground (engineer who needs to be told "this PRD passes its own grep tests") is small.

**What would change in v1.x of the suite:** the meta-sections could move from per-artifact to a "skill audit" that runs on demand against the artifact and produces a separate audit document. The artifact stays clean; the audit is available when wanted. Today the meta-sections are inline; this works but creates artifact bloat.

### Trigger disambiguation has one real-world unresolved issue

The TRIGGER-DISAMBIGUATION.md table covers ~40 cases. One the dogfood surfaces:

- "Performance work" (build it fast vs. monitor it stays fast) is documented as production-ready vs. observe-ready. But mid-build performance regression detection (a slice that was 800ms p95 on staging is 1200ms p95 on production) isn't owned by either skill cleanly. production-ready built the slice; observe-ready monitors prod. The "the slice regressed in prod after deploy" handoff lives between them.

The dogfood doesn't fix this because it's a real ambiguity. The pen-test (harden-ready) and the SLO breach (observe-ready) both surface it; neither owns the build-side fix.

**What would change in v1.x of the suite:** add a row to TRIGGER-DISAMBIGUATION.md naming this case explicitly. The fix is documentation; the underlying problem is an artifact of the suite's tier separation (build vs. observe), which is itself a feature, not a bug.

## What this dogfood doesn't prove

A fictional product, however rigorous, doesn't prove:

- **Real users adopt the suite.** No one outside the maintainer has run this end-to-end on a real project (that I know of). The dogfood is one example; real adoption requires real projects with real failure modes.
- **The artifacts catch real bugs.** The harden-ready findings (F-01 through F-08) are plausible, but they're invented. A real pen-test produces findings that surprise the architecture (or it should); fictional findings can't surprise their author.
- **The cost ceiling holds in practice.** $50/mo of a $400/mo cap looks healthy. A real pilot would discover that one Vercel traffic spike, or one Resend volume bump, or one Axiom log-volume month uses 5x the headroom. The dogfood can't simulate operational reality.
- **The team can actually execute the roadmap.** The 14-week plan with 50% slack is plausible. A real team would discover their effective-day count is closer to 3 days/week than 4, or that the HubSpot integration takes 8 days instead of 5, or that the pen-test surfaces a Critical that takes a week to fix. The dogfood is best-case-fiction.
- **The team agrees with the named failure-mode discipline.** Some teams prefer iterative PRDs over upfront frozen ones; some teams prefer Stripe-y stacks over Vercel-y ones; some teams want a more elaborate ROADMAP (Now-Next-Later is opinionated; not everyone runs Shape Up cadence). The suite is opinionated, and the dogfood reflects those opinions. A real team might disagree with several of them.

The dogfood is **necessary but not sufficient** for the adoption case. It's the artifact that proves the artifacts compose; it's not the artifact that proves the artifacts are valuable in practice.

## How this dogfood will be maintained

The dogfood is frozen at the moment of this write-up. The Pulse story doesn't continue past the M3 paying-pilot ceremony (week 14, fictional date 2026-08-08). If the suite changes (new version of a skill, new compatibility frontmatter, new failure mode named), this repo will be updated to reflect the canonical artifact format, but the Pulse-specific content will not get richer.

**Why frozen:** the dogfood's value is as a static reference. A reader can `git clone` and walk through one coherent example. If the example kept changing, the value-proof would be diluted by maintenance churn. Future dogfoods (a different fictional product at a different scale) would land in their own repos.

If a real project running the suite wants to publish their artifacts as a community-contributed example, that becomes a separate `aihxp/ready-suite-real-example-X` repo or a community-contributed list in the hub README. The dogfood pattern is reproducible.

## TL;DR

The suite holds up end-to-end on a fictional B2B SaaS product. Every artifact is rigorous; every cross-reference works; every skill's named failure modes are grep-testable on its own output. The discipline survives the dogfood test.

The dogfood does not prove real-world adoption. It proves the artifacts compose; it doesn't prove the artifacts are useful in practice. That proof requires a real project with real users, real schedule pressure, and real failure modes that the fiction can't simulate.

For now: this is the strongest evidence the suite has shipped. A reader can `git clone aihxp/ready-suite-example` and see what running the suite produces. The friction surfaces named above are honest critiques the suite's v1.x roadmap can address.

The suite is opinionated. So is this reflection.

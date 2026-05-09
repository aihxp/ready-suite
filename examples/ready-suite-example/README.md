# ready-suite-example

> **End-to-end reference: the [ready-suite](https://github.com/aihxp/ready-suite) applied to a fictional B2B SaaS product (Pulse). All eleven artifacts on disk, with cross-references intact, so you can see what running the suite actually produces.**

This repo is **not a real product**. It is a static reference: the artifacts that the eleven ready-suite skills produce, shown in their canonical `.{skill}-ready/` paths the way a real project running the suite would have them on disk. Use it to:

- Understand what the suite outputs end-to-end.
- See how the artifacts cross-reference each other (PRD references are real; clicking through works).
- Compare the worked-example references in each skill repo to a complete project that uses them all.
- Read the [DOGFOOD.md](./DOGFOOD.md) reflection on what the suite caught, what it missed, and where the discipline pays for itself.

For the suite itself (the eleven skills + the hub), see https://github.com/aihxp/ready-suite.

## The fictional product: Pulse

**Pulse** is a Customer Success ops platform for B2B SaaS account managers. The pilot customer is **DartLogic**, a 38-person B2B SaaS in San Francisco. The pilot is 14 weeks; the team is 5 people; the budget cap is $400/mo. The pilot signs a 12-month paid contract on success at week 14.

None of this is real. The product, the company, the people, the metrics, and the dates are fictional. The artifacts are detailed and rigorous (they pass the suite's own grep tests for failure modes); they would be a coherent starting point for a real Pulse-like project.

## The eleven artifacts

```
.kickoff-ready/PROGRESS.md           - audit ledger of the kickoff arc
.prd-ready/PRD.md                    - product requirements (frozen v1.0)
.architecture-ready/ARCH.md          - system architecture + ADRs
.roadmap-ready/ROADMAP.md            - 14-week pilot roadmap with capacity
.stack-ready/STACK.md                - 9-category ranked stack with ADRs
.repo-ready/SCAFFOLD.md              - what repo-ready set up at week 1
.production-ready/STATE.md           - mid-build slice tracker (week 9 of 14)
.deploy-ready/DEPLOY.md              - cutover plan + runbook
.observe-ready/OBSERVE.md            - SLOs + alert routing + runbooks
.harden-ready/FINDINGS.md            - week-12 pen-test (8 findings, all closed)
(.launch-ready/                       - empty: launch is v1.1 scope; recorded as skipped)
```

Plus the project-root files that the suite produces or expects:

- `AGENTS.md` (cross-tool agent brief, emitted by kickoff-ready Step 6 sub-step 6a)
- `DESIGN.md` (Google Labs format; design tokens, scaffolded by production-ready Step 3 after the visual identity settled)
- `LICENSE`, `.gitignore`

## Read order

For a first read, start with the planning tier in dependency order, then walk down the tier ladder:

1. [`.kickoff-ready/PROGRESS.md`](.kickoff-ready/PROGRESS.md) - the audit ledger; lays out the whole arc
2. [`.prd-ready/PRD.md`](.prd-ready/PRD.md) - what is being built, for whom, with what success criteria
3. [`.architecture-ready/ARCH.md`](.architecture-ready/ARCH.md) - the system shape, trust boundaries, ADRs
4. [`.roadmap-ready/ROADMAP.md`](.roadmap-ready/ROADMAP.md) - the 14-week sequence with capacity input
5. [`.stack-ready/STACK.md`](.stack-ready/STACK.md) - the technology picks
6. [`.repo-ready/SCAFFOLD.md`](.repo-ready/SCAFFOLD.md) - the repo scaffolding
7. [`.production-ready/STATE.md`](.production-ready/STATE.md) - the mid-build slice tracker
8. [`.deploy-ready/DEPLOY.md`](.deploy-ready/DEPLOY.md) - the cutover plan
9. [`.observe-ready/OBSERVE.md`](.observe-ready/OBSERVE.md) - SLOs + runbook
10. [`.harden-ready/FINDINGS.md`](.harden-ready/FINDINGS.md) - the pen-test results
11. [`DOGFOOD.md`](DOGFOOD.md) - what the suite caught and what it missed

Then the top-level files: [`AGENTS.md`](AGENTS.md), [`DESIGN.md`](DESIGN.md).

## What this repo demonstrates

- **Composition by artifact, not by RPC.** Each downstream artifact reads from the prior ones and refines, never duplicates. The PRD frames the problem; the architecture answers the how; the roadmap sequences the what; the stack picks the with what. No skill calls another; the artifacts are the contract.
- **Refusal of named failure modes.** Each artifact has a "what this skill refused" section grep-testable against its own discipline. The PRD is not hollow / invisible / feature-laundry / solution-first / assumption-soup / moving-target. The architecture is not theater / paper-tiger / cargo-cult / stackitecture. The roadmap is not fictional-precision / fictional-parallelism / quarter-stuffing / speculative / feature-factory / shelf / theater. Etc.
- **Cross-tool standards alignment.** The repo carries an `AGENTS.md` (cross-tool agent brief, Linux Foundation Agentic AI Foundation standard) and a `DESIGN.md` (Google Labs format, Apache 2.0). Any harness that reads these formats can pick up the project cold.
- **Tag-release parity, byte-identical SUITE.md, em-dash discipline.** The hub's mechanical lint (`scripts/lint.sh` in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)) enforces these across the twelve suite repos. This dogfood repo doesn't run the lint (it's a single-repo example), but the same conventions apply to its own discipline.

## What this repo doesn't have

- **Source code.** This is artifact-only. The eleven artifacts on disk are what the suite's planning + design + hardening produces; the actual application code is not part of the demonstration. (A real Pulse project would have the Next.js app at `src/`, but the suite's value is in the artifact layer.)
- **Real users.** No paying customer. No production deployment. The dates are fictional; the metrics are fictional; the sign-offs are fictional.
- **A claim of authority.** The Pulse product is one shape of B2B SaaS, sized at one specific stage. The suite produces different artifacts for different products at different stages. This repo is one example, not a template every project should copy.

## License

MIT. Use freely.

## Related

- [aihxp/ready-suite](https://github.com/aihxp/ready-suite) - the suite hub, install scripts, lint, and discovery
- Per-skill repos: [prd-ready](https://github.com/aihxp/prd-ready), [architecture-ready](https://github.com/aihxp/architecture-ready), [roadmap-ready](https://github.com/aihxp/roadmap-ready), [stack-ready](https://github.com/aihxp/stack-ready), [repo-ready](https://github.com/aihxp/repo-ready), [production-ready](https://github.com/aihxp/production-ready), [deploy-ready](https://github.com/aihxp/deploy-ready), [observe-ready](https://github.com/aihxp/observe-ready), [launch-ready](https://github.com/aihxp/launch-ready), [harden-ready](https://github.com/aihxp/harden-ready), [kickoff-ready](https://github.com/aihxp/kickoff-ready)
- Each skill repo carries a `references/EXAMPLE-<artifact>.md` worked-example file; the canonical content of those examples lives here at the canonical paths.

# Composing the ready-suite with orchestrators

Ready-suite skills are orchestrator-agnostic by design. They work with any harness that handles skill routing: plain Claude Code, Codex, Cursor, Windsurf, GSD (get-shit-done), BMAD, Superpowers, or a custom orchestrator. The principle is one-way: an orchestrator can know about ready-suite skills and invoke them at the right moment; ready-suite skills do not know about, and do not invoke, each other or any orchestrator.

This file documents what composing looks like in practice.

## The principles

1. **The harness is the router.** No ready-suite skill calls another. The harness or the orchestrator chooses which skill fires when.
2. **Artifacts are the contract.** Skills do not pass arguments; they read and write files at known paths (`.{skill}-ready/*.md`). Any orchestrator can sit between two skills as long as it preserves the artifacts.
3. **Project-level state is the orchestrator's job.** Phases, milestones, roadmap, sign-off ceremony belong to whatever orchestrates the project. Ready-suite skills track their own intra-skill state in `.{skill}-ready/STATE.md` files; the orchestrator owns the project view above that.
4. **Skills work standalone.** Every skill runs without an orchestrator present. The composition is opt-in.

## Pattern: GSD as orchestrator

GSD (get-shit-done) is a phase- and milestone-oriented workflow framework. Its commands map cleanly onto ready-suite skills at phase boundaries. The integration runs entirely in GSD's command prompts; ready-suite stays unchanged.

| GSD command | Ready-suite invocation |
|---|---|
| `/gsd-new-project` | Starts the planning tier. Optionally invokes `prd-ready` to write `.prd-ready/PRD.md`, then `architecture-ready` for `.architecture-ready/ARCH.md`, then `roadmap-ready` for `.roadmap-ready/ROADMAP.md`. Stack picked via `stack-ready` once architecture is settled. |
| `/gsd-plan-phase` | Reads existing `.{skill}-ready/*.md` planning artifacts to pre-fill phase decisions. Invokes the relevant planning-tier skill if the phase requires fresh planning (e.g., a new sub-feature with its own success criteria fires `prd-ready`). |
| `/gsd-execute-phase` | Maps to building tier. Invokes `production-ready` for app feature work, `repo-ready` for repo hygiene work. The phase's slice queue (from roadmap-ready) becomes production-ready's vertical-slice input. |
| `/gsd-ship` | Maps to shipping tier. Invokes `deploy-ready` to cut the release, then `observe-ready` to wire dashboards and alerts, then `launch-ready` if there is a public-facing launch component. |
| `/gsd-secure-phase` | Invokes `harden-ready` for adversarial review of the phase output. Consumes architecture trust boundaries, production-ready threat model, deploy-ready environment list, observe-ready alert catalog. |
| `/gsd-code-review` | Invokes `production-ready` Tier 4 verification (have-nots scan, hollow-check, contract tests). Optionally invokes `harden-ready` for security-focused review. |
| `/gsd-verify-work` | Invokes `production-ready` proof tests for each completed slice. |
| `/gsd-audit-milestone` | Invokes `harden-ready` if the milestone touches security-sensitive surfaces. Otherwise pure GSD audit. |

The integration cost is entirely in GSD: each command's prompt gets a few additional lines describing when to invoke which sibling skill. Ready-suite is consumed, not modified. New ready-suite skills released later inherit the composition pattern without GSD code changes.

## Pattern: BMAD as orchestrator

BMAD's Greek-named agent personas (Architect, PM, QA, Dev, etc.) overlap with several ready-suite skills. Two integration shapes work; pick one per project.

**Shape A: BMAD owns the planning tier; ready-suite owns building and shipping.** BMAD's PM and Architect agents produce equivalents of PRD.md and ARCH.md (call them `docs/prd.md` and `docs/architecture.md` in BMAD parlance). At the planning-to-building handoff, write the BMAD outputs into `.prd-ready/PRD.md` and `.architecture-ready/ARCH.md` paths so building- and shipping-tier ready-suite skills can read them. From that point forward, ready-suite drives. Pros: each side does what it is good at. Cons: requires path translation at one boundary.

**Shape B: BMAD off for ready-suite projects.** If the project is using ready-suite, do not also run BMAD. Pick one orchestration philosophy per project. This is the cleanest interop and the lowest cognitive load.

Mixing BMAD personas with ready-suite skills inside the same session creates a fragmented workflow. The persona-driven model (BMAD) and the harness-routed model (ready-suite) can compose at boundaries but should not compose within a single feature build.

## Pattern: Superpowers (working-style skills) alongside ready-suite

Superpowers and similar plugin families ship working-style skills like `/think-harder`, `/brainstorm`, `/tdd`, `/research`. These operate at a different layer than ready-suite: they shape how the agent reasons within a session, not what artifacts the session produces.

The two compose orthogonally with zero integration work. A user can invoke `/think-harder` mid-session while building with `production-ready`. There is no overlap to resolve.

The only soft duplication: each ready-suite planning-tier skill has its own research pass (`references/RESEARCH-*.md`), and Superpowers ships a generic `/research` skill. Use whichever is preferred; they do not conflict, but running both on the same question is redundant.

## Pattern: plain Claude Code, Codex, Cursor, Windsurf (no orchestrator)

The default. The user types a request, the harness routes to the matching ready-suite skill by trigger word, the skill runs end-to-end. No orchestration layer required. This is what every ready-suite skill assumes is the baseline.

The harness's skill-routing decision is what makes the "tight scope per skill" principle valuable: when triggers are precise and non-overlapping, the harness can route correctly without ambiguity.

## What ready-suite refuses to do

- **No skill invokes another.** A ready-suite skill does not call `production-ready` from inside `deploy-ready`, even when the dependency is obvious. The orchestrator (or the user) makes that call.
- **No skill stores project-level state.** STATE.md files inside `.{skill}-ready/` are intra-skill working memory, not project ledgers. If the project needs a phase or milestone tracker, that is the orchestrator's responsibility (or a manual file).
- **No skill knows about a specific orchestrator.** Ready-suite never gains a "GSD mode" or a "BMAD mode." Coupling to an orchestrator would defeat the orchestrator-agnostic principle and would force ready-suite to track every orchestrator's evolution.

## What ready-suite welcomes

- **An orchestrator that documents its ready-suite invocation pattern in its own command prompts**, the way GSD does in the table above.
- **A skill that reads ready-suite artifacts** (`.prd-ready/PRD.md`, `.architecture-ready/ARCH.md`, etc.) to pre-fill its own work, and writes its outputs back into the same artifact-shaped files when relevant.
- **A harness that improves skill-trigger precision**, so the routing layer stays accurate as more skills get added to the user's installed set.

## When the orchestrator is wrong about which skill to invoke

The user is the final authority. If a harness or orchestrator routes to the wrong skill, the user can invoke the right one explicitly by name. Ready-suite skills are addressable directly; nothing requires going through an orchestrator.

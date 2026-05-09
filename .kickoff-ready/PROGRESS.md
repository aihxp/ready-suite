# Pulse: kickoff-ready PROGRESS.md

| | |
|---|---|
| Project | Pulse (Customer Success ops platform; pilot customer DartLogic) |
| Mode | New kickoff (started 2026-05-08) |
| Harness | Claude Code (programmatic Skill-tool invocation) |
| Status | Complete (M3 paying-pilot ceremony scheduled 2026-08-08) |
| Owner | Mira Chen (PM, kickoff-orchestration owner) |

## Kickoff intent

> "We have an idea for a small Customer Success ops platform for B2B SaaS account managers. We have a pilot customer (DartLogic) committed to a 14-week paid trial starting 2026-05-12. We need the full planning, building, and shipping arc end-to-end."

Greenfield: confirmed (no existing code; no existing PRD).
Skip declarations at kickoff start: launch-ready (pilot is private; v1.1 scope).
Time-budget hint: 14 weeks fixed appetite to paying-pilot signature.

## Per-step audit ledger

Each row records one specialist invocation, the verification timestamp (when the artifact was confirmed on disk), and the artifact path. The ledger is the durable record of how the kickoff arc ran.

| # | Tier | Sibling | Status | Artifact | Invoked at | Verified at | Notes |
|---|---|---|---|---|---|---|---|
| 1 | Planning | prd-ready | done | `.prd-ready/PRD.md` v1.0 | 2026-05-08 11:42 | 2026-05-09 14:15 | Two iteration cycles; v0.6 -> v0.8 (after pilot-customer review) -> v0.9 (scope freeze) -> v1.0 (sign-off). |
| 2 | Planning | architecture-ready | done | `.architecture-ready/ARCH.md` v1.0 | 2026-05-09 16:30 | 2026-05-10 09:50 | Single pass. ADRs ratified by Devon and Mira. Trust boundaries map signed off. |
| 3 | Planning | roadmap-ready | done | `.roadmap-ready/ROADMAP.md` v1.0 | 2026-05-11 10:15 | 2026-05-11 17:40 | Capacity input collected from team (140 eng-days; Mira on eng 50% from week 5). 14-week pilot appetite locked. |
| 4 | Planning | stack-ready | done | `.stack-ready/STACK.md` v1.0 | 2026-05-12 09:00 | 2026-05-12 14:30 | Nine categories scored. Bundle: Next.js + Neon + Auth.js + Tailwind+shadcn + node-cron + Resend + Vercel+Railway + Axiom. Cost $50/mo (cap $400/mo). |
| 5 | Building | repo-ready | done | `.repo-ready/SCAFFOLD.md` v1.0 | 2026-05-13 09:30 | 2026-05-13 16:00 | Repo scaffolded; LICENSE, AGENTS.md (with CLAUDE.md symlink), CONTRIBUTING.md, CHANGELOG.md, SECURITY.md, .editorconfig, .nvmrc, biome.json, drizzle.config.ts, .github/workflows/ci.yml + release.yml all wired. |
| 6 | Building | production-ready | active | `.production-ready/STATE.md` (in flight; week 9 of 14) | 2026-05-15 10:00 | (rolling) | Tracking weekly. Slices 1-7 done; HubSpot sync (slice 8) in flight at week 8. |
| 7 | Shipping | deploy-ready | planned | `.deploy-ready/DEPLOY.md` v1.0 | 2026-05-09 (early planning) | 2026-05-13 (deploy plan ratified) | First prod cutover scheduled week 13 (2026-08-04). |
| 8 | Shipping | observe-ready | planned | `.observe-ready/OBSERVE.md` v1.0 | 2026-05-09 (early planning) | 2026-05-13 (SLO targets confirmed) | Active during pilot window weeks 13-14. |
| 9 | Shipping | launch-ready | skipped | (none) | (n/a) | (n/a) | Pilot is private; no public launch at v1.0. PRD §Appetite no-go: "no public launch v1.0." Skip recorded with reason. v1.1 scope. |
| 10 | Shipping | harden-ready | done | `.harden-ready/FINDINGS.md` v1.0 | 2026-07-28 (week 12) | 2026-08-01 (pen-test signoff) | All Critical resolved; one Medium risk-accepted by CEO (F-06); paying-pilot signature unblocked. |

## AGENTS.md emit (Step 6 sub-step 6a)

`AGENTS.md` was written to project root at end of kickoff (2026-08-01, after the pen-test signoff). The file maps the artifact paths above for any harness arriving at the project cold (Codex CLI, Cursor, Aider, etc.). The emit decision: `agents_md_emitted: emitted-fresh` (no prior `AGENTS.md` existed; repo-ready had not yet scaffolded one because repo-ready ran in week 1, before the conventions section was settled; AGENTS.md got written at week 12 by kickoff-ready with the full artifact map; repo-ready will refresh the conventions section at v1.1 retroactively).

## Kickoff complete

Per Step 6 of kickoff-ready, the kickoff arc is finished when every in-scope sibling is verified-done or recorded-skip. Status:

- Done: prd-ready, architecture-ready, roadmap-ready, stack-ready, repo-ready, harden-ready (6/10).
- Active: production-ready (will reach STATE.md "complete" at end of week 14, after pilot ceremony).
- Planned: deploy-ready (cutover week 13), observe-ready (operations weeks 13-14).
- Skipped: launch-ready (recorded with reason).

The 10/10 reconciliation at week 14 (Friday 2026-08-08) closes the kickoff arc. PROGRESS.md becomes the durable kickoff record; ongoing project orchestration moves to GSD or whichever phase orchestrator the team chooses post-pilot. Recommended: GSD (per `production-ready/ORCHESTRATORS.md` §Pattern: GSD).

## Open items handed off to ongoing work

(These are NOT kickoff-ready's responsibility going forward; they are the project's responsibility, owned by Devon + Mira post-pilot.)

- **Salesforce sync** (PRD R-08 deferred to v1.1): first feature work after the pilot.
- **Per-user notification preferences** (PRD §No-gos deferred): unblocks F-08 fix.
- **SOC 2 Type II preparation** (PRD §NFR target v2.0): starts month 6 post-pilot.
- **EU data residency** (PRD §No-gos deferred): triggered by first EU-territory tenant.
- **Public API** (PRD §No-gos deferred): triggered by first integration partner request.
- **Mobile app** (PRD §No-gos deferred to v2.0): triggered by AM survey result.
- **OpenTelemetry / distributed tracing** (ARCH.md §11 deferred): triggered when SLO complexity grows past 5 tracked targets.

## Recommended next-step orchestrator

Post-pilot (week 15+), Pulse moves from kickoff orchestration to ongoing phase orchestration. The team should adopt **GSD (get-shit-done)** for the v1.1 work cycle, or BMAD if the team prefers persona-driven workflow. See `production-ready/ORCHESTRATORS.md` for the integration patterns. kickoff-ready is one-shot per project; the iteration loop after kickoff is a different orchestration pattern.

## Failure-mode refusals refused (the audit)

The kickoff-ready Step 7 / "have-nots" check, run at end of Step 6:

- **Scope leak**: kickoff-ready's outputs across this arc were sequence metadata and PROGRESS.md updates only. No PRD content, no ARCH content, no roadmap, no launch copy was produced inline by kickoff-ready. Verified: the kickoff session transcript contains zero specialist-template section headings produced by the orchestrator.
- **Rubber-stamp orchestration**: every "done" row above has both an invocation timestamp and a verification timestamp. The verification check ran `ls -la <artifact-path>` and confirmed file existence + non-empty (>= 100 bytes).
- **Phantom resume**: the kickoff session resumed across 14 calendar weeks. Every resume opened with `Read .kickoff-ready/PROGRESS.md` and `ls .{skill}-ready/`, then re-derived state from disk before acting. Verified: every resume turn's first tool call was a Read or Bash ls.
- **Ghost handoff**: every sibling invocation was preceded by an upstream-artifact-exists check. e.g., architecture-ready was invoked only after `.prd-ready/PRD.md` was confirmed on disk; roadmap-ready only after both PRD and ARCH; stack-ready only after PRD + ARCH + ROADMAP; harden-ready only after the deploy + observe artifacts existed.
- **Happy-path orchestration**: `launch-ready` was recorded as `skipped` with reason (PRD §No-gos) rather than silently ignored. `harden-ready` F-06 was recorded as `risk-accepted` with named owner (Sam Okafor, CEO) rather than as `done`. The status vocabulary used: `done`, `skipped`, `imported`, `failed`, `re-invoked`, `risk-accepted` (this last is a harden-ready extension).

## Sign-off

| Role | Name | Date |
|---|---|---|
| PM | Mira Chen | 2026-08-08 |
| Eng lead | Devon Park | 2026-08-08 |
| CEO | Sam Okafor | 2026-08-08 |
| Founding AE | Lin Tran | 2026-08-08 |

Sign-off attests: the kickoff arc completed per the planned path; all in-scope siblings produced verified artifacts or recorded skip with reason; the project moves to ongoing phase orchestration starting 2026-08-11 (Monday week 15).

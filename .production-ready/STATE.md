# Pulse: production-ready STATE.md

| | |
|---|---|
| Tier | Tier 2 (matches PRD tier) |
| Status | Active build (mid-Next, week 9) |
| Last updated | 2026-05-09 (week 9 review) |
| Owner | Devon Park (eng lead) |

## What this file is

production-ready's intra-skill state ledger. Tracks which slices from the roadmap (`.roadmap-ready/ROADMAP.md`) are done, in-flight, blocked, or deferred. Updated at every tier boundary and every weekly review.

## Slice status

### Now (weeks 1-6) - complete

| Slice | PRD ref | Status | Verified |
|---|---|---|---|
| 1. Foundation: tenant + user + magic-link sign-in | R-01, R-07 (auth half) | Done (week 1) | M1 demo |
| 2. Mock-data ingest path (CSV) | R-06 placeholder | Done (week 2) | 100 DartLogic accounts loaded |
| 3. Account list view (per-AM) | R-02 | Done (week 3) | 800ms p95 verified at 100 accounts |
| 4. Account detail page (read-only) | R-02, R-03 prep | Done (week 4) | Lin reviewed; layout approved |
| 5. Touchpoint log | R-03 | Done (week 5) | 4s end-to-end median; L-2 instrumentation live |
| 6. M1 gate, demo to DartLogic | (gate) | Done (week 6) | Pilot CSV ingested; DartLogic feedback captured |

### Next (weeks 7-12) - in flight

| Slice | PRD ref | Status | Notes |
|---|---|---|---|
| 7. At-risk flag | R-04 | Done (week 7) | Devon's mock Manager view shows flagged accounts |
| 8. HubSpot sync (one-way) | R-06 | **In flight (week 8)** | DartLogic OAuth connected; first poll succeeds; rate-limit smoke tests passed; conflict policy verified on 3 sample updates. Risk-01 (rate limits) is the active concern; staggering implemented. |
| 9. Manager view + RBAC | R-07 (full) | Pending (week 8) | Generalist starts after HubSpot sync stabilizes |
| 10. At-risk pattern matcher + email | R-05 | Pending (week 9) | Patterns: no-touch-30d, support-ticket-cluster, NPS-drop. Implemented but threshold-tuning ongoing |
| 11. Slack notification (Should) | R-09 | At risk | If R-10 + R-11 also need to ship, R-09 is the first cut |
| 12. Manager weekly digest (Should) | R-11 | Planned (week 10-11) | Held for capacity check at week 9 |
| 13. Reassignment audit log (Should) | R-10 | Planned (week 10-11) | Held for capacity check at week 9 |
| 14. Audit log + admin tools | R-07 admin half + NFR audit | Planned (week 11) | |
| 15. Pen-test week | NFR Security | Scheduled (week 12) | External pen-tester contracted: HackerOne triage |

### Later (weeks 13-14) - planned

| Slice | PRD ref | Status |
|---|---|---|
| 16. Pilot deployment to DartLogic prod | (deploy gate) | Planned |
| 17. Pilot week 1: pattern tuning, latency review, sync health | (operations) | Planned |
| 18. M3 paying-pilot ceremony | M3 | Scheduled (week 14) |

## Visual identity (Step 3)

Resolved at week 4 via sub-step 3b (no DESIGN.md was present at week 1). Archetype: **Architectural Minimalism + Editorial Authority**. Five decisions:

1. Color palette: deep ink primary (`#1A1C1E`), warm-stone secondary (`#6C7278`), terracotta accent (`#B8422E`), used sparingly.
2. Typography pairing: Public Sans (sans, body + UI) + Source Serif 4 (serif, h1-h2 only).
3. Border radius: `4px sm`, `8px md`, `12px lg`.
4. Density: medium-comfortable; 8px base unit; account list rows 56px tall.
5. Signature detail: every primary CTA shows a 2px terracotta underline on hover.

A `DESIGN.md` was scaffolded from these tokens at end of week 4 (the recommended sub-step 3b move). The next agent on Pulse starts from sub-step 3a, not 3b.

## Mode tracking (production-ready Step 0)

Pulse started in **Mode A (Greenfield)** at week 1. Throughout: pure Mode A.

If a future engineer joins (per ROADMAP §Capacity, none planned within v1.0), the mode for their first session would be **Mode B (Assessment)**: read this STATE.md, run the inventory scan, pick up at the next planned slice.

## Have-not audits

Tier-1 hollow-check ran at week 6 (M1 gate): zero hollow buttons, zero placeholder data on screens, zero unwired filters. Result: pass.

Tier-2 hollow-check scheduled for end of week 11 (before pen-test week). Will run `references/preflight-and-verification.md` Tier 2 checklist, plus the `production-ready/references/visual-design-audit-mode.md` Tier 2 audit if a DESIGN.md exists (it does, scaffolded week 4).

## Open production-ready questions

(All resolved by the architecture or PRD; tracked here as the audit trail.)

1. ~~Server Components or all-client for the account-detail page?~~ Resolved week 3: Server Component with a client-island for the touchpoint-log form (per Auth.js + Next.js 15 idiom).
2. ~~Optimistic-UI for touchpoint save?~~ Resolved week 5: yes; the timeline updates immediately, rolls back on server failure.
3. ~~Rate-limit handling for HubSpot poll?~~ Resolved week 8: staggered start times per tenant + exponential back-off; alert on 3 consecutive failures.

## Next session checklist

When a future engineer reads this STATE.md to resume:

1. `Read .prd-ready/PRD.md`, `.architecture-ready/ARCH.md`, `.roadmap-ready/ROADMAP.md`, `.stack-ready/STACK.md` if cold-starting.
2. `Read .production-ready/STATE.md` (this file).
3. `git log --oneline -20` to see recent commits.
4. Run `pnpm dev`, sign in as Lin, verify the foundation works.
5. Pick up the next "In flight" or "Pending" slice from the table above.
6. Update this STATE.md before ending the session.

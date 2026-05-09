# Pulse: observability + SLOs + runbook

| | |
|---|---|
| Tier | Tier 2 (matches PRD tier) |
| Status | v1.0 (2026-05-09); SLO measurement starts at week 13 (first prod cutover) |
| Owner | Devon Park (primary on-call); Generalist (secondary) |
| Consumed STACK | `.stack-ready/STACK.md` v1.0 (Axiom for logs; Vercel + Railway for runtime) |
| Consumed ROADMAP | `.roadmap-ready/ROADMAP.md` §KPI handoff |
| Consumed DEPLOY | `.deploy-ready/DEPLOY.md` v1.0 |

## SLOs (the five Pulse cares about at v1.0)

| SLO | Definition | Target | Error budget | Alert when |
|---|---|---|---|---|
| **Account-list latency** (PRD R-02) | API p95 latency for `GET /api/accounts` over a 7-day rolling window | <= 800ms | 1% of monthly requests | p95 >= 1200ms for 5 consecutive minutes |
| **Touchpoint-save E2E** (PRD R-03) | Time from `POST /api/touchpoints` to client-side acknowledgment over a 7-day rolling window | <= 4s median | 1% of monthly mutations | median >= 6s for 5 consecutive minutes |
| **HubSpot sync freshness** (PRD R-06) | `now - max(last_synced_at)` per tenant, p99 | <= 20 minutes | 1% of polling cycles | >= 45 minutes for any tenant for any single observation |
| **Notification delivery** (PRD R-05) | `notification_sent_at - notification_triggered_at` p99 | <= 1 hour | 1% of monthly notifications | p99 >= 2 hours over a 1-hour window |
| **Auth failure rate** (NFR Security) | failed magic-link redemptions / total redemptions | <= 2% monthly | 5% spike threshold | failure rate >= 5% over a 1-hour window |

Each SLO is measured at the API server (Vercel logs) or the worker (Railway logs), shipped to Axiom, computed via Axiom's APL queries, and visualized on a single dashboard at `https://app.axiom.co/aihxp/dashboards/pulse-pilot`.

The error-budget policy: when the error budget for any SLO is exhausted in a calendar month, Pulse pauses non-critical feature work until the budget returns to >= 50% headroom. This is the discipline observe-ready calls "the error budget actually stops the train"; it is not theater.

## Alert routing

| Alert severity | Destination | Response time SLA |
|---|---|---|
| Page (Critical) | PagerDuty -> Devon (primary), Generalist (secondary) | <= 15 minutes |
| High | Slack `#pulse-pilot-alerts` (ping `@oncall`) | <= 1 hour business hours |
| Medium | Slack `#pulse-pilot-alerts` (no ping) | Same business day |
| Low | Daily digest email to Devon | Reviewed Mondays |

Page-severity alerts at v1.0 (the only ones that wake someone up):

1. SLO-burn: any SLO consuming >= 10% of monthly error budget in <= 1 hour.
2. Database unreachable for >= 2 minutes.
3. Auth provider (Resend) down for >= 5 minutes (magic-link delivery blocked).
4. Critical security alert: 10x spike in failed-auth attempts for any single tenant.

Everything else (sync stalls, slow queries, log-volume spikes, deploy-pipeline failures) is high or medium severity. The on-call discipline: do not page on noise. The error-budget policy is the bigger picture; pages are for "the page is on fire" moments.

## Runbook

The runbook is the playbook for the pages above. Each entry is a copy-paste-able sequence the on-call engineer executes without thinking. The bar: someone with 6 weeks on the team can run the runbook at 2 a.m. and not break anything.

### RB-1: SLO burn (any SLO)

**Symptom**: PagerDuty fires "Pulse SLO burn (account-list latency)" or similar.

**Steps**:

```
1.  Open the Axiom Pulse Pilot dashboard:
    https://app.axiom.co/aihxp/dashboards/pulse-pilot
    Confirm the burn (sometimes alerts fire on a stale evaluation).

2.  Check Vercel deployment health:
    https://vercel.com/aihxp/pulse-app
    If a recent deploy correlates with the burn, consider rolling back per
    DEPLOY.md §Rollback policy (Vercel rollback <prior-deployment-id>).

3.  Check Neon health:
    https://console.neon.tech/app/projects/pulse-prod
    Compute: query latency p95 trend; storage growth; connection count.
    If connections are pinned at the limit, the worker leaked connections;
    restart the worker (railway service restart pulse-worker).

4.  Check the slowest 10 queries in Axiom for the impacted endpoint:
    APL query:
      ['vercel-logs']
      | where ['url'] startswith '/api/accounts'
      | summarize p95 = percentile(['duration_ms'], 95) by bin_auto(['_time'])
    Identify the spike's start time and the spike's shape (gradual / step).

5.  If the spike correlates with a tenant's HubSpot sync (look for
    poll-cycle log lines around the spike start), reduce poll rate
    temporarily:
      railway run pulse-worker -- env HUBSPOT_POLL_INTERVAL=30m

6.  Page Devon if the burn doesn't resolve within 30 minutes.
```

### RB-2: Database unreachable

**Symptom**: PagerDuty fires "Pulse DB unreachable >= 2 minutes."

**Steps**:

```
1.  Check Neon status: https://status.neon.tech
    If Neon is having an incident, follow Neon's communication and
    update the #pulse-pilot Slack with a customer-facing note via Lin.

2.  If Neon is healthy: check the Vercel deployment for env var drift
    (a misconfigured DATABASE_URL produces this symptom).
    Roll back to the prior Vercel deployment.

3.  Check the worker logs for connection-leak signatures:
    APL: where ['service'] == 'pulse-worker'
         | where ['message'] contains 'pool exhausted'
    If present, restart the worker (railway service restart pulse-worker).
    Open issue: connection-leak post-mortem within 24 hours.

4.  If unresolved at 30 minutes: declare pilot down in #pulse-pilot;
    coordinate with Lin on customer communication.
```

### RB-3: Resend (email) down

**Symptom**: PagerDuty fires "Magic-link delivery blocked >= 5 minutes."

**Steps**:

```
1.  Check Resend status: https://status.resend.com
    Confirm the outage.

2.  Notify DartLogic AMs in #pulse-pilot:
    "Resend is down; magic-link emails delayed. Use existing sessions;
    new sign-ins delayed until resolved."

3.  Wait for Resend recovery (Resend SLA: 99.95%, typical recovery <30m).

4.  After recovery, verify email delivery to a test address; confirm
    queued auth emails were sent (Resend's reliability promise: messages
    accepted before the outage are delivered after).

5.  If outage exceeds 1 hour: open the Resend-to-Postmark fallback ADR
    (drafted but not implemented at v1.0; v1.x scope per stack ADR-S-006).
```

### RB-4: 10x spike in failed-auth attempts (single tenant)

**Symptom**: PagerDuty fires "Auth-abuse spike for tenant <id>."

**Steps**:

```
1.  Investigate: who is the tenant? What is the auth-failure pattern
    (rate, source IPs, target email accounts)?
    APL: ['vercel-logs']
         | where ['route'] == '/api/auth/email/verify'
         | where ['status_code'] == 401
         | where ['tenant_id'] == '<tenant-id>'
         | summarize attempts = count() by ['source_ip'], bin_auto(['_time'])

2.  If the pattern is brute-force: enable rate limiting at the route
    level (1 attempt per source-IP per minute; Vercel Edge Config flag
    PULSE_AUTH_RATE_LIMIT=on). The flag ships with v1.0 disabled by
    default.

3.  Notify the affected tenant's admin via the in-app audit log + email.

4.  File a security incident in .harden-ready/INCIDENTS.md (created on
    first-incident; not yet on disk at week 9).
```

## Structured logging discipline

All API server and worker logs are JSON-line, with these fields on every log:

```
{
  "_time":      "2026-05-09T11:23:45.678Z",
  "level":      "info" | "warn" | "error",
  "service":    "pulse-api" | "pulse-worker",
  "request_id": "<uuid>",
  "tenant_id":  "<tenant-id>",        // when in tenant context
  "user_id":    "<user-id>",          // when authenticated
  "route":      "/api/accounts",      // for API requests
  "duration_ms": 142,
  "status_code": 200,
  "message":    "<one-line description>",
  "context":    { ... arbitrary fields ... }
}
```

The grep test: every log emitted by Pulse code has at least the first 4 fields. Logs without `tenant_id` outside the auth/setup paths are flagged in code review; the linter (`pnpm lint:logs`) enforces this against the structured-logging schema.

## Dashboards

One Axiom dashboard at v1.0: `pulse-pilot`. Panels:

1. Five SLO trend charts (one per SLO above).
2. Top 10 routes by p95 latency (last 24h).
3. Tenant-by-tenant HubSpot sync freshness (heat-map; rows = tenants, cols = poll cycles).
4. Notification delivery histogram (count by latency bucket).
5. Error rate by route (pie + trend).
6. Worker job execution log (last 100 events; cron schedule, success/fail, duration).

The dashboard is reviewed Monday mornings at the weekly pilot review (per ROADMAP §Cadence). Anything outside expected shapes opens a ticket.

## On-call rotation

Two-person rotation through the pilot window (weeks 13-14 + extension to week 18 if pilot extends). Devon: weeks 13, 15, 17. Generalist: weeks 14, 16, 18. Escalation chain: Generalist -> Devon -> Sam (CEO, pilot-impact decisions only).

Post-pilot (week 19+): rotation shifts to a four-person rotation when the team grows. v1.0 STATE.md is bounded to the pilot window.

## What observe-ready refused at v1.0

Named failure modes refused, with rationale:

- **Paper SLOs** (numbers with no error-budget policy): Pulse's error-budget policy explicitly stops feature work when the budget exhausts. Refused.
- **Blind dashboards** (charts bound to no SLO): every panel on the `pulse-pilot` dashboard is tied to one of the five SLOs above, or is a leading indicator (route latency, sync heat-map). Refused.
- **Paper runbooks** (written once, never executed): the runbook entries above are designed for 2-a.m. execution by someone who has not seen them before. The week-13 cutover dry-run rehearses RB-1 and RB-2 against a synthetic outage before the real pilot starts. Refused.
- **Vanity metrics** (count of dashboard views, "engagement" with monitoring): the SLOs are user-facing performance and reliability targets. No vanity metrics on the dashboard.
- **Alert fatigue** (every signal pages someone): only 4 page-severity alerts at v1.0 (§Alert routing). Everything else is Slack or digest. The on-call discipline is "page only when paging is the right action."

## Out of scope (explicit)

- **Distributed tracing (OpenTelemetry)**: v1.x scope. The architecture (ARCH §11) names this as deferred.
- **APM tooling (Datadog APM, New Relic)**: stack ADR-S-008 picks Axiom for logs only; APM is v1.x if SLO complexity grows.
- **Real-user monitoring (RUM)**: pilot user count is 3; a RUM tool produces too little signal at this scale.
- **Synthetic monitoring (uptime checks)**: Vercel's built-in uptime monitoring covers this at v1.0; a dedicated tool is v1.x.

## Downstream handoff

- **harden-ready** at week 12 reviews this OBSERVE.md as part of the security audit; verifies the audit_log table is being written for security-sensitive events; verifies failed-auth alerting (RB-4) is wired.
- **launch-ready** is out of scope at v1.0; the pilot launch is private. v1.x will add `launch-day-telemetry.md` to this directory.

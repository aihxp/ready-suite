# Pulse: deployment plan

| | |
|---|---|
| Tier | Tier 2 (matches PRD tier) |
| Status | v1.0 (2026-05-09); first prod cutover scheduled week 13 (2026-08-04) |
| Owner | Devon Park (eng lead, primary on-call); Generalist (secondary on-call) |
| Consumed STACK | `.stack-ready/STACK.md` v1.0 (Vercel + Railway + Neon) |
| Consumed ROADMAP | `.roadmap-ready/ROADMAP.md` §Cutover cadence |

## Environments

| Environment | Hostname | Purpose | Data | Deploy trigger |
|---|---|---|---|---|
| Local | `localhost:3000` | Dev work | Mock + Neon dev branch per developer | `pnpm dev` |
| Staging | `staging.pulse.dev` | Continuous integration target; smoke tests | Neon `staging` branch with synthetic data | Auto on every push to `main` |
| Pilot pre-prod | `dartlogic-stage.pulse.dev` | DartLogic-only; mock data; pre-pilot rehearsal | Neon `pilot-stage` branch with mock DartLogic accounts | Manual (Vercel `Promote to Production` button on tagged builds) |
| Pilot production | `dartlogic.pulse.dev` | DartLogic real data; first paying-pilot environment | Neon `pilot-prod` branch | Manual (week 13 cutover; subsequent updates manual until week 14, then continuous) |

## Same-artifact promotion

Per the deploy-ready discipline, the SAME built artifact promotes across environments. There is no rebuild between staging and prod.

The artifact stack:

- **Vercel (web)**: a Vercel deployment, identified by a deployment ID. Deployments are immutable; promotion moves an alias from staging to prod, not a rebuild.
- **Railway (worker)**: a Docker image tagged `aihxp/pulse-worker:<git-sha>`. Built once on tag push to GitHub; pulled by Railway when promoted.
- **Neon (database)**: a branch per environment. Migrations apply per-branch on deploy.

## Cutover sequence (for the week-13 first-prod deploy)

1. **D-7 (week 12)**: pen-test results in. All Critical findings resolved or risk-accepted in writing by the CEO. Recorded in `.harden-ready/FINDINGS.md`.
2. **D-3**: feature freeze on the staging branch. Only release-blocking fixes merge between D-3 and D-1.
3. **D-2**: full smoke-test pass on `dartlogic-stage.pulse.dev` with the mock DartLogic dataset. Manual verification of: sign-in, account-list load, touchpoint log, at-risk flag, HubSpot sync (against a sandbox HubSpot tenant), email notification (to a test address), Slack notification (to a test channel).
4. **D-1**: deploy candidate tagged `v1.0.0-pilot-rc1`. Both Vercel + Railway deploy to `dartlogic-stage`.
5. **D-0 (Monday week 13, 09:00 PT)**: deploy ceremony. Devon executes the cutover playbook (below). Lin (AE) on standby for the AM-side onboarding.
6. **D+1 to D+14**: pilot-window operations (see `.observe-ready/OBSERVE.md`).

## Cutover playbook (the D-0 sequence)

```
1.  Confirm green CI on the release tag.
    Command: gh run view --repo aihxp/pulse-app --json conclusion -q .conclusion
    Expected: "success"

2.  Apply DB migrations to pilot-prod (expand phase only; no destructive
    drops between week 13 and week 14).
    Command: pnpm db:migrate:expand --env=pilot-prod
    Verify: drizzle migrations table shows the expected migration IDs.

3.  Promote the Vercel deployment from dartlogic-stage to dartlogic-prod.
    Command: vercel promote <deployment-id> --scope=aihxp --target=production
    Expected: dartlogic.pulse.dev resolves to the new build within 60s.

4.  Promote the Railway worker image.
    Command: railway service update pulse-worker --image aihxp/pulse-worker:v1.0.0-pilot
    Expected: railway service health is green within 90s.

5.  Verify the worker started its cron schedule.
    Command: gh logs --repo aihxp/pulse-worker --since 5m | grep "cron-schedule-loaded"
    Expected: "cron-schedule-loaded jobs=3"

6.  Smoke test.
    Steps: sign in as a test admin user; verify account list loads;
           log a touchpoint; trigger a no-touch-30d alert; confirm the
           alert email arrives.
    Expected: all four steps pass within 5 minutes.

7.  DartLogic AM onboarding (Lin owns).
    Steps: send the magic-link emails to the 3 DartLogic AMs; each AM
           signs in; each AM views their book; each AM logs one
           introductory touchpoint.
    Expected: 3/3 within 30 minutes; reported in #pulse-pilot Slack.

8.  Declare cutover complete.
    Steps: post in #pulse-pilot: "Cutover complete. dartlogic.pulse.dev
           is live. M3 ceremony Friday week 14."
    Expected: visible in the channel; pilot timer starts.

If any step 1-6 fails: see Rollback (§ below).
```

## Rollback policy

**Code rollback**: revert the Vercel alias to the prior deployment (one click in Vercel dashboard, or `vercel rollback <deployment-id>`). The prior deployment is preserved indefinitely; rollback is fast (~30 seconds).

**Worker rollback**: redeploy the prior Railway image tag. `railway service update pulse-worker --image aihxp/pulse-worker:<prior-tag>`.

**Database rollback (asymmetric, by design)**:

- **Expand-phase migrations** (column additions, index additions): the prior code can run against the new schema (the column / index is unused). Code rollback is sufficient; no DB rollback needed.
- **Contract-phase migrations** (column drops, table drops): explicitly forbidden between week 13 and week 14. The deploy-ready discipline names this asymmetry: code rolls back fast; data rolls back only via backup restore or by writing a forward-fix migration.
- **Backup**: Neon takes branch-level point-in-time backups continuously. If a destructive migration somehow shipped (the lint and code review caught nothing), restore the prior PIT and re-replay non-destructive writes from app logs. Estimated recovery time: 1-2 hours.

## What deploy-ready refused to ship at v1.0

The named failure modes deploy-ready refuses, with how Pulse avoids them:

- **Different-artifact promotion** (build twice, ship the second build to prod): Pulse builds once per tag; promotion moves aliases. Refused.
- **Expand-and-contract in the same deploy** (the canonical zero-downtime migration anti-pattern): Pulse has an explicit "no contract migrations during the pilot window" rule between week 13 and week 14. Expand happens at week 13; contract happens at week 16+ (post-pilot, after the data shape settles). Refused.
- **Code-vs-data rollback symmetry assumption** (assuming you can roll back data the way you roll back code): Pulse's rollback policy is asymmetric by design (§Rollback). Refused.
- **Paper canary** (a "canary" that gets 100% of traffic on day 1): Pulse's first deploy IS the production deploy for DartLogic only; the user count is 3. There's no canary because the population is bounded. Recorded as scope-fence, not theater.
- **First-deploy-as-discovery** (figuring out the env vars and secrets at cutover time): Pulse's pilot-pre-prod environment (`dartlogic-stage.pulse.dev`) ran for 6 weeks before the cutover. Every secret, every env var, every config knob was exercised. The cutover is a promotion, not a discovery.

## Observability cutover handoff

The week-13 cutover triggers the observe-ready operations window. See `.observe-ready/OBSERVE.md` for the SLO targets, the alert routing, and the on-call rotation. The deploy-ready and observe-ready handshake: deploy promotes the artifact; observe verifies the SLOs hold; deploy and observe both subscribe to the same Axiom error-rate alert during week 13.

## Cost guardrails

The PRD §NFR cost ceiling is $400/mo. The stack picks total $50/mo. Headroom of $350/mo absorbs:

- Vercel traffic spike (Hobby -> Pro auto-upgrade if needed: $20/mo)
- Resend email volume past free tier (3k emails/mo; pilot expected to send ~500/mo): unlikely to exceed
- Axiom log volume past free tier: unlikely
- A second DartLogic-like pilot joining late v1.0: under-budget

The cost monitor: a weekly Vercel + Railway + Neon + Resend + Axiom invoice review, owned by Devon. Alert if combined monthly cost exceeds $200 ($150 buffer to the ceiling).

## Out of scope (explicit)

- **Multi-region deploy**. Single-region (us-east-1) at v1.0; EU residency is v1.x.
- **Blue/green or canary**. Single-tenant pilot; not relevant at v1.0.
- **GitOps with ArgoCD or Flux**. Vercel + Railway have their own promotion flows; layering ArgoCD adds ops surface for no win at this scale.
- **Multi-cluster Kubernetes**. The architecture (ARCH §3) is single-deployable + worker; no Kubernetes.

## Downstream handoff

- **observe-ready** consumes the SLO targets from `.roadmap-ready/ROADMAP.md` §KPI handoff and the runbook from `.observe-ready/OBSERVE.md`.
- **harden-ready** consumes the deployment env list (§Environments) for the week-12 pen-test scope.
- **launch-ready** is mostly out of scope at v1.0 (pilot is private). The week-14 ceremony posts (DartLogic blog + Pulse blog announcing the first paying customer) are pilot-marketing artifacts, not launch-ready scope. Recorded in `.kickoff-ready/PROGRESS.md` as `launch-ready: skipped (v1.1 scope)`.

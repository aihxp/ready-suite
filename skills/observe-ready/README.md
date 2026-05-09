# Observe Ready

> **Keep a deployed app healthy once real users are on it. Refuse paper SLOs, blind dashboards, and paper runbooks.**

> **Part of the [ready-suite](SUITE.md)**, a composable set of AI skills covering the full arc from idea to launch (planning, building, shipping). See [`SUITE.md`](SUITE.md) for the full map and the live sibling skills.

The deploy is green. The pager is quiet. Three dashboards exist, one of which has been viewed in the last 90 days. The SLO page on Confluence says "99.9% availability" and no alert is wired to it. The runbook for "api down" has a `grep` command referencing a log field renamed six months ago. Then something breaks in a shape nobody instrumented for, the on-call opens the dashboard, and the chart they actually need either does not exist, is measuring the wrong thing, or is hosted on the same cluster that just went down. The alert that did fire has no runbook link. The runbook that is linked 404s because the wiki SSO went with the app.

None of this is a code bug. It is an observability-mechanics bug, and the tooling that exists today, from Datadog to PagerDuty to Grafana Cloud, has no opinion about any of it. This skill closes that gap. It refuses to call a number an SLO without an error-budget policy. It refuses to ship a dashboard whose above-the-fold charts do not bind to SLOs. It refuses to page on a runbook that has not been executed in the last quarter. It tests the observability surface for independence from the thing it observes and refuses to let Facebook 2021 or Roblox 2021 or Datadog 2023 happen here.

## Install

**Claude Code:**
```bash
git clone https://github.com/aihxp/observe-ready.git ~/.claude/skills/observe-ready
```

**Codex:**
```bash
git clone https://github.com/aihxp/observe-ready.git ~/.codex/skills/observe-ready
```

**pi, OpenClaw, or any [Agent Skills](https://agentskills.io)-compatible harness:**
```bash
git clone https://github.com/aihxp/observe-ready.git ~/.agents/skills/observe-ready
```

**Cursor:**
```bash
git clone https://github.com/aihxp/observe-ready.git ~/.cursor/skills/observe-ready
```

**Windsurf or other agents:**
Add `SKILL.md` to your project rules or system prompt. Load reference files as needed.

**Any agent with a plan-then-execute loop:**
Upload `SKILL.md` and the relevant reference files to your project context. The skill produces structured output (SLO entries, alert catalogs, runbook templates, incident logs) that any planner can consume.

## The problem this solves

Observability is the part of the lifecycle where AI-assisted configurations produce the most confident-looking, least useful output. The industry numbers are not ambiguous:

- **85% of teams report that the majority of their alerts are false positives** ([incident.io 2025](https://incident.io/blog/alert-fatigue-solutions-for-dev-ops-teams-in-2025-what-works)).
- **67% of engineers admit to ignoring or dismissing alerts without investigating.**
- **73% of organizations experienced outages linked to ignored alerts.**
- **~70% of observability spend goes to logs that are never queried** ([Chronosphere 2025](https://chronosphere.io/learn/2025-top-observability-trends/)).
- PagerDuty markets its Event Intelligence at "up to 98% noise reduction," which implies the baseline is 2% signal ([PagerDuty](https://www.pagerduty.com/resources/digital-operations/learn/alert-fatigue/)).
- Operational toil rose **30% in 2025, the first increase in five years**, despite heavy AI investment ([Runframe 2026](https://runframe.io/blog/state-of-incident-management-2025)).

Every named incident in the skill's research set (see [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md)) shares one or more of three traits: the observability surface depended on the thing it observed, the uniform rollout defeated symptom-based alerting, or the alerts-under-pressure signal-to-noise dropped so low that triage itself cost the outage most of its recovery time. Slack 2021 could not reach its own dashboards. Roblox 2021 made "remove circular dependencies in the observability stack" a remediation. Datadog 2023 could not observe itself for ~27 hours. Checkly 2024 went 5 hours silent because a deadman-switch alert on its own check results was missing.

observe-ready exists because none of the tools in the observability category are designed to say "no" to any of these shapes. Datadog will render whatever dashboards you write. PagerDuty will route whatever alerts you define. Grafana Cloud will ingest whatever Prometheus scrapes. The skill is the layer above the tool that catches the observability configuration before it ships.

## When this skill should trigger

The short frontmatter description is tight on purpose, to speed up skill-routing decisions. The full trigger surface lives here.

**Positive triggers (wire the observability surface or harden it):**
- "add monitoring / observability to this app"
- "define an SLO"
- "write an alert when <condition>"
- "add Datadog / Honeycomb / Sentry / Grafana / New Relic / Splunk / Dynatrace"
- "wire OpenTelemetry"
- "set up distributed tracing"
- "write a runbook" / "runbook for <alert>"
- "set up on-call" / "configure PagerDuty" / "incident.io setup"
- "post-mortem template" / "blameless post-mortem"
- "structured logging" / "log aggregation"
- "error budget policy"
- "burn rate alert" / "multi-window multi-burn-rate"
- "status page" / "customer communication during incident"
- "dashboard cleanup" / "prune alerts" / "fix alert fatigue"

**Implied triggers (the thesis word is never spoken):**
- "the pager goes off all the time"
- "we have no idea whether the service is healthy"
- "customers knew before we did"
- "we missed the incident for hours"
- "the runbook didn't work"
- "Datadog bill is 10x what we expected"
- "we can't find the logs for this error"

**Mode triggers (see SKILL.md Step 0):**
- Mode A: "we just shipped; add observability from scratch"
- Mode B: "we have metrics and logs but no SLOs"
- Mode C: "dashboards and alerts are out of control; fix it"
- Mode D: "we just had an incident; wire what was missing"
- Mode E: "the bill is detonating; cut without losing signal"

**Negative triggers (route elsewhere):**
- Tool selection ("Datadog vs. Honeycomb," "self-host Prometheus or Grafana Cloud") -> [`stack-ready`](https://github.com/aihxp/stack-ready)
- Deployment mechanics ("write the CI/CD pipeline," "canary config," "rollback plan," "migration calendar") -> [`deploy-ready`](https://github.com/aihxp/deploy-ready)
- App wiring ("build the users page," "add RBAC") -> [`production-ready`](https://github.com/aihxp/production-ready)
- Repo hygiene ("CODEOWNERS," "branch protection") -> [`repo-ready`](https://github.com/aihxp/repo-ready)
- Secrets vaulting and rotation -> security territory, not this skill (observe-ready does opinion on PII scrubbing at the telemetry boundary)
- Product analytics / funnels / A/B testing -> `production-ready`'s telemetry domain, not operational observability
- Performance tuning -> cloud-provider docs or a future scale-ready
- Security incident playbooks -> `production-ready`'s security deep-dive

**Pairing:** `deploy-ready` (same shipping tier). A canary in deploy-ready requires a metric from observe-ready. observe-ready's "uniform rollouts defeat symptom-based alerts" rule refers back to deploy-ready's rollout-strategy discipline. The two compose at the seam where shipping mechanics meet observed behavior. See [SKILL.md](SKILL.md) "Handoff" section.

## How it works

Twelve steps, four completion tiers, one artifact family under `.observe-ready/`.

1. **Step 0.** Detect observability state and mode (greenfield, instrumented-but-unbound, mature-with-sprawl, incident-reactive, cost-driven).
2. **Step 1.** Service inventory and user-journey map.
3. **Step 2.** Structured logging baseline: format, correlation IDs, PII scrubbing, sampling, retention.
4. **Step 3.** Metrics taxonomy: RED, USE, golden signals, per-service-type catalog, cardinality budget.
5. **Step 4.** SLO design: SLI, target, window, error budget, error-budget policy. The paper-SLO refusal lives here.
6. **Step 5.** Alert design: multi-window multi-burn-rate, symptom-based pages, severity ladder, routing independence, pruning cadence.
7. **Step 6.** Dashboard design: above-the-fold rule, per-service-type catalog, ownership and pruning metadata.
8. **Step 7.** Distributed tracing: OpenTelemetry, context propagation, tail sampling, retention alignment.
9. **Step 8.** Error tracking: release tagging, grouping, PII, metrics-vs-errors complementarity.
10. **Step 9.** Runbook discipline: template, executable commands, last-executed cadence, out-of-band hosting.
11. **Step 10.** Observability surface independence: the six-row dependency test.
12. **Step 11.** Incident response and post-mortem: severity ladder, IC role, status page, blameless format, action-item tracking, incident-to-learning loop.

Tiers: **Instrumented** (5), **Promised** (5), **Traceable** (5), **Rehearsed** (5). See [SKILL.md](SKILL.md) for per-tier requirements.

## What this skill prevents

Mapped against recurring, documented observability-shaped failures:

| Real incident or research finding | What this skill enforces that prevents it |
|---|---|
| **Slack 2021, 4 hours of errors** ([Slack Engineering](https://slack.engineering/slacks-outage-on-january-4th-2021/)): observability surface down with the service | Step 10 independence test; dashboards hosted on distinct infrastructure; out-of-band runbook mirror. |
| **Facebook 2021 BGP, 6 hours** ([Cloudflare](https://blog.cloudflare.com/october-2021-facebook-outage/)): tools unreachable, SSO path depended on the outage | Step 10 routing-independence row; alert paths via SMS/voice, not only Slack; runbook SSO path distinct from app SSO. |
| **Roblox 2021, 73 hours** ([Roblox](https://about.roblox.com/newsroom/2022/01/roblox-return-to-service-10-28-10-31-2021)): circular dependency between observability and Consul | Step 10 dependency test; remediations include out-of-band copy of critical surface. |
| **AWS us-east-1 2021** ([AWS](https://aws.amazon.com/message/12721/)): global console dependent on the failing region | Step 10 status-page independence row; host status page on a distinct provider. |
| **Datadog 2023, ~27 hours** ([Datadog](https://www.datadoghq.com/blog/2023-03-08-multiregion-infrastructure-connectivity-issue/)): observability vendor could not observe itself | Vendor-audit question in `vendor-landscape.md`; pair with secondary check (Better Stack, Checkly) for vendor-outage visibility. |
| **Cloudflare July 2019, 27-minute outage** ([Cloudflare](https://blog.cloudflare.com/details-of-the-cloudflare-outage-on-july-2-2019/)): uniform rollout defeated symptom-based alerts | Step 5 rollout-vs-observability coupling; uniform rollouts require pre-rollout synthetic observation; non-uniform require population-tagged SLIs. |
| **Cloudflare June 2022, 90-min outage** ([Cloudflare](https://blog.cloudflare.com/cloudflare-outage-on-june-21-2022/)): stepped rollout too coarse-grained | Step 5 canary-population-sized-to-signal rule; coordinate with deploy-ready's progressive-delivery discipline. |
| **CrowdStrike Channel File 291, 2024, 8.5M hosts BSOD** ([CrowdStrike RCA](https://www.crowdstrike.com/en-us/blog/channel-file-291-rca-available/)): uniform rollout, no ring-population-differentiated signal | Step 5 no-uniform-rollout-without-synthetic observation; ring-deployment SLI design. |
| **GitHub October 2018, 24h 11m degraded** ([GitHub](https://github.blog/2018-10-30-oct21-post-incident-analysis/)): alerts fired in volume, triage time under load was a tax | Step 5 correlation and suppression; Step 11 per-incident alert pruning; `alert-patterns.md` flappy-alert rule. |
| **Checkly 2024, 5-hour silent outage** ([Checkly](https://www.checklyhq.com/blog/post-mortem-outage-browser-check-results-alerting)): no deadman-switch on check-result absence | Step 3 deadman-switch metric for scheduled jobs, workers, synthetic checks, pipelines. |
| **AWS DynamoDB October 2025, cascading regional outage** ([InfoQ](https://www.infoq.com/news/2025/11/aws-dynamodb-outage-postmortem/)): each affected service emitted "my dependency is down" locally; no single-pane-of-glass at cross-service level | Step 1 dependency graph; Step 11 cross-service incident coordination; status page hosted independently. |
| **incident.io 2025**: 85% false-positive alerts; 67% engineers ignoring alerts; 73% outages linked to ignored alerts ([incident.io](https://incident.io/blog/alert-fatigue-solutions-for-dev-ops-teams-in-2025-what-works)) | Step 5 every-page-is-actionable rule; Step 5 pruning cadence; symptom-based pages over cause-based thresholds. |
| **Chronosphere 2025**: ~70% of observability spend on logs never queried ([Chronosphere](https://chronosphere.io/learn/2025-top-observability-trends/)) | Step 2 retention alignment; Mode E cost-driven sampling and cardinality discipline; `vendor-landscape.md` per-backend pricing traps. |
| **Honeycomb 2024-2025 "Observability 2.0"** ([Honeycomb](https://www.honeycomb.io/blog/time-to-version-observability-signs-point-to-yes)): cardinality-free wide events vs. per-series priced metrics | Step 3 cardinality discipline; high-cardinality labels land on wide-event backends or are excluded; pricing-model-aware metric design. |

## Reference library

Load each reference *before* the step that uses it, not after. Full tier annotations in [SKILL.md](SKILL.md).

- [`observe-research.md`](references/observe-research.md). Step 0 mode detection protocol and the paper-SLO detection procedure.
- [`logging-patterns.md`](references/logging-patterns.md). Step 2 structured format, correlation IDs, PII scrubbing at the OTel Collector, sampling, retention.
- [`metrics-taxonomy.md`](references/metrics-taxonomy.md). Step 1 and Step 3 RED / USE / golden signals, per-service-type catalogs, cardinality budget, deadman switches.
- [`slo-design.md`](references/slo-design.md). Step 4 SLI picking, target selection, error-budget policy template, multi-burn-rate math, dependency-chain composition, low-traffic strategies.
- [`alert-patterns.md`](references/alert-patterns.md). Step 5 symptom-based pages, four-tier burn-rate matrix, severity ladder, routing independence, quarterly pruning cadence, deadman-switch patterns.
- [`dashboards.md`](references/dashboards.md). Step 6 above-the-fold rule, per-service-type catalog (request / worker / batch / edge / pipeline), sprawl budget, ownership metadata.
- [`tracing.md`](references/tracing.md). Step 7 OpenTelemetry, W3C Trace Context, async queue and gRPC stream propagation, head vs. tail sampling, retention, span hygiene.
- [`error-tracking.md`](references/error-tracking.md). Step 8 Sentry/Rollbar/Bugsnag patterns, release tagging, grouping tuning, metrics-vs-errors, PII.
- [`incident-response.md`](references/incident-response.md). Step 9 runbook template and Step 11 severity ladder, IC role, war-room protocol, status-page discipline, customer communication.
- [`post-mortem.md`](references/post-mortem.md). Step 11 blameless format, causal analysis beyond Five Whys, action-item tracking, observability-gap feedback loop, alert pruning after incidents.
- [`vendor-landscape.md`](references/vendor-landscape.md). Datadog / Grafana Cloud / Honeycomb / New Relic / Splunk / Dynatrace / open-source OTel / Sentry / PagerDuty / Cribl / Chronosphere configuration deltas and pricing traps.
- [`RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md). Source citations behind every guardrail and the named-failure-mode derivations.

## The skill's named terms

observe-ready introduces three named failure modes the ecosystem did not already have a clean term for:

- **Paper SLO.** An SLO with no error-budget policy, no alert wired to it, no review cadence, and no stakeholder who knows its number. The word is present, the mechanism is not. The cousin of deploy-ready's "paper canary" across tiers: both name the "artifact present, mechanism absent" failure mode that dominates AI-generated systems-engineering output. The skill refuses to accept an SLO as a deliverable unless the policy is written, the multi-burn-rate alert is wired, and the review cadence is on the calendar.
- **Blind dashboard.** A dashboard above the fold with metrics that have no SLO behind them and nobody watched during the last incident. It passes review because it has charts; it fails its job because those charts are not bound to any promise. Distinct from "dashboard sprawl" (quantity) because it names the artifact (binding) rather than the count.
- **Paper runbook.** A runbook that was written once, attached to an alert, and never executed. The grep commands reference log fields that have been renamed. The URLs 404. The runbook exists, passed review, and fails on first execution during a real incident. Distinct from "runbook drift" because the term names the artifact (executability), not the process.

A related corollary: **unreachable runbook**, the runbook hosted on the service it documents. Facebook 2021 and Roblox 2021 are the citations. observe-ready's Step 10 independence test catches it.

See [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md) section 8 for the naming-lane survey and section 10 for why these were chosen.

## Contributing

Gaps, missing cases, outdated guidance, new incident citations: contributions welcome. Open an issue or PR. New vendor-landscape entries in [`vendor-landscape.md`](references/vendor-landscape.md) are especially valuable; the observability market moves fast.

## License

[MIT](LICENSE)

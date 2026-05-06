# observe-ready research pass, 2026-04

Scope check: this report covers what it takes to keep a deployed app healthy once it is in real environments. In scope: metrics, logs, traces, structured events, SLOs and error budgets, alert design, dashboards, runbooks, on-call ergonomics, OpenTelemetry adoption, vendor landscape gaps, post-incident learning artifacts. Explicitly out of scope: app wiring and end-to-end connection (production-ready), deployment mechanics and rollback (deploy-ready), stack or IaC tool selection (stack-ready), repo hygiene and CODEOWNERS (repo-ready), secrets vaulting and rotation (security), product analytics and A/B testing and funnel analysis (production-ready's telemetry domain), performance tuning beyond surfacing latency (future scale-ready), security incident response playbooks (production-ready's security deep-dive), user-facing error pages and branded 500s (production-ready).

observe-ready consumes artifacts from its siblings: the deploy manifest emitted by deploy-ready (so it knows what a release looks like), the stack emitted by stack-ready (so it can pick the right instrumentation path), the feature surfaces emitted by production-ready (so it can name SLOs per user journey, not per process). It does not re-enforce their invariants.

---

## 1. Top complaints about AI-generated observability configs

The pattern that rhymes with deploy-ready's "passes validate, fails in prod" is this: AI output produces an observability config that renders a dashboard, fires an alert, and emits a span, but the signal it produces is not the signal the operator needed during the outage that actually happened. The failure is not syntactic; the Grafana JSON is valid, the Terraform applies, the OTel config parses. The failure is at the level of "this says everything is green and the service is down," which is the observability equivalent of a passing test suite on a broken app.

### 1.1 Dashboard sprawl and dashboard debt

The most consistent industry complaint is volume. ASAPP's engineering team let "hundreds of engineers each built custom Grafana panels, leading to a technological sprawl of over 400 dashboards" with users unable to find or trust any of them ([Tech Monitor on ASAPP](https://www.techmonitor.ai/leadership/digital-transformation/asapp-dashboard-sprawl-case-study)). Flexport had "north of ~2700 dashboards" before Abhi Sivasailam cut them to roughly 60 ([Tasman Analytics](https://www.tasman.ai/news/dashboard-sprawl-is-killing-your-business)). Atlan's 2026 enterprise guide frames this as "dashboards created continuously while older ones remain active, unreviewed, and without clear ownership" ([Atlan](https://atlan.com/know/how-to-reduce-data-dashboard-sprawl/)). This is what AI-generated dashboards inherit on day one: the ten-panel "golden signals" dashboard that is valid JSON, has never been looked at during an incident, and hides the two charts that would tell you the service is degrading.

Dashboard sprawl has a cost beyond confusion. Tasman reports that "43% of dashboard users regularly skip their reports entirely and do their own analysis in spreadsheets" ([Tasman](https://www.tasman.ai/news/dashboard-sprawl-is-killing-your-business)). The dashboards still exist. They passed review. They just do not get watched. HackerNoon's "Observability Debt Hypothesis" frames this as perfect dashboards masking failing systems; the existence of the dashboard is confused for the act of observing ([HackerNoon](https://hackernoon.com/the-observability-debt-hypothesis-why-perfect-dashboards-still-mask-failing-systems)).

### 1.2 Alert fatigue and false-positive ratios

The numbers are stark. PagerDuty's own framing of the problem puts it plainly: the majority of alerts are not actionable ([PagerDuty](https://www.pagerduty.com/resources/digital-operations/learn/alert-fatigue/)). Incident.io's 2025 survey (summarized in their blog) put it quantitatively: "85% of teams report that the majority of their alerts are false positives" and "67% of engineers admit to ignoring or dismissing alerts without investigating" ([incident.io](https://incident.io/blog/alert-fatigue-solutions-for-dev-ops-teams-in-2025-what-works)). Runframe's 2026 State of Incident Management finds that "73% of organizations had outages linked to ignored alerts," and that toil went up 30% year over year despite heavy AI investment, the first rise in five years ([Runframe](https://runframe.io/blog/state-of-incident-management-2025)).

PagerDuty markets its Event Intelligence filter with the stat that it "reduces alert fatigue by filtering out up to 98% of system noise" ([incident.io summary](https://incident.io/blog/alert-fatigue-solutions-for-dev-ops-teams-in-2025-what-works)); the notable thing is that the baseline signal-to-noise such a filter exists to correct is two percent. That is the alert floor AI-generated monitor sets are pitched into.

### 1.3 Metrics without SLOs

Charity Majors is blunt: "on-call alerting should be triggered by service level objectives (SLOs) rather than simply being triggered by infrastructure failure or monitoring threshold breaches, and engineers should only be woken up if the business is being impacted" ([InfoQ interview](https://www.infoq.com/articles/charity-majors-observability-failure/)). The common AI-emitted pattern is the opposite: a monitor on CPU greater than 80%, on memory greater than 75%, on disk usage greater than 90%, on error count greater than zero. Every one of those is a cause, not a symptom, and Rob Ewaschuk's canonical advice is to alert on symptoms ([Ewaschuk, "My Philosophy on Alerting"](https://docs.google.com/document/d/199PqyG3UsyXlwieHaqbGiWVa8eMWi8zzAn0YfcApr8Q/edit)). None of them promises anything to a user. The bound-to-nothing metric is the observability equivalent of a test that asserts `expect(true).toBe(true)`.

### 1.4 Traces nobody reads

Head-based sampling (the default in every language SDK out of the box) samples at span creation time, which means "you cannot ensure that all traces with an error within them are sampled with head sampling alone" ([OpenTelemetry docs](https://opentelemetry.io/docs/concepts/sampling/)). Tail-based sampling keeps the interesting tail but is stateful: "the Collector must hold all spans for every in-flight trace until the decision_wait expires. For a system with 5,000 new traces per second, a 30-second wait, 8 spans per trace, and 2 KB per span, that works out to roughly 2.4 GB just for the span buffer" ([dev.to on scaling collectors](https://dev.to/taman9333/traces-at-scale-head-or-tail-sampling-strategies-scaling-the-collector-nk)). The AI default is head sampling at 1%; during an incident you query Jaeger, your error trace was dropped at birth, and your trace store holds 99% of the boring traces and none of the ones you need.

Retention is the sibling failure. If your error budget is a month and your trace store keeps 15 days, you cannot query the trace the postmortem needs.

### 1.5 Structured logging with PII baked in

The template-copy problem is well documented. Masking at ingestion "is the only defensible choice for compliance; if PII reaches your database, it is already a GDPR problem" ([dev.to, GDPR time bomb](https://dev.to/polliog/pii-in-your-logs-is-a-gdpr-time-bomb-heres-how-to-defuse-it-307l)). AI-templated log lines emit `user.email`, `user.phone`, `user.address`, and full request bodies because the demo code did. OneUptime's guidance on scrubbing PII from OpenTelemetry pipelines is the standard pattern: scrub at the collector, before export, with an attribute processor that drops or redacts fields by match ([OneUptime](https://oneuptime.com/blog/post/2026-02-06-scrub-pii-opentelemetry-logs-traces-metrics/view); [OneUptime on keeping PII out of telemetry](https://oneuptime.com/blog/post/2025-11-13-keep-pii-out-of-observability-telemetry/view)). An AI-generated OTel config does not have that processor unless the prompt demanded it.

### 1.6 Generic "add Datadog" Terraform that produces 47 dashboards

The specific AI regression: the Datadog provider and the Grafana provider both have first-class `dashboard` and `monitor` resources, so the LLM happily emits twenty of each from "add monitoring." The resulting fleet has no owner, no runbook, no SLO, and no pruning policy. Sawmills' guide to high-cardinality metrics on Datadog puts the cost framing directly: "high-cardinality metrics are the stealth tax of Datadog; they look harmless when you add 'just one more tag,' but at scale they quietly multiply into millions of time series" ([Sawmills](https://www.sawmills.ai/blog/best-practices-for-high-cardinality-metrics-in-datadog)). Datadog's pricing doc confirms: "a single custom metric in Datadog is defined by the unique combination of metric name and tags, with each distinct combination being a separate time series and a billable custom metric" ([Datadog docs](https://docs.datadoghq.com/account_management/billing/custom_metrics/)). SigNoz catalogs customer complaints that AI-adopted tags with high cardinality (`customer_id`, `request_id`) produce surprise 10x-100x bills ([SigNoz](https://signoz.io/blog/datadog-pricing/)). The AI-generated config does not know that `customer_id` as a tag is a bill detonator.

New Relic has the same shape: one engineering director reported paying "$1,000 a month and only ingesting 10% of their traces" because the default config was billed at $0.40 per GB ingest and the LLM did not know to sample ([SigNoz on New Relic CCU pricing](https://signoz.io/blog/new-relic-ccu-pricing-unpredictable-costs/); [SigNoz pricing guide](https://signoz.io/guides/new-relic-pricing/)). Middleware's "bill shock" writeup pegs the recurring pattern: "a company reported that when they turned on JVM-level telemetry unaware that it incurred a 'custom event' cost, it skyrocketed their bill 10x for a month" ([Middleware](https://middleware.io/blog/new-relic-pricing/)).

### 1.7 "Almost right" configs that pass validation and miss the signal

This is the observability-shaped version of the Stack Overflow 2024 finding ("AI solutions that are almost right, but not quite"). The monitor is valid, but its threshold was copied from a demo and bears no relation to the actual latency profile of this service. The dashboard uses `avg` where it should use `p99`. The alert condition uses `>` where `>=` would have caught it. The trace sampler is 1% head-based where this service's error rate is 0.5%. Every one of these passes review and is visible only when the thing you needed to see did not happen. The Checkly postmortem is the canonical version of this: "there was no monitoring or alerting for non-existing browser check results, so the outage went unnoticed for 5 hours" ([Checkly postmortem](https://www.checklyhq.com/blog/post-mortem-outage-browser-check-results-alerting)).

### 1.8 Runbooks that were written once and never executed

Runbook drift is the observability-adjacent twin of AI-generated dashboards. PagerDuty's own alerting principles document puts it bluntly: "an untested alert is equivalent to not having an alert at all" ([PagerDuty](https://response.pagerduty.com/oncall/alerting_principles/)). Runbooks decay faster than alerts because the systems they refer to change faster than the runbook. Runbook drift "happens when documented procedures fall out of date as systems change" and requires deliberate testing to prevent ([incidenthub guide](https://blog.incidenthub.cloud/The-No-Nonsense-Guide-to-Runbook-Best-Practices)). AI-generated runbooks at creation time look identical to well-maintained runbooks; the difference appears six months later when a real incident shows the grep command references a log field that no longer exists.

---

## 2. Named incidents where observability gaps extended outages

Each of these is scoped to observability failure, not deploy mechanics. The framing is "we were blind for N hours" or "the signal existed but no one watched it" or "the monitor did not fire." Date, org, summary, observability-specific failure mode, citation.

| Date | Org | Incident | Observability-specific failure mode | Source |
|---|---|---|---|---|
| 2018-10-21 | GitHub | 24 hours 11 minutes of degraded service, 5,000+ projects affected | Internal monitoring generated a high volume of alerts simultaneously; engineers spent time triaging notifications rather than the underlying issue. The signal existed; the signal-to-noise ratio under load drove response time up. | [GitHub blog postmortem](https://github.blog/2018-10-30-oct21-post-incident-analysis/) |
| 2019-07-02 | Cloudflare | 27-minute global 502 outage | CPU pinned to 100% globally. CPU alerting existed but the deploy hit every edge in one step, so the alert fired everywhere at once with no differentiating signal to rollback against. A uniform rollout defeats symptom-based alerting. | [Cloudflare blog](https://blog.cloudflare.com/details-of-the-cloudflare-outage-on-july-2-2019/) |
| 2021-01-04 | Slack | ~4 hours of errors and inaccessibility on the first workday of 2021 | "All debugging and investigation was hampered by the lack of their usual dashboards and alerts. While they had various internal consoles and status pages available, as well as command line tools and logging infrastructure, their metrics backends were still up, meaning they could query them directly, however this is nowhere near as efficient as using dashboards with their pre-built queries." Slack's own words. The observability surface went down with the service. | [Slack Engineering](https://slack.engineering/slacks-outage-on-january-4th-2021/) |
| 2021-10-04 | Meta / Facebook | ~6 hours of full-platform outage | Operators could not reach the internal tools needed to diagnose because those tools depended on the same DNS and BGP that had failed. Recovery required physical access to data centers. Observability that was "reachable via the outage" is the canonical pattern. | [Cloudflare](https://blog.cloudflare.com/october-2021-facebook-outage/), [The Register](https://www.theregister.com/2021/10/06/facebook_outage_explained_in_detail/) |
| 2021-10-28 to 2021-10-31 | Roblox | 73-hour outage affecting 50M players | "Challenges in diagnosing these two primarily unrelated issues buried deep in the Consul implementation were largely responsible for the extended downtime, as critical monitoring systems that would have provided better visibility into the cause of the outage relied on affected systems, such as Consul, which severely hampered the triage process." Their monitoring sat on Consul; Consul was the incident. The monitoring went down with it. Followup: Roblox's remediation was to "accelerate engineering efforts to improve monitoring and remove circular dependencies in the observability stack." | [Roblox return to service](https://about.roblox.com/newsroom/2022/01/roblox-return-to-service-10-28-10-31-2021) |
| 2021-12-07 | AWS us-east-1 | ~7+ hour region impairment; global console inaccessible | The console was hosted in us-east-1; when us-east-1 degraded, the tool to see and fix was also degraded. Multiple third-party observability vendors (Datadog, ThousandEyes, New Relic, Splunk) reported degradation in AWS integration metrics and synthetics during the same window. The observability industry was blind to its input. | [AWS message 12721](https://aws.amazon.com/message/12721/), [ThousandEyes analysis](https://www.thousandeyes.com/blog/aws-outage-analysis-dec-7-2021) |
| 2022-06-21 | Cloudflare | 90-minute outage affecting 50% of requests despite only 4% of the network being impaired | A BGP prefix-policy change was deployed as part of an infrastructure-standardization effort. A diff reorder withdrew critical prefixes. The change passed peer review. The observability-specific angle: the stepped rollout procedure existed, but the step granularity was large enough that the error reached all 19 target data centers before the monitoring-driven halt could kick in. | [Cloudflare blog](https://blog.cloudflare.com/cloudflare-outage-on-june-21-2022/) |
| 2023-03-08 | Datadog | ~27 hours multi-region service degradation; the observability vendor eating its own dogfood | A security update to systemd on several VMs caused a latent bug in the network stack on Ubuntu 22.04 to manifest when systemd-networkd restarted, deleting routes managed by Cilium. "When the incident started, users could not access the platform or various Datadog services via the browser or APIs and monitors were unavailable and not alerting. Data ingestion for various services was also impacted at the beginning of the outage." The observability platform could not observe the observability platform. | [Datadog blog](https://www.datadoghq.com/blog/2023-03-08-multiregion-infrastructure-connectivity-issue/), [Pragmatic Engineer deep-dive](https://newsletter.pragmaticengineer.com/p/inside-the-datadog-outage), [USENIX talk](https://www.usenix.org/conference/srecon23emea/presentation/de-vesine) |
| 2024-07-19 | CrowdStrike | ~8.5M Windows hosts BSOD globally | A Channel File 291 update passed CrowdStrike's content validator due to a bug; the sensor parsed it differently and crashed in kernel mode. The rollout was uniform, with no ring / canary population that could have thrown a localized alert before the global push. CrowdStrike's remediation included a new "system of concentric rings for rolling out updates" plus customer-selectable update-adoption tiers (early adopter / GA / opt-out), an explicitly ring-shaped progressive delivery model. The observability-specific lesson is that deploys without a canary population also have no population-differentiated signal to alert on. | [CrowdStrike RCA](https://www.crowdstrike.com/en-us/blog/channel-file-291-rca-available/), [SmartBear observability analysis](https://smartbear.com/blog/breaking-down-the-crowdstrike-outage-part-2/), [CSA analysis](https://cloudsecurityalliance.org/blog/2025/07/03/what-we-can-learn-from-the-2024-crowdstrike-outage) |
| 2025-10-20 | AWS DynamoDB (us-east-1) | Multi-hour regional outage cascading to Slack, Atlassian, Snapchat, EC2 instance launches, Lambda invocations, Fargate | A race condition in DynamoDB's internal DNS management caused two DNS Enactor processes to run concurrently, with a stale-plan check allowing an old plan to overwrite a newer one. Cleanup automation then deleted the stale plan, wiping DynamoDB DNS records. The cascading failure footprint was observability-invisible at the cross-service level because each affected service emitted its own local "my dependency is down" signal. There was no single-pane-of-glass showing that the root cause was DynamoDB DNS. | [InfoQ writeup](https://www.infoq.com/news/2025/11/aws-dynamodb-outage-postmortem/), [ThousandEyes analysis](https://www.thousandeyes.com/blog/aws-outage-analysis-october-20-2025), [Gremlin lessons](https://www.gremlin.com/blog/reliability-lessons-from-the-2025-aws-dynamodb-outage) |

Three observability-shaped patterns repeat:

1. **The observability surface depends on the thing it observes.** Facebook 2021, Roblox 2021, Datadog 2023, Slack 2021, AWS us-east-1 2021. When the dependency fails, the tool to see the failure fails with it. Roblox explicitly made "remove circular dependencies in the observability stack" a remediation.
2. **Uniform rollouts defeat symptom-based alerting.** Cloudflare 2019, Cloudflare 2022, CrowdStrike 2024. The alert fires everywhere at once, so the signal carries no differential information: there is no control group that was not hit, no subset that is healthy to compare against.
3. **Alert-fatigue-under-pressure.** GitHub 2018 explicitly cited triaging volume of incoming notifications as part of the response-time cost. The alerts existed; there were too many of them at the exact moment the engineer had the least capacity to filter.

---

## 3. Existing tools and their gaps

The vendor landscape is full. observe-ready's job is not to pick a tool; it is to specify what any chosen tool must actually do in the config it lands with.

### 3.1 Datadog

What it does: metrics, logs, APM, RUM, synthetics, SLOs, notebooks, dashboards, LLM Observability, all in one UI with generous product depth. Manages via Terraform provider with first-class `datadog_monitor`, `datadog_dashboard`, `datadog_service_level_objective` resources ([Datadog Terraform docs](https://docs.datadoghq.com/getting_started/integrations/terraform/)).

What it does not catch:
- Custom-metric cardinality billing is unbounded unless you configure it. "Metrics Without Limits" helps, but introduces its own complexity; Sawmills explicitly catalogs this as the stealth tax ([Sawmills](https://www.sawmills.ai/blog/best-practices-for-high-cardinality-metrics-in-datadog)). The AI-generated config does not tag exclusions.
- SLOs are first-class, but error budget policies (the "what happens when the budget is burned" rule) are not. You wire SLO to monitor; the monitor fires; the human decides. The org-level policy is out of band.
- Dashboards are free to create, expensive to maintain. There is no "last viewed 90 days ago, archive?" flow by default.

### 3.2 Grafana Cloud and the LGTM stack (Loki, Tempo, Mimir)

What it does: open-source-anchored observability. Grafana dashboards, Loki logs, Tempo traces, Mimir metrics. Adaptive Metrics auto-identifies unused time series for aggregation ([Grafana Cloud](https://grafana.com/products/cloud/)).

What it does not catch:
- Cardinality dashboards exist but are opt-in. The default is "ingest everything, bill by the 10k active series."
- Tempo retention is decoupled from Mimir retention. A trace sampled in Tempo may not join a metric still in Mimir at the time of query. AI-authored configs do not align retention windows.
- Loki's label-based index is powerful but will penalize you hard for a high-cardinality label. The config mistake is cheap to make and expensive to keep.

### 3.3 Honeycomb

What it does: wide structured events. Charity Majors' argument is that the "three pillars" are three views of one event stream, not three independent stores; Honeycomb charges by number of events, not per-attribute, which makes high-cardinality debugging economically viable ([Honeycomb on structured events](https://www.honeycomb.io/blog/structured-events-basis-observability); [high cardinality docs](https://docs.honeycomb.io/get-started/basics/observability/concepts/high-cardinality)). BubbleUp is the signature feature: compare a subset of events (the errors) to the baseline and show which dimensions differ.

What it does not catch:
- No built-in logs or traces store that is decoupled from the event model. If your app does not emit wide events, you are doing adapter work.
- Pricing model is linear on event count; if you instrument deeply without sampling, the bill tracks event volume, not infrastructure size.
- SLO support is present but the error-budget-policy and multi-burn-rate math still needs to be configured at the query level.

### 3.4 New Relic, Dynatrace, Splunk Observability (formerly SignalFx and AppDynamics under one roof)

What they do: full-fidelity APM with AI-driven anomaly detection and strong enterprise integrations. Dynatrace's OneAgent is still the most automated instrumentation in market.

What they do not catch:
- Pricing opacity is a recurring complaint. New Relic's CCU model produces "unpredictable costs" per SigNoz's writeup, with customers tracking spend in spreadsheets because "the bill is too complex to understand otherwise" ([SigNoz](https://signoz.io/blog/new-relic-ccu-pricing-unpredictable-costs/)).
- Proprietary agents create migration friction. Splunk acquired SignalFx and then AppDynamics; organizations find themselves with two Splunk-branded observability stacks that do not share ontology.
- The AI-driven "anomaly detection" is probabilistic; during a correlated failure it produces correlated anomalies with no causal ranking.

### 3.5 Chronosphere and Cribl (observability pipelines)

What they do: Chronosphere is a purpose-built Kubernetes observability platform with an explicit cost-control pitch. Cribl Stream is a vendor-agnostic telemetry pipeline that filters, enriches, and routes telemetry before it lands in the expensive backend.

Chronosphere frames the cost problem concretely: "enterprise log data growth is exceeding 250% year over year, with many organizations estimating that roughly 70% of their observability spend goes toward storing logs that are never queried" ([Chronosphere 2025 trends](https://chronosphere.io/learn/2025-top-observability-trends/); [SiliconANGLE on Chronosphere](https://siliconangle.com/2026/02/05/observability-cost-ai-scale-chronosphere-opensourcesummit/)). Cribl markets 30-50% volume reductions as routine ([Cribl](https://cribl.io/solutions/initiatives/cost-control/)).

What they do not catch:
- Neither opinions on what to alert on or what the SLO should be. They are pipeline infrastructure.
- Both require the upstream app to emit coherent telemetry in the first place.

### 3.6 Prometheus, Jaeger, OpenTelemetry Collector (open source self-host)

What they do: free, composable, CNCF-backed. Prometheus for metrics with PromQL, Jaeger for traces, OTel Collector for ingest/transform/export. OpenTelemetry graduated to CNCF graduated status in November 2024 ([CNCF announcement path](https://www.cncf.io/projects/opentelemetry/)).

What they do not catch:
- Operating the stack is a real workload. Long-term storage (Thanos, Cortex, Mimir), alerting (Alertmanager), dashboards (Grafana), retention (per-backend) are each independent choices.
- OTel Collector config is a rich, bespoke DSL. AI-generated configs routinely mis-order processors (a `tail_sampling` after a `batch` processor that loses the trace grouping) or misconfigure `memory_limiter` such that the collector OOMs under load.

### 3.7 Sentry, Rollbar, Bugsnag (error tracking)

What they do: capture exceptions with breadcrumbs, stack traces, release and deployment correlation. Sentry has the strongest performance-monitoring sidecar; Rollbar correlates with deploys aggressively and groups hard; Bugsnag is strongest on mobile (ANR and OOM crash data).

What they do not catch:
- Error tracking is a lens on a symptom. It does not tell you whether the user's request succeeded end-to-end; it tells you whether an exception happened somewhere.
- Grouping logic is opinionated and occasionally wrong. Rollbar groups aggressively, which can hide variant root causes; Sentry's default fingerprinting often over-splits under renames.
- None has a first-class SLO.

### 3.8 PagerDuty, incident.io, FireHydrant, Rootly, Blameless

What they do: alert routing, on-call rotation, incident coordination, postmortem capture, timeline, SLO-linked escalation, in some cases ChatOps-native workflows. PagerDuty is the incumbent; incident.io, FireHydrant, Rootly, Blameless are the 2020-era Slack-native insurgents.

What they do not catch:
- They are routing and coordination layers; the actual signal quality is upstream.
- Error-budget-policy automation is present in Rootly and others but is not a prescriptive standard.
- Runbooks attached to alerts are free text by default; they decay silently.

### 3.9 Better Stack, Checkly, Pingdom, BetterUptime (synthetic and status)

What they do: black-box uptime monitoring, status pages, browser checks, TLS and DNS checks. Checkly's writeup of their own 2024 outage is the model: "there was no monitoring or alerting for non-existing browser check results, so the outage went unnoticed for 5 hours" ([Checkly](https://www.checklyhq.com/blog/post-mortem-outage-browser-check-results-alerting)).

What they do not catch:
- They observe the public surface only. A correct status page and broken internal job is an invisible class of incident.
- Deadman's-switch style alerting (alert when the heartbeat stops) is not default; you have to know to configure it.

### 3.10 Lightstep, Chronosphere, Groundcover, ClickHouse-based stacks (SigNoz, others)

Lightstep was acquired by ServiceNow in 2021 and rebranded as ServiceNow Cloud Observability ([ServiceNow announcement](https://www.servicenow.com/blogs/2021/acquires-it-observability-leader-lightstep)). Chronosphere remains independent. Groundcover is eBPF-first and explicitly pitches itself as "observability without sending data to the vendor." ClickHouse-based stacks (SigNoz, Uptrace, and self-built) trade operational effort for dramatic cost reduction; SigNoz's public stance is that ClickHouse as a datastore produces lower infrastructure cost for large datasets.

### 3.11 Summary: what's left for observe-ready to own

Every tool in sections 3.1 to 3.10 is a distribution-shaped solution to the data problem. None of them has an opinion about the following, and all of the following are what actually goes wrong in AI-generated observability configs:

- **The bound to promise.** Every metric that is dashboarded should have an SLO behind it or be demoted to a supporting role. Every alert that pages should be linked to an SLO or user journey, not a threshold pulled from a demo.
- **The rollout-to-signal coupling.** If the deploy shape is uniform (no canary), the observability shape cannot differentiate. observe-ready has to refuse to emit "add an alert on error rate" as a sufficient plan when the rollout is uniform, because the alert will fire globally with no usable signal.
- **The dependency-graph test on the observability surface itself.** If your dashboards live on the same Kubernetes cluster as the app, you failed Roblox's remediation. observe-ready has to ask whether the observability path is reachable during the outage it describes.
- **The ownership and pruning policy on dashboards, alerts, and runbooks.** Every artifact gets an owner, a last-reviewed date, and a deletion default. AI-generated artifacts without that metadata are debt at birth.

---

## 4. OpenTelemetry adoption state, 2025-2026

OpenTelemetry was accepted to CNCF on 2019-05-07, incubated 2021-08-26, and reached graduated status in late 2024 / early 2025 ([CNCF project page](https://www.cncf.io/projects/opentelemetry/); [OpenTelemetry 2025 stability post](https://opentelemetry.io/blog/2025/stability-proposal-announcement/)). It supports four telemetry signals now (tracing, metrics, logs, and profiles) across more than a dozen languages.

### 4.1 What is stable

- **Traces.** Stable across major languages. W3C Trace Context propagation is the default. Instrumentation libraries for major web frameworks (Express, Fastify, Django, Spring, ASP.NET, Rails) are mature.
- **Metrics.** Stable. Data model and API are fixed.
- **Profiles.** The profiles data model reached stable in 2025 per OpenTelemetry's own release notes: "the new profiles data model is currently stable and is being used to lay the foundation for production-ready implementations" ([OpenTelemetry blog, 2025 stability](https://opentelemetry.io/blog/2025/stability-proposal-announcement/)).

### 4.2 What is still in motion

- **Logs API stability.** Still being stabilized across SDKs; the OpenTelemetry roadmap calls out "stabilizing the Logs API is crucial for providing a logging solution that aligns with OpenTelemetry's overarching goals."
- **Semantic conventions.** Many instrumentation libraries remain on "pre-release versions because they depend on experimental semantic conventions." New semantic convention groups emerged in 2024 (Databases, Messaging, RPC, System, AI / LLM), with Database conventions being actively stabilized ([OpenTelemetry semantic conventions](https://opentelemetry.io/docs/concepts/semantic-conventions/)).
- **Epoch releases.** A new release cadence model announced in 2025 aims to make adoption "easier for end-user organizations to consume" ([OpenTelemetry stability proposal](https://opentelemetry.io/blog/2025/stability-proposal-announcement/)).

### 4.3 Context propagation pitfalls

OpenTelemetry works only if context propagates. Three common traps:

- **Async queues.** The publisher must inject trace context into message headers; the consumer must extract. Dapr workflows explicitly publish context propagation guidance ([OpenTelemetry Dapr post](https://opentelemetry.io/blog/2026/dapr-workflow-observability/)). Without this, a job queue breaks the trace at every enqueue.
- **Long-lived gRPC streams.** "W3C trace context propagation is difficult with long-lived gRPC streams because HTTP and unary gRPC calls naturally carry traceparent and tracestate headers with each request, but a long-lived stream does not; once the stream is open, workflow steps cannot attach new metadata" ([Tracetest](https://tracetest.io/blog/opentelemetry-trace-context-propagation-for-grpc-streams)). The workaround is to attach context per message manually.
- **Serverless cold starts and fan-out.** Lambda-to-Lambda via async invocation breaks the propagation path; context must be carried in the event payload.

### 4.4 Sampling strategies

- **Head-based sampling** is the default and what every AI-generated config uses. It is simple, has no state, and is fast. It cannot sample on error because the error has not happened yet at span creation time ([OpenTelemetry sampling docs](https://opentelemetry.io/docs/concepts/sampling/)).
- **Tail-based sampling** keeps the interesting tail (errors, latency outliers, specific attributes). It requires all spans of a trace to be routed to the same collector instance, which creates a scaling challenge; the collector must buffer every in-flight trace until the sampling decision window closes ([OneUptime head vs tail](https://oneuptime.com/blog/post/2026-02-06-head-based-vs-tail-based-sampling-opentelemetry/view); [CubeAPM](https://cubeapm.com/blog/head-based-vs-tail-based-sampling/)).
- **Adaptive sampling.** Tail samplers may fall back to a less expensive strategy if they cannot keep up.

observe-ready's position: head sampling is fine for learning; a production stack that commits to traces without tail sampling (or an equivalent error-biased strategy) will miss the traces it actually needs during incidents. The AI default is insufficient and the skill should say so.

---

## 5. Alert fatigue literature: the actionability bar

The consensus across every serious source is the same: every alert must be actionable, or it should not page. The consensus predates SRE and is stable across Rob Ewaschuk (2013), the SRE book (2016), the SRE workbook (2018), Honeycomb (2020-2025), incident.io (2025), and Runframe (2026). The principle does not bend; the data says it is routinely ignored in practice.

### 5.1 Rob Ewaschuk, "My Philosophy on Alerting"

The canonical text. "Pages should be urgent, important, actionable, and real. They should represent either ongoing or imminent problems with your service" ([Ewaschuk](https://docs.google.com/document/d/199PqyG3UsyXlwieHaqbGiWVa8eMWi8zzAn0YfcApr8Q/edit)). The key operational principle: "err on the side of removing noisy alerts, over-monitoring is a harder problem to solve than under-monitoring." Ewaschuk's argument that symptom-based alerting dominates cause-based alerting is picked up whole into the SRE book chapter 6.

### 5.2 The SRE workbook on multi-window multi-burn-rate

Google's SRE workbook chapter on alerting on SLOs is the definitive treatment. "In most cases, the multiwindow, multi-burn-rate alerting technique is the most appropriate approach to defending your application's SLOs" ([Google SRE workbook](https://sre.google/workbook/alerting-on-slos/)). Burn rate is how fast, relative to the SLO, a service consumes the error budget. A single-window burn-rate alert is either too noisy (short window, small spikes page you) or too slow (long window, half your budget is gone before it fires). The multi-window multi-burn-rate pattern requires both a short-window and a long-window burn rate to exceed threshold simultaneously, which preserves detection speed while slashing noise.

Grafana's practical implementation guide ([Grafana](https://grafana.com/blog/how-to-implement-multi-window-multi-burn-rate-alerts-with-grafana-cloud/)) and Datadog's "burn rate is a better error rate" post ([Datadog](https://www.datadoghq.com/blog/burn-rate-is-better-error-rate/)) both reproduce the SRE workbook's four-tier matrix: a fast tier (14.4x burn for 1 hour, 5-minute short window), a medium tier (6x burn for 6 hours, 30-minute short window), and two slower tiers for trend detection. The math is fixed; the SLO is the input.

### 5.3 Charity Majors and Liz Fong-Jones on actionable alerts

Charity Majors puts it as a principle of observability-driven development: "you should never accept a pull-request unless you can answer the question, 'how will I know when this isn't working?'" ([InfoQ interview](https://www.infoq.com/articles/charity-majors-observability-failure/)). And more pointedly on the alert side, "on-call alerting should be triggered by service level objectives (SLOs) rather than simply being triggered by infrastructure failure or monitoring threshold breaches, and engineers should only be woken up if the business is being impacted."

Liz Fong-Jones frames SLO-based alerting as a reliability and retention play: "SLOs can be used to ensure that organizations are only alerting engineers when there's a genuine problem, allow organizations to understand whether engineering is moving too fast or too slow, and by having a quantitative idea of what reliability is within a system, engineers have a better idea of whether they've got scope to add new features" ([Platform Engineering talk](https://platformengineering.org/talks-library/observability-and-measuring-slos); [Honeycomb](https://www.honeycomb.io/author/lizf)).

### 5.4 Industry data on the false-positive baseline

- Incident.io 2025 survey across "hundreds of DevOps and SRE teams": "85% of teams report that the majority of their alerts are false positives" ([incident.io](https://incident.io/blog/alert-fatigue-solutions-for-dev-ops-teams-in-2025-what-works)).
- "67% of engineers admit to ignoring or dismissing alerts without investigating."
- "73% of organizations experienced outages linked to ignored alerts."
- Runframe 2026 State of Incident Management: toil rose 30% in 2025, the first increase in five years, despite heavy AI investment. "78% of developers spend 30%+ of their time on manual toil." ([Runframe](https://runframe.io/blog/state-of-incident-management-2025))
- PagerDuty markets Event Intelligence's 98% noise reduction as a headline feature, which implies the baseline is 2% signal ([PagerDuty](https://www.pagerduty.com/resources/digital-operations/learn/alert-fatigue/)).

### 5.5 The ratio: what should page vs ticket vs log

The SRE community's rule of thumb, derived from Ewaschuk and codified in the SRE workbook, is roughly:

- **Page** only for active user-visible problems or imminent burn of error budget. Multi-burn-rate SLO alerts. Page volume per on-call should be low-single-digit per shift.
- **Ticket** for latent issues that need attention this business day. Disk trending toward full. Certificate expiring in 30 days.
- **Log / dashboard only** for everything else. Metric trends that are interesting but not actionable.

The AI-generated default is "everything is a page, severity high." That is the observability equivalent of treating every commit as a release.

---

## 6. Observability vs monitoring: the Majors argument

The rhetorical move that Charity Majors made popular from roughly 2017 onward is to distinguish monitoring (watching known knowns, alerting on predicted failure modes) from observability (the ability to ask arbitrary questions of a system's behavior, including ones you did not think of in advance). The distinction matters because the failure modes AI-generated configs produce are monitoring failure modes; fixing them requires observability-shaped thinking.

### 6.1 The "unknown unknowns" framing

The classical observability argument: monitoring works when you know what can go wrong. Modern distributed systems fail in ways you cannot predict. Dynatrace's own framing concedes the point: "monitoring has a big blind spot, it only watches what you tell it to watch and requires you to know ahead of time what metrics or events are the harbingers of trouble" ([Dynatrace](https://www.dynatrace.com/news/blog/observability-vs-monitoring/)). Honeycomb's argument is more direct: observability requires wide structured events with enough dimensions that you can slice the data after the fact to find the combination of attributes that correlates with failure.

### 6.2 Cardinality is the load-bearing technical idea

High cardinality means many distinct values for a field (user IDs, request IDs, trace IDs, shopping cart IDs). High dimensionality means many fields per event. Honeycomb's claim: "mature instrumented services typically have around 100 dimensions per event" ([Honeycomb](https://www.honeycomb.io/blog/structured-events-basis-observability)). Traditional metrics-based tooling penalizes cardinality economically (every unique tag combination is a separate time series and a separate line on the invoice). Observability tools built around wide events price on event count, not attribute count, which keeps debug-shaped queries affordable.

The AI-generated config trap: `user_id` as a Datadog tag is a bill detonator. `user_id` as a Honeycomb event attribute is free. observe-ready should know the difference and refuse to emit high-cardinality tags against per-time-series pricing without explicit exclusion rules.

### 6.3 The "three pillars" debate

Honeycomb's explicit position: "three pillars refers to the idea of three separate telemetry signals, metrics, logs, and traces. These three signals have different structure, semantics, and use cases, and they're typically viewed in isolation from one another" and this isolation is the problem ([Honeycomb, OpenTelemetry is not three pillars](https://www.honeycomb.io/blog/opentelemetry-is-not-three-pillars); [They Aren't Pillars, They're Lenses](https://www.honeycomb.io/blog/they-arent-pillars-theyre-lenses)). The reframing: "monitoring, tracing, and logs shouldn't be different sets of data. Rather, they should be different views of the same cohesive picture."

Honeycomb's "Observability 2.0" framing is the 2024-2025 recasting: "Observability 1.0 has three pillars and many sources of truth, scattered across disparate tools and formats. Observability 2.0 has one source of truth, wide structured log events, from which you can derive all the other data types" ([Honeycomb](https://www.honeycomb.io/blog/time-to-version-observability-signs-point-to-yes); [charity.wtf](https://charity.wtf/tag/observability-2-0/)). The New Stack's piece "How the 3 Pillars of Observability Miss the Big Picture" makes the adjacent argument ([The New Stack](https://thenewstack.io/how-the-3-pillars-of-observability-miss-the-big-picture/)).

### 6.4 The observability cost crisis

Honeycomb's own blog calls it out: "The Cost Crisis in Observability Tooling" ([Honeycomb](https://www.honeycomb.io/blog/cost-crisis-observability-tooling)). Chronosphere pegs "enterprise log data growth exceeding 250% year over year" and "roughly 70% of observability spend going toward storing logs that are never queried" ([Chronosphere](https://chronosphere.io/learn/2025-top-observability-trends/)). Cribl claims 30-50% volume reductions as routine via pipeline filtering ([Cribl](https://cribl.io/solutions/initiatives/cost-control/)).

The failure mode is structural: legacy ingest-priced vendors incentivize instrumentation that fills the pipe whether or not the data is ever read. AI-generated configs ingest everything by default because the demo did. observe-ready's opinion has to be that ingest defaults need active negative curation, not just additive instrumentation.

---

## 7. SLO design literature: the hard problem

### 7.1 Canonical texts

- Google's SRE Book chapters 3 (Embracing Risk), 4 (Service Level Objectives), and 6 (Monitoring Distributed Systems) are the founding texts.
- Google's SRE Workbook chapters on implementing SLOs, alerting on SLOs, and error budget policy are the prescriptive counterparts ([SRE workbook on alerting on SLOs](https://sre.google/workbook/alerting-on-slos/); [error budget policy](https://sre.google/workbook/error-budget-policy/)).
- Alex Hidalgo's *Implementing Service Level Objectives* (O'Reilly, 2020) is the current practitioner book; it introduces the Reliability Stack framework and covers advanced SLI techniques and error budget use ([O'Reilly](https://www.oreilly.com/library/view/implementing-service-level/9781492076803/)).
- Nobl9's intro to error budget policies codifies the pattern for practitioners ([Nobl9](https://www.nobl9.com/resources/intro-to-error-budget-policies)).

### 7.2 SLO, SLI, error budget in plain language

- **SLI (Service Level Indicator)**: a measurable reliability signal. "What fraction of requests in the last N seconds returned 2xx in under 200ms."
- **SLO (Service Level Objective)**: a promise about the SLI over a time window. "99.9% of requests in a rolling 30-day window meet the SLI."
- **Error budget**: 1 minus SLO, converted to "bad events you can absorb." For 99.9% SLO over 30 days with 10M requests, error budget is 10,000 bad events.
- **Error budget policy**: the rule the org follows when the budget burns. Classic template: "if we burn >50% of the budget in a calendar month, freeze feature launches and work on reliability until the budget recovers" ([SRE workbook](https://sre.google/workbook/error-budget-policy/); [Nobl9](https://www.nobl9.com/resources/intro-to-error-budget-policies)).

### 7.3 Multi-window multi-burn-rate math

The recipe (from the SRE workbook, reproduced in every serious SLO vendor guide):

- 14.4x burn rate over 1-hour long window + 5-minute short window -> page for fast-acute burns. Consumes 2% of monthly budget in an hour.
- 6x burn rate over 6-hour long window + 30-minute short window -> page for medium burns. Consumes 5% of monthly budget in 6 hours.
- 3x burn rate over 24-hour long window + 2-hour short window -> ticket for slow burns.
- 1x burn rate over 72-hour long window + 6-hour short window -> ticket for drift.

Both windows must fire simultaneously for the alert to trigger. The short window preserves detection speed; the long window filters noise. Grafana's implementation walkthrough is the cleanest ([Grafana](https://grafana.com/blog/how-to-implement-multi-window-multi-burn-rate-alerts-with-grafana-cloud/)); OneUptime reproduces the pattern in a 2026 guide ([OneUptime](https://oneuptime.com/blog/post/2026-02-17-how-to-set-up-multi-window-multi-burn-rate-alerting-for-slos-on-google-cloud/view)). AI-generated monitor configs emit single-window burn-rate alerts; they get the noise / speed tradeoff wrong in both directions.

### 7.4 Low-traffic services and the SLO edge case

The SRE workbook explicitly flags it: "the multiwindow, multi-burn-rate approach works well when a sufficiently high rate of incoming requests provides a meaningful signal. However, these approaches can cause problems for systems that receive a low rate of requests. If a system has either a low number of users or natural low-traffic periods (such as nights and weekends), you may need to alter your approach. It's harder to automatically distinguish unimportant events in low-traffic services." The workaround is to extend windows, switch to synthetic traffic, or aggregate across related services. observe-ready must handle this case explicitly for new/small apps.

### 7.5 The "too tight SLO" trap

An SLO tighter than the dependency stack allows is worse than no SLO, because it guarantees the budget is always burned and the policy is always triggered, at which point the team stops trusting the policy. Hidalgo's book argues for starting loose and tightening with data. Nobl9's SLO framework guide echoes it: "If an error budget is exceeded, the general remedy is to focus on improving reliability, which may be enough of a policy" ([Nobl9 framework](https://www.nobl9.com/resources/slo-framework)). A 99.99% SLO on a service that depends on a 99.9% upstream cannot be met; claiming it is a lie the postmortem will expose.

### 7.6 Composition across services

If service A calls service B calls service C, and each has a 99.9% SLO, the end-to-end SLO for A is approximately 99.7% (the product). AI-generated SLO configs do not know about the dependency chain. observe-ready should flag the SLO product against the call graph.

### 7.7 Error budget policy as the political deliverable

The SRE workbook is explicit: the policy is the document that tells product and engineering how to behave when reliability is threatened ([SRE workbook error budget policy](https://sre.google/workbook/error-budget-policy/); [GitLab's public handbook error budget page](https://handbook.gitlab.com/handbook/engineering/error-budgets/)). A common pattern: if the rolling-window burn exceeds 50% at the halfway point, product cannot ship non-reliability work until burn recovers. The AI-generated "add an SLO" step routinely omits the policy. An SLO without a policy is a number on a dashboard.

---

## 8. The naming lane

deploy-ready landed on "paper canary" (canary with no numerical success criterion, no metric, no rollback trigger) and "expand-only migration trap" (shipped the expand phase, skipped the contract). stack-ready landed on "half-wired CTA" for components with visible controls and no wired handler. The observe-ready equivalent needs to name the class of "the artifact exists, the signal does not."

### 8.1 Claimed or too-generic terms (do not use)

- **Alert fatigue** is the heaviest claim in the space; used by every vendor from PagerDuty to IBM to Splunk ([IBM on alert fatigue](https://www.ibm.com/think/topics/alert-fatigue); [Atlassian](https://www.atlassian.com/incident-management/on-call/alert-fatigue)). Too claimed to own; observe-ready can reference it but cannot name it.
- **Alert graveyard** appears informally but has no specific observability claim attached. Possibly available, but diffuse in meaning.
- **Observability debt** is claimed. HackerNoon's "Observability Debt Hypothesis" ([HackerNoon](https://hackernoon.com/the-observability-debt-hypothesis-why-perfect-dashboards-still-mask-failing-systems)), TechDebt.guru's piece ([TechDebt.guru](https://techdebt.guru/observability-debt/)), and general industry use. Do not claim.
- **Dashboard sprawl** is claimed, cross-industry (BI, observability), heavy usage ([Atlan](https://atlan.com/know/how-to-reduce-data-dashboard-sprawl/); [SquaredUp](https://squaredup.com/blog/perspectives-our-solution-to-dashboard-sprawl/); [Tasman](https://www.tasman.ai/news/dashboard-sprawl-is-killing-your-business)). Do not claim.
- **Monitoring theater** has informal use as a pejorative; too close to generic "security theater" metaphor to claim distinctively.
- **Runbook drift** is claimed ([IncidentHub](https://blog.incidenthub.cloud/The-No-Nonsense-Guide-to-Runbook-Best-Practices)). Do not claim.
- **Three pillars / Observability 2.0 / wide events** are Honeycomb's territory.
- **SLO / SLI / error budget** are Google SRE terms.
- **Flying blind** is too broad; every industry uses it.

### 8.2 Candidates that appear unclaimed and fit the lane

Searches for each term as an observability-specific named anti-pattern returned no vendor or practitioner-established use:

- **"paper SLO"**: returns zero results as an established observability term. The phrase is natural enough to plausibly exist; it does not. Candidate is open.
- **"paper runbook"**: returns zero specific established use in the observability domain; general runbook literature uses "untested runbook" or "drifted runbook." Candidate is open.
- **"blind dashboard"**: returns zero established use.
- **"cold pager"**: returns zero specific observability use. The closest claim is dead man's switch / deadman alerts, which is a different pattern.
- **"dead alert"**: informal use exists but no canonical vendor claim.
- **"SLO cosplay"**: returns zero established use.
- **"cosmetic SLO"**: returns zero established use.
- **"unreachable runbook"**: the phrase is natural and unclaimed.
- **"phantom dashboard"**: unclaimed.

### 8.3 Recommended lane, ranked

The skill needs one flagship term, hooked to an immediately legible failure mode, and one or two technical-section terms. Same format as deploy-ready's lane.

1. **Paper SLO.** An SLO with no error-budget policy, no alert wired to it, no review cadence, and no stakeholder who knows its number. It appears on a page; it does nothing. The analogy to deploy-ready's "paper canary" is intentional: both are "the word is present, the mechanism is not." Paper canary is "routed traffic, no criterion;" paper SLO is "promised number, no consequence." The term is short, sticky, and it maps to an entire class of AI-generated SLO configs that satisfy review and do not constrain anyone's behavior. **Recommended as primary.**

2. **Blind dashboard.** A dashboard above the fold with metrics nobody has an SLO for and nobody watched during the last incident. It passes review because it has charts; it fails its job because those charts are not bound to any promise. The term aligns with the existing "flying blind" idiom without owning it, and it contrasts precisely with "paper SLO": one says "we wrote the promise, did not wire it;" the other says "we wired the view, did not bind it to a promise." Together they bracket the two most common AI-generated observability artifacts. **Recommended as secondary, section header for dashboard discipline.**

3. **Paper runbook.** A runbook that was written once, attached to an alert, and never executed. The grep commands reference log fields that have since been renamed. The URLs 404. The runbook exists, passed review, and fails on first execution during a real incident. Distinct from "runbook drift" because the term there describes a process (drift); "paper runbook" names the artifact. **Recommended as tertiary term for the on-call ergonomics section.**

Secondary useful term: **unreachable runbook** (the runbook is hosted on the service that is down, or requires VPN that is down, or requires SSO that is the problem). Closely related to the Facebook 2021 and Roblox 2021 patterns.

### 8.4 Why paper SLO as flagship

The word "SLO" is the one concept AI-generated observability configs hear the loudest and produce the most shallowly. A skill that leads with "paper SLO" announces its position immediately: observe-ready will not accept an SLO as a deliverable unless the error-budget policy and the multi-burn-rate alert and the review cadence all come with it. The flagship failure mode is high-frequency and high-impact; it names a thing every SRE recognizes without being named already.

---

## 9. Frequency data and sizing

### 9.1 The alert-quality baseline

- Incident.io 2025: "85% of teams report that the majority of their alerts are false positives" ([incident.io](https://incident.io/blog/alert-fatigue-solutions-for-dev-ops-teams-in-2025-what-works)).
- "67% of engineers admit to ignoring or dismissing alerts without investigating."
- "73% of organizations experienced outages linked to ignored alerts."
- Runframe 2026 State of Incident Management (synthesis of 20+ reports, 25+ team interviews July-December 2025): "operational toil rose 30% in 2025, the first rise in five years, despite AI investment." "78% of developers spend 30%+ of their time on manual toil, for a 250-person team that equals ~$9.4M/year" ([Runframe](https://runframe.io/blog/state-of-incident-management-2025)).
- PagerDuty implicit baseline: Event Intelligence's 98% noise reduction pitch suggests 2% of incoming alerts are actionable in the default customer state ([PagerDuty](https://www.pagerduty.com/resources/digital-operations/learn/alert-fatigue/)).

### 9.2 DORA and detection time

DORA 2024 updated MTTR to FDRT (Failed Deployment Recovery Time), narrowing the metric to deployment-attributable failures to separate software delivery quality from "the earthquake took the DC down" ([DORA guide](https://dora.dev/guides/dora-metrics/); [RedMonk on DORA 2024](https://redmonk.com/rstephens/2024/11/26/dora2024/); [Axify on change failure rate](https://axify.io/blog/change-failure-rate-explained)). The DORA high-performer benchmark for change failure rate is 0-2%. DORA's MTTD (Mean Time to Discover) is separate and measures detection speed explicitly, which is the quantity observe-ready directly affects. DORA 2024 also measured a 7.2% stability drop for AI-assisted delivery teams, which covers both deploy and observability hygiene ([DORA 2024](https://dora.dev/research/2024/dora-report/)).

### 9.3 Post-incident data on "the monitoring did not fire"

A hard statistic is not public, but the qualitative pattern is in the major postmortems:

- Checkly 2024: "the outage went unnoticed for 5 hours" because of a missing alert on absence of check results ([Checkly](https://www.checklyhq.com/blog/post-mortem-outage-browser-check-results-alerting)).
- Slack 2021: observability surface was down with the service ([Slack Engineering](https://slack.engineering/slacks-outage-on-january-4th-2021/)).
- Roblox 2021: explicitly called out circular dependency between observability and Consul as a primary extender of the 73-hour outage ([Roblox](https://about.roblox.com/newsroom/2022/01/roblox-return-to-service-10-28-10-31-2021)).
- Facebook 2021: tools unreachable during the incident ([Cloudflare](https://blog.cloudflare.com/october-2021-facebook-outage/)).
- GitHub 2018: alerts fired in high volume, signal-to-noise under load was a response-time tax ([GitHub](https://github.blog/2018-10-30-oct21-post-incident-analysis/)).

Dan Luu maintains a canonical collection of public postmortems at [danluu/post-mortems](https://github.com/danluu/post-mortems); the observability failure modes above repeat across the collection.

### 9.4 Cost of dashboard and metric sprawl

- Flexport: 2,700+ dashboards reduced to ~60 ([Tasman](https://www.tasman.ai/news/dashboard-sprawl-is-killing-your-business)).
- ASAPP: 400+ Grafana dashboards before cleanup ([Tech Monitor](https://www.techmonitor.ai/leadership/digital-transformation/asapp-dashboard-sprawl-case-study)).
- Enterprise log growth: 250% year over year per Chronosphere ([Chronosphere](https://chronosphere.io/learn/2025-top-observability-trends/)).
- ~70% of observability spend goes to logs that are never queried ([Chronosphere](https://chronosphere.io/learn/2025-top-observability-trends/); [SiliconANGLE](https://siliconangle.com/2026/02/05/observability-cost-ai-scale-chronosphere-opensourcesummit/)).
- Cribl pipeline reductions: 30-50% volume reduction as typical ([Cribl](https://cribl.io/solutions/initiatives/cost-control/)).
- New Relic CCU-based bill-shock anecdotes are common; "a company reported that when they turned on JVM-level telemetry unaware that it incurred a 'custom event' cost, it skyrocketed their bill 10x for a month" ([Middleware](https://middleware.io/blog/new-relic-pricing/); [SigNoz](https://signoz.io/blog/new-relic-ccu-pricing-unpredictable-costs/)).
- Datadog custom metrics pricing: "10x more expensive than Sysdig" per SigNoz ([SigNoz](https://signoz.io/blog/datadog-pricing/)).

### 9.5 Comparison to siblings

- production-ready reports qualitative "hollow dashboard" frequency (TODO counts, placeholder UI).
- stack-ready reports qualitative "stack regret" frequency.
- deploy-ready has hard DORA numbers.
- observe-ready has the hardest alert-quality and cost-sprawl numbers in the suite: the 85% false-positive rate, 67% alert ignoring, 73% correlation with outages, 70% queried-never log spend, and the named postmortems where the observability surface failed with the service. These are citable, specific, and quantitative.

---

## 10. Synthesis: what observe-ready owns

### 10.1 What observe-ready owns that no sibling and no tool does

Three load-bearing ideas. Each is distinct from a sibling's territory and not enforced by any vendor.

**(a) Every metric is bound to a promise, or it is demoted.** observe-ready will not accept a dashboard or a monitor as a complete deliverable unless every charted metric is either (1) a Service Level Indicator with a documented SLO behind it, (2) a supporting diagnostic metric explicitly marked as non-alerting, or (3) removed. The skill rejects the "add Datadog" default of forty generic charts and emits instead a short, bound dashboard: three to five SLIs, one per user-visible journey, each with a numbered SLO, each with a multi-window multi-burn-rate alert tier, each with an error budget policy rule. The rest is supporting material or deleted. This is the **paper SLO** test: any SLO that lacks the policy-plus-alert triplet is refused.

**(b) The rollout shape and the observability shape must match.** observe-ready consumes deploy-ready's output. If the deploy plan is uniform (no canary, no ring, no progressive rollout), observe-ready must refuse to emit "alert on error rate" as sufficient, because the error rate will rise everywhere at once and the alert carries no differential signal. CrowdStrike 2024 and Cloudflare 2019 are the canonical examples. The skill's rule: uniform rollouts require pre-rollout synthetic traffic observation or in-cluster shadow populations; non-uniform rollouts require population-tagged SLIs that differentiate ring membership. This preserves the observe-ready / deploy-ready boundary while calling out the cross-skill invariant.

**(c) The observability path cannot depend on the thing it observes.** Roblox's explicit remediation: "remove circular dependencies in the observability stack." observe-ready asks, for every observability artifact, "is this reachable if the app is down?" Dashboards hosted on the same cluster as the app are a soft failure. Runbooks hosted on Confluence with SSO gated through the same IdP as the app are a harder failure. Alert routing via the same Slack that depends on the same AWS region is the Facebook 2021 failure. The skill must enforce a dependency test on the observability surface itself, and recommend an out-of-band copy of the minimum needed (status page, runbook summary, contact tree) on infrastructure distinct from the app.

### 10.2 What observe-ready should enforce that is clearly observe-scoped

- **Multi-window multi-burn-rate alert defaults.** SLO alerts are never single-window. The SRE workbook tier matrix is the default; the AI-generated single-window alert is rejected.
- **Symptom-based pages, cause-based diagnostics.** Alerts that page are on user-visible SLIs. Cause-level metrics (CPU, memory, disk) are diagnostics only and do not page unless they predict a budget burn in a short horizon.
- **Sampling strategy appropriate to trace use.** Head sampling at 1% is acceptable for cheap debugging only. Any production commitment to traces requires tail sampling or error-biased sampling; the skill flags head-only configs as incomplete.
- **Retention alignment across signal types.** The trace retention window must cover the SLO window. If SLO is rolling 30 days and Tempo retention is 15 days, the skill flags the mismatch.
- **Cardinality budget per metric name.** High-cardinality dimensions (user_id, request_id, tenant_id) go on wide events or are explicitly excluded in the metrics pipeline. Datadog-style per-time-series pricing plus unbounded tags is a bill detonator the skill refuses.
- **PII scrubbing at the collector.** No AI-templated config ships without an OTel Collector attribute processor (or equivalent) that redacts declared PII fields. This is a GDPR-shaped default.
- **Runbook attached to every page, runbook is executable.** Alerts without runbooks are rejected; runbooks without a dated last-tested marker are flagged as paper runbooks.
- **Ownership and pruning metadata on every artifact.** Every dashboard, every alert, every SLO carries an owner, a last-reviewed date, and an archive-by rule. No artifact ships without these.
- **Error budget policy is part of the SLO deliverable.** An SLO number without a policy is a paper SLO; the skill refuses.
- **Deadman's switch / heartbeat.** Silent failure is detected by alert-on-absence. Checkly's own postmortem is the lesson.

### 10.3 Clear sibling boundary

- App wiring, scaffolded-but-unwired code, placeholder UI, feature-level CRUD: **production-ready**.
- Pipeline design, promotion, rollback, migration ordering, canary traffic-shift, progressive delivery mechanics: **deploy-ready**. observe-ready consumes the deploy shape but does not author it.
- Stack choice, framework-vs-framework decisions, provider selection: **stack-ready**.
- CODEOWNERS, branch protection, issue templates, review policy: **repo-ready**.
- Secrets vault choice, rotation policy, audit of secret access: **security**. observe-ready opinions on PII scrubbing in telemetry pipelines because that is an egress problem at the observability surface, not a vault problem.
- Product analytics, funnel analysis, A/B testing, user event tracking for marketing: **production-ready**'s product-telemetry territory. observe-ready cares about operational signals, not conversion signals.
- Security incident response playbooks, threat detection, SIEM: **production-ready**'s security deep-dive. observe-ready cares about application health.
- Performance tuning and scale plans: future scale-ready. observe-ready surfaces latency; it does not tune it.

### 10.4 Naming recommendation

Lead with **paper SLO** as the flagship term. It hooks to the SLO vocabulary that is already legible, it short-circuits the AI-generated "add an SLO" default that emits a number without consequences, and it gives the skill a concrete refusal criterion: no error-budget policy means no SLO. Carry **blind dashboard** as the secondary term for the dashboards section; carry **paper runbook** for the on-call ergonomics section; reserve **unreachable runbook** for the Facebook / Roblox pattern in the dependency-graph section. The flagship term's cousin is deploy-ready's paper canary; the two names together describe the "artifact present, mechanism absent" failure mode across deploy and observe, which is the defining AI-generated systems-engineering failure at this scale.

### 10.5 Frequency framing

observe-ready can lead with the hardest numbers in the ready-suite. Four citations up front do more work than any rhetoric:

- 85% of teams report majority of alerts are false positives (incident.io 2025).
- 67% of engineers admit to ignoring alerts (incident.io 2025).
- 73% of organizations had outages linked to ignored alerts (incident.io 2025).
- ~70% of observability spend goes to logs that are never queried (Chronosphere 2025).

Plus the named incidents where the observability surface failed: Slack 2021, Roblox 2021, Facebook 2021, Datadog 2023, AWS us-east-1 2021 and 2025. The pitch converts from "your monitoring might be bad" to "your monitoring is statistically noise, economically wasteful, and likely to fail when you need it."

The skill's opening claim can be direct: most AI-generated observability configs are paper SLOs on blind dashboards, wired to noisy alerts, with paper runbooks, on an observability surface that fails with the service. observe-ready is the skill that refuses to accept any of those shapes as done.

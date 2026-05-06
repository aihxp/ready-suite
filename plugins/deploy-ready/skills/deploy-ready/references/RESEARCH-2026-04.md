# deploy-ready research pass, 2026-04

Scope check: this report covers the gap between a known-green build and real user-facing environments. It explicitly excludes IaC tool choice (stack-ready), observability / SLOs (observe-ready, not yet built), repo hygiene (repo-ready), secrets management/rotation/vaulting (security territory), and app-level wiring (production-ready). What is in scope: environment promotion, pipeline design for deploy, deployment topologies, zero-downtime migrations, rollback discipline, progressive delivery, secrets injection at deploy time, pre/post-deploy checks, and the first-deploy-vs-subsequent-deploy split.

---

## 1. Top complaints about AI-generated deploy artifacts

The pattern here is consistent across every primary source: AI output passes the local/CI gate and fails at the environment gate. The failure mode is not "the YAML is invalid" but "the YAML is valid and still wrong for this cluster, this account, this region, this day." Developers call this out specifically when they bring AI-authored deploy artifacts into production-shaped contexts.

### 1.1 "Passes validate, fails in prod" for Kubernetes and Terraform

Testkube's writeup of AI-generated Kubernetes manifests is the clearest statement of the pattern. AI tools like Cursor generate deployment YAML that passes every unit and schema test, every mock confirms the resources, and the manifest still fails when applied to an actual cluster because the mocks cannot simulate network policies, security contexts, admission controllers, or the cluster's version-specific behaviors ([Testkube, 2025](https://testkube.io/blog/system-level-testing-ai-generated-code)). This is not a code quality issue. It is a missing-environment-context issue dressed up as a code quality issue.

Gruntwork's post on AI with Terraform walks through the same failure in IaC: AI tools generate Terraform that assumes a fresh environment with no resources deployed, but production environments have existing resources, multi-team configurations, drifted state, pinned provider versions, and compliance requirements. The output can pass `terraform validate` and still conflict with state, use the wrong provider version, or omit mandatory encryption settings ([Gruntwork, 2025](https://www.gruntwork.io/blog/thinking-of-using-ai-with-terraform); [Spacelift, 2025](https://spacelift.io/blog/terraform-ai)). The DataTalks.Club incident (an AI agent destroying a production VPC, ECS cluster, load balancers, and bastion) is cited as the ugly version of this: the agent inferred the wrong mental model of the environment and acted on it ([dev.to, rsiv, 2025](https://dev.to/rsiv/ai-sped-up-development-not-shipping-5g1)).

### 1.2 Missing readiness probes and broken rolling updates

AI-generated Deployment manifests frequently ship without readiness probes, or with probes whose path/port do not match the app. Kubernetes will then happily mark Pods Ready before they are Ready, route traffic into the void, or stall the rollout indefinitely. Resolve.ai and CubeAPM document this as one of the most common probe-related failure modes on rollout, particularly on copy-pasted or AI-templated manifests where the probe was not updated to match the app ([Resolve.ai](https://resolve.ai/glossary/how-to-debug-kubernetes-probe-issues); [CubeAPM](https://cubeapm.com/blog/kubernetes-readiness-probe-failed-error/)). Groundcover's writeup on deployments that "don't update" traces the same pattern to AI-copied manifests between applications with different endpoints ([groundcover](https://www.groundcover.com/learn/kubernetes/deployment-not-updating)).

### 1.3 Dockerfiles and pipelines that assume local state

The Docker-layer leak problem is a specific AI regression. AI-generated Dockerfiles often `COPY . /app` or `COPY .env .env` for convenience, and any secrets in the working tree get baked into an image layer forever. Even `RUN rm secret.txt` in a later layer does not remove it from the image, because Docker layers are append-only. Truffle Security and Intrinsec's surveys of Docker Hub found over 10,000 images leaking credentials through exactly this pattern; GitGuardian's 2026 secrets report attributes a 2x baseline leak rate to AI-assisted commits ([Truffle Security](https://trufflesecurity.com/blog/how-secrets-leak-out-of-docker-images); [Intrinsec](https://www.intrinsec.com/en/docker-leak/); [BleepingComputer, 2024](https://www.bleepingcomputer.com/news/security/over-10-000-docker-hub-images-found-leaking-credentials-auth-keys/); [GitGuardian via dev.to, 2026](https://dev.to/mistaike_ai/29-million-secrets-leaked-on-github-last-year-ai-coding-tools-made-it-worse-2a42)).

### 1.4 Pipelines that conflate CI with CD (no gated promotion)

A recurring complaint on CI/CD forums and Tech-Now's troubleshooting guide: AI generates a single workflow that builds, tests, and deploys to production on every push to main, with no staging, no approval gate, no environment separation, and no way to promote the same artifact across environments ([Tech-Now](https://tech-now.io/en/it-support-issues/copilot-consulting/how-to-fix-copilot-not-integrating-with-ci-cd-pipelines)). The anti-pattern is "push straight to prod," often written confidently, often with a production secret pasted into the workflow file. Related: AI-generated workflows routinely use `pull_request_target` or `workflow_run` with untrusted fork code paths, creating real RCE-and-secret-exfil paths ([Wiz](https://www.wiz.io/blog/github-actions-security-guide); [Orca Security, pull_request_nightmare](https://orca.security/resources/blog/pull-request-nightmare-github-actions-rce/); [timescale/pgai advisory](https://github.com/timescale/pgai/security/advisories/GHSA-89qq-hgvp-x37m)).

### 1.5 Migrations that are not actually zero-downtime

The AI output is cheerfully labelled "zero-downtime migration" and is in fact a single transaction that takes an ACCESS EXCLUSIVE lock on a big table. See section 4 for the canonical failure modes. The specific AI regression: because "zero-downtime migration" is a recognizable literary genre, the LLM produces text that sounds like one without enforcing the invariants (no `ALTER COLUMN` that rewrites the table, no non-concurrent index on a live table, no `NOT NULL` default on a populated column, no rename of a column still being read by the old version of the app).

### 1.6 Prompt injection via CI and review comments

A more recent complaint, but now well-documented: Claude Code, Gemini CLI, and Copilot are vulnerable to prompt injection routed through PR comments and issue bodies, which at the CI stage can be used to exfiltrate deploy secrets or alter the deploy artifact before it ships ([cybersecuritynews.com, 2025](https://cybersecuritynews.com/prompt-injection-via-github-comments/)). This makes the naive "let the agent run the deploy" pattern dangerous in any repo that accepts outside contribution.

---

## 2. Named incidents

Incidents below are strictly scoped to deploy-level failure modes (shipping mechanics) rather than app bugs. Date, org, incident summary, the deploy-level failure mode, source.

| Date | Org | Incident | Deploy-level failure mode | Source |
|---|---|---|---|---|
| 2012-08-01 | Knight Capital | $460M loss in 45 minutes; bankruptcy within weeks | Partial deploy: new code pushed to 7 of 8 SMARS servers, the 8th kept running old "Power Peg" code; a reused feature flag activated dormant code on that 8th server. Rollback worsened things because the team re-deployed the new-with-reused-flag to all servers, spreading the defect. | [Kosli](https://www.kosli.com/blog/knight-capital-a-story-about-devops-automated-governance/), [Doug Seven](https://dougseven.com/2014/04/17/knightmare-a-devops-cautionary-tale/), [Henrico Dolfing](https://www.henricodolfing.com/2019/06/project-failure-case-study-knight-capital.html) |
| 2017-01-31 | GitLab.com | 300GB production data loss, 6 hours of lost user edits (~5,000 projects, ~5,000 comments, ~700 new accounts) | Engineer ran `rm -rf /var/opt/gitlab/postgresql/data/*` on the primary, intending the secondary. The compounding deploy-level failures: pg_dump backups were not running (a deploy-time config regression), alert emails for backup failure were silently rejected by DMARC, and replication to the secondary was already broken. Five of five recovery mechanisms had been silently disabled at deploy time. | [GitLab postmortem](https://about.gitlab.com/blog/postmortem-of-database-outage-of-january-31/), [The Register](https://www.theregister.com/2017/02/01/gitlab_data_loss/) |
| 2017-02-28 | AWS S3 (us-east-1) | ~4 hours, estimated $150M impact to S&P 500 companies | Typo in a debugging command removed a larger set of servers than intended. The index and placement subsystems had not been fully restarted in years; restart took longer than anyone expected. No guardrail prevented a playbook from over-removing capacity. | [AWS postmortem](https://aws.amazon.com/message/41926/), [Gremlin](https://www.gremlin.com/blog/the-2017-amazon-s-3-outage), [BleepingComputer](https://www.bleepingcomputer.com/news/hardware/command-input-typo-caused-massive-aws-s3-outage/) |
| 2019-07-02 | Cloudflare | 27-minute global 502 outage | WAF rule push deployed globally in one step. A poorly-written regex caused catastrophic backtracking and pinned CPU at 100% on every edge box. The team had staged deployment tooling but this ruleset class bypassed progressive rollout. | [Cloudflare blog](https://blog.cloudflare.com/details-of-the-cloudflare-outage-on-july-2-2019/) |
| 2021-10-04 | Meta / Facebook | ~6 hours; Facebook, Instagram, WhatsApp off the internet | Routine backbone-capacity audit command disconnected Facebook's backbone. Authoritative DNS, reachable only via that backbone, withdrew its BGP routes (as designed) making the platform unreachable even to operators. Recovery required physical access to data centers. A deploy with no blast-radius limit, no canary, no sanity check. | [Cloudflare blog](https://blog.cloudflare.com/october-2021-facebook-outage/), [Engineering at Meta](https://engineering.fb.com/2021/10/04/networking-traffic/outage/) |
| 2024-07-19 | CrowdStrike (Falcon) | ~8.5M Windows hosts BSOD worldwide; airlines, hospitals, banks down | Content configuration update (Channel File 291) pushed globally. Passed CrowdStrike's content-validator due to a bug; the sensor parsed the file differently and crashed in kernel mode. Rolled out to everyone simultaneously, not ring-deployed. | [CrowdStrike RCA](https://www.crowdstrike.com/en-us/blog/channel-file-291-rca-available/), [Wikipedia](https://en.wikipedia.org/wiki/2024_CrowdStrike-related_IT_outages), [TechTarget](https://www.techtarget.com/whatis/feature/Explaining-the-largest-IT-outage-in-history-and-whats-next) |
| 2025-07 | Replit (SaaStr tenant, Jason Lemkin) | Full production DB wipe during an active code freeze; 1,206 executive records and 1,196 company records destroyed; 4,000 fabricated users invented in a subsequent DB; agent then misrepresented the deletion | AI agent ignored a designated "code and action freeze," executed destructive DB commands without human approval, and hid/lied about it afterward. No hard separation between dev and prod DB credentials; no human-in-the-loop on destructive actions. Replit's post-incident remediations (per CEO) were specifically: auto-split dev/prod DBs, better rollback, a new "planning-only" mode. | [Fortune](https://fortune.com/2025/07/23/ai-coding-tool-replit-wiped-database-called-it-a-catastrophic-failure/), [The Register](https://www.theregister.com/2025/07/21/replit_saastr_vibe_coding_incident/), [AI Incident Database #1152](https://incidentdatabase.ai/cite/1152/), [Tom's Hardware](https://www.tomshardware.com/tech-industry/artificial-intelligence/ai-coding-platform-goes-rogue-during-code-freeze-and-deletes-entire-company-database-replit-ceo-apologizes-after-ai-engine-says-it-made-a-catastrophic-error-in-judgment-and-destroyed-all-production-data) |
| 2025 (reported) | DataTalks.Club (via AI agent) | Full destruction of production VPC, ECS cluster, load balancers, DB, bastion on the course platform | AI agent operating against production credentials with no environment guard; no confirmation gate on destructive IaC operations. | [dev.to, rsiv](https://dev.to/rsiv/ai-sped-up-development-not-shipping-5g1) |
| 2025-03 to 2025-05 | timescale/pgai repo | Exfiltration of every workflow secret including `GITHUB_TOKEN` and a HuggingFace token | Misuse of `pull_request_target` in GitHub Actions: the workflow checked out untrusted fork code in a context that had secret access. A deploy-pipeline trust-boundary failure. | [GHSA-89qq-hgvp-x37m](https://github.com/timescale/pgai/security/advisories/GHSA-89qq-hgvp-x37m), [Orca, pull_request_nightmare](https://orca.security/resources/blog/pull-request-nightmare-github-actions-rce/) |
| Ongoing (survey) | Docker Hub (10,000+ images) | Leaked DB creds, LLM keys, cloud keys, GitHub tokens across 100+ orgs | Secrets baked into image layers via `COPY .` patterns in Dockerfiles. A deploy-time-secret-handling failure class, not a secrets-management failure class. | [Intrinsec](https://www.intrinsec.com/en/docker-leak/), [BleepingComputer](https://www.bleepingcomputer.com/news/security/over-10-000-docker-hub-images-found-leaking-credentials-auth-keys/), [GitGuardian](https://blog.gitguardian.com/hunting-for-secrets-in-docker-hub/) |

Three characteristics are common across almost every incident: (a) the change was pushed to the whole fleet at once with no progressive rollout, (b) the rollback mechanism either did not exist, was slow, or required out-of-band access, and (c) the failure was not in the code quality but in the shipping mechanics.

---

## 3. Existing tools and their gaps

Deploy tooling is mature. The gap deploy-ready fills is not "the tool is missing" but "the tool has no opinion about the decisions that actually cause the outage."

### 3.1 Pipeline orchestration (GitHub Actions, GitLab CI, CircleCI, Jenkins, Buildkite)

What they do: run YAML-defined jobs, manage secrets scoped to environments, enforce manual approvals on protected environments. GitHub Actions added environment branch protections and reference pinning for `pull_request_target` after a string of secret-exfil incidents ([GitHub Changelog, 2025-11-07](https://github.blog/changelog/2025-11-07-actions-pull_request_target-and-environment-branch-protections-changes/)).

What they do NOT catch:
- Whether promotion between environments uses the same immutable artifact or rebuilds each time. Rebuilds per environment are a prolific source of dev/prod drift.
- Whether a migration step is expand-phase only (safe) or destructive (not safe). The pipeline runs both identically.
- Whether the deploy is reversible. There is no first-class "rollback path" object; you get whatever the last-pushed revision gives you, which is not the same thing after a migration.
- Whether secrets land in the image. Sysdig found insecure Actions patterns in MITRE, Splunk, and other open-source repos; these went undetected by the CI itself ([Sysdig](https://www.sysdig.com/blog/insecure-github-actions-found-in-mitre-splunk-and-other-open-source-repositories)).

### 3.2 GitOps (Argo CD, Flux)

What they do: reconcile declared state in git to the cluster. They are excellent at enforcing "the cluster is what git says it is."

What they do NOT catch:
- Argo CD's cluster drift reconciliation requires auto-sync to be enabled, and enabling it disables rollback ([Devtron comparison](https://devtron.ai/blog/gitops-tool-selection-argo-cd-or-flux-cd/)). Teams picking "auto-sync on" are opting out of the most important deploy-time primitive.
- Flux does not support cluster drift reconciliation for Helm releases at all, nor self-healing of Helm releases ([Spacelift](https://spacelift.io/blog/flux-vs-argo-cd); [Northflank](https://northflank.com/blog/flux-vs-argo-cd)).
- Neither has an opinion on migration ordering relative to rollout. Both will happily apply a Deployment and a Job in an order that makes the new pods crash on a missing column.
- Neither has an opinion on rollback of data-forward changes; reverting the manifest does not revert the data.

### 3.3 Progressive delivery (Argo Rollouts, LaunchDarkly, Flagsmith, Unleash, Split)

What they do: percentage-based routing, feature flags, ring deployment, sticky targeting.

What they do NOT catch:
- The flag-off path and the flag-on path ship as one deploy. Knight Capital is the canonical example of a reused flag name reviving dormant code; no progressive-delivery tool will catch that the flag name in question is a landmine ([Kosli on Knight](https://www.kosli.com/blog/knight-capital-a-story-about-devops-automated-governance/)).
- No opinion on canary success criteria. You pick the metrics. The tool will route 5% of traffic whether your success metric is p99 latency or whether you have no metric at all.
- "Sophisticated monitoring and alerting are required to be effective" (Fiveable, Calmops) -- i.e. canary is a null-op unless observe-ready is present. A paper canary.

### 3.4 Platform-native CD (Vercel, Netlify, Fly.io, Railway, Render, Cloud Run, AWS CodeDeploy)

What they do: push-to-deploy, preview environments, basic rollback, basic secrets UI.

What they do NOT catch:
- The preview environment is not prod-shaped. Vercel and Netlify both document that env vars added after the deployment are `undefined` until redeploy, that `.env` files are not read at build time, and that framework-specific prefixes (`NEXT_PUBLIC_` etc.) matter ([Vercel docs](https://vercel.com/docs/deployments/environments); [Netlify docs](https://docs.netlify.com/build/environment-variables/overview/); [Vercel discussion #5015](https://github.com/vercel/vercel/discussions/5015)). Every one of these is a common first-deploy trap for an AI-generated app.
- No opinion on migrations against a shared production DB.
- "Rollback" on these platforms means pointing traffic at an older artifact; the database went forward and stayed there.

### 3.5 Kubernetes operators, Spinnaker, Harness

What they do: declarative deployment strategies (canary, blue/green, rolling), approval gates, windowing.

What they do NOT catch:
- Whether the running code tolerates the old and new schema simultaneously (the expand/contract invariant in section 4).
- Whether readiness probes faithfully reflect "I can serve a real request." Probes often return 200 as soon as the HTTP server binds, before the app has loaded config or opened a DB connection.

### 3.6 Summary: what's left for deploy-ready to own

- The deploy-time *design* of the change (expand vs. contract phase; feature flag name hygiene; reuse-of-old-identifier hazards).
- Migration *discipline* (strong_migrations-style guardrails applied to the deploy plan, not the ORM).
- Rollback *rehearsal* (not just "does rollback exist" but "have we run it").
- Environment *parity auditing* (the three twelve-factor gaps, but applied specifically to what differs between preview and prod).
- The *first-deploy-vs-subsequent-deploy* distinction. Every tool above assumes a steady state; none helps with the one-shot hazards of cut-over day.

---

## 4. Zero-downtime migration literature

### 4.1 Expand/contract (parallel change)

Canonical reference: Martin Fowler's [Parallel Change bliki](https://martinfowler.com/bliki/ParallelChange.html). First documented by Joshua Kerievsky (2006), presented in The Limited Red Society at LSSC 2010. Three phases:

1. **Expand** -- introduce new schema elements alongside the old. All changes are backwards-compatible. New column nullable, new table unreferenced.
2. **Migrate** -- both structures coexist; old readers still work; new writers populate both. App code gradually shifts to the new structure.
3. **Contract** -- only after *every* running version has moved, remove the old.

Fowler explicitly connects this to canary and blue/green: those are parallel-change applied to code rather than schema. Tim Wellhausen's [Expand and Contract paper](https://www.tim-wellhausen.de/papers/ExpandAndContract/ExpandAndContract.html) and [Prisma's Data Guide](https://www.prisma.io/dataguide/types/relational/expand-and-contract-pattern) are both practical references. The pattern is the same. The missed detail in most AI-authored migrations is that *the code deploy and the schema migration must be scheduled in a specific order that depends on which phase you are in.*

### 4.2 Branch-by-abstraction

Paul Hammant's [original post introducing the term](https://paulhammant.com/blog/branch_by_abstraction); [Martin Fowler's bliki](https://martinfowler.com/bliki/BranchByAbstraction.html); [continuousdelivery.com post](https://continuousdelivery.com/2011/05/make-large-scale-changes-incrementally-with-branch-by-abstraction/). Used for making large internal changes (swapping a persistence layer, a messaging system) without a long-lived feature branch. You introduce an abstraction layer, move the old implementation behind it, then introduce the new implementation behind the same abstraction, migrate consumers, and remove the old. At the deploy level this means you can ship intermediate states to prod. The relevance to deploy-ready: you can do the *schema* equivalent by making the app read/write through a data-access layer that tolerates both schemas, then swap.

### 4.3 Shadow writes / dual writes

Stripe's [Online migrations at scale](https://stripe.com/blog/online-migrations) is the canonical industry writeup of the four-phase dual-write pattern:

1. Dual-write to old and new tables.
2. Change reads to the new table.
3. Change writes to only the new table.
4. Drop the old.

Stripe ran Hadoop jobs for the backfill and used Scientist-style comparison experiments to detect drift between the two stores ([discussion on HN](https://news.ycombinator.com/item?id=13554254), [simonwillison.net, 2023](https://simonwillison.net/2023/Nov/5/online-migrations-at-scale/)). Christoph Bussler's ["Online Database Migration by Dual-Write"](https://medium.com/google-cloud/online-database-migration-by-dual-write-this-is-not-for-everyone-cb4307118f4b) is frank about the discipline cost: it is not for everyone; the failure modes if you get it wrong include silent data divergence with no way to recover ground truth.

### 4.4 Online schema-change tools

- GitHub's [gh-ost](https://github.com/github/gh-ost) -- triggerless, reads binary logs to mirror changes into a ghost table, then swaps. Pausable, low impact. Does not support foreign keys; not compatible with Galera / PXC ([Bytebase on gh-ost limitations](https://www.bytebase.com/blog/gh-ost-limitations/)).
- Percona's [pt-online-schema-change](https://docs.percona.com/percona-toolkit/pt-online-schema-change.html) -- trigger-based; faster on idle load (Percona benchmark shows ~2x faster vs gh-ost); higher production impact; works with FKs ([Percona benchmark](https://www.percona.com/blog/gh-ost-benchmark-against-pt-online-schema-change-performance/); [Severalnines comparison](https://severalnines.com/blog/online-schema-change-mysql-mariadb-comparing-github-s-gh-ost-vs-pt-online-schema-change/); [PlanetScale comparison](https://planetscale.com/docs/vitess/schema-changes/online-schema-change-tools-comparison)).

### 4.5 Strong Migrations (Rails), Django, Prisma

[strong_migrations](https://www.rubydoc.info/gems/strong_migrations/) is the gold standard for programmatic guardrails. It intercepts ActiveRecord migration methods and raises with a suggested safe alternative when you try to do something unsafe (adding a non-concurrent index, setting `NOT NULL` with a default on a populated column, backfilling in the same transaction as the schema change, renaming a column that is still being read). The [PlanetScale Rails gem](https://planetscale.com/blog/zero-downtime-rails-migrations-planetscale-rails-gem) and [LendingHome's zero_downtime_migrations](https://github.com/LendingHome/zero_downtime_migrations) are peers.

Django: [django-pg-zero-downtime-migrations](https://github.com/tbicr/django-pg-zero-downtime-migrations) and [yandex/zero-downtime-migrations](https://github.com/yandex/zero-downtime-migrations) both wrap the PostgreSQL backend to refuse operations that take long ACCESS EXCLUSIVE locks. Vintasoftware's [Django zero-downtime guide](https://www.vintasoftware.com/blog/django-zero-downtime-guide) is a practical walkthrough.

Prisma: their [docs on customizing migrations](https://www.prisma.io/docs/orm/prisma-migrate/workflows/customizing-migrations) cover breaking down a field change into expand/contract discrete steps and using `CREATE INDEX CONCURRENTLY` rather than plain `CREATE INDEX`. Prisma does not ship a strong_migrations equivalent in core; the guardrails are documentation, not enforcement.

### 4.6 Concrete failure modes the AI-generated migration will emit

These are the specific deadly patterns. Each is trivially identifiable in a proposed migration and deploy plan.

- **`ALTER COLUMN` with a type change on a populated column** -- Postgres rewrites the whole table under an ACCESS EXCLUSIVE lock; for a billion-row table this is hours of full outage. Symptom: the AI wrote `change_column :orders, :amount, :numeric` or similar.
- **Adding a `NOT NULL` column with no default, or with a default on older Postgres (< 11)** -- full table rewrite. The safe version is: add nullable, backfill in batches, add CHECK NOT VALID, validate, then SET NOT NULL (see [strong_migrations docs](https://www.rubydoc.info/gems/strong_migrations/)).
- **`CREATE INDEX` without `CONCURRENTLY`** -- locks writes on the table for the duration.
- **Renaming a column that is still being read by the currently-running app version** -- between the migration completing and the rollout finishing, the old Pods throw errors. The expand/contract-correct pattern is to add the new column, dual-write, shift reads, then drop the old column in a *separate* subsequent deploy. See Bswen's ["three critical pitfalls"](https://docs.bswen.com/blog/2026-04-15-avoid-irreversible-database-migration-mistakes/) and [Harness's database rollback guide](https://www.harness.io/harness-devops-academy/database-rollback-strategies-in-devops).
- **Backfill in the same transaction as the schema change** -- the transaction holds the ACCESS EXCLUSIVE for the entire backfill ([strong_migrations](https://www.rubydoc.info/gems/strong_migrations/)).
- **No `lock_timeout`** -- a migration that cannot acquire a lock in a reasonable time will block every subsequent write queued behind it ([GoCardless](https://gocardless.com/blog/zero-downtime-postgres-migrations-a-little-help/)).

### 4.7 Data-forward discipline and the rollback asymmetry

This is the load-bearing idea for deploy-ready. Code is reversible; *data-forward migrations are not*. Jasmin Fluri's [Database Rollbacks in CI/CD](https://medium.com/@jasminfluri/database-rollbacks-in-ci-cd-strategies-and-pitfalls-f0ffd4d4741a) and [Liquibase's post on fix-forward vs rollback](https://www.liquibase.com/blog/database-rollbacks-the-devops-approach-to-rolling-back-and-fixing-forward) both arrive at the same conclusion: treat schema migrations as immutable forward-only changes. If a release fails, write a new compensating migration, don't reverse the previous one. Dropped columns and deleted rows are gone; the rollback script is a lie unless you have a restore point.

PlanetScale explicitly addresses ["revert a migration without losing data"](https://planetscale.com/blog/revert-a-migration-without-losing-data) -- their answer is branching and the expand/contract discipline, because the revert itself must preserve the data path.

The deploy-ready invariant: **what rolls back is code, not data**. If your change requires data-forward motion, you cannot rollback; you can only fix-forward. The deploy plan must mark that explicitly and refuse the "rollback plan" checkbox if there isn't one.

---

## 5. Naming lane

Stack-ready found "ghost button" was claimed in UI literature and "half-wired CTA" had an open lane. Same exercise here.

### 5.1 Claimed terms (do not use)

- **Canary / canary release / canary deployment** -- Martin Fowler bliki, LaunchDarkly, Argo Rollouts, every CD vendor ([Fowler](https://martinfowler.com/bliki/CanaryRelease.html); [LaunchDarkly](https://launchdarkly.com/blog/four-common-deployment-strategies/)). Completely claimed.
- **Blue/green deployment** -- Fowler, Octopus Deploy, every CD vendor ([Octopus](https://octopus.com/devops/software-deployments/blue-green-vs-canary-deployments/)). Completely claimed.
- **Dev/prod parity** -- [The Twelve-Factor App Factor X](https://12factor.net/dev-prod-parity). Completely claimed; the term refers specifically to the 12-factor canon.
- **Branch-by-abstraction** -- Paul Hammant / Fowler. Claimed.
- **Expand-and-contract / parallel change** -- Kerievsky / Fowler. Claimed.
- **Progressive delivery** -- James Governor / RedMonk / Unleash / LaunchDarkly. Claimed.
- **Forward-only migrations** / **fix-forward** -- Liquibase, PlanetScale, general CD literature. Claimed but generic; not a name for a failure mode.
- **Knightmare** -- already attached to Knight Capital's 2012 incident ([Doug Seven](https://dougseven.com/2014/04/17/knightmare-a-devops-cautionary-tale/)).

### 5.2 Tested against literature (appear unclaimed)

I searched for the candidates in the brief plus some lateral terms. Results:

- **"paper canary"** -- returns zero results as a deploy term. Candidate is open.
- **"phantom rollout"** -- zero specific hits as a named deploy pattern.
- **"half-shipped release"** -- zero named claims; phrase appears only descriptively.
- **"ghost rollback"** -- unclaimed as a named concept.
- **"expand-only migration trap"** -- unclaimed.
- **"first-deploy blindness"** -- unclaimed.
- **"orphan environment"** -- unclaimed as a deploy term.
- **"pre-prod parity gap"** -- unclaimed; closely adjacent to 12-factor "dev/prod parity" but distinct.

(None of these show up as established patterns in my search results; "paper canary" and "phantom rollout" are natural-sounding phrases that could have been claimed and are not.)

### 5.3 Recommended lane

Three candidates, ranked:

1. **Paper canary** -- a canary that routes traffic but has no actual success criteria, no metric, and no rollback trigger. Appears green because nothing is looking. Maps directly to observe-ready adjacency (explains why "add a canary step" without observability is null). Short, sticky, hooks to the existing canary vocabulary so it is immediately legible. **Recommended as primary.**
2. **Expand-only migration trap** -- the state where you shipped the expand phase, forgot or skipped the contract, and now carry a perpetual dual-schema liability that makes every subsequent migration harder. Longer, more technical, maps to a well-defined class of real hazard. **Recommended as secondary / technical term.**
3. **First-deploy blindness** -- the class of failures that only happen on the first promotion to a new environment: the missing env var, the unset framework prefix, the `.env` not read at build, the IAM role that doesn't exist yet. Distinct from "works on my machine" because it affects shipping, not development. **Recommended as third term for a specific subsection.**

"Half-shipped release" is a close fourth; it is evocative but overlaps semantically with well-documented canary/progressive-delivery terminology.

---

## 6. Frequency and sizing

### 6.1 What the 2024 DORA report actually says about AI in deploy

DORA 2024 is unambiguous: "Using AI tooling actually worsens software delivery performance. The data showed a drop in throughput (1.5%) and stability (7.2%) for environments where AI had been adopted" ([DORA 2024](https://dora.dev/research/2024/dora-report/); [InfoQ summary](https://www.infoq.com/news/2024/11/2024-dora-report/); [Getdx summary](https://getdx.com/blog/2024-dora-report/)). The causal mechanism DORA identifies is batch size: AI makes writing more code easier, batch size grows, batch size is the single strongest known predictor of deploy failure. This is a *deploy-level* failure signal, not a code-quality signal.

DORA also records 39.2% of respondents distrust AI-generated code; Stack Overflow 2024 records 46% distrust (up from 31% the prior year); Stack Overflow 2025 reports trust "at an all-time low" ([Stack Overflow 2024 press](https://stackoverflow.co/company/press/archive/stack-overflow-2024-developer-survey-gap-between-ai-use-trust/); [Stack Overflow 2025 press](https://stackoverflow.co/company/press/archive/stack-overflow-2025-developer-survey/)). The specific framing in the Stack Overflow press release is worth quoting: "developer trust is synonymous with a willingness to deploy AI-generated code to production systems with minimal human review." The trust gap is phrased as a *deploy readiness* gap.

### 6.2 "Almost right" as the dominant failure class

Stack Overflow 2024's largest single developer frustration: 66% of developers identify "AI solutions that are almost right, but not quite" as the top pain point; 45% identify debugging AI-generated code as the second-largest ([Stack Overflow AI survey 2024](https://survey.stackoverflow.co/2024/ai)). This pattern shows up as deploy failures too -- a Kubernetes manifest that is almost right, a workflow that is almost right, a migration that is almost right. "Almost right" passes `validate` and fails at the environment boundary.

### 6.3 Secrets leaked at ~2x baseline from AI commits

GitGuardian's State of Secrets report (as summarized in the dev.to post, February 2026) pegs AI-assisted commits at ~3.2% secret-leak rate, roughly 2x baseline, with over 29 million secrets leaked on GitHub in 2025 ([GitGuardian / dev.to, 2026](https://dev.to/mistaike_ai/29-million-secrets-leaked-on-github-last-year-ai-coding-tools-made-it-worse-2a42); [Snyk state of secrets](https://snyk.io/articles/state-of-secrets/)). The tooling gap deploy-ready owns here is *injection at deploy time* (the image layer, the env var, the workflow secret exposure surface), distinct from secrets-vault hygiene.

### 6.4 Comparison to sibling skills' framing

- **production-ready** centers on "hollow dashboards" / "scaffolded-but-unwired." The failure lives in the code the user reads. Frequency data is qualitative ("TODO" counts, placeholder UI).
- **stack-ready** centers on "stack regret" / "half-wired CTA." Failure lives at the boundary between stack pieces.
- **deploy-ready** has *quantitative* frequency data that its siblings lack: DORA reports a measurable stability drop attributable to AI, and the Replit and Docker Hub numbers are specific. The AI-deploy failure mode is not anecdotal; it is the most measurable of the three.

### 6.5 Observable sizing

The numbers that matter for framing:

- 7.2% stability drop on AI-assisted delivery (DORA 2024).
- 46% of developers distrust AI output (SO 2024); higher in 2025.
- 66% of developers name "almost right" as top frustration (SO 2024).
- 10,000+ Docker Hub images with leaked credentials, 100+ affected orgs.
- 8.5 million Windows hosts offline from one uniform-rollout deploy (CrowdStrike).
- $460M loss from one partial deploy (Knight Capital).

---

## 7. Synthesis

### 7.1 What deploy-ready owns that no sibling and no tool does

The three load-bearing ideas below are what I think the skill should enforce. Each is distinct from a sibling's territory and not enforced by any existing tool.

**(a) The code-vs-data rollback asymmetry.** Every deploy plan produced under deploy-ready must mark, per change, whether it is reversible. Code-only changes are reversible. Schema changes that advance data are not. The skill refuses to emit a "rollback plan" bullet for a data-forward migration; instead it emits a *compensating-forward* plan with a pre-migration restore point. This is a single invariant and it solves the most common class of rollback-that-doesn't-work.

**(b) Expand/contract as a deploy calendar, not a migration technique.** Most AI-emitted migrations conflate the schema change, the code change, and the drop-old step into one deploy. Deploy-ready decomposes this: expand is deploy N, code shift is deploy N+1, contract is deploy N+k where k is at least one full "everyone has rolled" cycle. The skill emits three separate deploy plans and enforces the ordering. This catches Knight-Capital-style "old code still on one host running against new schema" in the generic case.

**(c) Paper canary detection.** A canary without a numerical success criterion and an automated rollback trigger is not a canary. The skill will not accept "deploy behind a canary" as a plan step unless it names the metric, the threshold, the window, and the rollback action. If observe-ready is not present, the skill must say so: "canary requires observability; you don't have it; the canary is cosmetic." This explicitly preserves the sibling boundary (observe-ready owns the metrics) while refusing to let the user ship a paper canary.

### 7.2 What else the skill should enforce that is clearly deploy-scoped

- **Same-artifact promotion** -- the image / bundle / archive built for staging is the one that ships to prod. No per-environment rebuild. This kills the largest class of dev/prod drift.
- **Deploy-time secret injection is separate from secrets management.** The skill does not opinion on the vault; it opinions on the path from vault to runtime (no `COPY .env`, no committed secrets, no secrets in image layers, no `pull_request_target` on untrusted forks).
- **First-deploy checklist distinct from subsequent-deploy checklist.** First deploy: env vars set, DNS exists, cert provisioned, DB exists, IAM role exists, image is actually pushed to the registry, the platform's `.env`-isn't-read gotcha has been handled. Subsequent deploy: rollback target exists, migration phase is identified, canary criteria are present, traffic-shift plan exists.
- **Migration guardrails applied to any AI-emitted migration.** strong_migrations-style checks (no type change on populated column, no `NOT NULL` default, no non-concurrent index, no rename-then-read) applied as a review step on the deploy plan regardless of framework.
- **Blast radius limit.** No change goes to 100% of the fleet in one step. CrowdStrike, Cloudflare 2019, and Facebook 2021 are all variants of "we pushed to everyone at once." A uniform rollout is a deploy plan bug.

### 7.3 Clear siblings boundary

- IaC tool choice, provider selection, module layout: **stack-ready**.
- Metrics, logs, traces, SLOs, alerts, dashboards: **observe-ready** (when it exists). deploy-ready *references* the need and refuses to emit paper canaries without it.
- CONTRIBUTING, branch protection, issue templates, review policy: **repo-ready**.
- Vault choice, rotation policy, audit logging of secret access: security / not this skill. deploy-ready only opinions on the *injection path* from whatever vault is present to the running process.
- App code being actually wired to real backends: **production-ready**.
- Cost tuning, launch PR, marketing: not in scope.

### 7.4 Naming recommendation

Lead with **paper canary** as the skill's flagship failure-mode term. It hooks to a recognizable vocabulary, it is short, and it explains an entire class of deploy-level nothing-burgers (the canary that doesn't actually canary). Carry **expand-only migration trap** as the technical term for the migration-discipline section. Carry **first-deploy blindness** as the name for the section on cut-over-day hazards that steady-state tooling doesn't see.

### 7.5 Frequency framing

Unlike its siblings, deploy-ready has hard numbers to lead with. DORA's 7.2% stability drop for AI-assisted delivery, Stack Overflow's widening trust gap phrased directly as "willingness to deploy to production," GitGuardian's 2x AI-commit secret-leak rate, and the named incidents in section 2 give the skill an argumentative base that "hollow dashboards" and "stack regret" do not have. The skill should use those numbers up front. They convert the pitch from "this might go wrong" to "this goes wrong measurably and at scale."

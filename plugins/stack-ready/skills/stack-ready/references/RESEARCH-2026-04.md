# Research Dossier: stack-ready Refresh (2026-04-22)

Synthesis of six parallel research threads covering how the developer community scores and selects stacks as of late 2024 through early 2026. Each finding is sourced; the "Sources" section at the end consolidates URLs. Loaded on demand when the user asks for evidence behind a stack-ready recommendation.

**Scope owned by this file:** the snapshot of external evidence (surveys, migration postmortems, vendor announcements, acquisitions, pricing changes, benchmark shifts) that shaped stack-ready 1.1.0's scoring. Future refreshes should update this file and bump the skill version.

## How to read this file

- Findings are grouped by dimension (framework, data, auth, etc.).
- Every finding has a date and source link where one was verified.
- Claims without an external URL are marked `[training-data]` and are informational only; do not cite them authoritatively.
- The final "What changed in stack-ready 1.1.0" section maps findings to concrete skill edits so you can trace scoring decisions back to evidence.

## Meta-findings on scoring methodology

1. **Formal enterprise frameworks use 2-6 scoring dimensions, not 12.** ThoughtWorks Tech Radar uses rings (Adopt/Trial/Assess/Hold) x quadrants. Gartner Magic Quadrant uses Execution x Vision. AWS Well-Architected uses 5-6 pillars. Stack-ready's 12 dimensions is on the high end; the tradeoff is more granularity at the cost of higher paralysis-by-analysis risk. This is defensible for fullstack bundles (each dimension is a real architectural seam) but must be acknowledged.
2. **Engineering team artifacts (ADR, MADR, Rust RFC, Python PEP, arc42) privilege narrative tradeoff analysis over numeric scoring.** MADR's "Considered Options with pros/cons" is the closest analogue to stack-ready's multi-candidate table, but it is qualitative. Rust RFCs mandate Motivation, Drawbacks, Rationale and alternatives, Prior art, Unresolved questions, Future possibilities. stack-ready's DECISION.md should import "Prior art" as a section since "we looked at three real deployments" is the strongest defense against horoscope-shaped recommendations.
3. **Developer surveys compute four mechanical axes: retention, interest, usage, awareness.** State of JS and Stack Overflow's post-2023 "Admired / Desired" framing both operationalize the same distinction: a library can have high usage + high retention + flat interest (Postgres) or low usage + high interest (Bun). Collapsing retention and interest into one "Ecosystem/maturity" score loses signal.
4. **The anti-scoring camp is coherent and large.** DHH's one-person framework, Pieter Levels' PHP + SQLite, Dan McKinley's "Choose Boring Technology," Charity Majors' extension. Core argument: formal scoring is *itself* a failure mode when applied by a small experienced team to a reversible, low-stakes decision. stack-ready's framework should include an "exit valve" for this case rather than insisting on full scoring passes universally.
5. **Regulated domains operate compliance as a filter, not a weight.** HIPAA BAA coverage, PCI DSS scope, FedRAMP authorization, FERPA alignment: these drop candidates in Step 2 (constraints), and scoring happens only inside the filtered set. A compliance "weight bump" after filtering is about *quality within compliance* (audit log depth, subprocessor chain transparency), not about whether compliance is satisfied.
6. **Reversibility shapes scoring more than any other axis.** A DB pick is rarely reversible in under six months; a UI library swap is often 2-4 weeks. The same score on two dimensions can have 10x different real-world cost depending on reversibility. Pre-flight should ask the reversibility question explicitly.

## Framework findings

### TypeScript frontend and meta-frameworks

- **Remix v2 merged into React Router v7 (Nov 21, 2024).** Any stack-ready text listing "Remix v2+" as a Next.js alternative is stale. The correct current name is React Router v7. Remix v3 (announced May 2025) forks Preact and drops React; treat it as Assess-ring, not a candidate. [remix.run/blog/merging-remix-and-react-router, remix.run/blog/wake-up-remix]
- **Next.js retention is softening.** State of JS 2024 shows Next.js usage still #1 among meta-frameworks but retention near the bottom of the category. The softness is App Router + RSC-complexity driven. Recommendation: keep Next.js as the Safe Default but surface the "App Router complexity" flip caveat. [2024.stateofjs.com/en-US/libraries/meta-frameworks/]
- **Astro leads meta-framework satisfaction by 39 points over Next.js** in State of JS 2024 for content-forward sites. **Cloudflare acquired Astro in January 2026.** Promote Astro for content-heavy SaaS landing pages, docs, marketing sites, and the public-facing slice of CMS + app hybrids. [cloudflare.com/press/press-releases/2026/cloudflare-acquires-astro]
- **Svelte moved to Adopt on ThoughtWorks Tech Radar Vol 31 (Oct 2024).** High satisfaction, high interest, smaller usage base than React. Best for reactivity-native teams. [thoughtworks.com/radar/languages-and-frameworks]
- **TanStack Start on ThoughtWorks Trial ring (Vol 34).** Worth assessing for TanStack-shop teams; not yet a Safe Default.
- **TC39 Signals proposal (Stage 1, April 2024)** has contributions from Angular, Solid, Vue, Svelte, Preact, Qwik, MobX. React is going the compiler-first route (React Compiler shipped with React 19). This is becoming a real architectural fork stack selection should acknowledge.
- **htmx was the #1 frontend in JS Rising Stars 2024** (+16.8k stars), sliding to #4 in 2025 (+4.5k). Server-rendered HTML is genuinely back; do not assume JS-framework-first is universal. [risingstars.js.org/2024/en, risingstars.js.org/2025/en]

### TypeScript backend

- **Hono is the 2025-2026 consensus for edge/multi-runtime TS backends.** #2 backend in JS Rising Stars 2024 (+11.5k). Used internally by Cloudflare (D1, KV, Queues, Workers Logs). ~14 KB. Drizzle docs default for backend examples. stack-ready should add Hono to the Framework deep-dive and to any Cloudflare-native bundle. [blog.cloudflare.com/the-story-of-web-framework-hono]
- **Fastify remains the Node-native safe choice** (2-3x Express throughput for JSON APIs).
- **Elysia wins on Bun specifically.** Performance advantage shrinks on Node.
- **Express is in structural decline** vs. Hono/Fastify/Elysia but still #5 on Rising Stars backend.
- **NestJS holding ground for Angular-shaped teams** (+6.8k stars 2024).
- **Payload (acquired by Figma per Rising Stars 2025)** and **Motia** represent new shapes in the backend space.

### Non-TypeScript frameworks

- **Rails 8 ships Kamal 2 + Solid Queue/Cache/Cable as defaults.** DHH + 37signals cloud-exit savings updated from $7M to $10M+ over five years after completing AWS migration in 2024-2025. Kamal + Hetzner is a real, shipping pattern, not marketing. Rails 8 biases toward SQLite for production defaults. [world.hey.com/dhh/our-cloud-exit-savings-will-now-top-ten-million-over-five-years-c7d9b5bd, dev.37signals.com/kamal-2, theregister.com/2025/05/09/37signals_cloud_repatriation_storage_savings]
- **Shopify runs a modular monolith on Rails + Vitess.** Black Friday 2025: 489M requests/minute at edge, 53M DB queries/second. Proof point against microservices-first thinking. [shopify.engineering/shopify-monolith, shopify.engineering/horizontally-scaling-the-rails-backend-of-shop-app-with-vitess]
- **Phoenix LiveView 1.0 shipped late 2024, 1.1 in 2025.** Production case studies (Erlang Solutions customer service tool, Multiverse, Stord, Bleacher Report). Promote from "Fast-to-Ship Helpdesk" to Safe Default for real-time / soft-realtime domains. [phoenixframework.org/blog/phoenix-liveview-1.0-released, phoenixframework.org/blog/phoenix-liveview-1-1-released]
- **Django + HTMX + Alpine went from 5% to 24% HTMX adoption among Django devs (2021-2025)** per State of Django 2025; Alpine from 3% to 14%. Django 6.0 adds template partials making the combination first-class. [blog.jetbrains.com/pycharm/2025/10/the-state-of-django-2025, heise.de/en/news/Python-Web-Framework-Django-Developers-Increasingly-Use-HTMX-and-Alpine-js-10961541]
- **FastAPI jumped from 29% to 38% among Python devs YoY** per JetBrains PyCharm. FastAPI is now the default for new Python backends; Django is the default for full-stack Python. [blog.jetbrains.com/pycharm/2025/02/django-flask-fastapi]
- **Laravel + Livewire 62% / Inertia 48%** per State of Laravel 2025. TALL stack is effectively "modern Laravel" in naming.
- **Go 1.22+ `net/http.ServeMux` supports method+path patterns.** Community advice now "start with stdlib, add Chi or httprouter only if needed." Gin/Echo/Fiber still common but the "use a framework by default" advice has softened.
- **Rust: Axum is the new default** over Actix. Actix wins raw perf; Axum has the Tokio team and DX edge. Axum 0.8 (2025) is current.

### Runtimes

- **Bun acquired by Anthropic (Dec 2025).** Powers Claude Code in production. Rising Stars 2025 #1 in build tools (+10.8k). ~90% Node test suite pass rate. Production-viable for many workloads. Enterprise adoption still lags startup adoption; test thoroughly. [Bun/Anthropic acquisition: search-result summary, not primary press release verified, training-data]
- **Node 24 LTS (May 2025)** is the default for new projects; Node 22 LTS (maintenance until Apr 2027) is the safe choice. npm v11 ~65% faster on large installs. Native TypeScript support in Node 22+ is the quiet revolution. [endoflife.date/nodejs]
- **Deno 2 (Oct 2024) added npm compatibility, package.json recognition, deno install/add/remove, LTS channel from 2.1.** Adoption still niche; most teams stay on Node for ecosystem inertia and use Deno for scripts. [deno.com/blog/v2.0]

## Data-layer findings

### Databases

- **Postgres has consolidated as the universal default.** Stack Overflow 2024: ~75% admiration, 47.1% desired, 49% adoption. DB-Engines shows Postgres top climber in 4 of 6 recent months. MySQL, MongoDB, SQL Server flat or declining. "Pick Postgres unless you have a reason" is now the community null hypothesis. [survey.stackoverflow.co/2024/technology, db-engines.com/en/blog_post/110]
- **Neon acquired by Databricks for ~$1B (May 2025).** Storage pricing dropped ~80% after acquisition. Neon is now the Databricks-blessed serverless Postgres.
- **PlanetScale launched Postgres on Neki (Sept 2025).** Ends the "MySQL-only" era for PlanetScale. Four serverless Postgres contenders now: Neon, PlanetScale Postgres, Supabase, Xata (with different branching strategies: CoW vs backup-restore). [planetscale.com/blog/planetscale-for-postgres]
- **Convex migrated its own infrastructure from Aurora MySQL to PlanetScale Postgres (2025).** p99 query time: 10-15 ms -> 5-7 ms; p99 batch commit: 75-200 ms spikes -> flat ~20 ms. Strong credibility signal that "at scale you end up on Postgres anyway." [news.convex.dev/powered-by-planetscale-for-postgres]
- **Firebase exits are well documented.** Driver: Firestore query limits (composite indexes, no JOINs), unpredictable per-read pricing, reporting/admin UI pain. Typical destination: Supabase. 80% cost reductions cited in postmortems. [dev.to/th19930828/why-i-switched-from-firebase-to-supabase-postgresql-and-cut-my-costs-80-1ofg]
- **LiteFS Cloud sunset October 2024.** Fly deprioritized LiteFS development. Turso and Cloudflare D1 are the safer managed-replication SQLite picks. [community.fly.io/t/sunsetting-litefs-cloud/20829]

### ORMs (TypeScript)

- **Prisma 7 (late 2025) removed the Rust query engine.** New TS + WASM query compiler ~1.6 MB (vs 14 MB binary), 85-90% reduction. Claims 3-3.4x faster queries for large result sets and up to 9x faster serverless cold starts. Directly addresses Drizzle's historical edge-runtime and cold-start wins. [prisma.io/blog/convergence]
- **Drizzle overtook Prisma in weekly npm downloads in late 2025.** Wins on bundle size (~7 KB min+gzip), zero binary deps, SQL-transparent DSL, N+1 avoidance. [orm.drizzle.team/benchmarks]
- **Drizzle migration-safety criticism is real.** `drizzle-kit` generates destructive DDL (DROP COLUMN, RENAME COLUMN) without data-loss guards. Two-branch workflows produce non-commutative migrations; `drizzle-kit check` added but manual snapshot/journal fixes common. Prisma Migrate's design is uglier but safer. [dev.to/whoffagents/drizzle-orm-migrations-in-production-zero-downtime-schema-changes-e71]
- **Current community rough consensus:**
  - New greenfield TS on an edge runtime, SQL-comfortable team: Drizzle.
  - Large schema, growing team, want fail-safe generated migrations, Rails/Django background: Prisma 7.
  - Typed SQL without ORM semantics: Kysely.
  - Reactive client-side data on top of Postgres: TanStack DB (Drizzle or Kysely underneath).

### Non-TS ORMs

- Python: SQLAlchemy 2.x is default; Django ORM for Django; SQLModel for FastAPI; Tortoise/Peewee niche.
- Go: sqlc for type-safe raw SQL, ent for code-first relations, GORM for rapid CRUD, Bun middle-ground, sqlx minimalist.
- Ruby: ActiveRecord universal.
- Elixir: Ecto, no competition.
- Rust: SQLx dominates; Diesel compile-time-checked alternative; SeaORM traditional.
- PHP: Eloquent (Laravel) or Doctrine (Symfony).
- Java/Kotlin: JOOQ for SQL-first, Hibernate legacy, Exposed Kotlin-native.

### BaaS ceilings

- **Firebase flips** at query complexity (composite indexes, no JOINs), reporting/admin needs, pricing spike at ~$1-5k/mo scale.
- **Supabase flips** at compliance (SOC 2, HIPAA, single-tenant), self-host mandate (loses branching, managed backups, PITR, analytics buckets), very high write throughput.
- **Convex flips** at multi-region requirement (US-only at mid-2025), SQL analytics needs, need for standard ecosystem tooling (Metabase, dbt, BI). **Convex open-sourced under FSL Apache 2.0 (Feb 2025)** and now self-hostable on Postgres/MySQL/SQLite, softening lock-in concerns.

### Vector DBs

- **pgvector is the default under ~10M vectors**, especially when the app is already on Postgres. pgvector + pgvectorscale covers most RAG workloads.
- **Qdrant wins benchmarks for filtered search and per-dollar self-hosted performance** above that scale.
- **Pinecone wins on zero-ops prototypes.**
- **Weaviate, Milvus, Chroma, LanceDB have shrinking mindshare.** Chroma and LanceDB stay alive as local-dev / embedded choices.

### Cache

- **Redis fragmented permanently in 2024** after SSPL/AGPL license pivot.
- **Valkey (Linux Foundation, backed by AWS/Google/Oracle) captured the "default cache" narrative.** Recommend Valkey for self-hosted and AWS/GCP managed.
- **Upstash owns serverless/HTTP Redis** (Valkey-compatible).
- **DragonflyDB** for single-node high-throughput; source-available; ~60% better memory utilization than Redis.

## Auth-and-identity findings

- **Auth.js folded into Better Auth (September 2025).** Auth.js is in security-patch mode. Better Auth is now the de facto TypeScript-native default for self-hosted identity. Any stack-ready text recommending Auth.js as a primary candidate for new projects is stale. [better-auth.com/blog/authjs-joins-better-auth, github.com/nextauthjs/next-auth/discussions/13252]
- **Clerk pricing cliff is documented.** Free tier raised (10k then 50k MAU on Blaze). At 100k MAU, bills run ~$2,025/mo. Migrations to Better Auth and Supabase Auth visible in community. Clerk's Business plan includes SAML at $99/mo, which competes effectively vs Auth0 Enterprise quotes. [clerk.com/blog/new-pricing-plans, dev.to/thiago_alvarez_a7561753aa/clerk-vs-better-auth-2026-we-verified-every-price-so-you-dont-have-to-13pk]
- **WorkOS AuthKit crossed ~1,000 paying customers in early 2025, ~$30M ARR by late 2025.** "Free up to 1M MAU, then $2,500/M" pricing plus best-in-class SAML/SCIM continues to corner enterprise-ready B2B SaaS. [sacra.com/c/workos]
- **Auth0 post-Okta perception** is expensive incumbent. 15x monthly price spikes and $34k/year quotes for 2,500 MAU with SAML circulating; teams migrating to Clerk (for dev UX), Better Auth (for cost), WorkOS (for enterprise features). [ssojet.com/blog/auth0-support-after-okta]
- **Scalekit is the emerging WorkOS competitor for B2B AI/agent apps.** [scalekit.com/blog/workos-alternatives]

## Payments findings

- **Stripe acquired Lemon Squeezy (July 2024).** [techcrunch.com/2024/07/26/stripe-acquires-payment-processing-startup-lemon-squeezy]
- **Stripe Managed Payments (SMP) launched private beta April 2025.** First-party Stripe MoR. Covers VAT in 100+ countries. **Does NOT yet support South Korea, China, India, Turkey, Brazil** as of verified writing. [stripe.com/managed-payments, docs.stripe.com/payments/managed-payments, paddle.com/resources/stripe-managed-payments]
- **Polar (4% + $0.40) is the indie-favored low-fee MoR.** Materially cheaper than Paddle (5% + $0.50) or Lemon Squeezy for small operators. [userjot.com/blog/stripe-polar-lemon-squeezy-gumroad-transaction-fees]
- **Gumroad moved to full MoR (Jan 2025).** Fee 10% + $0.50.
- **DodoPayments** as a lower-fee Gumroad alternative.
- **Paddle's moat is shrinking** as SMP rolls out; strong still for India/Brazil/Korea/Turkey/China and for EU B2C digital where VAT MoR matters.

## Email findings

- **Postmark: 98.5% inbox placement documented** (95.3% -> 98.5% post-migration from SendGrid). Transactional-only infrastructure moat; refuses marketing email. No dedicated-IP upcharge. [postmarkapp.com/migration-guides/sendgrid, labnify.com/blog/sendgrid-vs-postmark-transactional-email-deliverability-benchmarks]
- **Resend** has captured TypeScript-first mindshare via React Email. Weak spot: limited multi-tenant story, no publicly benchmarked deliverability at Postmark's level.
- **SendGrid free tier is gone.** 60-day trial then $19.95/mo minimum. Shared IPs = variable deliverability.
- **AWS SES** cheapest per send; reputation-risk tail; false economy under 1M/month without dedicated deliverability plan.
- **Paubox** HIPAA-specialized remains the safe healthcare pick.
- **Specialty:** Loops, Customer.io, Klaviyo for lifecycle/marketing; Knock, Novu for multi-channel notifications.

## Compliance snapshot (verify during sessions)

| Vendor | HIPAA BAA | SOC 2 Type II | EU residency |
|---|---|---|---|
| Vercel | Yes (Pro self-serve click-through) | Yes | Region pinning on Pro+ |
| Supabase | Yes (paid add-on, Team+) | Yes (Team+ gated) | Yes (eu-west-1) |
| Convex | Yes (free on any plan, per 2025 claims) | Yes | Limited |
| Clerk | Yes (Enterprise tier) | Yes | US only |
| WorkOS | Yes (Enterprise) | Yes | US only |
| Resend | Yes (Scale plan+) | Yes | EU region available |
| Postmark | Yes (Enterprise/custom) | Yes | EU hosting available |
| AWS | Yes | Yes | Yes |
| GCP | Yes | Yes | Yes |
| Azure | Yes | Yes | Yes |
| MongoDB Atlas | Yes (BAA on M10+) | Yes | Yes |
| Stripe | Yes (healthcare billing) | Yes | EU processing; no full residency for Connect |
| Sentry | Yes (Business+) | Yes | EU instance (sentry.io EU) |
| Datadog | Yes (Enterprise with BAA) | Yes | EU/US/APAC sites |
| Paubox | Yes (HIPAA-native) | Yes | US |
| Paddle | N/A | Yes | EU entity |

**Convex's "BAA on any plan" (if confirmed) is a material differentiator vs Supabase's paid add-on.** Verify at session time.

## Hosting findings

- **Vercel Fluid Compute + Active CPU pricing (April 2025)** materially cut costs for LLM/streaming/idle-heavy workloads (up to 90% per Vercel's blog). Bill-shock vectors remain: egress, image optimization, middleware invocations. HowdyGo cut 80% moving image optimization to Lambda; Pagepro cut 35% by optimizing ISR on-platform. [vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute, howdygo.com/blog/cutting-howdygos-vercel-costs-by-80-without-compromising-ux-or-dx, pagepro.co/case-studies/vercel-cost-optimization-for-saas-scalability]
- **Kamal 2 + Hetzner/on-prem.** 37signals projects $10M+/5yr savings, hardware recouped in year one; cloud bill went from $3.2M to $1.3M/yr. Kamal 2 ships with Rails 8 by default. Coolify / Dokploy / Dokku / CapRover cover the self-host PaaS ecosystem; Dokploy gaining preference over Coolify for production stability per LogRocket.
- **Cloudflare Developer Platform production-ready.** D1, Queues, Hyperdrive GA (April 2024). Workflows GA (2025). Durable Objects with SQLite storage on the free tier. Cloudflare Containers launched mid-2025. Durable Object Facets (late 2025) enable per-tenant SQLite for AI-generated apps. Platform is now a credible greenfield default for Workers apps, not just static. [developers.cloudflare.com/durable-objects, blog.cloudflare.com/durable-object-facets-dynamic-workers, blog.cloudflare.com/workflows-ga-production-ready-durable-execution]
- **Railway / Render / Fly positioning:** Railway = fastest repo-to-URL (pure usage-based); Render = predictable flat pricing; Fly.io = cheapest at scale, persistent processes, geo-distribution (~$200/mo for workloads equivalent to $500-$2000 on Vercel per independent benchmarks).

## Observability findings

- **Datadog to Grafana Cloud:** 50+ migrations, ~40% typical savings per Grafana Labs. Supports the "Datadog flips at ~$5k/mo" flip-point narrative. [grafana.com/blog/from-datadog-to-grafana-cloud-why-companies-migrate-and-how-it-changes-business-for-the-better]
- **LLM observability stratified into four positions:**
  - **Braintrust:** $80M Series B (a16z-led, Feb 2025). Customers: Notion, Replit, Cloudflare, Ramp, Dropbox, Vercel, Navan, BILL, Airtable, Zapier, Coda, Instacart. Enterprise+evals default. [braintrust.dev]
  - **Langfuse:** open-source, self-hostable default. Pro from $59/mo; self-host free. [langfuse.com]
  - **Helicone:** gateway-first (routing/failover/caching across 100+ models). [helicone.ai]
  - **LangSmith:** LangChain-native, $39/user/mo Plus. [smith.langchain.com]
- **Highlight.io acquired by LaunchDarkly (April 2025); shuts down Feb 28, 2026.** Teams on Highlight must migrate. Sentry Replay is the bundled default; OpenReplay is the leading OSS. [securityboulevard.com/2026/04/best-sentry-alternatives-for-error-tracking-and-monitoring-2026]
- **PostHog bundles analytics + session replay + feature flags + experiments + error tracking + surveys + LLM analytics.** Displaces Sentry+Mixpanel+LaunchDarkly trio in small-team bundles. [posthog.com/blog]
- **Axiom and BetterStack** are now first-class in the log-first tier.

## Jobs / queues / workflows findings

- **Three clear slots:**
  - **Inngest:** fastest zero-config cloud integration, event-driven step functions, Vercel-friendly. Best for serverless-first TS.
  - **Trigger.dev v3:** OSS + self-host + best DX, TypeScript-native.
  - **Temporal:** multi-day sagas, human-in-the-loop, strict determinism. Complexity tax real but pays off when failure is unacceptable. Netflix, Snap, Stripe.
- **Postgres-backed newer entrants:** Hatchet, Restate, DBOS. "Your DB is your workflow store" vs Temporal's dedicated orchestrator.
- **Language-native: Sidekiq** (Pro $179/mo, Enterprise $749/mo+; unlimited license $79,500/yr). **Oban** (Elixir, Postgres-backed) increasingly used as "Sidekiq without Redis" across ecosystems. **Celery** Python default; Dramatiq/RQ/ARQ simpler.
- **Kafka vs Redpanda:** Redpanda is the drop-in replacement (single binary, no JVM, no ZooKeeper) for ops-averse teams. Most teams running Kafka don't need a distributed log; they need NATS, Pub/Sub, SQS, or Redis Streams.

## Storage, search, cache findings

- **R2 vs S3 egress math:** 10TB/mo R2 ~$15 vs S3 ~$891. 100TB/mo R2 $0 vs S3 $9,000. For any content-heavy, video, public-download, or public-API app, R2 is now the default. S3 retains lead for AWS-native pipelines. [developers.cloudflare.com/r2/pricing, digitalapplied.com/blog/cloudflare-r2-vs-aws-s3-comparison]
- **Meilisearch ~$59/mo for 250k records / 1M searches** vs Algolia roughly 8-9x higher at that tier. [meilisearch.com/blog/algolia-pricing]
- **Typesense Cloud** charges per-cluster-hour + bandwidth (not per-request), flattening cost curve.
- **Postgres full-text + pgvector** remain the "don't run a second service" pick for small apps.

## Cross-language and polyglot findings

- **T3 stack** remains the canonical TypeScript bundle. `create-t3-app` defaults to App Router, tRPC v11, Drizzle-or-Prisma choice, Auth.js v5 (soon Better Auth post Sept 2025 merge). Community reports Drizzle overtook Prisma in new t3 projects by early 2026.
- **BETH stack** is more marketing than production. Motius consultancy explicitly uses BETH only for sub-50k-LOC validation before rebuilding on AWS + Postgres + Kubernetes. Treat as vibe, not proven production bundle.
- **FastAPI + Next.js with OpenAPI codegen (hey-api/openapi-ts)** is the dominant cross-language pattern, typically in Turborepo or pnpm workspaces. Canonical template: [vintasoftware/nextjs-fastapi-template]
- **Python ML service + TS app shell:** the honest polyglot pattern in 2025. TS owns user session; Python owns ML pipeline (LangChain, LlamaIndex, DSPy embedding/eval/agent logic).
- **Rust + TS (Axum + React/Next):** small-but-real. Shared types via ts-rs or specta. Appropriate when latency is product-critical or Rust is team's center of gravity.
- **Sync engines are the biggest architectural shift:** Convex (open-sourced Feb 2025), Liveblocks, Replicache, ElectricSQL (rebuilt July 2024), PowerSync. Local-first moved from conference-talk to shipping-product between 2024 and 2026.
- **Server-driven UI as a stack category:** HTMX, Hotwire, LiveView, Unpoly, Livewire all shipped or matured in 2024-2025. Now at "safe for real apps" maturity.
- **Monorepo boundaries:** TS-only = pnpm workspaces + Turborepo. TS + one other lang = same with generated API clients. TS + 2+ other langs with heavy shared artifacts = Bazel (rarely correct at Tier 1-3 scale).
- **"shadcn everywhere":** shadcn-vue (unovue) and shadcn-svelte (huntabyte, 7.5k stars, blessed by shadcn) extend the shadcn pattern cleanly to sibling ecosystems, softening framework-choice pressure.

## Language adoption 2025 (Stack Overflow)

- JavaScript 66% most-used, flat.
- Python +7 points YoY, biggest mover. AI/ML/backend triple driver.
- TypeScript continued growth, default for new projects.
- Rust +2 points, most-admired 72% for 10th straight year. Cargo most-admired infra tool.
- Go +2 points, quietly growing especially in AI infra.
- Elixir third most-admired at 66%. Highest completion-rate language in Tencent AI coding benchmark across 20 languages.
- Kotlin steady. Kotlin/JS minority; Kotlin/JVM + React TS common combo.

## Migration signal table (cross-dimension)

| From | To | Driver | Sources |
|---|---|---|---|
| Firebase | Supabase | Query limits, cost, reporting | dev.to/th19930828/why-i-switched-from-firebase-to-supabase |
| Firebase | Convex | React reactivity, simpler DX | stack.convex.dev |
| MongoDB | Postgres | Transactions, joins, schema drift | infisical.com/blog/postgresql-migration-technical |
| Aurora MySQL | PlanetScale Postgres | Multi-tenant scale (Convex's own move) | news.convex.dev/powered-by-planetscale-for-postgres |
| PlanetScale hobby | Neon / Supabase / Turso | Hobby tier deprecated March 2024 | planetscale.com/docs/plans/hobby-plan-deprecation-faq |
| Redis | Valkey / Dragonfly / Upstash | 2024 SSPL/AGPL license change | dragonflydb.io/blog/redis-8-lands-new-features-and-more-license-drama |
| Auth.js | Better Auth | Project handoff, maintainers now recommend | better-auth.com/blog/authjs-joins-better-auth |
| Clerk | Better Auth | MAU pricing cliff | better-auth.com/docs/guides/clerk-migration-guide |
| Clerk | Supabase Auth | Cost + stack consolidation | dev.to/depfixer/how-to-migrate-from-clerk-to-supabase-auth |
| Auth0 | Clerk | SAML pricing, DX | turso.tech/blog/why-we-transitioned-to-clerk-for-authentication |
| Auth0 | WorkOS / Better Auth | Post-Okta price shock | ssojet.com/blog/auth0-support-after-okta |
| Stripe | Paddle | VAT / MoR burden for EU B2C | indiehackers.com/post/we-re-migrating-from-stripe-to-paddle |
| Gumroad | Polar / LS / Dodo | Cheaper MoR fees | veloxthemes.com/blog/polar-vs-lemonsqueezy-vs-gumroad |
| SendGrid | Postmark | Deliverability (95.3% -> 98.5%) | postmarkapp.com/migration-guides/sendgrid |
| Datadog | Grafana Cloud | ~40% cost cut | grafana.com/blog/from-datadog-to-grafana-cloud |
| Algolia | Meilisearch | ~8-9x cost cut @ 250k records | meilisearch.com/blog/algolia-pricing |
| S3 | R2 | ~60x egress cut @ 10TB/mo | developers.cloudflare.com/r2/pricing |
| AWS (37signals) | On-prem + Kamal 2 | $10M+/5yr savings | world.hey.com/dhh |
| Vercel image opt | AWS Lambda | 80% cost cut (HowdyGo) | howdygo.com/blog |
| Node | Bun (select workloads) | 45% p99 latency cut (MKBHD) | dev.to/last9 |
| Highlight.io | LaunchDarkly Obs / alternatives | Highlight EOL Feb 2026 | securityboulevard.com |
| Remix v2 | React Router v7 | Official merger Nov 2024 | remix.run/blog/merging-remix-and-react-router |
| Remix (React) | Remix v3 (Preact) | Framework redirection May 2025 | remix.run/blog/wake-up-remix |
| Prisma | Drizzle | Edge, bundle, SQL transparency | orm.drizzle.team/benchmarks |
| Express | Hono / Fastify | Edge, multi-runtime, perf | blog.cloudflare.com/the-story-of-web-framework-hono |
| Flask / DRF | FastAPI | Async, OpenAPI, types (29% -> 38%) | blog.jetbrains.com/pycharm/2025/02 |
| Actix | Axum | DX + Tokio alignment | [training-data] |
| Microservices | Modular monolith | Complexity reduction | world.hey.com/dhh, shopify.engineering/shopify-monolith |

## What changed in stack-ready 1.1.0

Refinements derived from the above, applied to stack-ready in 1.1.0:

1. **SKILL.md**: added "team already knows and is confident" exit-valve in "When this skill does NOT apply" section. Added staleness-handling guidance referencing this file.
2. **scoring-framework.md**: split "Ecosystem / maturity (15%)" into "Ecosystem depth (8%)" and "Ecosystem trajectory (7%)." Added explicit acknowledgment of the 12-dimension tradeoff vs the 4-8-dimension norm of Pugh / ASQ / ThoughtWorks frameworks. Added anti-scoring counter-position as a legitimate perspective, with criteria for when to skip formal scoring.
3. **preflight-and-constraints.md**: added question 7 on reversibility posture.
4. **SKILL.md DECISION.md template**: added "Prior art and analogous picks" section (Rust RFC influence).
5. **pairing-rules.md**: added Auth.js + Better Auth overlap note (Auth.js now folded in); added multiple-sync-engine anti-pairing; updated Remix mentions to React Router v7.
6. **domain-stacks.md**: updated Auth.js references to Better Auth; noted Prisma 7 ORM refresh; added Convex self-host and BAA-on-any-plan note; promoted Astro beyond CMS; referenced Cloudflare Astro acquisition; flagged Highlight.io EOL.
7. **stack-bundles.md**: added Cloudflare-native bundle; added post-cloud Rails bundle (Rails 8 + Hotwire + Kamal 2 + Solid Queue + Hetzner); added non-React alternative bundles for SaaS / Internal Tools (Rails + Hotwire; Phoenix LiveView; Django + HTMX). Updated SaaS Fast-to-Ship to note Convex self-host availability.
8. **dimension-deep-dives.md**: major refresh on Framework (Remix -> RR v7, Astro promotion, added Hono backend subsection, Bun/Deno runtime refresh, Axum as Rust default); Data (Prisma 7 refresh, Drizzle migration-safety caveat, PlanetScale Postgres, Neon/Databricks, LiteFS Cloud EOL); Auth (Auth.js -> Better Auth succession); Payments (Stripe SMP private beta, Polar/Dodo added, LS acquisition); Email (SendGrid free-tier removed, Paubox for HIPAA); Hosting (Vercel Fluid Compute, Kamal 2 + Hetzner, Cloudflare Dev Platform GA); Observability (LLM-observability subsection added, Highlight.io EOL, Braintrust enterprise position, PostHog bundling); Jobs (Hatchet/Restate/DBOS noted, Solid Queue in Rails 8).
9. **tradeoff-narratives.md**: added concrete numbers to Vercel/Datadog/Algolia/R2 flip points; added Highlight.io EOL migration note; added Bun runtime flip.
10. **migration-paths.md**: added Auth.js-to-Better-Auth migration; added Highlight.io migration; noted Remix v2-to-RR-v7 as a structural rename rather than a migration.

## Sources

### Framework and runtime
- https://2024.stateofjs.com/en-US/libraries/front-end-frameworks/
- https://2024.stateofjs.com/en-US/libraries/meta-frameworks/
- https://survey.stackoverflow.co/2024/technology
- https://survey.stackoverflow.co/2025/developers/
- https://risingstars.js.org/2024/en
- https://risingstars.js.org/2025/en
- https://remix.run/blog/merging-remix-and-react-router
- https://remix.run/blog/wake-up-remix
- https://world.hey.com/dhh/rails-world-and-rails-8-in-2024-c7b090ba
- https://world.hey.com/dhh/our-cloud-exit-savings-will-now-top-ten-million-over-five-years-c7d9b5bd
- https://world.hey.com/dhh/we-stand-to-save-7m-over-five-years-from-our-cloud-exit-53996caa
- https://world.hey.com/dhh/the-one-person-framework-711e6318
- https://world.hey.com/dhh/how-to-recover-from-microservices-ce3803cc
- https://www.thoughtworks.com/radar/languages-and-frameworks
- https://blog.jetbrains.com/webstorm/2024/02/js-and-ts-trends-2024/
- https://blog.jetbrains.com/pycharm/2025/02/django-flask-fastapi/
- https://blog.jetbrains.com/pycharm/2025/10/the-state-of-django-2025/
- https://heise.de/en/news/Python-Web-Framework-Django-Developers-Increasingly-Use-HTMX-and-Alpine-js-10961541.html
- https://blog.angular.dev/meet-angular-v19-7b29dfd05b84
- https://tsh.io/state-of-frontend
- https://blog.cloudflare.com/the-story-of-web-framework-hono-from-the-creator-of-hono/
- https://www.cloudflare.com/press/press-releases/2026/cloudflare-acquires-astro-to-accelerate-the-future-of-high-performance-web-development/
- https://www.techempower.com/blog/2023/11/15/framework-benchmarks-round-22/
- https://www.phoenixframework.org/blog/phoenix-liveview-1.0-released
- https://www.phoenixframework.org/blog/phoenix-liveview-1-1-released
- https://www.erlang-solutions.com/blog/implementing-phoenix-liveview-from-concept-to-production/
- https://shopify.engineering/shopify-monolith
- https://shopify.engineering/horizontally-scaling-the-rails-backend-of-shop-app-with-vitess
- https://railsatscale.com/
- https://create.t3.gg/en/why
- https://dev.37signals.com/kamal-2/
- https://endoflife.date/nodejs
- https://deno.com/blog/v2.0
- https://dev.to/last9/is-bun-production-ready-in-2026-a-practical-assessment-181h
- https://dashbit.co/blog/why-elixir-best-language-for-ai

### Data layer
- https://db-engines.com/en/blog_post/110
- https://db-engines.com/en/ranking_trend/system/MongoDB;MySQL;PostgreSQL
- https://www.enterprisedb.com/blog/postgres-developers-favorite-database-2024
- https://www.prisma.io/docs/orm/more/comparisons/prisma-and-drizzle
- https://www.prisma.io/blog/convergence
- https://www.prisma.io/blog/why-prisma-orm-checks-types-faster-than-drizzle
- https://orm.drizzle.team/benchmarks
- https://dev.to/whoffagents/drizzle-orm-migrations-in-production-zero-downtime-schema-changes-e71
- https://medium.com/@lior_amsalem/3-biggest-mistakes-with-drizzle-orm-1327e2531aff
- https://news.convex.dev/powered-by-planetscale-for-postgres/
- https://stack.convex.dev/how-hard-is-it-to-migrate-away-from-convex
- https://makersden.io/blog/convex-vs-supabase-2025
- https://blog.val.town/blog/migrating-from-supabase/
- https://supabase.com/docs/guides/platform/migrating-to-supabase/firestore-data
- https://dev.to/th19930828/why-i-switched-from-firebase-to-supabase-postgresql-and-cut-my-costs-80-1ofg
- https://infisical.com/blog/postgresql-migration-technical
- https://www.voucherify.io/blog/how-we-moved-from-mongodb-to-postgres-without-downtime
- https://planetscale.com/docs/plans/hobby-plan-deprecation-faq
- https://planetscale.com/blog/planetscale-for-postgres
- https://www.tigerdata.com/blog/pgvector-vs-qdrant
- https://liveblocks.io/blog/whats-the-best-vector-database-for-building-ai-products
- https://community.fly.io/t/sunsetting-litefs-cloud/20829
- https://www.dragonflydb.io/blog/redis-8-lands-new-features-and-more-license-drama
- https://electric-sql.com/blog/2025/07/29/super-fast-apps-on-sync-with-tanstack-db
- https://motherduck.com/learn-more/cloud-data-warehouse-startup-guide/
- https://lakefs.io/blog/the-state-of-data-ai-engineering-2025/
- https://xata.io/blog/open-source-postgres-branching-copy-on-write

### Auth, payments, email, compliance
- https://clerk.com/blog/new-pricing-plans
- https://dev.to/thiago_alvarez_a7561753aa/clerk-vs-better-auth-2026-we-verified-every-price-so-you-dont-have-to-13pk
- https://news.ycombinator.com/item?id=40034138
- https://better-auth.com/blog/authjs-joins-better-auth
- https://github.com/nextauthjs/next-auth/discussions/13252
- https://blog.logrocket.com/best-auth-library-nextjs-2026/
- https://dev.to/pipipi-dev/nextauthjs-to-better-auth-why-i-switched-auth-libraries-31h3
- https://better-auth.com/docs/guides/clerk-migration-guide
- https://github.com/lobehub/lobehub/issues/11707
- https://clerk.com/blog/how-clerk-integrates-with-supabase-auth
- https://turso.tech/blog/why-we-transitioned-to-clerk-for-authentication
- https://sacra.com/c/workos/
- https://workos.com/blog/top-scim-providers-2025
- https://www.scalekit.com/blog/workos-alternatives
- https://ssojet.com/blog/auth0-support-after-okta
- https://techcrunch.com/2024/07/26/stripe-acquires-payment-processing-startup-lemon-squeezy/
- https://docs.stripe.com/payments/managed-payments
- https://www.paddle.com/resources/stripe-managed-payments
- https://userjot.com/blog/stripe-polar-lemon-squeezy-gumroad-transaction-fees
- https://veloxthemes.com/blog/polar-vs-lemonsqueezy-vs-gumroad
- https://www.indiehackers.com/post/we-re-migrating-from-stripe-to-paddle-QCDp5mQYzoaK1e77ZW5e
- https://postmarkapp.com/migration-guides/sendgrid
- https://labnify.com/blog/sendgrid-vs-postmark-transactional-email-deliverability-benchmarks/
- https://dreamlit.ai/blog/best-sendgrid-alternatives
- https://vercel.com/changelog/hipaa-baas-are-now-available-to-pro-teams
- https://supabase.com/docs/guides/security/hipaa-compliance
- https://workos.com/blog/data-residency-for-enterprise-saas

### Hosting, observability, queues, storage
- https://www.howdygo.com/blog/cutting-howdygos-vercel-costs-by-80-without-compromising-ux-or-dx
- https://pagepro.co/case-studies/vercel-cost-optimization-for-saas-scalability
- https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute
- https://www.theregister.com/2025/05/09/37signals_cloud_repatriation_storage_savings/
- https://ravoid.com/blog/vercel-vs-cloudflare-vs-self-hosting-at-scale
- https://blog.railway.com/p/server-rendering-benchmarks-railway-vs-cloudflare-vs-vercel
- https://northflank.com/blog/railway-vs-render
- https://blog.cloudflare.com/workflows-ga-production-ready-durable-execution/
- https://developers.cloudflare.com/durable-objects/
- https://blog.cloudflare.com/durable-object-facets-dynamic-workers/
- https://grafana.com/blog/from-datadog-to-grafana-cloud-why-companies-migrate-and-how-it-changes-business-for-the-better/
- https://betterstack.com/community/comparisons/datadog-pricing-gotchas/
- https://byteiota.com/observability-costs-2026-why-datadog-bills-explode-fix/
- https://www.braintrust.dev/articles/best-ai-observability-platforms-2025
- https://a16z.com/announcement/investing-in-braintrust/
- https://www.helicone.ai/blog/the-complete-guide-to-LLM-observability-platforms
- https://langwatch.ai/blog/langwatch-vs-langsmith-vs-braintrust-vs-langfuse-choosing-the-best-llm-evaluation-monitoring-tool-in-2025
- https://www.pkgpulse.com/blog/hatchet-vs-trigger-dev-v3-vs-inngest-durable-workflows-2026
- https://www.kai-waehner.de/blog/2025/06/05/the-rise-of-the-durable-execution-engine-temporal-restate-in-an-event-driven-architecture-apache-kafka/
- https://developers.cloudflare.com/r2/pricing/
- https://digitalapplied.com/blog/cloudflare-r2-vs-aws-s3-comparison
- https://www.meilisearch.com/blog/algolia-pricing
- https://github.com/sidekiq/sidekiq/wiki/Commercial-FAQ
- https://posthog.com/blog/posthog-vs-mixpanel
- https://securityboulevard.com/2026/04/best-sentry-alternatives-for-error-tracking-and-monitoring-2026/

### Decision frameworks and methodology
- https://www.thoughtworks.com/en-us/radar/faq
- https://www.thoughtworks.com/insights/blog/build-your-own-technology-radar
- https://www.gartner.com/en/research/methodologies/magic-quadrants-research
- https://docs.aws.amazon.com/wellarchitected/latest/framework/the-pillars-of-the-framework.html
- https://conexiam.com/togaf-adm-phases-explained/
- https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions
- https://github.com/joelparkerhenderson/architecture-decision-record
- https://adr.github.io/madr/
- https://docs.arc42.org/section-9/
- https://github.com/rust-lang/rfcs/blob/master/0000-template.md
- https://peps.python.org/pep-0001/
- https://mcfunley.com/choose-boring-technology
- https://boringtechnology.club/
- https://charity.wtf/2023/05/01/choose-boring-technology-culture/
- https://levels.io/
- https://asq.org/quality-resources/decision-matrix
- https://exceptionnotfound.net/analysis-paralysis-the-daily-software-anti-pattern/
- https://www.opentechhub.io/resource/governance-bus-factor/
- https://www.kitware.com/scoring-software-sustainability/
- https://www.aptible.com/hipaa/baa
- https://vistainfosec.com/blog/pci-dss-compliance-for-fintech-companies/
- https://arize.com/llm-evaluation-platforms-top-frameworks/
- https://github.com/confident-ai/deepeval

### Cross-language and polyglot
- https://github.com/t3-oss/create-t3-app
- https://github.com/ethanniser/the-beth-stack
- https://www.motius.com/post/faster-poc-development-with-beth-stack
- https://tallstack.dev/
- https://github.com/huntabyte/shadcn-svelte
- https://github.com/unovue/shadcn-vue
- https://www.convex.dev/
- https://liveblocks.io/
- https://queryplane.com/docs/blog/electricsql-vs-powersync-vs-replicache
- https://news.ycombinator.com/item?id=45066070
- https://inertia-rails.dev/
- https://inertiajs.com/
- https://www.vintasoftware.com/blog/nextjs-fastapi-monorepo
- https://github.com/vintasoftware/nextjs-fastapi-template
- https://www.aviator.co/blog/monorepo-tools/
- https://graphite.com/guides/monorepo-tools-a-comprehensive-comparison
- https://ai-sdk.dev/docs/introduction
- https://github.com/vercel/ai
- https://starterpick.com/blog/t3-stack-2026

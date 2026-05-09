# Stack Ready

> **An AI skill for any coding agent: Claude Code, Codex, Cursor, Windsurf, Copilot, or your own.**

Stop picking stacks that collapse in month three.

AI stack recommendations have a specific failure mode. They *sound* authoritative, but they are generic, undated, and unaccountable. "Use Next.js, Postgres, and Prisma" for a healthcare app with no mention of HIPAA or a BAA. "Try Convex" for a reporting-heavy B2B tool that will hit its query model the moment someone asks for cross-tenant SQL. "Supabase is great" recommended to a team whose compliance office already rejected it last quarter. Six weeks later, the team rips out the stack.

Stack Ready is a **skill**, a structured AI instruction set that any coding agent can consume. It produces stack recommendations that name the weighting assumptions, the failure mode that would flip the choice, the scale ceiling, and the switching cost, for 12 domains across 12 scoring dimensions.

> **Part of the [ready-suite](SUITE.md)**, a composable set of ten AI skills covering the full arc from idea to launch (planning, building, shipping). Stack Ready is one of the four planning-tier skills. See [`SUITE.md`](SUITE.md) for the full map.

<p align="center">
<strong>12 domains</strong> &nbsp;·&nbsp; <strong>12 scoring dimensions</strong> &nbsp;·&nbsp; <strong>41 compatibility-checked bundles</strong> &nbsp;·&nbsp; <strong>4 decision tiers</strong> &nbsp;·&nbsp; <strong>~150 verified sources</strong>
</p>

> **v1.1.0 (2026-04-22)** refreshed every scoring decision against primary sources: State of JS 2024, Stack Overflow Dev Survey 2024-2025, JavaScript Rising Stars 2024/2025, DB-Engines trends, ThoughtWorks Tech Radar Vol 31/34, State of Django 2025, State of Laravel 2025, 37signals cloud-exit public numbers, and ~150 more. Evidence captured in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md). See [CHANGELOG](CHANGELOG.md) for the full shift list.

## Install

This skill ships as part of the [ready-suite](https://github.com/aihxp/ready-suite) monorepo. The hub installer symlinks `SKILL.md` and `references/` for all eleven skills into every detected harness (Claude Code, Codex, Cursor, pi, OpenClaw, any Agent Skills harness):

```bash
git clone https://github.com/aihxp/ready-suite.git ~/Projects/ready-suite
bash ~/Projects/ready-suite/install.sh
```

Re-run anytime after `git pull` to pick up updates. To remove all symlinks, run `bash ~/Projects/ready-suite/uninstall.sh`.

**Windsurf or other agents without a programmatic Skill tool:** add this skill's `SKILL.md` to your project rules or system prompt. Load reference files as needed.

## When Stack Ready should trigger

The frontmatter description is tight on purpose, to keep skill-routing fast. The full trigger surface lives here.

**Positive triggers (pick or compare):**
- "What stack should I use for [X]."
- "Next.js vs. Remix," "Postgres vs. MongoDB," "Prisma vs. Drizzle," "Clerk vs. Auth.js," "Vercel vs. Railway."
- "Pick a database / ORM / auth provider / hosting provider / observability tool for [X]."
- "Should I use Convex / Supabase / Firebase for this."
- "What's the right stack for a [SaaS / fintech / healthcare / marketplace / CMS / AI] app."
- "Recommend an email provider," "recommend a payments provider," "recommend a job queue."
- "Build me a stack for [team size] working on [domain] with [budget]."

**Implied triggers (the phrase "stack" is never spoken):**
- "We're starting a new project and need to pick everything."
- "Our team is debating [library A] vs. [library B], can you settle it."
- "My co-founder wants to use [X], I want [Y], who is right."
- "What should I replace [X] with."

**Mode triggers:**
- **Greenfield** (Mode A): no code yet.
- **Assessment** (Mode B): existing codebase, evaluating current stack fit.
- **Audit** (Mode C): "did we pick right," "should we move off X," "is our stack still appropriate."
- **Migration** (Mode D): "move from [X] to [Y]," "what's the sequence to migrate off [X]."

**Negative triggers (route elsewhere):**
- Purely abstract debates with no project attached ("is Rust better than Go"). Skill requires a job.
- "Now build the app with [X]." That's [production-ready](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready).
- "Set up CI for my Next.js project." That's [repo-ready](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready).
- Single-library micro-questions ("zod vs. valibot for validation speed"). Answer inline unless the user wants the full scoring pass.
- Vendor sales questions ("is Vercel worth the price"). Answer factually; don't run the full workflow.

**Pairing:** On Claude Code and other skill-invocation-aware harnesses, Stack Ready hands off the chosen bundle to Production Ready (Step 2 architecture note) and to Repo Ready (stack-detected CI). On other harnesses, it surfaces the handoff to the user.

## The problem this solves

Generic AI stack recommendations fail in five specific ways:

1. **Unweighted scoring.** "Drizzle is better than Prisma" reads as objective but rests on weights (type-safety vs. maturity vs. ecosystem) that were never stated. Change the weights, the answer changes.
2. **No flip point.** "Use Convex" for a B2B SaaS with complex reporting sounds fine until the team needs a cross-tenant aggregation that doesn't fit Convex's query model. A good recommendation names that failure mode up front.
3. **No scale ceiling.** "Supabase is great for an MVP" is true. It's also true that Supabase has a documented ceiling, usually hit around a specific row count or query pattern. A recommendation without the ceiling is a promise you can't keep.
4. **No switching cost.** "You can always move later" ignores that moving off a BaaS after 18 months of product build is a 2-to-6-month engineering project. A real recommendation states the switching cost in engineer-weeks.
5. **Date rot.** A 2024 recommendation saying "use Clerk" may not survive Clerk's 2026 pricing change, a WorkOS acquisition, or a security incident. Undated recommendations are dated recommendations with the date hidden.

Stack Ready forces every recommendation to answer all five. The artifact it produces, `.stack-ready/DECISION.md`, is portable and auditable; a new engineer joining the team six months later reads it and understands not just the pick but the reasoning.

## Vibe picks vs. deliberate decisions

Karpathy's "vibe coding" has a cousin: vibe stack selection. Scroll a few threads, notice the popular names, install them, start building. When it works, it's fast. When it doesn't, the pattern is the same:

- **Firebase-to-Postgres rewrites** after the team hits data-modeling limits (documented repeatedly, 2024-2026).
- **Convex-to-something migrations** when reporting requirements outgrow the query model.
- **Auth provider swaps** (Auth0 -> Clerk -> Better Auth -> ???) when pricing or ergonomics shift.
- **Monorepo-to-microservices pivots** in teams of 2-4 who adopted microservices for signaling rather than scale.
- **Vercel-to-self-hosted moves** in month 18 when the bill hits $5k/month and no one asked about egress pricing at day one.

Each of these is a predictable outcome of a stack picked without stated weights, without a flip point, and without a scale ceiling. Stack Ready makes those three things mandatory output, not optional nuance.

## How it works

```
Step 0  Research     Detect mode (greenfield / assessment / audit / migration)
Step 1  Pre-flight   6 questions: domain, team, budget, ship window, scale, compliance
Step 2  Constraints  Convert answers into hard constraints and weighted preferences
Step 3  Candidates   Pull top picks per dimension from the domain matrix
Step 4  Pairing      Reject anti-pairings (Convex+Prisma, Supabase+Firebase, etc.)
Step 5  Scoring      1-10 per dimension with rationale and stated weights
Step 6  Tradeoffs    Flip point, scale ceiling, switching cost per shortlisted bundle
Step 7  Migration    (Mode D only) sequence, blast radius, rollback checkpoints
Step 8  Decision     Write .stack-ready/DECISION.md and hand off
Step 9  Staleness    Print skill version, warn if >6 months old
```

Each step maps to a **completion tier**. The decision is usable at every checkpoint, not just at the end.

## Four entry modes

| Mode | Trigger | Output |
|---|---|---|
| **Greenfield** | No code yet | Full scoring pass, Safe Default bundle recommended, other bundles ranked |
| **Assessment** | Existing codebase | Current stack inventory, gap analysis per dimension, targeted recommendations |
| **Audit** | "Did we pick right" | Assessment plus keep/adjust/replace verdict per dimension with rationale |
| **Migration** | "Move from X to Y" | Sequenced plan with blast radius, rollback checkpoints, data migration strategy |

## Completion tiers

18 requirements across 4 independently shippable tiers:

| Tier | Name | What you can do with it |
|---|---|---|
| 1 | **Shortlist** | Viable candidates per dimension, hard constraints satisfied |
| 2 | **Scored** | Bundles ranked with 1-10 per dimension, weights stated, pairings validated |
| 3 | **Justified** | Flip points, scale ceilings, switching costs all documented |
| 4 | **Decided** | `DECISION.md` written, handoff to production-ready/repo-ready declared |

The agent matches the tier to the session. A quick Saturday "which DB" question runs to Tier 2 and stops. A full SaaS stack pick for a funded team runs to Tier 4 with the artifact.

## What this skill prevents

Mapped against recurring, documented stack-picking failures:

| Failure pattern | What Stack Ready enforces that prevents it |
|---|---|
| **Firebase/BaaS to Postgres rewrite after 12-18 months** (common pattern) | Step 6 scale ceiling forces naming the point where the BaaS starts fighting the team |
| **HIPAA app on a service with no BAA** (compliance violation, rework) | Step 2 constraint map converts "PHI in the data layer" into a hard constraint that drops candidates in Step 3 |
| **Unstated weights driving an "objective" recommendation** | Step 5 requires explicit weighting vector; Have-nots list forbids unweighted scores |
| **Convex + Prisma stacked together** (paying for two data layers) | Step 4 pairing check rejects this as an anti-pairing |
| **Multiple auth providers in the same app** (user-record split-brain) | Step 4 pairing check rejects competing identity providers |
| **"Microservices for a team of 2"** (complexity floor exceeds scale) | Step 6 switching-cost discipline and Have-nots list reject complexity without a scale forcing function |
| **Vercel bill shock at month 18** (egress + seats not priced in) | Step 2 cost ceiling constraints require egress and seat pricing to be named, not assumed |
| **Dead-library recommendations** (archived repo, last commit >18 months) | Have-nots list: recommending unmaintained libraries is disqualifying |
| **"It depends" as the final answer** | Step 1 forces stated assumptions; Have-nots list forbids un-decided output |
| **Stack pick with no scale ceiling named** | Step 6 mandatory; Tier 3 gate |
| **Stack pick with no flip-point paragraph** | Step 6 mandatory; Tier 3 gate |
| **Stack pick with no switching cost named** | Step 6 mandatory; Tier 3 gate |
| **Handoff to implementation loses the reasoning** | Step 8 `.stack-ready/DECISION.md` artifact captures weights, flips, ceilings, and losers |
| **Stale recommendation from 2 years ago acted on today** | Step 9 staleness check; Have-nots list requires a date stamp |
| **Undisclosed vendor relationship inflating a score** | Have-nots list: undisclosed commercial ties are disqualifying |

## 12 domain profiles

Generic stack advice misses domain-specific landmines. The skill carries per-dimension picks, flip points, scale ceilings, and pairing rules for 12 domains:

| # | Domain | Typical core question |
|---|---|---|
| 1 | **SaaS / Multi-tenant** | How do we keep tenants isolated while iterating on shared features? |
| 2 | **E-commerce / Retail** | Can this handle variants, inventory-as-ledger, and tax correctness? |
| 3 | **CMS / Content / Blog** | Does the content model scale to translations, revisions, and preview flows? |
| 4 | **Fintech / Financial** | Does the stack support double-entry, append-only ledgers, and audit? |
| 5 | **Healthcare / Medical** | Does the managed service sign a BAA? Can we log every PHI access? |
| 6 | **Education / LMS** | Accessibility is Tier 1, not polish. How does the stack get there? |
| 7 | **CRM / Sales / Marketing** | Can we ingest events at scale, dedupe, and enrich without losing the audit trail? |
| 8 | **Customer Support / Helpdesk** | Real-time updates, SLA timers, tenant-scoped permissions, integrations. |
| 9 | **Marketplace / Two-sided** | Payments for multi-party flows, trust signals, moderation. |
| 10 | **AI / ML / LLM products** | Eval loops, prompt versioning, cost control, streaming UX. |
| 11 | **Analytics / BI / Dashboards** | Query flexibility, data freshness, cost per query, embed story. |
| 12 | **Internal Tools / Back-office** | Speed to ship, minimum ops burden, no customer-facing constraints. |

**Examples of what domain knowledge prevents:**
- **Fintech.** Picking a BaaS that doesn't support double-entry ledger audit requirements.
- **Healthcare.** Picking a managed host that refuses BAAs on the tier the team can afford.
- **E-commerce.** Picking an ORM pattern that can't model variants/inventory locations cleanly.
- **AI products.** Picking a framework that makes streaming UX hostile to the underlying model.
- **SaaS.** Picking a data layer where tenant isolation has to be reimplemented in application code.

## 12 scoring dimensions

Every domain profile scores candidates across the same 12 dimensions. Scores are 1-10 with one-line rationale, aggregated under user-overridable weights.

| # | Dimension | What it covers |
|---|---|---|
| 1 | **Framework** | The fullstack meta-choice (Next.js, Remix, SvelteKit, Nuxt, Rails, Django, Laravel, Phoenix, etc.) |
| 2 | **Language / runtime** | TypeScript, Python, Ruby, Elixir, Go, Kotlin, Rust |
| 3 | **Database** | Primary persistence: Postgres, MySQL, SQLite, MongoDB, Convex, DynamoDB, Firestore |
| 4 | **ORM / query layer** | Prisma, Drizzle, Kysely, SQLAlchemy, Ecto, ActiveRecord, raw SQL |
| 5 | **Auth / identity** | Better Auth, Auth.js, Clerk, WorkOS, Supabase Auth, Firebase Auth, Devise, django-allauth, Keycloak |
| 6 | **UI library** | shadcn/ui, Radix, Mantine, MUI, Chakra, Ant, Tailwind UI, HeroUI, headless + custom |
| 7 | **Client state / data fetching** | TanStack Query, SWR, Apollo, RTK Query, Convex hooks, Server Components, Hotwire, HTMX |
| 8 | **Hosting / deploy** | Vercel, Netlify, Railway, Fly, Render, AWS, GCP, Azure, Cloudflare, self-hosted |
| 9 | **Observability** | Sentry, Datadog, New Relic, Honeycomb, Axiom, Grafana Cloud, OpenTelemetry self-host |
| 10 | **Payments** | Stripe, Paddle, Lemon Squeezy, Braintree, Adyen, Stripe Connect |
| 11 | **Email / notifications** | Resend, Postmark, SendGrid, AWS SES, Loops, Knock, Novu |
| 12 | **Background jobs / queues** | Inngest, Trigger.dev, BullMQ, SQS, Sidekiq, Celery, Oban, Temporal |

## 41 compatibility-checked bundles

Each of the 12 domains ships with three pre-combined bundles (Safe Default / Fast-to-Ship / Enterprise), for 36 in total. v1.1.0 added 5 cross-domain named bundles covering the non-React-default world.

### Per-domain archetypes

| Archetype | Fit profile |
|---|---|
| **Safe Default** | Small-to-medium team, cash-efficient, ship in weeks, no exotic constraints, mature tooling preferred. The pick that is "probably right" when the user hasn't stated a strong opinion. |
| **Fast-to-Ship** | Solo or very small team, wants BaaS leverage, minimal ops surface, willing to trade scale ceiling for velocity. The MVP pick. |
| **Enterprise** | 10+ engineers, compliance in scope, self-host or portability matters, ops maturity, scale ceiling is higher than any single bundle can absorb. The "will survive" pick. |

### Cross-domain named bundles (new in v1.1.0)

| Bundle | Fit |
|---|---|
| **Cloudflare-native** | Workers + D1 (or Hyperdrive + Neon) + R2 + Durable Objects + Drizzle + Better Auth / Clerk. Edge-first apps, AI inference, post-CF-Astro-acquisition content stacks. |
| **Post-Cloud Rails** | Rails 8 + Hotwire + Kamal 2 + Hetzner VPS + Solid Queue/Cache/Cable + Postmark. Backed by 37signals' $10M+/5yr exit savings; real pattern, not a meme. |
| **Phoenix LiveView** | Phoenix 1.8 + LiveView 1.1 + Ecto + Oban + Fly.io. Soft-realtime native. Helpdesk, collab, presence, live dashboards. |
| **Django + HTMX + Alpine** | Django 6 + HTMX + Alpine + Tailwind. HTMX adoption among Django devs grew 5% to 24% (2021-2025). Canonical for CMS, B2B admin, internal tools in Python shops. |
| **TALL / Laravel + Livewire** | Laravel 12 + Livewire (62% per State of Laravel 2025) + Alpine + Tailwind + Forge. PHP's most polished SaaS stack. |

See [`references/stack-bundles.md`](references/stack-bundles.md) for full per-dimension fills with coherence rationale and flip indicators for all 41.

## Pairing rules

Some combinations do not work together, at any scale, for anyone. The skill rejects them in Step 4 before scoring. A representative sample:

| Anti-pairing | Why |
|---|---|
| **Convex + Prisma** | Convex replaces the data layer; stacking Prisma pays for two ORMs and fights the platform |
| **Supabase + Firebase** | Two BaaS is rarely "polyglot"; it is usually a migration in progress or a confused team |
| **Clerk + Better Auth + WorkOS** | Pick one identity provider; mixing creates user-record split-brain and impossible RBAC |
| **Prisma + Drizzle (same service)** | One ORM per service; mixing creates two sources of schema truth |
| **shadcn/ui + MUI (same app)** | Two design systems, one app, no survivors |
| **TanStack Query + SWR** | Pick one cache layer |
| **Sidekiq + BullMQ** | Two job queues is the wrong kind of polyglot |
| **Vercel + AWS Lambda in the same app path** | Vercel runs on AWS Lambda; stacking adds a hop for no benefit |

Full table in `references/pairing-rules.md` with rationale and legitimate-exception cases.

## Works with any stack

Stack Ready is opinionated about which stacks fit which domains, but it covers the full cross-section:

- **JavaScript / TypeScript**: Next.js, Remix, SvelteKit, Nuxt, Astro, Solid Start
- **Ruby**: Rails with Hotwire/Turbo or Inertia
- **Python**: Django with HTMX, FastAPI, Flask
- **PHP**: Laravel with Inertia or Livewire
- **Elixir**: Phoenix with LiveView
- **Go**: Echo, Chi, Gin (when a full framework isn't the fit)
- **Kotlin / Java**: Spring Boot, Ktor (typically enterprise)
- **.NET**: ASP.NET Core, Blazor

Managed-data-layer alternatives (Convex, Supabase, Firebase, Appwrite, PocketBase) are scored against traditional stacks per domain.

## Reference library

10 files, loaded on demand. A typical session reads 3-5, never all 10.

<details>
<summary>View the full reference library</summary>

| File | What it covers | ~Tokens |
|---|---|---|
| **Always loaded** | | |
| `stack-research.md` | Mode detection, codebase inventory protocol, stack-sniffing | ~8K |
| `preflight-and-constraints.md` | 7 pre-flight questions (domain, team, budget, ship window, scale, compliance, reversibility), compliance-to-constraint map | ~8K |
| **Tier 1** | | |
| `domain-stacks.md` | 12 domains, per-dimension picks with rationale, flip points | ~22K |
| `stack-bundles.md` | 36 per-domain bundles plus 5 cross-domain named bundles (Cloudflare-native, Post-Cloud Rails, Phoenix LiveView, Django+HTMX+Alpine, TALL/Laravel+Livewire) | ~16K |
| **Tier 2** | | |
| `pairing-rules.md` | Anti-pairings, overlap detection, legitimate-exception cases, staleness notes | ~7K |
| `scoring-framework.md` | 12 dimensions including split Ecosystem (depth + trajectory) and Exit cost axes; default weights; override mechanics; when to skip scoring entirely | ~11K |
| **Tier 3 / on-demand** | | |
| `dimension-deep-dives.md` | Per-dimension analysis: framework, TS backend (Hono), JS runtime, data, auth, UI, hosting, observability (including LLM sub-section), payments, email, jobs | ~18K |
| `tradeoff-narratives.md` | Flip points, scale ceilings, switching costs per candidate | ~11K |
| **Mode D only** | | |
| `migration-paths.md` | X-to-Y sequences: Firebase to Postgres, Auth0 to Clerk, Vercel to self-host, Auth.js to Better Auth, etc. | ~13K |
| **Evidence base (on demand)** | | |
| `RESEARCH-2026-04.md` | Consolidated research dossier behind v1.1.0 scoring. ~150 verified primary-source URLs across Stack Overflow Dev Survey 2024-2025, State of JS 2024, Rising Stars 2024/2025, DB-Engines, ThoughtWorks Tech Radar, 37signals cloud-exit, migration postmortems. Every scoring shift traceable here. | ~30K |

</details>

## Composes with production-ready and repo-ready

```
stack-ready       ->  "what stack fits this job?"
production-ready  ->  "build the app to production grade"
repo-ready        ->  "wrap the repo in hygiene"
```

The output of `stack-ready` (the `DECISION.md` artifact) slots directly into `production-ready`'s Step 2 architecture note. Three tight skills, each with its own scope, composable.

Do not pre-couple them. Each has independent trigger surface. A founder asking "what stack for my SaaS" should get `stack-ready` alone without being routed into an implementation workflow they didn't ask for. A developer running `production-ready` should not be forced back through `stack-ready` if they already know their stack. They compose on demand, not automatically.

## Principles

**Score under stated weights.** No recommendation reads as "objective." The weights are always surfaced, and the user can override.

**Name the flip point.** Every shortlisted bundle ships with the failure mode that would reverse the choice. A recommendation without a flip point is a horoscope.

**Name the scale ceiling.** Every bundle has a point where it starts fighting the team. That point is named, not hidden.

**Name the switching cost.** Stated in engineer-weeks. Moving off a stack is not "just a refactor."

**Stop at the decision.** Does not build the app. Does not configure the repo. Composes with skills that do.

**Date-stamp everything.** Skill version, last-updated date, current date, all printed at the end of every run. Staleness is a fact, not a rumor.

**No vendor capture.** No paid placement. No undisclosed commercial ties. Losing trust here kills the skill.

## Contributing

Gaps, outdated picks, missing domains: contributions welcome. This is a living document. The scoring matrix needs refresh every 3-6 months as libraries move, pricing changes, and new entrants shift the scoring. Open an issue or PR.

## License

[MIT](LICENSE)

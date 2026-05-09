# Production Ready

> **An AI skill for any coding agent: Claude Code, Codex, Cursor, Windsurf, Copilot, or your own.**

Stop shipping apps that fall apart on first click.

AI-generated apps (dashboards, admin panels, internal tools, SaaS back-offices, analytics consoles, ops centers) look finished until someone tries to use them. Buttons that don't save. Charts hardcoded to fake JSON. Login pages that accept anything. Sidebar links that 404. Settings pages with no persistence. Ten seconds of clicking reveals the truth: it's a screenshot, not a tool.

Production Ready is a **skill**, a structured AI instruction set that any coding agent can consume. It ensures every feature ships wired end-to-end: real auth, real data, real permissions, real states, real feedback, across any stack and any industry.

> **Part of the [ready-suite](SUITE.md)**, a composable set of ten AI skills covering the full arc from idea to launch (planning, building, shipping). Production Ready is the building-tier core. See [`SUITE.md`](SUITE.md) for the full map and [`ORCHESTRATORS.md`](ORCHESTRATORS.md) for how the suite composes with GSD, BMAD, Superpowers, and plain harnesses.

<p align="center">
<strong>37 reference files</strong> &nbsp;·&nbsp; <strong>33 industry verticals</strong> &nbsp;·&nbsp; <strong>24 production requirements</strong> &nbsp;·&nbsp; <strong>4 shippable tiers</strong>
</p>

## Install

**Claude Code:**
```bash
git clone https://github.com/aihxp/production-ready.git ~/.claude/skills/production-ready
```

**Codex:**
```bash
git clone https://github.com/aihxp/production-ready.git ~/.codex/skills/production-ready
```

**pi, OpenClaw, or any [Agent Skills](https://agentskills.io)-compatible harness:**
```bash
git clone https://github.com/aihxp/production-ready.git ~/.agents/skills/production-ready
```

**Cursor, Windsurf, or other agents:**
Add `SKILL.md` to your project rules or system prompt. Load reference files as needed.

**Any agent with a plan-then-execute loop:**
Upload `SKILL.md` and the relevant reference files to your project context. The skill produces structured output (tables, checklists, gap analyses) that any planner can consume. It's not tied to any specific agent runtime.

## When Production Ready should trigger

The short frontmatter description is tight on purpose, to speed up skill-routing decisions. The full trigger surface lives here.

**Positive triggers (build or extend):**
- "Dashboard," "admin panel," "control panel," "back office," "internal tool," "ops console."
- "Analytics view," "analytics dashboard," "reporting interface," "reporting dashboard," "metrics view," "KPI view."
- "Customer portal," "merchant dashboard," "operator console," "agent workspace."
- "CRM," "CMS," "LMS," "ERP-lite," "helpdesk," "marketplace admin," "e-commerce admin," "HR admin," "medical admin," "property management dashboard."
- Requests to build a "logged-in area," "user area," "authenticated section," or "multi-page interface with CRUD over domain data."
- Feature-level requests inside an existing dashboard that touch auth, RBAC, multi-page nav, tables, charts, or audit trails.

**Implied triggers (the word "dashboard" is never spoken):**
- "Add a sidebar nav and routing for these pages."
- "Wire up role-based access for admins and members."
- "Build user management with invites, roles, and deactivation."
- "Add an audit log of who did what and when."
- "Show charts driven by real data in the database."
- "Add filters, sorting, and CSV export to this table."
- "Build a settings page that saves user preferences."

**Mode triggers (from `codebase-research.md`):**
- **Greenfield** (Mode A): empty repo or boilerplate only.
- **Assessment** (Mode B): existing source files with routes, schema, components.
- **Audit** (Mode C): user says "audit," "verify," "harden," "check," "review," or "is this production-ready."
- **Migration** (Mode D): off-the-shelf template (Retool, Appsmith, shadcn admin kit), half-built prior-agent work, or cross-framework port.

**Negative triggers (route elsewhere):**
- Single component or single page ("add one chart," "build a landing page"). Skill is for multi-page systems.
- Repo hygiene (README, LICENSE, CI, CONTRIBUTING, issue templates, release automation). Delegate to [repo-ready](https://github.com/aihxp/repo-ready).
- Marketing site, blog, documentation site, or any frontend-only content surface.
- Pure greenfield scaffolding where the user only wants the repo initialized and not app features built. That's `repo-ready`.
- Data-science notebooks, research scripts, or CLI tools.

**Pairing:** On Claude Code and other skill-invocation-aware harnesses, Production Ready automatically hands off repo-hygiene work to [repo-ready](https://github.com/aihxp/repo-ready) when it hits Step 9 (verification). On other harnesses, it surfaces the handoff to the user instead of inlining the work.

## The problem this solves

AI agents build apps layer by layer: database, then API, then auth, then UI. This produces 80% completion on every layer and 0% completion on any actual feature. The result is a scaffold that *looks* done but does nothing.

Production Ready enforces **vertical-slice discipline**: build one feature completely (schema, API, permissions, UI, states, tests) before touching the next. When a feature is done, a real person can do a real job with it.

## Vibe coding vs. vibe engineering

Andrej Karpathy coined "vibe coding" in February 2025: generate code with an LLM, accept it, move on without reading it. When that works, it's magic. When it doesn't, you get the incidents in the news:

- **Moltbook** leaked 1.5M API keys and 35k user emails because row-level security was never enabled (2025).
- **Lovable** shipped an inverted access-control bug across 170+ production apps (CVE-2025-48757).
- **Base44** had a platform-wide authentication bypass.
- A **Replit agent** wiped a production database during a declared code freeze (1,206 executive records, 1,196 company records).
- **Veracode 2025** tested 100+ LLMs: 45% of generated code had vulnerabilities; 86% failure rate on XSS.
- **Socket 2025:** 20% of AI-suggested packages don't exist (slopsquatting is now a named attack vector).
- **METR 2025:** experienced developers were 19% *slower* with AI while believing they were 20% faster.
- **Stack Overflow 2025:** 66% cite "almost right, but not quite" as their top AI frustration; trust in AI accuracy dropped from 40% to 29% year-over-year.

Simon Willison coined the counterweight: **"vibe engineering."** Same AI leverage, but with tests, review, planning, threat models, and decision records. That's what this skill enforces.

If you want code the author (the model) doesn't have to understand, this is the wrong skill. If you want code that survives the next six months without you, it's the right one.

## How it works

```
Step 0  Research     Detect project state (greenfield / existing / audit)
Step 1  Pre-flight   12 questions that prevent incompatible decisions
Step 2  Architecture Stack, auth model, permission model, route map
Step 3  Identity     Derive unique visual personality from the domain
Step 4  Foundation   Auth, RBAC, shell, seed data, one working page
Step 5  Features     Each feature wired end-to-end with all states
Step 5.1 Hollow check Automated scan catches TODOs and fake data mid-build
Step 6  Cross-cutting Search, notifications, settings, exports, audit log
Step 7  Tests        Auth flow, CRUD, permissions, accessibility
Step 8  Harden       Security headers, performance budget, bundle size
Step 9  Verify       20-point smoke test before shipping
```

Each step maps to a **completion tier**. The app is shippable at every checkpoint, not just at the end.

## Three entry modes

Not just for new projects.

| Mode | Trigger | Output |
|---|---|---|
| **Greenfield** | Empty directory | Full scaffolding from zero |
| **Assessment** | Existing codebase | 7-part scan, gap analysis, targeted todos |
| **Audit** | "Verify this app" | Assessment plus checklist, severity-sorted fix-it list |

The research output is a structured document any agent's planner can consume to generate precise, gap-filling tasks instead of generic ones.

## Completion tiers

24 requirements, organized into 4 independently shippable tiers:

| Tier | Name | What you can do with it |
|---|---|---|
| 1 | **Foundation** | Sign in, see real data, create/edit/delete one entity, sign out |
| 2 | **Functional** | Role-based access, all states handled, settings that save, profile page |
| 3 | **Polished** | Audit trail, keyboard accessible, responsive to mobile, cross-cutting features wired |
| 4 | **Hardened** | Tested, secure, verified, zero hollow indicators, ready to ship |

The agent declares each tier complete at its checkpoint. For existing codebases, the research phase determines the current tier and works toward the next one.

## What this skill prevents

Mapped against real, documented AI coding failures:

| Real incident / research finding | What Production Ready enforces that would have caught it |
|---|---|
| **Moltbook (2025):** 1.5M keys leaked because RLS was never enabled | Step 2 threat model names every trust boundary; Tier 1 requires server-side auth; "permissions checked only on client" is an explicit disqualifier |
| **Lovable CVE-2025-48757:** inverted access control across 170+ apps | Tier 2 RBAC requires server-side checks on every mutation, mapped back to the threat model |
| **Base44 platform auth bypass** | Same as above |
| **Replit agent wiped prod DB during code freeze** | Destructive commands without confirmation and backup are an explicit disqualifier |
| **Slopsquatting (Socket 2025):** 20% of AI-suggested packages are ghosts | Step 4 requires pre-install verification of every unfamiliar dependency; hollow-check scans `package.json` for unpublished names |
| **Veracode 2025:** 45% of AI code has vulnerabilities, 86% XSS failure | Tier 4 security headers, rate limits, `npm audit`; threat model drives per-slice permission checks |
| **METR 2025:** experienced devs 19% slower with AI | Tier proof tests force real end-to-end verification over dopamine; vertical slices produce working features instead of parallel half-done layers |
| **Stack Overflow 2025:** 66% cite "almost right, but not quite" | Hollow-check protocol + smoke tests per slice catch wiring-level wrongness before it compounds |
| **Context entropy (Pragmatic Engineer):** vibe projects hit a wall around 3 months | `.production-ready/STATE.md` session state file + ADR-per-non-obvious-decision preserve context across sessions and handoffs |
| **Generic "AI slop" UI** (every app looks like shadcn defaults) | Visual identity framework with 10 archetypes, typography pairings, and explicit anti-patterns ("unmodified shadcn/Radix/MUI theme visible to the user") |
| **`const mockUsers = [...]` in components** | Seeded real persistence; hardcoded fake data is an explicit disqualifier |
| **`onClick={() => console.log("clicked")}`** | Explicit disqualifier at any tier |
| **"Coming soon" sidebar links** | Every nav link must route to a real page; explicit disqualifier |
| **Charts that re-randomize on refresh** | `Math.random()` driving any chart or KPI is an explicit disqualifier |
| **Login that accepts any credentials** | Tier 1 proof test requires failed-login rejection |
| **`// TODO: add validation`** | Hollow-check scans catch TODOs across JS/TS, Python, Ruby, PHP |

## 33 industry verticals

Generic CRUD misses domain-specific landmines. The skill carries gotchas, compliance requirements, UX patterns, and seed data shapes for 33 industries:

<details>
<summary>View all 33 domains</summary>

| # | Domain | # | Domain |
|---|---|---|---|
| 1 | SaaS / Multi-tenant | 18 | Non-profit / Fundraising |
| 2 | E-commerce / Retail | 19 | Media / Streaming |
| 3 | CMS / Content / Blog | 20 | Agriculture / Farm |
| 4 | Financial / Fintech | 21 | AI / ML / Chat |
| 5 | Healthcare / Medical | 22 | Entertainment / Events |
| 6 | Education / LMS | 23 | Gaming / Esports |
| 7 | Travel / Hospitality | 24 | Cybersecurity / SOC |
| 8 | Sports / Fitness | 25 | Construction / Field Services |
| 9 | Real Estate / Property | 26 | Marketplace / Platform |
| 10 | Logistics / Supply Chain | 27 | Insurance / InsurTech |
| 11 | HR / People / Payroll | 28 | Telecommunications / ISP |
| 12 | Project Management | 29 | Energy / Utilities |
| 13 | Customer Support / Helpdesk | 30 | Government / Public Sector |
| 14 | Marketing / CRM / Sales | 31 | Recruiting / ATS |
| 15 | IoT / Device Management | 32 | Co-working Space |
| 16 | Restaurant / Food Service | 33 | Workflow Automation |
| 17 | Legal / Law Firm | | |

</details>

**Examples of what domain knowledge prevents:**
- **Healthcare.** Building without HIPAA audit logging of every PHI access.
- **Financial.** Using `float` for money instead of integer cents.
- **E-commerce.** Modeling inventory as a counter instead of a ledger.
- **SaaS.** Missing `WHERE org_id = ?` on every query (tenant data leak).
- **Construction.** Missing AIA G702/G703 payment applications.

## Works with any stack

Pattern-based, not framework-specific:

- **React / Next.js** plus TypeScript, Prisma, Auth.js, shadcn/ui, TanStack Query
- **SvelteKit** plus TypeScript, Convex or Drizzle, Auth.js, Tailwind
- **Vue / Nuxt** plus TypeScript, Drizzle, shadcn-vue
- **Rails** plus Hotwire/Turbo, Devise
- **Django** plus HTMX, django-allauth
- **Laravel** plus Inertia, Breeze

...or anything else. The guidance translates.

## Reference library

37 files, loaded on demand. A typical project reads 4 to 8, never all 37.

<details>
<summary>View the full reference library</summary>

| File | What it covers |
|---|---|
| **`SKILL.md`** | Core workflow, vertical-slice discipline, haves/have-nots |
| `codebase-research.md` | Project state detection, greenfield/assessment/audit modes, codebase scan protocol |
| **Foundation** | |
| `preflight-and-verification.md` | 12 pre-flight questions, verification checklist, smoke test |
| `naming.md` | Cross-layer naming conventions (DB, API, UI, events, permissions, tests) |
| `information-architecture.md` | 7 layout patterns, navigation, sidebar, responsive |
| `auth-and-rbac.md` | Passkeys, magic links, RBAC, multi-tenant, impersonation |
| `data-layer.md` | Server Components, API contracts, queries, mutations, caching |
| **UI & UX** | |
| `ui-design-patterns.md` | Components, typography, spacing, tokens, visual identity decision framework |
| `data-visualization.md` | Charts, KPIs, tables, accessibility, sparklines |
| `states-and-feedback.md` | Loading, empty, error, toasts, undo, offline |
| `workflows-and-actions.md` | Forms, onboarding, drag-and-drop, approval workflows |
| `animation-and-motion.md` | Transitions, micro-interactions, loading choreography, spring physics |
| `dark-mode-deep-dive.md` | Token remapping, image handling, chart colors, flash prevention |
| `accessibility-deep-dive.md` | Screen readers, ARIA widgets, keyboard navigation, legal compliance |
| `error-pages-and-offline.md` | 404/403/500/503 pages, maintenance mode, PWA offline |
| `file-management-and-uploads.md` | Upload UX, chunked uploads, image crop, file previews |
| **Features** | |
| `settings-and-configuration.md` | User, org, system settings, admin panel, multi-tenant |
| `notifications-and-email.md` | In-app, email, push, SMS, Slack, delivery tracking |
| `payments-and-billing.md` | Checkout, subscriptions, invoicing, refunds, PCI |
| `reporting.md` | PDF/Excel generation, scheduling, large datasets |
| `analytics-and-telemetry.md` | Feature adoption, session replay, A/B testing, audit logs |
| **Integration** | |
| `system-integration.md` | Service layer, event bus, cache invalidation, feature flags |
| `api-and-integrations.md` | OAuth2, webhooks, data sync, building your own API |
| `internationalization.md` | i18n, RTL, date and number formatting, translation workflows |
| **Specialized** | |
| `ai-product-patterns.md` | Streaming, RAG, prompt management, eval, cost control |
| `testing-and-quality.md` | E2E, component, load, contract, visual regression testing |
| `performance-and-security.md` | Bundle size, SSR, CSP, CORS, rate limiting |
| `security-deep-dive.md` | Sessions, data protection, secrets, incident response |
| **Frontend & Marketing** | |
| `headers-and-navigation.md` | Header layout, mega menus, mobile nav, footer design |
| `marketing-and-landing-pages.md` | Hero sections, social proof, feature grids, pricing tables |
| `seo-and-web-standards.md` | Meta tags, Open Graph, robots.txt, llms.txt, RSS feeds, sitemap |
| `social-media-features.md` | Social links, share modals, embeds, social login |
| `email-template-design.md` | HTML email, responsive email, dark mode in email |
| `realtime-and-collaboration.md` | Presence, live cursors, collaborative editing, WebSocket lifecycle |
| **Growth & Operations** | |
| `login-and-auth-pages.md` | Login page design, registration UX, auth flows |
| `migration-and-data-import.md` | CSV/API import, platform migration, phased rollout |
| `expansion-and-scalability.md` | Multi-tenancy, feature flags, i18n prep, billing expansion |
| **Domains** | |
| `domain-considerations.md` | 33 verticals with gotchas, compliance, seed data |

</details>

## Contributing

Gaps, missing domains, outdated guidance: contributions welcome. Open an issue or PR.

## License

[MIT](LICENSE)

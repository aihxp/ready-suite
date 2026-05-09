# Pulse

This project was kicked off via the [ready-suite](https://github.com/aihxp/ready-suite). The kickoff arc produced the artifacts listed below; consult the relevant artifact before changes that touch its area.

## Ready-suite artifact map

| Sibling | Status | Artifact |
|---|---|---|
| prd-ready | done | `.prd-ready/PRD.md` |
| architecture-ready | done | `.architecture-ready/ARCH.md` |
| roadmap-ready | done | `.roadmap-ready/ROADMAP.md` |
| stack-ready | done | `.stack-ready/STACK.md` |
| repo-ready | done | `.repo-ready/SCAFFOLD.md` |
| production-ready | active (week 9 of 14) | `.production-ready/STATE.md` |
| deploy-ready | planned (week 13 cutover) | `.deploy-ready/DEPLOY.md` |
| observe-ready | planned (operational weeks 13-14) | `.observe-ready/OBSERVE.md` |
| launch-ready | skipped (v1.1 scope) | (not produced) |
| harden-ready | done (week 12) | `.harden-ready/FINDINGS.md` |
| kickoff-ready | done (orchestration arc) | `.kickoff-ready/PROGRESS.md` |

The kickoff audit ledger lives at `.kickoff-ready/PROGRESS.md`. It records every sibling invocation, skip declaration, and verification timestamp from the kickoff arc.

## Project conventions

This file is the cross-tool agent brief; project conventions (stack, build/test commands, forbidden actions, contribution policy) live in `CONTRIBUTING.md` and the per-tool overlay files (`CLAUDE.md` is a symlink to this `AGENTS.md`; `.cursorrules` and `.windsurfrules` mirror the conventions section).

### Stack (mirrors `.stack-ready/STACK.md` §5)

- Runtime: Node.js 22 LTS (pinned in `.nvmrc`)
- Language: TypeScript 5.x, strict mode
- Framework: Next.js 15 (App Router) + Server Actions
- Database: Postgres on Neon serverless, Drizzle for ORM and migrations
- Auth: Auth.js v5 with Email provider (magic-link); OIDC migration path preserved
- CSS / components: Tailwind v4 + shadcn/ui re-skinned with `DESIGN.md` tokens
- Job runner: node-cron in worker process (Railway)
- Email: Resend
- Hosting: Vercel (web) + Railway (worker)
- Observability: Axiom

### Commands

- `pnpm dev` - start the API + SPA in watch mode on port 3000
- `pnpm worker:dev` - start the cron worker in watch mode
- `pnpm test` - run Vitest unit + integration suite
- `pnpm lint` - Biome lint + format check
- `pnpm typecheck` - tsc --noEmit
- `pnpm build` - Next.js production build
- `pnpm db:migrate:expand` - apply expand-phase Drizzle migrations
- `pnpm db:seed` - seed Neon dev branch with mock DartLogic data
- `npx @google/design.md lint DESIGN.md` - validate design tokens (CI-enforced)

### Conventions

See `CONTRIBUTING.md` for the full contributor guide. Non-obvious rules:

- Multi-tenancy: every domain table has `tenant_id NOT NULL`. Every data-access function takes `tenant_id` as the first parameter; routes that bypass the helper fail the `tenant-scope-discipline` CI check (see `.harden-ready/FINDINGS.md` F-02 for the historical context).
- Touchpoint and at-risk-flag tables are append-only; deletes go through the audit log.
- Server-side checks before all mutations: the role middleware in `src/auth/rbac.ts` runs before every domain handler.
- Commit messages follow Conventional Commits, enforced by commitlint.
- DO NOT log secrets: the structured-logging redaction list lives in `src/lib/log.ts`; the `lint:logs` CI check enforces it (see `.harden-ready/FINDINGS.md` F-01).

### Forbidden actions

- Do not commit directly to `main`. All changes land via pull request with at least one review per `.github/CODEOWNERS`.
- Do not edit `pnpm-lock.yaml` by hand; run `pnpm install`.
- Do not write to `dist/` or `.next/` (gitignored; generated).
- Do not run `pnpm db:reset` against anything except your local Neon dev branch.
- Do not bypass the tenant-scope helper in data-access calls.
- Do not bypass `assertSlackWebhookUrl` when accepting Slack-webhook URLs (see F-04).
- Do not use `dangerouslySetInnerHTML` in the email templates without explicit sanitization (see F-06).
- Do not introduce em-dashes, en-dashes, arrows, or box-drawing characters in any markdown file in this repo. The hub's lint enforces this on the suite repos; we follow the same rule here.

## How to extend this file

Append project conventions below this line, or replace this template's body wholesale once the team has settled on the canonical agent brief. kickoff-ready will not re-edit this file. Treat it like any other repo-controlled doc: it passes through code review, it is covered by `CODEOWNERS`, and changes appear in the commit history.

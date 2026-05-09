# Pulse: repo scaffolding

| | |
|---|---|
| Tier | Tier 2 (matches PRD tier) |
| Status | v1.0 (2026-05-13) |
| Owner | Devon Park (eng lead) |
| Consumed STACK | `.stack-ready/STACK.md` v1.0 |

## What repo-ready scaffolded for Pulse

This file documents what the repo-ready skill set up for the Pulse project at week 1, before production-ready started building slices. The grep test: every file or directory referenced below exists on disk in this repo. Anything that does not exist is either out of scope (named in §Out of scope) or is a v1.x scaffolding item.

## Files at project root

| File | Purpose | repo-ready tier |
|---|---|---|
| `README.md` | Project intro, quickstart, contributor pointer | Tier 1 |
| `LICENSE` | MIT license, real year, real author | Tier 1 |
| `AGENTS.md` | Cross-tool agent brief; the canonical project conventions for any harness | Tier 2 |
| `CLAUDE.md` | Symlink to `AGENTS.md` (recommended pattern; see ready-suite repo-ready v1.6.10) | Tier 2 |
| `DESIGN.md` | Google Labs DESIGN.md format; design tokens consumed by production-ready Step 3 sub-step 3a | Tier 2 (added at week 4 by production-ready when the visual identity settled) |
| `CONTRIBUTING.md` | Contribution model: branching, PR review, commit messages, conventional commits enforced via commitlint | Tier 2 |
| `CHANGELOG.md` | Project changelog (separate from any per-skill changelog) | Tier 2 |
| `SECURITY.md` | Disclosure email, supported versions, rotation cadence | Tier 2 |
| `.gitignore` | Stack-detected: Node + Next.js + drizzle + .env | Tier 1 |
| `.editorconfig` | Editor consistency: 2-space indent, LF line endings, trim trailing whitespace | Tier 1 |
| `.nvmrc` / `.node-version` | Node 22 LTS pinned (Next.js 15 requirement) | Tier 1 |
| `package.json` | Dependencies, scripts, packageManager pinned to pnpm 9.x via Corepack | Tier 1 |
| `pnpm-lock.yaml` | Resolved dependency graph; committed | Tier 1 |
| `tsconfig.json` | TypeScript 5.x, strict mode, path aliases for src/ | Tier 1 |
| `biome.json` | Lint + format config; replaces ESLint + Prettier | Tier 2 |
| `drizzle.config.ts` | DB migration tool config; points at Neon | Tier 2 |
| `.env.example` | Documented env vars (no real secrets); real `.env` is gitignored | Tier 1 |

## Directory structure

```
.
.github/
  workflows/
    ci.yml            -> lint + typecheck + test on push and PR
    release.yml       -> tag-and-release automation on tag push
  CODEOWNERS          -> @aihxp default; @dartlogic-pilot reviewers on app/billing/ paths
  ISSUE_TEMPLATE/
    bug.yml
    feature.yml
  PULL_REQUEST_TEMPLATE.md
src/
  app/                -> Next.js App Router routes
  components/         -> React components (re-skinned shadcn/ui)
  db/
    schema.ts         -> Drizzle schema with tenant_id NOT NULL on every domain table
    migrations/       -> Drizzle migrations (numbered)
    tenant.ts         -> tenant-scope helper; every data-access function takes tenant_id
  lib/                -> shared utilities
  auth/               -> Auth.js v5 setup; magic-link Email provider
  worker/
    cli.ts            -> entry point for the Railway worker process
    jobs/
      hubspot-poll.ts -> 15-min HubSpot sync
      weekly-digest.ts -> Manager Monday email
      cohort-export.ts -> end-of-month cohort CSV
.tooling/
  pre-commit          -> commitlint, biome check, secret scan
  pre-push            -> typecheck, no-force-push without ALLOW_FORCE_PUSH
tests/
  unit/
  integration/        -> hits real Neon db (per CLAUDE.md "no mocks for DB tests")
  e2e/                -> Playwright; smoke tests against staging
docs/
  ADR/
    ADR-001-multi-tenancy.md   -> mirror of architecture-ready ADR-001
    ADR-002-magic-link-auth.md -> mirror of ADR-002
    ADR-003-worker-process.md  -> mirror of ADR-003
.kickoff-ready/
.prd-ready/
.architecture-ready/
.roadmap-ready/
.stack-ready/
.repo-ready/         -> this directory (scaffolding artifact)
.production-ready/
.deploy-ready/
.observe-ready/
.harden-ready/
```

## CI / CD

`.github/workflows/ci.yml`:

- Triggers: push to any branch, PR to main.
- Steps: pnpm install (cached), `pnpm lint` (Biome), `pnpm typecheck` (tsc --noEmit), `pnpm test` (Vitest), `npx @google/design.md lint DESIGN.md`.
- Branch protection: main requires green CI + 1 review.

`.github/workflows/release.yml`:

- Triggers: tag matching `v*`.
- Steps: build the production Docker image for the worker, push to GitHub Container Registry; trigger Vercel preview-to-prod promotion via the deploy-ready playbook.

## Quality tooling

| Concern | Tool | Config |
|---|---|---|
| Lint | Biome | `biome.json` |
| Format | Biome | (single tool, no Prettier) |
| Type check | TypeScript 5.x | `tsconfig.json` strict mode |
| Unit tests | Vitest | `vitest.config.ts` |
| Integration tests | Vitest + supertest + real Neon test branch | `tests/integration/setup.ts` |
| E2E tests | Playwright | `playwright.config.ts` |
| Pre-commit | husky + lint-staged | `.tooling/pre-commit` |
| Commit messages | commitlint | `.commitlintrc.json` (Conventional Commits) |
| Dependency scanning | GitHub Dependabot | `.github/dependabot.yml` |
| Secret scanning | GitHub default + gitleaks pre-commit | `.gitleaks.toml` |
| Visual regression | (deferred to v1.x) | -- |

## AGENTS.md scaffolding

repo-ready produced an `AGENTS.md` at project root with:

- One-sentence project description (mirrors `.prd-ready/PRD.md` summary).
- Stack section (mirrors `.stack-ready/STACK.md` §5 Bundle summary).
- Conventions section (commit messages, branching model, where not to put files).
- Forbidden actions section (no commit to main, no edit pnpm-lock by hand, no force-push, no run db:reset against anything except local).
- A pointer to `CONTRIBUTING.md` for the full contributor guide.

`CLAUDE.md` is a symlink to `AGENTS.md` per the canonical-and-overlay pattern. (Both files exist; the symlink is the implementation.)

## Out of scope (explicit)

- **Monorepo tooling** (turborepo, nx). Pulse is a single package; pnpm workspaces would be over-engineered.
- **Storybook**. Component-library docs are deferred to v1.x.
- **Visual regression testing**. v1.x scope.
- **Multi-language i18n**. Pulse v1.0 is English-only (PRD §No-gos).
- **Public-facing OpenAPI spec**. Internal-only API at v1.0.

## Downstream handoff

- **production-ready** consumes this scaffold to start the foundation slice (Step 4). The Next.js app is bootstrapped, the DB connection works, magic-link auth is wired, the worker process exists with one no-op cron job. Slices begin from there.
- **deploy-ready** consumes the `.github/workflows/release.yml` workflow plus the platform configs in `.stack-ready/STACK.md` §3.8.
- **observe-ready** consumes the structured-logging discipline in `CLAUDE.md` plus the SLO definitions in `.roadmap-ready/ROADMAP.md` §KPI handoff.
- **harden-ready** at week 12 consumes the trust-boundary code paths declared in `.architecture-ready/ARCH.md` §6.

## Why this scaffold satisfies repo-ready's no-placeholder rule

Every file named above contains actionable content tailored to Pulse's stack (Node 22 LTS, Next.js 15, Drizzle, Auth.js v5, Biome). No `TODO` markers; no `lorem ipsum`; no `{{author}}` left behind. The grep test: search the project for `TODO`, `{{`, `placeholder`, `Lorem ipsum`. Each hit is reviewable; legitimate `TODO` markers (e.g., in a function body where future work is named) are tolerated; structural placeholders are zero.

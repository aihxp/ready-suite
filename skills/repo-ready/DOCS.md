# Repo Ready -- Documentation

A ten-minute overview of what Repo Ready provides, how it's organized, and when to load each part.

## What is Repo Ready

Repo Ready is an AI skill -- a structured Markdown instruction set -- that turns a vague request like "set up my repo" into a production-grade repository tailored to your stack, project type, and stage. It works with any AI coding agent that reads instructions (Claude Code, Cursor, Cline, Windsurf, GitHub Copilot) and needs no runtime, API, or build step.

The problem it solves is narrow but expensive. AI-generated repo setups have a specific failure mode: they *look* configured but fall apart the moment someone tries to contribute. A README with just the project name. A CONTRIBUTING.md full of unresolved task markers. A SECURITY.md pointing to a fake example.com address. A CI workflow that runs an echo statement where real tests should be. A LICENSE with template variables still wrapped in curly braces. You run `gh repo view` and within ten seconds you can see it's a cardboard cutout, not a project.

Repo Ready enforces the opposite discipline: every generated file uses your project's real name, real author, real stack, and real workflow -- or it doesn't get generated at all. The skill ships 19 reference files across 4 tiers, covering 12 language ecosystems (JavaScript/TypeScript, Python, Go, Rust, Java/Kotlin, Ruby, C#/.NET, Swift, PHP, Elixir, C/C++, Dart/Flutter) and 3 platforms (GitHub, GitLab, Bitbucket) plus platform-neutral fallbacks for Azure DevOps, Gitea, Forgejo, Codeberg, and SourceHut.

## Getting started

Point your AI agent at `SKILL.md` and ask it to set up your repo. The workflow takes over from there.

```bash
git clone https://github.com/aihxp/repo-ready.git
# Tell your agent: "Read SKILL.md and references/, then set up this repository."
# The skill detects your stack, asks 1-3 questions if needed, and generates
# the stage-appropriate set of files.
```

No installation, no runtime dependencies, no API keys. The skill is pure Markdown -- any agent that reads instructions can use it, and you can read it yourself without any tooling.

**Three entry modes.** The skill detects which one applies from the filesystem:

- **Greenfield** -- empty directory, single `package.json`, or fresh scaffolding. The skill asks 1-3 questions (project type, stage, platform) and generates everything from scratch.
- **Enhancement** -- existing codebase with source files. The skill scans what already exists, fills gaps, and never overwrites your work. If detection is ambiguous or a conflict would occur, it stops and asks before writing.
- **Audit** -- when you ask "how professional is my repo?" The skill runs the 39-point health scorecard and produces a prioritized fix-it list.

## The 9-step workflow at a glance

The skill walks the agent through ten steps, each stack-aware and stage-appropriate:

| # | Step | What happens |
|---|---|---|
| 0 | **Detect** | Scans existing files, detects the stack, determines mode (greenfield / enhancement / audit) |
| 1 | **Profile** | Identifies project type × stage × audience to choose which files to generate |
| 2 | **Structure** | Sets up folders following your stack's conventions (Go -> `cmd/`, Python -> `src/package_name/`, Next.js -> `app/`) |
| 3 | **Document** | Generates README, LICENSE, CONTRIBUTING, SECURITY, CHANGELOG with your project's real content |
| 4 | **Platform** | Configures issue templates, PR templates, dependabot, CODEOWNERS for your target platform |
| 5 | **CI/CD** | Creates workflows that run your actual linter, tests, and build -- not placeholder scripts |
| 6 | **Quality** | Configures linter, formatter, and git hooks matched to the stack (Ruff for Python, Biome for TS, clippy for Rust) |
| 7 | **Security** | Adds dependency scanning, SAST, branch protection, and a real SECURITY.md contact |
| 8 | **Release** | Sets up changelog automation, version bumps, and publishing for the right registry |
| 9 | **Audit** | Runs a 39-point health scorecard to catch what's missing before declaring done |

Step 0 includes a Mode B (Enhancement) rollback protocol: if the agent detects an existing config that would conflict with what it's about to write, it stops, describes the conflict, and asks rather than silently overwriting your work.

## Completion tiers

Not every project needs every file. Repo Ready organizes requirements into four tiers, and the agent matches the tier to the project -- you stop when the tier is appropriate, not when the template list runs out.

| Tier | Name | What's configured | Proof test |
|---|---|---|---|
| 1 | **Essentials** | README, LICENSE, .gitignore, .gitattributes, .editorconfig, folder structure | Clone the repo, read the README, install, run. If that works, Tier 1 is complete. |
| 2 | **Team Ready** | + CI, quality tooling, CONTRIBUTING, CODE_OF_CONDUCT, issue/PR templates, CHANGELOG, branch protection | Fork -> follow CONTRIBUTING -> open PR -> CI runs -> review checklist appears. |
| 3 | **Mature** | + SECURITY.md, release automation, dependency scanning, CODEOWNERS, badges, SUPPORT.md, labels | A vulnerability report routes correctly; a release cuts changelog + package + GitHub release automatically. |
| 4 | **Hardened** | + signed commits, SBOM generation, supply chain attestation, compliance docs, ADRs, runbooks, full audit clean | Run the full audit -- zero critical/high findings. |

A weekend CLI gets Tier 1. A team project gets Tier 2. Mature open source gets Tier 3. Only critical/regulated projects need Tier 4. Forcing Tier 4 on a hackathon project is how you get a repo graveyard.

## The reference library

SKILL.md is the entry point -- about 12K tokens. It contains the full workflow, the completion tiers, the have-nots/dos/don'ts, stack detection, and enough depth to handle straightforward projects directly. When a specific layer needs more detail, the agent loads the matching reference file from `references/`.

There are **19 reference files across 4 tiers**. You load 3-5 per project -- never all 19. The table below shows what each file covers, which tier it belongs to, and how many tokens it adds to context.

| File | Tier | ~Tokens | What it covers |
|---|---|---|---|
| `project-profiles.md` | Always | ~16K | 11 project types × 3 stages × audience matrix with stack tool recommendations |
| `repo-audit.md` | Always | ~16K | 39-point health scorecard across 6 categories with automated scan script |
| `repo-structure.md` | Tier 1 | ~14K | Folder conventions and naming for all 16 ecosystems |
| `community-standards.md` | Tier 1 | ~8K | README, LICENSE, CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, CHANGELOG templates |
| `readme-craft.md` | Tier 1 | ~9K | README anatomy, badges, demos, dark mode logos, SEO |
| `quality-tooling.md` | Tier 2 | ~16K | Linters, formatters, git hooks per stack (Biome, Ruff, golangci-lint, clippy, etc.) |
| `ci-cd-workflows.md` | Tier 2 | ~17K | GitHub Actions and GitLab CI templates for all stacks |
| `platform-github.md` | Tier 2 | ~10K | GitHub issue forms, PR templates, dependabot, releases, CODEOWNERS, FUNDING |
| `platform-gitlab.md` | Tier 2 | ~14K | GitLab CI/CD, MR templates, Container/Package Registry, Pages |
| `platform-bitbucket.md` | Tier 2 | ~14K | Bitbucket Pipelines, branch permissions, issue/PR templates, deployment environments |
| `git-workflows.md` | Tier 2 | ~17K | Trunk-based / GitHub Flow / GitFlow, bots, label taxonomy, merge strategies |
| `monorepo-patterns.md` | Tier 3 | ~15K | Nx, Turborepo, pnpm/yarn workspaces, moon, Cargo, Go workspaces; affected-only CI; per-package changelog |
| `security-setup.md` | Tier 3 | ~13K | Dependabot/Renovate, CodeQL, secret scanning, SBOM, signed commits, supply chain, solo-dev enforcement contact |
| `release-distribution.md` | Tier 3 | ~12K | SemVer, Keep a Changelog, semantic-release/release-please/changesets, npm/PyPI/crates.io/Docker publishing |
| `licensing-legal.md` | Tier 3 | ~12K | License selection flowchart, CLAs/DCOs, compliance docs, SPDX |
| `technical-docs.md` | Tier 4 | ~13K | ADRs (MADR 4.0), whitepapers, RFCs, API docs, runbooks, post-mortems, diagrams-as-code |
| `community-governance.md` | Tier 4 | ~11K | GOVERNANCE.md, MAINTAINERS, Discussions, funding, deprecation, contributor recognition |
| `onboarding-dx.md` | On demand | ~15K | Makefile/Justfile/Taskfile, devcontainers, setup scripts, IDE config, AI-agent config files (CLAUDE.md, AGENTS.md, .cursorrules, etc.) |
| `questioning.md` | On demand | ~5K | Adaptive detection when auto-detection of stack/type/stage is insufficient |

"Always" files load in every session. Tier 1 files load for any project. Tier 2 files load for team projects and above. Tier 3/4 load only when the corresponding tier is in scope. "On demand" files load only when the agent hits the specific scenario they cover.

**Common loading patterns.** A few representative sessions so you can see what context cost looks like in practice:

- **MVP / weekend project (Tier 1 only):** `project-profiles.md` + `repo-structure.md` + `community-standards.md` -- roughly 38K tokens.
- **Team project (Tier 2):** `project-profiles.md` + `quality-tooling.md` + `ci-cd-workflows.md` + `platform-github.md` -- roughly 59K tokens.
- **Mature open source (Tier 3):** `project-profiles.md` + `security-setup.md` + `release-distribution.md` -- roughly 41K tokens.
- **Audit mode:** `project-profiles.md` + `repo-audit.md` -- roughly 32K tokens.

Loading all 19 at once would blow past most context windows, which is why the skill is deliberately tiered. The agent only loads what the current tier needs.

## Key principles

Five principles drive every decision the skill makes. If output violates any of them, it's a bug.

- **No placeholders.** Every generated file contains real, tailored content. No unresolved template variables, no task markers in production docs, no fake example.com addresses, no CI scripts that run an echo statement in place of real tests. A file with placeholders is worse than no file -- it signals an unmaintained project.
- **Stage-appropriate, not maximum.** A weekend CLI gets 5 files. Enterprise open source gets 30. The skill matches the project, not the other way around.
- **Stack-aware.** Python projects get Ruff, not ESLint. Go projects get `cmd/`/`internal/`, not `src/`. Rust projects get clippy + rustfmt. Every generated file matches the ecosystem.
- **Platform-aware.** GitHub gets Actions + issue forms + dependabot. GitLab gets GitLab CI + MR templates. Bitbucket gets Pipelines + branch permissions. Platform-neutral layers (Tier 1 community standards, Tier 3 licensing/security docs) transfer across Azure DevOps, Gitea, Forgejo, Codeberg, and SourceHut with no changes.
- **Keep going until a contributor can arrive.** README existing is 20% of the work. The other 80% -- CI, templates, docs, tooling, release automation, security policy -- is what makes a repo actually usable. Budget for all of it.

## Further reading

Everything in Repo Ready is Markdown, so the whole thing is readable without any tooling:

- `SKILL.md` -- the authoritative workflow. This is what the AI agent actually reads.
- `references/` -- 19 deep-dive reference files loaded on demand. Each is a focused treatment of one domain (licensing, security, monorepo tooling, etc.).
- `CHANGELOG.md` -- version history, kept in [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format.
- `README.md` -- the quick-pitch entry point with install instructions and feature tables.

If you're evaluating the skill, start with `SKILL.md` -- it's the fastest way to see the discipline the skill enforces, and it's short enough to read in one sitting. If you're using it, you don't need to read it directly; point your agent at it and ask. The skill is agent-agnostic, so the same setup works whether you run it through Claude Code, Cursor, Cline, Windsurf, or any other Markdown-reading coding agent. There's no vendor lock-in and no runtime coupling -- if a better agent exists tomorrow, the skill still runs.

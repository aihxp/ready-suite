# Repo Ready

[![CI](https://github.com/aihxp/ready-suite/actions/workflows/ci.yml/badge.svg)](https://github.com/aihxp/ready-suite/actions/workflows/ci.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![Latest release](https://img.shields.io/github/v/release/aihxp/repo-ready?label=release)](https://github.com/aihxp/ready-suite/releases) [![AI Skill](https://img.shields.io/badge/AI%20skill-Markdown-blueviolet)](SKILL.md)

An AI skill that sets up production-grade repositories.

Feed it to your AI coding agent. Ask it to set up your repo. It handles everything -- folder structure, documentation, CI/CD, quality tooling, security, releases -- tailored to your stack, your project type, and your stage. No generic templates. No placeholder files. No `{{author}}` left behind.

**Works with any AI coding agent** -- Claude Code, Cursor, Cline, Windsurf, Copilot, [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent), [OpenClaw](https://github.com/openclaw/openclaw), or any harness that parses the [Agent Skills standard](https://agentskills.io).

> **Part of the [ready-suite](SUITE.md)**, a composable set of eleven AI skills covering the full arc from idea to launch (orchestration, planning, building, shipping). Repo Ready is one of the two building-tier skills, alongside [production-ready](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready) (which owns app wiring; Repo Ready owns repo scaffolding). See [`SUITE.md`](SUITE.md) for the full map.

## Quick start

**With any AI coding agent:**
```bash
git clone https://github.com/aihxp/ready-suite.git
# Point your AI agent to SKILL.md and the references/ directory
# Then ask it to set up your repo -- the skill guides the entire process
```

**With Claude Code:**
```bash
# Add as a skill in your Claude Code configuration
# The skill triggers automatically when you ask to set up a repo
```

**With Cursor / Cline / Windsurf:**
```bash
# Add SKILL.md to your rules or instructions
# Load reference files as needed for each layer
```

**As a standalone reference:**
Read `SKILL.md` for the workflow, then load reference files as you configure each layer. Works even without AI -- it's just well-organized Markdown.

## Why this exists

AI-generated repo setups have a specific failure mode: they *look* configured but fall apart the moment someone tries to contribute.

| What you get without Repo Ready | What you get with it |
|---|---|
| `{{author}}` in LICENSE | Correct SPDX text with real year and author |
| README with just the project name | Full README: badges, install, usage, contributing, license |
| `security@example.com` in SECURITY.md | Real reporting process with real contact info |
| CI running `echo "test"` | CI running the project's actual lint, test, and build |
| `.gitignore` missing half the stack | Stack-detected ignores (node_modules, \_\_pycache\_\_, target/, etc.) |
| ESLint config in a Python project | Stack-appropriate tooling (Ruff for Python, not ESLint) |
| 20 empty template files with TODOs | Only the files this project type and stage actually need |
| CONTRIBUTING.md nobody customized | Real workflow matching the project's actual branching strategy |

## How it works

The skill walks your AI agent through a 9-step process. Every step is stack-aware and stage-appropriate:

0. **Detect** -- scans existing files, detects the stack, determines mode (greenfield / enhancement / audit)
1. **Profile** -- identifies project type × stage × audience
2. **Structure** -- sets up folders following your stack's conventions
3. **Document** -- generates README, LICENSE, CONTRIBUTING, SECURITY, CHANGELOG with real content
4. **Platform** -- configures issue templates, PR templates, dependabot, CODEOWNERS
5. **CI/CD** -- creates workflows that run your real linter, tests, and build
6. **Quality** -- configures linter, formatter, git hooks matched to the stack
7. **Security** -- adds dependency scanning, SAST, branch protection
8. **Release** -- sets up changelog automation, version bumps, publishing
9. **Audit** -- runs a 39-point health scorecard to catch what's missing

Each step maps to a **completion tier** -- so the repo is properly set up at every checkpoint:

| Tier | Name | What's configured | When to stop |
|---|---|---|---|
| 1 | **Essentials** | README, LICENSE, .gitignore, .editorconfig, folder structure | Weekend project |
| 2 | **Team Ready** | + CI, quality tooling, CONTRIBUTING, issue/PR templates, changelog | Team project |
| 3 | **Mature** | + SECURITY.md, release automation, scanning, CODEOWNERS, badges | Open source |
| 4 | **Hardened** | + Signed commits, SBOM, compliance docs, ADRs, runbooks | Enterprise |

## 16 stacks. One skill.

Repo Ready knows the conventions, tools, and folder structures for 16 ecosystems:

| Stack | Linter | Formatter | Test | Structure |
|---|---|---|---|---|
| **JavaScript / TypeScript** | Biome or ESLint v9 | Biome or Prettier | Vitest or Jest | src/, dist/ |
| **Python** | Ruff | Ruff | pytest | src/package_name/ |
| **Go** | golangci-lint | gofmt | go test | cmd/, internal/ |
| **Rust** | clippy | rustfmt | cargo test | src/, target/ |
| **Java / Kotlin** | ktlint, detekt | ktlint | JUnit | src/main/java/ |
| **Ruby** | RuboCop | RuboCop | RSpec | lib/, spec/ |
| **C# / .NET** | dotnet format | dotnet format | xUnit | src/, tests/ |
| **Swift** | SwiftLint | SwiftFormat | XCTest | Sources/, Tests/ |
| **PHP** | PHPStan | PHP-CS-Fixer | PHPUnit | app/, tests/ |
| **Elixir** | Credo | mix format | ExUnit | lib/, test/ |
| **C / C++** | clang-tidy | clang-format | CTest | include/, src/ |
| **Dart / Flutter** | dart analyze | dart format | flutter test | lib/, test/ |
| **Zig** | (none -- zig build) | zig fmt | zig build test | src/, zig-out/ |
| **Gleam** | gleam check | gleam format | gleam test | src/, test/ |
| **Deno** | deno lint | deno fmt | deno test | src/, mod.ts |
| **Bun** | Biome | Biome | bun test | src/, dist/ |

## 11 project types

Different projects need different files. A CLI tool needs shell completions; a SaaS needs runbooks; a library needs API docs. The skill knows the difference.

<details>
<summary>View all 11 project types</summary>

| Type | Key files beyond basics |
|---|---|
| **Library / SDK** | API docs, versioned changelog, publishing config, CITATION.cff |
| **CLI tool** | Install methods, shell completions, man pages |
| **Web app (SaaS)** | Runbooks, architecture docs, deploy config, docker-compose |
| **API / Microservice** | OpenAPI spec, API versioning, health checks, Dockerfile |
| **Mobile app** | Platform build configs, store metadata, fastlane |
| **Desktop app** | Installer packaging, auto-update, platform-specific builds |
| **DevOps / IaC** | Module docs, state management, environment configs |
| **Data / ML** | Model cards, dataset docs, notebook conventions, DVC |
| **Monorepo** | Per-package docs, workspace config, shared tooling |
| **Documentation site** | Content structure, build config, deploy pipeline |
| **Framework / Platform** | Extension docs, plugin API, migration guides |

</details>

## Three entry modes

| Mode | When to use | What happens |
|---|---|---|
| **Greenfield** | Starting a new project | Detects stack, asks 1-3 questions, generates everything |
| **Enhancement** | Existing codebase needs polish | Scans what exists, fills gaps, never overwrites your work |
| **Audit** | "How professional is my repo?" | Runs 39-point scorecard, produces a prioritized fix-it list |

## 19 reference files, loaded on demand

You read 3-5 per project, never all 19. Each one is a deep, actionable reference for a specific domain.

<details>
<summary>View the full reference library</summary>

| File | What it covers | ~Tokens |
|---|---|---|
| **Always loaded** | | |
| `project-profiles.md` | Project type × stage × audience matrix | ~16K |
| `repo-audit.md` | 39-point health scorecard with scan script | ~16K |
| **Tier 1** | | |
| `repo-structure.md` | Folder conventions for 16 stacks | ~14K |
| `community-standards.md` | README, LICENSE, CONTRIBUTING templates | ~8K |
| `readme-craft.md` | README anatomy, badges, demos, SEO | ~9K |
| `questioning.md` | Adaptive detection when auto-detect fails | ~5K |
| **Tier 2** | | |
| `quality-tooling.md` | Linters, formatters, hooks per stack | ~16K |
| `ci-cd-workflows.md` | GitHub Actions + GitLab CI templates | ~17K |
| `platform-github.md` | Issue forms, PR templates, dependabot | ~10K |
| `platform-gitlab.md` | CI/CD, MR templates, registry, Pages | ~14K |
| `platform-bitbucket.md` | Pipelines, branch permissions, deployment environments | ~14K |
| `git-workflows.md` | Branching, bots, labels, merge strategies | ~17K |
| **Tier 3** | | |
| `monorepo-patterns.md` | Nx, Turborepo, pnpm/yarn, moon, Cargo, Go workspaces, affected CI | ~15K |
| `security-setup.md` | Scanning, SBOM, supply chain, signed commits | ~13K |
| `release-distribution.md` | SemVer, changelog, publishing automation | ~12K |
| `licensing-legal.md` | License selection, CLAs/DCOs, compliance | ~12K |
| **Tier 4** | | |
| `technical-docs.md` | ADRs, RFCs, runbooks, diagrams-as-code | ~13K |
| `community-governance.md` | Governance, funding, deprecation | ~11K |
| **On demand** | | |
| `onboarding-dx.md` | Makefile/Justfile, devcontainers, IDE config | ~15K |

</details>

## Works with any platform

- **GitHub** -- Actions, issue forms, FUNDING.yml, dependabot, rulesets, Discussions, GHCR
- **GitLab** -- CI/CD, issue/MR templates, Container Registry, Package Registry, Auto DevOps
- **Bitbucket** -- Pipelines, branch permissions, issue/PR templates, deployment environments
- **Platform-agnostic** -- Documentation and quality tooling works everywhere

## Works with any AI agent

Repo Ready is pure Markdown -- no runtime, no dependencies, no API. Any AI agent that can read instructions can use it:

- **Claude Code** -- add as a skill, triggers automatically
- **Cursor** -- add SKILL.md to rules
- **Cline** -- add to .clinerules
- **Windsurf** -- add to .windsurfrules
- **GitHub Copilot** -- add to instructions
- **Any other agent** -- point it at SKILL.md

The instructions are agent-agnostic. The AI reads the workflow, loads the reference files it needs, and generates stack-appropriate output. No vendor lock-in.

## Core principles

**Stage-appropriate, not maximum.** A weekend side project gets 5 files. Enterprise open source gets 30. The skill matches the project, not the other way around.

**No placeholders.** Every generated file contains real content tailored to this project. No `{{author}}`, no `TODO: fill this in`, no `security@example.com`.

**Stack-aware.** A Python project gets Ruff, not ESLint. A Go project gets `cmd/`/`internal/`, not `src/`. Every file matches the ecosystem.

**Keep going until a contributor can arrive.** README existing is 20% of the work. The other 80% -- CI, templates, docs, tooling -- is what makes a repo actually usable. Budget for all of it.

## Documentation

For a 10-minute reader-facing overview of what Repo Ready provides, read [DOCS.md](DOCS.md). For the full workflow and reference library the AI agent actually reads, see [SKILL.md](SKILL.md).

## Contributing

Gaps, missing stacks, outdated tooling recommendations -- contributions welcome. This is a living document.

## License

[MIT](LICENSE)

<!-- GSD:project-start source:PROJECT.md -->
## Project

**Repo Ready**

An AI instruction set (Claude Code skill) that sets up production-grade repository structure, documentation, CI/CD, quality tooling, and platform configuration -- across any stack (Node/Python/Go/Rust/Java/Ruby/Swift/C#/PHP/Elixir/C++/Dart) and any platform (GitHub/GitLab/Bitbucket). The counterpart to production-ready (dashboards): repo-ready handles everything that makes a repository professional before the first feature is built.

**Core Value:** Every generated file must be tailored to the project's stack, type, and stage -- no placeholders, no template variables, no mismatched conventions.

### Constraints

- **Format**: Must be a Claude Code skill (SKILL.md + references/) -- no runtime dependencies
- **Size**: SKILL.md under 40KB; reference files under 80KB each -- context window limits
- **Compatibility**: Must work with Claude Code and be usable with other AI assistants
- **Ecosystem neutrality**: Equal depth for all 12 supported ecosystems
<!-- GSD:project-end -->

<!-- GSD:stack-start source:research/STACK.md -->
## Technology Stack

## Recommended Stack
### Core Framework
| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| Node.js | 20 LTS+ | Runtime | Universal in JS ecosystem, CLI tooling is mature |
| TypeScript | 5.x | Language | Type safety for template schemas, better DX |
| Commander.js | 12.x | CLI framework | De facto standard for Node CLIs, simple API |
### Template Engine
| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| Handlebars | 4.x | Template rendering | Logic-less templates prevent template complexity, partials for reuse |
| gray-matter | 4.x | YAML frontmatter parsing | Standard for parsing/generating frontmatter in markdown files |
### File System & Generation
| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| fs-extra | 11.x | File operations | Copy, ensure dirs, write files with better API than native fs |
| glob | 10.x | File pattern matching | Find existing docs, detect project type |
| Inquirer.js | 9.x | Interactive prompts | Collect project info, select project type, choose doc categories |
### Supporting Libraries
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| chalk | 5.x | Terminal styling | Status messages, warnings about missing docs |
| ora | 7.x | Spinners | During file generation |
| yaml | 2.x | YAML generation | FUNDING.yml, issue template config.yml |
| spdx-license-list | 6.x | License data | LICENSE file generation with correct text |
| cosmiconfig | 9.x | Config loading | .docreadyrc, docready.config.js project config |
| validate-npm-package-name | 5.x | Package validation | Validating project names in templates |
### Development
| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| Vitest | 1.x | Testing | Fast, TypeScript-native, good snapshot testing for template output |
| ESLint | 9.x | Linting | Flat config, TypeScript support |
| tsup | 8.x | Build | Simple bundling for CLI distribution |
| changesets | 2.x | Versioning | Manages changelog and versioning for the tool itself |
## Alternatives Considered
| Category | Recommended | Alternative | Why Not |
|----------|-------------|-------------|---------|
| CLI Framework | Commander.js | yargs, oclif | yargs has messy API; oclif is overkill for single-command CLIs |
| Template Engine | Handlebars | EJS, Liquid, Mustache | EJS allows arbitrary JS (dangerous); Liquid is slower; Mustache lacks partials |
| Prompts | Inquirer.js | prompts, enquirer | Inquirer has largest ecosystem, best maintained |
| Testing | Vitest | Jest | Vitest is faster, native ESM/TS, Jest config is painful |
| Build | tsup | esbuild, rollup | tsup wraps esbuild with sensible defaults for CLIs |
## Installation
# Core
# Dev dependencies
## Sources
- GitHub Community Standards: https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/about-community-profiles-for-public-repositories
- Commander.js: widely adopted Node.js CLI framework
- Handlebars: logic-less templating standard
<!-- GSD:stack-end -->

<!-- GSD:conventions-start source:CONVENTIONS.md -->
## Conventions

Conventions not yet established. Will populate as patterns emerge during development.
<!-- GSD:conventions-end -->

<!-- GSD:architecture-start source:ARCHITECTURE.md -->
## Architecture

Architecture not yet mapped. Follow existing patterns found in the codebase.
<!-- GSD:architecture-end -->

<!-- GSD:skills-start source:skills/ -->
## Project Skills

No project skills found. Add skills to any of: `.claude/skills/`, `.agents/skills/`, `.cursor/skills/`, or `.github/skills/` with a `SKILL.md` index file.
<!-- GSD:skills-end -->

<!-- GSD:workflow-start source:GSD defaults -->
## GSD Workflow Enforcement

Before using Edit, Write, or other file-changing tools, start work through a GSD command so planning artifacts and execution context stay in sync.

Use these entry points:
- `/gsd-quick` for small fixes, doc updates, and ad-hoc tasks
- `/gsd-debug` for investigation and bug fixing
- `/gsd-execute-phase` for planned phase work

Do not make direct repo edits outside a GSD workflow unless the user explicitly asks to bypass it.
<!-- GSD:workflow-end -->



<!-- GSD:profile-start -->
## Developer Profile

> Profile not yet configured. Run `/gsd-profile-user` to generate your developer profile.
> This section is managed by `generate-claude-profile` -- do not edit manually.
<!-- GSD:profile-end -->

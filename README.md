# The Ready Suite

> Eleven composable AI skills covering the full arc from idea to launch. Implements the [Agent Skills standard](https://agentskills.io). Plug them into Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw, or any harness that parses `SKILL.md` frontmatter natively. Each skill stands alone. They compose by reading and writing well-known artifact paths, never by calling each other.

This is the discovery hub. Every skill lives in its own repo with its own SKILL.md, references library, and CHANGELOG. The byte-identical [`SUITE.md`](SUITE.md) ships in every sibling repo so the suite map is visible from any entry point.

## The eleven skills, four tiers

```
ORCHESTRATION TIER       PLANNING TIER             BUILDING TIER         SHIPPING TIER
------------------       ------------------        ----------------      ------------------
kickoff-ready  ->        prd-ready           ->    repo-ready      ->    deploy-ready
                         architecture-ready  ->    production-ready ->   observe-ready
                         roadmap-ready       ->                          launch-ready
                         stack-ready         ->                          harden-ready
```

## What each skill owns

| Skill | Tier | One-line purpose | Version | Repo |
|---|---|---|---|---|
| **kickoff-ready** | Orchestration | Sequence the ten specialists for a greenfield project from raw user intent. | 1.1.1 | [github.com/aihxp/kickoff-ready](https://github.com/aihxp/kickoff-ready) |
| **prd-ready** | Planning | Define what we're building and for whom. | 1.0.9 | [github.com/aihxp/prd-ready](https://github.com/aihxp/prd-ready) |
| **architecture-ready** | Planning | Design how the big pieces fit together. | 1.0.8 | [github.com/aihxp/architecture-ready](https://github.com/aihxp/architecture-ready) |
| **roadmap-ready** | Planning | Sequence work over time. | 1.0.7 | [github.com/aihxp/roadmap-ready](https://github.com/aihxp/roadmap-ready) |
| **stack-ready** | Planning | Pick the right tools for the job. | 1.1.14 | [github.com/aihxp/stack-ready](https://github.com/aihxp/stack-ready) |
| **repo-ready** | Building | Set up the repo with production-grade hygiene. | 1.6.11 | [github.com/aihxp/repo-ready](https://github.com/aihxp/repo-ready) |
| **production-ready** | Building | Build the app to production grade. | 2.6.0 | [github.com/aihxp/production-ready](https://github.com/aihxp/production-ready) |
| **deploy-ready** | Shipping | Ship the app to real environments. | 1.0.13 | [github.com/aihxp/deploy-ready](https://github.com/aihxp/deploy-ready) |
| **observe-ready** | Shipping | Keep the app healthy once it's live. | 1.0.12 | [github.com/aihxp/observe-ready](https://github.com/aihxp/observe-ready) |
| **launch-ready** | Shipping | Tell the world the product exists. | 1.0.10 | [github.com/aihxp/launch-ready](https://github.com/aihxp/launch-ready) |
| **harden-ready** | Shipping | Survive adversarial attention; prove it to an auditor. | 1.0.6 | [github.com/aihxp/harden-ready](https://github.com/aihxp/harden-ready) |

## Why eleven skills, not one

Generic AI coding assistants do everything badly. The ready-suite splits the work into eleven skills with tight scope and distinct trigger surfaces, so the harness can route precisely and each skill can refuse work that belongs to a sibling.

A skill at this scope can be opinionated. It can carry concrete have-nots, named failure modes, and acceptance gates per step. It can ship references with worked examples and per-domain considerations. It can stay current without bloating, because each release only touches one tier of the lifecycle.

A single mega-skill cannot do any of these things at the same time without becoming the "god skill" the suite exists to prevent.

## Standards compliance

Ready-suite skills implement the [Agent Skills standard](https://agentskills.io). The contract is plain: a `SKILL.md` with YAML frontmatter and an optional `references/` directory the harness loads on demand. Any harness that parses this format runs every skill first-class. Verified harnesses today: Claude Code, Codex, Cursor, Windsurf, [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent), [OpenClaw](https://github.com/openclaw/openclaw). pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support with no per-tool integration work.

The suite also meets the [`AGENTS.md`](https://agents.md/) cross-tool agent-brief standard (governed by the Linux Foundation's Agentic AI Foundation), the project-root brief read natively by Codex CLI, GitHub Copilot, Cursor, Windsurf, Aider, Zed, Warp, Roo Code, Jules, Factory, Amp, Devin, and others. **kickoff-ready** emits a project-root `AGENTS.md` mapping the suite's artifact paths when none exists (Step 6 sub-step 6a); **repo-ready** scaffolds `AGENTS.md` as the canonical agent brief with `CLAUDE.md` as a thin overlay or symlink. Both respect any user-authored `AGENTS.md` already on disk.

The suite consumes the [Google Labs `DESIGN.md`](https://github.com/google-labs-code/design.md) format (Apache 2.0; YAML frontmatter holds machine-readable design tokens, the markdown body holds rationale plus an Agent Prompt Guide). **production-ready** detects a project-root `DESIGN.md` in Step 3 sub-step 3a and consumes it via DTCG export, Tailwind v4 export, or direct YAML read; the linter (`npx @google/design.md lint`) runs before component code so WCAG and token-resolution failures block the slice deterministically. When no `DESIGN.md` is present, production-ready falls back to its archetype + 5-decision derivation and optionally scaffolds a `DESIGN.md` from the chosen tokens.

## Claude Code plugin install

Inside Claude Code:

```text
/plugin marketplace add aihxp/ready-suite
/plugin install ready-suite@ready-suite
```

This adds the suite's marketplace and installs the `ready-suite` meta plugin, which depends on every specialist (`prd-ready`, `architecture-ready`, ..., `harden-ready`). One install command, eleven skills.

Want only one skill? Install it directly:

```text
/plugin install prd-ready@ready-suite
```

The marketplace lives in this hub repo at [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json). Each plugin is vendored under [`plugins/<skill-name>/`](plugins/) with its own manifest. See [`references/PLUGIN-RESEARCH.md`](references/PLUGIN-RESEARCH.md) for the format research that shaped these decisions.

Plugin maintainers refresh the vendored copies via:

```bash
bash scripts/refresh-plugin-skills.sh
```

This re-reads version + description from each sibling's `SKILL.md` frontmatter, re-vendors `SKILL.md` + `references/` from `~/Projects/<skill>/`, and rewrites the manifests. Run it whenever a sibling cuts a release, then commit and tag `plugin-v<x.y.z>`.

## One-command install (Codex, Cursor, pi, OpenClaw, all platforms)

Installs every skill into every detected harness (Claude Code, Codex, Cursor, plus the neutral Agent Skills path read by pi and OpenClaw) with a single shell command. Idempotent. Re-run anytime.

```bash
curl -sSL https://raw.githubusercontent.com/aihxp/ready-suite/main/install.sh | bash
```

Or, if you prefer to read the script first:

```bash
git clone https://github.com/aihxp/ready-suite.git
bash ready-suite/install.sh
```

What it does:

1. Detects which harnesses you have (`~/.claude`, `~/.codex`, `~/.cursor`, `~/.pi`, `~/.openclaw`). Skips ones that aren't installed.
2. When pi or OpenClaw is detected, also writes to the neutral `~/.agents/skills/` path defined by the [Agent Skills standard](https://agentskills.io). Both harnesses read this path natively, and any future AgentSkills-compatible harness inherits support for free.
3. For each of the eleven skills, ensures a dev copy at `~/Projects/<skill>/`. Clones from `aihxp/<skill>` if missing; reuses the existing copy if it's a clean git working tree.
4. Symlinks `SKILL.md` and `references/` from the dev copy into every detected harness's skills directory.
5. Existing non-symlink installs are backed up to `<target>.backup-<timestamp>/` first.

Edit a file in `~/Projects/<skill>/` and the change is live in every harness immediately. No re-install needed.

Verbose mode shows every step:

```bash
bash install.sh -v
```

## Per-skill install (manual)

If you want only one skill or prefer not to clone all eleven:

```bash
# Claude Code
git clone https://github.com/aihxp/<skill-name>.git ~/.claude/skills/<skill-name>

# Codex
git clone https://github.com/aihxp/<skill-name>.git ~/.codex/skills/<skill-name>

# Cursor
git clone https://github.com/aihxp/<skill-name>.git ~/.cursor/skills/<skill-name>

# pi, OpenClaw, or any Agent Skills-compatible harness (neutral path)
git clone https://github.com/aihxp/<skill-name>.git ~/.agents/skills/<skill-name>
```

**Windsurf or other agents:** point your project rules or system prompt at the skill's `SKILL.md` and load reference files as needed.

**Symlink trick.** If you keep dev copies under `~/Projects/<skill-name>/`, symlink each platform's skills directory at the dev copy. Updates in the dev copy propagate instantly to every harness without re-installing. (`install.sh` does this for you.)

## Uninstall

Removes the suite's symlinks from every detected harness. Leaves dev copies in `~/Projects/` and any `.backup-*/` directories untouched.

```bash
bash uninstall.sh
```

## Composition

Skills do not call each other. The harness is the router.

- **Plain harnesses** (Claude Code, Codex, Cursor, Windsurf): the harness's skill router invokes whichever skill matches the user's words.
- **Orchestrators** (GSD, BMAD, Superpowers, custom): see [`ORCHESTRATORS.md`](ORCHESTRATORS.md) for command-by-command integration patterns. The orchestrator knows about the suite; the suite stays orchestrator-agnostic.
- **Artifacts** are the contract. Every skill produces files at `.{skill}-ready/*.md` paths. Downstream skills read them. Skills compose without invoking each other.

## Composition principles

1. Tight scope beats combined scope. Splitting is the first move when scope drifts.
2. The harness is the router. No skill calls another.
3. Artifacts are the contract. Skills compose by file paths, not function calls.
4. Version tracking is mandatory. Every skill carries `version`, `updated`, `suite`, `tier`, `upstream`, and `downstream` in frontmatter.
5. No skill duplicates another. If work overlaps, one skill owns the canonical content and siblings reference it.
6. Graceful degradation. Every skill works standalone. Upstream absence is handled with sensible defaults, not errors.
7. Byte-identical SUITE.md across siblings. When any sibling releases, every sibling's SUITE.md row bumps. The known-good-versions table is authoritative from any entry point.

## Versions

The [SUITE.md](SUITE.md) known-good-versions table is byte-identical across every sibling. To find the latest of any skill, check the table here or in any sibling repo: they always agree.

When a sibling releases, every sibling's SUITE.md is updated in a coordinated patch pass. Tag-release parity is enforced (every git tag has a matching GitHub Release).

## License

MIT. Each skill repo carries its own LICENSE file with the same terms.

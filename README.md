# The Ready Suite

> Ten composable AI skills covering the full arc from idea to launch. Plug them into Claude Code, Codex, Cursor, Windsurf, or any harness that loads markdown skills. Each skill stands alone. They compose by reading and writing well-known artifact paths, never by calling each other.

This is the discovery hub. Every skill lives in its own repo with its own SKILL.md, references library, and CHANGELOG. The byte-identical [`SUITE.md`](SUITE.md) ships in every sibling repo so the suite map is visible from any entry point.

## The ten skills, three tiers

```
PLANNING TIER                     BUILDING TIER                  SHIPPING TIER
------------------------          -----------------              ------------------
prd-ready           ->            repo-ready          ->         deploy-ready
architecture-ready  ->            production-ready    ->         observe-ready
roadmap-ready       ->                                ->         launch-ready
stack-ready         ->                                ->         harden-ready
```

## What each skill owns

| Skill | Tier | One-line purpose | Version | Repo |
|---|---|---|---|---|
| **prd-ready** | Planning | Define what we're building and for whom. | 1.0.5 | [github.com/aihxp/prd-ready](https://github.com/aihxp/prd-ready) |
| **architecture-ready** | Planning | Design how the big pieces fit together. | 1.0.4 | [github.com/aihxp/architecture-ready](https://github.com/aihxp/architecture-ready) |
| **roadmap-ready** | Planning | Sequence work over time. | 1.0.3 | [github.com/aihxp/roadmap-ready](https://github.com/aihxp/roadmap-ready) |
| **stack-ready** | Planning | Pick the right tools for the job. | 1.1.10 | [github.com/aihxp/stack-ready](https://github.com/aihxp/stack-ready) |
| **repo-ready** | Building | Set up the repo with production-grade hygiene. | 1.6.7 | [github.com/aihxp/repo-ready](https://github.com/aihxp/repo-ready) |
| **production-ready** | Building | Build the app to production grade. | 2.5.12 | [github.com/aihxp/production-ready](https://github.com/aihxp/production-ready) |
| **deploy-ready** | Shipping | Ship the app to real environments. | 1.0.9 | [github.com/aihxp/deploy-ready](https://github.com/aihxp/deploy-ready) |
| **observe-ready** | Shipping | Keep the app healthy once it's live. | 1.0.8 | [github.com/aihxp/observe-ready](https://github.com/aihxp/observe-ready) |
| **launch-ready** | Shipping | Tell the world the product exists. | 1.0.6 | [github.com/aihxp/launch-ready](https://github.com/aihxp/launch-ready) |
| **harden-ready** | Shipping | Survive adversarial attention; prove it to an auditor. | 1.0.2 | [github.com/aihxp/harden-ready](https://github.com/aihxp/harden-ready) |

## Why ten skills, not one

Generic AI coding assistants do everything badly. The ready-suite splits the work into ten skills with tight scope and distinct trigger surfaces, so the harness can route precisely and each skill can refuse work that belongs to a sibling.

A skill at this scope can be opinionated. It can carry concrete have-nots, named failure modes, and acceptance gates per step. It can ship references with worked examples and per-domain considerations. It can stay current without bloating, because each release only touches one tier of the lifecycle.

A single mega-skill cannot do any of these things at the same time without becoming the "god skill" the suite exists to prevent.

## Install

Same on every platform. Install only the skills you actually use.

**Claude Code:**
```bash
git clone https://github.com/aihxp/<skill-name>.git ~/.claude/skills/<skill-name>
```

**Codex:**
```bash
git clone https://github.com/aihxp/<skill-name>.git ~/.codex/skills/<skill-name>
```

**Cursor:**
```bash
git clone https://github.com/aihxp/<skill-name>.git ~/.cursor/skills/<skill-name>
```

**Windsurf or other agents:** point your project rules or system prompt at the skill's `SKILL.md` and load reference files as needed.

**Symlink trick.** If you keep dev copies under `~/Projects/<skill-name>/`, symlink each platform's skills directory at the dev copy. Updates in the dev copy propagate instantly to every harness without re-installing.

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

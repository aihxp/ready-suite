# Claude Code plugin format: research and decisions

This document captures the research that shaped the ready-suite Claude Code plugin and marketplace. Future maintainers should re-verify findings against the current docs before any breaking change. The plugin format has evolved before and may evolve again.

Research date: 2026-05-06.

## Sources

Primary docs (Anthropic):

- Create plugins: https://code.claude.com/docs/en/plugins.md
- Plugins reference: https://code.claude.com/docs/en/plugins-reference.md
- Discover and install plugins: https://code.claude.com/docs/en/discover-plugins.md
- Create and distribute a marketplace: https://code.claude.com/docs/en/plugin-marketplaces.md
- Plugin dependency constraints: https://code.claude.com/docs/en/plugin-dependencies.md

Demo marketplace (Anthropic): https://github.com/anthropics/claude-code/tree/main/plugins

## What a Claude Code plugin is

A plugin is a directory bundling any combination of:

- Skills (`skills/<skill-name>/SKILL.md` plus references)
- Subagents (`agents/`)
- Hooks (`hooks/hooks.json`)
- Slash commands (`commands/`)
- MCP servers (`.mcp.json`)
- LSP servers (`.lsp.json`)
- Background monitors (`monitors/monitors.json`)
- Custom executables (`bin/`, added to PATH)
- Default settings (`settings.json`)

Discovery is automatic. Files placed at the conventional paths are loaded when the plugin is installed; no explicit declaration is needed beyond the manifest.

## Manifest

A plugin must contain `.claude-plugin/plugin.json` at its root. Format is JSON only.

Required fields:

- `name`: kebab-case identifier; doubles as the plugin's namespace.
- `description`: shown in the plugin manager UI.

Recommended fields:

- `version`: semver. If omitted, the harness uses the git SHA of the source as the version. Pinning a version is required for cache-friendly updates: pushing new commits with the same `version` does not invalidate the user's cached copy.
- `author`: object with `name` and optional `email`.
- `homepage`, `repository`, `license`, `keywords`: metadata.
- `dependencies`: array of plugin names or `{ "name": "...", "version": "..." }` objects. Resolved within the same marketplace.

## Marketplace

A marketplace is a repo containing `.claude-plugin/marketplace.json` at root that lists one or more plugins. The schema is documented at https://code.claude.com/docs/en/plugin-marketplaces.md. Minimal example:

```json
{
  "name": "ready-suite",
  "description": "AI skills covering the full arc from idea to launch.",
  "owner": { "name": "aihxp" },
  "plugins": [
    {
      "name": "prd-ready",
      "source": "./plugins/prd-ready",
      "description": "Define what we're building and for whom."
    }
  ]
}
```

The `source` field accepts a relative path (recommended for self-hosted plugins), a GitHub repo, a git URL with subdirectory, or an npm package name.

A single marketplace repo can host any number of plugins. This is the idiomatic pattern when shipping a related family of skills.

## Install flow (user side)

```text
/plugin marketplace add aihxp/ready-suite
/plugin install ready-suite@ready-suite
```

The first line registers the marketplace. The second installs the named plugin from that marketplace. Granular installs also work: `/plugin install prd-ready@ready-suite`.

Three install scopes:

- User scope (default): the current user, all projects.
- Project scope: written into `.claude/settings.json`, applied to all collaborators.
- Local scope: this repository for this user only.

## Versioning

- Plugins are versioned via semver in `plugin.json`.
- Tag convention: `<plugin-name>--v<version>` (e.g. `ready-suite--v1.0.0`).
- The CLI helper `claude plugin tag --push` exists.
- A plugin's `dependencies` can pin or range-match versions. Supports caret, tilde, hyphen, and comparator ranges (npm-semver compatible).

## Decisions for the ready-suite

### Where the marketplace lives

The marketplace lives in the existing hub repo (`github.com/aihxp/ready-suite`). The hub already serves as the discovery surface; making it the marketplace surface preserves a single entry point.

### Plugin shape: meta + specialists

The marketplace exposes twelve plugins:

1. Eleven specialist plugins: one per skill (`kickoff-ready`, `prd-ready`, ..., `harden-ready`). Each contains exactly that skill at `skills/<skill>/SKILL.md` plus its references. This keeps each skill installable on its own and preserves the un-prefixed skill name (so the harness routes triggers as users expect).

2. One meta plugin (`ready-suite`) with no skills of its own and a `dependencies` array listing all eleven specialists. Installing it pulls in the whole suite in one operation.

Why both: granular consumers can install one skill; the user who wants the whole suite gets a single install command. A single mega-plugin bundling all eleven skills inside `skills/` was rejected because it would namespace the skill ids under the plugin name and obscure how the eleven scopes compose.

### Vendoring, not symlinks or submodules

Each plugin directory contains a vendored copy of the skill's `SKILL.md` and `references/`. Updates land via a refresh that copies from the canonical content under `skills/<skill>/` into `plugins/<skill>/skills/<skill>/`. Submodules add cognitive load for users; symlinks are non-portable across marketplace consumers (they install the plugin, not the in-tree copies).

### Versioning cadence

Each specialist plugin's `version` matches the upstream skill's current SUITE.md version. The meta plugin starts at 1.0.0 and bumps independently when the bundle composition changes.

Tag-Release parity is preserved across the suite: each plugin release gets a matching tag (`<plugin-name>--v<version>`) plus a GitHub Release with the body lifted from the plugin's CHANGELOG (or the relevant section of the suite changelog).

The plugin lives outside the sibling-version sync graph that the eleven skill repos share. A skill release does not auto-bump the plugin; the plugin is refreshed and re-tagged on its own cadence (typically: every time a sibling cuts a release, run the refresh script and ship a plugin patch).

## Limitations and gotchas

- No documented size limit, but plugins are copied to `~/.claude/plugins/cache/<marketplace>/<plugin>/<version>/` on install. Keep it lean.
- Plugins cannot reference files outside their own directory. Vendoring is the only portable option.
- Setting `version` pins. Forgetting to bump it after a refresh means cached users will not see the update. The refresh script must bump the manifest version on every release.
- The marketplace lives in a regular GitHub repo. Public access is required for discovery via `/plugin marketplace add <owner>/<repo>`.

## Open questions

- Whether the dependency resolver respects semver ranges across marketplaces or only within the same marketplace. The docs imply same-marketplace; cross-marketplace resolution is not documented.
- Whether deleting a plugin from the marketplace removes it from existing installs. Likely no; users keep the cached copy until they explicitly uninstall.
- Whether the harness reports a clear error when a meta-plugin's dependency is missing from the marketplace, or whether it installs partially.

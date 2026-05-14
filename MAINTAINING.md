# Maintaining the ready-suite

Procedural guide for the maintainer of the ready-suite monorepo. Documents the rituals, version-bump rules, and release discipline that keep the eleven skills coherent inside one repo.

If you are reading this because you are about to land your first patch, read it twice. The discipline is small and learnable; the failure modes (drifted SUITE.md, em-dash in a public file, version frontmatter that disagrees with CHANGELOG) are recoverable but embarrassing. The lint catches every named failure mode in CI.

For the contributor-facing version of these conventions, see [`CONTRIBUTING.md`](CONTRIBUTING.md).

**Pattern source.** The discipline below is the ready-suite-specific instance of the canonical multi-repo-suite layout pattern, documented generically in [`skills/repo-ready/references/multi-repo-suite-layout.md`](skills/repo-ready/references/multi-repo-suite-layout.md) (loaded as `Mode D` of repo-ready). The hub-vs-specialist split, byte-identical collection-map invariant, coordinated version-table discipline, and the rituals all originated there. The ready-suite started as eleven separate repos plus a hub; in 2026-05 it consolidated to a monorepo (this repo) with `skills/<skill>/` subdirectories. The Mode D reference still describes both the multi-repo and monorepo variants of the pattern.

**Family relationship.** ready-suite is the modular parent. [`arc-ready`](https://github.com/aihxp/arc-ready) is the child born from ready-suite, carrying the same artifact paths, named failure modes, and tests into a single-skill distribution. [`Pillars`](https://github.com/aihxp/pillars) is the companion project-context standard: its `agents/*.md` files give ready-suite and arc-ready durable memory about project facts, decisions, constraints, and gaps.

## Layout

```
ready-suite/                     # the monorepo (this directory)
  README.md                      # discovery hub
  SUITE.md                       # canonical map; byte-identical with skills/<skill>/SUITE.md
  VERSION                        # release-train version shared by every skill and meta plugin
  CHANGELOG.md                   # hub-level curated narrative (dated, not versioned)
  CONTRIBUTING.md                # contributor guide
  AGENTS.md                      # project instructions for coding agents
  SECURITY.md                    # hub-level vulnerability reporting policy
  MAINTAINING.md                 # this file
  ORCHESTRATORS.md               # GSD/BMAD/Spec Kit/Superpowers integration patterns
  install.sh, uninstall.sh       # multi-harness installers
  scripts/lint.sh                # 7-check meta-linter
  scripts/bump-suite-version.sh  # coordinated release-train bump helper
  .editorconfig, .gitattributes  # root editor and line-ending defaults
  .github/workflows/lint.yml     # CI
  references/                    # hub-level references (TRIGGER-DISAMBIGUATION, etc.)
  plugins/                       # Claude Code plugin marketplace vendor copies
  skills/
    <skill-name>/
      SKILL.md                   # frontmatter + body (the canonical content)
      CHANGELOG.md               # per-skill version history
      SUITE.md                   # byte-identical with hub SUITE.md
      README.md                  # skill landing page
      LICENSE
      SECURITY.md
      CONTRIBUTING.md
      .github/CODEOWNERS
      references/                # skill-specific deep dives
```

Every `skills/<skill>/` carries the same baseline files. `production-ready/` additionally carries `ORCHESTRATORS.md` (mirror of the hub's). `repo-ready/` carries the most tooling (CODE_OF_CONDUCT, DOCS, Makefile, .editorconfig, .pre-commit-config, gitleaks config, etc.) because it is the canonical example of its own work.

## The four rituals

### Ritual 1: single-skill patch

When to use: a change confined to one skill's `SKILL.md`, `references/`, or `README.md` that does not touch SUITE.md, `compatible_with`, or any cross-skill surface.

Steps:

1. Make the change inside `skills/<skill>/`.
2. Bump frontmatter `version` and `updated` in `skills/<skill>/SKILL.md`.
3. Prepend a CHANGELOG entry to `skills/<skill>/CHANGELOG.md`:
   ```
   ## v<new> (<YYYY-MM-DD>)

   <one-paragraph problem-and-fix>

   ### Added / Changed / Removed
   - bullet

   ### Why a patch, not a minor (or vice versa)
   <one-paragraph rationale>

   ---
   ```
4. Run the lint:
   ```bash
   bash scripts/lint.sh --verbose
   ```
5. Commit and push:
   ```bash
   git add skills/<skill>/
   git commit -m "<skill> v<new>: <imperative summary>"
   git push origin HEAD
   ```

That is the whole ritual in the monorepo. No per-skill tag, no separate GitHub Release. The version still lives in frontmatter and CHANGELOG so consumers and the lint can see it; the git history is the audit trail.

### Ritual 2: coordinated cross-suite patch

When to use: a SUITE.md change, a new compatibility row, a new specialist behavior worth naming in the suite map, a `compatible_with` frontmatter change, a new `EXAMPLE-*.md` cross-reference, a new ORCHESTRATORS.md pattern.

Steps:

1. Edit hub-level files first: `SUITE.md`, `ORCHESTRATORS.md` (if applicable), `install.sh` (if applicable).
2. Sync SUITE.md to every skill subdir:
   ```bash
   for skill in kickoff-ready prd-ready architecture-ready roadmap-ready stack-ready repo-ready production-ready deploy-ready observe-ready launch-ready harden-ready; do
     cp SUITE.md skills/$skill/SUITE.md
   done
   ```
3. Bump the affected skills' versions and CHANGELOGs. Skills with real behavior changes get a minor bump; skills that are SUITE.md-sync-only get a patch bump.
4. Update the version table in `SUITE.md` (and re-sync to every skill subdir).
5. Run the lint:
   ```bash
   bash scripts/lint.sh --verbose
   ```
6. One commit, one push.

### Ritual 3: suite release train

When to use: a coordinated release where every skill and plugin package should publish the same version, such as 3.0.0.

Steps:

1. Run the strict lint before changing versions:
   ```bash
   bash scripts/lint.sh --strict-triggers --verbose
   ```
2. Run the bump script:
   ```bash
   bash scripts/bump-suite-version.sh <x.y.z> <YYYY-MM-DD>
   ```
3. Review [`RELEASE-CHECKLIST.md`](RELEASE-CHECKLIST.md).
4. Run the release verification commands from the checklist.
5. Commit all intended release files together and tag the monorepo `v<x.y.z>`.

### Ritual 4: lint regression recovery

When to use: CI flags a check failure (suite-md-sync drift, frontmatter-vs-changelog mismatch, em-dash in a tracked file, missing compatible_with value, new trigger overlap).

Steps:

1. Reproduce locally:
   ```bash
   bash scripts/lint.sh --fail-fast
   ```
2. Fix the specific failure named in the output.
3. If the lint itself is wrong (false positive), update the lint, not the data; commit the lint change in the same commit that fixes the trigger.
4. If a new trigger overlap is real, add a row to [`references/TRIGGER-DISAMBIGUATION.md`](references/TRIGGER-DISAMBIGUATION.md). Pass `--strict-triggers` in CI only when the table is exhaustive.

## Version-bump rules

Each skill's version follows semver. Since the 3.0.0 release train, the root `VERSION` file, every skill, the ready-suite meta plugin, and marketplace metadata move together.

- **Patch** (`x.y.Z`): bug fix, documentation tweak, SUITE.md sync, reference rewording, no behavioral or trigger change.
- **Minor** (`x.Y.0`): new step, new refusal, new reference deep dive, new `compatible_with` value, new artifact field, expanded trigger surface that does not break consumers.
- **Major** (`X.0.0`): renamed artifact, removed step, breaking trigger change, dropped `compatible_with` value.

The hub's CHANGELOG.md remains a dated narrative. The release-train version lives in root `VERSION` and is enforced by lint.

## Discipline rules the lint enforces

The seven mechanical checks in `scripts/lint.sh`:

1. **suite-md-sync**: hub `SUITE.md` is byte-identical with every `skills/<skill>/SUITE.md`. CI fails on drift.
2. **frontmatter-version**: every skill's `SKILL.md` `version:` value matches the top entry in its `CHANGELOG.md`. CI fails on mismatch.
3. **suite-release**: root `VERSION` matches every skill frontmatter version, every skill top changelog entry, the ready-suite meta plugin, and marketplace metadata. CI fails on mismatch.
4. **unicode-clean**: no em-dashes, en-dashes, arrows, or box-drawing characters in `SUITE.md` (any copy), hub policy docs (`README.md`, `MAINTAINING.md`, `CONTRIBUTING.md`, `AGENTS.md`, `SECURITY.md`), `RELEASE-CHECKLIST.md`, hub scripts, hub `install.sh` / `uninstall.sh` / `ORCHESTRATORS.md`, or any skill's top CHANGELOG entry. CI fails on any forbidden codepoint.
5. **compatible-with**: every `SKILL.md` declares `claude-code`, `codex`, `cursor`, `windsurf`, `pi`, `openclaw`, `any-agentskills-compatible-harness` under `compatible_with:`. CI fails on missing values.
6. **plugin-sync**: every specialist plugin manifest version matches `skills/<skill>/SKILL.md`, manifest URLs point at the monorepo skill path, vendored plugin skill files match canonical skill files, and the ready-suite meta plugin plus marketplace list every specialist. CI fails on drift.
7. **trigger-overlap**: cross-skill substring overlaps in description trigger phrases are flagged advisory. Each new overlap should either get a row in `references/TRIGGER-DISAMBIGUATION.md` or a tightened trigger phrase.

The lint is bash-3.2-compatible (macOS default), uses no associative arrays, and runs in under a second locally.

## Discipline rules the lint cannot enforce

- **Cross-skill artifact-path agreement**: every skill claims to read or write a `.<skill-name>/` artifact. If two skills disagree on a filename inside that path, the lint will not catch it. ORCHESTRATORS.md and the EXAMPLE-*.md worked examples are the cross-references.
- **Reference link validity**: links between skill SKILL.md files use full GitHub URLs (`https://github.com/aihxp/ready-suite/tree/main/skills/<skill>`). If a skill is renamed or removed, these links 404. No automated check yet.

When you encounter a recurring failure mode the lint cannot catch, add a check to `scripts/lint.sh`. The lint is canonical: discipline gets enforced mechanically or it does not get enforced.

## History

Pre-2026-05 the suite shipped as eleven separate repos under `aihxp/<skill>-ready` plus this hub. Each skill carried its own tags, GitHub Releases, and CHANGELOG. Coordinated patches required a five-step ritual across twelve repos with `gh release create` per skill. The discipline scaled to v1.x, but the cost-per-patch was high.

In 2026-05 the eleven skills consolidated into `skills/<skill>/` subdirectories of this hub. The eleven standalone repos were deleted. The five-ritual workflow collapsed to three. Tag-release parity is moot in the monorepo and was dropped from the lint. The byte-identical SUITE.md invariant remains, now between the hub root and each `skills/<skill>/`.

The earlier v2.5.12 precedent ("specialists patch SUITE.md only when their own bump warrants it") is also retired. In the monorepo every SUITE.md change syncs in the same commit; there is no scenario where SUITE.md drift is acceptable.

The full evolution of the discipline is in `git log`. The Mode D reference in `skills/repo-ready/references/multi-repo-suite-layout.md` documents both the multi-repo and monorepo variants for anyone scaffolding a similar collection.

# Maintaining the ready-suite

Procedural guide for the maintainer of the ready-suite. Documents the rituals, version-bump rules, and release discipline that keep the twelve repos coherent.

If you are reading this because you are about to land your first coordinated patch, read it twice and pair with the existing maintainer the first time. The discipline is small and learnable; the failure modes (missing tag, drifted SUITE.md, em-dash in a public file) are recoverable but embarrassing.

For the contributor-facing version of these conventions, see [`CONTRIBUTING.md`](CONTRIBUTING.md).

## The twelve repos

| Repo | Role | Version-tracked |
|---|---|---|
| [`ready-suite`](https://github.com/aihxp/ready-suite) | Hub: discovery, install scripts, lint, plugin marketplace, ORCHESTRATORS.md, TRIGGER-DISAMBIGUATION.md | No (hub does not have a version of its own) |
| `kickoff-ready` | Orchestration tier (the meta-skill) | Yes |
| `prd-ready`, `architecture-ready`, `roadmap-ready`, `stack-ready` | Planning tier | Yes |
| `repo-ready`, `production-ready` | Building tier | Yes |
| `deploy-ready`, `observe-ready`, `launch-ready`, `harden-ready` | Shipping tier | Yes |

Every skill repo carries: `SKILL.md` (with frontmatter), `CHANGELOG.md`, `SUITE.md` (byte-identical across all 12), `README.md`, `LICENSE`, optional `references/`. `production-ready` additionally carries `ORCHESTRATORS.md` (mirror of the hub's). The hub additionally carries `install.sh`, `uninstall.sh`, `scripts/lint.sh`, `.github/workflows/lint.yml`, the plugin marketplace, and the maintainer-facing docs.

## The five rituals

### Ritual 1: single-skill patch

The smallest coordinated change. One skill repo, no other repos affected.

When to use: a change confined to one skill's `SKILL.md`, `references/`, or `README.md` that does not touch SUITE.md, `compatible_with`, or any cross-cutting surface.

Steps:

```bash
cd ~/Projects/<skill>
# 1. Make the change.
# 2. Bump frontmatter version and updated date in SKILL.md.
# 3. Prepend a CHANGELOG entry. The pattern:
#       ## v<new> (<YYYY-MM-DD>)
#       <one-paragraph problem-and-fix>
#       ### Added / Changed / Removed
#       - bullet
#       ### Why a patch, not a minor (or vice versa)
#       <one-paragraph rationale>
#       ---
# 4. Run the lint from the hub:
bash ~/Projects/ready-suite/scripts/lint.sh
# 5. Commit, push, tag, release:
git add SKILL.md CHANGELOG.md references/  # whatever you touched
git commit -m "v<new>: <imperative summary>"
git push origin HEAD
git tag v<new>
git push origin v<new>
gh release create v<new> --title v<new> --notes "$(awk -v v='## v<new> ' '$0 ~ "^"v {f=1; next} f && /^---$/ {exit} f' CHANGELOG.md)"
```

Verify: `gh release view v<new>` shows the body lifted from the CHANGELOG.

### Ritual 2: coordinated cross-suite patch

The standard ritual. SUITE.md changes; all 12 repos sync.

When to use: a new compatibility row in SUITE.md, a new specialist behavior worth naming in the suite map, a `compatible_with` frontmatter change, a new `EXAMPLE-*.md` reference that cross-references siblings, a new ORCHESTRATORS.md pattern.

Bumps follow the suite versioning rule: skills with real behavior changes get a minor bump; skills that are SUITE.md-sync-only get a patch bump.

Steps (the canonical order):

1. **Discuss first** if the change affects scope or trigger surface. Open a hub issue. Confirm the bump shape.

2. **Make the changes in the hub** first. SUITE.md edits, ORCHESTRATORS.md edits if applicable, install.sh edits if applicable.

3. **Sync SUITE.md to every sibling**:
   ```bash
   cd ~/Projects/ready-suite
   for skill in kickoff-ready prd-ready architecture-ready roadmap-ready stack-ready repo-ready production-ready deploy-ready observe-ready launch-ready harden-ready; do
     cp SUITE.md ~/Projects/$skill/SUITE.md
   done
   # Verify byte-identical:
   for skill in kickoff-ready prd-ready architecture-ready roadmap-ready stack-ready repo-ready production-ready deploy-ready observe-ready launch-ready harden-ready ready-suite; do
     cmp -s ~/Projects/$skill/SUITE.md ~/Projects/ready-suite/SUITE.md && echo "$skill: ok" || echo "$skill: DIFFER"
   done
   ```

4. **Bump frontmatter version + updated date in every affected skill**. For each skill that needs a bump, edit `SKILL.md`:
   ```
   version: <new>
   updated: <YYYY-MM-DD>
   ```

5. **Update SUITE.md known-good versions table** to match the new versions. (You did this in step 2 if you remembered.)

6. **Update hub README known-good versions table** to match.

7. **Prepend CHANGELOG entries** in every affected skill. Two flavors of entry: feature/behavior change (named "minor") and SUITE.md-sync-only (named "patch"). Both end with `---` followed by a single blank line then the prior entries.

8. **Run the lint locally**:
   ```bash
   bash ~/Projects/ready-suite/scripts/lint.sh
   # Expect: 6/6 checks pass; trigger-overlap may emit advisory warnings.
   ```

9. **Per-skill: commit, push, tag, release**. Use a helper script (e.g., `/tmp/release_skill.sh` from prior sessions, kept in your dotfiles). The pattern per skill:
   ```bash
   cd ~/Projects/<skill>
   git add SKILL.md SUITE.md README.md CHANGELOG.md references/  # whatever changed
   git commit -m "v<new>: <imperative one-line summary>"
   git push origin HEAD
   git tag v<new>
   git push origin v<new>
   gh release create v<new> --title v<new> --notes "$(awk -v v='## v<new> ' '$0 ~ "^"v {f=1; next} f && /^---$/ {exit} f' CHANGELOG.md)"
   ```

10. **Hub commit + push** (no version, no tag, no release on the hub):
    ```bash
    cd ~/Projects/ready-suite
    git add SUITE.md README.md install.sh uninstall.sh scripts/ ORCHESTRATORS.md  # whatever changed
    git commit -m "<imperative one-line summary of the cross-suite change>"
    git push origin HEAD
    ```

11. **Verify CI**:
    ```bash
    gh run list --repo aihxp/ready-suite --limit 1 --json status,conclusion
    ```
    Expect `"conclusion": "success"` once the workflow finishes (~30s).

12. **Tag-release parity audit** post-merge:
    ```bash
    bash ~/Projects/ready-suite/scripts/lint.sh tag-release-parity
    ```

A coordinated patch is ~45 minutes of focused work after you have done one before. The first one is closer to two hours.

### Ritual 3: hub-only patch (install.sh, lint, README, MAINTAINING)

Some changes affect only the hub.

When the change is hub-only and does not touch SUITE.md:

- No version bump on any specialist.
- No SUITE.md sync (SUITE.md is unchanged).
- Hub commit + push only.

### Ritual 3a: hub + one-specialist patch (ORCHESTRATORS.md, single-skill audit refresh)

Some changes affect only the hub plus a single specialist (production-ready for ORCHESTRATORS.md; repo-ready for `AUDIT-REPORT.md` re-audits; etc.).

The discipline:

- The affected specialist gets a patch bump (frontmatter + CHANGELOG entry + tag + release).
- **The SUITE.md known-good versions table updates and the byte-identical sync runs across all 12 repos.** Every other specialist gets a sync-only patch bump (frontmatter + one-line CHANGELOG entry + tag + release), even if their own SKILL.md is unchanged.
- Hub commit + push.

**The v2.5.12 precedent has been retired.** That precedent allowed single-specialist patches to skip the full SUITE.md sync, on the rationale that the table would "catch up at the next coordinated patch." In practice this caused the SUITE.md table to drift two-to-four versions behind reality on the affected rows; the hub `scripts/lint.sh` `suite-md-sync` check now catches this drift on the daily workflow, and the cleanup-and-resync overhead exceeds the cost of always-syncing.

The new rule is uniform: **any version bump in any specialist triggers byte-identical SUITE.md sync across all 12 repos and a sync-only patch bump on the other 10 specialists.** This is more commits per patch, but it preserves the lint's invariant and removes the drift class entirely.

### Ritual 4: standalone hub-CI / lint regression

If the daily-scheduled lint workflow fires red:

1. Read the failing check name in the workflow output.
2. Run that specific check locally:
   ```bash
   bash ~/Projects/ready-suite/scripts/lint.sh <check-name> --verbose
   ```
3. Fix the drift. The most common culprits, in descending frequency:
   - **suite-md-sync**: a sibling pushed a SUITE.md edit out of band. Re-sync from the hub.
   - **frontmatter-version**: a sibling bumped CHANGELOG without bumping `SKILL.md` frontmatter, or vice versa. Reconcile.
   - **tag-release-parity**: a sibling pushed a tag without creating the matching release. Run `gh release create` against the missing tag.
   - **unicode-clean**: someone introduced an em-dash. Find via the verbose output, replace with comma/colon/parentheses, push.
   - **compatible-with**: a sibling's SKILL.md had a frontmatter merge collision; missing values. Restore from a sibling or from a recent commit.
   - **trigger-overlap**: advisory only by default; verify a row exists in `references/TRIGGER-DISAMBIGUATION.md` for any new collision.
4. Push the fix; re-run the workflow via `workflow_dispatch` to confirm green.

### Ritual 5: cutting a kickoff-ready release that introduces a new specialist

The largest ritual. Adding a twelfth skill (or replacing one) is a major-feature change to the suite map. Steps:

1. **Decide the tier**: orchestration / planning / building / shipping. The skill must not duplicate an existing skill's lane (the trigger-overlap lint will surface conflicts).
2. **Create the skill repo** under `aihxp/<new-skill>`. Mirror the eleven existing repos: `SKILL.md`, `CHANGELOG.md`, `SUITE.md`, `README.md`, `LICENSE`, `references/`.
3. **Update the suite-tier diagram** in `SUITE.md` (the four-tier ASCII diagram) and the `## What each skill owns` table.
4. **Update the dependency-flow text** in SUITE.md.
5. **Update kickoff-ready's `description` trigger list, scope-fence catalog, and downstream sibling list** to include the new specialist. Bump kickoff-ready to a minor.
6. **Update install.sh and uninstall.sh** to include the new skill in the `SKILLS` shell variable.
7. **Update the lint's `SKILLS` variable** in `scripts/lint.sh` (in two places: top-of-file constant, and `ALL_REPOS`).
8. **Update the GitHub Actions workflow** in `.github/workflows/lint.yml` to clone the new skill repo.
9. **Update the hub README**: tier diagram, version table, install commands.
10. **Coordinated patch ritual** (Ritual 2) plus the new specialist's first release.
11. **Plugin marketplace update** in `.claude-plugin/marketplace.json` to vendor the new skill. Run `bash scripts/refresh-plugin-skills.sh`. Tag a `plugin-v<x.y.z>`.

Cutting a new specialist is a half-day of focused work. Pair with the existing maintainer; do not solo it the first time.

## Version-bump rules

The suite uses semver but flavored to its own work shapes. The rules:

- **Major (`X.0.0`)**: a SKILL.md body restructure that breaks downstream consumers' expectations. Rare; effectively never seen in the suite to date.
- **Minor (`x.Y.0`)**: a new behavior the user can observe. Sub-step added; new artifact emit; new have-not enforced; new tier in the workflow. Examples: kickoff-ready 1.1.0 (AGENTS.md emit), production-ready 2.6.0 (DESIGN.md consumption).
- **Patch (`x.y.Z`)**: documentation-only updates, SUITE.md sync, frontmatter compatibility additions, reference-file additions that do not change SKILL.md body, ORCHESTRATORS.md addition or update.

Default to patch. Minor only when there is a behavior change a user can observe. The CHANGELOG entry's "Why a patch, not a minor" (or "Why a minor") line forces an explicit choice.

## Tag-release parity

Every git tag has a matching GitHub Release. The Release body is lifted verbatim from the CHANGELOG entry between the matching `## v<X.Y.Z>` heading and the next `---` separator.

Why this discipline: the suite's CHANGELOGs are the audit trail; releases are the canonical "what shipped at this version" surface. Drift here means a tag exists with no release notes, or a release exists with content not matching the CHANGELOG. The lint enforces the first; reviewer eyes enforce the second.

If you discover a tag without a matching release (the lint surfaces it), backfill:

```bash
cd ~/Projects/<skill>
ver=<x.y.z>
body=$(awk -v v="## v$ver " '$0 ~ "^"v {f=1; next} f && /^---$/ {exit} f' CHANGELOG.md)
gh release create "v$ver" --title "v$ver" --notes "$body" --repo "aihxp/<skill>"
```

Do not pass `--target` if the tag already exists on the remote; the GitHub API rejects it.

## SUITE.md byte-identical sync

`SUITE.md` is the canonical map of the suite. It exists in 12 places, byte-identical. The discipline: any time the canonical changes, the 11 siblings are re-synced in the same coordinated patch.

The sync is a copy operation (`cp`). The lint check `suite-md-sync` runs `cmp -s` per sibling to verify.

If you accidentally push a SUITE.md edit to a sibling out of band, the daily lint workflow will catch it within 24 hours. Recover by either:

- Reverting the sibling's SUITE.md to match the hub's (if the hub is the source of truth for the change).
- Promoting the sibling's edit to the hub and resyncing the other 10 siblings (if the sibling's edit is what was intended).

The principle: there is one canonical SUITE.md. The hub is its home. The sibling copies are mirrors.

## Em-dash / arrow / box-drawing rule

Forbidden characters in suite-authored files: `—` `–` `―` `‐` `‒` `−` `→` `←` `↑` `↓`. Pre-existing instances in older content are tolerated; no new ones may be introduced.

When writing a new file or extending an existing one:

- Comma, colon, or semicolon for a pause.
- Parentheses for a parenthetical.
- Two separate sentences when the break is strong.
- ASCII hyphen `-` for compound words and number ranges.
- ASCII `->` for an arrow.

The `unicode-clean` lint check enforces this on the load-bearing files (SUITE.md whole-file, hub README.md whole-file, top CHANGELOG entry per skill, hub install/uninstall/ORCHESTRATORS).

## When in doubt: read the lint output, then check the precedent

The lint output names what failed and where. The precedent for almost every coordinated-patch shape exists in the git history of one of the twelve repos. Read the last few coordinated-patch commits before doing your first one; the format and the rhythm will become obvious.

## File and folder layout per skill repo

The eleven specialist repos converge on a uniform top-level shape after the v1 hygiene-cleanup sweep. The hub has its own shape because it carries cross-cutting infrastructure. Documenting the canonical layout here so future maintainers (and contributors) know what's standard, what's intentional drift, and what's a known inconsistency to leave alone.

### Standard top-level files (every specialist repo)

| File | Purpose |
|---|---|
| `SKILL.md` | The skill. Frontmatter declares `version`, `updated`, `suite`, `tier`, `upstream`, `downstream`, `pairs_with`, `compatible_with`. Body is the workflow + reference table. |
| `CHANGELOG.md` | Skill version history. Top entry's `## v<X.Y.Z>` matches `SKILL.md` frontmatter `version`. Lint check enforces. |
| `SUITE.md` | Byte-identical across all 12 repos. Lint check enforces. |
| `README.md` | Skill landing page: install, when to use, link to SUITE.md. |
| `LICENSE` | MIT. |
| `SECURITY.md` | Private vulnerability disclosure: GitHub Security Advisories preferred channel, email fallback, severity-tied response SLAs. |
| `CONTRIBUTING.md` | Thin pointer to the hub's canonical contributor guide. No content duplication. |
| `.gitignore` | Minimal: OS / editor / install-backup ignores; `.claude/settings.local.json`; `.planning/`. |
| `.github/CODEOWNERS` | Default `* @aihxp` rule + comment block on the second-maintainer addition path. |
| `references/` | Skill-specific reference library, lazy-loaded on demand per the SKILL.md reference table. |

### Standard `references/` naming conventions

| Pattern | Use |
|---|---|
| `<skill>-research.md` | The on-load research summary the skill loads at Step 0. Example: `prd-research.md`. |
| `RESEARCH-YYYY-MM.md` | The dated source-citations dump (the deep research pass). Example: `RESEARCH-2026-04.md`. Most specialists carry both this and `<skill>-research.md`; the latter is the workflow-loaded surface, the former is the audit trail of where every claim came from. |
| `<skill>-anatomy.md` | The artifact-template reference (what the skill's output looks like, annotated). Example: `prd-anatomy.md`, `roadmap-anatomy.md`. |
| `<skill>-antipatterns.md` | Named failure-mode catalog with grep tests. Example: `prd-antipatterns.md`, `kickoff-antipatterns.md`. |
| `EXAMPLE-<ARTIFACT>.md` | Worked-example artifact (planning-tier only at v1). Example: `EXAMPLE-PRD.md`. The four planning-tier skills (prd, architecture, roadmap, stack) carry these; the seven other skills do not by design. |
| `<topic>.md` | Per-topic deep-dive references the workflow loads on demand. Example: `trust-boundaries.md`, `slo-design.md`, `payments-and-billing.md`. |

### Hub repo layout (different shape, intentional)

The hub (`aihxp/ready-suite`) carries cross-cutting infrastructure rather than a single skill. Its top-level shape:

| File / dir | Purpose |
|---|---|
| `SUITE.md` | Canonical byte-identical-across-12 suite map. Hub is its source of truth. |
| `README.md` | Suite hub landing page: discovery, install, the eleven-skill table, standards-compliance section. |
| `ORCHESTRATORS.md` | Cross-orchestrator composition (GSD, BMAD, Spec Kit, Superpowers, plain harnesses). Mirrored byte-identical to `production-ready` only (the v2.5.12 precedent). |
| `CONTRIBUTING.md` | Canonical contributor guide for every skill in the suite (the eleven specialists' `CONTRIBUTING.md` files point here). |
| `MAINTAINING.md` | This file. Maintainer-facing rituals. |
| `LICENSE` | MIT. |
| `install.sh`, `uninstall.sh` | Bash 3.2 install scripts. Symlink each skill's `SKILL.md` and `references/` into every detected harness's skills directory. |
| `scripts/lint.sh` | Meta-linter. Six checks across the 12 repos. |
| `.github/workflows/lint.yml` | CI on push, PR, and daily 06:00 UTC schedule. |
| `.github/CODEOWNERS` | Default `* @aihxp`; path-specific rules name the high-blast-radius surfaces. |
| `references/TRIGGER-DISAMBIGUATION.md` | Canonical resolution table for ambiguous user phrases that match more than one skill. |
| `references/PLUGIN-RESEARCH.md` | Format research for the Claude Code plugin marketplace. |
| `plugins/` | Vendored skill manifests for the Claude Code plugin marketplace. |
| `.claude-plugin/marketplace.json` | Claude Code marketplace manifest. |

The hub does NOT carry: `SKILL.md`, `CHANGELOG.md`, `version` frontmatter. It is not a skill; it does not version itself; it tracks the suite's collective version table inside `SUITE.md`.

### Intentional drift (known and accepted)

These per-repo deviations from the standard layout are deliberate. Do not "fix" them.

- **`repo-ready` carries an elaborate self-scaffold**: `.editorconfig`, `.gitattributes`, `.githooks/`, `.gitleaks.toml`, `.markdownlint.json`, `.pre-commit-config.yaml`, `.prettierignore`, `.prettierrc.json`, `Makefile`, `CODE_OF_CONDUCT.md`, `CLAUDE.md`, `DOCS.md`, `AUDIT-REPORT.md`. **Why:** repo-ready dogfoods its own discipline. The repo IS the demonstration of what a complete repo-ready scaffold looks like. The `AUDIT-REPORT.md` is the self-audit; the `DOCS.md` is the ten-minute reader-facing overview that repo-ready's audit-mode produces.
- **`production-ready` carries `ORCHESTRATORS.md`**: mirrored from the hub. The v2.5.12 precedent introduced ORCHESTRATORS.md as a patch on production-ready alone (because production-ready was the suite's heavy content at the time); the byte-identical mirror to the hub is the agreed shape.
- **`production-ready` references library uses `<topic>.md` flatly without an explicit `<skill>-research.md`**: instead `codebase-research.md`. Production-ready predates the `<skill>-research.md` naming convention; the existing scheme works and renaming would churn 38 reference files for no reader benefit.
- **`kickoff-ready` has only 7 references**: smaller than the planning-tier skills' 11-13. Kickoff-ready is the orchestration-tier meta-skill; its reference set is intentionally narrow (sequencing rules, handoff protocols, scope fence, antipatterns, progress tracking, AGENTS.md emit template).
- **`repo-ready/.planning/`**: GSD development artifacts kept on the published repo as a transparency trail of how repo-ready itself was built. The other ten specialist repos either don't use GSD or keep `.planning/` in a separate workspace; gitignore exists in the new template to prevent accidental commits in fresh repos.

### Known inconsistencies to leave alone (for now)

These are real inconsistencies that have been considered and explicitly not fixed in v1.0:

- **Six skills lack a dedicated `references/<skill>-antipatterns.md` file**: stack-ready, repo-ready, production-ready, deploy-ready, observe-ready, launch-ready, harden-ready. Some embed antipattern catalogs into other references; some carry the named-failure-mode discipline inline in SKILL.md without a dedicated file. **Why not fixed:** writing six new antipattern files is real research-level content work, not a session-scale unification. Will be addressed when each skill's content is next refreshed materially.
- **The hub does not carry a `CHANGELOG.md`**: hub-level changes are tracked in commit history alone. **Why not fixed:** the hub has no version of its own; a CHANGELOG implies a release stream; the hub doesn't have one. The git log serves the same purpose.
- **`production-ready` carries `ORCHESTRATORS.md` but no other shipping-tier skill does**: deploy-ready / observe-ready / launch-ready / harden-ready could each plausibly carry composition guidance. **Why not fixed:** the hub's `ORCHESTRATORS.md` covers the cross-orchestrator story; per-skill orchestration notes would duplicate. Production-ready's mirror is historical.

When in doubt about whether a per-repo file is "supposed to be there," consult this section first; if not addressed here, treat it as an open question and ask before fixing.

## Checklist for a clean coordinated patch

Before you push:

- [ ] Frontmatter `version` and `updated` bumped on every affected skill
- [ ] CHANGELOG entry prepended on every affected skill
- [ ] SUITE.md identical across all 12 repos (`cmp -s` confirms)
- [ ] Hub README known-good versions table updated
- [ ] `bash scripts/lint.sh` runs clean (or only the documented advisory trigger-overlap warning)
- [ ] No new em-dashes / arrows / box-drawing characters introduced
- [ ] Tag-release parity: `git tag` + `git push origin <tag>` + `gh release create` for every bumped specialist
- [ ] Hub commit pushed (no tag, no release for hub)
- [ ] CI workflow on the hub passes green

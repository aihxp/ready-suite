# Contributing to the ready-suite

Thanks for considering a contribution. The ready-suite is one repo at [`aihxp/ready-suite`](https://github.com/aihxp/ready-suite): hub-level files at the root, eleven specialist skills under `skills/<skill-name>/`. This file documents the contribution model and the conventions every PR is held to.

For maintainers (or anyone landing a coordinated cross-suite patch), see [`MAINTAINING.md`](MAINTAINING.md) for the SUITE.md sync ritual, the version-bump rules, and the release procedure.

## What kinds of contributions land

The suite welcomes:

- **Bug fixes** in any skill's SKILL.md, references, install scripts, or lint check.
- **New trigger-disambiguation rows** when a real overlap surfaces.
- **Standards-tracking updates** (a new harness joins the Agent Skills standard, a new format like `DESIGN.md` becomes load-bearing, etc.).
- **Documentation fixes** (typos, broken cross-references, stale version pointers).
- **New worked examples** for the planning-tier skills (the existing `EXAMPLE-*.md` files are templates; additional fictional projects illustrate the suite across domains).

The suite refuses (politely):

- **New skills** without a tier-fit discussion first. The eleven skills are scoped specifically; a twelfth needs to fit the orchestration / planning / building / shipping tier model and not duplicate an existing skill's lane. Open an issue first.
- **Behavior changes that drift from the named failure-mode discipline.** Each skill has named "Refuses ..." failure modes. A PR that softens a refusal weakens the moat against AI-generated slop.
- **Dependency additions to install.sh / uninstall.sh.** They are bash 3.2 compatible (macOS default) by design. New dependencies (jq, gh, node) shift the install surface.
- **AGENTS.md / DESIGN.md / SKILL.md format reinventions.** The suite tracks the open standards (agentskills.io, agents.md, github.com/google-labs-code/design.md). Inventing a private format is out of scope.
- **Skills that call other skills programmatically.** The harness is the router (composition principle 2 in `SUITE.md`). Skills compose via artifact paths, not function calls.

## Conventions every PR is held to

### No em-dashes, en-dashes, arrows, or box-drawing characters

The suite is unicode-disciplined. Forbidden characters in any suite-authored file: `—` (em-dash), `–` (en-dash), `―` (horizontal bar), `‐` (hyphen), `‒` (figure dash), `−` (minus sign), `→ ← ↑ ↓` (arrows). Use these alternatives:

- Comma, colon, or semicolon for a pause or aside.
- Parentheses for a parenthetical.
- Two separate sentences when the break is strong.
- ASCII hyphen `-` for compound words and number ranges.
- ASCII `->` for an arrow.

The `unicode-clean` lint check enforces this on `SUITE.md`, the hub `README.md`, hub `install.sh` / `uninstall.sh` / `ORCHESTRATORS.md`, and the top CHANGELOG entry of every skill. Pre-existing characters in older content are tolerated; no new ones may be introduced.

### Bash 3.2 compatibility (install / uninstall / lint)

`install.sh`, `uninstall.sh`, and `scripts/lint.sh` must run on macOS default bash 3.2. No associative arrays. No `mapfile` / `readarray`. No `${var,,}` lowercase. No `[[ ]]` (use `[ ]`). Test on a Mac before opening a PR if you touch any of those scripts.

### SUITE.md byte-identical between hub and skills/<skill>/

`SUITE.md` is the canonical suite map. It lives byte-identical at the hub root and inside every `skills/<skill>/` subdirectory. When any cross-suite content changes (a new compatibility row, a version bump in the known-good-versions table), SUITE.md is updated at the hub and copied to every skill subdir in the same commit. The `suite-md-sync` lint check enforces this.

### Frontmatter version matches CHANGELOG top entry

Every skill's `SKILL.md` frontmatter `version: X.Y.Z` must match the top `## v<X.Y.Z>` entry in its `CHANGELOG.md`. The `frontmatter-version` lint check enforces this. Bump both in the same commit.

### `compatible_with` standards-level values

Every skill's `compatible_with` frontmatter must include: `claude-code`, `codex`, `cursor`, `windsurf`, `pi`, `openclaw`, `any-agentskills-compatible-harness`. Additional values are fine (kickoff-ready also lists `antigravity`). The `compatible-with` lint check enforces this.

### Trigger overlap is advisory

The `trigger-overlap` lint check surfaces cross-skill substring overlaps in description trigger phrases. Overlaps are warnings, not failures. When you add a trigger phrase to a skill that overlaps another's, add a row to [`references/TRIGGER-DISAMBIGUATION.md`](references/TRIGGER-DISAMBIGUATION.md) in the same PR.

## Running the lint locally

```bash
git clone https://github.com/aihxp/ready-suite.git
cd ready-suite
bash scripts/lint.sh                   # all checks
bash scripts/lint.sh --verbose         # show ok lines too
bash scripts/lint.sh suite-md-sync     # one specific check
bash scripts/lint.sh --strict-triggers # fail on trigger-overlap warnings
```

GitHub Actions runs the same lint on every push to `main` and every PR. PRs that fail the lint do not merge.

## How to land a single-skill change

The simplest contribution shape: change one file under `skills/<skill>/`, no SUITE.md sync needed.

1. Fork the hub repo on GitHub.
2. Make the change inside `skills/<skill>/`. Bump the skill's frontmatter `version` and `updated` in `skills/<skill>/SKILL.md`. Prepend a CHANGELOG entry to `skills/<skill>/CHANGELOG.md` that names the change, the skill behavior delta (if any), and a "Why a patch, not a minor" line.
3. Run the lint locally; verify clean (or one trigger-overlap warning if expected).
4. Open a PR against the hub. Reference the issue (if any). Include a one-paragraph problem-and-fix in the PR body.
5. The maintainer reviews and merges.

## How to land a coordinated cross-suite change

If your change touches `SUITE.md`, `compatible_with`, multiple skills, or anything cross-cutting (e.g., a new harness joins the standards list), the patch touches several files in one PR. See [`MAINTAINING.md`](MAINTAINING.md) §"Ritual 2: coordinated cross-suite patch" for the full procedure. The high-level shape:

1. Open a discussion issue in the hub repo first if the change affects scope or trigger surface.
2. Edit the hub-level files first (`SUITE.md`, `ORCHESTRATORS.md`, etc.).
3. Sync `SUITE.md` to every `skills/<skill>/SUITE.md`.
4. Bump the affected skills' `version` and `updated` in their `SKILL.md` and prepend CHANGELOG entries.
5. Run the lint; verify clean.
6. One PR, one merge.

The single-repo workflow is much simpler than the prior multi-repo discipline. No per-skill tags, no per-skill GitHub Releases.

## Commit message style

```
<one-line summary, imperative tense, under 70 chars>

<paragraph: what changed, why it changed, what scope it touches>

<paragraph: known limitations, follow-up work, related issues>
```

Examples (real, from the repo's history):

- `Standards-compliant positioning: pi + OpenClaw via Agent Skills standard`
- `DESIGN.md (Google Labs) consumption: production-ready Step 3 sub-step 3a`
- `Trigger disambiguation table + lint check for cross-skill trigger overlap`

Avoid: subject lines like `update`, `fix`, `wip`, or `misc`. The history is the audit trail; opaque subjects are friction.

## Code of conduct

Be civil. The suite is opinionated; disagreements about discipline are welcome; condescension is not. The maintainer reserves the right to lock threads and close PRs that turn personal.

## Where to start

- **Documentation typo or broken link:** open a PR directly with a fix to the affected file under `skills/<skill>/` or the hub root.
- **Trigger-disambiguation row missing for a real ambiguity you hit:** open a PR against the hub adding a row to `references/TRIGGER-DISAMBIGUATION.md`.
- **Bug in a skill's named-failure-mode logic:** open an issue describing the failure case (with a reproduction); the maintainer triages.
- **Standards-tracking update (a new harness, a new format):** open an issue first, then a coordinated patch.

## License

MIT. By contributing, you agree your contribution is licensed under the same terms.

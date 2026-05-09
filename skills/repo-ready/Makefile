# Repo Ready has no build step. These targets are quality gates and convenience shortcuts.
#
# Usage:
#   make lint         Lint all Markdown with markdownlint-cli2.
#   make format       Format all Markdown with Prettier (respects .prettierignore).
#   make check-sizes  Enforce SKILL.md <= 40KB and references/*.md <= 80KB ceilings.
#   make hooks        Install the repo's git hooks (.githooks/pre-push, etc.).
#   make audit        Guidance for running the repo-ready skill against this repo.
#   make release      Release checklist (merge, CHANGELOG, tag, push, GitHub Release).

.PHONY: lint format check-sizes hooks audit release

lint:
	npx markdownlint-cli2 '**/*.md' '#.planning/**' '#node_modules/**'

format:
	npx prettier --write '**/*.md'

check-sizes:
	@set -e; \
	fail=0; \
	skill_size=$$(wc -c < SKILL.md | tr -d ' '); \
	echo "SKILL.md: $${skill_size} bytes (ceiling 40960)"; \
	if [ "$${skill_size}" -gt 40960 ]; then \
		echo "ERROR: SKILL.md exceeds 40960 bytes"; \
		fail=1; \
	fi; \
	for f in references/*.md; do \
		size=$$(wc -c < "$$f" | tr -d ' '); \
		echo "$$f: $${size} bytes (ceiling 81920)"; \
		if [ "$${size}" -gt 81920 ]; then \
			echo "ERROR: $$f exceeds 81920 bytes"; \
			fail=1; \
		fi; \
	done; \
	exit $${fail}

hooks:
	./.githooks/install.sh

audit:
	@echo "Repo Ready is an AI instruction set, not a CLI — it cannot be invoked from Make."
	@echo ""
	@echo "To run the audit against this repo:"
	@echo "  1. Open this repo in an AI coding agent (Claude Code, Cursor, Cline, etc.)."
	@echo "  2. Ask: \"Run the repo-ready skill in audit mode against this repo.\""
	@echo "  3. The agent loads SKILL.md + references/audit-mode.md and writes AUDIT-REPORT.md."
	@echo ""
	@echo "See references/audit-mode.md for the 35-point scorecard and workflow."

release:
	@echo "Release checklist (manual — repo-ready has no automated release workflow yet):"
	@echo ""
	@echo "  1. Merge all milestone PRs into main."
	@echo "  2. Update CHANGELOG.md — move [Unreleased] entries under a new [X.Y.Z] heading."
	@echo "  3. Commit the CHANGELOG bump: git commit -m \"chore: release vX.Y.Z\"."
	@echo "  4. Tag the release: git tag -a vX.Y.Z -m \"vX.Y.Z — <milestone name>\"."
	@echo "  5. Push tag: git push origin main && git push origin vX.Y.Z."
	@echo "  6. Create GitHub Release: gh release create vX.Y.Z --title \"vX.Y.Z ...\" --notes-file ..."
	@echo ""
	@echo "See CHANGELOG.md for the Keep a Changelog format and prior release structure."

#!/bin/sh
# .githooks/install.sh
#
# One-time setup: point git at the repo-local hooks directory and make
# the pre-push hook executable. Idempotent — safe to re-run.

set -e

git config core.hooksPath .githooks
chmod +x .githooks/pre-push

echo "Git hooks installed."
echo "Force-push now requires --force-with-lease or ALLOW_FORCE_PUSH=1."
echo "See references/agent-safety.md §3 for override patterns."

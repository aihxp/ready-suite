# Trigger disambiguation

The eleven ready-suite skills have tight scopes but adjacent triggers overlap. This file maps the most likely confusion cases to the canonical skill with one-line rationale.

The harness (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw, etc.) routes by description triggers. When a user phrase plausibly matches more than one skill, the harness picks one; this file is the reference for what the right answer is, and the disambiguating question to ask if the routing is genuinely ambiguous.

## How to use

User says X. You're not sure which skill should fire. Look up X in the table below or scan the rationale for the closest match. If still ambiguous, ask the user one clarifying question; do not run a five-option meeting.

## The disambiguation table

| User phrase | Canonical skill | Rationale |
|---|---|---|
| "set up CI" | repo-ready | Initial scaffolding (lint+test on PR) is repo hygiene. Add a deploy pipeline on top is deploy-ready. |
| "CI/CD pipeline" | deploy-ready | Pipeline that promotes builds is deployment. |
| "GitHub Actions" | repo-ready (default) | "Set up GitHub Actions" is scaffolding workflows. If user means promotion pipeline specifically, deploy-ready. |
| "release automation" | repo-ready (default) | Tag-and-release workflow on push is repo-ready. Promote-to-prod on tag is deploy-ready. |
| "SECURITY.md" | repo-ready (scaffold) | Scaffolding the file is repo-ready. Designing the disclosure program beyond the file is harden-ready. |
| "dependency scanning" | repo-ready (config) | Scaffold the scanner (Dependabot, Renovate) is repo-ready. Adversarial review of the dependency landscape is harden-ready. |
| "branch protection" | repo-ready (config) | Scaffold the rules is repo-ready. Verify they hold against bypass attempts is harden-ready. |
| "ADR" | architecture-ready (system shape) | System-shape ADRs (monolith vs services, sync vs async, trust boundaries) are architecture-ready. Tech-pick ADRs (Postgres vs Mongo, Next.js vs Remix) are stack-ready. |
| "pick a database" | architecture-ready (do we need one) or stack-ready (which one) | Whether to have a DB at all and what shape (relational, document, time-series) is architecture-ready. Which DB product is stack-ready. |
| "trust boundaries" | architecture-ready (declare) or harden-ready (verify) | Declare boundaries in architecture is architecture-ready. Verify they hold in implementation is harden-ready. |
| "runbook" | observe-ready (ops) or harden-ready (incident response) | Operational runbooks (alert response, rollback procedure, dashboard interpretation) are observe-ready. Incident-response and disclosure runbooks are harden-ready. |
| "audit" | repo-ready (hygiene) or harden-ready (security) | Repo-hygiene audit (audit-mode) is repo-ready. Security audit is harden-ready. |
| "performance" | production-ready (build fast) or observe-ready (monitor) | Build it fast in the first place is production-ready. Verify it stays fast in prod is observe-ready. |
| "make this production-ready" | production-ready (if dashboard) or harden-ready (if pre-launch) | Skill-name overlap. If user is building a multi-page admin app, production-ready. If they mean "harden it before shipping," harden-ready. |
| "we need to launch" | launch-ready (if app exists) or kickoff-ready (if greenfield) | App built but not announced is launch-ready. "I have an idea, ship it" is kickoff-ready. |
| "deploy" / "deploy this" | deploy-ready | Single deploy event is deploy-ready. |
| "first deploy" | deploy-ready | First-time deploy ceremony is deploy-ready. |
| "monitor" / "monitoring" / "alerting" | observe-ready | All operational signal-wiring is observe-ready. |
| "metrics" / "dashboards (operational)" | observe-ready | Operational metrics and ops dashboards are observe-ready. App dashboards (Grafana, Honeycomb) are observe-ready; product dashboards (admin panel, analytics view) are production-ready. |
| "structured logging" | observe-ready | Logging discipline for ops is observe-ready. |
| "OpenTelemetry" / "tracing" | observe-ready | Distributed tracing is observe-ready. |
| "post-mortem" | observe-ready (ops) or harden-ready (security incident) | Generic incident post-mortem is observe-ready. Security post-incident hardening is harden-ready. |
| "OWASP" / "Top 10" | harden-ready | OWASP walkthrough is harden-ready. |
| "pen test" / "penetration testing" | harden-ready | Pen-test prep, retest discipline, and finding triage are harden-ready. |
| "compliance" / "SOC 2" / "HIPAA" / "PCI-DSS" / "GDPR" | harden-ready | All compliance mapping with control-to-code evidence is harden-ready. |
| "responsible disclosure" / "bug bounty" | harden-ready | Disclosure program design beyond `SECURITY.md` is harden-ready. |
| "system diagram" / "C4" / "arc42" | architecture-ready | All system-shape diagrams are architecture-ready. |
| "service boundaries" / "monolith vs microservices" | architecture-ready | All boundary decisions are architecture-ready. |
| "what stack" / "which framework" / "which DB" | stack-ready | Tech-pick is stack-ready. |
| "Next.js vs. Remix" / "Postgres vs Mongo" | stack-ready | Comparison shopping is stack-ready. |
| "PRD" / "product spec" / "requirements doc" / "one-pager" | prd-ready | All product-definition docs are prd-ready. |
| "build a roadmap" / "milestone plan" / "Now-Next-Later" | roadmap-ready | Sequencing work over time is roadmap-ready. |
| "set up the repo" / "initialize the project" / "add README" | repo-ready | All repo-hygiene scaffolding is repo-ready. |
| "dashboard" / "admin panel" / "internal tool" / "back office" | production-ready | All dashboard-class apps are production-ready. |
| "build the app" | production-ready (if dashboard) | Default is production-ready. If user means scaffolding from scratch, repo-ready first then production-ready. |
| "landing page" / "marketing site" | launch-ready | Marketing landing is launch-ready (production-ready explicitly excludes marketing sites). |
| "Product Hunt" / "Show HN" / "Reddit launch" | launch-ready | Launch channels are launch-ready. |
| "waitlist" / "OG card" / "press kit" | launch-ready | Launch artifacts are launch-ready. |
| "kickoff" / "new project from scratch" / "I have an idea" | kickoff-ready | Greenfield orchestration from raw user intent is kickoff-ready. |
| "constitution.md" | (none) | The suite does not own a `constitution.md` equivalent. That slot belongs to Spec Kit; ready-suite reads it when present. See ORCHESTRATORS.md Pattern: Spec Kit. |
| "AGENTS.md" / "CLAUDE.md" | repo-ready (scaffold) or kickoff-ready (post-arc emit) | Project-conventions agent brief is repo-ready. Suite-artifact-map emit when none exists is kickoff-ready Step 6 sub-step 6a. |
| "DESIGN.md" | production-ready (consume) | Detect and consume the Google Labs DESIGN.md format in Step 3 sub-step 3a is production-ready. |

## When to fall back to the user

If a phrase is ambiguous and the rationale above does not disambiguate cleanly, ask one short clarifying question with two options. Examples:

- "Set up CI" -> "Just scaffold lint+test on PR (repo-ready), or also wire promote-to-prod (deploy-ready)?"
- "We need to launch" -> "Do you have an app already, or are you starting from idea?"
- "Audit the project" -> "Repo hygiene (repo-ready audit-mode), or security (harden-ready)?"
- "Performance work" -> "Build it fast (production-ready), or monitor it stays fast (observe-ready)?"
- "Make this production-ready" -> "Build the dashboard (production-ready), or harden before launch (harden-ready)?"

One question, two options. Do not list five.

## When the harness routes wrong

The user is the final authority. If a harness or orchestrator routes to skill X but Y is correct, the user invokes Y by name explicitly. Ready-suite skills are addressable directly; nothing requires going through an orchestrator's router.

## Out-of-scope phrases

These look like ready-suite triggers but are NOT. Route elsewhere:

| User phrase | Why not ready-suite |
|---|---|
| "fix this bug" | Generic debugging, not a ready-suite skill. Use the harness's general agent. |
| "refactor this module" | Not a ready-suite skill. Use the harness's general agent. |
| "write tests" (alone) | Generic testing. ready-suite skills include testing within their tier verification, but a standalone "add tests" request routes to general agent. |
| "translate to Spanish" | Not in scope. |
| "explain this code" | Generic code explanation, not a ready-suite skill. |
| "debug a memory leak" | Not in scope. |
| "write a blog post" | Not in scope (launch-ready writes launch-day copy, not ongoing content). |
| "pick a logo" | Not in scope. |

## How this file is maintained

`scripts/lint.sh` runs a `trigger-overlap` check that extracts trigger phrases from each skill's `description:` frontmatter and reports cross-skill substring overlaps for phrases of significant length. When a new collision appears (a sibling adds a trigger that substring-overlaps another sibling's), this file gets a new row.

The grep test for completeness: every row's "User phrase" column should be either a direct trigger phrase from one of the eleven skills' `description` fields, or a synonym a real user is likely to type. Phrases that match exactly one skill's triggers and have no plausible cross-skill confusion do not need a row here; rows exist for ambiguity, not for documentation.

## See also

- `SUITE.md` (byte-identical across 12 repos): the full per-skill scope, primary trigger words, and tier diagram
- `ORCHESTRATORS.md` (hub + production-ready): cross-orchestrator composition with GSD, BMAD, Spec Kit, Superpowers, plain harnesses
- `README.md` (hub): the eleven-skills-four-tiers diagram and the install entry point

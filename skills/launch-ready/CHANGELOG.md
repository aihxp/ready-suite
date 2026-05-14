## v3.0.0 (2026-05-14)

Suite-wide release train alignment. This major release stabilizes the monorepo distribution model, synchronized Claude plugin packaging, strict trigger routing, Pillars project-context integration, and release hygiene for the eleven-skill suite.

### Changed
- Aligns this skill with the ready-suite 3.0.0 release train.
- Keeps the skill's existing artifact paths and trigger ownership intact while publishing the shared major version.

### Why a major
This is a coordinated suite release: all eleven skills, the ready-suite meta plugin, and the marketplace metadata now move together for the 3.0.0 train.

---

# Changelog

## v1.0.17 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.7.0 release that adds Mode D (Multi-repo suite) to repo-ready workflow. This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.16 (2026-05-09)

Documentation patch. Adds `references/launch-antipatterns.md`, the named-failure-mode catalog this skill refuses, with grep tests, severity ladder, and per-skill guards. Closes one of the seven gaps named in MAINTAINING.md \"known-but-not-fixed inconsistencies\" (six skills lacked dedicated antipatterns files; this patch addresses the seventh in the same coordinated sweep).\n\n### Added\n\n- **`references/launch-antipatterns.md`** (~150 lines): named patterns extracted from the skill SKILL.md \"have-nots\" section, formatted with shape (concrete example), grep test (mechanical detection), severity (Critical / High / Medium / Low), guard (where the workflow catches it). Loaded on demand at every tier-gate check and during Mode C audits.\n- **Reference table row**: SKILL.md gains the new entry.\n\n### Changed\n\n- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.\n\n### Why a patch, not a minor\n\nAdditive reference content; SKILL.md body and frontmatter contract unchanged.\n\n---\n\n

## v1.0.15 (2026-05-09)

Documentation-only patch. Recovery sync after the just-retired v2.5.12 precedent. The repo-ready v1.6.15 release (which itself triggered the precedent retirement in MAINTAINING.md) shipped with the OLD SUITE.md committed; the catch-up sync to the other 10 siblings happened afterward in a separate hub commit, but the lint workflow correctly flagged the resulting drift. This patch lands the byte-identical SUITE.md across all 12 repos with the full version table current to all 11 specialists.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to the post-retirement state across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking; mechanical recovery from the lint-caught drift.

---


## v1.0.14 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.6.15 audit-refresh release. The v2.5.12 precedent (single-specialist patches do not trigger full SUITE.md sync) is retired effective this patch: the hub `scripts/lint.sh` `suite-md-sync` check enforces byte-identical `SUITE.md` across all 12 repos, so every specialist version bump (including audit-report refreshes that bump only one specialist) now triggers a full coordinated sync.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to repo-ready 1.6.15 across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.13 (2026-05-09)

Hygiene cleanup. Updates `.gitignore` to prevent accidental commits of `.claude/settings.local.json` (Claude Code personal local-override files; the `.local` suffix is the convention for "do not commit") and `.planning/` (GSD development artifacts). SUITE.md sync.

### Changed

- **`.gitignore`**: added `.claude/settings.local.json` and `.planning/` patterns.
- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Gitignore additions + SUITE.md sync; no behavior change.

---


## v1.0.12 (2026-05-09)

Documentation-only patch. Repo-hygiene cleanup landing as a coordinated sweep across the ten specialist skill repos. Adds `SECURITY.md`, `.github/CODEOWNERS`, `CONTRIBUTING.md`, and `.gitignore` (where missing). The audit was run via repo-ready audit-mode against all 12 suite repos; the gaps surfaced uniformly across the ten specialists (repo-ready was the gold-standard reference and needed no additions).

### Added

- **`SECURITY.md`**: private vulnerability disclosure policy. Two reporting channels (GitHub Security Advisories preferred; email fallback). Response-time SLAs by severity (Critical: 24h triage / 7d fix; High: 3d triage / 14d fix; Medium/Low: 7d triage). Names the realistic security surface for a markdown-only skill (prompt-injection, supply-chain tamper, malicious PR with hidden instructions); names known non-issues so reports are well-shaped. Cross-references the hub suite-wide policy.
- **`.github/CODEOWNERS`**: default `* @aihxp` rule. Comment block explains the second-maintainer addition path (replace the line with `@aihxp @second-handle` once a co-maintainer joins) and points at the hub cross-suite governance.
- **`CONTRIBUTING.md`**: thin pointer to the hub canonical contributor guide and the maintainer guide. Lists what the hub guide covers (unicode rule, bash 3.2 rule, SUITE.md byte-identical rule, frontmatter-version rule, compatible_with values, trigger-overlap advisory, lint mechanics, single-skill vs. coordinated-patch protocols, commit-message style). Avoids duplicating the canonical content here (one source of truth; eleven pointers).
- **`.gitignore`** (where missing): minimal OS / editor / install-backup ignores.

### What was deliberately NOT added

The audit also surfaced gaps for `CODE_OF_CONDUCT.md`, `.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md`, CI workflows, Dependabot, SAST, gitleaks, and `.editorconfig` / `.gitattributes`. These were rejected for skill repos because the repos are markdown-only documentation and have no users today. Adding bureaucratic scaffolding without a community to enforce it is theatre. When traction arrives, these get added in a follow-up patch; until then, the absence is honest.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill SKILL.md, references library, and frontmatter contract are unchanged. Only repo-hygiene scaffolding files added at project root and under `.github/`.

---


## v1.0.11 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the four planning-tier skill releases (prd-ready v1.0.10, architecture-ready v1.0.9, roadmap-ready v1.0.8, stack-ready v1.1.15) which add worked-example reference files for a single fictional B2B SaaS product (Pulse, a Customer Success ops platform). The four examples cross-reference each other to demonstrate the suite's compose-by-artifact principle: each downstream artifact reads from the prior one and refines, never duplicates. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.10 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v2.6.0 release of [production-ready](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready), which adds first-class consumption of the [Google Labs `DESIGN.md`](https://github.com/google-labs-code/design.md) format as the canonical design-system token source for dashboards. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `DESIGN.md` format and the consumption flow (production-ready Step 3 sub-step 3a). Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.9 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v1.1.0 release of [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) and the v1.6.10 release of [repo-ready](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready), both of which add first-class support for the [`AGENTS.md`](https://agents.md/) cross-tool agent-brief standard (Linux Foundation Agentic AI Foundation). kickoff-ready now emits a project-root `AGENTS.md` mapping the suite's artifact paths when none exists; repo-ready scaffolds `AGENTS.md` as the canonical agent brief with `CLAUDE.md` as a thin overlay or symlink. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `AGENTS.md` standard, the harnesses that read it, and the two specialists (kickoff-ready, repo-ready) that meet that surface. Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.8 (2026-05-06)

Documentation-only patch. Adds first-class support for [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) and [OpenClaw](https://github.com/openclaw/openclaw) via the [Agent Skills standard](https://agentskills.io). The suite now positions explicitly as agentskills.io-compatible: any harness that parses `SKILL.md` frontmatter natively runs every ready-suite skill first-class, with no per-tool integration. pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support for free.

### Changed

- **Frontmatter**: `compatible_with` now lists `pi`, `openclaw`, and `any-agentskills-compatible-harness` (the latter replaces the older `any-agent-with-skill-loading` value for tighter standards-level signaling).
- **SUITE.md**: install-locations table adds rows for pi, OpenClaw, and the neutral Agent Skills path; new "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).
- **Hub install.sh / uninstall.sh** (in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)): detect pi (`~/.pi/`) and OpenClaw (`~/.openclaw/`), write to the neutral `~/.agents/skills/` path. No regressions on the existing Claude Code / Codex / Cursor flow.

### Why a patch, not a minor

The skill's behavior, references, and workflow are unchanged. Only the frontmatter `compatible_with` list, `SUITE.md`, and the README install section move; the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only standards-compliance signaling.

---


## v1.0.7 (2026-05-06)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the new **orchestration** tier and the eleventh sibling, [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) v1.0.0. kickoff-ready sequences the ten core-suite specialists for greenfield projects from raw user intent: it triggers from a fresh idea ("kickoff," "I have an idea help me ship it") and invokes prd-ready -> architecture-ready -> roadmap-ready -> stack-ready -> repo-ready -> production-ready -> deploy-ready -> observe-ready -> (launch-ready || harden-ready), verifying each artifact on disk before advancing. It produces only `.kickoff-ready/PROGRESS.md`; it never produces specialist content. No behavioral changes to this skill.

### Changed

- **SUITE.md**: new "orchestration" tier introduced as the first column of the four-tier diagram; new kickoff-ready row in the per-skill table; updated dependency-flow text; new composition principle 8 ("Orchestration is one-way: kickoff-ready knows about specialists; specialists do not know about kickoff-ready"); known-good versions table now lists eleven skills.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.6 (2026-04-24)

Documentation-only patch. Removes the Mirror Box dogfood track from the ready-suite. The aihxp/mirror-box repo has been archived; the canonical-dogfood section in SUITE.md is gone; per-skill dogfood/ folders are deleted.

### Changed

- **SUITE.md** no longer carries the "Canonical dogfood target: Mirror Box" section. Byte-identical sync across all ten siblings.
- **dogfood/** folder removed from this repo.

### Why

The Mirror Box reference implementation required real infrastructure (Fastify + OTel + Fly.io + Honeycomb account) to fully exercise. The user wanted a skill suite, not a project that demands a particular hosted stack. Removing Mirror Box restores that posture: every skill stands on its own SKILL.md plus references; downstream consumers compose via the artifact contracts the skills describe, without depending on a shared hosted exemplar.

The interop standard is unchanged. Skills still produce `.{skill}-ready/*.md` artifacts; downstream siblings still read them. The contract holds without a canonical demo.

---


## v1.0.5 (2026-04-24)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the canonical dogfood target: [aihxp/mirror-box](https://github.com/aihxp/mirror-box). Adds a new "Canonical dogfood target" section to SUITE.md with links to the ten per-skill dogfood artifacts. Adds composition principle #7 codifying the byte-identical-SUITE.md invariant across siblings. No behavioral changes to the skill.

### Changed

- **SUITE.md**: new "Canonical dogfood target: Mirror Box" section with artifact links.
- **SUITE.md**: composition principles now include #7 (byte-identical SUITE.md across siblings).
- **SUITE.md**: version table bumped; all ten skills reflect the coordinated sync.

### Why a patch, not a minor

Same rationale as prior x.y.z patches: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.4 (2026-04-23)

Documentation-only patch. Reflects the arrival of `harden-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/harden-ready) as a live sibling in the ready-suite. harden-ready is the tenth and final core-suite skill; its v1.0.0 release completes the shipping tier alongside deploy-ready, observe-ready, and launch-ready, and completes the ready-suite across planning (four), building (two), and shipping (four) tiers. harden-ready owns post-deploy adversarial review, OWASP Top 10 walkthroughs (Web / API / LLM), compliance control-to-code mapping (SOC 2 / HIPAA / PCI-DSS / GDPR), pen-test preparation and retest discipline, responsible-disclosure program design beyond SECURITY.md, and class-not-instance post-incident hardening. No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `harden-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.4. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.3 (2026-04-23)

Documentation-only patch. Reflects the arrival of `roadmap-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/roadmap-ready) as a live sibling in the ready-suite. This release completes the nine-skill suite: `prd-ready` (what), `architecture-ready` (how), `roadmap-ready` (when), `stack-ready` (with what tools), `repo-ready` (the repo), `production-ready` (the app), `deploy-ready` (ship it), `observe-ready` (keep it healthy), `launch-ready` (tell the world). No behavioral changes to this skill.

### Changed

- **`SUITE.md`** updated to list `roadmap-ready` at 1.0.0 alongside the coordinated one-patch bump across every live sibling. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.3. No content change beyond the version tag.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling `SUITE.md` is touched to track a new sibling's release. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

## v1.0.2 (2026-04-23)

Documentation-only patch. Reflects the arrival of `architecture-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/architecture-ready) as a live sibling in the ready-suite. architecture-ready is a new planning-tier sibling; launch-ready's customer-facing positioning can reference the architectural posture named in ARCH.md (e.g., 'single-tenant enterprise deploy' vs. 'multi-tenant SaaS'). No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list architecture-ready at 1.0.0. Every sibling's recorded version is bumped one patch to track the release. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.2. No content change beyond the version tag.

All notable changes to this skill are documented here. Format loosely follows [Keep a Changelog](https://keepachangelog.com/). Version numbers follow the ready-suite discipline: major for breaking skill-contract changes, minor for additive behavior changes, patch for documentation-only updates (including sibling-ship tracking in SUITE.md).

## v1.0.1 (2026-04-23)

Documentation-only patch. Reflects the arrival of `prd-ready` v1.0.0 (https://github.com/aihxp/ready-suite/tree/main/skills/prd-ready) as a live sibling in the ready-suite. This release completes the top of the planning tier: prd-ready defines WHAT we are building, upstream of architecture-ready (HOW), roadmap-ready (WHEN), and stack-ready (WITH WHAT TOOLS). No behavioral changes to the skill.

### Changed

- **`SUITE.md`** updated to list prd-ready at 1.0.0 alongside production-ready 2.5.6, repo-ready 1.6.2, stack-ready 1.1.5, deploy-ready 1.0.4, observe-ready 1.0.3, and launch-ready 1.0.1. Copy remains byte-identical across every live sibling.
- **SKILL.md frontmatter version** bumped to 1.0.1. No content change beyond the version tag.

## v1.0.0 (2026-04-23)

First stable release of launch-ready, the shipping-tier skill that owns "tell the world the product exists" in the [ready-suite](SUITE.md). This is also the release that completes the shipping tier alongside deploy-ready 1.0.1 and observe-ready 1.0.0. Ships with the full SKILL.md contract, eleven reference files, a 10,300-word research report backing every guardrail, and full interop-standard frontmatter. Walked against a realistic solo-dev scenario (Node + Fly.io microSaaS receiving a landing page, waitlist, OG cards, and a Show HN draft) before cut; rough edges surfaced during the walk are addressed below.

### The skill's six named failure modes

launch-ready introduces six terms the ecosystem did not already have a clean name for. Each maps to a specific class of AI-generated launch output that the skill refuses (citations in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md)).

- **Hero-fatigue copy.** A hero sentence that survives the substitution test with a named competitor swapped in. The sentence is syntactically correct and says nothing specific. "Empower your team with AI-powered productivity" describes the category, not the product. The most common positioning failure in AI-assisted launches.
- **Spec-sheet positioning.** A feature grid that reads as a product spec: category labels ("Fast / Secure / Scalable") rather than product-specific capabilities; more than six tiles; no differentiator threaded through.
- **AI-slop landing.** The full aesthetic signature: gradient hero, shadcn card grid, Inter typography, pastel icon blobs, three-column features, gradient CTA buttons, testimonial carousel. Conversion Haus, AXE-WEB, and Overpass Studio have each published teardowns of this pattern. The cousin of deploy-ready's "paper canary" and observe-ready's "paper SLO" across shipping-tier siblings.
- **Paper waitlist.** A waitlist that captures emails with no double opt-in, no welcome email, no pre-launch sequence, no launch-day drop, and no post-launch follow-through. The form works; the funnel does not.
- **Unrendered OG.** An Open Graph card that renders correctly on the developer's laptop and breaks on one or more of the five channels (X, LinkedIn, Slack, iMessage, Discord) that real users will see it through. LinkedIn's 7-day cache turns a launch-day bug into a launch-week liability.
- **Silent launch.** A launch with no UTM-tagged share links and no conversion-waterfall events. Signups arrive; the founder cannot attribute them to source; the retrospective cannot diagnose which of the five launch-failure causes dominated.

### Core principle: the substitution test

The skill's load-bearing discipline is the substitution test, applied sentence by sentence to every user-facing surface the launch ships:

> Every user-facing sentence, image, and asset must fail the substitution test: if a direct competitor's name could be swapped in without the sentence becoming false or absurd, the sentence is not specific enough to ship.

The test catches hero-fatigue copy, spec-sheet feature headlines, AI-slop OG captions, launch-post first lines, and email subject lines. It is the grep-testable discipline that prevents the AI-slop landing pattern from shipping.

### What ships

- **SKILL.md** with the ready-suite interop standard: eleven frontmatter fields populated, six required sections present. Thirteen-step workflow (Step 0 through Step 12), four completion tiers (Positioned, Landed, Captured, Launched) totaling 20 requirements, a grep-testable have-nots list, a session state template, explicit consume/produce contracts with sibling skills.
- **Eleven reference files** under `references/`. Load-on-demand table annotates each with the step or tier that loads it.
  - `launch-research.md`. Step 0 five-mode detection protocol (A greenfield, B AI-slop rewrite, C relaunch, D rescue, E quiet B2B), launch-failure dominant-cause diagnosis, common misdiagnoses, resume protocol.
  - `positioning-and-copy.md`. Step 1 substitution test with procedure and examples, April Dunford's four-sentence positioning document adapted from *Obviously Awesome*, tone-of-voice frame, Step 3 banned-word audit with 17-word v1.0.0 list and replacement strategies, founder-voice vs. company-voice rule, edge cases.
  - `landing-page-anatomy.md`. Five canonical sections (hero, social proof, feature grid, pricing, CTA) in strict order, above-the-fold discipline for 1366x768 and 390x844 viewports, visual identity tokens (one brand color, two grays, typefaces, icon library), the aesthetic test with a naive viewer, shadcn-default anti-pattern catalog, hero and sub-hero copy patterns, accessibility and performance.
  - `seo-fundamentals.md`. Twelve launch-day gates with hard blocks, Open Graph and Twitter Card tag specs, schema.org Organization and SoftwareApplication JSON-LD templates, robots.txt and sitemap.xml discipline, Core Web Vitals thresholds for 2026 (LCP <2.5s, CLS <0.1, INP <200ms), the stray-noindex grep.
  - `social-share-cards.md`. The five-channel preview rule (X, LinkedIn, Slack, iMessage, Discord), cache TTL traps (LinkedIn 7 days documented), OG image spec (1200x630, <300KB, legible at half size), four content patterns, generation tool landscape (@vercel/og, Tailgraph, Bannerbear, Cloudinary, Figma export), Twitter Card Validator deprecation status.
  - `waitlist-and-email.md`. Ten-tool comparison matrix (Kit, Loops, Resend, Plunk, Beehiiv, EmailOctopus, Buttondown, MailerLite, Mailchimp, Substack), double-opt-in discipline with the "not actually legally required except Germany/Austria" nuance, confirmation and welcome email templates, three-to-four-email pre-launch sequence, launch-day drop with UTM and timing rules, three-email post-launch sequence, SPF/DKIM/DMARC discipline with mail-tester.com gating.
  - `launch-channels.md`. Per-channel etiquette for Product Hunt (2025 algorithm changes documented; only ~10% of submissions get Featured), Hacker News (Show HN title rules, the "Launch HN" restriction, submitter-account quality), Reddit (9:1 rule), X / Twitter (seven-tweet thread structure, no hashtags in 2026), LinkedIn (founder-voice, link in first comment), Indie Hackers (milestone format with numbers), dev.to (tutorial-shaped). Channel-selection matrix by product type.
  - `press-and-outreach.md`. Press-kit contents, 2026 press-landscape reality (TechCrunch shrinkage, niche newsletters dominant), target categories (TLDR variants, Pragmatic Engineer, Changelog, etc.), HARO / Qwoted / Connectively landscape post-2024 shutdown and relaunch, one-paragraph pitch email template, influencer outreach format, podcast outreach timing.
  - `launch-telemetry.md`. UTM taxonomy with five-parameter discipline and registry file, analytics tool selection (Plausible, Fathom, Umami, PostHog, GA4), five-event conversion waterfall (landing_view, cta_click, signup_submit, email_confirmed, activation), live referrer dashboard, traffic-spike readiness (static vs. SSR, database connection-pool failure mode from published postmortems), status-page requirement with observe-ready independence coupling.
  - `launch-week-runbook.md`. D-7 to D+7 calendar with pass criteria per day, D-0 hour-by-hour Pacific-time schedule (12:01 AM PH, 7 AM Show HN, 8:30 AM X thread, 9 AM LinkedIn, 10 AM-1 PM Reddit staggered, 11 AM waitlist drop), pre-written response-template library for common PH / HN / Reddit questions, timezone-aware scheduling variants for US Eastern / European / Asian / Australian founders, the no-change rule.
  - `post-launch-transition.md`. Transition criteria (D+7 complete, traffic within 3x baseline, waitlist segmented, retrospective written), internal and external retrospective templates, post-launch 1:1 outreach to the hot 10%, second-launch timing (6-12 weeks minimum), dominant-cause-driven remediation paths.
- **Research report** (`references/RESEARCH-2026-04.md`, 10,300 words, 733 lines). Covers: the three founder-failure archetypes (no traction, viral-but-crashed, shipped-with-no-positioning) with named Indie Hackers postmortems; the AI-slop landing aesthetic critique from Conversion Haus, AXE-WEB, Overpass Studio, and Bryant Chou's writeups; the consolidated banned-word list from Content Beta (300+ words), FOMO.ai, OneSecMedia, and Matrix Group; April Dunford's positioning framework; Julian Shapiro's landing-page guide and Harry Dry's Marketing Examples; Unbounce 2024 SaaS conversion benchmarks (3.8% median, 514% conversion gap attributable to reading level); Google Search Central 2026 ranking signals and schema.org type definitions; LinkedIn's explicit 7-day OG cache documentation; the Twitter Card Validator deprecation (2022, no official replacement); waitlist-tool landscape with Beehiiv double-opt-in deliverability data; Product Hunt 2025 algorithm analysis (Awesome Directories, Flowjam); Show HN etiquette and the Aidlab postmortem; launch-day traffic-spike postmortems (SadServers, iDiallo, Stan.sh, Gatling); HARO / Qwoted / Connectively landscape post-2024; Pieter Levels' and Marc Lou's published launch playbooks; Arvid Kahl's post-launch writing.
- **SUITE.md** at repo root listing launch-ready at 1.0.0 alongside production-ready 2.5.3, stack-ready 1.1.2, deploy-ready 1.0.1, and observe-ready 1.0.0 (sibling copies bumped as patches on this release).
- **README.md** with install paths for Claude Code, Codex, Cursor, Windsurf; the "what this skill prevents" incident-to-enforcement mapping across 16 failure patterns; reference-library index; six-named-terms section.

### Refinements from the dogfood walk

A pre-release walk against a realistic solo-dev Fly.io microSaaS scenario (Node API with a landing page at the same hostname, a real waitlist on Loops free tier, OG cards generated via @vercel/og, a Show HN post draft, and a D-7 to D+7 runbook on Google Calendar) surfaced the following, addressed in v1.0.0:

- **Mode B ("AI-slop landing exists") ordering.** Early drafts of the workflow ran substitution test after landing-page anatomy (Step 2 before Step 1's test). The walk surfaced that Mode B users already have a page; running anatomy first reinforces the shadcn-default structure and then re-discovers it in Step 3's banned-word pass. The v1.0.0 ordering puts the substitution test in Step 1 as a gate on the existing copy before any structural work.
- **LinkedIn cache TTL as a five-channel preview gate.** The walk confirmed a founder who iterates hero copy between D-14 and D-0 and shares on LinkedIn early will ship with a broken preview unless the refresh is explicit. Step 6 now requires LinkedIn Post Inspector pre-clearance as a named sub-gate, not just a "previewed" checkmark.
- **Double opt-in framed as deliverability, not compliance.** Initial drafts framed double opt-in as a legal requirement. Research surfaced the nuance: it is not legally required anywhere in the EU except Germany and Austria via case law, and CAN-SPAM / CASL do not require it. v1.0.0 frames double opt-in as a deliverability requirement (Beehiiv's 35.7% vs. 27.4% open-rate gap) with legal notes secondary.
- **UTM registry as a file.** Early drafts had UTM discipline as a rule. The walk surfaced that discipline without a file fails: campaigns collide, value spellings drift (`producthunt` vs. `product_hunt`). v1.0.0 requires `.launch-ready/utm-registry.md` as a produced artifact.
- **Paper-waitlist definition tightened.** Initial definition was "captures without nurture." The walk surfaced ambiguity; a founder might count one post-confirmation email as a "nurture sequence." v1.0.0 names six explicit criteria for the paper-waitlist refusal (no double opt-in, no confirmation, no welcome, no pre-launch sequence, no launch-day drop, no post-launch sequence, SPF/DKIM/DMARC failing). Any one fails the skill's contract.
- **The substitution test as a grep-testable list.** Initial drafts described the test conceptually. The walk surfaced that agents benefited from an explicit list of surfaces (hero, sub-hero, feature headlines, feature descriptions, pricing tier labels, CTA text, OG title, meta title, meta description, waitlist form headline, waitlist confirmation subject, welcome email subject, launch-day email subject, PH tagline, Show HN title, LinkedIn first line). v1.0.0 includes the full list at the top of `positioning-and-copy.md`.
- **The paper-canary / paper-SLO naming kinship acknowledged.** The walk surfaced that the three shipping-tier skills share a naming convention for the "artifact present, mechanism absent" class of failure: paper canary (deploy-ready), paper SLO and blind dashboard and paper runbook (observe-ready), paper waitlist and unrendered OG and silent launch (launch-ready). v1.0.0 makes the kinship explicit in both SKILL.md and CHANGELOG.

### Compatibility

- Claude Code (primary)
- Codex
- Cursor
- Windsurf (manual SKILL.md upload)
- Any agent with skill loading

### Suite siblings at release

- production-ready 2.5.3 (patch bumped to 2.5.4 for SUITE.md table update)
- stack-ready 1.1.2 (patch bumped to 1.1.3 for SUITE.md table update)
- deploy-ready 1.0.1 (patch bumped to 1.0.2 for SUITE.md table update)
- observe-ready 1.0.0 (patch bumped to 1.0.1 for SUITE.md table update)
- repo-ready (live, see its own CHANGELOG)

Planned siblings (not yet released): prd-ready, architecture-ready, roadmap-ready.

The shipping tier is complete at this release: deploy-ready ships it, observe-ready keeps it healthy, launch-ready tells the world.

## v3.0.0 (2026-05-14)

Suite-wide release train alignment. This major release stabilizes the monorepo distribution model, synchronized Claude plugin packaging, strict trigger routing, Pillars project-context integration, and release hygiene for the eleven-skill suite.

### Changed
- Aligns this skill with the ready-suite 3.0.0 release train.
- Keeps the skill's existing artifact paths and trigger ownership intact while publishing the shared major version.

### Why a major
This is a coordinated suite release: all eleven skills, the ready-suite meta plugin, and the marketplace metadata now move together for the 3.0.0 train.

---

# Changelog

## v1.0.13 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.7.0 release that adds Mode D (Multi-repo suite) to repo-ready workflow. This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.12 (2026-05-09)

Documentation patch. Adds `references/harden-antipatterns.md`, the named-failure-mode catalog this skill refuses, with grep tests, severity ladder, and per-skill guards. Closes one of the seven gaps named in MAINTAINING.md \"known-but-not-fixed inconsistencies\" (six skills lacked dedicated antipatterns files; this patch addresses the seventh in the same coordinated sweep).\n\n### Added\n\n- **`references/harden-antipatterns.md`** (~150 lines): named patterns extracted from the skill SKILL.md \"have-nots\" section, formatted with shape (concrete example), grep test (mechanical detection), severity (Critical / High / Medium / Low), guard (where the workflow catches it). Loaded on demand at every tier-gate check and during Mode C audits.\n- **Reference table row**: SKILL.md gains the new entry.\n\n### Changed\n\n- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.\n\n### Why a patch, not a minor\n\nAdditive reference content; SKILL.md body and frontmatter contract unchanged.\n\n---\n\n

## v1.0.11 (2026-05-09)

Documentation-only patch. Recovery sync after the just-retired v2.5.12 precedent. The repo-ready v1.6.15 release (which itself triggered the precedent retirement in MAINTAINING.md) shipped with the OLD SUITE.md committed; the catch-up sync to the other 10 siblings happened afterward in a separate hub commit, but the lint workflow correctly flagged the resulting drift. This patch lands the byte-identical SUITE.md across all 12 repos with the full version table current to all 11 specialists.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to the post-retirement state across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking; mechanical recovery from the lint-caught drift.

---


## v1.0.10 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the repo-ready v1.6.15 audit-refresh release. The v2.5.12 precedent (single-specialist patches do not trigger full SUITE.md sync) is retired effective this patch: the hub `scripts/lint.sh` `suite-md-sync` check enforces byte-identical `SUITE.md` across all 12 repos, so every specialist version bump (including audit-report refreshes that bump only one specialist) now triggers a full coordinated sync.

This skill SKILL.md, references library, and frontmatter contract are unchanged.

### Changed

- **SUITE.md**: known-good versions table catches up to repo-ready 1.6.15 across all 12 repos.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.9 (2026-05-09)

Hygiene cleanup. Updates `.gitignore` to prevent accidental commits of `.claude/settings.local.json` (Claude Code personal local-override files; the `.local` suffix is the convention for "do not commit") and `.planning/` (GSD development artifacts). SUITE.md sync.

### Changed

- **`.gitignore`**: added `.claude/settings.local.json` and `.planning/` patterns.
- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Gitignore additions + SUITE.md sync; no behavior change.

---


## v1.0.8 (2026-05-09)

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


## v1.0.7 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the four planning-tier skill releases (prd-ready v1.0.10, architecture-ready v1.0.9, roadmap-ready v1.0.8, stack-ready v1.1.15) which add worked-example reference files for a single fictional B2B SaaS product (Pulse, a Customer Success ops platform). The four examples cross-reference each other to demonstrate the suite's compose-by-artifact principle: each downstream artifact reads from the prior one and refines, never duplicates. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

Documentary-only sibling-ship tracking.

---


## v1.0.6 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v2.6.0 release of [production-ready](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready), which adds first-class consumption of the [Google Labs `DESIGN.md`](https://github.com/google-labs-code/design.md) format as the canonical design-system token source for dashboards. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `DESIGN.md` format and the consumption flow (production-ready Step 3 sub-step 3a). Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.5 (2026-05-09)

Documentation-only patch. Suite-wide `SUITE.md` sync for the v1.1.0 release of [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) and the v1.6.10 release of [repo-ready](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready), both of which add first-class support for the [`AGENTS.md`](https://agents.md/) cross-tool agent-brief standard (Linux Foundation Agentic AI Foundation). kickoff-ready now emits a project-root `AGENTS.md` mapping the suite's artifact paths when none exists; repo-ready scaffolds `AGENTS.md` as the canonical agent brief with `CLAUDE.md` as a thin overlay or symlink. This skill's behavior, frontmatter contract, and reference library are unchanged.

### Changed

- **SUITE.md**: new compatibility paragraph in the Standards section names the `AGENTS.md` standard, the harnesses that read it, and the two specialists (kickoff-ready, repo-ready) that meet that surface. Known-good versions table bumped for the coordinated patch sweep.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.4 (2026-05-06)

Documentation-only patch. Adds first-class support for [pi](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent) and [OpenClaw](https://github.com/openclaw/openclaw) via the [Agent Skills standard](https://agentskills.io). The suite now positions explicitly as agentskills.io-compatible: any harness that parses `SKILL.md` frontmatter natively runs every ready-suite skill first-class, with no per-tool integration. pi and OpenClaw both load skills from the neutral `~/.agents/skills/` path defined by the standard, so future AgentSkills-compatible harnesses inherit support for free.

### Changed

- **Frontmatter**: `compatible_with` now lists `pi`, `openclaw`, and `any-agentskills-compatible-harness` (the latter replaces the older `any-agent-with-skill-loading` value for tighter standards-level signaling).
- **SUITE.md**: install-locations table adds rows for pi, OpenClaw, and the neutral Agent Skills path; new "Standards" section names the standard and the verified harnesses (Claude Code, Codex, Cursor, Windsurf, pi, OpenClaw).
- **Hub install.sh / uninstall.sh** (in [aihxp/ready-suite](https://github.com/aihxp/ready-suite)): detect pi (`~/.pi/`) and OpenClaw (`~/.openclaw/`), write to the neutral `~/.agents/skills/` path. No regressions on the existing Claude Code / Codex / Cursor flow.

### Why a patch, not a minor

The skill's behavior, references, and workflow are unchanged. Only the frontmatter `compatible_with` list, `SUITE.md`, and the README install section move; the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only standards-compliance signaling.

---


## v1.0.3 (2026-05-06)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the new **orchestration** tier and the eleventh sibling, [kickoff-ready](https://github.com/aihxp/ready-suite/tree/main/skills/kickoff-ready) v1.0.0. kickoff-ready sequences the ten core-suite specialists for greenfield projects from raw user intent: it triggers from a fresh idea ("kickoff," "I have an idea help me ship it") and invokes prd-ready -> architecture-ready -> roadmap-ready -> stack-ready -> repo-ready -> production-ready -> deploy-ready -> observe-ready -> (launch-ready || harden-ready), verifying each artifact on disk before advancing. It produces only `.kickoff-ready/PROGRESS.md`; it never produces specialist content. No behavioral changes to this skill.

### Changed

- **SUITE.md**: new "orchestration" tier introduced as the first column of the four-tier diagram; new kickoff-ready row in the per-skill table; updated dependency-flow text; new composition principle 8 ("Orchestration is one-way: kickoff-ready knows about specialists; specialists do not know about kickoff-ready"); known-good versions table now lists eleven skills.

### Why a patch, not a minor

The skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched and the version + updated frontmatter fields tick. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

---


## v1.0.2 (2026-04-24)

Documentation-only patch. Removes the Mirror Box dogfood track from the ready-suite. The aihxp/mirror-box repo has been archived; the canonical-dogfood section in SUITE.md is gone; per-skill dogfood/ folders are deleted.

### Changed

- **SUITE.md** no longer carries the "Canonical dogfood target: Mirror Box" section. Byte-identical sync across all ten siblings.
- **dogfood/** folder removed from this repo.

### Why

The Mirror Box reference implementation required real infrastructure (Fastify + OTel + Fly.io + Honeycomb account) to fully exercise. The user wanted a skill suite, not a project that demands a particular hosted stack. Removing Mirror Box restores that posture: every skill stands on its own SKILL.md plus references; downstream consumers compose via the artifact contracts the skills describe, without depending on a shared hosted exemplar.

The interop standard is unchanged. Skills still produce `.{skill}-ready/*.md` artifacts; downstream siblings still read them. The contract holds without a canonical demo.

---


## v1.0.1 (2026-04-24)

Documentation-only patch. Suite-wide SUITE.md refresh introducing the canonical dogfood target: [aihxp/mirror-box](https://github.com/aihxp/mirror-box). Adds a new "Canonical dogfood target" section to SUITE.md with links to the ten per-skill dogfood artifacts. Adds composition principle #7 codifying the byte-identical-SUITE.md invariant across siblings. No behavioral changes to the skill.

### Changed

- **SUITE.md**: new "Canonical dogfood target: Mirror Box" section with artifact links.
- **SUITE.md**: composition principles now include #7 (byte-identical SUITE.md across siblings).
- **SUITE.md**: version table bumped; all ten skills reflect the coordinated sync.

### Why a patch, not a minor

Same rationale as prior x.y.z patches: the skill's behavior, frontmatter contract, and reference library are unchanged. Only the cross-sibling SUITE.md is touched. Per the suite versioning discipline, patch-level is the honest bucket for documentary-only sibling-ship tracking.

All notable changes to this skill are documented here. Format loosely follows [Keep a Changelog](https://keepachangelog.com/). Version numbers follow the ready-suite discipline: major for breaking skill-contract changes, minor for additive behavior changes, patch for documentation-only updates (including sibling-ship tracking in SUITE.md).

## v1.0.0 (2026-04-23)

First stable release of harden-ready, the shipping-tier skill that owns "survive adversarial attention and prove it to an auditor" in the [ready-suite](SUITE.md). This is the tenth and final core-suite skill; its v1.0.0 release completes the suite across planning (four), building (two), and shipping (four) tiers. Ships with the full SKILL.md contract, eleven reference files, a ~33K-token research report backing every guardrail, and full interop-standard frontmatter. Walked against a realistic solo-dev Mirror Box scenario (Supabase-backed SaaS receiving its pre-launch security review) before cut; rough edges surfaced during the walk are addressed below.

### The skill's seven named failure modes

harden-ready introduces seven terms the ecosystem did not have a clean name for, plus adopts five taken-term vocabulary items cited and attributed (not claimed). Each maps to a specific class of AI-generated-app security output that the skill refuses (citations in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md) Section 1).

- **Scanner-first security.** The scanner's output IS the hardening posture; anything the scanner did not find is assumed absent. Veracode 45% base-rate, Snyk 80% developer-bypass, and Lovable CVE-2025-48757 are the rebuttals. The most common failure mode in AI-generated codebases passing CI without adversarial review.
- **Paper trust boundary.** A trust boundary declared in the threat model or architecture diagram, not enforced in code, configuration, or network policy. Extends the ready-suite's paper family (observe-ready's paper SLO / blind dashboard / paper runbook; deploy-ready's paper canary; launch-ready's paper waitlist / unrendered OG). Lovable CVE-2025-48757 is the canonical incident.
- **Hardening-as-ritual.** Annual pen test, nothing between; or quarterly vulnerability scan treated as the control rather than the signal. The flagship negative name.
- **Compliance-without-security.** Every checklist item passes; the application is still exploitable via its front page. SOC 2 Type II reports describing controls in place while the production app has BOLA on its main API.
- **Pre-audit panic.** Hardening activity that only appears on the audit calendar, lapses immediately after, resumes next cycle. Subordinate to hardening-as-ritual.
- **Shallow-audit trap.** An audit that only finds what automated tools surface, missing the manual-review layer that catches the attacker's actual path.
- **CVE-of-the-week.** Reacting to each CVE as it lands without investing in the class of weakness that produced them. The Log4Shell 2.15 / 2.16 / 2.17 / 2.17.1 patch sequence is the textbook demonstration.

Vocabulary quoted and attributed, not claimed: **security theater** (Schneier), **compliance theater** (Chuvakin, Shortridge), **the lethal trifecta** (Willison), **Agents Rule of Two** (Meta 2025), **checklist rot** (Vehent).

### Core principle: every compliance claim and every scanner finding is verified by an adversarial read, or it is refused

The load-bearing discipline is that a security posture is what an attacker cannot do, not what a tool reports, what a checklist claims, or what a policy declares:

> Every compliance control is mapped to a specific file, configuration, or log artifact that implements it. Every scanner finding that is "accepted risk" has the acceptance justified with a named risk owner and an expiration date. Every trust boundary in the architecture diagram is verified enforced in code, configuration, or network policy. Every finding shipped in the hardening report is actionable: title, severity with justification, affected asset, reproduction steps, impact, root cause, proposed fix with a code example, regression prevention, retest plan, references.

### What ships

- **SKILL.md** with the ready-suite interop standard: eleven frontmatter fields populated, six required sections present. Fourteen-step workflow (Step 0 through Step 13), four completion tiers (Inventoried, Audited, Hardened, Accountable) totaling 20 requirements, a grep-testable have-nots list of 20+ items, a session-state template, explicit consume / produce contracts with sibling skills.
- **Eleven reference files** under `references/`. Load-on-demand table annotates each with the step or tier that loads it.
  - `harden-research.md`. Step 0 five-mode detection protocol (A pre-launch, B pre-audit, C post-incident, D continuous, E pre-pen-test), attack-surface-inventory procedure, where-to-look-first heuristic, research-report index.
  - `owasp-walkthrough.md`. Step 3 systematic walk of OWASP Web 2021, API 2023, LLM 2025 with manual test per category, scanner-gap analysis, reproduction payloads, cross-cutting checklist for AI-generated apps.
  - `auth-hardening.md`. Step 4 session-fixation deep verification, CSRF SameSite-Lax-bypass-via-cookie-refresh (PortSwigger 2024-2025), OAuth flow attacks (PKCE, state, implicit deprecation, redirect_uri exact-match, aud validation), JWT pitfalls (alg:none, algorithm confusion, weak HMAC, missing claims, JWKS jku, 2025 CVE-2025-4692/30144/27371), passkey/WebAuthn pitfalls (BE/BS flags, attestation, recovery, enumeration), BOLA deep audit, confused-deputy, multi-tenant DB-layer verification, step-up auth, admin audit trail.
  - `api-hardening.md`. Step 5 rate-limit algorithm (token bucket vs leaky vs sliding window vs fixed), key selection with IPv6 /64 trap, GraphQL attack surface (nested, alias, cost, introspection, batch), mass-assignment / BOPLA, input validation beyond shape, webhook HMAC with constant-time and replay, file-upload adversarial depth, idempotency-key verification, admin function-level authz, request-size limits, error-response leakage, verbose HTTP methods.
  - `crypto-primitives.md`. Step 6 Latacora Cryptographic Right Answers 2018 and PQ Edition 2024 distilled; AEAD versus raw encryption; AES-GCM vs ChaCha20-Poly1305 vs XChaCha20-Poly1305; nonce/IV reuse catastrophes; Argon2id parameters (19 MiB, t=2, p=1); signature schemes (Ed25519 default, ECDSA with RFC 6979, RSA-PSS 3072+); TLS configuration; key management (KMS, envelope encryption, rotation cadence); CNSA 2.0 post-quantum timeline (2025 preferred, 2027 new NSS, 2030 code signing, 2033 web/cloud, 2035 full); constant-time comparison.
  - `compliance-frameworks.md`. Step 7 control-to-code mapping for SOC 2 Common Criteria (CC1-CC9), HIPAA 164.312 Technical Safeguards (access control, audit, integrity, authentication, transmission), PCI-DSS 4.0 (12 principal requirements, notable v4.0 deltas including Req 6.4.3 Magecart and Req 8.3.1 MFA expansion), GDPR Article 32 (four examples plus risk-based proportionality). Cross-framework high-leverage-nine table showing the control overlap that dominates audits. Compliance-without-security traps called out per framework.
  - `security-tooling-landscape.md`. Step 8 SAST (Semgrep, CodeQL, Snyk Code, Checkmarx, Veracode, SonarQube, DryRun); DAST (ZAP, Burp, Acunetix, Invicti, StackHawk); SCA (Snyk, Socket, Dependabot, Renovate, OSV-Scanner, Chainguard, StackLok); IAST (Contrast, Seeker); container (Trivy, Grype, Docker Scout, Wiz); IaC (Checkov, tfsec, KICS, Snyk IaC); secret scanning (GitGuardian, TruffleHog, GitHub); SBOM (Syft, CycloneDX, SPDX); runtime (Falco, Tetragon, Datadog, Wiz); WAF (Cloudflare, Fastly, AWS, Imperva, Akamai); PTaaS (Cobalt, HackerOne, Synack, Bugcrowd); bug-bounty platforms; DSPM (Wiz, Orca, Lacework, Prisma, Defender). What each catches, what each misses, workflow invocation point.
  - `pentest-prep.md`. Step 9 scope document, rules of engagement per PTES / SANS, stage-specific posture (pre-launch / Series A / late-stage / compliance-driven), vendor comparison table (Cobalt $10K-$50K, HackerOne $15K-$75K, Synack $30K-$150K, Trail of Bits $50K-$300K+, Doyensec / NCC Group / Include / Bishop Fox tiers), deliverables expected, retest discipline with the "un-retested is not remediated" rule, between-engagement discipline bridging annual cadence, `.harden-ready/pentest/` directory structure.
  - `responsible-disclosure.md`. Step 10 RFC 9116 security.txt with required and recommended fields, policy page template, safe harbor via disclose.io templates, severity vocabulary (CVSS 3.1 and 4.0, EPSS v4, CISA KEV composite, the 28%-exploited-at-medium-CVSS finding), triage SLA (48h acknowledgment, severity-tiered fix SLA), coordinated disclosure timelines (Project Zero 90+30, CERT/CC 45-day, ZDI 120-day, CISA KEV-driven), Lovable 48-day cautionary case, bug-bounty economics ($81M paid 2025, severity distribution, AI-specific 540% prompt-injection YoY, 95% researcher quit rate), VDP-vs-private-vs-public matrix, stage-appropriate posture, test-the-program-before-live verification.
  - `post-incident-hardening.md`. Step 13 instance-class-classOfClasses discipline with five worked examples (Log4Shell 4-CVE patch sequence; xz-utils maintainer-compromise; SolarWinds build-pipeline; Replit 2025 excessive-agency; Lovable RLS paper-trust-boundary). `.harden-ready/CLASS-FIXES.md` registry template with two worked examples. Cross-reference to sibling skills for implementation handoffs.
  - `actionable-findings.md`. Steps 11 and 12 F-NN finding template with every section required (severity with CVSS + EPSS + KEV, affected asset, description, reproduction, impact, root cause, proposed fix with code example, regression prevention, retest, references), generic-finding anti-pattern identified, canon examples (Trail of Bits, Doyensec, NCC Group, Latacora formats), severity assignment rubric, retest workflow, findings index table, multi-pass convergence signals, two worked examples (BOLA written well vs badly), grep-testable actionability check.
- **Research report** (`references/RESEARCH-2026-04.md`, ~22K words, ~33K tokens). Twelve sections plus seven appendices:
  - Section 1: Named failure modes with SEO-lane analysis and adoption recommendations.
  - Section 2: The 2025-2026 AI codebase security incident catalog: Replit 2025 DB wipe, Lovable CVE-2025-48757, Moltbook/Vercel/Copilot cluster, Base44 (rumor-marked), Veracode 2025 GenAI report, slopsquatting (Socket 2025), xz-utils CVE-2024-3094, Log4Shell CVE-2021-44228, SolarWinds SUNBURST, npm/PyPI 2024-2025 supply chain, Snyk AI Code Security Report cluster, HackerOne 2025 disclosure data.
  - Section 3: Canonical security literature (OWASP Top 10 Web/API/LLM, ASVS, SAMM; NIST CSF 2.0, SP 800-53, SP 800-218; ISO 27001/27002:2022; CIS Controls v8; SANS Top 25; PCI-DSS v4.0.1; HIPAA 164.312; GDPR Art 32; SOC 2 TSC; Shostack, Stuttard/Pinto, Aumasson, Anderson, Google SRE/SecEng, Vehent, Bell et al.; Shortridge, Gibler, Thinkst, Guido, Mudge, Miller, Majors, Mitchell).
  - Section 4: Security tooling landscape with what-each-catches-and-misses analysis.
  - Section 5: Compliance framework mapping in engineering view for SOC 2 / HIPAA 164.312 / PCI-DSS 4.0 / GDPR Art 32, plus cross-framework high-leverage-nine table.
  - Section 6: Bug bounty economics (market numbers, severity distribution, AI-specific trends, when-pays-off / when-becomes-noise, VDP-vs-bounty, stage-appropriate posture, CVSS + EPSS + KEV composite).
  - Section 7: OWASP Top 10 walkthrough with scanner gaps per category.
  - Section 8: API, auth, crypto deep-dives (session/CSRF, OAuth flow attacks, JWT pitfalls 2025-2026 CVEs, passkey/WebAuthn, rate-limit design with IPv6 trap, GraphQL cost, authz-vs-authn confused-deputy, AEAD vs raw encryption, AES-GCM vs ChaCha20-Poly1305, nonce/IV reuse catastrophes, KDF selection, signature schemes, CNSA 2.0 post-quantum).
  - Section 9: Pen-test preparation and disclosure programs with PTES phases, RFC 9116 security.txt, Project Zero / CERT/CC / ZDI disclosure timelines, the Lovable 48-day cautionary case.
  - Section 10: Post-incident class hardening with Log4Shell / xz-utils / SolarWinds / Replit 2025 / Lovable walkthroughs.
  - Section 11: Actionable-findings template and canon report citations (Trail of Bits, Doyensec, NCC Group, Latacora, HackerOne Hacktivity, Bugcrowd Priority One).
  - Section 12: Hardening for AI-specific systems with OWASP LLM Top 10 2025, prompt-injection defense patterns, lethal trifecta, Rule of Two, RAG poisoning (PoisonedRAG USENIX Security 2025), tool-use sandbox escapes, secret exfiltration, denial-of-wallet, 540% prompt-injection bounty growth.
  - Appendix A: Citation index by section.
  - Appendix B: Top-line findings for the skill author (six citable base-rate numbers, flagship incidents, canonical frameworks).
  - Appendix C: Explicit non-scope.
  - Appendix D: Expanded incident narratives.
  - Appendix E: Expanded compliance framework detail.
  - Appendix F: Additional tooling notes.
  - Appendix G: What this report does not claim.
- **SUITE.md** at repo root updated for the ten-skill suite, listing harden-ready 1.0.0 alongside production-ready 2.5.9, repo-ready 1.6.5, stack-ready 1.1.8, deploy-ready 1.0.7, observe-ready 1.0.6, launch-ready 1.0.4, prd-ready 1.0.3, architecture-ready 1.0.2, roadmap-ready 1.0.1.
- **README.md** with install paths for Claude Code, Codex, Cursor, Windsurf; the "what this skill prevents" incident-to-enforcement mapping across 16 failure patterns and research findings; full trigger surface; reference-library index; seven-named-terms section.

### Refinements from the dogfood walk

A pre-release paper walk against a realistic solo-dev Mirror Box scenario (a Supabase-backed Next.js SaaS with an admin dashboard, a customer-facing journal feature, and a summarize-my-journal LLM integration; deployed on Vercel; undergoing pre-launch security review before Product Hunt) surfaced the following, addressed in v1.0.0:

- **Mode E (pre-pen-test) recognized as distinct from Mode A (pre-launch).** Initial drafts collapsed both into pre-launch. The walk surfaced that a pre-pen-test engagement prioritizes Step 9 (scope and ROE) and runs Steps 3 to 6 with the explicit goal of removing known-class findings before the external team arrives. v1.0.0 makes Mode E its own branch with load-bearing Step 9.
- **The CVSS + EPSS + KEV composite as Step 11 template field.** Initial drafts had CVSS alone as the severity anchor. Research surfaced the Picus finding that 28% of exploited vulnerabilities have only medium CVSS; the composite reframes triage priority. v1.0.0 template requires all three fields on NVD-listed findings; CVSS only on app-specific findings.
- **Lethal trifecta + Rule of Two as Step 3 LLM01 manual test.** Willison's 2024-2025 writing and Meta's 2025 Rule of Two extension are the canonical framework for LLM-tool agents. v1.0.0 names them verbatim in the OWASP LLM walkthrough with the four-property check table.
- **Paper trust boundary extends the suite's paper family.** The naming-lane analysis in Section 1 of the research confirms paper-SLO / paper-canary / paper-waitlist / unrendered-OG are the naming precedent. v1.0.0 makes the family kinship explicit in SKILL.md, README, and CHANGELOG.
- **Class-fix registry as a produced artifact.** Initial drafts had "do class-level fix" as a Step 13 instruction. The walk surfaced that the instruction without a registry is paper-discipline: the class-fix conversation happens in Slack and is forgotten by the next incident. v1.0.0 requires `.harden-ready/CLASS-FIXES.md` with per-incident entries (instance, class, class survey, class-level fix, regression guard).
- **The BOLA-first heuristic as the where-to-look-first.** The catalog of 2025 AI-app incidents is dominated by BOLA-class findings (Lovable, Moltbook cluster). The "if time is limited, test BOLA first" heuristic was inline in early drafts; the walk pulled it forward to Step 1 / `harden-research.md` as the explicit prioritization rule.
- **Refuse findings that cite only tool output.** The walk surfaced that AI-generated hardening passes default to listing scanner findings as the whole deliverable. The skill refuses that shape explicitly. First have-not in the list.
- **BaaS (Supabase / Firebase) anon-key direct-to-backend test as A01 step.** The Mirror Box dogfood involved Supabase; an early draft walked A01 BOLA only through the application's API. The walk surfaced the Lovable class: the anon key can be used to curl the BaaS REST endpoint directly, bypassing the app's auth. v1.0.0 explicitly names this test in the A01 walkthrough.
- **The "pen test without retest" refusal.** Early `pentest-prep.md` drafts had retest as a recommendation. The walk surfaced that engagements that skip retest produce hardening-as-ritual on the most expensive budget. v1.0.0 makes retest non-optional and calls out vendors that resist including it as a signal of billable-hour engagement.

### Compatibility

- Claude Code (primary)
- Codex
- Cursor
- Windsurf (manual SKILL.md upload)
- Any agent with skill loading

### Suite siblings at release

v1.0.0 ships with a coordinated one-patch-each bump across every live sibling's SUITE.md to track harden-ready's release. The nine sibling versions after this release:

- production-ready 2.5.9 (patch from 2.5.8)
- repo-ready 1.6.5 (patch from 1.6.4)
- stack-ready 1.1.8 (patch from 1.1.7)
- deploy-ready 1.0.7 (patch from 1.0.6)
- observe-ready 1.0.6 (patch from 1.0.5)
- launch-ready 1.0.4 (patch from 1.0.3)
- prd-ready 1.0.3 (patch from 1.0.2)
- architecture-ready 1.0.2 (patch from 1.0.1)
- roadmap-ready 1.0.1 (patch from 1.0.0)

This is the largest coordinated sync the suite will run. With v1.0.0 the core ready-suite is complete: ten skills across planning (prd, architecture, roadmap, stack), building (repo, production), and shipping (deploy, observe, launch, harden).

### Known limitations

- **Not legal advice.** The compliance-framework mapping is the engineering view of auditor expectations; working with qualified legal counsel on any framework-driven engagement remains required.
- **Not a pen-test tool.** harden-ready prepares engagements and verifies retest; it does not perform offensive testing, run exploits against unauthorized targets, or bypass controls. Active exploitation is the vendor's job under a signed engagement.
- **AI safety beyond security-adjacent.** Content-policy jailbreaks that produce disallowed content are a safety concern; the skill covers them only where they intersect with security (system-prompt extraction, training-data extraction, tool-use coercion).
- **OWASP category mapping drift.** The 2025 RC1 is tracked; when it graduates to 2025 final (expected mid-to-late 2026), the walkthroughs update accordingly. LLM Top 10 updates similarly.
- **Post-quantum posture is advisory, not urgent.** Most apps do not need PQ-ready primitives in 2026. The skill records the crypto-agility requirement and the CNSA 2.0 timeline but does not treat non-PQ crypto as a Critical finding absent a specific harvest-now-decrypt-later threat model.

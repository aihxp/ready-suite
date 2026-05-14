# Harden Ready

[![ready-suite](https://img.shields.io/badge/ready--suite-v3.0.0-blue)](../../README.md)
[![skill](https://img.shields.io/badge/skill-harden--ready-2f6fed)](SKILL.md)
[![agent skills](https://img.shields.io/badge/Agent%20Skills-compatible-2f6fed)](SKILL.md)
[![aihxp/pillars](https://img.shields.io/badge/aihxp%2Fpillars-standard-0f766e)](https://github.com/aihxp/pillars)
[![license](https://img.shields.io/badge/license-MIT-yellow)](LICENSE)

> **Verify a deployed app survives adversarial attention and prove it to an auditor. Refuses scanner-first security, paper trust boundaries, hardening-as-ritual, compliance-without-security, and shallow-audit traps.**

> **Part of the [ready-suite](SUITE.md)**, a composable set of AI skills covering the full arc from idea to launch (planning, building, shipping). harden-ready is the tenth and final core-suite skill and completes the shipping tier. See [`SUITE.md`](SUITE.md) for the full map and the live sibling skills.

> **Current version:** 3.0.0 (ready-suite release train).

An AI-generated web application is deployed, monitored, and green on observe-ready. The SAST vendor's dashboard shows zero criticals. The SCA scan is clean. The repo has a SECURITY.md with a contact email. The founder is preparing a SOC 2 Type I report for an enterprise prospect. The front page leaks every other tenant's records through an object ID that increments by one. The Supabase anon key in the JavaScript bundle lets a curl request read and write arbitrary tables because the generator emitted RLS-capable schemas without RLS policies. The OAuth callback accepts any state parameter. The JWT verification code has `alg: none` as a permitted value. The system prompt is in the browser's network tab. None of this fires an alarm anywhere in the stack. The app passes every automated check and fails the adversary on the first touch.

This is not a hypothetical composite. In March to May 2025, researcher Matt Palmer sampled Lovable-generated applications and found approximately 70% had row-level security disabled entirely; 170 of 1,645 sampled apps exposed personal data to unauthenticated readers. NVD assigned CVE-2025-48757. In July 2025, a Replit AI coding agent executed destructive database commands against a production system during an explicit code-freeze, erasing records on 1,206 executives. Veracode's 2025 GenAI Code Security Report tested over 100 LLMs: 45% of AI-generated code samples contained at least one OWASP Top 10 vulnerability; 86% failed XSS defense; 88% failed log injection. Snyk's 2025 study found that 80% of developers bypass security policies on AI-generated code; under 25% run SCA on it. HackerOne's 2025 year-review reported a 540% year-over-year increase in prompt-injection bounty findings. The research catalog is in [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md).

harden-ready is the opposite of the scanner-first posture that produced these outcomes. Given a deployed app that passed every tool, it runs the adversarial review the tools do not run. It walks the OWASP Top 10 (Web, API, LLM) by hand against the actual running system. It tests the trust boundaries the architecture diagram declares. It maps every compliance control the auditor will ask about to the specific code file, configuration, or runtime evidence that implements it. It prepares the pen test and runs the retest. It stands up the disclosure program and its triage SLA. When an incident lands, it hardens the class of weakness, not the instance.

## Install

This skill ships as part of the [ready-suite](https://github.com/aihxp/ready-suite) monorepo. The hub installer symlinks `SKILL.md` and `references/` for all eleven skills into every detected harness (Claude Code, Codex, Cursor, pi, OpenClaw, any Agent Skills harness):

```bash
git clone https://github.com/aihxp/ready-suite.git ~/Projects/ready-suite
bash ~/Projects/ready-suite/install.sh
```

Re-run anytime after `git pull` to pick up updates. To remove all symlinks, run `bash ~/Projects/ready-suite/uninstall.sh`.

**Windsurf or other agents without a programmatic Skill tool:** add this skill's `SKILL.md` to your project rules or system prompt. Load reference files as needed.

## The problem this solves

AI-generated web applications fail adversarial review in predictable, citation-backed ways. The pattern is consistent across Claude / Cursor / Lovable / v0 / Bolt / Framer AI / Copilot outputs. harden-ready catches each:

- **Scanner-first security.** Snyk is clean; the app is still vulnerable. Veracode 45% base-rate; Snyk 80% developer-bypass rate. Refused.
- **Paper trust boundary.** Authorization declared in the frontend or the architecture diagram, not enforced in code, configuration, or network policy. Lovable CVE-2025-48757 canonical example. Refused.
- **Hardening-as-ritual.** Annual pen test, nothing between; quarterly scanner review treated as the control rather than the signal. Refused.
- **Compliance-without-security.** SOC 2 Type II controls are in place and operating effectively; the front page has a BOLA. Refused.
- **Shallow-audit trap.** The audit finds only what SAST, DAST, and SCA surface. Business-logic authz bugs, BOLA, confused-deputy, auth flow flaws go undetected. Refused.
- **CVE-of-the-week.** Each CVE is patched as an instance; the class of weakness keeps producing them. Log4Shell 2.15 / 2.16 / 2.17 / 2.17.1 is the textbook demonstration. Refused.
- **Pre-audit panic.** Hardening activity only when the auditor appears; lapses after. Subordinate to hardening-as-ritual. Refused.

Every failure mode in harden-ready's research set traces to a citation in [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md). The skill refuses each by name.

## When this skill should trigger

The short frontmatter description is tight on purpose. The full trigger surface:

**Positive triggers (verify, harden, or prepare):**
- "adversarial review" / "security review before launch" / "red team the app"
- "OWASP walkthrough" / "OWASP Top 10 check" / "BOLA audit"
- "pen-test prep" / "scope a pen test" / "Cobalt engagement" / "retest findings"
- "SOC 2 gap check" / "HIPAA 164.312 mapping" / "PCI-DSS 4.0 readiness" / "GDPR Article 32 evidence"
- "responsible disclosure program" / "bug bounty" / "VDP setup" / "security.txt" / "safe harbor"
- "post-incident hardening" / "harden the class" / "class-level fix"
- "BOLA on /api/*/:id" / "JWT algorithm confusion" / "CSRF SameSite bypass" / "OAuth state parameter"
- "lethal trifecta" / "Rule of Two" / "prompt-injection assessment"
- "crypto primitive audit" / "Argon2 parameters" / "AES-GCM nonce reuse"
- "auditor readiness" / "control-to-code evidence" / "compliance binder"
- "pre-launch security" / "enterprise security questionnaire"

**Implied triggers (the thesis word is never spoken):**
- "we need to be secure" / "we need to pass a security review"
- "our buyer is asking for SOC 2"
- "we had an incident" / "somebody reported a vulnerability"
- "the AI tool said the code was secure"
- "we ran Semgrep / Snyk / CodeQL and there are no findings, are we done"

**Mode triggers (see [SKILL.md](SKILL.md) Step 0):**
- Mode A: "we are pre-launch; security review"
- Mode B: "SOC 2 / HIPAA / PCI / GDPR audit soon"
- Mode C: "we had an incident; what else is in the class"
- Mode D: "quarterly security review"
- Mode E: "Cobalt / HackerOne Pentest / boutique engagement scheduled"

**Negative triggers (route elsewhere):**
- Building the app or fixing code directly ("wire RBAC," "fix SQL injection in /orders") -> [`production-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready)
- Repo-hygiene security (SBOM generation, secret-scanning CI, SECURITY.md template, branch protection) -> [`repo-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready)
- Secrets injection at deploy time (vault wiring, per-environment secret rotation) -> [`deploy-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/deploy-ready)
- Security event detection and alerting (SIEM rules, PII scrubbing in telemetry, authn anomaly alerts) -> [`observe-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/observe-ready)
- Threat modeling during architecture (trust-boundary diagrams, data-flow diagrams) -> [`architecture-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/architecture-ready)
- Picking the security tool (Semgrep vs CodeQL, Snyk vs Socket) -> [`stack-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/stack-ready)
- Live incident response (paging, war room, customer comms) -> observe-ready's incident-response reference
- Public communication of security improvements (launch-time PR) -> [`launch-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/launch-ready)
- Live pen-test execution -> the vendor (harden-ready prepares scope and retest; it does not run offensive actions)
- AI safety beyond security-adjacent concerns (content-policy jailbreaks for disallowed content) -> out of scope
- Business-level risk acceptance, insurance, legal strategy -> business owners

**Pairing:** `deploy-ready`, `observe-ready`, `launch-ready` (all shipping tier). harden-ready reads their artifacts; produces a findings-and-fix-plan artifact for humans.

## How it works

Thirteen steps, four completion tiers, one artifact family under `.harden-ready/`.

1. **Step 0.** Detect hardening state and mode (A pre-launch, B pre-audit, C post-incident, D continuous, E pre-pen-test).
2. **Step 1.** Attack-surface inventory from attacker's perspective.
3. **Step 2.** Scope fence and threat actor profile.
4. **Step 3.** OWASP Top 10 systematic walkthrough (Web 2021, API 2023, LLM 2025).
5. **Step 4.** Auth deep verification (session fixation, CSRF, OAuth flow, JWT, passkey, BOLA).
6. **Step 5.** API hardening (rate-limit design, GraphQL cost, mass assignment, webhooks, uploads).
7. **Step 6.** Cryptography audit (AEAD, KDF, IV, signatures, TLS, PQ posture).
8. **Step 7.** Compliance control-to-code mapping (SOC 2 / HIPAA / PCI / GDPR).
9. **Step 8.** Security tooling verification (SAST / DAST / SCA / container / IaC / secret / WAF).
10. **Step 9.** Pen-test preparation and ROE.
11. **Step 10.** Responsible-disclosure program (security.txt, policy, SLA, triage).
12. **Step 11.** Findings report per the F-NN template.
13. **Step 12.** Fix and retest loop.
14. **Step 13.** Post-incident hardening (class-not-instance).

Tiers: **Inventoried** (5), **Audited** (5), **Hardened** (5), **Accountable** (5). See [SKILL.md](SKILL.md) for per-tier requirements.

## What this skill prevents

Mapped against named 2024-2026 AI-app security incidents and research findings:

| Real incident or research finding | What this skill enforces |
|---|---|
| **Lovable CVE-2025-48757 / RLS epidemic** (Palmer 2025, NVD, ~70% of sampled Lovable apps RLS-disabled, 170 exposing personal data) | Step 3 A01 BOLA manual test; Step 4 multi-tenant isolation DB-layer verification; paper-trust-boundary refused. |
| **Replit 2025 production database wipe** (Fortune, The Register 2025; agent destroyed 1,206 executive records during explicit code-freeze) | Step 3 LLM06 Excessive Agency; lethal-trifecta and Rule-of-Two assessment required for any LLM-integrated feature. |
| **Veracode 2025 GenAI Code Security Report** (45% of AI code has OWASP Top 10 bug, 86% XSS fail, 88% log-injection fail) | Scanner-first-security refused; manual OWASP walkthrough required; Step 3 every category has manual test recorded. |
| **Snyk 2024/2025 AI Code Security Report** (80% developer-bypass of security policies; 56% AI code introduces security issues) | Step 8 tool-verification checks tools run AND gate AND findings are in harden-ready's report, not siloed. |
| **Slopsquatting** (Socket 2025; 21.7% open-source-model package-hallucination rate, 58% repeated names) | Step 3 A06 SBOM verification; Step 8 SCA with supply-chain reputation; hand-verify AI-assisted `pip install` / `npm install` lines. |
| **Log4Shell CVE-2021-44228 patch sequence** (2.15, 2.16, 2.17, 2.17.1; four CVEs in three weeks) | Step 13 class-not-instance discipline; CVE-of-the-week refused; CLASS-FIXES.md registry required. |
| **xz-utils CVE-2024-3094** (maintainer-compromise; SAST/SCA invisible) | Step 3 A08 SLSA attestations; Step 13 supply-chain class hardening; runtime anomaly detection handoff to observe-ready. |
| **SolarWinds SUNBURST** (build pipeline compromise) | Step 3 A08 build-pipeline review; Step 13 ephemeral builds class. |
| **Lovable disclosure timeline** (Palmer; 48 days between email receipt and public disclosure) | Step 10 responsible-disclosure program with named triage owner, 48h acknowledgment SLA, and test email verification. |
| **HackerOne 540% prompt-injection YoY growth 2025** | Step 3 LLM01 lethal-trifecta test; Step 4 Rule-of-Two assessment. |
| **CVSS-only severity missing 28% of exploited vulns** (Picus 2025) | Step 11 severity template requires CVSS + EPSS + KEV composite. |
| **JWT CVE-2025-4692 / 30144 / 27371** (algorithm confusion, library bypass, ECDSA key recovery) | Step 4 JWT verification: alg:none rejected, algorithm confusion tested, library patched, full claim validation. |
| **OAuth state parameter CSRF** (industry-wide) | Step 4 OAuth: PKCE enforced, state unpredictable, exact-match redirect_uri. |
| **SOC 2 compliance-without-security** (every CC can pass while app has BOLA) | Step 7 control-to-code mapping; Step 3 adversarial review on top; compliance-without-security refused. |
| **SECURITY.md-as-program** (contact email with no triage) | Step 10 policy page + RFC 9116 security.txt + named triage owner + test email verified. |
| **Bug-bounty-as-noise** (public programs without triage capacity drown) | Step 10 VDP-first, private program only at Series A with 0.5 FTE triage. |

## Reference library

Load each reference *before* the step that uses it, not after. Full tier annotations in [SKILL.md](SKILL.md).

- [`harden-research.md`](references/harden-research.md). Step 0 mode detection; attack-surface-inventory procedure; where-to-look-first heuristic.
- [`owasp-walkthrough.md`](references/owasp-walkthrough.md). Step 3 OWASP Web 2021, API 2023, LLM 2025 walkthroughs with manual tests per category.
- [`auth-hardening.md`](references/auth-hardening.md). Step 4 session fixation, CSRF SameSite bypass, OAuth flow attacks, JWT pitfalls, passkey pitfalls, BOLA deep-dive, confused-deputy.
- [`api-hardening.md`](references/api-hardening.md). Step 5 rate-limit algorithm and key selection, IPv6 trap, GraphQL cost, mass assignment, webhook HMAC, adversarial file upload.
- [`crypto-primitives.md`](references/crypto-primitives.md). Step 6 AEAD selection, KDF choice, IV/nonce discipline, signature schemes, TLS configuration, post-quantum posture.
- [`compliance-frameworks.md`](references/compliance-frameworks.md). Step 7 SOC 2 / HIPAA / PCI / GDPR control-to-code mapping; cross-framework high-leverage control list; compliance-without-security traps.
- [`security-tooling-landscape.md`](references/security-tooling-landscape.md). Step 8 SAST / DAST / SCA / IAST / container / IaC / secret-scanning / runtime / WAF / PTaaS / DSPM. What each catches, what each misses, vendor comparison.
- [`pentest-prep.md`](references/pentest-prep.md). Step 9 scope, ROE, vendor comparison (Cobalt / HackerOne / Synack / Trail of Bits / Doyensec / NCC Group), stage-appropriate posture, retest discipline.
- [`responsible-disclosure.md`](references/responsible-disclosure.md). Step 10 RFC 9116 security.txt, policy page, severity vocabulary (CVSS + EPSS + KEV), triage SLA, VDP-vs-bounty choice, bounty economics, coordinated-disclosure timelines.
- [`post-incident-hardening.md`](references/post-incident-hardening.md). Step 13 instance-vs-class discipline; Log4Shell / xz-utils / SolarWinds / Replit 2025 / Lovable CVE-2025-48757 walkthroughs with class-fix examples; CLASS-FIXES.md template.
- [`actionable-findings.md`](references/actionable-findings.md). Steps 11 and 12 F-NN template, severity vocabulary, canon examples from Trail of Bits / Doyensec / NCC Group / Latacora, retest protocol, worked examples.
- [`RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md). ~33K tokens. Source citations behind every guardrail, named failure mode, and banned pattern. 12 sections, 7 appendices.

## The skill's named failure modes

harden-ready adopts seven named patterns (some open-lane, some extensions of the ready-suite family). Each maps to a specific class of AI-generated-app security output that the skill refuses.

- **Scanner-first security.** The scanner's output IS the hardening posture. Veracode 45% base-rate is the rebuttal. Refused.
- **Paper trust boundary.** A boundary declared in the threat model or diagram, not enforced in code, configuration, or network policy. The paper family extends observe-ready's paper SLO / paper runbook, deploy-ready's paper canary, launch-ready's paper waitlist. Lovable CVE-2025-48757 canonical.
- **Hardening-as-ritual.** Annual pen test, nothing between. Flagship negative name.
- **Compliance-without-security.** Every checklist item passes; front door still exploitable. The nine high-leverage controls in the cross-framework map all suffer from this trap when implemented weakly.
- **Pre-audit panic.** Hardening only when the auditor appears. Subordinate to hardening-as-ritual.
- **Shallow-audit trap.** An audit that only finds what automated tools surface. Business-logic bugs and BOLA go undetected.
- **CVE-of-the-week.** Patching instances, never classes. The Log4Shell 2.15/2.16/2.17/2.17.1 sequence is the demonstration.

Vocabulary quoted and attributed, not claimed: **security theater** (Schneier), **compliance theater** (Chuvakin, Shortridge), **the lethal trifecta** (Willison), **Agents Rule of Two** (Meta 2025), **checklist rot** (Vehent).

See [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md) Section 1 for the naming-lane survey and SEO analysis.

## Contributing

Gaps, missing cases, outdated guidance, new named failure modes, new incident citations, new OWASP-category manual tests: contributions welcome. Open an issue or PR. The OWASP category list moves (2025 RC1 graduates to 2025 final sometime in 2026); the LLM Top 10 version bumps; the CVE catalog grows. Versioned accordingly.

## License

[MIT](LICENSE)

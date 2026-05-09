# Pulse: harden-ready FINDINGS.md

| | |
|---|---|
| Tier | Tier 2 (matches PRD tier) |
| Status | v1.0 (2026-08-01); week-12 pen-test results in. Resolution status: complete (all Critical resolved). |
| Owner | Devon Park (eng lead, defends); Generalist (fixes) |
| Pen-tester | HackerOne triage team (engagement TR-2026-Q3-PULSE) |
| Engagement window | 2026-07-28 to 2026-08-01 (5 business days, week 12) |
| Consumed ARCH | `.architecture-ready/ARCH.md` v1.0 §6 (trust boundaries) |
| Consumed PRD | `.prd-ready/PRD.md` v1.0 §NFR Security |
| Consumed OBSERVE | `.observe-ready/OBSERVE.md` (audit log expectations) |

## Engagement scope

The pen-test scoped against `dartlogic-stage.pulse.dev` (the pre-prod environment, populated with mock DartLogic data structurally identical to production). The auditor was given:

- Two test tenant accounts (one AM role, one Manager role, one Admin role).
- A non-privileged account with an attempt to escalate.
- The architecture document (ARCH.md §6 trust boundaries).
- The PRD's NFR Security section.
- Read access to the `pulse-pilot` Axiom dashboard.

What was NOT given: source code access (gray-box methodology), Vercel admin, Neon admin, or any production credentials. The auditor tested as a determined external attacker who has read the public docs and the architecture (the latter is a slight cheat to focus the test on intended boundaries).

## Findings (8 total)

Severity scale: Critical / High / Medium / Low / Informational.

### F-01 (Critical, RESOLVED)

**Title**: HubSpot OAuth refresh token leaked to log aggregator.

**Description**: The HubSpot integration logged the refresh token at INFO level when the polling cycle started. Log entries were shipped to Axiom, which the entire eng team has read access to.

**Root cause**: a `console.log(...)` left over from initial integration debugging. The token was passed through a structured-logging helper that did not redact sensitive fields by name.

**Remediation**: removed the log line; added `refresh_token`, `access_token`, `oauth_token` to the structured-logging redaction list; added a `pnpm lint:logs` rule that fails CI when these field names appear in log emission code outside the auth module.

**Evidence**: commit `pulse-app@a3f72c1` (2026-07-29); lint rule `eslint-plugin-pulse-no-secret-log` v0.1.0 added to `biome.json` overrides.

**Resolution timestamp**: 2026-07-29 (same day as finding).

### F-02 (Critical, RESOLVED)

**Title**: Tenant-scope bypass via direct DB ID enumeration on the touchpoint timeline endpoint.

**Description**: The `/api/touchpoints/:id` endpoint did not enforce the tenant-scope check. An AM in tenant A could read a touchpoint belonging to tenant B by guessing or enumerating the touchpoint UUID (UUIDs are random but the enumeration test was constructed via the auditor's test-tenant DB).

**Root cause**: the route handler called `db.touchpoints.findById(id)` instead of `db.touchpoints.findById({ tenant_id, id })`. The data-access layer's tenant-scope helper exists (`src/db/tenant.ts`) but this route bypassed it.

**Remediation**: rewrote the route to pass `tenant_id` from the session; refactored every domain endpoint to use the tenant-scope helper exclusively (no direct `db.<table>.findById(id)` calls remaining). Added a CI check: `grep -nE 'db\.\w+\.findBy(Id|Email)\([^,]+\)' src/` returns zero matches.

**Evidence**: commit `pulse-app@b8e91f4` (2026-07-30); CI rule `tenant-scope-discipline` added to `.github/workflows/ci.yml`. Re-test by the auditor confirmed the bypass closed.

**Resolution timestamp**: 2026-07-30.

### F-03 (High, RESOLVED)

**Title**: Magic-link tokens reusable for 10 minutes after first use.

**Description**: Auth.js v5's default Email-provider behavior allows a magic link to be redeemed multiple times within its expiration window. An attacker who intercepts the email (e.g., via shoulder-surf or compromised email account) can sign in even after the legitimate user has already signed in.

**Root cause**: Auth.js's default `useVerificationToken` callback returns the token without consuming it. We did not override.

**Remediation**: overrode the `useVerificationToken` callback to delete the token row from the verification table after first successful redemption. Added an integration test: token redemption is one-shot.

**Evidence**: commit `pulse-app@c72a83d` (2026-07-30); `tests/integration/auth/magic-link-single-use.test.ts`.

**Resolution timestamp**: 2026-07-30.

### F-04 (High, RESOLVED)

**Title**: Slack webhook URL not validated against `hooks.slack.com`.

**Description**: The notifications module accepted any URL string for the Slack webhook destination. An attacker who could update an AM's Slack-webhook setting (via the AM's session) could redirect notifications to an arbitrary URL, exfiltrating account-name and at-risk-flag-reason data.

**Root cause**: the architecture (ARCH.md §6 boundary 5) declared the validation but the implementation had only a basic URL-format check, not the host-prefix check.

**Remediation**: validate the URL is `https://hooks.slack.com/services/...` before saving. Added a unit test for both accepted and rejected URLs.

**Evidence**: commit `pulse-app@d4f1928` (2026-07-31); `src/notifications/slack.ts` with a `assertSlackWebhookUrl` helper; `tests/unit/notifications/slack-url-validation.test.ts`.

**Resolution timestamp**: 2026-07-31.

### F-05 (Medium, RESOLVED)

**Title**: Audit log missing for the `at_risk_flag.cleared` event.

**Description**: The audit_log table captured `at_risk_flag.set` and `at_risk_flag.escalated` events but not `at_risk_flag.cleared`. A malicious AM could set a flag, attract attention, then silently clear it with no audit trail.

**Root cause**: the audit-log writer was added to two of the three flag-state-change handlers but not the third. Code review missed it.

**Remediation**: added the audit-log write to the cleared handler. Added a code-review checklist entry: "any state-change handler on a security-sensitive table writes an audit-log entry."

**Evidence**: commit `pulse-app@e832b6a` (2026-07-31); `src/atrisk/clear.ts`.

**Resolution timestamp**: 2026-07-31.

### F-06 (Medium, ACCEPTED)

**Title**: At-risk-flag reason text is not sanitized in the manager weekly digest email.

**Description**: An AM could enter `<script>alert(1)</script>` as the at-risk-flag reason. The Manager weekly digest email rendered the reason without escaping, opening a stored-XSS path against the Manager's email client.

**Root cause**: the email-template engine (Resend's React Email) auto-escapes by default, but the digest template used `dangerouslySetInnerHTML` for the reason field to allow line breaks to render.

**Risk-acceptance rationale**: the population is a single tenant with 4 known users (3 AMs + 1 Manager); all are DartLogic employees with access to set flag reasons. The XSS path requires an AM to attack their own Manager via a malicious flag reason. This is an insider-threat scenario; the email-client mitigation (modern Gmail strips inline scripts) is sufficient at v1.0. Risk owner: Sam (CEO). Re-evaluation at v1.x when the user count grows past 4.

**Compensating control**: the audit_log table records every flag-set event; any malicious reason is reviewable.

**Status**: acknowledged; tracked as `.harden-ready/RISK-REGISTER.md` entry RR-001 (file created post-pen-test).

### F-07 (Low, RESOLVED)

**Title**: Verbose error responses on the `/api/auth/email/verify` endpoint reveal whether an email is registered.

**Description**: The endpoint returned different messages for "email not found" vs "token expired," letting an attacker enumerate registered email addresses.

**Root cause**: Auth.js's default error responses are intentionally verbose; we did not override.

**Remediation**: overrode the error handler to return a generic "verification failed" for both cases.

**Evidence**: commit `pulse-app@f93c4e7` (2026-08-01).

**Resolution timestamp**: 2026-08-01.

### F-08 (Informational)

**Title**: Architecture trust-boundary 5 (notification-destination) is enforced for Slack but not for email.

**Description**: The Slack-webhook URL validation (F-04) is now in place. The email-destination address is not similarly validated; an AM could set their notification email to an attacker-controlled address. The auditor flagged this as an enforcement gap relative to the architecture document.

**Resolution**: the architecture document (ARCH.md §6) declared the boundary but did not require email-address validation (Slack URL was the named example). At v1.0, an AM's notification email defaults to their sign-in email and cannot be changed (the per-user notification-preference UI is deferred to v1.1 per PRD §No-gos). The risk is null at v1.0; will be addressed when the preference UI lands at v1.1.

**Status**: documented; closed as not-applicable at v1.0; tracked for v1.1.

## Compliance mapping (informational at v1.0)

The PRD §NFR Compliance defers SOC 2 Type II to v2.0 (post-pilot). At v1.0, no formal compliance commitment is made. The pen-test still produced control-mapping evidence for the controls Pulse claims:

| Claim | Evidence |
|---|---|
| TLS for all traffic | Vercel HTTPS terminator; verified |
| At-rest encryption at the database layer | Neon at-rest encryption confirmed (Neon docs + AWS-managed KMS); verified |
| Audit log for security-sensitive events (login, role change, account reassignment, flag set/cleared) | Audit_log table verified for all events except F-05 (which was the gap closed by remediation) |
| Trust boundaries (ARCH.md §6) enforced in code | F-02 + F-04 closed the gaps; F-08 documented as v1.1 scope |
| Pen-test before paying-pilot signature | This document |

## Out of scope at v1.0 (explicit)

The pen-test deliberately did NOT cover:

- **DDoS / volumetric attack resistance**: Vercel's platform-level rate limiting and Cloudflare upstream cover this; not pen-test scope at v1.0.
- **Side-channel attacks** (timing, cache-based): out of scope for a 5-day engagement.
- **Supply-chain attack on dependencies**: covered separately by GitHub Dependabot + the slopsquatting check in `production-ready/references/performance-and-security.md`.
- **Physical security**: N/A; cloud-hosted.
- **Insider-developer threat**: out of scope; addressed via repo-ready's branch protection + `CODEOWNERS`.

## Resolution summary

| Severity | Found | Resolved | Risk-accepted | Closed not-applicable | Open |
|---|---|---|---|---|---|
| Critical | 2 | 2 | 0 | 0 | 0 |
| High | 2 | 2 | 0 | 0 | 0 |
| Medium | 2 | 1 | 1 | 0 | 0 |
| Low | 1 | 1 | 0 | 0 | 0 |
| Informational | 1 | 0 | 0 | 1 | 0 |
| **Total** | **8** | **6** | **1** | **1** | **0** |

All Critical findings resolved. The pen-test sign-off (auditor confirmation) was issued 2026-08-01; recorded in `.harden-ready/SIGNOFF.md` (created at engagement close).

## Sign-off

| Role | Name | Date |
|---|---|---|
| Pen-tester (HackerOne) | Triage team lead | 2026-08-01 |
| Eng lead | Devon Park | 2026-08-01 |
| CEO (risk-acceptance for F-06) | Sam Okafor | 2026-08-01 |

Sign-off attests: all Critical and High findings are resolved. F-06 is risk-accepted in writing by the CEO with named compensating control. The engagement is closed; the M3 paying-pilot ceremony is unblocked.

## What harden-ready refused at v1.0

Named failure modes harden-ready refuses, with rationale:

- **Scanner-first security** (the Snyk-passed-but-front-door-exploitable pattern): the pen-test was gray-box and adversarial; F-01 and F-02 would not have been caught by SAST/SCA alone. Refused.
- **Paper trust boundaries** (declared in docs, absent in code): F-02 and F-04 surfaced enforcement gaps where the architecture declared boundaries that the implementation did not enforce; both were fixed by adding the enforcement to code, not by editing the doc to match the gap. Refused.
- **Hardening as ritual** (annual pen test, nothing between): the engagement is timed to the v1.0 pilot signature, not to a calendar. v1.x will run another engagement before any non-DartLogic tenant onboards. Refused.
- **Compliance without security** (checklist green, app vulnerable): no compliance claim is made at v1.0; the controls listed are the ones the architecture and code actually implement. Refused.
- **Shallow-audit traps** (only finds what tools surface): the auditor used gray-box methodology with the architecture document as a roadmap, which surfaced F-02 and F-08 (boundary enforcement gaps) that an automated scanner would miss. Refused.

## Downstream handoff

- **deploy-ready** consumes the all-resolved-or-accepted state to unblock the week-13 prod cutover. The cutover is scheduled for 2026-08-04.
- **launch-ready**: out of scope at v1.0 (the pilot is private; v1.1 brings the first generalized launch). When launch-ready fires at v1.1, this FINDINGS.md is the prior-engagement reference.
- **observe-ready**: F-04 (Slack URL validation) and F-05 (audit log gap) are wired to the OBSERVE.md alert routing so future regressions surface immediately. RB-4 (auth-abuse spike) is the runbook for F-07-class symptoms.

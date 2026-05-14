# Security policy

## Reporting a vulnerability

Report security vulnerabilities **privately**, not via public issues or pull requests. Two channels, in order of preference:

1. **GitHub Security Advisories** at the repository's `Security` tab. Click "Report a vulnerability." This is the canonical path; the report goes directly to the maintainer, stays private until disclosure, and produces a CVE if applicable.
2. **Email** to `hprincivil@gmail.com` with subject line `SECURITY: kickoff-ready` and a clear description of the issue, reproduction steps, and any proposed mitigation.

Expect an acknowledgment within **3 business days**. Disclosure timelines depend on severity:

- **Critical** (remote code execution, data exfiltration, auth bypass): triaged within 24 hours; fix targeted within 7 days; coordinated public disclosure after fix lands.
- **High** (escalation, sensitive-data exposure): triaged within 3 days; fix targeted within 14 days.
- **Medium / Low**: triaged within 7 days; fix scheduled per the suite's coordinated-patch cadence.

This skill is **markdown-only content** (a `SKILL.md` file plus references). The realistic security surface is small: prompt-injection attacks against an agent that loads the file, supply-chain risk if the repository is tampered with, or a malicious PR that introduces hidden instructions. The reporting channels above cover all three.

## Supported versions

The skill follows semantic versioning. Security fixes land on the latest minor release; older minors do not receive backports. Users are encouraged to track releases in the ready-suite changelog and the skill's CHANGELOG.md.

## Known non-issues

The skill is documentation; it does not execute code, store secrets, or process user data. Reports about "no encryption at rest" or "no rate limiting" are misdirected; this is a static markdown file.

## Cross-references

- Cross-suite security policy: [aihxp/ready-suite/SECURITY.md](https://github.com/aihxp/ready-suite/blob/main/SECURITY.md)
- Skill-suite hub: [aihxp/ready-suite](https://github.com/aihxp/ready-suite)

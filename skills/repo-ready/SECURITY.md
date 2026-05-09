# Security Policy

**repo-ready** is a Markdown-only Claude Code skill -- there is no runtime, no user input parsing, and no network surface. The vast majority of "security" concerns for this repository are about the *content* the skill generates: template strings that might instruct downstream projects to do something unsafe, copy-pasted config snippets with wrong defaults, or reference files that leak placeholder credentials. We treat those as security issues.

## Supported Versions

| Version | Supported              |
| ------- | ---------------------- |
| 1.4.x   | Fully supported        |
| 1.3.x   | Best-effort fixes      |
| < 1.3   | Unsupported            |

When a new minor version ships (e.g., v1.5), the previous minor drops to best-effort and anything two minors back becomes unsupported.

## Reporting a Vulnerability

**Please use GitHub Private Vulnerability Reporting (PVR) as the primary channel.** PVR is free, requires no setup on your end, and gives you a structured form that goes directly to the maintainers without exposing the report publicly.

**To file a report:**

1. Navigate to the [Security tab](https://github.com/aihxp/ready-suite/security) of this repository
2. Click **"Report a vulnerability"**
3. Fill in the form with as much detail as you can -- affected reference file or SKILL.md section, reproduction steps, and the impact you observed

GitHub's official guide: [Privately reporting a security vulnerability](https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing/privately-reporting-a-security-vulnerability).

Please do **not** open a public issue for security concerns -- public issues turn a responsible disclosure into a zero-day the moment they are filed.

## Response Timeline

| Milestone                 | Commitment                                       |
| ------------------------- | ------------------------------------------------ |
| Initial acknowledgement   | Within **72 hours** of the PVR submission        |
| Triage + severity rating  | Within **7 days** of acknowledgement             |
| Fix / mitigation timeline | Communicated at triage; depends on severity      |
| Public disclosure         | **90-day coordinated disclosure** (see below)    |

If you do not receive an acknowledgement within 72 hours, please open a [Discussion](https://github.com/aihxp/ready-suite/discussions) asking us to check our Security tab -- do not repost the vulnerability details in the Discussion.

## Disclosure Policy

We follow a **90-day coordinated disclosure** timeline:

- Day 0: Report received and acknowledged
- Day 0-7: Triage and severity assessment
- Day 7-90: Fix developed, reviewed, and released; reporter kept in the loop
- Day 90: If unfixed, the reporter may publicly disclose. We will request an extension only if the fix is materially in progress and near ready.

When a fix ships, the corresponding GitHub Security Advisory is published with the reporter credited (unless they ask to remain anonymous).

## What counts as a security issue

Because this is a Markdown skill, the security surface is unusual. The following *are* in scope:

- **Dangerous template content** -- a generated `.gitignore` that would actually *expose* secrets, a suggested CI workflow that runs untrusted PR code with write tokens, a recommended hook script that executes attacker-controlled input.
- **Placeholder credentials that could become real** -- an example API key in a reference file that happens to collide with a real key, a sample JWT signing secret that someone might copy-paste.
- **Malicious guidance** -- any reference file instructing users to disable signature verification, skip hooks by default, run `curl | sh` from an untrusted source, etc.
- **Supply-chain confusion** -- a reference recommending a package name that matches a known typosquat or is otherwise unsafe.

The following are **not** security issues and should be filed as regular bugs or feature requests:

- Typos, broken Markdown, grammar
- Cross-reference links that 404
- Reference files exceeding the 80KB ceiling
- Missing stack coverage or missing platform coverage
- Disagreements with a recommendation that is merely opinionated (not dangerous)

## Related

- [CONTRIBUTING.md](CONTRIBUTING.md) -- the general contribution workflow
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) -- community behavior standards
- [`references/security-setup.md`](references/security-setup.md) -- the guidance this SECURITY.md itself follows

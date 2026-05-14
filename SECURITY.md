# Security policy

## Reporting a vulnerability

Report security vulnerabilities privately, not via public issues or pull requests.

Use GitHub Private Vulnerability Reporting from the repository's Security tab whenever possible:

1. Open the Security tab for `aihxp/ready-suite`.
2. Click "Report a vulnerability."
3. Include the affected file, reproduction steps, impact, and any proposed mitigation.

If GitHub Private Vulnerability Reporting is unavailable, email `hprincivil@gmail.com` with subject line `SECURITY: ready-suite`.

## Response timeline

| Milestone | Commitment |
|---|---|
| Initial acknowledgement | Within 3 business days |
| Critical triage | Within 24 hours |
| High severity triage | Within 3 business days |
| Medium or low severity triage | Within 7 business days |

Fix timelines depend on severity and release scope. Security fixes land on the latest versions of the affected skill or hub file.

## Scope

ready-suite is mostly static Markdown skill content plus bash install, uninstall, refresh, and lint scripts. The security surface is unusual, but real.

In scope:

- Malicious or hidden prompt instructions in skill or reference content.
- Dangerous generated guidance, such as disabling verification, exposing secrets, or configuring CI with unsafe token permissions.
- Supply-chain confusion in recommended packages, workflows, or plugin manifests.
- Installer, uninstaller, or refresh script behavior that can overwrite unexpected paths, expose secrets, or run unsafe commands.
- Plugin packaging drift that could ship a different skill version than the source tree documents.

Out of scope:

- Typos, broken Markdown, or style disagreements.
- Missing platform coverage.
- Reports about runtime controls that do not apply to static Markdown content.

## Coordinated disclosure

Please keep vulnerability details private until a fix is available and an advisory or release note can be published. If a fix requires longer than 90 days, the maintainer will explain the blocker and proposed disclosure date.

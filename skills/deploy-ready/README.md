# Deploy Ready

[![ready-suite](https://img.shields.io/badge/ready--suite-v3.0.0-blue)](../../README.md)
[![skill](https://img.shields.io/badge/skill-deploy--ready-2f6fed)](SKILL.md)
[![agent skills](https://img.shields.io/badge/Agent%20Skills-compatible-2f6fed)](SKILL.md)
[![aihxp/pillars](https://img.shields.io/badge/aihxp%2Fpillars-standard-0f766e)](https://github.com/aihxp/pillars)
[![license](https://img.shields.io/badge/license-MIT-yellow)](LICENSE)

> **Ship an app from a known-green build into real user-facing environments safely, repeatably, and reversibly.**

> **Part of the [ready-suite](SUITE.md)**, a composable set of AI skills covering the full arc from idea to launch (planning, building, shipping). See [`SUITE.md`](SUITE.md) for the full map and the live sibling skills.

> **Current version:** 3.0.0 (ready-suite release train).

The build is green. The tests pass. CI is a sea of green checkmarks. Then the deploy to production stalls for 40 minutes because the `ALTER TABLE` took an `ACCESS EXCLUSIVE` lock on a billion-row table. The rollback plan says "redeploy the previous image" next to the migration, which reverts the code and leaves the data forward. The canary routes 5% of traffic to the new version, nobody is watching the metric that would have caught the regression, and the "canary passed" message is just a 15-minute timer. The first deploy to the new region fails because the IAM role does not exist and the `.env` is not read at build time on this platform. The second version of the code ships while the first is still running on one host, and a reused feature flag name wakes up dormant code from 2022.

None of these are code bugs. They are shipping-mechanics bugs, and the tooling that exists today, from GitHub Actions to Argo CD to Vercel's deploy UI, has no opinion about any of them. This skill closes that gap. It refuses to call a canary a canary without a metric and a rollback trigger. It refuses to emit a "rollback plan" bullet for a data-forward migration. It decomposes schema changes into a multi-deploy expand/contract calendar rather than letting the AI ship the entire cutover in one deploy. It distinguishes the first deploy to an environment from the hundredth, because first deploys fail differently.

## Install

This skill ships as part of the [ready-suite](https://github.com/aihxp/ready-suite) monorepo. The hub installer symlinks `SKILL.md` and `references/` for all eleven skills into every detected harness (Claude Code, Codex, Cursor, pi, OpenClaw, any Agent Skills harness):

```bash
git clone https://github.com/aihxp/ready-suite.git ~/Projects/ready-suite
bash ~/Projects/ready-suite/install.sh
```

Re-run anytime after `git pull` to pick up updates. To remove all symlinks, run `bash ~/Projects/ready-suite/uninstall.sh`.

**Windsurf or other agents without a programmatic Skill tool:** add this skill's `SKILL.md` to your project rules or system prompt. Load reference files as needed.

## The problem this solves

Shipping is the part of the lifecycle where AI-assisted development measurably hurts rather than helps. DORA 2024 is blunt about it: AI-assisted delivery environments show a 7.2% stability drop and a 1.5% throughput drop, with batch size as the proximate cause ([DORA 2024 report](https://dora.dev/research/2024/dora-report/)). Stack Overflow 2024 reframes developer AI trust as "willingness to deploy AI-generated code to production," and records that trust falling to an all-time low the following year ([Stack Overflow 2024](https://stackoverflow.co/company/press/archive/stack-overflow-2024-developer-survey-gap-between-ai-use-trust/); [2025](https://stackoverflow.co/company/press/archive/stack-overflow-2025-developer-survey/)). GitGuardian's 2026 data puts AI-assisted commits at ~2x baseline for secret leaks; Docker Hub audits have turned up 10,000+ images leaking credentials through `COPY .env` and similar one-line mistakes ([BleepingComputer](https://www.bleepingcomputer.com/news/security/over-10-000-docker-hub-images-found-leaking-credentials-auth-keys/)).

Every named incident in the skill's research set (see [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md)) shares three traits: the change went to the whole fleet at once with no progressive rollout, the rollback mechanism either did not exist or was slow, and the failure was not in code quality but in shipping mechanics. Knight Capital in 2012 ($460M in 45 minutes): partial deploy plus reused feature flag. GitLab in 2017 (300GB deleted): five silent backup regressions. CrowdStrike in 2024 (8.5M hosts offline): uniform rollout of a change that had a bug the content validator had been told to ignore. Replit in 2025 (full production DB wipe during an active code freeze): an AI agent without environment boundaries.

Deploy-ready exists because none of the tools in the CI/CD category are designed to say "no" to any of these shapes. GitHub Actions will run whatever YAML you give it. Argo CD will sync whatever state you declare. Vercel will deploy whatever you push. The skill is the layer above the tool that catches the deploy plan before it ships.

## When this skill should trigger

The short frontmatter description is tight on purpose, to speed up skill-routing decisions. The full trigger surface lives here.

**Positive triggers (build a deploy plan or pipeline):**
- "deploy this to staging / to prod"
- "set up a CI/CD pipeline"
- "promote the artifact to prod"
- "zero-downtime migration"
- "expand-contract" / "parallel change"
- "rollback plan" / "rollback this release"
- "canary deployment" / "canary release"
- "blue/green deployment"
- "progressive rollout" / "percentage rollout"
- "first deploy to <new environment>"
- "feature flag at deploy level" / "dark launch"
- "environment parity" / "staging is different from prod"
- "GitHub Actions for deployment"
- "Argo CD / Flux / GitOps"
- "promote the same artifact"
- "schema migration plan"
- "rolling update"

**Implied triggers (the thesis word is never spoken):**
- "my migration locked the table in prod"
- "staging passed and prod broke"
- "I need to revert this release"
- "the canary was green but users hit the bug"
- "I deployed and now the old and new versions are both running"
- "I dropped a column and the app is 500ing"
- "we pushed to every host at once"

**Mode triggers (see SKILL.md Step 0):**
- Mode A: "this is the first deploy to <env>"
- Mode B: "regular deploy" / "hotfix" / "patch release"
- Mode C: "production is broken right now" / "rollback now"
- Mode D: "build the CI/CD pipeline" / "pipeline from scratch"
- Mode E: "big migration coming up" / "schema change spans weeks"

**Negative triggers (route elsewhere):**
- Tool selection ("Fly.io vs. Render," "Terraform vs. Pulumi") -> [`stack-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/stack-ready)
- Observability ("add Datadog," "define an SLO," "write a runbook") -> `observe-ready` (not yet released)
- Repo hygiene ("set up CI for lint," "CODEOWNERS," "branch protection") -> [`repo-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/repo-ready)
- Secrets management ("rotate this key," "set up a vault") -> security territory, not this skill
- App wiring ("build the users page," "add RBAC") -> [`production-ready`](https://github.com/aihxp/ready-suite/tree/main/skills/production-ready)
- Cost or performance tuning ("this Lambda is expensive") -> cloud-provider docs
- Launch marketing ("landing page," "SEO") -> `launch-ready` (not yet released)

**Pairing:** `observe-ready` (same shipping tier). Canaries without observability are paper canaries; the two skills compose at exactly that seam. See [SKILL.md](SKILL.md) "Handoff" section.

## How it works

Twelve steps, four completion tiers, one artifact family under `.deploy-ready/`.

1. **Step 0.** Detect deploy mode (first, subsequent, incident, pipeline-construction, migration-dominated).
2. **Step 1.** Pre-flight: 10 questions including change-class, rollback path, feature-flag lineage.
3. **Step 2.** Topology and environment map.
4. **Step 3.** Promotion hierarchy and parity audit.
5. **Step 4.** Pipeline design (8 gates, same-artifact promotion).
6. **Step 5.** Classify every change as reversible, data-forward, mixed, or side-effectful.
7. **Step 6.** Migration calendar: expand -> cutover -> contract across multiple deploys.
8. **Step 7.** Rollout strategy (rolling, blue/green, canary, ring) with the paper-canary rule.
9. **Step 8.** Secrets-injection audit.
10. **Step 9.** Pre-deploy checklist (Mode A cold-start gates or Mode B subsequent).
11. **Step 10.** Ship, watching the canary metric directly.
12. **Step 11.** Post-deploy verification, incident log, contract-phase scheduling.

Tiers: **Pipelined** (5), **Promotable** (5), **Reversible** (5), **Hardened** (5). See [SKILL.md](SKILL.md) for per-tier requirements.

## What this skill prevents

| Real incident or research finding | What this skill enforces |
|---|---|
| Knight Capital, 2012, $460M, 45 min ([Kosli](https://www.kosli.com/blog/knight-capital-a-story-about-devops-automated-governance/)): partial deploy, reused feature flag woke dormant code | Step 1 Q9 feature-flag lineage check; Tier 3 Req 15 flag-reuse audit; Tier 4 Req 16 no uniform 0-to-100 pushes. |
| GitLab 2017, 300GB data loss ([GitLab postmortem](https://about.gitlab.com/blog/postmortem-of-database-outage-of-january-31/)): five silent backup regressions, engineer ran `rm -rf` on primary | Step 0 agent-destructive-command alert; rollback playbook destructive-command gate with Replit and GitLab citations; Tier 3 Req 12 rollback path rehearsed. |
| AWS S3 us-east-1, 2017 ([AWS postmortem](https://aws.amazon.com/message/41926/)): typo in debug command removed capacity | Blast-radius rule; no playbook runs against prod without progressive execution. |
| Cloudflare WAF regex, 2019 ([Cloudflare](https://blog.cloudflare.com/details-of-the-cloudflare-outage-on-july-2-2019/)): global push, no progressive rollout | Tier 4 Req 16 blast-radius limit; no change ships to 100% in a single uniform step. |
| Facebook BGP, 2021 ([Cloudflare](https://blog.cloudflare.com/october-2021-facebook-outage/)): config change took out DNS with no canary | Paper-canary rule; no change claimed as canary without named metric, threshold, window, automated rollback. |
| CrowdStrike channel file, 2024 ([CrowdStrike RCA](https://www.crowdstrike.com/en-us/blog/channel-file-291-rca-available/)): content update to 8.5M hosts at once | Ring-deployment requirement for endpoint-targeting changes; Tier 4 Req 16. |
| Replit agent, 2025 ([Fortune](https://fortune.com/2025/07/23/ai-coding-tool-replit-wiped-database-called-it-a-catastrophic-failure/)): AI agent wiped prod DB during code freeze | Destructive-command gate; no `prisma migrate reset`, `DROP TABLE`, `terraform destroy` against prod without named confirmation and restore point; dev/prod separation pre-flight. |
| DataTalks.Club, 2025 ([dev.to](https://dev.to/rsiv/ai-sped-up-development-not-shipping-5g1)): AI agent destroyed production VPC | Same destructive-command gate; separate runtime identity from deploy identity; least-privilege. |
| timescale/pgai, 2025 ([GHSA-89qq-hgvp-x37m](https://github.com/timescale/pgai/security/advisories/GHSA-89qq-hgvp-x37m)): `pull_request_target` with untrusted fork checkout exfiltrated secrets | Secrets-injection audit; no `pull_request_target` secret exposure; environment protection rules required. |
| Docker Hub 10,000+ images ([BleepingComputer](https://www.bleepingcomputer.com/news/security/over-10-000-docker-hub-images-found-leaking-credentials-auth-keys/)): secrets baked via `COPY .` / `COPY .env` | Artifact-level secret scan (not just source); `COPY .` anti-pattern in have-nots; per-topology injection patterns. |
| DORA 2024 ([DORA](https://dora.dev/research/2024/dora-report/)): 7.2% stability drop from AI-assisted delivery, root cause batch size | Decomposed deploy calendar (expand / cutover / contract across multiple deploys) instead of monolithic ship. |
| Stripe online migrations ([Stripe](https://stripe.com/blog/online-migrations)): four-phase dual-write pattern | Expand/contract calendar; shadow-write guardrails; silent-divergence detection cited from Bussler. |

## Reference library

Load each reference *before* the step that uses it, not after. Full tier annotations in [SKILL.md](SKILL.md).

- [`deploy-research.md`](references/deploy-research.md). Step 0 mode detection protocol.
- [`preflight-and-gating.md`](references/preflight-and-gating.md). Step 1 and Step 9 checklists and gate types.
- [`deployment-topologies.md`](references/deployment-topologies.md). Step 2 topology picker, per-topology first-deploy hazards, mixed-topology worked examples.
- [`pipeline-patterns.md`](references/pipeline-patterns.md). Step 4 pipeline gates, same-artifact enforcement, GitHub Actions good/bad YAML.
- [`environment-parity.md`](references/environment-parity.md). Step 3 four parity gaps, per-rung parity table, pre-prod parity gap as a named concept.
- [`first-deploy-checklist.md`](references/first-deploy-checklist.md). Mode A cold-start gates, per-platform gotchas.
- [`zero-downtime-migrations.md`](references/zero-downtime-migrations.md). Step 6 expand/contract calendar, the 10-pattern guardrail catalog, worked rename-across-3-deploys.
- [`rollback-playbook.md`](references/rollback-playbook.md). Step 11 code-vs-data asymmetry, compensating-forward, flag lineage, destructive-command gate.
- [`progressive-delivery.md`](references/progressive-delivery.md). Step 7 rollout strategies, the paper-canary rule, readiness-probe discipline.
- [`secrets-injection.md`](references/secrets-injection.md). Step 8 injection path from vault to runtime, per-topology patterns, supply-chain pitfalls.
- [`RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md). Source citations behind every guardrail and incident reference.

## The skill's named terms

Deploy-ready introduces three named failure modes the ecosystem did not already have a clean term for:

- **Paper canary.** A canary that routes traffic but has no named metric, no numeric threshold, no time or request window, and no automated rollback trigger. Appears green because nothing is looking. The skill refuses to call such a step a canary.
- **Expand-only migration trap.** The state where the expand phase shipped and the contract phase never did, leaving a permanent dual-schema liability that compounds across future migrations. The deploy calendar is the defense; STATE.md keeps the liability visible.
- **First-deploy blindness.** The class of failures that happens only on the first promotion to a new environment (missing env var, unset framework prefix, IAM role that does not exist, `.env` not read at build time, platform-specific gotchas). Distinct from "works on my machine" because it affects shipping, not development.

See [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md) section 5 for the naming-lane survey and section 7 for why these three were chosen.

## Contributing

Gaps, missing cases, outdated guidance, new incident citations: contributions welcome. Open an issue or PR. New guardrail patterns in [`zero-downtime-migrations.md`](references/zero-downtime-migrations.md) are especially valuable; migration footguns shift as databases evolve.

## License

[MIT](LICENSE)

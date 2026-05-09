# Launch Ready

> **Put a deployed, healthy app in front of real users without shipping AI-slop. Refuses hero-fatigue copy, spec-sheet positioning, paper waitlists, unrendered OG cards, and silent launches.**

> **Part of the [ready-suite](SUITE.md)**, a composable set of AI skills covering the full arc from idea to launch (planning, building, shipping). See [`SUITE.md`](SUITE.md) for the full map and the live sibling skills.

The app is deployed. The monitoring is green. The founder has eight weeks of runway and one shot at getting people to notice. What ships is a gradient-hero landing page whose hero sentence ("Empower your team with AI-powered productivity") describes Notion, Asana, Linear, and every other SaaS in the category. Six shadcn cards use the words "seamless" and "powerful" three times each. The OG image renders correctly on a developer laptop and at 600x315 thumbnail on LinkedIn shows a title the preview rendered as one unreadable line. The Show HN post gets flagged in seven minutes because the title starts with "Launch HN." The Product Hunt submission goes out at 9am Eastern because nobody mentioned 12:01 AM Pacific. The launch tweet has no UTM parameters; the founder cannot tell which of the five venues drove the four signups. The waitlist captured 143 emails; there is no email sequence scheduled. Two weeks later, activity is back to baseline.

None of this is a code bug. It is a launch-mechanics bug, and the tooling that exists today, from Framer to Kit to PostHog, has no opinion about any of it. This skill closes that gap. It refuses to call a sentence a hero if it survives the substitution test against a named competitor. It refuses to call a list of features a feature grid if there are more than six tiles. It refuses to ship an OG card that has not been previewed on five channels (X, LinkedIn, Slack, iMessage, Discord). It refuses to call an email list a waitlist if the pre-launch sequence is not drafted. It refuses to call a launch a launch if the D-7 to D+7 runbook has not been written down.

## Install

**Claude Code:**
```bash
git clone https://github.com/aihxp/launch-ready.git ~/.claude/skills/launch-ready
```

**Codex:**
```bash
git clone https://github.com/aihxp/launch-ready.git ~/.codex/skills/launch-ready
```

**pi, OpenClaw, or any [Agent Skills](https://agentskills.io)-compatible harness:**
```bash
git clone https://github.com/aihxp/launch-ready.git ~/.agents/skills/launch-ready
```

**Cursor:**
```bash
git clone https://github.com/aihxp/launch-ready.git ~/.cursor/skills/launch-ready
```

**Windsurf or other agents:**
Add `SKILL.md` to your project rules or system prompt. Load reference files as needed.

**Any agent with a plan-then-execute loop:**
Upload `SKILL.md` and the relevant reference files to your project context. The skill produces structured output (positioning docs, banned-word audits, OG-preview checklists, per-channel post-plans, D-7 to D+7 runbooks, UTM registries) that any planner can consume.

## The problem this solves

AI-assisted launch surfaces fail in predictable, identifiable, grep-testable ways. The pattern is so consistent across Claude / Cursor / Lovable / v0 / Bolt / Framer AI outputs that the skill enforces a banned-word list as a first-line defense. The fingerprints:

- **Hero-fatigue copy.** A hero sentence that describes the category, not the product. "Empower your team with AI-powered productivity" fits Notion, Asana, Linear, Monday, ClickUp, and every other SaaS in the decade. The sentence has no specificity; the substitution test fails in one read.
- **Spec-sheet positioning.** A feature grid with eight to twelve tiles, each one a category label ("Fast," "Secure," "Scalable") rather than a product-specific capability. The grid reads like a product spec, not a landing page.
- **AI-slop landing.** The full aesthetic: gradient hero, shadcn card grid, Inter typography, pastel icon blobs, three-column features, testimonial carousel, gradient CTA buttons. The page passes visual review and fails the "what does this do" test.
- **Unrendered OG.** An OG card that renders on the developer's laptop and is broken on every channel a real user encounters it. LinkedIn caches a broken render for 7 days, so a bug discovered on launch day is a bug that stays on LinkedIn for the entire launch window.
- **Paper waitlist.** A form captures emails. No confirmation email. No welcome email. No pre-launch sequence. No launch-day drop. The list accumulates for six months and decays to the point of unusability.
- **Silent launch.** Shared links without UTM parameters. Analytics without conversion-waterfall events. The founder cannot answer "where did the fourteen signups come from."
- **Launch-channel mismatch.** A Show HN post with "Launch HN" in the title (flagged on arrival). A Product Hunt post scheduled for Friday afternoon. A Reddit post to a sub where the founder has zero comment history. Each is a silent failure: the venue rejects without a loud error, and the founder learns about it from the traffic numbers.

Every named failure mode in the skill's research set (see [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md)) shares one or more traits: the landing page said something generic enough that no memory could form, the launch channel's etiquette was not respected, the launch-day telemetry was not wired, or the follow-through was not scheduled. launch-ready exists because none of the tools in the launch category are designed to say "no" to any of these shapes. Framer will render whatever you design. Kit will send whatever you draft. PostHog will capture whatever you tag. The skill is the layer above the tool that catches the launch configuration before it ships.

## When this skill should trigger

The short frontmatter description is tight on purpose, to speed up skill-routing decisions. The full trigger surface lives here.

**Positive triggers (build or ship the launch surface):**
- "launch my product" / "plan my launch"
- "build a landing page" / "write the landing page copy" / "hero copy"
- "design the OG card" / "set up Open Graph" / "social share preview"
- "add a waitlist" / "set up the waitlist" / "waitlist with a sequence"
- "launch-day SEO" / "meta tags for launch" / "schema.org for the product"
- "Product Hunt" / "PH post" / "Product Hunt launch"
- "Show HN" / "post to Hacker News" / "HN launch"
- "Reddit launch" / "r/SideProject" / "r/SaaS"
- "X launch thread" / "Twitter launch"
- "LinkedIn launch post" / "founder-voice launch"
- "Indie Hackers milestone"
- "dev.to launch article"
- "press kit" / "press outreach" / "pitch TechCrunch"
- "influencer outreach" / "podcast pitch"
- "UTM tracking" / "launch analytics" / "conversion waterfall"
- "launch week plan" / "launch-day runbook" / "D-7 to D+7"

**Implied triggers (the thesis word is never spoken):**
- "we are launching next week and nothing is ready"
- "my landing page doesn't convert"
- "nobody knows what our product does"
- "we launched and got 15 upvotes"
- "I need to tell people this exists"
- "the HN post got flagged"

**Mode triggers (see [SKILL.md](SKILL.md) Step 0):**
- Mode A: "we are pre-launch; start from scratch"
- Mode B: "we have a landing page but it is AI slop; fix it"
- Mode C: "we pivoted; relaunch the new story"
- Mode D: "we launched and nobody came; diagnose"
- Mode E: "B2B direct; no PH / HN, keep the rest"

**Negative triggers (route elsewhere):**
- Building the app ("wire the users page," "add RBAC") -> [`production-ready`](https://github.com/aihxp/production-ready)
- Deploying the app ("CI/CD," "canary," "migration") -> [`deploy-ready`](https://github.com/aihxp/deploy-ready)
- Monitoring the app ("SLO," "Datadog," "runbook") -> [`observe-ready`](https://github.com/aihxp/observe-ready)
- Picking the tool ("Framer vs. Webflow," "Kit vs. Loops") -> [`stack-ready`](https://github.com/aihxp/stack-ready)
- Repo hygiene ("CODEOWNERS," "release automation") -> [`repo-ready`](https://github.com/aihxp/repo-ready)
- In-app product telemetry (feature adoption, retention cohorts, A/B tests) -> `production-ready`'s analytics-and-telemetry reference
- Transactional email (password reset, receipts) -> `production-ready`'s notifications-and-email reference
- Ongoing marketing (content cadence, paid ads, sustained nurture) -> separate discipline, not in scope
- Pricing strategy (what to charge) -> business decision, not a skill
- Brand identity in the deep sense (logo, full type scale) -> upstream of launch-ready; consumes production-ready's tokens
- Legal copy (privacy, ToS) -> legal review; skill only flags the requirement
- App Store / Play Store listings -> out of scope for v1.0.0

**Pairing:** `deploy-ready` and `observe-ready` (same shipping tier). The three compose at the launch boundary: deploy-ready owns the pipeline, observe-ready owns the health surface, launch-ready owns the user-facing surface. A launch that does not read `.deploy-ready/STATE.md` risks shipping on top of an in-progress migration; a launch that does not read `.observe-ready/SLOs.md` risks a traffic spike burning the budget. See [SKILL.md](SKILL.md) "Handoff" section.

## How it works

Thirteen steps, four completion tiers, one artifact family under `.launch-ready/`.

1. **Step 0.** Detect launch state and mode (greenfield, AI-slop rewrite, re-launch, rescue, quiet B2B).
2. **Step 1.** Positioning and the substitution test: four sentences against named competitors.
3. **Step 2.** Landing page anatomy: five canonical sections in order; hero, social proof, feature grid, pricing, CTA.
4. **Step 3.** Copy discipline and the banned-word audit (seamless / powerful / revolutionary / effortless / intelligent / cutting-edge / game-changing / unlock / supercharge / streamline / empower / elevate / robust / best-in-class / leading / enterprise-grade / world-class).
5. **Step 4.** Visual identity and the aesthetic test (one naive viewer, one question).
6. **Step 5.** Launch-day SEO fundamentals: meta, OG, Twitter, schema.org, sitemap, robots, canonical, Core Web Vitals.
7. **Step 6.** OG social share cards: 1200x630, under 300KB, legible at 600x315, verified on X / LinkedIn / Slack / iMessage / Discord.
8. **Step 7.** Waitlist and email funnel: tool choice, double opt-in, confirmation, welcome, pre-launch sequence, launch-day drop, post-launch sequence, domain auth.
9. **Step 8.** Launch channel strategy: venue-specific titles, timing, hunter/submitter, amplification list, response plan.
10. **Step 9.** Press and outreach: press kit, niche target list, pitch email, influencer and podcast outreach.
11. **Step 10.** Launch-day telemetry: UTM taxonomy, conversion waterfall, referrer dashboard, traffic-spike readiness, status page.
12. **Step 11.** Launch-week runbook: D-7 through D+7 calendar with timezone-aware launch-day schedule.
13. **Step 12.** Post-launch transition: retrospective, waitlist segmentation, campaign close, handoff to production-ready's ongoing telemetry.

Tiers: **Positioned** (5), **Landed** (5), **Captured** (5), **Launched** (5). See [SKILL.md](SKILL.md) for per-tier requirements.

## What this skill prevents

Mapped against recurring, documented launch-shaped failures:

| Real incident or research finding | What this skill enforces that prevents it |
|---|---|
| **Shadcn-default aesthetic critiques** (Harry Dry, Swipe Files, Marketing Examples): indistinguishable SaaS landings | Step 1 substitution test; Step 3 banned-word audit; Step 4 aesthetic test with a naive viewer. |
| **Julian Shapiro landing-page guide** (julian.com/guide/growth): hero specificity + audience frame + what-it-replaces | Step 1 four-sentence positioning doc; replacement-framed differentiator per April Dunford. |
| **April Dunford *Obviously Awesome* positioning framework**: competitive-alternative framing beats feature framing | Step 1 "what it replaces" sentence required; feature grid rejected if not paired with replacement framing. |
| **AI-slop copy patterns** (Claude / Cursor / v0 / Lovable outputs flagged across Twitter / Reddit / IH): overuse of empower, seamless, revolutionary, effortless, intelligent, powerful | Step 3 banned-word list; grep-testable; zero hits above the fold without justification. |
| **Show HN flag dynamics** (news.ycombinator.com/showhn.html, Paul Graham guidelines): "Launch HN" non-YC, all-caps, or video-only triggers flagging | Step 8 venue-specific title rules; Show HN naming convention enforced. |
| **Product Hunt timing orthodoxy** (Ben Lang, Chris Messina, Rubén Gámez): 12:01 AM PT Tuesday/Wednesday/Thursday, hunter confirmed >48h | Step 8 timing and hunter-confirmation gates; Friday/Saturday/Sunday launches blocked. |
| **Reddit 9:1 rule**: subreddits require participation-to-promotion ratio | Step 8 comment-history check; zero-history subs blocked. |
| **LinkedIn OG cache duration (at least 7 days)**: a broken OG on launch day is broken for the entire window | Step 6 Post Inspector pre-clearance; five-channel preview rule. |
| **Waitlist decay without follow-through** (ConvertKit, Loops, Beehiiv deliverability blogs): lists unused for 6+ months lose 40-60% deliverability | Step 7 pre-launch sequence required; paper-waitlist refusal. |
| **UTM absence on launch-day shares**: founders cannot attribute post-launch signups by source | Step 10 UTM taxonomy mandatory across every shared link. |
| **Silent de-indexing via stray noindex**: AI-generated landing pages inherit `<meta name="robots" content="noindex">` from template defaults | Step 5 grep for noindex before shipping; SEO checklist item. |
| **Core Web Vitals red on PageSpeed**: launch-day traffic spike amplifies LCP and CLS penalties; first-visit conversion burn | Step 5 PSI green zone required; traffic-spike readiness in Step 10. |
| **Status page dependent on the app** (the Facebook 2021 / Slack 2021 pattern from observe-ready): status page unreachable during the incident it exists for | Step 10 out-of-band status page; observe-ready's INDEPENDENCE.md consulted. |
| **Launch on top of in-progress expand/contract migration** (deploy-ready's migration calendar): traffic spike meets half-deployed schema | Step 11 reads `.deploy-ready/STATE.md`; blocks launch-day drop on non-green deploy state. |
| **Landing page promises vapor features**: founder-written copy advertises features the shipped app does not have | Step 2 reads `.production-ready/STATE.md`; any feature not in STATE.md is flagged as vapor. |
| **No retrospective after silent launch**: founder relaunches without naming the dominant failure (positioning, venue, amplification, capture, timing) | Step 12 retrospective required before campaign close; Mode C and Mode D detection. |

## Reference library

Load each reference *before* the step that uses it, not after. Full tier annotations in [SKILL.md](SKILL.md).

- [`launch-research.md`](references/launch-research.md). Step 0 mode detection protocol and the launch-failure dominant-cause procedure.
- [`positioning-and-copy.md`](references/positioning-and-copy.md). Step 1 and Step 3 substitution test, differentiator test, April Dunford replacement framing, banned-word audit with replacements, tone of voice.
- [`landing-page-anatomy.md`](references/landing-page-anatomy.md). Step 2 and Step 4 five-section layout, above-the-fold discipline, anti-patterns, visual identity tokens, aesthetic test.
- [`seo-fundamentals.md`](references/seo-fundamentals.md). Step 5 meta, Open Graph, Twitter cards, schema.org JSON-LD, sitemap.xml, robots.txt, canonical, Core Web Vitals.
- [`social-share-cards.md`](references/social-share-cards.md). Step 6 five-channel preview rule, OG image specs, cache TTLs, generation tool landscape (@vercel/og, Tailgraph, Bannerbear, Cloudinary).
- [`waitlist-and-email.md`](references/waitlist-and-email.md). Step 7 tool landscape (Kit, Loops, Resend, Plunk, Beehiiv, EmailOctopus, Buttondown), double opt-in, pre-launch sequence, launch-day drop, post-launch sequence, deliverability (SPF/DKIM/DMARC).
- [`launch-channels.md`](references/launch-channels.md). Step 8 Product Hunt, Show HN, Reddit, X, LinkedIn, IH, dev.to etiquette, timing, titles, hunters, amplification, response plans.
- [`press-and-outreach.md`](references/press-and-outreach.md). Step 9 press kit contents, niche target list, pitch email format, influencer and podcast outreach.
- [`launch-telemetry.md`](references/launch-telemetry.md). Step 10 UTM taxonomy, analytics tool comparison, conversion waterfall, referrer dashboard, traffic-spike readiness.
- [`launch-week-runbook.md`](references/launch-week-runbook.md). Step 11 D-7 to D+7 calendar, launch-day timezone-aware schedule, response templates.
- [`post-launch-transition.md`](references/post-launch-transition.md). Step 12 transition criteria, retrospective template, handoff to production-ready.
- [`RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md). Source citations behind every guardrail, incident, and banned-word choice.

## The skill's named terms

launch-ready introduces five named failure modes the ecosystem did not already have a clean term for. Each maps to a specific class of AI-generated launch output the skill refuses.

- **Hero-fatigue copy.** A hero sentence whose claim survives the substitution test against named competitors. The sentence is syntactically correct, tonally fine, and says nothing specific. "Empower your team with AI-powered productivity" describes the category, not the product.
- **Spec-sheet positioning.** A feature grid that reads like a product spec: category labels (Fast / Secure / Scalable) rather than product-specific capabilities; more than six tiles; no differentiator threaded through. Distinct from "too many features" because the term names the artifact's shape, not its size.
- **AI-slop landing.** The full aesthetic pattern: gradient hero, shadcn card grid, Inter typography, pastel icon blobs, three-column features, gradient CTA buttons, testimonial carousel. The page passes a visual-design review and fails the "what does this do" test. The cousin of deploy-ready's "paper canary" and observe-ready's "paper SLO" across shipping-tier siblings: an artifact present, a mechanism absent.
- **Paper waitlist.** A waitlist that captures emails with no double opt-in, no welcome email, no pre-launch sequence, no launch-day drop, and no post-launch follow-through. The form works; the funnel does not.
- **Unrendered OG.** An Open Graph card that renders correctly on the developer's laptop and breaks on one or more of the five channels a real user will see it through (X, LinkedIn, Slack, iMessage, Discord). LinkedIn's cache (at least 7 days) makes a shipped-broken OG a launch-week liability.
- **Silent launch.** A launch with no UTM-tagged share links and no conversion-waterfall events. Signups arrive; the founder cannot attribute them to source; the retrospective cannot diagnose which of the five launch-failure causes dominated.

See [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md) for the naming-lane survey and the pattern derivations.

## Contributing

Gaps, missing cases, outdated guidance, new banned words, new incident citations: contributions welcome. Open an issue or PR. The banned-word list is especially alive; new AI-slop tells emerge with each model generation, and the list is versioned accordingly.

## License

[MIT](LICENSE)

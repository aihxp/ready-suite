# RESEARCH-2026-04: Foundations for the roadmap-ready skill

Date: 2026-04-23
Purpose: Research pass feeding the design of the `roadmap-ready` skill, the ninth and final skill in a composable AI-skills suite for software-product teams. `roadmap-ready` owns the question "given what we're building and how the pieces fit, what ships when and why?" This report is the citation base for SKILL.md's "why this rule" prompts and for the README's "What this skill prevents" table.

The nine skills in the suite: `prd-ready`, `architecture-ready`, `roadmap-ready`, `stack-ready`, `repo-ready`, `production-ready`, `deploy-ready`, `observe-ready`, `launch-ready`. Upstream of roadmap-ready: PRD + architecture. Downstream: stack, repo, production, deploy, observe, launch.

Formatting rules for this document: ASCII only. No em or en dashes. No emoji. No Unicode arrows. Use `->` for arrows, `-` for hyphens, parentheses or colons or two sentences for asides.

---

## Table of Contents

1. Named failure modes of software roadmaps
2. AI-generated roadmap failure patterns (2024-2026)
3. Canonical roadmap literature
4. Outcome-based vs. output-based roadmaps
5. Cadence models in practice
6. Sequencing and risk-driven prioritization
7. Dependency graphs and parallelism
8. Launch milestone identification and sequencing
9. How downstream tools and people actually read a roadmap
10. Current state of the art, 2026
11. Decision summary for roadmap-ready v1.0.0

---

## 1. Named failure modes of software roadmaps

The product-management vocabulary for roadmap pathology is inconsistent. Some terms are canonical (feature factory), some are emergent but widely-used (Now-Next-Later as a positive counter-pattern), and some ("roadmap theater", "speculative roadmap", "shelf roadmap") are used in the wild without a settled coiner. This section maps what is taken, what is open, and what `roadmap-ready` can adopt vs. coin.

### Feature factory (taken, well-attributed)

The phrase was popularized by John Cutler in his August 2016 Medium post "12 Signs You're Working in a Feature Factory" (https://cutle.fish/blog/12-signs-youre-working-in-a-feature-factory/, republished at https://medium.com/@johnpcutler/12-signs-youre-working-in-a-feature-factory-44a5b938d6a2). Cutler credits the phrase to a software-developer friend who said he was "just sitting in the factory, cranking out features, and sending them down the line" (https://amplitude.com/blog/12-signs-youre-working-in-a-feature-factory-3-years-later).

Cutler's twelve signs, still cited verbatim nearly a decade later, include: no measurement of feature impact, rapid shuffling of teams and projects ("Team Tetris"), infrequent acknowledged failures, no PM retrospectives, obsessing about prioritization with no matching validation, roadmaps that show a list of features rather than areas of focus or outcomes, and immediate movement to the next project after "done" (https://cutle.fish/blog/12-signs-youre-working-in-a-feature-factory/, https://www.mindtheproduct.com/break-free-feature-factory-john-cutler/).

Cutler later argued the root cause is trust, not measurement: "data is not a silver bullet and will not solve any issue of trust inside a company" (https://amplitude.com/blog/12-signs-youre-working-in-a-feature-factory-3-years-later).

Melissa Perri's "Escaping the Build Trap" (O'Reilly, 2018) is sometimes conflated with Cutler's coinage. Perri's term is "the build trap", not "feature factory", but the anti-pattern is the same: teams whose proxy for value is number of features shipped, not outcomes delivered (https://melissaperri.com/book, https://lethain.com/notes-escaping-the-build-trap/, https://www.amazon.com/Escaping-Build-Trap-Effective-Management/dp/149197379X). Perri identifies three anti-archetypes of product managers in a build trap: the mini-CEO, the waiter (the order-taker), and the former project manager (https://userpilot.com/blog/escaping-build-trap-mellisa-perri/).

Both "feature factory" and "build trap" are taken terms with clear attributions. `roadmap-ready` can reference them without coining new labels.

### Roadmap theater (emerging, not formally coined)

The phrase "roadmap theater" does not appear to have a single canonical coiner, but the concept (roadmap as performance, not commitment) shows up repeatedly in recent writing. The AI-Powered Project Manager Substack calls it out explicitly: project roadmaps "often concoct confidence in dates pulled from thin air, lock in expectations teams can't meet, and train stakeholders to ignore you because the dates always shift" (https://theaipoweredprojectmanager.substack.com/p/your-project-roadmap-is-a-lie-you).

Appcues describes the Gantt-chart variant: "the visual confidence of the chart can exceed the actual confidence of the underlying knowledge" (https://www.appcues.com/blog/a-gantt-chart-is-not-a-product-roadmap). ProductPlan's "Gantt Chart vs. Roadmap" essay makes the same case: Gantt charts are for tasks with known dependencies and durations, roadmaps are for strategic intent under uncertainty (https://www.productplan.com/learn/gantt-chart-vs-roadmap-whats-the-difference).

"Roadmap theater" is grep-testable and rhetorically sharp. Because no one owns it, `roadmap-ready` can adopt it as a named failure mode without attribution conflict. Analogous to "agile theater" and "security theater".

### Date-driven vs. scope-driven (taken; Shape Up framing)

Shape Up's "Fixed time, variable scope" is the canonical re-framing of this tradeoff (https://basecamp.com/shapeup/1.2-chapter-03). Ryan Singer's argument: traditional project planning fixes scope and lets time vary (so the date slips). Shape Up fixes time and lets scope flex (so the date holds). "Date-driven" in Singer's usage is a positive term; what the skill should flag is scope-driven masquerading as date-driven: a fixed date committed with scope still open-ended (https://gerrygastelum.medium.com/fixed-time-variable-scope-f648d2765a32, https://emergingtecheast.com/session/fixed-time-variable-scope-in-the-shape-up-methodology/).

### Now-Next-Later (positive counter-pattern; Janna Bastow, ProdPad, 2012)

Janna Bastow introduced the Now-Next-Later roadmap in 2012 at ProdPad. The framing: Now = actively building, clearly defined, in progress; Next = on deck, not fully spec'd, timing uncertain; Later = long-term strategic direction, greatest uncertainty (https://www.prodpad.com/blog/outcome-based-roadmaps/, https://productmanagementresources.com/now-next-later-roadmap/, https://open.spotify.com/episode/6E0v24z3S5hWp2huRbcarM). Bastow calls the roadmap "a prototype for your product strategy" - the value is in the roadmapping process, not the artifact (https://www.producttalk.org/product-roadmaps/).

This is the most widely-adopted non-quarterly roadmap structure in the 2020-2026 period, used at ProdPad, Intercom variants, many startups, and recommended by Teresa Torres when leaders insist on roadmaps (https://www.producttalk.org/2023/10/roadmaps-with-timelines/).

### Quarter fallacy (descriptive, not canonical)

Douglas Hofstadter's 1979 adage: "It always takes longer than you expect, even when you take into account Hofstadter's law" (https://en.wikipedia.org/wiki/Hofstadter's_law). Daniel Kahneman and Amos Tversky's planning fallacy (1979): predictions about future task durations show optimism bias and systematic underestimation (https://en.wikipedia.org/wiki/Planning_fallacy).

Applied to quarterly roadmap buckets: filling all four quarters with work-items implicitly claims all will be delivered, which contradicts empirical estimation data. A study of 16 years of NASA software projects found systematic effort underestimation by 1.4x to 4.3x (https://medium.com/@aymen.benammar.ensi/hofstadters-law-why-your-software-project-will-be-late-even-after-reading-this-article-2661bdc3a9bd). The "quarter fallacy" name isn't canonical; `roadmap-ready` may coin a sharper name ("quarter stuffing", "Q-bucket fallacy") or use the descriptive.

### Fictional parallelism (descriptive; not canonical under this exact name)

The term does not appear to have a single coiner, but the concept is widely-documented. American Psychological Association research cited by project-management writers shows task-switching reduces productivity by up to 40% (https://www.parallelprojecttraining.com/blog/the-multi-tasking-myth-in-project-management-why-single-tasking-is-the-key-to-productivity/, https://t2informatik.de/en/blog/multitasking-madness-in-project-management/). Critical Chain Project Management (Eliyahu Goldratt, "Critical Chain", 1997) attacks exactly this pattern: resource contention across ostensibly-parallel tasks collapses to serial execution with delay penalties (https://en.wikipedia.org/wiki/Critical_chain_project_management, https://tameflow.com/blog/2012-09-25/critical-chain-project-management-in-TOC/).

"Fictional parallelism" as a phrase is grep-testable and not owned. `roadmap-ready` can adopt.

### Shelf roadmap / speculative roadmap (descriptive; not canonical)

Roman Pichler's "10 Product Roadmapping Mistakes to Avoid" catalogues adjacent failure modes: roadmap not grounded in strategy, overly ambitious commitments, perfect-roadmap polish (https://www.romanpichler.com/blog/product-roadmapping-mistakes-to-avoid/, https://www.linkedin.com/pulse/10-product-roadmapping-mistakes-avoid-roman-pichler). ProductPlan lists six reasons roadmaps fail: misalignment with strategy, no outcome tie, false precision, politics, lack of socialization, and getting shelved (https://www.productplan.com/learn/reasons-product-roadmaps-fail/). ProdPad's "The Problem with the Perfect Roadmap" makes the case that polish correlates with staleness (https://www.prodpad.com/blog/problem-perfect-roadmap/).

The phrase "shelf roadmap" (roadmap written once, filed, never consulted) is used colloquially but not widely in print. `roadmap-ready` can coin or adopt.

### Outcome roadmap vs. feature roadmap (the axis, not a failure mode per se)

The central debate 2018-2026. Marty Cagan's "The Alternative to Roadmaps" (SVPG, September 2015) is the canonical anti-feature-roadmap essay: "95% of roadmaps are not outcome-based but output roadmaps" (https://www.svpg.com/the-alternative-to-roadmaps/). See Section 4 for the full debate.

### Summary: what `roadmap-ready` can adopt vs. coin

- **Taken and well-attributed**: feature factory (Cutler), build trap (Perri), fixed time / variable scope (Singer/Basecamp), Now-Next-Later (Bastow/ProdPad), outcome-based vs. output-based (Cagan et al.), planning fallacy (Kahneman/Tversky), Hofstadter's law (Hofstadter).
- **Emerging, safe to adopt as described**: roadmap theater, fictional parallelism, shelf roadmap, speculative roadmap.
- **Potentially coinable by `roadmap-ready`**: quarter fallacy (or: "quarter-stuffing"), perpetual now (the inverse of shelf: always-urgent, never-sequenced), linear roadmap (single-track assumption where multiple exist).

---

## 2. AI-generated roadmap failure patterns (2024-2026)

This section catalogues the observable failure modes when LLMs and LLM-backed PM tools produce roadmaps. Sources span vendor docs, product-management blogs, and industry commentary. Hacker News and Reddit surfaced less specific "roadmap hallucination" discussion than expected (the search returned mostly generic AI-hallucination debates, not roadmap-specific), so this section leans on product-management writing and vendor-comparison reviews.

### Fictional precision

The most consistently-observed pattern: LLMs produce Gantt charts with start/end dates, sometimes to the day, with no empirical basis. Appcues notes more broadly (applicable to both human and AI roadmaps): "the visual confidence of the chart can exceed the actual confidence of the underlying knowledge" (https://www.appcues.com/blog/a-gantt-chart-is-not-a-product-roadmap).

The AI-Powered Project Manager Substack frames it as "concocting confidence in dates pulled from thin air" (https://theaipoweredprojectmanager.substack.com/p/your-project-roadmap-is-a-lie-you). Applied to AI-generated roadmaps: the model has no visibility into team capacity, dependency resolution, or organizational context, yet emits precise dates anyway.

### Feature wishlist with no time axis

ChatPRD and similar tools generate PRD content and feature lists but do not connect them to sequencing. The ChatPRD product itself is documented as PRD-focused: "ChatPRD's catch is that it writes documents but doesn't connect them to roadmaps or execution, so you still need other tools to track what actually ships" (https://blog.buildbetter.ai/12-best-ai-product-management-tools-for-2025/). The output is a backlog, not a roadmap, but often presented as a roadmap. The result: lists with no appetite, no capacity match, no dependency order.

### Invented deadlines

LLMs default to filling templates, and common roadmap templates have date columns. Without explicit instruction to leave dates blank or to express uncertainty, the model fabricates. This is the same pattern as code hallucination (invented APIs, fake imports) applied to temporal commitments. Industry writing documents that "strategic decisions and user empathy remain the PM's domain" (https://www.chatprd.ai/learn/capabilities-of-ai-agents-product-management) - in practice, this means deadlines are exactly the wrong thing for an LLM to produce without human anchoring.

### Quarterly buckets that cram everything equally

A common AI pattern: given a feature list, distribute items evenly across Q1-Q4. The visual effect is a balanced grid. The modeling error: every quarter looks equally full and equally confident, contradicting Now-Next-Later's core insight that later items should be less precise, not equally precise (https://www.prodpad.com/blog/outcome-based-roadmaps/, https://productmanagementresources.com/now-next-later-roadmap/).

### Ignored dependencies

LLMs generating roadmaps from PRD text rarely infer that "checkout flow" requires "payments provider integration" which requires "compliance review" which requires "legal sign-off". The dependency chain is often visible in the architecture document but not encoded in the roadmap. This produces parallel-looking tracks that cannot actually run in parallel (see Section 7, fictional parallelism).

### Invisible parallelism

Related but distinct: even when dependencies are respected, LLM-generated roadmaps treat team capacity as infinite. Items stack in the same time column without capacity check. Amdahl's law applied to team scaling (https://en.wikipedia.org/wiki/Amdahl's_law, https://shahbhat.medium.com/applying-laws-of-scalability-to-technology-and-people-5884b4b4b04): serial fractions of work (reviews, coordination, shared-service dependencies) cap the achievable parallelism regardless of team size.

### Speculative features nobody specced

LLMs generating a roadmap from a vision doc will often hallucinate feature titles that were never specced, named in the PRD, or agreed in discovery. These look plausible (a good LLM produces plausible names) but are not commitments anyone has made. This is the AI version of the speculative roadmap failure mode.

### Tool-specific observations (2024-2026)

- **Productboard AI**: machine learning links customer feedback to feature ideas; roadmap prioritization is data-informed (https://www.productboard.com/blog/using-ai-for-product-roadmap-prioritization/). Limitation: "Productboard still doesn't track execution, so you need JIRA or Linear to see what engineering is actually building" (https://blog.buildbetter.ai/12-best-ai-product-management-tools-for-2025/).
- **Atlassian Rovo (Jira)**: rolled out to Jira Cloud April-October 2025. Can "turn a Jira Product Discovery view into a Confluence roadmap in minutes" (https://www.atlassian.com/software/jira/ai, https://idalko.com/blog/atlassian-rovo-transformation). Strength: operates over real data (your Jira tickets). Risk: same grid-generation issue when Jira data is sparse.
- **ChatPRD**: 250,000 documents generated across 30,000 users by 2025 (https://blog.buildbetter.ai/12-best-ai-product-management-tools-for-2025/). PRD-first, not roadmap-first.
- **Linear's AI features** (2025-2026): focused on triage, duplicate detection, project summarization, less on roadmap generation itself; roadmap surface is treated as a view over projects/cycles (https://monday.com/blog/rnd/linear-or-jira/).
- **Aha! AI**: enterprise-roadmap-oriented; strategic idea management and capacity-planning assistance (https://zeda.io/blog/aha-vs-jira).
- **Notion AI**: general-purpose; produces roadmap-like documents but inherits all of the above failure modes (fictional precision, no dependency check).

### The honest-broker gap

Across vendor docs, tool comparisons, and independent reviews, the same observation recurs: AI is strong at synthesis (triaging feedback, drafting document sections) and weak at commitment (which thing ships when, why this order). "AI excels at data synthesis and repetitive tasks, but strategic decisions and user empathy remain the PM's domain" (https://www.chatprd.ai/learn/capabilities-of-ai-agents-product-management). The productivity gap cited in vendor-comparison writing is "impossible to ignore" in favor of AI-native tools, but this is a synthesis gap, not a sequencing gap (https://blog.buildbetter.ai/12-best-ai-product-management-tools-for-2025/).

This is the niche `roadmap-ready` should occupy: not a better generator, a stricter refuser. A skill that says "I cannot commit to a date without capacity input" and "I cannot sequence items without a dependency graph" is the honest-broker response. Vendor tools do not refuse enough; they generate.

---

## 3. Canonical roadmap literature

### Ryan Singer, "Shape Up: Stop Running in Circles and Ship Work that Matters" (Basecamp, 2019)

Full text free online at https://basecamp.com/shapeup. The verbatim rules:

**Six-week cycles + two-week cool-down.** "Six weeks is long enough to build something meaningful start-to-finish and short enough that everyone can feel the deadline looming from the start" (https://basecamp.com/shapeup, https://www.curiouslab.io/blog/what-is-basecamps-shape-up-method-a-complete-overview). After each cycle, two weeks of cool-down: no scheduled work, bug fixes, exploration, planning for the next cycle (https://basecamp.com/shapeup/4.5-appendix-06, https://jujodi.medium.com/cool-downs-in-shape-up-some-practical-guidance-4f3656ceaaa).

**Appetite vs. estimate.** Instead of "how long will this take?" ask "how much time is this worth?" (https://basecamp.com/shapeup/1.2-chapter-03). Appetite fixes time; scope flexes. Small batch: two weeks. Big batch: six weeks. Nothing longer.

**The pitch (five elements).** Problem (one specific story that shows why status quo fails); appetite (two or six weeks); solution (core elements in easy-to-grasp form); rabbit holes (what could sink the work); no-gos (what is explicitly excluded) (https://basecamp.com/shapeup/1.5-chapter-06, https://basecamp.com/shapeup/1.4-chapter-05).

**The betting table.** A meeting during cool-down where senior stakeholders decide the next cycle's bets. At Basecamp: CEO, CTO, senior programmer, product strategist (https://basecamp.com/shapeup/2.2-chapter-08). Potential bets are pitches shaped during the last cycle or resurrected older pitches. "Bet" is the operative verb: this is a bet, not a commitment to a certainty.

**The circuit breaker.** "If a project doesn't finish in six weeks, you don't automatically continue it" (https://basecamp.com/shapeup). The default is to cancel and re-shape; extension is the exception.

**Hill charts.** A dot that moves from uphill (figuring it out) to downhill (executing on known work). A dot that stops moving is "a raised hand" - something is wrong (https://basecamp.com/shapeup/3.4-chapter-13).

**Scope.** Work is decomposed into scopes; each scope is one thing. Three parts = three scopes (https://basecamp.com/shapeup/4.5-appendix-06).

### Melissa Perri, "Escaping the Build Trap" (O'Reilly, 2018)

The central frame: "the build trap" is when quantity of features shipped becomes the metric. To escape, three ingredients are needed: strategy, process, organization (https://melissaperri.com/book, https://www.productbookshelf.com/2020/11/becoming-a-product-led-company/, https://userpilot.com/blog/escaping-build-trap-mellisa-perri/). "Solving big problems for customers creates big value for businesses" (Perri, paraphrased widely). Three anti-archetypes: mini-CEO, waiter, former project manager.

Perri's outcome-based roadmap view aligns with Cagan's: roadmap structured around business outcomes and opportunities, not feature lists.

### Marty Cagan, "Inspired" (2008, 2nd ed. 2017) and "Transformed" (2024, SVPG)

"The Alternative to Roadmaps" (SVPG, Sept 2015, https://www.svpg.com/the-alternative-to-roadmaps/) is the canonical Cagan essay on roadmaps. Two truths: "at least half of product ideas won't work, and even ideas that prove valuable typically take several iterations to deliver the expected business value." His claim: "95% of roadmaps are not outcome-based but output roadmaps."

Cagan's replacement is not "no roadmap" but "objectives plus high-integrity commitments": empowered teams get prioritized business outcomes, and when a specific date is genuinely required, it goes through a high-integrity commitment process (design, discovery, explicit sign-off) (https://www.svpg.com/the-alternative-to-roadmaps/, https://www.svpg.com/roadmap-alternative-faq/).

"Transformed" (2024) extends this into a full operating-model prescription: the product operating model, empowered product teams, product culture, product strategy (https://digitalgonzo.medium.com/review-marty-cagans-transformed-moving-to-the-product-operating-model-c8bc312ba435).

### Janna Bastow, ProdPad (2012-present)

Now-Next-Later, invented 2012. "The further away something is, the more uncertain it is, and your roadmap should reflect that" (https://productmanagementresources.com/now-next-later-roadmap/). ProdPad's roadmap tool is the canonical implementation; Bastow is host of "Talking Roadmaps" (https://www.talkingroadmaps.com/).

Bastow's framing: feature-and-date roadmaps encode three false assumptions (feature delivery timelines are knowable, the features will be viable, the features deserve to exist) (https://www.prodpad.com/blog/outcome-based-roadmaps/). Now-Next-Later replaces those with uncertainty gradients.

### C. Todd Lombardo and Bruce McCarthy et al., "Product Roadmaps Relaunched" (O'Reilly, 2017)

Sub-title: "How to Set Direction while Embracing Uncertainty" (https://www.oreilly.com/library/view/product-roadmaps-relaunched/9781491971710/, https://www.amazon.com/Product-Roadmaps-Relaunched-Direction-Uncertainty/dp/149197172X). The book argues modern roadmaps must explain strategic context, center customer value, and commit to outcomes not outputs.

Steve Blank on the book: "It's about time someone brought product roadmapping out of the dark ages of waterfall development and made it into the strategic communications tool it should be" (quoted at https://howtoes.blog/2025/06/07/product-roadmaps-relaunched-a-book-summary/).

The "lean roadmap" pattern: themes over features, confidence bands over dates, living document over frozen artifact.

### Teresa Torres, "Continuous Discovery Habits" (2021) and Opportunity Solution Trees

OST introduced 2016; formalized in the 2021 book (https://www.producttalk.org/opportunity-solution-trees/, https://www.shortform.com/blog/teresa-torres-opportunity-solution-tree/).

Structure (four layers, top to bottom): Outcome (measurable business result) -> Opportunities (unmet customer needs) -> Solutions (ideas that address opportunities) -> Experiments (tests validating the solution) (https://productschool.com/blog/product-fundamentals/opportunity-solution-tree).

Continuous discovery is defined as "conducting small research activities through weekly touchpoints with customers, by the team who's building the product" (https://userpilot.com/blog/continuous-discovery-framework-teresa-torres/). Relevance to roadmap-ready: OST is the upstream artifact that feeds an outcome roadmap. An outcome roadmap without discovery input is speculation.

On timelines, Torres's advice when leaders insist: share a Now-Next-Later with honest confidence bands, not a date Gantt (https://www.producttalk.org/2023/10/roadmaps-with-timelines/).

### Lenny Rachitsky, Lenny's Newsletter

"Where Great Product Roadmap Ideas Come From" (https://www.lennysnewsletter.com/p/where-great-product-roadmap-ideas, republished https://medium.com/swlh/where-great-product-roadmap-ideas-come-from-6392ccd0a3e3): sources of roadmap items are conversations with customers, behavioral data, using the product yourself, quiet thinking, teammate discussions, working backwards from vision.

"One Team, One Roadmap" (https://www.lennysnewsletter.com/p/one-team-one-roadmap-issue-27): the roadmap is a single artifact shared across functions, not an engineering version and a marketing version.

Rachitsky has also curated product-management templates (https://www.lennysnewsletter.com/p/my-favorite-templates-issue-37). The most-cited in his network: Kevin Yien (Square) PRD template; Intercom's story template; Asana's project brief.

### Intercom (Des Traynor, Paul Adams)

The "666 roadmap": six years, six months, six weeks (https://www.intercom.com/blog/podcasts/intercom-on-product-ep12/, https://www.intercom.com/blog/podcasts/podcast-paul-adams-on-product/). Adams brought a version (originally 20 years / 6 months) from Facebook; Intercom compressed 20 to 6 to keep it tractable.

Four roadmap inputs at Intercom: Customer Voice Report, Problems To Be Solved docs, internal strategy, and customer research (existing, prospective, churned) (https://www.intercom.com/blog/podcasts/podcast-paul-adams-on-product/).

"Intercom on Product: One for the roadmap" (https://www.intercom.com/blog/podcasts/intercom-on-product-ep12/): the roadmap process should evolve as the company scales; the same format does not fit 10 people and 500.

### Atlassian / Jira roadmap patterns

Atlassian's roadmap tooling spans basic Jira Roadmaps, Advanced Roadmaps (formerly Portfolio for Jira), and Jira Product Discovery. Rovo AI (2025-2026) adds natural-language roadmap generation from JPD views (https://www.atlassian.com/software/jira/ai, https://idalko.com/blog/atlassian-rovo-transformation). Rovo for Jira rolled out April-July 2025 for Premium/Enterprise and August-October 2025 for Standard (https://idalko.com/blog/atlassian-rovo-transformation).

The dominant Atlassian cultural pattern: roadmap = epic-with-timeline view. Good when epics are well-bounded. Bad (feature-factory-enabling) when used uncritically.

### The #NoEstimates movement (Woody Zuill, Neil Killick, Vasco Duarte)

Started as a Twitter hashtag around 2012 (https://builtin.com/software-engineering-perspectives/noestimates-software-effort-estimations, https://neilkillick.wordpress.com/2013/01/31/noestimates-part-1-doing-scrum-without-estimates/). Core argument: estimation is often waste; consistent small-slice delivery provides forecasting signal without ceremony.

Killick's phrasing: "estimation is not needed when the team is constantly delivering value to the market and/or end-users" (https://www.infoq.com/interviews/killick-no-estimates/). Technique: story slicing into deployable chunks (https://softwaredevelopmenttoday.com/noestimates/).

Critics (Ron Jeffries is a sometimes-participant, sometimes-skeptic; Glen Alleman and David Anderson have critiqued the strong form) argue estimates are necessary for portfolio-level commitments. The common-ground position (Killick 2016): the debate is about when estimates add value, not whether they ever do (https://neilkillick.wordpress.com/2016/03/12/the-common-ground-of-estimates-and-noestimates/).

Relevance to `roadmap-ready`: the skill must decide whether to force estimates or allow appetite-only commitments. Shape Up sidesteps estimates via appetite. `roadmap-ready` should allow both modes.

### Basecamp as cultural artifact

"Options, Not Roadmaps" (https://basecamp.com/articles/options-not-roadmaps): Basecamp's explicit statement that they do not maintain public roadmaps. Reason: "roadmaps communicate commitments to other people, and they explicitly choose not to make any commitments, internally or externally."

This is a strong opinion, not a universal rule. For a B2B SaaS with enterprise customers asking "when will SSO ship?", silence is commercially untenable. For a bootstrapped product (Basecamp), silence is sustainable. `roadmap-ready` should make this choice explicit, not default to either.

---

## 4. Outcome-based vs. output-based roadmaps

The central product-management debate 2018-2026. This section maps the terrain without picking a side.

### Definitions

**Output (or feature) roadmap**: sequence of features with delivery estimates. Items are things like "add notifications", "ship SSO", "revamp onboarding" (https://productschool.com/blog/product-strategy/outcome-based-roadmap, https://www.productledalliance.com/is-it-time-to-switch-from-feature-to-outcome-driven-product-roadmaps/).

**Outcome-based roadmap**: sequence of desired results, with specific initiatives as possible-but-not-fixed paths. Items are things like "increase activation by 20%", "reduce churn among enterprise accounts", "achieve H1 waitlist conversion of 35%" (https://www.productplan.com/learn/outcome-driven-roadmaps, https://amplitude.com/blog/move-from-outputs-to-outcomes, https://www.mindtheproduct.com/escape-from-the-feature-roadmap-to-outcome-driven-development/).

Intermediate: **theme-based roadmap**, where rows are thematic areas ("Growth", "Enterprise-readiness", "Mobile") and items within themes are unranked or softly-ranked (https://www.lennysnewsletter.com/p/one-team-one-roadmap-issue-27).

### The case for outcome roadmaps

- Aligns teams with business value, not activity (https://anarsolutions.com/feature-driven-vs-outcome-driven/).
- Preserves optionality: "focusing on the outcome instead of the feature means you can more easily adjust what the feature looks like" (https://blog.logrocket.com/product-management/feature-driven-to-outcome-driven-roadmap/).
- Resists feature factory: if the outcome stays and the feature doesn't move it, the feature is cut (Cutler argument).
- Per Cagan: it's how empowered teams can operate (https://www.svpg.com/the-alternative-to-roadmaps/).
- Per Torres: natural pairing with OST and continuous discovery (https://www.producttalk.org/opportunity-solution-trees/).

### The case for feature (output) roadmaps

- Stakeholders want to know what is shipping. Customers who churned want to know "did you ever build X?".
- Enterprise sales cycles require concrete commitments. Outcome language ("we aim to improve enterprise activation") does not close a deal.
- Mature products with well-understood problem spaces have less discovery need; features are the work (https://anarsolutions.com/feature-driven-vs-outcome-driven/, https://www.productledalliance.com/how-can-you-choose-the-right-product-roadmap-for-your-team/).
- Teams need build-order clarity. Outcomes don't naturally sequence dependencies.

### The synthesis position

Most 2024-2026 writing lands on "both, layered": outcome at the top (strategic view), features underneath (delivery view). Examples: ProductPlan's outcome-driven-roadmap template pairs outcomes with initiatives (https://www.productplan.com/learn/outcome-driven-roadmaps). Lenny Rachitsky's "One Team, One Roadmap" argues for a single artifact that satisfies both lenses (https://www.lennysnewsletter.com/p/one-team-one-roadmap-issue-27). Teresa Torres's pragmatic advice when leaders demand timelines: give them a Now-Next-Later with confidence bands, rooted in opportunities (https://www.producttalk.org/2023/10/roadmaps-with-timelines/).

Cagan's "high-integrity commitments" concept threads this needle: most work is outcome-framed; specific items where a hard date is necessary (regulatory deadline, partner launch) go through a commitment process that is explicit about cost (https://www.svpg.com/the-alternative-to-roadmaps/).

### Where each applies

- **Early-stage, pre-PMF**: outcome-based. Problem-space still shifting. Feature names are hypotheses.
- **Growth-stage, finding fit**: theme-based or hybrid. Some items are locked (contracts, partnerships); most items are exploratory.
- **Mature product, execution-heavy**: feature-based with outcome framing at the top. Items are mostly bounded. Capacity planning matters.
- **Regulated industries (finance, healthcare)**: hybrid with hard dates where regulation bites. Outcome framing is good, but SOC 2 audit deadlines are outputs with dates.
- **Public-facing roadmap (B2B SaaS)**: feature-based, with deliberate fuzziness. Many companies publish "Roadmap" pages with Now/Next/Later, feature titles, no dates (e.g., Linear, GitHub, Vercel).

### Implications for `roadmap-ready`

The skill should not hard-code outcome-only. It should require that every item has either an outcome framing OR an explicit high-integrity commitment reason. A feature with no outcome and no commitment reason is the grep-testable failure.

---

## 5. Cadence models in practice

This section catalogues the major cadence models for software roadmaps and when each applies. `roadmap-ready` should support multiple; it should not impose one.

### Continuous delivery (feature-flagged, trunk-based)

Cadence: there is no cadence. Deploy is decoupled from release via feature flags. Work merges to trunk frequently; features ship dark, activate for cohorts, roll to 100% (https://www.atlassian.com/continuous-delivery/continuous-integration/trunk-based-development, https://trunkbaseddevelopment.com/feature-flags/, https://martinfowler.com/articles/feature-toggles.html).

Roadmap implication: the roadmap cannot be a release calendar; it is a risk-and-exposure calendar. "When is X behind a flag?" and "When does X reach 100% rollout?" are the timing questions, not "when does X ship?"

Good fit: consumer SaaS at scale, strong DevOps culture, feature-flag infrastructure in place. Bad fit: enterprise with long contract windows tied to named releases.

### Milestone-based (named releases, external deadlines)

Cadence: release 1.0, 1.1, 2.0. Often tied to public events (conference launches, partner commitments, regulatory compliance dates).

Roadmap implication: the roadmap is organized around milestones. Work either fits a milestone or doesn't. Scope-cutting is the dominant ritual as milestone approaches.

Good fit: mobile apps (App Store gates), enterprise software with formal GA, hardware-adjacent software, regulated deployments. Bad fit: continuous-delivery consumer products.

### Shape Up (6-week cycles + 2-week cool-down)

Already documented in Section 3. Key rule: nothing bigger than 6 weeks; if it doesn't fit, re-shape it (https://basecamp.com/shapeup). Roadmap = sequence of bets at betting-table cadence, which is every 8 weeks.

Good fit: small product teams (5-40 engineers), strong product culture, autonomy. Bad fit: large enterprises with lots of coordination, regulatory-driven work.

### Quarterly themes with monthly check-ins

Widely-used by growth-stage SaaS. Quarter defines themes; month defines sub-outcomes; weekly sprints for execution. Often aligned with OKRs (https://www.productplan.com/learn/prioritize-product-roadmap-with-okrs/, https://monday.com/blog/rnd/okrs-for-product-management/, https://dragonboat.io/blog/product-okrs/).

Good fit: growth-stage (30-300 people), multiple product teams, board/investor reporting cadence aligned to quarters. Bad fit: very early stage (quarters are too long), very small teams (ceremony is overhead).

### SAFe PI Planning (Program Increments, 8-12 weeks)

Program Increment = 8-12 weeks of planning horizon, typically four to six iterations (https://framework.scaledagile.com/pi-planning/, https://www.easyagile.com/blog/the-ultimate-guide-to-pi-planning, https://miro.com/agile/pi-planning/what-is-pi-planning/).

PI Planning event: 2 days, whole Agile Release Train (ART, typically 50-125 people) in one room (physical or virtual) to align on PI objectives, identify dependencies, commit (https://www.eliassen.com/blog/elas-blog-posts/successful-program-increment-pi-planning-in-safe).

Good fit: large enterprises (500+ eng), multiple ARTs, regulated or safety-critical domains. Bad fit: startups, product-led companies, small teams. SAFe is controversial (critics: ceremony-heavy, not truly agile; defenders: works for domains that need coordination).

### OKR-aligned quarterly planning

Objectives and Key Results on a quarterly cadence. Not a cadence model on its own but an overlay. Three to five objectives per quarter, two to four KRs each (https://www.getjop.com/blog/okr-product-roadmap, https://dragonboat.io/blog/product-okrs/, https://monday.com/blog/rnd/okrs-for-product-management/).

OKRs pair naturally with outcome-based roadmaps: KRs become roadmap-column headings; initiatives underneath target specific KRs (https://www.planview.com/resources/guide/a-guide-to-okrs/improve-alignment-with-okr-roadmap/).

### Scrum sprints (2-week cadence)

Scrum is a tactical cadence, not a roadmap cadence. The Sprint is a "strategy-tactics bridge"; the Product Goal sits between Sprint Goal (tactical) and Vision (strategic) (https://www.scrum.org/resources/blog/sprint-vision-balancing-strategy-tactics-and-risk-product-goal).

Confusion arises when teams publish "the sprint backlog" as "the roadmap". This is the feature-factory symptom: no higher-level sequencing, just sprint-to-sprint tickets. `roadmap-ready` should flag when the only visible horizon is a sprint.

### Choosing a cadence

Informal decision matrix from the literature:

- **Team size 5-40, product-led, flag-equipped**: Shape Up or continuous delivery.
- **Team size 30-300, growth-stage, OKRs in use**: quarterly themes with monthly check-ins + OKRs.
- **Team size 100+, multiple ARTs, regulated**: SAFe PI.
- **Enterprise B2B with named releases**: milestone-based, with Shape Up or quarterly underneath.
- **Consumer SaaS at scale**: continuous delivery with rollout calendar.

The risk-tolerance axis: continuous delivery is highest tolerance (can roll back fast), PI Planning is lowest (commitments for 10-12 weeks).

The customer-expectation axis: public roadmaps push toward feature-named, longer-horizon. Private roadmaps can be looser.

---

## 6. Sequencing and risk-driven prioritization

### RICE scoring (Intercom, ~2015)

Formula: RICE = (Reach x Impact x Confidence) / Effort (https://www.intercom.com/blog/rice-simple-prioritization-for-product-managers/, https://www.productplan.com/glossary/rice-scoring-model, https://productschool.com/blog/product-fundamentals/rice-framework).

- **Reach**: number of people affected per unit time (per month, per quarter).
- **Impact**: 0.25 (minimal), 0.5 (low), 1 (medium), 2 (high), 3 (massive).
- **Confidence**: 0-100%, penalizes unsupported enthusiasm.
- **Effort**: total person-months across all roles.

Strengths: forces confidence discount explicit; cross-team comparability if reach units are consistent.

Criticisms: false precision when confidence and impact are guessed; gameability (tune impact or confidence to get the desired answer); reach is under-defined for internal-tooling or infra work (https://dovetail.com/product-development/rice-scoring-model/).

### MoSCoW at milestone level (Dai Clegg, 1994, DSDM)

Must-have (critical for success of the current timebox), Should-have (important but deferable), Could-have (desirable, low-cost), Won't-have (explicitly excluded this timebox) (https://en.wikipedia.org/wiki/MoSCoW_method, https://www.agilebusiness.org/dsdm-project-framework/moscow-prioritisation.html).

DSDM rule of thumb: no more than 60% of effort in Must-have; 20% Should-have; 20% Could-have acts as buffer.

MoSCoW is strongest at the milestone-cut level, weakest at continuous-flow. Its grep-testable failure: Won't-have empty. If nothing is excluded, it's not a milestone, it's a wishlist (https://www.productplan.com/glossary/moscow-prioritization).

### WSJF (SAFe)

Weighted Shortest Job First: WSJF = Cost of Delay / Job Size. Cost of Delay = User-Business Value + Time Criticality + Risk Reduction / Opportunity Enablement (https://framework.scaledagile.com/wsjf, https://airfocus.com/glossary/what-is-weighted-shortest-job-first/).

Values on a Fibonacci-like scale (1, 2, 3, 5, 8, 13, 20).

WSJF's economic argument: the jobs with highest value per unit time win (https://scrum-master.org/en/what-is-wsjf-weighted-shortest-job-first-safe/). Philosophical compatibility: WSJF and RICE express similar shape (value over effort), different inputs.

Criticism: Fibonacci estimation for all four components produces bucket fights; "time criticality" is hard to separate from "value" cleanly.

### Kano model (Noriaki Kano, 1980s)

Feature categories by satisfaction curve (https://en.wikipedia.org/wiki/Kano_model, https://productschool.com/blog/product-fundamentals/kano-model, https://www.qualtrics.com/articles/strategy-research/kano-analysis/):

- **Must-be (basic)**: absence causes dissatisfaction; presence is taken for granted.
- **Performance (one-dimensional)**: satisfaction rises linearly with investment.
- **Attractive (delighter)**: unexpected; presence creates disproportionate satisfaction, absence not noticed.
- **Indifferent**: no satisfaction impact.
- **Reverse**: presence causes dissatisfaction for some users.

Gravity: what is a delighter today becomes a performance expectation tomorrow and a must-be the day after (https://productschool.com/blog/product-fundamentals/kano-model). Dark mode is the most-cited example (2015 delighter, 2020 performance, 2025 must-be).

Kano is strong for roadmap framing, weak for sequencing. It categorizes, it doesn't rank.

### ICE scoring (Sean Ellis)

Impact x Confidence x Ease, each on 1-10 scale (https://growthmethod.com/ice-framework/, https://www.productplan.com/glossary/ice-scoring-model). Used at Dropbox, LogMeIn (Ellis coined "growth hacking") for growth-experiment prioritization.

Strength: fast. ICE is "dozens of ideas in a single session" (https://growthmethod.com/ice-framework/). Weakness: missing reach; subjective (https://productfolio.com/ice-scoring/). Same idea scored by two people diverges widely.

ICE is best for short-cycle experiment sequencing, not milestone sequencing.

### Opportunity scoring (Anthony Ulwick, Outcome-Driven Innovation, 1990s)

Opportunity = Importance + max(0, Importance - Satisfaction) (https://en.wikipedia.org/wiki/Outcome-Driven_Innovation, https://airfocus.com/glossary/what-is-opportunity-scoring/, https://anthonyulwick.com/jobs-to-be-done/).

Customer survey captures each desired outcome (JTBD atomic unit) on 1-10 importance and 1-10 satisfaction. Outcomes with high importance and low satisfaction are underserved; that is where innovation ROI is high.

This is a discovery tool more than a roadmap-sequencing tool. Its output feeds opportunity solution trees (Torres, Section 3) or roadmap themes.

### The "riskiest thing first" school (Eric Ries, Lean Startup)

Build-Measure-Learn loop. "Leap-of-faith assumptions": the beliefs whose wrongness would hose the project. Test the riskiest first (https://en.wikipedia.org/wiki/Lean_startup, https://togroundcontrol.com/blog/validated-learning/).

Sequencing implication for roadmaps: items that resolve the highest-risk assumption go first, even if they are small or unglamorous. The pattern: prototype the hardest integration before polishing the landing page.

### Shape Up: appetite first, not estimate first

Shape Up inverts the prioritization question. Not "how long does this take?" (estimate first) but "how much time is this worth?" (appetite first). Then shape to fit the appetite (https://basecamp.com/shapeup/1.2-chapter-03).

Not compatible with pure RICE/WSJF: RICE needs effort; appetite bypasses effort estimation by assigning a budget.

### The polish-indefinitely failure mode

Cited informally. The pattern: team picks an ambitious initiative, discovers mid-cycle that "one more iteration" improves it, iterates beyond appetite, ships late. Shape Up's circuit breaker addresses this exactly: at six weeks, ship or cut, do not extend by default (https://basecamp.com/shapeup).

"Polish indefinitely" is the opposite of the Shape Up rule. `roadmap-ready` should flag open-ended cycles.

### Compatibility matrix

| | RICE | MoSCoW | WSJF | Kano | ICE | Opp Score | Riskiest First | Appetite |
|-|-|-|-|-|-|-|-|-|
| RICE | - | L | C | S | S | S | C | C |
| MoSCoW | L | - | L | C | L | L | C | C |
| WSJF | C | L | - | S | S | S | C | C |
| Kano | S | C | S | - | S | C | S | S |
| ICE | S | L | S | S | - | S | C | C |
| Opp Score | S | L | S | C | S | - | C | S |
| Riskiest First | C | C | C | S | C | C | - | C |
| Appetite | C | C | C | S | C | S | C | - |

Legend: C = compatible (layer naturally); S = stacked (use both at different layers); L = loose overlap (both express preference, different semantics).

True conflicts are rare. The sharpest tension: RICE/WSJF (effort-in-denominator) vs. Shape Up (appetite-first, effort is not the input). Teams that use RICE to pick a pitch, then Shape Up to deliver it, resolve the conflict by layering.

---

## 7. Dependency graphs and parallelism

### Architecture decomposes into a DAG

Software architecture produces (explicitly or implicitly) a directed acyclic graph of components. Edges are dependencies: A depends on B means B must exist (or have its interface contract stable) before A is complete (https://www.databricks.com/glossary/dag, https://en.wikipedia.org/wiki/Directed_acyclic_graph, https://www.ibm.com/think/topics/directed-acyclic-graph).

The acyclic dependencies principle (Robert Martin): dependencies between modules should form a DAG; cycles are a design smell (https://dev.to/capnspek/common-graph-algorithms-directed-acyclic-graph-dag-algorithm-4bpl, https://www.tweag.io/blog/2025-09-04-introduction-to-dependency-graph/).

For `roadmap-ready`: the architecture artifact (from `architecture-ready`) should expose a dependency DAG. The roadmap's sequencing must respect topological order of that DAG. If the roadmap schedules A before B when A depends on B, the roadmap is incoherent.

### Critical Path Method (CPM) vs. Critical Chain (TOC) vs. Shape Up

CPM (Du Pont, Remington Rand, late 1950s): identify the longest sequence of dependent tasks; that is the project minimum duration. Optimize the critical path, accept non-critical tasks as slack (https://www.critical-chain-projects.com/the-method, https://www.projectcontrolacademy.com/project-critical-chain/).

Critical Chain (Eliyahu Goldratt, "Critical Chain", 1997, https://en.wikipedia.org/wiki/Critical_chain_project_management): CPM assumes infinite resources. In practice, the critical path changes when you account for resource contention. Critical Chain schedules the longest path of dependencies AND resource conflicts, and protects commitment dates with a project buffer rather than padding each task (https://asana.com/resources/critical-chain-project-management, https://tameflow.com/blog/2012-09-25/critical-chain-project-management-in-TOC/).

Task durations under CCPM are estimated at 50-60% confidence (vs. the typical 90%+ in classical CPM), and the saved padding aggregates at the project level as a buffer (https://www.proofhub.com/articles/critical-chain-management).

Shape Up rejects the entire critical-path framing. Scope flexes within fixed time; the "path" is whatever fits in six weeks. There is no project-level critical path because there is no project-level commitment beyond the cycle.

For `roadmap-ready`: the skill should not force CPM. It should, however, ensure dependencies are visible (DAG from architecture) and that the roadmap does not violate topological order.

### Real-world parallel-track capacity collisions

Multiple teams report the same pattern under different names:
- "Team Tetris" (Cutler): teams reassigned mid-cycle as priorities shift, causing chronic context-switching (https://cutle.fish/blog/12-signs-youre-working-in-a-feature-factory/).
- "Multi-tasking madness" (t2informatik): up to 40% productivity loss from task-switching, per APA research (https://t2informatik.de/en/blog/multitasking-madness-in-project-management/).
- "Multi-tasking myth" (Parallel Project Training): single-tasking outperforms because humans don't actually parallel-process (https://www.parallelprojecttraining.com/blog/the-multi-tasking-myth-in-project-management-why-single-tasking-is-the-key-to-productivity/).

### Fictional parallelism

The pattern: roadmap shows six tracks happening in Q1. Team has four engineers. Even with 100% utilization, there are not six concurrent full-bandwidth tracks. Two tracks advance; four stall. Reality asserts itself mid-quarter.

The planning artifact showed parallelism that the execution never delivered. Visually it looked like six lanes racing; in practice it was a single-file line with four items waiting.

Critical Chain addresses this by explicitly modeling resource contention (https://en.wikipedia.org/wiki/Critical_chain_project_management). Shape Up addresses it differently: by sizing bets to fit the number of teams (https://basecamp.com/shapeup).

### Amdahl's law applied to roadmap parallelism

Amdahl's law (1967): speedup from parallelization is capped by the serial fraction. Speedup = 1 / (s + p/N), where s is serial fraction, p is parallel, N is processors (https://en.wikipedia.org/wiki/Amdahl's_law, https://www.splunk.com/en_us/blog/learn/amdahls-law.html).

Applied to teams: even if the work is perfectly decomposable into independent items, the coordination overhead (reviews, dependency resolution, integration testing, cross-team decisions) is a serial fraction that caps achievable parallelism. "The serial work can be: build and deployment pipelines; reviewing and merging changes; communication and coordination between teams; and dependencies for deliverables from other teams" (https://shahbhat.medium.com/applying-laws-of-scalability-to-technology-and-people-5884b4b4b04).

Rule of thumb (not universal): with serial fraction of 20%, 10 parallel teams can achieve at most 5x speedup, not 10x. With serial fraction of 50%, max is under 2x.

Practical roadmap implication: doubling team size does not double throughput. A roadmap that schedules work proportional to headcount, ignoring the serial fraction, is over-committing.

### Capacity matching

A coherent roadmap requires team-size input. Heuristic: a single Shape Up cycle accommodates approximately one big batch (6 weeks) and two small batches (2 weeks) per small team (~3 engineers). An ART in SAFe (50-125 people) plans 5-8 PI objectives per PI.

Without a capacity number, the roadmap is stuffing. With a capacity number, sequencing decisions have ground truth to resist.

For `roadmap-ready`: the skill should require team-size input or refuse to commit dates.

---

## 8. Launch milestone identification and sequencing

### What a launch even is

There is no single definition. The literature distinguishes at least six modes:
- **Hard launch**: public, coordinated, high-visibility release; press, social, paid (https://www.rocketmvp.io/resources/soft-launch-vs-hard-launch).
- **Soft launch**: limited release to 50-500 early users, 2-8 weeks, feedback-and-fix focus.
- **Beta**: invite-only or public-opt-in, explicit "this is not GA", feedback loop.
- **GA (General Availability)**: product is officially for sale / open to all; distinct from beta.
- **Waitlist-to-GA**: pre-launch waitlist, gradual invite waves, eventually open; waitlist members convert 10x better than cold traffic (https://kickofflabs.com/blog/what-is-a-product-launch-waitlist/, https://getlaunchlist.com/checklists/producthunt).
- **Product Hunt / TechCrunch day**: orchestrated single-day spike on a platform; 6-week lead-up is typical for PH (https://getlaunchlist.com/blog/how-to-launch-on-product-hunt-2026, https://waitlister.me/growth-hub/guides/product-hunt-launch-checklist).

A `launch-ready` skill downstream of `roadmap-ready` needs to know which mode, because the milestones differ.

### Pre-launch milestones and D-7 runbooks

Typical pre-launch milestones observable in vendor guides and operations writing:
- **D-90 to D-60**: feature-complete target; content and assets in draft.
- **D-30**: soft-launch start with internal/friendly users; observability dashboards live.
- **D-14**: dogfooding complete, critical-path issues triaged, rollback tested once end-to-end.
- **D-7**: code freeze (or flag-freeze); press outreach begins; support runbooks reviewed; on-call schedule locked.
- **D-1**: final go/no-go; dashboards watched; rollback rehearsed.
- **D-0 (launch day)**: announcement, monitoring, hot-fix capacity reserved.
- **D+7**: post-launch retrospective and stabilization; support volume review.

Specific checklists: Cortex's Production Readiness Review (https://www.cortex.io/post/how-to-create-a-great-production-readiness-checklist), DX's production-readiness checklist (https://getdx.com/blog/production-readiness-checklist/), LaunchDarkly's release management checklist (https://launchdarkly.com/blog/release-management-checklist/), and GitScrum's launch-readiness go/no-go framework (https://docs.gitscrum.com/en/best-practices/launch-readiness-checklist).

Common gate-review content: KPIs defined and visible; alerts configured and linked to runbooks; on-call rotation assigned; dashboards cover latency, error rate, throughput; rollback path tested not just documented (https://getdx.com/blog/production-readiness-checklist/, https://www.cortex.io/post/software-release-checklist).

### Rollback as a first-class milestone

The strongest operational writing separates detection, containment, and rollback as independent readiness dimensions:

- **Detection**: will problems be visible? (observability live, alerts wired)
- **Containment**: can damage be limited fast? (feature flags, circuit breakers)
- **Rollback**: is reversal actually safe? (tested end-to-end, not hypothetical)

Common automatic-rollback triggers: error rate > 5x baseline; core feature broken; data integrity issue; security exposure. Decision-required triggers: error rate 2-5x baseline; non-core feature broken; performance degradation; many customer complaints (https://www.momentslog.com/development/how-to-run-a-production-readiness-review-that-catches-real-risk-before-launch-day).

For `roadmap-ready`: the last pre-launch milestone is not "code-complete". It is "observability-live, rollback-tested, runbooks-rehearsed". A roadmap that omits these is a roadmap to a crisis.

### "Launch has slipped" protocol

Informally documented in operations writing, distilled:
1. Determine cause: scope not complete, quality gate not passed, external dependency slip, capacity collision.
2. Decide hold vs. re-sequence: a hold is the cheaper option if the slip is small (< 1 week) and marketing commitments can move. A re-sequence is necessary when multiple launches chain (Product Hunt cannot be moved last minute).
3. Protect the chain: if the launch is a hub for downstream work (observability plan is wired to this launch; customer-support training is scheduled post-launch), document the new chain.

Shape Up's circuit-breaker logic applies: the default is to re-shape, not extend. Extending by default is how launches die.

### Handoff to `deploy-ready`, `observe-ready`, `launch-ready`

The roadmap-ready artifact should include, for each launch milestone:
- The launch mode (hard, soft, beta, GA, Product Hunt, etc.).
- The observability-live date (feeds observe-ready).
- The rollback-tested date (feeds deploy-ready).
- The support-runbook-complete date (feeds launch-ready).
- Named dependencies that must ship before the launch milestone (feeds all three).

Without this block, the downstream skills have to infer timing from context, which is the observed failure mode of AI-generated plans.

---

## 9. How downstream tools and people actually read a roadmap

A roadmap is read differently by each consumer. This section inventories the consumers and what each needs. The design rule for `roadmap-ready`: the roadmap artifact must satisfy all of these reads from one source, without per-audience rewrites (Lenny Rachitsky, "One Team, One Roadmap": https://www.lennysnewsletter.com/p/one-team-one-roadmap-issue-27).

### Engineering reads

"What am I building next, and why is THIS next, not something else?"

Engineering wants: sequence clarity, explicit dependencies (what must be done before my work), appetite or estimate (how big is this), done-definition (what does "complete" mean). A theme without a next-action is unactionable.

Linear's project model answers this well: a project has a name, a lead, a status, an updates feed, a list of issues. A Linear roadmap is a view over projects (https://monday.com/blog/rnd/linear-or-jira/, https://clickup.com/blog/linear-vs-jira/). Jira Advanced Roadmaps answers similarly via epics with dates (https://www.atlassian.com/software/jira/comparison/jira-vs-linear).

### Deploy reads

"When do I promote which artifact where?"

`deploy-ready` needs: the artifact identity (what is being deployed), the target environment sequence (staging -> canary -> prod), the promotion criteria (what gates), and the calendar (when does this chain start and finish).

This is a different view of the same roadmap data, organized by artifact and environment. Continuous-delivery shops pre-compute this via CI pipelines; milestone-based shops compute it per release (https://www.atlassian.com/continuous-delivery/continuous-integration/trunk-based-development, https://trunkbaseddevelopment.com/feature-flags/).

### Launch reads

"When is the launch milestone and what depends on it?"

Launch owners want: the launch date, the readiness gates (observability, rollback, runbooks), the lead-time for external commitments (press briefings, partner notifications, Product Hunt coordination), and the "hold vs. re-sequence" protocol if anything slips (https://getlaunchlist.com/blog/how-to-launch-on-product-hunt-2026).

### Stakeholder reads

"What is the commitment, and what is the appetite?"

Execs and investors want: what will be different in 6 months. They want a level of confidence labeled. They do not want six-month Gantts to the day; they want themes + a small number of hard commitments.

Cagan's high-integrity commitment framing is the clearest prescription: most of the roadmap is direction (outcome, not commitment), and a small number of items are explicit commitments made after discovery (https://www.svpg.com/the-alternative-to-roadmaps/).

### Customer reads

"What's on the public roadmap and when?"

B2B customers want: is the feature I care about coming? In 3 months? 12 months? Never?

The spectrum of public-roadmap approaches:
- **Publish nothing**: Basecamp, "Options, Not Roadmaps" (https://basecamp.com/articles/options-not-roadmaps).
- **Publish Now-Next-Later, no dates**: Linear, many modern SaaS, ProdPad customers. Features named; no date column.
- **Publish quarterly themes with indicative dates**: GitHub, Vercel, many mid-stage SaaS.
- **Publish a full Gantt**: rare for consumer SaaS; common for enterprise with contractual commitments.

`roadmap-ready` should support multiple public-facing derivatives from one internal roadmap; it should not force a public-Gantt default.

### Internal vs. public roadmaps

Difference axis:
- **Internal**: includes not-yet-spec'd exploration, capacity math, named owners, unresolved dependencies, "won't have" items, commercial context.
- **Public**: redacts exploration, removes internal owners and capacity, softens "won't have" to "not planned", adds customer-value framing, removes commercially-sensitive context.

Anti-pattern: same file published to both audiences. This is how internal context leaks and how customer-facing commitments accidentally emerge.

Basecamp's explicit "no public roadmap" is one valid response (https://basecamp.com/articles/options-not-roadmaps). The opposite extreme (everything public) is rare outside open-source projects. Most commercial teams maintain two derivatives from one canonical artifact.

### Roadmap-as-communication artifact

Format choices observed in the literature:
- **Trello cards**: lightweight, columns as phases (Now/Next/Later). Limits: no dependency edges.
- **Linear projects**: modern default for dev-heavy teams (https://monday.com/blog/rnd/linear-or-jira/).
- **Jira epics with dates**: the enterprise default; Jira Advanced Roadmaps for cross-team views (https://www.atlassian.com/software/jira/comparison/jira-vs-linear).
- **Productboard**: feedback-to-feature pipeline + roadmap view (https://monday.com/blog/rnd/productboard-vs-jira/).
- **Aha!**: strategic / enterprise roadmapping with OKR integration (https://monday.com/blog/rnd/aha-vs-jira/).
- **Airtable / Notion**: frequently used as roadmap surfaces; flexible but manual.
- **Plain Markdown**: increasingly common for AI-adjacent and devtools teams; checks into the repo; LLMs can read and write it.

`roadmap-ready` should output a Markdown canonical form that can be transformed to any of the above. Markdown is the most portable and the most grep-testable.

---

## 10. Current state of the art, 2026

### The AI-tooling landscape as of April 2026

- **ChatPRD**: PRD generation; 250,000 documents, 30,000 users (https://blog.buildbetter.ai/12-best-ai-product-management-tools-for-2025/, https://www.chatprd.ai/learn/best-ai-tools-for-product-managers). Strength: fast PRD drafting. Gap: no roadmap execution tie.
- **Productboard AI**: feedback-to-feature ML linking; AI-assisted prioritization (https://www.productboard.com/blog/using-ai-for-product-roadmap-prioritization/). Strength: customer-feedback triage at scale. Gap: does not track engineering execution.
- **Atlassian Rovo** (Jira, Confluence, JSM): GA'd 2025; can convert Jira Product Discovery views to Confluence roadmaps (https://www.atlassian.com/software/jira/ai, https://idalko.com/blog/atlassian-rovo-transformation). Strength: operates over your real Jira data. Risk: inherits whatever grid-shape you already use.
- **Aha! AI**: enterprise roadmapping AI (https://zeda.io/blog/aha-vs-jira).
- **Linear's AI features**: issue triage, project summarization; less focused on roadmap generation per se (https://monday.com/blog/rnd/linear-or-jira/).
- **Notion AI**: general-purpose document AI; widely used for roadmap doc drafting but has no product-data grounding by default.
- **Height**, **Dart AI**: AI-native startups in PM/PMO tooling (https://aipmtools.org/articles/future-of-ai-product-management).

### What the tools do well

- Triage large feedback volumes.
- Synthesize PRD content from bullet-point inputs.
- Generate first-draft roadmap documents when given a structured input (Jira data, PRD text).
- Summarize project status from updates.

### What the tools fail at

Consistent across writing and product-management commentary:
- **Commit confidently where there is no basis**: dates invented with no capacity input.
- **Respect dependencies**: without explicit dependency graph, sequencing is prose-order, not topological.
- **Match team capacity**: the models do not know how many engineers are available.
- **Distinguish commitments from directions**: everything is stated with the same assertiveness.
- **Refuse to commit when refusal is correct**: LLMs are trained to produce, not to decline.

"AI excels at data synthesis and repetitive tasks, but strategic decisions and user empathy remain the PM's domain" (https://www.chatprd.ai/learn/capabilities-of-ai-agents-product-management).

### Academic and industry writing, 2024-2026

- Roman Pichler's continued publishing on roadmapping mistakes (https://www.romanpichler.com/blog/product-roadmapping-mistakes-to-avoid/).
- Teresa Torres's work on continuous discovery continues influential; 2023 piece on "leaders still want timelines" is widely cited (https://www.producttalk.org/2023/10/roadmaps-with-timelines/).
- Marty Cagan's "Transformed" (2024) repositions the operating-model question (https://digitalgonzo.medium.com/review-marty-cagans-transformed-moving-to-the-product-operating-model-c8bc312ba435).
- Springer Nature 2023 chapter "Why Traditional Product Roadmaps Fail in Dynamic Markets" (https://link.springer.com/chapter/10.1007/978-3-031-21388-5_26) is one of the few academic treatments.
- Lenny Rachitsky's newsletter has become a central clearinghouse for templates and frameworks (https://www.lennysnewsletter.com/).

### New cadence models (2024-2026 observed)

- **"Discovery + delivery" paired tracks**: discovery as continuous (Torres), delivery as Shape Up cycles or Scrum sprints.
- **AI-native shops**: even shorter cycles (weekly or bi-weekly), because model iteration itself is faster than traditional feature delivery. Documented at AI-first startups but not yet a canonical named model.
- **"Forecast ranges" explicit**: roadmaps labeled with "70% by Q2, 95% by Q3" rather than single-date commitments, following probabilistic forecasting writing (https://theaipoweredprojectmanager.substack.com/p/your-project-roadmap-is-a-lie-you).

### The gap `roadmap-ready` fills

None of the above tools is an opinionated refuser. They all generate. The gap is a skill that:
- Refuses to commit dates without capacity input.
- Refuses to sequence without a dependency graph (from architecture-ready).
- Refuses to invent features not in the PRD.
- Requires every item to be either outcome-framed or have a high-integrity-commitment rationale.
- Outputs handoffs for deploy-ready, observe-ready, launch-ready with explicit gate dates.

This is the "stricter generator" positioning. It is not a smarter generator; it is a generator with teeth.

---

## 11. Decision summary for roadmap-ready v1.0.0

### Named failure modes roadmap-ready should prevent

Each row lists: name, source (coiner or adoption path), grep-testable marker, prevention rule.

| Name | Source | Marker | Prevention |
|-|-|-|-|
| Feature factory | John Cutler, 2016, https://cutle.fish/blog/12-signs-youre-working-in-a-feature-factory/ | Roadmap rows are feature names only; no outcome column; no measurement planned | Require outcome or high-integrity-commitment reason per item |
| Build trap | Melissa Perri, "Escaping the Build Trap", 2018 | Output metrics (features shipped) present; outcome metrics absent | Require at least one outcome per theme |
| Roadmap theater | Industry term; adopted, not coined by us; see https://theaipoweredprojectmanager.substack.com/p/your-project-roadmap-is-a-lie-you | Gantt-chart precision to the day; no confidence label | Forbid single-date commits without a confidence band or high-integrity sign-off |
| Fictional parallelism | Descriptive; multiple adjacent uses in PM writing and in CCPM literature | Number of simultaneous lanes > team size | Require team-size input; refuse roadmaps that exceed capacity |
| Quarter fallacy (or: quarter-stuffing) | Adaptation of Hofstadter's law + planning fallacy; coinable | All four quarters filled to visual balance | Require decreasing specificity across horizons (Now-Next-Later) |
| Date-driven without appetite | Inverse of Shape Up's "fixed time, variable scope" | Fixed dates with no scope flex mechanism | Require either fixed appetite (scope flexes) or fixed scope + explicit commitment |
| Scope-driven disguised as date-driven | Same source | Committed date with scope still open-ended | Require explicit "commitment" label + sign-off for fixed-scope fixed-date items |
| Shelf roadmap | Descriptive; ProductPlan, ProdPad | Last-modified date older than one cycle | Require freshness indicator per item; warn on stale items |
| Speculative roadmap | Descriptive; Pichler (https://www.romanpichler.com/blog/product-roadmapping-mistakes-to-avoid/) | Items with no PRD link, no discovery signal | Require source reference (PRD section, opportunity, customer evidence) |
| Invented deadlines (AI-specific) | Emerging, 2024-2026 | Dates produced by model with no input capacity | Refuse to emit dates when capacity is null |
| Invented features (AI-specific) | Emerging, 2024-2026 | Feature appears in roadmap not in PRD or architecture | Cross-check every feature has upstream reference |
| Polish-indefinitely | Shape Up circuit-breaker | Cycles extended past appetite without explicit decision | Enforce circuit-breaker: default is cut at end of cycle |
| Invisible parallelism | Amdahl's-law reading | Parallel tracks with shared-service bottleneck | Require dependency DAG from architecture; flag chokepoints |
| Perpetual now | Adjacent to feature factory and shelf roadmap | All items are Now; no Next or Later | Require Next and Later to be non-empty (even if fuzzy) |
| Linear (single-track) roadmap | Descriptive; the single-lane fallacy | All items in one column, no parallelism at all, even where appropriate | Flag single-track roadmaps when team size > 1 |

### Opinionated rules the skill should enforce

1. **Every item has an outcome or a commitment.** Outcome framing (measurable target) or high-integrity commitment rationale (why this hard date matters). No bare feature list.
2. **Dependencies come from architecture, not guesses.** `roadmap-ready` consumes the architecture DAG. It does not invent dependencies; it does not ignore them.
3. **Sequence respects topological order.** If A depends on B, A is not scheduled before B. If the PRD or architecture does not have the dependency, the skill asks, it does not assume.
4. **Capacity is required input.** Team size, available engineer-weeks per cycle. Without it, the skill refuses to emit dates.
5. **Horizons are fuzzy by design.** Now is specific. Next is directional. Later is thematic. Equal precision across all three is a failure.
6. **Cycle boundaries are hard.** Whether Shape Up's 6+2, a quarter, a SAFe PI, or a custom cadence: there is a named boundary, and there is a named "what happens when work doesn't fit" rule (cut, re-shape, defer).
7. **Appetite xor estimate.** An item has an appetite (fixed time, scope flexes) OR an estimate with a confidence band. Not both. Not neither.
8. **Won't-have is non-empty.** Every cycle has an explicit list of what was considered and rejected.
9. **Public-facing is a derivative.** The skill produces one canonical internal artifact and one or more redacted public views. The internal artifact is never the public one.
10. **Launch milestones name readiness gates.** Observability live, rollback tested, runbooks reviewed. A launch without these is not scheduled.
11. **No confident dates without ground truth.** When the PRD is fresh or capacity is unknown, the skill produces direction without dates, labeled as such.
12. **The artifact is Markdown.** Canonical output is plain Markdown. Tool-specific export is downstream.

### Handoff contract requirements

For each item that targets production or a public launch:

**For `production-ready` handoff:**
- Feature name, owner, target cycle or date.
- PRD section reference.
- Architecture component reference.
- Done-definition (acceptance criteria link).

**For `deploy-ready` handoff:**
- Artifact identity (what is being shipped).
- Target environment sequence (dev -> staging -> canary -> prod, or the project-specific variant).
- Promotion criteria per gate.
- Rollback path reference (must exist before deploy-ready runs).
- Flag strategy if behind feature flag.

**For `observe-ready` handoff:**
- KPIs the launch is expected to move (activation, conversion, retention, error rate).
- Alerts wired and linked to runbooks.
- Dashboard reference.
- On-call assignment for launch window.

**For `launch-ready` handoff:**
- Launch mode (hard, soft, beta, GA, Product Hunt, etc.).
- D-minus calendar (D-30, D-14, D-7, D-1, D-0, D+7 milestones at minimum).
- External commitments (press, partners, platform launches).
- Public-roadmap derivative reference (what customers see).
- Post-launch retrospective scheduled.

### Grep-testable have-nots (failure patterns the skill must emit warnings for)

If roadmap-ready's output contains any of these patterns, emit a warning or refuse:

- `TODO`, `TBD`, `FIXME` (unresolved placeholders).
- Feature names without an outcome field AND without a "commitment: <reason>" field.
- Date specified to the day without a confidence band (e.g., "2026-07-14" without "(70%)").
- More parallel tracks in any one period than `team_size` input.
- "Q1 / Q2 / Q3 / Q4" columns all with identical density of items (quarter-stuffing).
- An item in Now that has no owner.
- An item in Next or Later with a specific day-level date (specificity mismatch).
- A launch milestone with no "observability: live" and "rollback: tested" sub-items.
- An item present in the roadmap but absent from the upstream PRD or architecture.
- A dependency cycle (A -> B -> A).
- A single-value scope with both a fixed-date AND a fixed-scope stated without a "high-integrity commitment" label.
- A feature with no reach/impact/outcome indicator AND no appetite, i.e., no reason to be in the roadmap at all.
- Empty "Won't have" for any cycle.

### Conclusion

`roadmap-ready` should be a stricter generator, not a smarter one. It consumes the PRD (from `prd-ready`) and the architecture DAG (from `architecture-ready`), requires team-size input, and produces a Markdown roadmap artifact that respects dependency order, uses horizon-appropriate precision, and emits named handoffs for `production-ready`, `deploy-ready`, `observe-ready`, and `launch-ready`.

It refuses to commit dates without capacity input. It refuses to sequence without a dependency graph. It refuses to invent features. It flags quarter-stuffing, fictional parallelism, and shelf-roadmap staleness. It names its failure modes with attribution (feature factory = Cutler; build trap = Perri; fixed time / variable scope = Singer/Basecamp; Now-Next-Later = Bastow) and adopts the emerging-but-unowned terms (roadmap theater, fictional parallelism, speculative roadmap) as its own grep-testable labels.

The tools exist to generate roadmaps. The gap is a skill that refuses to lie.

---

## Sources

Shape Up and Basecamp:
- https://basecamp.com/shapeup
- https://basecamp.com/shapeup/1.1-chapter-02 (Principles of Shaping)
- https://basecamp.com/shapeup/1.2-chapter-03 (Set Boundaries)
- https://basecamp.com/shapeup/1.4-chapter-05 (Risks and Rabbit Holes)
- https://basecamp.com/shapeup/1.5-chapter-06 (Write the Pitch)
- https://basecamp.com/shapeup/2.2-chapter-08 (The Betting Table)
- https://basecamp.com/shapeup/3.4-chapter-13 (Show Progress)
- https://basecamp.com/shapeup/3.5-chapter-14 (Decide When to Stop)
- https://basecamp.com/shapeup/4.5-appendix-06 (Glossary)
- https://basecamp.com/articles/options-not-roadmaps
- https://world.hey.com/jason/changes-at-basecamp-7f32afc5
- https://github.com/basecamp/handbook/blob/master/how-we-work.md
- https://www.curiouslab.io/blog/what-is-basecamps-shape-up-method-a-complete-overview
- https://productmanagementresources.com/shape-up-method/
- https://www.sebastienphlix.com/book-summaries/singer-shape-up
- https://jujodi.medium.com/cool-downs-in-shape-up-some-practical-guidance-4f3656ceaaa
- https://gerrygastelum.medium.com/fixed-time-variable-scope-f648d2765a32
- https://emergingtecheast.com/session/fixed-time-variable-scope-in-the-shape-up-methodology/
- https://benjamintravis.com/blog/shape-up
- https://www.process.st/shape-up-process/
- https://cutlefish.substack.com/p/tbm-386-understanding-enabling-constraints

Melissa Perri, "Escaping the Build Trap":
- https://melissaperri.com/book
- https://melissaperri.com
- https://www.amazon.com/Escaping-Build-Trap-Effective-Management/dp/149197379X
- https://www.productbookshelf.com/2020/11/becoming-a-product-led-company/
- https://lethain.com/notes-escaping-the-build-trap/
- https://userpilot.com/blog/escaping-build-trap-mellisa-perri/

John Cutler, feature factory:
- https://cutle.fish/blog/12-signs-youre-working-in-a-feature-factory/
- https://medium.com/@johnpcutler/12-signs-youre-working-in-a-feature-factory-44a5b938d6a2
- https://amplitude.com/blog/12-signs-youre-working-in-a-feature-factory-3-years-later
- https://www.mindtheproduct.com/break-free-feature-factory-john-cutler/
- https://medium.com/@johnpcutler/beat-the-feature-factory-with-biz-chops-dfc7cf6309ae
- https://www.productplan.com/glossary/feature-factory
- https://medium.com/serious-scrum/14-signs-youre-working-in-a-scrum-feature-factory-4a29cf0cca87

Marty Cagan / SVPG:
- https://www.svpg.com/the-alternative-to-roadmaps/
- https://www.svpg.com/roadmap-alternative-faq/
- https://www.svpg.com/vision-vs-strategy/
- https://www.oreilly.com/library/view/inspired-2nd-edition/9781119387503/p03a.xhtml
- https://digitalgonzo.medium.com/review-marty-cagans-transformed-moving-to-the-product-operating-model-c8bc312ba435
- https://www.talkingroadmaps.com/episodes/are-roadmaps-ever-useful

Janna Bastow / ProdPad / Now-Next-Later:
- https://www.prodpad.com/blog/outcome-based-roadmaps/
- https://www.prodpad.com/blog/problem-perfect-roadmap/
- https://productmanagementresources.com/now-next-later-roadmap/
- https://open.spotify.com/episode/6E0v24z3S5hWp2huRbcarM
- https://www.producttalk.org/product-roadmaps/

Teresa Torres, Continuous Discovery and Opportunity Solution Trees:
- https://www.producttalk.org/opportunity-solution-trees/
- https://www.producttalk.org/2023/10/roadmaps-with-timelines/
- https://www.shortform.com/blog/teresa-torres-opportunity-solution-tree/
- https://productschool.com/blog/product-fundamentals/opportunity-solution-tree
- https://www.chameleon.io/blog/opportunity-solution-tree
- https://userpilot.com/blog/continuous-discovery-framework-teresa-torres/
- https://andrewclark.co.uk/product-book-summaries/continuous-discovery-habits
- https://danielelizalde.com/teresa-torres-continuous-discovery-habits/
- https://blog.logrocket.com/product-management/opportunity-solution-trees-definition-examples-how-to/
- https://www.mindtheproduct.com/reversing-teresa-torres-opportunity-solution-tree-to-find-the-why-behind-solutions/

Lenny Rachitsky:
- https://www.lennysnewsletter.com/p/my-favorite-templates-issue-37
- https://www.lennysnewsletter.com/p/one-team-one-roadmap-issue-27
- https://www.lennysnewsletter.com/p/where-great-product-roadmap-ideas
- https://medium.com/swlh/where-great-product-roadmap-ideas-come-from-6392ccd0a3e3
- https://www.notion.com/@lenny
- https://www.theproductfolks.com/product-management-blog/lenny-rachitskys-product-strategy-essentials

Intercom:
- https://www.intercom.com/blog/podcasts/intercom-on-product-ep12/
- https://www.intercom.com/blog/podcasts/podcast-paul-adams-on-product/
- https://www.intercom.com/blog/podcasts/intercom-on-product-ep02/
- https://www.intercom.com/blog/tag/product-roadmap/page/2/
- https://www.intercom.com/blog/rice-simple-prioritization-for-product-managers/
- https://www.intercom.com/blog/videos/intercom-on-product-ep21/
- https://www.intercom.com/blog/podcasts/intercom-on-product-facing-the-tech-slowdown/

Product Roadmaps Relaunched:
- https://www.amazon.com/Product-Roadmaps-Relaunched-Direction-Uncertainty/dp/149197172X
- https://www.oreilly.com/library/view/product-roadmaps-relaunched/9781491971710/
- https://www.productplan.com/learn/product-roadmaps-relaunched
- https://howtoes.blog/2025/06/07/product-roadmaps-relaunched-a-book-summary/

Outcome vs. output debate:
- https://productschool.com/blog/product-strategy/outcome-based-roadmap
- https://userpilot.com/blog/outcome-based-roadmap/
- https://anarsolutions.com/feature-driven-vs-outcome-driven/
- https://www.released.so/guides/product-roadmap-guide
- https://www.productledalliance.com/how-can-you-choose-the-right-product-roadmap-for-your-team/
- https://blog.logrocket.com/product-management/feature-driven-to-outcome-driven-roadmap/
- https://www.mindtheproduct.com/escape-from-the-feature-roadmap-to-outcome-driven-development/
- https://www.productledalliance.com/is-it-time-to-switch-from-feature-to-outcome-driven-product-roadmaps/
- https://www.productplan.com/learn/outcome-driven-roadmaps
- https://amplitude.com/blog/move-from-outputs-to-outcomes

Roadmap failure modes and mistakes:
- https://www.romanpichler.com/blog/product-roadmapping-mistakes-to-avoid/
- https://www.linkedin.com/pulse/10-product-roadmapping-mistakes-avoid-roman-pichler
- https://www.productplan.com/learn/reasons-product-roadmaps-fail/
- https://medium.com/design-bootcamp/three-hidden-roadmap-risks-all-successful-products-avoid-6ef8b696dfd3
- https://link.springer.com/chapter/10.1007/978-3-031-21388-5_26
- https://productart.substack.com/p/why-product-roadmaps-are-destroying
- https://www.netguru.com/blog/product-roadmap-mistakes
- https://www.mindtheproduct.com/mistakes-to-avoid-while-creating-a-product-roadmap/
- https://www.productlogz.com/blog/what-can-cause-an-unstable-product-roadmap
- https://theaipoweredprojectmanager.substack.com/p/your-project-roadmap-is-a-lie-you

Gantt charts vs. roadmaps:
- https://www.productplan.com/learn/gantt-chart-vs-roadmap-whats-the-difference
- https://www.appcues.com/blog/a-gantt-chart-is-not-a-product-roadmap
- https://fibery.com/blog/product-management/roadmap-vs-gantt-chart/
- https://blog.ganttpro.com/en/gantt-chart-vs-roadmap/
- https://www.sharpcloud.com/blog/product-roadmap-vs-gantt-chart
- https://www.savio.io/product-roadmap/gantt-chart-roadmaps/
- https://www.ricksoft-inc.com/post/product-roadmap-and-gantt-charts-differences/

RICE, ICE, WSJF, Kano, MoSCoW, Opportunity scoring:
- https://www.intercom.com/blog/rice-simple-prioritization-for-product-managers/
- https://www.productplan.com/glossary/rice-scoring-model
- https://productschool.com/blog/product-fundamentals/rice-framework
- https://whatfix.com/blog/rice-scoring-model/
- https://www.saasfunnellab.com/essay/rice-scoring-prioritization-framework/
- https://dovetail.com/product-development/rice-scoring-model/
- https://growthmethod.com/ice-framework/
- https://www.productplan.com/glossary/ice-scoring-model
- https://productfolio.com/ice-scoring/
- https://www.lennysnewsletter.com/p/the-original-growth-hacker-sean-ellis
- https://framework.scaledagile.com/wsjf
- https://www.6sigma.us/work-measurement/weighted-shortest-job-first-wsjf/
- https://nextagile.ai/blogs/agile/what-is-wsjf-weighted-shortest-job-first/
- https://airfocus.com/glossary/what-is-weighted-shortest-job-first/
- https://scrum-master.org/en/what-is-wsjf-weighted-shortest-job-first-safe/
- https://en.wikipedia.org/wiki/Kano_model
- https://productschool.com/blog/product-fundamentals/kano-model
- https://www.productplan.com/glossary/kano-model
- https://www.qualtrics.com/articles/strategy-research/kano-analysis/
- https://userpilot.com/blog/kano-model/
- https://en.wikipedia.org/wiki/MoSCoW_method
- https://www.productplan.com/glossary/moscow-prioritization
- https://www.agilebusiness.org/dsdm-project-framework/moscow-prioritisation.html
- https://monday.com/blog/project-management/moscow-prioritization-method/
- https://en.wikipedia.org/wiki/Outcome-Driven_Innovation
- https://anthonyulwick.com/jobs-to-be-done/
- https://airfocus.com/glossary/what-is-opportunity-scoring/
- https://medium.com/uxr-microsoft/what-is-the-opportunity-score-and-how-to-obtain-it-bb81fcbf79b7
- https://ascendle.com/ideas/jobs-to-be-done-jtbd-outcome-driven-innovation-explained/
- https://www.productcompass.pm/p/jobs-to-be-done-masterclass-with

#NoEstimates:
- https://softwaredevelopmenttoday.com/noestimates/
- https://builtin.com/software-engineering-perspectives/noestimates-software-effort-estimations
- https://neilkillick.medium.com/noestimates-part-1-doing-scrum-without-estimates-b42c4a453dc6
- https://neilkillick.wordpress.com/2013/01/31/noestimates-part-1-doing-scrum-without-estimates/
- https://neilkillick.wordpress.com/2016/03/12/the-common-ground-of-estimates-and-noestimates/
- https://neilkillick.wordpress.com/category/noestimates/
- https://www.infoq.com/interviews/killick-no-estimates/
- https://www.slideshare.net/neilkillick/the-noestimates-debate

Critical Path / Critical Chain / Theory of Constraints:
- https://en.wikipedia.org/wiki/Critical_chain_project_management
- https://en.wikipedia.org/wiki/Critical_Chain_(novel)
- https://www.critical-chain-projects.com/the-method
- https://www.projectcontrolacademy.com/project-critical-chain/
- https://www.researchgate.net/publication/222534871_Critical_chain_The_theory_of_constraints_applied_to_project_management
- https://www.sciencedirect.com/science/article/abs/pii/S0263786399000198
- https://asana.com/resources/critical-chain-project-management
- https://kaizen.com/insights/critical-chain-project-management/
- https://tameflow.com/blog/2012-09-25/critical-chain-project-management-in-TOC/
- https://www.proofhub.com/articles/critical-chain-management

Hofstadter's law / Planning fallacy:
- https://en.wikipedia.org/wiki/Hofstadter's_law
- https://en.wikipedia.org/wiki/Planning_fallacy
- https://www.paretoanalysis.tools/hofstadters-law-and-the-planning-fallacy/
- https://www.techtarget.com/whatis/definition/Hofstadters-law
- https://marc-prager.co.uk/time-management-training/7-fundamental-laws-time-management/hofstadter-law/
- https://medium.com/@aymen.benammar.ensi/hofstadters-law-why-your-software-project-will-be-late-even-after-reading-this-article-2661bdc3a9bd
- https://theknowledge.io/project-planning-with-hofstadters-law-and-the-2x-3x-rule/

Multitasking / Parallelism / Amdahl's law:
- https://www.parallelprojecttraining.com/blog/the-multi-tasking-myth-in-project-management-why-single-tasking-is-the-key-to-productivity/
- https://www.projectmanagement.com/blog-post/18355/multitasking
- https://t2informatik.de/en/blog/multitasking-madness-in-project-management/
- https://www.rosemet.com/project-multitasking/
- https://www.stackfield.com/blog/multi-project-management-135
- https://en.wikipedia.org/wiki/Amdahl's_law
- https://www.splunk.com/en_us/blog/learn/amdahls-law.html
- https://shahbhat.medium.com/applying-laws-of-scalability-to-technology-and-people-5884b4b4b04
- https://en.wikipedia.org/wiki/Task_parallelism

Dependency graphs / DAGs:
- https://www.databricks.com/glossary/dag
- https://en.wikipedia.org/wiki/Directed_acyclic_graph
- https://www.ibm.com/think/topics/directed-acyclic-graph
- https://dev.to/capnspek/common-graph-algorithms-directed-acyclic-graph-dag-algorithm-4bpl
- https://www.tweag.io/blog/2025-09-04-introduction-to-dependency-graph/
- https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html
- https://www.vulncheck.com/blog/understanding-software-dependency-graphs

SAFe PI Planning:
- https://framework.scaledagile.com/pi-planning/
- https://www.easyagile.com/blog/the-ultimate-guide-to-pi-planning
- https://miro.com/agile/pi-planning/what-is-pi-planning/
- https://www.eliassen.com/blog/elas-blog-posts/successful-program-increment-pi-planning-in-safe
- https://axify.io/blog/pi-planning
- https://agilefever.com/essential-guide-to-safe-pi-planning/
- https://blog.iconagility.com/what-is-pi-planning
- https://kendis.io/pi-planning-guide/
- https://www.planview.com/resources/guide/scaled-agile-framework-how-technology-enables-agility/program-increment-planning/

Continuous delivery / Trunk-based / Feature flags:
- https://www.atlassian.com/continuous-delivery/continuous-integration/trunk-based-development
- https://trunkbaseddevelopment.com/feature-flags/
- https://martinfowler.com/articles/feature-toggles.html
- https://developer.harness.io/docs/feature-flags/get-started/trunk-based-development/
- https://www.featbit.co/articles2025/trunk-based-development-feature-flags-2025
- https://docs.getunleash.io/guides/trunk-based-development
- https://www.harness.io/blog/trunk-based-development
- https://devcycle.com/blog/transitioning-to-trunk-based-development
- https://www.flagsmith.com/blog/trunk-based-development

OKRs and roadmaps:
- https://www.sharpcloud.com/blog/integrating-roadmaps-with-okrs-a-practical-guide
- https://www.planview.com/resources/guide/a-guide-to-okrs/improve-alignment-with-okr-roadmap/
- https://romanpichler.medium.com/okrs-and-product-roadmaps-5c00773b32c0
- https://www.productplan.com/templates/okr-roadmap/
- https://monday.com/blog/rnd/okrs-for-product-management/
- https://dragonboat.io/blog/product-okrs/
- https://www.getjop.com/blog/okr-product-roadmap
- https://oboard.io/blog/okr-alignment-and-breakdown
- https://www.productplan.com/learn/prioritize-product-roadmap-with-okrs/

Scrum / Sprint cadence:
- https://scrumguides.org/scrum-guide.html
- https://appliedframeworks.com/blog/sprint-cadence-a-pragmatic-guide
- https://www.scrum.org/resources/blog/sprint-vision-balancing-strategy-tactics-and-risk-product-goal
- https://www.atlassian.com/agile/scrum/ceremonies
- https://www.growingscrummasters.com/keywords/sprint-cadence/
- https://www.atlassian.com/agile/project-management/sprint-cadence
- https://www.pmi.org/disciplined-agile/agile/teamcadences
- https://bigpicture.one/blog/sprint-cadence-iteration/
- https://www.scrum.org/resources/blog/navigating-scrum-events-sprint
- https://agileseekers.com/blog/planning-interval-vs-traditional-sprint-planning-in-agile

Lean Startup / Build-Measure-Learn:
- https://en.wikipedia.org/wiki/Lean_startup
- https://www.amazon.com/Lean-Startup-Entrepreneurs-Continuous-Innovation/dp/0307887898
- https://www.summrize.com/books/the-lean-startup-summary
- https://togroundcontrol.com/blog/validated-learning/
- https://www.linkedin.com/pulse/build-measure-learn-which-risky-assumption-three-adam-berk
- https://insideproduct.co/build-measure-learn/
- https://readingraphics.com/book-summary-the-lean-startup/
- https://www.painbase.space/blog/the-lean-startup-approach-to-validating-business-ideas

Launch, release-readiness, rollback:
- https://www.momentslog.com/development/how-to-run-a-production-readiness-review-that-catches-real-risk-before-launch-day
- https://www.supportbench.com/run-support-driven-release-readiness-checklist/
- https://www.cortex.io/post/how-to-create-a-great-production-readiness-checklist
- https://getdx.com/blog/production-readiness-checklist/
- https://www.deployhq.com/blog/the-ultimate-deployment-checklist-ensuring-smooth-and-successful-releases
- https://checklist.gg/templates/release-roll-back-checklist
- https://docs.gitscrum.com/en/best-practices/launch-readiness-checklist
- https://www.cortex.io/post/software-release-checklist
- https://www.port.io/blog/production-readiness-checklist-ensuring-smooth-deployments
- https://launchdarkly.com/blog/release-management-checklist/
- https://www.rocketmvp.io/resources/soft-launch-vs-hard-launch
- https://getlaunchlist.com/checklists/producthunt
- https://getlaunchlist.com/blog/how-to-launch-on-product-hunt-2026
- https://waitlister.me/growth-hub/guides/product-hunt-launch-checklist
- https://usewhale.io/blog/product-hunt-launch-checklist/
- https://viral-loops.com/blog/coming-soon-website/
- https://kickofflabs.com/blog/what-is-a-product-launch-waitlist/
- https://www.shadow.do/blog/ultimate-guide-to-optimizing-your-product-hunt-launch

AI PM tools 2024-2026:
- https://aipmtools.org/articles/future-of-ai-product-management
- https://www.chatprd.ai/learn/capabilities-of-ai-agents-product-management
- https://www.chatprd.ai/learn/best-ai-tools-for-product-managers
- https://www.productboard.com/blog/using-ai-for-product-roadmap-prioritization/
- https://productschool.com/blog/artificial-intelligence/ai-product-roadmap
- https://productschool.com/blog/artificial-intelligence/ai-learning-roadmap
- https://blog.buildbetter.ai/12-best-ai-product-management-tools-for-2025/
- https://onehorizon.ai/blog/best-ai-product-management-tools
- https://visualping.io/blog/ai-tools-for-product-managers
- https://voltagecontrol.com/articles/ai-product-management-roadmap-frameworks-step-by-step-guide/
- https://pm-33.com/blog/ai-project-management-software-guide
- https://www.reforge.com/blog/how-ai-changes-product-management
- https://www.eleken.co/blog-posts/ai-product-manager

Atlassian Rovo / Jira AI:
- https://www.atlassian.com/software/jira/ai
- https://www.atlassian.com/software/rovo
- https://idalko.com/blog/atlassian-rovo-transformation
- https://community.atlassian.com/forums/Atlassian-AI-Rovo-articles/Harnessing-Rovo-in-Jira-A-Practical-Guide-for-Atlassian-Admins/ba-p/3142700
- https://www.servicerocket.com/resources/atlassian-rovo-your-ai-implementation-roadmap
- https://www.atlassian.com/blog/jira-product-discovery/system-of-truth-live-roadmap
- https://appsvio.com/blog/how-atlassian-rovo-and-ai-redefine-the-software-lifecycle-in-jira/
- https://community.atlassian.com/forums/Atlassian-AI-Rovo-articles/A-Deep-Dive-into-Rovo-Dev-and-Atlassian-AI-s-Agentic-Workflow/ba-p/3140356
- https://ikuteam.com/blog/understanding-jira-ai-enhancing-work-with-rovo
- https://www.zen-networks.io/en/atlassian/rovo/

Roadmap tool comparisons 2025-2026:
- https://monday.com/blog/rnd/linear-or-jira/
- https://monday.com/blog/rnd/linear-alternatives/
- https://monday.com/blog/rnd/aha-vs-jira/
- https://clickup.com/blog/linear-vs-jira/
- https://zeda.io/blog/aha-vs-jira
- https://www.atlassian.com/software/jira/comparison/jira-vs-linear
- https://ones.com/blog/jira-product-discovery-alternatives-6/
- https://ones.com/blog/best-jira-product-discovery-alternative/
- https://howtoes.blog/2025/08/05/best-product-roadmap-tools-for-2025-complete-comparison-of-15-top-options/
- https://monday.com/blog/rnd/productboard-vs-jira/

End of report.

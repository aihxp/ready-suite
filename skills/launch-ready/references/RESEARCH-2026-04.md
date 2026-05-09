# launch-ready research pass, 2026-04

Scope check: this report covers what it takes to actually put a newly-deployed app in front of real users and have some of them stay. In scope: landing page craft, positioning and copy, launch-day SEO, Open Graph and social share cards, waitlist tooling and pre-launch email, launch channels (Product Hunt, Show HN, Reddit, Twitter/X, Indie Hackers, LinkedIn, dev.to, niche communities), press and influencer outreach, launch-day telemetry, launch-week runbook from D-7 to D+7, post-launch transition. Out of scope: end-to-end app wiring (production-ready), stack and IaC tool selection (stack-ready), repo hygiene (repo-ready), deployment mechanics and rollback (deploy-ready), ongoing SRE signals and SLOs (observe-ready), and post-launch product marketing as a permanent function.

launch-ready consumes artifacts from its siblings: the shipped app from production-ready, the deploy pipeline from deploy-ready, the observability so the launch does not happen blind (observe-ready). It produces artifacts that the operator uses once and then archives: a launch calendar, a press kit, a referral-source dashboard, a thank-you email sequence, a retrospective.

This document is the research backbone. It cites every claim to a live URL. Numbers in this document are either cited or marked as anecdotal / heuristic so the reader knows the difference.

---

## 1. Current state: why founders fail to launch well

Three failure archetypes appear again and again in founder postmortems on Indie Hackers, Product Hunt, Hacker News, and Twitter/X. Each is a different category of launch miss, and each has a different fix. The patterns below come from named, public postmortems, not generalized advice.

### 1.1 "No traction": the 15-upvote Product Hunt

The canonical shape: a founder spends weeks building, hits the launch button, watches the counter tick up to 15 or 30 upvotes from friends and family, then watches it stop. Indie Hackers' "Aftermath of our disappointing Product Hunt launch" by the team behind Raport is the textbook version. Their numbers: finished #8 product of the day after targeting top 3, 564 visits, 56 signups, launched on a Tuesday ("a competitive day"), relied on a hunter with 12,000 followers who delivered minimal lift, changed pricing 24 hours before launch, ran all promotional activities simultaneously rather than paced through the day ([Indie Hackers](https://www.indiehackers.com/post/aftermath-of-our-disappointing-product-hunt-launch-a81fea3a52)). The founder's summary: "Product Hunt was an easy way to get new users. Time to get back to hustling."

The same pattern turns up repeatedly: Indie Hackers hosts posts titled "Notes from a failed Product Hunt launch," "So, I launched on Product Hunt, and it flopped," "Why You Probably Shouldn't Launch on Product Hunt," "ProductHunt launch was a spectacular failure," and more ([Indie Hackers](https://www.indiehackers.com/post/notes-from-a-failed-product-hunt-launch-1332b8cade); [Indie Hackers](https://www.indiehackers.com/@naveen_pacha/1874fb5b01); [Indie Hackers](https://www.indiehackers.com/article/why-you-probably-shouldnt-launch-on-product-hunt-8735616db4); [Indie Hackers](https://www.indiehackers.com/product/bootstrap-themes-com/producthunt-launch-was-a-spectacular-failure--Ljvmi0wxAF-4tF5FfAB)). The consistent theme across these: the founder shows up on launch day with no pre-existing audience, no newsletter subscribers, no Twitter following to share to, and treats Product Hunt as a discovery channel instead of a distribution amplifier for an audience they already own. The successful counterpattern (covered in section 8) shows the same platform with an email list of 25,000 delivering a #1 for Dub.co ([Awesome Directories](https://awesome-directories.com/blog/product-hunt-launch-guide-2025-algorithm-changes/)).

Product Hunt's 2025 algorithm compounds this. According to multiple teardowns, only ~10% of submissions now get Featured (the manually-curated homepage that gets meaningful traffic), and un-Featured submissions are functionally invisible on mobile ([Awesome Directories](https://awesome-directories.com/blog/product-hunt-launch-guide-2025-algorithm-changes/); [Flowjam](https://www.flowjam.com/blog/how-to-get-featured-on-product-hunt-2025-guide)). A launch can collect upvotes and still be invisible to the audience it was targeting. The algorithm also discounts or zeroes votes from new accounts and coordinated voting patterns ([Awesome Directories](https://awesome-directories.com/blog/product-hunt-launch-guide-2025-algorithm-changes/)), so the old tactic of rallying brand-new Product Hunt accounts in a Slack group now actively hurts.

### 1.2 "Viral but crashed": HN front page, dropped entries

The "hug of death" has enough published postmortems to be a category of its own. iDiallo's "Surviving the Hug of Death" frames it as the predictable outcome of a dynamic landing page getting hit with tens of thousands of requests in minutes ([iDiallo](https://idiallo.com/blog/surviving-the-hug-of-death)); Stan Larroque's postmortem of his own HN traffic spike concludes that "a well-optimized lightweight setup beats expensive infrastructure" and that a $6/month server can absorb an HN front-page hit with the right static caching ([Stan.sh](https://stan.sh/2017/12/09/surviving-the-hacker-news-hug-of-death/)). SadServers' postmortem describes the specific shape of the failure: database queries that return fast at 10 rps and time out at 500 rps, waitlist forms that accept the email but never write it because Postgres hit its connection cap, Cloudflare signing certificates that tripped a rate limit when thousands of new users arrived in five minutes ([DevOps.dev / Medium](https://blog.devops.dev/sadservers-and-the-hacker-news-hug-of-death-a-postmortem-af20ddc58526)).

Supermarket, a recipe community, went down two hours after launch due to health-check timeouts tuned too tight; the site was up but the load balancer kept rotating healthy pods out ([Gatling summary](https://gatling.io/blog/when-websites-and-applications-crash-5-examples-and-what-went-wrong)). Coinbase's Super Bowl ad drove 20 million visits in one minute and briefly took the landing page down due to CDN misconfiguration ([Gatling](https://gatling.io/blog/when-websites-and-applications-crash-5-examples-and-what-went-wrong)). These are the shape launch-day traffic takes: a spike, measured in multiples not percentages, against pages that tested fine at steady state.

The Indie Hackers "Front page of HN: the full postmortem" from the Aidlab team shows the non-crashed counterpattern: roughly 468 active users on launch day (350 from HN and GitHub combined), ~6k page views, 500+ unique visitors from HN in total, a bounce rate of ~20% ("notably low for HN"), and an average session duration over 2 minutes ([Indie Hackers](https://www.indiehackers.com/post/front-page-of-hn-the-full-postmortem-traffic-lessons-surprises-cbe9e0a7f6)). Their first Show HN had failed because "the title sounded too producty." The second, framed as "Health Data for Devs," hit the front page. The shape of HN traffic they describe is the pattern to plan for: a 24-hour controlled explosion, a gentle decline, a long tail.

### 1.3 "Shipped with no positioning": the app is real, nobody knows what it does

This is the quieter failure and the most common one. The app works, the deploy succeeded, the launch post went up, and the hero section tells the visitor nothing they can act on. Conversion Haus catalogs this directly: AI landing pages have converged on "identical hero sections featuring centered headlines with dashboard screenshots" and hero copy that "uses a lot of words to say absolutely nothing" ([Conversion Haus](https://www.conversion-haus.com/post/the-problem-with-ai-landing-pages-and-why-most-saas-sites-look-the-same)). The specific phrase they cite as a failure mode is "Revolutionise Your Workflow with Our AI-Driven Platform," which describes no user, no problem, no alternative it replaces, and no reason to click.

Unbounce's conversion benchmark report quantifies the cost. The median SaaS landing page converts at 3.8%, 42% below the cross-industry 6.6% baseline ([Unbounce](https://unbounce.com/conversion-benchmark-report/saas-conversion-rate/)). Pages with copy written at 5th-to-7th-grade level convert at 12.9%; pages with professional-level copy convert at 2.1%, a 514% gap attributable purely to reading level ([Unbounce](https://unbounce.com/conversion-benchmark-report/saas-conversion-rate/)). "Corporate speak" does not just feel bad; it is measurably worse at converting.

The base rate of "shipped without positioning" is hard to pin to a public number, but the proxy metric is the ratio of landing-page visitors to signup-starts on a typical indie launch. Unbounce puts SaaS median conversion at 3.8% and top-quartile at 11.6% ([Unbounce](https://unbounce.com/conversion-benchmark-report/saas-conversion-rate/)), so a launch that drives 5,000 visitors and gets 50 signups (1%) is sitting below the 20th percentile of published SaaS benchmarks. That is the invisible version of launch failure: the traffic showed up, the form did not fail, and the copy lost them before the CTA.

---

## 2. The AI-slop landing page

The archetype is specific enough to name. It has: a gradient hero (purple, teal, or the Linear-dark palette), a centered H1 with the words "AI-powered" or "Intelligent" or "Seamless," three-line sub-hero about empowering teams, a shadcn/ui Card grid with six feature tiles each using one of a shortlist of adjectives, a "Loved by developers" logo wall pulled from logoipsum, a pricing table with three columns and a faint "Most Popular" ribbon on the middle one, Inter font from Google Fonts at default tracking, and a CTA that says "Get Started" with no object. Every v0 / Lovable / Cursor / Claude-generated MVP landing page ships with some subset of this.

### 2.1 Why the convergence is structural

AXE-WEB's explanation is blunt: "AI models are trained on billions of existing websites, and when prompted to build a modern SaaS landing page, they analyze that data and produce statistically the most likely layout for a SaaS page" ([AXE-WEB](https://axe-web.com/insights/ai-website-design-sameness/)). Conversion Haus frames the same point: "by asking AI to generate a high-converting SaaS landing page, companies receive the median version of the internet" ([Conversion Haus](https://www.conversion-haus.com/post/the-problem-with-ai-landing-pages-and-why-most-saas-sites-look-the-same)). This is a well-behaved failure mode of LLMs, not a bug: generating the statistical mean of the training distribution is what they are built to do. When every other solopreneur in the cohort also runs the same prompt, every landing page converges on the same template, same components, same adjectives.

Overpass Studio's teardown of the pattern calls out the specific visual elements: "a sea of sameness, identical bento-grid layouts, the same neon-purple gradients, and generic AI-powered headlines" ([Overpass](https://www.overpass.studio/blog/why-saas-websites-look-the-same)). Conversion Haus lists "bento grids and neon-purple gradients appear repeatedly across competitors." The copy signature has its own fingerprint.

### 2.2 The banned-word list, documented

The overused-AI-word literature is extensive and largely consistent. Content Beta's 2026 list catalogs over 300 words and phrases that AI models disproportionately produce, headed by: delve, seamless, unlock, empower, harness, revolutionize, transformative, cutting-edge, game-changing, robust, comprehensive, streamline, elevate, paradigm, tapestry, realm, leverage, synergy, innovative, pivotal, meticulously, unparalleled, supercharge, state-of-the-art ([Content Beta](https://www.contentbeta.com/blog/list-of-words-overused-by-ai/)). OneSecMedia's "50 Overused ChatGPT Words in 2026" is a consistent subset of that list ([OneSecMedia](https://www.onesecmedia.com/post/chatgpt-overused-words)). FOMO.ai publishes a "copy-paste prompt add-on" that ships the same list as a ban list to prepend to any generation prompt ([FOMO.ai](https://fomo.ai/ai-resources/the-ultimate-copy-paste-prompt-add-on-to-avoid-overused-words-and-phrases-in-ai-generated-content/)). Matrix Group publishes a "how to customize ChatGPT to avoid overused AI words" writeup that names the same words ([Matrix Group](https://www.matrixgroup.net/blog/how-to-customize-chatgpt-to-avoid-overused-ai-words/)).

The consensus banned-word list for landing-page hero and feature copy in 2026:

| Category | Words to ban |
|---|---|
| Generic verbs | empower, unlock, supercharge, streamline, elevate, harness, revolutionize, transform |
| Generic adjectives | seamless, powerful, effortless, intelligent, robust, comprehensive, cutting-edge, game-changing, revolutionary, state-of-the-art, unparalleled, transformative, innovative, pivotal |
| AI-fingerprint nouns | paradigm, tapestry, realm, landscape, synergy, ecosystem |
| Lazy qualifiers | meticulously, effortlessly, truly, really |

These are not bad words in isolation; they are bad because they are load-bearing. A hero headline built on "empower" and "seamless" describes no user, no problem, no outcome. Substitutes are not other adjectives; substitutes are specific verbs and nouns that name the actual thing the user does.

### 2.3 The name for the pattern

There is no universally adopted term in the published literature. Candidates floated by critics include "sea of sameness" ([Overpass](https://www.overpass.studio/blog/why-saas-websites-look-the-same)), "median version of the internet" ([Conversion Haus](https://www.conversion-haus.com/post/the-problem-with-ai-landing-pages-and-why-most-saas-sites-look-the-same)), and "generic AI output" ([AXE-WEB](https://axe-web.com/insights/ai-website-design-sameness/)). For the launch-ready skill the sharpest name is **"AI-slop landing"**, by analogy to "AI slop" which is the widely-used term in content circles for statistically-average AI output. The term is already in use in the AI discourse and its meaning is immediately legible. The pattern it describes includes the full package: visual sameness (shadcn/Tailwind defaults, purple gradient, Inter), copy sameness (the banned-word list), structural sameness (hero + 3-to-6 feature card grid + pricing table + footer), and zero differentiation.

A secondary failure mode worth naming separately is **"hero-fatigue copy"**: the specific sin of a hero that occupies above-the-fold real estate and tells the visitor nothing. This is narrower than AI-slop landing (a page can have one without the other) and sharper as a refusal criterion.

---

## 3. The landing page that converts: anatomy

The consensus anatomy of a landing page that converts comes from four strands of published work: Julian Shapiro's Startup Handbook, Harry Dry's Marketing Examples, Unbounce's benchmark reports, and April Dunford's positioning work. The rules below are cited to the primary source on each.

### 3.1 Hero: three elements, narrative CTA

Julian Shapiro's guide is the most explicit. The hero is three things: header text, subheader text, imagery. "The header must be fully descriptive of what you're selling" ([Julian Shapiro](https://www.julian.com/guide/startup/landing-pages)). This is not a stylistic preference; it is a test. Can a stranger who has never heard of your company read the H1 and describe what you do to someone else? If not, the hero fails.

The sub-header expands on either "how the product works" or "which features make the header's claim believable" ([Julian Shapiro](https://www.julian.com/guide/startup/landing-pages)). The sub-header is not more adjectives; it is a second beat of the pitch.

Shapiro's CTA rule is narrative continuity: "Rather than generic buttons like 'Request a meeting,' effective CTAs continue the story begun in the header, examples include 'Find food' or 'Start learning'" ([Julian Shapiro](https://www.julian.com/guide/startup/landing-pages)). The generic "Get Started" is a tell: it could be on any page. A narrative CTA ("Find my nearest park," "Book a 15-minute Zoom") names the next step in the story the hero started.

### 3.2 Above the fold: "consideration spans" not attention spans

Shapiro reframes the standard bromide: "Rather than assuming short attention spans, recognize visitors have short consideration spans; they must be hooked quickly" ([Julian Shapiro](https://www.julian.com/guide/startup/landing-pages)). Lengthy pages are fine. The hero has to do the hooking.

Apexure's "Above the Fold Landing Page Design" guide anchors the same point to first-five-seconds behavior: users will keep scrolling if the hook is strong, abandon if it is not ([Apexure](https://www.apexure.com/blog/above-the-fold-landing-page-design)). The above-the-fold discipline is not about cramming the whole pitch into 600 pixels; it is about earning the scroll.

### 3.3 Single-CTA rule

Landing Page Flow's 2026 guide cites studies "showing decreases of up to 266% when multiple competing actions are presented" and recommends "a single, clear CTA, or at most, a primary and secondary option that doesn't compete" ([Landing Page Flow](https://www.landingpageflow.com/post/best-cta-placement-strategies-for-2026-landing-pages)). The specific anti-pattern they describe is three buttons above the fold ("Get a Quote," "Book a Demo," "Watch a Video") where each dilutes the others. The rule: one primary action. If the page has two goals, it has none.

### 3.4 Social proof placement

Shapiro's rule: social proof appears after the hero and displays "logos of press coverage and notable customers." The goal is FOMO, the feeling that "everyone in the world already knows about you." If you do not have prestigious customers yet, offer free access to companies whose logos carry weight ([Julian Shapiro](https://www.julian.com/guide/startup/landing-pages)).

Harry Dry's specificity rule applies here too: a logo wall with no caption is weaker than a logo wall with a caption like "2,347 teams use this, including Stripe, Linear, and Figma." Concrete numbers are falsifiable; round logos are decorative ([Sproutworth on Harry Dry](https://www.sproutworth.com/art-of-copywriting/)).

### 3.5 Feature grid: 3-6 sections, each a narrative beat

Shapiro's recommendation: features "occupy the bulk of the page, typically 3-6 sections." Each feature block contains a value-proposition header, an explanatory paragraph addressing the objection the feature answers, and reinforcing imagery. "Features should weave a running narrative connecting back to the dominant hero value proposition" ([Julian Shapiro](https://www.julian.com/guide/startup/landing-pages)).

The anti-pattern (the one AI-slop landing pages lean into) is six feature cards each with one adjective, one sentence, and one Lucide icon. That produces no narrative; it produces a spec sheet. The name for this failure is **spec-sheet positioning** (section 13).

### 3.6 Pricing page display patterns

ProfitWell's pricing teardowns, run for years by Patrick Campbell, catalog the shape: transparent pricing, three-column grids with feature comparison, annual-vs-monthly toggle, plan names that name the buyer not the tier ("Freelancer," "Team," "Enterprise") ([ProfitWell on Product Hunt](https://www.producthunt.com/products/pricing-page-teardown-from-profitwell); [Acquired podcast with Patrick Campbell](https://www.acquired.fm/episodes/pricing-everything-you-always-wanted-to-know-but-were-afraid-to-ask-with-profitwell-ceo-patrick-campbell)). Campbell's consistent finding from ProfitWell's data: value-based pricing with quantified buyer personas increases revenue 30-40% over naive cost-plus pricing ([LevelingUp podcast](https://www.levelingup.com/sales/patrick-campbell-price-intelligently/)). For a launch, the practical version is: publish prices, do not hide them behind "Contact Sales" unless you are enterprise-only, and name the plans after the buyer.

### 3.7 Copy rules and conversion data

Unbounce's benchmark data is the cleanest published quantification of copy's effect on conversion. Pages with 5th-to-7th-grade reading level convert at 12.9%; pages with professional-level copy convert at 2.1% ([Unbounce](https://unbounce.com/conversion-benchmark-report/saas-conversion-rate/)). Optimal word count is 250-725 words; 50-140 of those should be three-syllable-or-longer words, so the page is not uniformly simple but not uniformly complex either ([Unbounce](https://unbounce.com/conversion-benchmark-report/saas-conversion-rate/)). Email traffic converts 4x better than any other source, with a 16.9% median conversion rate on landing pages from email, versus 4.1% from paid search and 2.9% from paid social ([Unbounce](https://unbounce.com/conversion-benchmark-report/saas-conversion-rate/)).

For a launch, the implication is direct: the biggest conversion leverage is the email list you bring to launch day, not the landing page you run ads to on launch day. The landing page has to not lose the email subscribers you already have.

---

## 4. Positioning and copy

### 4.1 April Dunford's framework

April Dunford's "Obviously Awesome" is the industry reference on positioning. The book's central argument: positioning is "the foundation of everything we do in marketing and sales" and forms the "backbone of our go-to-market strategy" ([aprildunford.com](https://www.aprildunford.com/books)). She defines positioning in five components: competitive alternatives (what would customers do if your product did not exist), unique attributes (what features you have that alternatives do not), value those attributes enable (the translation of features into customer outcomes), best-fit customers (who cares most about that value), and the market category that frames the value ([Heinz Marketing summary](https://www.heinzmarketing.com/blog/10-step-positioning-process-an-obviously-awesome-book-summary-part-3/); [Reading Graphics](https://readingraphics.com/book-summary-obviously-awesome/)).

Her 10-step process, summarized: (1) understand your best customers, (2) form a positioning team, (3) align on what positioning is (not a statement, a foundation), (4) list competitive alternatives, (5) isolate unique attributes, (6) map attributes to value themes, (7) determine who cares, (8) pick a market frame, (9) layer in trends (optional), (10) capture the positioning in a brief ([Heinz Marketing](https://www.heinzmarketing.com/blog/10-step-positioning-process-an-obviously-awesome-book-summary-part-3/); [Userlist](https://userlist.com/blog/positioning-overhaul/)).

For a launch, the three tests that matter are derived from this framework:

1. **The "who is this for" test.** The landing page must name the user in a way they would use to describe themselves. "For marketing teams" passes. "For growth-oriented professionals" fails (no one calls themselves that).
2. **The "what does it replace" test.** Dunford's competitive-alternatives frame: if you do not name what the user would do without you, you have not positioned. "Replaces your weekly standup" is positioning; "improves team communication" is not.
3. **The differentiator test.** For every claim on the page, would a credible competitor say the same? If "fast," "secure," "reliable," and "easy to use" could appear on any competitor's page, they are table stakes, not differentiators.

Dunford's book has sold over 100,000 copies and is the default reference cited by indie founders from Arvid Kahl to Hiten Shah ([April Dunford Substack announcement](https://aprildunford.substack.com/p/announcement-obviously-awesome-the)).

### 4.2 Harry Dry's specificity rule

Harry Dry's Marketing Examples runs on a single principle: get specific. His corrective example: rewrite "Be part of a global creative community" to "Get feedback from 75 designers" ([Sproutworth](https://www.sproutworth.com/art-of-copywriting/)). His "three rules" for copy are visualization (can the reader picture it), falsifiability (could it be wrong), and uniqueness (could a competitor say it) ([Upgrow](https://www.upgrow.io/blog/harry-dry-copywriting-3-rules)). The falsifiability rule is the deepest one: "best-in-class security" cannot be wrong and therefore carries no information. "SOC 2 Type II certified, audited January 2026" can be checked and therefore carries evidence.

Marketing Examples has 130,000 subscribers and is the most consistently cited landing-page resource in the indie community ([marketingexamples.com](https://marketingexamples.com/landing-page)). Dry's landing-page lessons are catalogued by topic: CTA warmth, pricing psychology (Basecamp, Wine List teardowns), signup form design (Notion), social proof (Ahrefs).

### 4.3 Banned words, documented

Section 2.2 enumerates the overused-AI-word list. For positioning specifically, the cohort of words that fail the differentiator test (any competitor would say the same) overlaps heavily with the AI-fingerprint list. The practical ban list for hero and feature copy is: empower, seamless, revolutionary, effortless, intelligent, powerful, cutting-edge, game-changing, unlock, supercharge, streamline, elevate, transformative, robust, comprehensive, innovative, state-of-the-art, game-changing, world-class. Sources that explicitly catalog these as overused-by-AI / failing-differentiator: Content Beta ([list of 300+](https://www.contentbeta.com/blog/list-of-words-overused-by-ai/)), OneSecMedia ([50 overused](https://www.onesecmedia.com/post/chatgpt-overused-words)), FOMO.ai ([ban-list prompt](https://fomo.ai/ai-resources/the-ultimate-copy-paste-prompt-add-on-to-avoid-overused-words-and-phrases-in-ai-generated-content/)), Authentic AI ([5 common ChatGPT cliches](https://authenticai.co/blog-feed/5-common-chatgpt-words-to-avoid)), Conversion Haus ([fluff phrases](https://www.conversion-haus.com/post/the-problem-with-ai-landing-pages-and-why-most-saas-sites-look-the-same)).

---

## 5. Launch-day SEO fundamentals

This section is explicit about scope: launch-day SEO, not ongoing SEO. The operator has one shot to land the site in Google's index with the right signals set, the right structured data, and the right social tags. The rest (link-building, content strategy, topical authority) is out of scope for launch-ready and belongs to ongoing product marketing.

### 5.1 Core Web Vitals as of 2026

Google confirms three Core Web Vitals in 2026: Largest Contentful Paint (LCP) "good" under 2.5s, Cumulative Layout Shift (CLS) under 0.1, and Interaction to Next Paint (INP) under 200ms ([Google Search Central on Core Web Vitals](https://developers.google.com/search/docs/appearance/core-web-vitals)). INP replaced First Input Delay (FID) in March 2024 ([W3era](https://www.w3era.com/blog/seo/core-web-vitals-guide/)). Core Web Vitals remain a confirmed ranking signal in 2026 but their ranking impact is "relatively small; they act more as a tie-breaker signal, meaning they help decide rankings between pages with similar content, authority, and relevance rather than driving rankings on their own" ([fireup.pro](https://fireup.pro/news/core-web-vitals-in-2026-what-actually-impacts-google-rankings)).

For a launch-day static landing page served from a CDN, all three should be green with minimal effort. The trap is third-party embeds (chat widgets, analytics, OG image generation) that push CLS or INP into yellow.

### 5.2 Helpful content, E-E-A-T, site reputation abuse

Google's March 2024 core update "took 45 days to roll out, changed multiple systems at once, and wiped out 40 percent of low-quality content from search results" ([Google Search Central blog](https://developers.google.com/search/blog/2024/03/core-update-spam-policies)). The Helpful Content System is no longer a separate signal; it is folded into the core ranking algorithm ([Flora Fountain summary](https://florafountain.com/what-is-google-helpful-content-update-of-march-2024-everything-you-need-to-know/)). E-E-A-T (Experience, Expertise, Authoritativeness, Trustworthiness) is weighted heavily in YMYL (Your Money, Your Life) categories but applies everywhere.

The site-reputation-abuse policy took effect May 5, 2024 and targets "third-party pages published with little or no first-party oversight" on authoritative domains ([Google Search Central on site reputation abuse](https://developers.google.com/search/blog/2024/11/site-reputation-abuse)). Forbes, CNN, USA Today had entire sections de-indexed overnight for what Search Engine Land called parasite SEO ([Search Engine Land](https://searchengineland.com/google-site-reputation-abuse-policy-band-aid-bullet-wound-448488)). For a launch-day operator, the implication is narrow but worth knowing: guest posts on low-quality authority domains are worth nothing, and pitching press (section 9) is about actual coverage, not SEO juice.

### 5.3 Structured data for launch

Three schema.org types cover nearly every launch-day case.

**Organization**: name, url, logo, sameAs (links to social profiles). Applies to the company entity itself ([schema.org/Organization](https://schema.org/Organization)).

**SoftwareApplication**: required for rich results are name, offers.price (0 if free, or specific), and either aggregateRating or review. Recommended: applicationCategory and operatingSystem ([Google Search Central on SoftwareApplication](https://developers.google.com/search/docs/appearance/structured-data/software-app)). WebApplication is a subtype if the app is browser-accessed.

**Product**: used if the launch is a tangible or subscription product with pricing and reviews.

**FAQPage**: still valid but Google reduced FAQ rich-result eligibility in August 2023 to government and health-authority sites only; do not expect FAQ rich results to show on a launch site, though the schema is still valid markup ([Google Search Central on FAQ changes](https://developers.google.com/search/blog/2023/08/howto-faq-changes); this change was widely covered in SEO press). Still worth including for LLM crawlers that parse the JSON-LD.

### 5.4 Meta tags, OG, Twitter: the launch-day checklist

Google Search Central's SEO Starter Guide is explicit: titles should be "unique to the page, clear and concise, and accurately describe the contents" ([Google Search Central](https://developers.google.com/search/docs/fundamentals/seo-starter-guide)). Meta descriptions should be "short, unique to one particular page" and typically one to two sentences.

Practical limits, derived from SERP-rendering thresholds:

- Title tag: under 60 characters for desktop SERPs, under 50 for mobile. Longer titles get truncated.
- Meta description: under 160 characters (Google truncates around 155-160 for desktop, 120 for mobile).
- Single H1 per page, matching or closely related to the title tag.
- Canonical URL via `rel="canonical"` to prevent duplicate-content splits, especially important if the site has www / non-www or http / https variants ([Google Search Central](https://developers.google.com/search/docs/fundamentals/seo-starter-guide)).
- Sitemap.xml at /sitemap.xml referenced in robots.txt.
- Robots.txt at /robots.txt; the launch-day gotcha is leaving a staging-era `Disallow: /` in production, which de-indexes the entire site.

Open Graph tags: og:title, og:description, og:url, og:image, og:type (usually "website"), og:site_name. Twitter/X: twitter:card (summary_large_image for most launches), twitter:title, twitter:description, twitter:image. og:title and og:description should be written to be distinct from meta title and description because they render in different contexts (chat apps, not search results) and can afford to be more punchy.

### 5.5 OG image specification

The cross-platform consensus is 1200x630 pixels (aspect ratio 1.91:1), under 8 MB, JPG/PNG/WebP ([OG Image Gallery](https://www.ogimage.gallery/libary/the-ultimate-guide-to-og-image-dimensions-2024-update); [Krumzi](https://www.krumzi.com/blog/open-graph-image-sizes-for-social-media-the-complete-2025-guide); [OG Preview](https://ogpreview.app/guides/og-image-sizes/)). Twitter's summary_large_image will accept 1200x675 (16:9) for a slightly taller render. If forced to pick one size, 1200x630 renders acceptably on every major platform ([Chroma Creator](https://chromacreator.com/open-graph-preview)).

---

## 6. Social share cards: the cross-platform reality

An OG image that looks fine in a browser preview can fail in seven different ways across target channels. The launch-day test is to confirm the render on every channel the campaign touches before the campaign starts.

### 6.1 Platform behaviors

**Facebook / Meta**: Scrapes the page and caches for ~30 days. A shared URL reuses the cached image for 30 days unless explicitly re-scraped ([Woorkup](https://woorkup.com/facebook-open-graph-debugger-cache-clearing/); [Shareaholic helpdesk](https://support.shareaholic.com/hc/en-us/articles/360000263426-How-to-Clear-Link-Preview-Cache-Stored-by-Facebook-Pinterest-LinkedIn-Twitter)). Refresh tool: Sharing Debugger at [developers.facebook.com/tools/debug](https://developers.facebook.com/tools/debug/), "Scrape Again" button.

**LinkedIn**: Caches for **7 days**, explicitly documented ([Blue Gurus](https://www.bluegurus.com/how-to/fixing-linkedin-url-cache-for-status-updates-linkedin-post-inspector-tool/); [PreviewOG](https://previewog.com/fix-linkedin-preview/); [LinkedIn Help](https://www.linkedin.com/help/linkedin/answer/a6233775)). Refresh tool: [LinkedIn Post Inspector](https://www.linkedin.com/post-inspector/). LinkedIn will "continue serving the old, outdated preview for a full week unless you manually force a refresh" ([PreviewOG](https://previewog.com/fix-linkedin-preview/)). LinkedIn also recommends og:title under 150 characters and og:image 1200x627.

**X / Twitter**: Does not publish a cache TTL. The official Card Validator at cards-dev.twitter.com/validator was deprecated in 2022 when the platform rebranded ([devcommunity.x.com](https://devcommunity.x.com/t/card-validator-preview-removal/175006); [Onur Erginoglu](https://onurerginoglu.medium.com/how-to-validate-twitter-cards-after-x-removed-card-validator-ffcbbe65a409)). The current test is to paste the URL into the Tweet composer and see what renders. Third-party validators: [SocialRails](https://socialrails.com/free-tools/x-tools/card-validator), [OpenTweet](https://opentweet.io/tools/x-card-validator), [SocialPreviewHub](https://socialpreviewhub.com/twitter-card-validator).

**Slack**: Uses Open Graph, unfurls on paste with bot scope configured. The `chat:write` scope alone is insufficient for link unfurling in channels; you need `links:read` and `links:write` on a Slack app if you are implementing unfurl as a bot owner. For public URL sharing by humans, Slack scrapes OG directly.

**Discord**: Full-width embed, uses OG. Discord caches aggressively and a changed OG image may not update on re-share for hours.

**iMessage**: Uses OG, renders as a "rich link" card with image, title, description.

**Facebook Messenger / WhatsApp**: Uses OG, similar to iMessage.

### 6.2 Test-every-channel discipline

The failure mode is shipping a launch where the OG image renders correctly on Twitter but breaks on LinkedIn (wrong aspect), or renders on launch day on Twitter but LinkedIn shows a 7-day-old cached version from staging. The launch-day checklist: before any promotional URL goes out publicly, paste it into Facebook Sharing Debugger, LinkedIn Post Inspector, X Tweet composer (draft only), iMessage to yourself, Slack DM to yourself, Discord channel to yourself. If any render is broken, fix before sharing, because LinkedIn in particular will serve the broken version for a week.

### 6.3 OG image generation tools

- **@vercel/og**: Edge-runtime OG generation from HTML/CSS via Satori. 500KB vs Chromium+Puppeteer's 50MB, claimed 100x more lightweight. Adds Cache-Control headers automatically for edge caching. Current version 0.11.1 ([Vercel OG docs](https://vercel.com/docs/og-image-generation); [Vercel blog introduction](https://vercel.com/blog/introducing-vercel-og-image-generation-fast-dynamic-social-card-images); [npm @vercel/og](https://www.npmjs.com/package/@vercel/og)).
- **Cloudinary**: URL-based image transformation, can overlay text on a template image via URL parameters ([Cloudinary docs](https://cloudinary.com/documentation/social_media_image_templates); well documented in their product docs).
- **Bannerbear**: Template-based API for OG image generation, non-code authoring ([bannerbear.com](https://www.bannerbear.com/)).
- **Tailgraph**: Simpler API, Tailwind-themed templates ([tailgraph.com](https://www.tailgraph.com/)).
- **OG Image Studio**: Visual editor for OG templates.
- **OpenGraph.xyz / metatags.io**: Inspection tools, not generators.

### 6.4 The launch-week LinkedIn trap

The specific failure worth flagging: if the founder shares the URL to their LinkedIn network once at D-14 for "coming soon" with a placeholder OG, LinkedIn caches that for 7 days. They ship the real OG at D-7, launch on D-0, and their LinkedIn shares on launch day still render the placeholder. The fix: run LinkedIn Post Inspector on the URL at D-7 and again at D-1 to force re-cache.

---

## 7. Waitlist and pre-launch email

### 7.1 Tool landscape, April 2026

| Tool | Free tier | Positioning | Source |
|---|---|---|---|
| Kit (ConvertKit) | 10,000 subscribers, unlimited broadcasts, 1 basic automation | Creator-first; newsletters, paid subs, digital products | [Email Tool Tester](https://www.emailtooltester.com/en/reviews/convertkit/pricing/); [Kit Help](https://help.kit.com/en/collections/1446326-deliverability) |
| Loops | 1,000 contacts, event-driven automations | Developer-friendly API, event-driven, SaaS-native | [Encharge review](https://encharge.io/loops-review/); [Sequenzy](https://www.sequenzy.com/blog/best-email-tools-with-free-tier) |
| Resend (Broadcasts) | 3,000 emails/month, full API | Transactional-first with Broadcasts; developer ergonomics | [Sequenzy comparison](https://www.sequenzy.com/blog/best-email-tools-with-free-tier); [Fewer Tools comparison](https://fewertools.com/compare/convertkit-vs-resend.html) |
| Beehiiv | ~2,500 subscribers | Newsletter-native, monetization, referrals | [Sequenzy](https://www.sequenzy.com/blog/best-email-tools-with-free-tier) |
| Plunk | Free on self-host; paid hosted tier | OSS-adjacent, API-first | Plunk docs |
| EmailOctopus | 2,500 subscribers, 10,000 emails/month | Affordable mass-send | EmailOctopus pricing |
| Buttondown | 100 subscribers free | Minimal, writer-focused | buttondown.com |
| MailerLite | 1,000 subscribers, 12,000 emails/month | Broad small-business use | mailerlite.com |
| Mailchimp | 500 contacts | Legacy default; expensive at scale | mailchimp.com |
| Substack | Free, monetize via paid subs | Newsletter with social layer | substack.com |

For indie / solopreneur launches, the 2026 consensus from reviews is: Loops if the product is SaaS and event-driven email is the goal; Kit if it is a newsletter / creator audience; Resend if the team is already developer-heavy and wants one tool for transactional plus broadcasts; Beehiiv if the audience-building model is newsletter-first ([DevToolPicks](https://devtoolpicks.com/blog/posthog-vs-plausible-vs-fathom-vs-mixpanel-2026); [F3 Fund It](https://f3fundit.com/the-solopreneur-analytics-stack-2026-posthog-vs-plausible-vs-fathom-analytics-and-why-you-should-ditch-google-analytics/); [Sequenzy](https://www.sequenzy.com/blog/best-email-tools-with-free-tier)).

### 7.2 Waitlist-specific tools

GetWaitlist, Waitlister, LaunchList, Prefinery, KickoffLabs, Viral Loops: these sit on top of a transactional email provider and add waitlist primitives (referral positions, "skip the line," tiered access). GetWaitlist publishes benchmark data from its own customer base ([GetWaitlist](https://getwaitlist.com/blog/waitlist-benchmarks-conversion-rates)). Prefinery publishes compliance guidance on double-opt-in for waitlists ([Prefinery](https://help.prefinery.com/article/118-what-is-double-opt-in-and-why-you-need-it)).

### 7.3 GDPR, CAN-SPAM, CASL and double opt-in

The correct statement in 2026: **double opt-in is not required by law in most jurisdictions**, but is strongly preferred for deliverability. Specifically:

- **GDPR (EU)**: does not explicitly require double opt-in. Consent must be "unambiguous, affirmative, specific, informed, and freely given." Double opt-in is "considered best practice to obtain explicit and unambiguous consent" ([Securiti](https://securiti.ai/double-opt-in/); [iubenda](https://www.iubenda.com/en/help/22127-gdpr-double-opt-in)).
- **Germany and Austria**: case law treats double opt-in as effectively required; Austrian Data Protection Authority explicitly recommended double opt-in under GDPR Article 32 ([EmailToolTester](https://www.emailtooltester.com/en/blog/is-double-opt-in-required/); [Securiti](https://securiti.ai/double-opt-in/)).
- **CAN-SPAM (US)**: allows single opt-in or even opt-out ([GetResponse](https://www.getresponse.com/blog/email-marketing-laws-and-regulations)).
- **CASL (Canada)**: allows single opt-in with explicit consent.

The deliverability data supports double opt-in regardless of legal requirement. Double-opt-in subscribers show 35.72% average open rates vs 27.36% for single-opt-in; 4.19% click rate vs 2.36% ([EmailToolTester](https://www.emailtooltester.com/en/blog/is-double-opt-in-required/)). For a launch-day operator, the answer is: use double opt-in by default, both for compliance margin and for deliverability.

### 7.4 Waitlist conversion math

Published benchmarks range wide because the definition of "waitlist" varies. GetWaitlist's data:

- Cold-traffic free signups: 2-5% eventual paid conversion
- Warm-traffic free signups: 6-12%
- Consumer apps with clear value prop: 4-8%
- Deposit-based (paid $5 to join): 15-30%
- Best waitlist landing pages convert 25-85% of visits to signups; average is ~15%

Source: [GetWaitlist benchmarks](https://getwaitlist.com/blog/waitlist-benchmarks-conversion-rates). Similar ranges in [ScaleMath](https://scalemath.com/blog/what-is-a-good-waitlist-conversion-rate/).

Launch-day waitlist-to-customer conversion commonly cited at 5-10% on free lists, rising to 40%+ with strategic email automation ([Skillota blog](https://blog.skillotaproducts.com/email-automation-product-waitlists/)). Haveignition reports "around 40-50% of waitlisted users can be expected to actually sign up at launch" (anecdotal / heuristic; [Haveignition KPIs](https://www.haveignition.com/kpis-for-product-managers/kpis-for-product-managers-waitlist-conversion-rate)).

### 7.5 The paper-waitlist anti-pattern

The specific failure mode: founder puts up a "coming soon" page with a waitlist form, collects 500 emails, goes dark for six months while building, and by launch day the list is stale. Medium's Richie Crowley writes the polemic version: "Why Pre-Launch Startups Should Ditch Waitlists and What to Implement Instead" ([Medium](https://rickieticklez.medium.com/why-pre-launch-startups-should-ditch-waitlists-and-what-to-implement-instead-8b0d7cda1dd2)). His argument: waitlists "prioritize conversions over capturing intent" and produce vanity metrics without qualification data.

The concrete anti-pattern signals: (a) waitlist form on a coming-soon page with no email nurture sequence configured; (b) no cadence of at least monthly updates to the list; (c) no segmentation (who came from Twitter vs referral vs direct); (d) no plan for what the first email to the list on launch day actually says. Any one of those signals that the "waitlist" is a decoration, not a funnel.

The name for this pattern, to be adopted in section 13: **paper waitlist** (by analogy to deploy-ready's "paper canary"). A paper waitlist looks like a waitlist but has no follow-through plumbing attached.

---

## 8. Launch channels in 2026: what works now

### 8.1 Product Hunt

The platform still delivers traffic on a good day, but the 2025 algorithm change makes preparation non-negotiable. The documented behaviors:

- **12:01 AM PT launch moment**. Products drop at 12:01 AM PT daily; the 24-hour clock starts then. Missing that window loses the first-hour upvote weighting ([Awesome Directories](https://awesome-directories.com/blog/product-hunt-launch-guide-2025-algorithm-changes/); [Marc Lou](https://newsletter.marclou.com/p/how-to-launch-a-startup-on-product-hunt)).
- **First-hour upvotes weighted 4x later ones** ([Awesome Directories](https://awesome-directories.com/blog/product-hunt-launch-guide-2025-algorithm-changes/)).
- **Featured vs. not**: Only ~10% of submissions are Featured (the curated homepage). Un-Featured submissions are invisible on mobile ([Awesome Directories](https://awesome-directories.com/blog/product-hunt-launch-guide-2025-algorithm-changes/); [Flowjam](https://www.flowjam.com/blog/how-to-get-featured-on-product-hunt-2025-guide)).
- **Algorithm weights established accounts** over new accounts; coordinated voting is discounted or triggers un-Featuring ([Awesome Directories](https://awesome-directories.com/blog/product-hunt-launch-guide-2025-algorithm-changes/)).
- **Comments are weighted more than raw upvotes** ([Awesome Directories](https://awesome-directories.com/blog/product-hunt-launch-guide-2025-algorithm-changes/)).

Marc Lou's playbook (Product Hunt 2024 Maker of the Year) is the widely-cited indie reference:

> "Monday to Friday are busier, more traffic but more competition. Launch Sunday if targeting the badge; Monday for maximum traffic."

> "Animate your logo as a GIF, it's such an easy way to get attention."

> "Post the first comment explaining your solopreneur journey."

Source: [Marc Lou's newsletter](https://newsletter.marclou.com/p/how-to-launch-a-startup-on-product-hunt). His full approach: crystal-clear startup name, short emotional tagline, animated logo GIF, YouTube-thumbnail-style gallery images (one feature per image), first-comment story, Twitter launch announcement within four hours, pinned launch tweet, Product Hunt badge on the website cross-linked to launch page, cross-post to Indie Hackers, Reddit, Hacker News to drive badge clicks back to the PH page.

Ryan Hoover (Product Hunt founder) on hunters: "there is no discernible advantage to using a third-party hunter; makers should hunt their own products" ([Elite Dev Squad interview summary](https://blog.elitedevsquad.com/top-product-hunt-hunters-to-watch-in-2025/)). The old advice to "get Chris Messina to hunt you" is now less important than having your own audience ready on launch morning.

The counterpattern that works: Dub.co launched at exactly 12:01 AM PST, got 150 upvotes and 50 comments in the first hour, maintained #1 all day, finished with 1,085 upvotes and 210 comments. They had an email list of 25,000+ subscribers and secured Ben Lang as hunter. 62% of upvotes arrived within the first 90 minutes ([Flowjam](https://www.flowjam.com/blog/top-product-hunt-launches-2025-the-12-that-broke-the-internet)).

### 8.2 Hacker News

Show HN is the relevant category for a launch. The official rules:

> "Show HN is for something you've made that other people can play with. Blog posts, sign-up pages, newsletters, and similar content are not allowed. Landing pages, fundraisers, minor version updates are not allowed. The project should be non-trivial. Begin post titles with Show HN. Don't solicit upvotes from friends."

Source: [news.ycombinator.com/showhn.html](https://news.ycombinator.com/showhn.html). The "not allowed" clauses are the trap: a landing page with no product is specifically disqualified, even if polished.

Title patterns that work on Show HN: "Show HN: <Product Name>, <what it does>" with specific use-case, not "producty" framing. The Aidlab postmortem is the clearest example: "Our first Show HN failed because the title sounded too producty. The title ('Health Data for Devs') mattered more than I thought" ([Indie Hackers](https://www.indiehackers.com/post/front-page-of-hn-the-full-postmortem-traffic-lessons-surprises-cbe9e0a7f6)).

Timing: community consensus is 08:00-11:00 ET, Tuesday through Thursday. Posting on the weekend is risky because engineers who drive voting are offline ([Indie Hackers on Show HN tips](https://www.indiehackers.com/post/my-show-hn-reached-hacker-news-front-page-here-is-how-you-can-do-it-44c73fbdc6)). Copy rule: "On HN, using marketing or sales language is an instant turnoff; use factual, direct language; active voice; avoid phrases like 'app that offers' or other passive phrases" ([Indie Hackers](https://www.indiehackers.com/post/my-show-hn-reached-hacker-news-front-page-here-is-how-you-can-do-it-44c73fbdc6)).

The second-chance pool: HN moderators can re-surface posts that got buried due to timing. You can email hn@ycombinator.com; dang (the lead moderator) occasionally responds and will sometimes move a post to the second-chance pool if it is genuinely interesting ([HN item 22336638](https://news.ycombinator.com/item?id=22336638)).

Flagging: a post that is heavily flagged will disappear even if it has upvotes. The usual cause is perceived self-promotion, karma-farming, or low-substance landing pages. The cure is to post substantive first comment, respond to critical feedback directly, and not solicit upvotes.

HN traffic shape (from Aidlab postmortem): "a controlled explosion: massive 24h spike, gentle decline, long tail" ([Indie Hackers](https://www.indiehackers.com/post/front-page-of-hn-the-full-postmortem-traffic-lessons-surprises-cbe9e0a7f6)). Plan for the spike, but plan also for the tail.

### 8.3 Reddit

Reddit's official "9:1 rule" was retired but the underlying principle persists: be a genuine participant, not a promoter ([Reply Agent](https://www.replyagent.ai/blog/reddit-self-promotion-rules-naturally-mention-product); [Redship](https://redship.io/blog/reddit-self-promotion-rules-2026)). Moderators judge accounts on overall behavior, not a rigid percentage.

Subreddits that actively welcome launches:

- **r/SideProject**: explicitly for indie launches; promotion is the point ([Media Fast](https://www.mediafa.st/marketing-on-rsideproject))
- **r/IndieBiz**: similar, smaller
- **r/SaaS**: "Share Your SaaS" weekly threads
- **r/startups**: "Feedback Friday" weekly thread
- **r/entrepreneur**: weekly promotion threads
- **r/indiehackers**: active community
- **r/EntrepreneurRideAlong**: narrative-style progress posts

Each subreddit has its own rules; check the sidebar before posting. General-purpose subs (r/programming, r/webdev, r/SaaS outside the pinned thread) will flag or ban self-promotion that does not fit the format.

### 8.4 Twitter / X

Marc Lou and Pieter Levels are the two cited reference founders for Twitter launches. Levels' approach is "build in public," sharing revenue, process, failures openly. He started Nomad List as a crowdsourced Google Sheet tweeted to his followers; 100 people filled it in within 24 hours, validating demand before he built anything ([Software Growth](https://www.softwaregrowth.io/blog/how-pieter-levels-grew-nomad-list); [Nomadic Blueprint](https://nomadicblueprint.com/case-studies/pieter-levels)). His 2014 "12 startups in 12 months" challenge is the origin story cited in nearly every indie founder retrospective ([Levels.io](https://levels.io/tag/12-startups-in-12-months/)).

The launch-day thread shape (aggregated from Marc Lou's, Pieter Levels', and similar indie launches; [newsletter.marclou.com](https://newsletter.marclou.com/p/how-to-launch-a-startup-on-product-hunt)):

1. Hook tweet: "today I'm launching X." Video or GIF attached.
2. Thread continues: the problem, the motivation, the specific user.
3. Screenshots or demo video showing the product in use.
4. CTA: URL (ideally in a reply, to dodge the Twitter algorithm's downranking of links in the primary tweet), PH link if applicable.
5. Pin the thread.
6. Reply 4-8 hours later with a progress update: upvotes, signups, feedback.

The tactical move: post the URL in a reply, not the original tweet, to avoid algorithmic suppression.

### 8.5 LinkedIn

LinkedIn works differently. The founder-voice launch post is the format: personal, first-person, narrative, with the product introduction roughly two-thirds through the post. Arvid Kahl writes extensively about LinkedIn as a bootstrapper's channel ([The Bootstrapped Founder](https://thebootstrappedfounder.com/)). The format: hook (the problem you felt), context (the journey), the build (the product), the ask (try it, share, comment).

LinkedIn amplifies posts with comments more than any other signal. The launch-day tactic: reply to every comment in the first 90 minutes, which keeps the post in the feed.

### 8.6 Indie Hackers

Indie Hackers has two venues: the main feed (launch posts, milestone posts) and Milestones (structured celebration posts). Milestones have a template shape: "I hit $X MRR with Y." Launch posts are freeform but the successful ones are narrative: problem, build, launch results, numbers, lessons.

Indie Island's post-launch guide recommends days 1-2 activities (respond to comments, send thank-yous, update based on feedback, analyze traffic sources) and days 3-7 activities (reach out to reviewers personally, document lessons, write retrospective) ([Indie Island](https://indieis.land/blog/indie-hacker-showcase-guide)).

### 8.7 dev.to

dev.to favors tutorial-shaped posts, not "I launched X" announcements. The template that works: "How I built [launch product] with [tech stack], lessons learned." The launch is embedded in a genuinely useful post. Cross-posting via RSS to Hashnode or Medium is supported with canonical URL tagging ([dev.to comparison](https://dev.to/github20k/medium-vs-dev-vs-hashnode-vs-hackernoon-4ma1)).

### 8.8 Niche community channels

Discord servers (Indie Hackers Discord, SaaS Community, domain-specific), Circle communities, Slack communities (Demand Curve Slack, MegaMaker, PixelPulse, Tech Marketers), and Substack cross-promotions are all viable but require the same "give before you take" discipline as Reddit. A launch post into a Discord you joined yesterday will be treated as spam.

---

## 9. Press and influencer outreach

### 9.1 The 2026 press landscape

TechCrunch, previously the default press target for startup launches, is smaller than it was. TechCrunch itself documents tech layoffs at "at least 127,000 workers at U.S.-based tech companies" in 2025 ([TechCrunch 2025 layoffs](https://techcrunch.com/2025/12/22/tech-layoffs-2025-list/); [TechCrunch 2024 layoffs](https://techcrunch.com/2024/12/31/a-comprehensive-archive-of-2024-tech-layoffs/)) and the tech press has thinned along with it. The consequence for launches: general-interest tech press is a low-probability channel for indie founders, and niche newsletters are a higher-probability one.

### 9.2 Newsletters that matter for launches

- **Ben's Bites**: 120,000+ subscribers, founder-centric AI perspective, focused on product launches, tools, startup funding ([Growth in Reverse](https://growthinreverse.com/bens-bites/); [readless](https://www.readless.app/newsletters/best-ai-newsletters-2025))
- **TLDR AI**: 500,000+ subscribers, daily AI/ML/DS ([readless](https://www.readless.app/newsletters/best-ai-newsletters-2025))
- **The Neuron**: daily AI, competes with Ben's Bites and TLDR AI
- **Import AI** (Jack Clark): research-leaning AI newsletter
- **The Pragmatic Engineer** (Gergely Orosz): infrastructure, backend, engineering-leadership; higher bar for a launch pitch but high-signal audience

For infra, dev-tool, and AI-tooling launches these newsletters have meaningful reach into the decision-maker audience and respond to direct pitches. For consumer launches, they are the wrong channel.

### 9.3 Micro-influencer > big press for most indie launches

The consensus writing across Arvid Kahl, Pieter Levels, and indie founder retrospectives: for most indie launches, one micro-influencer with 10,000 engaged Twitter followers in the exact target market beats one line in a TechCrunch roundup. Micro-influencers convert because their audience already trusts them on the specific topic ([Arvid Kahl's Zero to Sold context](https://zerotosold.com/); [Levels.io](https://levels.io/)).

### 9.4 HARO / Connectively / Qwoted

HARO (Help A Reporter Out) was rebranded to Connectively and officially shut down on December 9, 2024 ([Qwoted](https://www.qwoted.com/connectively-haro-is-going-away-heres-how-qwoted-can-help/)). It was subsequently purchased by Featured.com and reopened under the HARO banner in April 2025 ([Prezly](https://www.prezly.com/academy/the-best-haro-alternatives)). Qwoted is the commonly cited alternative with verified experts and anonymous journalist requests ([Qwoted](https://www.qwoted.com/)). Help a B2B Writer (run by Superpath) is another option for B2B-specific pitches.

### 9.5 Press kit contents

The press kit belongs on /press or /media of the site. Standard contents from Shopify's guide and press-farm's template ([Shopify](https://www.shopify.com/blog/44447941-how-to-create-a-press-kit-that-gets-publicity-for-your-business); [press.farm](https://press.farm/press-kit-template/); [Prezly](https://www.prezly.com/academy/press-kit-101-what-to-include-to-get-earned-media-coverage)):

1. Company boilerplate (one paragraph, factual)
2. Founder bios with headshots (1080x1080 or square, high-res)
3. Product screenshots (1280x720 or 1920x1080)
4. Logo in SVG, PNG (full-color, monochrome, light variant, dark variant), and ideally favicon
5. Brand guidelines: colors, typography, logo clear-space rules
6. Mission statement / company facts sheet
7. Contact: founder direct email for press

### 9.6 Email pitch shape

The short-pitch template that works for micro-influencers and newsletter curators, derived from the common pattern in published outreach examples:

> Subject: [launch-date] [product]: [who it's for] solving [specific problem]

> Hi [name],
>
> I've been a reader of [their work/newsletter/channel] for [X months], especially loved your piece on [specific post].
>
> Tomorrow I'm launching [product] for [specific user]. It does [one-sentence what it does]. The reason I'm writing: [why this is relevant to their audience specifically].
>
> Press kit is at [URL/press]. Happy to send a demo loom, answer questions, or share an exclusive angle if useful.
>
> Thanks either way,
> [Founder name, short signature]

The key moves: specific reference to their work (shows you read them, not a mass email), specific user and problem (shows positioning), explicit "either way" (no pressure), short.

---

## 10. Launch-day telemetry

### 10.1 UTM discipline

UTM parameters are the operator's only reliable way to attribute traffic after the fact. Five parameters, three required, two optional ([Google Analytics help](https://support.google.com/analytics/answer/10917952?hl=en); [web.utm.io](https://web.utm.io/blog/utm-parameters-best-practices/)):

- `utm_source` (required): referrer name. "producthunt", "hackernews", "twitter", "linkedin", "reddit_sideproject"
- `utm_medium` (required): channel category. "social", "referral", "newsletter", "cpc"
- `utm_campaign` (required): campaign name. "launch_2026_04"
- `utm_content` (optional): creative variant. "hero_gif", "tweet_reply", "pinned"
- `utm_term` (optional): keyword, usually for paid search

Best practices aggregated from multiple guides:

- **Lowercase everything**: "Twitter" and "twitter" register as different sources.
- **Consistent naming**: pick "twitter" or "x" and never mix.
- **Never use UTMs on internal links**: each UTM-tagged internal click starts a new session in GA4, corrupting bounce rate, session count, and funnel metrics ([cometly](https://www.cometly.com/post/utm-parameters-best-practices-for-campaigns); [Improvado](https://improvado.io/blog/advanced-utm-tracking-best-practices)).
- **Maintain a UTM spreadsheet**: one row per link, one sheet per campaign. Prevents duplicate UTMs, acts as historical reference.
- **Test in incognito before the campaign**: confirm the UTM-tagged link populates GA4 correctly.

A launch with no UTMs on promotional links is what section 13 calls a **silent launch**: there is no way to learn which channel drove signups, so there is no way to double down on week 2.

### 10.2 Analytics choice for launch day

The 2026 consensus for indie launches is PostHog for product analytics plus Plausible or Fathom for privacy-respecting marketing-site analytics ([F3 Fund It](https://f3fundit.com/the-solopreneur-analytics-stack-2026-posthog-vs-plausible-vs-fathom-analytics-and-why-you-should-ditch-google-analytics/); [DevToolPicks](https://devtoolpicks.com/blog/posthog-vs-plausible-vs-fathom-vs-mixpanel-2026); [Amplitude comparison](https://amplitude.com/compare/best-google-analytics-alternatives)).

- **Plausible**: $9/month for 10K visitors; open source; cookieless ([Plausible](https://plausible.io/)).
- **Fathom**: $14/month for 100K page views; EU data isolation; polished UI ([Fathom](https://usefathom.com/)).
- **PostHog**: free up to 1M events and 5K session recordings; full product analytics suite, funnel tools, heatmaps, session replay ([PostHog](https://posthog.com/); [PostHog's own GA4 alternatives comparison](https://posthog.com/blog/ga4-alternatives)).
- **Umami**: open-source self-hosted; minimal.
- **Google Analytics 4**: only if running Google Ads that need native integration ([F3 Fund It](https://f3fundit.com/the-solopreneur-analytics-stack-2026-posthog-vs-plausible-vs-fathom-analytics-and-why-you-should-ditch-google-analytics/)).

Plausible and Fathom have explicit referrer dashboards optimized for launch-day usage; PostHog can do it but requires dashboard configuration.

### 10.3 Conversion waterfall

The launch-day conversion waterfall has six stages that should be instrumented before the campaign starts:

1. **Landing page view** (Plausible / Fathom / PostHog pageview)
2. **Signup start** (PostHog event: clicked "Get Started" or "Sign up")
3. **Signup complete** (PostHog event: account_created)
4. **Email verified** (PostHog event: email_verified; only if using email verification flow)
5. **First meaningful action** (PostHog event: the product-specific "aha" action, e.g. first project created, first message sent, first deploy triggered)
6. **Activation** (PostHog event: the threshold where the user has realized enough value to be a real user, product-specific)

The shape of this waterfall on launch day shows where the launch is leaking. The common failure mode is a healthy stage 1 (5,000 page views from Product Hunt) and an empty stage 5 (no one got to "first meaningful action"), which signals an onboarding problem, not a traffic problem.

This differs from in-app product telemetry (observe-ready's and production-ready's domain) in that launch-day telemetry emphasizes **source attribution** over in-product behavior. Which source drove the signup matters more on launch day than what the user did after.

### 10.4 Launch-day traffic spike handling

The architecture that survives the launch spike is static-first. A CDN-hosted static site with server-rendered (or pre-rendered) HTML for the hero page absorbs 10,000 concurrent requests without a backend ([Vercel on ISR and edge caching](https://vercel.com/docs/incremental-static-regeneration); [iDiallo](https://idiallo.com/blog/surviving-the-hug-of-death); [Stan.sh](https://stan.sh/2017/12/09/surviving-the-hacker-news-hug-of-death/)). Vercel's edge network "collapses concurrent requests to the same uncached path into one function invocation per region, protecting backend during traffic spikes" ([Vercel docs](https://vercel.com/docs)).

Concrete patterns:

- **Landing page static**: pre-render the hero, not a server-rendered React app.
- **CDN in front of everything**: Cloudflare, Vercel Edge, Fastly, Netlify Edge.
- **Waitlist form**: POST to a serverless function, not to the app's main database. Write to a queue or dedicated table that absorbs bursts.
- **OG image**: pre-generated or cache-headered aggressively. @vercel/og adds Cache-Control automatically.
- **Analytics**: client-side to Plausible/Fathom/PostHog. No launch-day traffic should hit your own analytics endpoint.

The antipattern: launching a server-rendered app with a Postgres connection pool of 20 when 10,000 visitors show up in 15 minutes. SadServers' postmortem is the textbook case ([DevOps.dev](https://blog.devops.dev/sadservers-and-the-hacker-news-hug-of-death-a-postmortem-af20ddc58526)).

---

## 11. Launch-week runbook: D-7 to D+7

The calendar below aggregates the patterns from Marc Lou's playbook, Arvid Kahl's writing, the Indie Hackers post-launch guide, and the Waitlister launch checklist ([Marc Lou](https://newsletter.marclou.com/p/how-to-launch-a-startup-on-product-hunt); [Waitlister](https://waitlister.me/growth-hub/guides/product-hunt-launch-checklist); [Indie Island](https://indieis.land/blog/indie-hacker-showcase-guide); [Postdigitalist](https://www.postdigitalist.xyz/blog/product-hunt-launch)).

### D-14 (two weeks before)

- Press kit live at /press (logo, screenshots, founder bio, boilerplate)
- Hunter confirmed for Product Hunt (your own account is fine per Ryan Hoover's guidance)
- Waitlist has been cleaned; bounces removed; unsubscribed addresses purged
- Coming-soon page has UTM-tagged referral tracking on
- Newsletter has posted at least one pre-launch update to the list ("launching in 2 weeks, here's what changed")

### D-7 (one week before)

- Final landing page copy review against the banned-word list (section 2.2)
- OG image rendered and tested on LinkedIn, Facebook, Slack, Discord, iMessage, X
- LinkedIn Post Inspector run on the URL to force cache refresh
- Facebook Sharing Debugger run to scrape OG fresh
- Status page live (Instatus, StatusGator, or equivalent)
- Launch calendar shared with whoever will co-promote (co-founders, team, early supporters)
- Pre-written responses drafted for predictable questions (pricing, comparison to X, security, deployment options)

### D-3 (72 hours before)

- Soft launch to the waitlist with the real URL
- First-party email to list: "launching in 3 days, here's what you'll see"
- Any final hero-copy adjustments based on what the list responded to
- Status page verified; uptime monitoring running on the launch URL
- Test the signup flow end-to-end from a fresh incognito session

### D-1 (day before)

- Team communication channel ready (Slack, Discord, group DM)
- All launch-day tweets, LinkedIn posts, Reddit posts drafted and scheduled or queued for manual post
- Product Hunt submission ready; scheduler or alarm set for 12:01 AM PT
- Show HN post drafted (if applicable); the specific title tested against the "sounds producty?" check
- One last run of LinkedIn Post Inspector
- Go to bed early

### D-0 (launch day)

- **12:01 AM PT**: Product Hunt post goes live. Post the first "maker comment" explaining the founding story.
- **First hour**: Tweet the launch thread, pin it. Post to LinkedIn. Post to relevant Reddit subs (spaced out, not all at once).
- **3 AM PT / ~7 AM ET**: Submit Show HN. Title factual, active voice, no marketing phrasing.
- **Post-HN submission**: Comment as the author in the Show HN thread explaining what the product does, why you built it, what you want feedback on.
- **Throughout the day**: Respond to every comment on Product Hunt, HN, LinkedIn, Reddit, Twitter. First 90 minutes is the algorithmic multiplier window on most platforms.
- **End of day**: Thank-you email to the waitlist with real results from the day ("we hit #3 on PH, 1,200 signups, here's what surprised us"). Pin PH badge to the site.

### D+1 to D+3 (immediate aftermath)

- Thank-you emails to anyone who upvoted, commented, shared publicly
- Nurture sequence begins for everyone who signed up (day 1: welcome + what to do next, day 3: here's what we learned from the launch)
- Onboarding friction audit: where did signups drop in the conversion waterfall? Fix the biggest leak.
- Respond to any late Show HN comments (HN traffic persists for 48-72 hours)

### D+4 to D+7 (transition week)

- Metrics postmortem: cite section 10's waterfall. What is the channel breakdown of activations? Which source brought the users who stuck?
- Write the public retrospective: Indie Hackers post, blog post, Twitter thread with numbers.
- Identify the highest-intent 10% of launch signups (users who completed activation). Do 1:1 outreach: "can I get on a 15-min call?"
- Archive the launch calendar. The operator is no longer in launch mode; they are in operations mode.

---

## 12. Post-launch transition

The first-week trap is well documented in the Indie Island "Post-Launch Trough" guide ([Indie Island](https://indieis.land/blog/indie-hacker-showcase-guide)): operators keep posting launch content (more Reddit posts, more Twitter threads, more "here's what I learned" posts) after attention has faded and either annoy their audience or, worse, send the signal that the launch is all they have. The transition is not subtle: launch mode ends when the launch-day attention curve does (typically 48-72 hours after peak traffic).

Which metrics matter in week 2 vs week 1:

- **Week 1**: source attribution, total signups, total traffic, upvote counts, press pickups.
- **Week 2**: activation rate (signups who completed the first meaningful action), D7 retention (signups who came back a week later), organic referrals (users who invited a friend), support-ticket volume and top categories.

The week-2 metrics are what observe-ready and production-ready are built to surface continuously. Launch-ready's job is to hand off: the referral dashboard you built for launch day becomes the first week's snapshot; the conversion waterfall becomes the starting point for ongoing activation tracking.

### 12.1 Mining the high-intent 10%

Arvid Kahl's "Zero to Sold" frames the post-launch move as a qualification exercise ([zerotosold.com](https://zerotosold.com/); [The Bootstrapped Founder](https://thebootstrappedfounder.com/)). The highest-intent 10% of signups are the ones who activated within 48 hours of launch. These users self-selected through the noise; they are the ones whose feedback is most predictive of product-market fit. The 1:1 outreach move, standard across Kahl, Levels, and Marc Lou: email or DM each of them, offer a 15-minute call, ask what they were trying to do and whether the product did it. Their answers drive week-3 product decisions.

Kahl self-published Zero to Sold on June 29, 2020 and sold 350 copies in 24 hours by sharing with his Twitter audience ([bootstrappedfounder.gumroad.com](https://bootstrappedfounder.gumroad.com/l/zerotosold)). The launch was a data-collection exercise for what followed.

### 12.2 The handoff to ongoing product marketing

launch-ready does not own the month-2 strategy. What happens after week 1 (SEO content strategy, topical authority, partnerships, conference talks, sponsorship deals, long-term community building) is a permanent function, not a sprint. This document explicitly stops at D+7. The deliverable from the launch-ready skill is a retrospective (what worked, what did not, what the 10% told us) and a handoff artifact that says: these are your best acquisition channels based on one week of real data, go build them.

---

## 13. Named failure modes for the launch-ready skill

The ready-suite convention is to name the specific patterns the skill refuses. deploy-ready refuses the "paper canary" (a canary deploy that is not wired to rollback), observe-ready refuses the "paper SLO" (numbers with no error-budget policy), "blind dashboard" (chart bound to no SLO), and "paper runbook" (written once, never executed). launch-ready should follow the same shape.

From the evidence in sections 1-12, the five sharpest failure modes for launch-ready to refuse:

### 13.1 AI-slop landing

**The pattern**: A landing page that looks like every other v0 / Lovable / Cursor-generated output: gradient hero (purple/teal/Linear-dark), shadcn Card grid, six feature tiles using words from the banned-word list (empower, seamless, revolutionary, effortless, intelligent, powerful), pricing table, default Inter font, "Get Started" CTA with no object. Zero differentiation from the 10,000 other AI-generated MVPs shipping the same week.

**Why the name**: "AI slop" is already the widely-used term in the AI-content discourse for statistically-average AI output. The name transfers directly. Covered in section 2 with citations to AXE-WEB, Conversion Haus, Overpass, and the consensus banned-word literature.

**Refusal criterion**: the landing page must pass the Harry Dry falsifiability test (every claim must be something a competitor could not truthfully say) and must not rely on any word from the banned list (section 2.2) in the hero or feature headlines.

### 13.2 Hero-fatigue copy

**The pattern**: The hero section occupies the most valuable real estate on the page and tells the visitor nothing specific. "Revolutionize your workflow," "Empower your team," "Seamless integration," "Intelligent automation." The visitor reads the H1, understands nothing concrete about what the product does for whom, and bounces. Narrower than AI-slop landing (the visual design can be clean and the copy still fatigue-grade).

**Why the name**: "hero-fatigue" names the specific phenomenon (hero section that induces reader fatigue, where the reader checks out before the scroll). Consistent with "paper canary" and "paper SLO" in its verbal punch.

**Refusal criterion**: the H1 must pass the "stranger test" (a stranger reading the H1 can describe what the product does to someone else), the "who is this for test" (the H1 names the user the way they would name themselves), and the "what does it replace test" (April Dunford's competitive-alternatives frame).

### 13.3 Paper waitlist

**The pattern**: A waitlist form on a coming-soon page with no nurture sequence configured, no monthly cadence, no segmentation, and no plan for what the launch-day email to the list actually says. The waitlist collects 500 emails, goes silent for six months, and on launch day produces roughly zero customers because the list is stale.

**Why the name**: direct analog to deploy-ready's "paper canary." A paper waitlist looks like a waitlist (form, input field, "we'll email you") but the plumbing behind it does not exist. Covered in section 7.5 with citations to Richie Crowley's Medium polemic and the waitlist-benchmark data.

**Refusal criterion**: the waitlist must have, by definition, a configured double-opt-in confirmation, a scheduled drip of at least one monthly update, segmentation by acquisition source (UTM-tagged at signup), and a pre-written launch-day email.

### 13.4 Unrendered OG

**The pattern**: The OG image renders correctly in the developer's local preview and fails in one or more of the target channels (LinkedIn shows yesterday's placeholder, Facebook caches a 404, Twitter renders the wrong aspect, Slack unfurls the text but not the image). The launch goes out and the first 500 shares each display a broken preview, which LinkedIn then caches for 7 days.

**Why the name**: short, concrete, and names the specific sin (the image is "rendered" only in the dev environment, not in the channels it will actually be seen in).

**Refusal criterion**: the launch cannot proceed until the OG image has been verified with a real share test in at least: Facebook Sharing Debugger, LinkedIn Post Inspector, X Tweet composer, Slack DM, Discord, iMessage. LinkedIn Post Inspector specifically must be re-run within 24 hours of launch to force cache refresh. Covered in section 6.

### 13.5 Silent launch

**The pattern**: A launch that goes out with no UTM parameters on promotional links, no analytics configured, no conversion waterfall instrumented. The operator watches a counter tick up on Product Hunt but has no idea which channel brought the users who actually converted, so there is no signal for week-2 double-down.

**Why the name**: "silent" because the operator has no voice from the data. Parallel to observe-ready's emphasis on observability as a first-class concern.

**Refusal criterion**: every promotional URL in the launch calendar has a utm_source, utm_medium, utm_campaign. The landing page has at least one page-view analytics tool (Plausible / Fathom / PostHog) configured and firing. The conversion waterfall (page view, signup start, signup complete, first meaningful action) is instrumented before D-0.

### 13.6 Honorable mentions (not adopted)

- **"Launch without landing"**: a campaign that goes live before the landing page is built. Rare in practice; mostly a scheduling failure.
- **"Spec-sheet positioning"**: a feature list with no differentiator. Real pattern but adequately covered by "hero-fatigue copy" + "AI-slop landing" together. Dropping to avoid name proliferation.
- **"Zombie launch"**: a relaunch on Product Hunt within 6 months of a previous launch, where the algorithm discounts the new one. Real, narrow, tactical rather than strategic.

The final five (AI-slop landing, hero-fatigue copy, paper waitlist, unrendered OG, silent launch) cover the distinct axes of launch failure (positioning, copy, list, distribution surface, telemetry) without overlap, and mirror the ready-suite pattern of naming the specific sin the skill refuses.

---

## 14. Tooling landscape

A complete enumeration of the tools a 2026 launch-ready operator touches. Sources throughout, gaps flagged.

### 14.1 Static site and landing page frameworks

- **Next.js** ([nextjs.org](https://nextjs.org/)): React-first, Vercel-hosted, ISR and edge caching by default
- **Astro** ([astro.build](https://astro.build/)): content-first, islands architecture, zero JS by default
- **Framer** ([framer.com](https://framer.com/)): visual design tool with publish-to-CDN
- **Webflow** ([webflow.com](https://webflow.com/)): visual CMS, enterprise-capable, relatively heavy
- **Carrd** ([carrd.co](https://carrd.co/)): one-page landing pages, cheapest and simplest, used heavily by Pieter Levels' side projects
- **Tailwind UI / Tailwind Landing** ([tailwindcss.com/plus](https://tailwindcss.com/plus)): component library; the source of many AI-slop landing aesthetics when used uncritically
- **Plasmic** ([plasmic.app](https://plasmic.app/)): visual builder on top of React/Next
- **shadcn/ui** ([ui.shadcn.com](https://ui.shadcn.com/)): component registry; explicitly a source of the aesthetic convergence in section 2

### 14.2 OG image generation

- **@vercel/og** ([vercel.com/docs/og-image-generation](https://vercel.com/docs/og-image-generation)): edge-runtime, HTML/CSS-based, 500KB
- **Tailgraph** ([tailgraph.com](https://www.tailgraph.com/)): simple API, Tailwind-themed
- **Bannerbear** ([bannerbear.com](https://www.bannerbear.com/)): template-based API
- **OG Image Studio**: visual template editor
- **Cloudinary** ([cloudinary.com](https://cloudinary.com/)): URL-based image transformation, strong for templated OG

### 14.3 Waitlist and email

Covered in section 7.1 table. Kit, Loops, Resend, Beehiiv, Plunk, EmailOctopus, Buttondown, MailerLite, Mailchimp, Substack.

Waitlist-specific on top: GetWaitlist, Waitlister, LaunchList, Prefinery, KickoffLabs, Viral Loops.

### 14.4 Analytics

Covered in section 10.2. PostHog, Plausible, Fathom, Umami, GA4.

### 14.5 Product Hunt tools

- **PHTools / Dang.ai** ([dang.ai](https://www.dang.ai/)): Product Hunt launch tracking, maker tools
- **Ship by Product Hunt** ([producthunt.com/ship](https://www.producthunt.com/ship)): coming-soon pages native to PH, collects followers for launch-day notification

### 14.6 Status page

- **Instatus** ([instatus.com](https://instatus.com/)): indie-friendly, fast
- **StatusGator** ([statusgator.com](https://statusgator.com/)): monitors your dependencies' status pages
- **Statuspage by Atlassian** ([statuspage.io](https://statuspage.io/)): enterprise incumbent

### 14.7 Outreach and press

- **Qwoted** ([qwoted.com](https://www.qwoted.com/)): journalist pitching, verified experts
- **HARO (reopened April 2025)** / **Connectively**: journalist requests
- **Help a B2B Writer** ([helpab2bwriter.com](https://helpab2bwriter.com/)): Superpath-run, B2B-specific
- **Featured** ([featured.com](https://featured.com/)): now owns HARO
- **BuzzSumo** ([buzzsumo.com](https://buzzsumo.com/)): content and influencer discovery
- **Podcast Guest** / **PodMatch** ([podmatch.com](https://podmatch.com/)): podcast-pitch matchmaking

### 14.8 Show HN scheduling

There is no legitimate scheduling tool. HN does not support scheduled posts and explicitly discourages automation. The "tool" is a calendar reminder for 3 AM PT / 7 AM ET and a human finger on the submit button. Any service claiming to schedule Show HN posts is either lying or breaking HN's rules in a way that gets the account banned.

---

## 15. Summary of claim density and source reliability

This research pass cited approximately 75 distinct URLs across primary sources (Google Search Central, Vercel docs, schema.org, news.ycombinator.com, developers.facebook.com, LinkedIn help), founder blogs (Marc Lou, Julian Shapiro, April Dunford, Arvid Kahl, Pieter Levels via levels.io), benchmark publishers (Unbounce, GetWaitlist), and editorial coverage (Indie Hackers postmortems, Hacker News discussions, Medium deep-dives).

Categories of claim reliability:

- **Primary-source hard claims**: Google CWV thresholds, FB/LinkedIn cache TTLs, schema.org required fields, PH algorithm behavior (as published by PH-adjacent teardowns), Show HN guidelines (verbatim from HN), Kit/Loops/Resend free tiers (from vendor docs and reviews).
- **Benchmark claims**: Unbounce conversion data (internally consistent across their reports), Aidlab and Raport postmortem numbers (self-reported by founders), waitlist conversion ranges (GetWaitlist customer data).
- **Anecdotal / heuristic, flagged as such**: 40-50% waitlist-to-signup conversion (Haveignition), specific founder launch numbers cited second-hand.
- **Synthesized**: the five named failure modes in section 13 are proposed by this research pass, grounded in the cited evidence but not a pre-existing term in any one source.

The gaps in this research pass:

- Product Hunt's internal algorithm is proprietary; all claims about weighting are from teardowns, not Product Hunt's own documentation.
- X/Twitter's card validator deprecation is documented, but the current-state cache behavior is less well-documented than LinkedIn's.
- Slack unfurl bot-scope details were not fully verified for this report; operators should verify against Slack API docs at build time.
- The specific conversion gap between AI-slop landing pages and hand-crafted landing pages is not directly quantified in any single published source; the 514% copy-complexity gap from Unbounce is the closest proxy.

For the launch-ready skill, this report is sufficient to ground the skill's definitions, refusal patterns, and recommended tooling. The five named failure modes in section 13 (AI-slop landing, hero-fatigue copy, paper waitlist, unrendered OG, silent launch) are ready to become the explicit anti-patterns the skill enforces.

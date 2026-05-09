# prd-ready research pass (April 2026)

Research pass to inform the design of `prd-ready`, the planning-tier ready-suite skill that owns "define what we're building and for whom" before architecture, stack, or build. Current date: 2026-04-23. Every claim is sourced inline.

## 1. AI-generated PRD failure modes

AI-generated PRDs fail in a surprisingly narrow band of predictable ways. The failures are consistent across tools (ChatGPT, Gemini, Claude, ChatPRD, Miro AI), across domains, and across experience levels of the PM driving the prompt. They cluster into ten discrete modes.

### 1.1 The "invisible" PRD (generic, could apply to any product)

The most cited failure. Tom Leung tested ChatGPT, Gemini, Claude, ChatPRD, and Notion AI against each other and found ChatGPT's output "deeply uninspiring" and "like an average of everything out there." He says, "I was reading something that could have been written for literally any product in any company," and that when asked to describe the target user, "it used phrases that could apply to any edtech product. When it outlined success metrics, they were the obvious ones (engagement, retention, test scores) without any interesting thinking" ([Fireside PM](https://firesidepm.substack.com/p/i-tested-5-ai-tools-to-write-a-prdheres)). Product-Led Alliance frames the same failure as a context problem: "flat, vaguely corporate output that says nothing while sounding like something is the hallmark of unedited AI output" ([Product-Led Alliance, AI slop is a context problem](https://www.productledalliance.com/ai-slop-is-a-context-problem/)).

**Why it matters:** "The problem with generic output isn't that it's wrong, it's that it's invisible. When trying to get buy-in from leadership or alignment from engineering, you need your PRD to feel specific, considered, and connected to your company's actual strategy" ([Fireside PM](https://firesidepm.substack.com/p/i-tested-5-ai-tools-to-write-a-prdheres)).

### 1.2 Feature laundry list (no priority, no cuts)

Common to both human and AI-written PRDs. "A 'feature laundry list' refers to adding too many features, which obscures a product's main value, confuses users, and increases development costs" ([ProductPlan glossary](https://www.productplan.com/glossary/product-requirements-document)). MoSCoW-style prioritization is the standard prescribed remedy, but absence of it is the default AI behavior ([ProductPlan](https://www.productplan.com/glossary/product-requirements-document)). GainMomentum frames it bluntly: "Most product requirements document templates are fundamentally broken, designed to create bloated, static documents that get bogged down in the 'what' (features and specs)" ([GainMomentum](https://gainmomentum.ai/blog/product-requirements-document-template)).

### 1.3 Missing out-of-scope / non-goals section

"Explicit out-of-scope definitions prevent scope creep, the single most destructive force in product development. If it's not in the PRD's 'not building' section, someone will assume it's in scope" ([prodmgmt.world PRD template guide](https://www.prodmgmt.world/blog/prd-template-guide)). The same source notes: "The second most common element across elite templates is a 'Non-Goals' or 'No Gos' section. Kevin Yien's template (from Square) and Basecamp's Shape Up Pitch both emphasize defining boundaries as much as requirements." AI-generated PRDs routinely omit this section entirely, or fill it with throwaway text like "not in scope for V1."

### 1.4 Assumption soup ("we assume users will love it")

AI PRDs treat user validation as an artifact to declare rather than to gather. Plane Blog names this directly: engineers reject PRDs that "jump straight into requirements without explaining the underlying problem" ([Plane](https://plane.so/blog/how-to-write-a-prd-that-engineers-actually-read)). Aakash Gupta's modern PRD guide names the failure "superficial completion": "All sections present but with vacuous content (tautologies like 'ensuring alignment with legal standards')" ([Aakash Gupta, Modern PRD Guide](https://www.news.aakashg.com/p/product-requirements-documents-prds)). His third failure pattern is "missing evidence: lacks customer data, competitive research, and analytics specificity, reducing persuasiveness and strategic grounding."

### 1.5 Engineers refuse to estimate

Named clearly by Figr Design: "A vague Product Requirements Document is a tax on your team's time and focus. Every question an engineer has to ask you after kickoff is a sign of a gap in the PRD. Each one of those gaps is a tax paid in developer time, lost momentum, and team morale" ([Figr Design](https://figr.design/blog/how-to-write-a-prd)). Developex: "Accurate estimates require clear requirements. Vague input leads to unreliable planning, budget issues, and strained trust" ([Developex](https://developex.com/blog/what-is-a-product-requirements-document/)). Plane Blog: "A PRD that says 'the system should be fast' or 'the user should have a good experience' isn't giving engineers anything to work with. Vague requirements create ambiguity. Ambiguity creates meetings" ([Plane](https://plane.so/blog/how-to-write-a-prd-that-engineers-actually-read)).

Most PRDs that cross the engineer-estimation threshold fail on five specific gaps, per Plane: problem statement missing, ambiguous scope, vague language ("simple," "intuitive," "fast"), missing success metrics, and stale documentation ([Plane](https://plane.so/blog/how-to-write-a-prd-that-engineers-actually-read)).

### 1.6 Moving-target / weekly-whiplash PRD

The PRD gets edited continually downstream, silently, without communication. Ben Horowitz, 1998: "Bad product managers don't have time to update their PRD. Bad product managers update the PRD and don't tell anyone, or don't tell enough people, or don't explain why" ([Horowitz, Good PM / Bad PM](https://sriramk.com/memos/Ben_Horowitz_Good_Product_Manager_Bad_Product_Manager.pdf)). Requirements volatility is framed as the unsolvable core of software engineering; Stack Overflow cites it as the primary source of project failure ([Stack Overflow blog: Requirements volatility](https://stackoverflow.blog/2020/02/20/requirements-volatility-is-the-core-problem-of-software-engineering/)). The failure compounds when AI is used to regenerate sections on demand: small regenerations create inconsistencies with sections the team already agreed on, and the team discovers this only when building.

### 1.7 Solution-in-search-of-a-problem

A PRD that leads with the feature rather than the problem. Carlin Yuen: "'User can't use <my solution>' is not a problem statement" ([Carlin Yuen, Writing PRDs](https://carlinyuen.medium.com/writing-prds-and-product-requirements-2effdb9c6def)). Intercom's product-principles series formalizes the counter: "Start with the problem to achieve better solutions" ([Intercom Blog](https://www.intercom.com/blog/intercom-product-principles-start-with-the-problem/)). Every Reforge/Lenny-style template now separates problem and solution sections, and Intercom's template explicitly states "Do not add the solution here" in the problem box ([prodmgmt.world PRD template guide](https://www.prodmgmt.world/blog/prd-template-guide)).

### 1.8 Over-specification / implementation bleed

The PRD starts prescribing HOW instead of WHAT. Chris Warren, engineering leader: "When the PRD starts describing the specific and detailed functionality and behavior of the product features that's a sign that it's getting into the realm of the Product Spec" ([Chris Warren on PRDs](https://medium.com/@csw11235/product-requirements-documents-prds-a-perspective-from-an-engineering-leader-6cc52404c9a5)). Product managers who prescribe implementation "limit engineering creativity, while vague technical specs lead to inconsistent implementation, missed edge cases, and rework during development" ([Productboard](https://www.productboard.com/glossary/product-requirements-document/)).

### 1.9 Template bloat ("somewhat good for many, really good for no one")

Aakash Gupta, former VP of Product at Apollo.io: "The average PRD template has become too long, and instead of being optimized for a few people (like design and engineering), the PRD has become something that's somewhat good for many people" ([Ditch the PRD template, embrace the PRD checklist](https://www.mindtheproduct.com/ditch-the-prd-template-and-embrace-the-prd-checklist/)). Templates accrete sections as each department adds requirements: "each team slightly tweaks the template. Most? They add a few requirements and sections." The result: PMs shoulder the entire specification load, overworked, and features ship undocumented.

### 1.10 Stale / untrusted document

"Decisions change in meetings but not in documents. Engineers stop trusting PRDs that don't reflect current reality" ([Plane Blog](https://plane.so/blog/how-to-write-a-prd-that-engineers-actually-read)). Once an engineer has found one stale claim, every other claim in the document becomes suspect. This is the worst outcome because it makes the PRD actively harmful: the team reverts to hallway conversations and Slack threads, and the document becomes theater.

### 1.11 Visual / design-mockup AI slop

When the PRD includes AI-generated wireframes, "they looked more like stock photos than actual product designs" with an obvious "AI-generated sheen," lacking authentic design thinking ([Fireside PM](https://firesidepm.substack.com/p/i-tested-5-ai-tools-to-write-a-prdheres)). This is a specific sub-failure of 1.1 but worth separating because it's visually obvious and kills credibility fastest.

### Summary: the 10 harvested failure modes

| # | Failure mode | Core symptom |
|---|---|---|
| 1 | Invisible PRD | Reads the same across any product |
| 2 | Feature laundry list | No priority, no cuts |
| 3 | Missing non-goals | Scope creep baked in |
| 4 | Assumption soup | User validation declared, not gathered |
| 5 | Non-estimable | Vague language, no acceptance criteria |
| 6 | Moving target | Silent edits, engineer whiplash |
| 7 | Solution-first | Leads with feature, not problem |
| 8 | Over-specification | Prescribes HOW, belongs in spec |
| 9 | Template bloat | Good-for-many, great-for-no-one |
| 10 | Stale / untrusted | One wrong line kills the whole doc |

## 2. Named failure-mode terms

Survey of which names are taken vs. open.

| Term | Usage level in the wild | Adoptable as skill vocabulary? | Evidence |
|---|---|---|---|
| "theater PRD" | **Open.** "Theater" exists as a critique in "security theater" and "agile theater" but not attached to PRDs. | Yes. Coinable. Highly evocative. | Google search returns no PRD-specific usage ([search results](https://www.google.com/search?q=%22theater+PRD%22)) |
| "feature laundry list" | **Lightly used.** Appears in PRD glossaries as a warning ([ProductPlan](https://www.productplan.com/glossary/product-requirements-document)). Not owned. | Yes. Use verbatim, reference ProductPlan. | "A 'feature laundry list' refers to adding too many features, which obscures a product's main value" |
| "moving target PRD" | **Lightly used.** "Moving target problem" is common in software engineering more broadly. Not bound to PRDs specifically. | Yes. Attach to PRD context. | "Finishing a project when someone keeps moving the finish line becomes an impossible task" ([ProjectManagement.com](https://www.projectmanagement.com/articles/321465/hitting-a-moving-target)) |
| "solution-in-search-of-a-problem PRD" | **Lightly used** as a general product anti-pattern. Rarely attached to the PRD artifact specifically. | Yes. Adopt; pair with Intercom's "start with the problem" principle. | [Intercom Product Principles](https://www.intercom.com/blog/intercom-product-principles-start-with-the-problem/) |
| "quill-and-inkwell PRD" | **Open.** Zero usage. Vivid, possibly too cute. | Reserve as rhetorical flourish, not a primary term. | No search hits. |
| "hollow PRD" | **Open** in PRD context. "Hollow" is already the load-bearing term for `production-ready`'s contract (hollow dashboards). Using it for PRDs creates suite consistency. | **Yes, strongly recommended.** Ties to suite vocabulary. | `production-ready` SKILL.md uses "hollow-check protocol"; reusing across the suite builds a consistent mental model. |
| "invisible PRD" | **Lightly used.** Tom Leung uses the word "invisible" to describe AI-generic PRDs ([Fireside PM](https://firesidepm.substack.com/p/i-tested-5-ai-tools-to-write-a-prdheres)). Not a formal term. | Yes. Adopt with attribution. Crisp. | "The problem with generic output isn't that it's wrong, it's that it's invisible." |
| "AI slop PRD" | **Emerging.** "AI slop" is now broadly adopted (2024-2026). Applied to PRDs by Product-Led Alliance, Fireside PM. | Yes. Useful for the Reddit/HN register. | [Product-Led Alliance](https://www.productledalliance.com/ai-slop-is-a-context-problem/) |
| "assumption soup PRD" | **Open.** No formal usage. | Yes. Coinable. Evocative. | Not attested, but supports failure mode 1.4. |
| "theater-of-completion PRD" | **Open.** Variant of "theater PRD." | Reserve. Slightly verbose. | No usage. |
| "superficial completion" PRD | **Lightly used.** Aakash Gupta's phrase ([Aakash Gupta Modern PRD Guide](https://www.news.aakashg.com/p/product-requirements-documents-prds)). | Yes. Attribute. | "All sections present but with vacuous content." |

### Coinage recommendations for prd-ready

Adopt these six terms as load-bearing vocabulary in the skill:

1. **"Hollow PRD"** -- primary term for a PRD that has sections but no decisions. Ties to `production-ready`'s "hollow dashboard" concept and creates a suite-wide pattern.
2. **"Invisible PRD"** -- secondary term for generic, could-be-anything output. Attribute to Tom Leung / Fireside PM.
3. **"Feature laundry list"** -- for missing-priority PRDs. Already in the wild; use verbatim.
4. **"Moving-target PRD"** -- for silent-edit whiplash.
5. **"Solution-first PRD"** (or "solution-in-search-of-a-problem") -- for PRDs that lead with the feature. Pair with Intercom's "problem-first" principle.
6. **"Assumption-soup PRD"** -- for user-validation-as-declaration. Coinage lane is open.

Reserve as rhetorical flourishes but not primary terms: "theater PRD," "quill-and-inkwell PRD." Both are usable once per skill, not more.

## 3. Canonical PRD literature

Each entry: what it is, what it contributes uniquely, and what `prd-ready` should borrow.

### Marty Cagan, Inspired / Silicon Valley Product Group

Cagan wrote a widely circulated 37-page "How to Write a PRD" that was the industry guide for an era ([SVPG](https://www.svpg.com/)). His views have since evolved. In 2019, he wrote: "I no longer advocate using a PRD... because it's easy for product managers to spend too much time working on them and not enough on the actual product." His current position: "PRDs are not inherently bad. If the product team does the necessary product discovery work to figure out a solution worth building, and then they add the step of documenting the details of what needs to be built so as to better communicate with remote engineers, that's fine. The problem is that in nearly every case, the PRD is written instead of the product discovery work, rather than after" ([SVPG, Discovery vs. Documentation](https://www.svpg.com/discovery-vs-documentation/); [SVPG, Revisiting the Product Spec](https://www.svpg.com/revisiting-the-product-spec/)).

**What Cagan uniquely contributes:** the discovery-before-documentation discipline. A PRD is only valuable if it follows discovery; written from a blank page as a substitute for discovery, it is theater. `prd-ready` should gate on: has any discovery happened, or is the PRD the entire investigation?

### Ben Horowitz, "Good Product Manager, Bad Product Manager" (1998)

Horowitz (with David Weiden) wrote what is still the most quoted essay on PRD discipline. "The PRD is the single most important document the product manager maintains and in most cases should be the definitive source of direction from marketing to engineering" ([Horowitz / Weiden memo](https://sriramk.com/memos/Ben_Horowitz_Good_Product_Manager_Bad_Product_Manager.pdf)). Good PMs "keep PRDs up-to-date daily or weekly at a minimum" and view the PRD as a living ongoing process. Bad PMs "don't have time to update their PRD... update the PRD and don't tell anyone... write a PRD and assume engineering understands it."

**What Horowitz uniquely contributes:** the communication-discipline dimension. A PRD is only as good as the downstream broadcast of its changes. `prd-ready` should treat changelogging and delta-broadcast as a first-class feature, not a footnote.

### Lenny Rachitsky, lennysnewsletter PRD templates

Lenny publishes a 1-Pager template (free on Notion) and a PRD template (via Atlassian Confluence) that are the most referenced modern versions ([Lenny's PRD template on Confluence](https://www.atlassian.com/software/confluence/templates/lennys-product-requirements); [Lenny 1-Pager on Notion](https://www.notion.com/templates/product-1-pager-template)). His 1-Pager "separates problem understanding from solution design." Lenny has said: "Nailing the problem statement is the single most important step in solving any problem. It's deceptively easy to get wrong, and when done well it's a superpower of the best leaders" ([via Sprig collection](https://sprig.com/collection/ask-critiquing-questions)). His newsletter hosts the most-shared "Examples and templates of 1-Pagers and PRDs" essay, though paywalled ([Lenny's Newsletter](https://www.lennysnewsletter.com/p/prds-1-pagers-examples)).

**What Lenny uniquely contributes:** the modern one-pager standard. A PRD fits on one page first, expands second. `prd-ready` should have a one-pager mode that is the default, with expansion triggered by the project's actual complexity.

### Intercom, "Product Principles" series

Intercom's blog series "Intercom on Product" operationalizes Jobs-to-be-Done as the frame for product requirements ([Intercom Product Principles, index](https://www.intercom.com/blog/tag/product-principles/)). Four-post arc: "Start with the problem," "Shape the solution to maximize customer value," "Build in small steps," "Back to the basics" ([Intercom Blog](https://www.intercom.com/blog/intercom-product-principles-start-with-the-problem/)). Their principle: solve real user problems (jobs to be done) rather than tailor solutions to generic personas.

**What Intercom uniquely contributes:** the problem-first gate. The template explicitly forbids writing the solution in the problem box. `prd-ready` should carry this forward as a structural rule, not a suggestion.

### Basecamp Shape Up (Ryan Singer)

Shape Up is the explicit anti-PRD. Instead of a PRD, teams write a **pitch** with five ingredients: Problem, Appetite, Solution, Rabbit holes, No-gos ([Shape Up Ch. 6, Write the Pitch](https://basecamp.com/shapeup/1.5-chapter-06)). An appetite is "completely different from an estimate. Estimates start with a design and end with a number. Appetites start with a number and end with a design" ([Shape Up Ch. 2](https://basecamp.com/shapeup/1.1-chapter-02)). Fixed time, variable scope: "The pitch summarizes the problem, constraints, solution, rabbit holes, and limitations. There's a specific appetite, the amount of time the team is allowed to spend on the project."

**What Shape Up uniquely contributes:** four things, all transplantable. (1) **Appetite before estimate** (fixed time, variable scope). (2) **Rabbit holes** as a first-class section (anticipated risks). (3) **No-gos** as a first-class section (explicit out-of-scope). (4) **Fat marker sketches** (sketches so rough you can't over-specify). `prd-ready` should adopt appetite, rabbit holes, and no-gos verbatim, and optionally recommend fat-marker sketches as the default visual form.

### Amazon Working Backwards / PR-FAQ

Amazon's Working Backwards process replaces the PRD with a press release and FAQ written from the customer's future perspective ([Working Backwards concepts](https://workingbackwards.com/concepts/working-backwards-pr-faq-process/); [Colin Bryar on Coda](https://coda.io/@colin-bryar/working-backwards-how-write-an-amazon-pr-faq)). "The press release (PR) portion is a few paragraphs, always less than one page. The FAQ should be five pages or less." If the PR "doesn't describe a product that is meaningfully better (faster, easier, cheaper) than what is already out there, or results in some stepwise change in customer experience, then it isn't worth building." AWS, Kindle, Prime Video were all shaped through PR-FAQs.

**What Amazon uniquely contributes:** the customer-outcome forcing function. The PR-FAQ tests whether the thing is worth building at all before any engineering starts. `prd-ready` should have an optional "PR-FAQ mode" for net-new products, and its default one-pager should include a customer-facing paragraph (the moral equivalent of the PR).

### Gibson Biddle, DHM (Netflix-era)

Former VP/CPO at Netflix and Chegg. The DHM model: "Delight customers in Hard-to-copy, Margin-enhancing ways" ([Biddle on Medium](https://gibsonbiddle.medium.com/2-the-dhm-model-6ea5dfd80792); [Lenny's podcast](https://www.lennysnewsletter.com/p/gibson-biddle-on-the-the-dhm-product)). Three questions: (1) How will it create delight? (2) What makes it hard to copy? (3) How does it improve margin?

**What Biddle uniquely contributes:** the moat question. Most PRDs answer "why build this" without asking "why can only we build this, and why will it last." `prd-ready` should include an optional "what makes this hard to copy" bullet in the rationale section, especially for net-new products rather than extensions.

### Reforge, Product Thinking writing

Reforge's PRD Toolkit introduces a three-stage evolution: **Product Brief** (1 page, problem-space alignment), **Product Spec** / Lean PRD (2-3 pages, solution-space alignment), **Full PRD** (comprehensive, build-ready) ([Reforge Blog, Evolving PRDs](https://www.reforge.com/blog/evolving-product-requirement-documents); [Reforge PRD Toolkit](https://docs.google.com/document/d/1A5EPqqiPfNy-Z_EPIRyDM4HCQPSsD8r94YWl48Pnm_s/edit)). The philosophy: "Think about it as a dynamic and evolving artifact that helps unlock the next stage of the development cycle. You should worry about your PRD being enough to get started, not about it being finished or perfect."

**What Reforge uniquely contributes:** the staged-document model. A PRD is not one document; it is a sequence of three documents each of which replaces the last. `prd-ready` should adopt this as its output model: a tiered artifact like `production-ready`'s 4 tiers, where each tier is independently shippable.

### Atlassian PRD template (Confluence)

Atlassian's reference PRD structure is the most-installed template in the industry. Sections: Project Details, Objectives and Success Metrics, Assumptions, UX and Design, Questions and Decisions, Scope / Out-of-Scope ([Atlassian, What is a PRD](https://www.atlassian.com/agile/product-management/requirements); [Confluence Lenny template](https://www.atlassian.com/software/confluence/templates/lennys-product-requirements)). Notably, it foregrounds "Questions and Decisions" (a running log of open issues with resolution dates) and a dedicated Out-of-Scope section.

**What Atlassian uniquely contributes:** the running-questions-log. Most PRDs treat open questions as flaws; Atlassian treats them as a first-class section. `prd-ready` should include a "Questions still open" section that is mandatory and dated, not optional.

### Google PRD / Spec conventions (public-facing)

Google's engineering culture is well-documented through design docs rather than PRDs ([Industrial Empathy, Design Docs at Google](https://www.industrialempathy.com/posts/design-docs-at-google/); [Google eng-practices](https://google.github.io/eng-practices/)). "Design docs are a key element of Google's software engineering culture. They are relatively informal documents that primary authors create before starting a coding project, documenting the high-level implementation strategy and key design decisions with emphasis on trade-offs." The best ones "lead readers through a logical flow: why this matters, to what we're building, to how we'll measure success."

**What Google uniquely contributes:** the trade-off-emphasis. Every design decision names what was rejected and why. `prd-ready` should include rejected-alternatives in the artifact; this is what `stack-ready` already does via "Rejected bundles and why." Same discipline should apply to the product scope.

### Additional: HashiCorp's "Problem Requirements Document"

HashiCorp calls their PRD a **Problem** Requirements Document, not Product Requirements Document ([HashiCorp PRD template](https://www.hashicorp.com/en/how-hashicorp-works/articles/prd-template)). "In most companies, PRD stands for 'product requirement document,' but HashiCorp has tweaked it to be a 'problem requirement document.'" PMs write PRDs; engineers follow with RFCs that address the problems surfaced. This is a clean separation between **what problem** (PM owns, PRD) and **what design** (eng owns, RFC).

**What HashiCorp uniquely contributes:** the naming discipline. Problem-ownership is PM; design-ownership is engineering. `prd-ready` should respect this boundary and hand off to `architecture-ready` for the design side.

### Adam Fishman, "Hot Take #1: PRDs are the worst way to drive product progress"

Adam Fishman's newsletter argues the Product Brief (1-2 pages + appendix) beats the PRD as a communication and context-setting tool ([FishmanAF newsletter Hot Take #1](https://www.fishmanafnewsletter.com/p/-hot-take-alert-1-prds-are-the-worst)). Core argument: "By taking a kitchen-sink approach to describing features and functionality we lose the art (and the collaboration) of product building." Most PRDs: too long, prescriptive enough to stifle team autonomy, discouraging of inquiry and dialogue. Product Brief structure: brief what/why, ideal end state (visual), launch and metrics, competitive context, appendix.

**What Fishman uniquely contributes:** the explicit anti-PRD case. `prd-ready` needs to know when to refuse to produce a PRD. A 4-person team shipping to 500 users in 2 weeks does not need a PRD; a Product Brief is the right artifact. This matches Shape Up, Reforge's three-stage model, and Cagan.

### Aakash Gupta, "Ditch the PRD template, embrace the PRD checklist"

Aakash argues that templates have become bloated because every department adds requirements; the result is "somewhat good for many, really good for no one" ([Mind the Product, Aakash Gupta](https://www.mindtheproduct.com/ditch-the-prd-template-and-embrace-the-prd-checklist/)). Replace the template with five stage-gated checklists: Planning, Kickoff, Solution Review, Launch Readiness, Impact Review. Each checklist is small and owned by the current phase.

**What Aakash uniquely contributes:** the checklist-over-template model. `prd-ready` should consider producing checklists at each lifecycle stage rather than one monolithic document. This also aligns with `production-ready`'s tier model (each tier has a pass-gate).

## 4. PRD vs. pitch vs. brief vs. one-pager: current discourse

### Four artifacts, four audiences, four timing windows

| Artifact | Length | Audience | When |
|---|---|---|---|
| **Pitch deck** | Slide form, presentation-driven | Investors, executives, early team | Fundraising, executive approval. Requires a narrator. ([IdeaPlan](https://www.ideaplan.io/compare/prd-vs-product-brief-vs-product-spec)) |
| **Product brief / 1-pager** | 1-2 pages + appendix | Decision-makers before approval; cross-functional leaders for early alignment | Pitching a quarterly roadmap item. Alignment before spec work. ([IdeaPlan](https://www.ideaplan.io/compare/prd-vs-product-brief-vs-product-spec); [Reforge](https://www.reforge.com/blog/evolving-product-requirement-documents)) |
| **Product spec / lean PRD** | 2-3 pages | Design, engineering, cross-functional IC review | Solution-space alignment before build. ([Reforge](https://www.reforge.com/blog/evolving-product-requirement-documents)) |
| **Full PRD** | 3-6+ pages | Engineering, QA, design, support for execution | Build phase. Source-of-truth for downstream work. ([Ideaplan](https://www.ideaplan.io/compare/prd-vs-product-brief-vs-product-spec)) |

"Think of the product brief as the pitch that gets an initiative approved and the PRD as the blueprint that guides execution. The brief answers 'should we build this?' while the PRD answers 'what exactly are we building?'" ([IdeaPlan](https://www.ideaplan.io/compare/prd-vs-product-brief-vs-product-spec)).

### Why teams pick each

- **Pitch deck:** external communication (investors, board), not build. Relies on narrator.
- **Brief / 1-pager:** internal approval-gating. Sent before a meeting or as a leave-behind. Readable in 2-3 minutes.
- **Lean PRD / spec:** cross-functional solution review. Enough detail to critique, not enough to over-specify.
- **Full PRD:** build-time coordination across many engineers, QA, designers, support. Overkill for a 2-person team; necessary for 15-person teams or regulated domains.

### What the PRD keeps that the others lose

- **Acceptance criteria** that QA can test against. Neither a pitch nor a brief contains these with precision.
- **Functional and non-functional requirements** the engineer will be held to. Briefs gesture at these; PRDs list them.
- **Out-of-scope / non-goals** explicit enough to defend against scope creep at launch.
- **Dependencies and integration points** between features, systems, teams. Briefs omit these.
- **Changelog** of decisions, who changed what and when.

### When a PRD is overkill

- Small team, small scope, reversible decision, minimal cross-functional coordination.
- Product Brief or 1-pager is enough ([FishmanAF](https://www.fishmanafnewsletter.com/p/-hot-take-alert-1-prds-are-the-worst)).
- "If the initiative is small enough that your team can just decide to build it, skip the brief and go straight to a PRD" ([IdeaPlan](https://www.ideaplan.io/compare/prd-vs-product-brief-vs-product-spec)). Or inverse: if the team can just decide, skip the PRD and ship.

### Current discourse (Apr 2026)

1. **Against full PRDs:** Marty Cagan (discovery over documentation), Adam Fishman (Product Brief > PRD), Basecamp (pitch, not PRD), Reforge (three-stage evolution).
2. **For full PRDs with discipline:** Ben Horowitz (PRD is the single most important doc), Chris Warren (PRD is necessary for engineering estimation), Plane / Figr / IdeaPlan (engineers need PRDs to stop asking "what did you mean").
3. **Middle ground (most prevalent):** PRD is a living document that starts as a brief, expands into a spec, expands into a full PRD only when scope justifies it ([Reforge](https://www.reforge.com/blog/evolving-product-requirement-documents); [Lenny](https://www.lennysnewsletter.com/p/my-favorite-templates-issue-37)).

**Implication for prd-ready:** the skill must let the user pick the right tier of artifact, not force a full PRD on every use case. Default to Product Brief / 1-pager; expand to PRD when scope, team size, or regulatory context demand it.

## 5. Frequency data

Hard numbers on how often PRDs fail downstream are scarce; the industry runs mostly on anecdote and self-selection bias.

### Available signals

- **Pragmatic Institute 2025:** 64% of product teams have integrated AI into their products. AI is "accelerating output, but it's not automatically improving judgment" ([Pragmatic Institute State of PM 2025](https://www.pragmaticinstitute.com/resources/state-of-product-management-marketing/)).
- **ProductPlan 2025 State of Product Management:** surveyed nearly 400 product professionals. Top challenges include "product strategy" as the most valuable job-to-be-done, but also gaps in execution visibility ([ProductPlan 2025 report](https://www.productplan.com/2025-state-of-product-management-annual-report/)).
- **Product Focus 2025 Profession Survey:** 532 product professionals, 47 countries. 22-page report ([Product Focus](https://www.productfocus.com/product-management-resources/profession-survey/)).
- **Forrester State of Product Management 2025:** highlights where current practices diverge from Forrester's prescriptions ([Forrester report summary](https://www.forrester.com/report/the-state-of-product-management-2025/RES184142)).

### Anecdotal quotes

- **Productboard:** "Most Product Requirement Documents fail because they list features instead of solving validated user problems" ([Productboard blog](https://www.productboard.com/blog/product-requirements-document-guide/)).
- **Mind the Product:** "At a tech SaaS company I worked for, Product was being built and Engineering productivity metrics looked great, but the resulting product did not live up to expectations, with Engineering blaming Product and Design for poor specification and a lack of guidance" ([Mind the Product](https://www.mindtheproduct.com/)).
- **Plane Blog:** "Most PRDs fail because they are written for the wrong audience (stakeholders who want to feel informed) instead of the right audience (engineers who need to build the thing)" ([Plane](https://plane.so/blog/how-to-write-a-prd-that-engineers-actually-read)).
- **Figr Design:** "A vague PRD is a tax on your team's time and focus. Every question an engineer has to ask you after kickoff is a sign of a gap in the PRD" ([Figr](https://figr.design/blog/how-to-write-a-prd)).
- **Fireside PM (AI-generated PRDs specifically):** testing five tools, the author concluded ChatGPT "lacked depth, nuance, and strategic thinking that felt connected to real product decisions" ([Fireside PM](https://firesidepm.substack.com/p/i-tested-5-ai-tools-to-write-a-prdheres)).

### What's missing

No public survey data on:
- What fraction of PRDs engineers refuse to estimate from.
- What fraction of PRDs get rewritten by engineering mid-build.
- What fraction of AI-generated PRDs are shipped without meaningful human revision.

**Implication for prd-ready:** the skill cannot cite a percentage failure rate. It can cite that the industry agrees on the failure modes (1-10 above) and that major PMs (Horowitz, Cagan, Fishman, Aakash, Reforge) have converged on a staged-artifact model. That convergence is the best signal available.

## 6. Downstream-consumer needs

For each downstream ready-suite skill, what the PRD must supply to let that skill do its job without re-litigating.

### 6.1 architecture-ready needs (planning tier, not yet released)

`architecture-ready` owns "design how the big pieces fit together" ([SUITE.md](https://github.com/aihxp/ready-suite/blob/main/skills/production-ready/SUITE.md)). From the PRD it needs:

- **Entities** (the nouns: users, orders, documents, sensors, etc.) with their key attributes and identifiers.
- **Flows** (the verbs: sign up, checkout, approve, escalate, refund, audit). Primary happy-path flow and at least two error/edge flows per feature.
- **Non-functional requirements** explicit: expected throughput (RPS/events/sec), latency SLOs (p50/p95/p99), availability target (three nines, four nines), data retention, RTO/RPO for disaster recovery.
- **Integration points** named: third-party APIs (Stripe, Salesforce, Twilio, etc.), internal services, message queues, webhooks, file/data exports.
- **Trust boundaries** (who sees what, who can mutate what, who the attacker is): consistent with `production-ready` Step 2 threat-model input.
- **Scale ceiling** (12-month honest projection of users, data, tenants, queries per day). This is the same signal `stack-ready` needs; PRD should produce it once, both skills consume it.
- **Compliance constraints** (HIPAA, PCI-DSS, SOC 2, GDPR, data residency) named, not implied.
- **Decision boundaries**: what is explicitly NOT decided at PRD time and deferred to architecture. (Example: "Queuing mechanism is architecture's call; PRD only specifies async delivery with 15-minute p95 latency.")

### 6.2 roadmap-ready needs (planning tier, not yet released)

`roadmap-ready` owns "sequence work over time." From the PRD it needs:

- **Priority ordering across features**: explicit ranking (MoSCoW or numeric) for the features in scope. Not "all important."
- **Release-gating criteria** per feature: what must be true to ship ("payments work for $1-$10,000 charges in USD; EUR deferred to v2").
- **Dependencies** between features (cannot ship B before A; may ship C in parallel with A).
- **Milestones** that are legible to stakeholders, not just to eng (beta, GA, v1.1, v2).
- **Must-haves vs. nice-to-haves** clearly marked, with a cut-line for "ship if time-boxed" (adopted from Shape Up's appetite model).
- **Risk/rabbit holes** per feature: what could blow up the schedule, borrowed directly from Shape Up.
- **Dates or ranges** if deadlines exist (contractual obligations, marketing windows, regulatory deadlines).

### 6.3 stack-ready needs (live, v1.1.4)

`stack-ready` has six pre-flight questions that drive its scoring ([stack-ready SKILL.md](https://github.com/aihxp/ready-suite/blob/main/skills/stack-ready/SKILL.md)). The PRD should pre-fill all six so `stack-ready` does not start from scratch:

1. **Domain.** "What real-world job does this stack serve?" PRD's Problem section plus target-user section should name the domain clearly enough that it maps to one of stack-ready's 12 domain profiles (SaaS/multi-tenant, e-commerce, healthcare, fintech, etc.).
2. **Team.** "How many engineers, what language depth, who is on call?" PRD should include a Team & Constraints section with this information, even if it's "unknown at this stage."
3. **Budget posture.** "Free-tier scrappy, cash-efficient growth, or enterprise-indifferent?" PRD's business-context section should name this as a *posture*, not a dollar figure. `stack-ready` expects a posture.
4. **Time-to-ship.** "Days, weeks, months, no hard deadline?" PRD's timeline section provides this. This also feeds `roadmap-ready`.
5. **Scale ceiling (12 months).** "Honest traffic and data estimate." PRD's success-metrics section should include expected user counts at launch, 3 months, 12 months. `stack-ready` reads this directly.
6. **Regulatory and data-residency constraints.** HIPAA, PCI-DSS, SOC 2, GDPR, FedRAMP, CCPA. PRD's compliance section answers this. "Silence is not an answer" per stack-ready's rule.

If the PRD produces all six, `stack-ready` skips interrogation and goes straight to constraint mapping (Step 2). If the PRD produces some but not all, `stack-ready` falls back to its default-assumption mode for the gaps. **`prd-ready` should produce these six answers as a structured block (YAML frontmatter, explicit bullets, or a `.prd-ready/STACK-INPUTS.md` file) so `stack-ready` can ingest them mechanically.**

### 6.4 production-ready needs (live, v2.5.5)

`production-ready` has 12 pre-flight questions ([production-ready SKILL.md](https://github.com/aihxp/ready-suite/blob/main/skills/production-ready/SKILL.md)). It also requires an Architecture Note (Step 2) with specific bullets: stack, data source, auth model, permission model, route map, threat model, visual identity. The PRD should supply:

- **Requirements stated concretely enough to build and test against.** "User can reset their password via email link within 10 minutes; link expires after 1 hour; rate-limited to 3 per user per hour." Not "secure password reset."
- **Entities and their CRUD surface.** Tier 1 of production-ready demands "create/edit/delete one entity" works end-to-end; the PRD must name the entity and specify what operations it supports.
- **Roles and permissions.** Who can read, who can write, who can delete, who can assign roles. This feeds production-ready's Step 2 permission model.
- **Audit trail requirements.** Which mutations must be logged, retained for how long, viewable by whom.
- **Error and edge states.** What happens when the user runs out of quota, hits rate limit, tries an operation on a deleted record.
- **Domain landmines.** Regulated domains (healthcare, finance, HR, legal) need explicit callouts. Healthcare without a HIPAA audit callout in the PRD leads to production-ready scrambling at Tier 4 to retrofit.
- **Visual identity direction.** Not the tokens (that's production-ready Step 3), but the direction: "modern clinical," "fintech-serious," "playful SaaS." production-ready needs a seed.
- **Acceptance criteria** per feature that QA and production-ready's Tier 1 proof tests can check against.

## 7. PRD lifecycle patterns

How real teams handle freeze, change management, versioning, and sign-off.

### 7.1 When to freeze a PRD

Rarely a hard freeze; more often a soft freeze tied to a phase gate. Common patterns:

- **Scope freeze before build.** Once engineering starts, new requirements route to v2 unless they're bug fixes to the existing scope. "Key milestones should include spec freeze, design complete, dev start, beta, and GA" ([search synthesis](https://www.getguru.com/reference/prd)).
- **Living-document model.** Horowitz and most modern guides argue for a living document: "keep PRDs up-to-date daily or weekly at a minimum" ([Horowitz memo](https://sriramk.com/memos/Ben_Horowitz_Good_Product_Manager_Bad_Product_Manager.pdf)). But critically, **every change is broadcast**.
- **Stage-gated checklist model.** Aakash's five checklists (Planning, Kickoff, Solution Review, Launch Readiness, Impact Review) each have a closure gate; the PRD sections owned by that stage freeze when the stage closes ([Aakash Gupta](https://www.mindtheproduct.com/ditch-the-prd-template-and-embrace-the-prd-checklist/)).

### 7.2 In-scope change vs. new PRD

The informal rule across the literature:

- **In-scope change** = clarification, acceptance-criteria tweak, wording change, adding a previously-implied detail. Stays in the current PRD, gets changelogged and broadcast.
- **New PRD** = adds a new feature, changes the target user, changes the success metric, changes the appetite / timeline materially. Gets its own PRD, cross-links to the prior one.
- **Gray zone** = adding a sub-requirement to an existing feature. Most teams resolve this as "in-scope with PM sign-off, new PRD without."

No public numeric threshold is cited ("1 week of engineering effort => new PRD"). The norm is judgment plus stakeholder agreement.

### 7.3 Version tracking

Ubiquitous tools:
- **Google Docs revision history:** auto-saves every change, nameable versions at significant points, detailed change tracking with author and time ([Google Drive API docs](https://developers.google.com/workspace/drive/api/guides/change-overview)). Most common PRD host in small-to-midsize companies.
- **Notion page history:** accessible via three-dot menu, shows chronological changes with author and diff ([Notion version control guide](https://www.papermark.com/blog/notion-version-control)). Available on Plus/Business tiers.
- **Confluence page history:** full page-version diff, comments per-version, required in enterprise-heavy Atlassian shops ([Atlassian Confluence](https://www.atlassian.com/software/confluence/templates/product-requirements)).
- **Git / markdown-in-repo:** growing practice, especially for PRDs tightly coupled to code. HashiCorp's template is explicitly markdown ([HashiCorp PRD](https://www.hashicorp.com/en/how-hashicorp-works/articles/prd-template)). `production-ready` stores its artifacts this way; `prd-ready` should follow suit.

**Additional discipline (across tools):** a visible changelog section at the top of the PRD, listing recent edits with date, author, and one-line summary. Aakash, Reforge, Atlassian, and Horowitz all agree this is non-negotiable.

### 7.4 Sign-off protocols

The approval flow typically names signers per role:
- **Product manager** (owner): responsible for the document.
- **Engineering lead**: feasibility, timeline, estimates.
- **Design lead**: UX feasibility, flows.
- **QA / test lead**: testability of acceptance criteria.
- **Data / analytics**: measurability of success metrics.
- **Legal / compliance**: for regulated features.
- **Marketing / product marketing**: launch readiness.
- **Customer support**: documentation and runbook readiness ([Perforce](https://www.perforce.com/blog/alm/how-write-product-requirements-document-prd); [Guru](https://www.getguru.com/reference/prd)).

"Sign-off from key stakeholders should be secured to finalize the PRD as the project's guiding document. Teams should track versions, record approvals (PM + Eng + Design + Data/Product Marketing), and only move to build when sign-offs for scope and metrics exist" ([via Guru](https://www.getguru.com/reference/prd)).

**What "done" means:**
- Tier 1: Brief approved, go/no-go decided.
- Tier 2: Spec approved, design and engineering aligned on solution direction.
- Tier 3: Full PRD approved, all signers on record, build authorized.
- Tier 4: Launch-ready PRD closed; impact review queued for 30 days post-launch (Aakash's fifth checklist).

## 8. Recommendations for prd-ready

What the research implies for the skill's contract and workflow.

### 8.1 Core principle (should be the skill's one-line)

> **Every PRD states the decisions it has already made, names the out-of-scope things it refuses to cover, and can be consumed by engineering without a clarification meeting.**

This is the anti-"hollow PRD," anti-"invisible PRD," anti-"moving target" stance. Mirrors `stack-ready`'s "every output states the weighting assumptions the user can override and names the failure mode that would flip the recommendation."

### 8.2 Tiered artifact, not monolithic document

Adopt Reforge's three-stage evolution plus `production-ready`'s four-tier pattern:

| Tier | Artifact | When |
|---|---|---|
| Tier 1: **Product Brief** | 1 page, problem + appetite + high-level solution + success + no-gos | Alignment before investment. Default output. |
| Tier 2: **Product Spec (lean PRD)** | 2-3 pages, Tier 1 plus entity model, flows, acceptance criteria, rabbit holes, dependencies | Solution-space alignment, pre-build |
| Tier 3: **Full PRD** | 3-8 pages, Tier 2 plus non-functional requirements, integration map, compliance, downstream-handoff sections | Build coordination, regulated domains, large teams |
| Tier 4: **Launch-ready PRD** | Tier 3 plus launch plan, metrics instrumentation, support docs, rollback plan | Pre-launch, gates go-live |

Each tier is independently shippable. Each tier has a sign-off gate. If the project does not need Tier 3, the skill does not force it.

### 8.3 Mandatory sections (borrow from the best, reject the junk)

Every tier must have:
- **Problem** (no solutions). Verbatim rule from Intercom.
- **Who** (target user, job-to-be-done, not a persona paragraph).
- **What flips the decision** (borrowed from `stack-ready`): what would we learn that would make this not worth building?
- **Non-goals / no-gos** (borrowed from Shape Up and Kevin Yien). Explicit, not implied.
- **Appetite** (borrowed from Shape Up): how much time are we willing to spend before we stop? Not "how long will it take."
- **Rabbit holes** (borrowed from Shape Up): anticipated risks that could blow up the work.
- **Questions still open** (borrowed from Atlassian): running log with owner and due date.
- **Changelog** (borrowed from Horowitz and every modern PRD guide): date, author, one-line summary.

Optional sections by tier:
- **What makes this hard to copy** (from Biddle's DHM): include for net-new products, skip for iterations.
- **PR-FAQ / press-release paragraph** (from Amazon): include for net-new products, optional for iterations.
- **Rejected alternatives** (from Google design docs and `stack-ready`): name the scopes we considered and cut.

### 8.4 Downstream-handoff block (mandatory in Tier 2+)

The PRD should produce a structured block that downstream skills can read mechanically. Suggested format (`.prd-ready/HANDOFF.md`):

```markdown
# PRD Handoff

## To stack-ready (six pre-flight answers)
- Domain: [...]
- Team: [...]
- Budget posture: [...]
- Time-to-ship: [...]
- Scale ceiling (12 months): [...]
- Regulatory constraints: [...]

## To architecture-ready
- Entities: [...]
- Flows: [...]
- Non-functional requirements: [...]
- Integration points: [...]
- Trust boundaries: [...]

## To roadmap-ready
- Priority ordering: [...]
- Release-gating criteria: [...]
- Dependencies: [...]
- Must-haves vs. nice-to-haves: [...]

## To production-ready
- Domain: [maps to production-ready's 33 domain profiles]
- Entities and CRUD surface: [...]
- Roles and permissions: [...]
- Audit requirements: [...]
- Acceptance criteria per feature: [...]
- Visual identity direction: [...]
```

This is what makes `prd-ready` compositional: every downstream skill can ingest its slice without re-interrogating the user. Matches `production-ready`'s pattern of consuming `.stack-ready/DECISION.md`.

### 8.5 Anti-patterns to refuse

`prd-ready` should have explicit disqualifiers (like `production-ready`'s "hollow indicators"):

- **Invisible PRD check.** A PRD where the target-user and success-metric sections could be swapped with another project's PRD is invisible. Block at tier gate.
- **Feature-laundry-list check.** A PRD with more than 7 un-prioritized features is a laundry list. Force prioritization or reject.
- **Solution-first check.** If the problem section names the solution, refuse. Intercom's rule.
- **Assumption-soup check.** If the PRD contains phrases like "users will love" or "customers want" without evidence, flag as assumption soup. Require either evidence or relabel as "hypothesis."
- **Moving-target check.** Every edit writes to the changelog. Edits without changelog entries are rejected.
- **Hollow-PRD scan** (suite-consistent with `production-ready`'s hollow-check): after each tier, scan the PRD for TODOs, "TBD," "coming soon," "we'll figure this out later." Any hit blocks the tier.

### 8.6 Lifecycle rules

- Default output is Tier 1 (Product Brief). User confirms or triggers expansion.
- Expansion to Tier 2 requires at least one answered "rabbit hole" section and one filled "non-goals" section.
- Expansion to Tier 3 is gated on engineering feasibility input (not just PM's word).
- Expansion to Tier 4 requires QA acceptance-criteria review.
- Every edit after Tier 2 closure requires a changelog entry with author and rationale.
- A "change so large it's a new PRD" is detected by: new feature, new target user, new success metric, or >50% timeline delta. Skill surfaces this and recommends forking.

### 8.7 Vocabulary to adopt (coinages confirmed for the skill)

Primary: **hollow PRD**, **invisible PRD**, **feature laundry list**, **moving-target PRD**, **solution-first PRD**, **assumption-soup PRD**.

Secondary (rhetorical, sparingly): **theater PRD**, **quill-and-inkwell PRD**.

External references to preserve (attribution): **fat marker sketch**, **appetite**, **rabbit holes**, **no-gos** (all Shape Up); **PR-FAQ** (Amazon); **DHM / hard-to-copy** (Biddle); **Product Brief** (Fishman + Reforge); **Problem Requirements Document** variant (HashiCorp).

### 8.8 What the skill should refuse to do

- Write a PRD from a single sentence of input without challenging assumptions. AI-generated PRDs from one-line prompts is the #1 failure mode documented.
- Generate wireframes or UI mockups inline. Visual identity belongs to `production-ready` (Step 3). `prd-ready` names the direction; it does not produce the pixels.
- Pick a stack. That's `stack-ready`'s job. The PRD supplies inputs; stack-ready supplies the pick.
- Make architecture decisions. That's `architecture-ready`'s job.
- Generate 15-page default output. The default is 1 page. Users opt in to expansion.
- Freeze the PRD at Tier 1. Freezing happens at Tier 2 or Tier 3 gates, not Tier 1.

### 8.9 Skill version signaling

Match `stack-ready`'s convention of ending every run with skill version, last updated, current date, and a staleness warning if older than 6 months. PRD practices shift less than stack picks (no new PRD framework launches monthly), but the warning still applies: a PRD written against 2024 Intercom principles might need review against newer patterns.

---

**End of research pass. April 23, 2026.**

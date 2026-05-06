# RESEARCH-2026-04: Architecture-Ready Source Material

Research pass for the `architecture-ready` skill. This document is the citation record for the SKILL.md body and the reference pack. Every rule, failure mode, and threshold in SKILL.md should trace to a line in here. The body is organized by the eight research areas listed in the skill brief, plus a synthesis at the end that names what SKILL.md should coin, what it should adopt, and what the downstream skills need from the ARCH.md artifact.

Citation format: author / title / publisher or venue / date / URL. All URLs verified April 2026. No em dashes, no en dashes, no emojis; ASCII hyphens and `->` only.

## 0. Synthesis up front (read this first)

Eight findings drive the SKILL.md design:

1. **The canonical failure mode is not bad architecture; it is architecture documents that decide nothing.** Every senior-engineer complaint surveyed (section 1) collapses to the same root: diagrams rendered, words printed, arrows drawn, no forces named, no alternatives rejected. The "Cover Your Assets" antipattern (SourceMaking, Brown / Malveau / McCormick / Mowbray, 1998) is the 20-year-old name for the AI-generated version.
2. **The industry is mid-correction away from the 2015-2021 microservices-by-default era, but in an uneven way.** Amazon Prime Video's 2023 post (section 4.1), Shopify's continued modular-monolith investment (section 4.1), and Stack Overflow's unapologetic 9-server monolith (section 4.1) are the public markers. Thoughtworks has held microservices at "Trial" not "Adopt" since 2018. Cell-based architecture (section 4.6) is the 2024-2026 resilience answer that is NOT the same as microservices.
3. **Event sourcing and CQRS are the most overprescribed advanced patterns.** The InfoQ / DDD community consensus is that building a whole system on event sourcing is itself an antipattern (section 4.5). AI-generated architecture frequently picks it anyway.
4. **ADR discipline is well understood but rarely practiced well.** Nygard's 2011 post is the canonical reference; `adr-tools` (Henderson fork) and `log4brains` are the canonical tools; but the practical failure mode is ADRs written retroactively, never superseded, and written for trivial decisions (section 7).
5. **Fitness functions work when teams ship them.** ArchUnit (Java), `dependency-cruiser` (JS/TS), and Packwerk (Ruby, Shopify open-source) are the three most-cited production examples (section 8). The Ford / Parsons / Kua / Sadalage second edition (2023) codified the practice.
6. **Every famous architectural outage since 2012 traces to a decision the architecture document did not discuss.** Knight Capital (dead code in a shared binary, section 5.1), S3 2017 (blast radius of a single command, section 5.2), Facebook BGP 2021 (DNS dependent on the same network whose health DNS advertises, section 5.4), Roblox 2021 (Consul as a single point of failure, section 5.7), Atlassian 2022 (site vs app identifier ambiguity in a deletion API, section 5.6), Cloudflare 2019 (single-commit global regex deploy, section 5.3).
7. **The downstream contract with stack-ready, production-ready, prd-ready, and roadmap-ready is explicit enough to enumerate.** See section 6. ARCH.md has to produce: system-shape decision, component list with trust boundaries, entity shapes with storage shape (not DB brand), integration-sync-vs-async decisions with idempotency and failure handling, NFR-to-architecture mapping with numbers carried through, a component dependency graph, and an ADR corpus.
8. **The AI-slop architecture document has a signature.** It lists components with no rationale, draws arrows with no direction or semantics, claims "scalable" without numbers, picks microservices because Amazon uses them, picks Kafka because the tutorial used Kafka, and never names what would flip the decision. SKILL.md must refuse these the same way prd-ready refuses invisible PRDs.

## 1. Top AI-generated architecture complaints and failure modes

The senior-engineer-complaint surface is large; the complaints compress to a small set of patterns.

### 1.1 Over-microservicing

"The microservices cargo cult" (Stavros Korokithakis, 2015; still widely cited in 2024-2026) names the pattern: teams adopt microservices because other companies do, ending up with all the complexity and none of the benefits. The Hacker News thread on that post (`news.ycombinator.com/item?id=10337763`) is the canonical 1000-comment referendum. The practical form: "10-user CRUD apps with 14 services, 3 message queues, a service mesh, and 2 engineers who cannot ship a feature without a cross-service schema migration." Stavros Korokithakis, "The microservices cargo cult," Stavros' Stuff, 2015, https://www.stavros.io/posts/microservices-cargo-cult/.

Martin Fowler's "MonolithFirst" (2015) and Sam Newman's subsequent "Monolith to Microservices" (O'Reilly, 2019) both argue the same: if you do not have a working monolith, you probably cannot design microservices well, because the service boundaries require domain knowledge you have not yet accumulated. Sam Newman, "Monolith to Microservices: Evolutionary Patterns to Transform Your Monolith," O'Reilly, 2019, ISBN 978-1-492-04784-1, https://samnewman.io/books/monolith-to-microservices/. Fowler's "MonolithFirst": https://martinfowler.com/bliki/MonolithFirst.html.

### 1.2 Cargo-cult cloud-native (K8s + Kafka + event sourcing for MVPs)

"Cargo cult in software engineering" surveys (Shahzad Bhatti, 2025, https://weblog.plexobject.com/archives/7080; Oleksandr Troitskyi, 2024, https://troitskyioleksandr.substack.com/p/cargo-cult-in-software-engineering) name the same pattern across platforms. "The Kubernetes Cargo Cult" (Portainer blog, 2024, https://www.portainer.io/blog/the-kubernetes-cargo-cult-why-the-cncf-stack-isnt-the-only-way) documents the CNCF-stack-as-default-for-everyone failure mode.

Specific AI-generated variants seen in 2024-2026: LLMs recommend Kafka for 100-event-per-day event logs because the training data saw Kafka in high-scale blog posts; recommend Kubernetes for 2-engineer teams because Kubernetes is over-represented in Medium tutorials; recommend microservices because the word "scalable" co-occurs with "microservices" in training data.

### 1.3 Diagrams with no decisions ("architecture theater")

The "Cover Your Assets" antipattern (William Brown, Raphael Malveau, Hays McCormick, Thomas Mowbray, "AntiPatterns: Refactoring Software, Architectures, and Projects in Crisis," Wiley, 1998, https://sourcemaking.com/antipatterns/software-architecture-antipatterns) catches this: authors evade making decisions; to avoid making a mistake, they list alternatives. When no decisions are made and no priorities are established, the documents have limited value.

"Architecture by Implication" (DevIQ, https://deviq.com/antipatterns/architecture-by-implication/) is the adjacent pattern: architecture assumed rather than documented. The effect is the same as architecture theater: a reader cannot trace a decision to a rationale.

Specific AI-slop variants: C4 container diagrams with no trust boundaries marked; arrows with no direction or semantics; "Service A calls Service B" with no protocol (REST? gRPC? async message?), no failure semantics (what if B is down?), no SLO.

See Simon Brown, "The C4 Model: Misconceptions, Misuses, and Mistakes," GOTO 2024, https://gotocph.com/2024/sessions/3326/the-c4-model-misconceptions-misuses-and-mistakes and Working Software, "Misuses and Mistakes of the C4 model," https://www.workingsoftware.dev/misuses-and-mistakes-of-the-c4-model/ for Brown's own documentation of how the C4 model is misused: ambiguous diagrams, mixed abstraction levels (containers with components inside a single diagram), and inconsistent notation across a diagram set.

### 1.4 "Scalable" with no numbers

The pattern is old enough to predate LLMs; LLMs amplified it. ThoughtWorks Technology Radar 2018 Vol 19 (https://www.thoughtworks.com/radar) placed microservices at "Trial" (not "Adopt") with the explicit guidance: do not adopt for scale you do not have. The "Layered microservices architecture" antipattern (Technology Radar, multiple volumes, https://www.thoughtworks.com/radar/techniques/layered-microservices-architecture) names the specific failure: teams split services by layer (UI service, logic service, data service) rather than by domain, producing a distributed monolith worse than the monolith they left.

### 1.5 Resume-driven architecture

"Resume-Driven Development: A Definition and Empirical Characterization" (Jonas Fritzsch, Marvin Wyrich, Justus Bogner, Stefan Wagner, ICSE 2021, https://arxiv.org/abs/2101.12703) is the peer-reviewed study. The survey (591 professionals: 130 hiring, 558 technical) found 60% of hiring professionals agreed that trends influence their job offerings, and 82% of software professionals believed trending technologies made them more attractive to employers. The paper formally defines RDD as "an interaction between human resource and software professionals in the software development recruiting process, characterized by overemphasizing numerous trending or hyped technologies."

The term "Résumé-Driven Development" predates the paper in grey literature (undated; the paper notes "anecdotally coined"). The practical architecture-tier form: an architect picks Kafka, Kubernetes, event sourcing, and CQRS for a 50-user internal tool because those are the four phrases that will appear on their resume when they leave.

### 1.6 Premature abstraction / speculative generality

Martin Fowler, "Refactoring: Improving the Design of Existing Code" (2nd ed, Addison-Wesley, 2018; 1st ed 1999) names "Speculative Generality" as a code smell at the code level. At the architecture tier: ports-and-adapters layers for a two-week CRUD project, a plugin system with no second plugin, a "future-proof" abstraction over a database that is only called from one service. Refactoring.guru, "Speculative Generality," https://refactoring.guru/smells/speculative-generality. Frontend At Scale, "Too General Too Soon," https://frontendatscale.com/issues/15/.

Victor Rentea, "Overengineering in Onion/Hexagonal Architectures" (2024, https://victorrentea.ro/blog/overengineering-in-onion-hexagonal-architectures/) and Three Dots Labs, "Is Clean Architecture Overengineering?" (https://threedots.tech/episode/is-clean-architecture-overengineering/) document the specific form in the Clean / Hexagonal / Onion world: 15 layers of abstraction for a CRUD API, interfaces with one implementation, ports with no alternative adapters.

### 1.7 "Just wire it to Postgres" (underthinking data shape)

The data-shape failure mode is less blogged but more consequential. Evidence: Sam Newman, "Monolith to Microservices" (2019, ch. 4) warns explicitly against splitting a monolith while sharing a database; Pat Helland, "Life beyond Distributed Transactions: an Apostate's Opinion" (CIDR 2007, https://www.cidrdb.org/cidr07/papers/cidr07p15.pdf) predates the problem by a decade; "Designing Data-Intensive Applications" (Kleppmann, O'Reilly, 1st ed 2017, ISBN 978-1-449-37332-0, https://www.oreilly.com/library/view/designing-data-intensive-applications/9781491903063/) chapters 5-9 are the canonical treatment. Kleppmann 2nd ed (with Chris Riccomini) is in early release (March 2025) with general availability expected January 2026 (https://www.oreilly.com/library/view/designing-data-intensive-applications/9781098119058/).

The AI-slop form: any persistence question produces "just use Postgres with Prisma" regardless of whether the workload is time-series, graph, append-only event log, write-heavy ledger, or OLAP. Postgres is a good default; it is not a design.

### 1.8 Complaints specific to LLM-generated architecture docs

From the 2024-2025 cohort of engineer blog posts and papers:

- "LLM Architectural Review: interrogate AI-generated architecture" (Christoforus Yoga Haryanto, Medium, 2024, https://medium.com/@cyharyanto/my-llm-architectural-review-63c0f940b225) coins the need for adversarial questioning. Summary: without iterative interrogation, LLMs produce "collaborative slop."
- "Using LLMs to Evaluate Architecture Documents" (Springer, 2025, https://link.springer.com/chapter/10.1007/978-3-032-24216-7_4) finds that the quality of the input architecture document drives the quality of LLM evaluation. Applied in reverse: if the architecture doc has no forces, the LLM cannot tell whether it is good.
- Pragmatic Engineer, "Software engineering with LLMs in 2025: reality check" (Gergely Orosz, 2025, https://newsletter.pragmaticengineer.com/p/software-engineering-with-llms-in-2025) documents the industry-wide pattern that LLMs produce plausible-looking architecture docs that collapse under light technical questioning.

The specific AI-slop architecture doc signature:
- Lists components with no rationale.
- Uses C4 vocabulary (Context, Container, Component) but without Simon Brown's actual discipline (one abstraction level per diagram, explicit notation, named protocols on arrows).
- Claims "scalable," "highly available," "fault-tolerant" with no numbers.
- Picks tools from the training-data frequency distribution (Kafka for any event, Redis for any cache, Postgres for any data) regardless of workload.
- Omits what was rejected and why.
- Omits non-functional numbers.
- Omits trust boundaries.
- Omits failure modes.
- Ships the diagram, not the decision.

## 2. Named failure modes: availability verdicts

For each candidate term: verdict (TAKEN / AVAILABLE / CONTESTED / ADOPTED), link, notes.

### 2.1 "Architecture theater"

Verdict: **CONTESTED** (low-frequency, informal, no canonical source). Google returns scattered uses in 2018-2024 blog posts about enterprise architecture. No book, no paper, no Wikipedia entry. The phrase "security theater" (Bruce Schneier, 2003) is the cultural reference; "architecture theater" is the plausible lift. SKILL.md can adopt and own the term with a specific definition. The closest prior art is the "Cover Your Assets" antipattern from "AntiPatterns" (1998) and "Architecture by Implication" from DevIQ (undated), but neither name covers the AI-slop form.

**Recommendation: ADOPT and define.** Define as: an architecture artifact (diagram, doc, ADR) that renders but decides nothing; passes visual review but fails any "what would flip this" question.

### 2.2 "Paper tiger architecture"

Verdict: **AVAILABLE** for the technical sense. The phrase "paper tiger" is common English (Mao, 1956; Schneier uses "security paper tiger"). In software, the phrase returns document-management software ("Paper Tiger") as the dominant hit. No architecture-discipline use.

**Recommendation: ADOPT.** Define as: architecture that reads robust on paper (redundant regions, HA databases, circuit breakers mentioned) but the first real load or first real failure collapses it because the decisions were not load-tested by design review.

### 2.3 "Cargo-cult cloud-native"

Verdict: **CONTESTED / ADOPTED informally.** "Cargo cult programming" traces to Richard Feynman's 1974 Caltech address and entered software folklore via Steve McConnell and Jeff Atwood. "The Kubernetes Cargo Cult" is live on Portainer's blog (https://www.portainer.io/blog/the-kubernetes-cargo-cult-why-the-cncf-stack-isnt-the-only-way). "The microservices cargo cult" is Stavros Korokithakis, 2015 (https://www.stavros.io/posts/microservices-cargo-cult/). The specific combination "cargo-cult cloud-native" appears in scattered 2022-2025 blog posts but is not a fixed term.

**Recommendation: USE as a general modifier ("the cargo-cult cloud-native antipattern"), credit prior uses, do not attempt to own.**

### 2.4 "Stackitecture"

Verdict: **AVAILABLE.** No Google hit returns the term as used in architecture discipline; the closest hits are tutorials about "stack architecture" (software stack layering).

**Recommendation: ADOPT.** Define as: architecture decisions driven by stack choice rather than problem shape. "We are using Next.js, so the architecture is serverless edge functions plus Postgres" is stackitecture; the stack-ready decision has overwritten the shape question. Opposite of architecture-ready's intended discipline (architecture shape first, stack after).

### 2.5 "Resume-driven architecture" / "Resume-driven development"

Verdict: **TAKEN.** Fritzsch et al., ICSE 2021 (https://arxiv.org/abs/2101.12703) is the academic reference. Well-established in grey literature since at least 2015.

**Recommendation: CITE and reuse, do not recoin.**

### 2.6 "Distributed monolith"

Verdict: **TAKEN** (Sam Newman, cited above; and InfoQ, "Microservices Ending up as a Distributed Monolith," 2016, https://www.infoq.com/news/2016/02/services-distributed-monolith/). Jonathan Tower's definition widely quoted: "the services are separately deployable but have so many dependencies that they must be deployed together."

**Recommendation: CITE and reuse. Use Newman's definition.**

### 2.7 "Non-architecture" ("we'll figure it out later")

Verdict: **AVAILABLE** in the exact phrase, but "no architecture" / "accidental architecture" / "architecture by neglect" cover adjacent space. SourceMaking's "Architecture By Implication" (https://sourcemaking.com/antipatterns/software-architecture-antipatterns) is the closest named prior art.

**Recommendation: ADOPT the term "non-architecture" with a tight definition (the explicit decision to defer architectural decisions indefinitely); or use "accidental architecture" (below) with proper credit.**

### 2.8 "Big ball of mud"

Verdict: **TAKEN.** Brian Foote and Joseph Yoder, "Big Ball of Mud," PLoP 1997 (https://www.laputan.org/mud/mud.html; PDF at https://hillside.net/plop/plop97/Proceedings/foote.pdf). Canonical. Referenced in virtually every architecture-antipattern list.

**Recommendation: CITE and reference, do not recoin.**

### 2.9 "Accidental architecture"

Verdict: **CONTESTED / ADOPTED informally.** Used in "AntiPatterns" (Brown et al., 1998), SourceMaking, and numerous blog posts. No single canonical coiner. Wikipedia's anti-pattern article lists it.

**Recommendation: USE as a general descriptor, cite SourceMaking or AntiPatterns.** Pairs well with "architecture by implication."

### 2.10 Additional candidate terms found during research

- **"Architecture astronautics."** SourceMaking. Excessive theoretical focus on abstract architectural ideas with no practical value. TAKEN.
- **"Cover Your Assets."** Brown et al., 1998. Document-driven processes that avoid decisions. TAKEN.
- **"Golden Hammer."** Brown et al., 1998. Applying the same tool everywhere. TAKEN.
- **"Ghost Architecture."** AVAILABLE. Could name: architecture that the org believes exists (from a slide deck, onboarding doc, wiki) but does not reflect the running system. Candidate if SKILL.md wants to name the "the architecture doc and the code disagree" failure.
- **"Horoscope architecture."** AVAILABLE. Lifted from the stack-ready vocabulary ("horoscope-shaped recommendations"); could name: architecture that reads plausibly regardless of the project, surviving the substitution test across domains. Strong candidate because prd-ready and stack-ready already use "horoscope" language.

### 2.11 Recommended coinage / adoption set for SKILL.md

Eight terms for SKILL.md to own or explicitly adopt with credit:

1. **Architecture theater** (adopt, define): doc renders, decides nothing.
2. **Paper tiger architecture** (coin): robust-looking, collapses on first real load.
3. **Stackitecture** (coin): stack choice masquerading as architecture.
4. **Horoscope architecture** (adopt from stack-ready vocabulary): reads plausibly for any product.
5. **Ghost architecture** (coin, candidate): the doc and the running system disagree.
6. **Architecture by implication** (cite DevIQ / SourceMaking): architecture assumed, not documented.
7. **Accidental architecture / Big ball of mud** (cite Brown et al. and Foote / Yoder): unplanned, emergent structure.
8. **Distributed monolith** (cite Newman): worst of both worlds.

Plus cite as "known named failure modes, referenced not coined": resume-driven development, cargo-cult cloud-native, premature abstraction, speculative generality, architecture astronautics, golden hammer, cover your assets.

## 3. Canonical architecture literature

Full citations for the SKILL.md reference bibliography.

### 3.1 Fundamentals of Software Architecture (Richards / Ford)

- 1st ed: Mark Richards, Neal Ford, "Fundamentals of Software Architecture: An Engineering Approach," O'Reilly, 2020, ISBN 978-1-492-04345-4, https://www.oreilly.com/library/view/fundamentals-of-software/9781492043447/.
- 2nd ed: "Fundamentals of Software Architecture: A Modern Engineering Approach," O'Reilly, 2024 (copyright 2025), ISBN 978-1-098-17551-1, https://www.oreilly.com/library/view/fundamentals-of-software/9781098175504/. New material on cloud, modular monoliths, generative AI, architecture metrics.

### 3.2 Building Evolutionary Architectures (Ford / Parsons / Kua / Sadalage)

- 1st ed: Neal Ford, Rebecca Parsons, Patrick Kua, "Building Evolutionary Architectures: Support Constant Change," O'Reilly, 2017, ISBN 978-1-491-98636-3.
- 2nd ed: Neal Ford, Rebecca Parsons, Patrick Kua, Pramod Sadalage, "Building Evolutionary Architectures: Automated Software Governance," O'Reilly, 2023, ISBN 978-1-492-09754-9, https://www.oreilly.com/library/view/building-evolutionary-architectures/9781492097532/ and https://evolutionaryarchitecture.com/.
- Key concept: **fitness functions**. "Mechanisms that provide guardrails with objective measures." The 2nd ed adds AI / generative testing applied to fitness functions. Thoughtworks sample chapter: https://www.thoughtworks.com/content/dam/thoughtworks/documents/books/bk_building_evolutionary_architectures_en.pdf.

### 3.3 Software Architecture: The Hard Parts (Ford / Richards / Sadalage / Dehghani)

- Neal Ford, Mark Richards, Pramod Sadalage, Zhamak Dehghani, "Software Architecture: The Hard Parts: Modern Trade-Off Analyses for Distributed Architectures," O'Reilly, 2021, ISBN 978-1-492-08689-5, https://www.oreilly.com/library/view/software-architecture-the/9781492086888/. E-book October 2021; print November 2021.
- The Sysops Squad narrative case study. Service granularity, workflow orchestration, contracts, distributed transactions, data decomposition patterns.

### 3.4 Michael Nygard, "Documenting Architecture Decisions"

- Michael T. Nygard, "Documenting Architecture Decisions," Cognitect Blog, November 15, 2011, https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions.html (also at https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions).
- Canonical ADR template. Fields: Title, Status (Proposed / Accepted / Deprecated / Superseded), Context, Decision, Consequences.
- Template mirrored at https://github.com/joelparkerhenderson/architecture-decision-record and at https://adr.github.io/.

### 3.5 C4 model (Simon Brown)

- Primary site: https://c4model.com/.
- Wikipedia: https://en.wikipedia.org/wiki/C4_model.
- LeanPub book: Simon Brown, "The C4 model for visualising software architecture," LeanPub, https://leanpub.com/visualising-software-architecture.
- 2024 book: "The C4 Model," O'Reilly, 2024, https://www.oreilly.com/library/view/the-c4-model/9798341660113/.
- "Misuses and Mistakes": https://www.workingsoftware.dev/misuses-and-mistakes-of-the-c4-model/ and Simon Brown's own GOTO 2024 talk at https://gotocph.com/2024/sessions/3326/the-c4-model-misconceptions-misuses-and-mistakes.

### 3.6 arc42 (Peter Hruschka, Gernot Starke)

- Origin: 2005, Dr. Gernot Starke and Dr. Peter Hruschka.
- Current template: https://arc42.org/ and https://github.com/arc42/arc42-template.
- Docs: https://docs.arc42.org/.
- 20th anniversary (February 2025): https://arc42.org/20yrs-ecosystem.
- 12-section template structure (introduction and goals, constraints, context and scope, solution strategy, building block view, runtime view, deployment view, crosscutting concepts, architectural decisions, quality requirements, risks and technical debt, glossary) is the complement to C4: C4 = diagrams; arc42 = document skeleton.

### 3.7 4+1 views (Philippe Kruchten)

- Philippe Kruchten, "Architectural Blueprints: The '4+1' View Model of Software Architecture," IEEE Software, vol. 12 no. 6, November 1995, pp. 42-50.
- PDF: commonly mirrored, e.g., https://www.cs.ubc.ca/~gregor/teaching/papers/4+1view-architecture.pdf (or as cited at https://csse6400.uqcloud.net/slides/views.pdf).
- Wikipedia: https://en.wikipedia.org/wiki/4%2B1_architectural_view_model.
- Views: logical, process, development, physical, plus scenarios (the "+1").

### 3.8 Team Topologies (Skelton / Pais)

- Matthew Skelton, Manuel Pais, "Team Topologies: Organizing Business and Technology Teams for Fast Flow," IT Revolution Press, 2019, ISBN 978-1-942-78881-2, https://teamtopologies.com/book.
- Four team types: stream-aligned, platform, enabling, complicated-subsystem.
- Three interaction modes: collaboration, X-as-a-service, facilitation.
- Central claim: software architecture and team structure are co-determined (Conway's Law, Inverse Conway Maneuver).
- Martin Fowler summary: https://martinfowler.com/bliki/TeamTopologies.html.

### 3.9 Accelerate (Forsgren / Humble / Kim)

- Nicole Forsgren, Jez Humble, Gene Kim, "Accelerate: The Science of Lean Software and DevOps," IT Revolution Press, 2018, ISBN 978-1-942-78833-1, https://itrevolution.com/product/accelerate/.
- Four key DORA metrics: deployment frequency, lead time for changes, change failure rate, time to restore service.
- Architectural claim: "high-performing teams have a loosely coupled architecture," empirically demonstrated across 23,000 survey responses.
- Annual State of DevOps report: https://dora.dev/.

### 3.10 Designing Data-Intensive Applications (Kleppmann)

- 1st ed: Martin Kleppmann, "Designing Data-Intensive Applications: The Big Ideas Behind Reliable, Scalable, and Maintainable Systems," O'Reilly, 2017, ISBN 978-1-449-37332-0, https://www.oreilly.com/library/view/designing-data-intensive-applications/9781491903063/.
- 2nd ed (with Chris Riccomini): expected January 2026, early release March 2025, https://www.oreilly.com/library/view/designing-data-intensive-applications/9781098119058/.
- Canonical reference for data architecture shape (not brand): storage engines, replication, partitioning, transactions, consistency models, stream processing.

### 3.11 Pat Helland papers

- Pat Helland, "Life beyond Distributed Transactions: an Apostate's Opinion," CIDR 2007, January 8 2007, pp. 132-141, https://www.cidrdb.org/cidr07/papers/cidr07p15.pdf. Updated version in ACM Queue, 2016, https://queue.acm.org/detail.cfm?id=3025012.
- Pat Helland, "Immutability Changes Everything," ACM Queue vol 13 no 9, 2015, https://queue.acm.org/detail.cfm?id=2884038; Communications of the ACM vol 59 no 1, January 2016, https://cacm.acm.org/practice/immutability-changes-everything/; CIDR 2015 paper at https://www.cidrdb.org/cidr2015/Papers/CIDR15_Paper16.pdf.
- Also recommended: Pat Helland, "Data on the Outside Versus Data on the Inside," CIDR 2005; "Mind Your State for Your State of Mind," ACM Queue 2018, https://queue.acm.org/detail.cfm?id=3236388.
- The Helland corpus is the foundation for modern distributed-data architecture thinking; anyone picking event sourcing / CQRS / distributed ledger should read these before writing ARCH.md.

### 3.12 Gregor Hohpe: Enterprise Integration Patterns, The Software Architect Elevator

- Gregor Hohpe, Bobby Woolf, "Enterprise Integration Patterns: Designing, Building, and Deploying Messaging Solutions," Addison-Wesley, October 2003, ISBN 978-0-321-20068-6, https://www.enterpriseintegrationpatterns.com/.
- Gregor Hohpe, "The Software Architect Elevator: Redefining the Architect's Role in the Digital Enterprise," O'Reilly, May 2020, ISBN 978-1-492-07754-1, https://www.oreilly.com/library/view/the-software-architect/9781492077534/.
- EIP is the vocabulary for async-messaging architecture (channels, endpoints, routers, transformers, correlation IDs); the SKILL.md integration-architecture section should name these.
- Architect Elevator is the business-IT translation discipline; central to why ARCH.md should bridge PRD (business) and stack-ready (technology).

### 3.13 Other foundational references worth citing

- **"AntiPatterns" (Brown / Malveau / McCormick / Mowbray), Wiley, 1998**, ISBN 978-0-471-19713-3. The origin of "Architecture By Implication," "Cover Your Assets," "Stovepipe System," "Jumble," "Reinvent the Wheel," "Vendor Lock-In."
- **"Big Ball of Mud" (Foote / Yoder), PLoP 1997**, https://www.laputan.org/mud/mud.html. The original characterization of haphazard architecture.
- **Eric Evans, "Domain-Driven Design: Tackling Complexity in the Heart of Software," Addison-Wesley, 2003**, ISBN 978-0-321-12521-7. Bounded contexts, ubiquitous language, aggregates; the framework for deciding service boundaries.
- **Vaughn Vernon, "Implementing Domain-Driven Design," Addison-Wesley, 2013**, ISBN 978-0-321-83457-7. Practical DDD.
- **Roy Fielding, "Architectural Styles and the Design of Network-based Software Architectures," PhD dissertation, UC Irvine, 2000**, https://ics.uci.edu/~fielding/pubs/dissertation/top.htm. Origin of REST; canonical discussion of "architectural style" as a distinct concept from "architecture."

## 4. State of the art 2026

### 4.1 Modular monolith resurgence

- **Shopify.** "Deconstructing the Monolith: Designing Software that Maximizes Developer Productivity," Shopify Engineering, 2019, https://shopify.engineering/deconstructing-monolith-designing-software-maximizes-developer-productivity. "Under Deconstruction: The State of Shopify's Monolith," 2024, https://shopify.engineering/shopify-monolith. The monolith has roughly 2M classes, 4000+ components, 2.8M lines of Ruby, 500K commits, 37 named components in 2024, handled 30TB/minute at BFCM 2025. Open-source tool: **Packwerk** (https://github.com/Shopify/packwerk), enforces component boundaries in a Ruby codebase.
- **Basecamp (DHH).** "The Majestic Monolith," Signal v. Noise, February 29, 2016, https://signalvnoise.com/svn3/the-majestic-monolith/. "The Majestic Monolith can become The Citadel," https://signalvnoise.com/svn3/the-majestic-monolith-can-become-the-citadel/. DHH's long-running Rails-monolith position; reasserted 2020-2024.
- **Stack Overflow.** Still a monolith in 2024. Nick Craver's long-running "Stack Overflow: The Architecture" series (2016 baseline, 2020-2023 updates) documents 9 web servers, 1 SQL Server + hot standby, 2 Redis servers, 3 tag engine servers, 3 Elasticsearch. 450 peak requests per second per server at 12% CPU. See https://nickcraver.com/blog/2016/02/17/stack-overflow-the-architecture-2016-edition/ and Hacker News 2023 thread at https://news.ycombinator.com/item?id=34950843.
- **GitHub.** Ruby on Rails monolith since 2008; well documented by GitHub engineering blog (https://github.blog/engineering/). Has extracted a small number of services (search, git hosting, actions runners) but the application tier remains a single Rails app.
- **Amazon Prime Video (video-quality monitoring service).** "Scaling up the Prime Video audio/video monitoring service and reducing costs by 90%," Primetech on the Amazon side (https://www.primevideotech.com/video-streaming/scaling-up-the-prime-video-audio-video-monitoring-service-and-reducing-costs-by-90), originally by Marcin Kolny, March 22 2023; widely republished (New Stack, https://thenewstack.io/return-of-the-monolith-amazon-dumps-microservices-for-video-monitoring/; DevClass, https://devclass.com/2023/05/05/reduce-costs-by-90-by-moving-from-microservices-to-monolith-amazon-internal-case-study-raises-eyebrows/). Note: single team, single service within Amazon; not "Amazon moved off microservices." Widely mis-cited.

### 4.2 Serverless maturity

- **Where it won.** Event-driven glue code, cron-like scheduled jobs, S3-triggered transforms, low-traffic APIs, auth hooks, webhooks, image resizing, CI/CD runners. AWS Lambda @ 15 years, 10 billion requests/day class. Cold starts < 1% of requests for most workloads (AWS, "Understanding and Remediating Cold Starts: An AWS Lambda Perspective," https://aws.amazon.com/blogs/compute/understanding-and-remediating-cold-starts-an-aws-lambda-perspective/). SnapStart for Java (2022) and provisioned concurrency mitigate cold-start for latency-sensitive workloads.
- **Where it stalled.** Sustained-load APIs (pricing crosses over into cheaper containers at a point); long-running workflows (15-minute Lambda limit); workloads with large in-memory state; vendor lock-in concerns; WebSockets and stateful protocols (better on containers); Amazon Prime Video's case above; Mikhail Shilkov's long-running cold-start benchmarks (https://mikhail.io/serverless/coldstarts/aws/).

### 4.3 Edge compute

- **Cloudflare Workers.** V8 isolate-based; ~0 cold start; global deployment in seconds; 100K requests/day free tier, 10ms CPU time per request. https://workers.cloudflare.com/.
- **Vercel Edge Functions.** V8-based, Cloudflare-adjacent; tightly coupled to Vercel's frontend pipeline.
- **Deno Deploy.** Deno 2 (2024) brought Node.js and npm compatibility; 35+ locations; more generous CPU time per request than Workers.
- **Netlify Edge Functions.** Powered by Deno.
- Consensus in 2026: edge compute has won for geographically sensitive low-latency static + a-tiny-bit-of-logic workloads; still not the right shape for workloads with substantial state, long-running operations, or heavy CPU.
- See DEV.to, "The Modular Monolith 2026 Complete Guide" and "Cloudflare vs Vercel vs Netlify: The Truth about Edge Performance 2026," and Medium / TechPreneur, "Deno Deploy vs Cloudflare Workers vs Vercel Edge Functions 2025" for recent comparative writeups (URLs in section 10 references).

### 4.4 Event-driven adoption

- Apache Kafka remains the dominant event backbone for real-time data pipelines in mid-sized and larger organizations.
- Confluent Cloud and Amazon MSK have reduced the operational cost of Kafka.
- Greenfield event-driven architecture adoption in 2024-2026 has cooled relative to 2018-2021 peak; teams now more likely to reach for message queues (SQS, Cloud Pub/Sub, RabbitMQ) for point-to-point async, Kafka only when they need the log.
- InfoQ Software Architecture and Design Trends Report 2024: https://www.infoq.com/articles/architecture-trends-2024/. Trends Report 2025: https://www.infoq.com/articles/architecture-trends-2025/. Both identify data-driven architecture (ML/analytics into transactional systems) and cell-based architecture as strong signals; event-driven as mature/adopted, not new.

### 4.5 Event sourcing / CQRS adoption

- Consensus as of 2024-2026: event sourcing applied to a whole system is itself an antipattern. Oliver Butzki, "Why Event Sourcing is a microservice communication anti-pattern," DEV.to, https://dev.to/olibutzki/why-event-sourcing-is-a-microservice-anti-pattern-3mcj. InfoQ, "A Whole System Based on Event Sourcing is an Anti-Pattern," 2016, https://www.infoq.com/news/2016/04/event-sourcing-anti-pattern/. Chris Kiehl, "Don't Let the Internet Dupe You, Event Sourcing is Hard," Blogomatano, https://chriskiehl.com/article/event-sourcing-is-hard.
- Practical rule documented in those sources: a history table gets 80% of the "audit log" value with essentially none of the event-sourcing cost.
- CQRS has broader practical adoption for specific bounded contexts (reporting read models, high-contention aggregates) but is similarly over-applied by LLM-generated architecture.

### 4.6 Cell-based architecture

- Canonical AWS writeup: "Reducing the Scope of Impact with Cell-Based Architecture," AWS Well-Architected, https://docs.aws.amazon.com/wellarchitected/latest/reducing-scope-of-impact-with-cell-based-architecture/.
- re:Invent 2024 talks: ARC312 ("Using cell-based architectures for resilient design on AWS," https://reinvent.awsevents.com/content/dam/reinvent/2024/slides/arc/ARC312_Using-cell-based-architectures-for-resilient-design-on-AWS.pdf) and ARC335 (robust cell architectures, https://reinvent.awsevents.com/content/dam/reinvent/2024/slides/arc/ARC335_Learn-to-create-a-robust-easy-to-scale-architecture-with-cells.pdf).
- Cells are partitioned independent replicas. Failures, deploys, and blast radius scope to one cell. The 2024-2026 preferred pattern for resilience at scale; distinct from microservices (cells can be monoliths), distinct from regions (cells are internal to a region).
- InfoQ 2025 trends report identifies cell-based architecture as the "early majority" for resilience-sensitive systems.

### 4.7 Microservices backlash

- Thoughtworks Technology Radar has held microservices at "Trial" not "Adopt" since 2018 (InfoQ, "Microservices to Not Reach Adopt Ring in ThoughtWorks Technology Radar," 2018, https://www.infoq.com/news/2018/06/microservices-adopt-radar/). Guidance: microservices are a valid architectural choice but require organizational maturity (CI/CD, observability, team topology) that most organizations do not have.
- 2023-2024 public walkbacks: Prime Video monitoring service (section 4.1); various Medium and DEV.to writeups ("How we got rid of our microservices"). Twitter (pre-X and early-X) rearchitecture reduced service count substantially under Musk (Q4 2022 through 2024), public details limited but referenced in multiple eng-leader tweets.
- The empirical regret-data gap: there is no DORA-quality longitudinal survey that specifically measures architecture-decision regret. JetBrains State of Developer Ecosystem 2024 (https://www.jetbrains.com/lp/devecosystem-2024/) surveys technologies used but not regret. The StackOverflow Developer Survey (https://survey.stackoverflow.co/) similarly measures use, not regret.

### 4.8 Hexagonal / Clean Architecture / Ports & Adapters critiques

- Alistair Cockburn, "Hexagonal Architecture," 2005 (https://alistair.cockburn.us/hexagonal-architecture/), is the canonical source. Ports and adapters; business logic at the center; IO at the edge.
- Robert C. Martin, "Clean Architecture: A Craftsman's Guide to Software Structure and Design," Prentice Hall, 2017, ISBN 978-0-13-449416-6.
- Critiques:
  - Victor Rentea, "Overengineering in Onion/Hexagonal Architectures," 2024, https://victorrentea.ro/blog/overengineering-in-onion-hexagonal-architectures/. Argues that the formalisms are complex blueprints that need simplification for actual problems, and applying them "by the book" leads to overengineering.
  - Three Dots Labs, "Is Clean Architecture Overengineering?" https://threedots.tech/episode/is-clean-architecture-overengineering/. Answer: it depends; for CRUD-dominant domains, yes.
  - Serge Skoredin, "Hexagonal Architecture in Go: Why Your 'Clean' Code Is Actually a Mess," https://skoredin.pro/blog/golang/hexagonal-architecture-go. Catalog of over-engineered Go Clean Architecture projects.
- Practical consensus 2024-2026: Hexagonal / Clean are valuable for high-domain-complexity projects, specifically where business logic must survive multiple storage / UI / integration changes over many years. For low-domain-complexity projects (CRUD, internal tools, early-stage products), the architecture is a tax that retards shipping.

## 5. Architectural postmortems (outages with architecture-decision root causes)

### 5.1 Knight Capital (August 1, 2012)

- SEC press release, "SEC Charges Knight Capital With Violations of Market Access Rule," October 16, 2013, https://www.sec.gov/newsroom/press-releases/2013-222. $12M settlement.
- ~$460M losses in 45 minutes.
- Architectural root cause: shared-binary deployment with a deprecated flag (`Power Peg`) still in the codebase, activated by a reused bit. One of eight servers was not updated; received new-flag requests; activated old code. Deploy script failed silently on one server.
- Architecture lessons: dead code is not neutral when flags are reused; binary-deployment symmetry was not a property the architecture enforced; there was no kill switch at the capital-exposure level.
- See Henrico Dolfing, "Case Study 4: The $440 Million Software Error at Knight Capital," https://www.henricodolfing.ch/en/case-study-4-the-440-million-software-error-at-knight-capital/; danluu/post-mortems Knight Capital entry.

### 5.2 AWS S3 US-EAST-1 (February 28, 2017)

- AWS official postmortem: "Summary of the Amazon S3 Service Disruption in the Northern Virginia (US-EAST-1) Region," https://aws.amazon.com/message/41926/.
- Root cause: an operator removed more servers than intended during debugging of a billing subsystem. Two S3 subsystems (index, placement) lost capacity; index had to be fully restarted (had not been restarted in years); restart took hours due to accumulated metadata.
- Blast radius: EC2 launches, EBS volumes from snapshots, Lambda, ELB, Redshift, RDS, many third-party services (Quora, Coursera, Docker, Medium, Down Detector). AWS Service Health Dashboard itself was S3-dependent and could not be updated.
- Architecture lessons: single-region dependency is not the same as multi-region; internal dependency graphs matter as much as external ones; "cell-based" refactoring began in response.

### 5.3 Cloudflare July 2, 2019 (regex / WAF)

- Official postmortem: "Details of the Cloudflare outage on July 2, 2019," https://blog.cloudflare.com/details-of-the-cloudflare-outage-on-july-2-2019/.
- Root cause: a WAF rule added a regex with catastrophic backtracking behavior; deployed globally at once; exhausted CPU on every edge server; 27-minute outage.
- Architecture lessons: global-all-at-once deployment for WAF rules was an architectural decision (emergency deploy capability was required for security response); the architecture had no graduated rollout for that class of change; no CPU-per-request circuit breaker; switched to RE2 / Rust regex engines with runtime guarantees.

### 5.4 Facebook BGP October 4, 2021

- Official postmortems: "Update about the October 4th outage," https://engineering.fb.com/2021/10/04/networking-traffic/outage/ and "More details about the October 4 outage," https://engineering.fb.com/2021/10/05/networking-traffic/outage-details/.
- Cloudflare's outside-in analysis: "Understanding how Facebook disappeared from the Internet," https://blog.cloudflare.com/october-2021-facebook-outage/.
- Root cause: a routine backbone-capacity audit command, with a bug in the audit tool that should have caught it, disabled backbone network globally. Facebook's DNS servers are designed to withdraw BGP advertisements when they cannot reach data centers, so DNS disappeared from the internet; internal tools required DNS; recovery required physical access.
- Architecture lesson (the one ARCH.md should cite): **DNS advertised itself via the same network whose health it was attempting to report on.** Internal tools, badge readers, and WhatsApp/Instagram had the same coupling. This is a trust-boundary and dependency-graph failure, not a bug.

### 5.5 GitLab.com database (January 31, 2017)

- Official postmortem: "Postmortem of database outage of January 31," https://about.gitlab.com/blog/postmortem-of-database-outage-of-january-31/.
- Root cause: an engineer deleted the primary PostgreSQL data directory on the wrong server while attempting to restore replication. The secondary was out of sync. Five of five backup mechanisms failed or were misconfigured (`pg_dump` against wrong Postgres version; DMARC rejecting notification emails; Azure disk snapshots not enabled; S3 bucket empty; LVM snapshots from several hours earlier, usable).
- Architecture lesson: backups are not backups until they are tested. "No ownership" for backup testing is an architecture failure, not an ops failure.

### 5.6 Atlassian (April 5-18, 2022)

- Official post-incident review: "Post-Incident Review on the Atlassian April 2022 outage," https://www.atlassian.com/blog/atlassian-engineering/post-incident-review-april-2022-outage.
- Pragmatic Engineer scoop: "The Scoop: Inside the Longest Atlassian Outage of All Time," https://newsletter.pragmaticengineer.com/p/scoop-atlassian.
- Root cause: a deactivation script took site IDs where app IDs were expected, because the deletion API accepted both types of identifier without validation. 775 customers lost production services for up to 14 days. Recovery was manual, batch-of-60 at a time, because multi-tenant-restore was not a first-class operation in the architecture.
- Architecture lesson: polymorphic identifiers in deletion APIs are a trust-boundary failure waiting to happen. Recovery is an architectural feature, not an incident-response feature; design for it up front.

### 5.7 Roblox (October 28-31, 2021, 73 hours)

- Official postmortem: "Roblox Return to Service 10/28-10/31 2021," https://corp.roblox.com/newsroom/2022/01/roblox-return-to-service-10-28-10-31-2021/.
- Root cause: HashiCorp Consul cluster fell over under Roblox's load because (a) a newly enabled Consul streaming feature had Go-channel contention under high read/write, and (b) BoltDB's freelist implementation required a linear scan for every read/write. Compounding factors: Nomad and Vault depended on Consul; monitoring depended on the same cluster; the system could not schedule new containers or retrieve secrets without Consul.
- Architecture lesson: service discovery was a SPOF, and monitoring of service discovery depended on service discovery. "Observability must not share fate with the system it observes."

### 5.8 Other postmortems worth referencing

- **Code Spaces (June 17, 2014)**: AWS account compromise, attacker deleted all S3 buckets / EC2 / RDS / EBS. Company shut down. Architecture lesson: separate backups from the production account.
- **British Airways 2017, 2018, 2019**: Data center power failure cascading across a shared architecture. Multiple hundred-million losses.
- **Fastly June 8, 2021**: Single customer's config change crashed the global edge. Architecture lesson: multi-tenant config validation.
- **Rogers Canada July 8, 2022**: Carrier-wide BGP misconfiguration, 15 million users offline.
- **Crowdstrike July 19, 2024**: A kernel-driver config update broke 8.5M Windows machines worldwide. Architecture lesson: all-at-once global deploy of a kernel-level component was an architectural decision; staged rollout was not mandatory; blast radius was "every Windows computer using the product."
- Canonical postmortem collection: Dan Luu, https://github.com/danluu/post-mortems. 
- AWS post-event summaries: https://aws.amazon.com/premiumsupport/technology/pes/.

## 6. Downstream skill needs from ARCH.md

This section is the schema input for SKILL.md's handoff contract. Every field listed here must either be in ARCH.md or explicitly deferred.

### 6.1 What prd-ready has already committed ARCH.md to produce

From `/Users/hprincivil/Projects/prd-ready/SKILL.md` Step 9 "Downstream handoff block," sub-section "To architecture-ready":

```
## Architecture-ready inputs
- Entities: [the nouns, with key attributes]
- Flows: [the verbs, happy path + at least 2 error paths per primary feature]
- Non-functional requirements: [copied from Step 6]
- Integration points: [named third-parties and internal services]
- Trust boundaries: [who sees what, who mutates what]
- Scale ceiling: [same as stack-ready]
- Compliance constraints: [same as stack-ready]
- Explicitly deferred to architecture: [what the PRD intentionally does not decide]
```

This is the INPUT contract to ARCH.md. ARCH.md's OUTPUT contract needs to serve stack-ready, production-ready, and roadmap-ready.

### 6.2 What stack-ready needs from ARCH.md

From `/Users/hprincivil/Projects/stack-ready/SKILL.md` Step 1 pre-flight and Step 2 constraint map:

- **Domain.** Already resolved by PRD; ARCH.md should not rename.
- **Scale ceiling.** ARCH.md can tighten if the decomposition changes the per-service scale ceiling.
- **Regulatory constraints.** ARCH.md decomposition can change what must be PCI / HIPAA / SOC2 scoped (fewer components in scope = less compliance burden).
- **Storage shape, not brand.** ARCH.md should declare: "this entity needs append-only event storage," "this workload needs graph traversal," "this read is OLAP-shaped," "this workload is key-value with write-heavy." Stack-ready picks the brand; ARCH.md picks the shape.
- **Sync/async boundaries.** Stack-ready needs to know which integration points are synchronous (blocking, latency-bound) vs. asynchronous (message-queued, eventually consistent). This determines queue/broker selection.
- **Self-host / managed tolerance.** Stack-ready picks the product; ARCH.md declares whether the component CAN be managed (e.g., "this database holds PHI, must be self-hostable in a BAA-bound region").

Specifically, stack-ready's `.stack-ready/DECISION.md` template expects ARCH.md to have already settled:
- The set of persistence layers required (not brands).
- The set of queues / message brokers required.
- The set of external integrations with their sync/async nature.
- The auth/identity boundary (one provider or federated?).

### 6.3 What production-ready needs from ARCH.md

From `/Users/hprincivil/Projects/production-ready/SKILL.md` Step 2 architecture note and Step 1 pre-flight:

- **System shape.** "modular monolith," "service-oriented," "serverless functions," etc. Production-ready's Step 2 architecture note quotes this.
- **Trust boundaries.** Production-ready's Step 2 requires a threat model with three answers (attacker-gain, highest-blast-radius mutation, trust-boundary locations). ARCH.md must pre-populate this.
- **Component list with responsibilities.** Not brands; capabilities.
- **Permission-model skeleton.** Role list, resource-by-action matrix. ARCH.md sets the boundary (what is tenant-scoped, what is global, what is admin-only); production-ready implements.
- **Route map skeleton.** Top-level URL structure, API surfaces.
- **Audit-log schema.** What must be logged. Production-ready's Tier 3 requirement #16 is "An audit log"; ARCH.md sets its shape.
- **Event/message contracts.** If async, what messages cross service boundaries. Production-ready's Tier 4 contract-test requirement depends on ARCH.md defining these.

Production-ready's SKILL.md line 461 is explicit:
> **`.architecture-ready/ARCH.md`** | Step 2 (architecture note) | System-level architecture decisions (monolith vs. services, sync vs. async, data-layer shape) adopted wholesale; local architecture note becomes a delta, not a redecision.

So ARCH.md's system-shape, sync-vs-async-decisions, and data-layer-shape are production-ready's architecture-note starting point.

### 6.4 What roadmap-ready will need from ARCH.md (not yet built)

prd-ready Step 9's roadmap-ready sub-section promises:
```
## Roadmap-ready inputs
- Priority ordering: [MoSCoW ranks, aggregated]
- Release-gating criteria: [per feature, what must be true to ship]
- Dependencies: [feature X blocks feature Y]
- Must-haves vs. nice-to-haves: [the cut line]
- Rabbit holes: [from Step 7]
- Dates or ranges: [contractual deadlines, marketing windows, regulatory dates]
```

The research brief for this file specifies: "roadmap-ready not yet built but described in prd-ready's handoff: priorities, dependencies, rabbit holes; architecture supplies the COMPONENT DEPENDENCY GRAPH."

ARCH.md's component dependency graph answers: "which components can be built first, which have to follow, which have circular dependencies that need breaking." Roadmap-ready reads this to propose a sequence that does not attempt to build C before B when C depends on B.

Specifically, ARCH.md should emit:
- **Component dependency graph.** Nodes are components; edges are dependencies (A depends on B means A's integration tests need B). Edge labels are sync/async.
- **Critical path.** The longest-dependency chain. Roadmap-ready's first-ship-date estimate depends on this.
- **Parallelism surface.** Which components can be built simultaneously.
- **Build-order constraints.** "Auth must be built before any tenant-scoped component." "Audit log must exist before any regulated-domain CRUD." "Event bus must be deployable before any async-consuming service."

### 6.5 Recommended ARCH.md artifact schema

Based on the downstream needs above, ARCH.md should have these sections:

```markdown
# ARCH.md

## Skill version
architecture-ready [version], [date].

## Upstream inputs consumed
(copied from .prd-ready/HANDOFF.md "Architecture-ready inputs")

## System shape
One of: single-process monolith / modular monolith / service-oriented / microservices /
event-driven / serverless / edge-compute-dominant / cell-based / hybrid.
Rationale: one paragraph. What flips it: one paragraph. Scale ceiling: numeric.

## Component breakdown
| Component | Responsibility | Owner (team topology) | Trust boundary | Public interface |
...

## Data architecture
Entities and storage SHAPE per entity (not brand):
- Relational OLTP
- Append-only event log
- Time-series
- Key-value
- Document
- Graph
- Full-text search
- Blob/object
- Analytics/OLAP
Retention, consistency model, PII status, encryption requirement per entity.

## Integration architecture
For every inter-component edge:
- Sync or async
- Protocol (REST / gRPC / message queue / event bus / webhook)
- Idempotency strategy
- Failure semantics (retry / dead-letter / fail-closed / fail-open)
- Versioning strategy (in-place / expand-contract / parallel)

## Non-functional architecture
For each NFR from PRD Step 6, the architectural response:
- Latency target -> which components contribute, caching strategy, SLA math
- Throughput target -> scaling strategy, bottleneck component
- Availability target -> redundancy, blast radius, degradation plan
- Security / compliance -> trust boundaries, encryption, audit
- Privacy -> PII segregation, retention
- Observability -> tracing, logging, metrics boundaries

## Trust boundaries
Network edge, session, role, tenant, regulatory. Map each boundary to which components it cuts through.

## Threat model (pre-fill for production-ready Step 2)
- What an attacker gains.
- Highest-blast-radius mutation.
- Where each trust boundary is.
- Compliance blast radius (if regulated).

## Component dependency graph
Emit as DOT / Mermaid / adjacency list. Critical path noted.

## Evolutionary architecture
Fitness functions to enforce the architecture over time:
- Module boundaries (e.g., Packwerk / ArchUnit / dependency-cruiser rules)
- Dependency direction (no cycles, layered constraints)
- Performance budgets (p95, p99)
- Security invariants (no PII in logs, TLS everywhere)

## ADR corpus
Link to .architecture-ready/adr/*.md.

## Rejected shapes
Three alternative shapes considered and why they lost.

## What this architecture does NOT decide
(explicitly deferred to stack-ready, production-ready, roadmap-ready, deploy-ready)

## Handoff block
- To stack-ready: storage shapes, broker shapes, integration list
- To production-ready: system shape, trust boundaries, threat model, audit schema
- To roadmap-ready: component dependency graph, critical path, parallelism surface
- To deploy-ready: deployment topology, cell boundaries, rollback unit
- To observe-ready: observability boundaries, SLO targets per component
```

This is the minimum. Everything below it is optional detail.

## 7. Diagrams and ADR practice in the wild

### 7.1 ADR practice

- Michael Nygard, "Documenting Architecture Decisions," 2011 (cited 3.4). Canonical template.
- **adr-tools** (Nat Pryce, 2014; widely forked): https://github.com/npryce/adr-tools. Bash CLI. ADR files numbered sequentially. `adr new "Title"` generates a new ADR. `adr link N supersedes M` marks M superseded.
- **adr-tools (Henderson fork)**: https://github.com/joelparkerhenderson/architecture-decision-record. Joel Parker Henderson's curated templates and examples.
- **log4brains** (Thomas Vaillant, 2020-present): https://github.com/thomvaill/log4brains. Generates a static-site ADR knowledge base from a local Markdown repo. Own ADRs are dog-fooded at https://thomvaill.github.io/log4brains/adr/.
- **adr.github.io**: https://adr.github.io/. Community home, template catalog, tooling directory.
- **arc42 Section 9 "Architecture decisions"**: https://docs.arc42.org/section-9/. arc42's integrated ADR slot.

Exemplar ADR repositories on GitHub (public, dog-fooded):
- https://github.com/cloudfoundry/community/tree/main/toc/rfc (CloudFoundry RFCs, RFC-style variant)
- https://github.com/openvex/spec (ADRs in a growing spec)
- Log4brains own ADRs (linked above) as the "how to write these well" reference.
- https://github.com/thomvaill/log4brains/tree/master/docs/adr for the tool's own decision history.

### 7.2 ADR failure modes in the wild

Documented in the 2024-2026 cohort of ADR-practice blog posts (DEV.to, Medium) and in IcePanel, "Architecture decision records (ADRs)" (https://icepanel.medium.com/architecture-decision-records-adrs-5c66888d8723):

1. **Retroactive ADRs.** Written after the decision was already implemented, for compliance. The rationale section is reverse-engineered. Low value because the alternatives considered are the ones the author remembers, not the ones that were on the table.
2. **ADRs never superseded.** A decision is reversed but the old ADR is silently abandoned. Readers 6 months later cannot tell which of two conflicting ADRs is current.
3. **ADRs for trivial decisions.** "ADR-042: Use tab-indented YAML." Dilutes the corpus.
4. **ADRs with no "alternatives considered."** The Nygard template has Context, Decision, Consequences; many teams omit the "what else we considered" that makes the ADR load-bearing.
5. **ADRs written by AI with invented alternatives.** Plausible-looking alternatives that were never actually on the table; readers cannot tell.
6. **ADRs buried in Confluence.** Physical location of ADRs matters: co-located with code, versioned with code, reviewed with code. Confluence-resident ADRs go stale within 6 months.

SKILL.md should specify: ADRs live in `.architecture-ready/adr/NNNN-slug.md`; numbered sequentially; Nygard format; "Alternatives" section mandatory; superseded ADRs retained, not deleted; new ADR links to the one it supersedes.

### 7.3 C4 diagram failure modes in practice

Simon Brown's own catalog, "The C4 Model: Misconceptions, Misuses, and Mistakes," GOTO 2024 (https://gotocph.com/2024/sessions/3326/the-c4-model-misconceptions-misuses-and-mistakes) and Working Software's writeup (https://www.workingsoftware.dev/misuses-and-mistakes-of-the-c4-model/):

1. **Mixing abstraction levels.** A Container diagram with Components inside a Container. Breaks the "one abstraction per diagram" rule.
2. **Inconsistent notation.** Different shapes for the same concept across diagrams.
3. **Inconsistent naming.** The same service called "Auth Service" in one diagram and "Identity" in the next.
4. **Ambiguous arrows.** An arrow between two containers with no label specifies nothing. C4 expects: protocol, purpose, sync/async.
5. **Missing the "Context" diagram entirely.** Jumping straight to Container.
6. **Container-as-component confusion.** Brown's own writing flags that "container" is a badly chosen word; people confuse it with Docker containers. The C4 container is a deployable unit (web app, API, database, file system) and is named independently of deployment technology.
7. **Never updating the diagrams.** C4 diagrams go stale faster than ADRs because the visual form hides drift.

SKILL.md should: default to C4 (Context, Container, Component) but not fetishize; demand explicit arrow semantics; co-locate diagrams with ADRs; allow Mermaid/PlantUML/Structurizr for text-first, diff-able diagrams.

## 8. Evolutionary architecture and fitness functions

### 8.1 Concept origin

Ford / Parsons / Kua, "Building Evolutionary Architectures," O'Reilly, 2017 (1st ed). 2nd ed (with Sadalage) 2023. The central concept: **fitness functions** are automated (unit-test-like) checks that the architecture still has the properties the team decided it should have, run on every commit.

Three pillars: **fitness functions**, **incremental change**, **appropriate coupling** (https://evolutionaryarchitecture.com/).

### 8.2 Concrete tools

- **ArchUnit (Java).** https://github.com/TNG/ArchUnit. Java library for asserting architecture rules as JUnit tests. Package-level dependency rules, layer rules, annotation rules, naming conventions. Baeldung intro: https://www.baeldung.com/java-archunit-intro. InfoQ "Fitness Functions for Your Architecture": https://www.infoq.com/articles/fitness-functions-architecture/.
- **dependency-cruiser (JS/TS).** https://github.com/sverweij/dependency-cruiser. CLI and CI tool for enforcing import rules, detecting cycles, visualizing dependencies. Used in production at GitLab (see `config/dependency_cruiser.js` in the GitLab monorepo).
- **Packwerk (Ruby).** https://github.com/Shopify/packwerk. Shopify's internal tool, open-sourced. Enforces package boundaries in Ruby monoliths.
- **NDepend / Structure101 (.NET, Java).** Commercial architecture governance tools.
- **Sonargraph Explorer.** Commercial.
- **OpenRewrite / PMD / ESLint custom rules.** Can encode fitness-function-like checks.

### 8.3 Evidence that fitness functions work

- ArchUnit production case studies: catching DDD domain-boundary violations in the CI pipeline. "Instead of quarterly architecture reviews, you get feedback on every commit" (InfoQ, 2021).
- Shopify's Packwerk is the production existence proof at scale: a 2.8M-line Ruby monolith with enforced component boundaries across 4000+ components and hundreds of concurrent contributors. Without the fitness function, the monolith would have degenerated into a big ball of mud long before 2024.
- InfoQ Architecture Trends 2024 and 2025 list fitness functions in the "early majority" stage.
- The counterfactual: teams without fitness functions report architecture drift within 6-12 months of any ADR being written. (Source: DEV.to, "Stop Architecture Drift: Operationalizing ADRs with Automated Fitness Functions," https://dev.to/alexandreamadocastro/stop-architecture-drift-operationalizing-adrs-with-automated-fitness-functions-22oi.)

### 8.4 What SKILL.md should require

At minimum, ARCH.md should name at least one fitness function per architectural invariant the decision relies on:
- If "modular monolith": a module-boundary check (ArchUnit / Packwerk / dependency-cruiser).
- If "layered": a layer-direction check.
- If "event-driven": a schema-compatibility check on event payloads.
- If "p95 < 200ms": a performance regression budget in CI.
- If "no PII in logs": a log-redaction test.
- If "tenant-isolated": a cross-tenant leakage test.

An architecture decision without a fitness function will drift. SKILL.md should enforce "every load-bearing architectural decision has a named enforcement mechanism or is explicitly flagged as un-enforceable."

## 9. "Named-term availability" summary table

| Candidate term | Verdict | Action for SKILL.md |
|---|---|---|
| architecture theater | CONTESTED, low-frequency | ADOPT and define |
| paper tiger architecture | AVAILABLE (non-software "paper tiger" usage only) | COIN |
| cargo-cult cloud-native | CONTESTED, informal usage established | USE as descriptor, cite prior art |
| stackitecture | AVAILABLE | COIN |
| resume-driven architecture / development | TAKEN (Fritzsch et al. 2021) | CITE, reuse |
| distributed monolith | TAKEN (Newman) | CITE, reuse |
| non-architecture | AVAILABLE in exact phrase | COIN (narrow definition) |
| big ball of mud | TAKEN (Foote / Yoder 1997) | CITE |
| accidental architecture | CONTESTED, informal | USE with credit to Brown et al. |
| architecture by implication | TAKEN (DevIQ / SourceMaking) | CITE |
| architecture astronautics | TAKEN (SourceMaking) | CITE |
| cover your assets | TAKEN (Brown et al. 1998) | CITE |
| golden hammer | TAKEN (Brown et al. 1998) | CITE |
| horoscope architecture | AVAILABLE | COIN (consistent with stack-ready vocabulary) |
| ghost architecture | AVAILABLE | COIN (candidate for "doc-reality drift") |

## 10. References (consolidated URL list)

Books and papers (canonical):
- Brown / Malveau / McCormick / Mowbray, "AntiPatterns," Wiley, 1998. https://sourcemaking.com/antipatterns/software-architecture-antipatterns
- Cockburn, "Hexagonal Architecture," 2005. https://alistair.cockburn.us/hexagonal-architecture/
- Evans, "Domain-Driven Design," Addison-Wesley, 2003.
- Fielding, "Architectural Styles and the Design of Network-based Software Architectures," UC Irvine, 2000. https://ics.uci.edu/~fielding/pubs/dissertation/top.htm
- Foote / Yoder, "Big Ball of Mud," PLoP 1997. https://www.laputan.org/mud/mud.html
- Ford / Parsons / Kua, "Building Evolutionary Architectures," O'Reilly, 1st ed 2017. https://evolutionaryarchitecture.com/
- Ford / Parsons / Kua / Sadalage, "Building Evolutionary Architectures," 2nd ed, O'Reilly, 2023. https://www.oreilly.com/library/view/building-evolutionary-architectures/9781492097532/
- Ford / Richards / Sadalage / Dehghani, "Software Architecture: The Hard Parts," O'Reilly, 2021. https://www.oreilly.com/library/view/software-architecture-the/9781492086888/
- Forsgren / Humble / Kim, "Accelerate," IT Revolution, 2018. https://itrevolution.com/product/accelerate/
- Fowler, "Refactoring," Addison-Wesley, 2nd ed 2018.
- Fowler, "MonolithFirst," 2015. https://martinfowler.com/bliki/MonolithFirst.html
- Fritzsch / Wyrich / Bogner / Wagner, "Résumé-Driven Development," ICSE 2021. https://arxiv.org/abs/2101.12703
- Helland, "Life beyond Distributed Transactions," CIDR 2007. https://www.cidrdb.org/cidr07/papers/cidr07p15.pdf
- Helland, "Immutability Changes Everything," ACM Queue 2015. https://queue.acm.org/detail.cfm?id=2884038
- Hohpe / Woolf, "Enterprise Integration Patterns," Addison-Wesley, 2003. https://www.enterpriseintegrationpatterns.com/
- Hohpe, "The Software Architect Elevator," O'Reilly, 2020. https://www.oreilly.com/library/view/the-software-architect/9781492077534/
- Kleppmann, "Designing Data-Intensive Applications," 1st ed, O'Reilly, 2017. https://www.oreilly.com/library/view/designing-data-intensive-applications/9781491903063/
- Kleppmann / Riccomini, "Designing Data-Intensive Applications," 2nd ed, O'Reilly, early release 2025, GA January 2026. https://www.oreilly.com/library/view/designing-data-intensive-applications/9781098119058/
- Kruchten, "Architectural Blueprints: The '4+1' View Model of Software Architecture," IEEE Software, 1995. https://en.wikipedia.org/wiki/4%2B1_architectural_view_model
- Martin, "Clean Architecture," Prentice Hall, 2017.
- Newman, "Monolith to Microservices," O'Reilly, 2019. https://samnewman.io/books/monolith-to-microservices/
- Nygard, "Documenting Architecture Decisions," Cognitect Blog, 2011. https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions.html
- Richards / Ford, "Fundamentals of Software Architecture," 1st ed, O'Reilly, 2020. https://www.oreilly.com/library/view/fundamentals-of-software/9781492043447/
- Richards / Ford, "Fundamentals of Software Architecture: A Modern Engineering Approach," 2nd ed, O'Reilly, 2024. https://www.oreilly.com/library/view/fundamentals-of-software/9781098175504/
- Skelton / Pais, "Team Topologies," IT Revolution, 2019. https://teamtopologies.com/book
- Vernon, "Implementing Domain-Driven Design," Addison-Wesley, 2013.

Blogs, posts, postmortems:
- AWS Message 41926 (S3 US-EAST-1, Feb 2017). https://aws.amazon.com/message/41926/
- AWS re:Invent 2024 ARC312 (cell-based architecture). https://reinvent.awsevents.com/content/dam/reinvent/2024/slides/arc/ARC312_Using-cell-based-architectures-for-resilient-design-on-AWS.pdf
- AWS Lambda cold starts (2024). https://aws.amazon.com/blogs/compute/understanding-and-remediating-cold-starts-an-aws-lambda-perspective/
- AWS Well-Architected, "Reducing the Scope of Impact with Cell-Based Architecture." https://docs.aws.amazon.com/wellarchitected/latest/reducing-scope-of-impact-with-cell-based-architecture/
- Amazon Prime Video monolith post (Kolny, March 2023). https://www.primevideotech.com/video-streaming/scaling-up-the-prime-video-audio-video-monitoring-service-and-reducing-costs-by-90
- Atlassian Post-Incident Review April 2022. https://www.atlassian.com/blog/atlassian-engineering/post-incident-review-april-2022-outage
- Bhatti, "When Copying Kills Innovation" (cargo cult), 2025. https://weblog.plexobject.com/archives/7080
- Brown, "The C4 Model: Misconceptions, Misuses, and Mistakes," GOTO 2024. https://gotocph.com/2024/sessions/3326/the-c4-model-misconceptions-misuses-and-mistakes
- Cloudflare, "Understanding how Facebook disappeared from the Internet," 2021. https://blog.cloudflare.com/october-2021-facebook-outage/
- Cloudflare, "Details of the Cloudflare outage on July 2, 2019." https://blog.cloudflare.com/details-of-the-cloudflare-outage-on-july-2-2019/
- DevIQ, "Architecture by Implication." https://deviq.com/antipatterns/architecture-by-implication/
- DHH, "The Majestic Monolith," Signal v. Noise, 2016. https://signalvnoise.com/svn3/the-majestic-monolith/
- DHH, "The Majestic Monolith can become The Citadel." https://signalvnoise.com/svn3/the-majestic-monolith-can-become-the-citadel/
- Dolfing, "Case Study 4: The $440 Million Software Error at Knight Capital." https://www.henricodolfing.ch/en/case-study-4-the-440-million-software-error-at-knight-capital/
- Facebook Engineering, "Update about the October 4th outage." https://engineering.fb.com/2021/10/04/networking-traffic/outage/
- Facebook Engineering, "More details about the October 4 outage." https://engineering.fb.com/2021/10/05/networking-traffic/outage-details/
- GitLab, "Postmortem of database outage of January 31," 2017. https://about.gitlab.com/blog/postmortem-of-database-outage-of-january-31/
- Haryanto, "My LLM Architectural Review," 2024. https://medium.com/@cyharyanto/my-llm-architectural-review-63c0f940b225
- InfoQ Architecture and Design Trends Report 2024. https://www.infoq.com/articles/architecture-trends-2024/
- InfoQ Architecture and Design Trends Report 2025. https://www.infoq.com/articles/architecture-trends-2025/
- InfoQ, "A Whole System Based on Event Sourcing is an Anti-Pattern," 2016. https://www.infoq.com/news/2016/04/event-sourcing-anti-pattern/
- InfoQ, "Microservices Ending up as a Distributed Monolith," 2016. https://www.infoq.com/news/2016/02/services-distributed-monolith/
- InfoQ, "Microservices to Not Reach Adopt Ring in ThoughtWorks Technology Radar," 2018. https://www.infoq.com/news/2018/06/microservices-adopt-radar/
- InfoQ, "Fitness Functions for Your Architecture." https://www.infoq.com/articles/fitness-functions-architecture/
- Kiehl, "Don't Let the Internet Dupe You, Event Sourcing is Hard." https://chriskiehl.com/article/event-sourcing-is-hard
- Korokithakis, "The microservices cargo cult," 2015. https://www.stavros.io/posts/microservices-cargo-cult/
- Luu, post-mortems collection. https://github.com/danluu/post-mortems
- New Stack, "Return of the Monolith: Amazon Dumps Microservices for Video Monitoring." https://thenewstack.io/return-of-the-monolith-amazon-dumps-microservices-for-video-monitoring/
- Nick Craver, "Stack Overflow: The Architecture 2016 Edition." https://nickcraver.com/blog/2016/02/17/stack-overflow-the-architecture-2016-edition/
- Pragmatic Engineer, "The Scoop: Inside the Longest Atlassian Outage." https://newsletter.pragmaticengineer.com/p/scoop-atlassian
- Pragmatic Engineer, "Software engineering with LLMs in 2025: reality check," 2025. https://newsletter.pragmaticengineer.com/p/software-engineering-with-llms-in-2025
- Rentea, "Overengineering in Onion/Hexagonal Architectures," 2024. https://victorrentea.ro/blog/overengineering-in-onion-hexagonal-architectures/
- Roblox, "Roblox Return to Service 10/28-10/31 2021." https://corp.roblox.com/newsroom/2022/01/roblox-return-to-service-10-28-10-31-2021/
- SEC press release, Knight Capital settlement, 2013. https://www.sec.gov/newsroom/press-releases/2013-222
- Shopify Engineering, "Deconstructing the Monolith," 2019. https://shopify.engineering/deconstructing-monolith-designing-software-maximizes-developer-productivity
- Shopify Engineering, "Under Deconstruction: The State of Shopify's Monolith," 2024. https://shopify.engineering/shopify-monolith
- Skoredin, "Hexagonal Architecture in Go: Why Your 'Clean' Code Is Actually a Mess." https://skoredin.pro/blog/golang/hexagonal-architecture-go
- Three Dots Labs, "Is Clean Architecture Overengineering?" https://threedots.tech/episode/is-clean-architecture-overengineering/
- ThoughtWorks Technology Radar. https://www.thoughtworks.com/radar
- ThoughtWorks Radar (Microservices technique). https://www.thoughtworks.com/radar/techniques/microservices
- ThoughtWorks Radar (Layered microservices architecture). https://www.thoughtworks.com/radar/techniques/layered-microservices-architecture
- Troitskyi, "Cargo Cult in Software Engineering." https://troitskyioleksandr.substack.com/p/cargo-cult-in-software-engineering
- Working Software, "Misuses and Mistakes of the C4 model." https://www.workingsoftware.dev/misuses-and-mistakes-of-the-c4-model/

Tools (fitness functions, ADR, modeling):
- adr-tools (Pryce). https://github.com/npryce/adr-tools
- adr.github.io community. https://adr.github.io/
- architecture-decision-record (Henderson). https://github.com/joelparkerhenderson/architecture-decision-record
- ArchUnit. https://github.com/TNG/ArchUnit
- arc42 template. https://github.com/arc42/arc42-template
- arc42 docs. https://docs.arc42.org/
- C4 model. https://c4model.com/
- dependency-cruiser. https://github.com/sverweij/dependency-cruiser
- log4brains. https://github.com/thomvaill/log4brains
- log4brains knowledge base demo. https://thomvaill.github.io/log4brains/adr/
- Packwerk (Shopify). https://github.com/Shopify/packwerk
- Structurizr (Simon Brown, C4 modeling). https://structurizr.com/

Trade publications referenced:
- DevOps.com, "Best of 2023: Microservices Sucks." https://devops.com/microservices-amazon-monolithic-richixbw/
- DevClass, "Reduce costs by 90% by moving from microservices to monolith." https://devclass.com/2023/05/05/reduce-costs-by-90-by-moving-from-microservices-to-monolith-amazon-internal-case-study-raises-eyebrows/
- Portainer, "The Kubernetes Cargo Cult." https://www.portainer.io/blog/the-kubernetes-cargo-cult-why-the-cncf-stack-isnt-the-only-way

## 11. Final recommendation: what SKILL.md should coin

Based on the research:

**Coin:**
- "Architecture theater" (doc renders, decides nothing).
- "Paper tiger architecture" (looks robust, collapses on first real load).
- "Stackitecture" (stack choice masquerading as architecture).
- "Ghost architecture" (doc and running system disagree).
- "Horoscope architecture" (reads plausibly for any product; fails substitution test).
- "Non-architecture" (explicit decision to defer architectural decisions indefinitely).

**Cite and reuse (do not recoin):**
- Distributed monolith (Newman).
- Resume-driven architecture / development (Fritzsch et al.).
- Big ball of mud (Foote / Yoder).
- Architecture by implication, cover your assets, architecture astronautics, golden hammer, accidental architecture (SourceMaking / Brown et al.).
- Cargo-cult architecture (Korokithakis / general folklore).
- Speculative generality / premature abstraction (Fowler).

**Document the AI-slop architecture signature explicitly** as a refusal target, parallel to prd-ready's banned-phrase list and AI-slop PRD audit mode:
- Lists components without rationale.
- Draws arrows without protocol, direction, or failure semantics.
- Claims "scalable" without numbers.
- Picks microservices / Kafka / K8s / event-sourcing by training-data frequency, not by problem shape.
- Omits what was rejected and why.
- Omits NFR numbers from PRD Step 6.
- Omits trust boundaries.
- Omits the component dependency graph.
- Omits fitness functions.
- Renders but does not decide.

**The architecture-ready core principle should parallel prd-ready's:**

> Every architectural decision is one of three things: a decision with rationale and alternatives rejected, a flagged hypothesis with a validation plan (including a fitness function), or a named open question with an owner and a due date. Every diagram names what it shows and at what level; every arrow names its protocol, direction, and failure semantics; every number traces to a PRD NFR or a reasoned extrapolation.

This is the test a single architect, a team, a downstream skill, or an LLM reviewer can apply sentence by sentence, arrow by arrow, and component by component.

## 12. Gaps in this research pass (flagged for future work)

- **Empirical architecture-decision regret data.** Neither DORA nor JetBrains nor InfoQ publishes longitudinal data specifically on architecture decisions reversed. A future research pass should survey engineering-leadership blog posts for "we rearchitected" / "we moved back to a monolith" / "we deleted our service mesh" posts and categorize the reasons.
- **Non-English architecture practice.** arc42 is strong in the German-speaking world; the English-speaking Anglo-American literature underweights it. Future passes should pull German, Japanese, and French architecture-discipline writing.
- **AI-generated architecture case studies.** Actual in-the-wild AI-generated ARCH.md samples from Claude / ChatGPT / Gemini / Copilot would sharpen the refusal list. This research pass used secondhand complaints; firsthand AI-slop samples would be better.
- **Quantitative comparison of ADR-adoption outcomes.** "ADRs improve onboarding time by X%" claims are anecdotal; a real study would strengthen the SKILL.md case for the corpus.
- **Cost-of-migration data by architecture shape.** How much does it actually cost (engineer-weeks) to move from monolith to service-oriented, or from event-driven back to CRUD? Sam Newman has anecdotes; no rigorous dataset.

End of RESEARCH-2026-04.md.

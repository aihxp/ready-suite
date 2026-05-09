# Architecture Ready

> **Given a PRD, produce an architecture that says what system shape to build and why, before any code is written or any tool is chosen. Refuses architecture theater, paper-tiger architecture, cargo-cult cloud-native, stackitecture, resume-driven architecture, horoscope architecture, ghost architecture, and "scalable" as a claim with no numbers.**

> **Part of the [ready-suite](SUITE.md)**, a composable set of AI skills covering the full arc from idea to launch (planning, building, shipping). See [`SUITE.md`](SUITE.md) for the full map and the live sibling skills.

A founder, tech lead, or staff engineer asks Claude or ChatGPT or Gemini to "design the architecture" and gets back a seven-page document with a C4 context diagram, a container diagram, a microservices breakdown, a Kafka event bus, a Redis cache, a Kubernetes deployment topology, an API gateway, and a "scalable, resilient, observable" summary. The document looks professional. It names twelve components. It cites "industry best practices." It decides nothing. Every decision is either the default a senior engineer would never write down (use HTTPS, log errors, back up the database) or the impressive-looking option that matches no constraint in the PRD (event sourcing for a CRUD app, a service mesh for a team of three, eventual consistency for an accounting ledger). The team starts building. In month three the architecture is quietly abandoned and the real architecture, the one the code actually shipped, is something else entirely, undocumented, and unexamined.

None of that is a drawing-tool bug. Draw.io, Lucidchart, Excalidraw, Mermaid, Structurizr, and Miro will happily render any diagram you hand them. The tool has no opinion about whether the container diagram has a rationale, whether the service boundaries cross a trust boundary without noticing, or whether the event-sourcing decision has a use case. This skill is the layer above the tool. It refuses to call a box a decision if it has no flip point. It refuses to call an arrow an integration if the sync/async, idempotency, and failure mode are unnamed. It refuses to call a service architecture if multiple services write to the same table. It refuses to pick microservices without a forcing function tied to the PRD's non-functionals.

## Install

**Claude Code:**
```bash
git clone https://github.com/aihxp/architecture-ready.git ~/.claude/skills/architecture-ready
```

**Codex:**
```bash
git clone https://github.com/aihxp/architecture-ready.git ~/.codex/skills/architecture-ready
```

**pi, OpenClaw, or any [Agent Skills](https://agentskills.io)-compatible harness:**
```bash
git clone https://github.com/aihxp/architecture-ready.git ~/.agents/skills/architecture-ready
```

**Cursor:**
```bash
git clone https://github.com/aihxp/architecture-ready.git ~/.cursor/skills/architecture-ready
```

**Windsurf or other agents:**
Add `SKILL.md` to your project rules or system prompt. Load reference files as needed.

**Any agent with a plan-then-execute loop:**
Upload `SKILL.md` and the relevant reference files to your project context. The skill produces structured output (system shape decisions, component tables, storage-shape maps, integration tables, NFR chains, trust-boundary maps, ADR corpora, C4 diagrams in text format, fitness-function specs, downstream handoff blocks) that any planner can consume.

## The problem this solves

AI-generated architecture documents fail in a narrow, predictable band. The research pass ([RESEARCH-2026-04.md](references/RESEARCH-2026-04.md)) catalogs eight recurring failure modes drawn from Neal Ford, Mark Richards, Rebecca Parsons, Martin Fowler, Sam Newman, Simon Brown, Michael Nygard, Eric Evans, Pat Helland, Martin Kleppmann, Gregor Hohpe, Gregory Hohpe, Adam Shostack, Matthew Skelton, Manuel Pais, ThoughtWorks Tech Radar, InfoQ, 37signals, Shopify Engineering, Stack Overflow Engineering, GitHub Engineering, the Pragmatic Engineer, and public postmortems from Amazon (S3 2017, Prime Video 2023), Cloudflare (2019), Facebook (BGP 2021), Knight Capital (2012), GitLab (2017), Roblox (2021), Atlassian (2022). The failures cluster into eight named patterns. Six are this skill's load-bearing vocabulary:

- **Architecture theater.** Diagrams and ADRs render but decide nothing. Every element passes visual review; every element collapses on "what would flip this" questioning. The AI-slop signature form of the older "Cover Your Assets" antipattern (Brown / Malveau / McCormick / Mowbray, 1998).
- **Paper-tiger architecture.** Reads robust on paper (HA databases, circuit breakers, redundant regions mentioned) but the latency chain, throughput chain, and availability chain have never been computed. Collapses on the first real load.
- **Cargo-cult cloud-native.** Kubernetes, Kafka, service mesh, event sourcing, CQRS adopted with no PRD-grounded justification. "Because it scales" is not a justification without a number. Named by Stavros Korokithakis (2015), extended to Kubernetes by Portainer (2024) and to event-sourcing by InfoQ (2016).
- **Stackitecture.** The architecture section is a stack list. Next.js plus Postgres plus Prisma plus Clerk, with no system-shape decision above it. Tool choices masquerading as architecture. (Coined here.)
- **Horoscope architecture.** The prose reads plausibly for any product in any category. "The system uses a scalable backend with a well-designed data layer." Fails the substitution test against two competitors in the same space. (Coined here.)
- **Ghost architecture.** The ARCH.md describes one system; the running system is a different one. No fitness function catches the drift. (Coined here.)

The research also names two secondary patterns as rhetorical flourishes: **resume-driven architecture** (Fritzsch et al., ICSE 2021) and **non-architecture** ("we'll figure it out later" dressed as agility). The six primary names plus these two are the skill's vocabulary.

architecture-ready exists because none of the architecture-authoring tools refuse any of these shapes. C4 renderers, drawing tools, and wiki platforms will render whatever you draw; they have no opinion about whether the document decides anything. The skill is the layer above the tool that catches the architecture before it ships downstream to stack-ready (which will pick the wrong tools for the wrong shape), to roadmap-ready (which will sequence the wrong components in the wrong order), and to production-ready (which will build the wrong thing from the wrong threat model).

## When this skill should trigger

The short frontmatter description is tight on purpose, to speed up skill-routing decisions. The full trigger surface lives here.

**Positive triggers (design or refine the architecture):**
- "design the architecture" / "what does the architecture look like" / "architect this"
- "system design" / "system diagram" / "high-level design" / "HLD"
- "monolith or microservices" / "service boundaries" / "bounded contexts"
- "data architecture" / "entity model" / "ERD" / "how should we store this"
- "integration architecture" / "how do the services talk" / "sync or async"
- "non-functional requirements" / "NFRs" / "map NFRs to architecture"
- "trust boundaries" / "threat model inputs"
- "ADR" / "architectural decision record" / "write an ADR for X"
- "C4 diagram" / "arc42" / "4+1 views" / "Structurizr" / "Mermaid architecture diagram"
- "fitness functions" / "architecture conformance" / "architectural drift"
- "review this architecture" / "is this architecture any good"
- "rearchitect" / "migration architecture" / "cut over from monolith"

**Implied triggers (the word "architecture" is never spoken):**
- "we're starting a new project and the PRD is done, what next"
- "what shape should this take"
- "should we have one service or many"
- "where do we put the queue / cache / search / event log"
- "can we use the same database across all these features"
- "how do we prevent cross-tenant leaks"
- "the team is growing; should we split the codebase"

**Mode triggers (see [SKILL.md](SKILL.md) Step 0):**
- **Mode A (Greenfield):** net-new system, PRD in hand.
- **Mode B (Assessment):** existing codebase, document the architecture as it actually is.
- **Mode C (Theater audit):** an AI-generated ARCH.md exists and fails the core principle.
- **Mode D (Refresh):** existing ARCH.md is stale.
- **Mode E (Evolution / rearchitecture):** the shape is changing materially.
- **Mode F (Rescue):** the architecture is misbehaving in production.

**Negative triggers (route elsewhere):**
- **Product requirements.** That is [`prd-ready`](https://github.com/aihxp/prd-ready).
- **Specific tools, frameworks, databases, auth providers.** That is [`stack-ready`](https://github.com/aihxp/stack-ready). architecture-ready names storage and compute shapes; stack-ready picks the actual product.
- **Timeline and sequencing.** That is `roadmap-ready` (not yet released).
- **Implementation, vertical slices, UI components.** That is [`production-ready`](https://github.com/aihxp/production-ready).
- **Deployment pipelines, environments, rollbacks.** That is [`deploy-ready`](https://github.com/aihxp/deploy-ready).
- **Observability dashboards, alerts, SLOs, runbooks.** That is [`observe-ready`](https://github.com/aihxp/observe-ready).
- **Repo structure, CI, monorepo decisions.** That is [`repo-ready`](https://github.com/aihxp/repo-ready).
- **Adversarial security review, penetration testing.** Future `harden-ready` skill.
- **Launch copy, marketing.** That is [`launch-ready`](https://github.com/aihxp/launch-ready).

**Pairing:** On Claude Code and other skill-invocation-aware harnesses, architecture-ready hands off to `stack-ready` (the chosen storage and compute shapes become stack-ready's pre-filled constraint map), to `roadmap-ready` (the component dependency graph becomes the sequencing input), and to `production-ready` (the system shape, component boundaries, trust boundaries, and NFR targets become the Step 2 architecture-note inputs wholesale). On other harnesses, it surfaces the handoffs to the user.

## What this skill prevents

The have-nots in SKILL.md map directly to the research pass. The following table summarizes the real incidents, named research findings, and industry postmortems that the skill's rules were designed to catch.

| Real incident / research finding | What this skill enforces |
|---|---|
| **Amazon Prime Video 2023 consolidation** (misread as "Amazon abandoned microservices"; actually one monitoring team's pipeline, 90% cost reduction). Amazon Engineering blog 2023. | Default to modular monolith unless a forcing function requires microservices; read cited postmortems before reusing the cite. |
| **Segment 2018 consolidation** (from microservices back to a monolith; published blog post). | Microservices backlash is real and predates the Prime Video case by five years. |
| **Istio control-plane merge 2020** (four microservices merged back to one binary). | Even the CNCF ecosystem has consolidation cases. |
| **Shopify Packwerk** (open-sourced 2021; enforces module boundaries in 2.8M-line Ruby monolith). | Fitness functions scale to 4000+ components; no excuse for "architecture drifted" at any scale. |
| **Stavros Korokithakis, "The microservices cargo cult" (2015).** | "Cargo-cult cloud-native" is a load-bearing have-not; SKILL.md refuses microservices-by-default without a forcing function. |
| **Fritzsch et al., "Resume-Driven Development" (ICSE 2021).** | Peer-reviewed evidence that trends drive tech picks; SKILL.md's flip-point requirement filters this out. |
| **Facebook BGP outage Oct 2021** (DNS advertised itself over the same network whose health DNS was meant to report - textbook trust-boundary failure). | The four (now five) canonical trust boundaries are mandatory; silent boundaries disqualify Tier 1. |
| **Knight Capital 2012** ($440M in 45 minutes; dead code in shared binary across deploy boundary). | Deploy-time trust boundaries; fitness function for reachable code in production paths. |
| **Cloudflare regex outage July 2019** (single commit pushed globally, no staged rollout). | Deploy blast radius is architectural; the skill names deploy topology as a decision. |
| **Amazon S3 outage Feb 2017** (single operator command took down a region). | Blast-radius analysis per highest-blast-radius mutation; Step 7 explicitly names cross-tenant DELETE, admin impersonation, etc. |
| **Atlassian 2022 outage** (14 days; site vs. app identifier ambiguity in a deletion API). | Trust-boundary discipline; data-ownership conformance. |
| **Roblox 2021 outage** (Consul as single point of failure across service discovery). | Service-discovery as a trust boundary; cell-based architecture as a resilience response. |
| **Simon Brown, "The C4 Model: Misconceptions, Misuses, and Mistakes" (GOTO 2024).** | C4 misuses refused: mixed abstraction levels, missing technology on containers, unlabeled arrows. |
| **Martin Fowler, "MonolithFirst" (2015).** | Modular monolith is the default; service extraction requires domain knowledge you cannot have day one. |
| **Sam Newman, "Monolith to Microservices" (O'Reilly 2019).** | Shared database for writes across services is the distributed-monolith antipattern. |
| **Ford/Parsons/Kua/Sadalage, "Building Evolutionary Architectures" (O'Reilly 2nd ed 2023).** | Fitness functions are Tier 3 required; named-but-not-wired disqualifies Tier 3. |
| **Michael Nygard, "Documenting Architecture Decisions" (2011).** | ADR format mandatory; retroactive ADRs labeled; supersession chains preserved. |
| **Eric Evans, "Domain-Driven Design" (2003).** | Bounded contexts are the component boundary language; anemic services and god services refused. |
| **Skelton and Pais, "Team Topologies" (2019).** | Team shape drives architectural shape; Conway's Law not ignored. |
| **Pat Helland, "Life Beyond Distributed Transactions" (CIDR 2007).** | Distributed transactions across services rejected; outbox pattern for cross-service state. |
| **Kleppmann, "Designing Data-Intensive Applications" (2017; 2nd ed with Riccomini, GA Jan 2026).** | Storage shape decisions precede database picks. |
| **InfoQ, "Event Sourcing Antipattern" (2016).** | Whole-system event sourcing refused; CQRS and event-sourcing must have PRD-grounded justification. |
| **ThoughtWorks Tech Radar (2018 to present).** | Microservices at "Trial" not "Adopt" since 2018; skill mirrors that posture. |
| **LLM Architectural Review research (Haryanto 2024; Springer 2025; Pragmatic Engineer 2025).** | AI-slop architecture signature is refused: components without rationale, "scalable" without numbers, training-data-frequency tool picks. |

Full citations in [`references/RESEARCH-2026-04.md`](references/RESEARCH-2026-04.md).

## Reference library

Load on demand. The SKILL.md body maps each step to a reference file.

| File | Purpose |
|---|---|
| [architecture-research.md](references/architecture-research.md) | Mode detection, load-bearing check, industry posture summary. Load at Step 0. |
| [system-shape.md](references/system-shape.md) | The seven shapes catalog, forcing functions, flip points. Load at Step 1 and Step 2. |
| [component-breakdown.md](references/component-breakdown.md) | DDD bounded contexts, Team Topologies, anemic/god service refusal. Load at Step 3. |
| [data-architecture.md](references/data-architecture.md) | Storage shapes, entities, tenancy, consistency, PII. Load at Step 4. |
| [integration-architecture.md](references/integration-architecture.md) | Sync vs. async, transports, idempotency, named patterns, CQRS refusal. Load at Step 5. |
| [non-functional-architecture.md](references/non-functional-architecture.md) | Latency, throughput, availability chains. Load at Step 6. |
| [trust-boundaries.md](references/trust-boundaries.md) | Four boundaries, blast radius, defense in depth, production-ready threat-model pre-fill. Load at Step 7. |
| [adr-discipline.md](references/adr-discipline.md) | Nygard format, supersession, when to write, when not. Load at Step 8. |
| [diagrams.md](references/diagrams.md) | C4 as default, arc42 and 4+1 alternatives, diagram-as-code. Load at Step 9. |
| [evolutionary-architecture.md](references/evolutionary-architecture.md) | Fitness functions, ArchUnit/dependency-cruiser/Packwerk. Load at Step 10. |
| [architecture-antipatterns.md](references/architecture-antipatterns.md) | Catalog of named failure modes. Load for Mode C audits and tier-gate checks. |
| [RESEARCH-2026-04.md](references/RESEARCH-2026-04.md) | Full research dossier with citations for v1.0.0. Load on demand. |

## Contributing

Gaps, missing cases, outdated guidance: contributions welcome. Open an issue or PR. Staleness is the enemy; if the industry moves on a shape or a postmortem that belongs in the have-nots, say so.

## License

[MIT](LICENSE)

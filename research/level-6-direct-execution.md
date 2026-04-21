---
status: active
created: 2026-04-08
published: true
title: "Level 6: Direct Execution"
summary: Beyond software — when agents execute processes directly, the code layer becomes optional.
layout: layouts/page.njk
---
# Level 6: Direct Execution — Beyond Software
> Software was always an intermediate representation. When agents can execute intent directly, the code layer becomes optional. L6 is agents running processes, not writing programs.

**Links:** [Cyborg Model](./cyborg-model.md), [Praxis — Agent Teams](./economics/praxis-agent-teams.md), [Claude Opus 4.6 Research](./claude-opus-4-6.md), [Cognitive vs. Motor Skills](./cognitive-vs-motor.md), [Karpathy LLM Wiki Convergence](../notes/karpathy-llm-wiki-convergence.md), [Career](../career/README.md)

## The Five Levels (Dan Shapiro, 2026)

From [The 5 Levels of AI Coding](https://www.youtube.com/watch?v=bDcgHzCBgmQ) (Nate B Jones, 2026-02-18) — [Transcript](../raw/videos/five-levels-ai-coding-clean.txt):

| Level | Name | Human role | AI role | Who reads code? |
|---|---|---|---|---|
| 0 | Spicy autocomplete | Writes code | Suggests next line | Human |
| 1 | Coding intern | Architects | Handles discrete tasks | Human reviews all |
| 2 | Junior developer | Reviews | Multi-file changes, navigates codebase | Human reads all |
| 3 | Developer as manager | Directs, approves/rejects PRs | Implements features | Human skims |
| 4 | Product manager | Writes spec, checks outcomes | Implements, tests | Human checks tests |
| 5 | Dark factory | Writes spec | Everything — spec in, software out | Nobody |

**Key data points from the video:**
- **StrongDM** — 3-person team running L5. No sprints, standups, or Jira. Specs + external "scenarios" (holdout sets the AI can't see). Digital twin universe for integration testing.
- **The self-referential loop** — Claude Code 90% written by itself. Codex 5.3 instrumental in creating itself. The feedback loop is closed.
- **The J-curve** — METR RCT found experienced devs 19% SLOWER with AI. Most orgs stuck at L2, getting slower while believing they're faster. The gap is organizational, not technological.
- **Junior pipeline collapse** — 67% decline in junior postings. The apprenticeship model breaks when AI handles entry-level work.
- **AI-native economics** — Cursor at $3.5M revenue/employee vs $600K SaaS average (5-6x multiplier).

**90% of developers who think they're AI-native are at L2.** The bottleneck is not the tool — it's the willingness to redesign workflows, org charts, and identity around AI as the executor.

## Level 6: Direct Execution

The 5 levels progressively remove the human from **code writing**. Level 6 removes the **code itself**.

| Level | Artifact | Example |
|---|---|---|
| L5 | Software (agent-written) | "Write me inventory management software" → code → software manages inventory |
| **L6** | **No software — the agent IS the process** | **"Manage my inventory" → agent manages inventory directly** |

### The Insight

Software was always an intermediate representation. Humans needed it because machines couldn't understand intent. You wanted "track what's in my warehouse and reorder when stock is low" — but machines needed that translated into loops, conditionals, database queries, API calls. The code was the translation layer between human intent and machine execution.

At L6, the agent understands the intent directly. The translation layer is optional. Sometimes you still want durable software (for performance, reliability, offline operation). But for many processes, the agent can just... do it.

### The Business Sim Analogy

In SimCity, you don't write a zoning-management program. You click "zone residential here" and the system executes. In Factorio, you don't write logistics code — you place a belt and the system routes items. The interface IS the execution layer. The code is invisible because it was never the point — the **process** was the point.

L6 extends this to real-world processes. The agent is the factory floor manager, the inventory clerk, the project coordinator — not the software that those people used to use.

### The Brain Model Connection

L5 is "the prefrontal cortex writes detailed motor plans for the motor cortex to execute."
L6 is "the prefrontal cortex intends, and the system executes."

That's how actual brains work. You don't write a motor program to reach for a cup — you intend to reach for the cup, and the motor system figures out the muscle activations. The conscious mind specifies WHAT, the subsystems handle HOW. The intermediate representation (motor plan) exists but is invisible to the conscious agent.

## The Vault as Progression Evidence

The vault itself documents the trajectory across just three months:

| Date | Snapshot | Level |
|---|---|---|
| **Feb 2026** (Praxis, first vault entry) | Agents as Jira managers, autocompleting tasks. Bad automated fridge. Rakuten managing 50 devs with agent routing. Success requires human in the loop for grounding. | L2-L3 |
| **Feb 2026** (this video) | StrongDM dark factory. 3 people, no Jira. Claude Code self-referential. "We threw out Jira." | L5 |
| **Apr 2026** (Karpathy convergence) | LLM wiki pattern — agents maintaining knowledge bases, not writing knowledge-base software. The vault's skills execute processes directly (ingest, sync, heartbeat). | Proto-L6 |
| **Apr 2026** (this page) | Prediction: L6 is next. Agents executing business processes, not writing software to execute them. | L6 (predicted) |

**The pacing problem is real.** Three months from "agents struggle with fridges" to "throw out Jira and run a dark factory." Each vault review is a snapshot of where the frontier is, and each snapshot obsoletes the last.

## Where L6 Already Exists

Proto-L6 is already happening in narrow domains:

- **This vault** — `/vault-ingest` doesn't write ingestion software. It ingests. `/vault-sync` doesn't write sync software. It syncs. The agent IS the process.
- **Automated trading** — algorithmic trading systems don't generate trading software; they trade. The agent is the trader.
- **Robotic process automation (RPA)** — bots that navigate UIs and fill forms. Crude L6 — the bot IS the clerk, not software that helps the clerk.
- **AI customer service** — the agent doesn't write helpdesk software. It helps customers directly.

What's changing is the **generality**. These were narrow, brittle, pre-programmed. LLM-based agents can handle ambiguity, novel situations, and multi-step reasoning — which is what makes general L6 newly viable.

## The L5 → L6 Transition

| Dimension | L5 (Dark factory) | L6 (Direct execution) |
|---|---|---|
| **Output** | Working software | Working outcomes |
| **Durability** | Persistent artifact (code, binaries) | Ephemeral — the agent acts, results persist as data/state changes |
| **Specification** | Detailed enough for code generation | Intent-level — "keep inventory above safety stock" |
| **Failure mode** | Buggy software | Wrong action (higher stakes, harder to undo) |
| **Human role** | Write specs, evaluate software | State intent, evaluate outcomes |
| **Trust requirement** | Trust the software (testable) | Trust the agent (requires grounding, judgment) |

The trust gap is the key barrier. L5 produces an artifact you can test. L6 produces actions you can only evaluate after the fact. This maps directly to the [LLM grounding problem](./llm-grounding-problem.md) — the agent needs enough understanding of real-world consequences to act responsibly.

## Boundary Conditions: The Cyborg Implementation Layer

L6 doesn't eliminate the need for humans at the edges. It moves the boundary. Three constraints surfaced during real-world coding work:

**1. UI Convergence** — When AI generates all code, UIs converge toward model defaults. Every Claude-generated app starts looking the same. Implementation is commoditized; the differentiator migrates to **style and taste** — the human judgment about what looks right, feels right, matches the brand. This is the Cyborg Model's "quality/taste" function becoming the primary competitive edge at L5+.

**2. Style as the New UX** — When every L5 shop ships equivalent code quality, the competition shifts to aesthetics, feel, and identity. AI can generate unlimited variations; the human picks which one. "Taste" — previously a soft skill — becomes the hardest and most valuable capability in production software.

**3. The Human Buffer at System Boundaries** — Two directions:
- **Inbound:** EDI/OCR interpreting messy real-world input. Intent is ambiguous at the boundary between the physical world and the digital system. Mistakes happen because the real world doesn't speak clean data.
- **Outbound:** The holdout who won't interact with AI. Property closings, contract negotiations, regulatory filings where a human counterparty requires a human. L6 creates a new role: the **agent-to-human translator** — a human intermediary who bridges the gap between autonomous agents and people who need a person across the table.

**The permanent insight:** The buffer isn't a temporary problem to be solved. It's a permanent feature of the architecture. It has always existed — early computing was physical switches and manual wiring; then punch cards; then assembly; then high-level languages; then GUIs; then natural language; now intent. Each step pushed the boundary forward into territory that previously required humans.

But the boundary migrates **both directions** simultaneously:
- **Push forward:** zero-code, dark factories, agents executing processes — the boundary advances
- **Push back:** insisting on custom UX, demanding human intermediaries, regulatory requirements for human presence — the boundary retreats where humans assert value or the real world resists

The buffer doesn't shrink monotonically. It oscillates. This is the [opposing forces](../philosophy/opposing-forces.md) pattern applied to human-machine interaction. The cyborg model's core claim: the boundary migrates to wherever the current friction is, but it never disappears — and pushing too hard in either direction generates counter-pressure.

## Open Questions

1. **When is durable software still the right answer?** L6 doesn't eliminate software — some processes need offline operation, sub-millisecond latency, or guaranteed determinism. Where's the boundary?
2. **The grounding problem at L6.** L5 failure = buggy code (fixable). L6 failure = wrong real-world action (possibly irreversible). How do you build the equivalent of StrongDM's "external scenarios" for real-world agent actions?
3. **Regulatory and liability implications.** Who's responsible when an L6 agent makes a bad inventory decision? A bad hiring decision? A bad medical decision? Software has audit trails; agent actions may not.
4. **The self-modifying agent.** At L6, the agent could modify its own processes based on outcomes. This is the neural plasticity / fitness function idea from the [brain architecture model](./cyborg-model.md#the-vault-as-brain-architecture). When does self-modification become unsafe?
5. **Timeline.** L5 went from "impossible" to "production" in ~18 months (3.5 Sonnet fall 2024 → StrongDM mid-2025). If the pattern holds, L6 in narrow domains is 2026-2027. General L6?

## Tags

[ai](../tags/ai.md), [agents](../tags/agents.md), [economics](../tags/economics.md), [cyborg](../tags/cyborg.md)

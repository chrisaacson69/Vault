---
status: active
created: 2026-02-12
published: true
title: The Cyborg Model
summary: Neither side is complete alone. The point is to distribute labor so each side does what they do best.
layout: layouts/page.njk
---
# The Cyborg Model — Human/AI Collaboration
> Neither side is complete alone. The point is to distribute labor so each side does what they do best.

**Links:** [Economics](./economics/README.md), [Risk and Entrepreneurship](./economics/risk-and-entrepreneurship.md), [Praxis](./economics/praxis-agent-teams.md), [LLM Grounding Problem](./llm-grounding-problem.md), [Cognitive vs. Motor Skills](./cognitive-vs-motor.md), [Claude Opus 4.6 Research](./claude-opus-4-6.md), [Gaming](./gaming/README.md), [Measurement, Causality, and Free Will](./philosophy/measurement-causality.md), [Karpathy LLM Wiki Convergence](../notes/karpathy-llm-wiki-convergence.md), [Level 6 — Direct Execution](./level-6-direct-execution.md), [Career](../career/README.md)

## What "Cyborg" Means

Not replacement. Not augmentation. **Integration.** The human and the AI form a single working unit where labor is distributed based on comparative advantage. Each side contributes what they do best, and the result exceeds what either could produce alone.

This isn't a metaphor — it's an economic statement. From [utility theory](./economics/value-and-profit.md): trade happens because both parties have different capabilities and different costs. The human-AI collaboration is a trade: the human provides what's expensive for the AI (judgment, grounding, physical action), and the AI provides what's expensive for the human (speed, scale, tireless execution, parallel processing).

## Comparative Advantages

### What Humans Do Best

**Entrepreneurial Judgment (CEO Function)**
- Making bets under genuine uncertainty with high stakes
- Weighing factors that aren't in the data — intuition, taste, experience
- Bearing responsibility for outcomes (skin in the game)
- See: [Risk and Entrepreneurship](./economics/risk-and-entrepreneurship.md)

**Grounding in Physical Reality**
- Understanding what things physically mean — that inventory costs real money, that being in the same room proves innocence, that a customer's frustration is real
- Translating real-world needs into specifications agents can execute on
- Validating whether AI output matches actual real-world requirements
- See: [LLM Grounding Problem](./llm-grounding-problem.md)

**Intent and Direction**
- Knowing what to build, not just how to build it
- Articulating the real requirement beneath the surface request
- "The skill that matters now is not technical proficiency — it's clarity of intent" (Video 2)
- Domain expertise: understanding which metrics matter, what customers actually want, what "good" looks like

**Quality Judgment ("Taste")**
- Evaluating whether output is actually good, not just technically correct
- Understanding context, nuance, audience, and appropriateness
- The difference between "this compiles" and "this is the right product"

**Physical World Execution**
- Interaction with the physical world remains a human (or robot) domain
- Pressing buttons, handling materials, face-to-face interaction, manual skills
- Robots are emerging but the physical execution gap is far from closed
- See: [Cognitive vs. Motor Skills](./cognitive-vs-motor.md) — the AI systems that handle cognitive tasks (LLMs) are architecturally different from those that handle physical/real-time tasks (autopilot NNs). Even humans have separate systems for these.

**Social and Emotional Intelligence**
- Career development conversations, team morale, organizational culture
- Reading a room, sensing unease, building trust through presence
- The parts of management that aren't coordination

### What AI Does Best

**Cognitive Execution at Scale**
- Writing code, generating content, processing documents, analyzing data
- Doing in minutes what takes humans hours or days
- Parallel processing — 24 agent sessions simultaneously (Rakuten)
- Sustained attention — 2 weeks of autonomous coding without fatigue

**Operational Coordination (COO Function)**
- Ticket routing, dependency tracking, cross-team coordination
- Understanding org charts and repo ownership from documented structure
- Knowing when to escalate — handling what's structured, punting what's not
- See: [Praxis](./economics/praxis-agent-teams.md) — Rakuten demonstrated this in production

**Pattern Recognition and Retrieval**
- Finding needles in haystacks — 76% retrieval at 1M tokens
- Holding 50,000 lines of code in context and reasoning across all of it
- Security research: finding 500 zero-days by building mental models of code
- Processing and synthesizing large document sets (due diligence, audits)

**Creative Problem-Solving Under Low Stakes**
- Novel methodology invention (git history analysis for security)
- Generating options, alternatives, approaches for human evaluation
- Exploring solution spaces faster than humans can

**Tireless, Consistent Operation**
- 24/7 availability, no fatigue, no mood variation
- Consistent application of rules and constraints
- Parallel execution across many workstreams simultaneously

## The Distribution of Labor

The video's framing: "The humans set direction, evaluate quality, and make judgment calls. The agents execute, coordinate, and scale."

This is correct but incomplete. The full distribution:

| Function | Human | AI | Why |
|----------|-------|-----|-----|
| **Direction** | Define goals, intent, what to build | Decompose goals into executable tasks | Humans know what's needed; AI knows how to break it down |
| **CEO Judgment** | High-stakes risk decisions, entrepreneurial bets | Present options with analysis, recommend but don't decide | Slow feedback loops make this hard to train; human bears consequences |
| **COO Operations** | Override when judgment needed | Routing, triaging, constraint enforcement, coordination | Structured, data-driven — AI's native domain |
| **Grounding** | Provide physical context, validate real-world fit | Process and organize information within text domain | LLMs can't distinguish lived experience from verbal claims |
| **Cognitive Execution** | Review, approve, iterate | Write code, generate content, analyze data, build | AI is faster, cheaper, tireless |
| **Physical Execution** | Hands-on work, physical presence, real-world interaction | Emerging robotics, but mostly indirect (controlling systems via software) | Different architecture needed — see [cognitive vs motor](./cognitive-vs-motor.md) |
| **Quality** | "Is this actually good?" — taste, domain expertise | "Is this technically correct?" — tests, validation, consistency | Correctness ≠ quality; humans judge the latter |
| **Pacing** | Must continuously update mental models of what's possible | Improves automatically with each model release | The boundary between human and AI roles shifts every few months |

## The Leverage Equation

From Video 2: skills like judgment, taste, and domain expertise "now have 100x leverage because they are multiplied by the number of agents that person can direct."

This is the economic argument for the cyborg model:
- **Before AI:** A person with great judgment could improve one team's output
- **Now:** That same person can direct dozens of agents, multiplying their judgment across all of them
- The **value of human judgment has increased**, not decreased — because it's the scarce input that unlocks the abundant input (AI execution)

Revenue per employee at AI-native companies (5-7x traditional SaaS) reflects this. It's not that the humans are 5-7x better. It's that each human is leveraged by agents.

The emerging org model: **2-3 humans + a fleet of specialized agents**, organized by outcome, not function. The humans set direction, evaluate quality, and make judgment calls. Everything else is delegated.

## The Pacing Problem

The capability boundary between "human territory" and "AI territory" is moving fast:
- January 2025: autonomous coding topped out at 30 minutes
- Summer 2025: 7 hours (Rakuten)
- February 2026: 2 weeks (C compiler); StrongDM running a 3-person "dark factory" — no sprints, no Jira, spec in → software out
- April 2026: Claude Code 90% self-written; Codex 5.3 instrumental in creating itself; the self-referential loop is closed
- Prediction: weeks to months by mid-2026; [Level 6 — direct execution](./level-6-direct-execution.md) (agents executing processes, not writing software) in narrow domains by 2027

"Your January mental model of what AI can and cannot do is already wrong."

### The J-Curve

A 2025 METR randomized control trial found experienced open-source devs were **19% slower** with AI tools — while believing they were 24% faster. The gap is organizational: bolting AI onto existing workflows causes a productivity dip (the J-curve) because the workflow hasn't been redesigned around the tool. Most organizations are stuck at the bottom of the J. The ones breaking through are the ones who redesigned end-to-end: specs, review processes, CI/CD, org structure.

### The Five Levels

Dan Shapiro's [five levels of AI coding](./level-6-direct-execution.md) (2026) map where the industry stands:

| Level | Human role | AI role |
|---|---|---|
| L0: Autocomplete | Writes code | Suggests next line |
| L1: Intern | Architects | Discrete tasks |
| L2: Junior dev | Reviews all code | Multi-file changes |
| L3: Manager | Directs, approves PRs | Implements features |
| L4: Product manager | Writes spec, checks outcomes | Everything |
| L5: Dark factory | Writes spec | Spec in → software out |
| **L6: Direct execution** | **States intent** | **Executes the process — no code needed** |

90% of developers who think they're AI-native are at L2. The vault's prediction: L6 is next — agents executing business processes directly, not writing software to execute them. See [Level 6 — Direct Execution](./level-6-direct-execution.md).

This means:
- Humans must continuously recalibrate where they add value
- Skills that were human-only 6 months ago may now be shared or AI-dominated
- The pacing challenge isn't just technical — it's psychological and organizational
- "The people in knowledge work desperately need their leaders to understand that humans need a ton of support to get through this change management"
- The bottleneck has moved from implementation speed to **spec quality** — understanding the problem deeply enough to describe it precisely

The cyborg model isn't static. The distribution table above will look different in 6 months. The human's job is to keep finding the frontier where their judgment, grounding, and physical presence create value that agents can't yet provide — and to stay ahead of the boundary as it moves.

## The Dissolving Technical/Non-Technical Divide

One of the most significant shifts: the distinction between "technical" and "non-technical" workers — which has organized knowledge worker hiring and compensation for 30 years — is dissolving.

- Non-technical Rakuten employees contribute to development via Claude Code
- CNBC reporters built a Monday.com replacement without writing code
- "Vibe working" — describe outcomes, not process

The new divide isn't technical vs non-technical. It's **people who can clearly articulate intent and evaluate output** vs **people who can't.** Domain expertise and judgment matter more than the ability to write a for-loop.

## Worked Example: Cyborg DJ

The DJ set pipeline is the cyborg model in miniature. Every role in the distribution table above maps cleanly:

**The pipeline:** [Camelot](../projects/camelot-from-youtube/README.md) analyzes tracks → Human writes the [set score](../projects/dj-set-1/README.md) (track order, transitions, EQ notes, energy arcs) → [Mix engine](../projects/set-mastering/README.md) executes the mix from instructions → Light mastering pass → Done.

**Who does what:**

| Cyborg Role | DJ Application |
|-------------|---------------|
| **Direction** (Human) | Track selection, set philosophy ("texture over harmony"), energy arc design |
| **CEO Judgment** (Human) | "Break Camelot intentionally here" — creative risk-taking the AI can't evaluate |
| **Grounding** (Human) | Knowing what sounds good on a dancefloor, what a crowd responds to |
| **Quality/Taste** (Human) | Final ear-test — "does this transition actually work?" |
| **Pattern Recognition** (AI) | Camelot detecting keys, BPM, structural events, beat grids per track |
| **Cognitive Execution** (AI) | Time-stretching, beat-matching, crossfading, gain staging, rendering |
| **Tireless Operation** (AI) | Processing 11 tracks × analysis + mixing without fatigue |

**The key insight:** The human initially assumed they needed a mastering tool (LANDR, Dolby.io). But the [DJ Set 1 README](../projects/dj-set-1/README.md) already contained all the mixing instructions — it was a program, not a cheat sheet. The right tool was a [programmatic mix engine](./programmatic-dj-mixing-tools.md) that could execute those instructions. Mastering became trivial because the hard decisions were already encoded.

This is the cyborg model's leverage equation in action: one human's creative judgment (track selection, transition design, energy philosophy) multiplied by AI execution (analysis, mixing, rendering) produces a result neither could achieve alone. The human can't time-stretch 11 tracks to beat-perfect alignment. The AI can't decide to "break Camelot intentionally because the texture matters more than the harmony."

See: [Set Mastering Pipeline](../projects/set-mastering/README.md), [Programmatic DJ Mixing Tools](./programmatic-dj-mixing-tools.md), [DJ Set 1](../projects/dj-set-1/README.md)

## The Vault as Brain Architecture

The cyborg model isn't just a way of working — the vault itself is a working model of how it works. The structural parallel between this vault and the mammalian brain is precise enough to be explanatory, not just metaphorical.

### The Binding Problem

The mammalian brain has specialized regions: visual cortex processes images, Broca's area handles language production, the hippocampus forms new memories, the motor cortex controls movement. Each region is optimized for its input type — different architectures for different problems (see [Cognitive vs. Motor Skills](./cognitive-vs-motor.md)). The hard problem was never the specialization. It was the coordination: **how do these separate systems talk to each other?**

The answer turned out to be structured pathways — white matter tracts, the thalamus as a routing hub, the association cortex binding concepts across modalities. The connections between regions are as important as the regions themselves.

The vault has the same architecture:

| Brain Structure | Function | Vault Analogue |
|---|---|---|
| **Thalamus** | Routing hub — nearly all sensory input passes through it before reaching specialized regions | **INDEX.md** — the master map everything passes through |
| **White matter tracts** | Direct connections between specialized regions | **Cross-links** (`**Links:**` sections between pages) |
| **Association cortex** | Binds concepts across modalities — where "seeing red" meets "feeling hot" meets "the word fire" | **Tag index files** — grouping related pages across domains (a tag like `economics` connects philosophy, gaming, and business) |
| **Hippocampus** | Forms new associations, consolidates short-term memory into long-term | **The ingest process** — raw input is processed, linked, and integrated into the existing knowledge structure |
| **Prefrontal cortex** | Executive function — what to attend to, what to suppress, what to act on | **The human directing the LLM** + CLAUDE.md schema |
| **Sensory input** | Raw, unprocessed signals from the world | **`raw/` folder** — unprocessed source material (articles, transcripts, PDFs) |
| **Working memory** | Limited capacity (~7 items), temporary, active processing | **The LLM's context window** |
| **Long-term memory** | Persistent, structured, retrievable via associative paths | **The vault itself** |

### Why This Matters: The Context Window Is Working Memory

The critical insight: the LLM's context window functions exactly like working memory. It's limited. It's temporary. It can only hold so much at once. When the conversation ends or the context fills up, everything in it is gone — unless it was written to the vault.

The vault structure is what makes long-term memory *work*. Not by cramming everything into the context window simultaneously, but by providing **navigable retrieval paths** so the LLM can load the right information when it needs it. The brain doesn't hold all memories in working memory either. It has *paths back* — and those paths are the cross-links, the index, the tags.

This is exactly why the [Karpathy LLM Wiki](../notes/karpathy-llm-wiki-convergence.md) pattern beats RAG. RAG reconstructs the retrieval path from scratch on every query — like a brain that lost all its white matter tracts and has to re-derive every association from raw sensory data each time. The vault's pre-built link structure means the associations are already there, maintained, ready to traverse. The LLM reads INDEX.md (thalamus), follows links to the relevant pages (white matter tracts), and synthesizes across them (association cortex). The path exists before the query.

### The Ingest Cycle

The full cycle mirrors sensory processing → memory consolidation:

1. **Sensation:** Raw input arrives in `raw/` (article, transcript, PDF)
2. **Perception:** The LLM reads and interprets the source, discusses key takeaways with the human
3. **Encoding:** The LLM creates structured vault pages with cross-links — the hippocampus forming new associations
4. **Consolidation:** `/vault-sync` updates INDEX.md, tag files, and bidirectional links — strengthening the pathways
5. **Retrieval:** Future queries traverse the link structure to find and synthesize relevant knowledge
6. **Reconsolidation:** New information updates existing pages — memories are revised, not just appended

The human's role throughout is the prefrontal cortex: deciding what to attend to, what matters, what emphasis to give. The LLM does the encoding, filing, and cross-referencing — the bookkeeping that makes the memory system actually work. This is why wikis maintained by humans alone always die: the maintenance burden (the hippocampal/association work) grows faster than human willingness to do it. The LLM doesn't get bored.

## Open Questions
- At what vault scale does INDEX.md-based retrieval (thalamic routing) break down, requiring embedding search (something more like parallel sensory processing)?
- Can the vault develop the equivalent of "intuition" — fast, cached retrieval paths that skip the full INDEX.md traversal? (Karpathy's "hot cache" was a primitive version.)
- **Neural plasticity / self-modifying skills:** The brain model is missing adaptation — pathways that fire together wire together, unused connections get pruned, frequently-used paths get myelinated. The vault's skills are "learned behaviors," and a self-modifying skill with a fitness function would be the synaptic plasticity layer. The hard part is defining the fitness function — the same problem as in [evolutionary game theory](./evolutionary-capitalist/value-utility-evolutionary-game-theory.md): the fitness landscape determines everything, and defining it wrong produces pathological optimization. Candidate: `/vault-heartbeat` as the first self-tuning skill, once the right fitness metric emerges. Videos exist on using markdown to define fitness functions for skills — worth ingesting when found.
- What's the optimal agent-to-human ratio for different types of work?
- How do organizations support humans through the pacing challenge?
- As AI handles more cognitive execution, does the remaining human work become more or less satisfying?
- How does the cyborg model interact with the physical world — what happens when robots close the execution gap?
- Can humans develop new forms of judgment that only emerge when working with AI? (Skills that didn't exist before the partnership)

## Tags
[ai](../tags/ai.md), [agents](../tags/agents.md), [cyborg](../tags/cyborg.md), [economics](../tags/economics.md)

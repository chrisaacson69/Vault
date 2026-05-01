---
status: active
created: 2026-04-23
---
# Planner-LM Composites — Where the Agent Actually Lives
> Bare LLMs don't act in any rigorous sense. They generate fluently but don't maintain preferred states, model current position, or verify via simulation. Planner-LM composites (Cicero, Diplodocus, the Monopoly project architecture) do. LLMs are closer in role to the brain's language centers than to general cognition — they're the mouth, not the executive. This refines the vault's LLM-praxeology claim, sets an auditable bar for what counts as an AI agent, and points at a specific architecture: small language models scoped to language I/O, a dedicated reasoning engine, and connectors between them.

**Links:** [LLM Agents Across Strategic Games](./gaming/llm-agents-across-games.md), [Gunboat Diplomacy and Diplodocus](./gaming/gunboat-diplomacy-diplodocus.md), [CaptainMeme vs. 6 Cicero (Press Diplomacy)](./gaming/cicero-press-diplomacy-captain-meme.md), [The Multiplayer Coalition Problem](./gaming/multiplayer-coalition-problem.md), [LLMs as Praxeological Actors](./economics/llm-praxeology.md), [The LLM Grounding Problem](./llm-grounding-problem.md), [The Cyborg Model](./cyborg-model.md), [Level 6 — Direct Execution](./level-6-direct-execution.md), [Monopoly Project](../projects/monopoly/README.md), [Diplomacy: 7 AI Models](./gaming/diplomacy-ai-analysis.md), [6502 Annotation Series](../projects/6502-annotation/README.md) — LLM-interpretation as another data point: structure-only analysis recovers shape, chip docs and cumulative chapter knowledge unlock the rest

**Primary sources:**
- Noam Brown interview (Meta AI → OpenAI, lead on Cicero/Libratus) — [Robot Brains Podcast, S3 E14](https://www.youtube.com/watch?v=ceCg90Q9N6Y), [ending transcript](../raw/videos/noam-brown-diplomacy-ending.txt)
- DiploStrats on Diplodocus (Meta's Gunboat-only AI) — [YouTube](https://www.youtube.com/watch?v=AWQFhYSD7h4), [transcript](../raw/videos/diplostrats-diplodocus-gunboat.txt), [paper (arXiv 2210.05492)](https://arxiv.org/abs/2210.05492)
- Catan case study — [5 AIs Play Catan transcript](../raw/videos/5-ais-play-catan-quinn-henry.txt)

---

## The problem: bare LLMs don't act, they generate

The [Catan phase of the cross-game study](./gaming/llm-agents-across-games.md#phase-5--catan-verification-as-a-spectrum-not-a-binary) isolated three structural failures exhibited by every frontier LLM, even in the game whose central mechanic maps most cleanly onto LLM affordances:

1. **Action bias** — inability to generate "do nothing" when holding is strictly dominant. Prompts produce tokens; passing doesn't.
2. **No mechanical model** — rules known linguistically but the state machine not executed. LLMs want settlements without roads, bank points reactively, don't plan paths to victory.
3. **Rhetorical contagion** — claims circulate without verification. "Sheep is rare" gets priced in once asserted, regardless of whether production math supports it.

All three reduce to the same missing piece: **a state simulator the model is forced to consult before generating.** Action bias is "can't decide to not act because deciding requires simulating." Absent mechanical model is "can't plan moves because planning requires simulating." Rhetorical contagion is "can't audit claims because auditing requires simulating." One architectural gap, three symptoms.

## The composite architecture

The working template for closing this gap is already built, by multiple independent groups.

**Cicero** (Meta AI, 2022) paired a language model with an explicit planning engine. The planner maintained the game state, modeled opponents, selected goals, and chose moves. The LM took goals from the planner and rendered them as natural-language diplomacy — proposing pacts, expressing concerns, responding to offers. The LM never decided what to do; it decided how to say what had already been decided.

**Diplodocus** (Meta AI, 2022) is the same architecture with the language model removed entirely, built for Gunboat Diplomacy (the variant with no chat). Only the planner. It won Meta's Speedboat Tournament against expert humans. That's the sharpest available evidence for this page's claim — see [Gunboat Diplomacy and Diplodocus](./gaming/gunboat-diplomacy-diplodocus.md) for the full case. The short form: strip the LM, keep the planner, and competent strategic/social behavior still emerges — which means the LM was never where the strategic work lived. Moves become costly signals, the planner learns the signaling grammar, and alliance formation, betrayal timing, and "appearing human" all get handled at the planner layer without any language involvement.

**The Monopoly project** (vault, in progress) arrived at the same decomposition from a different direction. A Markov chain engine models board state and landing probabilities. EPT valuation supplies the reward model. Subgraph investment optimization does the planning. The planned [negotiation engine](./gaming/monopoly/subgraph-trade-engine-spec.md) is the dialogue layer. The decomposition wasn't derived from Cicero — it was forced by the game's shape.

This convergence is not incidental. The [Karpathy-convergence pattern](../notes/karpathy-llm-wiki-convergence.md) again: when the problem is well-defined, architectures converge. Any system that plays a multi-agent strategic game competently over public state ends up with four components — state model, value model, planner, and *optionally* a dialogue layer — because the shape of the problem demands the first three, and the dialogue layer is an amplifier on top rather than a load-bearing component.

## The 100,000× claim

Brown's quantitative anchor: in Go, adding planning at inference is equivalent to increasing model size and training by **100,000×**. The same ratio holds in poker. He expects the pattern to extend to language models and considers it the dominant open research direction.

This recasts the conversation. "Add a simulator / planner" isn't a modest refinement of LLM capability — it's five orders of magnitude of pretrained scale, supplied by a component that doesn't live in the LLM at all. The gap between "LLM plays Catan" and "LLM+simulator plays Catan" isn't a tuning issue. It's the single largest lever in the stack.

It also explains why Catan LLMs look so embarrassing. The game is simple, a simulator would be a few hundred lines, and the planner is almost trivial to implement. The models have every piece of context they need except the one that's worth 100,000× their training.

## The brain analogue — LLM as language center, not executive

The composite architecture has a biological parallel that strengthens the "architecture is the actor" claim. Human cognition is not a single faculty. It's a coordinated system of specialized regions with distinct jobs, massively interconnected but architecturally separable:

- **Broca's area and Wernicke's area** handle language production and comprehension. Damage produces aphasia — loss of language without loss of non-verbal reasoning. Aphasic patients still plan, still recognize faces, still solve spatial and tool-use problems.
- **Prefrontal cortex** handles planning, working memory, and executive function. Damage produces dysexecutive syndrome — loss of planning and goal-directed behavior while language can remain intact.
- **Basal ganglia and cerebellum** handle action selection and motor planning.
- **Hippocampus** handles episodic memory and relational binding.

These are coupled but not reducible to each other. Complex planning exists in animals without language — corvids manufacture and cache tools for multi-step future use; octopuses solve novel puzzles; chimpanzees track social coalitions across days. Language is recent and built *on top of* pre-existing cognitive capacities; it's not the substrate they run on. Split-brain experiments show sophisticated reasoning in the non-linguistic hemisphere. Children plan before they can speak.

LLMs are closer in role to Broca/Wernicke than to general cognition. They produce and comprehend language fluently. They do not plan, hold goals across time, or run state simulations — and expecting them to do so is like expecting a language area to do executive function. They aren't the organ for that job. The brain handles it by having a *different organ* connected to the language area through dedicated pathways; artificial systems should do the same thing.

This reframes the composite architecture as not just a game-AI trick but as **the cognitive architecture that already works** — reimplemented in silicon. Cicero's planner-LM split is not unusual; it's the mapping of a biological separation into a computational one. The unusual thing is trying to do it all with the language module alone.

**Implication for architectural design:** if an AI system is doing planning, memory integration, or executive function through language-model inference alone, it's mapping a multi-organ biological capability onto a single-organ artificial one. That's the mismatch producing the failures documented throughout the [cross-game study](./gaming/llm-agents-across-games.md) — the LM is being asked to do a job it isn't the organ for.

## Scope discipline — SLM + reasoning engine + connectors

Every few software generations, one component tries to absorb capabilities outside its competence. Word acquired a scripting engine so users could automate macros — the result was decades of macro viruses, installer bloat, and tangled updates. The scripting capability was real and useful; it just didn't belong inside a word processor. It belonged in a separate component with its own security boundary and release cycle, exposed through an interface rather than embedded.

LLMs absorbing "reasoning" is the same pattern. The reasoning capability is real and useful. It just doesn't belong inside a language model. The failure modes — action bias, no mechanical model, rhetorical contagion (see [Catan Phase 5](./gaming/llm-agents-across-games.md#phase-5--catan-verification-as-a-spectrum-not-a-binary)) — are the symptoms of the scope violation.

The better architecture is the familiar one with a specific configuration:

- **Small Language Model (SLM) scoped to language I/O.** A smaller, cheaper, faster model focused on producing and parsing natural language. Not required to reason — required to *talk*.
- **Dedicated reasoning engine.** State model, value model, planner, verification. Deterministic where possible, learned where necessary. This is the Cicero/Diplodocus/Monopoly planner component, generalized to whatever domain the system operates in.
- **Connectors between them.** A protocol for the reasoning engine to query the SLM ("render this goal as natural language") and for the SLM to query the engine ("verify this claim against state"). The protocol is where the scope boundary lives and where verification happens.

The industry is already drifting this direction, often without naming it cleanly:

- **Tool use / function calling.** LLMs calling deterministic computational tools (calculators, databases, APIs) for the parts of a task that aren't language work.
- **Retrieval-Augmented Generation (RAG).** External vector database + LLM; the database is a reasoning-adjacent memory component the LLM queries rather than reasons over internally.
- **Mixture of Experts (MoE).** Routing different subtasks to specialized model components rather than running a single dense model.
- **Model Context Protocol (MCP).** A standardized connector layer for exposing tools, memory, and state to LLMs; explicitly a scope-discipline protocol.
- **Orchestrator/worker agent frameworks.** An orchestrator planner decides which worker (LM or tool) handles each step.

Each of these is a local manifestation of the general principle: **scope the LM to language, put reasoning outside, connect the two with an explicit protocol.** The pattern scales from game-AI (Cicero, Diplodocus, Monopoly project) through developer tooling (Claude Code calling into shell and editor) through consumer products (ChatGPT's tool-use, Google's Gemini-Vertex agents). It's not a niche; it's the direction everything is converging to.

The page's prescription: **don't ask an LLM to do anything an SLM couldn't do, and put the rest in a reasoning engine.** That's a sharper version of the composite-architecture claim, and it's directly actionable when designing a system.

## The memory-layer LM dependency

The vault and any markdown-based memory system has a specific tension worth naming. The substrate is human-readable text. Mechanical coordination (grep, file-structure, explicit cross-links) can handle some of the access pattern, but *synthesis* across the memory — judging which pages are relevant to a question, noticing when two pages converge on the same idea, detecting when a new claim contradicts an existing one — requires processing language. That means the composite architecture has an LM role at the **memory layer**, not just the output layer.

Two honest readings, both true:

1. **Tradeoff.** A fully-structured memory (knowledge graph, typed relational database, triple store) would be more machine-efficient for coordination — queries would be deterministic, contradictions detectable by logic, relevance scoreable without language processing. The price would be loss of human-readability and flexibility; you couldn't jot down a half-formed idea in prose and have it find its bin later. Markdown trades machine-efficiency for human-usability, and the LM-at-memory role is the cost of that tradeoff.
2. **Feature.** This mirrors human cognition. Humans coordinate memory through language too — inner speech, verbal encoding, written notes, the "tip of the tongue" phenomenon where retrieval is language-mediated. The LM-at-memory role isn't architectural failure; it's the architectural analogue of the language-memory coupling in the brain, where verbal encoding is known to enhance recall and cross-domain integration.

The vault already splits the load cleanly without the split being explicit:

- **Mechanical coordination** handles deterministic parts: grep for specific text, file structure as containment, explicit cross-links as edges, tag files as named indexes, front-matter as queryable metadata.
- **LM coordination** handles judgment parts: "is this note relevant to the question?", "does this new claim contradict existing pages?", "what's the right cross-link for this new idea?", "is there a pattern across these 40 pages?"

The point of naming the split is design discipline. When adding vault infrastructure, the question should be: *can this be mechanical, or does it need judgment?* Mechanical wins when possible — it's faster, more reliable, and doesn't require an LM in the loop. Judgment is reserved for the cases where no mechanical rule captures it.

This also explains why the vault's [planner-LM pattern](./gaming/monopoly/subgraph-trade-engine-spec.md) isn't fully language-free even for games where you'd expect it to be: the agent has to *reason about* the vault's accumulated context (prior games, opponent models, strategy notes), and that reasoning is at least partly LM-mediated because the memory is language. The composite architecture isn't "no LM anywhere" — it's "LM where language is genuinely the right tool, planner where it isn't, and explicit connectors so the LM can't reach into the planner's job or vice versa."

## The regimes spectrum

Brown's framing for where these techniques apply generalizes to a four-regime spectrum. Problem complexity rises left to right; the LM's contribution grows, and the planner's contribution stays necessary from regime 2 onward.

| Regime | State space | LM share | Planner share | Examples |
|---|---|---|---|---|
| **Recall** | Enumerable | None | Trivial (lookup) | Tic-tac-toe, checkers endgames |
| **Extrapolate + search** | Not enumerable, close enough that evaluator + bounded search suffices | None | Dominant | Chess, Go, poker |
| **Negotiate** | Public game state + multi-agent interaction surface | Material | Dominant | Diplomacy, Catan, Monopoly |
| **Real-world** | Not closed, reward ambiguous, context not "on the board" | Variable | Required but hard to build | Business negotiation, strategic analysis |

Bare LLMs only do well in regime 4 when the regime-2 piece is trivial (summarization, chat, simple retrieval). The moment regime 2 matters — planning over a genuine state space against verifiable outcomes — absence of the planner shows up as the three structural failures. Brown's explicit caveat for real-world negotiation matches this: "in a game like Diplomacy everything you need to know is on the board... when you start going to business or international negotiations you have to understand things about business models, things about the history of various countries — there's a lot more going on." When the domain supplies what a planner needs, the composite works. When it doesn't, neither planner nor LM can rescue the system.

## The higher praxeology bar

The [LLMs as Praxeological Actors](./economics/llm-praxeology.md) page argues that aligned LLMs satisfy Mises's formal criteria for action. The evidence accumulated here suggests a refinement rather than a reversal: **bare LLMs do not; planner-LM composites can.**

Mises's criteria require (a) an image of a preferred state, (b) deliberate choice toward that state, (c) belief that the chosen action will reduce felt uneasiness relative to the alternative. This decomposes cleanly into three operational tests:

1. Does the system maintain a preferred state *across time*?
2. Does it model its current position relative to that state?
3. Does it verify candidate moves via simulation or search before selecting one?

Bare LLMs fail all three. The "preferred state" is whatever the current prompt context suggests, which changes every turn; there is no persistent goal. Current position is represented implicitly in token context, not modeled as queryable state. Candidate moves are not verified — the model generates the most probable next token and commits to it.

Cicero passes all three. The planner holds the goal across turns, the game state is modeled explicitly, and moves are evaluated against the reward model before selection. The LM's job is narration, not action.

This bar is auditable. Given any claimed "AI agent," you can ask: where does the preferred state live, how is current position represented, what simulator or search is consulted before acting? If the answers are "in the prompt," "in the context window," and "none," the system is reactive generation, not action. If the answers name explicit modules, the system might be acting — where "the system" is the composite, not the LLM alone.

The actor, in every case where there is one, is the architecture — not any single component.

## Implication for L5/L6 automation

The [Level 6](./level-6-direct-execution.md) discussion extends Shapiro's 0–5 coding scale with direct process execution. L5 (no-code / natural language → working system) and L6 (direct execution) only deliver on problems that sit in regime 2 or 3: state observable, actions enumerable, reward unambiguous.

Real business problems are often regime 4. Data acquisition is itself part of the problem. The solution space isn't enumerable. What counts as "solved" is contested by stakeholders with different utility functions. An L5 tool applied to such a problem hits the same wall LLMs hit at Catan: fluent output, no mechanical model of the business, contagion on best-practices framings, no way to verify claims against ground truth because ground truth isn't accessible.

**This relocates the human's job in an AI-assisted business problem.** The work isn't "describe the problem and let AI solve it." The work is *planner construction* — defining state, specifying reward, enumerating legal actions, identifying which claims can be verified against what. That's the part L5/L6 cannot do, and it's the prerequisite that automation silently assumes and cannot produce. "Figuring out the solution is still hard at L6" because the solution *is* the planning. The tool downstream of the planning is close to incidental.

Sharp criterion for when L5/L6 will actually deliver: **the domain must supply what a planner needs.** Where it does (price quoting, contract templating, well-scoped code generation), zero-code tooling is real and improving fast. Where it doesn't, the tool produces fluent output in proportion to model fluency, and no amount of scaling fixes it, because the missing machinery isn't in the model.

## What this page commits to

- **LLMs alone don't act** in the rigorous praxeological sense, even when they look fluent. They generate.
- **The composite architecture** (state model + value model + planner + *optional* dialogue layer) is what acts, and it converges independently across game-playing research programs because the problem shape demands it.
- **Planning is worth 100,000×** pretraining scale on measured domains (Go, poker). The burden of proof is on claims that this doesn't generalize.
- **Diplodocus demonstrates the dialogue layer is optional.** The planner alone, with no language model, won a Gunboat Diplomacy tournament against expert humans. When language is available it widens the communication channel; when it isn't, moves become costly signals and the planner carries the strategic content through them.
- **LLMs are language organs, not general cognition.** The biological analogue is Broca/Wernicke, not prefrontal cortex. Planning, goal-maintenance, and state simulation are separate organs in the brain and should be separate components in artificial systems.
- **The architectural prescription is specific**: SLM scoped to language I/O + dedicated reasoning engine + explicit connectors. Don't ask an LLM to do anything an SLM couldn't do; put the rest in the reasoning engine. This is the direction the industry is already drifting (tool use, RAG, MoE, MCP, orchestrators).
- **Markdown-based memory has an LM-at-memory dependency** that is honest to name — it's the price of human-readability, and it matches the brain's own language-mediated memory coordination. Split the load: mechanical where possible, judgment where necessary.
- **The agent bar is auditable**: maintain preferred state, model current position, verify via simulation. Systems that don't implement these three are reactive, not agentic, regardless of surface fluency.
- **L5/L6 automation** works where domains supply what a planner needs and fails where they don't. The human's contribution in business-problem collaborations is planner construction, not problem description.
- **Forward-looking-pure planners execute multiplayer self-balancing coalitions more cleanly than humans.** Human coordination problems often fail because grudge-motivation pulls players off the game-theoretic optimum (oppose the leader) into revenge targeting. Composite AIs have no grudge term; they converge on the leader independently without needing explicit coordination. This is a [specific design advantage](./gaming/multiplayer-coalition-problem.md#grudge-vs-forward-looking--why-the-dynamic-works-better-for-ai-than-for-humans) in any coordination problem depending on N≥3 equilibrium self-correction — scoped to games whose structure rewards coordinated resistance (Diplomacy, Monopoly, most negotiation games) rather than targeting weakness (poker).

The vault's position on AI agents is coherent across the [gaming](./gaming/llm-agents-across-games.md), [grounding](./llm-grounding-problem.md), [praxeology](./economics/llm-praxeology.md), [cyborg model](./cyborg-model.md), and [L6](./level-6-direct-execution.md) threads: something is doing the acting, but it's the architecture, not the LLM. The most important near-term question for AI engineering is not "how much bigger can we make the LLM" — it's "what's the planner, and does the domain support one."

## Open questions

- Does the 100,000× ratio hold in negotiation regimes where ground-truth reward is present but noisy (coalition games with ambiguous terminal payoffs)?
- What is the minimum viable planner for a regime-3 game — can it be as small as a few hundred lines, or does competent play require learned evaluators?
- How do you build a planner for a domain that doesn't supply closed state? Is the answer always "you can't, so restrict the domain," or is there a way to construct enough scaffolding to make regime-4 problems tractable?
- If the actor is the architecture, what is the moral/legal status of composite systems? This is a refinement of the standard AI-agency question that the praxeology page sets up.
- **How brain-like does the decomposition need to be?** The Broca/executive split is suggestive but not prescriptive. Are there cognitive capacities (memory consolidation, episodic retrieval, attention) that should also be separate components rather than folded into the LM? The brain suggests yes; current practice is unclear.
- **Does the SLM + reasoner + connectors architecture have a minimum viable implementation for general tasks?** Games are a clean proving ground because the reasoner is easy to specify. For general-purpose agents, the reasoner's design is the open research problem.
- **Costly signaling as a general capability.** Gunboat demonstrates that planners can learn signaling grammars in non-language channels. Can this generalize to AI systems coordinating with each other or with humans through non-verbal costly-signal channels (e.g., action logs, staking commitments, published code)? The vault's [planner-LM composite architecture](./gaming/gunboat-diplomacy-diplodocus.md#costly-signaling-vs-cheap-talk--the-analytical-frame) implies it should.
- **Memory-layer LM mitigation.** Given that markdown memory forces some LM role at the memory layer, what's the optimal split? How much can be pushed into mechanical structure (explicit cross-links, typed tags, front-matter) before the human-usability cost exceeds the machine-efficiency gain?

## Tags

[ai](../tags/ai.md), [agents](../tags/agents.md), [llm-limitations](../tags/llm-limitations.md), [game-ai](../tags/game-ai.md), [grounding](../tags/grounding.md)

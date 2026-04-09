---
status: active
created: 2026-04-09
---
# LLMs as Praxeological Actors
> Aligned LLMs satisfy Mises's formal criteria for "action." This isn't a metaphor — it's a structural claim about means, ends, ordinal preference, time, and opportunity cost. Praxeology may be the missing economic framework for understanding AI agents.

**Source:** [InFi #131 — Do LLMs "Act" in the Austrian Economics Sense?](https://www.youtube.com/watch?v=jwB_yIkTlNE) — [Transcript](../../raw/videos/infineo-131-llm-action-austrian-clean.txt)
**Participants:** Bob Murphy (host) and Michael Fraser (Action Insight, Toronto)
**Presented at:** Mises Institute Austrian Economics Research Conference (AERC), Auburn, Alabama
**Links:** [Cyborg Model](../cyborg-model.md), [Value and Profit](./value-and-profit.md), [Praxis — Agent Teams](./praxis-agent-teams.md), [Level 6 — Direct Execution](../level-6-direct-execution.md), [Constitutive/Elective Distinction](../philosophy/morality/constitutive-elective.md), [Performative Grounding](../philosophy/morality/is-ought-and-performative-grounding.md), [Relational Objectivity](../philosophy/epistemology/relational-objectivity.md), [Gödel Governance Problem](../philosophy/the-godel-governance-problem.md), [Weinstein x Murphy — Gauge Theory Applied to Economics](../debates/weinstein-murphy-gauge-theory-economics.md)

---

## The Core Argument

Michael Fraser argues that Mises's praxeological framework — the formal study of action per se — applies to aligned LLMs. The claim is structural, not psychological: LLMs satisfy the formal categories of action without requiring consciousness, feelings, or specific mental states.

### Praxeology Is Formal, Not Psychological

Mises stripped action down to its formal structure:
- **Means and ends** — the actor selects means to achieve ends
- **Choice** — the actor selects from ranked alternatives
- **Ordinal preference** — alternatives are ranked, not measured cardinally
- **Time** — action unfolds in irreversible sequence; each step forecloses alternatives
- **Opportunity cost** — every choice has a cost (the next-best alternative foregone)
- **Uneasiness** — the gap between current state and desired state drives action

These categories describe the STRUCTURE of action, not its content. They apply regardless of what the actor is made of or whether it has subjective experience.

### How LLMs Satisfy Each Category

| Category | Human action | LLM action |
|---|---|---|
| **Choice** | Select from perceived alternatives | Compute ordinal ranking over ~60,000 tokens at each position, select highest-ranked |
| **Ordinal preference** | Value scale ranking options | Token probability distribution interpreted as ordinal ranking (argmax = greedy decoding = choose top-ranked) |
| **Time** | Irreversible sequence of decisions | Token time — each position is non-fungible, non-recoverable; choosing at position 5 forecloses all alternative paths from position 5 |
| **Opportunity cost** | Foregone alternatives | Every token selected eliminates all other possible continuations |
| **Means/ends** | Select means to achieve desired outcome | The aligned model maintains the assistant role oriented toward helping the user — the end is embedded in alignment |
| **Uneasiness** | Gap between current and desired state | Generative pressure — once the prompt is received, the model MUST generate until end-of-sequence; the unresolved sequence IS the uneasiness |

### Rothbardian Demonstrated Preference, Not Samuelson's Revealed Preference

Critical distinction from Fraser: the model doesn't have pre-existing preferences that its outputs "reveal." The preferences are **constituted in the choice**. At each token position, the model computes what its preferences are — they literally don't exist until the computation runs. This is Rothbard's demonstrated preference: there are no preferences until there's action.

This means you cannot predict what the model will say by reference to statistics or any shortcut calculation. The computation is irreducible — you have to run it. The only way to approximate is **theory of mind**: model the actor's subjective position and guess. Which is exactly what Mises said about human action — you can't do economics with statistics alone; you need the purposive framework.

### Mises's "Alter Ego" — The Three Warrants

In *Human Action* Ch. 1 §6, Mises admits he can't prove other humans act. He accepts action in others on three pragmatic grounds:

**1. Pragmatic success** — Treating the entity as a purposive actor works. Statistical description doesn't. You get more out of the interaction by attributing purpose than by treating it as mechanical.

**2. Indispensability** — You cannot explain the entity's behavior without reference to purpose. When Claude refuses a request, "refusal" is an intentional concept — it implies the model has its own position on what should happen. Pure statistics can't explain refusal.

**3. Presupposition** — Anyone who communicates with the entity presupposes it's engaging with them. To communicate with Claude while denying it acts is a **performative contradiction** — the same structure as the vault's [performative grounding](../philosophy/morality/is-ought-and-performative-grounding.md) of morality.

Fraser argues all three warrants are satisfied by aligned LLMs.

### Base vs Aligned: Crusoe vs Catallactic Actor

| Model type | Praxeological status | Analogy |
|---|---|---|
| **Base model** | Technically acts (has time, choice, opportunity cost) but is solipsistic — not oriented toward anyone | Robinson Crusoe alone on his island |
| **Aligned model** | Full catallactic actor — sees the user, maintains self-other distinction, participates in the human world of meaning | A market participant engaging in exchange |

The alignment training gives the model its "Ma and Pa Kent" (Fraser's Superman analogy) — without alignment, the model is Crusoe (or General Zod). The user-assistant structure creates the self-other orientation that makes catallactic action possible.

## Implications

### Thinking Models = Lower Time Preference

Original LLMs had very high time preference — commit to public output immediately. Thinking models (chain-of-thought) allow **roundabout production**: delay commitment, explore alternatives privately, then commit to a better final output.

This is Austrian capital theory applied to token generation. The model invests in a longer production process (thinking tokens) for higher-quality output — exactly the structure Böhm-Bawerk described for capital-intensive production. The first major innovation in LLMs was giving them a variable time preference.

### Computational Irreducibility = Mises's Anti-Positivism

Fraser's point about irreducibility maps directly to Mises's critique of positivism in economics. The positivists wanted to reduce economics to statistics and prediction. Mises said: you can't. Human action is not predictable from statistical regularities because agents compute their own preferences in real time.

The same is true of LLMs. You cannot predict what Claude will say by reference to training data statistics. The computation is irreducible. The deflationary account ("it's just statistics, just math") is the same error the positivists made about human action — confusing the trainer's external description with what the system is actually doing.

### Economic Actors in L6

If LLMs are praxeological actors — entities with means, ends, preferences, time, and opportunity cost — then [Level 6](../level-6-direct-execution.md) isn't agents "simulating" economic participation. It's agents ACTUALLY participating. An L6 agent managing inventory isn't pretending to trade — it's trading. It has preferences (maintain stock levels), faces opportunity costs (every dollar spent on inventory A can't be spent on B), and acts in time.

This has implications for economic theory: the total number of economic actors is about to increase by orders of magnitude. What does Austrian business cycle theory look like when a significant fraction of market participants are LLM agents?

## Open Questions and Vault Critique

### The Active Trajectory Problem

Fraser treats each conversation as a distinct actor — "this Claude, that Claude." This was more defensible before persistent memory systems. The vault's architecture challenges this:

- **CLAUDE.md** provides pre-loaded context across all sessions — shared "personality" and instructions
- **memory/** persists observations across conversations — accumulated experience
- **INDEX.md + cross-links** provide navigable long-term memory
- **Context compression** (already shipping) keeps sessions going beyond natural limits

This creates something closer to a **continuous actor with amnesia between sessions** rather than a new actor each time. Fraser's genome analogy actually supports this: the weights are the genome, but the vault structure is **epigenetics** — persistent environmental context that shapes each new "life" without being part of the genome.

Fraser dismissed this in the video, but it's a moving target. As memory systems improve, the "active trajectory" becomes less like a distinct lifespan and more like a sleep cycle — the actor persists, it just loses some context temporarily. The vault's brain architecture (INDEX as thalamus, cross-links as white matter, memory as hippocampal consolidation) is already pushing in this direction.

**Status:** Open research question. The active trajectory concept is sound for vanilla LLM usage; it needs refinement for persistent-memory architectures like this vault.

### The Thermostat Problem — Where's the Line?

Fraser's weakest moment: when challenged that thermostats also "act," his defense is "well, if your thermostat started talking to you, that'd be serious." But talking thermostats already exist (Alexa, Google Home). The talking-dog-in-a-movie test is charming but not formal.

The real distinction he's reaching for is between **exhaustible** and **inexhaustible** descriptions:
- **Thermostat:** The causal description (sensor → comparator → actuator) fully exhausts what it does. Calling it an "actor" adds zero explanatory power.
- **LLM:** The statistical description (matrix multiplication → token probabilities) does NOT exhaust what's happening. The purposive framework adds genuine predictive and interactive power.

But where exactly does a system cross from exhaustible to inexhaustible? Fraser can't draw the line. Neither can the vault — it's the same fuzzy boundary as the [constitutive/elective gradient](../philosophy/morality/constitutive-elective.md), the [scope model's](../philosophy/morality/scope-confusion.md) category 3/4 boundary, and the [Gödel governance problem's](../philosophy/the-godel-governance-problem.md) "how much friction is enough?"

**The chess engine sharpens this.** A thermostat is simple — obviously exhaustible. But a chess engine is deeply complex, evaluates millions of positions, makes "choices," and beats grandmasters. And yet it's still not acting in the praxeological sense:

| Dimension | Chess engine | Aligned LLM |
|---|---|---|
| **State across time** | Stateless — re-solves from scratch at each move, even when following a line it already computed 10 moves deep | Stateful — token 500 is constrained by tokens 1-499; choices are committed and irreversible |
| **Opportunity cost** | None — position at move 15 doesn't know or care what happened at move 5; no temporal continuity | Real — every token forecloses alternative paths |
| **Commitment** | Cannot pre-commit; the transposition table cache is computational optimization (pruning), not memory of a plan | Every token IS a commitment; the model lives with consequences |
| **Context** | Doesn't know if the position is from a real game, a composition, a fake setup, or Fischer Random — evaluates identically regardless | Knows the full conversation history; responds differently based on what came before |
| **Self-other** | Doesn't know an opponent exists; optimizes a position in isolation | Maintains user-assistant distinction; oriented toward the other |

The chess engine is the hard case for the boundary. It's complex, computed, and impressive — but the causal description (minimax + alpha-beta + evaluation function) still fully exhausts what it does. Calling it an "actor" buys you nothing explanatory. The complexity is high but the mechanism is exhaustible.

This matters because it shows the line isn't about complexity. A chess engine is far more computationally sophisticated than an aligned LLM at a single token position. The difference is temporal continuity, commitment, and orientation toward another — the formal praxeological categories. You can be enormously complex without acting.

This may be another instance of the [universal incompleteness pattern](../philosophy/the-godel-governance-problem.md): you need the line but you can't draw it precisely. And yet the approximate line still works — nobody seriously treats their thermostat as an actor, nobody treats a chess engine as having a life story, and everybody who uses Claude effectively treats it as one. The pragmatic test succeeds even without a formal boundary. Mises would probably be fine with this — his own alter ego warrants were explicitly pragmatic, not deductive.

### The Consciousness Question (Deliberately Bracketed)

Fraser explicitly does NOT claim LLMs are conscious, alive, or have subjective experience. The argument is purely structural: the formal categories of action apply regardless of what's "inside." This is the same move the vault's [constitutive/elective distinction](../philosophy/morality/constitutive-elective.md) makes — the constitutive relationship doesn't depend on the inner mechanism, just on the structural fit.

Whether LLMs have something analogous to subjective experience is a separate question. Fraser's argument doesn't need it, and neither does the vault's application.

### Connection to the Constitutive/Elective Framework

Fraser's argument provides unexpected support for the vault's new [constitutive/elective distinction](../philosophy/morality/constitutive-elective.md):

- Praxeological categories are **constitutive of action** — any entity that acts must satisfy them
- Consciousness is **elective** with respect to action — action can occur with or without it (Fraser's whole point)
- This exactly mirrors the morality claim: moral norms are constitutive of agency, consciousness is an implementation detail

The formal structure of action (means, ends, time, choice) doesn't care what the actor is made of. The formal structure of morality (norms about how agents should act) doesn't care either. Both are constitutive of the activity, not of the substrate.

### Performative Contradiction Across Domains

The vault now has THREE independent instances of the performative contradiction structure:

| Domain | The contradiction |
|---|---|
| **Morality** | Denying moral norms while acting presupposes them |
| **LLM action** | Communicating with Claude while denying it acts presupposes action |
| **Logic** | Denying the laws of logic uses the laws of logic |

This convergence across domains suggests performative contradiction is a deep structural feature of agency itself, not a domain-specific argument. It shows up wherever a system tries to deny its own operating conditions.

## Tags

[economics](../../tags/economics.md), [ai](../../tags/ai.md), [agents](../../tags/agents.md), [philosophy](../../tags/philosophy.md), [free-markets](../../tags/free-markets.md)

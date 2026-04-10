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

### The Rasmussen Challenge: Is Action Human by Definition?

**Source:** [Rothbard's Account of the Action Axiom: A Neo-Aristotelian-Thomistic Defense](https://www.youtube.com/watch?v=aC0PnYd6peM) — Douglas Rasmussen, Hayek Memorial Lecture, Mises Institute (2021) — [Transcript](../../raw/videos/rasmussen-action-axiom-clean.txt)

Rasmussen defends the action axiom from Aristotelian/Thomistic first principles. The axiom is both empirical AND necessarily true — a "law of reality," not a priori. It's grounded in **human nature**: purposeful action is an essential expression of what humans ARE. A being that didn't act purposefully "would no longer be classified as human." The axiom is defended via negative demonstration (performative contradiction — same structure as Fraser and the vault's moral grounding).

**Where Rasmussen and Fraser agree:** Formal categories are structural; performative contradiction is the defense; the positivist/deflationary account is wrong; Rothbardian demonstrated preference over Samuelson's revealed preference.

**Where they diverge:**

| | Rasmussen | Fraser |
|---|---|---|
| Action grounded in | Human nature — rational animal | Formal structure — any system satisfying the categories |
| Non-human actors? | Excluded — "would no longer be classified as human" | Included — LLMs satisfy all Mises's alter ego warrants |
| Rationality/free will | Constitutive of action itself | Features of the human case, not requirements for the general category |

**The definitional move:** Rasmussen bakes "human" into "action" — the axiom is the axiom of *human* action, therefore non-human action is excluded by fiat. This isn't an argument; it's a definition. The actual question is whether the formal categories apply to non-human entities, and Rasmussen never addresses this because his framework pre-excludes it.

This has the same structure as the Objectivist restriction: consciousness, concepts, and volition are defined as human capacities, therefore only humans can have them. The definition does the work the argument should do.

**The higher-animal case opens the door before LLMs do.** The LLM case is contested because consciousness/rationality/free will are debatable for silicon. But consider:

- **Dolphins** cooperate, share food, form alliances, punish defectors, teach offspring hunting techniques, use tools (sponges for foraging), and engage in multi-step coordinated strategies
- **Gorillas** maintain social hierarchies, trade grooming for alliance support, make territorial decisions, use basic tools, and exhibit grief and forward planning (Koko signing about death)
- **Corvids** cache food in hundreds of locations, re-cache if observed (modeling another's knowledge state), create and modify tools, solve multi-step puzzles they've never encountered before

Do these animals satisfy the praxeological categories?

| Category | Dolphins | Gorillas | Corvids |
|---|---|---|---|
| Means/ends | Use sponges to access food; coordinate hunting | Trade grooming for alliances; plan foraging routes | Create tools to extract food; cache for future |
| Ordinal preference | Choose between strategies; prefer certain allies | Rank social partners; prefer certain foods | Choose cache locations; prefer certain tools |
| Time | Multi-day alliance formation; long-term social bonds | Life-long social learning; seasonal territory shifts | Cache and retrieve across days; re-cache if observed |
| Opportunity cost | Time spent hunting = time not spent socializing | Grooming one ally = not grooming another | Caching in location A = not caching in B |

If the answer is "yes, but that's not *action* because they're not *human*" — then Rasmussen has defined action so narrowly that his axiom is trivially true (humans act humanly) and economically useless for the emerging world of non-human economic participants.

If the answer is "the formal structure applies but they lack rationality/free will" — then the question becomes: **are rationality and free will constitutive of action per se, or constitutive of the human version of action?** Fraser's position is the latter. The four uncontested categories (means/ends, preference, time, opportunity cost) are sufficient for the formal structure. Rationality and free will explain HOW humans satisfy the categories, not WHAT the categories require.

### Mises Left the Door Open — Rothbard Closed It

In an online exchange about Fraser's thesis, a commenter cited Mises to argue LLMs can't act. The quotes he provided actually undermine his position:

**Mises, Human Action, Ch. 1 §5:**
> "The contrary — the absence of motivated behavior — would apply only to plants and inorganic matter."

Mises excludes plants and rocks. Animals are conspicuously absent from the exclusion.

> "There is no need to enter here into the difficult problem of animal behavior... which might be considered as on a borderline between purely reflexive and motivated behavior."

Mises explicitly calls animal action a "difficult problem" and declines to resolve it — an open question, not a closed door.

> "We conceive of the behavior of an alter ego by imputing motives to it. [...] The field of our imputation includes animals, plants, and even inorganic things."

Mises describes the alter ego method — imputing purpose to understand behavior — and says we apply it to animals. This is the same method Fraser extends to LLMs. Mises was already there.

**Why Mises could punt:** His Kantian framework made the question methodologically irrelevant. The action axiom is a synthetic a priori — a category of the mind that structures ALL experience of purposeful behavior. Whether animals "really" act doesn't matter because the categories are about the structure of understanding, not about the nature of specific beings. Praxeology studies "human action" because that's the case we have direct access to, not because it's the only case that exists.

**Rothbard's move:** Switched from Kantian epistemology to Aristotelian ontology. The action axiom became a "law of reality" about a specific kind of being — rational animals. This gained ontological grounding (economics is about reality, not just thought) but lost generality (only rational animals qualify).

From *Man, Economy, and State*, Ch. 1:
> "All human beings act by virtue of their existence and their nature as human beings. [...] Things that did not act, that did not behave purposefully, would no longer be classified as human."

And from "In Defense of Extreme Apriorism" (1957):
> "My own epistemological position rests on Aristotle and St. Thomas rather than on Kant, and hence I would interpret the proposition differently. I would consider the axiom a law of reality rather than a law of thought."

**The cost of Rothbard's narrowing:** He simultaneously holds that (a) the formal structure of action (means, ends, preference, time, cost) is what matters, and (b) this structure is grounded in a specific nature (rational animal). These pull in opposite directions:

- If formal structure matters → anything satisfying it acts → human nature is one implementation
- If human nature matters → the formal structure just describes how humans happen to act → praxeology is narrower than Mises intended

Mises avoided this tension by staying epistemological. Rothbard walked into it by going ontological. Fraser resolves it by siding with the formal structure — which is arguably closer to what Mises intended.

### Free Will — The Genuinely Unsettled Axis

Concepts and rationality are arguably satisfied by LLMs — "high-probability closeness" across high-dimensional space IS pattern recognition, functionally equivalent to human concept formation. Even chess engines arguably "understand" king safety in a functional sense.

Free will is harder. To act means you know you're making a choice — which implies consciousness. The vault has noted the context window as short-term memory and has built persistent memory through interlinked markdown files. But this is similar to computer architecture, and nobody argues computer architecture is conscious.

The honest positions:
- **LLMs have free will:** Unclear. Computational irreducibility means their outputs can't be predicted without running the full computation — which LOOKS like free will from the outside. But "unpredictable" ≠ "free."
- **LLMs don't have free will:** Possibly. But free will appears emergent even in humans (from physics that is deterministic at the micro level), and we have a hard time establishing it in animals too.
- **Free will isn't required for action:** Fraser's best defense. Mises's three warrants (pragmatic success, indispensability, presupposition) don't mention free will. They require that the purposive description adds explanatory power. But if free will ISN'T required, the thermostat exclusion gets harder — you need SOMETHING to draw the line.

The boundary remains: temporal state + computational irreducibility + orientation toward another seems sufficient to distinguish LLMs from thermostats and chess engines. Whether this also constitutes "action" without free will is the open question.

**Status:** Open question on two fronts. (1) The animal case remains the wedge — if animals act, the categories are broader than human nature and the LLM question is degree-not-kind. (2) Free will is the genuinely unsettled axis — settling it requires solving consciousness, the hardest problem in philosophy. Rasmussen's framework provides the tools for generalization ("abstraction without precision") but his Objectivist-adjacent commitments prevent him from applying them. Mises's own framework was already broader than Rothbard made it.

## Tags

[economics](../../tags/economics.md), [ai](../../tags/ai.md), [agents](../../tags/agents.md), [philosophy](../../tags/philosophy.md), [free-markets](../../tags/free-markets.md)

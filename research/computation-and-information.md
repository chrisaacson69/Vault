# Computation and Information Theory
> What can be computed, what can be known, and what emerges from the limits of both.

**Status:** stub — connections mapped, detail to follow
**Created:** 2026-02-19
**Links:** [Measurement, Causality, and Free Will](./philosophy/measurement-causality.md), [Logic and Mathematics](./philosophy/logic-and-math/README.md), [LLM Grounding Problem](./llm-grounding-problem.md), [Cognitive vs. Motor Skills](./cognitive-vs-motor.md), [Triangular Arbitrage](../projects/triangular-arbitrage/README.md)

## Why This Matters

Computation and information theory sit underneath several threads in the vault:

- **Free will** — computational irreducibility is the mechanism by which organized complexity produces genuine agency (see [measurement-causality](./philosophy/measurement-causality.md))
- **LLM limitations** — what computation can and can't capture about physical reality
- **Formal systems** — Gödel showed arithmetic can't fully describe itself; Turing showed computation has equivalent limits
- **Market structure** — algorithmic detection of arbitrage is a computational problem with information-theoretic constraints

## Core Thinkers

### Alan Turing — Computability
- The Turing machine defines what "computable" means — a function is computable iff a Turing machine can calculate it
- **The halting problem:** No algorithm can determine whether an arbitrary program will halt or run forever. Computation has hard limits on self-knowledge.
- Direct parallel to Gödel: incompleteness (logic) ≈ undecidability (computation). Formal systems can't fully describe themselves, computers can't fully predict themselves.
- **Connection to free will:** If a system is computationally irreducible, you can't predict its output without running it — which is structurally identical to "you can't know what it will choose until it chooses."

### Claude Shannon — Information Theory
- Information is quantified as reduction of uncertainty (bits)
- **Channel capacity:** Every communication channel has a maximum rate at which information can be reliably transmitted (noisy channel theorem)
- **Entropy:** The measure of uncertainty/disorder in a system — connects to thermodynamics and the arrow of time
- **Connection to measurement-causality:** Each measurement reduces uncertainty (collapses possibilities), which IS information in Shannon's sense. Causality is the propagation of information through physical interaction.

### Stephen Wolfram — Computational Irreducibility
- **A New Kind of Science (2002):** Simple rules (cellular automata) can produce behavior so complex that no shortcut exists to predict the outcome — you must run the computation step by step
- **Computational equivalence principle:** Most systems above a minimal complexity threshold are equivalent in computational power — they can all simulate each other
- **Connection to free will:** This is the formal version of the "third category" argument. A computationally irreducible system is neither determined (no formula predicts it) nor random (it follows rules). It's something else — and that something else is where agency lives.
- **Connection to structural realism:** Wolfram argues the universe IS computation. Chris's position would be more cautious: computation is an extraordinarily useful model of the universe, but still a model (consistent with the [logic-and-math](./philosophy/logic-and-math/README.md) position).

### Kurt Gödel — Incompleteness (cross-ref)
- Already covered in [Logic and Mathematics](./philosophy/logic-and-math/README.md)
- Key connection here: Gödel, Turing, and Church independently proved equivalent results — formal systems, computation, and lambda calculus all hit the same wall. The limit isn't a property of any one formalism; it's structural.

## Topics to Develop

### Computability and Complexity
- P vs NP — the biggest open question in CS. Can every problem whose solution is quickly verifiable also be quickly solved?
- Complexity classes and what they mean for practical computation
- Algorithmic information theory (Kolmogorov complexity) — the shortest program that produces a given output. Connects to randomness: a string is random iff it can't be compressed.

### Information in Physics
- Landauer's principle — erasing information requires energy (connects information to thermodynamics)
- Black hole information paradox — does information survive crossing an event horizon?
- Wheeler's "it from bit" — the idea that physical reality is fundamentally informational
- Connection to measurement-causality: if measurement = information gain, and causality = information propagation, then information IS the substrate of causality

### Computation in Markets
- Algorithmic trading as a computational problem
- Information asymmetry and market efficiency (connects to [triangular arbitrage](../projects/triangular-arbitrage/README.md))
- Hayek's knowledge problem — markets as distributed computation. No central planner can compute what the price system computes spontaneously.

### Self-Reference and Strange Loops
- Gödel sentences, quines (programs that output themselves), fixed-point theorems
- Hofstadter's contribution: popularized self-reference as the key to consciousness (via *Gödel, Escher, Bach*)
- Chris's assessment: Hofstadter is a synthesizer/popularizer, not a theorist. The insights belong to Gödel, Turing, and the formal tradition. The "strange loop" concept is evocative but not rigorous.

## Open Questions

- Does computational irreducibility require ontological indeterminacy (quantum randomness), or is it sufficient on its own to ground free will even in a deterministic universe?
- Is Wolfram right that the universe IS computation, or is computation another map (consistent with structural realism)?
- How does Shannon entropy relate to thermodynamic entropy? Are they the same thing viewed from different angles, or genuinely distinct?
- Can Kolmogorov complexity provide a formal definition of "information generation" that distinguishes free agents from complex-but-determined systems?
- Hayek's knowledge problem + computational irreducibility: is this a formal proof that central planning is impossible, not just impractical?

## Suggested Reading

| Work | Author | Relevance |
|------|--------|-----------|
| *On Computable Numbers* (1936) | Alan Turing | Foundation of computability theory |
| *A Mathematical Theory of Communication* (1948) | Claude Shannon | Foundation of information theory |
| *A New Kind of Science* (2002) | Stephen Wolfram | Computational irreducibility thesis |
| *Gödel, Escher, Bach* (1979) | Douglas Hofstadter | Self-reference and consciousness (popularization) |
| *The Emperor's New Mind* (1989) | Roger Penrose | Non-computability of consciousness (counterpoint to Wolfram) |
| *Chaos* (1987) | James Gleick | Accessible introduction to nonlinear dynamics and sensitivity to initial conditions |

## Tags
[ai](../tags/ai.md), [philosophy](../tags/philosophy.md), [mathematics](../tags/mathematics.md)

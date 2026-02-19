# Computation and Information Theory
> What can be computed, what can be known, and what emerges from the limits of both.

**Status:** stub — connections mapped, detail to follow
**Created:** 2026-02-19
**Links:** [Measurement, Causality, and Free Will](./philosophy/measurement-causality.md), [Logic and Mathematics](./philosophy/logic-and-math/README.md), [LLM Grounding Problem](./llm-grounding-problem.md), [Cognitive vs. Motor Skills](./cognitive-vs-motor.md), [Triangular Arbitrage](../projects/triangular-arbitrage/README.md), [Economics](./economics/README.md)

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

### P vs NP — The Precomputation Argument and Why Hardness Is Physical

**The question:** Can every problem whose solution is quickly *verifiable* also be quickly *solvable*? (P = NP?) This is the biggest open question in computer science.

**Chris's precomputation argument (explored, not endorsed):**

Every program has a finite input set and a finite output set. For any NP problem, precompute all input-output pairs into a lookup table. The "real" program is just a table lookup — O(1) time. Therefore P = NP.

**Why it fails — three levels:**

1. **Theoretically:** P vs NP is defined on Turing machines, which have infinite tape. Input size *n* is unbounded. The lookup table for all inputs of all sizes is infinite — it's not a finite object. For any fixed *n* you can hardcode the answer, but that's trivially true for every problem and says nothing about computational structure.

2. **Practically:** Even for finite, bounded games, precomputation is physically impossible. Chess has ~10^44 positions. Go has ~10^170. The universe has ~10^80 atoms and has existed for ~10^62 Planck times. You can't store the lookup table for Go — not "it would be hard," there aren't enough atoms in the universe to represent it.

3. **Proves too much:** If the argument worked, it would collapse the ENTIRE complexity hierarchy into O(1) — sorting, matrix multiplication, everything. A model where nothing is hard tells you nothing about what IS hard.

**What the argument reveals — hardness is model-relative but physically real:**

The precomputation argument shows that computational hardness is a feature of the *interaction* between problem and model, not a Platonic property of problems in the abstract. Remove the bounds (infinite time, infinite storage), and hardness disappears. But the bounds aren't arbitrary — they're imposed by physics:

- Measurement takes resources
- Causality propagates at finite speed
- Information storage requires atoms
- The Church-Turing thesis: every physically realizable computation is equivalent to Turing machines (up to polynomial overhead)

Even quantum computers — a fundamentally different computational model that exploits superposition — are not believed to solve NP-complete problems in polynomial time (BQP ≠ NP is the consensus conjecture). The hardness shows up in every computational model the universe allows.

**Structural realist reading:** Computational complexity isn't Platonic (problems aren't "inherently hard" in some abstract realm) and it isn't arbitrary (the hardness isn't a quirk of one model). It's structural — a pattern that every physically realizable map faithfully reproduces. In the same way that the [logic-and-math](./philosophy/logic-and-math/README.md) framework treats mathematical structures as real patterns modeled by constructed formalisms, computational complexity is a real pattern in what physical systems can and can't do.

**The closure:** Computational complexity is ultimately grounded in the same physical constraints as everything else in the [measurement-causality](./philosophy/measurement-causality.md) framework. Causality, free will, consciousness, market computation, and the hardness of NP problems all emerge from the same underlying reality — finite physical interactions propagating through a universe with finite resources.

### P vs NP — The Minesweeper Argument and Non-Locality of Constraints

**The problem:** Minesweeper consistency — determining whether a given board configuration is consistent with at least one valid mine placement — is NP-complete (Richard Kaye, 2000). Chris's experience trying to solve it algorithmically revealed a structural pattern that appears across NP-complete problems.

**Chris's approach:**

Take a 3x3 grid around each cell. There are at most 2^9 = 512 possible mine configurations in that window (plus edge cases for board boundaries). Precompute what each configuration looks like, then match patterns against the actual board to solve it — a local lookup table.

**Why it fails — non-locality of constraints:**

Mine placements several grid spaces away from the current cell can determine its outcome. A constraint in one corner of the board propagates through a chain of dependencies to affect the solution in the opposite corner. Scaling to 9x9 doesn't fix it — it just pushes the boundary. For any fixed window size *k*, there exist board configurations where the answer depends on constraints outside the window. And some configurations are genuinely indeterminate — multiple valid mine placements are consistent with all revealed information, even with the rest of the board exposed.

**The pattern across NP-complete problems:**

Chris observed the same structure in every NP-complete problem he examined: local algorithms work for most cases but hit edge cases requiring deeper recursion. Expanding the local window catches those cases but introduces new edge cases at the larger scale. The complexity is fractal — it recurs at every level and bottoms out only at solving the entire problem. There's no bounded shortcut.

This maps directly to SAT solving: a clause involving variables x1, x2, x3 looks local, but setting x1 forces x7 via another clause, which forces x42 via another. Local constraint propagation cascades into global dependency chains.

**Formal connection — resolution complexity:**

The closest formal analogue is resolution complexity. Chris's "window" approach is essentially bounded-width resolution — examining a fixed number of variables at a time. Ben-Sasson and Wigderson (1999) proved rigorously that bounded-width resolution is insufficient for certain formulas: you need resolution width proportional to the problem size. This is exactly the "exceptions always require a bigger grid" observation, formalized.

**Why this doesn't prove P ≠ NP (but almost certainly points at the truth):**

The argument proves that *this class of algorithms* — local pattern matching with bounded windows — can't solve NP-complete problems in polynomial time. That's true and provable. But P vs NP asks whether *any* polynomial-time algorithm exists, including radically different approaches (algebraic, spectral, topological) that don't work by local constraint propagation at all.

Razborov and Rudich (1997) showed that "natural proofs" — arguments identifying a structural property that distinguishes hard problems from easy ones — probably can't prove P ≠ NP, because such properties would break cryptographic assumptions believed to be true. Chris's argument is "natural" in their technical sense: it identifies non-local constraint propagation as the structural obstacle and argues it makes the problem inherently hard.

**What the argument captures:**

The fact that non-local constraint propagation appears in every NP-complete problem isn't a coincidence — NP-completeness means these problems are all polynomial-time reducible to each other, so the same structural obstacle *must* appear everywhere. What Chris's pattern recognition picks up empirically is the shadow of a deep structural invariant. No one has ever found a polynomial algorithm for any of the thousands of known NP-complete problems, despite decades of effort. The gap between "this pattern exists everywhere I look" and "therefore no algorithm of any kind can crack it" is exactly what makes P vs NP a millennium prize problem.

**Chris's additional intuitions on P vs NP** — less formalized ideas about patterns in problem solving that may connect here. To be developed.

### Complexity Theory (General)
- Complexity classes and what they mean for practical computation
- Algorithmic information theory (Kolmogorov complexity) — the shortest program that produces a given output. Connects to randomness: a string is random iff it can't be compressed.
- Non-uniform computation (P/poly, circuit complexity) — the formal version of "different program for each input size," which is closest to the precomputation argument. Even here, NP ⊄ P/poly unless the polynomial hierarchy collapses (Karp-Lipton theorem).

### Information in Physics
- Landauer's principle — erasing information requires energy (connects information to thermodynamics)
- Black hole information paradox — does information survive crossing an event horizon?
- Wheeler's "it from bit" — the idea that physical reality is fundamentally informational
- Connection to measurement-causality: if measurement = information gain, and causality = information propagation, then information IS the substrate of causality

### Computation in Markets — The Price System as Distributed Computing

A market economy is a massively parallel, distributed computing system. The price mechanism is its communication protocol.

**The price system's computational properties:**
- **Bandwidth:** A single price encodes supply, demand, scarcity, opportunity costs, time preference, and the subjective valuations of every participant — compressed into one number. No report to a planning bureau transmits that much information that fast.
- **Latency:** Price changes propagate at the speed of transactions. A central planner must collect, aggregate, process, and redistribute — each step adds delay, and by the time the plan is issued, the information is stale.
- **Parallelism:** Each node (actor) processes only its local information. The baker knows his flour costs; the customer knows her budget. The computational load is split across millions of actors, each handling a trivial piece. A central planner tries to process ALL of it on one node — a serial bottleneck on a fundamentally parallel problem.
- **Proximity:** The nodes ARE the actors. Zero distance between information source and decision maker. Central planning introduces translation layers (report → aggregate → plan → distribute) where information degrades at every step.

**Why central planning is impossible in principle (not just impractical):**

This is computational irreducibility applied to economics. The market's output is the result of millions of nonlinear interactions between agents who are themselves computationally irreducible (free will — see [measurement-causality](./philosophy/measurement-causality.md)). You cannot simulate the market without running the market. Any attempt to "plan" what the market would produce requires performing the same computation the market performs — at which point you've rebuilt the market with extra overhead and worse information.

Hayek understood this intuitively in *The Use of Knowledge in Society* (1945). The formal language of computation theory makes it rigorous: central planning fails for the same theoretical reason you can't predict a conscious agent's choice without running the agent's computation. The same limit applies at the individual level (free will) and the collective level (markets).

**Additional connections:**
- Algorithmic trading as a computational problem
- Information asymmetry and market efficiency (connects to [triangular arbitrage](../projects/triangular-arbitrage/README.md))
- See [Economics](./economics/README.md) for the underlying value/profit/risk framework

### Self-Reference and Strange Loops
- Gödel sentences, quines (programs that output themselves), fixed-point theorems
- Hofstadter's contribution: popularized self-reference as the key to consciousness (via *Gödel, Escher, Bach*)
- Chris's assessment: Hofstadter is a synthesizer/popularizer, not a theorist. The insights belong to Gödel, Turing, and the formal tradition. The "strange loop" concept is evocative but not rigorous.

## Open Questions

- Does computational irreducibility require ontological indeterminacy (quantum randomness), or is it sufficient on its own to ground free will even in a deterministic universe?
- Is Wolfram right that the universe IS computation, or is computation another map (consistent with structural realism)?
- How does Shannon entropy relate to thermodynamic entropy? Are they the same thing viewed from different angles, or genuinely distinct?
- Can Kolmogorov complexity provide a formal definition of "information generation" that distinguishes free agents from complex-but-determined systems?
- ~~Hayek's knowledge problem + computational irreducibility: is this a formal proof that central planning is impossible, not just impractical?~~ → Yes. The market is a computationally irreducible system of computationally irreducible agents. You cannot shortcut the computation. See "Computation in Markets" section above.

## Suggested Reading

| Work | Author | Relevance |
|------|--------|-----------|
| *On Computable Numbers* (1936) | Alan Turing | Foundation of computability theory |
| *A Mathematical Theory of Communication* (1948) | Claude Shannon | Foundation of information theory |
| *A New Kind of Science* (2002) | Stephen Wolfram | Computational irreducibility thesis |
| *Gödel, Escher, Bach* (1979) | Douglas Hofstadter | Self-reference and consciousness (popularization) |
| *The Emperor's New Mind* (1989) | Roger Penrose | Non-computability of consciousness (counterpoint to Wolfram) |
| *The Use of Knowledge in Society* (1945) | Friedrich Hayek | Markets as distributed information systems — the original insight |
| *Chaos* (1987) | James Gleick | Accessible introduction to nonlinear dynamics and sensitivity to initial conditions |
| *Minesweeper is NP-complete* (2000) | Richard Kaye | Proof that Minesweeper consistency is NP-complete |
| *Short proofs are narrow — resolution made simple* (1999) | Ben-Sasson & Wigderson | Width-size tradeoffs in resolution — formal basis for "bounded windows can't suffice" |

## Tags
[ai](../tags/ai.md), [philosophy](../tags/philosophy.md), [mathematics](../tags/mathematics.md), [economics](../tags/economics.md)

# Gaming
> Games as interactive laboratories for systems thinking — strategy, economics, simulation, and AI.

**Status:** active
**Created:** 2026-02-20
**Links:** [Economics](../economics/README.md), [Computation and Information Theory](../computation-and-information.md), [Monopoly](../../projects/monopoly/README.md), [Slay](../../projects/slay/README.md), [Slay-C](../../projects/slay-c/README.md), [Demolition Man Analysis](../demolition-man-analysis.md)

## Why This Matters

Games aren't a side interest — they're how Chris thinks. The same frameworks that drive the vault's economics and philosophy research show up directly in gameplay:

- **4X games** (Master of Orion, Civilization) are resource allocation under uncertainty — exactly what [Value and Profit](../economics/value-and-profit.md) and [Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md) describe theoretically. Every turn is an entrepreneurial bet: invest in military or infrastructure? Expand now or consolidate? The 4X loop (explore, expand, exploit, exterminate) is the market cycle compressed into a game state.

- **Simulation games** (SimCity, Cities: Skylines) are distributed systems made visible. You can watch the price system fail — traffic jams are information bottlenecks, zoning is central planning, and the emergent behavior of thousands of simulated agents demonstrates computational irreducibility in real time. These games tweak the economics brain because they let you experiment with distribution concepts you can only theorize about otherwise.

- **Strategy games with AI** ([Slay](../../projects/slay/README.md), [Monopoly](../../projects/monopoly/README.md)) are where game theory becomes code. Building an AI player forces you to formalize intuitions about valuation, risk, and decision-making under incomplete information — the same problems the [Cyborg Model](../cyborg-model.md) addresses at the human/AI collaboration level.

## Sub-Topics

- [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) — why multiplayer games resist solution, the self-balancing three-player dynamic, phase decomposition, the Stockfish architecture as template, the interest rate framework, and the relative position model (EPT as slope)
- [Bilateral Trade Valuation](./bilateral-trade-valuation.md) — why trade evaluation requires simulating both players simultaneously; trajectory divergence, the patient predator exploit, and Nash equilibrium pricing
- [BattleValue](./battle-value.md) — BV = sqrt(Attack × HP): a universal combat comparison metric derived from Lanchester's Square Law; BV/Cost as the army composition ROI metric

## Genres and What They Teach

### 4X — Resource Allocation Under Uncertainty

The 4X genre is the purest game-form of entrepreneurial decision-making. You start with incomplete information, make irreversible investments, and compete against agents with different strategies and different information.

**Key games:**

- **Master of Orion** (1993) — The original. Colony management, tech tree, ship design, diplomacy. Clean enough to see the underlying systems. Chris's preferred 4X.
- **Remnants of the Precursors** (RotP) — Java remake of MOO1 by Ray Greer. Modernizes the gameplay while preserving the design philosophy. Unfortunately Java-only, which makes it inaccessible on constrained platforms (iOS).
- **Starbase Orion** — iOS native, closer to MOO2 in complexity. Solid mobile 4X but lacks RotP's modernization of the original MOO1 feel.
- **Civilization series** — Broader scope (cultural, diplomatic, scientific victory conditions), but the economic core is the same: allocate scarce resources across competing priorities under uncertainty. Competitive multiplayer Civilization demonstrates that turn-based play has the same adversarial interest rate dynamics as RTS — the turn structure discretizes time but doesn't change the economics.

**What 4X reveals:**

- The tech tree is a capital investment problem — you're betting on future returns from research you can't fully evaluate yet
- Diplomacy is repeated-game theory — trust, betrayal, credible commitments
- Military strategy is risk management — how much to invest in defense vs. growth
- The entire genre demonstrates why central planning fails at scale: the combinatorial explosion of possible strategies means there's no "optimal" build order, only adaptive judgment

### Simulation — Emergent Systems and Distribution

City builders and simulation games make economic distribution tangible. You set rules and watch emergent behavior unfold — which is exactly what markets do, and exactly what central planners try (and fail) to replicate.

**Key games:**

- **SimCity** (1989–) — The original urban simulation. Zoning, taxation, infrastructure. You learn quickly that top-down planning creates problems faster than it solves them.
- **Cities: Skylines** — SimCity's spiritual successor with much deeper simulation. Traffic modeling alone demonstrates how local decisions (one badly placed intersection) cascade into system-wide failures. The distribution and logistics layer is a playground for economic thinking.

**What simulation reveals:**

- Small rule changes produce wildly disproportionate outcomes (sensitivity to initial conditions — connects to [Computation and Information Theory](../computation-and-information.md))
- You cannot optimize a city for a single metric without destroying it on others — the same argument against Cocteau in [Demolition Man](../demolition-man-analysis.md)
- Emergent traffic patterns are computationally irreducible — you can't predict them without running the simulation, which is exactly the market computation argument
- The best cities aren't "planned" in detail — they're structured with good rules and allowed to evolve

### Strategy and Game AI — Formalizing Judgment

Building game-playing AI forces you to express intuitions as algorithms. This is where the vault's game theory connects to its AI research.

**Active projects:**

- [Slay](../../projects/slay/README.md) / [Slay-C](../../projects/slay-c/README.md) — Hex territory control. Alpha-beta search, heuristic evaluation, the tradeoff between search depth and evaluation quality.
- [Monopoly](../../projects/monopoly/README.md) — Markov chains for positional analysis, EPT valuation, strategic trading. The AI has to model other players' utilities to trade well — which is the economic framework in code.

**The multiplayer challenge:** Both Slay (simplified to 2 players) and Monopoly (3+ player trade dynamics never fully solved) hit the same wall — the coalition problem. See [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) for the full analysis.

**What game AI reveals:**

- Evaluation functions are subjective value made explicit — you have to decide what "good" means before you can search for it
- Search depth vs. evaluation quality is a compute budget problem — same tradeoff as agent team architecture
- Perfect play is computationally intractable for interesting games (see P vs NP discussion) — good play requires heuristic judgment, which is the AI equivalent of entrepreneurial intuition

### The MOO1 Problem — Classic Design on Modern Platforms

Master of Orion 1's UI design — menus, clicks, simple state displays — maps naturally to touch interfaces. The original game would be a near-perfect tablet experience if someone built a native port. Instead:

- **DOSBox on iOS** — Technically works, practically painful. Touch controls mapped to a DOS mouse interface with emulation overhead.
- **Remnants of the Precursors** — Excellent modernization, but Java/JVM means no iOS path. Apple's restrictions on JIT compilation make JVM apps structurally impossible on iOS.
- **Starbase Orion** — Native iOS, closer to MOO2. Good but different design philosophy than MOO1.

This is a microcosm of a larger problem: the best classic game designs are trapped in legacy platforms, and the economics of porting don't justify the effort for niche audiences. The games that best teach systems thinking are often the hardest to access.

## Open Questions

- Could a game be designed specifically as an economics teaching tool — making the price system, comparative advantage, and entrepreneurial judgment the core mechanics rather than just emergent properties?
- What would a 4X game look like with AI agents as advisors ([cyborg model](../cyborg-model.md) applied to gaming)?
- Is there a formal relationship between game AI evaluation functions and utility theory? Both are trying to compress complex state into a scalar value.
- The simulation genre demonstrates computational irreducibility intuitively — could this be formalized into a teaching tool for the concepts in [Computation and Information Theory](../computation-and-information.md)?

## Tags

[games](../../tags/games.md), [game-ai](../../tags/game-ai.md), [economics](../../tags/economics.md), [ai](../../tags/ai.md), [simulation](../../tags/simulation.md)

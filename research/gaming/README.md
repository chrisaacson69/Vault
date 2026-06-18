---
status: active
created: 2026-02-20
published: true
layout: layouts/page.njk
title: "Gaming"
permalink: /research/gaming/
---
# Gaming
> Games as interactive laboratories for systems thinking — strategy, economics, simulation, and AI.

**Links:** [Economics](../economics/README.md), [Computation and Information Theory](../computation-and-information.md), [Monopoly](../../projects/monopoly/README.md), [Slay](../../projects/slay/README.md), [Slay-C](../../projects/slay-c/README.md), [Demolition Man Analysis](../demolition-man-analysis.md)

## Why This Matters

Games aren't a side interest — they're how Chris thinks. The same frameworks that drive the vault's economics and philosophy research show up directly in gameplay:

- **4X games** (Master of Orion, Civilization) are resource allocation under uncertainty — exactly what [Value and Profit](../economics/value-and-profit.md) and [Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md) describe theoretically, and which [MIRR — 4X as Capital Allocation](./mirr-4x-framework.md) makes mechanical. Every turn is an entrepreneurial bet: invest in military or infrastructure? Expand now or consolidate? The 4X loop (explore, expand, exploit, exterminate) is the market cycle compressed into a game state.

- **Simulation games** (SimCity, Cities: Skylines) are distributed systems made visible. You can watch the price system fail — traffic jams are information bottlenecks, zoning is central planning, and the emergent behavior of thousands of simulated agents demonstrates computational irreducibility in real time. These games tweak the economics brain because they let you experiment with distribution concepts you can only theorize about otherwise.

- **Strategy games with AI** ([Slay](../../projects/slay/README.md), [Monopoly](../../projects/monopoly/README.md)) are where game theory becomes code. Building an AI player forces you to formalize intuitions about valuation, risk, and decision-making under incomplete information — the same problems the [Cyborg Model](../cyborg-model.md) addresses at the human/AI collaboration level.

## Sub-Topics

- [The Nash Bargaining Problem](./nash-bargaining-problem.md) — the atomic unit of negotiation: two players, $100, agree or get nothing; Nash's axiomatic solution, Rubinstein's patience model, ultimatum game behavior, and why identical agents can't trade
- [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) — why multiplayer games resist solution, the self-balancing three-player dynamic, phase decomposition, the Stockfish architecture as template, the interest rate framework, and the relative position model (EPT as slope)
- [Bilateral Trade Valuation](./bilateral-trade-valuation.md) — why trade evaluation requires simulating both players simultaneously; trajectory divergence, the patient predator exploit, and Nash equilibrium pricing
- [BattleValue](./battle-value.md) — BV = sqrt(Attack × HP): a universal combat comparison metric derived from Lanchester's Square Law; BV/Cost as the army composition ROI metric
- [MIRR — 4X Strategy as Capital Allocation Under Uncertainty](./mirr-4x-framework.md) — the central 4X thesis: each turn is a capital-allocation decision ranked by MIRR (reinvestment at your empire's own growth rate); the cross-game hub MoO + MoM point up to; option value, time-window "broken" strategies, research-as-portfolio
- [Capability Without Leverage](./capability-without-leverage.md) — a paid capability is worth zero (or negative) unless downstream leverage lets it shift the outcome; the metric correction (impact-share, not face efficiency) across Monopoly (brown trap), MoM (hard counter to zero), Catan (unleveraged port)
- [Randomness as the Termination Mechanism (N≥3)](./n3-termination-and-randomization.md) — the gang-up equilibrium never terminates without randomness; the design-side corollary of the coalition problem; calibration is the design quality; NA1 canonical specimen, Diplomacy the contrast case
- [The Dominance-Frontier Lens](../dominance-frontier-lens.md) — *(cross-domain)* map cost vs effect, draw dominance edges + the frontier curve, flag asymmetric counters; random-start viability as the design verdict; the methodology the counter-graph / frontier / BV / MIRR pages all share
- [NA1 — A Game-Design Crucible](./nobunaga-crucible.md) — the Nobunaga RE project as a ground-truth source of game-design theses; index to the repo + the theses it sparked (n3-termination + candidates)
- [Diplomacy: 7 AI Models](./diplomacy-ai-analysis.md) — analysis of 7 LLMs playing Diplomacy; case study for the coalition problem, Nash bargaining, physical grounding of strategy, and why different agents CAN trade
- [LLM Agents Across Strategic Games](./llm-agents-across-games.md) — seven-game cross-study (Monopoly, Diplomacy, Among Us, Mafia ×2, Coup, Catan) + clones control; architectural signatures stable across games; verification as a spectrum with hidden pockets concentrating decisive value; Catan isolates three LLM-general failures (action bias, no mechanical model, rhetorical contagion) and points to external-state engine architecture as the fix
- [LLM Game Benchmark — Outline](./llm-game-benchmark.md) — framework for evaluating new LLMs against the seven-game study; measurement axes, infrastructure, scoring method
- [Catan — 47,000 Games of Empirical Findings](./catan-47k-empirical.md) — Ioana Roman's quantitative analysis of 47k recorded games: balanced turn order, opening predicts win rate barely above random (27% vs 25%), Longest Road / Largest Army are symptoms not causes, winners favor the city engine over the road engine, Monopoly cards as systemic liquidity extraction, and the trade-efficiency paradox (winners overpay for position) confirming bilateral trade valuation across N=47k
- [Catan 50-Game Validation](./catan-50-games-validation.md) — empirical proof-of-method on the public 50-game Kaggle dataset; aggregate city-engine bias replicated (Δ=+0.016 winners vs losers), board-conditional refinement partially supported, theory updated to "universal city-engine bias + layered archetype effect"; methodological finding — Roman's "balanced turn order" requires snake-order placement specifically
- [Gunboat Diplomacy and Diplodocus](./gunboat-diplomacy-diplodocus.md) — Meta's Gunboat-only AI won a tournament against expert humans with no language model; moves as costly signals; the Denmark disband; the sharpest available confirmation of the planner-LM composite thesis
- [CaptainMeme vs. 6 Cicero (Press Diplomacy)](./cicero-press-diplomacy-captain-meme.md) — expert human ties Cicero for board top; the human/AI split observations (no grudge, forward-looking pure, intent-appeals fail); the N≥3 self-balancing advantage of forward-looking-pure agents
- [D&D Spell Damage Model](./dnd-spell-damage-model.md) — using CLT, proof by induction, and bimodal distributions to build a spell comparison metric; same instinct as BattleValue, different game
- [Battleship — 30 Billion Boards](./battleship-board-analysis.md) — *(specimen)* a closed-form proof that **structure creates norms** ([symmetry-breaking](../philosophy/dynamics/symmetry-breaking.md) with the substrate fully enumerated): uniform randomness on the asymmetric grid → forced optimal play; the minimax placement result is the sharpest *conditional ≠ arbitrary* case; NA1 is the epistemic twin; game-theory mechanism = deep best-response half vs flat minimax half

### Monopoly Theory — [monopoly/](./monopoly/)
- [Subgraph Investment Optimization](./monopoly/subgraph-investment-optimization.md) — build-vs-trade decision via Pareto dominance, graph matching, dynamic programming on reachable states
- [Frontier Trade Theory](./monopoly/frontier-trade-theory.md) — EPT frontier curves, brown trap, denial value, knockout probability, game horizon, race condition
- [Subgraph Trade Engine Spec](./monopoly/subgraph-trade-engine-spec.md) — complete AI architecture: subgraph analysis, trade search, pruning, 3-way cycles

### MOO1 Theory — [moo1/](./moo1/)
- [MOO1 Optimal Strategy](./moo1/optimal-strategy.md) — race tiers, opening theory, tech priorities, ship design via BV, diplomacy, endgame paths
- [MOO1 MIRR Analysis](./moo1/mirr-analysis.md) — MIRR-based investment decision: factory vs colonizer; financial metric for opening theory

### Master of Magic — [master-of-magic/](./master-of-magic/)
- [Economic Analysis](./master-of-magic/README.md) — BV + MIRR applied to all units, buildings, and spells; "balance through imbalance" tested quantitatively
- [Tier System and MIRR](./master-of-magic/tier-system-and-mirr.md) — time-gated tiers as investment; Wraith rush, Halfling Slinger stacking, building option value

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
- [MOO1 Opening Optimizer](../../projects/moo1-opening-optimizer/README.md) — Economic sim for the colony ship timing problem. Simulates the first 50–100 turns to derive optimal expansion timing across race, planet quality, and distance.

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

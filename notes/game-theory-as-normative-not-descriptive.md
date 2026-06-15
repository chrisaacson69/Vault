---
status: active
created: 2026-05-18
published: true
layout: layouts/page.njk
title: "Game Theory as Normative, Not Descriptive"
---
# Game Theory as Normative, Not Descriptive
> Game theory is a normative theory of optimal play given a stated game structure. It is not, and was not designed to be, a descriptive theory of actual human strategic behavior. The famous solution concepts (Nash bargaining, Rubinstein, iterated-PD cooperation, etc.) require importing assumptions — BATNA stability, discount factor, unknown end, axiomatic restrictions — that aren't derived from the strategic situation. Those imports are behavioral, institutional, or psychological facts the model imports to make the math close. Where the imports don't hold, the predictions don't hold. Where the predictions don't match observation (one-shot cooperation, real bargaining, the Axelrod TFT result), the imports are doing the work — and what actually drives behavior is **norms guiding action**, not utility maximization. The implication for the vault's [trade-theory work](../research/gaming/bilateral-trade-valuation.md) is that the transfer problem is hard not because we lack a clever algorithm, but because the bargaining situation has no game-theoretic answer without psychology-level imports.

**Links:** [Nash Bargaining Problem](../research/gaming/nash-bargaining-problem.md), [Multiplayer Coalition Problem](../research/gaming/multiplayer-coalition-problem.md), [Bilateral Trade Valuation](../research/gaming/bilateral-trade-valuation.md), [Frontier Trade Theory](../research/gaming/monopoly/frontier-trade-theory.md), [LLMs as Praxeological Actors](../research/economics/llm-praxeology.md), [Planner-LM Composites](../research/planner-lm-composites.md), [Hayek vs Mises: The Calculation Problem](./hayek-vs-mises-calculation.md), [Catan 47k Empirical](../research/gaming/catan-47k-empirical.md), [Coconut Island & Manufactured Option Space](../research/debates/coconut-island-and-manufactured-option-space.md) (a debate-sparked thesis that applies this note's "norms guide action" point to manufactured-scarcity rhetoric)

---

## The core claim

Game theory produces clean solutions only when the strategic structure is augmented with imports the strategic structure doesn't itself provide:

| Famous result | Strategic structure | Import doing the work |
|---|---|---|
| Nash bargaining solution | Two players, $100, agree on a split or get nothing | Cooperative axioms (symmetry, IIA) |
| Rubinstein bargaining | Alternating offers, two players | Discount factor δ < 1 imported from outside |
| Iterated PD cooperation | Iterated game | "Unknown end" — finite-end games backward-induct to defection |
| Folk Theorem | Infinitely repeated game | "Any individually-rational payoff is sustainable" — produces a continuum, doesn't select |
| Schelling focal points | Multiple equilibria | *Explicitly* psychological — round numbers, salience, convention |

The imports are sometimes presented as parts of the model (especially the discount factor), but they originate outside the strategic situation:
- **BATNA / disagreement point** comes from outside the negotiation
- **Discount factor** comes from psychology, opportunity cost, time-value-of-money
- **Unknown end** comes from the institutional setup of the repeated game
- **Axioms** are normative impositions, not derivations from strategic rationality

Strip them, and the bare game has either no unique solution (continuum of equilibria) or a different solution than the famous result.

## The bargaining indeterminacy

The cleanest demonstration. Two players, $100, propose splits.

- Under **one-shot simultaneous demands**: every (x, 100−x) with x ∈ (0, 100) is a Nash equilibrium. Infinite continuum.
- Under **Rubinstein alternating offers with δ < 1**: unique subgame-perfect equilibrium at (1−δ₂)/(1−δ₁δ₂). But δ comes from outside.
- Under **Nash cooperative axioms**: unique solution maximizing utility-gain product. But the axioms (especially symmetry and IIA) are normative.
- Under **no imposed structure, no discount**: no convergence; both players hold out forever at maximum demand; both get $0.

**The symmetry argument** ([[bilateral-trade-valuation]] §"asymmetric-externality reading"): if Player 1 and Player 2 are *internally* symmetric (same time-preference, same alternatives, same information, same utility-over-money), the game itself contains no information distinguishing them. Therefore the bare game cannot produce an outcome distinguishing them. Any asymmetric outcome requires importing asymmetric external factors.

The axis-points (100, 0) and (0, 100) are correctly excluded — those aren't bargaining outcomes, they're walk-away states equivalent to (0, 0). The interior is the bargaining space, and the bare game says nothing about which interior point gets played.

## The Mr. Beast example — BATNA is not exogenous

A perfect illustration that the "outside" of a game is itself manipulable:

Mr. Beast invents games like *"whoever keeps their hand on X the longest keeps X."* Player 2's BATNA is "leave when tired" — a utility threshold at exhaustion. Standard bargaining theory treats this as a fixed parameter of the situation.

Now Mr. Beast adds: *"last one to leave gets $10k."*

He hasn't changed the rules of the hand-on-X game. He's **rewritten Player 2's BATNA from outside.** The strategic situation flipped because the *outside* changed.

This is the canonical demonstration that the boundary of "the game" is arbitrary. If the outside is itself contestable — and in real strategic situations it almost always is, via information manipulation, manufactured time pressure, framing, third-party offers — then **the bargaining-theory practice of importing BATNA as a fixed parameter is foundationally wrong**. Real negotiators *manipulate the counterparty's BATNA*; that manipulation IS the strategic move. Standard bargaining theory cuts the boundary of "the game" too narrow and assumes a stable outside; the stable outside is itself manipulable.

There's a small literature trying to fix this — Aumann's correlated equilibria, mechanism design with strategic rule-setters — but mainstream bargaining theory still treats BATNA as exogenous data.

## The iterated-PD unraveling

Backward induction in a known-finite-end iterated Prisoner's Dilemma:

- At round N: defection dominates (no future to punish).
- Therefore at round N: both defect.
- At round N−1: knowing both will defect at N, no future cost to defecting now. Defect.
- Continue backward: defect at all rounds, back to round 1.

So the **theoretical prediction in any fixed-end iterated PD is universal defection.**

**Empirically, this doesn't happen.** Axelrod's tournaments (1980, 1981) used a fixed-length 200-round iterated PD. Strategies were submitted by game theorists, economists, etc. **Tit-for-tat won both tournaments** by a clear margin. TFT cooperates on round 1, then copies opponent's last move. It's *nice* (never defects first), *retaliatory* (punishes immediately), *forgiving* (returns to cooperation after one round), *clear* (easy to recognize). Always-defect strategies did poorly because they got punished by TFT-like opponents and lost the cooperation surplus.

**This is a clean empirical refutation of the backward-induction prediction.** In a strict game-theoretic setting (known-finite PD), the predicted equilibrium (universal defection) lost to a strategy theory said shouldn't win. The tournament was the test; theory failed it.

More recent: Press-Dyson 2012 introduced **zero-determinant strategies** — provably-extracting strategies that can force any linear combination of payoffs from an *adapting* opponent. ZD strategies are the "AlphaGo of iterated PD." But against other ZD strategies, they break down. The race-to-the-top of strategic sophistication doesn't converge on always-defect; it converges on cleverer cooperation/exploitation balances. **Sophistication doesn't validate the backward-induction prediction; it complicates it further.**

## The cooperation puzzle in one-shot games

Even in **one-shot** Prisoner's Dilemma — no iteration, no future — humans cooperate at 30-50% rates in lab experiments. Theory predicts 0%.

**Why?** Behavioral game theory (Camerer, Fehr, Falk, Bowles) proposes:

1. **Social preferences** — players have utility functions over fairness and others' outcomes, not just monetary payoff
2. **Bounded rationality** — players don't perform full backward induction; they apply heuristics like "be nice unless punished"
3. **Type uncertainty** — even one-shot games have uncertainty about whether the opponent is a cooperator; cooperation can be rational under that uncertainty
4. **Evolutionary residue** — cooperation in iterated ancestral games was selected for; humans bring those instincts to one-shot games even though it's formally "wrong"

These are **patches, not foundational fixes.** They treat the theory's failure as a parameter problem ("the utility function was wrong; add more terms") rather than a structural problem ("the model isn't modeling the right thing"). The patches make the model fit observed cooperation rates by tuning extra parameters — but the resulting model is no longer parsimoniously game-theoretic; it's a behavioral-economics model that uses game-theoretic notation.

The sharper read: **what actually drives cooperation is internalized norms, reputation across unrelated games, convention, focal points** — and these are *not properties of individual utility functions*. They're structural features of human social organization that game theory keeps trying to import as inputs rather than describing as the actual mechanism.

## Norms guide behavior, not self-interest

The cleanest framing of the empirical pattern: **in real strategic interaction, norms guide behavior more than self-interest does.**

- One-shot PD cooperation: norm of cooperation (fairness, reciprocity) over self-interest of defection
- Trust in commerce: norm of honesty over short-term exploitation gains
- Ultimatum game rejection of small offers: norm of fairness over self-interest in accepting any positive sum
- Real bargaining: round-number conventions, fairness anchors, "what's normal in this market"
- Monopoly trading: "trade vocabulary" (clean swaps, round-number sweeteners) is focal-point convention selecting among the equilibrium continuum

Game theory keeps importing these structural facts as parameters. The deeper reading is that **what game theory imports as 'preferences' or 'discount factors' are actually norms and conventions** — structural features of the social context that exist *prior to* and *independent of* the individual utility calculations the theory tries to perform on top of them.

This is the [praxeological](../research/economics/llm-praxeology.md) point applied to strategic interaction. Mises argued that human action follows from value frameworks, not from utility maximization. Game theory's empirical failures are exactly where it tries to derive action from optimization rather than describing how value frameworks (norms, conventions, institutions) actually structure behavior.

## What this means for the Monopoly / Catan trade-theory work

The vault's [transfer-problem checklist](../research/gaming/bilateral-trade-valuation.md) has six rows. Rows 4-6 (counterparty modeling, 3+-player asymmetric bargaining, multi-step trade chains) are the open ones. **They're open in the vault because they're open in the field, and they're open in the field because game theory doesn't actually solve continuous-bargaining-with-private-values.**

What real Monopoly play does — and what AI play needs to do to be strong — is **operate at the convention layer, not the utility-optimization layer.** Strong human players use:

- Round-number trade ratios (focal points)
- "Straight up" templates (clean swaps with no cash adjustment)
- Reputation across past games ("she's a fair trader" / "he price-gouges")
- Fairness anchors ("I gave you a good trade last time")
- Social pressure ("everyone else thinks this is fair")

These aren't game-theoretic moves; they're convention-mediated coordination on which equilibrium gets played. A Monopoly AI that tries to solve the bargaining problem via pure utility maximization will be empirically beaten by an AI that learns to operate at the convention layer — exactly because actual gameplay terminates at conventions, not at game-theoretic equilibria.

**Engineering implication:** the Monopoly AI's trade evaluator currently uses bilateral NPV-trajectory math (game-theoretic). The improvement isn't a smarter optimizer; it's adding a **convention layer** that proposes/accepts focal-point trades over optimizing trades, and that includes reputation across simulated games. The behavioral parameters Camerer would add to the utility function should instead be modeled as a separate convention component — that's the structural fix, not the parametric patch.

This is the [planner-LM composite](../research/planner-lm-composites.md) thesis applied to bargaining: pure planning (game-theoretic optimization) doesn't solve the problem; you need a separate layer for the convention/communication channel where actual coordination happens. **Cicero needed an LM because Diplomacy is a bargaining game and bargaining is a convention game, not a utility-maximization game.** The vault has been saying this in pieces; this is the unified statement.

## What game theory IS good for

The point isn't that game theory is useless — it's that it's misframed when used as descriptive theory. Game theory is **excellent** as:

- **Normative analysis** — "given that you've decided to participate in this strategic situation, what should you do under standard rationality assumptions?"
- **Existence and computation results** — Nash's existence proof, minimax theorems, mechanism-design impossibility theorems
- **Structural insight** — Pareto frontiers (the discrete-game-MPT work in [[Frontier Trade Theory]]); information-revelation tradeoffs; commitment problems
- **Benchmarking** — comparing actual behavior to game-theoretic predictions reveals exactly which norms/conventions are doing the load-bearing work

The vault's [bilateral trade valuation](../research/gaming/bilateral-trade-valuation.md), [frontier trade theory](../research/gaming/monopoly/frontier-trade-theory.md), and Pareto-filter constructions are normative game theory used well. They're tools for "given a stated objective and stated rules, here's the optimal path." They don't pretend to predict what actual humans will do; they prescribe what a rational player should do.

The mistake worth avoiding: **don't use these tools to predict behavior.** Use them to plan moves, to filter the decision space, and to identify where the convention layer kicks in. The convention layer is where actual gameplay happens, and it doesn't belong inside the game-theory toolkit — it belongs in the planner-LM composite as a separate component.

## Closing generalization — free markets create, bargaining distributes

The clearest framing of where bargaining theory sits in economics, recorded 2026-05-18 from the trade-theory discussion:

> **Free markets are good because they incentivize profit creation. But they don't explain how the profit gets divided. That's all bargaining.**

Most market-economics scholarship — Smith, Ricardo, the Austrians (Mises, Hayek, Rothbard), neoclassical equilibrium theory — addresses **why** trade creates value: comparative advantage, marginal utility, gains-from-trade, division of labor. That side of economics is well-developed. The vault's [Value and Profit](../research/economics/value-and-profit.md), [Risk and Entrepreneurship](../research/economics/risk-and-entrepreneurship.md), and the broader [economics thread](../research/economics/README.md) all live on the value-creation side.

The **distribution side** — how the gains-from-trade actually split between the trading parties — is much less developed. Standard treatments either:

1. **Assume the problem away** via perfect competition: prices clear at marginal cost, no surplus to bargain over. Convenient for theory; descriptively wrong for most real markets.
2. **Punt to "market forces"** — a polite phrase for "we don't model how the actual price got there."
3. **Use Nash cooperative bargaining axioms** — which we've now established import assumptions the strategic structure doesn't supply.
4. **Use Rubinstein non-cooperative bargaining** — which needs the discount-factor import from outside the strategic structure.
5. **Behavioral economics patches** — utility-function modifications that fit observed cooperation rates by tuning extra parameters, structurally identical to the GT patches called out earlier on this page.

**The honest position:** mainstream economic theory has a strong value-creation account and a weak value-distribution account. The distribution side IS the bargaining problem, and the bargaining problem is genuinely open. This isn't a peripheral concern; it's the open layer of microeconomics.

### Direct political consequences

Disputes about value distribution are ubiquitous and politically charged:

- **Wage rates** — how much of firm surplus goes to labor vs. capital
- **M&A premiums** — how much of the synergy surplus the target captures
- **Consumer surplus** vs. **producer surplus** distribution in any given transaction
- **Contract terms** — payment schedules, risk allocation, IP rights
- **Tax incidence** — who actually bears the cost when "the corporation" is taxed
- **Tariff incidence** — same question, international
- **Inheritance disputes** — distributing surplus across generations
- **Union negotiations** — explicit collective bargaining

These all reduce to "the value exists, who gets how much of it?" — i.e., bargaining. The political debates *appear* to be about whether markets work (they do, at value-creation); the actual disagreement is about distribution outcomes that bargaining theory doesn't pin down. **Treating "the market figured out the right division" as a value-creation argument is a category error — markets do creation, bargaining does distribution.**

### What this means for the vault thread

The vault has been doing the value-creation half cleanly (Austrian economics, comparative advantage, the trade-creates-mutual-benefit framework). The trade-theory work in [bilateral-trade-valuation](../research/gaming/bilateral-trade-valuation.md), [frontier trade theory](../research/gaming/monopoly/frontier-trade-theory.md), and the [Catan empirical analysis](../research/gaming/catan-47k-empirical.md) is the vault's actual engagement with the distribution-side problem — at game-board scale, but the structure is the same as wage negotiation, M&A pricing, or any commercial trade.

**The Monopoly/Catan trade-theory work isn't just game analysis.** It's the bargaining-problem half of economics applied to a constrained domain where the rules are exact and the outcomes are observable. The insights — counterparty modeling, asymmetric externalities, focal-point conventions doing equilibrium selection, planner-LM composites where the LM is the convention layer — all transfer to real-economy bargaining problems where the same structure operates with messier data.

**The "bargaining problem is the best unsolved research in game theory" framing is the right one.** Breakthroughs here improve more than game-AI; they improve the theoretical engagement with how markets actually distribute the surplus they create.

## Tags

[game-theory](../tags/game-theory.md), [economics](../tags/economics.md), [epistemology](../tags/epistemology.md), [meta-musing](../tags/meta-musing.md)

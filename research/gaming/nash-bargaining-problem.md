# The Nash Bargaining Problem
> Two people, $100, and a simple rule: agree or get nothing. The simplest game that reveals the structure of negotiation.

**Status:** active
**Created:** 2026-02-27
**Links:** [Gaming](./README.md), [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md), [Value and Profit](../economics/value-and-profit.md), [Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md), [Economics](../economics/README.md), [Monopoly](../../projects/monopoly/README.md)

## The Setup

Two people are given $100. If they can agree on how to divide it, each gets their agreed share. If they can't agree, both walk away with nothing.

That's the entire game. No turns, no cards, no dice. Just negotiation.

And yet this simple structure — Nash's bargaining problem (1950) — generates most of the deep questions about how rational agents divide surplus. It's the atomic unit of negotiation: everything in the [Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) and [Monopoly](../../projects/monopoly/README.md) trade dynamics is built from repeated instances of this game.

## Why It's Hard

At first glance, it seems trivially obvious: split 50/50. Both players know that $50 > $0, so why would either refuse?

But "obvious" is doing a lot of work. What if:

- **One player is richer than the other?** $50 means survival to one and pocket change to the other. Does that change the "fair" split?
- **One player is more patient?** If the negotiation takes time, the player who can afford to wait has leverage.
- **One player has a better outside option?** If I can walk away and earn $40 somewhere else, my effective disagreement point isn't $0 — it's $40. Now we're really only negotiating over $60.
- **One player is more risk-tolerant?** A player willing to gamble on breakdown can credibly demand more.

The 50/50 split is a special case — what Nash proved is that it's the *unique rational solution* under specific axioms, and understanding those axioms tells you exactly when and why it breaks.

## Nash's Axiomatic Solution (1950)

Nash didn't try to model *how* people negotiate (offers, counteroffers, bluffs). Instead, he asked: what properties should a "rational" solution have? He proposed four axioms, and proved that only one solution satisfies all four.

### The Four Axioms

**1. Pareto Efficiency.** No money left on the table. The solution must allocate the full $100 — any split where some money goes unclaimed is wasteful and both players could do better.

**2. Symmetry.** If the two players are identical in every relevant way (same utility functions, same outside options), the split must be equal. The solution shouldn't depend on arbitrary labels like "Player 1" or "Player 2."

**3. Invariance to Affine Transformations of Utility.** The solution doesn't change if you rescale someone's utility function. If I measure my happiness in dollars and you measure yours in euros, the underlying split shouldn't shift. This means the solution depends on the *shape* of preferences, not the units.

**4. Independence of Irrelevant Alternatives (IIA).** If we remove options from the feasible set that weren't going to be chosen anyway, the solution doesn't change. The agreed split shouldn't depend on deals that neither player would accept.

### The Nash Bargaining Solution

Under these four axioms, the unique solution maximizes the **Nash product**:

> Maximize (u₁ - d₁) × (u₂ - d₂)

Where:
- u₁, u₂ = the players' utilities from the agreed split
- d₁, d₂ = the players' utilities from the **disagreement point** (what each gets if negotiation fails)

For the symmetric $100 game with linear utility and d₁ = d₂ = 0, this gives exactly **$50 / $50**.

But the formula reveals what drives asymmetric outcomes. If player 1's disagreement point is $40 (they have an outside option), the Nash solution splits the *remaining surplus* ($60) equally — giving player 1 $70 and player 2 $30. The outside option doesn't just provide a floor; it shifts the entire negotiation in your favor.

## What Breaks When You Relax the Axioms

Each axiom, when dropped, points to a different theory of bargaining:

| Axiom Dropped | What Changes | Alternative Solution |
|---|---|---|
| Symmetry | Players with different "bargaining power" get different shares even with identical preferences | Asymmetric Nash solution (weighted product) |
| IIA | The shape of the full feasible set matters, not just the optimal point | Kalai-Smorodinsky solution (proportional to maximum possible gains) |
| Invariance | Cardinal utility comparisons become meaningful | Egalitarian solution (equalize utility gains) |
| Pareto efficiency | (Rarely dropped — hard to justify leaving money on the table) | |

The most practically relevant relaxation is **dropping symmetry** — introducing asymmetric bargaining power. The generalized Nash solution becomes:

> Maximize (u₁ - d₁)^α × (u₂ - d₂)^(1-α)

Where α represents player 1's bargaining power (0 < α < 1). At α = 0.5, it's the standard symmetric solution. As α → 1, player 1 captures nearly all the surplus.

**What determines α?** Nash's axioms don't say. That's where the non-cooperative models come in.

## The Ultimatum Game — Nash Bargaining With Structure

The Nash bargaining problem is *cooperative* — it says what rational agents *should* agree to, not *how* they get there. The **ultimatum game** adds structure:

1. Player 1 proposes a split (e.g., "$70 for me, $30 for you")
2. Player 2 either **accepts** (both get the proposed amounts) or **rejects** (both get nothing)

**Game-theoretic prediction:** Player 1 offers the minimum possible amount (say $1), and Player 2 accepts — because $1 > $0. Player 1 captures nearly the entire surplus. First-mover advantage is total.

**What actually happens:** In experiments, proposers typically offer 40-50%, and offers below 20% are rejected about half the time. People destroy real money to punish "unfair" splits.

This gap between theory and behavior is one of the most studied phenomena in behavioral economics. The explanations matter for AI agent design:

- **Fairness preferences.** People have utility for fairness itself, not just money. Rejecting $10 out of $100 costs $10 in cash but purchases self-respect and punishes the proposer. If you model the true utility function (including fairness), the behavior *is* rational.
- **Reputation effects.** In repeated interactions, rejecting unfair offers builds a reputation for toughness, which improves future bargaining outcomes. Even in one-shot games, people may apply heuristics trained on repeated interactions.
- **Spite as commitment device.** A credible willingness to destroy surplus gives you bargaining power. If I *will* reject anything below $40, and you believe me, the rational offer is $40. Irrationality (or the appearance of it) becomes a strategic asset.

## Rubinstein's Alternating Offers — Where Patience Is Power

Rubinstein (1982) modeled what happens when negotiation takes time:

1. Player 1 proposes a split
2. Player 2 accepts or rejects
3. If rejected, Player 2 counter-proposes (but the pie shrinks slightly — delay is costly)
4. Player 1 accepts or rejects
5. Repeat until agreement

The key parameter is the **discount factor** (δ) — how much each player values money now versus money later. A patient player (δ close to 1) barely cares about delay. An impatient player (δ close to 0) wants a deal *now*.

**Rubinstein's result:** The unique subgame-perfect equilibrium gives the more patient player a larger share. Specifically, with discount factors δ₁ and δ₂:

- Player 1 gets: (1 - δ₂) / (1 - δ₁δ₂)
- Player 2 gets: δ₂(1 - δ₁) / (1 - δ₁δ₂)

As both players become perfectly patient (δ → 1), the split converges to 50/50 — the Nash solution. **Patience literally *is* bargaining power in the Rubinstein model.** This is the non-cooperative foundation for the cooperative Nash result.

**Connection to time preference:** This links directly to [Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md). Time preference — how much you discount the future relative to the present — determines your effective bargaining power. A startup burning cash (high time preference, low δ) negotiates worse than a profitable company with runway (low time preference, high δ). The interest rate framework from the [Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) surfaces here too: the "interest rate" of the negotiation is the rate at which the pie shrinks, and each player's position relative to that rate determines their leverage.

## Connection to Monopoly Trade

Every trade in [Monopoly](../../projects/monopoly/README.md) is a Nash bargaining problem:

- **The surplus** is the combined EPT gain from the trade (both players completing monopolies, upgrading development potential, etc.)
- **The disagreement point** is the status quo — both players keep their current properties, no trade happens
- **The split** is determined by the cash sweetener and which properties change hands

The [Multiplayer Coalition Problem](./multiplayer-coalition-problem.md) documented why Monopoly trade evaluation failed: identical AIs reached identical valuations, producing no trade surplus. **The Nash framework explains why directly.** If both players have the same utility function and the same information, they assign the same value to every property. The "surplus" from trade approaches zero because there's no genuine disagreement about value. Nash's solution requires a surplus to divide — identical agents produce none.

**What Monopoly AI needs, restated in Nash terms:**

- **Genuine utility differences.** Different AI players need different valuations — different risk tolerances, different time preferences (δ), different positional assessments. This creates the asymmetric utility that generates trade surplus. The [Value and Profit](../economics/value-and-profit.md) framework says this explicitly: trade requires differing utilities.
- **Outside options that matter.** A player's disagreement point isn't just "no trade" — it's "no trade *with you*, but possible trade with player 3." In multiplayer, outside options are endogenous — they depend on what other players are willing to offer. This is the coalition problem expressed as endogenous disagreement points.
- **Patience asymmetry.** A player about to land on Boardwalk with a hotel has high time preference — they need a deal *now*. A player with a safe board position can wait. Rubinstein's model says the safe player should get a better deal. The Monopoly AI didn't model this.

## Connection to the Coalition Problem

The Nash bargaining problem is two-player by construction. The moment you add a third player, the framework needs extension — and this is exactly where the [coalition problem](./multiplayer-coalition-problem.md) lives.

**In two-player bargaining:** The disagreement point is fixed (both get nothing, or both keep status quo). The only question is how to split the surplus.

**In three-player bargaining:** The disagreement point is *endogenous*. If players 1 and 2 can't agree, player 1 can negotiate with player 3 instead. Player 2's leverage depends on what player 1's alternative deal looks like — and player 3's willingness to deal depends on what player 2 might counter-offer. Every bilateral negotiation happens in the shadow of every other possible bilateral negotiation.

This is why the [atomic trade evaluation problem](./multiplayer-coalition-problem.md#the-atomic-trade-evaluation-problem) is so hard. You can't evaluate a Monopoly trade bilaterally because the disagreement point isn't bilateral — it's determined by the full graph of possible trades across all players. The Nash bargaining solution assumes an exogenous disagreement point. In multiplayer games, the disagreement point is itself a game.

## Implications for AI Agent Negotiation

The Nash framework has direct implications for how AI agents should negotiate — whether in games or in real-world agent teams (see [Value and Profit](../economics/value-and-profit.md)):

1. **Know your BATNA.** Best Alternative To Negotiated Agreement = your disagreement point. An agent that doesn't compute its outside options will systematically accept bad deals.
2. **Model the other player's BATNA.** The Nash solution depends on *both* disagreement points. If you know the other agent is desperate (low outside option), you can extract more surplus.
3. **Patience is leverage.** In any time-pressured negotiation, the agent with more runway wins. This is a design consideration for agent teams — don't give negotiating agents hard deadlines visible to counterparties.
4. **Identical agents can't trade.** This is the Monopoly lesson generalized. If two agents have the same utility function, same information, and same outside options, the Nash surplus is zero. Productive negotiation requires genuine difference.

## Open Questions

- Can the Monopoly AI's trade stagnation be fixed by giving each AI a different δ (discount factor / time preference)? The Nash framework predicts this alone should generate trade surplus.
- In multiplayer Monopoly, can each player's BATNA be approximated by computing the Nash bargaining solution for every *alternative* bilateral pair? This would give each player an estimated outside option without solving the full coalition game.
- Does the empirical rejection behavior in ultimatum games (rejecting "unfair" offers) appear in AI agents? If Claude is asked to play the ultimatum game, does it reject low offers? What does that tell us about LLM utility functions?
- The Rubinstein model assumes common knowledge of discount factors. What happens when patience is private information? This connects to the hidden information problem in Monopoly (you don't know how badly another player needs a deal).
- Can the Nash bargaining framework be integrated into the EPT/relative position model? The surplus from a trade is the combined EPT gain; the split should follow the Nash product weighted by each player's relative position and outside options.

## Suggested Reading

| Work | Author | Relevance |
|---|---|---|
| *The Bargaining Problem* (1950) | John Nash | The original formulation and axiomatic solution |
| *Non-Cooperative Games* (1950) | John Nash | Nash equilibrium — the non-cooperative companion |
| *Perfect Equilibrium in a Bargaining Model* (1982) | Ariel Rubinstein | Alternating offers model; patience as bargaining power |
| *Game Theory and Economic Modelling* (1990) | David Kreps | Accessible treatment of bargaining theory and its limits |
| *Bargaining and Markets* (1990) | Osborne & Rubinstein | Comprehensive treatment linking bargaining to market theory |
| *Ultimatum Game* experiments (1982–) | Güth, Schmittberger, Schwarze | The behavioral evidence that humans aren't Nash-rational |

## Tags

[games](../../tags/games.md), [game-ai](../../tags/game-ai.md), [economics](../../tags/economics.md), [mathematics](../../tags/mathematics.md)

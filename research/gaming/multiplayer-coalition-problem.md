# The Multiplayer Coalition Problem
> Why multiplayer games resist solution, and what the self-balancing dynamics tell us about tractable approximations.

**Status:** active
**Created:** 2026-02-20
**Links:** [Gaming](./README.md), [Monopoly](../../projects/monopoly/README.md), [Slay](../../projects/slay/README.md), [Slay-C](../../projects/slay-c/README.md), [Computation and Information Theory](../computation-and-information.md), [Economics](../economics/README.md), [Risk and Entrepreneurship](../economics/risk-and-entrepreneurship.md), [Cyborg Model](../cyborg-model.md), [Civilizational Cycles](../philosophy/civilizational-cycles.md), [Opposing Forces](../philosophy/opposing-forces.md)

## The Problem

Two-player zero-sum games have clean solutions. Von Neumann's minimax theorem guarantees an optimal strategy exists, and alpha-beta search can approximate it efficiently. Chess, Go, two-player Slay — these are hard in practice (the game trees are enormous) but tractable in principle. Stockfish and AlphaGo prove that strong approximations are achievable.

The moment you add a third player, the structure breaks. Minimax no longer applies. The solution concept shifts to Nash equilibrium, and computing Nash equilibria in general-sum multiplayer games is PPAD-complete — believed to be computationally intractable, though not NP-hard in the classical sense. More importantly, Nash equilibria in multiplayer games are often non-unique, meaning there isn't a single "optimal" strategy — there are many equilibria, and which one emerges depends on coordination and convention, not just computation.

This isn't a limitation of current algorithms. It's structural. The coalition problem is the reason, and it appears in every multiplayer game Chris has worked on.

## The Coalition Problem Across Three Games

### Slay (6-Player)

Slay is essentially Risk with cleaner mechanics — hex territory control, income based on territory size, unit maintenance costs. The two-player version is tractable: alpha-beta search with heuristic evaluation produces competitive play. But six-player Slay reintroduces the full coalition problem:

- **Who do you attack?** Attacking any neighbor weakens both you and the defender relative to everyone else.
- **Temporary alliances emerge.** Two players sharing a border might implicitly cooperate (not attacking each other) to focus on a third. But the alliance is unstable — the moment the third player falls, the allies become competitors.
- **Kingmaker situations.** A weak player's decision about who to attack can determine which of two stronger players wins, even though the weak player has no chance of winning themselves.

The two-player simplification in the current [Slay](../../projects/slay/README.md) project was a deliberate choice to make the AI tractable. Restoring six players is an open problem.

### Risk

Risk adds explicit growth mechanics that change the coalition dynamics:

- **Asymmetric growth rates.** Not all players expand at the same speed. Continental bonuses, card timing, and position create persistent asymmetries.
- **The card escalation curve.** You must capture at least one territory per turn to draw a card. Card sets escalate in trade-in value. This is the game's built-in interest rate — and it's non-linear. Passivity is a death sentence because the penalty for falling behind compounds faster as the game progresses.
- **The penalty for combat.** Every attack weakens both attacker and defender relative to non-participants. The optimal move in isolation is always "let someone else fight" — but the card mechanic forces engagement.

The combat math is solved. Given N attackers and M defenders, the probability distribution of outcomes is computable. This is just dice math — a solved problem.

The multiplayer dynamics are not solved. Who to attack, when to attack, when to hold, when to break an alliance — this is the coalition problem in its purest form.

**The three-player stable state.** In a three-player Risk game (or when a larger game reduces to three players), a natural self-balancing dynamic emerges: the two weaker players gang up on the leader. When the leader is sufficiently weakened and one of the former underdogs takes the lead, alliances swap. This cycle repeats, creating a stable oscillation around rough equilibrium.

This is an emergent phenomenon — nobody designs it, it arises from rational self-interest. Each weaker player independently arrives at the same conclusion: the leader is the biggest threat to my survival, so I should pressure the leader. No coordination required.

**Connection to civilizational cycles.** This is precisely the asabiyyah dynamic from [Civilizational Cycles](../philosophy/civilizational-cycles.md) and the structural principle from [Opposing Forces](../philosophy/opposing-forces.md). Concentrations of power generate counter-forces proportional to the concentration. Peripheral groups unite against the dominant power, one of them eventually becomes dominant, and the cycle repeats. Same mechanism, different substrate.

### Monopoly

[Monopoly](../../projects/monopoly/README.md) adds layers of complexity that make the coalition problem even harder:

- **The pressure mechanism is trade, not combat.** In Risk and Slay, you can directly attack the leader. In Monopoly, you can refuse to trade with them (passive constraint), but the active dynamics are between non-leaders. A trade between players two and three that gives both monopolies can be existential for player one — but player one can't prevent it, only try to counter-offer.
- **Trades have externalities.** Every trade has parties to the deal and parties affected by the deal. A two-way trade is really a multiplayer event because it shifts the competitive landscape for everyone.
- **Hidden information.** Card hands and future dice rolls are unknown. Unlike Risk (where you can see the board) or Slay (perfect information), Monopoly has genuine uncertainty layered on top of the coalition problem.
- **Negotiation is unstructured.** Any player can offer anything to anyone at any time. There's no forced trade structure — the space of possible deals is enormous and continuous (cash sweeteners, conditional trades, multi-property swaps).

**What was tried:**

- Markov-chain positional analysis for landing probabilities (works well — this is solved math)
- Earnings Per Turn (EPT) valuation based on landing probability × rent (works for property valuation in isolation)
- Genetic algorithm tuning of fudge factors for trade evaluation (found a local optimum but couldn't escape it)

**What went wrong:**

- All AIs shared the same valuation model, so valuations converged within 5% of list price. Trade requires genuine disagreement about value — identical utility functions produce no trade surplus.
- The genetic algorithm tuned parameters within a fixed model rather than discovering new strategic structure. The model itself was the constraint.
- The three-party problem was never properly addressed. A trade's value depends on its effect on the competitive landscape, not just the direct property exchange. The fudge factors approximated this but couldn't capture the full positional dynamics.
- Self-play with identical models couldn't generate the diversity needed to escape the local optimum. The AIs were effectively playing against mirrors.

**What Monopoly needs:**

- **Positional awareness:** evaluating trades based on their effect on the full competitive landscape, not just property-level valuation
- **Player modeling:** different AIs need genuinely different strategies or at least different risk tolerances to generate trade surplus
- **Phase awareness:** the game plays differently at 6 players, 4 players, 3 players (self-balancing), and 2 players (solved)
- **Counter-offer logic:** when two opponents are negotiating a trade that threatens you, what can you offer to disrupt it?

### The Relative Position Model (2026-02-22)

The local optimum wall revealed the core problem: the AI was evaluating trades in *absolute* terms (does this property make me richer?) rather than *relative* terms (does this trade improve my position against the field?).

#### Dice-EPT vs. Property-EPT

A critical distinction for understanding what EPT actually measures:

**Dice-EPT** is exogenous income — Go salary, Chance cards, Community Chest, certain square effects. This is new money entering the system from "outside." If no player owned any property and everyone just rolled dice, dice-EPT is the only income. All players would have roughly the same dice-EPT, and net worth would grow at the same rate for everyone. No differentiation.

**Property-EPT** is endogenous transfer — rent. When someone lands on your property, your net worth increases and theirs decreases by the same amount. Property-EPT is zero-sum. It creates no new value; it redistributes existing value between players.

**The global interest rate** is the sum of all players' dice-EPT — the rate at which total player wealth actually grows. Property development doesn't change this rate. Building a hotel doesn't make the pie bigger; it redirects more of the existing flow to you.

**Relative position** = your total EPT (dice + property) / average EPT of all players. In the no-property baseline, this ratio is 1.0 for everyone — flat, no differentiation. As property gets acquired and developed, the ratios diverge. The whole game is about making your ratio greater than 1.0 at others' expense.

This means:
- **Buying property** converts cash (which earns nothing) into a claim on future redistribution
- **Building houses** amplifies your share of the redistribution, not the total flow
- **Dice-EPT sets the tempo** — it's the clock that determines how many turns the redistribution dynamics have to play out before someone goes bankrupt
- **Property-EPT is the mechanism for differentiation** — the only way to pull ahead of the field

#### EPT as Slope

Each player's net worth over time can be graphed as a curve. Total EPT (dice + property) is the slope — the rate at which your position changes per turn. A player with high property-EPT and low cash is on a steep trajectory; a player with high cash and low property-EPT is on a flat one. The graph makes the competitive landscape visible.

**The decision criterion changes.** Every action — trade, build, hold cash — should be evaluated by how it changes your EPT *relative to the field average*:

- **The clean rule:** EPT above average = growing. EPT below average = shrinking. Every decision is about getting above the average and staying there, or pushing the leader below it.
- A trade doesn't have to go in your favor to be good. If you're in second and you trade with last place where they gain more than you, that's fine — what matters is whether your gain moves you closer to (or past) the leader's EPT. The reference frame is the field average and the leader, not your trade partner.
- Building houses on a complete monopoly is a slope change — you trade cash (intercept) for higher rent income (slope), capturing a larger share of the redistribution
- The ROI horizon: when your net worth curve crosses another player's curve, that's the payoff point. A steep slope with low intercept eventually overtakes a shallow slope with high intercept — but only if you survive long enough
- Dice-EPT is constant across the graph (everyone gets roughly the same baseline). The slopes diverge only because of property-EPT differences.

**Leadership is the reference frame.** Leader identification is easy (EPT calculation is solved math). Once you know who's ahead on the slope chart, every decision becomes: does this action close the gap between me and the leader, or widen it? The three-player self-balancing dynamic falls out naturally — two players with lower slopes have shared incentive to avoid any trade that steepens the leader's curve.

### The Atomic Trade Evaluation Problem

The relative position model tells you *what to measure* (EPT relative to field average) but not *how to evaluate individual trades* in multiplayer. This is the problem that stalled the Monopoly project.

**The trap:** You evaluate a trade with the leader in isolation — you gain more property-EPT than they do, so your relative position improves. Good trade. But the leader *also* makes individually-favorable trades with player 3 and player 4. Each opponent thinks they got the better end. But the leader accumulates *some* benefit from every trade, and the sum of those small benefits across all trades exceeds any single opponent's gain. The leader traded with the field and came out ahead against the field, even though they "lost" each bilateral exchange.

This is the coalition problem resurfacing. You cannot evaluate a trade without knowing what *other* trades the leader is making or might make. And you cannot coordinate with other players to block the leader's trade strategy without forming a coalition — which is the unsolved problem.

**Why atomic evaluation is insufficient:** In two-player games, bilateral trade evaluation works — there's only one opponent, so the bilateral view IS the full view. In multiplayer, every bilateral trade changes the landscape for every other possible trade. The evaluation space isn't N individual trades — it's the *combination* of all trades the leader could execute in a round. That's combinatorial.

**This is the kingmaker problem expressed through trade.** The classic kingmaker scenario is "player 3 decides whether player 1 or player 2 wins." Here the dynamic is inverted: the leader extracts kingmaker-level advantage from the field by exploiting the fact that no single opponent can see or respond to the full pattern of trades. Each player sees only their bilateral exchange and evaluates it as favorable. The collective result is that the field kingmakes the leader without intending to — and without any single player being "wrong" in their individual assessment.

**This was the wall.** The fudge factors in the Monopoly AI were approximating something about this dynamic — heuristics for "be cautious trading with the leader" or "discount leader-trade gains" — but without the theoretical framework to derive them. The insight is that the solution can't live at the level of individual trade assessment. It has to operate at the level of trade *policy* or *strategy* — rules about patterns of trades, not evaluation of single trades. What that policy looks like is an open problem.

**Why the GA couldn't find this.** The GA optimized fudge factors within a model that evaluated trades in isolation. The relative position framework requires evaluating trades *against the full competitive landscape* — a fundamentally different objective function. Tuning parameters in the wrong model can't discover the right model. The GA also likely didn't distinguish between dice-EPT (which it can't control) and property-EPT (which is the entire strategic lever).

### The Fudge Factor Audit and Trade Log Review (Next Step)

Before building more theory, look at the data. The Monopoly AI's trade logs and the GA's tuning history contain empirical evidence about what actually happened — and what didn't happen.

**The pricing puzzle:** During GA optimization, trade prices stayed within ~5% of face value across the board. Properties with known EPT advantages (higher landing probability, better rent-to-cost ratios) didn't command premiums. This doesn't sit right — it suggests either the valuation model couldn't express large deviations from face value, or the game states never created enough pressure to move prices.

**The most likely explanation:** Identical AIs reach similar game states. With the same valuation model, both sides agree on what properties are worth, so there's no disagreement to drive prices. Price discovery requires genuine difference in assessment — two copies of the same spreadsheet negotiating will converge on face value every time. Self-play with mirrors doesn't generate the differential needed for price movement.

**What to look for in the logs:**
1. **When did trades happen?** Probably early, before cash differentials developed. If so, the identical-position problem was at its worst during the trading window.
2. **Did desperate players make defensive trades?** A player falling behind might trade at unfavorable terms just to stay relevant. If this didn't happen, the AI may have lacked survival instinct — it evaluated trades on absolute merit rather than "I'm dying, any improvement helps."
3. **Were there cash differential situations?** A cash-rich player completing a monopoly can immediately develop (build houses), making the trade worth far more to them. A cash-poor player completing a monopoly gets base rents only. The same trade has wildly different value depending on cash position — but if identical AIs accumulate similar cash, this differential rarely exists.
4. **What did the fudge factors actually do?** Each manually tuned parameter marks where intuition substituted for theory. Audit each one:
   - What gap does this factor compensate for? What would the AI do wrong without it?
   - Can the relative position framework replace it? If it's approximating "don't make trades that help opponents more than you," the EPT model handles it directly.
   - Is the factor capturing something the framework doesn't yet explain? If so, it's pointing at a theoretical gap — a research lead, not a bug.
   - Can the factor be derived from first principles? A fudge factor computable from game state rather than tuned by GA is a theory, not a hack.

The goal is not to "fix the AI" but to use the AI as a laboratory: each fudge factor is an empirical observation about what the theory doesn't yet explain. Replacing fudge factors with principled rules derived from the interest rate / relative position framework is the real research output. ELO gains may follow, but they're the lagging indicator — the leading indicator is whether the theory generates the factor's effect naturally.

**Connection to the project pause:** The Monopoly project stalled partly because the web client for testing against real opponents couldn't be built, but more fundamentally because the theoretical framework wasn't developed enough to know *what to test*. The relative position model and the fudge factor audit provide a concrete research path that doesn't require competitive testing — the theory can be developed and validated against the existing AI's behavior before any external play.

## The Interest Rate Framework

A unifying concept across all three games (and RTS, which makes it real-time):

The **interest rate** is the rate at which invested resources compound into future capability. It's not a fixed number — it's an emergent property of the competitive environment. Your opponent's strategy determines your effective interest rate because they determine when your investments need to start paying off.

- **Boom vs. rush (RTS framing).** Pure boom is a bet that your ROI window is long. A rush calls in the loan early — forcing your opponent to liquidate capital investments before maturity. Defense is a hedge: lower growth rate in exchange for insurance against the rush. The defense investment is the risk premium.
- **In Risk:** Total territory is fixed — conquering territory is redistribution, not growth (same zero-sum structure as Monopoly's property-EPT). The card escalation curve is Risk's equivalent of dice-EPT: exogenous value entering the system. The leader's position sets the urgency. Early game the "interest rate" appears high because unclaimed territory is available cheaply, but this is a one-time redistribution from neutral to player, not compounding.
- **In Slay:** Purely zero-sum. Total territory is fixed, income derives from territory. There is no exogenous income — no dice-EPT equivalent. Every gain is another player's loss. The interest rate concept still applies in the sense of how efficiently territory converts to military capability, but the pie never grows.
- **In Monopoly:** The global interest rate is the total dice-EPT — Go salary, Chance/CC income, etc. This is the rate at which new money enters the system. Property development doesn't change this rate; it changes the *distribution* of the flow (see [Dice-EPT vs. Property-EPT](#dice-ept-vs-property-ept) above). The strategic "interest rate" that matters for decision-making is your property-EPT relative to the field — how fast you're capturing redistribution compared to opponents.
- **In 4X (MOO1, Civilization):** Early colony ships compound because each new colony produces resources for the next expansion. The implicit rate is highest when unclaimed territory exists and drops as the map fills — diminishing marginal returns on capital investment.

The interest rate dictates **input/output matching**. A high effective interest rate means you need tight, efficient production chains with minimal waste — every turn's output must feed next turn's input cleanly. A low rate gives you slack to be inefficient. The interest rate and the input/output matching problem are two faces of the same underlying dynamic: how efficiently does invested capital compound in a competitive environment?

In competitive games, the interest rate is **adversarial**. Your opponent is actively trying to manipulate your effective interest rate — forcing you to spend now instead of invest, disrupting your supply lines, raiding your economy to reduce your compounding base. Scouting (in RTS/4X) or reading opponents' positions (in Monopoly/Risk) is spending resources to reduce uncertainty about what interest rate environment you're actually in. Without information, you're making blind bets on time preference — the difference between risk and Knightian uncertainty.

## The Solvability Spectrum

What does "solved" mean for each game?

| Level | Definition | Examples |
|---|---|---|
| **Ultra-weakly solved** | Outcome from the initial position is known (win/draw/loss) but no strategy is specified | |
| **Weakly solved** | Optimal play from the initial position can be computed | Checkers (Schaeffer, 2007) |
| **Strongly solved** | Optimal play from any legal position can be computed | Tic-tac-toe, Connect Four |
| **Approximately solved** | Near-optimal play is achievable through search + evaluation | Chess (Stockfish), Go (AlphaGo) |
| **Computationally irreducible** | No shortcut to optimal play — must be simulated/played out | Markets, possibly multiplayer coalition games |

**Where Chris's games fall:**

- **Two-player Slay:** Approximately solvable. Alpha-beta + good evaluation should approach strong play. A NN evaluation function (Stockfish approach) could push it further. The question is whether heuristic eval is the current bottleneck or search depth is.
- **Six-player Slay:** Likely computationally irreducible in the general case. Phase decomposition might yield tractable approximations.
- **Risk (combat):** Strongly solved. Dice probability is just math.
- **Risk (strategy):** Unknown. The three-player stable state suggests tractable approximations exist for late-game dynamics. The full six-player game may be irreducible.
- **Monopoly (property valuation):** Solved. Markov chains + EPT.
- **Monopoly (trade strategy):** Open problem. The unstructured negotiation space and hidden information may push this beyond even coalition game theory into mechanism design.
- **Chess:** Approximately solved via the cyborg approach (NN eval + alpha-beta search). The reference implementation.

## The Stockfish Architecture as Template

Stockfish's evolution provides a practical template for Chris's game AI projects:

**Phase 1 — Pure heuristics.** Handcrafted evaluation function, alpha-beta search. This is where [Slay](../../projects/slay/README.md) and [Monopoly](../../projects/monopoly/README.md) are now. Good for establishing a baseline and understanding what the evaluation function needs to capture.

**Phase 2 — Identify the bottleneck.** Is the AI losing because it can't search deep enough (search problem) or because it misjudges positions (evaluation problem)? In Slay, this is testable: give the AI infinite search depth on small boards and see if it plays perfectly. If yes, the bottleneck is search. If no, the evaluation function is wrong.

**Phase 3 — NN evaluation (cyborg split).** Replace the handcrafted evaluation with a learned one. Keep the search algorithm. The NN handles pattern recognition over complex game states (what Stockfish's NNUE does). The search handles systematic exploration (what alpha-beta does). Each component does what it's best at.

**Phase 4 — Multiplayer adaptation.** For games beyond two players, the search component needs to change. Alpha-beta assumes a single opponent minimizing your score. With multiple opponents, you need either:

- **Paranoid search** (assume all opponents cooperate against you — conservative but tractable)
- **Max-N search** (each player maximizes their own score — more realistic but exponentially more expensive)
- **Monte Carlo Tree Search** with multiplayer dynamics (what modern multiplayer game AI tends to use)
- Or the **phase decomposition** approach: different algorithms for different player counts as the game progresses

**The open question:** does the Stockfish architecture generalize to multiplayer games? The NN eval + algorithmic search split should work regardless of player count — the NN evaluates positions, the search explores futures. But the search algorithm itself may need to be fundamentally different for multiplayer dynamics. This is the core research question.

## Phase Decomposition — A Tractable Approximation?

The observation that multiplayer games naturally reduce through phases suggests a decomposition strategy:

**Phase 1: Many players (6→4).** High chaos, rapid elimination of weak players. Strategy is mostly local — survive, accumulate, exploit mistakes. Leader evaluation is less useful because the "leader" changes rapidly. Heuristic play focused on position and efficiency may be sufficient.

**Phase 2: Middle game (4→3).** Coalition dynamics intensify. Temporary alliances form and break. Kingmaker situations arise. Leader evaluation matters here — but identifying the leader is not actually the hard problem. These games are mostly perfect information, and calculating the lead is relatively straightforward:

- **Slay:** Perfect information. Territory count, income, unit strength — all visible. The leader is trivially identifiable.
- **Risk:** Nearly perfect information. The board state is fully visible. The only hidden information is cards held, but worst-case assumption (assume each opponent holds a tradeable set) is good enough for accurate positional assessment.
- **Monopoly:** The EPT (Earnings Per Turn) framework already solves this — Markov-chain landing probabilities × rent gives you each player's expected income. Total asset position is visible. The leader calculation is just math.

The hard problem in Phase 2 is not *who* is leading but *what to do about it* — the coalition response. When and how to pressure the leader, whether to ally with another underdog or go it alone, and how to avoid becoming the kingmaker.

**Phase 3: Three-player balance (3→2).** The self-balancing dynamic kicks in. The two weaker players pressure the leader. Alliances swap as leadership changes. This phase might be approximately solvable if the balancing dynamic can be formalized — perhaps as a repeated game where the equilibrium strategy is "always oppose the leader."

**Phase 4: Endgame (2→1).** Two-player game. Minimax applies. Solved or approximately solved depending on the game.

**The research question:** Can each phase be solved (or approximately solved) independently, with transitions between phases handled by recognizing when the game state has shifted from one regime to another? If so, the full multiplayer game doesn't need to be solved — only each phase does, and the phase transitions.

This is similar to how chess engines handle openings (book), middlegame (search + eval), and endgame (tablebases) as distinct problems with different algorithms. The multiplayer version would be: early game (heuristic accumulation), middle game (coalition-aware search), late game (self-balancing leader opposition), endgame (minimax).

## Open Questions

- Can the three-player self-balancing dynamic be formalized as a theorem? Something like: "In a three-player game with asymmetric growth rates and the ability to selectively attack, the unique stable strategy profile is 'always oppose the leader.'" If provable, this would solve the late-game phase for all three games.
- Is there a formal reduction from Risk's coalition problem (or Slay's, or Monopoly's) to a known PPAD-complete problem? This would prove intractability of the full solution.
- Can Monte Carlo Tree Search with multiplayer dynamics find better solutions than the heuristic + genetic algorithm approach that plateaued in Monopoly?
- Does giving AI players genuinely different valuation models (rather than the same model with tuned parameters) generate enough trade surplus to break Monopoly out of the 5% convergence trap?
- What's the minimum information an AI needs about opponents' strategies to make good coalition decisions? Leader identification is easy in these games (they're mostly perfect information — see Phase 2 note above). The real question is what additional modeling of opponent *intent* (not position) is needed to predict coalition shifts.
- Can the interest rate framework be formalized enough to serve as a meta-heuristic — an AI that explicitly models its effective interest rate and adjusts strategy based on whether it's ahead or behind the compounding curve?
- Is the Stockfish NN eval + algorithmic search split sufficient for multiplayer, or does the search itself need to be learned?
- **Relative position as objective function:** If the Monopoly AI is retrained with "maximize relative EPT slope advantage" instead of "maximize absolute win rate," does it escape the local optimum? The GA's convergence may have been an artifact of the wrong objective function, not a fundamental limitation.
- **Fudge factor analysis:** Which of the Monopoly AI's manually tuned parameters can be derived from the EPT slope / relative position framework? Each replaceable factor is a validation of the theory; each irreplaceable factor points to a gap.
- **Cross-game generalization:** All three games (Monopoly, Risk, Slay) share zero-sum redistribution on the territory/property axis. Monopoly and Risk also have exogenous income (dice-EPT, card escalation). Slay is purely zero-sum. The "EPT above average = growing, below average = shrinking" rule should apply universally — in Risk the "EPT" is territory income rate, in Slay it's territory × income per hex. Does this single framework unify trade evaluation (Monopoly), attack targeting (Risk/Slay), and alliance formation (all three)?

## Suggested Reading

| Work | Author | Relevance |
|---|---|---|
| *Theory of Games and Economic Behavior* (1944) | Von Neumann & Morgenstern | Foundation of game theory; minimax theorem for two-player zero-sum games |
| *Non-Cooperative Games* (1950) | John Nash | Nash equilibrium — the solution concept for multiplayer games |
| *The Complexity of Computing a Nash Equilibrium* (2009) | Daskalakis, Goldberg, Papadimitriou | Proof that computing Nash equilibria is PPAD-complete |
| *Mastering Chess and Shogi by Self-Play* (2017) | Silver et al. (DeepMind) | AlphaZero — NN eval + MCTS replacing handcrafted heuristics in two-player games |
| *Efficiently Updatable Neural-Network-based Eval* (2020) | Yu Nasu (Stockfish) | NNUE — the cyborg approach: NN eval inside traditional alpha-beta search |
| *Pluribus: Superhuman AI for Multiplayer Poker* (2019) | Brown & Sandholm | AI for six-player poker — the closest existing work to the multiplayer coalition problem with hidden information |
| *War and Peace and War* (2006) | Peter Turchin | Asabiyyah and civilizational cycles — the real-world analogue of the three-player balancing dynamic |

## Tags

[games](../../tags/games.md), [game-ai](../../tags/game-ai.md), [economics](../../tags/economics.md), [ai](../../tags/ai.md), [mathematics](../../tags/mathematics.md), [simulation](../../tags/simulation.md)

---
status: active
created: 2026-11-08
discussion: pending
---
# Board-Game Simulation Channels — Perfect Play, Board Odds, Forced Win
> Three YouTube channels that turn board-game strategies into scripted bots and run them through millions of games. The engineering is mostly sound: Board Odds' Risk dice tables match the vault's exact solver to the decimal. But **every result is a statement about the bot players it was measured against**, and the three channels change the opponent, the rules and the meaning of a strategy's name from video to video. Read across channels, most apparent contradictions dissolve once you line up the rule set and the opponent model. **They are also less independent than they look:** Board Odds copies Perfect Play's script template, and Board Odds and Forced Win run Catan on the same open-source engine.

**Sources:** ten captured transcripts, one line each on the per-game pages below, all in [raw/videos/](../../../raw/videos/) dated 2026-10-13 to 2026-11-07 (clipped 2026-11-08).

**Links:** [Pokémon Gen 1 tournament](../pokemon-gen1-1v1-tournament.md) (the same genre, critiqued: fixed policy ⇒ exact chain), [D&D Monster Tournament — Exact Markov Chains](../dnd-monster-tournament-markov.md), [Risk — The Attrition Constant](../risk-attrition-odds.md), [Catan — 47k Empirical](../catan-47k-empirical.md), [Monopoly project](../../../projects/monopoly/README.md), [Frontier Trade Theory](../monopoly/frontier-trade-theory.md), [Hollow Opponent, Perceived Depth](../hollow-opponent-perceived-depth.md)

---

## Per-game pages

| Game | Videos | Page |
|---|---|---|
| Monopoly | Perfect Play, Board Odds | [monopoly.md](./monopoly.md) |
| Catan | Perfect Play, Board Odds, Forced Win; DandyDrew's reaction to Perfect Play | [catan.md](./catan.md) |
| Risk | Perfect Play, Board Odds | [risk.md](./risk.md) |
| Ticket to Ride (+ Minesweeper) | Perfect Play, Board Odds; Perfect Play only | [ticket-to-ride.md](./ticket-to-ride.md) |

Scope is deliberate: Perfect Play's five games, plus every Board Odds and Forced Win video on the same games. Board Odds' other eleven games (Othello, Codenames, Yahtzee, Battleship, …) are not captured.

## The three channels

| | Perfect Play (`@PerfectPlaySim`) | Board Odds (`@BoardOdds`) | Forced Win (`@forcedwingames`) |
|---|---|---|---|
| First video | 2026-10-13 (Monopoly) | 2026-10-20 (Risk) | 2026-10-27 (Catan), its only video |
| Players | a hand-built "regular", then each plan **search-tuned** against regulars | a "normal" bot plus **one fixed habit** per test; an "expert" chosen by a small grid scan | hand-written bots plus the engine's own look-ahead bot |
| Engine | own code, unpublished | own code (code linked for Risk); **Catanatron** for Catan | **Catanatron** |
| Validation | against published numbers: a 1996 landing table, a 2003 dice table, a 2017 Minesweeper paper, a 2022 Leiden thesis | strongest: exact Markov landing model, invariant checks on every action, identical-bot controls (25.00% / 50.00%), paired dice across seats | little stated |
| Weak spot | headline game counts mostly unitemised (Monopoly's 300M shows ~10M) | "normal" never calibrated against real play | internal tensions (City Rusher "equilibrium" vs its own cities-first habit test) |

## How to read a result from these channels

1. **Name the opponent.** "Plan X wins 44.8%" means *against these regulars*. Perfect Play's own Risk test shows the tuned player's 48% collapsing once three copies of it share a table (the lone regular wins 82%). An exploit of one opponent model is not a strategy.
   A champion makes the same objection from the table side: DandyDrew says human Catan is cooperative (the table trades with and gangs up on whoever leads), which no bot here models ([catan.md](./catan.md#a-champions-read-dandydrew-on-perfect-play)).
2. **Name the rule set.** The Risk Australia dispute between the channels is a draft-vs-deal rule difference, which Perfect Play's own dealt-territory test confirms ([risk.md](./risk.md)).
3. **Check the label.** "Ore/wheat", "port" and "army" mean different bots on each channel. Perfect Play's knight army buys about one extra dev card a game. Board Odds' largest-army bot buys dev cards first.
4. **Check the clock.** Several headline effects are game-length effects: the Ticket to Ride hoarder wins by ending the game at round 30 against bots pacing for 41. And 67% of Board Odds' no-trade Monopoly games hit its 1,000-round cap, so "luck takes over" partly reflects the cap's tiebreak.
5. **Count oracles, not channels.** Agreement between Perfect Play and Board Odds is weaker evidence than it looks (next section).

## Independence

- **A shared template.** Every Board Odds video opens with Perfect Play's Monopoly line, "Everybody at the table has a ___ strategy", and closes with its "tell me in the comments" sign-off. Perfect Play used it first. The simulation setups differ (paired dice, different baselines, different caps), so this reads as a copied format or a shared AI-script template rather than one author. Treat the two as **independent in simulation, correlated in framing**.
- **A shared engine.** Board Odds' and Forced Win's Catan both run on Catanatron, so engine-level artifacts (board generation, the seat effect) would show up in both.
- **An external oracle that does hold:** the vault's [`risk-battle-odds.py`](../../../tools/risk-battle-odds.py) reproduces all six of Board Odds' quoted battle odds (5v5 50.62, 10v10 56.76, 20v20 63.34, 9v10 47.99, 13v10 78.68, 16v10 90.70). That validates the dice layer only, not the strategy layer.

## What carries across the games

- **Seat edges appear in every bot simulation** (Monopoly, Risk, Ticket to Ride, Catan). Perfect Play checked Catan's against real games, where seats are roughly even, and made it vanish by adding about 20% spot misjudgement. Treat bot seat effects as artifacts of bots agreeing perfectly.
- **"Never negotiates" is the shared blind spot.** All three say so. Every trading result runs on one or two narrow trade types, which bounds what they can say about the vault's [trade theory](../monopoly/frontier-trade-theory.md).

## Open Questions

- Is Perfect Play's "41,000 real online games" Catan check the same twosheep.io data behind [Catan — 47k Empirical](../catan-47k-empirical.md) (47,000 games)? Both find even seats.
- Do the channels publish code or result tables? (Board Odds links Risk code; Perfect Play's engine is unpublished.)
- Is a channel-agnostic test possible? Rerun one disputed claim (South America vs Australia under a dealt start) on one engine with both channels' opponent models.

## Tags

[games](../../../tags/games.md) · [simulation](../../../tags/simulation.md) · [game-ai](../../../tags/game-ai.md) · [methodology](../../../tags/methodology.md) · [youtube](../../../tags/youtube.md)

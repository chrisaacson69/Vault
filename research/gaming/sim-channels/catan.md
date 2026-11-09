---
status: active
created: 2026-11-08
discussion: folded-in
---
# Catan — Perfect Play vs Board Odds vs Forced Win
> Three bot simulations of base Catan, two of them on the same open-source engine (Catanatron). They agree on a core: **a varied opening beats pure pip-chasing, wasting the robber hurts while its exact target barely matters, trading matters, and naive "road every chance" bots are hopeless (3.5–5.3%).** They disagree on cities vs settlements, ore/wheat plans, ports, knights and seat order, and almost every disagreement traces to a different baseline opponent, optimised vs hand-written bots, or a strategy name meaning a different bot. Each channel found a different "biggest lever" because each tested different levers: Board Odds opening placement, Forced Win hand size over 7, Perfect Play settlements before cities.

**Source:** [Perfect Play — "The Best Catan Strategy, Tested on 200 Million Games"](../../../raw/videos/2026-10-31%20perfect-play-catan-200m-games.md) — <https://www.youtube.com/watch?v=3XLDKvhrIjk> (12:29, 2026-10-31; auto-captions)
**Source:** [Board Odds — "The Best Catan Strategy, Tested on 3 Million Games"](../../../raw/videos/2026-10-21%20board-odds-catan-3m-games.md) — <https://www.youtube.com/watch?v=u-LJ2lhFnY8> (13:18, 2026-10-21; auto-captions)
**Source:** [Forced Win — "The Best Catan Strategy, Tested on 3.7 Million Games"](../../../raw/videos/2026-10-27%20forced-win-catan-3-7m-games.md) — <https://www.youtube.com/watch?v=_3h9RjWUyts> (11:02, 2026-10-27; creator captions)
**Source:** [DandyDrew — "The Best Catan Strategy, Tested on 200 Million Games - Catan Pro Reacts"](../../../raw/videos/2026-11-04%20dandydrew-reacts-perfect-play-catan.md) — <https://www.youtube.com/watch?v=5PTM5PdqyVw> (22:51, 2026-11-04; auto-captions; split from the played video with [`tools/split-reaction.py`](../../../tools/split-reaction.py))
**Source:** [Catan road and seed-vs-skill sources](../../../raw/articles/2026-11-08%20catan-road-and-seed-sources.md) — a manifest for the fan's 36,000-game simulation (Wargamer, <https://www.wargamer.com/catan/fan-simulated-36000-games>) and Goodman, Perez-Liebana & Lucas, "Seeding for Success" (<https://arxiv.org/abs/2503.02686>)

**Links:** [Simulation channels hub](./README.md), [Catan — 47k Empirical](../catan-47k-empirical.md), [Catan 50-Game Validation](../catan-50-games-validation.md), [Capability Without Leverage](../capability-without-leverage.md) (the unleveraged port), [Bilateral Trade Valuation](../bilateral-trade-valuation.md)

---

## Setups

| | Perfect Play | Board Odds | Forced Win |
|---|---|---|---|
| Engine | own | Catanatron [0:58] | Catanatron [1:17] |
| Board | random; no adjacent 6/8 [0:54] | random; adjacency rule not stated | random |
| Player trading | 1-for-1 when both need; none with a near-winner [1:06] | **none**, bank and ports only [1:58] | 1-for-1 swap offers [1:27] |
| Opponents | search-tuned plans vs a regular; a tuned player [2:20–2:34] | 8 fixed hand-written plans [2:22–3:53] | 8 hand-written bots + the engine's look-ahead AI [1:39, 6:18] |
| Main design | 35 tables × 500k; one plan vs 3 regulars and vs 3 tuned [2:37–4:12] | 2.5M random 4-of-8 games; 50k per plan vs 3 balanced [1:21, 4:11] | 70 tables × 10k; habit tests vs 3 Builders [2:23, 4:13] |

## Headline rankings (one plan vs three baselines)

- **Perfect Play** (vs 3 regulars): tuned 60.5, knight army 57, all five 57, road builder 47, biggest numbers 43, ore-wheat-sheep ~34, port trader ~34 [3:13–3:35].
- **Board Odds** (vs 3 balanced, baseline 24.7): five resources 26.7, high numbers 23.9, largest army 21.4, ore-wheat 19.3, wood-brick 5.3, longest road 5.3 [5:07–9:28]. Only five resources beats normal, by 2 points.
- **Forced Win** (tournament): City Rusher 33, Trader 32, Port Master 31, Builder 30, Army 29, Saver 24, Never Trades 18, Road Builder 3.5 [2:54]. Its "AI Playbook" (rules distilled from the engine bot) wins 41% against both Builders and City Rushers [8:38–9:31].

## Where they agree

- **Varied openings help.** +2 (Board Odds), +8 for a five-resource rule (Forced Win), all five co-top (Perfect Play). Perfect Play's caveat: its equally strong knight army rarely touches all five, so variety "isn't the secret" [7:53].
- **Pure pips underperform** in all three.
- **Robber.** A random robber costs 3.7 / ~4 / 10.5 points. Leader vs max-damage targeting differs by under a point or ties.
- **Trading.** Random trading −8.4 (Board Odds); never trading 16 vs 25 (Forced Win); only accepting offers −6 (Perfect Play).
- **Longest road comes with winning, not before it.** Winners hold it 33.8% (Board Odds) and 44% (Forced Win), and the tuned player holds it in almost 9 of 10 wins (Perfect Play). But Forced Win's Road Builder held it in 79% of its games and still lost 96.5% [3:45].

## Where they disagree, and why

| Question | Disagreement | Likely cause |
|---|---|---|
| Cities vs settlements | Perfect Play: settlements first is the biggest habit (~15 pts). Forced Win: its habit test agrees (cities-first 22%), yet its City Rusher wins the tournament. Board Odds: "build cities" | different baselines; Board Odds never ablated build order apart from resource weights |
| Ore/wheat | Forced Win first; Perfect Play and Board Odds near the bottom | Perfect Play's version also bans longest road and starves wood/brick; its own decomposition blames those rules |
| Ports | Perfect Play last at every table; Forced Win third | Perfect Play forces 19/20 port starts at a pip cost; Forced Win's Builder barely uses the bank, so ports are a relative edge |
| Knights | Perfect Play co-best; Board Odds below normal; Forced Win's AI never takes largest army | Perfect Play's knight army is the tuned player plus ~1 card a game, not dev-first |
| Seat order | Perfect Play first > last by 2.5; Board Odds seat 2 worst; Forced Win last 31 vs first 18 | engine/placement artifacts; same engine, opposite results suggests a definition difference |

## Cross-check against real games

Perfect Play compared with "41,000 real online games" [10:05]. The knight pattern matched: 3 knights more than double the win rate. The seat pattern did not: real seats are roughly even, and adding about 20% spot misjudgement erased the bot seat edge. Our [47k page](../catan-47k-empirical.md) (Ioana Roman, twosheep.io) also finds turn order balanced. Whether the two datasets are the same is open.

## No principle survives the sources

Line up every Catan source the vault holds and each popular principle appears on both sides:

| Source | Longest-road holder among winners | Conclusion |
|---|---|---|
| Fan simulation, 36k games (Reddit, via Wargamer) | 56–61% | roads are "OP"; wheat is the best resource |
| Forced Win | 44% (excluding Road Builder tables) | rebuts the fan by name [3:33] |
| Board Odds | 33.8% | "a prize for the winner, not a way to become one" |
| Perfect Play | in almost 9 of 10 of its tuned player's wins | "chase the longest road" |
| [Roman, 47k real games](../catan-47k-empirical.md) | n/a | a symptom of winning, not a cause |

The same split runs through resources and build order. Perfect Play's tuned player leans on ore then wheat, and the fan's data names wheat the best resource, yet ore-wheat-sheep "loses" on two channels. Perfect Play says settlements before cities, while Forced Win's City Rusher wins its tournament. The fan's own write-up concedes the point: no strategy won overall, each had an edge in different starting situations.

**Why: the board picks the plan.** "Seeding for Success" (Goodman, Perez-Liebana & Lucas, IEEE Transactions on Games, 2025) gives Catan's randomness by source, with competent MCTS agents:
- **The map decides more than the dice.** Trimmed span is 0.31 for the map against 0.11 for the dice.
- **A seat's value depends on the board.** The first player averages 22%, but on 95% of boards their underlying win chance lies between 4% and 56%.
- **Skill reveals the position.** With random agents the board has no effect at all. Across the paper's 15 games, the more skilled the agents, the more the specific board or deal decides the result.

A fixed principle averages over boards, so it is wrong on many of them. Drew makes the same point from the table: what works depends on the setup and on what the other players do. That is the hub page's thesis in its clearest case ([chess, not chutes and ladders](./README.md#thesis--chess-not-chutes-and-ladders)).

## A champion's read (DandyDrew on Perfect Play)

DandyDrew (USA Catan champion, top-ranked online) reacted to Perfect Play's video, playing 98% of it. The commentary was separated from the playback by aligning his capture against Perfect Play's: 47.4% of the reaction is his. Timestamps below are in his video.

- **He rejects the same two takeaways the other channels contest.** He is "cool with everything with the exception of one and two" [21:25]: Perfect Play's #1 "settlements before cities" and #2 "chase the longest road". Board Odds says build cities and don't chase roads, and Forced Win's City Rusher wins its tournament. **A top player and two simulations disagree with Perfect Play at the same two points.** That is two independent lines rather than three, since Board Odds and Forced Win share the Catanatron engine. His view on #1 is mixed: he also defends settlements-first on social grounds, because an early city makes you the target [11:22].
- **His central objection is the opponent model.** He describes human Catan as cooperative: when someone leads, the table trades heavily and gangs up [5:29]. He is "shocked" that ore-wheat-sheep, "one of the most dominant strategies in the meta", ranks near the bottom, and expects it to rise at a cooperative trading table, where social balancing lets it work without wood, brick or longest road [5:29, 17:05]. This is the hub page's *name the opponent* rule, made by a top player.
- **The labels.** To him, Perfect Play's knight army and ore-wheat-sheep are nearly the same plan, since ore-wheat-sheep's premise *is* dev cards and largest army [3:42]. That is the same label problem the disagreement table above traces from the bots' side.
- **A selection effect called out.** "Three knights more than double the win rate" is "obvious because you need three knights to get army" [18:55]. Perfect Play used that pattern as its match against real games, so the match is weaker than presented.
- **Where he agrees with the data:** don't start on a port, because going coastal opens the board to everyone else [9:10]. Dev-card-first play collapses because production falls behind [12:55]. Ore and wheat come first [15:04].
- **Mechanics the bots miss:** humans hold knights for timing instead of playing every one [20:04].
- He corrects the pronunciation of Perfect Play's cited champion, Bo Peng [16:02].

## Reading the board as an economy (Chris)

The setup is random, but each resource's total pips can be counted. That supply plus each build's recipe says which goals are cheap and which are expensive *on this board*, which should drive the plan or at least the opening. The qualitative version is already in the vault as the [board-as-efficient-frontier sketch](../catan-47k-empirical.md#board-as-efficient-frontier--a-prescription-theory-sketch). What this adds is a price.

**The price, computed.** [`tools/catan-board-supply.py`](../../../tools/catan-board-supply.py) weights each build's recipe by its inputs' scarcity, where 1.0 per card means a perfectly even board. Over 200,000 random boards (run 2026-11-09):
- **Brick and ore are scarce by design:** 3 tiles each against 4 for the others, so 9.7 expected pips vs 12.9. A resource's total ranges from about 6 to 17 between the 5th and 95th percentile boards.
- **Cities are the most board-sensitive build:** median price 5.48 for 5 cards, 4.45–7.46 between the 5th and 95th percentiles, because a city needs 3 ore. Roads run 2.13 (1.74–2.83), settlements 4.04 (3.68–4.57), dev cards 3.09 (2.69–3.73).
- **The city/settlement price ratio runs from 1.00 to 2.02** (median 1.36). On some deals a city costs no more than a settlement; on others it costs twice as much. Channels averaging over random boards are averaging over that swing, which is one reading of why they split on cities vs settlements.

That is board supply, not what a player captures, and it leaves out two things that also price a build:

- **Open land expires; cities don't (Chris, spelling out DandyDrew's "pace with the board" [11:56]).** Roads and settlements are the land-grab phase. Settlement spots are a shared stock that runs out, while a city can go on a spot you own at any time. A player who rushes cities can grow big early and then stall with nowhere left to expand. So a settlement's real price has to include the option it saves you from losing, and the supply model above can't see that.
- **A big early city paints a target.** Drew: "when you build an early city, you become an early target… you're going to take a lot of heat" [11:35]. A city on a big spot reads as the lead, and the lead draws the robber.
- **Identical bots can't find the gaps (Chris).** When every player follows the same rules, nobody leaves a gap for anyone else to exploit: no open land left by a table of city-rushers, no undercontested resource. The [frontier sketch](../catan-47k-empirical.md#common-knowledge-competition--the-counter-positioning-move)'s counter-positioning move needs a table of players with different plans. A homogeneous bot table measures each plan against copies of the baseline, never against the hole the others leave.

**Verifying it needs expert human games, not bots (Chris).** A recorded game shows how real players reacted to a board, so the board's prices can be set against how the winner actually won. Bot games can't do that, for the reasons this page exists: their plans are fixed and don't react to the board. The comparison design:
- per game: the full board → prices → which path the board makes cheap (cities and dev cards vs roads and settlements);
- the winner's realized path (VP from cities, settlements, longest road, largest army, VP cards);
- the control: did players whose path matched the board's prices win more often than players whose path didn't? That control is needed because a winner's path also follows from their placement, not only from the board.

**Data.** The public Kaggle 50 games can't run this: they record only the tiles players touched, not the full board. Roman's 47k set is private. The usable expert sources are **twosheep's Champs-division replays** (viewable one at a time, no bulk export) and **DandyDrew's recorded games**, both small-N and transcribed by hand. Catanatron stays useful for the price tool's mechanics, not for verifying the theory.

**Holding the scarce resource.**
- **Trading leverage.** Owning the only good supply of a scarce resource is a better outside option, and in [Nash bargaining](../nash-bargaining-problem.md) an outside option shifts the split, not just the floor. It's the same pattern as the [Monopoly careful trader](./monopoly.md#what-both-channels-missed).
- **The robber, a hypothesis (Chris).** Resources are [hidden trackable](../catan-47k-empirical.md#hidden-trackable--a-soft-design-flaw), so a careful robber knows whether you hold the scarce card and the odds of stealing it. They may rob *you* but on a different hex, so your scarce hex keeps producing for trade. And the holder may refuse to trade with whoever robbed them. That is the same social price as breaking a continent in [Risk](./risk.md#the-axis-neither-channel-varies-the-planning-horizon-chris). Bots carry no grudge, so in their games an attack costs only what it costs on the board.

## Caveats

- No player negotiation anywhere. Board Odds has no player trading at all.
- Perfect Play's plans are "the best version of X found against regulars"; Board Odds' and Forced Win's are hand-written, so "longest road loses" means "this naive road bot loses".
- Board Odds' ablations *randomise* a decision rather than remove it, which measures a bad version of each decision.

## Open Questions

- Does Forced Win's +13 from "never end a turn on more than 7 cards" survive against a baseline that already manages its hand?
- Does Catanatron allow adjacent 6/8? If so, Board Odds' and Forced Win's boards differ from Perfect Play's.
- Comparison with [Catan — 47k Empirical](../catan-47k-empirical.md)'s city-engine and trade-overpay findings is the next step.
- On expert human games (twosheep Champs replays, DandyDrew's games, transcribed by hand): do players whose path matches the board's prices win more often? Catanatron can check the tool's mechanics but can't verify the theory, since bot plans don't react to the board.
- Does robbing the scarce-resource holder on their scarce hex cost the robber trades, or is the refusal-to-trade response too rare to matter?

## Tags

[games](../../../tags/games.md) · [simulation](../../../tags/simulation.md) · [game-ai](../../../tags/game-ai.md) · [youtube](../../../tags/youtube.md)

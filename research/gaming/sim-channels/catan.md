---
status: active
created: 2026-11-08
discussion: pending
---
# Catan — Perfect Play vs Board Odds vs Forced Win
> Three bot simulations of base Catan, two of them on the same open-source engine (Catanatron). They agree on a core: **a varied opening beats pure pip-chasing, wasting the robber hurts while its exact target barely matters, trading matters, and naive "road every chance" bots are hopeless (3.5–5.3%).** They disagree on cities vs settlements, ore/wheat plans, ports, knights and seat order, and almost every disagreement traces to a different baseline opponent, optimised vs hand-written bots, or a strategy name meaning a different bot. Each channel found a different "biggest lever" because each tested different levers: Board Odds opening placement, Forced Win hand size over 7, Perfect Play settlements before cities.

**Source:** [Perfect Play — "The Best Catan Strategy, Tested on 200 Million Games"](../../../raw/videos/2026-10-31%20perfect-play-catan-200m-games.md) — <https://www.youtube.com/watch?v=3XLDKvhrIjk> (12:29, 2026-10-31; auto-captions)
**Source:** [Board Odds — "The Best Catan Strategy, Tested on 3 Million Games"](../../../raw/videos/2026-10-21%20board-odds-catan-3m-games.md) — <https://www.youtube.com/watch?v=u-LJ2lhFnY8> (13:18, 2026-10-21; auto-captions)
**Source:** [Forced Win — "The Best Catan Strategy, Tested on 3.7 Million Games"](../../../raw/videos/2026-10-27%20forced-win-catan-3-7m-games.md) — <https://www.youtube.com/watch?v=_3h9RjWUyts> (11:02, 2026-10-27; creator captions)

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

## Caveats

- No player negotiation anywhere. Board Odds has no player trading at all.
- Perfect Play's plans are "the best version of X found against regulars"; Board Odds' and Forced Win's are hand-written, so "longest road loses" means "this naive road bot loses".
- Board Odds' ablations *randomise* a decision rather than remove it, which measures a bad version of each decision.

## Open Questions

- Does Forced Win's +13 from "never end a turn on more than 7 cards" survive against a baseline that already manages its hand?
- Does Catanatron allow adjacent 6/8? If so, Board Odds' and Forced Win's boards differ from Perfect Play's.
- Comparison with [Catan — 47k Empirical](../catan-47k-empirical.md)'s city-engine and trade-overpay findings is the next step.

## Tags

[games](../../../tags/games.md) · [simulation](../../../tags/simulation.md) · [game-ai](../../../tags/game-ai.md) · [youtube](../../../tags/youtube.md)

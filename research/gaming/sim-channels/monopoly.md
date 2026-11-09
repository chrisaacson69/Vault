---
status: active
created: 2026-11-08
discussion: pending
---
# Monopoly — Perfect Play vs Board Odds
> Two bot simulations of official-rules Monopoly agree on the practical rules: **trade, build aggressively (mortgage lone properties to do it), don't sit on cash, buy what you land on, don't stop at three houses, stay in jail once the board fills.** Both find trading the biggest single lever, and without it the game stalls: two of three no-trade games never end. Board Odds adds a paired-dice luck measure. Expert beats normal 71.63% one-on-one, but the same seat wins both games on 47.19% of boards, so "dice decided" that share for this matchup. Both channels' trade models are narrow (set-for-set swaps, plus cash for a set's last pieces on Board Odds), which bounds what they say about real trading.

**Source:** [Perfect Play — "The Best Monopoly Strategy, Tested on 300 Million Games"](../../../raw/videos/2026-10-13%20perfect-play-monopoly-300m-games.md) — <https://www.youtube.com/watch?v=S_2eVAaw1UM> (8:48, 2026-10-13; creator captions)
**Source:** [Board Odds — "How Much of Monopoly Is Luck? I Simulated 100 Million Games"](../../../raw/videos/2026-11-06%20board-odds-monopoly-luck-100m-games.md) — <https://www.youtube.com/watch?v=eqzI_SjMBT4> (17:06, 2026-11-06; auto-captions)

**Links:** [Simulation channels hub](./README.md), [Monopoly project](../../../projects/monopoly/README.md), [Frontier Trade Theory](../monopoly/frontier-trade-theory.md), [Capability Without Leverage](../capability-without-leverage.md)

---

## Setups

| | Perfect Play | Board Odds |
|---|---|---|
| Rules | official; auctions, even building, 32 houses [0:37–0:52] | official US Classic; auctions; 1,000-round cap, then "richest" wins (undefined) [1:42–2:51] |
| Trades | one type: a swap completing a set for both sides [1:16] | set-for-set swaps, plus cash for a set's last pieces [2:57–3:05] |
| Baseline | "Buy Everything": buys all, builds with any money, always trades [1:25] | "Normal": buys if it can, bids ≤ printed price, builds only if $200 remains, sells set pieces at 2× [3:13–3:30] |
| Design | 8 bots, all 70 four-player tables; 1M-game single-habit tests [2:12–2:48] | 750k boards with **fixed dice per seat**, players rotated through seats; 17 single-habit players [0:33–4:44] |
| Validation | 400M rolls vs a 1996 landing table [0:54–1:08] | exact Markov landing model (0.012 pp), rent cross-check, invariant checks, 25.00/50.00% controls [4:57–5:46] |

## Results side by side (single habit vs three baselines)

| Habit | Perfect Play | Board Odds |
|---|---|---|
| Baseline share | ~21% (1 game in 6 never ends) [2:50] | 25% [8:47] |
| Mortgage to build / build with every dollar | 21 → ~23 [5:13] | 30.02 / 30.96 [8:52–8:58] |
| Stop at 3 houses | 17 [5:03] | 18.53 [9:16] |
| Keep a cash cushion | 13 ($300/$500) [4:22] | 15.33 ($500) [9:39] |
| Orange + red only | under 3 [3:20] | 15.42 [9:51] |
| Never trade | 6.5 [5:30] | 4.69 [11:12] |
| Stay in jail once houses exist | in the final bot [7:42] | 26.6 [10:46] |

The directions agree everywhere. The levels differ because the baselines differ: Perfect Play's baseline already builds with its last dollar, Board Odds' keeps $200.

## Findings worth keeping

- **Sets come from trades.** With trading off, no Perfect Play player completed a set in more than half its games [3:46]. With no trades on Board Odds, 67% of games are still running at round 1,000 [11:44].
- **Overpaying loses.** Board Odds: paying 3× to complete a set gives 19.7 vs the 2× baseline [10:59]. Perfect Play: a "careful trader" that refuses swaps favouring the other side does *worse* than always accepting [5:43]. A trade that completes a set for both sides is a race, and refusing it stalls you along with the opponent.
- **Skip a property only while someone else buys it.** Perfect Play's tuned bot learned to skip green and utilities against normal players, but in self-play the copy that reverted to buying everything won 69% [7:06–7:14]. That makes property value opponent-dependent, the same point the hub page makes about strategies.
- **Colour-set duels.** Orange beats every other set one-on-one; green and dark blue sit near the bottom, above only brown; light blue beats Boardwalk/Park Place 6 in 10 [6:13–6:24]. These are 2-player single-set duels, not normal games.
- **Luck share (Board Odds).** Expert vs normal 1v1: the same seat won both games on 47.19% of boards, the expert won from both seats on 48.03%, the normal on 4.77% [7:04–7:12]. With trading off, dice-decided rises to 75.10% [11:54]. The creator warns this is matchup-specific, not "Monopoly is 47% luck" [1:13].
- **Series length.** At p = 0.7163 a best-of-9 reaches 90% for the better player [7:19–7:36].

## Caveats

- **Trade model.** Both channels accept almost every set-completing swap, so "always trade" holds against counterparts who always say yes. Neither models denial, timing or three-way deals, which is where the vault's [frontier trade theory](../monopoly/frontier-trade-theory.md) lives.
- **Non-ending games** drive the levels: Perfect Play doesn't say how they score; Board Odds scores them by an undefined "richest".
- **The expert is tuned against the normal bot**, so 71.63% partly measures that bot's 2× pricing.
- **Possible shared authorship** of the script: see the hub page's independence section.

## Open Questions

- How do these compare with the [Monopoly project](../../../projects/monopoly/README.md)'s engine and EPT valuations? (The comparison step, not yet done.)
- Does "orange beats every set" survive in 4-player games with houses capped at 32, where the housing shortage is a weapon?

## Tags

[games](../../../tags/games.md) · [simulation](../../../tags/simulation.md) · [game-theory](../../../tags/game-theory.md) · [youtube](../../../tags/youtube.md)

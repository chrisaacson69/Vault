---
status: active
created: 2026-11-08
discussion: pending
---
# Ticket to Ride — Perfect Play vs Board Odds (+ Perfect Play's Minesweeper)
> The two channels agree on the small rules: **skip the face-up locomotive, don't grab routes indiscriminately, don't rush the ending, and draw extra tickets only with trains to spare.** They split on the big one. Perfect Play's card hoarder, which takes only cards for 21 rounds and then lays long routes, wins 83% against its regulars, while Board Odds says "long routes are not a plan; tickets are." The video itself shows why the hoarder wins: **it ends the game at round 30 against bots pacing for round 41.** It is a clock exploit of one opponent model, and the channel's own counter-tests (Fast Builders, long-route tables) shrink it to 1 in 10 and 32%. Minesweeper is Perfect Play only and has no counterpart here.

**Source:** [Perfect Play — "I Made 13 Ticket to Ride Strategies Fight for 200 Million Games"](../../../raw/videos/2026-11-07%20perfect-play-ticket-to-ride-13-strategies.md) — <https://www.youtube.com/watch?v=E05MAjOyEaI> (13:21, 2026-11-07; auto-captions)
**Source:** [Board Odds — "The Best Ticket to Ride Strategy, Tested on 100 Million Games"](../../../raw/videos/2026-11-07%20board-odds-ticket-to-ride-100m-games.md) — <https://www.youtube.com/watch?v=b5Mtpd-a5I8> (15:40, 2026-11-07; auto-captions)
**Source:** [Perfect Play — "The Best Minesweeper Strategy, Tested on 600 Million Games"](../../../raw/videos/2026-10-16%20perfect-play-minesweeper-600m-games.md) — <https://www.youtube.com/watch?v=NXHu0n9Ezco> (8:23, 2026-10-16; auto-captions)

**Links:** [Simulation channels hub](./README.md), [Hollow Opponent, Perceived Depth](../hollow-opponent-perceived-depth.md), [Wordle — Solved](../wordle-solved.md) (another exactly solvable guessing game)

---

## Setups

| | Perfect Play | Board Odds |
|---|---|---|
| Rules | "2025 box", 4 players, 45 trains; map not stated [0:53] | USA base map, 36 cities, 100 routes, 30 tickets; 3 starting tickets, keep ≥2 [1:13–2:21] |
| Baseline | "regular": keeps ~5 tickets, scores ~110 in ~41 rounds, **calibrated to real 4p scores** [1:35] | "Normal": keeps its 2 cheapest tickets, never takes a face-up locomotive; scores 92.6, uncalibrated [2:23, 11:38] |
| Plans | 13 plans from guides and a 2022 Leiden thesis, each search-tuned vs regulars [2:01–2:31] | 18 single habits vs 3 Normals, 4M four-player games each; an expert from a 16-combination scan [3:00–3:21] |

## Where they agree

- **Skip the face-up locomotive.** Board Odds: always taking it 12.57%, conditional 15.55% [4:46–5:45]. Perfect Play: better or tied at every table, +4 for the regular [10:40]. It costs a whole turn for one card.
- **Grabbing any route loses.** Board Odds' worst habit is "grab any route of ≥4 trains" (11.37). Perfect Play: grabbing anything, even 1s and 2s, costs wins [11:45].
- **Rushing loses.** Board Odds: rushing at 12 trains left 16.05, with 1.22 failed tickets a game [12:06].
- **Ticket draws are conditional.** Drawing after every finished ticket 15.06, never drawing 17.85 (Board Odds). Perfect Play: mid-game draws pay only with trains to spare [10:56].
- **Both admit their bots never block**, so hoarding is probably overrated against people.

## The hoarder

- **Plan:** keep the 2 cheapest tickets, take only cards for 21 rounds (up to 46 in hand), then lay about seven 5–6 train routes [3:41–4:43].
- **Result:** 83% vs regulars, 87 after tuning [2:57–3:06], **while scoring only about 92**.
- **Mechanism, from the video itself:** the game ends around round 30 instead of 41. Regulars stopped at round 30 have 51 points; with the hoarder at the table, 55. A draw-only control does about the same: "the clock, not the routes" [4:38].
- **Counters:** three Fast Builders hold it to 1 in 10 [7:56]. On a long-route table it wins 32% [5:41]. Against real winners in the worst case, a 92 beats about 5 of 100 [6:58].
- **Perfect Play's robust answer:** draw until about round 18, then keep and finish 2 tickets: 78% vs regulars, the only plan above 50% at all 7 tournament tables [9:15–9:46].

## Where they disagree

- **Long routes.** Perfect Play's Long Hauler wins 52%; Board Odds' route grabber gets 16.77. Perfect Play's plans are tuned and its regulars are slow. Board Odds never tested hoard-then-long-routes with tickets dropped.
- **Ticket ambition.** Perfect Play: keeping all starting tickets costs wins everywhere. Board Odds: keeping all 3 is +8.6 and keeping the highest-value ones +12.4. But Board Odds' baseline keeps the 2 *cheapest*, so "keep more" is measured from a deliberately thin start. Perfect Play's "four starting tickets" [10:58] may be an edition difference or a caption error.
- **"Expert"** means unrelated bots: 32.5% (Perfect Play) vs 55.51% (Board Odds).

## Minesweeper (Perfect Play only)

Expert board, modern first-click rule, 10M games per player [0:48, 2:40]. Rookie under 2%, corner starter 23, regular 29, counter 32, explorer 33, **odds player 39**, perfect machine 51 [2:46–3:04]. Learning the 1-1 and 1-2-1 patterns is worth 15× the wins [3:19]. Of the ~10-point gap between the best human-style player (41%) and the machine, 4 points are logic and 6 are exact-odds guessing [7:09–7:30]. Validation was on the classic first-click rule (35.58% vs a 2017 paper's 35.56%), not the modern rule used for results [1:01–1:16].

## Open Questions

- Does Board Odds' Normal pace its games like real players? It reports no game lengths, and pace is the variable the hoarder result hinges on.
- Is Perfect Play's map the USA base map, and does the 2025 box change starting tickets?

## Tags

[games](../../../tags/games.md) · [simulation](../../../tags/simulation.md) · [game-ai](../../../tags/game-ai.md) · [youtube](../../../tags/youtube.md)

---
status: active
created: 2026-11-08
discussion: pending
---
# Clue — Board Odds' Monte Carlo vs the Deduction Videos
> Chris's observation: the other Clue creators "didn't take the Monte Carlo approach, but probably a better mathematical approach." **On deduction that is right.** Let's Get Into It writes down a near-complete set of constraint rules (two-way card counts, one-per-category case-file rules, rescanning after every fact), and What's What adds proof by contradiction across several tags at once. Board Odds' best bot, as described, uses a simpler rule set. **But Clue is not only a logic puzzle.** It is an N≥3 deduction race, and only Board Odds measures what the race rewards: accusation timing pays against note-takers (+16 points) but almost nothing against experts (+0.7), seat order is worth about 8 points, and hiding cards is worth zero. The deduction videos' "win every time" claims are unmeasured, and nobody defines perfect play. Two incomplete halves: the inference engine and the evidence about what it's worth.

**Source:** [Board Odds — "The Best Clue Strategy, Tested on 50 Million Games"](../../../raw/videos/2026-10-23%20board-odds-clue-50m-games.md) — <https://www.youtube.com/watch?v=PhFmMADbL3A> (13:29, 2026-10-23; auto-captions)
**Source:** [StrataGames — "How to Win at Clue Every Time!"](../../../raw/videos/2020-03-30%20stratagames-win-clue-every-time.md) — <https://www.youtube.com/watch?v=dtnrpmwD9Ao> (4:33, 2020-03-30; auto-captions)
**Source:** [Let's Get Into It — "How to win Clue … Coding a Clue Solver" (#SoME3, ep. 1)](../../../raw/videos/2023-08-17%20lets-get-into-it-coding-a-clue-solver.md) — <https://www.youtube.com/watch?v=ijkDbdlpY6c> (18:35, 2023-08-17; auto-captions)
**Source:** [What's What — "How to Win Clue (Cluedo) the Fastest"](../../../raw/videos/2023-09-22%20whats-what-win-clue-fastest.md) — <https://www.youtube.com/watch?v=wd6u_xwaYpo> (8:28, 2023-09-22; auto-captions)
**Source:** [What's What — "You are playing CLUE wrong: Use the Number System"](../../../raw/videos/2026-07-16%20whats-what-clue-number-system.md) — <https://www.youtube.com/watch?v=g_F5H7sYd3Y> (5:21, 2026-07-16; auto-captions)

**Links:** [Simulation channels hub](./README.md#thesis--chess-not-chutes-and-ladders), [Guess Who](./guess-who.md) (the 2-player deduction game, solved exactly), [Computation and Information](../../computation-and-information.md) (the Minesweeper non-locality argument: local rules miss chained constraints), [Randomness as the Termination Mechanism (N≥3)](../n3-termination-and-randomization.md)

---

## Board Odds: a ladder of deduction layers

324 possible solutions, 3–6 players, dice movement on the creator's own simplified board ("not the official board"); 50M games [1:03–2:10]. Each bot adds one layer to the one before:

| Bot | Adds | 4-player tournament | vs three note-takers |
|---|---|---|---|
| Casual | ticks only cards it is shown | 0.0% | — |
| Note-taker | who *couldn't* disprove | 18.1% | 25.0 (control) |
| Detective | who showed to whom, cross-referenced | 29.4% | 39.4 |
| Hider | re-shows a card the guesser has seen | 29.5% | 39.3 |
| Gambler | accuses at two combinations left | 34.7% | 41.2 |
| Expert | hand sizes, own cards and known cards as anchors, asks about its least-certain card | **38.3%** | **47.7** |

[2:46–4:01, 4:44–7:48, 9:19, 11:16]

- **The value of a strategy depends on the opponents.** Against three detectives the hider and detective drop to 25.0% and the expert to 30.9% [9:31–9:40]. Against three experts the gambler's coin flip is worth 0.7 points [11:49–11:58].
- **The expert's edge grows with table size:** 44.4% at 3 players (1.3× fair share), 50.8% at 5 (2.5×), 52.7% at 6 (3.2×) [8:01–8:24].
- **Seat order:** 29.6 / 28.1 / 21.3 / 21.0% for seats 1–4, about the step from detective to expert. Median game: 7 rounds [10:12–10:31].
- **Stated limits:** bots never lie or forget, there are no tells, and the expert's tactics are "not … the best possible" [2:15–2:31, 13:09–13:21].

## The deduction videos

| | Unseen refutations (tags) | Card count, both ways | Case-file category rules | Multi-tag contradiction | Suggestion choice |
|---|---|---|---|---|---|
| StrataGames | yes [1:18] | yes [2:28–3:00] | — | — | none |
| Let's Get Into It | yes, with a suggestion log [10:43] | yes [15:50] | yes [16:14] | admits its rules "can't get everything" [17:40] | none |
| What's What (fastest) | yes [1:19] | yes [3:11–3:30] | row rule [3:31] | **yes, the "fallacy"** [6:07–7:12] | anchor known cards, probe one unknown [4:52–5:33] |
| What's What (number system) | yes, "elimination, not suspicion" [2:31] | — | — | deferred | none |
| Board Odds' expert, as described | yes [3:05] | one way only [7:20–7:28] | not stated | not stated | anchor and probe the least-certain card [3:55] |

- **Only StrataGames uses the all-pass inference.** If nobody can disprove, the three cards are in the suggester's hand or the envelope [2:01–2:24].
- **Let's Get Into It has the most complete written procedure:** process each suggestion, rescan after every new fact, and apply row, column and case-file rules in both directions [13:27–16:53]. It still says the rules are incomplete. That is Chris's non-locality point again: local rules miss constraints that chain across the grid.
- **What's What's "fallacy"** is reasoning across hand size and several tags at once. Peacock's three cards must cover tags 1–4, so the dagger is impossible [6:07–7:12].
- **Showing policy.** What's What says to protect rooms, because they are costly to visit [4:13–4:33]. That is untested. Board Odds tested a different policy (re-showing the same card) and found it worth nothing against careful players.

## Verdict on "a better mathematical approach"

- **True for inference.** The deduction creators describe stronger constraint machinery than Board Odds documents for its best bot. Board Odds never mentions the inverse card count, case-file rules, the all-pass inference or multi-tag contradiction. Whether its code does them is unstated, so this rests on what it leaves out.
- **Not information theory.** No one computes information gain. The suggestion advice in What's What and Board Odds' expert is the same heuristic: anchor with known cards and probe one unknown.
- **The race is the half the math leaves out.** When to accuse, what to show, seat order and table size all change the result, and only Board Odds measures them. "Win every game in three or four turns" (What's What [0:11]) and "every time" (StrataGames' title) are unmeasured.
- **Nobody defines perfect play.** It would need complete deduction *and* the race decisions (accusation timing against the opponents' progress), which is the hub thesis once more: the move depends on the position, here how close the others are to solving.
- **Combined:** the most complete inference engine from the math side plus Board Odds' race measurements is the best available picture. Neither alone gives perfect play.

## Open Questions

- What is Let's Get Into It's later episode's answer to "these rules can't get everything", and does it reach full constraint satisfaction over the 324 solutions?
- How much would full deduction (the Let's Get Into It rule set plus contradiction) add over Board Odds' expert in the same simulation?
- Chris notes at least four more Clue videos take the mathematical route; they are not captured here.

## Tags

[games](../../../tags/games.md) · [game-theory](../../../tags/game-theory.md) · [simulation](../../../tags/simulation.md) · [youtube](../../../tags/youtube.md)

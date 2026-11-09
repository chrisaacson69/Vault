---
status: active
created: 2026-11-08
discussion: pending
---
# Risk — Perfect Play vs Board Odds
> The two channels appear to disagree about Australia: Perfect Play's turtle wins 44.8%, while Board Odds calls it a trap (27.8% against ordinary players, behind South America's 41.6%). **The disagreement is a rules difference.** Perfect Play drafts territories and Board Odds deals them, and Perfect Play's own dealt-territory test drops the turtle to 24.5%. Under a deal, Australia's single entrance stops paying, and Board Odds shows its scripted follow-up into Asia costs another 8 points. The dice layer is solid on both channels: Board Odds' battle odds match the vault's exact solver to the decimal.

**Source:** [Perfect Play — "The Best Risk Strategy, Tested on 128 Million Games"](../../../raw/videos/2026-10-22%20perfect-play-risk-128m-games.md) — <https://www.youtube.com/watch?v=h5k-Q-zsa94> (8:49, 2026-10-22; auto-captions)
**Source:** [Board Odds — "Is Australia a Trap? I Played Risk 1 Million Times"](../../../raw/videos/2026-10-20%20board-odds-risk-australia-trap.md) — <https://www.youtube.com/watch?v=z9V-y4LWAjY> (25:25, 2026-10-20; auto-captions)

**Links:** [Simulation channels hub](./README.md), [Risk — The Attrition Constant](../risk-attrition-odds.md), [The Multiplayer Coalition Problem](../multiplayer-coalition-problem.md), [`tools/risk-battle-odds.py`](../../../tools/risk-battle-odds.py)

---

## Setups

| | Perfect Play | Board Odds |
|---|---|---|
| Rules | 1993 edition; **territory draft** [0:37–0:41] | classic; **territories dealt**, 30 armies each [1:56] |
| Cards | 4, 6, 8, 10, 12, 15, then +5 [0:52] | same; "simplified a little" [22:02] |
| Fortify | limited (chain fortify tested as a variant) [5:21] | once, to an adjacent territory |
| Baseline | "regular": attacks at ≥ equal armies, finishes the nearest continent [1:44–2:01] | "opportunist": chases the cheapest continent; every bot looks up exact odds before attacking [2:44–3:51] |
| Design | 8 bots, 70 four-player tables × ~250k [2:32] | 600k random 4-of-12 games; 20k per plan vs 3 opportunists [10:13, 13:46] |
| Validation | 11 vs 10 = 56.8% from a 2003 table [1:07] | exact enumeration and a whole-battle solver to 150 armies, plus 1M-roll MC [4:32–6:23] |

## Independent check

Our [`risk-battle-odds.py`](../../../tools/risk-battle-odds.py) (absorbing Markov chain, documented on [Risk — The Attrition Constant](../risk-attrition-odds.md)) gives 5v5 **50.62%**, 10v10 **56.76%**, 20v20 **63.34%**, 9v10 **47.99%**, 13v10 **78.68%**, 16v10 **90.70%**. Board Odds quotes 50.6, 56.8, 63.3, 48, "13 for 75%" and "16 for 90%" [6:23–6:53]. Both channels' 56.8% is the same 10-rolling-armies-vs-10 case. Run 2026-11-08.

## Results

- **Perfect Play tournament (fair 25%):** Australia turtle 44.8, North America 27, South America / Blitz / Regular ~23–24, Card Hoarder 21.5, No Continents 19.5, Europe+Africa 15.6 [2:41–2:58].
- **Board Odds tournament:** North America 38.9, South America 36.7, Australia 35.6, Africa 28.6, Opportunist 26, … Europe 16.5, Random 4.7 [10:35–11:55].
- **One plan vs three baselines:** Perfect Play's regular pointed at Australia 43.8, at Europe 10.8 [3:50]. Board Odds: South America 41.6, North America 39.6, Africa 33.8, Australia 27.8, Europe 14.4, Asia 12.1 [13:49–14:32].

## Where they agree

- **Europe and Asia are the worst targets** on both channels.
- **Card hoarding costs about 1–1.5 points**, and attack-threshold or border-thickness tweaks move results by only a few points.
- **Games are short:** median 11 rounds vs half within 13.
- **Seat 1 has an edge** (stronger under a draft: 40 vs 28 at three players on Perfect Play).
- **Australia gains relative value at bigger tables** on both.

## The Australia dispute, resolved

1. **Draft vs deal.** Perfect Play: "deal the territories out … and the turtles' edge is gone. 24.5% against about 25 for each regular" [4:47–4:53]. Board Odds deals every game. Under a deal you hold all of Australia at the start only 1 time in 339 [9:21].
2. **What happens after Australia.** Perfect Play's turtle sits behind its door. Board Odds' Australia plan pushes into Asia by script; switching its second target to South America lifts it from 27.8 to 36.2 [14:57–15:20], still behind South America-first.
3. **Perfect Play's regulars may leave Australia uncontested** in the draft (they draft where they already hold most of a continent), so part of its 44.8% comes from opponents who undervalue it.

**Net:** Australia is strong when you can take it cheaply (a draft against bots that don't contest it) and then sit. Under random deals it is an ordinary continent with a bad exit.

## Other findings

- **Multiple turtles self-destruct.** Two turtles and two regulars: 8% per turtle, 42% per regular. Four turtles: median game 182 rounds [4:21–4:44].
- **The tuned Perfect Play player** (Australia, 5:4 attacks, hunts card holders) wins 48% against three regulars, but a lone regular wins 82% against three copies of it [6:36–7:20].
- **Board Odds' fight-choice ablation:** choosing fights at random (from those with at least 3-in-10 odds) drops the opportunist to 0.2% [16:26–17:53]. Fight selection is the whole game for these bots.
- **Bonus per border territory** (Board Odds): Australia 2.0, North America 1.67, Asia 1.4, Europe 1.25, South America and Africa 1.0 [7:20]. South America ranks fifth on that ratio yet first in results, so the ratio alone doesn't explain the ranking; neither channel says what does.

## Caveats

- No alliances, truces or ganging up on the leader on either channel, and a visible Australia stack is exactly what a human table gangs up on.
- Perfect Play's attack rule counts armies rather than using odds, and its turtle's "big edge" is never quantified.
- Board Odds' plans follow fixed target lists.

## Open Questions

- Does the [attrition page](../risk-attrition-odds.md)'s "stability decays as players are eliminated" show up in these channels' game-length data?
- South America vs Australia under a draft with odds-aware opponents was never run by either channel.

## Tags

[games](../../../tags/games.md) · [simulation](../../../tags/simulation.md) · [game-theory](../../../tags/game-theory.md) · [youtube](../../../tags/youtube.md)

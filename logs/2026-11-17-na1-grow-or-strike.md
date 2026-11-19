# Session log: NA1, grow or strike, the economy floor, and the mid-game stall (2026-11-16 to 17)

Continues [the pocket planner](./2026-11-16-na1-pocket-planner.md). Chris: *we were trying to solve NA1 at skill 3, but the opponents are growing faster than us, so we often stagnate. Tune the fief planner to expand sooner by forgoing growth. How much econ can we give up without putting us at risk? Tackle it at level 1 first to nail down principles; it is context-sensitive.* The numbers are in **`na1-decompiler/docs/synthesis-frontier.md` #61**; this is the map.

## What happened
- **The uniform dial** (`--topped`, skill 1, 340 games): tempo pays until about 0.6 of the AI's economy at year 20, then a cliff (178 unified at 30% topped, 117 at 15%, 86 at 0%). Survival keeps rising as unification falls: hiring everything makes you hard to kill and unable to win.
- **Chris's metric:** P(win), not the fastest unification found by EV, which argues for a safer approach. So pick the middle of the plateau, not the peak: the edge moves with skill, start and shocks. Plague (#46) is fatal only while you hold one fief, so the risk belongs to the one-fief to two-fief step.
- **Chris's earliest-X planner** (`expand.STRIKE`): *we know every neighbour's growth and what we can afford; decide grow vs hire by whatever makes the invasion time X smallest.* The first version banked gold and deadlocked: it planned strikes that the safety check never approved (107-123 unified against 155). Chris: *the player should not be banking at all.* Without banking, and with the safety check made the planner's own verdict: skill 1, 167 against 155 at an unchanged economy (0.77 vs 0.76); skill 2, 47 against 32; skill 3 still 0.
- **Tolerance** (the state a new fief may be left in, keyed on fiefs held): neither longer games nor more losses. Chris asked why, and said to tally specifics. Walking Owari through skills 1-3 with a per-game event tally showed three things. Fiefs are not traded back and forth (1-4% churn). The dial covers one or two attacks a game. And the battle sets its own tolerance: 6/15/18% of conquests end HUNTABLE or COMING under SAFE-only rules, because the forecast used the mean survivors and a battle has a long low tail.
- **Sizing for a bad battle** (battle-lab quantiles, `KEEP_Q`): it fixes the churn (non-SAFE conquests 14% → 1% at skill 2) and loses games (40 → 24-37). The optimistic forecast was a good risk tolerance, as Chris argued: a low-odds conquest still pays.
- **The tempo reading, tested** (`na1sim.tempo`, paired on the same start and seed): **a deadline at about year 12, not a slope.** Earlier buys nothing before it; missing it halves the win rate. Chris: *age is a hard cap, but it cannot force an earlier start; if a 41-year-old can start early, why not a 20-year-old?* Checked: the late openers lose to **mid-game stalls**. They peak at about 9 fiefs around year 30 against 3-4 consolidated rivals, slide back, and the lord dies of age (1,390 of 1,417 such losses at 69+). The original complaint, placed: it is the mid-game, not the opening.

## Tools
- `expand.STRIKE` (earliest-X, save vs grow, targets' growth projected; `strike_ok` = `score`'s verdict), `--tol EARLY,LATE,N`, `--hold`, `expand.KEEP_Q` / `--keep-q`.
- `long_game` returns a per-game tally (every real attack with the prize's state; every fief lost). `skill_lab --quantiles --out keep_q.json`. `na1sim.tempo` (pooled, in-start and paired cuts by first-conquest year).

## Commits
na1-decompiler `main`, pushed: `9eb1fb0`, `5d1a7b2`, `582e3dc`, `db64bdf`, `913dacc` (#61). Vault: this log, the [margin page](../research/gaming/margin-sets-player-intelligence.md) (grow-or-strike section, its tempo question resolved), a pointer on [risk and entrepreneurship](../research/economics/risk-and-entrepreneurship.md).

## Open
- **Next: the mid-game combined attack** on the stalled games (about 9 fiefs, 3-4 rivals left). Chris named two kinds: **several fiefs on the same turn** (the order fiefs act in matters), and **the same fief over several years** (you need not win at once, but the enemy may recover faster).
- A time-clock risk dial, only after that.
- Carried over: the Hatakeyama pact test (#49); the unexplained rice +56; the ev odds table measured at skill 1.

Continued in [the empire planner and MIRR](./2026-11-18-na1-empire-planner.md) (#62-#70).

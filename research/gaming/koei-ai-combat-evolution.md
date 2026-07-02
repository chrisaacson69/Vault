---
status: active
created: 2026-06-30
---
# How KOEI's NES AI & combat resolution evolved — a five-decompiler study

> Reading the decompiled code of five KOEI NES strategy games in the same engine family — ROTK1, NA1,
> NA2, Genghis Khan, ROTK2 — lets us *trace* (not guess) two design questions across the corpus: **does
> the AI play by the same rules as the player**, and **how is a battle resolved when it isn't shown on
> the tactical map**. The answer to the first is "yes, from the start"; the second is a *speed↔fidelity
> knob KOEI kept re-setting* — the off-screen model alternates across the lineage, the signature of a
> studio *experimenting* with its AI throughout, not climbing a single upgrade curve.

**Links:** [The Dead-Verb Test — does KOEI learn?](./dead-verbs-mechanism-viability.md) (this is the
combat-side answer to its cross-series scorecard) · [The Hollow Opponent](./hollow-opponent-perceived-depth.md)
(NA1's strategic AI decoded as shallow — complements the combat layer here) · [NA1 crucible](./nobunaga-crucible.md)
· grounded in named functions per game (the five `*-decompiler` repos' `docs/04`+`docs/06` + source).

## The corpus + the dating (read first)
All five share one 219-opcode bytecode VM (a family-invariant engine). We decompiled the **US/NES ROMs**,
which are localizations of KOEI's **Famicom** ports — but for the *design* question ("how did the AI
evolve") the meaningful clock is the **original-computer release**, i.e. when KOEI actually designed each
game's systems; the port is just the re-implementation we happen to be reading. Watch the two pitfalls:
the repo names `na1`/`na2` are *decompiler-project* numbering, **not** series order, and "original game"
≠ "the game we decompiled" — the US "Nobunaga's Ambition" we read is the **Zenkokuban** (computer 1986),
and "Nobunaga's Ambition II" is **Sengoku Gun'yūden** (computer 1988), *not* the 1983 original.

On the design clock the five line up as a near one-per-year sequence:

| repo | game decompiled | **original computer** | Famicom port (our ROM's parent) |
|---|---|---|---|
| `ro3k` | Sangokushi (ROTK1) | **1985** (Dec 10) | 1988 |
| `na1` | Nobunaga no Yabō: **Zenkokuban** | **1986** | 1988-03-18 |
| `gk` | Genghis Khan | **1987** | 1989-04-20 |
| `na2` | Nobunaga no Yabō: **Sengoku Gun'yūden** | **1988** | 1990 |
| `rot3k2` | Sangokushi II (ROTK2) | **1989** | 1990 |

Dates are arguable at the margin (computer vs Famicom vs NES all differ by 1-3 years), **but the point is
robust to that argument**: on *either* clock the off-screen combat model is *non-monotonic* (Finding 1),
so the headline isn't "the AI got steadily better" — it's that **KOEI was visibly *experimenting* with
the AI throughout the lineage**. (Sources: Wikipedia *List of Koei games* + per-title articles,
Koei Wiki, superfamicom.org, 2026-06.)

## Finding 1 — off-screen battle resolution is a speed↔fidelity knob, set by sub-series
"Off-screen" = an AI-vs-AI or unwatched battle that doesn't run the player-visible tactical grid. Three
distinct strategies appear across the family:

| game | strategy | mechanism (grounded) |
|---|---|---|
| **ROTK1** | **(0) no abstraction** — always the full sim | every War runs the 30-day tactical loop `run_30_day_battle_turn_loop $8F06`; no separate resolver found. Per-cell odds from `province_strength_score $B9CC` (troops·10 + arms + training). |
| **NA1** | **(1) one-shot strength compare** | `resolve_siege_assault_outcome $8DFD`: `strength = men·(2+bonus) + arms + skill + morale + 10% to higher-Drive; higher wins`. **No incremental casualties** — loser splits, winner absorbs half. |
| **NA2** | **(1) one-shot power compare, RNG-free** | `determine_battle_victor $ACE4`: `Σ war×soldiers/100, leader ×3`, higher side wins; deterministic, **no RNG**. Fixed-% attrition: winner keeps 60%, loser 10%. |
| **GK** | **(2) cheap round simulation** | `resolve_battle $947C`: day-budget loop (`−3/round`) over `resolve_battle_round`; power sum → `win_probability_percent`; casualties **quadratic in loser share** (`muldiv(swing, e², s²+e²)`) — the side losing the odds bleeds disproportionately. |
| **ROTK2** | **(2) cheap round simulation** | `simulate_field_battle $B0BB`: up to **6 rounds**, each `power=(rng×4-6)·Σ(loyalty/4+morale/3+intel/2+war)·(troops/100+1)/50`, attrite by `power_a·100/(a+b)` ratio per round, early-exit at 0. |

**All three strategies coexist — and on the design clock they *alternate*, which is the signature of
experimentation, not a climb.** Ordered by original-computer year:

> ROTK1 '85 **full-sim** → Zenkokuban '86 **one-shot** → GK '87 **round-sim** → Sengoku '88 **one-shot**
> → ROTK2 '89 **round-sim**

KOEI built the full 30-day sim, abstracted it to an O(1) verdict, *invented* the cheap round-sim in GK,
**went back** to the O(1) verdict for Sengoku Gun'yūden, then returned to the round-sim for ROTK2. That
back-and-forth is a design space being *explored*, not a ladder climbed. Two real sub-patterns ride
underneath it: the speed↔fidelity knob is genuine (O(1) verdict vs iterated attrition — the round-sim is
the sweet spot between a coin-flip and the full grid), and choices **cluster by sub-series** (the two
*Sangokushi* games went full→round; the two *Nobunaga* games both stayed one-shot, '88 just dropping the
RNG; GK is the round-sim's origin, which ROTK2 inherits). But the headline is the alternation itself.

## Finding 2 — "the AI plays by the same rules" was foundational; the handicap moved out of combat
In **every** game the AI executes through the player's own effect/resolve math — it cannot cheat the
formulas. What *varies across the family* is how much code is literally shared (and it doesn't track the
calendar cleanly either — back-to-back Sengoku '88 and ROTK2 '89, yet ROTK2 reuses the player's exact
driver while Sengoku/NA2 keeps a *separate* AI bank — experimentation in the integration strategy too):
- **ROTK1**: one turn driver `province_turn_driver_player_or_ai $82A0` for both; shared resolvers
  (`resolve_officer_action_outcome_by_mode`), only the decision *source* differs.
- **NA1**: AI develops via the player's `effect_dam`/`effect_grow` "on the same lossy curve, **not a
  cheat**"; trades on the same market table.
- **NA2**: shares the `apply_*` effect engine but dispatches through a *separate AI bank* (player→5/6/7,
  AI→4). "AI and player share the rules engine."
- **GK**: AI farcalls the *same bank-2 dispatcher table* the human menu drives ("no separate AI command set").
- **ROTK2**: AI reuses `run_command_march` — the player's *exact* command driver, end to end (the tightest).

But "same rules" ≠ "symmetric" early on. **ROTK1 has an explicit combat handicap** —
`province_strength_score` adds `(players−1)<<4` strength to every non-player province (plus ±4·(players−1)
on recruit/persuade). The later games **move the AI's edge out of combat**: NA1's advantage is
"subsidy + action-economy, not a combat cheat"; NA2's off-screen victory is deterministic and symmetric
(no RNG, identical power sum both sides); GK's difficulty "tunes the economy, not the core thresholds
— easy is a player boost, not a dumber AI." So the *fairness of combat itself* improved: a combat
handicap (ROTK1) → handicaps confined to economy while the battle math is symmetric (NA1→ROTK2).

## Synthesis — a studio experimenting, not climbing
The throughline is **continuous experimentation with the AI**, toward (but never settling on) a fairer,
less black-box opponent. Three grounded observations, all robust to the dating argument:
1. **Off-screen combat fidelity *alternates*** — full-sim ('85) → one-shot ('86) → round-sim ('87) →
   one-shot ('88) → round-sim ('89). The speed↔fidelity knob (O(1) verdict vs iterated attrition) is
   real and the round-sim is the sweet spot, but KOEI kept *re-deciding* which way to set it — that's
   exploration, not a monotonic upgrade. (Choices also cluster by sub-series; GK is the round-sim's
   origin, inherited by ROTK2.)
2. **The AI's integration with the player's code also got re-tried**, not steadily tightened: from
   shared-resolvers-separate-decision (ROTK1) up to the AI running the player's *exact* driver (ROTK2),
   but with Sengoku '88 stepping back to a *separate* AI bank in between. The invariant underneath is
   firm: in every title the AI executes the player's own effect/resolve math — it never cheats the formulas.
3. **The handicap migrated out of the visible battle.** The one *explicit combat* handicap we found sits
   in the earliest title (ROTK1's `province_strength_score` +(players−1)<<4); later titles keep their
   edge in the *economy* (subsidy + action-economy) and leave the battle math symmetric — so the part
   the player watches reads as fair.

This is the payoff of decompiling the whole family: you can watch a studio *work a problem* — make a
strategy AI competitive *and* believable on 8-bit hardware — across roughly 1985-1989 of design (ported
to Famicom 1988-1990). The honest shape isn't "they got better every year"; it's **they experimented
throughout** — re-trying the combat sim and the AI-integration each title — with a steady *direction of
travel* (same formulas as the player; hide the handicap in the economy; make the off-screen fight feel
like a fight). That is exactly the ROTK2-walk hunch, refined: a design *disposition* pursued by trial,
not a clean upgrade curve.

## Extension (2026-07-02) — games 6–7 move the experiment to the *tactical* layer
The study above is the five historical-sim titles. Two more of the family have since been decompiled —
**BK** (Bandit Kings, game 6, the NA2 MMC5 twin) and **Gemfire** (game 7, 1992, KOEI's first *fantasy*
title) — and Gemfire is where the experimentation visibly shifts from the *off-screen resolver* to the
**tactical battle design itself**.

**Off-screen model (a Gemfire row for Finding 1): round-sim — and it's the *same code* as the tactical
fight.** `resolve_strategic_round $8234` is a squared-ratio Lanchester `p²/(p²+q²) × rng(80–120%)`; the
tactical `resolve_melee_attack` is the *same* `p²/(p²+q²) × rng(90–110%)`, and both feed on
`side_strength $8AF5 = soldiers/10 + 1` with **no per-type term**. So Gemfire doesn't *alternate* the
speed↔fidelity knob — it **collapses** it: the "off-screen" battle is literally the tactical resolver run
headless (bank 8 picks the full tactical fight if a human is on either side, else the round-sim). The
round-sim wins outright, and the two combat surfaces become **one model wearing two presentations**.

**New axis — variance without stat-bloat.** With combat power held flat (soldier count only), Gemfire
puts all the *interest* into **geometry + one exotic slot**, never a stat table:
- **Role is fixed by formation slot, not stats** — `is_ranged_unit` switches on `unit_idx % 5` (slots 1,3
  ranged, 0,2 melee); the four standard units differ only in reach (adjacent vs a few-cell raycast in
  `can_reach_target`) and move budget.
- **Slot 4 is the only *typed* slot** — the **Fifth Unit** is the sole place a real `unit_type` enters,
  carrying the exotic range (`unit_type_table +16`: Dragon 14, Fachan 15), flight (`move_unit_along_path`
  special-cases types 7/12 = Gargoyles/Wyvern to bypass obstacle cells), and spell reach. It's "powerful
  if you control the right things, otherwise just more — but with style."
- **The battle got shorter and positional** — `run_battle_rounds` is a **5-round × 4-turn** box won by
  side-wipe or leader-kill (`check_side_wiped` / `check_leader_defeated`): a capture-the-flag scenario,
  not BK's 30-turn attrition grind.

On a *proven* engine (RoT3K2's ROM-shape twin, VM transferred with zero code changes) KOEI kept the
balanced attrition core and the one-ply strategic AI untouched, and spent the whole design budget on
**one new variance axis (the Fifth Unit) + a shorter, position-driven fight** — the low-risk way to make
a fantasy reskin feel new. The principle: **decouple *interest* (geometry + one exotic slot) from *power*
(flat soldier count).** It's the same disposition as Finding 1 — experiment on the *presentation* of
combat while leaving the symmetric math alone — just aimed at the tactical layer instead of the off-screen one.

*Next thread:* go title-by-title to catalog what **distinguishes** each game (not only the shared
evolution) — Gemfire's "variance in geometry + one Fifth-Unit slot / capture-the-flag battle" is the
first such per-game signature. Grounded in [`GemFire-decompiler`](https://github.com/chrisaacson69/GemFire-decompiler)
`docs/06-combat-overview` · `docs/07-tactical-engine` · `docs/08-battle-fx` · `docs/schema`.

## Method
Grounded by reading each repo's decompiled C + `docs/` chapters (one focused agent per game, citing
named functions); ROTK2's numbers verified directly in `simulate_field_battle`/`calc_province_military_
power`. Dating was checked against Wikipedia's *List of Koei games* + per-title articles (original-computer
years 1985-1989; Famicom ports 1988-1990) — but it stays the *soft* layer on purpose: the thesis
(experimentation, non-monotonic combat model) is the same whichever clock you pick, so no claim here
rests on a strict timeline.

## Tags
[koei](../../tags/koei.md) · [game-ai](../../tags/game-ai.md) · [reverse-engineering](../../tags/reverse-engineering.md) · [nes](../../tags/nes.md)

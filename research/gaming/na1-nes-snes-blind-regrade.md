---
status: active
created: 2026-07-16
---
# NA1 NES ↔ SNES — grading two blind reverse-engineerings

> Nobunaga's Ambition was reversed twice, independently: the **NES** original as a bytecode-VM
> title (`na1-decompiler`, emulator-certified) and the **SNES** port as native 65816
> (`na1-snes-decompiler`). This is the *grade*: reconstruct the game's architecture and formulas
> from the SNES code **alone** (treating the NES work as unverified), then diff. Two binaries, two
> consoles, two execution models, two toolchains — and they agree on **every structurally-checkable
> fact and every derived formula**. That agreement is the "one C source, two compile targets" thesis
> proven the hard way.

**Links:** the native-port finding → [The one that isn't a VM](./na1-snes-native-port.md) · the AI
lineage → [KOEI AI & combat evolution](./koei-ai-combat-evolution.md) · the AI-depth thesis →
[The Hollow Opponent](./hollow-opponent-perceived-depth.md) · method → [[feedback_rederive_then_grade]],
[The Three-Layer Method](../karpathy-three-layer-method.md). Repos: `na1-snes-decompiler` (SNES),
`na1-decompiler` (NES oracle — used only to *grade*, never to derive).

## The method — create, then check (verification independence)

Two strict phases per section. **CREATE:** derive the section's structure + constants from the SNES
native code only, without opening the NES conclusions. **CHECK:** only once a claim is fixed, diff it
against the NES work — matches mutually validate, mismatches grade both. Feeding the NES answers in as
context would bias the re-derivation toward agreement and destroy the independence that makes the
cross-check mean anything. (Purest form of verification-independence = dropping to a lower, independent
artifact — here the second binary — not asking a second agent.)

## The scorecard — five sections, all converged

| Section | Key result | Grade |
|---|---|---|
| **Setup / world-gen** | 26-byte fief record (SoA parallel arrays); **1560 scenario data byte-identical** at twin ROM addresses (17-fief `$C3:903D`↔NES `$3:9258`; 50-fief `$C3:BB0D`↔NES `$3:B0BE`) | ✅ exact |
| **Economy** | Grow = `2·amt·(6−skill)/√(output+amt)`, √-diminishing + `(6−skill)` handicap + hidden loyalty/dams drain | ✅ **identical formula** |
| **Turn-start / events** | cadence `rng(2)`/`rng(4)`/`rng(40)<3`; illness `rng(400)<100−health`; **Fall (season 2) harvest**; Riot(loyalty) vs Revolt(morale) | ✅ all exact |
| **AI turn** | weighted-coin-flip cascade; weakest-adjacent-by-men-ratio; state-5 = human; difficulty lives in the constants; subsidized not skilled | ✅ all match |
| **Combat** | `(115−15·skill)` handicap (AI 100%, player scaled); casualties `pct_op(men,pct)+(pct≥50?1:0)`; **8-stat weight table `{5,5,10,10,10,15,20,25}` sum 100 → +40%**; 3 unit types (Rifles>Cav>Inf, +100% rank term) | ✅ identical |

Field map — **two orders, confirmed against the ROM scenario block** (`$C3:903D`, all 17 records
decode with `debt==0`, "noone starts in debt" as the alignment anchor). The **ROM scenario record is
header-first**: `koku(+0), gold(+2), debt(+4), town(+6), rice(+8), output(+10), dams(+12),
loyalty(+14), wealth(+16), men(+18), morale(+20), skill(+22), arms(+24)` — where the header field is
the **koku range** (it sets a recruit/income *range*, not a literal). The **RAM runtime record is
header-last**: `gold(+0), debt(+2), town(+4) … arms(+22), header(+24)` — the new-game loader rotates
koku from front to back. `men/morale/skill/arms` are stored **literally** in both, so pristine turn-0
troop counts *are* readable from ROM. (Care: comparing a live dump to this base
must use the **province** index on both sides — the ROM table's clan storage
order silently mis-pairs fiefs otherwise. Correctly aligned, a just-started
dump sits mostly within ~30% of base, up to ~2× where a fief has recruited or
lost — not the ~6× an *un*-aligned compare falsely shows.)

## What the port actually changed — and what it froze

**Changed (QoL / presentation):** sectioned command menus; explicit unit **icons + names**
(Infantry/Cavalry/Rifles — a 3-type system the NES *already had* but only exposed in its manual); a
single-image strategic map (vs paged); more scenarios; 10-byte name slots (NES 9). The RAM map carried
over almost verbatim — `game_year $2001`, difficulty `$2D63`↔NES `$6D63`, twin-address scenario tables.

**Frozen:** the *game*. Same formulas, same 8-stat combat table, same difficulty-as-handicap
(`115−15·skill` combat, `6−skill` economy — applied to the **player**, AI runs at 100%), same
weakest-neighbour AI. The **AI got no smarter across the hardware leap** — a 16-bit CPU with room for
search or lookahead still runs the 1986 weighted-coin-flip cascade. KOEI *chose* the shallow opponent;
it was a design philosophy, not a compute limit. "Not fair, but a challenge" — subsidy over skill.

**The one real architectural change — the combat resolver was unified.** The NES ran *two* battle
resolvers: the tactical sim, plus a cheaper **simplified auto-resolve** for off-screen AI-vs-AI battles
(bytecode-confirmed). The SNES has **one** — `run_turn`'s tactical sim is the only resolver;
`try_attack`/`execute_attack` are tactical-only (per-unit-contact), reachable solely via `run_battle`,
with no strategic aggregate shortcut (`$2E6B` queues nothing here). So SNES auto-resolve is the *same*
deterministic sim run **headless** — `anim_attack` + cursor boxes + VBlank waits skipped, math untouched.
Hardware-driven: the 6502 couldn't afford full tactical AI for every off-screen skirmish (hence the NES
approximation); the 65816 could, so the approximation was dropped. It's the lone place the hardware leap
changed the *engine* rather than the *presentation* — while leaving the AI and every formula frozen.

*Strategic consequence.* On the NES the two resolvers churned **different casualties** — the tactical
fight ground the loser down "to the man," auto-resolve was lax — so watching enemy battles was a near-
mandatory *weapon* (you watched to maximize a rival's losses; auto let them off easy). The SNES
unification removes that lever: identical casualties drawn or not, so `[Don't View]` is a pure time-save
at zero strategic cost. A player's sense that watching "does nothing" is independent behavioral
corroboration of the one-resolver callgraph. *Precise clincher (open):* an emulator RAM-diff — watch vs
`[Don't View]` from the same seed, casualties compared to the soldier.

## The combat "tarnish"

Combat strength is a many-term additive aggregate — `men + terrain(defensive) + lord-military-compare
+ unit-type + unit-rank(+100% when favored) + 8-stat W(+40%)`, all ×`(115−15·skill)`. The unit rank
(Rifles>Cav>Inf) is **one +100% term**, not a 4× damage multiplier — fief Skill (weight 25) and daimyo
IQ (20) dominate the contest. Casualties are then a deterministic `pct_op(men, p)`; only **Bribe** rolls
dice (`rng(0..5−skill)+morale+Charisma` — a defection contest that flips men, *not* melee attrition).
The result is combat math too tangled to intuit at the table — legible only once fully enumerated.

## The play isn't in the engine — positional strategy

The graded mechanics collapse to one strategic truth: **the combat engine is a red herring.** The AI
decides one fief at a time, opportunistically (`is_favorable = calc_combat_odds < 50`, adjacency-gated),
and the `(115−15·skill)` handicap it applies *only to human fiefs* deflates your apparent strength in its
own odds math — a **targeting magnet**, not merely softer attacks: an equally-statted AI fief is "safe,"
your identical fief wears a soft-target sign. So the winning game is entirely positional, and the elaborate
combat math almost never gets to matter:

- **Don't be the weakest among your neighbors, and don't become it** — the literal negation of the AI's
  one-ply decision function. You never need *global* strength, only local, and only enough to fail each
  neighbour's favorability gate *given your handicap*. "Attack only when you can hold" is the same rule
  forward: an ungarrisoned conquest just mints a new weakest-border-fief for the next AI turn to pile onto.
- **Front-load before the subsidy compounds.** Your daimyo stats are frozen at the character roll; the AI's
  **drift upward every turn** and its economy is subsidized (`6−skill`, `init_ai_budget`, Fall boost). Your
  edge is *maximal on turn 1 and decays monotonically* — so the speedrun rushes: max-reroll all 5 stats
  (winning the daimyo half of the 8-stat table outright), exploit that **assassination has no AI counter**
  (unreachable from the AI turn; it never retaliates diplomatically), seed the `$2E17` turn order to chain
  decapitations, then buy the leaderless lands and pack the new men into chokepoints before the AI catches up.

**Placement beats lord class** — the sharpest statement of the thesis. Speedruns start **Miyoshi in Settsu**,
only a *B-class* lord, because he is ringed by weak, easily-assassinated neighbours — a soft opportunity
field. One of the *hardest* starts is **Uesugi in Echigo**, an **A-class** lord, precisely because he sits
among other A/S daimyo and must grind wins out of the best defensive fief in the game. A strong lord among
titans is worse-placed than a middling lord among weaklings — exactly what an adjacency-local, opportunistic
engine predicts. The engine's complexity is nearly a magic trick: it hides how little the engine actually
decides. See [The Hollow Opponent](./hollow-opponent-perceived-depth.md) and
[The Dead-Verb Test](./dead-verbs-mechanism-viability.md).

## The thesis, measured — the turn-1 attack matrix

The positional argument above is qualitative; a **backend attack simulation** turns it into a map. The confirmed formula core (`attack_sim.py`) computes, for each fief, its weakest adjacent enemy and whether the owner is *favored* — all inputs SNES-derived: `favored ⟺ atk_strength > def_strength` (the `odds<50` gate decoded via `percent(a,b)=a·100/(a+b)`), `strength = men·(1+0.40·W/100)·handicap`, W = the 8-stat weighted win-count, handicap `= 100` (AI) or `115−15·k` (human difficulty *k*). Adjacency is the NES-verified 17-fief border table (bank-4 `$8300`) — the SNES derives borders from map geometry at runtime, with no static table to read. Two front-ends feed the core: `attack_sim_base.py` runs the **canonical turn-0 base** from the province-order NES extracts (`17fief.txt`/`17Diamyo.txt`); the dump front-end runs a live WRAM snapshot as a cross-check.

**There is no single deterministic turn-0** — and pinning that down was half the exercise. The ROM base is deterministic, but new-game *randomizes before the player ever sees the map*: koku is rolled from the first stat, a **random fief gets a ~+50% men bonus**, and turn-1 already has some daimyo buying or losing men. Two alignment traps had to be cleared to even read the base: the ROM record is **header-first** (koku at `+0`) while the RAM record is header-last (loader rotates it), *and* the ROM scenario table is stored in **clan order, not province order** (record 0 = Mikawa/Tokugawa, record 1 = Owari/Oda) — a fief-indexed read straight off the ROM mislabels all 17. The `17fief.txt` extract, already remapped to province order, sidesteps both; a byte-compare confirms it is **identical to SNES `$C3:903D` on every field except koku** — the randomized field diverging (800 vs 1000) is itself the byte-level proof that koku is rolled.

So the deliverable is a **base matrix = the center of a distribution**, with three stable conclusions:
- **Two structural magnets, and they are historically exact.** *Mino* (Saitō, base men **38**) is the weakest neighbour of **five** fiefs (Echizen, Hida, Mikawa, Shinano, Owari) — ringed by the strongest clans in the game (Oda, Takeda, Tokugawa, Asakura); this is the Mino everyone historically piled onto, reproduced from stats alone. *Iga* (Rokkaku, **21**) is the weakest neighbour of **four**. The fiefs that can't favourably attack even their weakest neighbour as the AI (Musashi, Kaga, Suruga, Mino, Iga) are themselves among the magnets — **weakness both blocks striking out and invites being struck**, the NES "weakness, not a timer, summons the wars" rule from SNES stats alone.
- **The handicap squeeze.** Of 17 fiefs, **12** can favourably take their weakest neighbour as the AI (or a human at difficulty 1 — `115−15·1 = 100%`, so *difficulty 1 applies no combat handicap at all*). Each level strips ~15% strength: **12 → 12 → 12 → 11 → 10 → 6** (AI/h1…h5). The handicap isn't a softer AI — it's a shrinking permission set on the *human's* own aggression.
- **Structure survives the jitter; exact flags don't.** A just-started dump (human moved first) sits mostly within ~30% of this base — the player's own fief read *identical* — with a few movers (Musashi 70→150 flipped to favoured; Suruga/Shinano dropped ~0.4×), yet surfaced *the same two magnets*. And the ~+50% random bonus is asymmetric exactly as designed: landing on **Mino (38→~57)** lifts it out of universal-victim status; landing on **Owari (78→~117)** is pure overkill on the strongest fief — "great if it's Noto, wasted on Oda." Good replayability lever, possibly tuned a touch strong.

*NES↔SNES divergence surfaced here (a real one, not an over-read).* The **NES** strategic gate is a men-ratio bar with noise — `ratio−10−rng(skill·3) > 60`, target = weakest adjacent by **provisioned** men (a rice-starved fief counts as 0 men). The **SNES** gate is a plain 50% bar on a *strength composite* (`men × W × handicap`). So the port moved the selectivity out of a raw-men ratio and into the strength formula — the 8-stat W-scaling and the difficulty handicap now do the gating that an explicit `>60`+skill-noise term did on the NES. Same emergent behaviour (weakest-neighbour aggression, difficulty-as-handicap), re-expressed through the combat-strength model rather than a bespoke ratio test.

## What the exercise demonstrated about method

And a coverage lesson the *questions* surfaced: the "100% label-walk (715/715)" was 100% of the
**direct-call + syscall** routines — but the **player command verbs are a 4th indirect-dispatch island**
(~94 routines behind the command jump tables, `mul32_a`→table→indirect `JSR`), invisible to a DFS from
`main`, exactly like the syscall island. Asking "what are the non-economy verbs?" is what exposed it;
enumerating the tables and walking their targets brought the total to **821 routines, ~809 named**.
*"100% of the walk" ≠ "100% of the program" when dispatch is indirect — census every jump table.*

Every discrepancy across five sections was a **CREATE-phase over-read from the lossy C decompiler**
(record-field offsets; "seeding is generated" — it's a fixed ROM copy; "SNES added a 2nd loyalty stat"
— it's morale relabeled; "daimyo folded into the fief record" — they're separate, the fief outlives its
lord). The blind-then-check discipline **caught each before it was committed**, while the SNES native
code independently reproduced the NES's emulator-certified numbers (Grow, illness, the 8-stat weights,
the casualty formula). Two independent reverse-engineerings agreeing at the arithmetic level is the
strongest oracle either one could have.

## Tags
[reverse-engineering](../../tags/reverse-engineering.md) · [snes](../../tags/snes.md) · [65816](../../tags/65816.md) · [koei](../../tags/koei.md) · [game-design](../../tags/game-design.md)

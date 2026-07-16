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

Field map (both, header-first in ROM): `header, gold, debt, town, rice, output, dams, loyalty(+12),
wealth, men(+16), morale(+18), skill(+20), arms(+22)`.

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

## The combat "tarnish"

Combat strength is a many-term additive aggregate — `men + terrain(defensive) + lord-military-compare
+ unit-type + unit-rank(+100% when favored) + 8-stat W(+40%)`, all ×`(115−15·skill)`. The unit rank
(Rifles>Cav>Inf) is **one +100% term**, not a 4× damage multiplier — fief Skill (weight 25) and daimyo
IQ (20) dominate the contest. Casualties are then a deterministic `pct_op(men, p)`; only **Bribe** rolls
dice (`rng(0..5−skill)+morale+Charisma` — a defection contest that flips men, *not* melee attrition).
The result is combat math too tangled to intuit at the table — legible only once fully enumerated.

## What the exercise demonstrated about method

Every discrepancy across five sections was a **CREATE-phase over-read from the lossy C decompiler**
(record-field offsets; "seeding is generated" — it's a fixed ROM copy; "SNES added a 2nd loyalty stat"
— it's morale relabeled; "daimyo folded into the fief record" — they're separate, the fief outlives its
lord). The blind-then-check discipline **caught each before it was committed**, while the SNES native
code independently reproduced the NES's emulator-certified numbers (Grow, illness, the 8-stat weights,
the casualty formula). Two independent reverse-engineerings agreeing at the arithmetic level is the
strongest oracle either one could have.

## Tags
[reverse-engineering](../../tags/reverse-engineering.md) · [snes](../../tags/snes.md) · [65816](../../tags/65816.md) · [koei](../../tags/koei.md) · [game-design](../../tags/game-design.md)

---
status: active
created: 2026-05-04
updated: 2026-05-04
---
# Utopia — Building Economy
> Every formula. The 9 building prices. The 5 income streams. The 3 score components (Housing / GDP / Food, all clamped at 30) plus the welfare bonus. The fertility-mortality population model. The 33% per-round crop mortality. The exposed mechanics that make Utopia *playable* once you can see them — and that took the community decades to reverse-engineer because the game itself never told anyone.

**Links:** [Utopia README](./README.md), [Memory Map](./01-memory-map.md), [Display & Tile System](./02-display-and-tiles.md), [Input & Control Dispatch](./03-input-and-dispatch.md), [The Tic Engine](./04-tic-engine.md), [CoM Spell Counter-Graph](../../../research/gaming/master-of-magic/com-counter-graph.md), source: [`source/utopia.asm`](./source/utopia.asm)

## What this chapter delivers

The complete strategic decision space, in source-extracted form. After this chapter, **anyone can compute optimal Utopia build orders without playing the game once.** That's the verification of the dominance-frontier transparency principle — exposed mechanics convert the meta-game from "discovery" to "play." The 1981 player had to infer all of this by experiment over hundreds of hours; the 2026 reader gets it from `L_5877`, `L_59CD`, and the `PRICES` table in about 12 minutes of source reading.

## The price table

`PRICES` lives at `$5910` as a 9-entry DECLE block, indexed 1-9 by item number (with the entry at `PRICES-1` so `PRICES-1 + item_number` works as the lookup):

| # | Item | Cost (gold) | Color |
|---|---|---|---|
| 1 | **Fort** | 50 | Black |
| 2 | **Factory** | 40 | Black |
| 3 | **Crop** | **3** | Dark Green |
| 4 | **School** | 35 | White |
| 5 | **Hospital** | 75 | Red |
| 6 | **House** | 60 | Yellow |
| 7 | **Rebel** (mercenary) | 30 | Black |
| 8 | **PT Boat** | 40 | (set by code) |
| 9 | **Fishing Boat** | 25 | (set by code) |

**Crops are by far the cheapest investment.** Everything else costs 25–75. The 17× cost gap between the cheapest building (Crop) and the most expensive (Hospital) is the central tension of the build order.

## L_5877 — the purchase commit

When the player presses Enter on a pending selection (Chapter 3), control reaches `L_5877`. The flow:

```asm
L_5877: MVI     CURSEL, R0          ; what's being bought
        MVI     CURPLR, R1          ; which player
        CMPI    #$0007, R0          ; rebels: skip cursor checks
        BEQ     L_58A0              ;
        CMPI    #$0008, R0          ; boats: check harbor instead
        BGE     L_5924              ;

        ; Otherwise: buildings 1-6 — must place under the cursor
        ...
        JSR     R5, MOB_TO_CARD     ; what tile is the cursor over?
        MVI     CURSEL, R0
        JSR     R5, GRAM_OR_GROM    ; \_ GROM = open sea; RAZZ
        BEQ     L_5941              ; /
        MVI@    R2,     R1
        MOVR    R1,     R3
        SLLC    R3,     2           ; \_ check bit 14 = ownership
        BOV     L_591D              ; /  (Chapter 2's trick again)

        ; Ownership check: must match CURPLR
        ...

L_589C: MOVR    R1,     R3
        SLLC    R3,     1           ; \_ bit 15 must be 0 = empty tile
        BC      L_5941              ; /

        ;; Now actually buy it (or RAZZ if poor)
L_58A0: MVII    #PRICES-1, R3
        ADDR    R0,     R3          ; PRICES[CURSEL]
        MVI@    R3,     R1          ; load price
        MVII    #GOLD_0,R4
        ADD     CURPLR, R4
        ADD     CURPLR, R4          ; address of player's gold (2-byte)
        MVI@    R4,     R0          ; load gold
        CMPR    R1,     R0          ; can afford?
        BLT     L_5941              ; no: RAZZ
        SUBR    R1,     R0          ; deduct price
        ...                          ; write back updated gold
```

Three placement validations before money changes hands:

1. **Tile must be GRAM** (i.e., on an island, not in the open sea — open-sea tiles use GROM). RAZZ if you try to build on water.
2. **Bit 14 of the tile must match the buyer** (the ownership trick from Chapter 2 — you can't build on the opponent's island). RAZZ otherwise.
3. **Bit 15 of the tile must be 0** (the tile is empty land, not already a building). RAZZ if you try to overbuild.

If all three pass, the price is looked up via `PRICES-1 + CURSEL`, gold is checked, deducted, and the new building is written into BACKTAB at the cursor position. The building tile carries the appropriate color from a parallel `COLORS` table (also indexed 1-9).

Two special cases bypass cursor checks:
- **Rebels (item 7)** can be bought from anywhere — they spawn somewhere on the *opposing* player's island via the `RBLTRY` retry loop (Chapter 7).
- **Boats (items 8, 9)** are placed in your *harbor* tile (a fixed BACKTAB address per player: `$027A` for player 0, `$0262` for player 1) rather than under the cursor.

## The five income streams

`L_59CD` runs at end-of-round for each player in turn (toggling `CURPLR` between iterations). Five sources of gold get summed into the round's income:

```asm
;; 1. Award baseline gold for factories
MVI     N_FTRY, R0          ; loaded from FTRY_n
MVII    #$0004, R1
JSR     R5, X_MPY           ; factories × 4
JSR     R5, AWARD_GOLD      ; → RGLD_n + GOLD_n

;; 2. Award baseline gold for fishing boats
MVII    #F_BO_0,R1
ADD     CURPLR, R1
MVI@    R1,     R2          ; R2 = fishing boats × 1
JSR     R5, AWARD_GOLD

;; 3. Productivity bonus
MVI     SCHL_n, R0          ; schools
ADDI    HOSP_n, R0          ; + hospitals
MVI     N_FTRY, R1          ; × factories
JSR     R5, X_MPY           ; → factories × (schools + hospitals)
ADD     HOSP_n              ; + hospitals
CMPI    #$001E              ; clamp to 30
JSR     R5, AWARD_GOLD

;; 4. +10 baseline (NOT counted toward RGLD)
JSR     R5, L_5A24          ; adds 10 to GOLD_n only

;; 5. (already accumulated) fishing income from per-tic INC_GOLD
;;     (1 gold per ~50 ticks = 2.5 sec of parked fishing boat under fish)
```

The five streams in plain math:

| # | Source | Formula | Notes |
|---|---|---|---|
| 1 | **Factory baseline** | `Factories × 4` | flows to RGLD (counts for GDP); **passive** — pure building count |
| 2 | **Fishing-boat baseline** | `FishingBoats × 1` | flows to RGLD; trivial — extra boats aren't passive income |
| 3 | **Productivity bonus** | `min(30, Factories × (Schools + Hospitals) + Hospitals)` | clamped at 30 |
| 4 | **Stipend** | `+10 flat` | does NOT flow to RGLD (excluded from GDP) |
| 5 | **In-round fishing** | `1 per ~50 ticks of parked-fishing-boat-on-fish` | flows to RGLD |

**The stipend is the most interesting design choice in the income model.** Every player gets +10 free gold per round, but it's deliberately excluded from `RGLD` (the round's "earned" gold). So the stipend keeps the game from collapsing when a player has nothing — they always get enough to build a few crops or a fishing boat — but it doesn't inflate their GDP score. The score rewards *productive* income, the safety net just prevents elimination.

## The population model — fertility vs mortality

Before scoring runs, populations are updated for both players:

```asm
fertility = 50                              ; 5.0% baseline
fertility += 3 × Crops                       ; food helps
fertility += 3 × Hospitals                   ; healthcare helps
fertility += 1 × Houses                      ; shelter helps
fertility -= 3 × Schools                     ; education suppresses

mortality = 11                              ; 1.1% baseline
mortality -= 3 × Hospitals
mortality = max(2, mortality)                ; clamped min 0.2%
mortality += 1 × Factories                   ; pollution / industrial death

fertility = max(40, fertility)               ; clamped min 4.0%

births = (pop / 10) × (fertility / 100)
deaths = (pop / 10) × (mortality / 100)
pop = min(9999, pop + births - deaths)
```

Five buildings shape population: **Crops, Hospitals, Houses, Schools, Factories.** The signs:

| Building | Fertility | Mortality | Net effect on pop growth |
|---|---|---|---|
| Crop | **+3** | — | strong positive |
| Hospital | **+3** | **−3** (clamped min 2) | very strong positive |
| House | +1 | — | mild positive |
| School | **−3** | — | strong negative |
| Factory | — | **+1** | mild negative |

Schools and Factories are the **industrial trade-off** — they boost gold income (factory baseline + productivity multiplier) but suppress population growth. Hospitals pull double duty: they're the *only* building that both helps fertility AND reduces mortality, justifying their 75-gold price.

**The hospital effect on mortality is clamped before the factory penalty is added.** From the source: `; Note that this is after clamping the hospital effect.` So 3 Hospitals get you mortality = max(2, 11-9) = 2; adding 1 Factory bumps mortality to 3; adding more hospitals does *not* re-reduce. The clamp protects against under-zero, then factories add on top. **Industrialization is unavoidably deadly** — you can't completely cancel factory pollution with hospitals.

## The score formulas — three components, all clamped at 30

After population is updated, scoring runs (also for each player in turn):

```asm
pop100 = pop / 100

housing = ((Houses × 500) / pop100) / 3       , clamped 30
GDP     = ((RGLD × 100)   / pop100) / 12      , clamped 30
food    = (((FishingBoats + Crops) × 500) / pop100) / 3   , clamped 30

round_score = housing + GDP + food + Schools + Hospitals
            , clamped 100

total_score += round_score
```

Three observations:

1. **All three components scale inversely with population.** A player with 1000 pop needs 30/3 = 10 houses to max housing; a player with 5000 pop needs 50 houses. **Growing population makes scoring *harder*, not easier** — counter-intuitive design that prevents pop-stacking.

2. **The three "main" components cap at 30 each** (90 total max). The remaining 10 points come from `Schools + Hospitals` welfare bonus. Round-score is then capped at 100. **You can max round score with 30+30+30+10 split** (a "10 schools + hospitals combined" minimum to reach 100).

3. **GDP scales harder than the others.** Note the `/12` divisor (vs `/3` for housing and food) and the `×100` multiplier (vs `×500`). Working through:
   - Housing: `(Houses × 500 / pop100) / 3` — 1 house per 100 pop = 5 housing score; 6 houses per 100 pop = 30 (max)
   - Food: same as housing — 6 (boats+crops) per 100 pop maxes out
   - GDP: `(RGLD × 100 / pop100) / 12` — RGLD = pop/100 × 12 / 100 × 100 = `RGLD_max = 0.12 × pop` to max out. At 1000 pop: need 120 round-gold. At 5000 pop: 600. **Hard cap is 255** since RGLD is 1-byte (acknowledged in the source: `; Note: Don't try to earn more than 255 gold bars in one round. I don't personally think that's possible.`) — but 255 gold from the income streams alone is implausible.

This is what the user meant by *"the game is about fishing as much as you can"* — fishing is the only income stream that scales with **player effort within the round** (positioning boats on fish schools), not just building counts. Factory baseline (×4) and productivity bonus give you a steady-state income, but **fishing is the lever for spiking GDP score in any specific round.**

**Important refinement on fishing boats:** the +1/round baseline is trivial; the real fishing income is the per-tic `INC_GOLD` flow from a parked-fishing-boat-on-fish-school. But:

- Each player has only one carryable MOB at a time (the cursor swaps to a boat in mode 8/9, and the rectangle returns when the boat is parked).
- Fish drift across the map after spawning at one of the four corners (Chapter 4).
- The player must physically *navigate to* the fish school, then drop the boat there.

So **fishing boats are positional capital, not productive capital.** Owning 2-3 boats is useful because you can have one parked in each map sector — when fish appear, the closest boat can be carried over. But the *count itself* contributes only the trivial +1/round baseline; the rest is active play. **Fishing is a navigation problem layered on top of the economic engine.**

## Crop mortality — 33% per round, randomized

After scoring, the engine walks every tile on both islands and rolls a die for each crop:

```asm
L_5B6B: ...                          ; reset RGLD_n to 0 for next round
        MVII    #LFT_ISLE_OFS_TBL,R1 ; iterate from left island start

L_5B74: ...                          ; figure out left vs right (CURPLR)
        MVI@    R1,     R2           ; \_ get island offset
        ADDI    #$0200, R2           ; /  → BACKTAB address
        MVI@    R2,     R3           ; \_ load tile
        SLR     R3,     2            ;  |- extract card # (Chapter 2's GET_TILE_NO logic)
        SLR     R3,     1            ; /
        ANDI    #$00FF, R3
        CMPI    #$0003, R3           ; \_ is it a crop (tile 3)?
        BNEQ    L_5BAB               ; /  no: skip

        MVII    #$0003, R0           ; \_ rand(0..2) — 2/3 chance of survival
        JSR     R5,     X_RAND2      ; /
        TSTR    R0
        BNEQ    L_5BAB               ; survived: skip

        ; otherwise: NUKE THE CROP
        ...                          ; clear the tile, decrement CROP_n
        ...
```

**33% per-round mortality**, independent for each crop, no rain modifier visible at this scoring stage. Expected lifetime of a crop = ~3 rounds. The `RCRP_n` (rain-on-crop) variables from Chapter 1 must influence this elsewhere — they're updated by the weather system (Chapter 6) and presumably modify per-tile survival, but the end-of-round mortality scan as written is uniform 33%.

The user's intuition that *"hoping your crops get the most rain"* is the right strategic frame — crops are cheap (3 gold) but need rain to be worth more than the upfront cost. Without rain modifiers, expected crop value = 3 rounds × food-score contribution. With rain bonus presumably extending lifetime, crops with rain become long-term food generators.

## Strategic implications — what falls out

With everything exposed, the strategy frontier is computable. A few decisions become obvious:

### Crops dominate early
- 3 gold per crop, 3 rounds expected lifetime, +3 fertility, contributes to food score.
- **Cheapest food-score builder by 8×** (next cheapest is fishing boat at 25). With 100 starting gold, you can build **33 crops** vs 4 fishing boats. Even with 33% mortality, 33 crops far outproduce 4 fishing boats for food score.
- The trade-off: crops sit on tiles, blocking other builds. So the strategy is "carpet the island in crops early, replace with higher-value buildings as gold grows."

### Hospitals are the only true win-win
- +3 fertility AND −3 mortality (clamped) AND +1 score bonus.
- 75 gold is steep but **paid back in population growth** (every doubling of population doubles steady-state income via productivity bonus).
- **Buy hospitals before factories** to set up the multiplier.

### The factory chain
- Factory alone: +4 gold/round = 10 rounds payback.
- Factory + 1 School: +4 + (1 × 1) + 0 hospital = 5 gold/round = 8 rounds payback.
- Factory + 1 School + 1 Hospital: +4 + (1 × 2) + 1 = 7 gold/round = 5.7 rounds payback (also +1 mortality from factory, +0 net mortality from hospital).
- **2 Factories + 2 Schools + 2 Hospitals**: +8 + (2 × 4) + 2 = 18 gold/round = 1.7-round payback per factory. Productivity multiplier compounds.
- **Schools cost fertility**, so over-Schooling shrinks population, which paradoxically *helps* GDP and Housing scores (they scale inversely with pop).

### Anti-fertility is sometimes optimal
- High population caps your scores (you need more houses, more crops, more boats per capita).
- **Schools are a *score* tool as much as an income tool** — they suppress population growth so your buildings stay "high per capita."
- Optimal long-game might be: grow to ~500 pop, then add Schools to *stop* growing while building infrastructure that maxes out the per-capita ratios.

### Round-score ceiling math
- Maximum round score = 100. To reach it: 30 Housing + 30 Food + 30 GDP + 10 from Schools/Hospitals.
- 30 Housing at 500 pop = 6 Houses (= 360 gold).
- 30 Food at 500 pop = 6 (FishingBoats + Crops) (= cheap with crops).
- 30 GDP at 500 pop = 60 RGLD per round (= achievable with factory + productivity bonus + fishing).
- 10 welfare from 5 Schools + 5 Hospitals = 175+375 = 550 gold.
- **The "perfect 100" is achievable but requires ~1500+ gold of optimized building** — multiple rounds of accumulation. The game *can* be won with skill once the formulas are known.

## What the game told the 1981 player

Nothing. **None of these formulas appeared in the manual or game UI.** The player saw three numbers in the status bar (turn, gold, score) and a graphical island. They didn't see:

- The 50/40/3/35/75/60 prices (had to memorize by trial)
- The `Factories × (Schools + Hospitals) + Hospitals` productivity formula (had to discover by experiment)
- The 33% per-round crop mortality (had to count crops across rounds)
- The `−3 fertility per School` penalty (would only show up over many rounds of population data)
- The 30-cap on each score component (had to guess from the numbers plateauing)

**This is what the user meant by "exposed mechanics makes the game about play, not discovery."** A 1981 player's first 50 hours of Utopia were spent on what we just extracted in 12 minutes of source reading. With the formulas in hand, the game becomes a clean optimization problem with rich tactical variation (positioning boats on fish, reacting to weather, anticipating pirate raids). Without them, it's a black-box stochastic process you eventually develop folk-rules for.

This is the **same dynamic the dominance-frontier work captured for CoM** — once the spell economy is documented, play becomes the skill. The 1981 → 2026 source-reading transition for Utopia is exactly that documentation step, retroactively performed.

## Curiosities

**The `+10 stipend` is a soft floor.** Without it, a player who lost all their forts and crops to a hurricane would have no income to recover, no way to climb out, and the game would deadlock. The stipend ensures every player can afford 3 crops every round (3 × 3 = 9 gold spent, 1 left over). **Anti-tilt floor predates modern game design vocabulary** — Don Daglow had this instinct in 1981.

**RGLD is 1-byte → overflow at 256, not a ceiling.** The source comment reads as amusement: `; Don't try to earn more than 255 gold bars in one round. I don't personally think that's possible.` But the real risk is sharper: **at 256 RGLD wraps to 0**, and since GDP score is computed from RGLD, *your GDP score collapses to zero on the round you over-earned*. Defensive advice, not bravado. Theoretical max RGLD per round (excluding fishing) = `30 productivity bonus + Factories × 4 + FishingBoats × 1` = if 9 Factories and 9 FishingBoats: 30 + 36 + 9 = 75. Adding fishing income from a long turn with multiple parked-boat-on-fish events could push this further, especially in 120-second turn lengths. 255 is reachable on the tail; the wraparound is then a real game-feel bug.

**The food score formula has a documented overflow case.** `((Crops + FishingBoats) × 500)` overflows 16-bit if `Crops + FishingBoats > 65`. Source comment: `; Note: This can overflow if (crops + fishing boats) > 65`. With 9 fishing boats max + 31 island tiles per player, this is theoretically reachable but unlikely in normal play.

**Crop tiles are decoded from BACKTAB at end-of-round, not tracked separately.** The crop mortality scan uses GET_TILE_NO style decode on every island tile rather than reading from a "list of crops." This means the crop counter (`CROP_n`) and the actual crop tiles can drift out of sync if anything modifies BACKTAB without updating the counter — a coupling assumption rather than enforcement.

**The `INPUT_DISP` color hack** (line 2113):
```asm
; Note: First two colors in color table also form BIDECLE 0
; for last entry in the input dispatch table above. Nice hack.
```
The terminator of the input-dispatch table (two zero words) overlaps with the first two color entries of the COLORS table (which are both `C_BLK = 0`). **Two zeroes serve double duty as both a sentinel and as data.** That's the kind of byte-saving cleverness 4 KB cartridges demanded.

## What this clarifies for later chapters

- **Chapter 6 (MOBs / world events)**: the rain mechanics that affect crop survival, the fishing-while-parked mechanic that produces in-round gold, and the pirate-raid mechanic that destroys fishing boats all live here. The connection back to scoring is: weather destroys crops (food drops), pirates destroy boats (food + GDP drop).
- **Chapter 7 (rebels)**: rebels are item #7 (cost 30 gold), bought from anywhere, placed via `RBLTRY` (250-attempt loop) on the opposing player's island. The 30-gold price is the player's "buy a rebel against the opponent" lever — purchase and effect both live in this chapter and the next.
- **Chapter 8 (round / scoring orchestration)**: the round-display flow (`L_5429`), the SCORES vs TOTALS toggle (`SC_TOT`), and the end-of-game transition (`L_547E`) wrap around what we just walked through.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | `PRICES`, `COLORS`, `H_SCOR`/`G_SCOR`/`F_SCOR`, `N_FTRY`, `AWARD_GOLD`. The naming is so faithful that the formulas read like pseudocode. |
| **Source comments** | The income-stream order, the "productivity bonus = `Factories × (Schools + Hospitals) + Hospitals`" explanation, the clamping discipline, the **+10 stipend exclusion from RGLD**, the overflow caveat for food score, the harbor-tile addresses for boat placement. |
| **CP1610 ISA knowledge required** | `X_MPY` (16-bit multiply, result in R2), `X_DIV` and `X_DIVR` (divide, divide-with-rounding) — both EXEC ROM utilities. Their input/output conventions (R0/R1 args, R0/R2 results) are convention; documented externally. Nothing newer than what Chapters 1-4 already needed. |
| **External hardware knowledge required** | None new. The bit-15 = "tile occupied" check is a Utopia convention exposed in the build code, not Intellivision hardware. |
| **Disagreements with source** | None. The source is *exceptionally* clear here — the formulas are not just present but explained in comments alongside. This is by far the most well-documented chapter so far. |

Net for the project hypothesis: the scoring chapter is the **acid test**. If the source could be read at the engine level for everything but the score formulas, the bet would have been incomplete. **The score formulas come out cleanly from labels + comments + standard arithmetic ops** — and they are exactly what a strategic player would need to optimize. The reader emerges with the entire decision space documented.

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)

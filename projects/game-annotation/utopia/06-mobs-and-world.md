---
status: active
created: 2026-05-04
updated: 2026-05-04
---
# Utopia — MOBs and the World
> The eight hardware sprites and what they DO. Fishing as navigation. Pirates as random mortgage on your fishing boats. Weather damage as a hidden 125-point counter that finally answers what `RCRP_n` and `TDMG_n` actually do. The neighbor-table fort defense that costs less than 12 instructions. Hurricane = 5× more damaging than a tropical storm = ∞× more damaging than rain — and the rain that's *not* damaging actually gives you free gold.

**Links:** [Utopia README](./README.md), [Memory Map](./01-memory-map.md), [Display & Tile System](./02-display-and-tiles.md), [The Tic Engine](./04-tic-engine.md), [Building Economy](./05-building-economy.md), source: [`source/utopia.asm`](./source/utopia.asm)

## The 8 hardware sprites — what each one does

The Intellivision STIC has 8 MOBs. From Chapter 1's allocation:

| MOB | Role | RAM | Behavior |
|---|---|---|---|
| 0 | Weather over Player 0's island | `$031D` | Drifts, has a damage rate, hurts buildings underneath |
| 1 | Weather over Player 1's island | `$0325` | Same |
| 2 | Player 0's cursor / boat | `$032D` | Carries cursor or a boat sprite; controlled by disc |
| 3 | Player 1's cursor / boat | `$0335` | Same |
| 4 | Pirate 0 | `$033D` | Drifts, sinks parked fishing boats, blocked by forts |
| 5 | Pirate 1 | `$0345` | Same |
| 6 | Fish school 0 | `$034D` | Drifts, despawned when fishing boat parks under it long enough |
| 7 | Fish school 1 | `$0355` | Same |

Per-MOB record is 8 bytes (attribute / ROM-ptr / X / Y / velocity / animation / spare / spare). The collision loop in Chapter 4 walks all 4 movable MOBs (players + pirates) every tic; weather and fish move via STIC velocity registers without per-tic code.

## Fishing — the active income loop

`PARK_FISH` is what runs when a fishing boat (cursor mode 9) drops onto a fish-school MOB:

```asm
PARK_FISH:
        PSHR    R5
        JSR     R5, MOB_TO_CARD     ; tile under fish school
        JSR     R5, GET_TILE_NO
        CMPI    #$0009, R1          ; \_ is it actually a fishing boat?
        BNEQ    L_54CA              ; /  no: leave
        MVI@    R2,     R1          ; \_ bit-14 ownership lookup
        SLLC    R1,     2           ;  |
        BOV     L_54B2              ;  |
        MVII    #$0001, R1          ;  |
        B       L_54B3              ; /
L_54B2: CLRR    R1
L_54B3: MVO     R1,     CURPLR

L_54B5: MVII    #FISH_0,R1          ; \_ get this player's fishing counter
        ADD     CURPLR, R1          ; /
        MVI@    R1,     R2
        INCR    R2                  ; +1 interaction
        CMPI    #$0032, R2          ; reached 50?
        BNEQ    L_54C9              ; no: just store
        CLRR    R2                  ; \_ yes: reset counter
        MVO@    R2,     R1          ; /
        JSR     R5, INC_GOLD        ; +1 gold to player
        JSR     R5, FISH_PLING      ; sound effect!
```

**Fishing math:** every per-tic call to `PARK_FISH` (when a fish school slides over a parked fishing boat) increments `FISH_n` by 1. At 50 interactions, the counter resets and `INC_GOLD` fires (1 gold to the player, +1 to RGLD). At 20 Hz, **50 ticks = 2.5 seconds of overlap** to earn one gold. A 60-second turn with one boat-on-fish overlap at 100% duration would yield ~24 gold. Realistic numbers are much lower — fish drift, the boat is stationary, the overlap is intermittent.

**This is what makes fishing tactical, not strategic.** The game-state input is "did a fish drift over a parked boat for 50 of the last 1200 ticks?" Player skill = predicting fish drift trajectories and parking boats *ahead* of where they'll be, not *where they are now.* The corner-spawn pattern (Chapter 4) gives you the prediction; the constant 50-tic threshold tells you the cost.

`UNPARK_FISH` is symmetric for the case where the *fish* drifts over a *parked* boat (vs the boat being placed under the fish):

```asm
UNPARK_FISH:
        PSHR    R5
        SUBI    #$0002, R0          ; map MOB # 2/3 → player # 0/1
        MVO     R0,     CURPLR
        B       L_54B5              ; same body as PARK_FISH
```

The two routes (place-boat-under-fish vs fish-drifts-onto-parked-boat) share the same counter logic from `L_54B5` onward.

## Pirates — random sinkings on your fishing boats

Pirates spawn at corners (Chapter 4 — same `L_526A` utility as fish, just different MOB attribute setup). They drift with random velocity tweaks. When a pirate MOB ends up over a fishing-boat tile, `L_54F8` fires:

```asm
L_54F8: PSHR    R5
        MOVR    R1,     R4          ; copy MOB # (pirate)
        JSR     R5, MOB_TO_CARD
        JSR     R5, GET_TILE_NO

        CMPI    #$0009, R1          ; \_ Not a fishing boat?  Leave.
        BNEQ    L_553B

        MOVR    R4,     R1
        PSHR    R2
        PSHR    R4
        JSR     R5, FORT_NEAR_MOB   ; Is there a fort nearby?
        PULR    R4
        PULR    R2
        TSTR    R1
        BNEQ    L_553C              ; Yes: ours or theirs?

L_550F: MVI@    R2,     R1          ; \_ bit-14 ownership
        SLLC    R1,     2           ;  |
        BOV     L_554C              ; /  same trick again

        ; ... (pirate touch-counter increment to 20, then sink)
```

Three checks:
1. Is the tile under the pirate a fishing boat (#9)?
2. Is there a fort within one square (Manhattan distance) of the pirate?
3. Whose fishing boat is it?

**If a fort is nearby, the pirate is harmless.** This is the entire defensive value of forts: **pirate-blocking proximity defense**. The fort doesn't actively attack — it just radiates a 1-square exclusion zone for pirate predation. (Forts also block weather damage for nearby buildings via the same `FORT_NEAR_*` lookup — see weather section below.)

When all three checks pass, a per-pirate touch-counter (`$0195`/`$0196`) increments. At 20 ticks (1 second), the fishing boat sinks. **One pirate × 1 second of overlap = -25 gold worth of fishing boat plus the in-round gold income from that boat.** Pirates are slow but inexorable when they reach you.

## FORT_NEAR_MOB — the neighbor-table fort defense

The fort-proximity check is one of the most elegant routines in the game:

```asm
FORT_NEAR_MOB:
        ...                          ; setup
        ; First search positive offsets
L_5650: MVII    #NBR_TBL, R4
L_5654: MVI@    R4,     R1          ; get neighbor offset
        ; ... add or subtract from MOB position
        ; ... check if tile at that offset is a fort (#1)

NBR_TBL:
        DECLE   $0001, $0013, $0014, $0015
        ;       +1     +19    +20    +21
        ;       E      SW     S      SE
```

The neighbor table has only 4 entries — but the routine runs them **twice**, once with positive offsets (E, SW, S, SE) and once subtracting (W, NE, N, NW). **8 neighbor positions checked from 4 entries, in 12 instructions.** The trick: any 8-direction-around-a-tile neighbor is `±1` (E/W) or `±20` (N/S) or `±20±1` (diagonals) — and 4 positive offsets + their negations cover all 8.

The routine returns:
- `R1 = 0` if no fort found
- `R1 = 1` if a fort exists; `CURPLR` set to the fort's owner (decoded via the bit-14 trick)

`FORT_NEAR_CARD` is even simpler — it's a 3-instruction wrapper that calls into `FORT_NEAR_MOB`'s middle, skipping the MOB-to-card conversion. **One implementation, two callers, both with friendly entry points.**

## Weather — the 125-point damage accumulator

`WTHR_V_LAND` is what runs when a weather MOB overlaps an island tile:

```asm
WTHR_V_LAND:
        MOVR    R1,     R2
        INCR    R2                  ; \_ get weather MOB ROM ptr
        MVI@    R2,     R3          ; /
        SDBD
        CMPI    #HURR_MOB_TBL, R3   ; is it a hurricane?
        BNEQ    L_56A1              ; no: check rain vs storm
        MVII    #$0005, R2          ; HURRICANE: damage rate = 5
L_569D: MVO     R2,     DMG_RT
        B       L_56AF

L_56A1: MVI@    R1,     R0
        ANDI    #$0010, R0          ; bit 4 of color = storm flag
        TSTR    R0
        BNEQ    L_56AB
        MVII    #$0001, R2          ; TROPICAL STORM: damage rate = 1
        B       L_569D
L_56AB: CLRR    R2                  ; RAIN: damage rate = 0
        B       L_569D
```

**Three weather types, three damage rates:**

| Weather | Damage rate | Per-tic damage to TDMG_n | Time to destroy a building |
|---|---|---|---|
| **Hurricane** | 5 | +5 | 25 ticks = **1.25 seconds** |
| **Tropical storm** | 1 | +1 | 125 ticks = **6.25 seconds** |
| **Rain** | 0 | 0 | never (rain doesn't damage) |

After the type is determined, control reaches `L_56AF` which does the BACKTAB lookup to figure out what's underneath. Bit-14 still serves as the ownership oracle. Then:

```asm
L_56BC: MVII    #TDMG_0,R1
        ADD     CURPLR, R1
        PSHR    R1
        MVI@    R1,     R0
        ADD     DMG_RT, R0          ; accumulate damage at this rate
        CMPI    #$007D, R0          ; is total ≥ 125?
        BLT     L_56FD              ; no: just store
        ; otherwise: weather destroys a building
        ...                          ; decrement item count, blank tile, kill 0-101 population
```

**`TDMG_n` is a 125-point damage budget.** It accumulates as weather sits over land. Once it reaches 125, *one building* under the weather gets destroyed AND between 0 and 101 population are killed (random). The damage counter resets after destruction.

So the *damage rate* converts directly to *time-to-kill*:
- **Hurricane**: 5 per tic = 25 ticks per kill = **1.25 seconds per building destroyed**
- **Tropical storm**: 1 per tic = 125 ticks per kill = **6.25 seconds per building destroyed**
- **Rain**: 0 — never destroys anything

A hurricane that drifts over a built-up island and stays there for **5 seconds destroys 4 buildings** plus up to 400 population. This is why hurricanes are catastrophic and rain is mostly cosmetic.

The 0-101 casualty roll deserves a note: **the source explicitly does not check for negative population.** Comment: `; (Note: No check for -ve!)` — meaning a small player hit by a hurricane could theoretically wrap their population into garbage values. Combined with the chapter 1 finding that population is 16-bit and starts at 1000, a single hurricane killing 101 against pop=50 could underflow. **Whether this happens in practice depends on whether the game ever reaches that state** — early-game players have 1000 starting pop, so it'd take repeated catastrophes.

## Rain on crops — the +1 gold reward

Earlier the player observed *"hoping your crops get the most rain"* — that's the exact mechanic at `L_573E`:

```asm
L_573E: JSR     R5, GET_TILE_NO     ; what's under the weather?
        CMPI    #$0003, R1          ; \_ if not a crop, leave
        BNEQ    L_5759              ; /
        MVII    #RCRP_0,R3          ; \
        ADD     CURPLR, R3          ;  |- increment per-player rain-on-crop counter
        MVI@    R3,     R2          ; /
        INCR    R2
        CMPI    #$000C, R2          ; reached 12?
        BLT     L_5758              ; no: store and leave
        CLRR    R2                  ; yes: reset
        MVO@    R2,     R3
        JSR     R5,     INC_GOLD    ; +1 gold!
        JSR     R5,     L_5F97      ; rain-on-crop sound effect
        PULR    R7
```

**Every 12 ticks of weather over a crop tile = +1 gold.** This is the player-friendly companion to the punishing weather damage on buildings. Weather doesn't discriminate by type for this — even *hurricane drifting over a crop* gives +1 gold per 12 ticks. (Hurricanes destroy crops just like other buildings via the 125-damage path though, so the +1-per-12-ticks reward only really lasts until the crop is destroyed, which for a hurricane is 25 ticks total — meaning a hurricane over a crop pays out ~2 gold before destroying the crop. Net: +2 gold − 3 gold rebuild cost = small loss. For tropical storm: 125-tick lifetime pays ~10 gold. For rain: indefinite — pure positive income, the crop never dies from rain alone.)

**Strategic implication:** rain is genuinely good. It gives you free gold without destroying anything. **A round with constant rain over your crops is the best possible weather for a crop-focused player.** This validates the user's intuition about hoping for rain.

## Sinking ships — non-MOB animation, finished

Chapter 4 introduced the sinking-ship animation (the only non-MOB animation in the game). Now we can see the full mechanism. When a fishing boat is sunk by either weather (item type 9 destroyed) or pirate (touch-counter reaches 20), control reaches `L_5707`/`L_5591`:

- `SNKACT = 1` is set — the per-tic `L_54E8` call now advances the animation
- `SNK_AT` stores the BACKTAB offset of the sinking boat
- `SNKFRM` advances through animation frames
- `SNKCNT` is the inter-frame delay counter (controls animation speed)

When the animation completes, `SNKACT` is cleared and the BACKTAB tile becomes plain water. **The whole non-MOB animation system exists to handle exactly this one case** (ships destroyed by collision/weather instead of being explicitly removed). It's a small bespoke system but it's the only one of its kind.

## The harbor — fixed-position boat staging

From the purchase commit (Chapter 5), we learned that buying a boat (item 8 or 9) places it in a fixed *harbor* tile per player:

- **Player 0's harbor**: BACKTAB address `$027A`
- **Player 1's harbor**: BACKTAB address `$0262`

The game checks if the harbor is empty before allowing a purchase — RAZZ if it's full. This means a player can have *at most one boat in the harbor at a time*. To make a second boat, they have to first move the existing one away (pick it up with mode-0 cursor, drop somewhere on water).

Combined with the in-game movement constraint (one carryable MOB per player), this creates the **tactical fishing economy**:

1. Buy fishing boat → appears in harbor
2. Pick up cursor (mode 0) → cursor disappears, drag boat
3. Sail boat to fishing area, drop it (mode-0 keypress, now toggle back to cursor)
4. Repeat for additional boats — but each one occupies the harbor briefly

A 2-3 boat fleet is logistically slow to build and requires constant relocation. **The harbor is an architectural choice that throttles boat acquisition** — the game doesn't let you spam-buy a navy.

## Curiosities

**Bit 4 of color encodes weather type.** Tropical storm and rain share the rain MOB ROM (`$5D08`); they're distinguished by a color bit. Why? Probably: same animation, different damage profile, different visual color (grey vs black). One sprite serves two purposes via the color stack, saving GRAM.

**Hurricanes are the cause of the population-underflow possibility.** The 0-101 random casualties on a building destruction with no negative-pop check is a 1981-style "good enough" — you'd have to sustain multiple hurricanes against a tiny population to actually trigger it. But it's there in the code, with the comment.

**Hurricanes have their own MOB ROM table.** The "is it a hurricane?" check compares against `HURR_MOB_TBL` rather than reading a flag bit. Hurricanes are rendered with different graphics (the spinning-spiral MOB), so they need their own animation table. The 1-in-12 chance from Chapter 4 specifically picks this table.

**Rain is the only weather type that's unambiguously *good* for the player who has crops** — `0 damage` + `+1 gold per 12 ticks` over a crop tile. A "perfect rain" turn (continuous rain over your crops, nothing else) is pure positive income. **Combined with the user's intuition about "hope for good rain,"** this is the underlying mechanic: rain is a passive gold generator if you have crops in the rain's path. Players' subjective sense that "rain is good" is exactly correct.

**Forts are the only defensive structure.** They cost 50 gold and provide nothing scoreable (no contribution to Housing/GDP/Food). Their entire value is the 1-square exclusion zone for pirates and weather. Building one fort costs 50; protecting a 25-gold fishing boat from one pirate raid breaks even on the second save. **Fort ROI is purely defensive: how many threats does each fort prevent?** A fort placed centrally on an island can cover ~9 tiles (itself + 8 neighbors), making it a strong deal for crop carpets but possibly redundant for sparse buildouts.

## What this clarifies for later chapters

- **Chapter 7 (rebels)**: rebels share the 250-attempt placement infrastructure, also use `FORT_NEAR_CARD` for fort-defended tile rejection. The relationship between rebels and the score system (the trigger condition for AI-spawned rebels) is the chapter's hinge.
- **Chapter 8 (round orchestration)**: the round transition sequence — score → crop mortality → rebel spawn → display → next round — was visible in fragments throughout. The full sequence and the SCORES/TOTALS toggle close out the engine.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | `WTHR_V_LAND`, `FORT_NEAR_MOB`, `FORT_NEAR_CARD`, `PARK_FISH`/`UNPARK_FISH`, the harbor address constants, `DMG_RT`/`TDMG_n`/`RCRP_n`. |
| **Source comments** | The "have you ever seen a him-a-cane?" pun (an actual joke in the source), the no-negative-pop bug confession, the bit-4-of-color = storm flag, the `NBR_TBL` 4-entries-via-negation trick (explicit comment cross-references the offset arithmetic). |
| **CP1610 ISA knowledge required** | Nothing new. Bit-decoding (`SLR R, 2; SLR R, 1; ANDI #$00FF`) for tile extraction, ownership-via-`SLLC`+`BOV`, the SDBD prefix, the +1/+19/+20/+21 neighbor-offset trick. All compounds of patterns from earlier chapters. |
| **External hardware knowledge required** | None new. The MOB record layout (8 bytes per MOB) was already established in Chapter 4. |
| **Disagreements with source** | None — the comments are again carrying significant meaning. The "him-a-cane" joke is pure documentation. |

Net for the project hypothesis: **the world-events chapter is the densest in mechanical findings but required no new ISA knowledge.** The neighbor-table fort defense, the 125-point weather counter, the 50-tic fishing threshold, and the rain-on-crop bonus all surface from labels + comments + the BACKTAB inspection idioms we already knew.

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)

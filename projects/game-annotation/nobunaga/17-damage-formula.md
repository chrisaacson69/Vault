---
status: active
created: 2026-05-20
---
# Chapter 17 — The Damage Formula: How Soldiers Die

> Chapter 14 named the damage primitive; chapter 15 placed the engine in bank 2; chapter 16 mapped the render pipeline. This chapter walks the per-day combat orchestrator (`$AFE1`), the movement system (`$9B08 → $99D2 → $97D9 → $9792`), the damage-application code (`$830B`), and surfaces the supply mechanic (rice consumption with 31-day limit). The exact damage *coefficients* — which stat multiplies what — turn out to live in **native 6502 code at bank-2 `$8003`** rather than VM bytecode, so the formula's structure is mapped but its multipliers wait for a runtime trace or a 6502 disassembly pass. What's already concrete: the /30 fixed-point design, the rice supply mechanic, the 31-day exhaustion limit, and the resulting **3-province rice-exhaustion attack** — a non-obvious dominance-frontier edge that turns map topology into strategic economics directly.

**Links:** [Chapter 14 — Combat Overview](./14-combat-overview.md) · [Chapter 15 — Tactical Map](./15-tactical-map.md) · [Chapter 16 — Render Pipeline](./16-tactical-map-render.md) · [Nobunaga README](./README.md)

## The three unit-data tables

Combat tracks each unit across **three** parallel structures:

| Table | Base | Stride | Read via | Purpose |
|---|---|---|---|---|
| **Strength array** | `$6FBC` | 2 B | direct via VM `loadA_mem_word` | **current displayed strength** as 16-bit per unit (0 = dead) |
| **Metadata** | `$6FD0` | 5 B | `$828B` (ch 15) | unit type / position / morale / overlay-tile state |
| **Damage accumulator** | `$6F7D` | 6 B | `$827E` | sub-display precision accumulator + engagement-pair state |

10 slots × (2 + 5 + 6) = 130 bytes total. The three-table design separates concerns: `$6FBC` is the authoritative strength, `$6FD0` carries everything else about the unit, `$6F7D` holds the sub-display damage precision for the `/30` carry.

Validated against a paused-state SRAM dump from mid-battle: `$6FBC` showed `14, 12, 9, 5, 4, 5, 0, 4, 4, 4` (one wiped-out unit at slot 6, matching observed gameplay).

## The `/30` conversion — confirmed in code

The damage-application routine `$830B` decodes to this loop body (cleaned up):

```
host_call $827E    ; ptr = $6F7D + side×6
addA_imm4 +4       ; ptr += 4 (offset of damage accumulator field)
loadA_ind_word     ; d = *ptr  (load 16-bit damage accumulator)

loadA d
loadB +30
div_signed         ; tens = d / 30  ← displayed-strength decrement
storeA_local +10

loadA d
loadB +30
mod_signed         ; rem = d mod 30  ← sub-displayed remainder
storeA_local +9

; update internal accumulator with rem, with overflow carry:
loadA_local +8     ; index
aslA               ; ×2 (word offset)
loadB_local +0x1D  ; base pointer (unit-record array address)
add                ; addr = base + idx*2
loadA_ind_word     ; current_accumulator
add                ; current += rem
storeA_ind_word    ; write back

loadB +30
cmp_ult            ; if current < 30 ...
branch_z continue  ; ... skip the carry path

; CARRY PATH: current >= 30, so push one more "displayed loss"
loadA addr
loadA_ind_word
subB +30           ; current -= 30
storeA_ind_word
loadA local[+10]
incA               ; tens += 1
storeA local[+10]

continue:
; ... decrement displayed strength by `tens` (chapter-15 unit table)
```

So **the engine's damage tracking is**:

```
internal_accumulator += rem        ; sub-display precision
if internal_accumulator >= 30:
  internal_accumulator -= 30       ; carry
  tens += 1
displayed_strength -= tens         ; apply to the visible unit table
```

The literal `+30` constant appears **four times** in this 60-instruction routine — the `/30` ratio is hard-coded everywhere. Chapter 14's hypothesis is now structural fact.

## The combat-day driver at `$AFE1`

`$830B` has exactly one caller: `$B09F`, inside `$AFE1`. That routine is the **per-day combat orchestrator**. First 100 instructions show the shape:

```
$AFE1: per-day entry
  $AFEB  host_call $CA52                  ; ← RNG roll for the day's randomness
  $AFFC  host_call $8903, $8977,           ; 4 sub-handlers — these compute the
  $B006   $92CA, $8D39                     ; damage values for the day
  
  if (local[+6] != 0):                     ; early exit: end-of-combat
    host_call $AF3B
    vm_return
  
  loop_1 (2 iterations, one per side):
    host_call $827E                        ; get unit-record ptr
    [update +2 and other fields]
  
  host_call $8B39
  
  loop_2 (2 iterations, one per side):
    [check deep-nested status field]
    if (status < 0):                       ; unit dead → side loses
      host_call $838F                      ; get province
      host_call $AF3B                      ; end-of-combat (this side lost)
      vm_return
  
  host_call $ADD1
  $B09F: host_call $830B                  ; ← APPLY DAMAGE
  ...
```

The structural read:

1. **One RNG roll per day** — `$CA52` (the guarded random) fires once, presumably seeding multiple damage rolls downstream rather than rolling per-unit.
2. **Four sub-handlers** compute the damage values (`$8903`, `$8977`, `$92CA`, `$8D39`). Each is its own routine; appendix work to walk them.
3. **Two 2-iteration outer loops** — both run once per side (attacker/defender). The first iterates unit state setup; the second checks for unit death.
4. **Two end-of-combat exit paths**: state flag set (`local[+6] != 0`), or any unit's status field goes negative.
5. **Damage application** (`$830B`) happens after `$ADD1`, near the end of the day's processing.

## Captured damage events: 3 combats, 6 strength updates

A memory-write breakpoint trace on `$6FBC-$6FCF` (the strength array) across 3 sequential battles captured exactly 6 strength updates, all flowing through VM opcode `$B1` (`storeA_ind_word`) at PC `$ECBE`/`$ECB9`:

| Pair | Frame | Unit | Side | Old → New | Damage |
|---|---|---|---|---|---|
| 1 | 11461 | 2 | attacker | 9 → 7 | −2 |
| 2 | 11469 | 7 | defender | 4 → 1 | −3 |
| 3 | 12011 | 7 | defender | 1 → 0 | −1 (kill) |
| 4 | 12019 | 1 | attacker | 12 → 12 | 0 |
| 5 | 12136 | 5 | defender | 5 → 2 | −3 |
| 6 | 12144 | 2 | attacker | 7 → 4 | −3 |

### What this reveals about the damage model

**Damage is gradual, not catastrophic.** Per-event damages cluster at 0-3 strength points. There's no special "kill" opcode — **units die when their strength counter reaches 0**, period. The "wipe-out" observed at combat-2 wasn't a one-shot; it was the final `−1` after accumulated damage from combat-1 (4 → 1 → 0).

**Some events deal zero damage.** Pair 4 wrote `$0C` over `$0C` — no change. The engine sometimes runs through the strength-update motions without actually injuring anyone. Possibly defensive code that overwrites the field with its current value, or a "morale recovery" event that nets out to zero damage.

**The "1:2 attacker:defender casualty ratio" from chapter 14 is variable per battle, not structural.** Combat 1 had a 2:3 ratio (1.5×), combat 3 had 3:3 (1×). Different battles produce different ratios based on stat differences and RNG. There's no hardcoded "attacker advantage" multiplier — the ratio emerges from the underlying formula being applied to different inputs.

### The formula itself is still hidden — what we need to capture

We now know the damage RESULTS but not the FORMULA. To get the formula:

- **Path A**: Broader trace filter capturing the bytecode that computes `new_strength` just before each `$ECBE` write. Filter `pc == $E867 || pc == $ECBE` will capture the full VM opcode stream + the writes. Trace will be ~10× larger but reveals the exact computation.
- **Path B**: SRAM dumps before each combat of `$7001-$7100` (province stat quad at offsets 16/18/20/22) plus the unit records. With multiple combats giving us damage data points, we can fit the formula by regression against the stat differences.

The formula is `damage = f(attacker_stats, defender_stats, terrain, RNG)` for some `f` we can identify from data points + the bytecode stream.

## What stat-quad feeds the damage

The province record at SRAM `$7001 + idx×26` (chapter 9) holds these stats:

| Offset | Field |
|---|---|
| 16 | men |
| 18 | morale |
| 20 | skill |
| 22 | arms |

Chapter 14 promised: "men/morale/skill/arms feed the combat formula." `$AFE1` reads from `$6F57`, `$6F63`, `$6F7D`, `$6D9D`, and `$7BE6` — different SRAM addresses than the static province record. So the engine **stages combat-specific copies** of the relevant stats elsewhere (probably at combat init, when the per-fief CHR upload also happens). Finding the exact 16-bit slot for each modifier requires walking the four sub-handlers.

## The rice-exhaustion attack — a dominance-frontier edge

The rice mechanic's two ingredients (linear man-day consumption + 31-day hard deadline) produce a non-obvious counter-strategy that turns map topology into strategic economics directly.

### The math

```
1 rice = food for 1 man for one full 31-day battle
       (= 1 man-day = 1/31 rice consumption rate)

Defender with R rice, N men, facing K successive attacks that run the full clock:
  Each attack drains up to N rice from the defender's stockpile.
  Survival requires R ≥ K × N.

Even K=1: if R < N, the defender's rice runs out mid-battle —
          "you have no rice!" instant defeat from a single attack.
```

A garrison of 100 men needs **100 rice in stockpile just to survive a single full-length attack**, 300 to survive three, etc. The defender's logistics burden scales **linearly in BOTH the garrison size AND the count of attack vectors**.

### Worked example: a 3-province exhaustion attack

```
Target province T: 100 defenders, R rice.
Attacker controls A, B, C all adjacent to T, each with ≥ 10 rice.

Turn 1: Send 10 men + 10 rice from A → T.
  Attacker maneuvers (doughnut-style tactical map) for 31 days.
  T consumes ~100 rice over the battle.

Turn 2: Send 10 men + 10 rice from B → T.  Another ~100 rice gone.

Turn 3: Send 10 men + 10 rice from C → T.
  If R was initially < 300, T runs out mid-battle. Instant defeat.

Cost: 30 attacker men + 30 rice. Required defender rice: ≥ 300.
```

### The counter — forcing decisive engagement

The strategy depends on the attacker being able to **maneuver away from contact** for 31 days. If the defender can corner the attackers and force combat resolution, the strategy collapses — the small attacking force gets crushed before any rice ticks down.

So viability depends on **two topology variables**:

1. **Strategic-level**: K adjacent enemy provinces (more = more attack vectors)
2. **Tactical-level**: the fief's tactical-map geometry — doughnut/chokepoint shapes that *allow* the attacker to evade contact, vs. tight open maps that *force* engagement

**Beautiful symmetry**: doughnut fiefs are strong on *both* offense and defense. Same geographic feature, different role. The defending army uses doughnut shape to evade a larger attacker; the attacking army uses doughnut shape to evade a stronger garrison while running down their rice clock.

### Strategic implications

1. **Defender's required-rice scales as `K × N`**. A centrally-located province with K=4 attack vectors and N=100 men needs 400 rice in stockpile to survive coordinated assault. **Geography is economics.**

2. **Pyrrhic-conquest recursion**: the captured province inherits depleted rice, making it vulnerable to the same trick from adjacent enemies.

3. **The 31-day limit IS the dominance-frontier mechanism.** Not a random kill switch — a *deterministic resource clock*. Time replaces RNG as the closing mechanism.

4. **The province adjacency table at bank-4 `$8300`** (chapter 12) plus the rice consumption model lets us compute per-fief vulnerability:

```
vulnerability(T) = K_T × N_defenders / R_stockpile
```

A score ≥ 1 means a coordinated K-attack assault can exhaust the defender. Computing this for all 17 fiefs is appendix work — but that ranking *is* the strategic-frontier picture for the conquest phase.

### The deeper design lesson

The rice mechanic models supply chains with **just two primitives**: linear man-day consumption + a 31-day hard deadline. Yet from those alone emerge logistics planning, geographic vulnerability scaling, the exhaustion-vs-engagement counter-strategy pair, pyrrhic-conquest recursion, and a real skill ceiling (knowing when to attack vs invest in rice).

That's the same compress-to-strategic-essence pattern visible across the vault: *M.U.L.E.*'s 4 commodity prices producing economic depth; Catan's 11 number tokens × 19 hexes producing combinatorial richness; Connect Four's one-mechanical-constraint producing deep tactical play. **Mechanical depth scales with the right primitives, not with the count of primitives.** A 1989 strategy game gets the strategic richness of a supply-chain simulation from two numbers and one threshold.

### Connection to vault frames

- **Dominance-frontier counter-graph** (the project's stated goal): this is exactly the kind of non-obvious counter-edge the project was designed to surface. The edge isn't on the men-vs-men axis — it's on the **rice-vs-time axis**, an orthogonal dimension.
- **Configuration-axis randomness**: like Catan's board, NA's strategic randomness lives in *which provinces border which* — not in dice. Once the map is set, the strategy is computable.
- **Asymmetric attrition / rubber-banding**: small high-mobility forces decisively beating large garrisons via the orthogonal axis. Rubber-banding-by-resource-asymmetry.

## Errata to the original open-items list

The 2026-05-20 walk-through revealed the six "damage sub-handlers" from `$AFE1` aren't damage formula components — they're combat infrastructure:

| Sub | Actual purpose |
|---|---|
| `$8903` | unit-position iteration / setup (calls `$82DB` cell-coord check) |
| `$8977` | per-fief CHR-RAM tile upload (pushes PPU `$1570` dest + ROM `$9F6E` source) |
| `$92CA` | **supply attrition** — reads/depletes defender's gold (`$7001+idx×26+0`) and rice (`+6`) |
| `$8D39` | prints `\nFief %2d` header |
| `$8B39` | prints `\nDay  %2d` header per day |
| `$ADD1` | clears 5-byte casualty buffer at `$7BEE-$7BF2` |

The movement system is `$9B08 → $99D2 → $97D9 → $9792`, with `$9792` running a 4-check gauntlet (`$8FEC` range, `$9019` feature-flag, `$9735` enemy-scan-via-native-`$8003`, `$970A` bounds). Each unit per turn picks a random target cell via `rand%5, rand%11` and the gauntlet decides whether to move.

**The damage-value computation itself lives in native 6502 at bank-2 `$8003`** — `$9735` calls it with three word args per attack and the result feeds `$830B`'s /30 accumulator. We can't see the multiplier chain via VM disassembly because it's not VM bytecode. To extract the formula:

1. Set a Mesen breakpoint at PC `$8003` while in combat
2. Log register state + zero-page (`$0050+` syscall args, `$6F7D+N×6` unit records, `$6FD0+N×5` displayed records, `$7001+idx×26+16..22` stat quad)
3. The multiplier chain decodes from data flow in ~100-300 native instructions

This is the kind of architectural choice Koei would make: combat damage is per-unit-per-day on the critical path (up to ~310 evaluations per battle); strategic-engine commands are one-per-keypress slow path. Putting the hot loop in native saves ~50× CPU vs VM dispatch.

## Method note — what worked, what's deferred

**Static disassembly carried 80% of the chapter** — the `/30` design, the day-driver shape, the 31-day limit, the supply attrition, the movement gauntlet, the strategic implications of the rice mechanic. None of this needed runtime.

What's deferred: the **damage formula coefficients** (men × morale × skill × terrain × leader × pct / N). That's a native-code walk or a targeted Mesen trace — clean appendix work whenever the user wants to capture a combat exchange.

The big payoff: with what we now know about the rice mechanic and the adjacency graph, **the strategic-frontier picture for NA's conquest phase is computable from data we already have**. The exact damage formula is a refinement, not a blocker. The hidden mechanics that drive the dominance-frontier counter-graph are surfaced.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

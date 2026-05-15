---
status: active
created: 2026-05-14
---
# Chapter 15 — The Tactical Map: Where the Battle Lives

> Chapter 14 framed combat from a trace, but placed the engine in the wrong bank. Static disassembly fixes that: combat is in **bank 2**, not bank 0, and the bank-2 region `$8200–$83C6` holds a clean **modular combat engine** — fifteen small bytecode subs, each doing one job. From that engine the per-fief tactical-map data is reached through a single cell-address formula in `$DC88`, which loads the literal `$A57E` and multiplies the fief index by 55. So **each fief's tactical map is 55 bytes (11 × 5 cells) starting at bank-2 `$A57E`**. Chris's defensive archetypes — the doughnut-fief, the chokepoint fiefs — live as 55-byte data records in this table. This chapter locates them, the unit-data table, and the engine's structure; the per-cell damage math is chapter 16.

**Links:** [Chapter 14 — Combat Overview](./14-combat-overview.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Nobunaga README](./README.md)

## Correction to chapter 14: combat is in bank 2

Chapter 14 treated `$828B / $82DB / $827E` as bank-0 native code because the AI's war path is in bank 0. Static reading found these aren't bank-0 code at all — their bytes at bank-0 offsets don't disassemble cleanly. The trace's `$EB7A` calls land in those CPU addresses **after a bank switch** — and bank 2 at those addresses contains real `20 23 E8` bytecode-subroutine stubs. So:

> **The combat engine is a set of bytecode subroutines in bank 2, reached after the war driver switches that bank in.** The bank-0 `$821E` we found earlier is the *war driver* (orchestration), not the combat engine itself.

Bank 2's combat region is a clean cluster of bytecode stubs:

| Sub | Frame | Role (best read so far) |
|---|---|---|
| `$822A` | −2 | combat-screen entry / main orchestration |
| `$8270, $827E` | 0 | small helpers |
| **`$828B`** | 0 | **unit-address calculator (`addr = $6FD0 + idx × 5`)** |
| `$829A` | 0 | sibling calculator (base `$6FDA`) |
| `$82A9, $82B9, $82C9` | 0 | further address-arithmetic helpers |
| **`$82DB`** | 0 | **cell-coord bounds check (x ≤ 10, y ≤ 4) → calls cell reader** |
| `$82FF, $830B, $836A` | 0/−8/−4 | mid-tier handlers |
| `$838F, $83A2, $83C6` | 0/0/−2 | more helpers |

Most of these are frame-offset 0 — meaning they take their inputs entirely through positive frame slots (arguments pushed by the caller) and use no own locals. That's the signature of a small, function-style helper, which is exactly what a combat engine wants: cheap, composable primitives.

## Unit data — SRAM `$6FD0`, 5 bytes per slot

`$828B`'s entire body is eight bytecode instructions:

```
$8291 setB 5             ; regB = 5
$8292 mul                ; regA = idx * 5
$8293 loadB_local +0x0D  ; regB = an offset argument
$8294 add                ; regA = idx*5 + offset
$8295 loadB $6FD0        ; regB = $6FD0 (the table base)
$8298 add                ; regA = idx*5 + offset + $6FD0
$8299 vm_return
```

`$828B` is a **pure address calculator** for **a 5-byte-per-record table at SRAM `$6FD0`**. Five bytes per slot, five slots per side: the army's per-unit data fits in 25 bytes on each side, 50 total. The 5-byte record presumably holds *current men count, unit type (0–2: Rifles/Infntry/Cavalry), position (x,y on the 11×5 grid), and one flag/morale byte*. Per the chapter-14 unit model: slot 0 is the commander and slots 1–4 are the four composed type units.

`$829A` is the same calculator with base `$6FDA` (= `$6FD0 + 10`). Two interpretations:

- The two bases address **opposite-side unit tables** (attacker vs defender) at the same stride. If each side's table is 25 bytes (5 slots × 5 bytes), the second base would be `$6FE5`, not `$6FDA`. So this reading needs adjustment.
- More likely: **each unit has two record halves** at offsets 0 and +10, accessed independently. `$828B` reads/writes the "primary" 5 bytes; `$829A` reads/writes the "secondary" 5 bytes. With 10 bytes per unit × 5 slots × 2 sides = 100 bytes, the layout fits the surrounding SRAM cleanly.

Either way, the **base is `$6FD0` and the per-slot stride is 5** — that's locked.

## The tactical map — 11 × 5 cells, 55 bytes, bank-2 `$A57E`

The cell reader's wrapper `$82DB` opens with two bounds checks:

```
setB 10   cmp_ugt   branch_nz exit   ; bail if x > 10
loadA_local +0x0D   setB 4   cmp_ugt   branch_z proceed   ; bail unless y > 4 fails
... clearA; vm_return                ; bail path
... proceed: host_call $DC88(x, y)
```

Valid input: **x ∈ {0..10}, y ∈ {0..4}** — i.e. **11 columns × 5 rows = 55 cells**. That's the entire battle map per fief.

And inside `$DC88` (bank 15, the cell reader), the cell-address formula is exposed by a literal `loadB_imm_word $A57E` combined with `setB 55; mul`:

```
cell_addr = (province_idx × 55) + $A57E + cell_offset
```

So the **per-fief tactical maps are packed at bank-2 `$A57E`, 55 bytes each**:

| Province | Address |
|---|---|
| 0 (Noto) | `$A57E` |
| 1 (Echigo) | `$A5B5` |
| 7 (Mikawa) | `$A6FF` |
| 15 (Shinano) | `$A8B7` |
| 16 (Owari) | `$A8EE` |
| 17 (last) | `$A925` end |

17 fiefs × 55 bytes = 935 bytes; the table runs `$A57E – $A925` in bank 2.

## The cells are tile indices, not terrain enums

A first reading of the 55-byte records hoped for small terrain codes (0 = plains, 1 = woods, etc.). The actual values span the full byte range (0–255) and form recurring multi-byte patterns: e.g. Fief 2 (Echigo) contains the repeated subsequence `170 232 123 233` four times in 55 bytes. That's the signature of **graphics tile-index data** — each cell stores which 8×8 CHR-RAM tile to draw, and the *terrain semantics* are implicit in which tile-cluster the renderer recognizes.

| Fief | Distinct cell values |
|---|---:|
| 1 Noto | 35 |
| 2 Echigo | 27 |
| 8 Mikawa | 36 |
| 9 Mino | 25 |
| 16 Shinano (Takeda's mountains) | 39 |
| 17 Owari (Oda) | 35 |

Shinano's high variation matches its historical mountainous terrain; Mino's lower count suggests a more uniform plain. Mapping the exact tile-index → terrain (woods, plains, river, castle, etc.) is a one-pass project: the tile-rendering code (the `$DC66`/`$DC88` cluster combined with the `$8888`/`$3C3C`/`$00FF` tile bitmaps we found in bank 12, which is the CHR-RAM source) will reveal which tile means what. That's appendix material, not load-bearing for the combat engine.

What matters for the strategy counter-graph the project is building: **the doughnut-fief and chokepoint-fief archetypes Chris described from the project's start exist as concrete 55-byte records in this table.** Once the tile-to-terrain map is decoded, every fief's tactical map can be rendered and the asymmetric defensive advantages catalogued.

## Combat engine flow, revised

With the bank-2 placement and the map data location, the combat structure refines:

```
   AI war path (bank 0) -- declares war
        |  bank-switch to bank 2
        v
   $822A (bank 2) combat-screen entry        [chapter 14: $81FC was a label in here]
        |
        v
   map setup: for each cell (x,y) in 11x5:
        $82DB (bounds check) -> $DC88 (read $A57E[idx*55 + y*11 + x]) -> render
        |
        v
   day loop (per day):
        unit-action inner loop ($828B family on $6FD0 unit data)
            damage math:  $827E -> $838F -> $D70D (percentage)  +  $CA52/$CA46 (RNG)
        end-of-day check: supplies, casualties, leader, retreat
        |
        v
   ending: print one of the four messages (ch 14) + resolution
```

`$828B`'s 1 005-hit trace count now reads as **1 005 unit-record address computations** — every time the engine reads or writes a unit's slot, it goes through this calculator. That's the price of encapsulating the table base in a single sub: one helper call per access, but only one place in the code to change if the table moves.

## What's open

- **`$822A` walked end to end** — what its bytecode actually orchestrates. The chapter-16 deep dive starts here, since `$822A` is the combat *entry from inside bank 2* (the AI's war path host_calls it after the bank switch).
- **The damage formula**, validated against the day-4 and day-5 exchange numbers Chris gave (3-unit attacker 8 → 6, 2-unit defender 5–6 → 0–2; then 3-unit attacker 5 → 3, 3-unit defender 6 → 2). The `$827E → $838F → $D70D` triple plus the `$828B` unit reads is the call shape; reading them tells us `(strength, type, terrain, RNG) → casualties`.
- **The cell tile-index → terrain map.** Disassembly of `$DC66`/`$DC88`'s renderer plus the bank-12 CHR-RAM tile data will pin which byte means woods, mountain, river, castle, etc. Once decoded, all 17 fief maps can be rendered and the doughnut/chokepoint archetypes located in the data.
- **The 5-byte unit record's field layout.** A targeted memory-watch trace of `$6FD0–$6FF3` across a single attack exchange would expose which byte stores the men count (the one that drops from 8 to 6 in your day-4 exchange).

## Method note — when the trace points to the wrong bank

Chapter 14 had the engine in bank 0 because that's where the trace's CPU addresses *look* like they should resolve. The mistake: `$EB7A`'s indirect JMP resolves through `ptr0` to a CPU address whose meaning depends on the *currently mapped bank*, not on where the calling code lives. The fix was to inspect the raw bytes at the target CPU address in every bank and find which one has a coherent bytecode stub. Worth recording as a project lesson: **for any indirect-call target in `$8000–$BFFF`, check all 15 banks before claiming a placement.**

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

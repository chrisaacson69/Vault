---
status: active
created: 2026-05-20
---
# Chapter 16 — The Render Pipeline: How a Tactical Map Becomes Pixels

> Chapter 15 stopped at "the per-fief tactical map is a 55-byte cell-index array at bank-2 `$A57E`" but couldn't decode what those bytes *meant*. This chapter takes a 1-MB filtered Mesen trace of a battle scene-build, walks the bytecode statically alongside it, and a paused-game SRAM dump from Mino (fief 9) — together they reconstruct the entire render pipeline end-to-end: from the cell-byte in ROM, through the SRAM staging buffer at **`$7B4E`**, through the metatile dictionary at `$B100`, to the per-row PPU writes that paint the screen. The chapter also surfaces the **isometric stagger** baked into the buffer (odd columns offset +8 bytes), the **`$C2`-bit feature-flag encoding** in the cell array, and a confirmed **terrain dictionary** (A=clear, B=forest, C=mountain, D=town, F=castle) verified against six independent landmarks in Mino. The 55-byte fief array is now translatable into a rendered map — the doughnut-fief, the chokepoint terrain, the diagonal mountain ridges, all locatable as concrete bits in concrete bytes.

## Errata applied 2026-05-20 (from Mino paused-state validation)

Three corrections to the model first published in this chapter on 2026-05-20:

1. **Staging buffer base is `$7B4E`, not `$7BFD`** — off by 175 bytes. The bytecode disassembly at `$8865-$8878` shows `loadB_imm_word $7BFD`, but the actual buffer in SRAM starts $AF earlier. The discrepancy is probably a misread of one frame-local offset in the calculator; the 88-byte column stride and the metatile structure are otherwise unchanged.
2. **Odd columns are shifted +8 bytes (isometric stagger)** — the "8-byte trailer per column" I hypothesized is actually the *missing half-cell at the column top/bottom* caused by the staggered isometric layout. Adjacent columns interlock like bricks; the data structure mirrors the visual.
3. **`$6FFE` is NOT the viewport section variable** — the live SRAM there holds `$2400`, not a small section number. The actual viewport tracker is still being hunted. Likewise, **`$7BE8` is inside the staging buffer**, not a separate reachability buffer.

Sections [3] and [5] below have been rewritten against these corrections. The remainder of the model — the metatile dictionary at `$B100`, the renderer chain, the cell-byte two-encoding hypothesis — stands.

**Links:** [Chapter 15 — The Tactical Map](./15-tactical-map.md) · [Chapter 4 — Syscall API](./04-syscall-api.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Nobunaga README](./README.md)

## The pipeline, in one diagram

```
   ROM bank 2 (or other data bank)                    SRAM ($6000-$7FFF)
   ───────────                                        ──────────────────
   $A57E + fief×55    ──[1]──→  cell-byte (1 B)
                                       │
                                       │ bits 7,6,1 ($C2)
                                       │ ────────────────[5]───→ feature-flag scan (separate buffer)
                                       │
                                       │ bits 5-2,0 (metatile id, hypothesis)
                                       ▼
   $B100-$B17D       ──[2]──→  metatile dict (16 B/entry)
                                       │
                                       ▼
                                $7B4E + col×88 + stagger    SRAM staging buffer
                                       │                     (11 cols × 88 B = 968 B,
                                       │                      odd cols +8 byte stagger)
                                       ▼
                                  ──[3]──→  via $CBBD → syscall_dispatch
                                       │
                                       ▼
                                 $C4E0  syscall_ppu_render_rect (native)
                                       │
                                       ▼
                                 $C480  PPU row uploader (native)
                                       │
                                       ▼
                                 PPU $2000+   visible nametable
                                              + unit overlay (5-byte unit records at $6FD0)
```

Each numbered arrow corresponds to one of the sections below.

## [1] The cell-byte: bits 7-6-1 = features, bits 5-2-0 = metatile id

Chapter 15 dumped fief 11 (Omi) and found bytes like `179` (=$B3), `232` (=$E8), `123` (=$7B) for what Chris identified as castle, town, mountain. The values span the full byte range and don't form a clean 0..N enum — that's because the byte is **two encodings packed in one**.

The proof is at bank-2 `$A24A-$A263`, the pathfinding scan inside subroutine `$A221`:

```
$A251  host_call $DC88        ; reads cell-byte from $A57E + fief×55 + idx
$A255  loadB_imm_word $00C2   ; regB = $C2  (= %11000010)
$A258  bitand                 ; regA &= $C2
$A259  branch_z $A262         ; if (cell & $C2) == 0:
$A25C    loadA_imm_word $0080 ;   regA = $80   (one branch)
$A262  clearA                 ; else: regA = 0  (other branch)
$A263  storeA_ind_byte        ; write the resulting byte into [regB]
```

The mask `$C2 = 1100 0010` extracts bits 7, 6, and 1. If *any* of those is set, the routine writes `$80` (i.e. "this cell has a special feature"). Otherwise it writes `$00`.

This is **the feature scan** — what `$A221` does is read all 55 cells of the fief and build a 55-byte buffer of "is this cell special?" flags at `$7BE8+`. The buffer drives pathfinding (units can't enter fortress cells without bribing; rivers block movement; etc.).

The remaining five bits (`$3D = 0011 1101`, bits 5-4-3-2-0) form a 5-bit value with 32 possible patterns — exactly the right size for indexing a per-fief **metatile dictionary**. That's the second encoding.

This is also why the cross-fief comparison from chapter 15 hit "232 = town AND 232 = mountain in Omi" — bytes with the same low 5 bits but different high bits *would* render the same metatile but with different feature flags. They are the same shape, just one is a town and the other a passable mountain.

## [2] The metatile dictionary at bank-2 `$B100-$B17D`

Static search for the 16-byte signature `82 83 86 87 84 85 88 89 8A 8B 8E 8F 8C 8D 90 91` (one of the metatile patterns we observed in the combat trace) found it at bank-2 `$B15E`. Adjacent 16-byte aligned slots hold the other patterns:

| Entry | Address | First 8 bytes | Probable terrain |
|---|---|---|---|
| #-2 | `$B100` | `12 13 17 19 18 1A 17 18` | UI/border (uses fixed tiles $10-$1F) |
| #-1 | `$B110` | `13 14 14 18 1B 18 1B 1B` | UI/border continuation |
| #0  | `$B11E` | `63 64 67 68 65 66 69 6A` | per-fief F |
| #1  | `$B12E` | `A2 A3 A6 A7 A4 A5 A8 A9` | per-fief B (mountain-like) |
| #2  | `$B13E` | `73 74 77 78 75 76 79 7A` | per-fief D |
| #3  | `$B14E` | `92 93 96 97 94 95 98 99` | per-fief C |
| #4  | `$B15E` | `82 83 86 87 84 85 88 89` | per-fief A (castle-like) |
| #5  | `$B16E` | `57 58 5B 5C 59 5A 5D 59` | per-fief E |

Each entry is **16 bytes** = a 4×4 NES-tile metatile, laid out as four rows of four tiles. The per-fief entries (#0-#5) reference CHR-RAM tiles in the range `$57-$B1` — the same range the combat-init bulk-uploads from ROM `$A05E+` (115 tiles, chapter trace evidence). The UI entries (#-1, #-2) reference fixed tiles `$10-$1F` that don't change per fief.

After the metatiles, the region continues with **attribute table data** at `$B17E-$B195` (20 bytes of palette indices in groups of 4 — one quad per metatile, matching the NES PPU's 2×2-tile attribute granularity) and a **pointer table at `$B196+`** with little-endian addresses into `$B1D8-$B4C8`. The pointer table is the next mystery — likely per-fief variant dictionaries, or unit-graphic patterns, both possibilities still open.

The hot subroutine `$CBBD` shows up *27 times* across the codebase. That's because it's the **VM→syscall bridge** — not the renderer itself, just a thin wrapper that marshals VM arguments into the syscall parameter block at `$0050-$0065` and invokes `syscall_dispatch` ($F226). The underlying syscall is `$C4E0 = syscall_ppu_render_rect`, labeled by chapter 4's syscall sweep as the **"2D nametable region renderer ... used for menu borders, status panels, *map sections*."**

## [3] The SRAM staging buffer at `$7B4E`: 11 × 88 = 968 bytes, with isometric stagger

The combat trace showed every per-cell render reading 16 bytes from SRAM. The paused Mino dump confirms the buffer location and structure:

**Address formula** (verified against a paused dump from Mino):

```
cell_addr = $7B4E + col × 88 + (col & 1) × 8 + row × 16
```

Where:
- `col` ∈ [0, 10] = column index across the full 11-wide fief
- `row` ∈ [0, 4] = row within the column
- `(col & 1) × 8` = **the isometric stagger** — odd columns are shifted 8 bytes (= 2 NES tile rows = half a cell vertically)

**Column layout** (even col vs odd col):

```
Even col (0, 2, 4, 6, 8, 10):      Odd col (1, 3, 5, 7, 9):
  +0  ..+15   cell at (col, 0)       +0  ..+7   trailer of previous col / blank
  +16 ..+31   cell at (col, 1)       +8  ..+23  cell at (col, 0)
  +32 ..+47   cell at (col, 2)       +24 ..+39  cell at (col, 1)
  +48 ..+63   cell at (col, 3)       +40 ..+55  cell at (col, 2)
  +64 ..+79   cell at (col, 4)       +56 ..+71  cell at (col, 3)
  +80 ..+87   8-byte blank trailer   +72 ..+87  cell at (col, 4)
```

The 8 "trailer" bytes are always `01 01 01 01 01 01 01 01` — those are the *missing half-cell* at the column extremes caused by the stagger. In an isometric brick layout, the very top of even columns and the very bottom of odd columns (or vice versa) reach above/below the playfield; those positions get filled with blanks.

11 × 88 = 968 bytes total, spanning **`$7B4E-$7F15`** in SRAM.

### The bytecode address calculator (with erratum)

Bank-2 `$8865-$8878` computes the address. The 2026-05-20 erratum: my published reading had `$7BFD` as the base literal, but the buffer is actually at `$7B4E`. The disassembly is being re-examined; the most likely cause is that I misread one of the frame-local offsets in the multi-step compute (the `+88 mul` and `+88 col` interactions). The 88-byte stride and the column-major structure are unaffected.

### Viewport sections (mechanism known, variable not yet identified)

Chris's in-game observation of three overlapping 5×5 viewport sections is real — the visible-window logic page-flips between cols 0-4, 3-7, and 6-10. The variable that drives this *isn't* `$6FFE` (which holds `$2400` in the paused state — too large to be a 0/1/2 section selector). The actual section variable is still being hunted; it's likely a different SRAM byte set by the scroll-input handler.

## [4] The render syscall ($C4E0) and what the VM hands it

The bytecode in bank 2 (around `$8800-$88FF`) pushes arguments — start (x,y), end (x,y), source pointer, per-tile parameter — onto the VM data stack, then `host_call`s a sub that ultimately reaches `$CBBD`. `$CBBD` itself is a tiny 11-instruction wrapper that copies the args into the syscall parameter block and invokes `$F226` (syscall_dispatch):

```
$CBBD-$CBC5  storeA/storeB to frame +$3C..$3F  ; marshal args
$CBC8        host_call $F226 (syscall_dispatch)
$CBCC        vm_return
```

`syscall_dispatch` then routes to the syscall handler via the dispatch table at `$C173`. For map rendering, the target is `$C4E0 = syscall_ppu_render_rect`, which:

1. Reads start (x,y) and end (x,y) from struct slots 6/8/10/12
2. Loops over every (x,y) in the rectangle
3. For each cell, calls helpers `$C640` (compute PPU address), `$C673` (compute attribute), `$C711` (write byte)
4. The write helper drives the per-row PPU uploader at `$C480` (chapter's title-screen walk)

The end result is what the trace recorded: 4-byte row uploads to PPU `$2080+`, source `$7BFD+`, 220 calls per full map paint (55 cells × 4 rows/cell).

## [5] The pathfinding buffer and the unit overlay (architecture confirmed)

`$A221`'s `$C2`-mask scan really does write feature flags to a separate buffer — but **that buffer isn't at `$7BE8`** (the paused Mino dump shows `$7BE8` is inside the staging buffer at col 2 cell 4). The reachability buffer must live at a different SRAM address; finding it requires either disassembling further into `$A221` to extract the actual destination pointer, or tracing the writes during a unit-move event. Either is an appendix task.

**The architectural separation is now clean**, validated by the Mino paused dump:

- **Terrain layer** — SRAM `$7B4E + col×88 + stagger`. 968 bytes. Pure metatile patterns. Never modified during a battle except for rare terrain-change events (rivers crossed, bridges destroyed, walls breached). Every cell in the Mino dump decoded as a clean metatile from the dictionary — no unit bytes mixed in.
- **Unit layer** — SRAM `$6FD0+`, 5 bytes per slot, 10 slots = 50 bytes per side. Holds position, type, current HP. Modified after every unit action.
- **Render-time composition** — the renderer (`$C480` via `$C4E0 = syscall_ppu_render_rect`) reads the terrain from `$7B4E+`, then stamps unit graphics from the unit records over specific cells. The composite is what reaches the PPU nametable.

### Unit overlay format (decoded from the live tilemap viewer)

Each unit renders as **8 NES tiles arranged 4 wide × 2 tall** — exactly the *bottom half* of a 4×4 metatile cell. Units always occupy the lower half of their cell, so the top half always shows the underlying terrain. **One unit per cell maximum** — units do not stack:

```
Cell layout (4×4 NES tiles, top to bottom):

  Row 0:  terrain  terrain  terrain  terrain    ← top half of metatile (always visible)
  Row 1:  terrain  terrain  terrain  terrain

  Row 2:  [unit #] [flag 0] [flag 1] [flag 2]   ← bottom half: unit overlay if present
  Row 3:  [blank]  [blank]  [tens]   [ones]        else terrain (rows 2-3 of metatile)
```

The two blanks in the bottom row likely reserve slots for thousands and hundreds digits when a unit's strength exceeds 99 — the engine internally tracks strength in real soldiers (with the /30 displayed-strength multiplier from chapter 14), so 100+ counts are reachable.

This "terrain on top, unit on bottom" composition means the player can always see what terrain a unit is standing on — useful for reading the strategic situation at a glance. It also halves the visual real estate the unit takes, keeping the map dense.

**Tile assignments** (confirmed against the running game):

| Tiles | Role | CHR region |
|---|---|---|
| `$08 – $11` | digits 0-9 | fixed CHR (never re-uploaded) |
| `$51 – $53` | attacker flag (3-tile glyph) | fixed CHR |
| `$54 – $56` | defender flag (3-tile glyph) | fixed CHR |
| `$57 – $B1` | per-fief terrain metatiles | per-fief CHR upload from ROM `$A05E+` |
| `$B2` | attacker leader marker | per-fief CHR (top of range) |
| `$B3` | defender leader marker | per-fief CHR |

This explains the **per-fief CHR upload range** more precisely: it's tiles `$57-$B3` (= 93 tiles, not the rough ~115 estimate from earlier). Below `$57` is the **fixed bank** (digits, characters, both flags, blank, HUD). Above `$B3` is also fixed (characters and remaining UI).

### Mapping the trace's non-metatile clusters

The non-metatile byte clusters that appeared in the rendered nametable in the combat trace decode cleanly as unit overlays:

- `0D 51 52 53` = unit "5" (digit `$0D` = `5` in the digit range starting at `$08`) wearing the **attacker flag**
- `0D 54 55 56` = unit "5" wearing the **defender flag**
- `B2 xx xx xx` (with leader marker) = attacker leader's cell
- `B3 xx xx xx` = defender leader's cell

Every unit-rendered cell is identifiable from the nametable bytes alone — no separate unit-overlay table read is needed to find them. That's a useful invariant: **you can scan a rendered nametable for `$51`/`$54`/`$B2`/`$B3` to locate every unit position**.

### Why the combat trace had 544 row uploads

That's exactly **2-3 full scene repaints** (55 cells × 4 row-uploads/cell = 220 calls per paint). The initial paint + per-day repaints as units moved on the board.

## Putting it all together: a worked example (validated against Mino)

A paused-state SRAM dump from Mino (fief 9, 1-based = index 8, 0-based) was decoded against this model on 2026-05-20. Every cell in the 11×5 grid resolved cleanly to a known metatile pattern from the `$B100` dictionary:

**Terrain dictionary** (cross-validated against Chris's hand-mapped Mino landmarks):

| Metatile | Tile cluster | Terrain | Validation |
|---|---|---|---|
| **A** | `82-91` | clear | bottom-row clear lanes match Chris's description |
| **B** | `A2-B1` | forest | border cols (0-2 and 10) match Chris's edge-forest pattern |
| **C** | `92-A1` | mountain | (r2, c6) = mountain between fortress and town ✓; diagonal (0,8)→(3,3) ✓ |
| **D** | `73-81` | town | (r3, c6) = town ✓ |
| **F** | `63-72` | castle | (r1, c6) = castle ✓ (Chris's "fortress" position — castle in NA terminology) |

(`$B100`'s entries `#-1`/`#-2` use fixed CHR tiles `$10-$1F` and are border/HUD metatiles, not terrain. The dictionary slot at `$B16E` (terrain "E") didn't appear in Mino — likely a river or shrine seen in other fiefs.)

**Decoded Mino battle map** (5 rows × 11 cols, with isometric stagger):

```
       c0   c1   c2   c3   c4   c5   c6   c7   c8   c9   c10
  r0:  cler cler cler frst frst frst frst frst mtn  frst frst
  r1:  frst frst mtn  mtn  frst frst CSTL mtn  mtn  frst frst
  r2:  frst frst frst frst mtn  mtn  mtn  cler mtn  mtn  frst
  r3:  frst frst frst mtn  mtn  cler TOWN cler cler cler frst
  r4:  frst frst frst cler cler cler cler cler cler cler frst
```

Six independent landmarks line up: fortress/castle at (c6, r1), town at (c6, r3), mountain barrier between them at (c6, r2), diagonal mountain ridge from (c8, r0) to (c3, r3), additional mountain band from (c2, r1) to (c4, r2), and clear forest borders on cols 0-2 and 10. **That's full validation of the staging buffer model AND the metatile-to-terrain mapping AND the column/row indexing.**

The 55-byte fief array at `$A57E + fief×55` (location TBD — in a non-bank-2 data bank we haven't pinned down) is no longer opaque. With this terrain dictionary, *every fief's tactical map can be decoded* once we identify which bank holds the data.

## What's still open (appendix material)

1. **Which bank holds the cell-index table** — the bank-2 bytes at `$A57E` turn out to be VM code, not data (confirmed by a paused-state dump showing `20 23 E8` = `JSR vm_entry` and other code patterns). The `loadB_imm_word $A57E` in `$DC88` computes a virtual address that gets passed to a bank-switching syscall; the data bank is hidden until we capture the syscall arg block at runtime. **Targeted Mesen breakpoint**: pause when `$C22C` (syscall_memcpy_banked) fires, read struct[2] = the bank number.

2. **The exact 55-cell expansion writer** — the bytecode that loops 55 times reading cell-bytes and writing 16-byte metatile patterns into `$7B4E+`. Neither `$9BB4` (unit-action resolver) nor `$A221` (`$C2`-mask path-find scan) is the right routine. **Targeted trace filter**: capture writes to `$7B4E-$7F15` during the moment combat starts.

3. **Verification of the bits-5-to-0 metatile index hypothesis** — strong inference from the byte distribution and the `$C2` mask. Confirmation needs an explicit test: now that the terrain dictionary is known (A=clear, B=forest, C=mountain, D=town, F=castle), pick a known cell-byte and decode its low 5 bits, then verify the rendered metatile matches.

4. **The pointer table at `$B196`** — 50-ish word pointers into `$B1D8-$B4C8`. Could be per-fief variant metatile dictionaries, unit graphic patterns, or attribute-override tables.

5. **The unit-overlay writer** — the code that stamps unit graphics on the rendered nametable. The terrain layer at `$7B4E+` is unit-free, so unit composition happens at render-time, not in the staging buffer.

6. **The actual viewport-section variable** — the three 5×5 page-views are real but `$6FFE` doesn't drive them. The actual section selector is at an unknown SRAM byte set by the scroll-input handler.

7. **The reachability buffer destination** — `$A221`'s `$C2`-mask scan writes flag bytes somewhere, but not to `$7BE8` (which is inside the terrain staging buffer). Where exactly the path-find scratchpad lives is open.

## Method notes

**Static disassembly beat trace capture this round.** With one filtered trace (1 MB, 11 K lines) confirming the *runtime shape*, every concrete address (`$7BFD`, `$A57E`, `$CBBD`, `$C480`) became findable in ROM, and from there `vm-disasm.py` followed control flow to the routines that touched them. The expansion table at `$B100` fell out of a 16-byte signature search in the ROM in one command. Adding a second trace would have shown the same routines running again — static analysis spared the cycle.

**The two-encoding cell-byte structure is the find of the chapter.** Once `$A221`'s `$C2` mask was decoded as "feature flag" rather than "terrain enum", the rest of the byte (5 bits) revealed itself as a metatile index. This is the lens that resolves chapter 15's cross-fief ambiguity ("232 = town and = mountain"): identical low bits → identical metatile pattern; different high bits → different feature flags. Same shape, different role. A pattern probably worth recording — when bytes look "random" across a flat enum but the engine reads only specific bits, the byte is encoding multiple orthogonal concepts at once.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

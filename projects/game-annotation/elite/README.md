---
status: active
created: 2026-08-05
---
# Elite (NES) — `elite-decompiler`

> Pointer page (process-table entry) for the Elite NES reverse-engineering project. **Not a KOEI
> title** — this one exists to answer a single architectural question: *how do you draw a wireframe
> 3D game on a console that can only display 8×8 tiles?*

**Links:** the theory → [Arithmetic Scarcity and the 3D Problem](../../../research/gaming/arithmetic-scarcity-3d.md) ·
the NES siblings → [game-annotation series](../README.md) ·
platform reference → [NES Mappers](../../../research/nes/mappers-reference.md) ·
project SDK → [projects/CLAUDE.md](../../CLAUDE.md).

## Identity (resolve by logical name, never hardcode a path)

| Field | Value |
|-------|-------|
| Logical name | `elite-decompiler` |
| GitHub | `github.com/chrisaacson69/elite-decompiler` *(**PUBLIC**, pushed 2026-08-31)* |
| Sibling path | `../elite-decompiler` (resolved per-machine via vault `.claude/local-paths.md`) |
| Entry point | `README.md` → `docs/00-recon.md` → `mesen-labels.toml` |
| Upstream reference | `nes-elite-beebasm` (third-party, read-only — **point at it, don't vendor it**) |

## ROM

`Elite (World) (Unl).nes` — 131,088 B · **mapper 1 (MMC1)** · 128 KiB PRG (8 × 16 KiB) ·
**CHR-RAM** (CHR-ROM size 0) · battery-backed · `RESET=$C000 NMI=$CED5 IRQ=$CED4`.

## Status — scaffolded 2026-08-05

Recon complete; no original analysis beyond it yet.

- `docs/00-recon.md` — ROM identity, the rendering architecture, next questions
- `mesen-labels.toml` — **1,142 RAM symbols + 917 code labels across 8 banks**
- `source/asm/bank[0-7].asm` — ~81k lines of linear-sweep listing (the greppable native floor)
- `Elite (World) (Unl).mlb` — **1,701 Mesen labels**, auto-loads in the debugger beside the ROM
- `docs/02-conventions.md` — cross-bank `_bN` calling convention, thin routines, generated tables
- `docs/03-frame-architecture.md` — main-loop/NMI split, frame pacing, the VBlank cycle budget
- `tools/import_labels.py` · `tools/gen_mlb.py` · `tools/verify_rom.py`

### Reading notes (from a line-by-line pass over bank 7)

Three things that look like sloppiness and aren't, recorded in `docs/02`:

- **The cross-bank convention** — 85 `Name_bN` trampolines and 28 `.bankN` fast-path labels in bank 7
  alone. `Foo_b6` = "call `Foo`, paging in bank 6 *if it isn't already*". The apparent redundancy is
  forced: `.bankN` is the already-paged fast path, `storeA` exists because the MMC1 serial write
  **destroys A**, the outgoing bank rides the stack so calls nest, and `SetBank` brackets the 5-write
  sequence with a guard because **MMC1's shift register isn't atomic** — an NMI inside it corrupts the
  mapper. `ResetBank`/`ResetBankA`/`ResetBankP` differ only in preserving nothing / A / the flags.
  **Opposite style to the KOEI siblings**, though: Elite bakes the target bank into ~85 per-routine
  stubs, KOEI passes it as an argument to *one* generic `call_in_bank` (`$DCD1`) plus a banked
  `copy_from_bank` memcpy. KOEI shadows all five MMC5 windows in RAM (`$070C-$0710`); Elite tracks a
  single `currentBank` — both because the mapper registers are **write-only on both chips**. The
  structural driver: KOEI runs a **bytecode VM**, so banking can be handled centrally and the
  bytecode stays bank-agnostic; Elite is native throughout, so every call site carries its own.
  Specialization (fast path, no marshalling, 85 stubs of ROM) vs generality (tiny mechanism,
  runtime-computed bank — which a script-dispatching VM needs and Elite never does).
  And Elite barely uses the other classic answer: scanning all named routines finds only **four**
  verbatim cross-bank duplicates (`ZINF`, `XX21_NOISE`, `GetSystemImage1`, `SendToPPU2`).
- **Thin one-JMP routines are mostly long-branch trampolines**, not legacy. The 6502 branches ±127
  bytes; measured targets sit 140-332 source lines away. A small genuine residue of shims does exist
  (`StartEffect_b7 → JSR StartEffect_b6`).
- **`_MATCH_ORIGINAL_BINARIES` is not storage-vs-generation.** Both branches are *assembler-time* and
  the ROM is identical; the switch exists only to reproduce a **stray workspace byte** the 1991
  assembler left at the head of `log`/`logL`. Which is why `ACT` (arctan) has no literal variant — its
  formula reproduces the bytes exactly. The `EQUB`s are the observation, the `FOR` loop the derivation:
  create-then-check wired into the build.

### Frame architecture (`docs/03`)

**No fixed frame rate, no 30 fps interleave.** The main loop rasterizes free-running at whatever
rate the scene allows; the NMI fires at 60 Hz regardless and uploads what it can. They meet only at
`WaitForNMI` (28 call sites). So a heavy scene is slow *twice* — more tiles to rasterize, and a
bigger pattern set that **spills its upload across multiple VBlanks**.

`ADD_CYCLES`/`SUBTRACT_CYCLES` maintain `cycleCount`, a **cooperative deadline budget** with
hand-computed static costs: each chunk *reserves* its cost before running and bails (refunding via
`ADD_CYCLES`) if the budget would go negative, resuming next VBlank.

**Heavy frames drop the rate; they never tear.** The two buffers aren't front/back copies — `pattBuffer0`
feeds PPU **bitplane 0** and `pattBuffer1` feeds **bitplane 1**, and Elite spends that second bit not on
colour but as a *hidden page*: `SetPaletteForView` maps one plane's palette entry to `hiddenColour`
(black) and the other's to `visibleColour` (cyan), so **the frame under construction is drawn in black**
and is invisible while it builds. `FlipDrawingPlane` swaps the roles — **the page flip is a three-byte
palette write to `$3F01`**. Nothing is copied, nothing tears, the whole frame appears at once; a slow
frame just flips later while the PPU keeps re-showing the last complete one. (Hence `lastPattern` being
two bytes — the planes ride different frames' upload schedules.) The price is colour depth: two planes
would buy 3 ink colours, spending one on double-buffering leaves **one ink colour plus black** — exactly
the right trade for monochrome wireframe.

**Why not display tiles incrementally instead?** Because `firstFreePattern` is a per-frame bump
allocator, **pattern numbers are re-bound every frame** — pattern 47 is hull this frame, station the
next. Nametable and pattern table are only meaningful *together*, so partial upload doesn't blend two
valid pictures, it pairs an index from one frame with pixels from another: garbage, not patchwork.
Making it coherent would need stable cross-frame tile→pattern binding — a real allocator with liveness
and a free list — i.e. paying more per frame for a worse result. The engine marks the boundary itself:
incremental upload *is* used for the **icon bar** (`barPatternCounter`, four patterns per NMI call),
which is safe precisely because it's static. Incremental where content doesn't change; atomic flip
where it does.

And the budget is not VBlank — **the NMI blanks the screen** (`PPU_MASK = 0`) for the whole upload
and restores it after, so the real constraint is how long the display may stay blank. Converted to
scanlines the two constants line up: NTSC 6,797 ≈ **60 scanlines**, PAL 7,433 ≈ **70** — both ~22.5%
of their region's frame. PAL's VBlank *is* 70 lines so it steals no picture; NTSC's is only 20, so
the NTSC build blanks ~40 visible scanlines to buy the same window. **A heavy frame therefore blanks
more of the display** — a third cost channel beyond rasterize and upload.

Working hypothesis worth testing as the read continues: **the inefficiencies cluster in cold code**
(reset, init, memory clear) while the per-frame paths are tight (unrolled PPU streaming, log multiply,
sparse allocation). If so it's triage, not sloppiness — and the falsifier is a plodding construct on
the frame path.

**Deliberately not built: a reconstructed source.** A buildable, fully-commented source already
exists upstream and provably assembles to our exact bytes; regenerating one from the labels would
be a rebuild of a grounded artifact — worse than the original (it loses the prose commentary) and
verifiable only against the thing it copied. The rule here is **point at upstream for reading,
derive only what upstream doesn't have**. The `.mlb` is exactly that: upstream has no Mesen label
file, and it's a mechanical projection of data already held, so it's pure gain.

## The finding

The NES PPU has no framebuffer. Elite's answer, in three parts:

1. **CHR-RAM** — the cart ships writable pattern tables, so the pattern table can *be* a bitmap.
2. **The pattern table is the framebuffer.** `PPUCTRL = #$10` selects background patterns at
   `$1000`; the blitter's base pointer `$e0` is set to `#$10` in two places. Elite rasterizes into
   CPU RAM and streams into CHR-RAM through `$2007`.
3. **Sparse, dynamically-allocated tiles.** One pattern table is 256 patterns; the screen is 960
   cells, so a static "tile *N* at cell *N*" ramp is unaffordable. `LOIN` instead finds which tile a
   pixel lands in, reuses that tile's pattern if allocated, otherwise **grabs the next free pattern
   and assigns it**. Wireframes touch few cells, so you only materialize patterns where ink lands.
   Patterns are monochrome — 1 bit/pixel, 8 bytes each.

Same instinct as the rest of the [arithmetic-scarcity](../../../research/gaming/arithmetic-scarcity-3d.md)
family: don't pay for what you don't use.

## Why this target is methodologically useful

It has a **complete public answer key** — Mark Moxon's fully-labelled disassembly — whose NTSC build
is **byte-identical to our ROM across all 131,072 PRG bytes** (only 5 bytes of iNES header differ).
That makes it the cleanest available **create-then-check** target: derive from the ROM, then diff
against a ground truth that cannot be hand-waved.

It already paid out once. The CHR-RAM substrate and the `$1000` blit target were derived
independently from the ROM; the *dynamic allocator* was not, and would have been missed for a while
because it lives in the line routine rather than the init path. **The check bought the algorithm,
not the architecture** — a useful calibration on what blind work does and doesn't find.

## The cost model (`docs/01-rendering-architecture.md`)

The **entire 8 KiB cart PRG-RAM is the render target** — not save RAM that gets borrowed:
`pattBuffer0/1` at `$6000`/`$6800` (2 KiB each = **256 patterns × 8 bytes**, monochrome 1bpp,
double-buffered) and `nameBuffer0/1` at `$7000`/`$7400`. The NES's own 2 KiB never holds pixels.

`firstFreePattern` is a **bump pointer with a per-frame reset** — allocate by incrementing, free by
throwing away the whole arena at frame start. No free list, no fragmentation, O(1).

And the optimisation that makes it viable: `lastPattern = firstFreePattern`, so the NMI handler
uploads only patterns `0 … high-water mark`. **Patterns never allocated are never uploaded.**

> **Cost ∝ screen area actually covered by ink, twice over** — once to rasterize, once to upload.
> Empty space costs nothing in either. For a game whose viewport is overwhelmingly black, that is
> close to the ideal cost curve — and it inverts a bitmap's fixed cost.

The corollary is a real failure mode: cost scales with *projected area*, so the renderer is fastest
when there's least to see and slowest in a close dogfight, against a hard 256-pattern pool
(`firstFreePattern = 0` is the documented exhaustion signal). Tile reuse is **within-frame only** —
two edges meeting in one 8×8 cell share a pattern; across frames the arena resets and everything is
redrawn.

## Open questions

- Exact viewport geometry — how many of the 256 patterns go to the space view vs. the dashboard.
- What visibly happens when the pool exhausts mid-frame — dropped lines, or is there a guard?
- Measure it: log peak `firstFreePattern` per frame across docking vs. a close fight.
- Are the NES log-table *contents* byte-identical to the 6502SP version's, or regenerated?

## Answered: the log tables survived, in fixed-bank ROM

The NES port **keeps** the 6502 Second Processor version's logarithm multiply. `log` `$C100`,
`logL` `$C200`, `antilog` `$C300`, `antilogODD` `$C400` — page-aligned in **bank 7, the fixed bank**,
permanently mapped; `FMLTU` at `$F770`, `LL28` at `$FA91`, and 26 indexed reads of those pages in
bank 7's listing.

The ROM-vs-RAM worry dissolves twice over. On a 6502 `lda log,x` is a 4-cycle absolute-indexed read
whether the page is RAM or ROM — the BBC put its tables in RAM only because *everything* on a BBC is
in RAM, never for speed. The one real risk was **banking**, and siting the tables in the always-mapped
bank removes it. The budget even inverts: 1 KB is **0.8% of 128 KiB of ROM** versus roughly **2% of the
BBC's entire 48 KiB of RAM**, where it competed with the program and the screen. The cartridge had it
easier.

→ Elite is now a **three-substrate specimen** for the hub: shift-add (cassette/disc), log tables in RAM
(6502SP), log tables in fixed-bank ROM (NES) — one algorithm across two memory architectures.

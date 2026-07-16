---
status: active
created: 2026-07-15
---
# The one that isn't a VM — Nobunaga's Ambition (SNES) compiled straight to native 65816

> KOEI's SNES strategy engine is a **portable bytecode VM** — proven across ROTK2, Gemfire, and
> L'Empereur. **Nobunaga's Ambition (USA, SNES) is the exception:** it has **no bytecode VM at all**.
> The same C source that the NES original ran on a bytecode interpreter ("Sea-16") was, on this SNES
> port, **compiled directly to native 65C816**. Same game, two *compile targets* — bytecode on NES,
> native on SNES — which is exactly what makes a clean C-to-C comparison possible.

**Links:** the rule this is the exception to → [KOEI's portable VM (ROTK2 SNES)](./koei-snes-portable-vm.md) ·
the method entry → [SNES cartridge teardown](./snes-cartridge-teardown.md) · the NES original (the oracle
for *difference*, not answers) → the `na1-decompiler` repo · [DREAM goto-free structuring](../reverse-engineering/dream-goto-free-structuring.md)
(reused to structure the native decompiler's output).
Code: sibling repos `na1-snes-decompiler` (the title), `snes-decompiler` (65C816 substrate — extended
to HiROM + a new native→C decompiler here), `koei-snes` (consulted for the syscall/ABI model).

## The evidence — no VM, three independent ways

1. **No fetch–decode loop** anywhere — no `LDA [pc] / INC pc / JMP (table,X)` idiom for *any* direct-page
   PC register (generalized whole-ROM scan). Zero hits.
2. **No primary dispatch table** — the largest run of consecutive code-pointer words in the ROM is 64
   (the two syscall tables). A register-machine VM structurally needs a ~256-entry table; none exists.
3. **`main` is plainly native** — `$C1:0A2C` pushes args with `PEA` and calls services via `JSL $C08000`,
   fanning out into native routines across banks `$C1–$C7`.

Confirmed by a reachability walk: from every native entry (RESET/NMI/IRQ + `main` + all 59 syscall
handlers) the walker reaches **56,613 instructions / 123 KB with *zero* decode conflicts** — a native
walker flowing cleanly through the whole code floor is the signature of contiguous native code, not a
bytecode blob.

## Cartridge & shape (all self-verified against the internal checksum)

| | NES NA1 | **SNES NA1** |
|---|---|---|
| CPU / board | 6502 / MMC1 | 65C816 / **HiROM** (first HiROM KOEI SNES title) |
| Size | — | 512 KiB (banks `$C0–$C7`), 8 KiB SRAM |
| Execution model | **bytecode VM** (Sea-16); the 6502 hosts it | **native 65C816**; no VM |
| Syscall BIOS | 23 entries @ `$C173`, `PHP+JMP($FFFE)` | **60 entries** @ `$9550`, `JSL $C08000` + 22-byte param block |
| Game logic lives in | VM bytecode | native code, banks `$C1–$C7` |

## Why (hypothesis — grounded facts above, interpretation here)

NA1 is KOEI's *first* strategy title (1983); its design predates the bytecode VM the later, bigger games
needed for ROM-fit and portability. The likely story: porting a *small, old* game to a chip with a real
stack and 24-bit addressing, KOEI simply **recompiled NA1's original C to native 65816** instead of
retrofitting it onto the VM. Note the chronology twist — NA1-SNES (1993) is a *later* release than
ROTK2-SNES (~1991) yet is engine-*simpler*, because it tracks the *game's* age, not the port's date.
This is interpretation, not proof; it would be confirmed by finding the same native shape in other
ports of KOEI's earliest titles.

## The engine that IS there

- **Compiler-generated cdecl** — every call site is `PEA args / JSL / PLA×N` (caller-cleanup); callees
  open stack frames and read args/locals `$nn,S`. Large arg lists clean up with `TSC/ADC/TCS`. This
  regularity is what makes the native code liftable.
- **BIOS = 60 syscalls, a graphics/display + state API** — a draw-queue drained by NMI (sprite/tilemap
  blitters, `ScrollBG`, `PlotTile`), Mode-7, `ScreenOn/Off`, `SetBrightness`, `WaitVBlank`, memory/getters.
  No general-math syscall: the HW multiply is used *inside* blitters for row addressing.
- **Native math library @ `$C1:F800`** — 32-bit signed mul/div (restoring division on zero-page regs,
  wrapping the HW `$4202/$4204/$4214/$4216` units) + add32/sub32/neg. The 65816's math capability is
  exactly why no VM math layer was needed.
- **Text engine = plain-ASCII `printf`** (same family as NES): 556 located strings, `%d:%s` = year:fief;
  glyph tile = `0x0800 + ASCII`; strings can embed leading 16-bit tile/control words.
- **Records are RAM-resident** — no in-place ROM record tables (a full long-address data-read sweep found
  44 targets, none indexed). As on the NES, the fief/daimyo **initial** state sits in ROM and is **copied
  to `$7E`/SRAM at new-game**, where each turn mutates it; runtime access is bank-relative, not long. The
  record schema is therefore recovered from the SRAM save layer + the new-game loader, not a ROM table.

## The deliverable that makes this reusable — a native 65816→C decompiler

Built `snes-decompiler/tools/native_decompile.py` by **converting, not rebuilding**: it reuses the
`w65c816` decoder and **ports the DREAM structurer from `koei-snes/tools/vm_struct.py`** (dominators →
natural loops → goto-free `if`/`while`); only the 65816 statement-lifter (register model + S-relative
cdecl frame + the `PEA/JSL/PLA` call idiom + syscall-name rendering) is new. Validated against a
hand-decompiled oracle (`$C3:56B1` = a screen fade-out). This is the SNES analog of the NES
`vm_decompile.py`, so **both platforms now lift to C** — the same-source-two-targets comparison can
proceed function-by-function.

## The full reverse — 100% symbol table + a whole-program C listing

- **Label-walk COMPLETE: 715/715 nameable routines named** (658 app + 57 syscalls) via a DFS-from-`main`
  post-order (leaves first, name bottom-up). The graph has **only 3 indirect transfers whole-ROM**, so
  the walk saw everything reachable. The last 126 named were *boot-path islands* — `main` itself, the
  new-game/scenario generator, the opening cutscene, `game_over_screen` — structurally unreachable from
  a turn-based command loop (bootstrap + teardown live on either side of the loop, not inside it).
- **Data-walk COMPLETE: 148 WRAM/MMIO labels**, provenance-graded — 104 MMIO registers (hardware spec,
  usage-confirmed), ~40 hardware-shadow vars, and 4 oracle-confirmed game-state vars (`game_year`,
  `game_season` = {Spring/Summer/Fall/Winter}, `scenario`, `lord_names`). The C compiler's zero-page
  scratch pool and ambiguous flags are left generic *on purpose* — naming by inference would negatively
  leverage a guess into every accessor.
- **Whole-program C listing**: `decompiled/listing.c` (660 KB), all 727 routines, **0 fallback**, with
  labels + MMIO + syscall names + named signatures applied. This is the artifact the NES↔SNES
  comparison reads from.

## Same decision model, different substrate — the three-pillar AI

The re-platform changed the *implementation*, not the *game*. All three AI subsystems —
**military, economic, diplomatic** — run **the player's own formulas** with `difficulty` as a pure
coefficient handicap: combat `(0x73 − difficulty×15)`, economy `(6 − difficulty)`, persuasion
`rand_range(6 − difficulty)`. The AI acts **alone** — per-entity loops, **no coalition logic** — which
is exactly the beatable-because-uncoordinated signature confirmed on the NES original. So bytecode-VM
(NES) vs native-65816 (SNES) is a *compile-target* swap over one unchanged design.

## Method note
Cold-read first (the NES `na1-decompiler` was consulted only to *classify the difference*, never to
supply an answer). The finding inverts the going-in hypothesis ("the later SNES engine is more
advanced") — at the execution layer it is *simpler*. Honest labelling throughout: content-proven data
types only (`bg_layout`, `tilemap_row`); the other 50 data blobs stay generic pending consumer grounding.

## Tags
[reverse-engineering](../../tags/reverse-engineering.md) · [snes](../../tags/snes.md) · [65816](../../tags/65816.md) · [koei](../../tags/koei.md) · [game-design](../../tags/game-design.md)

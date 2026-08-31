---
status: reference
created: 2026-04-26
published: true
layout: layouts/page.njk
title: "NES Mappers Reference"
---
# NES Mappers Reference
> The cartridge logic that extends the NES beyond its base 32 KiB PRG / 8 KiB CHR address space. Curated from nesdev.org/wiki — currently covering NROM (Mappy's mapper). Will grow as we cover more games.

**Links:** [NES Research](./README.md), [PPU Reference](./ppu-reference.md), [APU Reference](./apu-reference.md), [Game Annotation Series](../../projects/game-annotation/README.md)

## Why mappers exist

The NES's 6502-derived 2A03 has the same 16-bit address space as any 6502 (64 KiB). The cartridge connector exposes:
- **PRG** (program ROM) at CPU `$8000–$FFFF` — 32 KiB max without help.
- **CHR** (character/pattern ROM) at PPU `$0000–$1FFF` — 8 KiB.

To ship a game bigger than 32 KiB code or 8 KiB graphics, the cartridge needs hardware to swap banks of ROM into the addressable window. That hardware is the **mapper** — extra logic on the cartridge PCB. NES games are categorized by which mapper their cartridge uses.

Mappers range from "no extra logic" (NROM) to "30+ KiB SRAM with battery, IRQ generator, expanded audio, and PPU snooping" (MMC5).

## NROM — the simplest cartridge

**The mapper that isn't.** No bank-switching logic at all. The cartridge is just ROM chips wired straight to the bus.

### NROM-128 (16 KiB PRG)

- CPU `$8000–$BFFF`: 16 KiB PRG-ROM
- CPU `$C000–$FFFF`: same 16 KiB PRG-ROM, mirrored
- PPU `$0000–$1FFF`: 8 KiB CHR-ROM (fixed)
- Mirroring (nametables): horizontal or vertical, set by board
- **No registers, no IRQs, no audio expansion.**

### NROM-256 (32 KiB PRG)

- CPU `$8000–$FFFF`: 32 KiB PRG-ROM (no mirroring; whole space)
- PPU `$0000–$1FFF`: 8 KiB CHR-ROM
- Otherwise identical to NROM-128.

### Reset/IRQ vectors

The 6502 reads its reset and interrupt vectors from the top of memory:
- `$FFFA–$FFFB`: NMI vector (PPU VBlank handler)
- `$FFFC–$FFFD`: Reset vector
- `$FFFE–$FFFF`: IRQ/BRK vector

For NROM-128, these are physically the last 6 bytes of the 16 KiB PRG. For NROM-256, they're the last 6 bytes of the 32 KiB PRG.

### Notable NROM games

- **Super Mario Bros.** — NROM-256
- **Donkey Kong** — NROM-128
- **Excitebike** — NROM-128
- **Galaxian** — NROM (8 KiB, smallest)
- **Mappy** — NROM-128 (Namco arcade port to Famicom; 16 KiB PRG + 8 KiB CHR)
- **Ice Climber, Balloon Fight, Wrecking Crew, Clu Clu Land** — all early Nintendo first-party NROM titles

The NROM era is essentially "first 18 months of NES" — anything before MMC1 took over for bigger games.

### What you can fit in NROM-128

- 16 KiB code budget — comparable to ~4× Adventure (4 KiB).
- 8 KiB CHR — 256 background tiles + 256 sprite tiles (each 16 bytes, 8×8).
- 2 KiB internal NES RAM ($0000–$07FF, mirrored).
- 256 bytes of OAM for sprites.
- 2 KiB of name table RAM (one nametable + mirror, depending on mirror mode).

The NES still forces you to be efficient at NROM scale, but it's a different scale — "tight enough to require care" instead of Adventure's "tight enough to require ingenuity in every byte." The capability budget moved from "every cycle counts" to "every kilobyte counts."

## Bank-switching mappers (to be expanded)

Larger games use mappers that put a register at some address in the cartridge's CPU window. Writing to that register selects which 8/16/32 KiB ROM bank appears in the addressable window.

**Common mappers we'll cover later in the series:**

- **MMC1 (mapper 1)** — Zelda, Metroid, Final Fantasy. 5-bit serial-write register; banks PRG and CHR; configurable mirroring.
- **UNROM (mapper 2)** — Mega Man, Castlevania, Contra. PRG-only banking; 16 KiB swappable + 16 KiB fixed.
- **CNROM (mapper 3)** — small CHR-only banking.
- **MMC3 (mapper 4)** — Super Mario Bros. 3, Mega Man 3+, Kirby's Adventure. Granular CHR + PRG banking, **scanline IRQ counter** (the big one — enables status bars and parallax without sprite 0 hit).
- **MMC5 (mapper 5)** — Castlevania III, and KOEI's whole late NES catalogue. Most complex stock mapper; expanded audio, scanline IRQs, vertical split, ExRAM — **and a hardware multiplier** (below).

Each mapper extends what's possible — but the **fundamental NES limits don't change**. Same CPU clock, same PPU rendering, same 240-line frame, same OAM constraints, same audio. Mappers add ROM/RAM/IRQ; they don't change the chip relationship the programmer is working with.

### MMC5 is also a math coprocessor

The exception to "mappers don't change the chip relationship." The 6502 has **no multiply instruction**, and the MMC5 supplies one as [an 8×8 unsigned multiplier at `$5205`/`$5206`](https://www.nesdev.org/wiki/MMC5):

```
$5205  write multiplicand   ->  read low byte of product
$5206  write multiplier     ->  read high byte of product
```

Unusually, the product is **combinational — readable on the very next CPU cycle**, with no trigger-and-wait handshake (mapper 90's multiplier makes you wait 8). That costs real ASIC area, and it makes the MMC5 multiplier behave less like a coprocessor and more like *an instruction that happens to live at an address*.

**Confirmed in use across the vault's own decompiled KOEI ROMs** — every MMC5 title, with named call sites where a native listing exists:

| Title | Where | What it does |
|---|---|---|
| **NA2** (1988) | `vm_op_mul16` `$E2F2`, `mul16_hw_08_0c` `$E8E1`, `calc_nametable_addr` `$F9F0` | a **VM opcode** backed by hardware; nametable addr = `col + row*32` |
| **ROTK2** (1990) | `record_ptr_via_hwmul` `$D8D8` | record pointer = `$71D4 + A*$22` (struct indexing) |
| **L'Empereur** (1991) | `mul32_mmc5` `$EFCB`, `deref_add_mult_call` `$D5D6`, `calc_nametable_addr` `$FA55` | **32-bit multiply-accumulate** built on the 8×8 unit |
| **Gemfire** (1992) | `vm_op_mul16` `$EE25` | matched 1.00 to NA2's hardware opcode |
| **Bandit Kings** (1990) | *(no native listing committed)* | 49 multiplier operands present in ROM — see the scan below |

Two observations that only fall out of reading the ROMs:

1. **Software composes upward from an 8-bit primitive** — NA2 builds `mul16`, L'Empereur builds a 32-bit MAC. The same shape KOEI later used on the SNES, where [`$C1:F800` wraps the 5A22's `$4202` unit](../gaming/na1-snes-native-port.md).
2. **Divide stayed in software.** NA2's `vm_op_udiv16` (`$E354`) is explicit: *"MMC5 has no hw divide; only multiply moved to `$5205/6`."* So the VM's instruction set carries a hardware-accelerated multiply and a software divide **side by side** — the asymmetry made visible in a shipped commercial game.
3. **The commonest use isn't arithmetic, it's addressing** — `base + index × stride` and `col + row × 32`. The "math coprocessor" in the mapper mostly does struct and tile lookup.

## How much of the MMC5 did KOEI actually use?

Most of the PPU-side feature set plus the multiplier — but **not** the expansion audio and **not** the scanline IRQ.

**Method (v2).** Scan **PRG-ROM only** for 6502 absolute-addressing instructions whose operand is a known MMC5 register, split by **read vs write**. The split is a built-in validity test: nearly every MMC5 register is *write-only*, so reads of banking or audio registers are almost certainly bytes inside data being misread as code. Only `$5204` and the multiplier `$5205/6` are meaningfully readable — and genuine multiplier use should show a **balanced write:read ratio**, because you write two operands and read two product bytes.

Writes only (the meaningful direction), with the multiplier shown as W/R:

| Feature | NA2 '88 | ROTK2 '90 | BK '90 | LEmp '91 | Gemfire '92 | Verdict |
|---|--:|--:|--:|--:|--:|---|
| **Multiplier** `$5205/6` | **28/24** | **36/31** | **26/23** | **33/32** | **14/12** | **heavy real use** |
| PRG/CHR banking | 13 | 13 | 13 | 14 | 8 | real (mandatory) |
| Vertical split `$5200-02` | 5 | 5 | 5 | 5 | 5 | **real** — see below |
| ExRAM mode `$5104` | 4 | 4 | 4 | 4 | 4 | **real** — mode switched at runtime |
| Fill mode `$5106/7` | 2 | 2 | 2 | 2 | 2 | **real** — tile/colour from variables |
| Expansion audio `$5000-15` | 2 | 2 | 10 | 8 | 2 | **doubtful** — init only |
| Scanline IRQ `$5203/4` | 0 | 0 | 0 | 0 | 1 | **unused** — compare reg never written |

**The multiplier result is the solid one.** Write:read runs near 1:1 in every title (28/24, 36/31, 26/23, 33/32, 14/12) on exactly the two multiplier addresses. Random data does not produce a balanced write:read signature on a specific register pair. In Gemfire **100% of the hits are in the fixed bank**, where the native floor lives.

**Vertical split, ExRAM and fill mode are real too** — confirmed against NA2's actual disassembly, which computes the values at runtime rather than writing constants:

```asm
b15_fcdb:   sta $5201     ; split scroll <- value computed by two ASLs (x4)
b15_fd20:   and #$1f
b15_fd22:   ora $73
b15_fd24:   sta $5200     ; split control <- (A & $1f) | runtime var $73
b15_fd29:   sta $5202     ; split bank    <- from var $58
b15_fbd0:   sta $5106     ; fill tile     <- from var $52
b15_fbd5:   sta $5107     ; fill colour   <- from var $54
```

Nobody computes values at runtime in order to *disable* a feature. `$5104` likewise gets `#$01` and `#$02` at different points — ExRAM mode switched dynamically, not set once. A vertical split is exactly the right hardware for a strategy game's non-scrolling side panel, so this is unsurprising in hindsight.

**The two features KOEI did *not* take are the interesting ones.** `$5203` (the IRQ scanline compare) is **never written in any of the five** — you cannot use scanline IRQs without it. And expansion audio shows only 2 writes in NA2, occurring inside an init run that stores the same value to `$5010`, `$5105`, `$5200` in sequence — the signature of a zeroing loop, not music. *(BK's 10 and L'Empereur's 8 audio writes are not explained by that and remain open — see the gap below.)*

**Corrections recorded, because both errors looked like findings.** A first pass grepped the decompiler repos for `$5205`, got zeros for Bandit Kings and Gemfire, and called it a per-title difference — that measured the *corpus*, since only `na2-decompiler` commits a native 6502 listing. A second pass scanned the ROMs but included **CHR-ROM**, which is 33-50% of each file and is pure tile graphics; that inflated every count (expansion audio's apparent 10→42 growth curve was almost entirely reads-of-write-only-registers inside graphics data, and vanished under the v2 method).

**A correction worth keeping visible.** An earlier pass here grepped the five decompiler repos for `$5205`, found **zero** in `bk-decompiler` and `GemFire-decompiler`, and flagged it as a real difference between titles. That was wrong, and the reason is instructive: **only `na2-decompiler` commits a native 6502 disassembly** (`source/1-asm-6502/`) — `bk`, `rot3k2`, and `GemFire` commit `source/asm/` as **VM bytecode dumps**, and `LEmp` has no `source/` tree at all. Grepping for a 6502 operand string across repos containing no 6502 listing measures the *corpus*, not the ROMs. Four clean zeros looked like a finding; it took a second tool — reading the ROM bytes directly — to show the first one measured nothing.

**The native floor was analysed — only the listing is missing.** Label counts in the `$8000-$FFFF` range: **NA2 2,096 · Bandit Kings 3,227 · ROTK2 1,749 · Gemfire 1,365 · L'Empereur 1,297.** Step 2 clearly happened in all five (Bandit Kings has the most native labels of any title in the family). What was never emitted is the *artifact* — only `na2-decompiler` has a `source/1-asm-6502/` listing. So regenerating is a **re-run of `koei-nes/tools/disasm6502.py` against an existing label table**, not a redo of the analysis.

Doing it would settle the two questions this scan leaves open: whether Bandit Kings' and L'Empereur's ~10 expansion-audio writes are real, and whether the multiplier call sites in the four unlisted titles match NA2's named ones.

Wider context: [Arithmetic as a Purchase](../arithmetic-as-a-purchase.md).

## How mapper choice constrains game design

Worth keeping in mind across the series:

- **NROM (Mappy, SMB, Donkey Kong)**: ~16 KiB code, fixed CHR. Engine has to be tight; level data has to be compressed; all art is loaded at game start.
- **UNROM (Castlevania)**: PRG can be 256 KiB (16 banks × 16 KiB). Tons of code/level-data space. CHR is RAM, dynamically updated — gives flexibility but eats CPU during transfers.
- **MMC1 (Zelda)**: PRG and CHR both bankable. Save data via WRAM with battery. Enables RPG-scale games.
- **MMC3 (SMB3)**: scanline IRQ → status bar that doesn't scroll; small CHR banks → animated tiles by swapping pattern bytes. The mapper enables the *style* of game.

Mappers are part of game design, not just delivery infrastructure.

## Tags

[6502](../../tags/6502.md) · [reverse-engineering](../../tags/reverse-engineering.md) · [assembly](../../tags/assembly.md) · [mmc1](../../tags/mmc1.md) · [nes](../../tags/nes.md)

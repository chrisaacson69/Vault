---
status: active
created: 2026-07-07
---
# Breaking Down an SNES Cart — the teardown method

> How to "look under the hood" of *any* Super Nintendo ROM before you know a single opcode: read the
> internal header, detect the memory mapping, project the file into 65C816 address space, then find the
> subsystems. This is the target-agnostic groundwork the NES KOEI decompilers earned the right to skip
> (one fixed 6502 + mapper) but the SNES forces back to the front — the architecture is genuinely bigger.
> Every fact here traces to the **[SNESdev Wiki](https://snes.nesdev.org/wiki/SNESdev_Wiki)**; nothing is
> from memory. Existence proof of the first two steps: the `snes-decompiler` tools (below) run and self-test.

**Links:** [snes-decompiler project pointer](../../projects/game-annotation/snes/README.md) · the NES
counterpart series → [KOEI AI/combat evolution](./koei-ai-combat-evolution.md) &
[game-annotation](../../projects/game-annotation/README.md) · method kin →
[Transpilation as a Grounding Strategy](../transpilation-as-grounding.md) (weak formal language → grounded one).

## The architecture break vs. the NES work

The eight KOEI NES titles share **one** CPU (6502) and a handful of mappers; classify-once, reuse forever.
The SNES resets that: you must re-detect per cart.

| Axis | NES (prior work) | SNES (this) |
|------|------------------|-------------|
| CPU | 6502, 8-bit | **65C816**, 16-bit A/X/Y toggled by M/X flags, 24-bit addressing |
| Code addressing | zero-page + bank switch | bank-relative; instructions cross 24-bit space |
| ROM projection | iNES mapper number | **LoROM / HiROM / ExHiROM** (must be detected) |
| Graphics | PPU, fixed | PPU **modes 0–7** (Mode 7 = affine), color math, HDMA |
| Audio | on-CPU APU | **separate SPC700 CPU** + S-DSP, BRR samples (its own teardown) |
| Enhancement | — | in-cart coprocessors: **SA-1, Super FX, DSP-1, CX4** |

## The four-step teardown

1. **Read the internal header** (32 bytes at CPU `$00:FFC0`). Title (21 B), map/speed byte `$FFD5`,
   chipset `$FFD6`, ROM size `$FFD7`, RAM size `$FFD8`, country `$FFD9`, checksum `$FFDE`, complement
   `$FFDC`. The header sits at a *different file offset per mapping* — that's what makes step 2 necessary.
2. **Detect the mapping.** The header lands at file `0x7FC0` (LoROM) or `0xFFC0` (HiROM); score each
   candidate by the defining identity **`checksum XOR complement == 0xFFFF`**, the map-mode nibble, and a
   printable title. LoROM = 32 KiB banks at `$8000–$FFFF`; HiROM = 64 KiB banks linear in `$C0–$FF`.
3. **Lay the memory map + find the entry point.** 256 banks × 64 KiB. WRAM's low 8 KiB mirrors into many
   banks; all 128 KiB is linear at `$7E–$7F`. System area: **PPU regs `$2100–$21FF`**, **CPU/DMA regs
   `$4200–$43FF`**. The **emulation RESET vector at `$FFFC`** is where execution — and disassembly — begins.
4. **Identify the subsystems** and peel each on its own: PPU mode & tilemaps (graphics), SPC700 program
   in APU RAM (audio), and any coprocessor named by the chipset byte (changes the whole disassembly).

**Then classify (per the kernel rule):** is the game logic native 65C816, or a **bytecode VM** like the
KOEI NES titles? That fork picks the strategy — walk native code, or build a transpiler for the VM.

## Tooling — grounded, running, reusable

Logical name **`snes-decompiler`** → `github.com/chrisaacson69/snes-decompiler` *(local, not yet pushed)*
· relative `../snes-decompiler`. It is the SNES analog of the NES shared layers (`nes-render` / `koei-nes`),
built in two layers just like the NES side (generic CPU decoder + cart wiring):

- **CPU level** — `tools/w65c816.py`: pure 65C816 decoder (256-opcode WDC matrix + **M/X flag width
  tracking** — immediate length is runtime REP/SEP state). Zero SNES imports; the 65C816 analog of the NES
  `disasm6502`; graduates to its own repo when a 2nd 65C816 system needs it. Opcode table cross-checked vs 6502.org.
- **SNES level** — `tools/disasm65816.py` (drives the CPU core through the mapper; `--base` for relocated/WRAM
  code), `tools/walk65816.py` (recursive-descent walker over a **static 24-bit segment map** — banks don't overlap
  or swap, so address→byte is a fixed partition; PBR-aware, per-path M/X, flags code-vs-data conflicts),
  `tools/header_parse.py` (mapping + header + RESET entry), `tools/mapper.py` (`cpu_to_file`/`file_to_cpu` + `.smc` strip).

**Verified end-to-end on a real cart:** disassembling ROTK2 (SNES) from its RESET vector produces the
canonical SNES boot (CLC/XCE/SEI, REP/SEP, `$2100`/`$4200` PPU-DMA init) with correct M/X-tracked immediate
widths — stream alignment onto real hardware registers is the proof the widths are right. First target =
`rot3k2-snes-decompiler` (KOEI shipped ROTK2 on both MMC5 NES and SNES → the decompiled NES sibling is the
oracle). Findings harvest back here.

## Tags
[snes](../../tags/snes.md) · [65816](../../tags/65816.md) · [assembly](../../tags/assembly.md) · [reverse-engineering](../../tags/reverse-engineering.md) · [games](../../tags/games.md) · [game-design](../../tags/game-design.md)

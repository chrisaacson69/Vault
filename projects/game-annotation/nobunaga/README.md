---
status: active
created: 2026-05-10
---
# Nobunaga's Ambition (NES, USA, 1989)
> Solo deep-dive on a 256 KB MMC1 strategy cartridge — 64× the size of Adventure, and the test case for whether the annotation method scales to data-heavy hidden-mechanics engines.

**Links:** [Game Annotation Series](../README.md) · [Adventure](../adventure/README.md) · [Mappy](../mappy/README.md) · [Utopia](../utopia/README.md) · [M.U.L.E.](../mule/README.md) · [NES mappers reference](../../../research/nes/mappers-reference.md) · [LLM Grounding Problem](../../../research/llm-grounding-problem.md) · [Dominance-frontier game-analysis lens](../../../research/gaming/master-of-magic/com-counter-graph.md)

## Why this game

Koei's *Nobunaga's Ambition* is the canonical case of **hidden mechanics so opaque the dominant strategy degenerates to "pick the high-luck leader and assassinate everyone."** TAS speedruns confirm: the game's visible interface gives the player no honest signal about the engine underneath, so play collapses onto a few exploitable stats. Source-level transparency is the antidote — turn the hidden engine into a mappable counter-graph. Same lens we applied to [Master of Magic spell counters](../../../research/gaming/master-of-magic/com-counter-graph.md), now against an opaque 1980s strategy engine.

This is also the first of the series **without an external annotated disassembly** as a starting point. Adventure, Mappy, Utopia, and M.U.L.E. all had prior community work. NA is raw bytes only — the method now has to carry its own weight.

## Cartridge facts (from iNES header + static analysis)

- **Mapper:** MMC1 (mapper 1), SOROM variant (8 KB battery-backed PRG-RAM)
- **PRG-ROM:** 16 × 16 KB = 256 KB (the practical max for plain MMC1)
- **CHR:** 8 KB CHR-RAM (uploaded from PRG at runtime)
- **Mirroring:** software-controlled, initialized to vertical (control reg = $0E)
- **SHA-1:** `1F7D440085E9BC17FA22B23744D611E69B978C07`
- **Koei signature** at $FFE0–$FFEF: `"NOBU-NES10      "` (recognizable across Koei carts)

## Boot vectors (bank 15, fixed at $C000–$FFFF)

| Vector | Address | Role |
|---|---|---|
| RESET  | $C000 | MMC1 + APU init, zero RAM, then `JMP $8000` (hand off to bank 0) |
| NMI    | $C0DA | VBlank: OAM DMA, controller poll, frame counter |
| IRQ    | $C139 | **Software task dispatcher** keyed on $0050 via the BRK flag |

The IRQ handler is the most interesting find from session 1: a 23-entry dispatch table at $C173 implements an **OS-style syscall API**. Game code in banks 0-14 calls into bank-15 kernel services via `jsr syscall_dispatch` at $F226. See Chapters 1 and 4 — chapter 1 found the table; chapter 4 decoded it as a syscall surface (originally framed as "BRK-VM" but the actual mechanism is `PHP + JMP ($FFFE)`, not BRK).

## Chapter map

| # | Chapter | Status |
|---|---|---|
| 1 | [Boot, vectors, and the BRK dispatcher](./01-boot-and-dispatch.md) | session 1 draft |
| 2 | [Zero-page memory map](./02-zero-page-map.md) | session 2 draft |
| 3 | [NMI/VBlank pipeline (PPU + OAM + audio driver)](./03-nmi-pipeline.md) | session 3 draft |
| 4 | [The Syscall API: what each of the 23 dispatch entries does](./04-syscall-api.md) | session 4 draft |
| 5 | [The Bytecode VM](./05-bytecode-vm.md) | session 5 draft |
| 6 | [The VM Disassembler](./06-vm-disassembler.md) | session 6 draft |
| 7 | [The SRAM Save Layer](./07-sram-save-layer.md) | session 7 draft |
| 8 | [The VM Instruction Set: Arithmetic, Control Flow & the 9999 Cap](./08-vm-instruction-set.md) | session 8 draft |
| 9 | [The Command System: how a menu pick becomes a formula (Grow fully traced)](./09-command-system-and-grow.md) | session 9 draft |
| 10 | The Grow family + display-command family (diff against ch 9) | planned |
| 11 | The economy: harvest & tax formulas | planned |
| 12 | Daimyo AI decision engine | planned |
| 13 | Combat resolution & hidden stat formulas | planned |
| 14 | Synthesis: from bytecode to strategy counter-graph | planned |

Chapter numbers may shift as the structure clarifies — the M.U.L.E. project also reserved chapter 7.5 for strategic-frontier analysis once the mechanics were mapped. Expect the same pattern here.

## Toolchain

- **Mesen 2** (installed via `winget install SourMesen.Mesen2`) — debugger, trace logger, ca65-syntax disassembly export. Primary runtime tool.
- **Raw `xxd` + Python** for static analysis when runtime correlation isn't needed (session 1 was entirely static).
- **ca65 syntax** as the annotation target — same convention as the other game-annotation chapters.

## Method note

Adventure and Mappy worked because the ROMs were small enough to read end-to-end. M.U.L.E. worked because Kroah's external annotation gave a calibrated start. **Nobunaga's at 256 KB with bank switching breaks both crutches** — we have to build the chapter framework from architectural cuts (dispatch table, save format, AI driver), not linear ROM reads. The BRK dispatcher discovered in session 1 is the first such cut; each of its 23 entries gets a sub-investigation.

If the method holds here, it scales. If it doesn't, the failure mode is the lesson.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [llm-limitations](../../../tags/llm-limitations.md)

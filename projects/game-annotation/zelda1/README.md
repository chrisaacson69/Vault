---
status: active
created: 2026-10-29
---
# The Legend of Zelda (NES) — `Zelda1-decompiler`

> Pointer page (process-table entry) for the Zelda 1 reverse-engineering repo. A skeleton on
> emu-harness's standard layout: so far the overworld, decoded from the ROM and verified live. It is
> the first **banked** native title (MMC1), so it is the second consumer for the native drivers
> Mappy proposed.

**Links:** the theory → [Zelda AI speedrun harness](../../../research/gaming/zelda-ai-speedrun-harness.md) ·
library → [emu-harness](../emu-harness/README.md) · the first native title → [Mappy](../comparisons/mappy/README.md) ·
platform reference → [NES Mappers](../../../research/nes/mappers-reference.md) ·
project SDK → [projects/CLAUDE.md](../../CLAUDE.md)

## Identity (resolve by logical name, never hardcode a path)

| Field | Value |
|-------|-------|
| Logical name | `Zelda1-decompiler` |
| GitHub | [github.com/chrisaacson69/Zelda1-decompiler](https://github.com/chrisaacson69/Zelda1-decompiler) *(**PUBLIC**, pushed 2026-10-29)* |
| Sibling path | `../Zelda1-decompiler` (resolved per machine via vault `.claude/local-paths.md`) |
| Entry point | `README.md` → `re-roadmap.toml` (`py -3.14 -m emu_harness status Zelda1-decompiler`) |
| Depends on | `emu-harness` (`pip install -e ../emu-harness`); the ROM from the machine's ROM store |
| Oracle | aldonunez's [zelda1-disassembly](https://github.com/aldonunez/zelda1-disassembly) (PRG0): graded against after, never derived from |
| Stack | Python 3.14; Mesen 2 for the live checks |

## ROM

`Legend of Zelda, The (USA) (Rev 1).nes`: mapper 1 (MMC1), 128 KiB PRG, battery. Its headerless
SHA-1 matches the AIBeatsZelda run-6 `.bk2`, which makes it the replay oracle.

**Status:** skeleton, 2026-10-29. Assets is partial (all 128 overworld screens, EXACT 128/128 against
the ROM's own `LayoutRoomOW` and Mesen's live PPU); every other phase is todo, and the next session is
classify and recon.

## Tags
[nes](../../../tags/nes.md) · [6502](../../../tags/6502.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [decompilation](../../../tags/decompilation.md)

---
status: active
created: 2026-09-30
---
# Aerobiz (SNES)

> The third KOEI SNES title, and the first one that isn't a port of a decompiled NES game. Its first
> recon found a decoding bug in the shared toolchain that both earlier titles had shipped with.

**Links:** system → [SNES](../README.md) · toolchain → [KOEI tools](../../koei/README.md) ·
engine siblings → [ROTK2 (SNES)](../rot3k2-snes/README.md), [Gemfire (SNES)](../gemfire-snes/README.md) ·
open questions it serves → [the hollow opponent](../../../../research/gaming/hollow-opponent-perceived-depth.md)
(is argmin-weakest a KOEI house pattern?), [Nobunaga crucible](../../../../research/gaming/nobunaga-crucible.md)
(binding-constraint depth)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `AeroBiz-decompiler` *(local; no remote yet)* |
| Sibling path | `../AeroBiz-decompiler` (resolved via `.claude/local-paths.md`) |
| Cart | Aerobiz (USA), LoROM, 1 MiB, 8 KiB SRAM, RESET `$800C`, no coprocessor |
| Status | 🔬 recon #1 complete (2026-09-30): engine profile `[aerobiz]` derived and verified; module walk next |
| Depends on | `koei-snes` → `snes-decompiler` |

The game is the original *Air Management: Oozora ni Kakeru* (Super Famicom, 1992). It was also released on FM Towns,
PC-98, Mega Drive and X68000. **There is no NES/Famicom version.** So unlike ROTK2 and Gemfire, it has no
decompiled NES twin to serve as an oracle; the oracles are the engine siblings and the manual.

## What it has contributed so far

- **Engine map:**
  - 22 WRAM code modules (two resident: `COMMON` and `ALNMAIN`) and 479 bytecode routines.
  - 99 syscalls (Gemfire has 82, ROTK2 69).
  - The resource archive at `$00:F000`, not the `$F800` the toolchain assumed.
- **Module roles** read off COMMAND's switch. The command modules are `AIRWAY` (routes), `NEGO`, `TRADE`, `INVEST`
  (budget), `CAMPAIGN` (marketing), `OPERATE` (hotels and charters) and `SIMULATE` (board meeting). The AI candidate is `ALGO`.
- **A shared-toolchain bug that is common to all three titles.** Opcode `$D8` is `jz abs16` (2-byte operand), not
  `brz r8`. Several compare, divide and shift opcode names describe the complement or the wrong operation.
  - The shipped ROTK2 and Gemfire decodes are wrong at every `$D8`.
  - Their walkers reported "0 errors" because they had no way to detect the desync, which self-heals after one phantom instruction.
  - It was caught by re-deriving the operand sizes from the handler code, which included executing the handlers on an emulator.

## Tags
[snes](../../../../tags/snes.md) · [65816](../../../../tags/65816.md) · [reverse-engineering](../../../../tags/reverse-engineering.md) · [games](../../../../tags/games.md)

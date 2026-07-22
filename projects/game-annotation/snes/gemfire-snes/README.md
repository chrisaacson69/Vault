---
status: active
created: 2026-07-21
---
# Gemfire (SNES)

> The second KOEI SNES title reversed — and the pass that exposed the trampoline bug in
> [rot3k2-snes](../rot3k2-snes/README.md), forcing a full re-walk there.

**Links:** system → [SNES](../README.md) · toolchain → [KOEI tools](../../koei/README.md) ·
NES twin → [gemfire (NES)](../../nes/gemfire/README.md) ·
thesis → [Gemfire (SNES) fully decompiled](../../../../research/gaming/gemfire-snes-decompiled.md)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `Gemfire-snes-decompiler` *(public)* · `github.com/chrisaacson69/Gemfire-snes-decompiler` |
| Sibling path | `../Gemfire-snes-decompiler` (resolved via `.claude/local-paths.md`) |
| Cart | Gemfire (USA), LoROM, 1 MiB, 8 KiB SRAM, RESET `$800F` |
| Status | ✅ complete — **all 591 bytecode routines named across 11 WRAM overlay modules** |
| Depends on | `koei-snes` → `snes-decompiler` |

⚠️ **Not cloned on this machine** (2026-07-21).

## What it contributed

- **The per-routine native `JSR $3287` trampoline** (body at +5), made profile-driven. This is the key
  engine finding, and the reason the ROTK2 SNES walk had to be redone — the same trampoline pattern was
  silently corrupting that title's names.
- Engine coverage: 218 + 48 opcodes, 82 syscalls, 88 native routines; modules root + command +
  comusr1/2 + comcmp-AI + settei + event + senzen/sensou/sengo + ending; plus a full data-walk.
- Second cross-console pair (after ROTK2), so the portable-VM finding is checked twice, not once.

## Tags
[snes](../../../../tags/snes.md) · [65816](../../../../tags/65816.md) · [reverse-engineering](../../../../tags/reverse-engineering.md) · [games](../../../../tags/games.md)

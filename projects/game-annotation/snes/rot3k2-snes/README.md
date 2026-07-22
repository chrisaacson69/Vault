---
status: active
created: 2026-07-21
---
# ROTK2 — Sangokushi II (SNES)

> The first KOEI **SNES** title reversed, and the title that proved the portable VM from both sides.
> Its NES twin [rot3k2](../../nes/rot3k2/README.md) was the oracle — a port comparison, not a cold read.

**Links:** system → [SNES](../README.md) · toolchain → [KOEI tools](../../koei/README.md) ·
NES twin → [rot3k2 (NES)](../../nes/rot3k2/README.md) ·
theses → [KOEI's portable VM](../../../../research/gaming/koei-snes-portable-vm.md),
[The Rosetta Stone Method](../../../../method/rosetta-stone-method.md),
[DREAM — goto-free structuring](../../../../research/reverse-engineering/dream-goto-free-structuring.md)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `rot3k2-snes-decompiler` *(public)* · `github.com/chrisaacson69/rot3k2-snes-decompiler` |
| Sibling path | `../rot3k2-snes-decompiler` (resolved via `.claude/local-paths.md`) |
| Cart | ROTK2 (USA), LoROM, 1 MiB, 32 KiB battery SRAM, RESET `$800C` |
| Status | ✅ **re-walked & complete** — ~1,316 bytecode routines named across 26 code modules, 4 data blobs documented |
| Depends on | `koei-snes` → `snes-decompiler` |

⚠️ **Not cloned on this machine** (2026-07-21).

## What it contributed

- **The portable-VM proof.** VM opcodes byte-for-byte identical to the NES twin (NES 219 / SNES 218),
  same resident-library + command-app architecture, **province record stride 25 on both**. The bytecode
  targets a virtual address space behind a stable syscall ABI — architecture-agnostic *by design*.
  The SNES is a **faithful port + facelift** (69 vs ~31 syscalls: DMA/Mode 7/SPC700); the lone data
  change is the officer record 21→34.
- **A found-and-fixed walker bug.** The Gemfire pass exposed an offset-0 defect — each routine's 5-byte
  `JSR $23E6` trampoline was being decoded *as bytecode*, mis-shifting and mis-keying names. The
  trampoline profile was backported and **all 26 modules re-walked**; damage ranged from severe
  (comroot/AI: 110 corrections) to none. Old files kept as `*.offset0-backup.toml`. A clean specimen of
  why the second target is also a *check on the first*.
- Coverage now includes the hex tactical engine and its 13 sub-overlays, never decompiled before.
- Two decompiler experiments came out of it: a C lift and a **DREAM-style structurer** (65–75% goto-less).

## Tags
[snes](../../../../tags/snes.md) · [65816](../../../../tags/65816.md) · [reverse-engineering](../../../../tags/reverse-engineering.md) · [games](../../../../tags/games.md)

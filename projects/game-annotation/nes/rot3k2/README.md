---
status: active
created: 2026-07-21
---
# ROTK2 — Sangokushi II (NES)

> Design clock **1989**; Famicom port 1990. **Fully decompiled**, and the NES half of the
> portable-VM proof — KOEI shipped ROTK2 on *both* MMC5 NES and SNES, so this repo is the oracle for
> [rot3k2-snes](../../snes/rot3k2-snes/README.md).

**Links:** system → [NES](../README.md) · toolchain → [KOEI tools](../../koei/README.md) ·
SNES twin → [rot3k2-snes](../../snes/rot3k2-snes/README.md) ·
theses → [KOEI AI & combat evolution](../../../../research/gaming/koei-ai-combat-evolution.md),
[KOEI's portable VM](../../../../research/gaming/koei-snes-portable-vm.md)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `rot3k2-decompiler` *(public)* · `github.com/chrisaacson69/rot3k2-decompiler` |
| Sibling path | `../rot3k2-decompiler` (resolved via `.claude/local-paths.md`) |
| Cart | MMC5 |
| Status | ✅ fully decompiled — all 18 bytecode banks + native floor + data-walk + memory map |
| Depends on | `koei-nes` → `nes-render` |

⚠️ **Not cloned on this machine** (2026-07-21).

## What it contributed

- **Off-screen combat: strategy (2) — cheap round simulation.** `simulate_field_battle $B0BB` runs up
  to **6 rounds**; each round computes
  `power = (rng×4−6) · Σ(loyalty/4 + morale/3 + intel/2 + war) · (troops/100+1) / 50`, attrites by the
  `power_a·100/(a+b)` ratio, and early-exits at 0.
- **The cross-console oracle.** Because the same title exists on SNES, reversing both sides made each
  the other's check — VM opcodes byte-for-byte identical, province record stride 25 on both. This is
  the specimen behind [The Rosetta Stone Method](../../../../method/rosetta-stone-method.md).
- The walk that produced it is what seeded the four-agent cross-family sweep of the sibling
  decompilers.

## Tags
[nes](../../../../tags/nes.md) · [6502](../../../../tags/6502.md) · [reverse-engineering](../../../../tags/reverse-engineering.md) · [games](../../../../tags/games.md)

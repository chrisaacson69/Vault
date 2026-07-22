---
status: active
created: 2026-07-21
---
# ROTK1 — Sangokushi (NES)

> The earliest title in the KOEI NES decompiler family, and the baseline the other four are read
> against. Design clock **1985** (Dec 10); Famicom port 1988.

**Links:** system → [NES](../README.md) · toolchain → [KOEI tools](../../koei/README.md) ·
thesis → [KOEI AI & combat evolution](../../../../research/gaming/koei-ai-combat-evolution.md)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `ro3k-decompiler` *(private)* · `github.com/chrisaacson69/ro3k-decompiler` |
| Sibling path | `../ro3k-decompiler` (resolved via `.claude/local-paths.md`) |
| Depends on | `koei-nes` → `nes-render` |

⚠️ **Not cloned on this machine** (2026-07-21).

## What it contributed

- **Off-screen combat: strategy (0) — no abstraction at all.** Every War runs the full 30-day tactical
  loop `run_30_day_battle_turn_loop $8F06`; no separate resolver exists. Per-cell odds come from
  `province_strength_score $B9CC` (troops·10 + arms + training).
- **The one explicit AI combat handicap in the whole lineage lives here** — `province_strength_score`
  adds `(players−1)<<4`. Every later title moves the AI's edge to the *economy* and keeps the visible
  battle symmetric. That makes ROTK1 the anchor for "the AI executes the player's own formulas."
- Officer-holds-army is established here and retained through L'Empereur.

## Tags
[nes](../../../../tags/nes.md) · [6502](../../../../tags/6502.md) · [reverse-engineering](../../../../tags/reverse-engineering.md) · [games](../../../../tags/games.md)

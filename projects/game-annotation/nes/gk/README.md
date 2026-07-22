---
status: active
created: 2026-07-21
---
# Genghis Khan (NES)

> Design clock **1987**; Famicom port 1989-04-20. The title that introduces *cheap round simulation* to
> the family.

**Links:** system → [NES](../README.md) · toolchain → [KOEI tools](../../koei/README.md) ·
thesis → [KOEI AI & combat evolution](../../../../research/gaming/koei-ai-combat-evolution.md)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `gk-decompiler` *(private)* · `github.com/chrisaacson69/gk-decompiler` |
| Sibling path | `../gk-decompiler` (resolved via `.claude/local-paths.md`) |
| Scope | full bytecode decompilation + architecture docs; ROM not included |
| Depends on | `koei-nes` → `nes-render` |

⚠️ **Not cloned on this machine** (2026-07-21).

## What it contributed

- **Off-screen combat: strategy (2) — cheap round simulation.** `resolve_battle $947C` runs a
  day-budget loop (`−3`/round) over `resolve_battle_round`; power sum feeds
  `win_probability_percent`.
- **Casualties are quadratic in the loser's share** — `muldiv(swing, e², s²+e²)` — so the side losing
  the odds bleeds disproportionately. A markedly different curve from the one-shot comparisons on
  either side of it in the lineage.
- Sits between two *one-shot* titles on the design clock, which is the core evidence that KOEI's
  off-screen model **alternates** rather than climbs.

## Tags
[nes](../../../../tags/nes.md) · [6502](../../../../tags/6502.md) · [reverse-engineering](../../../../tags/reverse-engineering.md) · [games](../../../../tags/games.md)

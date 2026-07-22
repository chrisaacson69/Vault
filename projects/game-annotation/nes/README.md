---
status: active
created: 2026-07-21
---
# NES / Famicom — system node

> The 6502 + PPU substrate and every title decompiled on it. Sibling of [snes/](../snes/README.md).
> The shared KOEI toolchain these titles run through lives one level over in
> [koei/](../koei/README.md), because the engine spans both consoles.

**Links:** series hub → [Game Annotation](../README.md) · toolchain → [KOEI tools](../koei/README.md) ·
system tools → [nes/tools](./tools/README.md) · project SDK → [projects/CLAUDE.md](../../CLAUDE.md) ·
hardware → [PPU](../../../research/nes/ppu-reference.md) · [APU](../../../research/nes/apu-reference.md) ·
[mappers](../../../research/nes/mappers-reference.md) · [NES research](../../../research/nes/README.md)

## The three layers

```
nes-render          generic PPU / render core       ← target-agnostic   → tools/
   ↑
koei-nes            KOEI Famicom VM engine layer    ← family-specific   → ../koei/
   ↑
<title>-decompiler  per-title decompilation                             → below
```

`nes-render` **graduated out of NA1** the moment Mappy needed it — the SDK's shared-lib rule working as
intended: a second consumer turns a helper into a real dependency with exactly one home.

## Titles

Repo names are **decompiler-project numbering, not series order**, and "game 6/7/8" is the order the
family was decompiled, **not** release order (L'Empereur 1991 is game 8; Gemfire 1992 is game 7). The
design-clock year is the *original computer* release — the meaningful clock for "how did the AI evolve",
since the NES ROM is a localization of the Famicom port.

| Folder | Repo | Title | Design clock |
|---|---|---|---|
| [ro3k/](./ro3k/README.md) | `ro3k-decompiler` | Sangokushi (ROTK1) | 1985 |
| [na1/](./na1/README.md) | `na1-decompiler` | Nobunaga no Yabō: *Zenkokuban* | 1986 |
| [gk/](./gk/README.md) | `gk-decompiler` | Genghis Khan | 1987 |
| [rot3k2/](./rot3k2/README.md) | `rot3k2-decompiler` | Sangokushi II (ROTK2) | 1989 |
| [bk/](./bk/README.md) | `bk-decompiler` | Bandit Kings of Ancient China *(game 6)* | — |
| [gemfire/](./gemfire/README.md) | `GemFire-decompiler` | Gemfire, 1992 *(game 7)* | — |
| [lemp/](./lemp/README.md) | `LEmp-decompiler` | L'Empereur, 1991 *(game 8)* | — |

⚠️ **`na2` is unconfirmed.** The [five-decompiler study](../../../research/gaming/koei-ai-combat-evolution.md)
names `na2` (*Sengoku Gun'yūden*, 1988) as decompiled, but **no `na2-decompiler` repo exists on
GitHub** — it may live inside `na1-decompiler`. No folder until that's verified.

⚠️ **None of these are cloned on this machine** (2026-07-21) — see `.claude/local-paths.md`.

## Non-KOEI NES work

**Mappy (Famicom/NES)** — Namco's 16 KB platformer, 8 chapters complete. It belongs to the
**hardware-capability arc** paired against Adventure (Atari 2600), so it is indexed by
[comparisons/](../comparisons/README.md), not here. Filing it under this node would sever the arc —
the cross-console comparison *is* the point.

## Why NES and SNES are separate nodes

The NES work reused one 6502 + a few mappers across seven titles. The SNES forces re-detection per cart
(mapping, CPU width, coprocessors) and a different disassembler — so each console gets its own
substrate package. What they *share* is the KOEI engine family, which is why that lives in
[koei/](../koei/README.md) rather than being duplicated into both.

## Tags
[nes](../../../tags/nes.md) · [6502](../../../tags/6502.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [games](../../../tags/games.md)

---
status: active
created: 2026-07-21
---
# NES system tools — rendering & emulator integration

> The **target-agnostic** NES tooling: rendering, and Mesen (emulator) integration. KOEI-specific
> tooling — the VM decompiler, the walk pipelines, `games.toml` — is **not** here; it lives in
> [koei/](../../koei/README.md).

**Links:** system → [NES](../README.md) · KOEI toolchain → [koei/](../../koei/README.md) ·
hardware → [PPU](../../../../research/nes/ppu-reference.md) ·
[mappers](../../../../research/nes/mappers-reference.md)

## Rendering — `nes-render`

| Field | Value |
|-------|-------|
| Logical name | `nes-render` *(private)* · `github.com/chrisaacson69/nes-render` |
| Sibling path | `../nes-render` (resolved via `.claude/local-paths.md`) |
| Contents | `nes_render.py`, `na1_font_atlas.png` |
| Role | generic PPU / rendering core; target-agnostic |
| Depended on by | `koei-nes`, the per-title decompilers, Mappy |

**Graduated out of NA1** when Mappy needed it — the moment a second app wanted it, it became a real
dependency with exactly one home. (The `na1_font_atlas.png` still riding along is a leftover of that
extraction; it is NA1-specific data in a generic package.)

## Emulator integration — Mesen

Mesen label/workspace generation is how a decompiled symbol table gets back into a debugger. It is
currently **scattered across three homes**:

| Tool | Lives in | Scope |
|---|---|---|
| `mesen-labels.py`, `mesen-workspace.py` | `game-annotation/tools/` | the comparisons monorepo |
| label emission | `koei-nes/tools/` | KOEI NES |
| `gen_mlb` | `koei-snes` | KOEI SNES |

⚠️ **Duplication flagged, not fixed.** Three implementations of "emit emulator labels from the symbol
table" is exactly the drift-by-re-derivation the SDK warns about — but consolidating them requires the
repos cloned and a judgment call about which is canonical. Recorded here so the next person finds all
three instead of writing a fourth. See [feedback: drift is re-derivation] in the memory area index
`area_re_method`.

Also in the comparisons monorepo's `tools/`: `asm-relabel.py` and `vm-disasm.py` — the latter predating
the NA1 extraction, so verify against `na1-decompiler` before reusing it.

⚠️ **Nothing here is cloned on this machine** (2026-07-21).

## Tags
[nes](../../../../tags/nes.md) · [6502](../../../../tags/6502.md) · [reverse-engineering](../../../../tags/reverse-engineering.md)

---
status: active
created: 2026-07-21
---
# The comparison studies — paired deep-reads

> The four titles the series started as, organized in **paired comparisons**. The pair structure forces
> the comparison rather than letting each game stand alone — which is why these are indexed by *arc*,
> not by console. All four live in a single monorepo.

**Links:** series hub → [Game Annotation](../README.md) · project SDK → [projects/CLAUDE.md](../../CLAUDE.md) ·
hardware → [TIA (2600)](../../../research/atari-2600/tia-reference.md) · [PPU (NES)](../../../research/nes/ppu-reference.md)

## Identity — one repo, four titles

| Field | Value |
|-------|-------|
| Logical name | `game-annotation` *(private)* · `github.com/chrisaacson69/game-annotation` |
| Sibling path | `../game-annotation` (resolved via `.claude/local-paths.md`) |
| Layout | `adventure/` · `mappy/` · `mule/` · `utopia/` · `tools/` |
| Tools | `asm-relabel.py`, `mesen-labels.py`, `mesen-workspace.py`, `vm-disasm.py` |

⚠️ **Not cloned on this machine** (2026-07-21).

⚠️ Its `vm-disasm.py` **predates the NA1 extraction** — verify against `na1-decompiler` before reusing
it. The Mesen tooling here is one of three copies; see [nes/tools](../nes/tools/README.md).

## Arc 1 — Hardware capability (6502 family)

How does the platform's hardware constraint shape the design? *Same CPU family, different
display/memory architecture.*

| Game | Platform | ROM | Status |
|---|---|---|---|
| Adventure | Atari 2600 | 4 KB | complete (8 chapters) |
| Mappy | Famicom/NES | 16 KB + 8 KB CHR | complete (8 chapters) |

**What the arc reveals:** 2600 (no frame buffer, beam racing, 128 bytes RAM) → NES (PPU does rendering,
2 KB RAM, larger code budget) is roughly a **4–8× capability jump that enabled a different *kind* of
game**, not just a bigger one. Mappy also carries the NES design vocabulary inherited from Pac-Man.

## Arc 2 — Mechanical complexity (early strategy engines)

How does the strategic decision engine evolve once the platform stops being the limiting factor?
**Different ISAs on purpose** — mechanical depth is the comparison axis, not the chip.

| Game | Platform | Status |
|---|---|---|
| Utopia | Intellivision (CP1610) | complete — 4,075-line source; one of the earliest console turn-based strategy games (1981) |
| M.U.L.E. | Atari 800 (6502) | complete — 49,981-line 6502 disassembly + Kroah's algorithm doc (ch 7.5 reserved for Chris's strategic-frontier analysis) |

**The arc question:** what does player-vs-player *auctioning* add to a Utopia-style solo economic
engine? Utopia (1981) already runs closed-loop adaptive AI via score-driven rebel spawning; M.U.L.E.
(1983) keeps the economic spine and adds an auction layer.

**Key M.U.L.E. finding — the mechanism-vs-equilibrium gap:** the auction *enables* specialization, but
spoilage + zero-sum incentives may pull the equilibrium back toward self-sufficiency + a Crystite
lottery. A mechanism existing is not the same as a mechanism *mattering* — the seed of
[The Dead-Verb Test](../../../research/gaming/dead-verbs-mechanism-viability.md).

[Nobunaga's Ambition](../nes/na1/README.md) opened as the third entry in this arc, then broke out of the
comparison format entirely and became a full decompiler → [nes/](../nes/README.md).

## Why these aren't filed under a console

Both arcs are **cross-system by design**. Arc 1 pairs Atari 2600 against NES precisely to isolate the
display-architecture jump; Arc 2 spans Intellivision (CP1610 — not even 6502) and Atari 800. Filing
them by console would sever the comparison, which *is* the deliverable. See
[Author Web, Derive Hierarchy](../../../method/author-web-derive-hierarchy.md).

## Tags
[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [games](../../../tags/games.md)

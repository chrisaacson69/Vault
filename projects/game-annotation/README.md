---
status: active
created: 2026-04-26
published: true
layout: layouts/page.njk
title: "Game Annotation Series — moved to standalone repos"
permalink: /projects/game-annotation/
---
# Game Annotation Series — moved to standalone repos

System-level deep-reads of classic game source (Adventure, Mappy, Utopia, M.U.L.E.,
Nobunaga's Ambition) — used as a stress test for LLM interpretation of low-level code.
The chapters, disassembly, and tooling outgrew the vault and now live in their own
repositories (extracted **2026-06-05** with git history preserved):

- **Nobunaga's Ambition** — bytecode-VM decompiler + `lowering-atlas` →
  **[na1-decompiler](https://github.com/chrisaacson69/na1-decompiler)** *(private)*
- **Adventure / Mappy / Utopia / M.U.L.E.** + shared RE tools →
  **[game-annotation](https://github.com/chrisaacson69/game-annotation)** *(private)*
- **Civilization Revolution** — the next title, but a **different method**. CivRev can't be
  cheaply decompiled (no source; the original purged by the iOS 32-bit cull), so it's a
  **strategy/game-design analysis** grounded in community tables + live CivRev2 measurement +
  small exploratory models, not an assembly deep-read. It stays **in-vault** for now →
  **[projects/game-annotation/civ-revolution/](./civ-revolution/README.md)** (thesis:
  [The City-Builder That Plays as a Rush](../../research/gaming/civ-revolution-wide-rush.md)).

The meta-question the series chased — *how well can an LLM interpret vintage assembly
from a cold read?* — produced the thesis that when the source is a weakly-grounded formal
language, you build a deterministic transpiler to a grounded one and let the model read
that (see [Transpilation as a Grounding Strategy](../../research/transpilation-as-grounding.md)).
Nobunaga's `vm_decompile.py` is the existence proof.

## Tags
[6502](../../tags/6502.md) · [nes](../../tags/nes.md) · [assembly](../../tags/assembly.md) · [reverse-engineering](../../tags/reverse-engineering.md) · [games](../../tags/games.md) · [llm-limitations](../../tags/llm-limitations.md)

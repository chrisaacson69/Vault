---
published: true
layout: layouts/page.njk
title: "Nobunaga's Ambition (NES) — moved to its own repo"
permalink: /projects/game-annotation/nobunaga/
---
# Nobunaga's Ambition (NES) — moved to its own repo

This project now lives in a standalone repository:

**→ https://github.com/chrisaacson69/na1-decompiler** *(private)* — the canonical **identity** (relocatable, but can't be browsed because it's private).

**Reachability:** clone it as a **sibling of the vault** so the relative path `../na1-decompiler/` resolves — this is portable across machines (any box that clones the two repos side by side) *and* readable by an agent (unlike the private URL). Read and reuse from there: code, tools, decompiled banks, and docs are under `../na1-decompiler/nobunaga/` — start at its `CONTEXT.md` and `ROADMAP.md`; `../na1-decompiler/lowering-atlas/` is the forward-catalog tooling. (If a machine doesn't follow the sibling layout, its absolute path belongs in that machine's *local* resolver — never committed here, since this page is published.)

The NA1 bytecode-VM decompiler — and its sibling [`lowering-atlas`](../lowering-atlas/README.md) —
were extracted from this vault on **2026-06-05** with full git history preserved (236 commits).
Active work continues in the new repo, not here. The ROM and big/generated artifacts are
gitignored there and kept locally.

**Design & strategy theses** the project sparked (it became a game-design crucible) live in the vault: [NA1 — A Game-Design Crucible](../../../research/gaming/nobunaga-crucible.md) — the index tying this repo to the in-vault theses (e.g. [Randomness as Termination (N≥3)](../../../research/gaming/n3-termination-and-randomization.md)).

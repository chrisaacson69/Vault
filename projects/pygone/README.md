---
status: active
created: 2026-06-05
published: true
layout: layouts/page.njk
title: "pygone — moved to its own repo"
permalink: /projects/pygone/
---
# pygone — moved to its own repo

A sub-4096-byte chess engine — a real modern search (PVS, null-move, LMR, qsearch,
transposition table) shipped in ≤4096 bytes of Python. Now lives in its own repository:

**→ https://github.com/chrisaacson69/pygone** *(private)*

Extracted from this vault on **2026-06-05** (it had been developed here untracked). The
engine, the `pyshrink`/`shrink` minifiers, the match/tactics/watch harness, the vendored
sunfish opponent, and the teardown / floor-vs-ceiling write-ups all moved with it.

**Vault thesis this project is a specimen of:** [Repairing LLM Code — The Two Oracles](../../research/repairing-llm-code.md) — pygone is the *inverse* case (readable Python → 4 KB blob), the floor-vs-ceiling complement to the decompiler's bytecode→readable-C direction. (Re-wired 2026-06-08: the 2026-06-05 repo extraction had severed this link — the seam-breaker the method page warns about.)

## Tags
[chess-engine](../../tags/chess-engine.md) · [code-golf](../../tags/code-golf.md) · [compression](../../tags/compression.md) · [compilers](../../tags/compilers.md)

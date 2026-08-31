---
published: true
layout: layouts/page.njk
title: "Lowering Atlas"
permalink: /projects/game-annotation/lowering-atlas/
---
# Lowering Atlas

> Sibling tooling to the NA1 decompiler, in the **same repo**: compile *known* C control-flow
> constructs through GCC `-O0` (`-fdump-tree-cfg`) and catalog the CFG signature each leaves — sourcing
> the finite inverse-lowering ("atom") table **forward**, instead of reverse-engineering each sub as its
> own exception.

**Links:** parent project → [NA1](../README.md) · system → [NES](../../README.md) ·
series hub → [Game Annotation](../../../README.md) · project SDK → [projects/CLAUDE.md](../../../../CLAUDE.md)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `na1-decompiler` (the `lowering-atlas/` subdir) |
| GitHub | `github.com/chrisaacson69/na1-decompiler` *(public)* |
| Sibling path | `../na1-decompiler/lowering-atlas/` |
| Extracted | 2026-06-05, with full git history preserved |

⚠️ **Not cloned on this machine** (2026-07-21).

## Status

v1 corpus — 27 functions across if / loop / break-continue / switch / `&&`-`||` — confirms NA1 atoms
**1** (continue = multi-latch; GCC's own latch-finder returns `None`), **2** (multi-level break = goto),
the guard/shared-return family, and reproduces the atom-4 shared-switch-exit shape
(`M = post-dom(S)` broken by a guard edge, = `$9C84`).

Flags `for` ≡ `while` and `?:` ≡ `if/else` as **graph-indistinguishable**. cc65 (real 6502) planned as v2.

## Why it's the right shape

Sourcing the atom table forward is the **reuse/convert > rebuild** rule applied to a decompiler: the
compiler is a deterministic oracle you already have, so cataloging what it emits is cheaper *and*
better grounded than inferring the inverse from each decompiled sub. Related:
[DREAM — goto-free structuring](../../../../../research/reverse-engineering/dream-goto-free-structuring.md).

## Tags
[compilers](../../../../../tags/compilers.md) · [reverse-engineering](../../../../../tags/reverse-engineering.md) · [assembly](../../../../../tags/assembly.md) · [6502](../../../../../tags/6502.md)

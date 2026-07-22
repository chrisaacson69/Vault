---
published: true
layout: layouts/page.njk
title: "NA1 — Nobunaga's Ambition (NES)"
permalink: /projects/game-annotation/nobunaga/
---
# NA1 — Nobunaga's Ambition (NES)

> The bytecode-VM decompiler that outgrew annotation and became the series' crucible. `na1-decompiler`
> was extracted from this vault on **2026-06-05** with full git history preserved (236 commits);
> active work continues there, not here.

**Links:** system → [NES](../README.md) · toolchain → [KOEI tools](../../koei/README.md) ·
series hub → [Game Annotation](../../README.md) · sibling tooling → [Lowering Atlas](./lowering-atlas/README.md) ·
project SDK → [projects/CLAUDE.md](../../../CLAUDE.md)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `na1-decompiler` |
| GitHub | `github.com/chrisaacson69/na1-decompiler` *(public)* |
| Sibling path | `../na1-decompiler` (resolved per-machine via `.claude/local-paths.md`) |
| Entry point | `na1-decompiler/nobunaga/CONTEXT.md` → `ROADMAP.md` |
| Also carries | `na1-decompiler/lowering-atlas/` — the forward-catalog tooling |
| Title | Nobunaga no Yabō: *Zenkokuban* · design clock **1986** · Famicom port 1988-03-18 |
| Cart | MMC1/SOROM, 256 KB |
| Depends on | `koei-nes` (family engine) → `nes-render` (generic render core) |

⚠️ **Not cloned on this machine** (2026-07-21) — see `.claude/local-paths.md`. The four RE skills
(`/label-walk`, `/data-walk`, `/var-walk`, `/nobunaga`) cannot run until it is.

**Reachability:** clone as a **sibling of the vault** so `../na1-decompiler/` resolves — portable
across machines *and* readable by an agent. If a machine doesn't follow the sibling layout, its
absolute path belongs in that machine's *local* resolver — never committed here, since this page is
published.

## Why it matters to the series

NA1 is where the meta-question got its sharp answer: when the source is a *weakly-grounded* formal
language (a bespoke bytecode VM), don't read it cold — **build a deterministic transpiler to a grounded
language and let the model read that**. `vm_decompile.py` (bytecode → C) is the existence proof.

It also radiated theses well outside game annotation — agent design, LLM grounding, transpilation —
which is why it gets a crucible hub rather than a single home.

## Theses it sparked

- [NA1 — A Game-Design Crucible](../../../../research/gaming/nobunaga-crucible.md) — the index tying this repo to the in-vault theses
- [Randomness as Termination (N≥3)](../../../../research/gaming/n3-termination-and-randomization.md)
- [The Hollow Opponent](../../../../research/gaming/hollow-opponent-perceived-depth.md) — the AI decoded as one-ply argmin-weakest
- [The Dead-Verb Test](../../../../research/gaming/dead-verbs-mechanism-viability.md) — Bribe/Ninja/Pact/Marry as dead verbs
- [Transpilation as a Grounding Strategy](../../../../research/transpilation-as-grounding.md)

## Tags
[nes](../../../../tags/nes.md) · [6502](../../../../tags/6502.md) · [mmc1](../../../../tags/mmc1.md) · [nobunagas-ambition](../../../../tags/nobunagas-ambition.md) · [reverse-engineering](../../../../tags/reverse-engineering.md) · [assembly](../../../../tags/assembly.md)

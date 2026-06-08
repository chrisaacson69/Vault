---
status: active
created: 2026-06-08
---
# Nobunaga's Ambition (NA1) — A Game-Design Crucible
> Reverse-engineering NA1's bytecode VM down to the actual formulas turned a 1980s strategy game into a **ground-truth source** for game-design theses: claims you can *verify against the machine* rather than infer from play. Several generalize well beyond NA1. This page is the index that ties the crucible together — the repo (the RE work), the vault theses it sparked, and the candidates still in the notes.

**Links:** [Randomness as Termination (N≥3)](./n3-termination-and-randomization.md) (the broadest finding, promoted), [The Multiplayer Coalition Problem](./multiplayer-coalition-problem.md), [The Dominance-Frontier Lens](../dominance-frontier-lens.md) (NA1's per-fief combat maps are a worked instance), [Game Annotation Series](../../projects/game-annotation/README.md)
**Repo:** [`na1-decompiler`](https://github.com/chrisaacson69/na1-decompiler) *(private)* — extracted from this vault 2026-06-05; the decompiler, verified formulas, and emulator live there.

> An **index / crucible page** (per [Specimen & Thesis](../../method/specimen-and-thesis.md)): NA1 is an external-repo specimen whose *deep RE artifacts are repo-only*, but it has fed in-vault theses that need a hub. This is that hub.

## Why NA1 is a crucible, not just a project

Most game-design claims are inferred from play and stay arguable. NA1's claims are **decoded from the bytecode** — the harvest formula, the combat terminator, the natural-death probability, the turn-order shuffle are *read off the machine*, byte-exact. That makes NA1 an unusually strong specimen: when a design principle holds *here*, it holds against ground truth, not against intuition. The generalizable ones are worth lifting out as portable theses; the NA1-specific mechanics stay in the repo.

## Theses it has sparked

**Promoted (in-vault):**
- **[Randomness as the Termination Mechanism (N≥3)](./n3-termination-and-randomization.md)** — the broadest finding: NA1's six independent randomization sources are what let an N≥3 game terminate against the gang-up equilibrium. NA1 is that thesis's canonical worked specimen.

**Candidates still in the notes (repo + memory), worth promoting:**
- **Turn-economy — action slots are the binding constraint** (4 decisions/year; the frontier is 4-D: terrain × count × quality × runway). A portable strategy-design thesis, currently memory-only.
- **Binding-constraint determines analysis depth** — a tight multi-axis constraint (NA1) yields per-position character; a loose single-axis one (Aerobiz) goes flat. A general game-analysis lens.
- **Equilibrium & termination under deterministic play** — the N=17 gang-up draw that motivates the randomization layer (the deterministic half of the n3 thesis).

These are flagged here so the crucible's harvest is visible and the promotions don't get lost in memory (the [release-valve trap](../../method/specimen-and-thesis.md)).

## What stays in the repo (external-repo specimen)

The decompiler pipeline, the verified econ/combat formulas, the emulator, the per-fief tactical maps, and the label/data symbol tables are repo-only by design — they're the *RE artifacts*, not portable theses. Per the two-altitude method, this page is their in-vault anchor; the deep work lives at [`na1-decompiler`](https://github.com/chrisaacson69/na1-decompiler).

## Tags
[games](../../tags/games.md), [strategy](../../tags/strategy.md), [game-theory](../../tags/game-theory.md), [game-ai](../../tags/game-ai.md)

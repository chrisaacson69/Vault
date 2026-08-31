---
status: active
created: 2026-08-10
---
# democracy3-solver
> "Solve" Positech's Democracy 3 by extracting its game-data model and running optimization on it.

**Logical name:** `democracy3-solver` · **Sibling path:** `../democracy3-solver`
(resolved on this machine via [`.claude/local-paths.md`](../../.claude/local-paths.md)) ·
**Remote:** none yet (local-only) · **Stack:** Python (LP/MILP library deferred)

**Links:** [MOO1 Opening Optimizer](../moo1-opening-optimizer/README.md) (sister "solve a game with a
sim + optimizer" project), [project SDK](../CLAUDE.md), [Three-Layer Method](../../research/karpathy-three-layer-method.md)

## Overview
Democracy 3's entire simulation is **data, not code**: `data/simulation/*.csv` defines a feedback
network of ~40 simulation values, ~123 policies, 21 voter groups, and situations, where every node
emits **effects** that are polynomial functions of a source value `x` (optionally lagged by *inertia*).
A turn resolves the network to a fixed point; vote share is read off the voter groups. That makes the
game a **nonlinear constrained optimization over a fixed-point simulator** — LP/MILP are the tractable
approximations, not the native form.

**Two-layer architecture:** (1) a grounded equilibrium **simulator** built by *converting* the CSV
grammar (the oracle), then (2) an **optimizer** on top — linearized LP for marginal advice, MILP for a
global solve — with every candidate scored by Layer 1. This is the verification-layer thesis made
concrete: the simulator is the accumulated state that keeps the optimizer honest.

## Goals
- [x] Layer 0 — CSV + effect-formula parser; loads real game data, surfaces the 6 shipped data typos
      instead of guessing. (11 formula tests pass.)
- [x] Scope agreed — strategic optimizer, not a gameplay sim (see repo `notes/scope.md`): maximize a
      **user-defined X over outcomes + finances** s.t. `budget_balance ≥ 0`; finances first-class and
      endogenous; voting/cynicism/assassination/political-capital/implementation-delay all dropped.
- [ ] Layer 1 — equilibrium fixed-point solver of the effect network + reconstructed budget. Needs the
      *combination rule* (keystone). Validate against the game's `data_dump/` hook + real play.
- [ ] Layer 2 — optimizer: constrained max of X (`balance ≥ 0`), linearized-LP → MILP. "Best return
      per $" = the budget constraint's shadow price; minimizing spend is *not* the goal.

## Notes
- Game CSVs are the single source of truth; read in place (no copy → no drift).
- Classify-first: nonlinear fixed point + small combinatorial part (discrete sliders, situation on/off).
- Harvest confirmed findings back to the vault (this repo = the dated specimen).

## Tags
[python](../../tags/python.md), [optimization](../../tags/optimization.md), [gaming](../../tags/gaming.md)

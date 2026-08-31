---
status: active
created: 2026-08-10
---
# democracy3-solver
> "Solve" Positech's Democracy 3 by extracting its game-data model and running optimization on it.

**Logical name:** `democracy3-solver` · **Sibling path:** `../democracy3-solver`
(resolved on this machine via [`.claude/local-paths.md`](../../.claude/local-paths.md)) ·
**Remote:** https://github.com/chrisaacson69/democracy3-solver *(public)* · **Stack:** Python (LP/MILP library deferred)

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
- [x] Layer 1 — equilibrium fixed-point solver + reconstructed budget. **Running** against the live
      game CSVs: converges in 51 iterations (`max_delta 9.1e-07`); budget reconstruction lands within
      a few $Bn per line vs the game (Military 232/225, Pensions 200/204, Schools 95/98).
- [x] Layer 2 — marginal + greedy optimizer. `frontier.py` ranks moves as free-wins / paid-per-$ /
      savings-with-tradeoff under `balance ≥ 0`; `optimize_us.py` drives balance −$97Bn → $0Bn and
      X −1.48 → +1.44 over 40 moves. LP/MILP path still deferred (`pulp` declared, MILP untested).
- [ ] **Validate Layer 1 against the independent oracle.** Current check is against a turn-1 savegame —
      a *transient*, not an equilibrium (mean |diff| 0.115; CrimeRate 0.82, Health 0.68). The game ships
      `data/simulation/data_dump/{inputs,outputs}`, which the repo's own `CLAUDE.md` names as the real
      oracle; it is not yet wired in. Verification-independence says this is the next gate, not more solver.
- [ ] Finance + membership subsystems (`_effectivedebt_`, `_global_interest_rates_`, `*_perc`) are still
      zeroed, so loop gain is too low to hold the game's doom basin — the blocker named in repo `notes/scope.md`.

## Notes
- Game CSVs are the single source of truth; read in place (no copy → no drift).
- Classify-first: nonlinear fixed point + small combinatorial part (discrete sliders, situation on/off).
- Harvest confirmed findings back to the vault (this repo = the dated specimen).

## Tags
[python](../../tags/python.md), [games](../../tags/games.md), [simulation](../../tags/simulation.md)

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
- [x] Layer 2 — **both optimizers built** (2026-08-31; repo `notes/layer2.md`). A **trust-region SLP**
      (ℓ1-penalty merit function, step acceptance, adaptive region) replaces the old unconditional-step
      version that swung the balance by $1500Bn between iterations. A **MILP** encodes the whole network
      at once — and because 89% of its 1149 edges are affine and the nonlinear rest read only 57 source
      nodes, it fits in ~514 binaries. Layer 1 re-scores every candidate from either.
- [x] **The situation flags are decision variables in the MILP** — a situation's hysteresis band is a
      state where active *and* inactive are both self-consistent, so the binary IS the basin choice.
      That makes basin escape searchable, which the SLP structurally cannot do (it freezes the set).
      On the US start it escapes 10 of 12 starting situations: X −0.20→+2.98 at +$75Bn, Layer-1 verified.
- [x] **The lesson worth keeping: the higher number was the less trustworthy one.** The SLP hits X=3.000
      (the objective's theoretical ceiling — all six nodes on their clamp bounds) but only *conditional on
      its frozen basin*; release the situations and the same policy vector scores 2.803 at −$9Bn, infeasible.
      The MILP's lower +2.977 is the one that holds. When two optimizers disagree, the one that did not
      assume its basin wins. Chosen objective also **saturates**, so it never exercises the Pareto premise.
- [ ] **Validate Layer 1 against the independent oracle — the prerequisite is missing.** The game ships
      `data/simulation/data_dump/{inputs,outputs}`, which the repo's `CLAUDE.md` names as the real oracle,
      but **both directories are empty**: the game only writes them under a debug condition not yet found.
      Finding that trigger is the actual gate, not writing more validation code.
- [ ] Finance + membership subsystems (`_effectivedebt_`, `_global_interest_rates_`, `*_perc`) still
      zeroed — 11 unresolved sources reported on every MILP run — so loop gain is too low to hold the
      game's doom basin. Two shipped, grounded, **unread** data sources answer this: `data/simconfig.txt`
      (interest rates, credit ratings, `DEBT_TO_GDP_MAX`) and `data/missions/{usa,uk,france,germany,
      canada,australia}/` (per-country policy start vector, income bands, GDP range, population,
      starting debt). Reading `missions/` would also retire `budget.py`'s screenshot-calibrated scale
      factors and generalise the solver past the US.

## Notes
- Game CSVs are the single source of truth; read in place (no copy → no drift).
- Classify-first: nonlinear fixed point + small combinatorial part (discrete sliders, situation on/off).
- Harvest confirmed findings back to the vault (this repo = the dated specimen).

## Tags
[python](../../tags/python.md), [games](../../tags/games.md), [simulation](../../tags/simulation.md)

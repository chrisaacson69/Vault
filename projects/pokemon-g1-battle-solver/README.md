---
status: active
created: 2026-10-12
---
# Pokémon G1 Battle Solver
> Exact absorbing-chain solutions for Generation 1 Pokémon 1v1 battles, grounded in the pret/pokered disassembly. The aim is to replace a 170k-battle Monte Carlo ranking with exact answers, plus the checks it skipped.

**Links:** [Pokémon Gen 1 — 170,000 Sampled Battles](../../research/gaming/pokemon-gen1-1v1-tournament.md) (**the thesis this project tests**), [D&D Monster Tournament — Exact Markov Chains](../../research/gaming/dnd-monster-tournament-markov.md) (the fixed-policy ⇒ Markov-chain argument), [HeroClix](../heroclix/README.md) (**the prior art to reuse**: `duel.py` exact 1v1 chain + `dominance.py`), [Risk — The Attrition Constant](../../research/gaming/risk-attrition-odds.md), [Transpilation as Grounding](../../research/transpilation-as-grounding.md)

**Logical name:** `pokemon-g1-battle-solver` — [github.com/chrisaacson69/pokemon-g1-battle-solver](https://github.com/chrisaacson69/pokemon-g1-battle-solver) (public), cloned as a sibling (`../pokemon-g1-battle-solver`). Python 3.14, stdlib only so far.
**Repo entry point:** `README.md` (status table) → `CLAUDE.md` (hard rules).

## Status (2026-10-12)

- **Done:** `tools/dominance.py`, evolution dominance over all 72 Gen 1 edges from pokered. 48 strictly dominated, 56 if pre-evolution moves carry over. The 16 exceptions are type changes or stat losses (Poliwhirl → Poliwrath is the notable one).
- **Next:** merge Yellow learnsets (pokeyellow); find Gym Leader Matt's full ranking table and run the dominance-inversion check; then the exact duel, reusing heroclix's chain machinery after reading it.

## Tags

[games](../../tags/games.md) · [projects](../../tags/projects.md) · [simulation](../../tags/simulation.md)

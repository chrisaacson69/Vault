---
status: active
created: 2026-10-18
---
# bw-combat-matrix
> Equal-cost counter matrix for every Brood War unit pair: exact per-hit duels scored by Lanchester's square law.

**Logical name:** `bw-combat-matrix` · **Sibling path:** `../bw-combat-matrix`
(resolved via [`.claude/local-paths.md`](../../.claude/local-paths.md)) · **Remote:** none yet (local commits only) ·
**Stack:** Python (data pipeline) + JS (engine and page) · **Live page:** https://claude.ai/artifact/QTP6TRokrsiXW6wkGuBTcL *(private)*

**Links:** [BattleValue](../../research/gaming/battle-value.md) (this is a matchup-specific BV/Cost specimen),
[project SDK](../CLAUDE.md)

## Overview
Every number comes from the game's own `.dat` files, cross-checked against BWAPI. Combat rules
are converted from OpenBW's engine source rather than wiki tables. The two values the engine
can't fix (Firebat hits and Interceptor cycle) are empirical, labelled as such, and adjustable.
The repo README holds the pipeline and the model limits.

## Status (2026-10-18)
- [x] `.dat` decoder + BWAPI cross-check (2,344 fields; only turret-hull diffs)
- [x] Duel engine with shields/armor/type order, stim, adrenal, regen, acid spores, carrier, reaver, suicide, mines; hits-to-kill both ways (volley + in-fight); 23 hand-worked tests
- [x] Interactive page: per-side upgrades, resources (gas weight) or supply cost
- [x] Local commit (54a7f2a)
- [ ] GitHub remote
- [ ] Splash / army-scale focus-fire (the model's biggest blind spot: Firebat vs Zergling reads 0.29)

## Tags
[games](../../tags/games.md), [strategy](../../tags/strategy.md)

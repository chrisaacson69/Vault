# CivRev — tools (engines/generators)

The exploratory models for the CivRev strategy space — the analog of NA1's sim/tools, scaled to a
tables+measurement game (no decompiled engine to emulate). **Nothing built here yet** — this is the planned
slate. Each tool consumes the structured [`data/`](../data/README.md) and tests a claim in the
[thesis](../../../../research/gaming/civ-revolution-wide-rush.md).

## Planned engines
1. **`tech-frontier.py` — the dominance frontier over the tech tree.** Plot beaker-cost vs first-discover-
   bonus value; surface the *thin spine* (the few techs that dominate) and the dominated bulk. Pure function
   of the captured tech table — **buildable now**, no measurement needed. Tests: "the research path is much
   thinner than it looks."
2. **`wide-vs-tall.py` — the MIRR model.** Compare "mint a city via Republic 1-pop settler" vs "grow a city
   organically" under the empire's own growth rate (the hurdle). **Blocked on measurement**: needs the
   city-growth/food curve + the Republic rule. Turns *"wide tends to beat tall"* into *"beats by X."*
3. **`opening-rush.py` — decapitation-rush feasibility.** Given AI opening tempo (~5/~10) + map layout +
   hut/gold RNG, how many capitals fall before turn ~10? **Blocked on measurement** (AI tempo, contact-
   immunity, lone-Warrior-vs-capital). Tests the opening exploit's ceiling/variance.

## tech-frontier — v1 status & v2 axes
**v1 (built, runs):** values ONLY each tech's first-discover bonus, in gold-equivalent, as a
function of city count. Confirmed two thesis claims from grounded data: the **thin spine** (4 of 46
techs Pareto-dominate the tree) and the **1→2-city regime flip** (one-time bonuses like Free Walls
lead the single-city opening; per-city bonuses like Irrigation/Literacy take over once you expand).
Magnitudes ride on soft weights; the *structure* (per-city scales with width × time; one-time is
flat) is grounded in the bonus types.

**Known limitation — "pure math without context" (Chris).** First-bonus ROI is ONE projection of a
multi-axis value. v2 axes, from observed play:
1. **Unlock value** — a tech is worth what it *enables*, not just its bonus. Code of Laws → **Republic**
   (the 1-pop-settler engine) dwarfs its Free Trading Post; Pottery's bonus is nothing but it unlocks
   Hanging Gardens. *Needs the governments table (gap) + wonder/unit valuation.*
2. **Capability ≠ hammer cost** — a free Catapult's value is "sieges behind walls," not 20 hammers
   (the face-efficiency trap, see research/gaming/capability-without-leverage.md). *Needs a unit
   tactical-role model (siege / naval / map-control), not just A/D/M.*
3. **Placement/control context** — Free Walls auto-lands on the "best-developed" city, not where
   you need it → value below face. *Hard to model without the placement rule (measure on CivRev2).*
4. **Inter-tech dominance** — Navigation *looks* great but is dominated by Steam Power (Galleon
   2/2/3 ⪯ Cruiser 6/6/5 for +10 cost, and Steam Power is on the path you walk anyway). **GROUNDED
   and buildable now** from the units table: flag any tech whose unlocked unit is Pareto-dominated by
   a not-much-deeper tech's unit. The dominance-frontier lens applied to *unlocks* — catches the traps
   v1's first-bonus ROI can't see.
   **→ BUILT: `trap-detector.py`.** Criterion = *dead-end leaf tech + dominated unit* (not raw
   domination, which is the tree's default). Flags Navigation/Galleon as the lone tech-trap; refuses
   to flag the on-path progression line; also surfaces negative-window unit-traps (Legion ⪯ the
   *cheaper* Horseman). Remaining caveat = A/D/M only, ignores special abilities (Submarine stealth,
   siege-through-walls) → that's the v2 **capability** axis (#2), still open.

## Shared data
`civrev_data.py` is the single source of truth (tech table w/ cost+prereq+bonus, unit stats, prod
costs), grounded to `raw/civrev-*.md`. Both `tech-frontier.py` and `trap-detector.py` import it so the
tables can't drift between tools. **Built so far:** `tech-frontier.py`, `trap-detector.py`. Blocked on
the CivRev2 measurement session: `wide-vs-tall.py`, `opening-rush.py`.

## Principle
Deterministic generators over validated data beat hand-analysis (the vault's *mechanical → generator*
rule): where an answer is a function of the captured tables, write the function; reserve judgment calls for
where the data genuinely runs out. Keep every tool's output traceable to a `data/` value + its `raw/`
provenance.

---
status: active
created: 2026-06-22
published: true
layout: layouts/page.njk
title: "Civilization Revolution — Project Hub"
permalink: /projects/game-annotation/civ-revolution/
---
# Civilization Revolution — Project Hub
> The next title in the [Game Annotation Series](../README.md), but a **different method**: CivRev can't be cheaply decompiled (no source, console/mobile binaries, the original purged by the iOS 32-bit cull), so this is a **strategy/game-design analysis grounded in community tables + live CivRev2 measurement + small exploratory models** — not an assembly deep-read. This folder is the working home for that data and tooling; the portable thesis lives in `research/gaming/`.

**Thesis (the deliverable):** [Civilization Revolution — The City-Builder That Plays as a Rush](../../../research/gaming/civ-revolution-wide-rush.md) — the intended city-builder collapses into an opening decapitation rush + a wide-expansion MIRR snowball; building tall, culture, and the game's designed identity are *dead verbs*.
**Frameworks it instantiates:** [The Dead-Verb Test](../../../research/gaming/dead-verbs-mechanism-viability.md) (specimen #2), [The MIRR 4X Framework](../../../research/gaming/mirr-4x-framework.md) (live confirmation), [The Hollow Opponent](../../../research/gaming/hollow-opponent-perceived-depth.md), [Dominance-Frontier Lens](../../../research/dominance-frontier-lens.md).

## Why a project, not just vault pages
The thesis pages are portable theses (they stay in `research/gaming/`). This project exists to hold the
things a research page shouldn't: the **structured game data** and the **engines/generators** we build to
explore the strategy space (the CivRev analog of NA1's sim/tools). Started in-vault; extract to a sibling
repo later only if a real code base grows (as NA1 did on 2026-06-05).

## Structure
- **[`data/`](./data/README.md)** — the game tables. Raw Tier-1 captures live in the vault's `raw/civrev-*.md`
  (source of truth); `data/` is for the *structured* (JSON/CSV) versions the tools consume, once built.
- **[`tools/`](./tools/README.md)** — engines/generators (planned): a tech dominance-frontier calculator, a
  wide-vs-tall MIRR model, an opening-rush feasibility model. None built yet.
- **Thesis** — `research/gaming/civ-revolution-wide-rush.md` (portable, stays in research).

## Grounding status
**Captured (Tier-1, community wikis), in `raw/`:** technologies, wonders, units, buildings, civilizations,
great people, relics, terrain, combat modifier structure, resource→tech map. See
[`raw/civrev-civilopedia-tables.md`](../../../raw/civrev-civilopedia-tables.md) and its four companion files.

**Load-bearing gaps — the CivRev2 measurement session (next):** the city growth/food curve (turns
*wide-beats-tall* from "tends to" into "by X"), the Republic 1-pop-settler rule + founding pop, the AI
opening tempo (~5/~10-turn clock), the rush-cost formula, unit sell values, and the per-resource bonuses
(paste the 403'd Fandom table). The same session doubles as the **"did CivRev2 learn?"** test — whether the
sequel nerfed the Republic exploit, the wide snowball, the backfill, or the immune scout.

## Next steps
1. **CivRev2 measurement session** — fill the load-bearing numbers above against Chris's live oracle.
2. **Structured data** — convert the `raw/` tables into `data/` JSON for the tools.
3. **Engines** — build the dominance-frontier + wide-vs-tall MIRR models in `tools/`.

## Tags
[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [game-ai](../../../tags/game-ai.md) · [game-theory](../../../tags/game-theory.md)

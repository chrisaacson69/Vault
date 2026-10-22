---
status: active
created: 2026-10-21
published: true
layout: layouts/page.njk
title: "dj-score"
permalink: /projects/dj-score/
---
# dj-score
> The one shared library for DJ track analysis — beat grid, key, events, spectral score, collision, Rekordbox export. Camelot is its UI; CyborgDJ is its second consumer.

**Repo:** [dj-score](https://github.com/chrisaacson69/dj-score) — logical name `dj-score`, sibling `../dj-score` (next to `camelot-from-youtube` and `cyborgdj`)
**Links:** [Camelot From YouTube](../camelot-from-youtube/README.md) — the source specimen and the UI that consumes it, [CyborgDJ](../cyborgdj/README.md) — second consumer (its forked scripts retire), [Well-Structured Python at Scale](../../research/well-structured-python.md) — the design this follows (§2 layout, §4 migration recipe), [Eyes and Ears for LLMs](../../research/eyes-and-ears-for-llms.md) — G1 grid / G7 stems goals, [DJ Blend Tool Test Plan](../../research/dj-blend-tool-test-plan.md) — Phase 3 grid results behind the grid swap, [CyborgDJ as Controller](../../research/cyborgdj-inference-interface.md) — this library as an MCP tool surface (design; needs cache-first analysis)

## State

Ledger steps 1–5 done (2026-10-21), archiving deferred until all extraction is finished. dj-score holds the model,
the cache store, every analysis module and the services. camelot's UI now runs on them, verified by a replayed-
session oracle against the pre-repoint UI. Every camelot CLI now has a `dj-score` subcommand. Code-only: fixtures are
generated locally. Camelot extraction complete (2026-10-22: nothing left to harvest, per a Breeder hand-label evaluation). Camelot's retired tools are archived locally (2026-10-22). Tracks now live in a shared, local-only music library (`../music`: originals, plus `analysis/<track>/` for derived files), resolved for every tool by dj-score `adapters/library`. Next: the comb grid as an optional second grid (step 6 prep), then the CyborgDJ audit: code, data (same cleanup as camelot) and whether the mixer is its own library. Python ≥ 3.11, `src` layout; layers `cli → bootstrap → (adapters | services) → ports → domain`
enforced by import-linter, core kept free of plotting/UI/ML/IO packages. Migration from camelot is
copy → repoint → archive (nothing is purged; retired tools and their outputs move to camelot's `archive/`); the per-tool keep / fold / retire verdicts and the order live **in the repo** at
`MIGRATION.md` — that file is the single source; this page only points at it.

## Tags
[music](../../tags/music.md), [python](../../tags/python.md), [audio-processing](../../tags/audio-processing.md)

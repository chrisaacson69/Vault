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
**Links:** [Camelot From YouTube](../camelot-from-youtube/README.md) — the source specimen and the UI that consumes it, [CyborgDJ](../cyborgdj/README.md) — second consumer (its forked scripts retire), [Well-Structured Python at Scale](../../research/well-structured-python.md) — the design this follows (§2 layout, §4 migration recipe), [Eyes and Ears for LLMs](../../research/eyes-and-ears-for-llms.md) — G1 grid / G7 stems goals, [DJ Blend Tool Test Plan](../../research/dj-blend-tool-test-plan.md) — Phase 3 grid results behind the grid swap

## State

Ledger steps 1–2 committed (2026-10-21): model, the one cache store, and a golden-fixture generator. The repo
is code-only, so fixtures are generated locally and gitignored. Next is step 3 (domain leaves). Python ≥ 3.11, `src` layout; layers `cli → bootstrap → (adapters | services) → ports → domain`
enforced by import-linter, core kept free of plotting/UI/ML/IO packages. Migration from camelot is
copy → repoint → archive (nothing is purged; retired tools and their outputs move to camelot's `archive/`); the per-tool keep / fold / retire verdicts and the order live **in the repo** at
`MIGRATION.md` — that file is the single source; this page only points at it.

## Tags
[music](../../tags/music.md), [python](../../tags/python.md), [audio-processing](../../tags/audio-processing.md)

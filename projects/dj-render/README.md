---
status: active
created: 2026-10-22
published: true
layout: layouts/page.njk
title: "dj-render"
permalink: /projects/dj-render/
---
# dj-render
> The render library: a DJ mix spec in, mixed audio out (time-stretch, EQ, crossfade, gain). dj-score measures; dj-render renders; CyborgDJ is the controller over both.

**Repo:** [dj-render](https://github.com/chrisaacson69/dj-render) — logical name `dj-render`, sibling `../dj-render` (next to `dj-score` and `cyborgdj`). Python ≥ 3.11, `src` layout; numpy, scipy, soundfile, pyrubberband (Rubber Band CLI and ffmpeg on `PATH`).
**Links:** [dj-score](../dj-score/README.md) — the analysis library it pairs with, [CyborgDJ](../cyborgdj/README.md) — the controller that consumes it, [CyborgDJ as Controller](../../research/cyborgdj-inference-interface.md) — the MCP layer meant to sit over both libraries, [Crossover Calibration](../../research/dj-crossover-calibration.md) — the knob sweep that will render trials through it, [Well-Structured Python at Scale](../../research/well-structured-python.md)

## State

Split out of CyborgDJ's `engine` package on 2026-10-22, at the end of the CyborgDJ audit (dj-score migration step 7).
Chris: *"the dependency issues are key here and I think a render library goes a long way to making CyborgDJ more
of a controller, so we can build the MCP layer on top of both libraries."* The code was copied unchanged; four reference
transitions render byte-identical through it. Its one architecture rule, enforced by import-linter: the renderer
takes grid results (tempo, first downbeat, bar frames) and never computes analysis, so no librosa and no dj-score.
Open: it still detects a first downbeat itself when a spec gives none, and the specs carry hand-typed tempos
(up to 0.86% off). Reading the grid from dj-score's analysis in the music library changes the audio, so it waits
on listening tests. Details live in the repo (`CLAUDE.md`) and in CyborgDJ's `AUDIT.md`; this page only points.

## Tags
[music](../../tags/music.md), [python](../../tags/python.md), [audio-processing](../../tags/audio-processing.md)

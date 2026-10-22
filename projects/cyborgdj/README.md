---
status: active
created: 2026-02-20
published: true
layout: layouts/page.njk
title: "CyborgDJ"
permalink: /projects/cyborgdj/
---
# CyborgDJ
> Human writes the score, machine executes the mix — a programmatic DJ mixing engine.

**Repo:** [cyborgdj](https://github.com/chrisaacson69/cyborgdj)
**Links:** [dj-render](../dj-render/README.md) — the render library CyborgDJ's engine became (2026-10-22), [dj-score](../dj-score/README.md) — the analysis library, [Eyes and Ears for LLMs](../../research/eyes-and-ears-for-llms.md) — the translator goals (G1–G6) whose text surface this engine executes, [DJ Set 1](../dj-set-1/README.md), [Set Mastering](../set-mastering/README.md), [Camelot From YouTube](../camelot-from-youtube/README.md), [Programmatic DJ Mixing Tools](../../research/programmatic-dj-mixing-tools.md), [The Cyborg Model](../../research/cyborg-model.md), [DJ EQ Blending Technique](../../research/dj-eq-blending.md), [Multi-Genre & Wide-BPM Mixing](../../research/dj-multi-genre-mixing.md), [DJ Blend Tool Test Plan](../../research/dj-blend-tool-test-plan.md), [dj-score](../dj-score/README.md) — shared analysis library; replaces the forked `scripts/{spectral_collision,export_rekordbox,analyze_track}.py` and the stale `camelot/` copy, [CyborgDJ as Controller](../../research/cyborgdj-inference-interface.md) — decided 2026-10-21: CyborgDJ becomes the controller; dj-score is its tool surface

## Overview

A programmatic DJ mixing engine that reads structured JSON specs and produces continuous mixed audio. Creative decisions (track selection, transition design, EQ strategy) stay with the human; mechanical execution (beat-matching, time-stretching, crossfading, rendering) is automated.

The mix lives in a JSON spec file — change a bar number, re-render, listen, repeat.

## Status (2026-10-22)

Cleaned up by the [dj-score](../dj-score/README.md) migration's step 7 audit (the repo's `AUDIT.md`). The repo holds
code only: tracks live in the shared, local-only music library (`../music`); mix projects (specs, renders, notes)
live in `music/CyborgProjects/<project>/` (Preach = DJ Set 1b, Loud, dinka-giga-mix, EZ). Superseded scripts are
archived locally. **Open:** every spec renders on camelot's contaminated tempogram BPMs (up to 0.86% off the
measured tempo), compensated by hand-set downbeats; switching the renderer to the library's comb grid changes the
audio, so it waits on listening tests (a Foss A/B: "a little cleaner") and an objective verify step.

## Tech Stack

| Library | Role |
|---------|------|
| **soundfile** (+ ffmpeg for MP3) | Audio I/O |
| **pyrubberband** (Rubber Band CLI) | Time-stretching |
| **scipy** | EQ, filtering, first-downbeat onsets |
| **numpy** | Array math for mixing and crossfades |

## Architecture

CyborgDJ is now the **controller** over two libraries: [dj-score](../dj-score/README.md) measures and
[dj-render](../dj-render/README.md) renders (split out 2026-10-22, because the dependencies differ: the renderer needs
no librosa, analysis needs no Rubber Band). The repo keeps the CLI and controller-side scripts; the MCP layer is to
sit over both libraries ([controller design](../../research/cyborgdj-inference-interface.md)).

## Transition Features

| Feature | Spec key | Notes |
|---------|----------|-------|
| Crossfade curves | `fade_type`, `fade_power` | linear, equal_power, exp, s_curve |
| Fader automation | `automation.outgoing/incoming` | `[[bar, value], ...]` breakpoints |
| Per-band EQ automation | `automation.outgoing_low/mid/high`, `incoming_low/mid/high` | Independent gain envelopes per frequency band. See [EQ Blending Research](../../research/dj-eq-blending.md) |
| 3-band EQ ramp | `eq_3band_outgoing/incoming` | Start/end gains per band with power curve |
| Parametric EQ | `eq_outgoing/incoming` | Highpass, lowpass, shelf, peak filters |
| Tempo ramp | `tempo_ramp` | Gradual BPM matching across overlap |
| Decoupled fader | `fade_offset_bars`, `fade_bars` | EQ spans full overlap, fader moves in sub-region |
| Outgoing hold | `outgoing_hold` | Keep outgoing at full volume, slam cut |

Per-band EQ automation subsumes fader automation, 3-band EQ ramp, decoupled fader, and outgoing hold into a single general model. When EQ lanes are present, legacy features are ignored with a warning. See the [implementation results](../../research/dj-eq-blending.md#step-1-implementation-results-2026-02-22) for practical findings.

## Pipeline Position

Part of the full cyborg DJ workflow:
1. **dj-score** analyzes tracks (grid, key, events, spectra; formerly Camelot)
2. **DJ Set 1** describes the mix (track order, transitions, creative intent)
3. **CyborgDJ** executes the mix from JSON spec
4. **Set Mastering** applies light mastering polish

## Tags
[music](../../tags/music.md), [audio-processing](../../tags/audio-processing.md), [python](../../tags/python.md), [cyborg](../../tags/cyborg.md)

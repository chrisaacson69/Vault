# CyborgDJ
> Human writes the score, machine executes the mix — a programmatic DJ mixing engine.

**Status:** active
**Created:** 2026-02-20
**Repo:** [cyborgdj](https://github.com/chrisaacson69/cyborgdj)
**Links:** [DJ Set 1](../dj-set-1/README.md), [Set Mastering](../set-mastering/README.md), [Camelot From YouTube](../camelot-from-youtube/README.md), [Programmatic DJ Mixing Tools](../../research/programmatic-dj-mixing-tools.md), [The Cyborg Model](../../research/cyborg-model.md)

## Overview

A programmatic DJ mixing engine that reads structured JSON specs and produces continuous mixed audio. Creative decisions (track selection, transition design, EQ strategy) stay with the human; mechanical execution (beat-matching, time-stretching, crossfading, rendering) is automated.

The mix lives in a JSON spec file — change a bar number, re-render, listen, repeat.

## Tech Stack

| Library | Role |
|---------|------|
| **soundfile** | Audio I/O (WAV, FLAC) |
| **librosa** | Beat detection, BPM analysis |
| **pyrubberband** | Time-stretching (Rubber Band Library) |
| **pedalboard** | EQ, filtering, gain (Spotify, JUCE-based) |
| **numpy** | Array math for mixing and crossfades |

## Architecture

```
cyborgdj/
├── loader.py        # Audio I/O, beat detection, bar grid computation
├── stretcher.py     # Time-stretch via pyrubberband
├── crossfader.py    # Crossfade math — fade curves, overlap mixing
├── effects.py       # EQ and gain via pedalboard
├── engine.py        # Orchestrator — reads spec, coordinates everything
└── cli.py           # Command-line interface
```

## Pipeline Position

Part of the full cyborg DJ workflow:
1. **Camelot** analyzes tracks (BPM, key, structure, events)
2. **DJ Set 1** describes the mix (track order, transitions, creative intent)
3. **CyborgDJ** executes the mix from JSON spec
4. **Set Mastering** applies light mastering polish

## Tags
[music](../../tags/music.md), [audio-processing](../../tags/audio-processing.md), [python](../../tags/python.md), [cyborg](../../tags/cyborg.md)

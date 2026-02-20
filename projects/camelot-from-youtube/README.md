# Camelot From YouTube
> Music analysis tool for detecting key, BPM, structure, and energy at the phrase level.

**Status:** active
**Created:** 2026-02
**Repo:** `https://github.com/chrisaacson69/camelot_from_youtube`
**Links:** [DJ Set 1](../dj-set-1/README.md), [Order Playlist](../order-playlist/README.md), [Set Mastering Pipeline](../set-mastering/README.md)

## Overview

Python tool suite for DJ audio analysis. Started as a CLI key detector using chroma/Krumhansl profiles, expanded into a full GUI (`audio_ui.py`) with BPM detection, beat grid, key timeline, structural event detection (drops, builds, fills, transitions), stem separation, and loudness analysis.

### Components

- **`camelot_from_youtube.py`** — CLI: single-window, consensus, and timeline key analysis
- **`audio_ui.py`** — tkinter/matplotlib GUI with playback, zoom, per-chart state, event editing
- **`key_detect.py`** — Camelot wheel mapping and key detection
- **`rekordbox_export.py`** — Export analysis data to Rekordbox XML (BPM, key, beat grid, cue points)

### Key Features

- BPM detection with beat grid alignment
- Key detection per phrase with Camelot wheel mapping
- Structural event detection (energy changes, percussive fills, melodic drops)
- Stem separation (drums, bass, vocals, other)
- Rekordbox XML export with hot cues and memory cues
- Independent zoom/pan per chart view with auto-follow during playback

## Dependencies

- `librosa`, `numpy`, `scipy` — audio analysis
- `matplotlib`, `tkinter` — GUI
- `pygame` — audio playback
- `pyrekordbox` — Rekordbox XML export
- Foreign tool: `yt-dlp` (YouTube audio download, separate repo)

## Tags
[music](../../tags/music.md), [python](../../tags/python.md), [ai](../../tags/ai.md)

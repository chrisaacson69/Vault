# Order Playlist
> DJ playlist optimizer using Camelot harmonic mixing, BPM smoothness, and energy arcs.

**Status:** complete
**Created:** 2026
**Repo:** `C:\Users\Chris.Isaacson\source\repos\order_playlist`
**Links:** [Camelot From YouTube](../camelot-from-youtube/README.md), [DJ Set 1](../dj-set-1/README.md)

## Overview

Python CLI tool that orders DJ/music tracks for optimal harmonic flow. Uses greedy nearest-neighbor algorithm with configurable weights for Camelot key compatibility, BPM smoothness, and energy arc dynamics. Supports build/cooldown modes, regex track selection, and CSV output.

### Algorithm

- Camelot wheel distance scoring (same key, adjacent, relative major/minor)
- BPM delta penalty with configurable weight
- Energy arc shaping (build up vs. cool down)
- Greedy nearest-neighbor path construction

## Tags
[python](../../tags/python.md), [music](../../tags/music.md)

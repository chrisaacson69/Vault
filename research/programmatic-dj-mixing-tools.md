# Programmatic DJ Mixing Tools
> Research into tools and libraries that can execute a DJ mix from written instructions — loading tracks, time-stretching, beat-matching, applying EQ crossfades, and rendering a continuous output file.

**Status:** active
**Created:** 2026-02-20
**Links:** [DJ Set 1](../projects/dj-set-1/README.md), [Set Mastering Pipeline](../projects/set-mastering/README.md), [Camelot From YouTube](../projects/camelot-from-youtube/README.md)

---

## The Use Case

We have a [detailed markdown document](../projects/dj-set-1/README.md) describing an 11-track DJ set with:
- Exact bar numbers for cue-in/cue-out per track
- Overlap lengths in bars (e.g., 35-bar overlap between Foss and Alone)
- BPM values per track (120 -> 123 -> 126 -> 129 staircase)
- Key information (Camelot notation) per section
- EQ notes (e.g., "cut Below The Belt's mids/highs" during transition 9->10)
- Energy curves and structural events (drops, breakdowns, builds)
- Transition strategies (clean cut vs. crossfade vs. percussive bridge)

**Goal:** A tool that reads these instructions and executes the mix automatically, producing a continuous WAV/FLAC file.

### Requirements Checklist

| Requirement | Description |
|------------|-------------|
| Load tracks | Read multiple audio files (WAV, FLAC, MP3) |
| Time-stretch | Change tempo without pitch shift (e.g., 120 BPM -> 123) |
| Cue points | Start playback at bar X, end at bar Y |
| Crossfade with EQ | Overlap two tracks with independent EQ control per track |
| Gain staging | Per-track volume adjustments |
| Output | Render a single continuous audio file |

---

## Category 1: Python Libraries (Build-It-Yourself Stack)

The most flexible approach: assemble a pipeline from individual Python libraries. This gives maximum control over every parameter but requires writing the orchestration code yourself.

### Core Stack Recommendation

```
librosa          — BPM detection, beat tracking, audio analysis
pyrubberband     — High-quality time-stretching (wraps Rubber Band Library)
pedalboard       — EQ, filtering, compression, gain (Spotify's library, wraps JUCE)
soundfile        — High-quality audio I/O (WAV, FLAC, OGG)
numpy            — Array math for mixing/overlaying signals
scipy.signal     — Biquad filters, Butterworth EQ (if not using pedalboard)
pydub            — Simple crossfades, format conversion, quick prototyping
```

### Library-by-Library Assessment

#### librosa
- **Purpose:** Audio analysis, BPM detection, beat tracking, onset detection
- **Time-stretch?** Yes via `librosa.effects.time_stretch()`, but quality is mediocre (phase vocoder). Use pyrubberband instead for production output.
- **EQ/filtering?** No built-in EQ. Can do spectral manipulation but that's not standard EQ.
- **Programmatic?** Fully — pure Python/numpy API
- **Quality:** Excellent for analysis, mediocre for time-stretching
- **Maintained?** Yes, actively. v0.11.0 current. Large community.
- **Role in our pipeline:** Analysis layer — detect BPM, beat positions, bar boundaries. Already used in Camelot.
- [Documentation](https://librosa.org/doc/main/)

#### pyrubberband
- **Purpose:** Python wrapper for the Rubber Band Library (professional-grade time-stretching)
- **Time-stretch?** Yes — this is its sole purpose, and it does it well. Uses Rubber Band's R2/R3 engines.
- **EQ/filtering?** No
- **Programmatic?** Fully — `pyrb.time_stretch(y, sr, rate)` takes numpy arrays
- **Quality:** Professional. Rubber Band is used in Ableton, Ardour, Audacity, Sonic Visualiser, and many commercial DAWs.
- **Maintained?** Wrapper is lightly maintained (v0.4.0). Rubber Band itself is very actively maintained (v4.0, Oct 2024).
- **Role in our pipeline:** Time-stretch each track to target BPM. E.g., stretch a 120.19 BPM track to 123 BPM by applying rate = 123/120.19.
- [GitHub](https://github.com/bmcfee/pyrubberband) | [Rubber Band](https://breakfastquay.com/rubberband/)

#### pedalboard (Spotify)
- **Purpose:** Full audio effects library — EQ, compression, reverb, gain, limiting, pitch shift, time stretch. Built on JUCE.
- **Time-stretch?** Yes — `pedalboard.time_stretch()` uses Rubber Band internally.
- **EQ/filtering?** Yes — `LowShelfFilter`, `HighShelfFilter`, `HighpassFilter`, `LowpassFilter`, `PeakFilter`. Full parametric EQ capability.
- **Programmatic?** Fully — Python API. Can also load any VST3/AU plugin.
- **Quality:** Professional. C++ core (JUCE), processes 300x faster than pySoX. Used internally at Spotify.
- **Maintained?** Yes, very actively. v0.9.22 current. Spotify-backed.
- **Role in our pipeline:** THE key library. Handles EQ transitions (cut mids/highs on outgoing track), gain staging, time-stretching, and could even load VST3 plugins for mastering. Could replace both pyrubberband and scipy.signal.
- **License:** GPLv3 (important for distribution, fine for personal use)
- [GitHub](https://github.com/spotify/pedalboard) | [Docs](https://spotify.github.io/pedalboard/)

#### pydub
- **Purpose:** Simple audio manipulation — concatenation, crossfades, overlays, format conversion, gain
- **Time-stretch?** No
- **EQ/filtering?** Basic high-pass/low-pass only (via effects module). Not parametric.
- **Programmatic?** Fully — very intuitive Python API
- **Quality:** Adequate for simple operations. Not designed for professional audio processing. Pure Python overlay is slow for large files.
- **Maintained?** Lightly. Still widely used but not fast-moving.
- **Role in our pipeline:** Utility layer — format conversion, simple concatenation, quick prototyping. Not suitable as the core mixing engine.
- **Limitations:** No time-stretch, basic EQ only, overlay() is slow for many operations, crossfade duration cannot exceed segment length.
- [GitHub](https://github.com/jiaaro/pydub)

#### soundfile
- **Purpose:** Audio file I/O — read/write WAV, FLAC, OGG, AIFF via libsndfile
- **Time-stretch?** No (I/O only)
- **EQ/filtering?** No (I/O only)
- **Programmatic?** Fully
- **Quality:** Lossless. 24-bit/32-bit float support.
- **Maintained?** Yes, stable.
- **Role in our pipeline:** Load source tracks, write final output. Pairs with numpy arrays.
- [PyPI](https://pypi.org/project/soundfile/)

#### scipy.signal
- **Purpose:** Digital signal processing — Butterworth filters, biquad filters, IIR/FIR filter design
- **Time-stretch?** No
- **EQ/filtering?** Yes — full filter design: `butter()`, `iirfilter()`, `sosfilt()`. Can implement any EQ curve.
- **Programmatic?** Fully — numpy-based
- **Quality:** Mathematically precise. No coloring or "warmth" — clinical.
- **Maintained?** Yes (part of SciPy, v1.17.0)
- **Role in our pipeline:** Alternative to pedalboard for EQ if you want pure-Python filters without GPLv3. Biquad cookbook implementations available.
- [Docs](https://docs.scipy.org/doc/scipy/reference/signal.html) | [Biquad Cookbook (Python)](https://gist.github.com/endolith/5455375)

### Proposed Python Pipeline Architecture

```
[DJ Set Markdown/JSON]
    |
    v
[Parser] — Extract per-track cue points, BPM targets, overlap bars, EQ notes, gain values
    |
    v
[For each track:]
    |-- soundfile.read() → numpy array
    |-- librosa.beat.beat_track() → beat/bar positions (or use pre-computed from Camelot)
    |-- pyrubberband.time_stretch() or pedalboard.time_stretch() → match target BPM
    |-- Trim to cue-in / cue-out bar positions
    |
    v
[Transition Engine:]
    |-- For each transition:
    |   |-- Get outgoing track's tail (N bars)
    |   |-- Get incoming track's head (N bars)
    |   |-- Apply EQ to outgoing (e.g., pedalboard.HighpassFilter to cut lows)
    |   |-- Apply EQ to incoming (e.g., fade in lows gradually)
    |   |-- Apply gain envelopes (linear or equal-power crossfade)
    |   |-- Sum the overlapping audio (numpy addition)
    |
    v
[Concatenation] — Join all sections: solo portions + crossfaded overlaps
    |
    v
[Output] — soundfile.write() → WAV/FLAC
```

### Estimated Development Effort

- **Parser for DJ Set 1 markdown:** 2-4 hours (extract the structured data into a JSON spec)
- **Core mixing engine:** 8-16 hours (time-stretch, cue, crossfade with EQ, gain staging)
- **Testing and tuning:** 4-8 hours (ear-testing transitions, adjusting EQ curves)
- **Total:** ~2-4 days of focused work

---

## Category 2: Dedicated DJ Automation Tools (Closest to Turnkey)

### pyCrossfade ★ MOST RELEVANT
- **What it does:** Beat matching at the bar level, gradual BPM shifting across bars, EQ modification during crossfades. Exactly what we need.
- **Time-stretch?** Yes — applies per-bar time-stretching to gradually shift BPM
- **EQ/filtering?** Yes — EQ modification during transitions
- **Programmatic?** Yes — Python API. Define transition length in bars.
- **Quality:** Uses madmom for beat tracking (high quality). Rubber Band for stretching.
- **Maintained?** Moderately — Docker releases up to v0.3.1. Not heavily maintained but functional.
- **Limitations:** Designed for 2-track transitions, not full 11-track set orchestration. You'd need to chain transitions. Beat tracking via madmom is slow (45-150s per track) but results are cached. No built-in "read a tracklist and execute" mode.
- **Verdict:** Best existing tool for the transition problem. Could be wrapped in an outer loop that processes our tracklist sequentially. Would need modification to accept our pre-computed bar/beat data from Camelot rather than re-analyzing.
- [GitHub](https://github.com/oguzhan-yilmaz/pyCrossfade)

### MixingBear + AudioOwl
- **What it does:** AudioOwl analyzes tracks (BPM, beats, notes). MixingBear performs automatic beat-aligned mixing of two tracks.
- **Time-stretch?** No — matches at beat boundaries but doesn't change tempo
- **EQ/filtering?** No
- **Programmatic?** Yes — `mixingbear.mix('track01.wav', 'track02.wav', 'output.wav')`
- **Quality:** Basic — finds "matching" beats within a tolerance window and overlays
- **Maintained?** Lightly. Last significant updates several years ago.
- **Limitations:** No time-stretch means it can't handle BPM mismatches. No EQ control. Very simple crossfade only.
- **Verdict:** Too simple for our use case. No BPM matching, no EQ.
- [AudioOwl GitHub](https://github.com/dodiku/AudioOwl) | [MixingBear GitHub](https://github.com/dodiku/MixingBear)

### Mix Machine
- **What it does:** Given a collection of MP3s, beatmatches or crossfades tracks into a single continuous mix
- **Time-stretch?** Via EchoNest (deprecated API)
- **EQ/filtering?** Unknown (likely basic)
- **Programmatic?** Yes — Python script
- **Maintained?** No — depends on deprecated EchoNest API
- **Verdict:** Dead. EchoNest was acquired by Spotify and the API shut down.
- [GitHub](https://github.com/cameronbracken/mix-machine)

### Automix (MZehren)
- **What it does:** Academic project for automatic DJ mixing — finds cue points, computes transitions
- **Time-stretch?** Based on Essentia library analysis
- **Programmatic?** Python API
- **Maintained?** Academic project, not actively maintained
- **Verdict:** Research code, not production-ready. Interesting for algorithms but not for executing a predefined mix.
- [GitHub](https://github.com/MZehren/Automix)

---

## Category 3: DAW Scripting

### DawDreamer ★ STRONGEST DAW OPTION
- **What it is:** A full DAW-in-Python. Built on JUCE. Supports VST2/3 plugins, parameter automation, Rubber Band time-stretching, Ableton-style warp markers, FAUST DSP, audio routing graphs.
- **Time-stretch?** Yes — Rubber Band integration with warp markers (Ableton-style)
- **EQ/filtering?** Yes — load any VST3 EQ plugin, or use built-in filter/compressor/reverb
- **Programmatic?** Fully Python. No GUI needed. Offline rendering.
- **Quality:** Professional — JUCE audio engine, VST3 plugin hosting, Rubber Band stretching
- **Maintained?** Yes, actively. v0.8.4. Cross-platform (macOS, Windows, Linux, Colab, Docker).
- **License:** GPLv3
- **Why it's compelling:** You could load each track as a PlaybackWarpProcessor, set time_ratio to match target BPM, add VST3 EQ plugins with automated parameters, route everything through a mixer, and render offline. It's essentially "Ableton without the GUI."
- **Limitations:** Learning curve. Documentation is functional but not extensive. Need to understand the audio graph model.
- **Verdict:** The most powerful single tool for this job. Can do everything: load tracks, time-stretch with Rubber Band quality, host VST3 EQ plugins with automation, mix, and render. The entire DJ set could be scripted as a single Python program.
- [GitHub](https://github.com/DBraun/DawDreamer) | [Docs](https://dirt.design/DawDreamer/)

### Reaper + ReaScript
- **What it is:** Professional DAW with embedded scripting (Lua, Python, EEL2). Full API access to tracks, items, envelopes, FX parameters, rendering.
- **Time-stretch?** Yes — Reaper has built-in stretching (elastique or Rubber Band via ReaSamplomatic)
- **EQ/filtering?** Yes — via ReaEQ or any VST/AU plugin, with full automation
- **Programmatic?** Partially — ReaScript can automate everything within Reaper, but Reaper must be running. Scripts can create tracks, place items, set automation envelopes, configure FX, and trigger renders.
- **Quality:** Professional DAW quality
- **Maintained?** Yes — Reaper is very actively developed. ReaScript API is mature.
- **Approach:** Write a Lua/Python script that:
  1. Creates a track per DJ track
  2. Imports audio items with correct start positions
  3. Sets stretch markers for BPM matching
  4. Adds ReaEQ with automation envelopes for crossfade EQ
  5. Sets volume envelopes for crossfades
  6. Renders to WAV
- **Limitations:** Requires Reaper to be installed and running. Not headless. Script development requires understanding Reaper's internal model.
- **Verdict:** Excellent if you already use Reaper. The most scriptable traditional DAW. But DawDreamer gives you similar power without needing a running DAW.
- [ReaScript Docs](https://www.reaper.fm/sdk/reascript/reascript.php) | [API Reference](https://www.extremraym.com/cloud/reascript-doc/)

### Ableton Live + Python
- **What it is:** Professional DAW with Python MIDI Remote Scripts and OSC control via AbletonOSC
- **Time-stretch?** Yes — Ableton's warping engine (the industry standard for electronic music)
- **EQ/filtering?** Yes — full plugin hosting with automation
- **Programmatic?** Partially — via AbletonOSC (live control over OSC) or PyLive. But requires Live to be running. ALS files are gzip-compressed XML and could theoretically be generated programmatically.
- **Quality:** The gold standard for electronic music production
- **Maintained?** Yes — Live 12 current
- **Approach:** Either control a running instance via OSC, or generate .als project files programmatically (reverse-engineer the XML schema)
- **Limitations:** Requires Ableton Live license ($$$). Not headless. ALS file generation is undocumented. OSC approach requires Live running.
- **Interesting:** DJ.Studio can export to Ableton Live projects with full automation — if DJ.Studio supported our structured input, this would be the ideal chain.
- **Verdict:** Overkill for automated mixing. Better suited as a finishing/mastering step after the mix is assembled.
- [PyLive](https://github.com/ideoforms/pylive) | [AbletonOSC](https://github.com/ideoforms/AbletonOSC)

---

## Category 4: CLI Tools

### Rubber Band CLI
- **Purpose:** Standalone time-stretching and pitch-shifting
- **Time-stretch?** Yes — this is the gold standard. R2 (Faster) and R3 (Finer) engines. Formant preservation.
- **EQ/filtering?** No
- **Programmatic?** CLI: `rubberband -t <timeratio> -p <semitones> in.wav out.wav`
- **Quality:** Professional. R3 engine is best-in-class for complex mixes, vocals, bass content.
- **Maintained?** Yes — v4.0 (Oct 2024). Actively developed.
- **Role:** Pre-process each track to target BPM before mixing, or use via pyrubberband/pedalboard/DawDreamer
- **Install:** `apt-get install rubberband-cli` (Linux) or build from source
- [Website](https://breakfastquay.com/rubberband/) | [GitHub](https://github.com/breakfastquay/rubberband)

### FFmpeg
- **Purpose:** Swiss army knife for audio/video processing
- **Time-stretch?** Yes — `atempo` filter (preserves pitch). Quality is adequate, not great.
- **EQ/filtering?** Yes — `equalizer`, `highpass`, `lowpass`, `bandpass`, `treble`, `bass` audio filters. Full parametric EQ.
- **Crossfade?** Yes — `acrossfade` filter. Can specify duration in samples or seconds. Supports different fade curves.
- **Programmatic?** CLI only, but highly scriptable. Complex filter graphs via `-filter_complex`.
- **Quality:** Adequate for utility work. Time-stretching quality is below Rubber Band. EQ is functional.
- **Maintained?** Yes — very actively.
- **Limitations:** Complex filter graphs become unwieldy. No beat-awareness — all timing is in seconds, not bars. Chaining many operations requires careful filter graph design or multiple passes.
- **Role:** Utility — format conversion, simple crossfades, concatenation. Not the core mixing engine.
- [Filters Docs](https://ffmpeg.org/ffmpeg-filters.html)

### SoX (Sound eXchange)
- **Purpose:** CLI audio processing — effects, format conversion, concatenation
- **Time-stretch?** Yes — `tempo` effect (iso-pitch stretching). Quality is acceptable for speech, less so for music.
- **EQ/filtering?** Yes — `equalizer`, `treble`, `bass`, `highpass`, `lowpass`, `bandpass` effects
- **Programmatic?** CLI only
- **Quality:** Below Rubber Band for time-stretching. EQ is functional.
- **Maintained?** Stable but slow development. Still widely available.
- **Role:** Legacy utility. Rubber Band CLI is superior for time-stretching. pedalboard or FFmpeg better for EQ.
- [SoX](https://sourceforge.net/projects/sox/)

---

## Category 5: Open Source DJ Software with Scripting

### Mixxx
- **What it is:** Free, open-source DJ software with JavaScript controller scripting
- **Time-stretch?** Yes — real-time playback engine
- **EQ/filtering?** Yes — 3-band EQ per deck, full effects chain
- **Programmatic?** Partially — JavaScript scripting for controller mappings and Auto DJ behavior. Not designed for offline batch processing.
- **Auto DJ scripts:** [AutoDJ by byronxu99](https://github.com/byronxu99/AutoDJ) uses cue points for entrance/exit. [midiAutoDJ](https://github.com/budul100/midiAutoDJ) adds phrase matching and intelligent fade decisions.
- **Quality:** Good for real-time DJ use
- **Maintained?** Yes — Mixxx 2.4+ with ES7 JavaScript engine
- **Limitations:** Designed for real-time performance, not offline rendering. Scripting API is controller-centric, not "here's a tracklist, render a mix." Would need to run Mixxx, configure Auto DJ, play through in real-time, and record the output.
- **Verdict:** Not suitable for automated offline rendering. Great DJ software, wrong tool for this job.
- [Mixxx](https://mixxx.org/) | [MIDI Scripting Wiki](https://github.com/mixxxdj/mixxx/wiki/midi-scripting)

### DJ.Studio
- **What it is:** Timeline-based DJ mix editor with AI-powered automixing
- **Time-stretch?** Yes
- **EQ/filtering?** Yes — automation editor with effect blocks
- **Programmatic?** No — GUI only. No public API, CLI, or scripting interface. Can export to Ableton Live projects.
- **Quality:** Good — designed specifically for DJ mix creation
- **Maintained?** Yes — actively developed, v2.0+
- **Interesting feature:** AI automixing that "tries millions of combinations." But no way to feed it our structural data.
- **Verdict:** Closest commercial tool to what we want conceptually, but no programmatic access. If it had an API that accepted a tracklist with transition parameters, it would be the answer.
- [DJ.Studio](https://dj.studio/) | [Help Center](https://help.dj.studio/)

---

## Recommendation Matrix

| Approach | Time-Stretch | EQ Crossfade | Programmatic | Quality | Effort | Best For |
|----------|-------------|-------------|-------------|---------|--------|----------|
| **DawDreamer** | Yes (Rubber Band) | Yes (VST3 + built-in) | Fully (Python) | Professional | Medium | Full pipeline in one tool |
| **Python Stack** (librosa + pyrubberband + pedalboard) | Yes (Rubber Band) | Yes (pedalboard) | Fully (Python) | Professional | Medium-High | Maximum flexibility |
| **pyCrossfade** (modified) | Yes (per-bar) | Yes | Mostly (needs wrapping) | Good | Low-Medium | Quick prototype |
| **Reaper + ReaScript** | Yes (built-in) | Yes (ReaEQ) | Mostly (needs Reaper) | Professional | Medium | If you use Reaper already |
| **FFmpeg chain** | Adequate | Yes (filters) | CLI scripting | Adequate | Medium | Quick and dirty |
| **Mixxx Auto DJ** | Yes | Yes | Partially | Good | Low | Real-time only |

---

## Top Recommendations for DJ Set 1

### Recommendation 1: DawDreamer (Best Single Tool)

DawDreamer can do everything we need in a single Python script:
- Load tracks via PlaybackWarpProcessor with Rubber Band time-stretching
- Set warp markers / time ratios to match target BPMs
- Host VST3 EQ plugins (or use built-in filters) with parameter automation for crossfade EQ
- Route all tracks through a mixer with gain automation
- Render offline to WAV

This is essentially "script an Ableton session in Python." The Camelot analysis data maps directly to DawDreamer's API.

### Recommendation 2: Custom Python Stack (Most Flexible)

If DawDreamer proves too opaque or its audio graph model doesn't fit:
```python
import soundfile as sf
import pyrubberband as pyrb
from pedalboard import Pedalboard, HighpassFilter, LowpassFilter, LowShelfFilter, Gain
import numpy as np
import librosa
```

This gives you explicit control over every sample. Pedalboard handles EQ and effects with professional quality. pyrubberband handles time-stretching. numpy handles the mixing math. More code but fewer abstractions.

### Recommendation 3: pyCrossfade as Starting Point (Fastest to Prototype)

Fork pyCrossfade and modify it to:
1. Accept pre-computed beat data from Camelot (skip the slow madmom analysis)
2. Chain 11 transitions sequentially
3. Add per-transition EQ parameters from our markdown spec

This gets a working prototype fastest, but may hit limitations for complex transitions (clean cuts, percussive bridges, the "HARD" transition 9->10).

---

## Integration with Existing Projects

### Data Flow: Camelot -> Mix Engine -> Mastering

```
[Camelot From YouTube]
    |-- analysis_cache.json (BPM, beats, bars, keys, events per track)
    |
    v
[DJ Set 1 README.md]
    |-- Human-curated mix instructions (cue points, overlaps, EQ notes)
    |
    v
[Mix Engine] (DawDreamer or Python Stack — THIS RESEARCH)
    |-- Parse instructions
    |-- Time-stretch tracks to target BPMs
    |-- Apply cue points (bar X to bar Y)
    |-- Execute crossfades with EQ
    |-- Gain staging
    |-- Render continuous mix
    |
    v
[dj-set-1-mix.wav]
    |
    v
[Set Mastering Pipeline]
    |-- Structure-aware mastering (Dolby.io API, Ozone, or custom)
    |-- Output: dj-set-1-mastered.wav
```

The mix engine is the missing middle piece between Camelot's analysis and the mastering pipeline.

---

## Next Steps

- [ ] Install and test DawDreamer — load a single track, time-stretch it, apply EQ, render
- [ ] Install and test pedalboard — apply EQ filters to a track, verify quality
- [ ] Fork pyCrossfade — test a single 2-track transition with pre-computed beat data
- [ ] Define a JSON schema for mix instructions (parseable from the DJ Set 1 README)
- [ ] Prototype: mix tracks 1-2 (Deep Style -> Foss) with time-stretch 120->123 and crossfade
- [ ] Evaluate output quality of each approach
- [ ] Choose approach and build full pipeline for all 11 tracks

---

## Tags
- [music](../tags/music.md)
- [python](../tags/python.md)
- [audio-processing](../tags/audio-processing.md)

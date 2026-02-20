# Set Mastering Pipeline
> Structure-aware mastering for DJ mixes, using Camelot analysis data to drive per-section processing.

**Status:** planning
**Created:** 2026-02-20
**Links:** [DJ Set 1](../dj-set-1/README.md), [Camelot From YouTube](../camelot-from-youtube/README.md)

---

## Concept

Standard mastering tools treat a mix as a flat audio file — one set of EQ, compression, and limiting applied uniformly. But a DJ set has structure: breakdowns, builds, drops, transitions, key changes, and energy curves. Camelot already detects all of this. The idea is to feed that structural data into the mastering process so different sections get different treatment.

### What Structure-Aware Mastering Would Do

| Section Type | Processing |
|-------------|-----------|
| **Breakdown** | Lighter compression, wider stereo, more reverb tail, lower LUFS target |
| **Build** | Gradual limiter tightening, rising high-shelf, increasing loudness |
| **Drop** | Harder limiting, tighter low-end, mono bass below ~120Hz, peak LUFS |
| **Transition** | Careful gain staging where two tracks overlap, crossfade-aware EQ |
| **Key change** | Ensure no mastering artifacts emphasize dissonance at the boundary |

---

## Tool Landscape

### Cloud AI Mastering Services

| Tool | API? | Input | Per-Section Control? | Pricing | Notes |
|------|------|-------|---------------------|---------|-------|
| **LANDR** | Yes (REST) | Audio + 3 intensity presets + style | No | ~$2.50/track | Only cloud tool with a real API. Could split mix at transitions and submit segments with different intensity settings. |
| **eMastered** | No | Audio + reference track + sliders | No | $15/mo or $48 upfront | Browser upload only. Grammy-winner-tuned AI. No programmatic access. |
| **Waves Online Mastering** | No | Audio | No | ~$2-3/track bulk | Upload and download. No API. |
| **BandLab** | No | Audio | No | Free | Basic quality. Good for quick previews. |

### Local / Plugin Tools

| Tool | API? | Input | Per-Section Control? | Pricing | Notes |
|------|------|-------|---------------------|---------|-------|
| **iZotope Ozone 12** | No (DAW plugin) | Audio + genre/LUFS targets + module selection | Yes (manual automation) | ~$250 (Advanced) | Most control. Master Assistant suggests settings; Custom mode lets you pick genre targets, modules, LUFS. Automation in DAW gives per-section control — but it's manual. |
| **matchering** | Python lib | Audio + reference track | No | Free (open source) | Spectral profile matching. Could split-and-match per section against different references. |
| **AI Mastering (aimastering.com)** | Yes (REST) | Audio | No | Varies | Has an API, but shifting focus to offline/open-source version. |

### Programmatic Building Blocks (Python)

| Library | Purpose |
|---------|---------|
| **matchering** | Match spectral profile to a reference track |
| **pyloudnorm** | LUFS measurement and loudness normalization (EBU R128) |
| **scipy.signal** | Filters, EQ, dynamics processing |
| **librosa** | Audio loading, spectral analysis (already in Camelot stack) |
| **pydub** | Simple audio manipulation, splitting, concatenation |
| **soundfile** | High-quality audio I/O |

---

## Approaches (Ordered by Effort)

### 1. Cloud Service Baseline (Today)

Upload the mixed-down set to LANDR, eMastered, or BandLab. Get a baseline master. Compare against the raw mix. This requires no code — just a reference point.

**Limitation:** Treats the whole mix uniformly. Breakdowns get slammed the same as drops.

### 2. LANDR API + Segment Splitting

Use the LANDR API programmatically:

```
analysis_cache.json → parse structural events →
  split audio at transition boundaries →
  for each segment: select LANDR intensity based on event type →
  submit via API → download masters →
  crossfade segments back together
```

**Pros:** Leverages a professional mastering engine. Programmable.
**Cons:** ~$2.50/segment adds up. Crossfade artifacts at rejoin points. LANDR's 3 intensity levels are coarse.

### 3. Ozone + DAW Automation (Manual but High Quality)

Load the mix in a DAW (Ableton, Logic, Reaper). Use Ozone on the master bus. Manually set automation breakpoints at each structural event from the README/analysis_cache. Automate Ozone's modules per section.

**Translator concept:** Script that reads `analysis_cache.json` and outputs DAW-native markers/automation:
- **Ableton**: Generate `.als` automation or MIDI CC
- **Reaper**: Generate ReaScript setting Ozone parameters at each event time
- **Any DAW**: At minimum, generate a marker list with suggested settings per section

**Pros:** Maximum quality. Full control over every parameter.
**Cons:** Manual setup per mix. DAW-dependent.

### 4. Custom Python Pipeline (Build It)

Build a mastering pipeline that reads `analysis_cache.json` directly:

```python
# Pseudocode
events = load_analysis_cache("dj-set-1/analysis_cache.json")
audio = load_audio("dj-set-1-mix.wav")

for section in events.sections:
    segment = audio[section.start:section.end]
    if section.type == "drop":
        segment = apply_hard_limit(segment, target_lufs=-8)
        segment = mono_bass(segment, cutoff=120)
    elif section.type == "breakdown":
        segment = apply_gentle_compression(segment, target_lufs=-12)
        segment = widen_stereo(segment)
    elif section.type == "build":
        segment = apply_rising_limit(segment, start_lufs=-12, end_lufs=-8)
    # ... crossfade between processed segments

export("dj-set-1-mastered.wav", processed_audio)
```

**Pros:** Fully automated. Structure-aware. Reads the same data Camelot produces. Reproducible.
**Cons:** Significant development effort. Processing quality depends on our DSP implementation vs. commercial engines.

### 5. Hybrid: Custom Pipeline + Commercial Engine

Best of both worlds: use the custom pipeline for section-aware decisions (where to process differently, what targets to aim for) but delegate the actual audio processing to a commercial engine via API (LANDR) or plugin hosting.

---

## The MD-to-Tool Translation Layer

The core insight: Camelot already produces the structural analysis. The missing piece is a translator that converts `analysis_cache.json` (or the DJ Set README) into tool-native instructions.

### What the Translator Reads

From `analysis_cache.json` / DJ Set README:
- **Events**: time, bar, type (drop/breakdown/build/fill/transition), energy direction
- **Key timeline**: which Camelot key is active at each bar
- **BPM/beat grid**: exact timing of bars and beats
- **Track boundaries**: where each track starts/ends in the mix
- **Overlap zones**: where two tracks are playing simultaneously

### What the Translator Outputs

Depends on target tool:
- **LANDR API**: Split points + intensity per segment
- **DAW markers**: Timestamp + label + suggested parameters
- **Ozone automation**: Parameter curves per module per section
- **Custom pipeline**: Processing rules per section type

---

## Next Steps

- [ ] Run DJ Set 1 through a cloud mastering service for baseline
- [ ] Investigate LANDR API access (sign up, get API key, test with one track)
- [ ] Test matchering + pyloudnorm on a single track segment
- [ ] Prototype the analysis-to-markers translator (JSON → DAW markers)
- [ ] Evaluate: cloud baseline vs. Ozone manual vs. custom pipeline

## Tags
[music](../../tags/music.md), [python](../../tags/python.md), [ai](../../tags/ai.md), [audio-processing](../../tags/audio-processing.md)

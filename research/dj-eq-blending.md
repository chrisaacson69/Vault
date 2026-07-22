---
status: active
created: 2026-02-22
published: true
layout: layouts/page.njk
title: "DJ EQ Blending Technique"
---
# DJ EQ Blending Technique
> How pro DJs use EQ — not the crossfader — as the primary transition tool.

**Links:** [CyborgDJ](../projects/cyborgdj/README.md), [DJ Set 1](../projects/dj-set-1/README.md), [Programmatic DJ Mixing Tools](./programmatic-dj-mixing-tools.md), [Crossover Calibration](./dj-crossover-calibration.md)

## Context

Pro DJ feedback on the CyborgDJ 1b mix: transitions sounded like a "mixtape" — songs glued together rather than a cohesive blend. The critique: transitions were too "event-like." Real DJs don't use the crossfader as the transition — the transition IS the EQ. The fader is cleanup.

This research collects technique breakdowns from tutorial videos and synthesizes them into patterns that map to CyborgDJ's automation system.

## Source Videos

| # | Video | Channel | Focus |
|---|-------|---------|-------|
| 1 | [The Transition ALL HOUSE DJs Need To Know](https://www.youtube.com/watch?v=FqO2ShLGIWo) | Crossfader | Loop + layer technique; frequency spectrum filling |
| 2 | [Bass Swapping - Don't Make This Common Mistake](https://youtu.be/xVNk9z7j-hg) | Club Ready DJ School | Hard vs soft bass swaps; when each works |
| 3 | [How to Mix Tech House (5 Levels)](https://www.youtube.com/watch?v=h0VQEEj--_U) | Club Ready DJ School | Progressive skill levels; EQ + phrasing as foundation |
| 4 | [3 Ways To Mix Techno](https://www.youtube.com/watch?v=22XjZKJS69E) | Crossfader | Slow EQ blend, drop swap, layering — most mechanically detailed |

Transcripts saved at `C:\Users\Chris.Isaacson\` as `*_transcript.txt`.

## Core Principle

**EQ blending is managing frequency real estate, not volume.** Two basslines should never coexist in the same frequency space. The fader is the cleanup crew; the EQ knobs are the actual transition.

## Technique 1: Slow EQ Blend (from Video 4)

The most mechanically detailed technique. Order of operations for a long blend (~64 bars / ~2 minutes at 128 BPM):

1. **Kill all 3 EQ bands on incoming** (isolator mode = silence)
2. Both tracks running, phrase-aligned
3. **Bring incoming MID in first** — harmonic content, lets listener acclimate
4. **Bring incoming HIGH in** — texture, shimmer
5. **Simultaneously cut outgoing LOWS** — making frequency room for the bass swap
6. **Cut outgoing HIGHS** — handing over the top end
7. **Boost outgoing MID slightly** — preserve one specific element (stab, vocal) while everything else fades
8. **Slowly kill outgoing MID** — final goodbye
9. **Fader moves last**, if at all — just cleanup

Key: this is **six independent EQ moves happening at different times, in different directions, at different rates.** Not a crossfade.

### Mapped to Automation Lanes

```json
{
  "overlap_bars": 64,
  "automation": {
    "outgoing_fader":  [[0, 1.0], [56, 1.0], [64, 0.0]],
    "incoming_fader":  [[0, 1.0]],
    "incoming_mid":    [[0, 0.0], [8, 0.8], [24, 1.0]],
    "incoming_high":   [[0, 0.0], [16, 0.0], [32, 1.0]],
    "incoming_low":    [[0, 0.0], [32, 0.0], [36, 1.0]],
    "outgoing_low":    [[0, 1.0], [24, 1.0], [28, 0.0]],
    "outgoing_high":   [[0, 1.0], [20, 1.0], [32, 0.0]],
    "outgoing_mid":    [[0, 1.0], [48, 1.0], [56, 0.0]]
  }
}
```

## Technique 2: Bass Swap (from Video 2)

The bass swap is the critical moment in any EQ transition. Two variants:

### Hard Swap
Instant switch at a phrase boundary. Works when:
- Both tracks have substantial bass
- Incoming is kicking in (drop, energy building)
- Outgoing is naturally dropping off (breakdown, outro)

```json
"outgoing_low": [[0, 1.0], [32, 1.0], [32.25, 0.0]],
"incoming_low": [[0, 0.0], [32, 0.0], [32.25, 1.0]]
```

### Soft Swap
Gradual, not to zero. Maintains warmth. Prevents the "empty" sound.

```json
"outgoing_low": [[0, 1.0], [24, 1.0], [40, 0.3]],
"incoming_low": [[0, 0.0], [24, 0.0], [40, 0.8]]
```

Key quote from the tutorial: *"I could hear it — I just took the bass out too aggressively and didn't really leave enough warmth in the exiting song."*

### Decision Framework
- **Hard swap** when: incoming drop is hitting, outgoing is sparse, high energy moment
- **Soft swap** when: both tracks have body, you want mashup warmth, or incoming is still building
- **Phrase alignment is critical** — swapping mid-phrase "cuts sections in half and sounds unnatural"

## Technique 3: Loop + Layer (from Video 1)

1. Loop a vocal section (lives in high frequencies)
2. Layer a track with a strong kick underneath (low frequencies)
3. Fader already at 1.0 — it never moves
4. Use filter as a reveal tool: incoming starts filtered, gradually open
5. Frequency spectrum is filled by different tracks occupying different bands

This maps directly to CyborgDJ's `loop_start`/`loop_end` feature combined with per-band automation.

## Technique 4: Drop Swap (from Video 4)

Both tracks at drops simultaneously. Bring incoming highs and mids in, keep incoming bass cut. At the phrase boundary, swap the bass. Creates high-energy mashup. Both tracks contribute energy — removing one loses dimension.

## Technique 5: Layering (from Video 4)

Multi-deck approach (2-4 decks). Each deck provides different frequency content:
- Deck 1: hi-hats / percussion
- Deck 2: synths / pads
- Deck 3: vocals / acapella
- Deck 4: kick + sub

Weave between them — add, remove, boost, reduce. Go from track A to track B and back again.

## Cross-Cutting Insights

1. **Mids arrive first, bass last** — consistent across tutorials. Harmonic content before rhythmic energy.
2. **Outgoing removal ≠ inverse of incoming introduction** — they happen at different times and rates.
3. **"Flexible" is the keyword** — not formulaic. Reading what both tracks are doing at each moment.
4. **The fader is the last thing** — or doesn't move at all. The transition is complete before the fader moves.
5. **"There is no point adding anything else to the mix if the EQing and phrasing isn't taken care of first"** — EQ + phrasing is the foundation (Video 3, Level 1).

## Architectural Implication for CyborgDJ

All techniques are special cases of **per-widget automation lanes with breakpoint interpolation**:

- Each EQ band (low, mid, high) per track = one automation lane
- Each fader per track = one automation lane
- Each lane is an array of `[bar, value]` breakpoints, linearly interpolated
- Existing fader automation (`automation.outgoing` / `automation.incoming`) is the same pattern

The current system has separate mechanisms for:
- Fader curves (`fade_type`, `fade_power`)
- EQ ramps (`eq_3band_outgoing` with start/end values)
- Fader automation (`automation` with breakpoints)
- Decoupled fader (`fade_offset_bars`, `fade_bars`)

These are all convenience shortcuts for common patterns of the general model. The general model subsumes them all.

## Roadmap: Batch → Real-Time Convergence

The `[[bar, value], ...]` breakpoint format is the interchange layer — the "MIDI file of DJ mixing." It doesn't care whether a human typed it, a recording captured it, or a real-time engine is consuming it.

| Step | What | Mode |
|------|------|------|
| **1 (now)** | Per-band automation lanes in the spec, batch-rendered with numpy | Batch |
| **2 (later)** | Widget classes with state, consuming same breakpoint format for playback or recording from real-time input | Real-time |
| **3 (eventually)** | Bidirectional — record on controllers → export spec → tweak JSON → re-render batch or play back through controllers | Both |

Step 1 doesn't preclude steps 2-3. The spec format is the stable contract between all three.

**Real-time → Batch:** DJ moves physical EQ knobs → MIDI listener records timestamped events → quantize to bar grid → output is automation lanes JSON. The recording IS the spec.

**Batch → Real-time:** Read spec → run transport clock → interpolate breakpoints at each tick → send values to virtual mixer (or MIDI out to motorized faders). The spec IS the playback score.

### Step 1 Design: Per-Band Automation Lanes

Extend the existing `automation` field. New lane names:

| Lane | What | Values |
|------|------|--------|
| `outgoing_fader` | Outgoing volume | 0.0–1.0 |
| `incoming_fader` | Incoming volume | 0.0–1.0 |
| `outgoing_low` | Outgoing bass EQ | 0.0 (kill) – 1.0 (unity) |
| `outgoing_mid` | Outgoing mid EQ | 0.0 – 1.0 |
| `outgoing_high` | Outgoing high EQ | 0.0 – 1.0 |
| `incoming_low` | Incoming bass EQ | 0.0 – 1.0 |
| `incoming_mid` | Incoming mid EQ | 0.0 – 1.0 |
| `incoming_high` | Incoming high EQ | 0.0 – 1.0 |

Backward compatibility:
- Old `automation.outgoing` / `automation.incoming` → treated as fader lanes
- Old `eq_3band_*`, `fade_type`, `fade_power`, `fade_offset_bars`, `fade_bars`, `outgoing_hold` all still work
- When `automation` has EQ lanes, old `eq_3band_*` fields are ignored (with warning)

Implementation: one new code path in `execute_transition()` that detects EQ lanes in `automation`, splits both overlap regions into 3 bands, applies per-band gain envelopes from breakpoints, sums the bands back together, then applies fader envelopes on top.

## Step 1 Implementation Results (2026-02-22)

Per-band automation lanes implemented in `cyborgdj/engine.py`. Tested on transition 7→8 (PQM → Quivver, 80-bar overlap, 1A→1A perfect harmonic match). Three iterations rendered and A/B compared against the existing fader-only automation.

### What Works

- The system renders correctly — independent per-band envelopes, crossover frequencies, fader lanes on top of EQ lanes.
- Tutorial ordering (mids first → highs → bass swap → outgoing mids linger → fader cleanup) produces a recognizable blend shape.
- Crossover frequency is the single biggest lever. Default 300 Hz is too low for prog/trance — bass harmonics and kick warmth (200–500 Hz) leak into the mid band and cause mud. **450 Hz** was a significant improvement for the PQM/Quivver pair.
- Backward compatibility preserved: specs with no EQ lanes hit the original code path unchanged.

### What Doesn't Work (Yet)

- **Blind breakpoint authoring is too slow.** Three iterations of listen → adjust values → re-render got closer but couldn't nail it. The specific gain values and timing depend entirely on what each track is doing at each moment — not something you can intuit from a JSON file.
- **The fader-only automation for 7→8 still sounds better.** Its "distraction anchor" pattern (Quivver dips to 0.05 during PQM's vocal callback, then rises) creates a clearer narrative. The EQ blend spread both tracks across frequency bands simultaneously, which sounded muddier even when technically "correct."
- **Crossover frequency is track-dependent.** 450 Hz worked for this pair, but a house track with a higher kick might need 500+ Hz. This needs per-transition tuning or spectral analysis.

### Specific Findings from Iteration

| Issue | Root cause | Fix applied |
|-------|-----------|-------------|
| Incoming mids stomp outgoing melody (bar ~11) | Incoming mids ramped too aggressively (0.3 by bar 8) | Gentler start: 0.15 by bar 16 |
| Bass bleed through mid band (bar ~29) | 300 Hz crossover — bass harmonics in mid band | Raised low_freq to 450 Hz |
| Incoming bass too early | Arrived before outgoing vocal callback finished | Delayed incoming_low entry |
| Outgoing highs interfering | Dropped too slowly | Steeper drop, done by bar 38 |
| Mud from outgoing "lows" | Actually bass harmonics in the mid band (300–450 Hz) | Higher crossover + earlier outgoing_mid drop |

### Key Insight: Authoring Method Matters More Than Rendering

The `[[bar, value]]` format is the right interchange layer, but hand-authoring breakpoints is the wrong input method. The rendering engine is not the bottleneck — the authoring workflow is. This confirms the roadmap: real-time recording (Step 2) or spectral analysis tools are needed before per-band EQ can be practically used for production mixes.

### Candidate Next Steps (status as of 2026-07-22)

1. ~~**Spectral analysis tool**~~ — **SHIPPED, and this page failed to record it.** See below.
2. **Real-time recording (Step 2)** — MIDI controller input recorded as timestamped events, quantized to bar grid, exported as automation lanes. The recording IS the spec. *Still open.*
3. **Template library** — parameterized versions of tutorial techniques (slow blend, hard swap, drop swap) that adapt to overlap length. Starting points, not finished products. *Still open — and this is the "recipe generator" layer in the 2026-07 architecture.*

## 2026-07-22 Revisit — what was already built, and what's actually missing

### The spectral tool shipped; the page didn't say so

Candidate Next Step #1 exists in two places and was never harvested back here:

- `camelot_from_youtube/spectral_analysis.py` — per-bar energy across 31 ISO-266 third-octave bands,
  producing an `(n_bars, 31)` dBFS matrix.
- `camelot_from_youtube/collision.py` — two-track spectral collision over a transition zone; identifies
  hotspots, **suggests EQ crossover frequencies**, emits JSON as EQ recommendations for CyborgDJ specs.
  Docstring notes it was ported from `CyborgDJ/scripts/spectral_collision.py` — so the tool is *forked
  across both repos*.

**This is textbook index rot**: the artifact existed, the page still advertised it as unbuilt, and a fresh
session nearly rebuilt it from scratch. The `(n_bars, 31)` matrix is also the right *representation* — a
per-bar symbolic score, discrete and time-anchored — as opposed to a raw FFT dump, which is why the earlier
"add an FFT engine" attempts didn't help: the problem was representation, not resolution.

### Cross-repo duplication (the "had to keep reminding it to use camelot" problem, physically)

| Capability | `camelot_from_youtube` | `CyborgDJ` |
|---|---|---|
| Spectral collision | `collision.py` | `scripts/spectral_collision.py` |
| Rekordbox export | `rekordbox_export.py` | `scripts/export_rekordbox.py` |
| Analysis output | `<track>/analysis_cache.json` | `camelot/<track>/key_analysis.json` — **copied, partial, stale** |

CyborgDJ doesn't *depend* on camelot; it holds a partial copy of camelot's output. A dependency you have to
remember is a habit, not a dependency. Repo root also carries `analyze_btb_bars{,_v2}.py` and
`analyze_btb_vocal{,_v2,_v3,_v4}.py`, and `specs/` runs to 28 files with `v1`…`v7` and `-savepoint` —
the human-in-the-loop guessing cycle, legible in filenames.

### Rekordbox vs librosa — an empirical split (Chris, 2026-07)

Comparing the two on the same catalog: **Rekordbox detects beats far better; librosa finds key far better.**
Not luck — structural:

- **Beats:** Rekordbox assumes a rigid constant-tempo grid and fits phase to it — a correct strong prior for
  machine-sequenced dance music. `librosa.beat.beat_track` is deliberately genre-general (onset envelope +
  DP) and is built to *follow* tempo variation; on a track locked to 128.00 BPM that flexibility is pure
  downside. It also has **no downbeat concept at all**.
- **Key:** Rekordbox reports one global key from a mediocre proprietary detector. The vault's own stack is
  CQT chroma + Krumhansl with **consensus voting and bar-aligned timeline windows** — a better *method* for
  tracks that change key. It beat a commercial tool because of the architecture around the primitive.

**Two consequences.** (1) Stop recomputing the grid — read Rekordbox's back via `pyrekordbox` (MIT, active),
which already ships as a dependency but is currently used write-only. (2) Rekordbox's grids are a **free,
genre-matched labelled benchmark** for scoring neural beat trackers on *this* catalog rather than on
Ballroom/GTZAN.

### The actual gap

| Layer | Status |
|---|---|
| Per-bar spectral score | ✅ `spectral_analysis.py` |
| Stems (incl. 6-stem guitar/piano) | ✅ `separate_stems.py`; superseded by `audio-separator` |
| Conflict detection + crossover suggestion | ✅ `collision.py` |
| LUFS | ✅ `pyloudnorm` already wired into the UI |
| Beat grid | ⚠️ librosa-based, no downbeat model |
| **Critic on the rendered output** | ❌ |
| **Closed loop / parameter search** | ❌ |
| **A/B judgement log** | ❌ |

`collision.py` predicts conflict from the **two source tracks before the mix** — the same analysis that
proposes the crossover also vouches for it. That is self-consistency, not verification. Running the same
third-octave measurement **on the rendered output** and comparing predicted-vs-actual is an independent
oracle, and it reuses code that already exists.

The 2026-02-22 conclusion — *"authoring method matters more than rendering"* — was right, and it points at
a specific fix: the LLM should never author gain values. Picking a number that sounds right at bar 8 requires
maintaining state, simulating, and verifying — none of which a language model does (see
[Planner-LM Composites](./planner-lm-composites.md)). The LLM picks the **recipe and constraints**; a solver
picks the **values**, scored by the critic. That converts "listen → adjust → re-render" from a human loop
into a search, and the iteration table above is already a hand-derived objective function waiting to be
converted into metrics.

**Next-actionable:** start the **A/B judgement log** on the very next listening comparison — spec A, spec B,
which won, one line of why. Every comparison made in February was discarded; those pairs are the training
set for a learned mix-quality evaluator, and there is
[no published metric to reuse](./programmatic-dj-mixing-tools.md#2026-07-22-revision--what-superseded-what).

## Tags
[music](../tags/music.md), [audio-processing](../tags/audio-processing.md), [cyborg](../tags/cyborg.md)

# Set Mastering Pipeline — "Cyborg DJ"
> Human writes the score, machine executes the mix, light mastering pass finishes it.

**Status:** active
**Created:** 2026-02-20
**Repo:** [CyborgDJ](https://github.com/chrisaacson69/CyborgDJ) — the mix engine (Python stack: pyrubberband + pedalboard + numpy)
**Links:** [DJ Set 1](../dj-set-1/README.md), [Camelot From YouTube](../camelot-from-youtube/README.md), [Programmatic DJ Mixing Tools](../../research/programmatic-dj-mixing-tools.md), [The Cyborg Model](../../research/cyborg-model.md)

---

## The Cyborg DJ Concept

This project is the [Cyborg Model](../../research/cyborg-model.md) applied to DJ mixing. The human provides creative judgment — track selection, set order, transition philosophy, energy arcs, EQ decisions. The machine provides tireless execution — time-stretching, beat-matching, crossfading, gain staging, rendering. Neither side is complete alone.

### The Paradigm Shift

The original framing of this project was: "How do we master a DJ set?" That was the wrong question. The [DJ Set 1 README](../dj-set-1/README.md) already contains everything needed to **build** the mix — track order, exact bar numbers, BPM targets, overlap lengths, EQ notes, transition strategies. It's not a cheat sheet for a human DJ. It's a **program** that a machine can execute.

The real question is: **"What tool reads a markdown document and produces a mixed DJ set?"**

Mastering is now just the final light polish on an already-well-built mix — a much simpler problem.

### The Full Pipeline

```
[Camelot From YouTube] — AI analyzes each track (BPM, key, structure, events)
        |
        v
[DJ Set 1 README.md] — Human curates the set (order, transitions, EQ, energy)
        |
        v
[Mix Engine] — Machine executes the mix from MD instructions
        |    (time-stretch, cue, crossfade with EQ, gain staging)
        |    See: research/programmatic-dj-mixing-tools.md
        v
[dj-set-1-mix.wav] — Continuous mix, built to spec
        |
        v
[Light Mastering Pass] — Final polish (limiter, LUFS normalization)
        |    Much simpler because the hard decisions are already in the MD
        v
[dj-set-1-mastered.wav] — Done
```

### Division of Labor

| Function | Human | Machine | Why |
|----------|-------|---------|-----|
| **Track selection** | Choose the 11 tracks | — | Taste, intent, vibe |
| **Set order** | Sequence by energy/key/BPM arc | Camelot provides harmonic data | Human judges the flow |
| **Transition design** | Decide overlap length, type, EQ strategy | — | Creative judgment |
| **BPM matching** | Specify target BPMs | Time-stretch via Rubber Band | Mechanical execution |
| **Beat-matching** | Specify cue points (bar numbers) | Align at beat grid | Mechanical execution |
| **EQ during crossfade** | Write EQ notes ("cut mids/highs") | Apply filters via pedalboard/VST3 | Mechanical execution |
| **Gain staging** | Set relative levels | Apply gain automation | Mechanical execution |
| **Rendering** | — | Produce continuous WAV | Mechanical execution |
| **Quality check** | Listen and approve | — | Taste, the final ear |
| **Mastering** | — | Light limiter + LUFS target | Mechanical execution |

---

## Why LANDR / Cloud Mastering Isn't the Right Tool

The initial research explored cloud mastering services (LANDR, Dolby.io, etc.) as the primary tool. This was a category error:

- **Mastering tools** process a finished audio file — they polish, they don't build
- **We need a mixing engine** that builds the audio from instructions first
- LANDR processing a 90-minute set as "one song" would fight the mix's natural dynamics
- The MD front-loads the hard decisions (levels, EQ, transitions), making mastering trivial

Cloud mastering may still be useful for the final polish step, but it's step 2 — and a much lighter step than originally conceived. Even just a limiter + LUFS target in the Python pipeline might suffice.

---

## Concept: Structure-Aware Mastering (Step 2)

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

## Tool Landscape (Researched 2026-02-20)

### The Key Question

Can any existing mastering tool accept a markdown document describing a DJ mix's structure (key changes, drops, breakdowns, energy curves, transitions) and use that to guide mastering decisions?

**Short answer: No. Nothing on the market accepts structural text/metadata as mastering input.** The closest is SoundBoost.ai, which accepts natural-language text prompts like "warm and punchy" — but not structural timecodes or section maps. Every tool either analyzes the audio itself or accepts a reference track for tonal matching. The "analysis_cache.json to mastering instructions" translation layer described below remains a custom build.

---

### Cloud AI Mastering Services

| Tool | API? | Text/Prompt Input? | Per-Section? | Pricing | Notes |
|------|------|---------------------|-------------|---------|-------|
| **LANDR** | Yes (REST, also on RapidAPI) | No. Audio-only. AI deduces genre from audio. User picks Warm/Balanced/Open style + Low/Med/High intensity + optional reference track. | No | ~$2.50/track (volume discounts) | Only mainstream cloud tool with a documented API. Could split mix at transitions and submit segments with different intensity settings. Trusted by 5M+ musicians. |
| **Dolby.io** | Yes (REST, well-documented) | No text prompts. Accepts genre profile (Electronic/Hip-Hop/Rock/Acoustic/Pop/Orchestral), target LUFS (-9/-11/-14), intensity (0-100%), stereo image enable/disable. | Partially — their engine "continuously adjusts processing over the duration of the track depending on characteristics of the music" but you cannot specify section boundaries. | $0.05/min, 200 free min/mo | Industry-grade. Used by SoundCloud and UnitedMasters. Good analysis API too. Preserves metadata. **10-minute max file length** — a 60-min DJ set would need splitting anyway. Nov 2025 update added stereo imaging analysis + enhancement. |
| **RoEx (Tonn API)** | Yes (REST + Python SDK) | No text prompts. Accepts musical_style (e.g. ROCK_INDIE), desired_loudness (LOW/MEDIUM/HIGH), sample_rate. | No explicit per-section control. The engine analyzes spectral content, transients, dynamics, stereo distribution internally. | ~$1.76-2.20/track | Research-backed (Queen Mary University of London). 2M+ tracks processed since 2023. Python package `roex-python` (last updated Oct 2025). Also has analysis and mixing endpoints. |
| **Masterchannel** | Yes (REST API, ~$1.50/master) | No. Fully autonomous AI — no profiles, parameters, or presets needed. Genre-aware but inferred from audio. Optional reference track matching. | No | $15-20/mo consumer, $1.50/master API | Co-founded by Matoma. Used by Eurovision contestants and Grammy winners. Output up to 192kHz/64bit. Previews free via API. |
| **eMastered** | No | No. Audio + reference track + sliders (stereo width, loudness). | No | $15/mo or $48 upfront | Browser upload only. Grammy-winner-tuned AI. No programmatic access. 30M+ tracks mastered. |
| **Waves Online Mastering** | No | No. Audio + style (Precise/Organic/Elevated) + tone (Depth/Presence). Optional reference track. | No | $2.99-5.99/track (credit system) | Mid-2025 update: enhanced clarity, tighter low-end, EDM optimization (collab with Dave Aude). Works on iOS/Android. No API. |
| **BandLab** | No | No. Audio + preset selection (Universal/Fire/Clarity/Tape + 4 premium). | No | Free (premium $14.95/mo) | Has interesting AI tools (SongStarter, Voice Cleaner, Stem Separator) but mastering is preset-only. Album mastering mode for consistency across tracks. |
| **CloudBounce** | Shut down 2025 | N/A | N/A | N/A | Technology absorbed into FL Studio's AI Mastering and FL Cloud. |
| **Remasterify** | No | No. Upload-and-process workflow. Personalized approach that "learns from what you upload." | No | Not published | Good for album consistency. Supports 96kHz exports. No API, no text prompts. |

### Text-Prompt-Based Mastering (The Closest Thing)

| Tool | API? | Text/Prompt Input? | Per-Section? | Pricing | Notes |
|------|------|---------------------|-------------|---------|-------|
| **SoundBoost.ai** (formerly Diktatorial Suite) | **No public API** | **YES — natural language text prompts.** "Airy highs, warm midrange" parsed by LLM. Mastering Engine v3.5 (2025) has "richer prompt handling." 6 AI mastering engineer personas (Sophia=smooth, Alex=punchy, Marcus=loud, Luna=clear, Kai=vintage). Prompt-to-mastering with session memory. | **No per-section control.** Whole-track processing. Iterative revision via follow-up prompts ("add reverb," "brighten the air") but applied globally. | From $8/mo | **Most relevant tool for text-guided mastering.** Combines LLM with audio processing. Guided Mode allows revision without reuploading. Real-time Final EQ. BUT: accepts vibes/adjectives, not structural data (timecodes, section types, energy curves). Cannot say "at 3:45 switch from gentle to hard limiting." |

### Local / Plugin Tools

| Tool | API? | Text/Prompt Input? | Per-Section? | Pricing | Notes |
|------|------|---------------------|-------------|---------|-------|
| **iZotope Ozone 12** | No (DAW plugin only: VST3/AU/AAX) | No. Master Assistant 2.0 analyzes audio, suggests settings. Modern/Vintage modes. Reference track matching. | **Yes (manual automation in DAW).** This is the only tool that truly supports per-section processing — but via manual DAW automation, not programmatic input. New in v12: Stem EQ, Bass Control, Unlimiter, IRC 5 Maximizer. | ~$250 (Advanced) | Most control of any tool. Script-based automation approach (Approach 3 below) is the best path for Ozone. Released ~Sept 2025. |
| **matchering** | Python library | No. Audio + reference track only. | No (whole-track matching). | Free (open source) | Matches RMS, frequency response, peak amplitude, stereo width to a reference. Could split-and-match per section against different references (custom code). v2.0.6 on PyPI. Requires Python 3.8+, 4GB RAM. |
| **AI Mastering (aimastering.com)** | Yes (REST, OpenAPI spec, SDKs in Ruby/Go/Node) | No text prompts. Parameters: mode, bass_preservation, mastering_algorithm (v1/v2), target_loudness, noise_reduction, bit_depth, output_format. Has `start_at`/`end_at` float params for partial mastering. | **Partial — has `start_at` and `end_at` parameters** for processing a specific time range. Could submit multiple jobs for different sections. | Free (was paid, now free as maintainer shifts to open-source desktop version) | Open-source mastering algorithm (phaselimiter). v2 algorithm optimizes for "Proposity 2" metric. 15-min max, 250MB max. The `start_at`/`end_at` params are interesting for per-segment processing. |
| **Slate Digital Virtu** | No (web app + desktop app) | No. Style profiles (Universal/Pop/Rock/Hip-Hop/EDM/Instrumental) + loudness target + reference track + EQ/compression/stereo tweaks. | No | Included with Slate subscription | Desktop version unlocks unlimited mastering. No API or programmatic access. |

### Programmatic Building Blocks (Python)

| Library | Purpose |
|---------|---------|
| **matchering** | Match spectral profile to a reference track |
| **pyloudnorm** | LUFS measurement and loudness normalization (EBU R128) |
| **scipy.signal** | Filters, EQ, dynamics processing |
| **librosa** | Audio loading, spectral analysis (already in Camelot stack) |
| **pydub** | Simple audio manipulation, splitting, concatenation |
| **soundfile** | High-quality audio I/O |
| **roex-python** | Python SDK for RoEx Tonn API (mastering, mixing, analysis) |

---

## Approaches (Ordered by Effort)

### 1. Cloud Service Baseline (Today)

Upload the mixed-down set to LANDR, eMastered, BandLab, or Waves. Get a baseline master. Compare against the raw mix. This requires no code — just a reference point. Also try SoundBoost.ai with descriptive prompts ("progressive trance mix, wide breakdowns, punchy drops").

**Limitation:** Treats the whole mix uniformly. Breakdowns get slammed the same as drops.

### 2. Dolby.io API + Forced Splitting (Best Cloud API Path)

The 10-minute file limit actually forces splitting — which works in our favor. A 60-minute set split at structural boundaries gives ~6-10 segments, each under 10 minutes.

```
analysis_cache.json → parse structural events →
  split audio at transition/section boundaries →
  for each segment: select Dolby.io genre profile + intensity + LUFS target based on event type →
  submit via API → download masters →
  crossfade segments back together
```

**Dolby.io advantages over LANDR API:** More parameters (genre profile, intensity 0-100%, LUFS target, stereo image control), better pricing ($0.05/min + 200 free min/mo), proven at scale (SoundCloud uses it), analysis API for validation.

**Alternatively with LANDR API:** Same split approach but only 3 intensity levels (Low/Med/High) and 3 styles (Warm/Balanced/Open). Coarser control but simpler.

**Alternatively with AI Mastering API:** Free, has `start_at`/`end_at` params (no splitting needed), but the service is winding down and quality may be lower.

**Pros:** Leverages professional mastering engines. Programmable. Multiple API options.
**Cons:** Crossfade artifacts at rejoin points. Cloud APIs don't accept section metadata — we're just simulating per-section processing by splitting.

### 3. Ozone 12 + DAW Automation (Manual but Highest Quality)

Load the mix in a DAW (Ableton, Logic, Reaper). Use Ozone 12 on the master bus. Manually set automation breakpoints at each structural event from the README/analysis_cache. Automate Ozone's modules per section.

New Ozone 12 modules relevant to DJ sets: **Stem EQ** (process stems differently within the stereo mix), **Bass Control** (mono bass management), **Unlimiter** (undo over-limiting in source tracks), **IRC 5 Maximizer** (better limiting algorithm).

**Translator concept:** Script that reads `analysis_cache.json` and outputs DAW-native markers/automation:
- **Reaper**: Generate ReaScript setting Ozone parameters at each event time (most scriptable DAW)
- **Ableton**: Generate `.als` automation or MIDI CC
- **Any DAW**: At minimum, generate a marker list with suggested settings per section

**Pros:** Maximum quality. Full control over every parameter. Ozone 12's Stem EQ is uniquely valuable for DJ mixes (can EQ vocals separately even in a stereo master).
**Cons:** Manual setup per mix. DAW-dependent. ~$250 for Ozone 12 Advanced.

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

### 5. Hybrid: Custom Pipeline + Commercial API

Best of both worlds: use the custom pipeline for section-aware decisions (where to process differently, what targets to aim for) but delegate the actual audio processing to a commercial engine via API.

**Most promising hybrid:** Custom splitter/decision engine + Dolby.io API for actual mastering + matchering for spectral matching against per-section reference tracks + pyloudnorm for final loudness verification.

### 6. SoundBoost.ai Iterative Prompting (Experimental)

Use SoundBoost.ai's text prompt interface iteratively — master the whole track, then use follow-up prompts to refine. Not truly structure-aware, but the LLM-powered prompt system could be told "the section from 2:00-3:30 is a breakdown that should be wider and less compressed" and the revision system might respond to that. Worth testing, but likely applies changes globally rather than to specific time ranges.

**Pros:** No code needed. Natural language interface. Revision without reuploading.
**Cons:** No evidence it can target specific time ranges. No API for automation. Likely applies prompts globally.

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
- **Dolby.io API**: Split points + genre profile + intensity (0-100) + LUFS target + stereo image settings per segment
- **LANDR API**: Split points + intensity (Low/Med/High) + style (Warm/Balanced/Open) per segment
- **AI Mastering API**: `start_at`/`end_at` time ranges + mastering parameters per segment (no splitting needed)
- **DAW markers**: Timestamp + label + suggested parameters (for manual Ozone workflow)
- **Ozone/Reaper automation**: ReaScript parameter curves per Ozone module per section
- **matchering**: Per-section reference track selection (match drops to punchy references, breakdowns to wide references)
- **Custom pipeline**: Processing rules per section type

---

## Research Findings Summary (2026-02-20)

### Can Any Tool Accept a Structural Description Document?

**No.** No mastering tool on the market — cloud, plugin, or open source — accepts a text document describing a mix's structure (key changes, drops, breakdowns, energy curves, transitions) as input for guiding mastering decisions.

The gap in the market:

| What Exists | What's Missing |
|-------------|----------------|
| Audio-driven AI analysis (all tools) | Accepting pre-computed structural metadata |
| Reference track matching (LANDR, Ozone, matchering, Masterchannel) | Accepting a section map with per-section targets |
| Natural language vibes/adjectives (SoundBoost.ai only) | Natural language structural descriptions with timecodes |
| Genre profiles (Dolby.io, LANDR, Virtu) | Time-varying parameter profiles driven by analysis data |
| Per-section automation (Ozone in DAW, manual only) | Programmatic per-section automation from analysis JSON |
| `start_at`/`end_at` partial processing (AI Mastering only) | True section-aware processing chains |

### Tools With APIs (Ranked by Usefulness for This Project)

1. **Dolby.io** — Best parameters, best pricing, proven at scale, forced splitting aligns with our needs
2. **LANDR** — Established API, simpler parameters, higher per-track cost
3. **RoEx Tonn** — Good Python SDK, research-backed, but limited mastering parameters
4. **Masterchannel** — Cheapest per-master ($1.50), but least control (fully autonomous)
5. **AI Mastering** — Free, has start_at/end_at, but winding down

### Tools With Text/Prompt Input

1. **SoundBoost.ai** — Only tool accepting natural language for mastering. LLM-powered. But: no API, no per-section control, no structural metadata input. Prompts are vibes ("warm," "punchy"), not structure ("at bar 64, switch to hard limiting").

### Tools With Per-Section Processing

1. **iZotope Ozone 12** — Via manual DAW automation only. Best quality, most control, but not programmatic.
2. **AI Mastering API** — Via `start_at`/`end_at` parameters. Could submit multiple API calls per section. But service is winding down.
3. **Dolby.io** — Engine internally adjusts over time, but no user-facing per-section control. Forced splitting due to 10-min limit creates de facto per-section processing.

### 2025-2026 Updates

- **Ozone 12** (Sept 2025): Stem EQ, Bass Control, Unlimiter, Master Assistant 2.0, IRC 5 Maximizer
- **Waves Online Mastering** (mid-2025): Enhanced clarity, EDM optimization, reduced pricing
- **SoundBoost.ai Mastering Engine v3.5** (2025): Richer prompt handling, dynamic intensity, session memory, real-time Final EQ
- **Dolby.io** (Nov 2025): Stereo imaging analysis + enhancement, expanded mastering profiles
- **RoEx roex-python** (Oct 2025): Updated Python SDK
- **CloudBounce** (2025): Shut down. Technology absorbed into FL Studio.
- **Auphonic** (Feb 2026): Added automatic music segment cutting (podcast-focused)

---

## Next Steps

- [ ] Run DJ Set 1 through cloud mastering services for baseline (LANDR, Waves, SoundBoost.ai, BandLab)
- [ ] Sign up for Dolby.io API (200 free minutes/month) and test with a single segment
- [ ] Investigate LANDR API access (sign up, get API key, test with one track)
- [ ] Test matchering + pyloudnorm on a single track segment
- [ ] Try SoundBoost.ai with descriptive prompts to see if per-section language has any effect
- [ ] Prototype the analysis-to-split-points translator (JSON → segment boundaries + per-segment API params)
- [ ] Prototype the analysis-to-DAW-markers translator (JSON → Reaper markers/ReaScript)
- [ ] Evaluate: cloud baseline vs. Dolby.io split vs. Ozone manual vs. custom pipeline
- [ ] If Ozone 12 path chosen: prototype ReaScript that reads analysis_cache.json and sets Ozone automation

## Tags
[music](../../tags/music.md), [python](../../tags/python.md), [ai](../../tags/ai.md), [audio-processing](../../tags/audio-processing.md), [cyborg](../../tags/cyborg.md)

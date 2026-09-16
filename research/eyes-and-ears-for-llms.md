---
status: active — synthesis from discussion 2026-09-16; goals stated, requirements not yet derived
created: 2026-09-16
published: true
layout: layouts/page.njk
title: "Eyes and Ears for LLMs — the Audio Translator"
---
# Eyes and Ears for LLMs — the Audio Translator
> Vision looks "solved" for LLMs and sound doesn't — but not because sound is harder. Modern models
> never translate images into text at all (the encoder emits tokens directly), and the internet handed
> vision its supervision signal for free. Music never got one. The page names sound's **three grounding
> regimes** (echolocation = physics, speech = transcripts, music = *half*-grounded), lays out the
> three-tier translator stack vision already walked, verifies which datasets and pretrained models can
> be pulled today, and states the translator as a set of **goals with examples and oracles** — the
> objective-function form — so the requirements can be derived from them.

**Links:** [The LLM Grounding Problem](./llm-grounding-problem.md) — the parent; this page answers its open question *can multimodal models close the grounding gap?* (partly, and only where the modality has an oracle), [Oracles Are Objective Functions](./oracles-as-objective-functions.md) — why the goals below each name their oracle, [DJ Blend Tool Test Plan](./dj-blend-tool-test-plan.md) — Phase 3 (2026-09-15): the reference was contaminated, comb tempo + `beat_this` downbeats = 1.000/0.999; this page is the theory that result sits in, [Programmatic DJ Mixing Tools](./programmatic-dj-mixing-tools.md), [The Cyborg Model](./cyborg-model.md) — human writes the score, machine executes; the translator is what lets the *LLM* read the score, [CyborgDJ](../projects/cyborgdj/README.md), [Camelot From YouTube](../projects/camelot-from-youtube/README.md) — tier 3 already built, [The Three-Layer Method](./karpathy-three-layer-method.md), [Repairing LLM Code — The Two Oracles](./repairing-llm-code.md) — correctness grounds *downward*; here the verifiable layer grounds downward to the waveform and the statistical layer has no lower oracle, [Transpilation as a Grounding Strategy](./transpilation-as-grounding.md) — the same move (deterministic transpile into a grounded representation) for sound, [Multi-Genre & Wide-BPM Mixing](./dj-multi-genre-mixing.md) — the DJ vocabulary the probe has to learn

## Provenance

Discussion, 2026-09-16, no raw source. Chris's prompt: a friend's video → frames → 3D-model pipeline,
and the observation that "translating data into text an LLM can manipulate seems much more robust
with visual data than sound data." Dataset and model pointers below were web-verified the same day;
everything else is synthesis. Chris "lived through" the 40 years of vision dominance from just after
the blocks-world robot-arm era, and remembers two systems: a Spotify recommender that predicted
tracks "extremely well" from audio-derived tags (melodic, four-on-the-floor…), and a Microsoft
Research project building 3D models from many photographs of one object.

## The premise, corrected in three places

1. **The room video is not an LLM doing geometry.** Video → frames → 3D is photogrammetry:
   feature matching, structure-from-motion, bundle adjustment, and lately Gaussian splatting or NeRF
   for rendering. The Microsoft project Chris remembers is **Photosynth** (Live Labs, 2006–08), the
   productized *Photo Tourism* (Snavely, UW); its lineage runs through Bundler to COLMAP, still the
   SfM front end under most splatting pipelines. It is 40+ years of *well-posed geometry* with
   epipolar constraints, and the answer is verifiable by reprojection error with no human in the loop.
   An LLM may orchestrate the tools; it does not reconstruct the room. The demo is therefore the
   *vision analog of the ears pipeline*: a specialized tool produces a structured intermediate (mesh /
   point cloud) that the LLM then reasons over. Same cyborg pattern.
2. **LLMs do not translate images into text.** A vision encoder (ViT patches → embeddings, projected
   into the model's token space) drops the image straight into the residual stream. No OCR-then-reason
   step; the image *is* tokens. The encoder was aligned contrastively (CLIP) on billions of
   image–caption pairs, so its space already agrees with language before the LLM sees it. That is why
   it feels effortless.
3. **"Judging distances with ease" is partly illusion.** VLMs are strong on the *semantic* content of
   screenshots (the web is saturated with screenshots + surrounding text) and coarse relations; they
   are notoriously weak at metric precision — counting, analog clocks, exact positions. Robust for what
   the training distribution covers, not for geometry.

**The asymmetry is data, not modality.** Audio encoders are the same architecture — Whisper and AST run
a transformer over a mel spectrogram, which is an image. The brain analogy holds too: cortex is roughly
uniform, and the Sur lab's ferrets, with retinal input rewired into auditory cortex, grew visual
orientation maps there. Architecture is not the difference; the *input statistics and the supervision
signal* are. Vision got its signal free from the web (image + caption). Audio's free signal was speech
transcripts. Music never got one — which is why it is 40 years behind on the same NN layers.

## Sound's three grounding regimes

"Sound has no grounding" narrows to something more useful: sound has three regimes, and music is the
odd one out.

| Regime | Oracle | Analog in vision | Status |
|---|---|---|---|
| **Echolocation / acoustic ranging** | physics — time-of-flight → distance, doppler → velocity | structure-from-motion | well-posed; easy for the same reason the room video is easy |
| **Speech** | the transcript — billions of paired hours | image captions | solved (Whisper); every "native audio" LLM is secretly a speech model |
| **Music** | *half*-grounded: pitch = frequency, rhythm = periodicity, consonance = integer ratios → physically verifiable; genre / mood / "sounds like" → **no physical oracle, the ground truth is a human ear** | semantic content of a photo | tier 3 partially built (Camelot); tier 2 exists but small |

The design consequence: the translator must draw the line explicitly. A **verifiable layer** (tempo,
key, beat grid, section *boundaries*) is checked against the waveform or an external annotation; a
**statistical layer** (similarity, character, section *labels*) is checked against listeners. Different
oracles, different verification, never mixed — and the verifiable layer can always overrule the
statistical one. Phase 3 of the [test plan](./dj-blend-tool-test-plan.md) is what happens when the
human oracle gets contaminated: 11 of 14 "reference" grids were camelot's own export re-imported.

## The three-tier stack vision already walked

| Tier | Vision | Audio | What the LLM gets |
|---|---|---|---|
| 1. Handcrafted descriptors | SIFT, HOG — the 40 years | librosa / Essentia: MFCC, chroma, spectral centroid, onset envelope, tempogram | numbers, no meaning |
| 2. Learned embeddings, contrastively aligned to text | CLIP (2021) | CLAP, MERT, MuQ, Essentia `discogs-effnet` (2020–24) | a similarity space where "sounds like" is a distance and a text query lands in it |
| 3. Symbolic / structural | mesh, scene graph, OCR | beat grid, key, sections, chords, stems (Demucs) | **text it can manipulate** — the Camelot JSON |

Librosa "puts numbers to noise" (tier 1). "Understanding the numbers" is tier 2, and vision solved it
not with a smarter feature extractor but with *contrastive alignment*. The scale gap is the whole
story: LAION-5B had ~5 billion image–caption pairs; LAION-CLAP trained on ~630 k audio–caption pairs;
MusicCaps is 5.5 k clips. The Spotify recommender Chris remembers was the **Echo Nest** inside Spotify
(acquired 2014; `danceability / energy / valence / acousticness` + per-segment timbre and pitch
vectors), and the "huge dataset" is the **Million Song Dataset** (2011, Echo Nest + Columbia LabROSA,
1 M tracks of those features). The tag *phrasing* ("four-on-the-floor beats, melodic") is Pandora's
Music Genome vocabulary — hand-annotated by musicologists, i.e. expert meta-tags, the opposite of
audio-derived — so the memory blends two systems. Today that recommender is: embed every track with
MERT or `discogs-effnet`, nearest-neighbour search. Two afternoons, not a research program.

## What can be pulled today (verified 2026-09-16)

**Spotify's features are gone.** On 2024-11-27 Spotify deprecated `audio-features`, `audio-analysis`,
`recommendations` and related-artists for any app created after that date — 403, no waitlist, no path
back. The thing Chris remembers cannot be called; it has to be rebuilt from audio.

| Resource | What | Why it matters here |
|---|---|---|
| [**Harmonix Set**](https://github.com/urinieto/harmonixset) ([Zenodo](https://zenodo.org/records/3527870), [ISMIR 2019](https://ccrma.stanford.edu/~urinieto/MARL/publications/ISMIR2019-Nieto-Harmonix.pdf)) | 912 Western pop/EDM tracks; human **beats + downbeats + functional sections** (intro / verse / chorus / drop…); JAMS, mel-specs (~1.2 GB), YouTube URLs with DTW alignment scores | *The* DJ dataset, and an oracle that is not Chris's own annotations — contamination becomes checkable |
| **MTG-Jamendo** | ~55 k full CC-licensed tracks; genre / instrument / mood-theme tags | the only large set that ships *audio* → legal training / fine-tuning data |
| **Million Song Dataset** | 1 M tracks of Echo Nest features, no audio | the feature vocabulary Spotify's was; historical |
| **MusicCaps** (~5.5 k) / **Song Describer** (~1.1 k) | clip + free-text caption | the audio–caption pairs CLAP-style models train on; the data gap in numbers |
| **GTZAN** | 1 k clips, 10 genres | the classic benchmark — known contaminated (duplicates, mislabels); the cautionary twin of Phase 3 |
| [**Essentia `discogs-effnet`**](https://mtg.github.io/essentia-labs/news/tensorflow/2020/01/16/tensorflow-models-released/) ([Replicate](https://replicate.com/mtg/effnet-discogs)) | EfficientNet-B0 trained on 2 M+ recordings with Discogs metadata; **400 Discogs styles** (tech house vs progressive vs deep — DJ-grade taxonomy) + mood heads; doubles as an embedding extractor | tier 2 as a pip install; "librosa plus understanding" with zero training |
| **MERT**, **CLAP** | general music / audio–text embeddings | tier 2 alternatives; [MARBLE](https://github.com/a43992899/MARBLE) benchmarks them |
| [**dj-tagger**](https://github.com/Dinpo/dj-tagger) | Essentia ML + Beatport + Last.fm, autonomous DJ tagging | someone already built the tier-2 tagger for this use — **read before writing** (reuse > rebuild) |

## Goals — objective-function form

Chris: "LLMs work best trying to optimize towards a goal." Each goal below is stated as an
[objective with an oracle](./oracles-as-objective-functions.md): what to produce, a worked example,
what it is scored against, and which side of the verifiable/statistical line it sits on. Requirements
are derived *from* these, afterwards (see the stub section).

### G1 — The verifiable grid (tier 3, verifiable)
**Goal:** for any track, emit a rigid beat grid — tempo to 0.01 BPM, first-downbeat offset, bar
count — that survives to the end of the track.
**Example:** `track.wav` →
`{"bpm": 124.00, "downbeat_offset_s": 0.412, "bars": 129, "meter": "4/4", "confidence": {"tempo": "comb", "phase": "beat_this"}}`
**Oracle:** the waveform (onset envelope comb search) cross-checked against an *external* human grid —
Harmonix Set. Pass = beat F-measure ≥ 0.99 and downbeat ≥ 0.99 on Harmonix, not on camelot's own
re-imported export.
**State:** 1.000 / 0.999 on the three clean Rekordbox tracks (Phase 3). Harmonix not yet run.

### G2 — Structure (tier 3; boundaries verifiable, labels statistical)
**Goal:** sections at bar resolution with *functional* labels.
**Example:** →
`[{"bar": 1, "label": "intro"}, {"bar": 33, "label": "build"}, {"bar": 65, "label": "drop"}, {"bar": 97, "label": "breakdown"}, {"bar": 129, "label": "drop"}, {"bar": 161, "label": "outro"}]`
**Oracle:** *boundaries* — novelty/self-similarity on the waveform, checked against Harmonix segment
boundaries (tolerance ±1 bar); *labels* — Harmonix functional labels, accepting that these are human
and genre-shaped. This is the borderline case: the same object has a physical half and a cultural half.
**State:** camelot emits "structure, events"; `allin1` (the SOTA structure model) is blocked on Windows
(NATTEN). Untested against any external oracle.

### G3 — Key and harmonic content (tier 3, verifiable)
**Goal:** Camelot key per track and per section, plus a chroma profile the LLM can compare.
**Example:** → `{"key": "8A", "confidence": 0.91, "sections": {"drop": "8A", "breakdown": "11B"}}`
**Oracle:** physics — pitch-class profile from chroma; agreement with Rekordbox / Mixed In Key as a
second reader. Key-as-a-knob ([multi-genre page](./dj-multi-genre-mixing.md)) makes this a solver
input, so a wrong key is a wrong mix.
**State:** built in camelot; accuracy vs a second reader not measured.

### G4 — "Sounds like" (tier 2, statistical)
**Goal:** given a seed track and constraints from the verifiable layer, return ranked candidates *with
reasons in DJ vocabulary*.
**Example:** `"like PQM – The Flying Song, 124–128 BPM, 8A/9A/7A"` →
`[{"track": "…", "distance": 0.12, "why": ["melodic", "four-on-the-floor", "driving bass", "low vocal presence", "style: progressive house 0.81"]}, …]`
**Oracle:** the listener — Chris's judged pairs (this *is* / *isn't* a match). Scored as precision@k.
Guard: G1/G3 constraints are hard filters, so the statistical layer never overrules the verifiable one.
Known bias: whatever `discogs-effnet` / MERT learned from listeners, this inherits — fine for
*retrieval*, dangerous for *claims*.
**State:** nothing built; `dj-tagger` and `discogs-effnet` are the reuse candidates.

### G5 — The DJ-vocabulary probe (tier 2 → tier 3, statistical, *yours*)
**Goal:** labels that exist in no dataset because they are about *use in a set*, not about the track:
`opener / peak / closer`, `mix-in window`, `mix-out window`, `energy 1–10`, `texture` (per
[DJ Set 1](../projects/dj-set-1/README.md)'s texture-over-harmony).
**Example:** →
`{"role": ["opener", "mid-set"], "energy": 6, "mix_in": {"bar": 1, "len_bars": 32}, "mix_out": {"bar": 161, "len_bars": 16, "clean": true}, "texture": "pad-led, sparse percussion"}`
**Oracle:** Chris's labels — a small probe (thousands of parameters) trained on a pretrained embedding,
over a few hundred labeled tracks. Held-out agreement with Chris. The honest statement: this is the
contaminable layer, and it is the *only* genuinely new thing; everything beneath it is reuse.
**State:** vocabulary not yet fixed; no labels collected.

### G6 — The text surface (the translation itself)
**Goal:** render G1–G5 as one compact document per track that an LLM reads to *write a set* — the
score in the [cyborg model](./cyborg-model.md) — and that the CyborgDJ engine can execute unchanged.
**Example:** a ~30-line block per track: header (bpm, key, energy, role), a bar-indexed section list
with mix-in/out windows, and a five-tag character line; the LLM's output is the existing JSON spec
(`fade_bars`, `automation`, `eq_3band…`) with bar numbers taken from the document.
**Oracle:** two-sided — (a) *verifiable*: the rendered mix has no beat clash (grid error over the
overlap < 10 ms), which the engine can measure; (b) *statistical*: Chris's A/B against a hand-written
transition — the [crossover-calibration](./dj-crossover-calibration.md) harness already logs these.
**State:** the JSON spec and engine exist; the input document does not.

## Requirements — to be derived from the goals

*Stub, by design.* Chris: "we can see if we can't get the requirements afterwards." Each goal above
fixes an output schema, an oracle, and a pass threshold; requirements fall out as (a) the data each
oracle needs on disk (Harmonix audio alignment, a labeled-pairs file for G4, a label file for G5),
(b) the environment (torch + `beat_this` + Essentia on Windows — `allin1`'s NATTEN block is the known
hazard), and (c) the order — G1 → G2 → G6 gives an end-to-end path before any training; G4/G5 are the
first place a NN gets *trained* rather than reused.

## Open Questions

- G2's line: is a section *boundary* really verifiable from the waveform alone, or does novelty
  detection only agree with humans on genres with a drop? Harmonix will say.
- Does `discogs-effnet`'s 400-style head already cover the DJ vocabulary well enough that G5 is a
  relabeling rather than a probe?
- What is the minimum labeled-track count at which a G5 probe beats a zero-shot CLAP text query?
- Native-audio LLMs (Gemini, GPT-4o audio) — speech-biased today; is there a test that shows whether
  they read *music* structure at all, so the page knows when tier 3 stops being necessary?
- Oracle contamination generalizes: any layer whose reference is the tool's own prior output. Is
  there a mechanical check (provenance on every reference file) worth adding to the test plan?

## Tags
[ai](../tags/ai.md), [grounding](../tags/grounding.md), [music](../tags/music.md), [audio-processing](../tags/audio-processing.md), [machine-learning](../tags/machine-learning.md), [cyborg](../tags/cyborg.md), [llm-limitations](../tags/llm-limitations.md)

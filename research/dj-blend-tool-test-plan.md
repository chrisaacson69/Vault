---
status: active
created: 2026-09-14
published: true
layout: layouts/page.njk
title: "DJ Blend Tool Test Plan — Retrieve, Fit, Close the Gaps"
---
# DJ Blend Tool Test Plan — Retrieve, Fit, Close the Gaps
> An ordered plan to pull in the candidate tools for the two-track blend problem, test each against
> one fixed transition, and see which of the open gaps (critic, closed loop, A/B log) each one closes.

**Links:** [Eyes and Ears for LLMs](./eyes-and-ears-for-llms.md) — the theory Phase 3 sits in: verifiable vs statistical layers, Harmonix Set as the external oracle that makes contamination checkable, [Crossover Calibration](./dj-crossover-calibration.md) (the H1/H2 design this plan executes), [DJ EQ Blending Technique](./dj-eq-blending.md) (the gap table), [Programmatic DJ Mixing Tools](./programmatic-dj-mixing-tools.md) (verified tooling, 2026-07-22), [CyborgDJ](../projects/cyborgdj/README.md), [Camelot From YouTube](../projects/camelot-from-youtube/README.md), [Oracles as Objective Functions](./oracles-as-objective-functions.md), [The Three-Layer Method](./karpathy-three-layer-method.md)

*Status: plan, not results. Every "pass criterion" below is a bar to clear, not a number achieved.*

## Where this came from (2026-09-14)

A session that started as "how do I build an ear for Claude" converged, without hints, on the route the
vault already holds: **stems → per-bar spectral score → derive the crossover, don't search for it.**
Convergence from a cold start is weak evidence the route is right. What the session *added* is small
and listed here so it isn't lost; what it *re-derived* is pointed at, not repeated:

- **Grounded (verified against the platform docs 2026-09-14):** the Messages API has no audio input
  modality — text, images, PDF, plain text only. So "Claude as ear" is *always* a feature pipeline that
  emits text and plots; the model can read a labelled log-frequency plot or a third-octave matrix, never a
  waveform. This closes half of the open question in
  [Programmatic DJ Mixing Tools → Still open](./programmatic-dj-mixing-tools.md#still-open-do-not-read-absence-as-absence).
- **New candidates:** pitch features on the bass stem (kick fundamental, bass note → harmonic clash between
  the two tracks' lows), the sub-band phase-correlation metric as a first-class critic input, a synthetic
  self-blend oracle, and Mixxx's analysis code as a reference implementation.
- **Corrections to the session's first pass, from the vault:** `allin1` is stale → use `beat_this`;
  `madmom` models are NonCommercial and PyPI is 2018 → git-only, personal use; raw `demucs` → `audio-separator`.

## The gap table this plan fills

From [DJ EQ Blending → The actual gap](./dj-eq-blending.md#the-actual-gap): the spectral score, stems,
collision/crossover suggestion, and LUFS **exist**; the beat grid is librosa with no downbeat; and three
layers are missing — **a critic on the rendered output, a closed loop, an A/B judgement log.**
`collision.py` proposes a crossover from the *sources*; nothing yet measures the *output* — that is
self-consistency, not verification.

## The fixture — one pair, one window

Every test below runs on the same transition so results compare: **PQM → Quivver** (spec
`pqm-quivver-t07-v4.json`: both 129.2 BPM, 1A→1A, 80-bar overlap, PQM cue 65–289, Quivver 0–226). It is the
pair the February results called out (300 Hz leaked, 450 Hz fixed it) — which makes it the only transition
with a hand-found answer to cross-check against. Render **only the ≈8 bars around the bass swap**, looped,
per the calibration design.

**Grounding gap found while writing this:** no spec on disk carries `low_freq: 450`. Current specs hold
200/250/300; the 450 Hz finding lives only in the vault page. Phase 0 re-establishes it before anything
depends on it.

## Environments (this machine, checked 2026-09-14)

| Env | Python | Has | Note |
|---|---|---|---|
| `camelot_from_youtube/env1` | 3.14.2 | librosa 0.11, numpy 2.3, pyloudnorm, pyrekordbox 0.4.4 | the live analysis env; torch 2.11+ supports 3.14 per the migration notes |
| `camelot_from_youtube/env_demucs` | 3.9.13 | demucs 4.0.1, torch 2.5.1+cu121 | superseded path; `audio-separator` needs ≥3.10 |
| system `py -3` | 3.9.13 | — | not the target |

Decision to make in Phase 0: extend `env1` (torch + audio-separator + beat_this) or stand up one
`env_mir` for the neural tools. Prefer one env; the cross-repo duplication noted in the EQ page came from
having several.

## Phases — ordered by value per effort

The calibration page's rule governs the order: **the repeat-trial noise floor is run first**, because it
bounds what every later phase has to deliver and may retire H1 before H1 is built.

### Phase 0 — Baseline and fixture (existing engine only)
- **Tool:** CyborgDJ `--transition` render; `split_3band` in `effects.py` (Linkwitz-Riley, `low_freq` param).
- **Test:** render the 8-bar swap window at `low_freq` ∈ {250, 300, 450, 600}; confirm by ear that 450 still
  beats 300 (re-establish February).
- **Pass:** four loopable stimuli exist; the 450-vs-300 preference reproduces. If it doesn't, the February
  finding was pair-and-day specific — stop and record that.
- **Closes:** nothing yet; produces the fixture.

### Phase 1 — H2: the noise floor (2AFC harness)
- **Tool:** a small harness to write — blind, randomized, 2AFC, adaptive staircase, **repeat trials inserted**.
  Playback only; no analysis.
- **Test:** ~30 trials on the Phase 0 stimuli plus finer steps; measure self-consistency on the repeats.
- **Pass:** a measured JND band for this pair (e.g. "choices are consistent above ±X Hz, noise below").
- **Closes:** **the A/B judgement log** — the harness *is* the log (spec A, spec B, pick, why). Sets the
  resolution target for Phases 2 and 4.

### Phase 2 — H1: derive the crossover, cross-check against the hand-found value
- **Tools:** `camelot_from_youtube/collision.py` (exists; `--bars-a/--bars-b` over the swap window),
  `spectral_analysis.py` (exists), `audio-separator` (retrieve) for bass/drum stems.
- **Test A:** run `collision.py` on the fixture; does its suggested crossover land near 450 Hz?
- **Test B:** bass-stem LTAS → the "−30 dB point" / valley between bass reach and melodic fundamentals →
  a second candidate. Compare A, B, and 450 Hz.
- **Pass:** a derived number within the Phase 1 JND of the hand-found one. Two agreeing derivations
  (matrix-based, stem-based) are the mutually-confirming-oracles pattern; one that disagrees is a finding
  about *which* representation the ear tracks.
- **Closes:** the "crossover needs per-transition tuning" item — if it passes, the number is computed, not
  authored.
- **Caveat carried from the July research:** stems for *discovery* only; the "other" stem caps at ~9 dB SDR
  on this genre. Don't render from stems here.

### Phase 3 — Beat grid: replace the weakest existing layer
- **Tools:** `beat_this` (retrieve, MIT), `pyrekordbox` (installed, currently write-only) to read
  Rekordbox's grids *back*, `librosa.beat.beat_track` (current).
- **Test:** score all three against the Rekordbox grid on the catalog in `camelot_from_youtube/` — Rekordbox
  is the free genre-matched benchmark the July page identified; downbeat accuracy is the number that matters
  (Zehren's switch-point rule: downbeat at the start of a 4-bar period). *Ran 2026-09-15 — see results below.*
- **Pass:** `beat_this` ≥ Rekordbox on downbeats, or a decision to read Rekordbox and stop recomputing.
- **Closes:** ⚠️ beat grid row of the gap table. Independent of Phases 1–2; can run in parallel.

### Phase 4 — The critic: measure the rendered output
- **Tools:** `spectral_analysis.py` run **on the render** (reuse), `pyloudnorm` short-term LUFS, numpy
  correlation of the two bass stems in the sub band (< ~120 Hz) across the swap.
- **Metrics** (the calibration page's four, plus one): residual bass energy above the crossover; source
  overlap in the crossover band; short-term LUFS deviation through the swap; **sub-band phase correlation**
  (cancellation is why some swaps "lose the kick" with correct EQ); predicted-vs-actual third-octave delta.
- **Test:** compute each metric for every Phase 1 stimulus; check which single metric best predicts the
  2AFC picks. **Do not train a model** — if one deterministic metric predicts well, the critic is done.
- **Synthetic oracle:** blend a track into a tempo-shifted copy of itself with a known offset and a known
  crossover; the critic must score the known-correct render best. A critic that fails the synthetic case
  is not measuring what we think.
- **Pass:** one metric with high agreement against human picks; the synthetic case ranks correctly.
- **Closes:** **critic on the rendered output** — and with Phase 2's derivation, enables the closed loop
  (LLM/human picks recipe and constraints; solver picks values; critic scores).

### Phase 5 — Pitch features on the lows (new; lowest priority)
- **Tools:** `librosa.pyin` (installed) on the bass stem; `basic-pitch` (retrieve — runtime support on
  Windows/3.14 **unverified**; ONNX path is the one to try).
- **Test:** kick f0 and bass note per bar for both tracks over the swap; compute harmonic clash
  (interval between the two lows). Check whether clash predicts 2AFC picks *beyond* the Phase 4 metrics.
- **Pass:** measurable added predictive value, or an explicit "no — the spectral metrics already carry it."
- **Closes:** decides whether pitch belongs in the critic at all.

### Phase 6 — The "ear" hypothesis (deferred until 2 and 4 exist)
- **Test:** hand the LLM the `collision.py` report + plot (a labelled log-frequency image) and ask for the
  crossover and the swap timing; compare against the measured answer from Phases 2 and 4.
- **Pass/fail is informative either way:** it measures whether reading the plots adds anything over the
  deterministic pipeline — the still-open "audio-understanding LLM" question, now testable because the
  ground truth exists.

## Phase 3 — results (2026-09-15)

Bench lives in `camelot_from_youtube/bench/` (scorer, runners, rigid-grid fitter; `README.md` there).
Reference = the grid Rekordbox holds per track (`PQTZ` tag via `pyrekordbox`); F-measure at 70 ms.

**The reference was contaminated, and finding that out is the main result.** Of 14 tracks in Rekordbox,
the 11 DJ-set tracks were *imported from camelot's own `rekordbox_collection.xml`* on 2026-02-20 and
never re-analysed (`created`/`updated` one minute apart; BPMs 120.19 / 123.05 / 126.05 / 129.19 = librosa
tempogram **bin centres** 60·86.13/43…40 to two decimals; `TEMPO Inizio` = camelot's first downbeat).
Only Flip of the Coin, Waves and Quicksilver (added 2026-03-07, BPM 122.00 / 124.00 / 122.00) carry a
native Rekordbox analysis. So the [EQ page's Rekordbox-vs-librosa split](./dj-eq-blending.md#rekordbox-vs-librosa--an-empirical-split-chris-2026-07)
was, for those 11 tracks, camelot's rigid export judged against camelot's drifting beats — the *rigidity*
conclusion stands (see below), the *Rekordbox-detects-better* half is untested until they are re-analysed.

Against the three clean references:

| tracker | beat F | downbeat F | what it tells you |
|---|---|---|---|
| camelot (cached) / raw librosa | 0.66 / 0.67 | 0.00 | DP tracker drifts ±200 ms through a rigid track; no downbeat model |
| `beat_this` (minimal post-proc, no madmom) | 0.97 | **0.97** | locally right, incl. downbeats; but snaps tempo coarsely (130.00 on a ~129 track) and drifts ~3 s over a long track |
| rigid grid, tempogram tempo + onset phase | 0.30 | 0.07 | tempogram bin is 0.05–1 BPM off — a rigid grid at the wrong tempo is worse than a drifting one |
| rigid grid, **comb-search tempo** + onset phase | **1.000** | 0.67 | 2-D search (±1.5 BPM × phase) over the onset envelope recovers 122.00/124.00 exactly; camelot's downbeat-phase estimator is at chance |
| comb tempo + onset phase + **`beat_this` downbeat phase** | **1.000** | **0.999** | the combination: deterministic grid, NN only votes bar phase |

Three tracks is thin evidence, but every row has a mechanism behind it, and the mechanisms match what
you already knew: **structure (one tempo) beats sample-following; the tempo must be searched, not read
off a tempogram bin; the downbeat needs a learned model.** On the 11 contaminated tracks, `beat_this`,
the comb search, and a line fit through librosa's own beats all agree on tempos the export doesn't hold
(Quivver 128.98 not 129.199; Below The Belt / LTN 130.00 not 129.19) — those exported grids are probably
0.1–0.8 s adrift by the end of the track.

**Tool verdicts.** `beat_this`: keep, for the downbeat vote (and as a tempo cross-check) — runs on
Py 3.14 + torch 2.11 cu128 in `env_mir`, ~5 s/track on the RTX 3050. `allin1`: **not runnable here** —
NATTEN has no Windows wheels and there is no CUDA toolkit on this machine; run it in the cloud (Linux
wheels exist) if section labels are wanted. `pyrekordbox` read path: works; the grids it returns are
only a reference *after* Rekordbox has analysed the track itself. `madmom` DBN (what makes `beat_this`'s
published numbers): not tried — NC licence, git-only, Py 3.14 build unverified.

**Open, in priority order.** (1) Re-analyse the 11 DJ-set tracks in Rekordbox → 14 clean references, then
re-run `beat_bench.py score`. (2) The half-beat phase flip: full-band and kick-band onset scoring each pick
the off-beat on different tracks; it can't be judged until (1). (3) Port `rigid_grid.py --comb` +
`beat_this` phase into `bpm_detect.py` — camelot's export would then carry a grid that survives to the end
of the track.

## Retrieval checklist

| Tool | Action | Verified gotcha |
|---|---|---|
| `audio-separator` | `pip install audio-separator` in the chosen env (≥3.10, CUDA torch first) | GPU ⚠️ in its table is DirectML-specific, not CUDA; chunked to avoid OOM |
| `beat_this` | install from GitHub (CPJKU) | MIT; Windows/torch-version support to confirm on install |
| `pyrekordbox` | already installed — add a *read* path (`master.db` grids in) | none |
| `basic-pitch` | optional, Phase 5 only | runtime support on this Python unverified |
| `madmom` | **do not retrieve** unless `beat_this` fails | NC models; git-only install |
| `allin1` | **do not retrieve** | stale, NATTEN build on Windows |
| Mixxx source | reference only — read its beat/key analysis, don't run it | C++; not for offline rendering |

## Open questions
- Does the Phase 1 JND vary by pair, or is it stable across the catalog? (One pair answers nothing about this.)
- Re-summation artifacts of stems remain unmeasured — Phase 2 never renders from stems, so this stays open.
- Where does the derived crossover live once computed — in the spec (authored) or computed at render time
  from the analysis cache (a real dependency on camelot, replacing the copied `camelot/` folder in CyborgDJ)?

## Tags
[music](../tags/music.md), [audio-processing](../tags/audio-processing.md), [cyborg](../tags/cyborg.md), [python](../tags/python.md)

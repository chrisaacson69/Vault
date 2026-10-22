---
status: active
created: 2026-10-22
published: true
layout: layouts/page.njk
title: "Two Libraries Out of a Grown Tool — the dj-score / dj-render Extraction"
---
# Two Libraries Out of a Grown Tool — the dj-score / dj-render Extraction
> Over 2026-10-21/22, camelot_from_youtube (a Tk app that had grown 25 analysis scripts) and CyborgDJ (a renderer
> holding forks of them) became two libraries, two apps and one shared data store: **dj-score** measures,
> **dj-render** renders, camelot is the UI and CyborgDJ the controller, all reading the `music` library. No result
> changed along the way, and that was checked every time, not assumed. This is the dated specimen of
> [Well-Structured Python at Scale](./well-structured-python.md): its §4 recipe, run on a real codebase.

**Links:** [Well-Structured Python at Scale](./well-structured-python.md) (the thesis this tests), [dj-score](../projects/dj-score/README.md), [dj-render](../projects/dj-render/README.md), [CyborgDJ](../projects/cyborgdj/README.md), [Camelot From YouTube](../projects/camelot-from-youtube/README.md), [CyborgDJ as Controller](./cyborgdj-inference-interface.md) (the MCP design this enables), [DJ Blend Tool Test Plan](./dj-blend-tool-test-plan.md) (the beat-grid bench), [Oracles Are Objective Functions](./oracles-as-objective-functions.md), [The Three-Layer Method](./karpathy-three-layer-method.md)

## What changed

| Before | After |
|---|---|
| camelot: UI + 25 scripts, each CLI with its own loader and grid; track data and audio in the repo | **dj-score** (analysis: grid, key, events, spectra, collision, Rekordbox export), layered and import-linted; camelot = the UI on top |
| CyborgDJ: renderer + forks of camelot scripts + a stale copy of its analysis + 28 specs, renders, transcripts | **dj-render** (spec → audio; may not import librosa or dj-score); CyborgDJ = the controller (CLI + scripts) |
| tracks scattered across repos; derived files beside the audio | **`music/`**: originals; `analysis/<track>/`; `CyborgProjects/<project>/` (specs, renders, notes); local only |
| 4 camelot envs (two on Python 3.9), ~10 GB | 2 envs (UI; one GPU/ML env with a committed recipe), −4.9 GB |

The ledger with every verdict is dj-score's `MIGRATION.md`; CyborgDJ's `AUDIT.md` holds its half. Public repos now
hold code only. Retired tools sit in local, gitignored `archive/` folders, and git history keeps their code.

## What we learned

**1. Convert, don't rewrite, and prove it against the original running.** Every module moved with an oracle test
that runs camelot's own code (imported from its git history at a pinned revision, so archiving can't break it) on
the same input and requires identical output: JSON, cache files, chart pixels, a replayed UI session (43
observations), a printed report. For the renderer the oracle is byte-identical WAVs from four transitions, re-run
after every structural step. "Same output" is cheap to check and settles arguments that review cannot.

**2. An oracle must be shown able to fail.** Green suites lied in five different ways, each found only by
looking:
- inputs that never reached the branch (collision with zero gaps);
- a mutation masked by stale `.pyc` (same size, same second);
- a data move that emptied the glob that parametrizes the tests (zero cases is green);
- a harness that *skipped* missing tracks;
- a legacy module switching the whole test session to Tk, surfacing only as an intermittent error under load.

The fixes, all mechanical: plant a mutation and watch it fail; assert coverage; raise on empty inputs; fail rather
than skip; reproduce the failure condition deliberately (Tk disabled) and revert the fix to see it break again.

**3. Split along dependency lines, not topics.** "Music" was one topic but two dependency families: analysis
(librosa) and rendering (Rubber Band, scipy, no librosa). Chris: *"the dependency issues are key here."* The
seam was already visible in the code: the renderer needs grid *results* (tempo, downbeat, bar frames), never
analysis *code*. An import contract makes the seam permanent, and a planted violation proves the contract bites.

**4. One resolver for shared state.** The music library's layout is known in exactly one place (dj-score's
`adapters/library`; dj-render repeats three lines rather than depend on it), and it is *read from disk*: a folder
with `analysis/` is a library. So the UI, the CLIs, the renderer and the tests needed no configuration when Chris
moved the data, and audio outside a library still works the old way.

**5. Archive, don't purge; and data stays out of public view.** Nothing was deleted. Tracked files were copied and
compared byte for byte before removal, untracked ones moved. Some "stale copies" turned out to be the only copy:
CyborgDJ's `key_analysis.json` files were the only key analysis for four tracks, and a different tool's output
than the same-named file in the library.

**6. Accumulated state is contaminated, so check it against a lower artifact.**
- The specs' tempos were camelot's tempogram bin centres, up to 0.86% off, about two beats of drift every two
  minutes. Hand-set downbeats had been compensating, and were re-tuned across versions; the Foss anchor sat 189 ms
  off the nearest real beat.
- The September bench's "Rekordbox references" were camelot's own export.
- The Breeder hand labels' times inherited a grid that is one beat uncertain in places.

Each was caught by going one level down: the stems, drum onsets, Rekordbox's native analyses. The new comb grid
reproduced the September bench to 1e-9 s on all 14 tracks.

**7. Baselines before claims.** Every Breeder label sits on a phrase boundary, so "fire every 8 bars" scores 6/10.
Against that baseline, camelot's micro "fill detector" was a phrase-position prior, and the `full_drop` event to
harvest existed only in a docstring. Nothing was left to extract.

**8. On dense tracks a locked grid beats a detector, and the ear is the final judge.** The measured-tempo Foss
render was *"so close that it is very hard to tell, but B does sound a little cleaner"*: faded kicks turn mistiming
into a warble, not double beats. A fixed tempo assumes the beat through the gaps where detectors lose it. Switching
the renderer's grid therefore waits on listening, and on an objective verify step.

**9. Verify claims about the environment too.** "ffmpeg is blocked" was carried for two days; it was only
`ffprobe`. Application Control allows specific builds: PyMuPDF loads when pinned to the allowed binary. Merging
two GPU envs was accepted only after their Demucs stems matched to 63–77 dB below each stem.

**10. The corrections were part of the method.** Several confident statements were wrong and were retracted with
evidence: the label grid being "exactly right"; ffmpeg; `align_to_master.py` as a live second consumer; the
audit's plan to move loader I/O into dj-score, which contradicted its own dependency finding. Each surfaced
because the next step re-checked the last one.

## Still open (feature work, not structure)

- **Downbeat and phrase phase:** the comb grid gets tempo and beat phase right, but its downbeat vote is 0.67 and
  nothing estimates which bar starts a phrase. That blocks making it the default.
- **The renderer reading the grid from the library** instead of hand-typed spec tempos (changes audio: listen first).
- **The verify loop:** measure a dj-render output with dj-score (kick alignment in the overlap).
- **Smaller items:**
  - `snap_cues_to_bars` folds into export;
  - CI for the import contracts;
  - cache-first analysis for the MCP layer;
  - re-exporting Rekordbox locations;
  - a private archive (undecided);
  - removing Python 3.9.

## Open Questions

- Once the renderer reads the library's comb grid, do the hand-set `first_beat_sample` overrides become unnecessary
  across the Preach set, or does the ear still disagree somewhere?
- Which objective measure of a rendered overlap tracks what Chris hears on dense tracks (a "warble" from faded
  kicks), so the verify loop can stand in for listening on small differences?
- Can phrase phase (which bar opens a phrase) be estimated from the audio without a learned model, or does it
  need `beat_this`-style learning like the downbeat?

## Tags
[python](../tags/python.md), [software-engineering](../tags/software-engineering.md), [music](../tags/music.md), [audio-processing](../tags/audio-processing.md)

---
status: active — design from discussion 2026-10-21; nothing built yet
created: 2026-10-21
published: true
layout: layouts/page.njk
title: "CyborgDJ as Controller — the Interface Between Inference and the Engines"
---
# CyborgDJ as Controller — the Interface Between Inference and the Engines
> The [dj-score](../projects/dj-score/README.md) library already has the shape of an MCP server: one
> service per use case, results as JSON-ready records, a cache as shared state. Decided: **CyborgDJ becomes the
> controller** (inference holds the set) and the code does the busywork. The design question is *where*
> inference sits in each loop. It calls tools directly when planning, as with REA; it writes a deterministic
> search it then stays out of when tuning, as the Zelda bot did. The second loop is where the open
> "tuning knob" problem lives.

**Links:** [dj-render](../projects/dj-render/README.md) — the render library (2026-10-22), the second tool surface next to dj-score, [The Cyborg Model](./cyborg-model.md) (the Cyborg DJ worked example this extends), [An AI Speedruns NES Zelda](./gaming/zelda-ai-speedrun-harness.md) (inference at authoring time, a 4-verb socket at run time), [REA](./reverse-engineering/rea-candidate-tool.md) (inference driving tools over MCP at run time), [Crossover Calibration](./dj-crossover-calibration.md) (the tuning-knob problem, designed, not built), [DJ EQ Blending](./dj-eq-blending.md) (real-time knobs, "the spec is the stable contract"), [Eyes and Ears for LLMs](./eyes-and-ears-for-llms.md) (why the model's ears must be a feature pipeline), [Oracles Are Objective Functions](./oracles-as-objective-functions.md), [Programmatic DJ Mixing Tools](./programmatic-dj-mixing-tools.md), [CyborgDJ](../projects/cyborgdj/README.md), [dj-score](../projects/dj-score/README.md), [Well-Structured Python at Scale](./well-structured-python.md)

## The idea, in Chris's words
> *"After some recent projects I have seen, I was thinking that this library can be or is similar to an MCP
> server. If so, the AI inference can figure out instructions which are then fed to the MCP to process, this
> way Cyborg DJ focuses on controlling the task at hand while the code does the busywork. I was thinking this
> was similar to the Zelda controller and the decompiler projects we reviewed recently."*

Asked whether CyborgDJ becomes the agent (holding the set, calling dj-score and render tools) or stays the
renderer: *"closer to 1."* On speed: *"Zelda was real-time so the need for speed was apparent there.. since
CyborgDJ's output is a wav file, I am not sure we need complete speed, but we still have not solved the 'tuning
knob' problem, so there might be a time and place for that."* On the interface: *"Zelda had to poke lua, REA was
tools driven by inference, so this seemed like the same pattern."*

## Why dj-score is already most of an MCP server
- The constitution makes the CLI thin: parse, call one service, print. An MCP entry point is the same with a
  different surface (a tool call in, one service, JSON out). It would sit beside `cli` in the top layer, with
  an optional dependency and no domain changes; import-linter keeps analysis out of it.
- The tool list is the service list built in migration steps 4–5: `analyze_track`, `analyze_key`, `analyze_events`,
  `compare_spectra`, `align_pair`, `analyze_timeline`, `export_to_rekordbox`, `inspect_stems`. The results are
  dataclasses that `domain/codec` turns into JSON.
- **The gap:** tools have to be cheap to call repeatedly, and analysis takes minutes per track. The CLI (like
  camelot's) recomputes from audio. An MCP needs **cache-first** analysis (use the project cache, compute only
  if missing), which makes the cache the controller's RAM, as the Zelda bot read state from RAM.
- **The model cannot hear.** The Claude API has no audio input (verified 2026-09-14,
  [eyes and ears](./eyes-and-ears-for-llms.md)), so its "ears" are dj-score's analysis, as text and plots.

## Two placements of inference, from the two references
The Zelda run had **two interfaces**: the agent wrote Python at *authoring* time, and that Python drove the
emulator through a four-verb Lua socket at *run* time. Inference never touched a frame. REA is the other
placement: inference calls MCP tools over Ghidra at run time, question by question. CyborgDJ needs both:

| Loop | Speed needed | In the loop | Interface |
|---|---|---|---|
| **Plan the set** (order, keys, overlap bars) | minutes is fine | inference | MCP over dj-score, from the cache (REA-style) |
| **Render** the spec to a WAV | seconds to minutes | CyborgDJ engine | an MCP verb: render(spec) |
| **Verify** the render | seconds | dj-score on the output | an MCP verb: measure the WAV (beat alignment, bass handoff, collision): the Zelda replay check |
| **Tune a knob** (crossover Hz, EQ curve) | fast per trial | a deterministic sweep; Chris judges | **Zelda-style**: inference configures the sweep once; code turns the knob |

Turning a knob one tool call at a time would put inference in an inner loop, which is slow and costly. This is the
REA teardown rule again: *"only use tokens when we need inference."* The Zelda analogue is **segment search
from a bookmark**: 60–90 seeded attempts, each scored to one number, best kept. For the DJ case: from cached
analysis and pre-stretched audio, render an ~8-bar window per candidate (the
[calibration](./dj-crossover-calibration.md) design's window), score each by measurement, and loop the best
few for Chris's ear. Inference picks what to sweep and reads the results. The human holds the criteria, as the
Zelda owner did (he wrote no code and supplied every big correction).

## Two Zelda lessons that apply to the knob loop
- **Calibrate the instrument on a known answer before believing its "no."** There is one: for the February pair,
  300 Hz leaked bass into the mids and 450 Hz fixed it ([EQ blending results](./dj-eq-blending.md)). A crossover
  scorer that does not rank 450 above 300 on that pair is broken, whatever it reports elsewhere.
- **Search hides bugs.** If the scorer is wrong, the sweep routes around the error instead of exposing it (the
  bot "learned" flank attacks don't work because its sword went sideways). The calibration design already logs
  every trial as a labelled A/B pair, so the scorer can be checked against Chris's choices.

## Limits
- MCP is request/response. The knob loop needs a **playback surface for the human**, and camelot's UI already
  has one (pygame playback, markers).
- *Corrected 2026-10-22:* the renderer's MP3 decode (ffmpeg) and time-stretch (rubberband) both run on the work
  machine. Application Control blocks only `ffprobe`, which Demucs needs, so stem separation runs elsewhere.

## What this changes next
The CyborgDJ audit (before [migration](../projects/dj-score/README.md) step 7) sorts each script by the loop it
serves: planning, measuring and verifying go to dj-score tools; rendering stays in CyborgDJ as tool verbs; the
`analyze_btb_*` experiments are likely early knob-tuning attempts and evidence for what the sweep should score.
`cyborgdj/loader.py`'s own downbeat detector belongs with step 6 (the grid swap).

## Open Questions
- Is MCP needed, or does a CLI with JSON output suffice for Claude Code? MCP adds typed schemas, discoverable
  tools and use outside a shell (claude.ai, desktop), but REA's author found a plain Ghidra MCP did about as well
  as his harness: the server is packaging, the substrate is the value.
- What does the knob sweep score? H1 says the crossover is derivable from stems; H2 says the perceptual tolerance is coarse
  ([calibration](./dj-crossover-calibration.md)). The scorer is whichever survives the 300/450 check.
- Which renders count as verified, and against what threshold (beat offset in ms, bass overlap in dB)?

## Tags
[music](../tags/music.md), [agents](../tags/agents.md), [claude](../tags/claude.md), [ai](../tags/ai.md)

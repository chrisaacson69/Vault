---
status: active
created: 2026-05-14
---
# Chapter 13 — The Turn Loop and the Harvest: What a Round Looks Like

> Chapter 11 mapped the player's 21 verbs; chapter 12 mapped the AI's decision engine. What was missing was the *loop* that drives both — the per-round backbone that hands the turn from player to AI, processes every fief, fires the season's harvest, and comes back to the player. A Mesen `$EB7A` call-graph trace across a full turn boundary (a fall turn, two wars) makes that backbone visible. This chapter walks the trace and shows the five-phase shape of a round, the per-fief AI pipeline (correcting chapter 12), the harvest's signature, and where the exact top-level loop sub still hides.

**Links:** [Chapter 12 — Daimyo AI](./12-daimyo-ai.md) · [Chapter 11 — The Strategic Engine](./11-strategic-engine-complete.md) · [Nobunaga README](./README.md)

## What the trace shows

14 985 `$EB7A` events across frames 29 731 – 33 321 (≈ 3 590 frames, one full turn boundary). Stripping the idle cursor loop, the events fall into a clean five-phase shape:

| Phase | Frames | What's happening |
|---|---|---|
| 1. End of previous player turn | 29 700 – 30 000 | UI render, message dismissal |
| 2. **AI turns** | 30 300 – 31 000 | the per-fief AI pipeline, ~16 iterations |
| 3. *Hit any key* pause | 31 200 – 31 600 | `$801D`/`$8003`/`$CA03`/`$CBB1` polling loop |
| 4. **Harvest / season change** | 31 700 – 32 100 | the `$E03C` cluster driving `$D70D` math |
| 5. *Hit any key* pause + new player turn | 32 200 – 33 321 | second pause, then `$B79B` fires at Fr 33 101 |

Two wars are folded into phase 2 — one of those 16 AI iterations included combat (the `$87D8` Dam effect handler fires 22 times — more than any other effect — suggesting some of those AI fiefs went to war and the war path reuses that handler). Combat's full path is the next chapter arc.

## Phase 2 — the AI per-fief pipeline (corrects chapter 12)

Each AI-fief iteration is a fixed sequence. Reading two consecutive iterations side by side (Fr 30 839 and Fr 30 868) shows the same call shape every time:

```
$CC54                                 ; close the previous render
$B875  -> $B64B  -> $CA52/$CA46       ; first stage; develop-dispatcher; roll
$B4D5  -> $949A -> $D972/$DAD7/$DAAB  ; second stage; bank-0 helpers
$D98D ×many / $DD3A / $D9B7 / $D77E   ; predicate scans
$93B3 / $939D / $9382 / $D6DE  (loop) ; per-target scoring (4 iterations)
$CA52/$CA46  $945D                    ; another roll, dispatch
$B2EF / $B2B2 / $CB94 / $DB12         ; pipeline tail handlers
$B338 / $B32B                         ; more decision branches
$8357 / $CB5E / $8303 / $8A4E         ; military/economic helpers
$D134 / $CFFC / $CA65 / ...           ; status redraw
$CC7B / $B2EF / $CB5E / $8BE5 / ...   ; another helper invocation
$B42B  -> $B2B2 / $CB94 / $DB12       ; develop executor
   $87D8 / $CBCD / $87D8 / $CBCD      ; effects: Dam, sqrt, Dam, sqrt
   $887D / $D972 / $82AC / $CB5E      ; Dam2
   $87F0 / $D836                      ; Grow
$D7DA / $D7CD / $D815 / $D7F7         ; UI updates after the action
$8C68 / $D98D / $CA52/$CA46 ×many     ; post-action rolls (RNG bursts)
$D972 / $D628 / $D98D / $D982         ; predicate cleanups
$CC7B / $D134 / ...                   ; re-render for the next fief
```

The crucial correction to chapter 12: **`$B875`, `$B64B`, `$B4D5`, `$B3AA`, `$B42B` are *stages of a pipeline*, not alternatives.** Each fires roughly 16 times — once per AI fief — and they run in the same order every time. The `$B94C` 6-way switch (chapter 12) lives *inside* `$B64B`, where it picks among the Dam/Grow/Build sub-actions; that part of chapter 12 is right, just one level down. The cascade-of-coin-flips model is *more* right under this correction: each pipeline stage has its own `$CA52` roll deciding "should I do this at all" — so an AI fief that doesn't need development simply rolls 0 at every stage and the fief produces nothing.

Three observations the corrected model makes obvious:

1. **`$CA52`/`$CA46` fire 555 times each over the round** — a 1:1 lockstep, which is consistent with `$CA52`'s body (one guard, then one RNG call). 555 ÷ 16 fiefs ≈ 35 rolls per fief — a *lot* of dice, which fits a "many stages, each independently gated" pipeline rather than a single decision.
2. **`$87D8` (Dam effect) fires 22 times** versus `$87F0` (Grow) and `$887D` (Dam2) at 12 and 11 — the develop dispatcher leans on Dam. Whether that's per-fief bias or one fief getting Dam'd repeatedly is a trace-by-frame question.
3. **`$B8A0`, the "Turn %2d Fief %2d" sub, never fires.** Chapter 12 called it the AI per-fief turn handler. It isn't. It's a different context — likely combat or scenario start — and the real pipeline entry is reached indirectly (a native loop or a deep indirect call, see "what's still open" below).

## Phase 4 — the harvest

Burst 2 (Fr 31 700 – 32 100) carries a different signature from the AI pipeline: heavy `$D70D` (the percentage operator), with three new subs at the head — **`$E03C`, `$DF73`, `$DA24`** — plus the familiar `$D6DE` helper. That math-heavy fingerprint, in the slot between AI turns and the next player turn, is the **harvest / season change**. (Bank 2 `$9E73`, the candidate I'd identified from chapter 8's "value + income, clamped at 9999" code, doesn't fire here — that sub is something economy-adjacent but not the seasonal harvest. The real harvest lives in bank 15 at the `$E03C` cluster.)

What the harvest *does* — apply per-fief income on a percentage curve, clamp at 9999 — is the same shape as the develop commands' tails (chapter 8, chapter 10), just driven over every fief in one pass. The exact field updates (which stats accumulate, which decay) are an effect-formula appendix item once the `$E03C` body is walked.

## Phase 5 — the player turn entry

Frame 33 101 fires `$B79B` — the player command-dispatch from chapter 11 (the *"your orders?"* prompt → `$B9B2` indirect call). The lead-in is identical to the AI pipeline's: a status render (`$CC7B`/`$D134`/`$CFFC`/`$CA65`/`$CB30`/`$CB11`/`$CEC4`), then `$CC54` closing the render, then **`$B79B`** fires and immediately calls `$85A7` and starts iterating through `$83D5`/`$83A2` (the per-fief sub-renderers chapter 11 already noted inside `$B79B`'s loop). So the *same* render preamble (`$CC54`-terminated status display) precedes both an AI-fief iteration and the start of the player turn — the loop calls one handler or the other based on who owns the current fief.

That symmetry is the structural hint about the top-level loop: **it iterates "the next fief to process" and dispatches player-handler-or-AI-pipeline based on ownership** — same render preamble, different action sub.

## What's still open

- **The exact top-level loop sub.** The per-fief iteration boundaries are visible in the trace (every iteration begins with the `$CC54` close + status render), but the *containing* sub is reached indirectly and doesn't surface as a `$EB7A` target. Almost certainly a native loop in bank 15 (consistent with no bytecode-stub hits) that walks the `$6F0B` turn-order permutation, looks up each daimyo's fiefs, and indirect-calls the right handler. The right cut for this is a *short* exec-breakpoint trace at `$E867` (`vm_dispatch`) across one iteration boundary — that exposes the bytecode PC stream so the indirect-call site is visible.
- **The two wars' call path.** The wars are folded into phase 2 — `$87D8` firing more than its siblings (22 vs 12, 11) is the tell. Walking the AI war path is the natural opener for the combat-resolution chapter arc.
- **The harvest body.** `$E03C` / `$DF73` / `$DA24` are named here; their bytecode disassembly is the next short walk — and it's where the per-stat income/decay numbers live.
- **Difficulty config writer.** Still not found. The config block at `$6D5F–$6D65` (`01 01 02 32`) feeds the AI thresholds, so the difficulty selector writes there at game start — a focused search at boot is the path.
- **Leader characteristics in command effects.** Grow's effect didn't read the daimyo record; War's probably does. Walking War's effect is a quick test.

## Method note — when the trace beats the static walk

This chapter is the first one where a Mesen capture *corrected* a static reading (the chapter-12 pipeline-vs-switch error) rather than just confirming one. The pattern is general: when dispatch goes through computed indirection — table-index times stride plus base, all in one bytecode subroutine — *no* literal address appears in the ROM for the called handler, and reference-search is blind. A trace of the indirect-jmp trampoline (`$EB7A`) makes the call graph visible directly. It is the right tool for "this code is reached, but nothing names it." Combined with the static walk (for *content*), it is the project's full toolkit.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

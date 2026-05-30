---
status: active
created: 2026-05-29
---
# Transpilation as a Grounding Strategy
> The LLM grounding problem is a gradient, not a switch: a model is fluent in C/Python, weak in 6502, barely there in a bespoke VM, poor in COBOL. The fix for a weakly-grounded formal language isn't "reason harder in it" — it's a deterministic transpiler to a strongly-grounded one. Meet the LLM in a language it already knows.

**Links:** [The LLM Grounding Problem](./llm-grounding-problem.md), [AI History — A Personal Arc](./ai-history-personal.md), [Principled LLM Code](./principled-llm-code.md), [Planner-LM Composites](./planner-lm-composites.md), [Game Annotation Series](../projects/game-annotation/README.md), [Nobunaga's Ambition](../projects/game-annotation/nobunaga/README.md)

## The claim

LLM grounding across **formal languages** is differential — a function of corpus frequency. The same model is:
- **deeply grounded** in C, Python, JS (huge training corpus),
- **weakly grounded** in 6502 assembly,
- **barely grounded** in a bespoke bytecode VM (Nobunaga's Sea-16 interpreter — *two* web resources exist; SCUMM is far better documented),
- **poorly grounded** in COBOL (corpus exists, but old, small, idiosyncratic).

The standard grounding framing ([[llm-grounding-problem]]) treats grounding as something a model has or lacks. For formal languages it's a **gradient over the training distribution** — and that makes it *solvable per-language*, not by universal fluency but by translation.

## The move: deterministic transpile to a grounded target

When the LLM hits a weakly-grounded formal language, don't make it reason *in* that language. Build a **deterministic transpiler** to a grounded one, and let the LLM reason in its native tongue.

This is the cleanest rung of the grounding hierarchy. The [[feedback_llm_grounding_layers]] Layer-2 pattern was *non-language signal → learned translator (FFT/CLIP/ASR) → NL → LLM* — but learned translators are **lossy**. Formal languages are special: **the translator is a compiler — exact, deterministic, verifiable.** 6502 → C loses nothing recoverable. So this is the most *reliable* form of the translator pattern: it converts an intractable task (reason in bytecode) into a tractable, checkable one (verify the transpiler + reason in the output). The hard work moves to where it's groundable.

It's also the [[planner-lm-composites]] / tools-and-pointers shape: the deterministic tool (transpiler) does the precise work; the LLM does the fluent reasoning. `vm_decompile.py` IS the thesis in one tool.

## The proof-of-concept: the game-annotation curriculum

The [Game Annotation Series](../projects/game-annotation/README.md) walked a curriculum that built to this without planning to:

| Stage | Game | What it taught |
|---|---|---|
| Learn the foreign language | **Adventure (2600)** | 6502 from a well-annotated teaching text |
| Apply it with references | **Mappy (NES)** | read NES 6502 with PPU/APU/memory-map docs |
| Hit a language *hosting* a language | **Nobunaga (NES)** | the 6502 is mostly a state machine running a **bytecode VM** — a "perfect C interpreter." Hand-tracing failed years ago precisely because the VM layer was invisible. |
| Build the bridge | **Nobunaga** | `vm_decompile.py`: bytecode → **C**. Translate the unfamiliar into the familiar instead of learning the unfamiliar by hand. |

**NA is a *harder* proof than COBOL** — near-zero documentation, a bespoke undocumented VM. If transpile-to-grounded carries that, it carries better-documented legacy languages comfortably. (The M.U.L.E.-vs-NA lesson: when there's no external annotation, the method has to carry its own weight — and here it did.)

## The application: COBOL and legacy modernization

"LLMs struggle with COBOL" is the same problem with a bigger price tag — banks, insurance, government run trillions of dollars on COBOL with a shrinking pool of COBOL programmers. The naive approach (ask the LLM to understand/rewrite COBOL directly) fights the grounding gradient. The NA-derived approach: **transpile COBOL deterministically to a grounded intermediate (readable C / Python / typed pseudocode), then let the LLM reason, document, and modernize from there.** Grounding-by-translation, not fluency.

This is the career-relevant payoff: a hobby RE project de-risks a marketable capability on a harder target than the real one.

## Caveats (so it isn't magic)

- The transpile is only as good as the decompiler's **correctness** — garbage transpiler, garbage grounding. (Verify it: [[feedback_documented_vs_actual_behavior]].)
- **Data interleaved with code** is the real blocker (the NA whole-picture problem) — entry-point-driven decode handles most; ambiguous regions must be marked, not guessed.
- Idioms and intent can be lost in translation; the output is *readable*, not *annotated*. The LLM still has to reason — it's just reasoning in a language it knows.
- Spend the effort where the [[feedback_binding_constraint_depth]] pays: transpile when the source language is the binding constraint on understanding, not reflexively.

## The full circle

Chris's languages ran BASIC → COBOL → … → 6502/VM. The lesson the curriculum produced: the scalable answer to "the LLM doesn't know language X" is **not** to teach it X, and not to hand-trace X yourself — it's to **build the deterministic bridge from X to a language it already knows.** The grounding problem, for formal languages, is solved one transpiler at a time.

## Tags

[ai](../tags/ai.md), [grounding](../tags/grounding.md), [llm-limitations](../tags/llm-limitations.md), [reverse-engineering](../tags/reverse-engineering.md), [software-engineering](../tags/software-engineering.md)

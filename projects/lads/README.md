---
status: active
created: 2026-07-21
---
# LADS — byte-exact reconstruction

> A reconstruction of **LADS**, the memory-resident 6502 assembler from Richard Mansfield's
> *The Second Book of Machine Language* (COMPUTE! Publications, 1984) — rebuilt from the book's printed
> source listings and **verified byte-for-byte against the book's own published object code**.

**Links:** project SDK → [projects/CLAUDE.md](../CLAUDE.md) ·
[Game Annotation](../game-annotation/README.md) *(sibling method, deliberately separate — see below)* ·
[Transpilation as a Grounding Strategy](../../research/transpilation-as-grounding.md) ·
[Repairing LLM Code — The Two Oracles](../../research/repairing-llm-code.md)

## Identity

| Field | Value |
|-------|-------|
| Logical name | `lads-2bml` |
| GitHub | `github.com/chrisaacson69/lads-2bml` *(public)* |
| Sibling path | `../lads-2bml` (resolved per-machine via `.claude/local-paths.md`) |
| Entry point | `README.md` → `tools/materialize.sh` |
| Targets | C64 / VIC / PET (rebuilt from source) · Atari / Apple (object images) |

⚠️ **Not cloned on this machine** (2026-07-21). Pushed **2026-07-18** — *newer than the vault tip*.

## Why it is NOT game annotation

The annotation and decompiler work runs **bytes → meaning**: no source exists, so the deliverable is
an interpretation and the risk is that it is unfalsifiable. LADS runs the other direction — **source →
bytes** — because the book printed the *complete commented source* **and** (Appendix B) the *object
code*. That inverts the epistemics:

- The work is faithful transcription + assembly, not interpretation.
- The check is **exact equality**, not plausibility. Any mismatch is a *located* transcription error.
- The oracle is itself validated — the object listings carry per-line MLX checksums (all 831 pass).

So it is neither a game nor an annotation; it's a **reproducibility project** that happens to share the
6502 substrate. It earns its own node rather than a leaf under `game-annotation/`.

## Status

The **C64 build assembles to the shipped object code with 0 mismatches across all 4,986 bytes**
(`dist/c64-disk/VERIFY.txt`). Reproducible via `bash tools/materialize.sh`.

Along the way the oracle caught **~20 real defects in the archived listings** that reading would never
have surfaced — `EOR`→`FOR`, PETSCII `$1D` cursor-rights flattened to spaces, a `=`-for-`-` in the Apple
hex, and a printed dev-variant carrying the shipped original only in a comment.

## Forks within forks — one source of truth, everything else generated

LADS supported five machines × configs (disk- vs RAM-based assembly, I/O targets), all inlined into a
single printed listing. The repo keeps **one** trunk and materializes each fork:

```
src/raw_blocks/     extracted book listings          ← the trunk (C64)
src/corrections/    OCR fixes
tools/phase1_manifest.txt   module order, trims
src/forks/          machine/*.delta, config/*.delta  ← forks within forks
dist/<fork>/        lads.asm  lads.bin  lads.prg …   ← GENERATED + committed
```

Nothing is duplicated: every `dist/<fork>/` is generated from core + deltas, **so there is no drift**,
and each is verified against its oracle where one exists (C64 → Appendix B-1, Apple → B-5).

## Why it matters to the vault

This is the cleanest specimen of two standing theses:

- **Verification independence is altitude** — the published object code is a genuinely *independent,
  lower-altitude* oracle. Not a second opinion: a different artifact. Byte equality is the strongest
  form of the deterministic guard the RE pipelines approximate.
- **Drift is re-derivation** — trunk + deltas + generated `dist/` is the same discipline as a
  `mesen-labels.toml` symbol table with everything projected from it. One home per fact; the forks are
  a *function* of the trunk, never a copy of it.

## Tags
[6502](../../tags/6502.md) · [assembly](../../tags/assembly.md) · [reverse-engineering](../../tags/reverse-engineering.md)

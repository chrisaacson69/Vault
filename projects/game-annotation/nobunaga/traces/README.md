---
status: active
created: 2026-05-29
---
# traces/ — Empirical Data + Provenance System
> Memory dumps (`.dmp`) and execution traces (`.txt`) captured from the emulator. These are **empirical and NOT regenerable** — you can't reliably reproduce the exact run, so they're treated as precious. The folder is named right (they *are* traces). The historical problem wasn't storage — it was that data was captured *without provenance*, so "what is this file?" became unanswerable. The fix is the index below.

## The provenance system (use this — it's the whole point)

Every capture should be self-describing **at capture time**. Tool: [`../tools/data-index.py`](../tools/data-index.py), index file: `INDEX.tsv`.

```
py tools/data-index.py add <file> --note "what this is / what question it answers"
py tools/data-index.py scan        # list files here that have NO provenance yet (the backlog)
py tools/data-index.py show        # the index, newest first
```

- **`capture-test.py` auto-registers** every memory snap (pass `--note "..."` for context). Memory dumps are now self-documenting.
- **Mesen trace `.txt`** are created outside capture-test — register them by hand once: `data-index.py add <trace> --note "..."`.
- **Backlog:** `scan` currently reports ~147 un-contextualized legacy files. Their provenance is mostly lost — contextualize the ones you recognize, purge the rest. Don't trust an un-indexed file; an un-indexed empirical dump ≈ no data.

## What's here

| Pattern | Size | What it is | Status |
|---|---|---|---|
| `<tag>_PRE.dmp` / `<tag>_POST.dmp` | 8 KB | **Command-test memory snapshots** — the core evidence (all 17 fiefs per snap). Pre/post a command. | ✅ precious; fact-checks formulas across saves. |
| `<fief>-ppu-memory.dmp` | 16 KB | Per-fief PPU dump → input to `render-fief-from-ppu.py`. | ✅ keep. |
| `<fief>-save-ram.dmp` | 8 KB | Per-fief SRAM snapshot. | ✅ keep. |
| named milestones: `VICTORY-final-sram.dmp`, `fall-1562-*`, `battle-{start,mid,end}.dmp` | 8–16 KB | Game-state checkpoints. | ✅ keep. |
| `*.mss` / `*.sav` | varies | Mesen savestates / battery saves. | ✅ keep. |
| `<fief>-combat-init.txt[.gz]`, `fall1566-trace.txt.gz` | 136–536 MB raw | Full combat/turn **execution** traces — the code-side companion to the `.dmp` memory. Empirical, **not regenerable**. | ✅ **gzipped 2026-05-29** (lossless, ~12:1). Cold storage. |

**Memory + execution are a pair:** a `.dmp` is the machine state, the matching `.txt` trace is how it got there. Note that pairing in the `--note` when you can.

## Compression (done 2026-05-29)

The 12 large traces were gzipped (~2.9 GB → ~250 MB), zero information loss. `combat-trace-decode.py` now reads `.gz` transparently and accepts a path arg, so an archived trace is usable directly:
```
py tools/combat-trace-decode.py traces/echigo-combat-init.txt.gz
```
Other tools: `gunzip` on demand (reversible).

## Naming convention (going forward)

Make every capture self-describing so it never needs re-identifying:
```
<scenario>-<season><year>-<what>[_PRE|_POST].dmp      # scenario omitted for default 17-fief
```
Examples: `spring1567-grow_PRE.dmp`, `mikawa-hire_POST.dmp`. Disposable scratch: prefix `tmp-`. And always `data-index.py add` it (capture-test does this for you).

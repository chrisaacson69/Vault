---
status: active
created: 2026-10-11
---
# moo1-re
> Reverse engineering Master of Orion 1 (DOS v1.3) toward exact, independently cross-verified mechanics — the vault's first DOS target, run data-first.

**Logical name:** `moo1-re` · **Sibling path:** `../moo1-re`
(resolved on this machine via [`.claude/local-paths.md`](../../.claude/local-paths.md)) ·
**Remote:** https://github.com/chrisaacson69/moo1-re *(public)* · **Stack:** Python 3.11+ stdlib

**Links:** [MOO1 Opening Optimizer](../moo1-opening-optimizer/README.md) (consumer of the verified mechanics) · [Data-First RE](../../method/data-first-re.md) (method) · [zappatic RE stream](../../research/gaming/moo1/zappatic-re-stream.md) (the series it started from) · [Diplomacy cross-check](../../research/gaming/moo1/xcheck-diplomacy.md) · [Random events cross-check](../../research/gaming/moo1/xcheck-events.md) · [project SDK](../CLAUDE.md)

## Status (2026-10-11)
Scaffolded with a dual save decoder (zappatic's layout × 1oom's offsets — 41/41 on a turn-1 Steam
save) and an EXE byte-search verifier for 1oom's static tables (first hit: starting race relations in
`ORION.EXE`). Oracle roles — binary > 1oom > OSG intent; zappatic and Chris's lore as independent
checks — are in the repo's `CLAUDE.md`. Findings live in `research/gaming/moo1/`; this page is a pointer.

## Tags
[games](../../tags/games.md) · [reverse-engineering](../../tags/reverse-engineering.md) · [python](../../tags/python.md)

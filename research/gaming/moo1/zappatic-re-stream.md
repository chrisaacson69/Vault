---
status: active
created: 2026-10-11
---
# zappatic — Reverse Engineering Master of Orion (stream digest)
> A 9-VOD, ~36-hour Twitch series (Sep–Oct 2026) reverse-engineering MOO1 v1.x **data-first**: save file → live RAM → struct JSON, with Ghidra used only twice and largely abandoned. Its durable output is a published struct library (`zapdebugger-moo.json`). It yields almost no exact formulas — its value to us is the **method for a DOS target**, the **savegame/RAM layout**, and **new behavioural facts** (hard caps, diplomacy meters, random events).

**Source:** [raw/videos/moo1-re/](../../../raw/videos/moo1-re/README.md) (playlist index + local transcripts) — <https://www.youtube.com/playlist?list=PLZVzPYU15yts>
**Source:** [raw/videos/moo1-re/zappatic-site/](../../../raw/videos/moo1-re/zappatic-site/README.md) (struct/symbol JSON) — <https://zappatic.net/moo>

**Links:** [Data-First RE](../../../method/data-first-re.md) (the thesis this is a specimen of) · [MOO1 Optimal Strategy](./optimal-strategy.md) · [MOO1 Opening Optimizer](../../../projects/moo1-opening-optimizer/README.md) · [The Rosetta Stone Method](../../../method/rosetta-stone-method.md) · [The Anchor Method](../../../method/anchor-method.md)

**Three-way cross-checks (stream × OSG × 1oom):** [diplomacy](./xcheck-diplomacy.md) · [random events](./xcheck-events.md)

**Per-part notes:** [1](./zappatic-stream/part01.md) · [2](./zappatic-stream/part02.md) · [3](./zappatic-stream/part03.md) · [4](./zappatic-stream/part04.md) · [5](./zappatic-stream/part05.md) · [6](./zappatic-stream/part06.md) · [7a+7b](./zappatic-stream/part07.md) · [8](./zappatic-stream/part08.md)

## Timeline

| Part | Focus |
|---|---|
| 1 | Planet struct (0xB8 × 108) from save-name stride; ship-design struct (0x44); per-planet orbit ships (24 B) |
| 2 | Build accumulators, planet flags/enums; researched-tech lists (6 × 60 u8, count-gated); research is probabilistic |
| 3 | Diplomacy block via save before/after diffs + file splicing; mood (−100..+100), treaty enum, diplomat meters; `players[6]` absorbs "game state"; year |
| 4 | Save-file analyzer; RAM↔disk block reorderings; **Ghidra: turn logic is in STARMAP.EXE** (ORION.EXE "a loader" per stream — too strong: it holds new-game data, e.g. the race-relations table at 0x22D6A); 32-bit fields detected by paired 16-bit writes |
| 5 | Fleets en route (260 × 28 B), transports (100 × 18 B); hard caps; failed DOSBox↔Ghidra address join (manual delta 0x7DD0) |
| 6 | Game settings, 4 trailing per-planet arrays; **random-events block decoded by forcing one event at a time** |
| 7 | Spy reports (year-made + per-field highest-tech watermark); terraforming/refit not stored; "player unknown" = global game state |
| 8 | Save tail, breakthrough + info-panel queues, Guardian/win fields; Borland 1991 copyright string |

## Method worth stealing (tooling not — we won't rebuild his debugger)
- **Save first, then RAM.** Measure record stride in the save (distance between two planet names), find the same bytes live, overlay a struct of `unknownN` u16 fields, trim until record 2 aligns.
- **Canaries both ways.** Fill a save block with AA/BB/CC…, load, search RAM → where it lives and whether it's one struct (contiguous) or copied piecemeal. Reverse: poke a distinctive value in RAM, save, find it in the file.
- **One-action save diff + splice to bisect.** Save before/after a single action; copy candidate blocks from "after" into a copy of "before" to bound which bytes carry the effect.
- **Stored vs derived test.** Poke it and end the turn: if it snaps back, it's recomputed (costs, totals, labels, mood partially). Many UI numbers are derived — don't map them as state.
- **Widths from behaviour.** 0xFFFF → signed; 0x0101/0x0707 → two u8; a 32-bit write breakpoint that never fires while two 16-bit ones do → a 32-bit field.
- **Sweep enums to the crash.** Step 0,1,2… until the label goes garbage / spills into the next string table / "illegal interrupt".
- **Change one variable per test** — his recurring self-inflicted confusion; also one-shot flags get consumed by mass edits.
- **Check the other instances** of an array of structs (the spy report lived in the *target's* player record).

## The DOS-specific wall
Real-mode segment relocation means a runtime `seg:off` doesn't equal the Ghidra address of the same code/data; his symbols even drift between segments (`3813`/`6813`/`8813`) across runs. He bridged it once by byte-pattern search (delta 0x7DD0) and Ghidra's auto-analysis left the target undisassembled. He then mostly stopped using code at all. See [Data-First RE](../../../method/data-first-re.md) for what this implies for us.

## Findings new to the vault (behavioural, from his pokes)
- **Hard caps:** 260 fleets en route (all players), 100 transports. Save is fixed-size, 108 planet slots always reserved. *(1oom agrees: `enroute_num` 0..259, `transport_num` 0..99.)* Distinct from the OSG's **32,000-ship limit**, which is ships per *stack* (display cap; true limit a u16) — see [OSG capture](../../../raw/books/moo1-osg/README.md), ch.15.
- **Transports** use the attacker's armor/weapon tech **at arrival**, not at launch.
- **Diplomacy:** 4 per-relationship diplomat meters recover each turn; diplomat withdrawn when any ≤ −100 (an earlier −55 was retracted); breaking a trade treaty sets all to −300; refused tech exchange −30; tech tribute +10 on meter 4. Mood is recomputed each turn. Trade proposals step +25 BC. Two of these are **v1.3 bugs**, per 1oom `doc/list_gamediff.txt`: a money tribute doing nothing (OSG says it should work), and merely *entering* the threaten/break-treaty dialogue costing a large temporary penalty.
- **Random events:** a 411-word events block; per-event state (0 none / 1 trigger / 2 ongoing) + planet/player + progress. Comet: progress vs signed target, years-to-impact countdown; pirates: random positive progress decaying below 0; space crystal / amoeba: wait counter → move, leave after visiting ≥ 5 planets; quake damage random and not stored. Hold **Alt** on the main screen to disable events.
- **Research:** chance appears near ~90% of base cost, ~50% at 2×, ~99% at 3×; progress decays at 0% allocation; overshoot lost on completion. ⚠ These are **displayed** percentages — v1.3's tech screen shows **half the true probability** (known bug; Chris; 1oom `doc/list_gamediff.txt`). Formula: 1oom / OSG.
- **Not stored:** relocation delay (= travel time), refit progress, terraform cap (base + tech).

## Cross-checked against independent sources (2026-10-11)
- **Save length 59,036 B** — stream ✔, 1oom `SAVE_MOO13_LEN 59036` ✔; his `zapbinanalysis-moo.json` sums to **59,014** — the missing 22-byte tail is 1oom's `end`@0xE686, `winner`@0xE688, `election_held`@0xE68C. Block offsets that overlap agree exactly (names 0xE1BA, settings 0xE2D2, counts 0xE1B6/8).
- **Year:** 1oom stores `year=1` at start, displays `year + 2299` — the stream's three phrasings all reduce to this.
- **"Chat said the source exists" (Part 6 ~3:40):** chat isn't in the VOD audio, so unresolved. 1oom is the only public source-level artifact found. A regular viewer **"Darkstar"** fed him the original's skip-intro argument (`YOMAMA`, documented in 1oom `doc/usage_common.txt`) and the scrapped-ships insight; the legacy 1oom mirror is `github.com/darkstar/1oom`. Suggestive, **not established**.
- His symbol file's `crc32 0xBF0B8580` matches neither Steam v1.3 EXE (ORION `0x6237FE7B`, STARMAP `0x63B00693`); he runs the eXoDOS build. Unresolved.

## Known v1.3 bugs — read measurements through them
The stream measures the *binary*; the OSG describes *intent*; 1oom catalogues the gap (`doc/list_gamediff.txt`, `doc/list_pbxnum.txt`, `doc/pbxin_fixbugs.txt`, ~94 `WASBUG` comments in `src/`). Chris knows the lore and can arbitrate: e.g. ship stacks display-capped at 32,000 from a signed-16 wrap (1oom clamps `game_num_limit_ships = 32000`), research % displayed at half. **Before recording any stream or OSG number as a mechanic, check it against this list.**

## Open Questions
- What does `crc32` hash — file, loaded image, or a different build? Does his RAM map hold on Steam v1.3?
- Diplomacy meters vs the OSG's "diplomacy points" / relations bar (ch.11) and the event mechanics vs ch.14 — the next cross-check.
- Trade-income ramp (OSG ch.5) and the unknown "goes-negative → news, counts at 606" field (Part 8) — check 1oom.
- His remaining `unknownN` fields: 1oom's `game_save_moo13.c` names them; a field-by-field merge would close most.

## Tags
[games](../../../tags/games.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [methodology](../../../tags/methodology.md)

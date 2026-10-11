---
status: active
created: 2026-10-11
---
# zappatic MOO1 RE stream — Part 2 notes
> Per-part extraction (auto-caption transcript → structured notes). Values are **as heard**; hex is often caption-garbled — confidence marked per item. Digest: [zappatic-re-stream](../zappatic-re-stream.md).

**Source:** [part02-3tdKnTGFq2I.txt](../../../../raw/videos/moo1-re/part02-3tdKnTGFq2I.txt) — <https://www.youtube.com/watch?v=3tdKnTGFq2I>

Source: `Vault/raw/videos/moo1-re/part02-3tdKnTGFq2I.txt` (auto-captions). Numbers below are as heard;
captions garble hex, so treat any hex value as low-confidence unless marked otherwise. "unknownNN"
is the streamer's own field-index label inside his struct definitions, not a byte offset.

## Summary
- Mapped the planet's per-turn build accumulators: ship-building progress (unknown19), defense/base progress (unknown45), factory/industry progress (unknown20) [0:05:00–0:15:00].
- Identified planet fields: explored flag (59), unrest/rebellion state (87?), stargate (47), shield class (49), owner/"colonized by" (24), and two planet-modifier fields (hostile/fertile/gaia) [0:20:00–1:20:00].
- Reworked the tech-research struct: the "target" is really **base cost**, the progress fields were off by one, and he found a per-domain flag that forces or blocks the next breakthrough, plus a per-domain "count researched" field [1:20:00–2:00:00].
- Diffed savegames before and after researching Deep Space Scanner. Found the **researched-tech list**: 6 arrays × 60 uint8 tech IDs (string indexes) inside the per-player block, previously mislabelled "player ship configuration" [2:05:00–2:50:00].
- Used memory value-search to find the empire **reserve** (32-bit) and several tech-screen label values. Most of the latter are display-only [2:55:00–3:10:00].
- Gave himself tech IDs (antimatter drive, thorium cells) to test ship range and contact. Unlimited range triggers contact with all races [3:15:00–3:50:00].
- Started a `races` struct with per-opponent spy sliders, spy jobs, security slider and spy counts. Ran a symbol-overlap check to place it just before tech research [3:30:00–4:10:00].
- "Diplomat gone" turned out to be screen-only state, not saved. His write breakpoint failed to fire, which he blamed on a bug in his own tool. Unresolved at end [4:00:00–4:15:00].

## Tooling & setup
- **Own memory-viewer / editor app**: the window scales now; it lists weapons, specials and all research names, typed in off-stream [0:00:00]. Fields can be shown as checkboxes, enum drop-downs, signed/unsigned 8/16/32-bit and arrays. Arrays of enums lose the drop-down because he never implemented that [3:40:00].
- **Symbol file = JSON** [1:15:00]. It holds top-level symbols with **segment:offset**, e.g. a `planets` array typed `planet[108]` (108 planets, as heard), and `struct` definitions with ordered fields. These are applied to live emulator memory. He edits it in VS Code and hot-reloads symbols [2:55:00, 3:35:00]. He likens it to the original C/C++ `struct Planet` [1:15:00].
- **Struct-size discipline**: he keeps a fixed struct size when splitting fields (per-player block "should be 575 bytes", which turned out to be **576**) so later repeated blocks stay aligned [2:35:00–2:45:00].
- **"Find symbol overlaps" tool**: finds structs whose ranges share physical addresses. He uses it to place a new struct and to check whether a found address is already mapped [3:30:00, 4:05:00].
- **Memory value search** (Cheat-Engine style: search value, change it in game, "next search" to narrow) inside "our range for Orion" [2:55:00, 3:50:00]. Also searches for byte sequences in a segment [2:20:00].
- **Own bindiff tool** for comparing two save slots side by side [0:50:00, 2:05:00]. His **savegame editor** also writes saves. He checked its on-disk writes with a separate hex editor because it is "not tested thoroughly" [2:15:00].
- **Write breakpoints** in his debugger. They failed to fire on a 16-bit and on a byte value, which he called his own bug, to fix later [4:10:00–4:15:00].
- Compiler: he remarks "this is Borland's C++" [1:10:00]. Context unclear (it may answer a chat question). Confidence: low-med.
- The game manual, in text form and as the official MicroProse PDF (tech screen, p.31), was used to interpret UI [1:30:00–1:35:00, 3:25:00].
- **Ghidra and disassembly were not used in this session.** It was all live-memory and savegame work.
- Addresses heard (garbled, low confidence): reserve around "4244" [2:55:00]; spy slider at "423F", races struct started at segment offset "…CC" / "4230" [3:30:00–3:35:00]; diplomat-gone screen flag at "47AD"/"478AD" [4:00:00]; tech amounts around "B33435" [2:00:00].

## Method
- **Play-and-poke loop**: pick an unknown field, compare its value across planets/states, write values (often "big" or recognisable ones) through the editor, then check (a) the UI, (b) whether it persists or **resets next turn**, and (c) the effect after End Turn. If a field resets every turn, it is probably derived or recomputed (e.g. cost recalculated, labels refreshed) [0:00:00–0:30:00, 1:20:00].
- **Arithmetic confirmation**: predict the next value as old + production and check it, e.g. 342 + 106 = 448 vs observed 449 ("one off") [0:05:00–0:10:00], and 183 + 52 = 235 exact [0:10:00]. Then force it, e.g. ship progress 1580 vs cost 1590 gives a ship next turn [0:10:00].
- **Enum discovery by sweep**: write 0..N and record which values the game accepts or reverts. Shield accepts 0/5/10/15/20, not 25 [0:35:00]; unrest 0/1/3 [0:30:00]; modifier values spill into unrelated strings past the end of the table [1:15:00].
- **Bitfield vs enum test**: unrest with 5 and 15 (all low bits set) did not trigger, so it is a plain value, not a bit check [0:25:00–0:30:00].
- **Savegame diffing**: save in slot 1 just before the event (colonize, research completes) and in slot 2 just after, then bindiff [0:50:00, 2:05:00]. To isolate which changed byte matters, he **duplicates the "before" save and patches candidate bytes one at a time**, reloading each time [2:10:00–2:20:00]. He copied a whole block over to rule a region out [2:15:00].
- **Gotcha, count-gated lists**: patching an ID into an array shows nothing unless the matching "count" field is also raised, because the UI loops only N entries [2:10:00, 2:30:00].
- **Locating save data in memory**: search for a unique neighbour, such as the ship name "Polaris", instead of non-unique byte runs, then count over to the target [2:20:00]. The reverse also works: take bytes around a memory value and search for them in the save to find where it lives in the file [3:30:00].
- **Plant a recognisable value** to find a field in the save. When the planted value never appears in the save, the field is **transient UI state** [4:10:00].
- **Off-by-one recovery**: he spotted that his "progress" labels were shifted by one because an extra field sits between the per-domain values, and renumbered them [1:40:00–1:45:00].
- Dead ends: lowering ship cost does nothing because cost is recomputed each turn [0:05:00, 3:20:00]. Several planet unknowns (14, 16, 18, 21, 22, 77) showed no visible effect [0:20:00, 1:10:00–1:20:00]. Contact flags were lost because a search wasn't narrowed before a new game reset them [3:55:00].

## Findings — data structures & file formats
**Planet struct** (live `planets[108]`; also in the save, first section)
- Save planet record order as seen in diff: name (12 chars, garbage after the terminator), x, y (e.g. 144, 92), star colour (yellow=0), size (small=0), "flicker timer" counter, … [0:50:00]. *med*
- unknown19 = **ship-building progress** (accumulated production; compared to ship cost) [0:10:00]. *high*
- unknown45 = **defense/base building progress**, next to the base count [0:10:00]. *high*
- unknown20 = **industry/factory building progress** (carries the fractional factory) [0:15:00]. *med-high*
- unknown59 = **explored** boolean, meaning a ship has passed. Setting it reveals planet details [0:20:00, 1:05:00]. *high*
- unknown87 (as heard) = **unrest state** enum: 0 none, 1 unrest, 3 rebellion. Not a bitfield [0:25:00–0:30:00]. *med* (index heard once)
- unknown47 = **stargate** present, boolean 0/1 [0:30:00]. *high*
- unknown49 = **planetary shield class** enum: 0, 5, 10, 15, 20 (25 invalid). It is cleared next turn unless research or other state backs it, so another field or progress is involved [0:35:00]. *med*
- unknown24 = **owner / "colonized by"**, signed 16-bit: −1 (65535) uncolonized, 0 = player, 1..5 = opponent slots. Opponent races are random per game, so this is **not** a fixed race enum [0:55:00–1:00:00]. Setting it to 0 hands you the planet [1:00:00]. *high*
- unknown10 tracks population, possibly max-pop related. Setting current population to 0 crashed, perhaps a divide-by-zero (his guess) [1:00:00–1:05:00]. *low*
- **Two planet-modifier fields** combine into the label under the planet [1:10:00–1:15:00]. Modifier "1": 0 hostile?, 1 empty, 2 fertile, 3 gaia, 4 empty/corrupt, 5 spills into an unrelated string. The other field holds values such as hostile and Forex Tech (hostile = −1 or 0; Forex Tech is the last entry of a preceding string array) [1:15:00]. *low-med*, mapping partly muddled in speech
- Unknowns with no visible effect: 14 (2/3/4 across planets), 16 (0/1), 18, 21, 22, 77 (−1 on some planets), plus a set of six zero fields that reset every turn [0:20:00–0:45:00, 1:10:00–1:20:00]. Earlier fiddling with them may have dropped a planet's population to 1 [0:40:00].

**Per-player block** (in the save after the planets; repeated once per player, then trailing unknown data) [0:45:00–0:50:00, 2:50:00]
- Contents: 6 ship designs, new ship names, unknown data, **unlocked research arrays**, **ship counts** array. He renamed it from "player ship configuration" to player info [2:50:00]. *high*
- **Unlocked research**: 6 arrays (computers, construction, force fields, planetology, propulsion, weapons) × **60 uint8 slots**. Each entry is an index into that domain's tech-name string array. The array is authoritative: putting 45 into computers made Battle Computer Mk X selectable in ship design [2:20:00–2:45:00]. *high*
- Only the first `count` entries are valid; the rest is uninitialized garbage [2:30:00]. The game **sorts the array by ID** when a new tech completes, and next-research offers depend on the highest ID held [2:50:00]. *high*
- Block size ended at **576 bytes** (he expected 575) [2:45:00]. *med*
- Ship designs: size field values small=2, medium=15, large=100, huge=700 alongside costs 8 / 49 / 270 / "5090". This is not a cost input [0:00:00]. A design field forced back to 0, an unknown flickering field auto-corrects to 2, and unknown27 is not the engine [0:00:00, 3:15:00]. *low*
- Ship counts per design, e.g. 2 scouts + 1 colony ship [2:40:00–2:45:00]. *med*

**Tech-research struct** (memory; per player; repeated per player in the save) [1:20:00–2:00:00, 2:05:00]
- Per domain: next-research ID ("target" choice), **base cost** (the manual's term; he first called it target), **progress**, and an in-between flag (renumbered unknown56/57) [1:35:00–1:45:00]. *med-high*
- In-between flag: 0 shows %, 1 shows the bulb, 3 something lower. Setting it to 1 can force the breakthrough next turn even at 952/18000, but it sometimes **blocks** completion until cleared [1:25:00, 1:45:00–1:50:00]. *low-med*
- Starting around unknown91: **count of techs researched per domain** (e.g. computers 11, construction 3). This is the array length for the unlocked-research arrays. Setting construction to 10 shows a generic "Construction Technology" entry [1:55:00–2:00:00]. *high*
- Diff on Deep Space Scanner: computers count 1→2, base cost changed ("406" hex heard, about 1600), next target 4→10 (0x0A), progress reset to 1, a "level" 1→4, 3→5, 0x39→0x3A, 0x50→0x51 [2:05:00]. *low* for the hex
- unknown13+14 = **reserve (BC), 32-bit**, verified by exceeding 65535 [2:55:00–3:00:00]. *high*
- unknown11+12 = total-income label, 32-bit and recomputed (display only) [3:00:00]. *med*
- Display labels: unknown29 computer scan range (persists), unknown34 robot control, unknown38 propulsion ship range (label only; it does not change travel), unknown37 factory waste stored as value ×10, unknown23 terraform label, waste-reduction label just before it [3:00:00–3:10:00]. *med*
- unknown15 = **reserve slider position, range 0–200** (not 0–100) [3:10:00]. *med*
- Ordering learned from the overlap check: `races` block → tech research (starts with bytes "B0 16B", as heard) → planet orbiting ships [4:05:00]. *med*

**Races / espionage struct** (new, partial) [3:30:00–4:10:00]
- Per-opponent spy sliders (u16; first found by value search; 5 opponents) at about unknown21+ [3:35:00]. *med*
- Spy jobs enum around unknown39/40: 0 hide, 1 sabotage?, 2 espionage? (he swapped the order once) [3:40:00]. *low-med* on 1 vs 2
- unknown44 = overall security slider, 0–200 scale [3:40:00]. *med*
- unknown46 = spy count per opponent [3:45:00]. *med*
- Five suspicious values of 2, one per opponent, meaning unknown [3:50:00]. The struct ends at field 47 to avoid overlapping tech research [4:10:00].
- "Diplomat gone" flag (heard 47AD/478AD) is **UI-screen state, not saved**. A planted value never reached the save [4:10:00]. *med*

## Findings — game mechanics & formulas
- Build progress accumulates as production per turn into per-planet accumulators. A ship is produced when ship progress ≥ ship cost. Lowering cost alone does nothing because cost is recomputed from the design each turn [0:05:00–0:10:00, 3:20:00]. *high*
- Factories can build at fractional rates (0.2 per year means one every 5 turns), with the remainder carried in the industry accumulator [0:15:00]. *med*
- Population has no hidden accumulator; growth is applied straight to current population [0:15:00]. *low-med*
- Research points are global, summed from all planets and split by the slider ratios directly into each domain's progress [0:15:00–0:20:00]. *med*
- After base cost is met, completion is **probabilistic** and the % rises with overspend, but it is not simple: 1704/1280 gave 46%, about 9408/~6000 gave 34%. The % appears even slightly below base cost (base 12500: 12500→5%, 12600→6%, 11300→1%, threshold around 11261/11262) [1:25:00–1:35:00]. Formula unknown. *low*
- Progress **decays** when a domain gets 0% allocation (computers dropped about 700 from 6713) [1:45:00]. *med*
- On completion, progress resets to 1 and the overshoot is lost [1:25:00]. *med*
- Base cost is recomputed from the researched set; inserting advanced techs changed the next cost to 75 [2:50:00]. *low-med*
- Starting techs come free (e.g. nuclear missile and laser for weapons; battle scanner for computers) [1:55:00, 2:45:00]. *med*
- Ship travel range is limited to N parsecs from the nearest colony, set by fuel-cell tech (manual: reserves allow 5 parsecs; thorium cells = unlimited) [3:20:00–3:25:00]. Getting unlimited range immediately triggered contact with all races [3:30:00, 3:50:00]. *med*
- The labels on the tech screen (scan range, ship range, factory waste, terraform +N) are derived values, and editing them does not change gameplay [3:00:00–3:10:00]. *med*
- Tech IDs heard: computers 1 battle scanner, 4 deep space scanner, 10 (0x0A) Battle Computer Mk II, 45 (0x2D) Battle Computer Mk X, plus ECM Jammer Mk 5 and "advanced computer tech 8". Construction 1 reserve fuel tanks, 3 improved industrial tech 9, 10 "duroid" (duralloy) armor. Propulsion 41 thorium cells [2:25:00–2:35:00, 3:25:00]. *med* (5 was also heard as "Mark 2 battle computer", which conflicts with 10; *low*)

## Named code/data
All are field labels in his JSON symbol file, not code addresses.
- Planet: `ship building progress` (unk19), `defense building progress` (unk45), `industry building progress` (unk20), `explored` (unk59, checkbox), unrest enum (unk87?), `stargate` (unk47), shield enum `planet shield class` (unk49), `colonized by` (unk24, enum `planet colonizers`), `planet modifier 1/2` [0:10:00–1:15:00].
- Player block: `unlocked research` arrays of struct `achieved research <domain>` (u8 enum) × 60 per domain; `ship counts` [2:30:00–2:50:00].
- Tech research: base cost (renamed from target), progress per domain, "achieve <domain> next turn" flags, `amount of <domain> researched` (from unk91), `reserve` (u32, unk13+14), total income planets (u32), computer scan range (29), computer robot control (34), propulsion ship range (38), construction factory waste (37, /10), planetology terraform (23), reserve slider (15) [1:50:00–3:10:00].
- Races: `spy slider[opponent]`, `spy jobs` (enum hide/sabotage/espionage), overall security slider (44), `spy count` (46), `diplomat gone` (UI, around 47AD) [3:35:00–4:05:00].

## Open questions / unresolved
- Formula for the research completion % and the exact role of the per-domain "achieve/block" flag [1:30:00–1:50:00].
- The red dot on the tech screen; the manual does not explain it [1:30:00–1:35:00].
- Planet unknowns 14, 16, 18, 21, 22, 77 and six resetting zero fields; terraforming and shield progress fields need the matching research first [1:20:00].
- Which field actually grants a planetary shield [0:35:00–0:40:00].
- Trade, treaties, war/alliance, relation ("amiable/uneasy") and contact flags were not found [3:00:00, 3:50:00–4:00:00].
- The five values of 2 per opponent and the reverting fields after the ship counts [2:50:00–2:55:00, 3:50:00].
- Ship-design unknowns (the size→2/15/100/700 field, the auto-correcting one); why some researched engines and thorium cells don't appear in design lists [0:00:00, 3:15:00–3:30:00].
- Write breakpoint not firing, attributed to his tool; persistent diplomat state still unknown [4:15:00].
- The big block between planets and players in the save, which changes every turn [3:30:00].

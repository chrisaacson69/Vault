---
status: active
created: 2026-10-11
---
# zappatic MOO1 RE stream — Part 8 notes
> Per-part extraction (auto-caption transcript → structured notes). Values are **as heard**; hex is often caption-garbled — confidence marked per item. Digest: [zappatic-re-stream](../zappatic-re-stream.md).

**Source:** [part08-w6TFb0RZdtk.txt](../../../../raw/videos/moo1-re/part08-w6TFb0RZdtk.txt) — <https://www.youtube.com/watch?v=w6TFb0RZdtk>

Source: `raw/videos/moo1-re/part08-w6TFb0RZdtk.txt` (auto-captions; numbers as heard; "unknown N" = his placeholder field names, numbering is his, often garbled).

## Summary
- Reconciled the **game-state block on disk vs. in RAM**: the same sub-blocks exist in both but are stored in a different (partly reversed) block order on disk, and the first block is duplicated at the top of the save. Named the nebula fields (count, X[4], Y[4], icon[4]). [0:10:00]–[0:20:00]
- Located the **save-file "suffix"** (last ~11 u16 values) in RAM by planting dummy bytes in the save and hex-searching memory; split it into suffix1/suffix2. Identified a **"Guardian defeated by"** field (1000 = not-applicable magic) and a **win-condition** field that must equal 2 to fire the "returns to Orion" ending. [0:25:00]–[1:00:00], [1:35:00]
- Found and fixed an **editor bug**: ships-en-route / transports "owned by" was a *race* dropdown but indexes *players*; renamed the planet-colonizer enum to "opponents". [1:15:00]
- Decoded the **research-breakthrough queue**: a count + 15-entry arrays of (field, tech ID), plus researcher-type (0 scientist / 1 spy / 2 trooper) and planet-ID arrays. [1:30:00]–[1:50:00], [4:30:00]–[4:40:00]
- Named several **random-event trigger/planet-ID pairs** (fertile, deep mining, donation, depleted) and a one-time "player conquered Orion" flag. [2:05:00]–[2:20:00]
- Fully decoded the **info-panel ("master's notes" end-of-turn popups) queue**: 20 u8 planet IDs + 20 u8 panel types, count = N+1, last slot = revert-to planet with type 7 "no panel"; plus many one-shot master's-note booleans. [2:25:00]–[3:35:00], [3:55:00]–[4:30:00]
- Found **player home-planet IDs[6]**, **Orion planet ID**, a mysterious **news-event index** field (negative values fire GNN news strings), and the **fleet-production report** array (ships built last turn). [4:45:00]–[5:35:00], [5:50:00]
- Confirmed the binary was built with a **Borland** toolchain ("Copyright 1991 Borland International" string). [3:55:00]

## Tooling & setup
- **Own savegame editor/viewer** (same tool as web version at zappatic.net/moo): drag a save file in, see/edit named structures; structures defined in a **JSON file** with field types (u8/u16/s16/32-bit), arrays, enums (rendered as dropdowns), booleans (checkboxes), and an "indexes into" link (e.g., planet ID → planets array) that does not work for array-typed fields. [0:00:00], [1:30:00], [3:30:00], [4:00:00]
- Has a **diff view** ("new diff") for comparing save files. [0:25:00]
- Same tool has a **live RAM view** with the same struct overlays ("symbols"): he creates symbols at segment:offset (e.g. `3813:9E2E`, `3813:F326`), reloads symbols, sorted by memory address; separate struct types for "on disk" vs "RAM" variants (renamed "game settings RAM" → "game settings" since the type implies location). [0:20:00], [0:30:00], [0:40:00]
- Hex search in RAM per segment (no ASCII search; must type hex — searched `6F726C616E64` "orland"); notes he has to "go to the correct segment" (one segment is "too dense"). [0:25:00], [0:35:00], [3:55:00] (conf: med on tool name; caption says "going into GEX")
- Debugger: break into game, inspect data segment (saw E000 when broken in wrong place; 6124 mentioned); **read breakpoints** report hits to a console; **write breakpoints** on fields. [3:45:00], [3:55:00], [5:20:00]
- **Scripts/buttons** in the tool: "unlimited ship range", "max loadout scout" (huge hull, many weapons, specials, shields, 5000 HP), forcing research progress. [0:35:00], [1:25:00]
- His tool itself segfaulted once; tool also has a stale-search bug requiring reset. [0:25:00], [0:50:00]
- **Compiler identification**: "Copyright 1991 Borland International" string in the main segment (string truncated); he assumes Borland C++ but unsure (could be Borland assembler); said he may be confusing with Commander Keen memories. [3:55:00]
- Save file size is constant (~59 KB) regardless of galaxy size; 108 planet slots always reserved. [1:05:00]
- Error text when corrupting event region: "You must run ORION.EXE" (he speculates copy protection-related). [4:45:00]
- Crash message when researcher type = 3: something like "SPIES.LBX exceeds number of [entries]". [4:40:00]
- Uses GOG copy's manual (tech tree table, couldn't find it on stream). [4:05:00]
- Web editor update with today's fields to be uploaded "in the next days". [6:00:00]

## Method
- **Save-dummy-and-search**: overwrite unknown save bytes with distinctive patterns (AA.., BB.., CC.., DE/EF/F0.., 11 22 33 44), reload the save in game, hex-search RAM for the pattern to find where the block lives; contiguous hits = one struct, scattered/missing = individually-copied variables. Keep plausibly-critical values (e.g. E803 = 1000) intact to avoid crashes. [0:25:00]–[0:40:00]
- **Reverse direction**: change a value in RAM to a recognizable number (e.g. 1000 → 500 = F401; 0 → 3344), save the game, open the save in the editor and locate it. Revealed that suffix1 is stored in inverted order on disk. [0:35:00]–[0:40:00]
- **Poke-and-observe in live RAM**: change a field, trigger the relevant screen/turn, watch the UI (e.g., nebula icon changes only after map reload; panel text changes immediately). [0:15:00], [0:20:00], [3:10:00]
- **Next-turn reset test**: whether a field is reset each turn distinguishes transient triggers from persistent state. [0:30:00], [2:20:00]
- **Force conditions via editor**: give scout weapons, set orbiting ship counts per planet to spawn fleets, set ships en route count/travel speed, set research progress far above base cost to force breakthroughs, change planet type to Gaia for more RP, unlimited range to meet races. [0:45:00], [1:10:00], [1:40:00], [4:20:00]
- **Coincidence control**: started new games so a suspicious value (7 = planet "Mentor") didn't coincide with a planet ID — proved 7 is "no panel". [3:05:00]–[3:10:00]
- **Binary search on thresholds**: bisected the unknown-87 threshold to 605/606. [4:45:00]–[4:50:00]
- **Width detection**: values like 0101 / 0707 imply two u8s rather than one u16; split fields into A/B bytes. [1:10:00], [2:35:00]–[2:40:00], [3:20:00]
- **Breakpoints to check whether a field is ever read**: set a breakpoint on six -1 values; never hit on next turn → unused (at least there). [3:45:00]
- Count array lengths against neighbouring known arrays (15 research entries; 20 panel entries) to infer struct sizes; keep total sizes intact so struct overlays still map onto the file. [1:45:00], [1:50:00], [3:20:00]
- Dead ends / pitfalls: setting many fields to 1 at once marks one-shot master's notes as "already shown" so they never fire again; mass edits cause crashes/side effects ("changing too many values at the same time"). [2:25:00], [2:35:00]
- Chat input: viewer "Darkstar" pointed out the 4095 value was from scrapping 4095 ships → led to fleet-production array. [5:50:00]

## Findings — data structures & file formats
**Game state: disk vs RAM** [0:05:00]–[0:20:00]
- On-disk game state contains the same sub-blocks as RAM but in a different order: four blocks appear in reverse order on disk while each block's internal field order is preserved; the first block (starting "103 112 … 59") is duplicated at the top of the save and has no duplicate in RAM. Current year sits at a different position (end in RAM). (conf: med)
- Ships-en-route array size and ship-transports array size are in the RAM game state but on disk sit between the events block and player names. [0:15:00], [4:15:00] (conf: med)
- Nebula fields: nebula count (disk "unknown 19", value 2), nebula X positions u16[4] (disk unknown 24–27; e.g. 260, 160, 0, 0), nebula Y positions u16[4] (disk unknown 28–31; 84, 44, 0, 0), nebula icon u16[4] (RAM "unknown 74", disk unknown 20–23; image index for nebula shape, 0 = unused, unsigned). Max 4 nebulae. In RAM, Y and X arrays come before count; on disk count first. [0:10:00]–[0:20:00] (conf: high for X/Y/icon/count; med for exact unknown numbers)
- Also "4500 0" values near nebula fields, possibly nebula-related, unnamed. [0:10:00] (conf: low)
- Game settings: two unknowns with values 12 and 9; changing 9→500 not reset on next turn, no visible effect. [0:20:00]–[0:25:00] (conf: low)
- After game settings: map flags; per-planet arrays [108] of population, bases, factory counts; then "last configured ship" (ship-design screen remembers your last unbuilt design). [0:25:00] (conf: high)

**Save suffix (end of file)** [0:25:00]–[0:45:00]
- ~11 u16 values after the last-configured-ship block (ends "…3"/"030"). Includes E803 (=1000).
- suffix2: 7 u16 values found contiguous in RAM at seg 3813 offset heard "9 E2 E2" (likely 9E2E). Reset to zero on next turn. (conf: med on address)
- suffix1: RAM at 3813:F326, 3 values, stored in inverted order on disk; one more value adjacent on disk not found in RAM. (conf: med)
- A few other suffix values (the A/B/CC positions) are individual variables copied from scattered RAM locations; not located. (conf: med)
- **Guardian defeated by** (u16, enum opponents; 1000 = magic "unassigned"; changing it from 1000 fires the "Guardian of Orion has been defeated by …" news, 0 = player, then resets to 1000; set to 0 by actually killing the Guardian). [0:40:00]–[0:55:00], [1:30:00], [1:35:00] (conf: high)
- **"Bigger win condition"** field: value 2 triggers the "returns to Orion" victory ending; 1 semi-crashes; 3 does nothing. Winner name shown is always the player regardless of the adjacent value. [0:50:00]–[1:00:00] (conf: med)

**Ships en route / transports** [1:00:00]–[1:20:00]
- Owned-by indexes players (opponents enum, -1 = unassigned), not races — editor bug fixed. Fields: X, Y, target planet ID, travel speed, ship count(s), 3 unknowns. Travel speed may be a u8 (observed 0101 / 1025 when misaligned, actually mis-read). [1:05:00]–[1:15:00] (conf: high on owner; low on travel-speed width)
- Per-planet orbiting ship counts live in the player struct and can be edited to spawn ships. [1:10:00] (conf: high)
- Ship design is copied into a separate combat structure during combat (edits mid-combat don't apply). [2:50:00]–[2:55:00] (conf: med)

**Research breakthrough queue (events area)** [1:30:00]–[2:05:00], [4:25:00]–[4:40:00]
- Count field (formerly thought a checkbox) = number of pending breakthrough screens; Guardian gave 3–4. (conf: high)
- Array[15] research field + array[15] tech ID (index within that field's enum); multiple breakthroughs in the same field per turn allowed. (conf: high on structure, med on 15)
- Array[15] researcher type: enum 0 default scientist, 1 spy (stolen tech), 2 trooper (ruins / Orion "troopers landing"); 3 crashes (spies LBX). (conf: high)
- Array[15] research planet ID (planet shown for spy/trooper; regular research holds home planet e.g. 85 but unused in text). (conf: high)
- Neighbouring values: 2s set by Guardian event, -1000 values, and a 16 value persisting; hypothesis "highest ID achieved in field for suggestions" doubted. (conf: low)

**Random events (events block)** [2:05:00]–[2:20:00]
- Fertile trigger (unknown 70, bool) + fertile planet ID (71); deep mining trigger (72) + planet ID; donation trigger + donation recipient (u16, opponents; 500 BC observed both times — maybe fixed); depleted trigger (76) + planet ID. Triggers are transient (cleared, news shown); planet-ID slots not cleaned after. (conf: high on meaning, med on unknown numbers)
- Player conquered Orion (unknown 78): one-time persistent boolean. [2:15:00] (conf: high)
- After these: unidentified values (40, 30, 30, 13, 7, -1…); poking them changes nothing. [2:20:00], [5:35:00]–[5:40:00] (conf: n/a)

**Info panels / master's notes** [2:25:00]–[3:35:00]
- "Info panel click countdown" (unknown 380): N+1 where N = panels queued; decremented per click. (conf: high)
- Info panel planet IDs u8[20] and info panel types u8[20] (enum: 0 max factories, 1 max population, 2 terraformed, 3 stargate, 4 planetary shield, 7 no panel; 5/6 show nothing). Queue shifts up as each is shown; game appends the start-of-turn selected planet with type 7 as the final entry → reverting selection. [2:40:00]–[3:35:00], [3:45:00] (conf: high)
- Master's-note one-shot booleans (u8 halves of former u16s): 37A/370A? "help at turn one" (shown only if current year == first year and flag clear) [3:35:00]; 370B substantial population/start missile bases [2:35:00]; 371A contacted other race [2:50:00]; 372A must not fall behind in tech [2:50:00]; 372B upgrade ships after new weapon [3:50:00]; 374 reduce waste [2:45:00]; 374B new engine type [4:10:00]; 375 planetary shield invented [4:30:00]. Setting flag to 1 suppresses; conditions must hold to fire. (conf: high on meanings, med on IDs as heard)
- Six -1 values after the panel arrays (one straggler), not read on next turn (breakpoint). [3:35:00]–[3:45:00] (conf: med)
- Values 405/407/408 became 5 at research moments; only 5 slots before the file block ends (save stops at that 8th value, then en-route/transport array sizes). [3:55:00]–[4:20:00] (conf: low)

**Other** 
- Player home planet IDs u16[6] (unknown 81). [4:55:00]–[5:00:00] (conf: high)
- Orion planet ID (unknown 79; e.g. 105). [5:30:00] (conf: high)
- "Unknown 87" news-event related: signed u16; ≥606 increments by 1 per turn (605 doesn't), large positives stop; negative values fire GNN-style news with the "planets" icon by string index: -50 space crystal destroyed system + empire; -49 amoeba arrives; -48 amoeba destroyed ("amoeba" typo noted); -47 left galaxy; -46 destroyed system; -45 empty; ~-17 depleted; ~-12/-13 race conquered Orion; also "new leader emerged" (revolution) string; -1 empty; must be negative (FF D2 works, 00 D2 doesn't). [4:45:00]–[5:35:00] (conf: med; indices low)
- Space crystal event: X/Y (spawns at 0,0 if not set), target planet ID, target progress countdown (waits turns at planet), visited count; high visited count → leaves galaxy. Destruction not reproduced. [5:05:00]–[5:15:00] (conf: med)
- Fleet production panel: u16[6] ships built last turn per design (unknown 211), display-only. [5:50:00] (conf: high)
- Trade: total income from trade is signed (possibly 32-bit), grows over time (-7 → -6 with agreement 25); the delta variable not found. Trade cooldown field. [4:20:00] (conf: med)
- Unknowns surveyed at start: per-planet unknowns, ships en route 3 unknowns, per-opponent sets of 6, diplomat availability, spy sets of 6, spy report (highest tech ID per field + report year + 2 unknowns), ship names 12 chars, ship icon index (e.g. 120), 60 techs per field, ship totals. [0:00:00]–[0:05:00]

## Findings — game mechanics & formulas
- Max factories = max population × factories-per-colonist (2 with robotic control): 120 pop → 240, 80 → 160, 100 → 200. [2:30:00], [2:35:00] (conf: high)
- Guardian has 2000 HP (combat UI). [0:50:00] (conf: high)
- Guardian kill → news + tech awarded; can award multiple techs (3–4). [1:30:00]–[1:45:00] (conf: high)
- AI opponents never attack Orion (from a playthrough video; game can still display "X conquered Orion" news). [2:15:00], [5:30:00] (conf: low)
- Research: progress is 32-bit; base cost examples 2700, 250, 4900; screen shows 99% chance once over cost; breakthrough needs RP actually being spent; once stuck not triggering despite huge progress (unexplained). Tech choices offered in tiers of ~5; option count seemed to depend on accumulated RP. [1:40:00], [1:55:00], [2:00:00], [4:10:00]–[4:15:00] (conf: med)
- Ship maintenance cost scales with design cost: absurd design → 39,000% spending, zero production. [1:40:00] (conf: high)
- Space crystal lingers at each planet for a countdown, then moves to the next. [5:05:00] (conf: med)
- Spying steal tech shows 4 of 6 fields. [4:25:00] (conf: low)
- Many "not applicable" sentinels inconsistent: -1, 1000, -1000, 0, 7. [4:00:00] (conf: high)

## Named code/data
- `nebula_count`, `nebula_x[4]`, `nebula_y[4]`, `nebula_icon[4]` [0:10:00]–[0:20:00]
- `game_settings` (renamed from game settings RAM) [0:20:00]
- `suffix1` (RAM 3813:F326), `suffix1_ram`, `suffix2` (RAM 3813:9E2E as heard) [0:30:00], [0:40:00]
- `guardian_defeated_by` (opponents enum, 1000=unassigned) [1:35:00]
- `bigger_win_condition` (needs 2) [1:00:00]
- enum `opponents` (renamed from planet colonizers; -1 = unassigned) [1:15:00]
- `research_breakthrough_count`, `research_field[15]`, `research_breakthrough_id[15]`, `researcher_type[15]` (enum), `research_planet_id[15]` [1:35:00]–[1:50:00], [4:35:00]
- `fertile_trigger`/`fertile_planet_id`, `mining_trigger`/planet ID, `donation_trigger`/`donation_recipient`, `depleted_event`/`depleted_planet_id`, `player_conquered_orion` [2:10:00]–[2:15:00]
- `info_panel_click_countdown` (380), `info_panel_planet_id[20]`, `info_panel_type[20]` (enum) [2:25:00], [3:25:00]
- master's notes booleans: help turn one, substantial population, contacted other race, must not fall behind, upgrade ships, reduce waste, new engine type, planetary shields [2:35:00]–[4:30:00]
- `player_home_planet_id[6]`, `orion_planet_id` [5:00:00], [5:30:00]
- `fleet_production_ships[6]` [5:50:00]
- unknown 87 kept as unknown "news event related" [4:50:00], [5:35:00]
- No function names or code addresses this session.

## Open questions / unresolved
- Why on-disk game-state blocks are reordered and the first block duplicated. [0:15:00]
- Game-settings unknowns 12 and 9; suffix values reset per turn; one suffix1 value not in RAM. [0:20:00], [0:40:00]
- Audience button disabled after meeting races in one game. [0:35:00]
- Research-adjacent values (2s, -1000, 16); research not triggering despite 99%. [2:00:00], [4:15:00]
- Values 405–408 becoming 5; six -1 values; values 40/30/30/13/7; ~80-value region after research. [4:05:00], [5:40:00], [5:45:00]
- Trade-income growth delta location (on his to-do; plans to check assembly). [4:20:00]
- Red dots on research screen. [3:55:00], [5:40:00]
- Spy-screen tech availability storage. [4:25:00]
- Unknown 87 semantics and the 606 threshold; complete news-index map. [4:50:00], [5:35:00]
- Stargate message firing unexpectedly at turn 1 near fleet-production fields. [5:55:00]
- Game state in RAM changed many values late session (unexplained). [5:45:00]
- Plans: read the manual for tech-tree tables; upload editor update; next stream Saturday still MOO, then likely pivot to GTA San Andreas after hooking his debugger into PCSX2. [4:05:00], [6:00:00]

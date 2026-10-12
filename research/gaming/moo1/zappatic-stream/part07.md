---
status: active
created: 2026-10-11
---
# zappatic MOO1 RE stream — Part 7a+7b notes
> Per-part extraction (auto-caption transcript → structured notes). Values are **as heard**; hex is often caption-garbled — confidence marked per item. Digest: [zappatic-re-stream](../zappatic-re-stream.md).

**Source:** [part07a-__IjbunAiig.txt](../../../../raw/videos/moo1-re/part07a-__IjbunAiig.txt) — <https://www.youtube.com/watch?v=__IjbunAiig>

Sources: `part07a-__IjbunAiig.txt` (2:45:35), `part07b-poOnHw_wNRI.txt` (1:56:14). The stream crashed at about 7a 2:45 (his Ubuntu session died), and 7b picks up in a new game.
Hex values below are as heard in auto-captions. Where I worked out arithmetic myself, it is labelled **[derived]**.

## Summary
- Ran down a to-do list he took from a playthrough video: ship relocation delay, factory refit, terraforming, trade-agreement ramp, nebulae, and spy reports [7a 0:00:00].
- **Ship relocation delay is not stored.** It is just the travel time between the two stars, and a newly built ship spawns as a ship en route [7a 0:10:00].
- **Terraforming:** the planet has a base size and a "size with terraforming". The progress is the gap between them, so no separate counter exists [7a 0:25:00–0:30:00].
- **Factory refit (robotic controls) has no separate stored state.** Refit mode starts once factories reach the cap and seems to finish in one turn [7a 0:35:00–0:45:00].
- **Spy report:** found "spy report made in year" (unknown 298 in the target's player struct) [7a 2:00:00]. In 7b he used a DOSBox-X write breakpoint to find the six "highest research ID per category" values just before it. They had been hidden in a misaligned planet-orbiting-ships array [7b 0:30:00–0:50:00].
- **Last configured ship design** is stored as a ship-design struct at the very end of the save file. It is the design the designer screen re-opens with [7b 1:20:00–1:30:00].
- **Nebulae** live in the global block: a count, a Y-position array and an X-position array (max about 4) [7b 1:35:00–1:40:00].
- **"Player unknown" was renamed "game state".** It is a global block (current year, current planet ID, nebulae, ships-en-route/transport array sizes), and its layout differs between RAM and disk [7b 1:40:00–1:50:00].

## Tooling & setup
- **His own debugger front-end ("zap debugger")**, attached to DOSBox-X. It overlays a tree of C-like structs (JSON symbol files) on RAM and shows live values. Fields can be edited live, made signed or unsigned, typed as arrays or enums with dropdowns, or set as "indexes into" another array so that an ID expands into the struct it points at [7a 1:30:00][7b 1:45:00].
- **Two separate symbol/JSON descriptions:** one for RAM and one for the save file, because some blocks are ordered differently on disk [7a 2:30:00–2:35:00][7b 1:30:00].
- **Scripts panel:** JavaScript buttons that change symbol values. He refactored a generic `giveResearch(type, name)` helper: it looks up the "unlocked research <type>" array and the "amount of <type> researched" count, writes the ID at index = count, then increments the count. Buttons: unlimited range, research terraforming, research robotic controls [7a 0:05:00–0:20:00][7a 0:40:00].
  - Gotcha: script errors don't show in the scripts tab, only in another log. A field-name typo ("computer" vs "computers") failed silently. He wants a red error pane [7a 0:40:00].
  - Research enum IDs have gaps (no ID 6 in computers, for example), so you can't just loop over IDs [7a 0:05:00].
- **Save-file analyzer:** colour-coded known blocks (planets, ships en route, transports, players, ships & research, events, array sizes, player names, game settings, galaxy-map flags, player planet pop/base/factory arrays). Grey means zeros, hatched means unknown. Supports a 3-way diff with differing rows in red [7a 0:05:00][7a 0:50:00–1:05:00].
- **Memory search:** exact value, 8- or 16-bit, signed or unsigned, then refine by increased / decreased / unchanged. He also uses byte-sequence search [7a 1:25:00–1:30:00][7a 2:10:00].
- **"Find symbol overlaps" button:** lists symbols that map to the same address. He used it to find that "player unknown" and "game state" overlapped [7b 1:45:00].
- **DOSBox-X built-in debugger:** 16-bit memory write breakpoint/watchpoint, `bp` to set a code breakpoint, F10 step over, F11 trace into. It shows only about 10 lines of disassembly, which he finds too few. He wants to bring the disassembly into his own app [7a 2:40:00][7b 0:00:00–0:05:00].
- **Segments:** his tool maps data at segment `3813` (as heard), but the game's DS at the breakpoint was `3A8E` (heard as "3 A 8E", "3 A AE", "388E"). Offsets therefore have to be recalculated between the two [7a 2:40:00][7b 0:15:00]. Confidence: med.
- **Ghidra:** used on his other games, for example image decoding. For MOO he is mostly avoiding it because of "relocation of the addresses" trouble, so code found at runtime is hard to locate in Ghidra. In 7b he did not reopen Ghidra; he suspects it or the graphics driver caused the crash [7a 1:30:00][7a 1:40:00][7a 2:40:00][7b 0:00:00].
- **Known tool bugs:**
  - Clicking a race symbol sometimes jumps to the wrong address; a second click fixes it [7a 1:20:00].
  - The status-bar selection length was lost [7a 1:35:00].
  - The diff stops working after a structure reload [7a 2:30:00].
  - The save viewer has no search, so he uses an external hex editor [7b 0:10:00].
- **Savegame editor** at zappatic.net/moo: drop in a save, see the same structures, edit and save to any slot. He'll update it with this session's findings [7a 1:40:00][7b 1:55:00].
- Assumes a 16-bit DOS game, so he starts by laying unknown 16-bit fields over a new block. Fields are almost all 16-bit with a few 32-bit ones, so no padding issues [7a 1:40:00][7a 2:05:00].

## Method
- **Bootstrap a struct from the save file** [7a 1:35:00–1:40:00]:
  - Take a recognisable string from the start of the save (the first planet name, "Nubius").
  - Hex-search RAM for it; the whole block is identical in RAM.
  - The planet name's address is the array base; the distance to the next planet's name is the struct size.
  - Scroll the file until planet names stop, then divide the length by the size: 108 planets.
  - Fill with unknown 16-bit fields, then perturb them (set X to 50, watch the star move).
- **Perturb and observe both ways:** change a value and watch the screen, or act in the game and watch which fields change. Examples: the twinkle timer goes to 0 when a star twinkles; max pop 200 → 400 shows on screen [7a 1:30:00–1:35:00].
- **Save diffing:** save in slots 1, 2 and 3 across controlled changes (turn advance, planting a spy), open all three and diff. Pitfalls:
  - The report "age" coincided with the current year, which created false leads [7a 0:50:00–0:55:00].
  - An 8-bit value of 0x27 turned out to be half of the 16-bit value 0x2710 [7a 1:00:00].
- **Look in the right instance:** he searched only his own player (index 0) for the spy-report data. That was useless, because nobody holds a report on themselves. The value turned up in the target race's player struct [7a 1:00:00][7a 2:00:00]. Lesson he stated: check the other instances of an array of structs.
- **Hypothesis cycling on encoding:** for report age he tried raw value, N+1 and N−1 (searching 65535 for −1), all of which failed. The real encoding was "year the report was made"; age = current year − stored [7a 1:10:00–1:55:00]. The breakthrough came by accident: changing the current year changed every report age [7a 1:55:00].
- **Planted sentinel sequences:** give a race a known run of research IDs, for example construction `0x13 0x0A 0x0E` (as heard), then byte-search to see whether a snapshot copy appears after spying. One match was a coincidence in another race's propulsion array, so he lengthened the sequence until it was unique [7a 2:05:00–2:15:00]. No second copy appeared, which proved the report screen is rendered live from the race's current research arrays [7a 2:15:00].
- **Snapshot reasoning:** because research is only ever added, a report only needs a "watermark" per category, not a copy of the list. His first guess, array length, failed in memory and file searches [7a 2:20:00–2:30:00]. The answer was the highest ID per category [7b 0:30:00–0:40:00].
- **Write-watchpoint into code:** put a 16-bit write watchpoint on the known "report made in year" variable, advance a turn with a spy planted, and break in the report-writing routine. Then step with F10, read the effective addresses, and count stores: a store that runs 6 times means 6 research categories [7a 2:40:00][7b 0:05:00–0:30:00].
  - The breakpoint only fires when a spy is present, so he forced 100 spies [7b 0:00:00].
  - The write is skipped if the value hasn't changed.
- **Diagnosing an array misalignment:** values "trailing" every planet's ship counts (all zero) except the 108th, which held report data. That led him to realise each per-planet record starts with 6 unknowns, then the ship counts. The 6 leftovers after the last planet are the report fields [7b 0:40:00–0:50:00].
- **Overlap detection:** a field that updated live where it shouldn't, or two symbols sharing an address, exposed that "player unknown" was really the global game state [7a 1:15:00][7b 1:40:00–1:50:00].
- **Using in-game research text:** he sets a tech as the "currently researching" item to read its description without researching it [7a 0:30:00].
- **Dead ends:**
  - Relocation delay: not stored.
  - Refit progress: not stored.
  - Report research list stored as array length: no.
  - Report age at N±1: no.
  - Trade-agreement ramp: not investigated this session.

## Findings — data structures & file formats
- **Planet struct**
  - Contains "size with terraforming", the value shown in the UI and used for max pop [7a 0:25:00]. Confidence: high.
  - Contains a "base size" that stays at the original value [7a 0:25:00]. Confidence: high.
  - A third size-like field read 100, later 50 and 85, with no visible effect [7a 0:25:00]. Confidence: low.
  - "Unknown 25" is −1 on the home planet. Changing it changes something unidentified [7a 1:40:00]. Confidence: low.
  - Has a twinkle timer [7a 1:30:00]. Confidence: high (from an earlier stream).
  - Planet array base was read out as "6813 26 uh 2C60" (garbled); the array holds 108 planets [7a 1:35:00–1:40:00]. Confidence: address low, count high.
- **Ships & research (per player):** six arrays of 60 8-bit research IDs, one per category [7a 0:00:00]. A separate per-player "amount researched" count gives each array's live length [7a 0:15:00]. Field names are plural, e.g. "unlocked research computers" [7a 0:40:00]. The game keeps each array in ID order [7a 2:20:00]. Confidence: high.
- **Player struct**
  - **Spy report made in year** = "unknown 298", stored in the *target* race's player struct near the end. For example, player 5 at DS:CB60 with game DS 3A8E [7a 2:00:00–2:05:00][7a 2:40:00]. Confidence: high. Report age = current year − value; 0 means never reported. The player's own struct also gets values, presumably for AI spies [7b 0:40:00].
  - Two unknown 16-bit fields follow it [7b 0:45:00]. Confidence: med.
  - "Unknown 54" (player) is signed [7a 1:15:00]. Confidence: med.
- **Spy report highest research ID per category:** six 16-bit values, one per category, immediately before "made in year". Computers comes first (written at DS:CB54 with value 4 = Deep Space Scanner) [7b 0:25:00–0:30:00][7b 0:50:00–0:55:00]. Confidence: high.
  - 0 hides the category, 1 is the default. Setting computers to 3 hid ID 4; setting 5 didn't show IDs the race doesn't own.
  - **[derived]** CB54 + 6×2 = CB60, which matches the year field directly after.
  - Only one report per target, so any spy's report overwrites it. He notes this means AIs can't hold separate reports [7b 0:50:00].
- **Planet orbiting ships (per player, 108 entries + tail):** each entry is **6 unknown 16-bit values, then 6 ship counts** (one per design slot). He had previously mapped it the other way round. The 6 values after entry 108 are the spy-report IDs above [7b 0:45:00–0:50:00]. Confidence: high for the reorder.
  - The 6 leading per-planet values are reset when the orbit screen is redrawn. Slot 0 becomes 1 whenever the owner has any fleet at the planet and 0 when the fleet leaves; it is not ship-type dependent. Possibly an "any ships in orbit" flag [7b 0:55:00–1:05:00]. Confidence: low.
- **Report write routine (code):** the DOSBox-X break was on a store of DX into `[BX-79C4]` with BX=4524 → DS:CB60 (as heard) [7a 2:40:00–2:45:00]. Confidence: med.
  - **[derived]** 0x4524 − 0x79C4 wraps to 0xCB60 in 16-bit arithmetic, which resolves his "can't reproduce" confusion.
  - In the loop: `0x468 * 5 = 0x1608` (heard "multiplying 468 by 5", then AX 1608). Adding the category count (3) gives 160B, which indexes an array [7b 0:20:00–0:25:00]. **[derived]** 0x468 = 1128 is a per-player stride, unconfirmed.
  - Also "5 times 84 is 4524" (heard) [7b 0:25:00]. **[derived]** 0x4524/5 = 0xDD4, a possible player-struct stride. Low confidence; he did not state a struct size.
  - DS:C118 = player 5 "amount of computers researched" (3), preceded by "4E2 4E2" [7b 0:20:00–0:25:00]. Confidence: med.
  - DS:CB66 is touched 6 times per report and lies outside the player structs; purpose unknown [7b 0:10:00–0:25:00]. Confidence: low.
- **Game state (formerly "player unknown", also merged with the old "game state" symbol):** global, not per-player. In RAM it is 95 16-bit values, about 190 bytes. He found it should be 190 bytes, corrected from 188 by one missing 16-bit value [7b 1:45:00–1:50:00]. Confidence: med.
  - Earlier he forced it into 6 sub-structs because of a repeating "~8 values then zeros" pattern; it is now one flat array [7a 1:50:00–1:55:00].
  - **Current year:** stored as year − 2300 + 1, so stored 50 shows 2349 and stored 40 shows 2339. Indexed as unknown 80, later corrected to 81 [7a 1:10:00][7a 1:55:00][7b 1:45:00]. Confidence: high.
  - **Current planet ID** is a little above the current year (heard "97", with one 16-bit value in between). It indexes into planets [7b 1:45:00]. Confidence: med.
  - **Nebula count** (RAM unknown 78; disk "unknown 19") [7b 1:40:00]. Confidence: high.
  - **Nebula Y positions** array (starting at RAM unknown 65), then **X positions** array, about 4 entries; 4 seems to be the max [7b 1:35:00–1:40:00]. Confidence: high for existence and order, med for max = 4.
  - Ships-en-route and ship-transport array sizes sit next to the current year in RAM (RAM unknown 82, earlier wrongly marked signed) but are elsewhere on disk [7a 1:15:00][7b 1:40:00–1:45:00]. Confidence: med.
  - Unknowns 83–88 might be signed; no effect seen when edited, and they reset [7a 1:55:00]. Confidence: low.
  - **RAM vs disk layout differs.** The disk copy is roughly in reverse order, with one sub-block scrambled. The block containing the year is out of place, and a test pattern 1..7 that he wrote once in RAM appears twice in the file [7a 2:30:00–2:35:00]. Confidence: med.
- **Last configured ship design:** the final save block, starting with a 12-char ship name ("Scout", "Marauder", "Goblin"), is a full ship-design struct [7b 1:15:00–1:30:00]. Confidence: high.
  - It is what the design screen re-opens with, and it updates even if you cancel. Cost and hit points (600 → 0x0258) verified.
  - In RAM it is at 3813:9EF8 ("scout"); the tail block is about 0x46 bytes [7b 1:10:00–1:15:00].
  - About 20 trailing bytes are still unknown, then `00 E8 03` (as heard) and zeros to the end of the file. That tail was not found in memory [7b 1:25:00–1:30:00]. Confidence: low.
  - A second similar block ("Colony Ship") follows in RAM but not in the save [7b 1:15:00].
  - At first he read the name as "last suggested new ship name"; suggestions come from the per-player new-ship-names list (Goblin, Cyclops, Demon, …) and can repeat [7b 1:20:00].
- **Ship name length** is 12 characters [7b 1:15:00]. Confidence: high.
- **File trailer order (end of file):** last configured ship design, then planet factory counts, planet base counts and planet populations as flat arrays (player only), then opponent flags, then game settings [7b 1:30:00]. Confidence: med.
- **Game settings** has two unknowns (values 12 and 9) [7b 1:10:00]. Confidence: low.
- **Diplomacy fields** in the player struct, seen in passing: diplomat availability, four sets of mood values that change every turn [7a 1:20:00], trade amount proposals, 174 zero bytes of unknown [7a 1:25:00], and contact flags [7a 2:00:00]. Some fields are copied from opponents into your own struct and can't be edited; "3054" vs "3094" are copies [7a 1:25:00]. Confidence: low–med.
- **"Ships & research" unknown block:** large, never changes between saves, possibly leftover garbage memory [7a 1:05:00]. Confidence: low.

## Findings — game mechanics & formulas
- **Relocation delay** = ship travel time between the two stars, computed rather than stored. The built ship is created as a ship en route [7a 0:10:00]. Confidence: high.
- **Terraforming** raises "size with terraforming" by about 1–2 per turn toward base + tech bonus; the asterisk shows while below target [7a 0:25:00]. Confidence: high.
  - Improved Terraforming +10, then +20 … up to +100; Complete Terraforming is +120 at "2 BC per million" (in-game text) [7a 0:30:00]. Confidence: high (from game text).
  - The cap is computed from base size + research, not stored [7a 0:25:00].
- **Waste reduces max population** by the waste amount (waste 90 → −90 off size) [7a 0:35:00]. Confidence: med.
- **Robotic controls:** factories per population go 2 → 3 … (Improved Robotic Controls 3–7) [7a 0:30:00–0:45:00]. Confidence: med.
  - In-game text: the refit cost to upgrade to robotic controls 3 is half the standard factory cost [7a 0:30:00]. Confidence: high (from game text).
  - "Refit" appears only once factories reach pop × current multiplier (e.g. 600 at pop 200 with ×3) [7a 0:35:00–0:45:00]. Confidence: med.
  - Refit seemed to finish within one turn regardless of production spending; there is no separate progress variable, only factory count [7a 0:45:00]. Confidence: low–med; he found it odd.
  - Robotics base research cost noted as 1,000 [7a 0:30:00]. Confidence: low.
- **Spy reports:** they update during the turn only when you have a living spy in that race; planting the spy takes effect the next turn [7a 0:55:00][7a 1:55:00]. Confidence: high.
  - The report screen renders live from the race's current research arrays, capped at the stored highest ID per category, counting down from the highest. Only about 8–10 items fit; the lowest drop off [7a 2:15:00–2:20:00][7b 0:40:00]. Confidence: high.
- **Trade agreements** reportedly start negative and ramp up over time (from a YouTube playthrough). Not located [7a 0:00:00]. Confidence: n/a.
- **Nebulae** reportedly disable ship or planet shields inside them; he is not sure which and did not test it [7b 1:30:00]. Confidence: low.
- **Galaxy background** looked identical across two new huge galaxies, so it is probably not saved; only nebula positions are [7b 1:05:00–1:10:00]. Confidence: low–med.

## Named code/data
All addresses are as heard. RAM addresses are in the game's DS 3A8E unless noted.
- `size with terraforming`, `base size` (planet) [7a 0:25:00]
- `spy report made in year` = player "unknown 298"; player 5 at DS:CB60 [7a 2:05:00][7a 2:40:00]
- `spy report computers highest research ID` (and five siblings, one per category), the 6 values after orbiting-ships entry 108; computers at DS:CB54 for player 5 [7b 0:50:00–0:55:00]
- `planet orbiting ships`, restructured to 6 unknowns + 6 ship counts per planet [7b 0:50:00]
- Report-write instruction: `mov [bx-79C4], dx` (approximately as heard), with BX=4524 [7a 2:40:00]
- `current year` = game state unknown 80, later 81 [7a 1:55:00][7b 1:45:00]
- `current planet ID` (indexes into planets) [7b 1:45:00]
- `nebula count`, `nebula y positions[]`, `nebula x positions[]` (game state) [7b 1:35:00–1:40:00]
- `ships en route array size` / `ship transports array size` (game state RAM unknown 82 area) [7b 1:40:00–1:45:00]
- `game state` / `game state on disk` (renamed from `player unknown` / `player unknown disk`; a separate `player RAM` copy was also created) [7a 2:35:00][7b 1:50:00]
- `last configured ship design` (end of file; RAM 3813:9EF8) [7b 1:25:00–1:30:00]
- Script helpers: `giveResearch(type, name)`, buttons "unlimited range", "research terraforming", "research robotic controls" [7a 0:15:00–0:40:00]

## Open questions / unresolved
- **Trade-agreement ramp variable:** not looked at [7a 0:00:00].
- **Planet fields:** the third size-like field (100/50/85) and planet "unknown 25" (−1) [7a 0:25:00][7a 1:40:00].
- **Two unknowns after "spy report made in year"** in the player struct [7b 0:55:00].
- **DS:CB66** is touched 6 times by the report routine [7b 0:20:00].
- **Meaning of the 6 leading per-planet values in orbiting ships** (slot 0 behaves like a fleet-present flag) [7b 1:00:00–1:05:00].
- **Single report slot per target:** how do AI spies keep their own reports? [7b 0:50:00]
- **End of file:** the last ~20 bytes of the last-configured design, and the `E8 03` tail [7b 1:30:00].
- **Game-state layout:** most of game state is still unmapped. The RAM vs disk reordering is unexplained, as is why the 1..7 test pattern appears twice on disk; the disk-side game-state struct still needs filling in [7a 2:35:00][7b 1:50:00].
- **Game-state unknowns 83–88:** signed? Purpose unknown [7a 1:55:00].
- **Refit timing:** it felt instantaneous, so the mechanic may not be fully understood [7a 0:45:00].
- **Large unchanging unknown block** in ships & research [7a 1:05:00].
- **Ghidra relocation:** code found at runtime still can't be mapped into Ghidra [7a 1:40:00][7a 2:45:00].
- **Tool fixes he wants:** a script error pane, the selection length, the diff after reload, search in the save viewer, and more disassembly lines than DOSBox-X shows [various].

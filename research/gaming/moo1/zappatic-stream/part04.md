---
status: active
created: 2026-10-11
---
# zappatic MOO1 RE stream — Part 4 notes
> Per-part extraction (auto-caption transcript → structured notes). Values are **as heard**; hex is often caption-garbled — confidence marked per item. Digest: [zappatic-re-stream](../zappatic-re-stream.md).

**Source:** [part04-klMOQ5YWQuo.txt](../../../../raw/videos/moo1-re/part04-klMOQ5YWQuo.txt) — <https://www.youtube.com/watch?v=klMOQ5YWQuo>

Source: `Vault/raw/videos/moo1-re/part04-klMOQ5YWQuo.txt` (auto-captions; hex values are often garbled, so they are recorded as heard). "Unknown N" / "3047" / "306" etc. are **his struct-field symbol numbers in the analyzer**, not addresses, unless marked as an address.

## Summary
- He mapped the RAM structs from earlier streams onto the **savegame file**: planets (108), then an unknown gap, then the 6-entry player array, a small unknown, per-player ship configs, research, names, and a block that turns out to be **game state** [0:00:00]–[0:45:00].
- He found that the save is **not a straight RAM dump**. Some blocks are stored in reverse order, some padding is dropped, and fields are reordered [0:25:00][1:05:00][1:40:00][1:45:00].
- He identified the first two player fields as **race** and **banner color** and added enums for both [1:50:00]–[1:55:00].
- He fixed an off-by-one drift in the player struct: the opponent mood array has **6** entries (indexed by player ID, with self = 0), not 5 [2:15:00]–[2:20:00].
- He decoded several diplomacy arrays of 6: has-contact flags, a contact/introduction state enum, the trade proposal amount, accepted trade amounts, a trade cooldown(?), and four "diplomat availability" meters that remove the diplomat at a −100 threshold [2:25:00]–[3:40:00].
- He found that research base cost and progress are **32-bit**, written as two 16-bit writes. The flag he had earlier read as an "achieved" boolean is actually the high word [3:45:00]–[3:55:00].
- In Ghidra he found that **STARMAP.EXE, not ORION.EXE, holds the game code**. The year increment uses a direct (non-indexed) address, which shows the "array of 6" block is really a single game-state struct [1:30:00]–[1:40:00].

## Tooling & setup
- **His own file/struct analyzer** (custom app) [0:00:00][0:10:00]:
  - You drop a savegame file onto it and it colors each region (red = planets, green = unknown, and so on).
  - The file definition **imports the same struct definitions as the RAM project** rather than reimplementing them.
  - It supports arrays and enums (dropdowns), signed/unsigned and 16/32-bit fields, comments, and a "symbol overlap" button [1:20:00].
  - Missing features: search, reload button, offset display and 2D arrays [0:00:00][0:20:00][0:40:00].
  - Bug: a "show root element" node he added just before the stream shifted every offset by +1, so he rebuilt without it [0:10:00]. Parse errors are reported only in the console and also caused off-by-one display [0:10:00][0:40:00].
  - Field symbol names must be unique. He renumbered duplicates to the 300/3000 range [2:10:00].
- **Hex editor** ("GX" as heard; probably a hex editor name, garbled): used for search, length/offset calculation and manual patching of save files. He searches values in reversed byte order because of little-endian storage [0:00:00][0:40:00][1:05:00].
- **File diff tool**: used to compare two saves that differ by one action [1:10:00][1:50:00].
- **DOS debugger (his own)**:
  - Live RAM view and editing while the game runs.
  - Read and write breakpoints at **16-bit and 32-bit** width.
  - "Show code at this address" [1:25:00][1:30:00][3:45:00][3:55:00].
  - He notes the debugger's physical addresses vs. segment offsets [1:25:00].
- **Ghidra** [1:25:00]–[1:35:00]:
  - To get from the debugger to Ghidra, he searches **instruction byte patterns**, because the segment offsets/base differ between them ("base offset is a thousand", as heard) [1:30:00].
  - Byte patterns tried (as heard, low confidence):
    - `83 3E 84 CC 46 7C 17`, read as a compare word.
    - `FF 06 A4 CC`, the year increment.
    - `8B E2 43 01`.
  - **ORION.EXE did not contain the patterns. STARMAP.EXE did**, so ORION.EXE is presumed to be a loader [1:35:00] (high).
  - Ghidra's auto-analysis left the target region undisassembled, so he had to disassemble it manually [1:35:00].
- Game save details:
  - Saves are numbered slots.
  - Save names live in a separate **CONFIG.MOO** index file, not in the save itself [0:50:00].
  - He deleted a save before re-saving to rule out leftover data from a previous file [0:45:00].

## Method
- **Anchor search with planted values.** Set opponent mood sliders in RAM to 10/20/30/40/50, save, then search the file for those values (byte-swapped) to find the start of the player array [0:05:00]–[0:20:00].
- **Gap sizing.** Compute file offset of a known anchor minus the end of the previous known region, then insert an unknown filler array of that size.
  - Mistake: he sized the filler in 16-bit elements using the byte count. 9080 bytes needs 4540 u16, not 9080 [0:20:00].
  - He repeats this for each gap. For example, 0x33A bytes = 826 = 413 u16 between the research and the names [0:40:00].
- **Cross-check file against RAM.** Compare the same data in the debugger RAM view and the file view. This exposed reversed block order, missing padding and reordered fields [0:25:00]–[0:45:00][1:40:00][1:45:00].
- **Force game events to exercise fields:**
  - Patch the propulsion tech (Thorium cells / unlimited range, and set the propulsion research count to 2) to meet all races immediately [0:05:00][1:00:00].
  - Use a shorter range (10) to meet only some of them [4:05:00].
  - Use a Guardian planet to force combat [0:55:00].
- **Garbage-fill to classify regions.** Fill an unknown block with recognizable bytes (AA, BB, CC, FF...), save, and diff to see where they land.
  - A crash when one entry was overwritten told him that entry is live data, in this case the current planet ID and year [1:10:00]–[1:20:00].
  - A field that changes nothing and does not crash may be unused or UI state.
- **One-action save diffs.** Save, change one thing (selected planet, new game with a different race/color), save to another slot, and diff [1:10:00][1:45:00]–[1:55:00].
- **Breakpoint width test.** A 32-bit write breakpoint did not fire but a 16-bit one did. Breakpoints on both halves showed **two 16-bit writes**, which proves the field is 32-bit [3:45:00]–[3:55:00].
- **Read the code to decide array vs. scalar.** A write breakpoint on the year led to an `inc word [data]` instruction that uses a direct address with no index register. So the game state is not indexed per player [1:30:00]–[1:35:00].
- **Threshold probing.** Step a value (−1, −55, −100, 120...) and watch UI availability, such as the diplomat being present [3:25:00]–[3:30:00].
- **Chat assistance.** A viewer identified symbol 3056 as total research, and he confirmed it [4:05:00]–[4:10:00].
- Dead ends:
  - The ship name at the end of the file ("Starfighter"): editing it to "Comet" had no effect and the value reset on save [1:00:00]–[1:05:00].
  - The 4-value per-entry block survived several experiments without being decoded [0:45:00]–[1:00:00][4:00:00].
  - Has-contact flags reset because the master flag is stored elsewhere [2:25:00][4:05:00].

## Findings — data structures & file formats
- **Savegame top-level order** [0:00:00]–[0:45:00] (med-high):
  1. Planets ×108.
  2. Unknown gap of 9080 bytes (4540 u16).
  3. Players ×6.
  4. A small unknown: 5→6 u16. Each value is 0 or 1 except the last, which is 4; probably one per player [0:20:00]–[0:25:00].
  5. Per-player "ship configurations" ×6. Each contains ship designs, new ship names, unknown data, and unlocked research; he renamed it because it is more than ship configs [0:20:00]–[0:25:00].
  6. Unknown, 413 u16.
  7. Player names ×6.
  8. A "player unknown" block, later found to contain game state [1:20:00]–[1:40:00].
  9. Trailing data, including a ship name string [1:00:00].
- **Offsets as heard:**
  - End of planets / start of unknown ≈ file 0x4DA0 (heard "4 D A Z").
  - Player array starts at file 0x7118 [0:05:00] (med).
  - Arithmetic check (mine, not stated): 0x7118 − 9080 = 0x4DA0, which is consistent with the heard values. If planets start at file 0, that gives 184 bytes per planet (low; not stated).
- **Planet limit** is 108 [0:00:00] (high).
- **Player names**: 15 u16 per name = 30 bytes, about 15 characters [0:35:00][1:20:00] (med). In the file a run of FF bytes precedes the first name; RAM does not have it [0:25:00].
- **Name/game-state block after the names** [0:25:00]–[1:45:00]:
  - It starts at RAM 0xF396. Its entries looked 0x1E (30) bytes long, then 32 bytes [0:30:00]–[0:35:00][1:15:00]–[1:20:00].
  - It is stored in **reverse order in the file** compared with RAM (heard as "0..5 in RAM, 5..0 in file").
  - It contains the **current year** and the **currently selected planet ID**. Symbol "unknown 14" is the current planet ID [1:20:00].
  - The year increment uses a direct address, so this is a single game-state struct and not an array of 6 [1:35:00]. The earlier "array of 6" interpretation is now in doubt [1:20:00]–[1:40:00] (med-high).
  - Where RAM has 4 zero u16 (8 bytes) between two fields, the file has only 1 u16 [1:45:00] (med).
  - Overwriting the 4th "entry" crashed the game [1:15:00].
- **Save writer reorders fields.** The year and planet fields appear in the file in a different order with "a one in between" in RAM. Confirmed: "not just dumping this block of memory" [1:05:00] (high).
- **Saves contain genuine duplicate data, not stale data.** Even a pristine save (the file deleted first) contained duplicated "5492 MIT…" bytes [0:45:00] (med).
- **UI state is saved**, e.g. the planet twinkle/flicker timer [4:00:00] (med).
- **Player struct**:
  - Field 0 = **race**, field 1 = **banner color** [1:55:00] (high). Confirmed by diffing Meklar/white (8, 4) against Darlok/yellow (9, 5) and by in-game color changes [1:55:00]–[2:05:00].
  - The 3rd and 4th early fields are unknown. Observed values: 4/0/18/2 and 3/5/27/2. Possibly a picture or string index; not resolved [4:00:00].
  - One race-like field acts as a **string/display index** rather than the authoritative race [2:05:00] (med).
  - **Opponent mood slider**: s16[6], range −100..100, indexed by player ID, own slot always 0. Fixing this from 5 to 6 entries resolved the cumulative off-by-one [2:15:00]–[2:20:00] (high).
  - An array of 108 "orbiting ships" values at the end of the struct (per planet). All fields are 16-bit, so there is no alignment padding issue [2:15:00] (med).
  - The player's mood values are **copied from the other races' structs at turn end**. You must edit the other race's entry to make a change stick [2:00:00] (med).
- **Race enum**, read off the new-game screen in order [1:55:00]:
  - Confirmed: **Human = 0, Meklar = 8, Darlok = 9** (high).
  - Order as heard (garbled): "human, merchon, silicid, onari(?), clon, bull rafi, meccar, darlock", plus a forgotten one he added afterward. Middle positions are low confidence from the transcript.
- **Banner color enum**: blue 0, green 1, purple 2, red 3, white 4, yellow 5 [1:55:00] (high; white = 4 and yellow = 5 confirmed by diff).
- **Diplomacy arrays.** All are [6] indexed by player ID, self = 0 [2:25:00]–[3:10:00]:
  - **Has contact with**: bool[6] starting at "unknown 7". Setting it triggers the "you've made contact" popup, but it resets because the master flag is elsewhere. Contact can be broken [2:25:00] (med).
  - A second copy of the mood values, s16[6], the same numbers as the mood array [2:25:00] (med).
  - "Opponent-related unknown" [6] at symbols 22–27. Values clear when you exit the race interaction screen [2:30:00] (low-med).
  - **Opponent contact state** enum [6] at symbol 144 [2:35:00]–[2:45:00] (med-high):
    - 0 = no contact.
    - 1 = show introduction next turn.
    - 2 = contact made / introductions done.
    - Setting 0 or 1 re-triggers the intro scene. Patched propulsion research did not produce contact while the value was still 2.
  - **Trade amount proposal** [6]: the BC/yr suggested during an opponent interaction [2:40:00]–[2:45:00] (med).
  - **Accepted trade amount proposals** [6] at symbol 306. First guessed as "previous proposals", then renamed [2:45:00]–[2:55:00] (med).
  - The **trade agreement** (current BC) [6] was already known [2:40:00].
  - Signed [6] at symbol 119. It drops to about −30 or −255 when a trade agreement is made, then counts up each turn to a cap of 100. Hypothesis: trade agreement cooldown. Setting it to 100 did not re-enable trading [3:00:00]–[3:20:00] (low-med).
  - **Diplomat availability ×4**: four s16[6] meters [3:10:00]–[3:40:00] (med).
  - Treaties, spy jobs, spy slider and spy creation progress are all converted to [6] arrays [3:05:00]–[3:10:00] (med).
- **Research fields**:
  - Base cost and progress per field are **u32**, written as two 16-bit writes.
  - The former "achieved" bool is the high word of progress [3:50:00]–[3:55:00] (high).
  - RAM address of a 32-bit progress word, as heard: "838C"/"883C" (low).
- **Tech effect labels**: factory waste stored as 8 and displayed as 80 (×10) [3:55:00] (med). Computer scan range = 3 and robotic control = 5 are present. The ground combat bonus is not found [3:45:00][3:55:00].

## Findings — game mechanics & formulas
- **Year**: displayed year = stored value − 1 + 2300 [1:25:00] (med). It is incremented by `inc word` in the next-turn code in STARMAP.EXE [1:30:00]–[1:35:00] (high).
- **Research success chance** (med) [3:50:00]:
  - Progress around 90% of base cost: the light bulb shows full with no percentage.
  - Base 100,000 with progress 120,000: a percentage appears.
  - Base 100,000 with progress 200,000: 50%.
  - Base 100,000 with progress 300,000: 99%.
  - So roughly **3× base cost ≈ guaranteed** next turn. He also restates it as "target three times the base" [3:50:00]–[3:55:00]. Exact formula not derived.
- **Diplomat availability** [3:25:00]–[3:40:00] (med):
  - The diplomat disappears if **any** of the 4 meters is ≤ −100. He had written down −55 earlier and retracted it.
  - Observed maximum is around 120.
  - Each meter recovers each turn at its own rate.
  - Threatening war/attack hits all four.
  - Breaking a trade agreement set all four to −300.
  - Offering a tech tribute raises meter #4 (+10 per offer).
  - A money tribute changed nothing.
  - Tech exchange caused odd drops.
- **Trade proposals** step up by +25 BC: 25 → 50 → 75. Bidding up after declines is hypothesized [2:45:00][3:20:00] (low-med).
- **Tribute availability** may be a countdown counter that decrements per offer. The field was not pinned down [3:00:00][3:35:00] (low).
- **Total research** label (symbol 3056) = planet production × research slider %. Example: 44% of 63 → 27. It is a computed display value and not editable [4:10:00]–[4:15:00] (high).
- **Labels that are computed or display-only:**
  - Total income from planets: 395 [3:45:00].
  - Total income from trade (symbol 3047), shown as 12 BC with a 50 BC agreement [4:15:00] (med).
  - A "ships" value (14) that he suspects is floating point [4:15:00] (low).
- The mystery 4-value block is **not combat-related** (tested against a Guardian fight) and does not change on turns, moves or diplomacy [0:50:00]–[1:00:00] (med).
- Ship name suggestions: the file stores a name ("Starfighter"), but the suggestion appears random, and patching the name had no effect [1:00:00]–[1:05:00] (low).

## Named code/data
These are symbols in his analyzer. Addresses are as heard.
- `planets` (array of 108) and `players` (array of 6, struct renamed `player`) [0:10:00]
- `unknown two` (5→6 u16 after the players) [0:20:00]
- Ship configurations struct, renamed because it also holds unlocked research [0:20:00]
- `player names` [6] and `player unknown` [6] at RAM 0xF396 [0:35:00]–[0:40:00]
- `current planet ID` (unknown 14) and `current year`, in the game state; year increment at "CC48"/"CCA4" (garbled) [1:20:00][1:30:00]
- `race`, `banner color` and `banner color 2`, plus enums `races` and `banner colors` [1:55:00]–[2:05:00]
- `opponent mood slider` [6] [2:15:00]
- `has contact with` bool[6] (from unknown 7) [2:25:00]
- `opponent contact made` [6] with enum `opponent contact state` (symbol 144; 0 none, 1 next turn, 2 made) [2:45:00]
- `trade amount proposal` [6], `accepted trade amount proposals` [6] (symbol 306) and `trade agreement cooldown` (symbol 119, tentative) [2:45:00]–[3:15:00]
- `diplomat availability` 1–4 [3:10:00]
- `total research` = 3056 and `total income trade` = 3047 [4:10:00]–[4:15:00]
- Research `base cost` and `progress`, retyped to u32 [3:50:00]

## Open questions / unresolved
- The 9080-byte gap between the planets and the players [0:20:00].
- The 5–6 u16 after the players [0:25:00].
- The 413-u16 gap before the names [0:40:00].
- The block after the names: which entries are an array and which are game state. Also why the file is reversed, why padding is dropped, and why the 4th entry crashes [1:20:00]–[1:45:00].
- The trailing ship name string at the end of the save [1:05:00].
- Where the master "contact established" flag lives, given that has-contact flags reset and contact can break [2:25:00][4:05:00].
- Player fields 3–4 (picture/string index?) [4:00:00].
- How to trigger a trade agreement. The cooldown semantics and the reason trade stays disabled are unresolved [3:15:00]–[3:20:00][4:15:00].
- Whether the diplomat meters are summed or each is checked separately. Observations were mixed [3:40:00].
- A tribute counter field [3:00:00].
- The ground combat bonus storage. Many tech labels are not found [3:55:00]–[4:00:00].
- The "ships" floating-point label [4:15:00].
- The Ghidra pattern search on ORION.EXE failed. Only after switching to STARMAP.EXE did he find the code [1:30:00]–[1:35:00].

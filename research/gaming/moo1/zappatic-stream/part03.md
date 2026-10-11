---
status: active
created: 2026-10-11
---
# zappatic MOO1 RE stream — Part 3 notes
> Per-part extraction (auto-caption transcript → structured notes). Values are **as heard**; hex is often caption-garbled — confidence marked per item. Digest: [zappatic-re-stream](../zappatic-re-stream.md).

**Source:** [part03-RFiZCVmz3AM.txt](../../../../raw/videos/moo1-re/part03-RFiZCVmz3AM.txt) — <https://www.youtube.com/watch?v=RFiZCVmz3AM>

Source: `Vault/raw/videos/moo1-re/part03-RFiZCVmz3AM.txt` (auto-captions; hex values are often garbled. Values below are as heard, not corrected.)

## Summary
- He merged the earlier separate "races" and "tech research" symbols, which sit next to each other in RAM, into one "game state" struct. Later he found that this struct is really one part of a per-player record [0:05:00]–[0:10:00], [2:30:00]–[2:45:00].
- He found the diplomacy/"race interactions" block with savegame diffing plus live RAM pokes. It holds the mood slider (-100..+100), the treaty enum, trade-agreement BC/year and four "diplomat availability" counters. Each block is a 5-wide (or 6-wide) per-opponent array [0:35:00]–[1:40:00].
- He showed that this block repeats 6 times (one per player) and is the single big **players[6]** struct. It contains the old game-state fields and the per-planet orbiting-ship counts (108 planets x 24 bytes). No overlaps remained after the merge [1:45:00]–[2:55:00].
- File order is: planets → big unknown block → players[6] → per-player ship configurations (designs, new ship names, unlocked research) → small unmapped block → player names (6 x 15 chars) → misc tail [3:00:00].
- Galaxy size does not change the savegame size (always 59036 bytes). The game rewrites only the planets in use and leaves stale data from older saves in the rest [3:00:00]–[3:10:00].
- Poking the big unknown block after the planets corrupted on-screen strings, so the block is string/text related (not a starfield bitmap as he had guessed). It is re-initialised on each new game [3:10:00]–[3:20:00].
- In a "game state" struct he found the current year (stored as year−2300, displayed +1), the selected planet ID and the planet count. In the savegame these are byte-reordered/scattered rather than a straight RAM dump. Setting the planet count live changes how many stars exist, and a value too high crashes [3:35:00]–[4:00:00].

## Tooling & setup
- **Custom DOSBox build** ("tossbox hijacking", which is probably DOSBox) with a memory viewer/debugger UI: a symbol browser with structs/arrays, rows highlighted red when a value changes, and an overlap detector ("no duplicate physical addresses found") [0:05:00], [0:50:00], [2:30:00], [2:55:00].
- **Write watchpoints did not fire.** His hook is on the `mem_writeb_inline` path in DOSBox `paging.h`. He thinks the game writes through the "checked" write variants, which he never hooked. Fix left for later [3:20:00].
- **Symbol definitions live in a JSON file** that he edits by hand. A formatter ("printer", which is probably Prettier) complained about a missing comma after merging arrays [0:10:00]. The fields use `unknownNN` names, and he considered auto-renumbering them [0:10:00]. Fields can be U8/U16/signed and set as arrays of structs. He also keeps a JSON of game data that he searches (e.g. for "trade") [0:50:00].
- Symbols are given as **segment:offset**. Examples: segment "3813" for race interactions and player names, earlier bases "4230"/"4240"/"4237", a ship-configs segment "6813", and game state at "4750"/"4756". He linearises them by hand: `3813:A29C` (heard "3813 0 + A29C") = linear `423CC` [0:05:00], [0:35:00], [2:35:00], [2:55:00], [3:45:00]. Medium confidence (garbled digits).
- He notes the tech-research base differs from his races base "by 10x in the segment" (seg vs linear ×16 confusion) [0:05:00].
- **Hex editor** (GHex mentioned) for savegame search, plus a **side-by-side diff tool** for before/after saves [0:25:00], [2:25:00].
- **Memory value search** in his tool (all values / increased / unchanged / decreased filters). He wanted to add "increased by N" [3:20:00]–[3:25:00].
- **Feature wish**: memory "snapshot" with an old-value column, because red highlights are lost for rows off-screen [0:50:00].
- The viewer can't scroll above segment offset 0, which he wants to fix [3:45:00].
- Ghidra, the compiler and the memory model are not discussed in this part.

## Method
- **Force the game state so you can test.** He poked RAM to unlock "unlimited range" propulsion (tech 29h) and to set propulsion research count = 2, which made contact with every race on turn 1 so the diplomacy UI is usable [0:00:00], [0:20:00].
- **Savegame before/after diff around one action.** He saved to slot 3, made a non-aggression pact, then saved to slot 4. Changes appeared in an "after big block" region and in game-state tech bytes (29h = thorium cells given as tribute) [0:20:00]–[0:25:00].
- **Locate a diffed byte in RAM**: search for a distinctive byte run near it, revert the value, reload the screen and watch the UI. Many candidates had no effect. Changing one byte from 0x13 to 0 moved the mood slider [0:30:00]–[0:35:00].
- **File splicing to bisect**: he duplicated the "before" save and copied the changed block in from the "after" save. Loading it showed the pact present, which bounds the field to that block. He then reverted values one by one in RAM [0:45:00].
- **Sweep values to find enum/range**: poke 1/2/3/4/5 and read the UI label. That gave the treaty enum, and showed 5 is not valid [0:45:00]–[0:50:00]. Sliding the mood value gave its range of -100..+100 (signed) [0:35:00]–[0:40:00].
- **Threshold finding by bisection**: he set the counter to -51, -55, -57 and so on to find the cutoff where the diplomat leaves [1:30:00].
- **Watch per-turn counters**: values that change every turn (some update twice per turn) point to the diplomatic recovery counters [1:05:00].
- **Struct-size inference from repetition**: he looked for a "small block / big block of zeros" pattern repeating 6 times in the hex. Then he padded the struct with filler arrays of U16 (205, 174, 150, 1300/1276/1271 entries). He tuned the padding until a known value (the mood slider) lined up in player[1], checking with **cross-player symmetry**: A's mood toward B must equal B's toward A [1:45:00]–[2:15:00].
- **Sentinel trick for overlap search**: he wrote ABCDEF into a field so he could find where the old game-state struct begins inside the new players struct (field 145) [2:30:00].
- **Arithmetic sanity check**: 108 planets x 12 U16 = 1296 vs 1286 padded. He closed the gap, then re-verified alignment with the mood values [2:50:00].
- **Dead end**: he spent time "off" on the merged struct but was viewing the wrong array index (player 5 instead of 0) [2:40:00].
- **Dead end**: he assumed the struct was all U16. He notes some 32-bit fields exist, which would shift later fields [2:35:00]–[2:40:00].
- **Year search**: searching for 2300/2301 as U16 found nothing. Increased/unchanged filtering left about 6000, then 150 candidates. He switched to diffing two saves one turn apart and found it as a small value (year−2300) [3:20:00]–[3:35:00].
- **Verify in the savegame by editing the file**: he changed the bytes in the save and reloaded. Selected planet, year and planet count all took effect, which proves the location even where the RAM layout differs [3:40:00], [4:00:00].
- **Corruption probing**: he wrote FFs into the unknown block and looked at many screens (design, research, news). That narrowed the block to string data [3:10:00]–[3:20:00].

## Findings — data structures & file formats
- **Savegame size is fixed at 59036 bytes** whatever the galaxy size (high) [3:05:00].
- **Savegame top-level order**: planets (Vega first), then a large unknown block (string-related), then players[6], then per-player ship configurations ×6 (designs, new ship names starting "Star Fighter"/"Intruder", then about 60-byte unlocked-research sections), then a small unmapped block, then player names, then an "alphabet in caps stopping at W" plus a "Scout" design at the very end (med) [3:00:00], [2:55:00].
- **Planet records**: max 108. Only the planets in use are written, and the rest keeps garbage from an earlier save. Like Commander Keen, the game opens the existing file instead of truncating it (high) [3:00:00]–[3:05:00]. Uninitialised structs commonly hold garbage (med) [2:55:00].
- **Old "races" block = 102 bytes (66h)**: spy sliders, spy job (hiding/sabotage/espionage), overall security slider (max 200, "percentage over 200"), spy counts per opponent, then `unknown47`. Tech research follows directly after; overall security slider at offset "C8" (med) [0:05:00].
- **Old game state = 288 bytes (144 U16 fields)**, found to start at field 145 of the per-player struct (med) [2:30:00].
- **Spy creation progress**: a 5-entry array in game state ("unknown27"). It accumulates toward the next spy and the cost is subtracted when a spy is made. The spy count dropped to 0 after a big poke, possibly a signed overflow or a cost issue (med) [1:10:00], [1:20:00].
- **Players[6] struct** (segment 3813, linear around A1EE heard; low on exact address). One per player, contiguous. The first 6 bytes of player 0 are unclear (the 44 50 18 70 preamble), and player 1 starts with value "AA" (low). The fields found are:
  - **Mood slider**: 5 × S16, range -100..+100. Labels: harmony at max, 12 = relaxed, -12 = unease, 0 = neutral. Formerly "unknown15" (=opponent 1), with opponent 0 at unknown14 (high) [0:35:00]–[0:40:00].
  - **Treaty**: 5 × U16 enum at "unknown116". 0 none, 1 non-aggression pact, 2 alliance, 3 war, 4 final war, 5 invalid (high) [0:45:00]–[0:50:00].
  - **Trade agreement BC/year**: 5 × U16 at "unknown118". Any value works; the UI suggests multiples of 25 (high) [1:15:00]–[1:20:00].
  - **Four diplomacy counters** ("diplomat availability" parts): arrays starting at unknown83, 89, 104 and 110. Each is 6 wide: one stray zero (self) followed by opponents in reverse order 5,4,3,2,1 (med on the ordering). They are signed and recover each turn (some double-step). Threaten-to-attack pushed one to -220/-300, and each refused tech exchange drops one by 30. On the unknown110 set, below **-55** the diplomat is gone/no audience. The other sets also gate audiences, so it is a combination (med) [0:55:00]–[1:40:00].
  - Unknown 5-wide arrays after the trade array, e.g. values -9 and -12; possibly inter-AI relations (low) [1:40:00].
  - **Ship counts per planet**: `planet_orbiting_ships[108]`, each 12 × U16 = 24 bytes (2592 bytes). First field `ship0_count`, then counts per this player's 6 design slots plus unknowns. Example: planet 8 shows 2 of design 0 and 1 of design 5 (med–high) [2:45:00]–[2:55:00].
  - **Cross-player symmetry**: player A's slot for player B uses the same index scheme both ways ("I am the equivalent index"). The master values appear to be in the opponent's record and are copied to the player's (med) [2:05:00]–[2:15:00]. Treaty and trade values did *not* obviously mirror (open) [2:15:00]–[2:20:00].
  - Possible 32-bit fields inside game state (low) [2:35:00].
- **Planet unrest**: a planet field ("unknown86", next to unrest state) holds the unrest/rebel percentage. Sabotage "incite revolt" adds to it, the game picks the target planet at random, and at ≥100 a rebellion/new leader resets the treaty to none and trade to none (high) [1:10:00], [1:25:00].
- **Ship configurations** (segment around 6813): a separate per-player struct holding designs, new ship names and unlocked research (six tech-field arrays). It is not inside players[] (high) [0:15:00], [2:55:00]–[3:00:00].
- **Player names**: 6 × char[15] at segment 3813 offset "F33C" (heard). Example names: Dynamon/"Don", TVC 15, Saurak, Myamar, Nazgur, Sedime(?) (med; first guess of 16 was 1 too large) [2:25:00]–[2:30:00].
- **Game state struct** (segment 4750 heard, fields from offset 0; earlier located at "4756"):
  - unknown, **current/selected planet ID** (U16, index into planets), unknown, **current year** (U16, displayed year = 2300 + value + 1), then unknowns (high on year and planet; med on the address) [3:35:00]–[3:50:00].
  - The selected planet is saved [3:40:00]. In the save these fields sit near the end (after the names), byte order/position "reversed" versus RAM, and the surrounding bytes don't match RAM (med) [3:40:00]–[3:45:00].
  - **Planet count** (U16) is found the same way, just before the names in the save. Setting it to 5 or 10 changes how many stars exist; a value too high crashes (high on behavior) [3:55:00]–[4:00:00].
  - A value of 3 near it was tested as difficulty and broke the game when changed (it is not difficulty) [3:50:00].
- **Big unknown block after the planets**: it changes every turn and is re-initialised each new game. Writing FF into it corrupted on-screen strings and terminators (text in several screens, research/tech dialogs) without crashing. He first guessed starfield/nebula bitmap, which this disproves (med) [0:25:00], [3:10:00]–[3:20:00]. The starfield has parallax (several layers) [3:05:00].
- The savegame has no version number (high, his observation) [3:15:00].

## Findings — game mechanics & formulas
- Overall security slider goes to 200% max (med) [0:05:00].
- Spy production builds progress per opponent and pays the cost out when a spy is made. The "years to next spy" display follows the slider (med) [1:10:00].
- Incite-revolt sabotage: random target planet of the victim. Each success adds rebels and unrest % (the shown "N rebels / N%" match). At ≥100% it triggers rebellion and a new leader, resetting relations to neutral with no treaty and no trade (high) [1:10:00]–[1:30:00].
- Diplomacy counters recover toward positive each turn. Threats and refused deals push them down (-30 per refused tech exchange). Below about -55 on one counter the diplomat is withdrawn, and other counters can also block audiences (med) [1:00:00]–[1:40:00].
- Mood slider is recomputed each turn, so pokes partly snap back toward a computed value (med) [2:05:00]–[2:10:00].
- Non-aggression pact acceptance depends on mood; neutral races refused and the Sakkra accepted after tribute (low; anecdotal) [0:20:00].
- Foreign trade agreement was greyed out early in the game, cause unknown (low) [0:50:00].
- Giving tech sets the recipient's tech byte to the tech ID (29h = thorium cells) (med) [0:25:00].

## Named code/data
- `game_state` (old, merged and then removed) → `players[6]` (seg 3813) [2:45:00]
- `race_interactions` (seg 3813, offset heard "A1EE") → renamed `players` [0:35:00], [2:45:00]
- `mood[5]` (S16) [0:40:00]; `treaty[5]` + enum `treaties` [0:50:00]; `trade_agreements[5]` (start unknown118) [1:15:00]
- `diplomat_availability` arrays (unknown83/89/104/110), comment "< -55 = diplomat gone" [1:35:00]
- `spy_creation_progress[5]` (game-state unknown27) [1:10:00]
- `unrest_percentage` (planet unknown86) [1:25:00]
- `planet_orbiting_ships[108]` (`ship0_count` first field) [2:50:00]
- `player_ship_configurations` (seg around 6813) with `unlocked_research` lifted out of `ship_unknown` [0:15:00]
- `player_names[6][15]` (seg 3813, offset "F33C") [2:30:00]
- `game_state` (new; seg 4750): `current_planet_id`, `current_year`, plus planet count located in the save [3:50:00]–[4:00:00]
- `diplomat_gone` symbol deleted as superseded [2:55:00]
- No code (function) addresses this session.

## Open questions / unresolved
- Race/color picked at new game; difficulty; where AI–AI treaties and alliances are stored (e.g. an alliance with the Darlocks seen in a report) [0:00:00], [1:40:00], [3:50:00].
- The "contact made with race" flag [0:20:00].
- Why treaty and trade values don't mirror between players' records when mood does [2:15:00]–[2:20:00].
- The meaning of each of the 4 diplomacy counters, the stray "self" slot, and the -9/-12 arrays [1:35:00]–[1:40:00].
- The 6-byte preamble of player 0, the end-of-struct mismatch (about 15–16 bytes short of a block before the names), and possible 32-bit fields [2:00:00], [2:25:00], [2:35:00].
- What the big string-related block actually is, and why it is in the save [3:15:00].
- Why year, selected planet and planet count are reordered and scattered in the save rather than dumped from RAM, and where that RAM lives [3:45:00], [4:00:00].
- The small unmapped block and the "alphabet A–W" plus trailing "Scout" at file end [3:00:00], [2:55:00].
- Fix the write-watchpoint hook for DOSBox checked-write paths [3:20:00].
- The ship-config "SKA" items' effect [0:00:00].

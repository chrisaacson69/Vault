---
status: active
created: 2026-10-11
---
# zappatic MOO1 RE stream — Part 5 notes
> Per-part extraction (auto-caption transcript → structured notes). Values are **as heard**; hex is often caption-garbled — confidence marked per item. Digest: [zappatic-re-stream](../zappatic-re-stream.md).

**Source:** [part05-pvIsR571sr0.txt](../../../../raw/videos/moo1-re/part05-pvIsR571sr0.txt) — <https://www.youtube.com/watch?v=pvIsR571sr0>

Source: `Vault/raw/videos/moo1-re/part05-pvIsR571sr0.txt` (auto-captions; hex values often garbled, recorded as heard).

## Summary
- Re-saved a "pristine" game right after a fresh DOSBox launch to confirm that the mystery "garbage" bytes in the save are just leftover, reused memory. A fresh launch gives mostly zeros. [0:00:00]
- Found the **ships-on-route** array (fleets in flight) right after the planets in the save: owner, X/Y, target planet, travel speed and a 6-slot per-design ship count. The game caps it at **260 entries**. [0:05:00]–[2:10:00]
- Found the **ships-on-route count** in RAM (seg 4756 off 6), then in the save file next to the end of the ship-configuration block. [0:45:00]–[0:55:00]
- Tried to tie the count's write and read breakpoints to Ghidra and failed. Ghidra's load base and segments don't match DOSBox, and some code isn't disassembled. [0:55:00]–[1:50:00]
- Hit the 260 limit by pasting duplicate records into a save and checking which ones reached RAM. This showed the following block is real data, not padding. [1:50:00]–[2:15:00]
- Showed that block is the **colonist/troop transport** array (100 entries × 9 u16), and found its count right next to the fleet count. [2:15:00]–[3:50:00]
- Transports don't store armor or weapons. Ground combat uses the tech the player has when the transport arrives. [3:25:00]–[3:35:00]
- Mapped a "totally unknown" 411×u16 block in RAM. Also found a 32-bit planet field that relates to the planetary reserve or inbound transfers, but its meaning isn't settled. [3:50:00]–[4:10:00]

## Tooling & setup
- **DOSBox** (he also says "dolls box"), with his own Qt **debugger** that hooks into the emulator: memory view by segment:offset, value search ("first search" then narrowing), 16-bit read and write watchpoints, and a 10-line disassembly pane. The disassembly re-syncs when you scroll up, because x86 instructions vary in length and the heuristic can start mid-instruction. [0:55:00] [1:30:00] [2:05:00]
- His own **save-file analyzer**: drag in a file, overlay structs, color-code blocks (planets red, ships-on-route green, transports purple, players yellow), diff two saves (changed lines turn red) and follow index links into other arrays. It also has a basic hex editor with insert/overwrite modes; block-repeat paste isn't implemented yet. [0:00:00] [1:50:00] [2:05:00]
- Field definitions live in **JSON files**: field name, type (U16/U8/32-bit/signed), arrays, enums such as `races` (drives a dropdown), "indexes into" another array (e.g. a planet ID linked to `planets`), and comments. The same definitions drive both the debugger and the analyzer. Symbols (address → struct) are kept in an **INI** file. He did the same JSON approach before for Spelunky 2 as an x64dbg plugin, generating C++ structs from the JSON. [2:05:00] [2:30:00] [2:35:00]
- **Ghidra**: STARMAP.EXE and ORION.EXE are loaded separately. Ghidra loads at segment 0x1000, and the memory map shows a block starting at "A000" (as heard). Code segments mentioned as heard: 1468, 1924, 1EA2, 2155, 2375, 2438, 426x. Total loaded is about 622 KB; STARMAP.EXE is 563 KB and ORION.EXE 211 KB on disk. Ghidra's auto-analysis left regions undisassembled, so instruction-pattern search missed them. He knows Ghidra has a remap/rebase tool but couldn't get it working. [1:05:00]–[1:25:00]
- Hex editor **ImHex** (heard "hex emx or IMX"). vbindiff was suggested as a diff tool but rejected because it's console-only, so he wrote his own visual diff. [2:05:00]
- Game build is the **eXoDOS** copy, exact version unknown. The save has no version header: it starts directly with the first planet's name, "Proxima". [1:10:00] [3:40:00]
- **Launch**: eXoDOS `RUN.BAT` picks a sound card and deletes the config/save-game config every time the sound choice changes. A viewer suggested running ORION directly with an argument heard as "your mama"; that worked and is faster to relaunch after crashes. Exact argument and its effect are low confidence. [3:35:00]–[3:40:00]
- Data is mostly 16-bit. Known 32-bit fields: treasury/reserve money, total planet income, tech research progress, and the planet "inbound / planetary reserve" field. [1:15:00] [4:05:00]
- Future plan: add PCSX2 support to his tools for GTA San Andreas. [4:10:00]

## Method
- **Pristine-save control**: restart DOSBox, start a new game (Huge, 5 opponents), save immediately. Leftover bytes in unused buffers drop to zeros, which shows they come from reused memory dumped into the save. [0:00:00]
- **Minimal-change save diffing**: save, make one game action (e.g. accept a fleet move), save to another slot, diff. A planet "twinkle timer" changes every tick, so every planet record shows as changed; ignore it. [0:05:00]
- **Predict the value before searching**: he expected the fleet's X/Y to equal Sol's coordinates (295,53), looked for those numbers in the diff, then byte-swapped them for little-endian ("27 01 35 00 09 00 01 00 02 00") and searched RAM to find the live copy. [0:05:00]–[0:10:00]
- **Poke and observe**: change one field in RAM and watch the UI.
  - Owner 0→1 turned the fleet orange, so it's the race/owner. [0:15:00]
  - Changing the speed field changed the ETA, and 0 crashed the game (likely division by zero). [0:15:00]–[0:20:00]
  - Setting slot 3 to 8 showed 8 bombers, which confirmed the count slots. [0:20:00]
  - Some fields don't repaint until you click the item again. [0:20:00]
- **Enlarge the record by elimination**: send a second fleet to see where the next record starts, which shows where the first one ends. [0:25:00]
- **Size arrays by arithmetic on the gap** between known neighbors (planets before, players after). Check by confirming downstream structs still line up, e.g. player race/banner fields and player names stay in sync. A wrong size (he forgot the 6-element count array) pushed the players past the end of the file. [0:30:00]–[0:45:00] [2:10:00]
- **Finding a count variable**: search RAM for the current number of fleets (17), advance turns as fleets arrive, then re-search (16, then 9) until one hit is left. Confirmed by setting it to 0, which made the fleet icon vanish, then finding the same value in the save via diff. Used again for transports. [0:45:00]–[0:55:00] [3:40:00]–[3:45:00]
- **Finding the hard cap**: duplicate records in a save with the hex editor (marked with AA bytes), load it, and see how many reach RAM. Records 0..259 loaded and index 260+ held other data, so the cap is 260. This also proved the next block is real. [1:50:00]–[2:15:00]
- **Write/read watchpoints → Ghidra**:
  - The write hit `FF 06 86 CC` (inc word [CC86]) followed by `33 C9 EB 5A`. These bytes are in STARMAP.EXE (hex editor, file offset ~6C39) but Ghidra's instruction search can't find them. [0:55:00]–[1:05:00]
  - He worked out a manual Ghidra↔DOSBox offset by finding one common byte run: RAM 0813:92FC equals Ghidra 1468:4B7C, and Ghidra's linear address is 0x7DD0 higher. Converting back to a seg:off that Ghidra recognises failed because the segment choice is ambiguous; he asked Google for the formula offset = phys − seg×16. [1:05:00]–[1:25:00]
  - Read watchpoints found 3 spots doing `inc di; cmp di,[CC86]` (bytes `47 3B 3E 86 CC`) with DS heard as "E000". [CC86] read 0x1B and DI 0x36B, which didn't match the count variable he was after, so this was inconclusive. [1:35:00]–[1:50:00]
- **Fill with 0xFF to find the consumer screen**: overwrite an unknown block with FFs and open screens to see which one crashes or misbehaves. Then watch the block across turns for change. The block only came alive after a war declaration, when the AI started sending transports. [2:20:00]–[2:45:00]
- **Pattern-spotting on raw words**: he noticed a repeating "small value, 4 big, 4 small" group and that 256 likely means two packed bytes, then split u16s into u8 pairs. [2:45:00]–[2:50:00]
- **Cheating game state to reach mechanics**:
  - Gave himself Thorium cells (unlimited range) by setting the propulsion tech and bumping the propulsion count to 2, which made contact with every race. [2:25:00]
  - Set planets to explored and owned, changed tundra to terran so he could land, and raised planet size to raise max population. [3:05:00]–[3:10:00]
  - Gave the scout design a hyperthrust engine to cut ETA. [3:15:00]
  - Reset diplomat availability to 0 and set the opponent's mood to −100 to force a feud. [3:20:00]
  - Changed a planet's owner to an enemy so he could launch a ground invasion. [3:25:00]
- **Change one variable per test**: he notes it was a mistake to change two values at once before a crash, because he couldn't tell which caused it. [3:30:00]
- **Dead ends**:
  - Searching RAM for the mouse map X/Y failed; it's likely viewport-relative or computed on the fly. [3:00:00]
  - Ghidra pattern search failed (see above). [1:00:00]–[1:50:00]
  - He first read the speed field as "distance traveled", then corrected it to speed. [0:25:00]

## Findings — data structures & file formats
Save-file order as of this session: planets (108 records) → ships-on-route[260] → transports[100] → players[6] → per-player ship configurations (designs, new-ship-name suggestions, unlocked research, ship counts) → … fleet count and transport count … → player names → partly unknown 30-byte-ish records (from the last stream, includes the current year) → trailing unknowns (scout name, FFs). [0:00:00] [2:25:00] [3:45:00]–[3:55:00]

| Item | Detail | Confidence |
|---|---|---|
| Garbage bytes in save | Unused buffers are reused for menus and dumped into the save as-is; a pristine launch gives zeros | high [0:00:00] |
| Planet X/Y | X/Y is the top-left corner of the star's selection square; a ship in orbit shares it exactly. Sol was (295,53) in the first game and (177,224) in the later one | high [0:05:00] [2:50:00] |
| Planet twinkle timer | Per-planet counter incremented every tick (makes every planet differ in diffs) | high [0:05:00] |
| **ShipsOnRoute** struct | 14 × u16 = 28 bytes (layout below) | high [0:15:00]–[0:40:00] |
| ShipsOnRoute: +0 owner | Race enum (0 = Human) | high [0:15:00] |
| ShipsOnRoute: +2 X, +4 Y | Current position, u16 | high [0:15:00] |
| ShipsOnRoute: +6 target planet | Index into planets[] | high [0:10:00] |
| ShipsOnRoute: +8 travel speed | Probably the speed of the slowest ship. Higher means lower ETA; 0 crashes (div-by-zero suspected); unchanged between turns | med [0:20:00]–[0:30:00] |
| ShipsOnRoute: +10..+20 ship count[6] | Count per player design slot 0..5 (scout = slot 0, colony ship = slot 4, bomber = slot 3) | high [0:20:00] |
| ShipsOnRoute: last 3 u16 | Unknown; often "1 0 0", one entry showed 256 (maybe 2× u8); changes reverted next turn | low [0:25:00] [0:35:00] |
| ShipsOnRoute array | Max **260** entries, one shared array for all players (AI fleets mixed in). Unused slots are zeroed when fleets arrive. A fleet = up to 6 designs, so a group moves as one | high [2:10:00] |
| Fleets-in-flight count | u16 in RAM at seg **4756** off **6**; in the save next to the end of the ship-configuration block (split out of "unknown 3"); verified across saves (17→9→3) | high [0:45:00]–[0:55:00] |
| **ShipTransport** struct | 9 × u16 = 18 bytes: owner (race), X, Y, target planet ID, population amount (millions), then 4 unknown u16 (mostly 1/0). Zeroing the last one crashes the game and deletes the transport; zeroing the first unknown makes the transport vanish (possibly speed or progress) | med (layout) / low (unknowns) [3:10:00]–[3:35:00] |
| Transport array | **100** entries. Gap left after the fleet array = 900 u16 = 100 × 9 | high [3:45:00] |
| Transport count | u16 at seg 4756 off **8**, right after the fleet count; also adjacent in the save | high [3:40:00]–[3:50:00] |
| Transports not in fleet list | Temporary pseudo-ship drawn with a colony-ship icon; not part of the ships-on-route array | high [3:10:00] [3:25:00] |
| "Totally unknown" block | 411 × u16, in RAM at 6813:B8E0; in the save it's the data after the per-player ship counts (last count word heard 1336; starts "28 1E … 4F1 … FF01 … 4D4D", ends in FFs). Not adjacent to the configs in RAM. One word changed between saves (heard "03 → 506") | med location / low meaning [3:50:00]–[4:10:00] |
| Earlier "411 is zero" diff | An unknown-array element was 0, then 17, then 9 between saves; this led him to the fleet count's file position | low [0:50:00] |
| Planet "unknown 22" → planetary reserve | 32-bit field (held about 1,340,000 when poked). Inbound reserve transfers land here, and excess spending at max population is said to go to "planetary reserve", but the field stayed 0 in one test | med [4:00:00]–[4:10:00] |
| Player reserve (treasury) | 32-bit, in player struct; not recalculated each turn (pokes persist) | high [1:15:00] [4:05:00] |
| Diplomat availability | Fields in the player struct, a 4-part group heard as "−2, 220, 8, 3". Setting to 0 brings the diplomat back | med [3:20:00] |
| Mood slider | Per (player, opponent) pair. Edit it in the opponent's struct (e.g. player 5 vs player 0): player 0's copy gets overwritten from the opponents' values | med [3:20:00] |
| Research count arrays | Per-field "amount unlocked" count must be bumped when you add a tech (propulsion → 2, construction → 3) or the change is ignored | high [2:25:00] [3:35:00] |
| Planet size → max pop | Setting planet size to 80 made max population 80 | med [3:10:00] |
| Player 0 unknown 16 | Unknown | low [2:00:00] |

## Findings — game mechanics & formulas
- **Fleet movement**: a group of up to 6 designs moves at one speed, probably the slowest ship's. ETA comes from the speed and 0 crashes, which suggests a division. ETA bottoms out at 1 turn. Confidence med. [0:25:00]–[0:30:00]
- **Hard cap of 260 fleets in flight** across all players; what happens beyond it wasn't tested. Confidence high. [2:10:00]
- **Hard cap of 100 transports**. Confidence high. [3:45:00]
- **Transports**:
  - To your own planet they carry colonists; to an enemy planet they carry troops. [3:10:00]–[3:20:00]
  - You can only target explored planets whose environment you can control (tundra rejected, terran accepted). [3:05:00]
  - Target population is limited ("can only support 40 million"); overflow was clamped (it reached 39). [3:10:00]
  - Confidence med.
- **Ground combat**: armor and weapons (titanium combat armor, hand lasers) come from the attacker's **current research at arrival**, not a snapshot at launch; a mid-flight Andrium armor upgrade applied. Armor tech sits in the Construction field and also raises transport hit points. Defenders won despite worse weapons because of numbers. Confidence high for "not stored". [3:25:00]–[3:35:00]
- **Range/contact**: Thorium cells (unlimited range) gives immediate contact with all races. Engine type affects ETA, and range seemed to as well. Confidence med. [2:25:00] [3:15:00]
- **AI diplomacy**: the Mrrshan declared war unprompted after he cheated contact (possibly a side effect). Mood −100 turns relations into a feud the next turn. Threatening while dishonorable got him a gift and a recalled diplomat, not war. Confidence low/med. [2:45:00] [3:20:00]
- **Reserve transfers**: transfers come from the global reserve, not from another planet, and the inbound amount applies next turn. Excess beyond max population or factories is said to go into the planetary reserve, but that's not confirmed in memory. Confidence low. [3:55:00]–[4:10:00]
- The game nulls out fleet records on arrival, though it still keeps a count. [0:45:00]

## Named code/data
| Name | Address (as heard) | Notes |
|---|---|---|
| `ships_on_route` (array of `ShipOnRoute`) | 6813:0930 | 260 entries; struct type `ship on route`. [0:10:00] [2:10:00] |
| `ship_design` | — | Existing struct renamed from "ship" to "ship design" (size/icon/space fields). [0:10:00] |
| ships-on-route array size | 4756:0006 (u16) | Mistakenly read 4760 first. [0:45:00]–[0:50:00] |
| ship transports array size | 4756:0008 (u16) | [3:40:00] |
| `ship_transports` (first called "ships unknown") | 6813:94F0 | 100 × 9 u16. [2:15:00] [3:10:00] [3:45:00] |
| `totally_unknown` | 6813:B8E0 | 411 × u16. [3:50:00] |
| Fleet-count write site | 4E23:1839 (also heard "423839", "4823 1839") | `inc word [CC86]` = FF 06 86 CC; in STARMAP.EXE at file offset ~6C39; not located in Ghidra. [0:55:00]–[1:35:00] |
| Read sites | e.g. 4A90:37CF and an offset ending B72 | 3 × `inc di; cmp di,[CC86]`. [1:35:00]–[1:45:00] |
| Ghidra↔RAM delta | RAM 0813:92FC ≡ Ghidra 1468:4B7C → +0x7DD0 linear | [1:10:00] |
| Planet field `planetary reserve` (was unknown 22) | — | Renamed; 32-bit. [4:05:00]–[4:10:00] |
| Current planet ID | in `game_state` | Used throughout as a lookup. [0:10:00] |

## Open questions / unresolved
- The last 3 u16 of ShipOnRoute (values 1/0/0 and 256) and the 4 unknown u16 of ShipTransport (one is crash-critical). [0:35:00] [3:35:00]
- Getting Ghidra's segment mapping to match DOSBox, finding why the fleet-count code isn't found in Ghidra, and whether there's a hardcoded 260 bound check in code. [1:05:00]–[1:50:00] *(Mapping + fleet-count parts answered 2026-10-16 → [REA page](../../../reverse-engineering/rea-candidate-tool.md#open-questions): the `inc [CC86]` is at file `0x6CE39` (heard "~6C39"), inside FBOV overlay #71 at offset `0x1839`. Ghidra doesn't load overlays, which is why it couldn't be found. The 260 bound check is still open.)*
- Whether fleets beyond 260 are dropped or corrupt memory. [2:10:00]
- Meaning of the 411-word "totally unknown" block (maybe ship-related, given its position in the save). [3:55:00]–[4:10:00]
- Why the planetary reserve didn't increase despite the "placed in planetary reserve" message, and where reserve transfers end up. [4:05:00]–[4:10:00]
- Planet unknowns that might hold recovery progress for comet or plague events; untested because the events are hard to trigger. [2:20:00]
- Spending-cost fields, which may be computed on the fly. [3:55:00]
- Separating the unlocked research from the ship-configuration array. [3:55:00]
- Mapping the map cursor's X/Y. [3:00:00]

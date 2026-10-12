---
status: active
created: 2026-10-11
---
# zappatic MOO1 RE stream — Part 1 notes
> Per-part extraction (auto-caption transcript → structured notes). Values are **as heard**; hex is often caption-garbled — confidence marked per item. Digest: [zappatic-re-stream](../zappatic-re-stream.md).

**Source:** [part01-KAI-LQKsAtc.txt](../../../../raw/videos/moo1-re/part01-KAI-LQKsAtc.txt) — <https://www.youtube.com/watch?v=KAI-LQKsAtc>

Source: `Vault/raw/videos/moo1-re/part01-KAI-LQKsAtc.txt` (auto-captions). All hex values are **as heard**; caption garbling is common. `unknown N` = his positional field label (a list of u16 fields after a char-array name) at the moment he named it. **Caveat:** at ~[0:31] he resized the planet name field, so planet `unknown N` numbers stated before ~[0:31] may be offset from those stated after it. He never said by how much.

## Summary
- He started from the savegame: SAVE1.GAM, about 59–60 KB, opened in a hex editor. Planet records showed up right away as fixed 0xB8-byte (184-byte) blocks. He then found the same bytes in RAM, so the save is largely a memory dump. [0:00:00]–[0:05:00]
- He mapped the **planet struct** at `6813:2C60` by editing fields live and watching the UI. He named about 25 fields, including name, x/y, star color and size, environment, modifier, population, factories, waste, production, the 5 spending sliders and their locks, bases, and the relocation and transport targets. [0:10:00]–[1:30:00]
- He found the **selected-planet index** at `4756:0000` and the maximum planet count, which is **108** in a huge galaxy. [0:55:00]–[1:05:00]
- He mapped the **ship design struct**: 0x44 (68) bytes, a 12-char name, then u16 fields. He named about 15 fields and built enums for armor, computer, shield, ECM, engine and specials. Player 0's designs are at `6813:7A40`. The designer's working copy is at `4765:01F0`. [1:35:00]–[2:35:00]
- He defined a **per-player ship configuration** block: 6 designs, 12 suggested names, about 288 unknown u16, and per-design ship totals at the end. The array holds **6 players**, and the 7th entry is garbage. [2:45:00]–[3:00:00]
- He found the **per-planet orbiting-ships array**: 108 entries × 24 bytes at `4237:018C`. He confirmed it also appears in the savegame. [3:00:00]–[3:20:00]
- He started the **tech research struct** near `4240:0032`. It holds 6 field sliders, locks, levels, the current topic per field, progress, and a possible RP target. It was left incomplete. [3:25:00]–[4:00:00]

## Tooling & setup
- He runs his own DOS emulator/debugger front-end. It has a scaler option, but the window would not scale beyond the default at 3x or 5x. [0:00:00]
- **Symbols file auto-loads by CRC** of the game executable. He says he has "already gotten the CRC", so the symbols load automatically. [0:00:00]
- The symbols file is hand-edited in VS Code as a JSON-like format. It has `struct` definitions (an object with `fields`), arrays (`[N]`), `char` arrays, `u16` and signed 16-bit types, `enum`s, and validation for structs and enums. Each symbol is defined as segment base + address + type. [0:10:00], [0:15:00], [0:55:00], [1:40:00], [2:45:00]
- The symbol viewer can **"index into"**: a scalar symbol (for example the current planet ID) can index into an array symbol, so the viewer follows the selection live. [0:55:00]
- The viewer shows enums as drop-downs for live editing, and it can **force/freeze values**, for example forcing the star flicker counter to 0. [0:20:00], [1:00:00]
- The viewer has a **"no duplicate physical" overlap check** that confirms symbol ranges don't overlap. [3:25:00]
- **Memory search with successive filtering** works like a Cheat Engine–style narrowing. He searches a value, changes it in game, then re-searches. For example, 13 gave ~1100 hits, then 19 gave 1 hit. [0:55:00], [2:40:00], [3:25:00]
- A **memory viewer** shows segment:offset and "physical" addresses. He converts segment+offset to physical to do arithmetic, e.g. 40 bytes before `424E:0000` → `424B:0008`. [3:35:00]
- **Bug in his tool:** the viewer's segment base sometimes changes on its own (424E/424B/44B confusion). He says he needs to fix it. [3:40:00]
- He also uses an external **hex editor** on the savegame. [0:00:00], [3:15:00]
- Addresses are real-mode `segment:offset`. The segments seen are `6813` (planets and player ship configs), `4756` (UI selection), `4765` (designer working copy), `4237` (orbit array) and `424E`/`4240` (tech). Which executable he was debugging (ORION.EXE or STARMAP.EXE) and the memory model were **not stated**.
- **Ghidra, disassembly and compiler/runtime identification were not used** this session. He says the field boundaries "could be figured out by looking at the assembly" but defers it. [0:15:00]
- There is a recurring **load-game failure**: saves disappear or won't load. He suspects he deleted too many files while clearing old saves. [0:15:00], [0:45:00], [0:50:00], [1:15:00]
- He wants to add a value-history / snapshot feature to compare values across turns. It is not built yet. [0:30:00]

## Method
- **Savegame first.** The save "has the critical information", so he identifies record boundaries in the hex editor by measuring repeated layouts, such as the distance between two planet names (0xB8). He then searches RAM for the same byte run (planet name plus a few following bytes) to locate the live copy. [0:00:00]–[0:05:00]
- **Struct skeleton by padding.** He defines the name as a char array, then appends `unknown1..N` u16 fields until the next record's name is clobbered, and trims back. He then turns the symbol into an array and checks that record 2's name lines up. This avoids doing the size arithmetic by hand. [0:10:00]–[0:15:00]
- **Name-length check.** He looks for the longest in-game name and the null terminator. Tau Ceti ("Tao Signi") was getting truncated, which showed the planet name is longer than 8; he widened it by 4 bytes. He also renamed a ship in game to test max length (11 chars typed, so 12 reserved). [0:30:00], [1:40:00]
- **Sign detection:** a value showing as 0xFFFF means -1, so he retypes the field as signed. He did this for planet unknowns 24, 25 and 53, and for ship available-space. [0:20:00], [0:30:00], [2:35:00]
- **Live-edit-and-observe loop.** He picks a field whose value matches a UI number (e.g. 100, 50, 30), changes it, and watches the UI. Some fields are not re-read live, so he leaves and re-enters the screen or ends the turn before concluding. [0:20:00]–[0:25:00]
- **Random-poke exploration** for fields not shown in the UI: he changes a value and looks for map changes. This found x/y (the planet moved) and star icon/color. It also caused crashes when indexes went out of range. [0:45:00]–[0:50:00]
- **Enum discovery by sweeping.** He steps the value through 0,1,2… and records the UI string for each. He stops when the string becomes empty or garbage, or when the game crashes ("illegal unhandled interrupt"). Overflow into neighbouring string tables (e.g. environment → "ultra poor") marks the end of the enum. [1:05:00]–[1:20:00], [2:10:00]–[2:30:00]
- **Use the game's own actions as tests:** colonizing a 2nd planet gave two known IDs (13 and 19). Setting relocation/transport targets then revealed the planet-ID fields. [0:30:00]–[0:35:00]
- **Find UI state by value toggling:** to find the selected planet, he searched 13, clicked another planet, searched 19, and got 1 hit. [0:55:00]
- **Find counts by mass-building:** he built many scouts (2 → 30 → 34) and searched. He then split the fleet (send 19, keep 15) to tell the per-planet count apart from the global total. [2:40:00]
- **Array stride from two known elements.** He put a distinctive count (100 scouts = 0x64; 16 = 0x10) on two adjacent planets and measured the distance, which gave 24 bytes. He then computed the base as `known_addr − stride × index`. He had an off-by-one and corrected it from 1A4 to 18C. [3:05:00]–[3:10:00]
- **Boolean toggling search** for the tech-screen lock checkboxes: he searched 0, locked one, searched 1, unlocked, searched 0, and so on. [3:25:00]
- **Anchor then grow upward.** He found a mid-struct field (the locks) and prepended dummy fields while moving the base address up until the sliders aligned. Distinctive values (e.g. a 0x7802 word) mark the struct start. [3:30:00]–[3:45:00]
- **Cross-check against the savegame.** He wrote odd values into RAM, saved, then searched the save for them to find block boundaries. The first match was a coincidence. A second search (the bytes "24 128") gave a convincing match. He suspected the save reorders regions relative to RAM. [3:35:00]–[3:40:00]
- **Cheat/sanity tests reveal derived values.** Cost, available space and maneuver in the designer snap back or flicker, so they are recomputed every frame. Cost on a built design is recomputed at turn end, so a cost=1 cheat failed. [2:30:00]–[2:35:00]
- **Dead ends:**
  - Moving a planet's x/y did not change reachability. [1:30:00]
  - Moving ships (not in orbit) were not located; a plan to filter by decreasing x was judged weak. [3:20:00]
  - Research-points arithmetic didn't match the candidate fields. [3:50:00]
  - Research stalled until production was raised and the game restarted. [3:55:00]

## Findings — data structures & file formats

### Savegame (SAVE1.GAM)
- The file is about 59–60 KB. [0:00:00] — high
- The **planet array is at the start of the file**. It is the same bytes as in RAM, "an entire memory dump of the planets". [0:05:00] — med (he says the file starts with the same 0x54 'T' byte as RAM; the exact file offset of the first record wasn't stated)
- In a small galaxy the planet records end at file offset **0x1140**. He computed 0x1140/0xB8 = "18" and took it as 18 decimal, then found more than 18 planets. *Note: 0x1140/0xB8 = 0x18 = 24 decimal; this may explain his miscount.* [0:00:00]–[0:05:00] — low/med
- After the planets there is a sparse, zero-heavy region he guesses is player data. Then come the ship designs (Scout, Fighter, Destroyer, Bomber, Colony Ship). Then come the suggested ship names (Starfighter, Comet, Seeker…), with blocks repeated per race. The player name ("Zygote") is near the end. [0:05:00], [1:35:00] — med
- The orbit-ship array and the ship totals are present in the save. [3:15:00]–[3:20:00] — high
- Some RAM blocks (tech area) may be **stored in a different order** in the save. This is his hypothesis after a failed match. [3:40:00] — low

### Planet struct — 0xB8 (184) bytes; array at `6813:2C60` (heard "6813 … 2C60")
- **Size 0xB8 = 184 bytes.** The fixed stride was verified via array alignment. [0:05:00], [0:15:00] — high
- **Count: 108** (index 0–107) in a huge galaxy; the last one is "Aratus". It may vary with galaxy generation. [1:00:00] — med-high
- Planet IDs seen: Mentor (Sylum home, Sylum = his race pick) = 13 in a small galaxy; Tao Signi = 19; Mentor = 5 in another small game; Talos = 4; Altair = 6. [0:20:00], [0:30:00], [1:25:00], [3:00:00] — high (game-instance specific)
- **name**: char array, first 8 bytes, then widened by 4 bytes after "Tao Signi" was truncated. He said "maybe 10", and the final width appears to be 12. [0:10:00], [0:30:00] — med
- **unknown 7**, called a timer or "flicker": an animation counter for the star flicker on the map. Forcing it to 0 makes the star flicker. [0:20:00] — med
- **unknown 12**: first named planet size, then reclassified as max-population-related. At 500 the UI shows "100 + max"; at 50 it shows "100 max". [0:20:00]–[0:25:00] — med
- **current population** (index not stated): setting it to 150 triggered the advisor message about missile bases. [0:25:00] — high
- **unknown 24, 25** are signed (0xFFFF seen). [0:20:00] — high
- **unknown 28 factories**. [0:25:00] — high
- **unknown 29 production**: there are two production fields, gross (shown in brackets) and net. Unknown 29 was the left/yellow one, and he guessed it is net. [0:30:00] — med
- **unknown 37–41 spending sliders**: ship, defense, industry, eco, tech. They are percentages, and memory edits can exceed 100% in total. [0:25:00] — high
- **unknown 42 ship to build**: the index of the design selected for production. [0:25:00] — high
- **unknown 43 ship relocation planet ID**: equals its own ID when not relocating. [0:30:00]–[0:35:00] — high
- **unknown 52 transport destination planet ID**. The number of colonists in transit is NOT stored in the planet struct. [0:35:00] — high
- **unknown 53**: signed and counts oddly (-7 → -6 …). [0:30:00], [0:40:00] — low (meaning unknown)
- **unknown 27 previous turn's population**: the growth display is current − previous. [0:35:00] — high
- **unknown 23 waste**. [0:35:00] — high
- **unknown 54.. locks** for ship, defense, industry, eco and tech, as booleans. He confirmed the first one and assumed the rest are in order. [0:40:00] — med-high
- **unknown 44 missile base count**. [0:40:00] — high
- **unknown 20**: changes only at end of turn with erratic values (-6, 5, 0, 9, 7, 1, 7). Meaning unknown; he suggested an event countdown. [0:40:00], [1:25:00] — low
- **x coordinate / y coordinate**: two adjacent fields. Origin is top-left. Mentor's x was 67. Altair is at (48, 78)? and Mentor at (192, 28)? as heard ("4878", "19228"). [0:45:00], [3:00:00] — high (field meaning) / low (values)
- **unknown 5**: setting it to 1 crashed the game ("illegal unhandled interrupt"). [0:45:00] — low
- **Star appearance**: he initially treated **unknown 6** as "star icon size and colour", with values up to about 12 before a crash. He then concluded there are separate **colour** and **size** fields. [0:50:00]–[1:00:00] — med
  - **Star colour enum**: 0 yellow, 1 red, 2 green, 3 white, 4 blue, 5 purple. 6 crashed and 7 crashed. He thinks purple is the special star (Orion). [0:55:00] — med-high
  - **Star size**: only **0 = small** and **6 = large** were observed in the data. He expected 3 sizes, but only 0 and 6 exist. [1:00:00] — med
- **Environment enum** (field index possibly 13, heard "this is the environment and uh 13"). The UI label is the planet's environment type. [1:05:00]–[1:10:00] — values med, index low
  - As heard: 0 no habitable planets, 1 radiated, 2 toxic, 3 inferno, 4 dead, 5 tundra; then barren, minimal, desert, steppe and arid (the exact positions of these five were garbled); 11 ocean, 12 jungle, 13 terran (home), 14 gaia.
  - Values 15+ overflow into another string table: ultra poor, poor, empty. So the enum ends at 14.
- **unknown 15 planet icon**: the planet graphic in the planet panel. It is not live and needs a refresh. 9 is valid; 50 crashes. [1:10:00]–[1:15:00] — high
- **unknown 17 resource modifier** (planet "specials"). [1:15:00]–[1:25:00] — med
  - Values: 0 ultra poor, 1 poor, 2 is displayed as "Gaia" (he re-labels it **neutral/empty** because Gaia is a string-table overlap), 3 artifacts, 4 rich, 5 ultra rich, 6 4x tech. Then overflow: 7 hostile, 8 empty, 9 fertile.
  - The modifier affects the industry readout: a value of 264 with 4x tech vs 66 with poor.
- **Two adjacent fields that are -1** on unexplored planets. -1 shows the "no info" screen. Setting them gives "human colony, range 10,000 parsecs"; 0 shows the planet name and "colonize". He reads this as exploration/ownership state. [1:20:00]–[1:25:00] — low
- A **field near environment/modifier** takes the values 1, 2, 4 and 3. He suspects a bitmask (possibly per-player). [1:30:00] — low
- Range/reachability is **not** computed from the planet's stored x/y. It appears cached or derived elsewhere. [1:30:00] — med

### UI / global
- **Current selected planet ID**: u16 at `4756:0000`. [0:55:00] — high

### Ship design struct — 0x44 (68) bytes
- **name**: char[12]. "Colony Ship" is 11 characters plus the null. [1:40:00] — high
- The rest is 56 bytes = 28 × u16 by assumption. Some fields may be 8-bit. [1:40:00]–[1:45:00] — med
- **Player 0 designs**: `6813:7A40` (heard "7 A40"; once "70 40"). There are **6 design slots**; the 6th held garbage until a ship was designed. [1:40:00], [2:00:00] — high
- **unknown 5 cost** (BC); a Scout costs 8. It is recomputed from components at turn end. [1:45:00], [2:35:00] — high
- **unknown 28 hit points**: the UI calls it "hits"; the in-game label is "hit points". [1:45:00], [2:00:00] — high
- A separate field holds 100, which is not hit points and doesn't change. [1:55:00] — low
- **unknown 20 special slot 1**. The next two fields are special slots 2 and 3; a 2nd slot set to 3 gave Barren Base. [1:45:00], [1:55:00] — high
- **Weapons**: **4 weapon-type slots plus 4 count fields**. "unknown 9" is weapon related. A slot needs count ≥ 1 to display. Examples: 1 = laser, 3 = nuclear missile (×2 / ×5 variants). [1:50:00]–[1:55:00] — high (structure), med (exact indices)
- **unknown 8 ship icon** (picture index; 12 = the big colony ship). [1:55:00] — high
- **unknown 7 ship size**: 0 small, 1 medium, 2 large, 3 huge. [2:00:00] — high
- **unknown 6 available space**: **signed**, because an overloaded design goes negative (-1035). Total space (e.g. 204) is adjacent. [2:00:00], [2:35:00] — high / med
- **unknown 26 armor**: [2:10:00] — enum med
  - 0 titanium, 1 titanium II. The 2–3 entries were garbled (zortrium?).
  - Around 6 is "Andrium". Adamantium and adamantium II follow; the exact indices were not stated.
  - 12 neutronium, 13 neutronium II, 14 none, 15 empty/garbage.
- **unknown 25 computer**: 0 none, 1–11 = Mark I–XI; 12+ is garbage. [2:10:00]–[2:15:00] — high
- **unknown 23 shield**: 0 none(?). [2:15:00] — med
  - 1–7 map to Class I–VII.
  - 8 is Class IX, 9 is XI, 10 is XIII, 11 is XV. The numbering skips after 7.
  - 12 is nothing.
- **unknown 24 ECM**: 0 none, 1–10 = Jammer I–X, 11 none, 12 garbage. [2:15:00]–[2:20:00] — high
- **unknown 27 maneuver**: snaps back, so it is computed. [2:20:00] — med
- **unknown 17 engine**: 0 retros, then nuclear, sublight, fusion, impulse, ion(?), anti-matter, interphased, hyperthrust (last; the next value crashes). [2:20:00] — med (garbled names)
- **Specials enum**: about **30** entries. [1:45:00]–[2:30:00] — med (names partly garbled)
  - 0 none; reserve tanks; colony base; barren base; tundra base; dead base (~5); inferno base; 8 radiated base(?).
  - 9 battle scanner; ~10 anti-missile rockets.
  - Then: repulsor beam, warp dissipator ("love it dissipator"), energy pulsar, inertial stabilizer, zyro shield, automated repair, stasis field, cloaking device, ion stream projector.
  - 20 high energy focus, 21 ionic pulsar.
  - Then: black hole generator, subspace teleporter, lightning shield, neutron stream projector, advanced damage control(?), technology nullifier, inertial nullifier, oracle interface, displacement device.
- Two large unknown values in each design flicker in the designer. One rises by about 10 per laser and more per heavy laser; he wondered if it is weapon weight, but it doesn't match the space arithmetic. [2:05:00]–[2:25:00] — low
- **Designer working copy** = same ship struct at `4765:01F0` ("47 65 … 1F0"; he first misread it as 4785). Its fields are recalculated every frame. [2:05:00] — med-high

### Player ship configuration — array of **6 players** starting at `6813:7A40`
- Layout: `ships[6]` (6 × 68 bytes), then `suggested_names[12]` (char[12] each, null-terminated with leftover garbage), then about **288 × u16 unknown**. [2:45:00]–[3:00:00] — med
  - He computed 0x7EA7 − 0x7C68 = 575 bytes (odd), which gives 287 fields. Ship totals sit at the end, and he added one more field for the 6th count, giving 288.
  - The 7th entry was garbage ("enum values not found"), so there are **6 players maximum**.
- **The last 6 u16 are total ship counts per design slot** (e.g. 0x22 = 34 scouts). These are **recomputed** from the per-planet orbit arrays (and presumably in-transit fleets) when the screen refreshes. [2:45:00], [3:00:00], [3:15:00] — high
- Suggested names are per race: ours were Starfighter, Comet, Seeker, Starblazer, Nova…; another race had Warbear, Punisher, Rhino, Grizzly. Every race starts with a Scout and a Colony Ship (some also a Fighter/Destroyer/Bomber). [1:35:00] — high
- The roughly 575-byte middle block is unknown. He guesses fleet location data, combat data, or uninitialised memory. [2:45:00], [3:20:00] — low

### Planet orbiting ships — 108 × 24 bytes at `4237:018C`
- The stride is **0x18 (24) bytes = 12 u16**. [3:05:00]–[3:10:00] — high
- The **first 6 u16 are the count of each design slot in orbit**, scoped to the owning player (player 0 here). Editing a count changes the in-game orbit and is reflected in the totals. [3:00:00]–[3:10:00] — high
- **Field 7** (just after the counts) stays 1 on Talos once he had ships there, even after colonizing and after removing all ships. Meaning unknown. [3:10:00]–[3:15:00] — low
- The base was first computed as `1A4` and corrected by one stride to `18C`. [3:10:00] — high
- Whether this is per-player or indexed differently is untested. Adding ships to an undiscovered planet (Altair) didn't show them, possibly because the planet was unexplored. [3:00:00] — low

### Tech research struct — base about `4240:0032` (shifted from the lock-flag anchor at `424E:0000`)
- The struct start is assumed at a 0x7802 word. [3:40:00]–[3:45:00] — low
- **unknown 46–51 sliders** in order: computers, construction, force fields, planetology, propulsion, weapons. [3:45:00] — high
- **Locks**: 6 booleans in the same order. [3:30:00] — high
- **Levels**: 6 values, e.g. weapons level 10. The level is editable and reflected in the UI. [3:45:00] — high
- Another nearby field changed the **ground combat percentage** label. [3:30:00] — low
- **unknown 73.. current research topic ID per field**: computers first, then construction, …, weapons. [3:55:00] — med
- **Progress per field**: RP accumulated. Setting it near the threshold filled the light-bulb indicator. Values around 53,000 may be signed. [3:50:00]–[4:00:00] — med
- **RP target per field** (e.g. 400, 1600). Each may be 32-bit, or have a field in between, since he had to skip one. [4:00:00] — low

## Findings — game mechanics & formulas
- **Population growth display** = current pop − previous-turn pop (planet unknown 27). The eco readout said +2, but growth was 93 → 97 (+4), so the displayed eco number is not the whole growth. [0:35:00] — high for display, low for the formula
- Production has gross (shown in brackets) and net values. [0:25:00]–[0:30:00] — med
- Spending sliders are not clamped when edited in memory, so totals can exceed 100%. [0:25:00] — high
- Ship totals per design are **derived** by summing the per-planet orbit (and fleet) data and recomputed on refresh. Editing a total is overwritten. [3:00:00] — high
- Design **cost and space are derived** from components. They are recalculated each frame in the designer and at turn end for built designs, which blocks a cost-edit cheat. [2:35:00] — high
- Range/reachability does not follow edits to a planet's stored x/y; it seems to be precomputed or cached. [1:30:00] — med
- **Research is probabilistic** after reaching a threshold: the UI showed "99% chance", and a 15% chance just after crossing it. Progress doesn't drop by the exact RP spent, and the RP-per-turn vs progress-delta arithmetic didn't reconcile (e.g. +67 RP gave 80 → 147). [3:50:00]–[4:00:00] — med
- Research yields nothing when production is 0. Raising production enabled RP, e.g. 340 or 600 RP per turn after cheating population. [3:50:00] — med
- Planet resource modifier scales industry output: the readout was 264 with 4x tech vs 66 with poor. [1:20:00] — med
- Environment and modifier, and other enums, are indexes into string tables. Values past the end show adjacent strings or crash. [1:15:00] — high

## Named code/data
All are data symbols; no functions were named. Addresses are as heard.

| Name | Address | Type |
|---|---|---|
| planets | `6813:2C60` | planet[108] (struct 0xB8) |
| current planet ID | `4756:0000` | u16, indexes into planets |
| player ship configurations | `6813:7A40` | [6] {ships[6] (struct 0x44), new ship names[12] (char[12]), ship unknown[~288 u16, last 6 = ship counts]} |
| current ship design | `4765:01F0` | ship |
| planet orbiting ships | `4237:018C` | [108] × 24 bytes (first 6 u16 = per-design counts) |
| tech research | ~`4240:0032` | struct, anchor of lock flags was `424E:0000` |

- Enums defined: star colour, star size, environment, planet modifiers, ship specials, ship sizes, ship armor, ship computers, ship shields, ship ECM, ship engines. [0:55:00]–[2:30:00]
- Planet field names (dash-separated): name, timer, planet-size / max-pop-related, current-population, previous-turn-population, factory-count, production (×2), waste, ship/defense/industry/eco/tech slider, lock-* ×5, ship-to-build, ship-relocation-planet-ID, transport-destination, bases-count, x, y, star icon/colour/size, environment, planet-icon, planet-modifiers.

## Open questions / unresolved
- Where in-transit fleets (moving ships and their positions) are stored. [2:40:00], [3:20:00]
- What the roughly 575-byte unknown block in each player config holds. [2:45:00], [3:20:00]
- The meaning of orbit-entry field 7 (stays 1). [3:15:00]
- The two flickering design fields and the constant 100 field. [1:55:00]–[2:25:00]
- Planet unknown 20 (erratic per-turn), unknown 53 (signed countdown), unknown 5 (crash), the 1/2/4/3 bitmask field, and the -1 exploration/owner fields. [0:40:00], [1:25:00]–[1:30:00]
- Why reachability ignores edited x/y. [1:30:00]
- Whether 108 is the true planet maximum. [1:00:00]
- Whether star size has values other than 0 and 6. [1:00:00]
- The tech struct start, the RP target width (16 vs 32 bit), and the research probability formula. [4:00:00]
- Whether the save reorders RAM blocks. [3:40:00]
- Whether the per-player ship config fields are 8-bit or 16-bit. [1:45:00]
- The load-game failures and the segment-drift bug in his viewer. [1:15:00], [3:40:00]
- He has not yet looked at code or assembly at all.

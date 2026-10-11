---
status: active
created: 2026-10-11
---
# zappatic MOO1 RE stream — Part 6 notes
> Per-part extraction (auto-caption transcript → structured notes). Values are **as heard**; hex is often caption-garbled — confidence marked per item. Digest: [zappatic-re-stream](../zappatic-re-stream.md).

**Source:** [part06-2m4pVDNvwOA.txt](../../../../raw/videos/moo1-re/part06-2m4pVDNvwOA.txt) — <https://www.youtube.com/watch?v=2m4pVDNvwOA>

Source: auto-captions. Numbers and addresses are recorded as heard. "unknown N" means the field index in zappatic's symbol struct as he read it aloud. Captions don't make clear whether those indices are 0- or 1-based.

## Summary
- Linked the new web save editor, which shows the same symbol view as his debugger but works on the on-disk save. It has one-click scripts (unlimited ship range, unlimited ship construction, scout loadout). [0:00:00]
- Found the AI personality and objective fields in the player struct, with both enums fully listed (0–5). [0:00:00]–[0:05:00]
- Found and named the "game settings" block, in RAM and in the save, by diffing two saves with different galaxy sizes: map dimensions, two unknowns that scale with galaxy size, galaxy size enum, planet array size, difficulty, player count. The field order on disk is the reverse of RAM. [0:15:00]–[1:15:00]
- Added a script that explores every planet. [1:10:00]
- Mapped the four trailing per-planet arrays of 108 entries each: galaxy-map flags (owner as the player sees it), populations, base counts, factory counts. They sit in segment 6813 in RAM and come right before the trailing "scout" string in the save. [1:20:00]–[2:05:00]
- Turned the 411-word "totally unknown" block into an `events` struct. He forced random events by poking trigger slots and decoded quake, nova, industrial accident, assassination, computer virus, comet, pirates, derelict, space crystal and amoeba, plus the research-breakthrough fields. [2:10:00]–[5:05:00]
- Learned that events are a fixed slot per event type, with a state value (0 none / 1 triggered / 2 ongoing) plus parameters. Chat described it as a state machine. [3:15:00]–[3:25:00]

## Tooling & setup
- **His own debugger / symbol viewer** for the DOS process. It searches memory within the ORION range and has a symbols tree with typed fields: u16, signed 16, boolean (checkbox), enum (dropdown), "indexes into planets", arrays, structs and comments. Rows turn red when a value changes. Red highlighting is not in the raw memory view yet; he plans to add it. [0:25:00], [2:20:00], [3:15:00]
- **Symbol definition file** holds separate RAM and on-disk versions of the same block when their layouts differ, e.g. "game settings RAM" vs "game settings on disk". Symbols are declared as `segment` + offset, for example segment 4744 (heard "47 444 … address 1C"; low confidence) and segment 6813. [0:25:00]–[0:30:00], [0:55:00]
- **Segment bug:** a "new segment" appears at runtime, so symbol lookups landed at 8813/3813/5813 instead of 6813 and the right segment had to be found by searching. He fixed it by restarting the tool. The large Orion segment was quoted as "582 656" (bytes). [1:15:00]–[1:20:00]
- **Save-file viewer** colours each known struct in the save. It has no search yet, so he used a separate hex editor for searching and editing. It reloads after symbol-file edits; he wants a reload button. [0:15:00], [1:35:00], [2:00:00]
- **Scripts:** "explore all planets" was written this session. It calls get-symbol on `game settings RAM.planet array size`, loops over the planets and sets `planets[i].explored = true`. Existing scripts: unlimited ship range, unlimited ship construction, scout loadout. [0:00:00], [1:05:00]–[1:10:00]
- **Sign bug:** enum lookups fail on -1 because the tool looks up 65535 on a signed field. [1:35:00]
- Chat said source code for the game exists. He hadn't known that and prefers to work things out himself, keeping the source as a fallback. [3:40:00]
- He web-searched for lists of MOO1 random events and mostly found MOO2 / 2016-remake pages. He also found a cheat: holding Alt on the main screen turns random events off. [2:20:00], [4:35:00]
- No Ghidra or disassembly this session; all work was memory and save poking. [whole session]

## Method
- **Poke and observe in the live game:** change a candidate value in RAM, then watch the UI or the next turn. That is how he confirmed the personality fields, map size, flags and every event field. [0:00:00], [0:50:00], [3:05:00]
- **Diffing saves:** to find planet array size he made two games (huge with 108 planets, small with 24) and looked for a value that is 0x6C in one save and 0x18 in the other. Searching for 0x6C alone was useless because it is the letter "l". [0:15:00]–[0:20:00]
- **Varying one setting at a time:** he changed one new-game option per run (opponents, difficulty, galaxy size) and watched the settings words. This separated difficulty, player count and galaxy size, and showed the "9,12,3" triple tracks galaxy size. He noted he once changed too many settings at once and had to back up. [0:40:00]–[1:05:00]
- **Mapping RAM to the save** by matching value patterns. Example: a run of FFs followed by 00/01 found by search in both RAM and the save. He computes array start offsets by subtracting the index × 2 from a known element's address (e.g. 0x6D at planet index 76 gives the base address). [1:15:00]–[2:05:00]
- **Recognising a planet array from a known value:** a value of 45 at index 76 matched his planet's population, and it tracked turn by turn. Base counts were confirmed by building a base and by writing 123 bases, which copied into the array the next turn. [1:45:00], [2:05:00]
- **Canary values:** he wrote recognisable bytes (A, B, C…) into the save in a hex editor, loaded it, then searched RAM for them to find a block's RAM location. [2:00:00]–[2:05:00]
- **Forcing events:** he set slots in the events block to 1 one at a time, ended the turn and read the news. Setting many at once fired several events and muddled the attribution; he then reset and went one at a time. Parameters were found by giving neighbouring words distinct values (planet 5 vs 6, then 8 → "Artemis"). [3:00:00]–[3:10:00]
- **Writes the game ignores:** events read their parameters once when they fire. Values set afterwards don't change the news, and quake damage numbers are not stored back into the block. [3:10:00], [3:25:00]
- **Dead ends:**
  - Waiting for natural events (a long "waiting game"). [2:10:00]–[2:50:00]
  - A rebellion did not visibly land in the events block. [2:35:00]
  - Report age ("18 years old") is not visible anywhere. [0:10:00]
  - The nebula background has not been located. [0:50:00], [1:40:00]
  - Tech-exchange screens don't record the other race in the breakthrough fields. [2:55:00]
- **Crashes as signal:** zero or invalid values in some fields crash the game, e.g. comet field 48 = 0 and a block of FFs in flags. Writing FFs risks out-of-range indexing, so he prefers to write 1s. [3:00:00], [3:55:00], [4:05:00]

## Findings — data structures & file formats
- **Player struct, personality and objective:** these are the two words right after race and banner colour, formerly "unknown 3/4". [0:00:00]–[0:05:00] — **high**
  - Personality enum: 0 xenophobic, 1 ruthless, 2 aggressive, 3 erratic, 4 honorable, 5 pacifistic.
  - Objective enum: 0 diplomat, 1 militarist, 2 expansionist, 3 technologist, 4 industrialist, 5 ecologist. Values above 5 don't exist.
  - The human player also has values (e.g. erratic/diplomat). Their effect is unknown.
- **Player countdown fields (unknown 6 and one other):** decrease by 1 each turn for AI players, then reset to a different value when they reach 0 (e.g. reset to 17). Observed values include 18/3 for the human, 11/14 and 9/9. Possibly an AI interaction timer. [0:10:00] — **med** that they count down; **low** on meaning.
- **Treaties:** the alliance/war display comes from each player's treaty array. A change has to be made on both players to stick, and player 0's copy gets overwritten from the opponents' side. [0:15:00] — **med**
- **Planet array size (save):** u16 = 108 (huge) or 24 (small). It sits right after the "player unknown" block and is preceded by a u16 zero. [0:20:00]–[0:25:00] — **high**
- **"Player unknown" block (save):** re-sized from 192 bytes (6 × 16 × 2) to 190 bytes (95 u16). 95 is not divisible by 6, so the block is not per-player. RAM and disk contents don't map one-to-one. [0:35:00]–[0:40:00] — **med**
- **Ship-route and transport array sizes:** two separate values at the end of the 411-word "unknown 3" block, e.g. 7 and 2 in one save, 15 and 0 in another. [0:20:00], [1:35:00] — **high**
- **Game settings block** (RAM name "game settings RAM", formerly "totally unknown 2"; heard at segment 4744, offset ~0x1C, low confidence). [0:25:00]–[1:15:00]
  - Field order in RAM, as heard: 343/340, 390/391, 9, 12, 3, 108, 0, 6. **The save stores the same words in reverse order.**
  - Map height and width: 340 and 391. These are the planet-coordinate extents of the galaxy map in world space, not bitmap size. Changing them stretches or compresses star placement, while the nebula background stays put. Which value is height and which is width was stated inconsistently. [0:50:00]–[0:55:00] — **high** that they are map extents; **low** on the height/width assignment.
  - Two unknowns that scale with galaxy size — small 4,6; medium 6,8; large 7,10; huge 9,12. They are not mineral or environment counts, and writing large values had no visible effect. [1:00:00]–[1:15:00] — **high** that they are galaxy-size dependent; meaning unknown.
  - Galaxy size enum: 0 small, 1 medium, 2 large, 3 huge. [1:05:00] — **high**
  - Planet array size: 108 for huge, 70 for large, 24 for small. Lowering it shrinks the planet list. [0:25:00], [1:15:00] — **high**
  - Difficulty enum: 0 simple, 1 easy, 2 average, 3 hard, 4 impossible. [0:45:00] — **high**
  - Player array size = 1 + number of opponents. [0:40:00]–[0:45:00] — **high**
- **Save tail region:** contains alphabet strings ("0–9 A–W", "…XYZ") that look like leftover garbage, and the string "scout" always appears near the end. [0:25:00], [1:15:00] — **low** (garbage hypothesis)
- **Order of blocks in the save:** planets → ships en route → ship transports → players → ships/research → events (the 411-word "unknown 3", plus the route and transport sizes) → player names (15 characters each) → "player unknown" → planet array size → game settings → galaxy map flags → planet populations → planet bases → planet factories → "scout"/garbage. [1:35:00]–[1:40:00], [1:55:00], [2:00:00] — **med–high**
- **Galaxy map flags:** 108 × signed 16-bit values, one per planet, holding the player index whose flag is drawn (-1 = none). They are drawn from the human player's point of view and refreshed at the next turn. The values are player indices, not race IDs. [1:20:00]–[1:35:00] — **high**
  - RAM: segment 6813, offset 0xC150. The first search wrongly gave 0xC40. In the save, flags come right after game settings.
  - Poking flags in RAM can add flags, but removing them by writing FF sometimes doesn't stick, and doing so caused a crash.
- **Planet populations:** 108 × u16 at RAM 6813:BDF0 (ends around BEC6). Only the human player's planets are filled, with values copied from the planet struct each turn. In the save it is the array after the flags. [1:45:00]–[1:55:00] — **high**
- **Planet base counts:** 108 × u16 at RAM 6813:BC40. In RAM it comes *before* populations; in the save it sits between populations and factories. Human player's planets only. [2:00:00]–[2:05:00] — **high**
- **Planet factory counts:** 108 × u16 at RAM 6813:BFA4. He first computed BFA2 and corrected it by one element. In the save it is the last array. Human player's planets only. [1:55:00]–[2:00:00] — **high**
- **Events block** (save "unknown 3", RAM "totally unknown" → typed as struct `events` of 411 u16 words) [2:10:00]–[2:15:00] — **high** that the block holds the events.
  - It starts with 40 and 30 (0x28, 0x1E) in every game. [2:10:00]
  - Near the end are signed values: index 119 is -1, and roughly 401–406 hold six -1/FF values, apparently one per player. [2:15:00]
  - Each event has its own fixed slot, so for example only one industrial accident can exist at a time unless more slots exist. [3:20:00]–[3:25:00] — **med**
  - Per-slot details are under Mechanics below; field names are under Named code/data.
- **Research breakthrough fields:** index 120 is the trigger for a research breakthrough (assumed boolean), 121 is the research field (enum of six fields). The tech ID within that field follows; he said "136", heard unclearly. Tech IDs depend on the field, so one enum can't cover them. [2:25:00]–[2:35:00] — **med**
  - Observed: force fields (index 2) + ID 4 = Class II Deflector Shields.
  - Weapons (5) + ID 5 = Gatling Laser.
  - Planetology + ID 5 = Improved Eco Restoration.
  - Force fields + ID 12 = Class V Planetary Shield.
  - Computers (0) + ID 4 = Deep Space Scanner, written by a tech exchange.
- **Map coordinate origin:** top-left of the map. [4:40:00] — **high**

## Findings — game mechanics & formulas
- **Planet-ID convention in events:** event planet fields index into the planets array. The race named in news text comes from the planet owner's player → race lookup. If the owner is -1, the text defaults to race 0 "Human", probably because a guard leaves the variable at 0. [3:50:00], [4:00:00] — **med**
- **News wording:** if the affected planet belongs to the human player, news says "astronomers" or "your"; otherwise it names the race. [4:05:00] — **med**
- **Quake:** index 27 = trigger (boolean, B914). Index 28 = player, which only affects the news text. Index 29 = planet ID. [3:05:00]–[3:10:00], [3:40:00] — **high**
  - Damage numbers (e.g. 16 population, 30 factories, "9 mil") are random. They are subtracted directly from the planet and not stored.
- **Nova (supernova):** index 30 = state (0 none, 1 triggered, 2 ongoing). Index 31 = unknown and apparently unused. Index 32 = planet ID. Index 33 = boolean, predicted vs averted. With state 2, turning index 33 off counts as success ("solar rejuvenator… saved"). [3:40:00]–[3:50:00] — **med**
- **Industrial accident:** index 35 = state (B924) with an enum of none, triggered, ongoing. Index 36 = unknown. Index 37 = planet ID. [3:10:00]–[3:20:00] — **high**
  - It persists at 2 until the waste is cleaned up, then returns to 0. The planet becomes "radiated" or polluted.
- **Assassination:** index 38 = trigger (B92A), index 39 = target player (the emperor), index 40 = assassin player (the ambassador). [3:20:00]–[3:30:00] — **med**
  - Setting it to 2 did not produce a success; every attempt failed and the success condition is unknown.
  - Assassin = target (0/0) is accepted without problems.
  - The target's race gets angry.
- **Computer virus:** index 41 = trigger, index 42 = player, index 43 = research field. [3:30:00]–[3:35:00] — **high**
  - It subtracts research points from that player's progress in the field. Progress is stored per player, not per planet.
  - Examples: 31 RP from force fields; computers reset from 70 to 0 while the news said "110".
- **Comet:** index 44 = state (0/1/2). Index 45 = unknown, possibly involved in success. Index 46 = planet ID. Index 47 = years to collision, counting down 1 per turn. [3:55:00]–[4:20:00] — **med**
  - Index 48 = destroy target (signed; 0 crashes the game).
  - Index 49 = destroy progress (signed). It goes up each turn by varying random-looking amounts (3, 14, 37, 57→74→82). When progress ≥ target, the comet is "destroyed".
  - Tests: target 10 was beaten at 27, and progress set to 499 against a target of about 500 also won. The captions say "5,000" in places, so treat the target value as low confidence.
  - Writing more than 32767 showed the fields are signed.
  - Another value (50) had no visible effect.
  - The comet does not appear on the map.
- **Pirates:** probable state slot at index ~50 (0/1/2; index not stated clearly). Index 51 = no effect. Index 52 = planet ID. Index 53 = pirate progress (signed). [4:20:00]–[4:30:00] — **med**
  - Progress starts at a random positive value and drops each turn. When it goes below 0 the pirates are "eliminated".
  - Ships orbiting the planet cleared them quickly.
  - Some percentage text ("by 0%") seen once is unexplained.
- **Derelict:** index 54 = "derelict found" trigger, index 55 = player who finds it. Gives "numerous weapon and shield technology secrets". [4:20:00], [4:30:00] — **high**
- **Space crystal:** [4:30:00]–[5:05:00] — **high**
  - Index 56 = state (0/1/2).
  - Index 57/58 = X/Y map coordinates. It is only drawn during turn processing, like ships.
  - Index 59 = wait counter (signed). While > 0 it waits; at ≤ 0 it moves to its target. After arriving it waits about 4 turns.
  - Index 60 = destroyed flag. When set, the news credits the human player's fleet whatever values are in the neighbouring fields.
  - Index 61 = target planet ID. Index 62 = planets visited.
  - It leaves the galaxy ("mysteriously disappeared") once visited ≥ 5.
- **Amoeba:** index 63 = state, followed by X/Y. He assumes the same layout as the space crystal (wait, destroyed, target, visited). [4:45:00], [5:05:00] — **med** (layout assumed)
- **Rebellion:** the rebellion news did not show up in the event block. Index 260 (RAM BAE6) toggled near a rebel event and took values 1/2, so it is not a boolean. BB72 counted down 16→5→…→0 with no visible effect. Possibly AI scheduling counters. [2:35:00]–[2:50:00] — **low**
- A crash with the message "colonies LBX entry 28 exceeds number of LBX entries" followed editing the 40/30 header words. The cause was not confirmed. [3:00:00] — **low**
- Population is capped to the planet maximum when the array is copied each turn (e.g. 200 → 25). [1:50:00] — **med**

## Named code/data
All are data symbols; no functions were named this session.

**Player struct and game settings**
- Player struct: personality, objective. [0:05:00]
- `game settings RAM` / `game settings on disk` (formerly totally unknown 2). Fields: galaxy map height, galaxy map width, two unknowns, galaxy size, planet array size, difficulty, player array size. Segment 4744 (low confidence). [0:30:00]–[0:55:00]

**Per-planet arrays (segment 6813)**
- `galaxy map flags` — 6813:C150. Struct of signed 16, enum = player / planet colonizers. [1:30:00]
- `planet populations` — 6813:BDF0. [1:45:00]
- `planet factory counts` — 6813:BFA4. [2:00:00]
- `planet mystery` → base counts — 6813:BC40. [2:05:00]

**`events` struct** (411 × u16) [2:10:00]–[5:05:00]

| Index | Name as heard | Notes |
|---|---|---|
| 27 | trigger quake | B914 |
| 28 | quake player | |
| 29 | quake planet ID | |
| 30 | nova state | |
| 32 | nova planet ID | |
| 33 | nova predicted | |
| 35 | industrial accident state | B924 |
| 37 | industrial accident planet ID | |
| 38 | trigger assassination | B92A |
| 39 | assassination target player | |
| 40 | assassin player | |
| 41 | trigger computer virus | |
| 42 | computer virus player | |
| 43 | computer virus research field | |
| 44 | comet state | |
| 46 | comet planet ID | |
| 47 | comet collision years | |
| 48 | comet destroy target | |
| 49 | comet destroy progress | |
| ~50 | pirate state | index not clearly stated |
| 52 | pirates planet ID | |
| 53 | pirate progress | heard as "pirates present", then renamed |
| 54 | derelict found trigger | |
| 55 | derelict player | |
| 56 | space crystal state | |
| 57 / 58 | space crystal X / Y | |
| 59 | space crystal target turn/progress | comment: >0 means don't move |
| 60 | space crystal destroyed | |
| 61 | space crystal target planet ID | |
| 62 | space crystal planets visited | |
| 63 | amoeba state | + X/Y and the same fields |
| 120 | trigger research breakthrough | |
| 121 | research breakthrough field | |

**New enums:**
- personality types
- objective types
- galaxy size
- game difficulty
- research fields
- industrial accident states
- nova states
- comet states
- pirate states
- space crystal states

## Open questions / unresolved
- Meaning of the per-player countdown fields, and where report age ("18 years old") is stored. [0:10:00]
- The galaxy-size-dependent pair (4/6, 6/8, 7/10, 9/12). [1:15:00]
- Where the nebula background is stored, or whether it is generated from a seed. [0:50:00], [1:40:00]
- Contents of the "player unknown" block (95 words). [0:40:00]
- Why separate population, base and factory arrays exist only for the human player. [1:55:00]
- What the 40/30 header words of the events block mean. [2:50:00], [3:00:00]
- The unused word between each event's trigger and planet ID (indexes 31, 36, 45, 51). [3:40:00]
- What makes an assassination succeed. [3:30:00]
- What drives comet destroy progress. [4:20:00]
- The pirate "percent" message. [4:25:00]
- Whether events have more than one slot each. [3:25:00]
- Events not yet located: plague, population boom, mineral up/downgrade, wealthy merchant, mysterious explosion, rebellion. [4:35:00], [2:35:00]
- The cause of the "colonies LBX entry 28" crash. [3:00:00]
- Tool to-dos:
  - search in the save viewer
  - red change-highlighting in the memory view
  - snapshot/diff of values over time (suggested by chat)
  - the segment bug
  - the -1 enum lookup bug
  [1:20:00], [1:35:00], [3:15:00]

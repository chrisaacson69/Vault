---
status: active
created: 2026-05-13
---
# Chapter 7 — The SRAM Save Layer

> The 8 KB battery-backed PRG-RAM at $6000-$7FFF holds the game's complete persistent state — every province, every daimyo, every name. This chapter decodes it field-by-field using live SRAM dumps from a 17-fief Tokugawa playthrough. We find: a 26-byte province record matching the ROM defaults exactly (with an LE/BE byte-swap during boot), a 7-byte daimyo record packing age + 5 attributes, parallel name tables indexed by clan and province ID, and a $7FXX "transient UI cache" region whose contents (like the frame counter at $7FE9) get rewritten every frame and are zeroed at boot.

**Links:** [Chapter 4 — Syscall API](./04-syscall-api.md) (SRAM I/O via syscalls $15/$16) · [Chapter 5 — Bytecode VM](./05-bytecode-vm.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Nobunaga README](./README.md)

## The save problem

Nobunaga's Ambition is a turn-based strategy game with 17 (or 50) provinces, ~17 active daimyo clans, and ten-plus attributes per fief — plus a player-specific layer (personal stats, current location, treasury). All of it must survive a power-off. The MMC1 SOROM board provides exactly this: 8 KB of battery-backed PRG-RAM mapped at $6000-$7FFF. The cartridge's iNES header declares battery support, which is why Mesen creates a `.sav` file automatically when the user invokes the game's in-game Save option.

Chapter 4 documented the **two SRAM syscalls** that mediate access:
- `syscall_set_chr_bank0_reg` ($15 → $C60C) — opens/closes the MMC1 WRAM-enable bit
- `syscall_sram_block_with_checksum` ($16 → $C5AA) — reads or writes a block via a staging buffer at $0200, computing a 16-bit checksum

These are exclusively invoked from VM bytecode (no native code calls them directly). The syscalls bracket every save operation with WRAM enable/disable to prevent stray writes from corrupting the save during normal gameplay.

This chapter decodes **what** the bytes actually mean.

## Method note — capturing live SRAM

Chapter 4's `.sav` lifecycle was confirmed during this investigation: Mesen writes the `.sav` file only when the user **reloads the ROM** (Tools → Reload ROM). Save states (`.mss`) and even the game's own Save menu don't flush the `.sav` — they require a full ROM reload. This is awkward for iterative inspection.

The breakthrough was **reading SRAM directly in Mesen's Memory Viewer** (Save RAM tab). Mesen exposes the live PRG-RAM bytes at any moment, indexed from $0000 (= CPU $6000). This is faster than the `.sav` route and lets us watch values change in real time as we play.

Three artifacts were produced this session, all stored in the project folder for cross-reference:
- `sram-50fief-invaded.sav` — early 50-fief scenario state
- `sram-current.sav` and `sram-mikawa-rice-given.sav` — 17-fief Tokugawa state at various turn counts
- Inline pastes from the live Memory Viewer (the highest-fidelity captures)

## The SRAM memory map (17-fief scenario)

| Region | Content | Confidence |
|---|---|---|
| **$6000-$6019** | 26-byte preamble — possibly a header / global game state (we see partial Tokugawa stats here, mixed order, suggesting **live UI cache**) | high (region type), low (field meanings) |
| **$601A-$62F1** | **Province table — 50 records × 26 bytes each.** NOT 17 records: the "17-fief scenario" is a 17-province *window* into the full 50-province map of Japan. Records 0-16 are the playable fiefs; records 17-49 are the rest of Japan (unnamed, non-playable background territory). This mirrors the ROM defaults table layout exactly. | **decoded** |
| **$62F2-$74CF** | Dense game state — daimyo records, additional per-province data, scenario leftovers | partial |
| **$74D0-$752E** | Zeros / unused | high |
| **$752F-$75A6** | **Daimyo table** — 17 records × 7 bytes each | **decoded** |
| **$75A7-$76FF** | Zeros / unused in 17-fief (used in 50-fief for additional daimyo records) | high |
| **$7700-$77A6** | 5-byte daimyo records left over from 50-fief, mostly $14-filled in 17-fief | high |
| **$77A8-$78??** | **Daimyo name table** — 17 names × 9 bytes (8 chars + null pad) | **decoded** |
| **$78??-$7BFF** | **Province name table** — 17 names × 9 bytes (or similar) | **decoded** |
| **$7C00-$7E2D** | Map tile data — 558 bytes of background tile indices for the strategic map view | structural |
| **$7E2E-$7F00** | Map color/palette index data | structural |
| **$7F00-$7FFF** | **Transient UI cache** — frame counter at $7FE9, status flags, animation timing, menu position, etc. Zeroed at boot ($7FE7, $7FC7, $7FD3, $7FD1 explicitly cleared in the boot bytecode) | **decoded** (region type) |

The boundary between "canonical game state" and "UI cache" runs roughly at $7C00. Everything before is data that must survive a save; everything after is recomputable from the canonical state plus per-frame inputs.

## The province record (26 bytes)

**Mikawa's record at $60B6**, captured from the live Memory Viewer at turn ~2:

```
Offset  Bytes      16-bit BE   Field        Notes
$60B6   07 02      $0702=1794  header       base koku — Mikawa was a historically rich province
$60B8   00 00      $0000=0     debt         "
$60BA   00 42      $0042=66    town         "
$60BC   00 2B      $002B=43    rice         (player gave rice this turn, dropped from 75)
$60BE   00 88      $0088=136   output       
$60C0   00 40      $0040=64    dams         
$60C2   00 4E      $004E=78    loyalty      
$60C4   00 5E      $005E=94    wealth       
$60C6   00 47      $0047=71    men          
$60C8   00 4B      $004B=75    morale       
$60CA   00 4A      $004A=74    skill        
$60CC   00 49      $0049=73    arms         
$60CE   00 F4      $00F4=244   footer       hypothesis: annual income or computed yield
```

**Three structural notes:**

1. **Gold is NOT in the province record.** The player's gold appears to be stored separately (chapter 8's job to locate exactly where). Province "wealth" is a different thing — it represents the *province's economic capacity*, not the daimyo's treasury.

2. **The header (base koku) is per-province** and lines up with historical Sengoku reality. Mikawa = 1794, which matches Mikawa's well-known high-yield rice fields. Other provinces seen: Echigo $074F=1871 (Uesugi Kenshin's heartland), Kaga $063D=1597, Echizen $0671=1649 (Asakura), Hida $064F=1615 (mountain province, lower), Suruga $063B=1595 (Imagawa). The footer at the end varies similarly.

3. **The province record table is much larger than 17.** It runs from $B002 to
   the daimyo-table marker at $B530 — `$B002 + 51×26 = $B530` exactly, so the
   table is 51 fixed-size records. The "17-fief scenario" activates only records
   0-16 (the 17 named, playable provinces); records 17-50 are the rest of Japan's
   provinces, present as unnamed/non-playable background. The header field
   confirms this: index 0 (Hatakeyama/Noto) is `0` and the other 16 playable
   provinces start at `1000`, while the background provinces carry larger
   `3000/7000/4500/2500` values — established AI territory with pre-built
   stockpiles. The header is **dynamic** (Mikawa's grew 1000 → 1794 across two
   turns of play), most likely an accumulated rice/koku stockpile. This is the
   **generic-engine pattern** seen in chapters 4-5: one large world engine,
   scenario-parameterized for which provinces are active. Index 7 = Mikawa.

## The ROM defaults table (LE in ROM, BE in SRAM)

The same 26-byte province format exists **twice in PRG-ROM** — once per scenario:

- **17-fief scenario** at bank 3, CPU `$9258`
- **50-fief scenario** at bank 3, CPU `$B0BE`

Mikawa's defaults at `$9258` (17-fief):

```
$9258   20 03            $0320 = 800       header (different from runtime 1794 — likely
                                              modified on game start based on scenario parameters)
$925A   45 00            gold = 69         (the LE encoding stores low byte first)
$925C   00 00            debt = 0
$925E   42 00            town = 66
$9260   4B 00            rice = 75
$9262   50 00            output = 80
$9264   50 00            dams = 80
$9266   4C 00            loyalty = 76
$9268   4D 00            wealth = 77
$926A   47 00            men = 71
$926C   4B 00            morale = 75
$926E   4A 00            skill = 74
$9270   49 00            arms = 73
$9272   E8 03            $03E8 = 1000      next record's header
```

All 12 starting stats match user-reported turn-1 values **exactly in display order**. The ROM defaults exist as a separate template (`$9258` for 17-fief, `$B0BE` for 50-fief), and the boot bytecode initializes SRAM by copying from this template.

**The byte-order quirk:** ROM stores stats little-endian (value, then $00). SRAM stores them big-endian ($00, then value). The boot bytecode that copies ROM → SRAM swaps bytes per field. This is a small but real engine detail — likely an artifact of how the 6502 reads operands (LSB first) being inverted by the copy routine's instruction order.

The ROM defaults include `gold` at field 1 (between header and debt), but the runtime SRAM **omits gold from the province record** — supporting the hypothesis that gold is migrated to a daimyo-scoped or player-scoped location at boot. The defaults table is a static "starting condition" snapshot, not a structural mirror of the live record.

## The daimyo record (7 bytes)

**17-fief table at $752F-$75A6**, 17 records × 7 bytes each.

The user's Tokugawa character: age=18, H=97, D=94, L=69, Ch=82, IQ=84.

```
$7560:  12 61 5E 3A 52 54 00
         ↑   ↑  ↑  ↑  ↑  ↑  ↑
         |   H  D  L  Ch IQ status
         age = $12 = 18  ✓
         H   = $61 = 97  ✓
         D   = $5E = 94  ✓
         L   = $3A = 58  (drifted from 69 during play — luck decreases over turns)
         Ch  = $52 = 82  ✓
         IQ  = $54 = 84  ✓
```

**Record layout (7 bytes):**

| Byte | Field | Range | Notes |
|---|---|---|---|
| 0 | **age** | $0B-$29 (11-41) | Sengoku-era ages; matches historical daimyo birth dates relative to 1560 scenario |
| 1 | **Health** | $39-$78 (57-120) | NPC clans can exceed 100; player capped at 99 |
| 2 | **Drive** | $29-$76 (41-118) | "Motivation" — affects AI behavior intensity |
| 3 | **Luck** | $1F-$72 (31-114) | Fluctuates between turns from random events |
| 4 | **Charisma** | $25-$72 (37-114) | Affects loyalty of subordinates and diplomacy |
| 5 | **IQ** | $46-$75 (70-117) | Affects strategy quality |
| 6 | **Status** | usually $00 | $01 seen for one record (Saito, rec 8) — likely "dead" or "special state" flag |

**Tokugawa is at index 7** in the 17-fief daimyo table (matching the name "Tokugawa" at $77E7 in the name table, also index 7). The two tables are parallel: `record[N] in $752F` and `name[N] in $77A8` describe the same clan.

### Cross-clan stat ranges (verified from this scenario)

| Clan | rec @ | age | H | D | L | Ch | IQ |
|---|---|---:|---:|---:|---:|---:|---:|
| Hatakeyama | $752F | 21 | 100 | 86 | 84/86 | 52/54 | 75 |
| Uesugi | $7536 | 30 | 87 | 111 | 92/94 | 118 | 115 |
| Hojo | $753D | 22 | 96 | 109/110 | ?? | ?? | ?? |
| Honganji | $7544 | 30 | 88 | 101 | 82 | 85 | 70 |
| Asakura | $754B | 27 | 78 | 108 | 105/111 | 91 | 106 |
| Anekoji | $7552 | 20 | 95 | 90 | 41/43 | 115 | 93 |
| Imagawa | $7559 | 41 | 57 | 118 | 28/24 | 93/94 | 96 |
| **Tokugawa** | **$7560** | **18** | **97** | **94** | **58-69** | **82** | **84** |
| Saito | $7567 | 28 | 53 | 55 | 37 | 51 | 61 (status flag $01) |
| Tsutsui | $756E | 11 | 91 | 57/59 | ~92 | 60 | 86 |

(Some fields drift between turns due to random events; ranges reflect what's observed in two saves.)

The historical accuracy is striking: Tokugawa Ieyasu (born 1542) = 18 years old in 1560; Uesugi Kenshin = 30; Imagawa Yoshimoto = 41 (he died at the Battle of Okehazama at 41 in 1560, the game's scenario start). The age field IS historical age in the year 1560, the scenario base year.

## How daimyo matches fief: shared index

The province table and the daimyo table are **aligned by index** — `daimyo[N]` owns `province[N]` at game start. There is no explicit "owner" field in the province record; ownership is implicit in the table position.

This was verified against history for all 17 of the 17-fief clans:

| idx | daimyo | province | historical check |
|---:|---|---|---|
| 0 | Hatakeyama | Noto | ✓ Hatakeyama held Noto — the weakest start (base koku 0) |
| 1 | Uesugi | Echigo | ✓ Uesugi Kenshin's domain |
| 2 | Hojo | Musashi | ✓ Hojo controlled the Kanto |
| 3 | Honganji | Kaga | ✓ the Ikko-ikki "peasant kingdom" |
| 4 | Asakura | Echizen | ✓ |
| 5 | Anekoji | Hida | ✓ |
| 6 | Imagawa | Suruga | ✓ Yoshimoto's base |
| 7 | Tokugawa | Mikawa | ✓ Ieyasu's home province |
| 8 | Saito | Mino | ✓ |
| 9 | Tsutsui | Yamato | ✓ |
| 10 | Asai | Omi | ✓ |
| 11 | Rokkaku | Iga | ✓ (Rokkaku held southern Omi adjacent to Iga) |
| 12 | Kitabatake | Iseshima | ✓ |
| 13 | Ashikaga | Yamashiro | ✓ the shogunate, in Kyoto |
| 14 | Miyoshi | Settsu | ✓ |
| 15 | Takeda | Shinano | ✓ Shingen's conquest |
| 16 | Oda | Owari | ✓ Nobunaga's home province |

17 of 17 correct. **There is no "special" leading record.** Every table — daimyo
records, daimyo names, province records, province names — is dense from index 0.
Index 0 is simply the weakest clan, Hatakeyama, whose province (Noto) has a base
koku header of 0. The real table anchors are $752F (SRAM) / $B532 (ROM) for the
daimyo records — exactly the $B532 the earlier draft tried to skip past.

The 0F 27 (= 9999) sentinel sits immediately *before* the daimyo table, so the
table genuinely begins at $B532; the sentinel is a table-boundary marker, not a
record. An intermediate revision mistook index 0 for a neutral template slot and
re-anchored all four tables one record late — relative pairings still matched, so
the error hid until the last real clan (Oda) appeared to spill past the table end
into garbage. With the dense anchors, Oda lands cleanly at index 16, the 17th and
final clan, exactly where an in-game start shows him.

The 50-fief scenario has the identical structure: 50 dense entries, index 0 =
Kakizaki/Ezo (header 0), index 49 = Shimazu/Satsuma.

## The name tables (parallel-indexed by clan/fief ID)

Names are stored in fixed-length slots — **daimyo names in 9-byte slots, province names in 10-byte slots** (ASCII chars + null pad), one slot per clan/fief, indexed identically to the records they describe.

### Daimyo name table at $77A8 (17 entries)

```
$77A8: Hatakeyama (truncated to 8 chars)
$77B1: Uesugi
$77BA: Hojo
$77C3: Honganji
$77CC: Asakura
$77D5: Anekoji
$77DE: Imagawa
$77E7: Tokugawa     ← index 7 = player
$77F0: Saito        ← index 8
$77F9: Tsutsui
$7802: Asai
$780B: Rokkaku
$7814: Kitabatake
$781D: Ashikaga
$7826: Miyoshi
$782F: Takeda
$7838: Oda          ← Nobunaga's clan
```

### Province name table

17 historical Sengoku provinces, in 10-byte slots:
```
Noto, Echigo, Musashi, Kaga, Echizen, Hida, Suruga, Mikawa, Mino,
Yamato, Omi, Iga, Iseshima, Yamashir(o), Settsu, Shinano, Owari
```

Mikawa is **index 7** in the province name list — matching the user's "fief 8" display (1-indexed) and the province record location at $6000 + 7*26 = $60B6 (so the record table is 0-indexed, naming list is 0-indexed, UI is 1-indexed; standard off-by-one).

## The "transient UI cache" region ($7F00-$7FFF)

A handful of distinctive runtime-only behaviors confirmed:

- **$7FE9 — frame counter / animation tick.** The user observed this byte counting (incrementing) when the game was unpaused, stable when paused. Consistent with a 60Hz tick that drives sprite animations, cursor blinking, music timing, menu opening transitions, etc.
- **$7FE7, $7FC7, $7FD3, $7FD1 — status flags.** Boot bytecode explicitly zeroes all four on game start (chapter 6 finding). Likely include "paused," "in-menu," "in-combat," "music-driver-active."
- **$7FCD-$7FEA range — frequent read/write traffic during play** (observed in Mesen). The whole upper-trailer region is per-frame transient state.
- **Boot bytecode zeroes this region**, so save-and-restore doesn't preserve UI position — only canonical state survives a power cycle. The game rebuilds the UI cache from the canonical tables on every game start.

This is good design: the **save layer** is just the canonical state; the **runtime layer** lives in this transient region and is rebuilt as needed. It keeps the save file small (8 KB suffices for a complex strategy game) and makes save migration robust.

## Erratum to chapter 6

The chapter 6 disassembler reading of `load_word_A8 $7FE7` was **not** a read — it's a **write** of `$08/$09` to the address. With `clear_aux_ptr` ($08/$09 = 0) preceding each `load_word_A8`, the boot is **zeroing** four specific SRAM addresses ($7FE7, $7FC7, $7FD3, $7FD1) — the UI-state flags described above. Already noted; chapter 6's labels TOML is correct.

## Chapter-1 to chapter-6 alignment

This chapter rounds out the project's structural picture. Each kernel/runtime layer documented in chapters 1-6 has a corresponding place in the save:

| Chapter | Layer | SRAM region |
|---|---|---|
| 1, 4 | Kernel + syscalls | (none — kernel state is in $0050-$0065 + ZP scratch, not SRAM) |
| 3 | Music driver | $0700-$0760 (in main RAM, not SRAM) |
| 5, 6 | VM | (none — VM frame is on the active stack at ptr1, not in SRAM) |
| **7** | **Game state** | **$6000-$7BFF (canonical), $7F00-$7FFF (transient)** |

The save's job is to capture **game state** — what makes one game-in-progress different from another. The VM bytecode and kernel are constants (in PRG-ROM and PRG-ROM); they don't need to be saved.

## Open questions for chapter 8+

- **Gold storage location.** Player's gold (2 at the time of capture) is not in the province record. Likely in the daimyo-scoped data, possibly a per-player record near $7500 or extending the daimyo record format.
- **Footer semantics.** Each province record ends with a 16-bit value (Mikawa = 244). Likely a derived/computed field — maybe annual gold income produced, or a function of (rice × output × loyalty / 100). Confirm by running one turn and seeing if gold increases by exactly 244.
- **Secondary table at $61D4-$629F.** 17 more 26-byte records with much higher headers ($0B00-$0B23 range). Probably **per-fief military / production capacity / NPC posture**. Each daimyo's "current army" might live here, separate from the per-fief "infrastructure" stats.
- **Market prices** (rate=1.0, rice=1.4, arms=2.8, men=3.0, ninja=1.9) — user reports these fluctuate, so they're in SRAM somewhere, but our partial paste didn't surface them. Probably in the $6Dxx or $6Fxx dense-but-uncategorized regions. Will follow up.
- **Map data at $7C00-$7E2D** — 558 bytes of tile indices. Likely a 18×31 strategic-map grid. Chapter 8 (province table + map) can decode the rendering.
- **Save validation** — `syscall_sram_block_with_checksum` (chapter 4) computes a 16-bit checksum. Where is the checksum stored? Likely at a known offset (maybe $7FFC-$7FFD or similar trailer). Chapter 8 can chase.

## Method note — runtime SRAM dumps are the productivity unlock

The chapter 4-6 chapters all relied on Mesen trace logs. Chapter 7 needed a different artifact: byte-level memory snapshots at known game moments. The Memory Viewer's Save RAM tab is the right tool for this.

For future chapters that need to find **specific data structures** rather than **specific code paths**:
- Take a base snapshot at one game state
- Make ONE controlled change in-game
- Take a second snapshot
- Diff the byte arrays

The byte that changed by the amount the UI shows is the field. Two snapshots and a diff replaces hours of static disassembly. This is the same methodology the user used for the rice-give test in this session.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [save-format](../../../tags/save-format.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

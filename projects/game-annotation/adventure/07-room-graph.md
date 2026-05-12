---
status: active
created: 2026-04-26
---
# Adventure — Room Graph & Level Differences
> 31 rooms, 4-way adjacency, three game variants encoded in 18 bytes of overrides. Same 9-byte record format as the object table — the engine reuses one multiplication routine for both worlds.

**Links:** [Adventure README](./README.md), [Memory Map](./01-memory-map.md), [Sprite Multiplexing](./03-sprite-multiplexing.md), [Movement & Collision](./04-movement-collision.md), source: [`raw/adventure.asm`](../../../raw/adventure.asm)

## The room record

From the comment block at line 2685, every room record is **9 bytes**:

| Offset | Field |
|---|---|
| 0–1 | Pointer to room graphics data (low/high) |
| 2 | Color |
| 3 | B&W Color |
| 4 | CTRLPF (bits 5–0) + thin-wall flags (bits 6–7) |
| 5 | Room Above |
| 6 | Room Left |
| 7 | Room Down |
| 8 | Room Right |

**Same record size as the object table.** Both worlds — the static room map and the dynamic object roster — use 9-byte records. That means **one indexing routine** can address both, just with different base addresses.

## The 9-byte trick — `RoomNumToAddress`

Multiplying by 9 has no single 6502 instruction. Robinett's solution (line 477):

```asm
RoomNumToAddress:
       STA    $D8                 ;save room number
       STA    $93
       LDA    #$00
       STA    $94
       CLC
       ROL    $93                 ;×2
       ROL    $94
       ROL    $93                 ;×4
       ROL    $94
       ROL    $93                 ;×8
       ROL    $94
       LDA    $D8                 ;original room
       CLC
       ADC    $93                 ;×8 + ×1 = ×9
       STA    $93
       LDA    #$00
       ADC    $94
       STA    $94
       LDA    #<RoomDataTable
       CLC
       ADC    $93                 ;add base address
       STA    $93
       LDA    #>RoomDataTable
       ADC    $94
       STA    $94
       RTS
```

Three `ROL` pairs to shift left 3 times (multiply by 8), then add the original to get ×9. Result: `$93/$94` points to the room's record in `RoomDataTable`. Same recipe `CacheObjects` uses (chapter 3) for object indexing — except `CacheObjects` uses an 8-bit running index and `ADC #$09` instead of multiplication, since it's stepping through entries sequentially. Two different access patterns, same record stride.

## The 31 rooms

`RoomDataTable` (line 2698) holds 31 rooms (indices `$00`–`$1E`):

| Index | Name | Notes |
|---|---|---|
| `$00` | Number Room | Game-variant display at start |
| `$01`–`$02` | Below Yellow Castle | Top access path |
| `$03` | Left of Name | The room with the Easter egg trigger |
| `$04`–`$08` | Blue Maze | Top, #1, Bottom, Center, Entry |
| `$09`–`$0B` | Invisible Maze | "Catacombs" — low-contrast walls |
| `$0C`–`$0D` | Side Corridors | |
| `$0E` | Top Entry Room | |
| `$0F` | White Castle | |
| `$10` | Black Castle | |
| `$11` | Yellow Castle | |
| `$12` | Yellow Castle Entry | |
| `$13`–`$16` | Black Maze | The dot's hideout |
| `$17`–`$1A` | Red Maze | |
| `$1B` | Black Castle Entry | |
| `$1C` | Other Purple Room | |
| `$1D` | Top Entry Room (Red variant) | |
| **`$1E`** | **Name Room** | **The Easter egg signature room** |

The naming pattern reflects geography — "Top of Blue Maze" / "Bottom of Blue Maze" / "Center of Blue Maze" — Robinett labeled rooms by their *function in the world* rather than just numbering them. The .asm symbols (e.g., `BlueMazeTop`, `CastleDef`) make the source readable as a *map description*.

### Castle rooms share graphics

Three castles all use `CastleDef` as their graphics pointer:

```
LFEA2: .byte <CastleDef,>CastleDef,  $0C,$0C,$21,$0E,$0F,$0D,$0F  ;0F White
LFEAB: .byte <CastleDef,>CastleDef,  $00,$02,$21,$01,$1C,$04,$1C  ;10 Black
LFEB4: .byte <CastleDef,>CastleDef,  $1A,$0A,$21,$06,$03,$02,$01  ;11 Yellow
```

**One graphic, three castles, distinguished by color.** Yellow has color `$1A`, White `$0C`, Black `$00`. The castle outline is identical; the COLUPF write makes them look different. Cost: zero per castle for graphics; one byte for color.

### The Invisible Maze isn't actually invisible

Rooms `$09`–`$0B` (and `$13`–`$16` for the Black Maze) have CTRLPF byte `$25`/`$24` and color `$08` (light gray). Background is also `$08` per the kernel's setup. So the walls are drawn in light gray on light gray background — visible but **low-contrast**. The "invisible" name is design folklore; the implementation is just same-color foreground/background.

## Adjacency — the 4-direction model

Each room's bytes 5–8 are room indices for Above/Left/Down/Right. Walking off an edge calls `GetNewRoom` (chapter 4):

```asm
GetNewRoom:
       LDA    VSYNC,X             ;current room
       JSR    RoomNumToAddress    ;point $93/$94 at record
       LDA    ($93),Y             ;Y = 5/6/7/8 = direction
       JSR    AdjustRoomLevel     ;handle level differences
       STA    VSYNC,X             ;new room
```

Y is the direction code: `5` = up, `6` = right, `7` = down, `8` = left. Read the byte at that offset, that's your destination. Simple, except…

## The `$80` flag — game variants in 6 markers + 18 bytes

Some adjacency entries have bit 7 set (values `$80`+):

```
LFE24: BelowYellowCastle, ..., $08,$02,$80,$03  ;01; Down = $80 (variant!)
LFE2D: BelowYellowCastle, ..., $11,$03,$83,$01  ;02; Down = $83
LFE36: LeftOfName,        ..., $06,$01,$86,$02  ;03; Down = $86
LFF0E: TwoExitRoom,       ..., $89,$89,$89,$89  ;1B; All 4 = $89 (variant for everything!)
LFF17: NumberRoom,        ..., $1D,$07,$8C,$08  ;1C; Down = $8C
LFF20: TopEntryRoom,      ..., $8F,$01,$10,$03  ;1D; Up = $8F (variant!)
```

`AdjustRoomLevel` (line 1218) handles them:

```asm
AdjustRoomLevel:
       CMP    #$80                ;flag bit set?
       BCC    AdjustRoomLevel_2   ;no → use as-is
       SEC
       SBC    #$80                ;strip flag
       STA    $D8
       LDA    $DD                 ;level (stored as 0/2/4)
       LSR                        ;÷2 → 0/1/2
       CLC
       ADC    $D8                 ;index into RoomDiffs
       TAY
       LDA    RoomDiffs,Y         ;real destination for this level
AdjustRoomLevel_2:
       RTS
```

And `RoomDiffs` (line 2733):

```asm
RoomDiffs:
LFF32: .byte $10,$0F,$0F          ;$80 flag → Down from Room 01: L1=$10, L2=$0F, L3=$0F
LFF35: .byte $05,$11,$11          ;$83 flag → Down from Room 02
LFF38: .byte $1D,$0A,$0A          ;$86 flag → Down from Room 03
LFF3B: .byte $1C,$16,$16          ;$89 flag → Room 1B (all 4 directions)
LFF3E: .byte $1B,$0C,$0C          ;$8C flag → Down from Room 1C
LFF41: .byte $03,$0C,$0C          ;$8F flag → Up from Room 1D
```

**18 bytes total** (six entries × three levels each). Plus the 6 in-room markers (`$80`, `$83`, `$86`, `$89`, `$8C`, `$8F`). Twenty-four bytes encode the entire **three-game-variant adjacency system**.

### What changes between game variants

Looking at RoomDiffs:

| Marker | Direction | Level 1 → | Level 2/3 → |
|---|---|---|---|
| `$80` | Down from Room 01 | Room `$10` (Black Castle) | Room `$0F` (White Castle) |
| `$83` | Down from Room 02 | Room `$05` (Blue Maze) | Room `$11` (Yellow Castle) |
| `$86` | Down from Room 03 | Room `$1D` (Top Entry) | Room `$0A` (Maze Entry) |
| `$89` | Room 1B (all 4) | Room `$1C` (Purple) | Room `$16` (Black Maze Entry) |
| `$8C` | Down from Room 1C | Room `$1B` (Black Castle Entry) | Room `$0C` (Side Corridor) |
| `$8F` | Up from Room 1D | Room `$03` (Left of Name) | Room `$0C` (Side Corridor) |

**Level 1 (Game 1)** is the easy "simple kingdom" layout — the rooms connect to castles directly. **Levels 2/3** rewire the world to push you through mazes. The "harder" Adventure isn't just faster dragons (chapter 6) — it's a **structurally different map**.

### `LFF0E` (Room $1B Black Castle Entry) is the most-rewired

All four adjacencies are `$89` — every direction out of Room `$1B` is variant-controlled. In Level 1 you exit to Room `$1C` (a connecting room). In Levels 2/3 you exit to Room `$16` (Black Maze Entry — a much more complex space). This single 4-byte cluster reshapes a whole region of the map.

## The "thin wall" flags in CTRLPF

Bits 6 and 7 of the CTRLPF byte aren't TIA hardware bits — they're Adventure's own per-room flags. From `SetupRoomPrint` (line 280):

```asm
       LDY    #$04
       LDA    ($93),Y             ;CTRLPF byte
       STA    CTRLPF              ;low 6 bits → TIA's CTRLPF register (mirror, score, etc.)
       AND    #$C0                ;extract upper 2 bits (thin-wall flags)
       LSR  LSR  LSR  LSR  LSR    ;shift bit 6 down to bit 1
       STA    ENAM1               ;right thin wall (missile 1 enabled?)
       LSR
       STA    ENAM0               ;left thin wall (missile 0 enabled?)
```

So one byte does double duty: bits 0–5 configure TIA's CTRLPF (mirror, score, ball width); bits 6–7 enable Adventure-defined thin walls via M0/M1. The same architectural compaction principle as the entire engine: pack two pieces of state into one byte by exploiting which bits are unused by the canonical use.

## The hidden-room jump revisited

From chapter 4, in `MoveGroundObject`'s right-edge handler:

```asm
       LDA    VSYNC,X             ;current room
       CMP    #$03                ;Room "Left of Name"?
       BNE    DealWithRight_3     ;no → normal right-exit
       LDA    $A1                 ;Black Dot's room
       CMP    #$15                ;Black Maze #3 (the Dot's hideout)?
       BEQ    DealWithRight_3     ;yes → dot still hidden → normal exit
       
       ;Hidden-room override: jump straight to Room $1E (Name Room)
       LDA    #$1E
       STA    VSYNC,X
       LDA    #$03
       STA    VBLANK,X
       JMP    MovementReturn
```

So Room `$1E` (Name Room) is **not reachable by normal adjacency**. Only the override path leads there, and only if the Black Dot has been moved *out* of Room `$15`. This is the Easter egg pathway.

The condition makes sense: the Dot starts in Room `$15` (hidden inside a wall in the Black Maze). The player has to find it (it's a single dark pixel against the dark maze) and use the Magnet to extract it from the wall. Once the Dot is no longer in Room `$15`, walking right from Room `$03` (which would normally lead somewhere via the standard adjacency) instead **teleports** to the Name Room.

Chapter 8 will trace the full sequence. For now: **the entire Easter egg gating is 4 lines of assembly** — `CMP #$15 / BEQ skip / LDA #$1E / STA VSYNC,X`.

## The Number Room and game start

Room `$00` (Number Room) has all-zero adjacency — `$00, $00, $00, $00`. You can't walk out of it. It's the room shown at game start displaying which game variant you're playing. The game's first action moves the man out of this room into the actual playable world.

Room `$1C` ("Other Purple Room") also uses `NumberRoom` graphics — sharing the same wall layout but in a connected position. Recycling room graphics across rooms with different topology is another texture-of-byte-saving in this chapter.

## Efficiency catalogue (chapter 7 entries)

- **Room records share the 9-byte format with object records.** One stride, one indexing recipe (`ROL ROL ROL + ADC original`), reused across both worlds.
- **31 rooms in 31 × 9 = 279 bytes.** The entire world map fits in less than a quarter of one of today's HTML files.
- **Three game variants in 24 bytes** (6 markers + 18 RoomDiffs entries). Adventure ships three structurally different worlds for the cost of one.
- **One graphics asset per visual** (CastleDef shared across 3 castles, NumberRoom across 2 rooms). Color overrides do the differentiation.
- **CTRLPF byte does double duty** — TIA configuration in low 6 bits, Adventure's thin-wall flags in upper 2 bits. The TIA happens to ignore those bits, so they're free real estate.
- **Same `AdjustRoomLevel` routine handles all variant lookups.** No special-case code per "variant room" — the `$80` flag drives the same dispatcher every time.
- **Easter egg gating in 4 lines of assembly.** A condition that looks like a major design feature is one byte comparison and one branch.
- **The Invisible Maze is drawn the same as any room** — just with foreground color matching background. No special "invisible" code path.

## What this confirms about earlier chapters

- **Chapter 1's "9-byte object table records"** finding now has a sibling: room records are also 9 bytes. The architectural choice was probably driven by what convenient sub-multiples of 9 the 6502 can compute (×8 + ×1 via three ROLs).
- **Chapter 3's `RoomNumToAddress` mention** ("uses ROL chains to multiply by 9") is the same trick, applied to room data instead of object data. The series predicted this would recur; it does.
- **Chapter 4's hidden-room jump** is now legible end-to-end — the override path, the dot-position condition, the destination Room `$1E`. We can trace from "walk right in Room $03" to "see Robinett's name" using only this chapter's data structures plus chapter 4's movement code.
- **Chapter 6's level-as-difficulty** had a parallel here: level (`$DD`) doesn't just speed up the dragons, it **rewires the world**. Both axes scale through the same byte.

## LLM-interpretation log

**Pure structure was sufficient for:**
- Recognizing the 9-byte stride in `RoomDataTable` (the comment header named the offsets, and the `.byte` lines have consistent 9-element layout).
- The `AdjustRoomLevel` routine as a flag-then-lookup pattern (CMP #$80 / BCC bail / SBC #$80 / table lookup).
- `RoomNumToAddress`'s shift-and-add pattern as a "multiply by 9" idiom.
- The mapping between `$80`-flag values and `RoomDiffs` indices (the offset is just `flag - $80`, computable from inspection).

**The literal source comments carried decisive information for:**
- The room name → room number mapping. Without "Blue Maze Top," "White Castle," etc., the rooms are anonymous.
- The CTRLPF bit-7/bit-6 thin-wall convention — these are Adventure-specific extensions not in any TIA reference. Only the source comment ("True if right thin wall wanted") tells you about them.
- That `$DD` is "level number" stored shifted (the `LSR` makes sense only with this knowledge).
- The `$80` flag's purpose — comments name it as variant-handling explicitly.

**External knowledge was load-bearing for:**
- That CTRLPF bits 0–5 are real TIA configuration (mirror, score, priority, ball width). Without this, you'd think bits 6–7 were also TIA-defined.
- 6502 multiplication idioms via ROL chains — recognizing the pattern as ×8+×1=×9.
- The Easter egg's existence and folklore (the Dot extraction, the Magnet usage). The code shows the *gate*, not the *intended-use story*.

**The big find of chapter 7 — the architectural symmetry.** Object records and room records are **both 9 bytes**, addressed via the same multiplication recipe, accessed via the same indirect-Y pattern. Once you see this, the engine reveals itself as **two parallel data-driven systems** sharing the same primitives. This wasn't visible until chapter 7 — chapters 1–6 established that *objects* used the 9-byte format; this chapter shows the *map* uses it too. The pattern is engine-wide, not subsystem-specific.

This is the inverse of chapter 6's finding ("difficulty is the bite-state starting value"). Where chapter 6 surfaced a clever encoding, chapter 7 surfaces a structural unification. Both are kinds of compression — chapter 6 compresses semantically (one byte = one parameter that means three things); chapter 7 compresses architecturally (one indexing recipe = both data tables).

## What chapter 7 sets up for chapter 8

- **Room `$1E` (Name Room)** is the destination of the Easter egg. Chapter 8 will look at the graphics data — what's actually drawn in the Name Room — and trace the full Easter egg path: Dot's hiding spot, magnet extraction, Room `$03` walk-right, signature reveal.
- **The Black Dot's record** at `$A1`/`$A2`/`$A3` (chapter 1's finding) is the state variable the Easter egg key turns on.
- **Room `$15` (Black Maze #3)** is the Dot's initial location. The Dot's mechanic — invisible by being one pixel against a dark background — is the puzzle hook.

## Tags

[6502](../../../tags/6502.md) · [atari-2600](../../../tags/atari-2600.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md)

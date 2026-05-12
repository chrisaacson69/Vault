---
status: active
created: 2026-04-26
---
# Adventure — Sprite Multiplexing
> The 2600 has 2 player sprites. Adventure shows up to 5 visible game-objects per room. How.

**Links:** [Adventure README](./README.md), [Memory Map](./01-memory-map.md), [Display Kernel](./02-display-kernel.md), [TIA Reference](../../../research/atari-2600/tia-reference.md), source: [`raw/adventure.asm`](../../../raw/adventure.asm)

## The constraint

The TIA's complete movable-graphics roster:

| Hardware | Width | Color | Adventure's use |
|---|---|---|---|
| Player 0 | 8 px (or NUSIZ-multiplied) | COLUP0 | Object slot 1 (one game-object per frame) |
| Player 1 | 8 px (or NUSIZ-multiplied) | COLUP1 | Object slot 2 (one game-object per frame) |
| Missile 0 | 1/2/4/8 px | COLUP0 | Left-side thin wall (when room has one) |
| Missile 1 | 1/2/4/8 px | COLUP1 | Right-side thin wall (when room has one) |
| Ball | 1/2/4/8 px | COLUPF | **The man** (the player avatar) |

Five movable graphics. **Maximum five visible objects per frame**, no flicker — the natural ceiling. But Adventure has rooms with up to ~6+ game-objects (man, dragon, bat, sword, key, chalice). Something has to give.

## The three-layer trick

Adventure's "sprite multiplexing" isn't one technique — it's three stacked tricks:

1. **Repurpose the cheapest sprite for the most-common object.** The man is the player avatar; he's in *every* room. Renting a Player sprite for him would burn 1 of the 2 P-sprites permanently. Instead the **ball** renders the man, freeing both P-sprites for room contents.
2. **Per-frame slot assignment.** Each room can contain many objects. Each frame, the engine picks **two** to display via P0/P1 — different objects different frames. This is the rotation cursor `$9C`.
3. **Per-object hardware reconfiguration.** Each frame, after picking the two objects, the engine **rewrites NUSIZ, COLUPx, and graphics pointers** to match those specific objects. The same hardware sprite shows a sword one frame and a dragon the next.

Walls round out the budget: thin walls (the kind you can see through but not pass) are drawn by **missiles** M0/M1, configured per-room from the playfield-control byte. The kernel never actually treats them as missiles in the gameplay sense.

## The rotation cursor — `CacheObjects`

Every frame, the engine has to answer: *which two objects do I display this frame?* The routine `CacheObjects` (line 434) walks the object table looking for matches:

```asm
CacheObjects:
       LDY    $9C                 ;start where we left off last frame
       LDA    #$A2                ;mark both slots
       STA    $95                 ;      as empty
       STA    $96
MoveNextObject:
       TYA
       CLC
       ADC    #$09                ;next record (records are 9 bytes)
       CMP    #$A2                ;past end of table?
       BCC    GetObjectsInfo
       LDA    #$00                ;wrap to 0
GetObjectsInfo:
       TAY
       LDA    Store1,Y            ;low byte of object's Info ptr
       STA    $93
       LDA    Store2,Y            ;high byte
       STA    $94
       LDX    #$00
       LDA    ($93,X)             ;read object's room
       CMP    $8A                 ;in current room?
       BNE    CheckForMoreObjects ;no → next
       
       LDA    $95                 ;is slot 1 empty?
       CMP    #$A2
       BNE    StoreObjectToPrint  ;no → fill slot 2
       STY    $95                 ;yes → fill slot 1
       JMP    CheckForMoreObjects ;keep looking for slot 2

StoreObjectToPrint:
       STY    $96                 ;fill slot 2
       JMP    StoreCount          ;stop searching

CheckForMoreObjects:
       CPY    $9C                 ;back to where we started?
       BNE    MoveNextObject
StoreCount:
       STY    $9C                 ;remember where we ended
       RTS
```

**`$9C` is a cursor that moves forward through the object table each frame.** It starts somewhere; each frame's CacheObjects walks forward from there picking the first two in-room objects, and saves the new position. If the room has more than 2 objects, the cursor advances past the ones it picked, so next frame's first-pick is the *third* object, second-pick is the first, etc.

### Tracing 3 objects in one room

Suppose a room has objects at table indices 9, 18, 27:

| Frame | Start `$9C` | Picks | New `$9C` | Visible |
|---|---|---|---|---|
| N | 0 | 9, 18 | 18 | 9, 18 |
| N+1 | 18 | 27, 9 | 9 | 27, 9 |
| N+2 | 9 | 18, 27 | 27 | 18, 27 |
| N+3 | 27 | 9, 18 | 18 | back to N |

A 3-frame cycle. Each object visible 2 of every 3 frames. At 60 Hz, that's 40 Hz effective per object — visible flicker, but every object is on-screen most of the time. **This is the famous Adventure flicker.** It's not random; it's a deterministic forward walk.

### What happens with 1 or 2 objects

- **2 objects:** `CacheObjects` picks both immediately, no rotation needed. Both visible every frame, no flicker.
- **1 object:** Slot 1 fills, loop continues until `Y == $9C` (full revolution), exits with slot 2 still `#$A2` (empty). Display kernel sees a "null object" in slot 2 and skips it.
- **0 objects:** Both slots stay `#$A2`. Display kernel renders no P0/P1 graphics.

## The triple use of `$A2`

The constant `$A2` does **three jobs** in this engine:

1. **"No object" sentinel** in `$95`/`$96`/`$9D` — checked with `CMP #$A2`.
2. **End-of-table marker** in `CacheObjects` — `CMP #$A2 ; BCC` wraps the cursor when the next index would exceed it. The table has 18 records × 9 bytes = 162 bytes = `$A2`. Past the last byte = wrap.
3. **The Black Dot's X coordinate** lives at RAM address `$A2`. (See [chapter 1](./01-memory-map.md).)

These aren't independent coincidences — Robinett designed the table to make them coincide. The table size, the sentinel value, and the dot's record placement all chosen so one constant covers all three. **Three uses, one byte.**

## The z-order swap — `SwapPrintObjects`

Two objects need special handling: the **Invisible Surround** (object #0, byte index `$00`) and the **Bridge** (object #10, byte index `$5A`). Both are large multi-pixel sprites that have to render as Player 0 — the Player 1 slot has subtle restrictions that smaller sprites tolerate but these don't.

```asm
       LDA    $95                 ;is slot 1 the Surround?
       CMP    #$00
       BEQ    SwapPrintObjects    ;if so, swap to slot 2
       
       CMP    #$5A                ;is slot 1 the Bridge?
       BNE    SetupObjectPrint    ;if not, no swap needed
       
       LDA    $96                 ;is slot 2 the Surround?
       CMP    #$00
       BEQ    SetupObjectPrint    ;if so, leave alone (slot 2 is fine? — see note)
```

(The conditional logic here is slightly tangled in the source — there's a comment that the second test "leaves it as player01" which conflicts with the rule above. The exact logic ends up choosing whichever slot ordering avoids putting both large objects in slot 2. For the deep details we'd need to step through with concrete cases.)

When the swap fires:

```asm
SwapPrintObjects:
       LDA    $95
       STA    $D8
       LDA    $96
       STA    $95                 ;swap via $D8
       LDA    $D8
       STA    $96
```

`$D8` is the temp byte from chapter 1's "general scratch." Three loads + three stores. Cheaper than any swap idiom.

## Per-slot setup pipeline

Once `$95` and `$96` are decided, `SetupObjectPrint` (line 317) configures TIA for both objects:

```asm
       LDX    $95                 ;byte index into Store table
       LDA    Store1,X            ;low byte of Info ptr
       STA    $93
       LDA    Store2,X            ;high byte
       STA    $94
       
       LDY    #$01
       LDA    ($93),Y             ;Object's X coord
       STA    $86                 ;→ kernel's Object1 X
       LDY    #$02
       LDA    ($93),Y             ;Object's Y coord
       STA    $87                 ;→ kernel's Object1 Y
       
       LDA    Store3,X            ;Curr ptr (state machine pointer)
       STA    $93
       LDA    Store4,X
       STA    $94
       LDY    #$00
       LDA    ($93),Y             ;current state byte
       STA    $DC                 ;cache it
       
       LDA    Store5,X            ;States list ptr
       STA    $93
       LDA    Store6,X
       STA    $94
       JSR    GetObjectState      ;walk states list to find graphics ptr for this state
       
       INY
       LDA    ($93),Y             ;graphics low byte
       STA    $82                 ;→ kernel's P0 sprite ptr
       INY
       LDA    ($93),Y             ;graphics high byte
       STA    $83
       
       ;...color from Store7/Store8 → COLUP0
       ;...size from Store9 → NUSIZ0
```

Then the same again for slot 2 → P1 (writing `$88`/`$89`/`$84`/`$85`/COLUP1/NUSIZ1).

Every load is indexed by `X` = the slot's byte index into the parallel `Store1`–`Store9` arrays. Pure table-driven setup. The engine's only knowledge of "what kind of object am I rendering" is the byte index — everything else is data.

## Per-object NUSIZ — sprite copies and sizes

```asm
       LDA    Store9,X            ;Object's Size byte
       ORA    #$10                ;ensure missile-width bit
       STA    NUSIZ0
```

NUSIZ controls **how the player sprite renders this frame**:

| NUSIZ bits 0–2 | Effect |
|---|---|
| `000` | Single 8-px player |
| `001` | Two copies, close (17 px apart) |
| `010` | Two copies, medium (33 px) |
| `011` | Three copies, close |
| `100` | Two copies, far (65 px) |
| `101` | Single, double-width (16 px) |
| `110` | Three copies, medium |
| `111` | Single, quad-width (32 px) |

Adventure exploits this to make some objects render at different physical sizes from the same 8-pixel-wide sprite data. The Bridge gets a wider NUSIZ to span the gap you walk through. The Surround uses NUSIZ to extend its black "fog" patch. Each object's `Store9` byte is its NUSIZ template, written fresh into NUSIZ0 (or NUSIZ1) every frame.

## Per-object color via COLUP0 / COLUP1

Each object record's Color and B&W-Color bytes load into COLUP0 (slot 1) or COLUP1 (slot 2). **Each visible object renders in its own color, independent of the room.** Objects can change color across rooms (the chalice is "Flash" → cycling colors via `ChangeColor`). The kernel doesn't have to know this — color is set at frame setup time, written once into the COLUPx register, and TIA uses it for every line that sprite is visible.

## State machine walk — `GetObjectState`

Each stateful object has a States list in ROM: `state_value, gfx_ptr_low, gfx_ptr_high, state_value, gfx_ptr_low, gfx_ptr_high, ...`. `GetObjectState` (line 508) walks the list comparing `$DC` (current state) against each entry, and on match returns with the pointer pair ready to read.

For the dragon, this means:
- Idle state → still-dragon graphic
- Chase state → moving-dragon graphic (open mouth)
- Attack state → biting graphic
- Dead state → dead-dragon graphic
- Eaten-you state → dragon-with-man-in-mouth graphic

The kernel doesn't know any of this. The kernel reads through `($82),Y` and emits whatever bytes it finds. The state machine *changes the pointer*, and the picture changes.

## Putting it all together — one frame's setup

For a room containing the man + Yellow Dragon + Sword + Yellow Key + Chalice (busy room), one frame:

1. `CacheObjects` walks from `$9C`, picks (say) Sword and Yellow Key.
2. `SwapPrintObjects` checks for Bridge/Surround — neither, no swap.
3. `SetupObjectPrint` for slot 1 (Sword):
   - Load Sword's X/Y → `$86`/`$87`
   - State = "exists" → graphics ptr = sword sprite → `$82`/`$83`
   - Color: Yellow → COLUP0
   - Size: 8-px single → NUSIZ0
4. Same for slot 2 (Yellow Key):
   - X/Y → `$88`/`$89`
   - Graphics → `$84`/`$85`
   - Color: Yellow → COLUP1
   - Size: 8-px → NUSIZ1
5. Display kernel runs. Ball draws the man. P0 draws Sword. P1 draws Yellow Key.
6. **Next frame:** `CacheObjects` starts from new `$9C`, picks Chalice and Yellow Dragon. Same pipeline, different objects in P0/P1. Sword and Key are invisible this frame.
7. **Frame after:** rotation continues; Sword visible again, Key not, etc.

To the eye: 4 objects flickering in a busy room, each visible most of the time. To the engine: same render code every frame, parameterized by which two slots are filled.

## Efficiency catalogue (chapter 3 entries)

- **Man-as-ball** frees both player sprites for room contents. Net +1 visible object per frame, every frame.
- **Inter-frame rotation via `$9C`** turns "2 player sprites" into "any number of objects, with flicker." Cost: zero extra cycles; the cursor is updated for free at the end of each CacheObjects call.
- **Triple use of `$A2`** — sentinel, end-of-table, and Black Dot X coordinate, all from one byte by deliberate table sizing.
- **Per-frame hardware reconfiguration.** NUSIZ, COLUP, graphics pointer all rewritten each frame, so each TIA register is "owned" by whatever object happens to be in that slot. No registers permanently committed to a specific object.
- **Missiles double as walls.** The same hardware that other games use for bullets becomes Adventure's thin-wall renderer — configured from the room data's `CTRLPF` byte at no per-frame cost.
- **Z-order via slot swap.** Sprites that need to render in P0's z-position get moved to slot 1 by 6 instructions. Cheaper than any sorting algorithm.
- **State machines drive sprites for free.** The state byte changes; the graphics pointer changes; the kernel is unchanged.

## LLM-interpretation log

**Pure structure was sufficient for:**
- Identifying CacheObjects as a table-walking selection loop (TYA + ADC #$09 + CMP-wrap is unmistakable).
- Recognizing the slot-swap idiom (load A→temp, load B→A, load temp→B).
- The "iterate till you return to start" pattern (`CPY $9C ; BNE`).
- The parallel `Store1,X` / `Store2,X` / `Store3,X` / ... access pattern as a struct-of-arrays layout.

**The literal source comments carried decisive information for:**
- That `$95`/`$96` map to TIA Player 0 / Player 1 specifically (the comment "we want it as player01" reveals the z-order constraint).
- The semantic of `$00` and `$5A` in the swap test — without comments, these are bare numbers; with them, "Surround" and "Bridge" are named.
- The phrase "we want it as player01" in line 299 — a design-intent comment that decodes z-order behavior I'd never extract from structure.

**External knowledge (TIA reference) was load-bearing for:**
- That P0/P1/Ball/M0/M1 are the *complete* movable roster — five total. Until you know that, "two players" sounds like the limit.
- NUSIZ semantics — the bits-to-modes table is pure documentation.
- COLUPx semantics — that each player has its own color register, so per-object color is "free."
- Missile-as-wall: that missiles can be configured at any width/color is in the docs; that a game would *use* missiles for walls is creative.
- Ball's color comes from COLUPF (playfield) — relevant to why the man is the ball (no separate color register competition).

**The most interesting finding from chapter 3:** the **triple-use of `$A2`** as sentinel + table-end + Black Dot X coordinate **was not visible** until I had:
- The TIA reference (chapter 2 grounding) → understand what objects the engine needs to track.
- The chapter-1 memory map → know where the Black Dot's record lives.
- The CacheObjects code → see the wraparound check.

The same fact appears in three different mental models, and only triangulating them surfaces the design pattern. **This is what cumulative chapter knowledge is for** — chapter 3 was answerable only because chapters 1 and 2 had laid the right primitives. Without that scaffolding, the chapter-3 read would have been "this is a strange iteration loop with magic numbers." With it: "this is an extraordinarily compact piece of data engineering."

## What chapter 3 sets up for later

- **Chapter 5 (bat AI)** — the bat is famously flickery in busy rooms because it's competing for slots in `CacheObjects`. The flicker is partly hardware, partly the bat picking up extra objects.
- **Chapter 6 (dragon state machine)** — the per-state graphics-pointer mechanism is what makes "dragon eats you" possible without any kernel changes.
- **Chapter 7 (room graph)** — `RoomNumToAddress` (line 477) at the end of this section uses ROL chains to multiply by 9 (8 + 1) — same record-size-9 multiplier, since rooms also use 9-byte records.

## Tags

[6502](../../../tags/6502.md) · [atari-2600](../../../tags/atari-2600.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md)

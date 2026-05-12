---
status: active
created: 2026-04-26
---
# Adventure — The Bat AI
> The bat steals from you, drops things at random, and flies through walls. Underneath: a shared AI engine, a priority list, a 4-second timer, and one of the cleanest extensions of the [TIA-names-as-offsets trick](./04-movement-collision.md) in the ROM.

**Links:** [Adventure README](./README.md), [Memory Map](./01-memory-map.md), [Movement & Collision](./04-movement-collision.md), [TIA Reference](../../../research/atari-2600/tia-reference.md), source: [`raw/adventure.asm`](../../../raw/adventure.asm)

## The famous chaos

Players remember the bat as the most maddening entity in Adventure: it flies into your room out of nowhere, snatches your sword mid-fight, drops it across the map, picks up a dragon and brings the dragon to you, etc. It is not random. It runs ~30 lines of well-structured code with a hard-coded priority list and a 4-second timer.

## The bat's record — the field-offset trick goes wide

Chapter 4 showed Room/X/Y aliasing TIA's `VSYNC`/`VBLANK`/`WSYNC`. The bat extends the trick to **seven fields**, all accessed by indexed addressing with `X = $CB`:

| Field | TIA constant | Address | Meaning |
|---|---|---|---|
| Room | `VSYNC` ($00) | `$CB` | Current room |
| X | `VBLANK` ($01) | `$CC` | X coordinate |
| Y | `WSYNC` ($02) | `$CD` | Y coordinate |
| Movement | `RSYNC` ($03) | `$CE` | Direction bits (matches joystick encoding) |
| State | `NUSIZ0` ($04) | `$CF` | Wing-flap animation index (0–7) |
| Carried | `NUSIZ1` ($05) | `$D0` | Object the bat is currently carrying |
| Fed-Up | `COLUP0` ($06) | `$D1` | Timer until next target switch |

Look at `MoveGameObject` (line 1280):

```asm
MoveGameObject:
       JSR    GetLinkedObject     ;find target and compute direction
       LDX    $D5                 ;X = AI agent's record address ($CB for bat)
       LDA    $9B                 ;new movement
       BNE    MoveGameObject_2
       LDA    RSYNC,X             ;← READ AGENT'S CURRENT MOVEMENT (offset 3)
MoveGameObject_2:
       STA    RSYNC,X             ;← STORE NEW MOVEMENT (offset 3)
       LDY    $D4                 ;delta
       JSR    MoveGroundObject
       RTS
```

`RSYNC,X` with `X = $CB` resolves to `$CB + $03 = $CE` — the bat's movement byte. The mnemonic says "RSYNC" (a TIA reset-horizontal-sync register); the actual operation is "load/store this AI agent's current direction." Free symbol, again.

The dragons get the same treatment. Red Dragon at `$A4`–`$A8`, Yellow at `$A9`–`$AD`, Green at `$AE`–`$B2` — each a 5-byte record, each accessed via the same TIA-names-as-offsets pattern. **One indexing convention covers four AI entities.**

## The shared AI engine

`MoveGameObject` is generic. The bat calls it with `BatMatrix`. Each dragon calls it with its own matrix. The engine doesn't know which agent it's driving:

```asm
;Bat's invocation (line 1587):
MoveBat_3:
       LDA    #$CB                ;agent address
       STA    $D5                 ;tell engine where the agent lives
       LDA    #$03                ;3 pixels of movement
       STA    $D4
       LDA    #<BatMatrix
       STA    $D2                 ;priority list (low)
       LDA    #>BatMatrix
       STA    $D3                 ;priority list (high)
       LDA    $D0                 ;carried object → exclude from search
       STA    $D6
       JSR    MoveGameObject      ;runs the generic engine
```

Five parameters: agent address (`$D5`), delta (`$D4`), matrix pointer (`$D2`/`$D3`), and exclusion (`$D6` — what NOT to chase). Each AI configures these and calls into the same code.

## The priority matrix

The bat's `BatMatrix` (line 1656) is a list of `(self, target)` pairs:

```asm
BatMatrix:
       .byte $CB,$B9              ;Bat → Chalice
       .byte $CB,$B6              ;Bat → Sword
       .byte $CB,$BC              ;Bat → Bridge
       .byte $CB,$BF              ;Bat → Yellow Key
       .byte $CB,$C2              ;Bat → White Key
       .byte $CB,$C5              ;Bat → Black Key
       .byte $CB,$A4              ;Bat → Red Dragon
       .byte $CB,$A9              ;Bat → Yellow Dragon
       .byte $CB,$AE              ;Bat → Green Dragon
       .byte $CB,$B3              ;Bat → Magnet
       .byte $00                  ;terminator
```

**Strict pickup priority.** Chalice trumps everything. If the chalice is in the bat's current room, the bat ignores the sword right next to it and flies for the chalice. Bridge ranks above keys. Dragons rank above the magnet (which is why the bat sometimes hands you a live dragon — it'd rather grab a dragon than the magnet).

The matrix encodes design intent as data. Want to change the bat's priorities? Edit the table. No code change, no recompile of logic — just the order of `.byte` lines.

## How target selection works — `GetLinkedObject`

```asm
GetLinkedObject:
       LDA    #$00
       STA    $E1                 ;index into matrix
GetLinkedObject_2:
       LDY    $E1
       LDA    ($D2),Y             ;first object in pair (the bat itself)
       TAX
       INY
       LDA    ($D2),Y             ;second object (target)
       TAY
       LDA    VSYNC,X             ;bat's room (via Room offset)
       CMP.wy $0000,Y             ;target's room (via Room offset)
       BNE    GetLinkedObject_3   ;not same room → next pair
       
       CPY    $D6                 ;is target the carried object?
       BEQ    GetLinkedObject_3   ;skip if so
       CPX    $D6                 ;is bat itself the exclusion?
       BEQ    GetLinkedObject_3
       
       JSR    GetLinkedObject_4   ;found one — compute direction
       RTS
GetLinkedObject_3:
       INC    $E1
       INC    $E1
       LDY    $E1
       LDA    ($D2),Y             ;end of list?
       BNE    GetLinkedObject_2
       LDA    #$00
       STA    $9B                 ;no liked object found → no movement
       RTS
```

Walks the matrix top-to-bottom. First entry where bat and target share a room (and target ≠ exclusion) wins. The **`CMP.wy $0000,Y`** is using `$0000` as the base for indexed Y addressing — with `Y` holding an object's address, this reads the object's Room field (offset 0). Same trick as `VSYNC,X`, just expressed differently because Y can't index against the same kind of base.

So the bat's "AI" is: "what's the highest-priority thing in my room? Go toward it."

## Direction toward target — `GetLinkedObject_4`

Pure sign-of-difference. No pathfinding, no obstacle avoidance:

```asm
GetLinkedObject_4:
       LDA    #$FF                ;all bits set = no movement
       STA    $9B
       
       LDA.wy $0000,Y             ;target room
       CMP    VSYNC,X             ;same as agent's room?
       BNE    GetLinkedObject_8   ;no → don't try to move
       
       LDA.wy $0001,Y             ;target X
       CMP    VBLANK,X            ;agent X
       BCC    GetLinkedObject_5   ;target is left → move left
       BEQ    GetLinkedObject_6   ;same X → check vertical
       
       LDA    $9B                 ;clear bit 7 (move right)
       AND    #$7F
       STA    $9B
       JMP    GetLinkedObject_6
GetLinkedObject_5:
       LDA    $9B                 ;clear bit 6 (move left)
       AND    #$BF
       STA    $9B
GetLinkedObject_6:
       LDA.wy $0002,Y             ;target Y
       CMP    WSYNC,X             ;agent Y
       BCC    GetLinkedObject_7   ;target is above
       BEQ    GetLinkedObject_8   ;same Y → done
       
       LDA    $9B                 ;clear bit 4 (move up)
       AND    #$EF
       STA    $9B
       JMP    GetLinkedObject_8
GetLinkedObject_7:
       LDA    $9B                 ;clear bit 5 (move down)
       AND    #$DF
       STA    $9B
GetLinkedObject_8:
       LDA    $9B
       RTS
```

**The movement byte uses joystick encoding** (active-low). `$FF` = no movement; bits cleared = directions enabled. This is the same encoding `MoveObjectDelta` reads (chapter 4) for the player. So the bat's AI output feeds straight into the same movement primitive that handles joystick input. **One movement routine drives the entire game world.**

The bat will fly **into a wall** if its target is past it. The hardware collision check (chapter 4) is for the *ball* (the man); the bat doesn't care. This is why the bat famously flies through walls — *the AI can't see them*.

## The Fed-Up cycle — the chaos engine

The bat doesn't seek targets every frame. Most of the time it just continues drifting in its current direction. Only periodically does it stop to look for a new pickup:

```asm
MoveBat:
       INC    $CF                 ;animation: cycle wing-flap state 0–7
       LDA    $CF
       CMP    #$08
       BNE    MoveBat_2
       LDA    #$00                ;wrap
       STA    $CF
       
MoveBat_2:
       LDA    $D1                 ;Fed-Up counter
       BEQ    MoveBat_3           ;hit zero → time to pick again
       INC    $D1                 ;increment toward zero (wraps)
       LDA    $CE                 ;current movement direction
       LDX    #$CB
       LDY    #$03                ;3 px delta
       JSR    MoveGroundObject    ;just drift in current direction
       JMP    MoveBat_4
       
MoveBat_3:                         ;FED UP — pick a new target
       ;... configure engine and call MoveGameObject ...
       ;... if adjacent to target, pick it up and reset $D1 = $10 ...
```

The cycle:

1. After picking up an object, `$D1 = $10` (16).
2. Every frame: `INC $D1` → 17, 18, ... 254, 255, then wraps to 0.
3. From 16 to wraparound = **240 frames ≈ 4 seconds at 60 Hz**.
4. When `$D1 == 0`, bat goes Fed-Up: re-runs target selection. If a higher-priority object is now in its room, it'll move toward and pick that one (dropping the current carry, since pickup overwrites `$D0`).

So the bat carries something for ~4 seconds, then evaluates again. If you've moved into the bat's room with a higher-priority object than what it's carrying, it'll drop its current cargo to grab yours. **This is why the bat steals from you.**

## The pickup itself

```asm
;See if Bat can pick up object.
       LDA    VBLANK,X            ;target X
       SEC
       SBC    $CC                 ;minus bat X
       CLC
       ADC    #$04                ;center the bat on the object
       AND    #$F8                ;within 7 pixels?
       BNE    MoveBat_4           ;no → bail
       
       LDA    WSYNC,X             ;target Y
       SEC
       SBC    $CD
       CLC
       ADC    #$04
       AND    #$F8                ;within 7 pixels vertically?
       BNE    MoveBat_4
       
;Got it.
       STX    $D0                 ;set as carried
       LDA    #$10                ;reset Fed-Up timer
       STA    $D1
```

A simple 7-pixel proximity test on both axes (the `AND #$F8` masks the low 3 bits — anything within 7 in absolute value passes). Note this is **software** proximity, not TIA collision — the bat's pickup doesn't go through the player/missile collision latches because the bat isn't a hardware sprite (it shares P0 or P1 only when it's the displayed object that frame). The AI runs whether or not the bat is currently visible.

## Carrying and the steal-from-player rule

Once the bat carries an object, it drags it along every frame:

```asm
MoveBat_4:
       LDX    $D0                 ;carried object
       LDA    $CB                 ;bat's room
       STA    VSYNC,X             ;set object's room (drag along)
       LDA    $CC
       CLC
       ADC    #$08                ;offset 8 px right of bat
       STA    VBLANK,X            ;set object's X
       LDA    $CD
       STA    WSYNC,X             ;set object's Y
       
       LDA    $D0                 ;what bat carries
       LDY    $9D                 ;what player carries
       CMP    Store1,Y            ;same object?
       BNE    MoveBat_5
       
       LDA    #$A2                ;bat just took it from us
       STA    $9D                 ;player drops the object
```

The check at the end is the **steal rule**: if the bat's carried object equals the player's carried object, the player's hand goes empty (`$9D = #$A2`). This is the moment the bat literally yanks the sword out of your hand. The geometry is implicit — the bat is now where the object is, the object's position is now where the bat is, and the player is wherever they were. The transitive ownership transfer happens via the carried-object pointers without any positional check.

## Putting it all together — why the bat feels chaotic

Five mechanisms compounding:

1. **Inter-frame flicker.** From [chapter 3's rotation](./03-sprite-multiplexing.md) — in busy rooms the bat is visible only some frames, so it appears to teleport.
2. **Wall-blind AI.** The pathfinding is sign-of-difference only. The bat flies into walls and through them.
3. **4-second target re-evaluation.** Periodically the bat decides whether what it's carrying is still the highest-priority object in its room. If you walked in with a chalice, your sword is dead weight.
4. **Strict priority list.** Chalice > Sword > Bridge > Keys > Dragons > Magnet. The bat will drop a key for a dragon (alarming) or drop a sword for the chalice (devastating mid-fight).
5. **Steal-on-overlap.** No fight, no warning — if the bat reaches your object and is in the same 7-pixel box, the object is theirs and you're empty-handed.

To the player: chaos. To the engine: 30 lines of arithmetic and a lookup table.

## Efficiency catalogue (chapter 5 entries)

- **TIA-names-as-offsets extends to 7 fields**, not just 3. The bat's whole record is accessed via `VSYNC,X / VBLANK,X / WSYNC,X / RSYNC,X / NUSIZ0,X / NUSIZ1,X / COLUP0,X` — the assembler had constants for all of them already.
- **One AI engine, four agents.** `MoveGameObject` + `GetLinkedObject` drives the bat, Red Dragon, Yellow Dragon, Green Dragon. Per-agent matrices encode their personalities. Estimated savings: ~200+ bytes vs per-agent code.
- **Movement encoding shared between joystick and AI.** `MoveObjectDelta` doesn't know whether `$9B` came from `SWCHA` or `GetLinkedObject_4`. Same primitive feeds player movement and enemy movement.
- **Priority list as data, not code.** Adding/removing/reordering bat preferences is a `.byte` table edit. The famous Chalice-first behavior is one byte position.
- **The Fed-Up timer is a wrap-around increment.** `INC $D1` until it overflows from `$FF` to `$00`. No subtract, no compare against a max, no separate counter. The natural overflow IS the timeout. `$10` initial value sets the period; raise it for less-frequent re-targeting.
- **Animation in 1 byte.** `$CF` cycles 0–7 each frame for the wing flap. Direct write to `Curr` selects one of 8 sprite pointers in the BatStates list. The display kernel reads through the pointer; no animation loop needed.
- **Pickup is software, not hardware.** The bat isn't always a displayed sprite, so proximity has to be checked in code. But the check is a single subtract + mask: `SBC ; ADC #$04 ; AND #$F8 ; BNE skip`.
- **Steal mechanic is pointer-only.** No coordinate check — if the bat's carried = the player's carried, the player drops it. The objects' positions follow.

## What this surfaces about earlier chapters

- **Chapter 1's "$A4–$A8 Red Dragon (Room, X, Y, Movement, State)" record format** is now retroactively explained. It's not just a convenient grouping — it's the exact 5-byte layout that the AI engine reads via TIA-named offsets. The "Movement" field is at offset 3 because `RSYNC = $03`. The "State" field is at offset 4 because `NUSIZ0 = $04`. **The dragons inherit the bat's record layout because they share the AI engine.**
- **Chapter 4's TIA-names-as-offsets trick** is even bigger than it looked. It's not just Room/X/Y; it's the whole movable-object schema. Every AI agent's record is laid out so its fields align with sequential TIA constants. The chip's register map *is* the engine's struct definition.
- **Chapter 3's flicker** is now load-bearing for *gameplay perception* of the bat. The flicker is what makes the bat feel teleportational. The deterministic rotation is the visual representation of the deterministic AI.

## LLM-interpretation log

**Pure structure was sufficient for:**
- Recognizing `BatMatrix` as a priority-ordered lookup table (sequential `.byte` pairs with terminator).
- The "iterate matrix until match" pattern in `GetLinkedObject` (load/check/INC/INC/loop).
- Sign-of-difference direction logic — `CMP ; BCC ; BEQ` followed by AND-mask is unmistakable.
- The Fed-Up wrap-around timer (`INC $D1 ; ... BEQ go-fed-up`) — overflow-as-timeout is a textbook 6502 pattern.

**The literal source comments carried decisive information for:**
- That `$D1` is the "Fed-Up Value" — without that name, it's just a counter; with it, the *gameplay* meaning becomes clear.
- That BatMatrix entries are `Bat,<object>` pairs ordered by priority (the per-line comments name each object).
- That `STA $9D ;Drop object` at the end of `MoveBat_4` is the player-drops-object moment. Critical to understanding the steal mechanic; opaque without the comment.
- The phrase "Reset the Bat Fed Up Time" (line 1630) confirming pickup → reset to `$10`.

**External knowledge (TIA / 6502) was load-bearing for:**
- That `RSYNC = $03`, `NUSIZ0 = $04`, `NUSIZ1 = $05`, `COLUP0 = $06` — the full sequence of TIA constants whose names get repurposed as field offsets. Without confirming this, lines like `LDA RSYNC,X` would read as TIA accesses, not record-field reads.
- That `LDA.wy $0000,Y` is the absolute-Y form; the assembler's `.wy` suffix forces non-zero-page encoding even when the address fits. Critical for distinguishing this from `LDA $00,Y` zero-page-indexed (which doesn't even exist on the 6502).
- The active-low joystick/movement encoding from chapter 4 — needed to read the AND-mask sequence as "enable direction X."

**Big find from chapter 5:** The TIA-names-as-offsets trick is **systemic, not a one-off**. Chapter 4 found it for movement (Room/X/Y). Chapter 5 finds it for the *entire 7-byte AI record*. Robinett designed his data structures around the 2600's register map.

This means **chapter 4's finding was understated.** The trick isn't just "save 3 bytes per coord access" — it's the *entire data layout convention* of the engine. Every AI agent's record is shaped to match the TIA constant sequence. Going forward I should look at every record in the source through this lens.

## What chapter 5 sets up for chapter 6

- **The dragon AI** uses the exact same engine. Chapter 6 will look at three matrices (`RedDragMatrix`, `YellowDragMatrix`, `GreenDragMatrix`) and how dragons differ. Predict: Red Dragon's matrix prioritizes Sword (it's the boldest); Green's includes the Magnet (it's the most-paranoid?). We'll find out.
- **The `$DC` state cache** from chapters 1 and 3 will fully come into focus when we walk DragonStates — five sprite pointers for idle/chase/attack/dead/eaten-you that the kernel reads through.
- **The dragon difficulty table** (`DragonDiff` at line 1561) sets per-agent deltas based on level. Chapter 6 will trace how level (`$DD`) flows into dragon speed.

## Tags

[6502](../../../tags/6502.md) · [atari-2600](../../../tags/atari-2600.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md)

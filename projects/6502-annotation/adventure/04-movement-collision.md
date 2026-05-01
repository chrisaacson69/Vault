---
status: active
created: 2026-04-26
---
# Adventure — Movement & Collision
> The TIA does nearly all collision detection in hardware. The engine just reads the latches. And `MoveObjectDelta` exploits the *names* of TIA registers as struct field offsets — the most elegant byte-saving trick in the ROM.

**Links:** [Adventure README](./README.md), [Memory Map](./01-memory-map.md), [Sprite Multiplexing](./03-sprite-multiplexing.md), [TIA Reference](../../../research/atari-2600/tia-reference.md), source: [`raw/adventure.asm`](../../../raw/adventure.asm)

## The big idea — collision in hardware

The TIA tracks **all 15 pairwise collisions** between Player 0, Player 1, Missile 0, Missile 1, Ball, and Playfield. Each pair has a latch bit you read via `CXP0FB`/`CXP1FB`/`CXM0FB`/`CXM1FB`/`CXBLPF`/`CXPPMM` (`$30`–`$37`). Latches stay set until you explicitly clear them with `CXCLR` (`$2C`).

Adventure's collision system is built on this. **It does not compute hit-tests in software** for the major game-object collisions. The engine just queries TIA latches, interprets which displayed object the latch refers to (via `$95`/`$96`), and triggers gameplay accordingly. The hardware does the geometry; the software does the dispatch.

```asm
;Every frame, near the start of the kernel:
       STA    CXCLR               ;Clear Collision Latches.   (line 70)
```

That one write resets all 15 latches. Through the frame, TIA sets them as the beam draws sprites that overlap. By the time game logic runs in overscan, the latches reflect every collision that happened during the visible region — for whatever pair of objects happened to be on screen this frame.

This composes beautifully with chapter 3's [rotation-based selection](./03-sprite-multiplexing.md): the displayed object pair changes every frame, so over a rotation cycle, **collisions between every pair of in-room objects eventually fire**. Hardware collision detection over rotated displayed pairs = effective N-object collision with no software hit-tests.

## TIA register names as struct field offsets

This trick was hiding in plain sight. Look at `MoveObjectDelta` (line 1180):

```asm
MoveObjectDelta:
       STA    $9B                 ;store direction wanted
MoveObjectDelta_2:
       DEY                        ;count down delta
       BMI    MoveObjectDelta_7   ;done?
       
       LDA    $9B
       AND    #$80                ;right?
       BNE    MoveObjectDelta_3
       INC    VBLANK,X            ;← INCREMENT X COORDINATE
       
MoveObjectDelta_3:
       LDA    $9B
       AND    #$40                ;left?
       BNE    MoveObjectDelta_4
       DEC    VBLANK,X            ;← DECREMENT X COORDINATE
       
MoveObjectDelta_4:
       LDA    $9B
       AND    #$10                ;up?
       BNE    MoveObjectDelta_5
       INC    WSYNC,X             ;← INCREMENT Y COORDINATE
       
MoveObjectDelta_5:
       LDA    $9B
       AND    #$20                ;down?
       BNE    MoveObjectDelta_6
       DEC    WSYNC,X             ;← DECREMENT Y COORDINATE
       
MoveObjectDelta_6:
       JMP    MoveObjectDelta_2
```

**`INC VBLANK,X` is not touching VBLANK.** `VBLANK` is the symbol the assembler resolved to `$01`. With `X = $8A` (the ball's record address), the absolute target is `$01 + $8A = $8B` — the ball's **X coordinate** in RAM. Same trick on `WSYNC,X` → `$02 + $8A = $8C` = ball's Y coordinate.

The engine deliberately defines every object's record as **3 bytes: Room (offset 0), X (offset 1), Y (offset 2)**. The TIA constants `VSYNC = $00`, `VBLANK = $01`, `WSYNC = $02` happen to equal those offsets. So `VSYNC,X`, `VBLANK,X`, `WSYNC,X` become "this object's Room, X, Y" with no extra constants and no symbol redefinitions.

Costs Robinett zero bytes of definition. Saves three bytes per use. And the assembler doesn't care that the symbols mean two different things in different contexts.

This pattern recurs throughout the source — anywhere the engine reaches into an object's record by indexed addressing. Look at `MoveGroundObject` (line 1064):
```asm
       LDA    VSYNC,X             ;Get object's room number.
```
That's not reading the VSYNC register. With `X` set to the object's record address, it reads the object's Room field (offset 0).

The mnemonic is misleading, the comment tells the truth, and the byte budget benefits.

## The movement system

### Joystick read — `$99` and `$9B`

`SWCHA` (`$0280`, RIOT) returns both joysticks in one byte, **active-low** (pressed = 0). Adventure reads it once per frame:

```asm
       LDA    SWCHA               ;Read joysticks.
       STA    $99                 ;      and store value.
```

Then ORs in a per-phase mask to disallow movement in some game phases:

```asm
       LDA    $99
       ORA    ReadStick_3,Y       ;merge out movement not allowed in this phase
       STA    $9B                 ;cooked movement → MoveObjectDelta input

ReadStick_3:
       .byte  $00,$C0,$30         ;phase 0: no mask; phase 1: no horiz; phase 2: no vert
```

`$9B` is the "direction wanted" byte that `MoveObjectDelta` checks bit-by-bit. Because the bits are active-low (TIA convention), `BNE skip` means "if bit set, the player did NOT push that direction" — so the routine moves the object only when the bit is clear. Inverted logic that fits SWCHA's encoding without translation.

### Move N pixels per frame — `MoveObjectDelta`

Each call moves the object Y times in the wanted direction (Y is the delta). The man moves **3 pixels per frame** (line 921: `LDY #$03`). Different objects use different deltas — the dragon's delta varies by difficulty (chapter 6). Carried-object pickup uses delta 6 to cover the larger distance from object to ball.

The loop body checks each direction bit independently and applies INC/DEC. Diagonal motion is supported automatically — both X-bit and Y-bit can be clear in the same call.

### Edge crossing → new room

After moving, `MoveGroundObject` checks whether the object went off the screen edge:

```asm
;Check Up.
       LDA    WSYNC,X             ;Y coord
       CMP    #$6A                ;past top?
       BMI    DealWithLeft        ;no, check left edge instead
       LDA    #$0D                ;wrap to bottom
       STA    WSYNC,X
       LDY    #$05                ;direction: up-exit
       JMP    GetNewRoom

;Check Left.
DealWithLeft:
       LDA    VBLANK,X            ;X coord
       CMP    #$03                ;past left?
       BCC    DealWithLeft_2      ;yes
       CMP    #$F0                ;past right?
       BCS    DealWithLeft_2
       JMP    DealWithDown        ;no, on to down check
```

Each direction has a threshold (`$6A` top, `$03` left, `$0D` bottom, `$9F`/`$9B` right) and a corresponding "direction wanted" code (5/6/7/8) used to index the room's adjacency list.

`GetNewRoom` consults the current room's record:

```asm
GetNewRoom:
       LDA    VSYNC,X             ;current room
       JSR    RoomNumToAddress    ;find its record
       LDA    ($93),Y             ;read the Y'th adjacency entry
       JSR    AdjustRoomLevel     ;apply level-specific transformation
       STA    VSYNC,X             ;new room
```

So each room record carries its 4 neighbors (up/down/left/right). Walking off an edge looks up the neighbor and drops the object at the opposite edge of the new room. Same code handles every object — the man, dragons, the bat — because they're all just "an object whose `VSYNC,X / VBLANK,X / WSYNC,X` got changed."

### The hidden-room jump (Easter egg foreshadowing)

Inside the right-edge handling there's an asymmetry — see lines 1142–1156:

```asm
       LDA    VSYNC,X             ;Get the Ball's Room.
       CMP    #$03                ;Is it room #3?
       BNE    DealWithRight_3     ;normal right-exit
       
       LDA    $A1                 ;Check the room of the black dot.
       CMP    #$15
       BEQ    DealWithRight_3     ;normal exit
       
;Manually change to secret room.
       LDA    #$1E                ;Set room to secret room.
       STA    VSYNC,X
       LDA    #$03
       STA    VBLANK,X
       JMP    MovementReturn
```

When the man is in room `$03` and walks right, the normal exit is overridden — *unless* the Black Dot is in room `$15`. This is the Easter egg pathway. The Dot is the key; carrying it to a specific room unlocks the conditional. Chapter 8 will trace this fully.

## The collision pipeline

### Per-frame query loop

Each frame, after the kernel runs and TIA latches are populated, game logic queries them in a fixed order. From `BallMovement` (line 822):

```asm
BallMovement:
       LDA    CXBLPF              ;ball-playfield (wall) collision?
       AND    #$80
       BNE    PlayerCollision     ;hit a wall
       
       LDA    CXM0FB              ;ball-missile0 (left thin wall)?
       AND    #$40
       BNE    PlayerCollision
       
       LDA    CXM1FB              ;ball-missile1 (right thin wall)?
       AND    #$40
       BEQ    BallMovement_2
       
       LDA    $96                 ;exception: dot ignores right thin wall
       CMP    #$87
       BNE    PlayerCollision

BallMovement_2:
       LDA    CXP0FB              ;ball-player0 (slot 1 object)?
       AND    #$40
       BEQ    BallMovement_3
       LDA    $95                 ;exception: surround doesn't collide
       CMP    #$00
       BNE    PlayerCollision

BallMovement_3:
       LDA    CXP1FB              ;ball-player1 (slot 2 object)?
       AND    #$40
       BEQ    NoCollision
       LDA    $96
       CMP    #$00                ;exception: surround again
       BNE    PlayerCollision
       JMP    NoCollision
```

Six TIA reads, each followed by an exception check. **No coordinate math anywhere.** The exceptions:
- The Black Dot (`$96 == #$87`, where `$87` is the dot's byte index in the Store table) ignores right thin walls — part of the Easter egg pathway.
- The Invisible Surround (`$95 == #$00` or `$96 == #$00`) never triggers a collision when overlapping the ball — because the Surround is *positioned around the player* every frame; without this exception you'd be in constant collision.

### What "PlayerCollision" actually does

When a wall collision fires, the engine restores the ball to its previous position (saved in `$E2`/`$E3`/`$E4` before movement) — effectively rolling back the move. The man stays put. This is software collision *response* on top of hardware collision *detection*.

### The bridge bypass

The bridge is the one major exception — you can walk through it instead of bumping. From line 858:

```asm
PlayerCollision:
       CPY    #$02                ;are we checking for the bridge case?
       BNE    ReadStick           ;no, bail
       LDA    $9D                 ;object being carried?
       CMP    #$5A                ;the bridge?
       BEQ    ReadStick           ;if you're carrying it, doesn't matter
       LDA    $8A                 ;current room
       CMP    $BC                 ;same as bridge's room?
       BNE    ReadStick
       
;Check going through the bridge.
       LDA    $8B                 ;ball X
       SEC
       SBC    $BD                 ;minus bridge X
       CMP    #$0A                ;in [10, 23]?
       BCC    ReadStick
       CMP    #$17
       BCS    ReadStick
       
       LDA    $BE                 ;bridge Y
       SEC
       SBC    $8C                 ;minus ball Y
       CMP    #$FC                ;within range?
       BCS    NoCollision         ;you're walking through the bridge
       CMP    #$19
       BCS    ReadStick
```

Software bounding-box check: if the ball is within the bridge's footprint, suppress the collision and let movement proceed. This is the *only* place Adventure does proximity math for normal gameplay collisions. Everything else is hardware.

### Pickup detection — `PickupPutdown`

Detecting which object you've touched works the same way:

```asm
       LDA    CXP0FB              ;ball-player0?
       AND    #$40
       BEQ    PickupPutdown_3
       LDA    $95                 ;slot 1's object index
       STA    $97                 ;remember it
       JMP    CollisionDetected
       
PickupPutdown_3:
       LDA    CXP1FB              ;ball-player1?
       AND    #$40
       BEQ    PickupPutdown_4
       LDA    $96
       STA    $97
       JMP    CollisionDetected
```

When the man overlaps a sprite, the engine reads which slot's object that was (`$95` or `$96`) and stores it in `$97` as "the object collided with." Then `CollisionDetected` checks whether it's a carryable object (`CMP #$51` — anything past byte index 0x51, which is the Sword, qualifies) and whether it's already being carried.

### Object-vs-object — `PBCollision` and `FindObjHit`

For object-vs-object queries (sword vs dragon, key vs portcullis, bat vs anything), the engine uses `CXPPMM` (player-player and missile-missile collisions):

```asm
FindObjHit:
       LDA    CXPPMM              ;P0-P1 collision?
       AND    #$80
       BEQ    FindObjHit_2        ;no
       CPX    $95                 ;is X the slot-1 object?
       BEQ    FindObjHit_3
       CPX    $96                 ;or slot-2?
       BEQ    FindObjHit_4
FindObjHit_2:
       LDA    #$A2                ;no match → null
       RTS
FindObjHit_3:
       LDA    $96                 ;return the OTHER slot
       RTS
FindObjHit_4:
       LDA    $95
       RTS
```

The interface: pass an object in X, ask "did you collide with anything this frame?" Return the other slot's object (or `$A2` for no). This is how sword-kills-dragon works — the dragon AI calls `FindObjHit(X=dragon)` and acts if the answer is the sword.

Combined with chapter 3's rotation: any dragon will be in P0 or P1 only some of the time; the sword is similarly intermittent. Over a few frames of rotation, *if* both happen to be displayed simultaneously and overlap, the collision fires. This is why sword kills happen "when you connect" — visually obvious, mechanically dependent on the slot rotation aligning.

## Efficiency catalogue (chapter 4 entries)

- **TIA names as field offsets.** `VSYNC = $00`, `VBLANK = $01`, `WSYNC = $02` happen to be the Room/X/Y offsets. `INC VBLANK,X` reads as "increment X coordinate" because that's what it does — for any X holding an object record's address. Free symbols, no extra definitions.
- **Hardware collision detection.** The 15 TIA pairwise-collision latches are the entire collision engine. No coordinate math except the bridge exception. Reading 6 collision registers at fixed positions ≈ 18 cycles of game state per frame.
- **Rotation × collision.** Because the displayed object pair rotates each frame (chapter 3) and TIA tracks only the displayed pair's collisions, multi-object collision over a rotation cycle is automatic. No per-pair check loop.
- **One movement routine for everything.** `MoveObjectDelta` works on any object whose address you load into X. Man, dragon, bat, dropped objects — same code path.
- **Rollback via `$E2`/`$E3`/`$E4`.** Save room/X/Y, attempt movement, on collision restore. Cheaper than predictive collision math.
- **Per-phase joystick masking.** Three bytes (`$00, $C0, $30`) and one ORA implement "no horizontal" / "no vertical" / "free movement" phases — used for cinematic moments where the man can't move on certain axes.
- **The Surround / Dot collision exceptions** are 2-instruction guards (`CMP #$00 ; BEQ`), letting otherwise-uniform collision logic accommodate the two objects with special semantics.

## What this chapter surfaces about earlier chapters

The TIA-names-as-offsets trick **retroactively explains** several memory-map decisions in chapter 1:

- Why every movable record starts with **Room, X, Y in that order** — because that's what `VSYNC, VBLANK, WSYNC` resolve to.
- Why the 3-byte minimum record (Magnet, Sword, Chalice, etc.) has *exactly* those three fields — the field layout is forced by which TIA constants you can repurpose.
- Why `$8A`–`$8C` is the ball's record — to make `VSYNC,X` with `X=$8A` give Room, etc. The ball's address was chosen so the indexing works.

This is one of those design decisions that compounds: pick the right base addresses, line up your data layout with TIA's register layout, and entire categories of code become free.

## LLM-interpretation log

**Pure structure was sufficient for:**
- Identifying `MoveObjectDelta` as a directional update loop (4 symmetric AND-then-INC/DEC blocks).
- Recognizing the joystick-bit AND-mask pattern (`AND #$80` for right, `#$40` for left, etc.).
- The save-position / restore-on-collision pattern via `$E2`/`$E3`/`$E4`.
- The collision-query chain (CXxxx reads followed by branches) as exhaustive pair enumeration.

**The literal source comments carried decisive information for:**
- That `INC VBLANK,X` is "Increment the X coordinate" — without the comment you'd assume it's actually touching VBLANK and be confused. **The comment is the only thing that disambiguates the trick.**
- The semantics of object indices (`#$87` = dot, `#$5A` = bridge, `#$00` = surround).
- The bridge bypass logic — every condition has an explanatory comment that tells you what game state it represents.

**External knowledge (TIA / RIOT / 6502 docs) was load-bearing for:**
- That `VSYNC`/`VBLANK`/`WSYNC` are constants resolved by the assembler, not "magic names that always mean TIA writes." This is 6502 / assembler knowledge, not chip-specific.
- All 15 TIA pairwise collision pairs and which register reports which.
- Active-low SWCHA encoding — without it, the inverted "BNE skip" branches read as backwards.
- That `CXCLR` needs to fire every frame to reset latches.
- The 6502 indexed addressing math (base + X = effective address) — this is the foundation of the field-offset trick.

**The big find from chapter 4: the field-offset trick.** Pure structure showed me there were INC/DEC operations on TIA register addresses with X-indexing. The comment told me what they actually did. Putting it together required understanding that absolute,X addressing computes base+X regardless of what "base" symbolically represents — that's the 6502 fact that makes the trick work. The TIA reference helped me confirm `VSYNC = $00 / VBLANK = $01 / WSYNC = $02`, which is what makes the offsets line up with Room/X/Y. **Three different inputs converged on the find.**

This is the second time (after chapter 3's `$A2` triple-use) that the most interesting trick in a chapter required all three inputs to surface. Pattern: **the cleverest tricks live at the intersection of source structure + chip docs + assembler semantics.** Each alone misses them; together they snap into focus.

## Tags

[6502](../../../tags/6502.md) · [atari-2600](../../../tags/atari-2600.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md)

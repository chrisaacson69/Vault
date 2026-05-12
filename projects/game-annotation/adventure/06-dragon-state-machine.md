---
status: active
created: 2026-04-26
---
# Adventure — The Dragon State Machine
> Three dragons, one AI engine, a five-state machine, and a difficulty system that's *one byte per setting*. The matrix format encodes both chase and flee with no extra bits.

**Links:** [Adventure README](./README.md), [Memory Map](./01-memory-map.md), [Movement & Collision](./04-movement-collision.md), [The Bat AI](./05-bat-ai.md), [TIA Reference](../../../research/atari-2600/tia-reference.md), source: [`raw/adventure.asm`](../../../raw/adventure.asm)

## The shared engine, again

`MoveRedDragon`, `MoveYellowDragon`, `MoveGreenDragon` are nearly identical wrappers — each loads its own matrix into `$D2/$D3`, sets a delta, picks a Store-table byte index, and calls `MoveDragon`. From line 1374:

```asm
MoveRedDragon:
       LDA    #<RedDragMatrix
       STA    $D2
       LDA    #>RedDragMatrix
       STA    $D3
       LDA    #$03                ;3 px/frame — Red is the fastest
       STA    $D4
       LDX    #$36                ;byte index for Dragon #6 (Red)
       JSR    MoveDragon
       RTS

MoveYellowDragon:
       ;... same shape, delta = 2, X = $3F (Dragon #7) ...

MoveGreenDragon:
       ;... same shape, delta = 2, X = $48 (Dragon #8) ...
```

Three differences across the three dragons: **matrix, delta, byte index**. Everything else is shared. Red moves 3 pixels per frame; Yellow and Green move 2. Red is the fastest, which fits its lore as the most fearsome (Rhindle).

## The personality matrices — chase OR flee, encoded by slot

Each dragon's matrix is a list of `(first, second)` pairs, terminated with `$00`:

```asm
RedDragMatrix:
       .byte $B6,$A4              ;Sword, Red Dragon
       .byte $A4,$8A              ;Red Dragon, Ball
       .byte $A4,$B9              ;Red Dragon, Chalice
       .byte $A4,$C2              ;Red Dragon, White Key
       .byte $00

YelDragMatrix:
       .byte $B6,$A9              ;Sword, Yellow Dragon
       .byte $BF,$A9              ;Yellow Key, Yellow Dragon
       .byte $A9,$8A              ;Yellow Dragon, Ball
       .byte $A9,$B9              ;Yellow Dragon, Chalice

GreenDragonMatrix:
       .byte $B6,$AE              ;Sword, Green Dragon
       .byte $AE,$8A              ;Green Dragon, Ball
       .byte $AE,$B9              ;Green Dragon, Chalice
       .byte $AE,$BC              ;Green Dragon, Bridge
       .byte $AE,$B3              ;Green Dragon, Magnet
       .byte $AE,$C5              ;Green Dragon, Black Key
```

Look at the slot positions:
- **Sword always appears first.** Followed by the dragon.
- **The dragon always appears first** in the rest.

This is the encoding trick. Recall from chapter 5 that `GetLinkedObject_4` computes "the direction X needs to go to reach Y" (where X = first matrix element, Y = second). Then `MoveGameObject` applies that direction to whichever agent is in `$D5`.

So the agent's relationship to the matrix entry determines behavior:

| Matrix entry | Agent ($D5) | Effective behavior |
|---|---|---|
| (X, Y), agent = X | first slot | X moves toward Y → **chase Y** |
| (X, Y), agent = Y | second slot | Y moves in "X-toward-Y" direction → **flee X** |

For the dragons (agent = the dragon's address):
- `(Sword, Dragon)` → agent in second slot → **dragon flees sword**
- `(Dragon, Ball)` → agent in first slot → **dragon chases ball**
- `(Dragon, Chalice)` → agent in first slot → **dragon guards chalice** (parks on it)
- `(Dragon, Bridge)` → **dragon guards bridge**

**Same matrix format. Slot order = behavior.** Robinett got "chase" and "flee" out of one byte by exploiting which slot the agent occupies. No flag, no second table, no branch.

### Per-dragon personality

| Dragon | Flees | Chases | Guards |
|---|---|---|---|
| Red | Sword | Ball | Chalice, White Key |
| Yellow | Sword, Yellow Key | Ball | Chalice |
| Green | Sword | Ball | Chalice, Bridge, Magnet, Black Key |

The Yellow Dragon flees the **Yellow Key** specifically — the key that opens its own castle. That's a thematic touch you can't see from gameplay; it's encoded in one matrix line.

The Green Dragon guards more than the others (4 objects vs 2 for Red, 1 for Yellow) — it's the "everything important is mine" personality.

## The five-state machine

The dragon's state byte lives at offset `$04` from its record (NUSIZ0 alias). Five values matter:

| State | Meaning | Behavior |
|---|---|---|
| `$00` | Alert (idle/chase) | Moves via AI; checks for ball collision (→ start bite), checks for sword hit (→ dead) |
| `$01` | Dead | Frozen sprite forever |
| `$02` | Eaten Ball | Drags player coords with dragon; player can't move |
| `$03`–`$FB` | Roaring (animated) | State increments each frame; animation cycles through sprite list |
| `$FC`–`$FF` | Bite window | If ball still adjacent, transition to Eaten ($02). If escaped, state wraps to $00 (back to alert). |

Diagram:

```
              ┌──────── sword hit ─────────┐
              ▼                            │
  ┌─────────────────┐              ┌──────────────┐
  │ $01  DEAD       │              │ $00  ALERT   │◄────┐
  └─────────────────┘              │   (chase AI) │     │
                                   └──────┬───────┘     │
                                          │             │
                              ball overlap│             │
                                          ▼             │
                                   ┌──────────────┐     │
                                   │ $D0..$F6     │     │
                                   │  ROARING     │     │
                                   │ (set from    │     │
                                   │  DragonDiff) │     │
                                   └──────┬───────┘     │
                                          │INC each frame│
                                          ▼             │
                                   ┌──────────────┐     │
                                   │ $FC..$FF     │     │
                                   │ BITE WINDOW  ├─escape (wrap → $00)
                                   └──────┬───────┘     ▲
                                  ball   │              │
                                  adj    ▼              │
                                   ┌──────────────┐     │
                                   │ $02  EATEN   │ (terminal — game over)
                                   └──────────────┘
```

## Difficulty as starting state — `DragonDiff`

This is the most compact difficulty system I've seen in any game.

```asm
DragonDiff:
       .byte $D0,$E8              ;Level 1 : Amateur, Pro
       .byte $F0,$F6              ;Level 2 : Amateur, Pro
       .byte $F0,$F6              ;Level 3 : Amateur, Pro
```

Six bytes. That's the entire difficulty table. When the dragon catches the ball:

```asm
       LDA    SWCHB               ;console switches
       ROL  ROL  ROL              ;move P0-difficulty bit into bit 0
       AND    #$01
       ORA    $DD                 ;merge in level (stored as 0/2/4)
       TAY                        ;Y = 0..5
       LDA    DragonDiff,Y        ;new state value
       STA    NUSIZ0,X            ;set as dragon's roaring state
```

**Difficulty isn't a multiplier or a parameter — it's the starting value of the bite-state countdown.** The state increments every frame, and at `$FC` the bite triggers. So the player has `$FC - DragonDiff[level/diff]` frames to escape:

| Level/Diff | Start | Frames to escape | Real time @ 60Hz |
|---|---|---|---|
| 1 / Amateur | `$D0` | 44 | 0.73 sec |
| 1 / Pro | `$E8` | 20 | 0.33 sec |
| 2 / Amateur | `$F0` | 12 | 0.20 sec |
| 2 / Pro | `$F6` | 6 | **0.10 sec** |
| 3 / Amateur | `$F0` | 12 | 0.20 sec |
| 3 / Pro | `$F6` | 6 | **0.10 sec** |

Pro mode at Level 2/3: **6 frames between roar and dead**. That's why Adventure is hard.

The escape mechanism is implicit — if the ball moves out of the dragon's collision box during the countdown, `PBCollision` returns false at the bite frame and the state continues incrementing through `$FC..$FF` until it wraps to `$00`, returning to alert. **The wrap-around-as-timeout pattern from the bat reappears**, here used to recover from a missed bite.

## The bite trigger flow

```asm
       JSR    MoveGameObject      ;move the dragon (chase/flee/guard)
       
       LDA    $A0                 ;dragon's object number (saved at top)
       JSR    PBCollision         ;did dragon hit the ball?
       BEQ    MoveDragon_4        ;no → check sword hit
       
       ;Dragon caught the ball — start the bite sequence
       compute DragonDiff index
       NUSIZ0,X = DragonDiff[Y]   ;set roaring state
       VBLANK,X = $E3             ;snap dragon X to ball's saved X
       WSYNC,X = $E4              ;snap dragon Y to ball's saved Y
       trigger roar sound
```

The position snap is critical. When the dragon catches the ball, the dragon's position is *set to the ball's previous position* (chapter 4's rollback save). So even if the ball moved away this frame, the dragon visually catches up. Otherwise the bite would happen with the dragon and ball already separated by one frame's worth of movement.

## The sword-kill check

```asm
MoveDragon_4:
       STX    $9A                 ;save dragon record address
       LDX    $A0                 ;dragon object number
       JSR    FindObjHit          ;what hit the dragon?
       LDX    $9A                 ;restore dragon address
       CMP    #$51                ;is it the sword? (#$51 = byte index of sword in Store table)
       BNE    MoveDragon_5        ;no → continue
       
       LDA    #$01                ;state = DEAD
       STA    NUSIZ0,X
       trigger death sound
```

`FindObjHit` (chapter 4) returns the object the dragon collided with via TIA's player-player collision latch. If it's `#$51` (Sword), the dragon dies. **One register read, one comparison, one state assignment — that's the entire sword-kill mechanic.**

Note this only fires when the dragon and the sword are *both* in the displayed object pair this frame (chapter 3's rotation). In a busy room, getting the kill requires the rotation to align. That's the experiential "swing the sword and hope it connects" — it's actually "swing the sword and hope this frame's slot rotation includes both you and the dragon."

## Difficulty's other lever — `$D6` exclusion

The dragon's `MoveDragon` configures the AI engine's exclusion:

```asm
       LDA    SWCHB               ;P1 difficulty
       AND    #$80
       BEQ    MoveDragon_2        ;Amateur
       LDA    #$00                ;Pro: ignore nothing
       JMP    MoveDragon_3
MoveDragon_2:
       LDA    #$B6                ;Amateur: ignore SWORD
MoveDragon_3:
       STA    $D6
```

Then in `GetLinkedObject` (chapter 5), `$D6` filters which matrix entries are skipped. **In Amateur mode, the dragon doesn't see the sword** — so the `(Sword, Dragon)` flee entry is skipped, dragons march straight at you, and you can stab them with ease. **In Pro mode, dragons flee the sword** — you have to chase them down to hit them. Same matrix, two behaviors, controlled by one byte.

This is counter-intuitive at first ("Easy means dragon doesn't run = easier?") but it's exactly right: in Easy mode the dragon walks right onto your sword. In Pro mode the dragon dodges, forcing the player to corner it.

## The Eaten state — the player becomes a passenger

Once `NUSIZ0,X = $02`, every frame:

```asm
       ;State 02: dragon has eaten the ball
       LDA    VSYNC,X             ;dragon's room
       STA    $8A                 ;ball's room (force player into dragon's room)
       STA    $E2                 ;ball's previous room
       LDA    VBLANK,X
       CLC
       ADC    #$03                ;offset 3 px
       STA    $8B                 ;ball X = dragon X + 3
       STA    $E3
       LDA    WSYNC,X
       SEC
       SBC    #$0A                ;offset -10 px
       STA    $8C                 ;ball Y = dragon Y - 10
       STA    $E4
```

The ball's coordinates are slaved to the dragon's, with a small offset (3 right, 10 down) — that's where the dragon's mouth is in the sprite. The player can no longer move because the position is overwritten every frame. The dragon can wander into other rooms carrying the player. **The only way out is Game Reset** — the only state with no escape transition.

Note that `$E2/$E3/$E4` (the rollback-save addresses from chapter 4) are also written, so the rollback-on-collision system can't restore an "outside the dragon" position. The eaten state hijacks the rollback system.

## The position-snap quirk in the bite

When the bite confirms (state crosses `$FC` with ball still adjacent):

```asm
       LDA    #$02
       STA    NUSIZ0,X            ;state = EATEN
       trigger eat sound
       
       LDA    #$9B                ;max screen X
       CMP    VBLANK,X
       BEQ    MoveDragon_8
       BCS    MoveDragon_8
       STA    VBLANK,X            ;clamp X to $9B
       
MoveDragon_8:
       LDA    #$17                ;min screen Y
       CMP    WSYNC,X
       BCC    MoveDragon_9
       STA    WSYNC,X             ;clamp Y to $17
```

After the bite, the dragon is clamped to a known on-screen position (X ≤ $9B, Y ≥ $17). This guarantees the eaten-player stays visible — no risk of the dragon (and you, in its mouth) being off-screen. The clamp is a safety net for the position-snap.

## Efficiency catalogue (chapter 6 entries)

- **Three dragons share one engine** via three thin wrappers. ~30 bytes of difference across three personalities.
- **Matrix slot order encodes chase vs flee.** No extra bits, no flag bytes. The agent's position in the slot determines whether the computed direction means "go toward" or "go away."
- **Difficulty as starting state.** Six bytes for the entire difficulty system. Pro mode is just a higher starting value — same code path, faster trigger.
- **Sword-fleeing toggled by `$D6`.** One byte (`#$00` vs `#$B6`) flips dragon behavior between aggressive (Easy) and evasive (Pro).
- **Sword-kill is a single CMP.** `FindObjHit` returns whatever hit the dragon; if it's `#$51`, dragon dies. No special-case code per attacker — any object-vs-dragon collision goes through the same query.
- **Wrap-around as escape timeout.** State increments past `$FC` continue past `$FF` and wrap to `$00`. No reset code needed for "ball escaped the bite" — natural overflow restores Alert state.
- **Eaten state hijacks the rollback save.** Writing `$E2/$E3/$E4` along with the live coords prevents the player from being "rolled back" to a free position. Reuse of an existing system rather than a new one.
- **Position snap on catch and on bite confirm.** The dragon's X/Y get rewritten at the moment of catch (to ball's previous position) and at the moment of eat (to a safe on-screen corner). Visual coherence with no separate animation system.
- **Per-dragon delta in one byte.** Red moves 3, others move 2. The "Red is more dangerous" feel is one assignment in the wrapper.

## What this confirms about earlier chapters

- **Chapter 5's "shared AI engine" is fully validated.** Same `MoveGameObject` + `GetLinkedObject` drives bat and three dragons. Each with its own matrix and a few config bytes. Total agents-per-byte ratio is excellent.
- **Chapter 4's TIA-names-as-offsets** is now visible across every line of dragon code. `NUSIZ0,X` for state, `VBLANK,X` for X, `WSYNC,X` for Y, `VSYNC,X` for room — all reading dragon record fields via repurposed TIA constants.
- **Chapter 3's rotation matters for combat.** The sword-kill requires both sword and dragon to be in the displayed pair this frame. Rotation determines combat tempo.
- **Chapter 1's record format** is fully load-bearing. The dragon's 5-byte (Room/X/Y/Movement/State) layout is exactly what the AI engine reads. Re-arranging the fields would break everything.

## LLM-interpretation log

**Pure structure was sufficient for:**
- Identifying the three dragon `Move<Color>Dragon` routines as wrappers around a shared `MoveDragon`.
- The state-dispatch tree (`CMP #$00 / BNE`, `CMP #$01 / BEQ`, `CMP #$02 / BNE`) as a 5-state machine.
- The bite-state countdown via `INC NUSIZ0,X` followed by `CMP #$FC / BCC return`.
- The eaten-state position-slaving (LOAD dragon coord, SUBTRACT/ADD offset, STORE to ball coord) as visual position lock.

**The literal source comments carried decisive information for:**
- That `#$51` is the sword's byte index in the Store table — without this, the kill check is opaque.
- The `;Set Easy - Ignore Sword` and `;Set Hard - Ignore Nothing` comments naming the difficulty mapping. The bare AND/BEQ/LDA/JMP would not reveal which path is which difficulty.
- DragonDiff's row labels (`Level 1 : Am, Pro`) — the indexing math `(level | diff_bit)` is comprehensible from code, but which row is which depends on the comments.
- Per-matrix-line role labels — `;Sword, Red Dragon` confirms slot order matters; `;Red Dragon, Ball` confirms the inverse.

**External knowledge (TIA / 6502) was load-bearing for:**
- That `NUSIZ0,X = $04 + X` and that `$04 + dragon_address` lands on the state field. Combining chapter 5's full-record-via-TIA-names with the dragon address arithmetic.
- `SWCHB` bit layout — bit 7 is P0 difficulty, bit 6 is P1 difficulty. Without this, the `ROL ROL ROL ; AND #$01` extraction is opaque.
- That `$DD` (level) is stored as 0/2/4 (pre-shifted) — implicit from `ORA $DD` working with the 6-row table.

**Big find from chapter 6: the matrix-slot-encodes-role pattern.** Pure structure showed me `GetLinkedObject` computes "X-toward-Y" direction. The matrix data showed me sword-then-dragon and dragon-then-target patterns. Putting them together — that the agent's slot in the matrix changes the *role* the computed direction plays — required holding three things at once: the engine code (chapter 5), the matrix data (this chapter), and the realization that direction-applied-to-source = chase, direction-applied-to-target = flee. That's a four-input synthesis: source, comments, chip docs, and prior-chapter understanding. The deeper we go, the more chapter-cumulative the findings get.

**Difficulty-as-starting-state** is also a chapter-6-only finding. Once you see DragonDiff and the `STA NUSIZ0,X` line, the design pattern snaps: "difficulty is just where the bite countdown starts." But the realization required understanding the full state machine first — which required understanding the AI engine first — which required the TIA-names-as-offsets trick. Each chapter has been earning the next.

## What chapter 6 sets up for chapter 7

- **Room graph & adjacency.** `RoomNumToAddress` (line 477) and the room-record format will explain how the world topology is stored. We've seen room records have Room#, X/Y, color, B&W color, CTRLPF byte, and 4 adjacency entries (up/down/left/right). The `AdjustRoomLevel` routine modifies adjacency per difficulty level — different game variants have different room connections.
- **The "secret room" jump in chapter 4** will be revisited as part of the room-graph discussion.

## Tags

[6502](../../../tags/6502.md) · [atari-2600](../../../tags/atari-2600.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md)

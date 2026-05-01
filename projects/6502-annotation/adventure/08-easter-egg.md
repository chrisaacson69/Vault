---
status: active
created: 2026-04-26
---
# Adventure — The Easter Egg
> Object #4, position (50, 69) in Room $1E. Gated by one byte comparison. Origin of the term "Easter egg" in software. The first signed credit in a commercial video game.

**Links:** [Adventure README](./README.md), [Memory Map](./01-memory-map.md), [Movement & Collision](./04-movement-collision.md), [Room Graph](./07-room-graph.md), source: [`raw/adventure.asm`](../../../raw/adventure.asm)

## The signature

Line 2511 of the source:

```asm
;Object #4 : State FF : Graphic
GfxAuthor:
       .byte $F0                  ;XXXX
       .byte $80                  ;X
       .byte $80                  ;X
       .byte $80                  ;X
       .byte $F4                  ;XXXX X
       .byte $04                  ;     X
       .byte $87                  ;X    XXX
       .byte $E5                  ;XXX  X X
       ...    ;~90 bytes total
```

90+ bytes of bitmap that, when rendered as a tall narrow column at Room `$1E` position (`$50`, `$69`) and color-cycled through "flash" mode, spells:

```
CREATED BY
WARREN
ROBINETT
```

Warren Robinett's name, hidden inside the cartridge, gated by a puzzle subtle enough that none of Atari's QA testers found it.

## The mechanism

Five distinct facts in the code, working together:

### 1. The Author object exists in the engine's roster

From the object table (chapter 1, line 2774):

```
LFF68: .byte <AuthorInfo,>AuthorInfo, <AuthorCurr,>AuthorCurr,
       <AuthorStates,>AuthorStates, $CB,$00,$00      ;#4 Name  Flash
```

Object #4 ("Name") has Curr in ROM (so no state machine — it's just one sprite), color `$CB` flashing. To the engine, it's just another object in the table. The display kernel will render it whenever it's the current room's contents and gets picked into a slot via [chapter 3's rotation](./03-sprite-multiplexing.md).

### 2. AuthorInfo locks the signature to Room $1E

```asm
AuthorInfo:
       .byte $1E,$50,$69          ;Room 1E, (50, 69)
```

The signature lives at room `$1E`, fixed position. Object #4 never moves, never gets carried, never appears anywhere else. **It only shows up if you're in Room `$1E`** — which means the question is *how do you get to Room `$1E`*.

### 3. Room $1E has no normal adjacency

Looking at [chapter 7's room records](./07-room-graph.md), Room `$1E` has adjacency `$06,$01,$06,$03`. But **no other room lists `$1E` as a neighbor.** Walking around the world's normal connections will never lead you to Room `$1E`. There is no door.

### 4. The override path — `$03` walk-right with the dot conditions

From [chapter 4's `MoveGroundObject`](./04-movement-collision.md) right-edge handler:

```asm
       LDA    VSYNC,X             ;current room
       CMP    #$03                ;Room 3 ("Left of Name")?
       BNE    DealWithRight_3     ;no → normal exit
       LDA    $A1                 ;Black Dot's room
       CMP    #$15                ;Room $15 (Black Maze #3)?
       BEQ    DealWithRight_3     ;dot still hidden → normal exit
       
       ;Override: teleport to Room $1E
       LDA    #$1E
       STA    VSYNC,X             ;new room
       LDA    #$03
       STA    VBLANK,X            ;new X
       JMP    MovementReturn
```

**Eight lines of assembly are the entire Easter egg gating.** The condition: walking right from Room `$03` while the Black Dot is anywhere except its starting room.

### 5. The Black Dot starts in Room $15

From `Game1Objects` (line 785):

```asm
Game1Objects:
       .byte $15,$51,$12            ;Black dot (Room, X, Y)
```

And the same in `Game2Objects` (line 804). So in every game variant, the dot's initial room is `$15` (Black Maze #3). The condition `LDA $A1 ; CMP #$15` is true at game start — meaning **the override fires only after the player has moved the dot.**

## The dot

The Black Dot is the most peculiar object in the game. Three things make it the puzzle's key:

**1. It's one pixel wide.** Look at `GfxDot` (line 2506):

```asm
GfxDot:
       .byte $80                  ;X
       .byte $00
```

A single bit. The dot is a single dark pixel.

**2. It's drawn in playfield color over a playfield wall.** In Room `$15` (Black Maze #3), the wall color and the dot color coincide. **You literally cannot see the dot.** It exists in the room as a hardware sprite, but visually it's invisible against the maze.

**3. It ignores the right thin wall.** From [chapter 4's BallMovement](./04-movement-collision.md):

```asm
       LDA    CXM1FB              ;ball-missile1 (right thin wall) collision?
       AND    #$40
       BEQ    BallMovement_2
       LDA    $96                 ;is slot 2 the dot?
       CMP    #$87                ;dot's byte index
       BNE    PlayerCollision
       ;else: dot is allowed through right thin walls — no collision
```

When the dot is the displayed slot-2 object, the right thin wall doesn't block it. **You can walk the dot through walls** that would normally stop you. This is how you carry the dot out of the Black Maze and into the world.

## The full path

Putting it all together:

1. **Walk into the Black Maze** (rooms `$13`–`$16`). The dot is invisible — you have to bump into it by exhaustive exploration. Folklore: bring a Chalice (which color-cycles via "Flash") into the room — during certain color frames, the dot becomes momentarily visible against the contrasting playfield.
2. **Pick up the dot.** TIA collision fires when you overlap it ([chapter 4](./04-movement-collision.md)); the engine reads the `$96` slot, recognizes the dot's byte index `$87`, registers it as the carried object (`$9D = $87`).
3. **Carry the dot through walls.** Because the dot ignores right thin walls (and the player carries the dot at a fixed offset from the ball), you can pass through walls that would otherwise be impassable. This is the only way to get the dot out of certain enclosed maze rooms.
4. **Reach Room `$03` (Left of Name)** with the dot anywhere except Room `$15`.
5. **Walk right.** The override fires. Teleport to Room `$1E`. The signature blooms in the center of the screen.

The whole puzzle is ~10 bytes of code and one bit of weird object data. The *difficulty* of the puzzle is its discoverability — the dot is invisible by design.

## Why it exists

Atari in 1979 had a strict no-credits policy. Cartridges did not name their programmers. The official rationale was talent-poaching prevention; the practical effect was that developers who wrote million-selling games for Atari salaries had no way to attach their names to their work. Warren Robinett, the 25-year-old who built Adventure, was paid roughly $20,000 per year while Adventure earned Atari ~$25 million.

So Robinett added the signature without permission and without telling anyone. He gated it carefully — it had to be reachable in principle (or it wouldn't be a real credit) but not findable by casual play or QA testing (or it would be removed before release). Then he quit Atari before the cartridge shipped.

The signature stayed undiscovered for months after release. Then in 1980, **Adam Clayton, a 15-year-old in Salt Lake City**, found it. Word reached Atari. Internal discussion considered re-issuing the cartridge with the signature removed; the manufacturing cost made this prohibitive. Atari kept it.

Steve Wright, Atari's software development director, **coined the term "Easter egg"** to describe Robinett's hidden signature — and to position future intentional hidden content as a *feature* rather than a security failure. The term spread. Today every "Konami code", every "secret level," every developer credit hidden in a settings page descends from this 90-byte sprite at line 2511.

Atari subsequently changed policy and began crediting programmers on later games.

## The architecture of one credit

What's striking, reading the code, is that the Easter egg is **not a hack**. Robinett didn't bolt on a special "if you press this combination, show the credits" mechanism. He built it into the same data structures every other object uses:

- The signature is **Object #4** in the standard 9-byte object table.
- Its position is in the standard `AuthorInfo` 3-byte (Room, X, Y) record.
- Its graphics are in the standard `GfxAuthor` bitmap.
- The destination room (`$1E`) is a normal room in `RoomDataTable` with a normal 9-byte record.
- The gating condition is **8 lines** in the right-edge handler, indistinguishable from any other special-case override.

If you read the engine looking for "where's the secret?", you wouldn't find anything that looks like a secret. You'd find a normal object, a normal room, and a normal-looking conditional that happens to teleport. **The Easter egg is in the same architectural style as the rest of the game.** That's what makes it survive 45 years of hardware emulation and source-code tracing — it doesn't depend on any trick, any timing, any anomalous code path. It's just data and arithmetic.

This is the design lesson at the heart of the series: **deeply consistent architecture lets even unauthorized features look like they belong.** Robinett added a credit by adding *one more object* to a system designed for objects, *one more room* to a system designed for rooms, *one more conditional* to a system designed for conditionals. He didn't have to invent any new mechanism. The engine was hospitable to the unannounced.

## Efficiency catalogue (chapter 8 entries)

- **Easter egg as standard data.** No special-case mechanism, no separate code path. Object #4 is just another row in the object table; Room `$1E` is just another row in the room table. Zero engine modifications.
- **Gate condition is 8 instructions.** `CMP #$03 / BNE / LDA $A1 / CMP #$15 / BEQ / LDA #$1E / STA / LDA #$03 / STA / JMP`. Identical in structure to any other room-transition special case in the source.
- **The dot's "invisible" design uses no special invisibility code.** It's just a 1-bit sprite drawn in the same color as the playfield it covers. The "trick" is the absence of contrast.
- **The dot's wall-bypass is one CMP.** `CMP #$87 ; BNE collide` — the same pattern as the Surround's collision exception. Nothing in the code says "this is for the Easter egg"; it's a per-object collision rule that happens to enable the puzzle.
- **One graphic asset, used once.** The 90-byte `GfxAuthor` is the largest single sprite in the ROM. Robinett spent his byte budget on the signature itself, not on its delivery mechanism.

## What the chapter confirms about the whole series

- **Chapter 7's "Room `$1E` has no normal adjacency"** is now load-bearing. The whole point of the override is that there's no other way to reach this room.
- **Chapter 4's "right thin wall collision exception for the dot"** was the single weirdest line in the collision code; chapter 8 reveals it's there *specifically* for the Easter egg path. Without the wall-bypass, the dot couldn't physically be carried out of the Black Maze.
- **Chapter 3's per-object color (COLUPF)** is what makes the dot invisible — the dot's color matches the wall's color in Room `$15`. The same hardware feature that lets each visible object render in its own hue is also what lets one object hide in plain sight.
- **Chapter 1's `$A1` (Black Dot Room)** is the gate variable. The single byte at zero-page address `$A1` controls whether the credit is reachable. Three uses for the value `$A2` (chapter 1) plus this one use for the *address* `$A1` — Robinett squeezed more meaning into adjacent bytes than most programs do across a kilobyte.

## LLM-interpretation log

**Pure structure was sufficient for:**
- Recognizing `GfxAuthor` as a sprite bitmap by its position in the data section and its `.byte` pattern matching other Gfx* labels.
- Identifying Object #4 in the table as having Curr in ROM (no state machine) → just one sprite.
- The gate condition's structure as a multi-stage conditional override (`CMP / BNE / LDA / CMP / BEQ / unconditional override`).

**The literal source comments carried decisive information for:**
- That `GfxAuthor` is actually the author's name (the comment names it; without that you'd see a 90-byte bitmap with no obvious meaning).
- That `AuthorInfo` is "Object #4 : Author's Name" — the object's identity is conveyed by the section comment, not by anything in the bytes.
- The Black Dot's identity at byte index `$87` — recognized only because earlier code commented `;If object2 (to print) is not the black dot then collide.`

**External knowledge was load-bearing for:**
- The historical context of Atari's no-credits policy and Robinett's act.
- The folklore around the "Chalice color-flicker reveals the dot" technique.
- The discovery story (Adam Clayton, 1980) and the Steve Wright "Easter egg" coinage.
- That the term "Easter egg" in software *originates here*. Reading the code alone, you'd see "an object that displays the programmer's name, gated by a puzzle." You wouldn't know it was the *first* of its kind.

**The big find of chapter 8:** the Easter egg is **not architecturally distinct.** I expected to find some kind of special-case "if all conditions met, show secret room" mechanism — a bypass, a hidden subroutine, something gated outside the normal engine. There isn't any. The Easter egg uses the same primitives as the rest of the game. **Robinett's design discipline made his unauthorized addition indistinguishable from sanctioned content.** That's why it survived QA, survived 45 years of analysis, and remains the canonical example of an Easter egg.

The meta-pattern of the series — "the cleverest tricks live at the intersection of source structure + chip docs + assembler semantics + cumulative chapter knowledge" — applies one more time. Recognizing the Easter egg as architecturally consistent rather than architecturally separate required understanding the object table (chapter 1), the rotation system (chapter 3), the collision exceptions (chapter 4), the room graph (chapter 7), and the override path (chapter 4 + 7). With all those in hand, chapter 8's finding is obvious. Without them, you'd just see scattered "weird code."

## The series, complete

Eight chapters covered:

1. **Memory map** — 128 bytes of state, organized as 9-byte object records, addressed via TIA-name aliasing.
2. **Display kernel** — 192 visible scan lines painted by hand under VDEL01-buffered two-line iterations.
3. **Sprite multiplexing** — man-as-ball + inter-frame rotation + per-frame TIA reconfiguration.
4. **Movement & collision** — TIA hardware does the geometry; engine queries 6 collision registers; `INC VBLANK,X` is "increment X coordinate."
5. **Bat AI** — shared engine, priority matrices, 4-second Fed-Up timer, steal-on-overlap.
6. **Dragon state machine** — same engine; matrix slot order encodes chase vs flee; difficulty is the bite-state starting value.
7. **Room graph** — 9-byte room records, three game variants in 24 bytes via `$80`-flag adjacency overrides.
8. **Easter egg** — built from the standard primitives; gated by 8 instructions; origin of the term in software.

**The cumulative LLM-interpretation finding**: assembly is a stress test where pure-structure analysis recovers shape but misses the cleverest tricks. Chip documentation closes most of the gap. Cumulative chapter knowledge closes the rest. **Reading 6502 well requires building a model of the chip, the engine, and the design language together.** No one of these is enough; all three together unlock the architecture.

Robinett wrote 4 KB of code and data in 1979 that 45 years later still rewards careful reading. Each subsystem is dense without being clever-for-its-own-sake; each compaction has a structural reason; the whole engine is *consistent*. The Easter egg is a feature of the same engine that runs the dragons. That's why it's still here.

## Tags

[6502](../../../tags/6502.md) · [atari-2600](../../../tags/atari-2600.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md)

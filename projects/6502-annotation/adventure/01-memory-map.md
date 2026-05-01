---
status: active
created: 2026-04-26
updated: 2026-04-26
---
# Adventure — Memory Map
> Every byte of zero-page RAM Adventure uses, what it means, and how it's organized. Until you have this, nothing else in the source makes sense.

**Links:** [Adventure README](./README.md), [TIA Reference](../../../research/atari-2600/tia-reference.md), source: [`raw/adventure.asm`](../../../raw/adventure.asm)

## The constraint

The 6507 exposes 13 address lines → 8 KB max addressable. That space is sliced by the address decoder:

| Range | What's there |
|---|---|
| `$00`–`$3F` | TIA registers (write `$00`–`$2C`, read `$30`–`$3D`); mirrored through `$40`–`$7F` |
| `$80`–`$FF` | RIOT RAM — **128 bytes, all of system RAM** |
| `$0280`–`$0297` | RIOT I/O & timer (joystick, console switches, `INTIM`, `TIM64T`) |
| `$F000`–`$FFFF` | Cart ROM (the 6507 sees it here; physically wired to `$1000`–`$1FFF` on the cart bus, mirrored to fill higher addresses) |

The 6502 core hardcodes the stack to page 1 (`$0100`–`$01FF`). The 2600 doesn't decode bit A8, so stack pushes to `$0100`–`$01FF` actually land in RIOT RAM at `$0080`–`$00FF` via address mirroring. **The stack and game variables share the same 128 bytes.** Adventure uses `$80`–`$DD` for state (94 bytes), leaving `$DE`–`$FF` (34 bytes) for the stack to grow down into.

## How Adventure organizes the world

Two layers:

1. **Engine state** in zero page (`$80`–`$DD`): pointers the display kernel reads, the player's position, scratch values, dynamic data for moving entities (dragons, bat).
2. **Object table** in ROM. The first record (#0 Invisible Surround) lives at `Store1`–`Store9` (lines 2752–2769 of source) with each byte individually labeled so other code can reference fields by name. Records #1–#18 are stored compactly at `$FF4D`–`$FFEE` (lines 2771–2788), 9 bytes each.

Each record is **9 bytes**:

| Offset | Field |
|---|---|
| 0–1 | Info pointer (Room/X/Y data location — RAM for movables, ROM for statics) |
| 2–3 | Curr pointer (current state byte — RAM if stateful, ROM if not) |
| 4–5 | States pointer (state list in ROM) |
| 6 | Color |
| 7 | Color in B&W |
| 8 | Size of object |

The Curr pointer split is the key design idea: **stateful objects** (portcullises, dragons, bat, "Number" which uses level `$DD`) point at RAM; **stateless objects** (sword, bridge, keys, dot, chalice, magnet, name, null) point at ROM. The engine reads through the pointer either way, so one display routine handles both.

## Memory map

### Display kernel (`$80`–`$91`)

| Addr | Meaning | Notes |
|---|---|---|
| `$80`–`$81` | Pointer to current room graphics (3-byte playfield definition) | indirect-Y reads in `PrintDisplay` (line 93) |
| `$82`–`$83` | Pointer to Player00 sprite (Object1) graphics | (line 134) |
| `$84`–`$85` | Pointer to Player01 sprite (Object2) graphics | (line 119) |
| `$86` | Object1 X coordinate (→ Player00 sprite) | (line 56) |
| `$87` | Object1 Y coordinate | (line 130) |
| `$88` | Object2 X coordinate (→ Player01 sprite) | (line 60) |
| `$89` | Object2 Y coordinate | (line 114) |
| `$8B` | Ball/man X coordinate | (line 64) |
| `$8C` | Ball/man Y coordinate | (line 72) |
| `$8D` | Adjusted Y (ball Y − 4) — centers the man on the requested coord | (line 75) |
| `$8E` | Scan-line counter — counts down across the visible frame | (line 89, 172) |
| `$8F` | Room-definition byte index (0–8: PF0 top, PF1 top, PF2 top, …) | (line 92) |
| `$90` | Player00 sprite-byte index | (line 138) |
| `$91` | Player01 sprite-byte index | (line 123) |

Note the asymmetry: `$8A` belongs to the ball (next group) and `$8D` is a derived value. The "Ball" hardware sprite renders the *man* — the player avatar is technically the 2600's ball, not its players. The two TIA player sprites are repurposed for whichever two game-objects are currently visible in the room.

### Ball / current room (`$8A`, `$8B`, `$8C`)

| Addr | Meaning |
|---|---|
| `$8A` | Current room number (the room the ball is in — i.e., where the player is) |
| `$8B` | Ball X coordinate (man's X) |
| `$8C` | Ball Y coordinate (man's Y) |

### Object-print pipeline (`$92`–`$9F`)

These are scratch and per-frame state for "which two objects do I show as Player00 and Player01 this frame, and what happened to them."

| Addr | Meaning |
|---|---|
| `$92` | Previous joystick state (for edge detection — see line 655 "Compare with what was before") |
| `$93`–`$94` | General-purpose 16-bit indirect pointer into object dynamic data |
| `$95` | Object slot 1 — which game object is showing as Player00 this frame |
| `$96` | Object slot 2 — which game object is showing as Player01 this frame |
| `$97` | Scratch — object collided with |
| `$98` | Scratch (single use, line 951) |
| `$99` | Scratch — joystick raw / object delta (line 1003 even the original commenter wrote `;????`) |
| `$9A` | Saved Y / portcullis number / object's dynamic data address (overloaded) |
| `$9B` | Cooked direction wanted: bit 7 right, bit 6 left, bit 5 down, bit 4 up |
| `$9C` | Last-object loop counter (during the "find what to display this frame" sweep) |
| `$9D` | Object currently being carried by the ball (`$A2` = nothing) |
| `$9E` | Object's X delta vs. ball — preserved across pickups so the held object stays at a constant offset |
| `$9F` | Object's Y delta vs. ball |

### Dragon AI scratch + Black Dot (`$A0`–`$A3`)

| Addr | Meaning |
|---|---|
| `$A0` | Object number being processed by dragon AI |
| `$A1` | Black Dot — Room |
| `$A2` | Black Dot — X (accessed only via indirect-Y through `$93/$94`, never as direct `LDA $A2`) |
| `$A3` | Black Dot — Y (same — indirect access only) |

The Black Dot is a normal 3-byte movable object at `$A1`–`$A3`, just like the static carryables. It's accessed entirely through the generic display/pickup code via the indirect pointer `($93),Y`, so nothing in the source ever names `$A2` or `$A3` directly.

**The `#$A2` sentinel coincidence.** The constant `#$A2` is used everywhere as the "no object" marker (`CMP #$A2`). That's a *value*, not an address. Robinett picked `$A2` because no object's record *starts* at address `$A2` — the dot starts at `$A1`, the dragons at `$A4`/`$A9`/`$AE`. `$A2` falls in the inter-record gap, so a pointer comparison against `$A2` can never match any real object. The address `$A2` happens to be inside the dot's record (its X byte), but since pointer comparisons use record-start addresses, no conflict.

### Movable enemies — Dragons & Bat (`$A4`–`$D1`)

Each dragon is a 5-byte record: **Room, X, Y, Movement, State**. Initialization at lines 805–807 writes 5 bytes per dragon.

| Addr | Field | Init from line 805–807 |
|---|---|---|
| `$A4`–`$A8` | Red Dragon (Room, X, Y, Movement, State) | `$14,$50,$20,$A0,$00` |
| `$A9`–`$AD` | Yellow Dragon | `$19,$50,$20,$A0,$00` |
| `$AE`–`$B2` | Green Dragon | `$04,$50,$20,$A0,$00` |

The bat extends the same shape with two extra bytes for its inventory:

| Addr | Field |
|---|---|
| `$CB` | Bat Room |
| `$CC` | Bat X |
| `$CD` | Bat Y |
| `$CE` | Bat Movement |
| `$CF` | Bat State |
| `$D0` | Object the Bat is currently carrying |
| `$D1` | Bat "Fed-Up" counter — increments on every cycle; when it overflows, bat picks something new (this is what makes the bat feel restless / mischievous) |

### Static carryable items (`$B3`–`$C7`) — Room, X, Y

3-byte records. No movement or state — when carried, X/Y are slaved to the ball; when dropped, they sit where left.

| Addr | Object |
|---|---|
| `$B3`–`$B5` | Magnet |
| `$B6`–`$B8` | Sword |
| `$B9`–`$BB` | Chalice |
| `$BC`–`$BE` | Bridge |
| `$BF`–`$C1` | Yellow Key |
| `$C2`–`$C4` | White Key |
| `$C5`–`$C7` | Black Key |

### Portcullises (`$C8`–`$CA`)

| Addr | Object |
|---|---|
| `$C8` | Portcullis #1 state (Yellow castle gate) |
| `$C9` | Portcullis #2 state (White castle gate) |
| `$CA` | Portcullis #3 state (Black castle gate) |

A portcullis has no X/Y — it's drawn at a fixed location in its castle's room. Only state matters (open / closed / opening / closing). Lines 1682, 1729 use `INC $C8,X` to advance state — the `,X` lets one routine update any of the three.

### General-purpose scratch / engine state (`$D2`–`$DD`)

| Addr | Meaning |
|---|---|
| `$D2`–`$D3` | Object Store pointer (bat AI lookup table — list of object pairs) |
| `$D4` | Current object's movement delta |
| `$D5` | Saved dynamic data address (during AI processing) |
| `$D6` | Difficulty toggle / second object in current match |
| `$D7` | Cooked joystick record (with edge-detection from `$92`) |
| `$D8` | General scratch — used in object-slot swap (309–314) and room arithmetic (1225) |
| `$D9` | Invisible Surround — Room |
| `$DA` | Invisible Surround — X |
| `$DB` | Invisible Surround — Y |
| `$DC` | Cache of current object's state byte (during state-machine lookups) |
| `$DD` | Difficulty level (1–4); also OR'd into object behavior to make objects act differently per level |

The "Invisible Surround" (`$D9`–`$DB`) is the [unique-to-Adventure mechanic](https://en.wikipedia.org/wiki/Adventure_(1980_video_game)#Gameplay) where in difficulty 2/3 an invisible barrier appears around the player in some rooms — a separate position record because it's displayed independently of the man.

## Cross-cutting observations

**The "object table" is the engine.** Almost every subsystem (display, collision, AI, pickup) iterates the table at `$FF4D` and reads/writes through the per-object pointers. The 18 records share one shape; the engine has no idea whether it's iterating a dragon or a key. This is closer to ECS than to a hand-written loop per entity. Robinett built a small game engine inside 4 KB.

**Stateful vs stateless via pointer destination.** Same record format, but the Curr pointer either targets RAM (object has a state machine — portcullis open/close, dragon idle/chase/attack/dead, bat carrying-something) or ROM (object is just a sprite — sword, key, magnet). The engine handles both transparently because everything is read through pointers. This is *the* trick that lets one engine handle eight different object types.

**Pointers everywhere despite tight RAM.** `$80`–`$85` and `$93`–`$94` are 16-bit indirection pointers. With only 128 bytes total, spending 8 of them on pointers might look wasteful, but it's what lets one display routine and one AI routine handle every object — no per-type code duplication.

**Magic-number sentinels picked from the inter-record gaps.** `#$A2` ("no object") works because no object's record *starts* at address `$A2` — the constant value falls in the gap between the Black Dot ($A1) and the Red Dragon ($A4). A pointer comparison can never hit a real object. The cost: the sentinel is fragile against future record layout changes — but Adventure shipped, so future-proofing wasn't a concern.

**Per-level behavior re-uses existing fields.** `$DD` (level) is OR'd into object data (line 1472) so a single object record produces different behavior per difficulty. No per-level lookup table needed.

**Address mirroring makes the stack work.** Because A8 isn't decoded, the 6502's hardcoded page-1 stack pushes land in RIOT RAM. The stack and game variables coexist in 128 bytes by hardware accident.

## What changed in v2 (after grounding)

Three concrete corrections from v1:

1. **v1 said "the Atari 2600 has 128 bytes of RAM, all in zero page (`$80`–`$FF`)"** — true, but obscured the *why*. Address space is sliced into TIA registers (`$00`–`$3F`), RAM (`$80`–`$FF`), and RIOT I/O (`$0280`–`$0297`), with cart ROM at `$F000`–`$FFFF`. The "stack and variables in the same 128 bytes" claim is correct, but the *mechanism* is address mirroring (A8 not decoded), not "the stack happens to live there."
2. **v1 said the object table is at "`$FFC0`-ish."** Wrong — it's at `$FF4D`–`$FFEE` for records #1–#18, plus a separately-labeled record #0 at `Store1`–`Store9`. And the record format is **9 bytes** (Info, Curr, States pointers + Color, B&W Color, Size), not "Info/Curr/States + 3 bytes meta."
3. **v1 said `$A2` is "almost certainly not used as live RAM"** and `$A3` was unaccounted. Wrong — both are part of the Black Dot's 3-byte Info record (`$A1`=Room, `$A2`=X, `$A3`=Y). They're never accessed by direct addressing, only via indirect-Y through `($93),Y` in the generic display code, which is why the grep missed them. The constant `#$A2` is still the "no object" sentinel — that's a *value*, picked specifically because no object's record *starts* at address `$A2`.

The big new pattern v2 surfaces: **stateful vs stateless objects via pointer destination.** Curr pointer to RAM = object has a state machine; Curr pointer to ROM = object is just a sprite. The engine doesn't care; it reads through the pointer either way. This is the design pattern that lets one engine handle 18 different object records.

## LLM-interpretation log (v2)

Tracking what each kind of input contributed.

**Pure structure was sufficient for:**
- Pointer pairs `$80/$81`, `$82/$83`, `$84/$85`, `$93/$94`. The pattern `STA $80; STA $81; LDA ($80),Y` makes "16-bit indirection" unambiguous.
- Object record stride. Three consecutive `.byte` lines of identical length *is* the schema, no comment needed.
- `$C8`/`$C9`/`$CA` as a 3-element array — `INC $C8,X` tells you that.

**Literal source comments carried decisive information for:**
- Which X/Y pair belongs to which game entity (Player00 vs Player01 vs Ball — the hardware names give no hint about game role).
- The semantic name of `$D1` ("Bat Fed-Up Value") — the byte is a counter; the game-design meaning ("makes the bat restless") is not in the bytes.
- Which slot (`$95` vs `$96`) maps to which TIA register at any moment.

**External knowledge (TIA / RIOT / 6507 docs) was load-bearing for:**
- TIA register semantics — addresses give location, not behavior.
- The 6502's indirect-Y addressing mode `LDA ($80),Y`.
- The 6507's 13-address-line constraint — explains both the 8 KB ROM cap *and* why ROM aliases at `$F000`/`$D000`/`$9000`/etc. all hit the same cart.
- Address-mirroring decode rules — explains the stack-in-RAM coexistence without needing a comment in the source.
- Sprite multiplexing as a technique (chapter 3) — without it, `$95`/`$96` look like redundant state.

**The diff between v1 and v2 grounding:** TIA/RIOT docs in context corrected three specific factual errors and surfaced one major design pattern (stateful-vs-stateless via pointer destination). Notably, **none of the chapter's variable identifications changed** — those were structural and correct. What needed fixing was framing (address space) and structural-format claims (object table location, record size). Same lesson as chapter 2: **structure-only analysis is reliable for shape; chip semantics and memory-map specifics need docs.**

**Even the original disassembler hit walls:** line 1003 reads `LDA $99 ;????` — the human commenter, with a running ROM, sometimes couldn't tell either. Useful baseline for "how complete should we expect any analysis to be."

## Tags

[6502](../../../tags/6502.md) · [atari-2600](../../../tags/atari-2600.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md)

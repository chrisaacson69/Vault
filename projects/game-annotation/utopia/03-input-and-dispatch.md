---
status: active
created: 2026-05-04
updated: 2026-05-04
---
# Utopia — Input & Control Dispatch
> How player input gets from the controllers into the game. The 5-entry dispatch table that turns Utopia into an event-driven program. The two-key build menu (item-then-Enter). The bit-14 ownership check on every boat pickup. RAZZ.

**Links:** [Utopia README](./README.md), [Memory Map](./01-memory-map.md), [Display & Tile System](./02-display-and-tiles.md), source: [`source/utopia.asm`](./source/utopia.asm)

## The dispatch table — Utopia is event-driven

Utopia has no main loop in the conventional sense. The 20 Hz `TICTSK` (Chapter 4) advances world state on a timer; *every other update* runs as a callback fired by the Intellivision EXEC ROM when player input arrives. The 5-entry dispatch table is the entire input-side architecture:

```asm
CTRL_DISPATCH_TBL:
        BIDECLE DISC_INPUT  ; Disc dispatch (movement)
        BIDECLE KEYPAD_INP  ; Keypad dispatch (numbers + Clear/Enter)
        BIDECLE DISP_SCORE  ; Top action button
        BIDECLE DISP_POP    ; Lower-left action button
        BIDECLE DISP_ROUND  ; Lower-right action button
```

Boot installs the table address into a known EXEC location:

```asm
        ; Set up controller dispatch table
        SDBD
        MVII    #CTRL_DISPATCH_TBL, R0
        MVO     R0,     G_035D
```

`G_035D` is the EXEC's "where do I call back when input arrives?" pointer slot. From this point on, the game is reactive: the EXEC scans both controllers each frame, and when something happens it fires the matching dispatch entry with the standard register convention:

- `R0` = the input value (key code, disc direction, or release flag)
- `R1` = which player (0 or 1)

Every dispatch handler receives those two registers. The handler does its thing and returns. **No polling code anywhere in the game.** Modern architecture for 1981.

## DISC_INPUT — moving the cursor (or a boat)

The disc is the directional thumbpad. DISC_INPUT translates it into a velocity for the player's MOB (which is either the rectangle cursor or whichever boat the player has picked up).

```asm
DISC_INPUT:
        PSHR    R5
        MVO     R1,     CURPLR          ; remember which player
        TSTR    R1
        BNEQ    L_5799                  ; branch if player 1
        MVI     G_032E, R2              ; player 0 MOB pointer

L_577C: MOVR    R0,     R1
        INCR    R0                      ; \_ disc-up event?
        BEQ     L_5796                  ; /  (R0 == -1 → release)

        SDBD
        CMPI    #F_BO_MOB_TBL, R2       ; \_ is it a boat?
        BGE     L_579D                  ; /

        MVII    #$000F, R0              ; velocity = 15 (cursor)

L_5788: JSR     R5,     X_MOB_VEL       ; EXEC: convert disc dir → MOB velocity

        MVI     CURPLR, R1
        TSTR    R1
        BNEQ    L_5793
        MVO     R0,     G_0331          ; store player 0 velocity
        PULR    R7
L_5793: MVO     R0,     G_0339          ; store player 1 velocity
        PULR    R7

L_5796: CLRR    R0                      ; \_ disc release: halt
        B       L_5788                  ; /

L_579D: MVII    #$000A, R0              ; velocity = 10 (boats slower)
        B       L_5788
```

Two branches matter:

1. **Disc release** (`R0 == -1` per the EXEC convention; `INCR R0` plus `BEQ` is the test for `R0 + 1 == 0`) → set velocity to zero. **The cursor coasts naturally based on its STIC velocity register; the game never explicitly says "stop" — it just clears the velocity once you let go.**
2. **Cursor vs boat**: if the MOB pointer is below `F_BO_MOB_TBL`, it's the rectangle cursor (faster, vel=15); otherwise it's a boat (slower, vel=10). One byte distinguishes them.

`X_MOB_VEL` is an EXEC ROM utility that takes the disc direction (R1) and a velocity magnitude (R0) and produces the X/Y velocity components. The result is stored at `G_0331` (player 0 MOB velocity register) or `G_0339` (player 1) — STIC shadow registers that the hardware reads each frame to move the sprite.

## KEYPAD_INP — the two-key build menu

The keypad input handler is the most interesting state machine in the game so far. It's a **two-key command-confirm pattern**: press a building number (1–9), then press Enter ($B) to commit, or Clear ($A) to abort. Pressing 0 is a separate cursor-mode toggle.

```asm
KEYPAD_INP:
        PSHR    R5
        MVO     R1,     CURPLR          ; remember who pressed this
        MVO     R0,     CURSEL          ; remember what key

        CMPI    #$0001, R0              ; is this an item key (1-9)?
        BGE     L_57B4                  ; yes: handle item

        ;; Key 0: toggle cursor mode (cursor ↔ boat)
        MVII    #$019B, R2              ; \
        ADD     CURPLR, R2              ;  |- read CURS_n (cursor mode)
        MVI@    R2,     R1              ; /
        TSTR    R1
        BEQ     UNPARK_BOAT             ; mode 0 (rectangle): try pickup
        B       PARK_BOAT               ; mode 8/9 (carrying boat): try drop
```

Key 0 is the **boat pickup/drop toggle**. Cursor mode 0 (the rectangle) means "grab if there's a boat under me"; mode 8 or 9 means "drop the boat I'm carrying." The same key services both because the cursor mode itself is the state.

```asm
L_57B4:
        MVII    #SLCT_0,R2              ; \
        ADD     CURPLR, R2              ;  |- get this player's selection state
        MVI@    R2,     R1              ; /

        CMPI    #$0009, R0              ; \__ R0 in 1..9?
        BLE     L_57CB                  ; /   yes: handle item key
                                        ;     no:  R0 = $A (Clear) or $B (Enter)

        CMPI    #$0014, R1              ; \_ Clear/Enter with no pending sel?
        BGE     L_5941                  ; /  RAZZ

        MVO     R1,     CURSEL          ; copy player's pending sel to CURSEL
        MVII    #$0014, R1              ; \_ reset player's selection state
        MVO@    R1,     R2              ; /

        CMPI    #$000B, R0              ; \_ Enter? then commit (buy)
        BEQ     L_5877                  ; /
        PULR    R7                      ; Clear: just leave (state is reset)

L_57CB: CMPI    #$0014, R1              ; \_ Existing selection != none?
        BNEQ    L_5941                  ; /  RAZZ (can't change pending sel)
        MVO@    R0,     R2              ; otherwise: store new selection
        PULR    R7
```

The state machine has exactly three states per player:

| `SLCT_n` | Meaning |
|---|---|
| `$14` (= 20) | Idle — no pending selection |
| `1`–`9` | An item is selected, awaiting Enter or Clear |
| (transient) | Just-pressed key being routed |

Initial state at boot is `$14`, set by the boot sequence we saw in Chapter 1 (`MVII #$0014, R0; MVO R0, SLCT_0; MVO R0, SLCT_1`). Now the `$14` sentinel makes sense: **`$14` means "no item pending,"** chosen because it's outside the valid range 1–9 (and outside the action keys $A and $B).

The transitions:

| State | Press 1–9 | Press Enter ($B) | Press Clear ($A) |
|---|---|---|---|
| `$14` (idle) | → that number; await | RAZZ | RAZZ |
| `1`–`9` | RAZZ (can't change sel) | commit purchase via `L_5877` | reset to `$14` |

The "press item, then press Enter" pattern doubles the input cost over a one-key system, but in exchange the player can review their choice on the cursor before committing. **Confirm-before-act** discipline — the same instinct that makes modern UIs put a "Buy" button next to the cart total instead of charging on every click.

## Where the boat-grab actually checks ownership

Pressing 0 with cursor mode 0 falls through to `UNPARK_BOAT`. This is where the bit-14 ownership trick from Chapter 2 actually gets enforced:

```asm
UNPARK_BOAT:
L_57D8: JSR     R5, MOB_TO_CARD     ; Get BACKTAB card under cursor

        MVI@    R2,     R0          ; Read card from display
        MOVR    R0,     R3
        SLLC    R3,     2           ; \_ Bit 14 = 0 → owned by player 1
        BOV     L_5814              ; /  Bit 14 = 1 → owned by player 0

        MVI     CURPLR, R3          ; \
        TSTR    R3                  ;  |- RAZZ if owned by player 1
        BEQ     L_5941              ; /   but CURPLR is 0 (cross-pickup)

L_57E5: JSR     R5, GET_TILE_NO     ; What kind of thing under cursor?

        CMPI    #$0008, R1          ; PT boat?
        BEQ     L_57F2
        CMPI    #$0009, R1          ; Fishing boat?
        BEQ     L_57F2
        B       L_5941              ; Neither: RAZZ
```

Three checks before a boat can be picked up:

1. **Is there *anything* tagged with bit-14 ownership under the cursor?** If bit 14 is set (player 0's territory), the L_5814 branch checks that CURPLR is 0; if not, RAZZ. Symmetric for bit 14 clear (player 1).
2. **Is the tile under the cursor card 8 (PT boat) or card 9 (Fishing boat)?** If it's anything else (an island tile, a building, the sea), RAZZ.
3. **If both pass**, remove the boat card from BACKTAB (`ANDI #$3007, R0; MVO@ R0, R2` — clears bits 3–10 = the card # — leaving only the format word's color and bits) and update the player's MOB to display the boat sprite.

The ownership check is two CP1610 instructions: `SLLC R3, 2; BOV L_5814`. Shift-left twice puts bit 14 into the carry/overflow flag; `BOV` branches on overflow. **One bit, two instructions, complete cross-island theft prevention.**

The same shape — `MOB_TO_CARD; GET_TILE_NO; check ownership; check tile-type` — recurs throughout the game whenever the cursor interacts with the world. Once you've internalized this 8-line pattern, half the engine becomes legible at a glance.

## The action buttons — display, not act

The three action buttons (top, lower-left, lower-right) all do the same thing: **show a stat in the status bar while the button is held, hide it when released.** They share a common implementation pattern:

```asm
DISP_SCORE:                             ; (top action button)
L_5987: PSHR    R5
        TSTR    R0                      ; R0 < 0 means key release
        BMI     L_59A1                  ; if so, undisplay
        MVO     R7,     BARINH          ; suppress gold-bar display
        MVII    #SCOR_0, R4             ; \
        ADDR    R1,     R4              ;  |_ get player score (2-byte)
        ADDR    R1,     R4              ;  |  R1 is 0 or 1; stride is 2
        SDBD                            ;  |
        MVI@    R4,     R0              ; /
L_5993: TSTR    R1
        BNEQ    L_59A5                  ; player 1 → bottom-right
        MVII    #$02DD, R4              ; \
        CLRR    R3                      ;  |- bottom-left position
        XORI    #$0004, R3              ; /
L_599B: MVII    #$0004, R1              ; \_ 4-digit number
        JSR     R5, X_PRNUM_RGT         ; /
        PULR    R7

L_59A1: CLRR    R1                      ; \
        MVO     R1,     BARINH          ;  |- on release: re-enable gold display
        PULR    R7                      ; /

L_59A5: MVII    #$02EB, R4              ; \_ player 1's status area position
        CLRR    R3
        XORI    #$0002, R3
        B       L_599B
```

`DISP_POP` and `DISP_ROUND` use the same `L_5993` / `L_599B` tail — they only differ in *which value* gets loaded into R0 (population vs round score) before the shared print logic. `DISP_ROUND_U` is even more compact — it's just "load the round score and jump to the shared display path." **Four user-visible features, one shared 12-instruction printer.**

The address-arithmetic pattern is worth noting. To get a per-player address from a parallel array:

```asm
MVII    #SCOR_0, R4         ; base = address of player 0's slot
ADDR    R1,     R4          ; \_ stride = 2 bytes per player,
ADDR    R1,     R4          ; /  so add R1 twice
```

For 1-byte arrays (RSCO, RGLD), it's a single `ADDR R1, R4`. The stride matches the data-element size — same convention everywhere, easy to recognize.

## The BARINH ("bar inhibit") flag

`BARINH` ($18B from the memory map) gates the gold-bar display. While an action button is held — showing a stat overlay in the status bar — the gold bar refresh would *overwrite* the displayed number. Setting `BARINH = 1` suppresses that, restoring it on key release. This is **soft mutex by flag**, the 1981 alternative to anything fancier.

It's a recurring game-developer question: how do you have two pieces of UI compete for the same screen real estate without flicker? Utopia's answer is to give one a flag the other can check. Cost: one byte of RAM, one TST per gold-bar refresh.

## Curiosities

**The dispatch table is in ROM, not RAM.** `CTRL_DISPATCH_TBL` is a static fragment in the cartridge — the EXEC reads the pointer once at boot and follows it. Means the game can't reconfigure dispatch on the fly without rewriting RAM. (And it does, exactly once, at game-end: `MVII #$1906, R0; MVO R0, G_035D` disables the controllers entirely.)

**Address arithmetic relies on the per-player stride matching data size.** If `SCOR` were 4 bytes instead of 2, the `ADDR R1, R4` pattern would need three additions, not two. The convention is uniform across the codebase but it's a fragile contract — adding a new per-player resource of the wrong size would break every parallel-array reader silently.

**No keypad debouncing in the game code.** Holding a key would presumably re-fire the dispatch, but every call sets `SLCT_n` to the same value, so re-fires are idempotent. Building purchase (`L_5877`) presumably guards against double-buy somewhere — worth checking when we read building economy in Chapter 5.

**The "RAZZ" sound** is the universal error response — everywhere an invalid input is detected, control jumps to `L_5941` which plays a buzzer and exits. Frequent enough to be its own design idiom: **the engine never silently ignores an input.** Either the input does something or you hear a noise. This is honest UX for 1981 — better than the game appearing frozen on bad input.

## What this clarifies for later chapters

- **Chapter 4 (tic engine)**: TICTSK runs at 20 Hz alongside the event-driven dispatch. The two are independent — gameplay state advances on TICTSK regardless of input, but input drives building placement, fishing, and combat resolution. The gold-bar display from BARINH connects here.
- **Chapter 5 (building economy)**: `L_5877` is the purchase commit that runs after Enter is pressed. The selection in `CURSEL` plus the cursor position fully determines the buy. Building cost validation, gold debit, and structure placement all happen there.
- **Chapter 6 (MOBs / world)**: the MOB ROM tables (G_032E for player 0, G_0336 for player 1, F_BO_MOB_TBL, PTBO_MOB_TBL) are the per-MOB configuration data. UNPARK_BOAT swaps the player's MOB table pointer to the boat-shape table when the boat is picked up — same MOB slot, different graphics.
- **Chapter 7 (rebel system)**: rebels use the same MOB infrastructure plus the bit-14 ownership check to land on the *opposing* player's island. RBLTRY (250 placement attempts) is the rejection budget for valid landing tiles.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | The dispatch architecture, the keypad state machine boundaries, the boat-pickup pattern, the four shared-tail display routines. Naming is consistently good (`SLCT_n`, `CURSEL`, `BARINH`, `UNPARK_BOAT`). |
| **Source comments** | The `R0 = $A for clear, $B for enter` distinction, the cursor-mode encoding (0 = rect, 8 = PT boat, 9 = fishing boat), the MOB ROM pointer assignments per player, the bit-14 cross-reference back to Chapter 2. |
| **CP1610 ISA knowledge required** | `SLLC R, 2; BOV` for high-bit testing (already learned in Chapter 2 — paying off now). The `INCR R0; BEQ` test for "R0 == -1" (key release sentinel). The `MVI@`/`MVO@` indirect mode chain for parallel-array access. Nothing new this chapter — the Chapter 1 + Chapter 2 vocabulary was sufficient. |
| **External hardware knowledge required** | The EXEC ROM's input-callback architecture and the role of `G_035D`. The MOB velocity register convention at `G_0331` / `G_0339`. The Intellivision controller's disc + 12-key layout (numbers 0–9, Clear, Enter — modeled exactly by the keypad input handler). All from Intellivision dev reference; ~5 lines of doc. |
| **Disagreements with source** | The comment at `L_57BD` says `R0 = $A for clear, $B for enter` but doesn't explicitly note that $14 is the "no selection" sentinel — that was deduced from the boot init in Chapter 1 plus the comparisons in this chapter. Worth flagging because the sentinel value drives the entire state machine. |

Net: this chapter required zero new ISA knowledge — the Chapter 2 toolkit (SLLC + BOV bit-test, parallel-array stride, BACKTAB readers) carried it. The hypothesis from the README continues to hold: **source quality + accumulating idiom vocabulary > deep ISA reference for understanding the engine.**

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)

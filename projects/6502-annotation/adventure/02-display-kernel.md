---
status: active
created: 2026-04-26
updated: 2026-04-26
---
# Adventure — The Display Kernel
> How Adventure paints a frame on a chip with no frame buffer, on a CPU with no interrupts. Every scan line is hand-timed.
> *Revised after grounding against the [TIA reference](../../../research/atari-2600/tia-reference.md). See "What changed in v2" at the bottom.*

**Links:** [Adventure README](./README.md), [Memory Map](./01-memory-map.md), [TIA Reference](../../../research/atari-2600/tia-reference.md), source: [`raw/adventure.asm`](../../../raw/adventure.asm)

## The two constraints

**1. The TIA has no frame buffer.** It has registers describing what's on the screen *right now*. The CPU updates those registers as the electron beam moves. The picture is generated *by* the CPU keeping pace with the CRT.

**2. The 6507 has no interrupts.** No NMI, no IRQ. You cannot write a vertical-blank handler. The chip gives you `WSYNC` (parks the CPU until the next HBLANK) and `INTIM` (a hardware countdown timer). Every frame is hand-counted.

Together: **the CPU is the video chip's slave**. NTSC frame = 262 scan lines × 76 CPU cycles ≈ 19,912 cycles. Of those, only the off-screen regions (~67 lines × 76 cycles ≈ 5,000 cycles) are available for game logic.

## NTSC frame structure

| Region | Lines | Notes |
|---|---|---|
| VSYNC | 3 | Tells CRT to retrace |
| VBLANK | 37 | Beam off-screen at top; safe for work |
| Visible | 192 | Picture; CPU must feed TIA every line |
| Overscan | 30 | Beam off-screen at bottom; safe for work |
| **Total** | **262** | 60 fps NTSC |

## Adventure's main loop

```
DoVSYNC          (line 224)  — assert VSYNC for 3 lines, set VBLANK timer
SetupRoomPrint   (line 244)  — load room ptr/color/CTRLPF; CTRLPF.REF=1 → mirrored playfield
   ↓ (game logic during VBLANK, gated by INTIM)
PrintDisplay     (line 54)   — position sprites
PrintDisplay_1   (line 77)   — block on INTIM until visible region begins
PrintPlayer01    (line 111)  — visible kernel, top of loop
PrintPlayer00    (line 126)  — falls through; second half
PrintPlayer00_4  (line 181)  — sprite-only branch (PF unchanged)
PrintPlayer00_3  (line 171)  — DEC $8E, loop or exit
TidyUp           (line 188)  — clear sprites, start TIM64T for overscan budget
   ↓ (game logic during overscan)
DoVSYNC          back to top
```

## The visible kernel — two scan lines per loop iteration

This is the part I had wrong in v1. The kernel has **two `WSYNC` calls per loop iteration**, which means **each iteration of `DEC $8E` covers two scan lines**, not one. Let me show the structure:

```asm
PrintPlayer01:                        ; --- LINE A: prep ---
       LDA    $8E                     ; check P1 Y match
       SEC
       SBC    $89
       STA    WSYNC                   ; ← WSYNC #1: park at start of line A
       BPL    PrintPlayer00           ; if Y not reached, skip P1 fetch

       LDY    $91                     ; fetch next P1 sprite byte
       LDA    ($84),Y
       STA    GRP1                    ; write to GRP1 — BUFFERED via VDEL01
       BEQ    PrintPlayer00
       INC    $91

PrintPlayer00:
       LDX    #$00                    ; check P0 Y match
       LDA    $8E
       SEC
       SBC    $87
       BPL    PrintPlayer00_1

       LDY    $90                     ; fetch P0 sprite byte
       LDA    ($82),Y
       TAX                            ; stage in X for STX GRP0 below
       BEQ    PrintPlayer00_1
       INC    $90

PrintPlayer00_1:                      ; check ball Y match
       LDY    #$00                    ; assume ball off
       LDA    $8E
       SEC
       SBC    $8D
       AND    #$FC                    ; ±4 line tolerance
       BNE    PrintPlayer00_2
       LDY    #$02                    ; ball on

PrintPlayer00_2:                      ; --- LINE B: commit ---
       LDA    $8E
       AND    #$0F                    ; every 16th iteration → playfield refresh
       BNE    PrintPlayer00_4

       STA    WSYNC                   ; ← WSYNC #2: park at start of line B
       STY    ENABL                   ; commit ball state
       STX    GRP0                    ; write GRP0 — also COMMITS GRP1 via VDEL01
       LDY    $8F                     ; refresh playfield
       LDA    ($80),Y
       STA    PF0
       INY
       LDA    ($80),Y
       STA    PF1
       INY
       LDA    ($80),Y
       STA    PF2
       INY
       STY    $8F

PrintPlayer00_3:
       DEC    $8E                     ; advance loop counter (1 dec = 2 lines)
       LDA    $8E
       CMP    #$08
       BPL    PrintPlayer01

PrintPlayer00_4:                      ; sprite-only commit (no PF refresh)
       STA    WSYNC                   ; ← WSYNC #2 (alt branch)
       STY    ENABL
       STX    GRP0                    ; commits both GRP0 and buffered GRP1
       JMP    PrintPlayer00_3
```

Why two scan lines? Because `STA WSYNC` parks until the *next* HBLANK. Two `WSYNC`s with work between them = two scan-line transitions = two scan lines per iteration. `$8E` starts at `$68` (104) and the loop exits when it reaches 8 — **96 iterations × 2 lines = 192 scan lines**, exactly the NTSC visible region.

## The VDEL01 double-buffer trick

Line 87, in `PrintDisplay`'s setup:

```asm
       LDA    #$01
       STA    VDEL01              ;vertically delay Player 01
```

This sets `VDEL1 = 1`. With vertical delay enabled, GRP1 is **double-buffered**: a write to GRP1 lands in the "new" copy but doesn't display until the next write to GRP0 commits both atomically.

Combined with the two-line iteration:
- **Line A**: write `GRP1` → buffered, not yet visible. Player 1 still shows whatever it showed last frame's pair.
- **Line B**: write `GRP0` → commits BOTH the new GRP0 and the previously-buffered GRP1, on the same beam pass.

Without VDEL01, writing GRP1 mid-line would smear the sprite. With it, all sprite updates happen cleanly during HBLANK at the start of line B. This is the central trick that makes the kernel work — and there's exactly one line in the source that sets it up.

## The 32-line playfield refresh

`PrintPlayer00_2` checks `LDA $8E ; AND #$0F ; BNE skip`. The PF refresh fires only when `$8E AND $0F == 0`. Because `$8E` decrements once per **two scan lines**, the refresh fires every **16 iterations × 2 lines = 32 scan lines**.

So Adventure paints the room as **6 horizontal stripes** (192 / 32) of mirrored playfield. With CTRLPF.REF = 1, each PF0/PF1/PF2 triple draws one half-line that's mirrored across the screen.

Playfield pixel granularity: each PF bit is **4 color clocks ≈ 4 pixels wide**. PF0 contributes 4 visible bits, PF1 contributes 8, PF2 contributes 8 → 20 bits per half × 4 CLK = 80 CLK = half the visible width. Mirrored = 160 CLK = full visible width.

So Adventure's playfield "tile" is **4 CLK wide × 32 scan lines tall**, mirrored left-to-right. This is *why* every Adventure room is left-right symmetric and visually blocky. Refreshing more often would produce finer vertical detail but cost cycles the kernel doesn't have.

(Note on the comment in the source: line 152 says "Have we reached a sixteenth scan line." The original disassembler was wrong — or, charitably, was counting iterations rather than physical lines.)

## The Y-match pattern

Each player sprite has a Y coordinate. The kernel checks every scan-line iteration:

```asm
       LDA    $8E                 ;current scan-line counter
       SEC
       SBC    $87                 ;subtract Object1's Y
       BPL    PrintPlayer00_1     ;not yet reached → skip
```

If `$8E ≥ Y`, the sprite hasn't begun yet (we're above its top). When `$8E < Y`, fetch successive sprite bytes via the indirect pointer `($82),Y` and increment `$90`. The same pattern handles Player01, the ball, and (chapter 3 will show) every other moving entity.

## The marquee trick — `PosSpriteX` (line 198)

Recall from the [TIA reference](../../../research/atari-2600/tia-reference.md): the TIA has no "set sprite X" register. Position is determined by *when* you write to `RESP0`/`RESP1`/`RESBL` — the write latches the sprite to the current beam position (with a 5-pixel offset, since RESPx takes 4 CLK to reset + 1 CLK latch delay).

```asm
PosSpriteX:
       LDY    #$02                ;start with 2 in Y (10-cycle offset)
       SEC
PosSpriteX_1:
       INY
       SBC    #$0F                ;divmod by 15
       BCS    PosSpriteX_1
       EOR    #$FF                ;remainder → fine offset
       SBC    #$06                ;adjust into HMxx range
       ASL                        ;shift into high nybble
       ASL                        ;(HMxx is signed nybble in upper 4 bits)
       ASL
       ASL
       STY    WSYNC               ;park at start of next line
PosSpriteX_2:
       DEY                        ;burn cycles to advance the beam
       BPL    PosSpriteX_2
       STA    RESP0,X             ;latch sprite at current beam position
       STA    HMP0,X              ;store fine-motion offset
       RTS
```

What's happening:

- **Coarse positioning via cycle burning.** 1 CPU cycle = 3 color clocks = 3 horizontal pixels. The `DEY/BPL` loop after `WSYNC` burns Y machine cycles → advances the beam ~3·Y pixels. After `RESP0`, the sprite latches there (+5 pixels).
- **Fine positioning via HMOVE.** The remainder of `(X / 15)` becomes a signed-nybble offset in `HMP0`. The next `STA HMOVE` (issued elsewhere) shifts every sprite by ±8 pixels max. This nudges the sprite to the exact target column.
- **One routine for all five movables.** `STA RESP0,X` indexed by X (0–4) hits any of P0/P1/M0/M1/Ball. The `PrintDisplay` setup at lines 56–66 calls `PosSpriteX` three times — for Object1, Object2, and the man — using one routine across all sprite types.

The `STA WSYNC` between fine-offset computation and `STA RESP0,X` is the alignment trick: it ensures the cycle-burn loop starts at a known beam position (column 0), so the burn count corresponds directly to a target column.

This routine — **divmod by 15, burn the remainder, latch with RESP, fine-tune with HMOVE** — is one of the most-copied snippets in 2600 history. Modern programmers still find new variants.

## Cycle budget — verifying with the source's annotations

The source's right-margin cycle counts let us check the math. **Worst case for line A** (P1 Y matched, falls through to P0 Y matched):

```
WSYNC release →
PrintPlayer01 body:           3+5+3+2+5            = 18
PrintPlayer00 body:           2+3+2+3+2 + 3+5+2+2+5 = 29
PrintPlayer00_1 ball check:   2+3+2+3+2+2+2        = 16
PrintPlayer00_2 dispatch:     3+2+2 (BNE not taken) = 7
                              ─────
Total:                        70 cycles
```

70 cycles vs the 76-cycle line budget — fits with margin. For the WSYNC-#2 to next-WSYNC-#1 stretch (line B with PF refresh):

```
WSYNC release →
ENABL/GRP0 commit:            3+3                  = 6
PF refresh:                   3+5+3+2+5+3+2+5+3+2+3 = 36
DEC $8E + branch:             5+3+2+2              = 12
                              ─────
Total:                        54 cycles
```

54 cycles — comfortable. Then PrintPlayer01 of next iteration runs another 8 cycles before WSYNC #1 → ~62 cycles total during line B's visible portion. Under budget.

Robinett's cycle counts add up. The kernel was sized to fit, with no slack for accident.

## The overscan budget — `TIM64T`

After the visible kernel:

```asm
TidyUp:
       LDA    #$00
       STA    GRP1                ;clear sprites
       STA    GRP0
       LDA    #$20
       STA    TIM64T              ;arm 32 × 64 = 2048-cycle countdown
       RTS
```

The hardware timer counts down at one tick per 64 CPU cycles. `INTIM` is polled at the start of next frame's setup — if game logic overruns, the picture corrupts visibly. Adventure's logic is sized to the budget. The DoVSYNC routine arms a separate `$2A × 64 = 2,688-cycle` budget for the room-setup phase before visible begins.

## Efficiency catalogue (chapter 2 entries)

- **Two-line iteration with VDEL01 double-buffer** lets sprites update atomically without smearing, while spreading the compute over two scan lines.
- **Playfield refresh once per 32 lines** trades vertical resolution for sprite-fetch cycles. Defines Adventure's blocky look.
- **CTRLPF.REF mirroring** halves the playfield data Robinett has to encode per room.
- **One `PosSpriteX` for all five movables** via `STA RESP0,X` indexing.
- **Cycle-burning for sub-pixel positioning** — time *is* horizontal position on this hardware.
- **One scan-line counter (`$8E`) drives every decision** — Y-match, 16-iteration boundary, exit condition.
- **`STA WSYNC` is free synchronization** — no clock, no interrupt, just a register write.
- **`TIM64T` enforces the time budget** — overrun corrupts the picture, which is the chip's way of forcing you to fit.

## What changed in v2 (after grounding)

Five concrete corrections from v1:

1. **v1 said "two-phase kernel staggers work across lines."** Wrong. Each iteration covers **two scan lines**, with `WSYNC #1` parking at line A, work happening during line A, `WSYNC #2` parking at line B, and commit writes happening at line B. The "stagger" is *within* one iteration via VDEL01, not across iterations.
2. **v1 said "8×16 pixel playfield tiles."** Wrong on both axes. Each PF bit is **4 color clocks wide**, and PF refresh fires every **32 scan lines** (16 iterations × 2 lines), not every 16. Adventure paints **6 horizontal stripes** per room.
3. **v1 missed VDEL01 entirely.** The single line at 87 (`STA VDEL01`) is the load-bearing trick — without it the two-line kernel structure smears sprites. Now properly explained.
4. **v1 missed CTRLPF.REF mirroring.** The reason every Adventure room is left-right symmetric. Now noted in the SetupRoomPrint description.
5. **v1 said "Adventure uses ~96 of 192 visible lines."** Wrong by exactly 2×. 96 iterations × 2 lines = 192 lines = the full NTSC visible region.

## LLM-interpretation log (v2 — with TIA docs in context)

**Pure structure was sufficient for** (unchanged from v1):
- Identifying the loop as a counter-driven kernel.
- Recognizing `PosSpriteX` as a divmod-by-15.
- The Y-match pattern.

**The literal source comments still helped with:**
- Per-register intent ("Wait for end of current frame" beats "STA INTIM").
- Variable naming ($8E = "Scan Line Count").

**External knowledge that v1 needed but didn't have:**
- That `STA WSYNC` parks until the *next* HBLANK — implying two `WSYNC`s = two scan lines (not "two halves of one line"). I had this backwards.
- That `VDEL01` exists and double-buffers sprite writes. The source aliases `VDEL01 = $26` at line 28; without docs you'd see one assignment to it and not realize it activates a major hardware feature.
- That CTRLPF bit 0 is the mirror flag (REF). Line 282 writes CTRLPF; without docs the value's meaning is opaque.
- Exact playfield bit width (4 color clocks per bit) and bit ordering (PF1 MSB-first, PF2 LSB-first — *opposite*).
- That HMOVE extends HBLANK by 8 CLK — relevant for cycle accounting near sprite repositioning.

**The meta-finding.** Putting TIA docs in context **did** improve the chapter — significantly. Five concrete corrections and one major restructuring. The errors v1 made were not "could be wrong, plausibly correct" — they were **specific and falsifiable**, and exactly the type that documentation grounding catches.

This validates the project's reusable `research/` structure: chapter 3 (sprite multiplexing) and chapter 6 (dragon AI, which uses NUSIZ) will pull from the same TIA reference. The investment amortizes.

But also note what *didn't* change: the algorithmic recognition (divmod, Y-match, counter), the high-level architecture (two-line iteration, scan-line driven), and the efficiency commentary all survived. Pure-structure analysis was correct where it applied; the corrections were all chip-semantics, not control flow.

## Tags

[6502](../../../tags/6502.md) · [atari-2600](../../../tags/atari-2600.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md)

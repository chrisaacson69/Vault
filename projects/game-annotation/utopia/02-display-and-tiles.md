---
status: active
created: 2026-05-04
updated: 2026-05-04
---
# Utopia — Display & Tile System
> How the two islands get on screen, the 16-bit display word format, and the brilliant bit-14 trick that makes BACKTAB itself encode tile ownership.

**Links:** [Utopia README](./README.md), [Memory Map](./01-memory-map.md), source: [`source/utopia.asm`](./source/utopia.asm)

## STIC display architecture

The Intellivision's video chip is the **STIC** (Standard Television Interface Chip). Two memory regions matter for Utopia:

- **BACKTAB** at `$0200`–`$02EF` — 240 16-bit cards arranged as a **20-column × 12-row tile map**. Each card is one display word.
- **GRAM** at `$3800`–`$39FF` — 64 user-definable 8×8 graphics cards (8 bytes each). Programs load tile shapes here at boot.
- **GROM** — read-only graphics in the EXEC ROM (alphanumerics, basic shapes). The display word's bit 11 selects GRAM vs GROM as the tile source.

Sprites (MOBs) are a *separate* hardware layer with their own register set and GRAM-card backing — those are out of scope for this chapter (covered alongside the world objects in Ch6).

## The 16-bit display word

Each BACKTAB card is a packed 16-bit word. The bits Utopia cares about, by what we observe in the source:

| Bit | Meaning |
|---|---|
| 0–2 | Color (3 bits, indexes into Color Stack) |
| 3–10 | Card number (8 bits, 0–255) |
| 11 | GRAM/GROM select (`1` = GRAM, `0` = GROM) |
| 14 | **Utopia-specific: island ownership** (`1` = left island = Player 0; `0` = right or Player 1) |

The card number is in bits 3–10 because tile shape data is 8 bytes long, so the hardware uses the value shifted left by 3 as a card-data offset. `GET_TILE_NO` reverses this:

```asm
GET_TILE_NO:
        PSHR    R5
        MVI@    R2,     R1          ; Read card from BACKTAB
        SLR     R1,     2           ; \_ shift right by 3 to recover
        SLR     R1,     1           ; /  the 8-bit card number
        ANDI    #$00FF, R1          ; mask out other bits
        PULR    R7
```

`GRAM_OR_GROM` looks at bit 11 only:

```asm
GRAM_OR_GROM:
        PSHR    R5
        MVI@    R2,     R1          ; Get card
        SDBD
        ANDI    #$0800, R1          ; Keep GRAM/GROM bit
        TSTR    R1                  ; Z = 1 means GROM, Z = 0 means GRAM
        PULR    R7
```

These two routines are the **only readers of the display word** in the engine — every other consumer of "what tile is at this position?" goes through them. That's the entire BACKTAB inspection API.

## Clearing the screen

CLRSCR is two MVII setups around `X_FILL_ZERO`:

```asm
CLRSCR:
        PSHR    R5
        MVII    #$0200, R4          ; \   Clear the screen
        MVII    #$00F0, R0          ;  |- by writing 0 to
        JSR     R5, X_FILL_ZERO     ;  |  $200 - $2EF
        PULR    R7
```

`$00F0` = 240 — exactly the BACKTAB size. So CLRSCR overwrites every card with `$0000`, which decodes to "card 0, GROM, color 0" — i.e., a black background. Called at boot and at most state transitions.

## How an island gets on screen — the two-table unpack

The two islands are stored not as a 2D pixel map but as **two parallel sparse lists**:

- An **offset table** — addresses into BACKTAB where land tiles go
- A **picture table** — which GRAM card to put at each of those addresses

There's one pair per island. Sea is implicit (anywhere not in the offset list stays cleared from CLRSCR).

```asm
LFT_ISLE_OFS_TBL:
        DECLE   $002A,  $003D,  $003E,  $003F   ; cards in the upper-left
        DECLE   $0051,  $0052,  $0053,  $0065   ;
        DECLE   $0066,  $0067,  $0068,  $0069   ;
        ...                                     ; 31 entries total
        DECLE   $00AB

RGT_ISLE_OFS_TBL:
        DECLE   $0032,  $0033,  $0035,  $0038   ; cards in the upper-right
        ...                                     ; 31 entries total

LFT_ISLE_PIC_TBL:
        DECLE   $0013, $0014, $0000, $0015,     ; GRAM card numbers
        ...                                     ; in same order as offsets
RGT_ISLE_PIC_TBL:
        DECLE   $0014, $0015, $0013, ...
```

The author of the source even drew the islands in ASCII as a comment (line 357 of asm). They're roughly mirror-image landmasses with terrain detail — about 31 land tiles each.

The unpack loop (in the boot sequence at `L_50D7`) walks both tables in lockstep:

```asm
        SDBD                            ; \
        MVII    #LFT_ISLE_OFS_TBL, R1   ;  |_ Set up pointers to
        SDBD                            ;  |  offset and picture tables
        MVII    #LFT_ISLE_PIC_TBL, R4   ; /

L_50D7: MVI@    R1,     R2              ; Get next offset
        ADDI    #$0200, R2              ; Turn into BACKTAB pointer

        ; Setup format word based on left vs right island
        SDBD
        CMPI    #RGT_ISLE_OFS_TBL, R1   ; Are we on right island?
        BGE     L_50E6                  ;
        SDBD
        MVII    #$4803, R0              ; No: bit 14 SET (left)
        B       L_50EA
L_50E6: SDBD
        MVII    #$0803, R0              ; Yes: bit 14 CLEAR (right)

L_50EA: JSR     R5, DISP_ISLE_CARD      ; Display GRAM card

        SDBD
        CMPI    #LFT_ISLE_PIC_TBL, R1   ; Loop until end of table
        BNEQ    L_50D7
```

The single loop processes **both islands back-to-back** because the LFT_ tables are followed immediately in memory by the RGT_ tables — when the offset pointer crosses the boundary `RGT_ISLE_OFS_TBL`, the format word switches from `$4803` (bit 14 set) to `$0803` (bit 14 clear). One loop, both islands, the format word is the only thing that changes mid-stream.

## DISP_ISLE_CARD — the per-card write

The actual render of one tile:

```asm
DISP_ISLE_CARD:
        PSHR    R5
        MVI@    R4,     R3              ; Get card index from picture table
        SLL     R3,     2               ; \_ shift left by 3 for display
        SLL     R3,     1               ; /  (recall: card # is in bits 3-10)
        XORR    R3,     R0              ; Merge with format word
        MVO@    R0,     R2              ; Write to BACKTAB
        INCR    R1                      ; Advance offset pointer
        PULR    R7
```

XOR (not OR) because the picture-table card numbers are bare integers — no bits need to be cleared from the format word. The shift-left-by-3 puts the card number in bits 3–10 where the STIC expects it. The format word `$4803` or `$0803` already carries the GRAM bit (11), color (bits 0–2 = 3 = "tan"), and the island marker (bit 14).

Net cost: **one BACKTAB write per land tile**, ~62 writes for both full islands.

## The bit-14 ownership trick

This is the design move worth highlighting. **The screen layout itself encodes which player owns each tile.** Once an island card is written, its bit 14 permanently tags it as Player 0's or Player 1's territory. Game logic that needs to know "whose island is this fishing boat parked next to?" doesn't consult a separate ownership map — it reads the BACKTAB card directly:

```asm
PARK_FISH:
        PSHR    R5
        JSR     R5, MOB_TO_CARD     ; \_ Look at the BACKTAB card
        JSR     R5, GET_TILE_NO     ; /  under the school of fish
        CMPI    #$0009, R1          ; Parked fishing boat?
        BNEQ    L_54CA
        MVI@    R2,     R1          ; \   Read card again, this time
        SLLC    R1,     2           ;  |  for the bit-14 island marker.
        BOV     L_54B2              ;  |- Bit 14 = 1 → Player 0
        MVII    #$0001, R1          ;  |        bit 14 = 0 → Player 1
        B       L_54B3              ;  |
L_54B2: CLRR    R1                  ; /
L_54B3: MVO     R1,     CURPLR
```

`SLLC` (shift left + carry) followed by `BOV` (branch on overflow) is the CP1610 idiom for "test the high bit" — after the shift, the original bit 14 is in the overflow flag. Two instructions, no register clobbering. Source comment explicitly cross-references the unpack: `Same as island cards. (see unpk code above)`. The same encoding is used in two places.

**Why this is brilliant:** in 1981, RAM is the binding constraint. Storing a separate ownership byte per tile would be 240 bytes of RAM — twice the entire game-state allocation. Storing it as one bit inside an already-existing display word is *free*. The display hardware doesn't care about bit 14 (it only reads bits 0–11 for rendering), so the bit is available for whatever the game wants to encode.

## GRAM initialization at boot

The cartridge header points the EXEC ROM at the GRAM init sequence:

```asm
.GRAM_INIT_5024:
        DECLE   $0021           ; # of GRAM cards to init = 33 (decimal)
        DECLE   $0001,  $0380   ; #00-07: from CART offset $0380
        DECLE   $0011,  $0380   ; #08-0F:
        DECLE   $0021,  $0380   ; #10-17:
        DECLE   $0031,  $0380   ; #18-1F:
        DECLE   $0040           ; #20:    one final card
```

**33 GRAM cards** load at boot. That's the entire visual vocabulary of Utopia: the 9 building tiles, terrain variants (the picture-table values $0013–$0020 we saw above are GRAM card indices in this range), water, status-bar glyphs, and a few cursor/animation cards. The Intellivision's GRAM has 64 cards total, so Utopia uses about half — leaving room for MOB sprites in the upper half (`$01F0` down to `$0180` per the MOB allocation in the header).

## The status bar — text on the bottom rows

Status display is just BACKTAB writes near the end of the visible region. Coordinates we observe in the source:

| BACKTAB addr | Position | Used for |
|---|---|---|
| `$0229` | row 1, col 9 | "TERM OF OFFICE:" prompt at game start |
| `$0279` | row 5, col 25 | "TURN LENGTH:" prompt |
| `$02CC` | bottom area | "FINAL SCORE" header |
| `$02E3` | row 11, col 3 | turns remaining (number) |
| `$02E5` | row 11, col 5 | remaining seconds (number) |

`STAT_UPD_TIME` shows the rendering pattern:

```asm
STAT_UPD_TIME:
        PSHR    R5
        MVI     NUMTRN, R0
        SUB     CURTRN, R0          ; turns remaining = NUMTRN - CURTRN
        MVII    #$0002, R1          ; field width = 2 digits
        CLRR    R3
        XORI    #$0006, R3          ; color = 6
        MVII    #$02E3, R4          ; BACKTAB position
        JSR     R5, X_PRNUM_RGT     ; right-justified number print

        MVI     REMSEC, R0
        MVII    #$0004, R1          ; field width = 4 digits
        MVII    #$02E5, R4
        JSR     R5, X_PRNUM_RGT
        J       L_54E8              ; → update sinking ships
```

`X_PRNUM_RGT` is an EXEC ROM utility that converts a number to text and writes glyph card numbers to BACKTAB starting at the given position. Color bits (3 bits in the display word) supply the text color directly. **No separate text framebuffer** — the bottom rows of BACKTAB serve double duty as the status display, with text glyphs sourced from GROM (bit 11 = 0).

The status updates run on the per-tic flow (Chapter 4), but the *display mechanism* is what we just saw: write glyph card numbers into BACKTAB, color via bits 0–2.

## What this chapter clarifies for later ones

- **Tile lookups everywhere go through GET_TILE_NO and GRAM_OR_GROM.** Every collision routine, every "is there a building here?" check, every world-event scatter will route through these two readers. They're only ~10 instructions each but they're the engine's BACKTAB API.
- **Bit 14 is the ownership oracle.** Anywhere later code asks "which player owns this?", it's reading bit 14 from a BACKTAB card. This is how forts protect *their player's* islands without a separate adjacency table — the fort knows which side it's on.
- **Status display is just BACKTAB writes near the end of the region.** No separate text layer, no sprite-based digits. Whatever updates the gameplay state at the right address reflows the on-screen text immediately.

## Curiosities

**The `SDBD` prefix appears constantly.** SDBD = "Set Double-Byte Data," a CP1610 instruction prefix that tells the next memory access to read two consecutive 8-bit words instead of one 16-bit word. Used everywhere in this game when accessing 8-bit RAM addresses (which is nearly everywhere). It's the inverse of the SWAP-write idiom from Chapter 1: SWAP for writing two bytes, SDBD for reading two bytes (or for reading an immediate value packed across two ROM words). Once recognized, it's just punctuation — but unfamiliar to a 6502 reader.

**Why `XORR R3, R0` instead of `OR`?** When merging the shifted card number into the format word, XOR works because the card number is in bits 3–10, and the format word has zeros in those bits — XOR equals OR when one operand has the relevant bits clear. CP1610 has no `OR` opcode at all (only `XOR` and `AND`); this is a forced choice, not a clever one. Worth flagging because a 6502 reader would expect `ORA` here.

**The picture table has zeros mixed in** (`$0000` entries). These are valid offsets into BACKTAB that get a "card 0" GRAM tile — which is just the cleared-screen tile. So those entries are *intentional gaps* in the island shape that the unpack writes through but renders as blank. The author could have left them out of the offset table, but keeping them lets the picture table be edited without re-aligning the offset table. **A small concession to maintainability over compactness** — uncommon in 1981 cartridge code.

## LLM-interpretation log

| Source of understanding | Where it carried |
|---|---|
| **Source labels alone** | The two-table unpack, CLRSCR, GET_TILE_NO, GRAM_OR_GROM purposes, the LFT/RGT split. |
| **Source comments** | The bit-14 island encoding ("Same as island cards" cross-reference in PARK_FISH was the smoking gun), the ASCII-mapped islands, GRAM card init counts, the STAT_UPD_TIME structure. |
| **CP1610 ISA knowledge required** | `SLR R1, 2; SLR R1, 1` = shift right by 3 (the count argument is encoded `0b00, 0b01, 0b10, 0b11` = 1,2,3,4 not the literal value — minor confusion). `SLLC` + `BOV` for high-bit testing. `SDBD` prefix for two-byte memory access. `XORR` instead of `OR` (CP1610 has no OR opcode). |
| **External hardware knowledge required** | STIC display word format (bits 0–2 color, 3–10 card #, 11 GRAM/GROM). BACKTAB location ($0200–$02EF) and 20×12 dimensions. GRAM at $3800–$39FF with 64 cards. None of this is in the source; all from Intellivision Wiki / GI 1610 manual. The source's labels carry the *engine* but you do need ~10 lines of STIC reference to interpret the bit format. |
| **Disagreements with source** | None this chapter. The source comments are accurate where present, and where absent the structure is unambiguous. |

Net for the project hypothesis: **the source quality is letting us read the engine without learning the CP1610 ISA in depth**, but a small investment in STIC display-word format pays off — and the bit-14 ownership trick was worth a separate finding all on its own. The two GRAM-vs-GROM and tile-number readers will be referenced constantly in later chapters; their <20 lines collectively are now in our working vocabulary.

## Tags

[games](../../../tags/games.md) · [strategy](../../../tags/strategy.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [llm-limitations](../../../tags/llm-limitations.md)

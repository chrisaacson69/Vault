---
status: active
created: 2026-05-10
---
# Chapter 1 — Boot, Vectors, and the BRK Dispatcher
> First architectural cut into a 256 KB cartridge: decode the iNES header, find the reset code, identify the interrupt handlers, and discover that the IRQ vector is actually a software-task scheduler dispatching across 23 subsystems.

**Links:** [Nobunaga README](./README.md) · [NES mappers reference](../../../research/nes/mappers-reference.md) · [NES PPU reference](../../../research/nes/ppu-reference.md) · [NES APU reference](../../../research/nes/apu-reference.md)

## iNES header (file offset 0–15)

```
4E 45 53 1A   "NES\x1a"           iNES magic
10            16                  PRG banks × 16 KB = 256 KB
00            0                   no CHR-ROM → CHR-RAM
12            0001_0010           mapper low=1, battery=1, vertical-mirror=0
08            0000_1000           mapper high=0, bits 2-3=10 → NES 2.0
00 00         submapper/upper bits
77            PRG-RAM=8 KB, PRG-NVRAM=8 KB (the battery save)
07            CHR-RAM=8 KB
00 00 00 00 00 (reserved)
```

**Verdict:** mapper 1 (MMC1), 256 KB PRG, 8 KB CHR-RAM, 8 KB battery-backed PRG-RAM at $6000–$7FFF. The combination of 8 KB battery RAM + 256 KB PRG identifies this as a **SOROM** board (Koei used this for their large-state strategy carts).

## Bank layout under MMC1

The MMC1 control register is set to `$0E` during reset (see below). Decoded:

- Bits 0–1 = `10` → **vertical mirroring**
- Bits 2–3 = `11` → **PRG mode 3** (16 KB switchable at $8000–$BFFF; 16 KB fixed at $C000–$FFFF, set to the last bank)
- Bit 4 = `0` → CHR 8 KB mode

So **bank 15 is permanently mapped at $C000–$FFFF** and holds the boot code, interrupt handlers, and presumably the most critical "always live" routines. Banks 0–15 (well, 0–14 in practice; selecting 15 into the switchable region duplicates the fixed bank) rotate through $8000–$BFFF as the game switches subsystems.

The reset vector points to **$C000** — i.e., the very first byte of bank 15. The Koei signature `"NOBU-NES10      "` sits at $FFE0–$FFEF, just above the vector table.

## The 6502 vector table at $FFFA–$FFFF

```
$FFFA  DA C0   → NMI   = $C0DA
$FFFC  00 C0   → RESET = $C000
$FFFE  39 C1   → IRQ   = $C139
```

## Reset handler ($C000–$C0D9)

The reset code follows the canonical NES boot pattern with MMC1-specific register sequencing layered in.

```asm
; --- CPU init ---
$C000: SEI                  ; mask IRQs (which point at the BRK dispatcher — see below)
$C001: CLD                  ; clear decimal (no-op on NES 6502 but standard)
$C002: LDX #$FD
$C004: TXS                  ; SP = $FD (note: not the usual $FF)
                            ; — by booting with SP one slot lower the boot code can drop
                            ;   a sentinel into $01FE without disturbing later use of the stack

; --- MMC1 control register: 5 serial writes of bit 0, then a reset preamble ---
$C005: LDA #$FF
$C007: STA $9FFF            ; bit 7 high → MMC1 internal reset
$C00A: LDA #$0E             ; control value = 01110
$C00C: STA $9FFF            ; serial write 1 (LSB)
$C00F: LSR A                ; A = $07
$C010: STA $9FFF            ; write 2
$C013: LSR A                ; A = $03
$C014: STA $9FFF            ; write 3
$C017: LSR A                ; A = $01
$C018: STA $9FFF            ; write 4
$C01B: LSR A                ; A = $00
$C01C: STA $9FFF            ; write 5 — commits CONTROL = $0E

; --- CHR bank 0 register = 0 (5 writes, all zeros) ---
$C01F: LDA #$00
$C021: STA $BFFF            ; ×5

; --- PRG bank register = 0 (5 writes to anywhere in $E000-$FFFF) ---
$C030: STA $FFF0            ; ×5  (selects bank 0 at $8000–$BFFF on entry)
```

The `STA $FFF0` trick is the standard MMC1 idiom: any write to $E000–$FFFF routes to the PRG-bank register. Writing the address `$FFF0` rather than `$E000` is purely cosmetic — but it does mean the 5-write commit sequence is invisible to anyone grepping for `$E000`.

Continuing:

```asm
; --- Zero misc RAM, fill defaults ---
$C03F: STA $0073            ; clear var $73
$C042: LDA #$00 / STA $0080 / STA $00B0    ; clear $80, $B0

; --- Two init subroutines (likely PPU warmup / wait-for-VBlank) ---
$C04A: LDA #$10
$C04C: JSR $C6A6
$C04F: JSR $C537            ; called twice — almost certainly the standard
$C052: JSR $C537            ;   "wait for two VBlanks before touching PPU" pattern
$C055: LDA #$1E
$C057: JSR $C570

; --- Fill RAM regions with $3E (some neutral-default tile or value) ---
$C05A: LDX #$00
$C05C: LDA #$3E
$C05E: STA $0090,X          ; $0090–$00AF (32 bytes of zero-page-ish RAM)
$C061: STA $0700,X          ; $0700–$071F (32 bytes of $0700 page)
$C064: INX / CPX #$20 / BNE $C05E

; --- Fill OAM-shadow buffer at $0600 with $F8 (Y = off-screen) ---
$C069: LDA #$FF / STA $0074
$C06E: LDX #$00
$C070: LDA #$F8
$C072: STA $0600,X          ; Y = $F8 (sprite off-screen)
$C075: STA $0603,X          ;   (also writing every 4th-byte offset — sprite Y again?
$C078: INX × 4              ;    actually since both target the +0 and +3 columns and
$C07C: BNE $C072            ;    INX runs 4× per loop, we hit Y at +0 then again at +3,
                            ;    +4, +7, +8, +11... which is *every* byte alternating.
                            ;    Closer read: $0600,X and $0603,X with X stepped by 4
                            ;    fills offsets [0,3,4,7,8,11,...] — covers all positions
                            ;    that hold sprite Y (bytes 0 of each 4-byte sprite) and
                            ;    sprite X (byte 3). Initializes Y and X to $F8 so unused
                            ;    sprites are off-screen and don't smear.)

; --- Set up ZP indirect-pointer pairs ---
$C07E: LDA #$FF / STA $02   ; ZP $02/$03 = $05FF  (wait — high byte stored first?)
$C082: LDA #$05 / STA $03   ;   actually 6502 stores high in $03 → pointer = $05FF
$C086: LDA #$20 / STA $1C   ; $1C/$1D = $0020
$C08A: LDA #$00 / STA $1D
$C08E: LDA #$30 / STA $1E   ; $1E/$1F = $0030
$C092: LDA #$00 / STA $1F

; --- APU init ---
$C096: LDA #$1F / STA $4015 ; enable all 5 channels (pulse1, pulse2, tri, noise, DMC)
$C09B: LDA #$C0 / STA $4017 ; frame counter: 5-step mode, no IRQ

; --- Clear small tables ---
$C0A0: LDX #$00 / LDA #$00 / STA $0720,X / INX / CPX #$05 / BNE  ; clear $0720–$0724
$C0AC: clear every byte at $0734 + N×9 for N=0..4     ; 5 records, 9-byte stride
                                                       ; — this is the player/daimyo
                                                       ;   record skeleton: 5 slots
                                                       ;   of 9-byte fixed-size records.

; --- Default state vars ---
$C0BC: LDA #$04 / STA $0083 / STA $0085   ; $83 and $85 = 4
$C0C4: LDA #$D2 / STA $0084 / STA $0086   ; $84 and $86 = $D2
$C0CC: LDA #$00 / STA $0089                ; $89 = 0

; --- Two more init calls ---
$C0D1: JSR $C68A
$C0D4: JSR $C757

; --- Hand off to main program in bank 0 ---
$C0D7: JMP $8000
```

Two findings worth flagging:

1. **Five slots of 9-byte records at $0734.** The clear loop initializes exactly 5 records of 9-byte stride. That matches **5 daimyo player slots** (in a Koei strategy game you'd expect this to be one record per active warlord — the game's max active players or AI seats). Five is plausible for a slimmed-down NES port of the home-computer Nobunaga's. Chapter 2 will confirm the record layout.

2. **Paired 16-bit counters at $83/$84 and $85/$86.** Initialized to `($04, $D2)` and `($04, $D2)` — so both start at `$04D2 = 1234`. The NMI handler (next section) increments each pair by 2 every frame. Two synchronized but independently-gateable wall-clocks — probably one for the in-game month/year counter and one for an animation/timeout timer.

## NMI handler ($C0DA–$C138)

Standard VBlank shape; the order of operations matters because NMI fires while rendering is off and the PPU is writable.

```asm
$C0DA: PHA / TXA / PHA / TYA / PHA       ; save A, X, Y
$C0DF: LDA $2002                         ; clear VBlank flag
$C0E2: JSR $C54F                         ; deferred PPU updates (tile/palette uploads)
$C0E5: LDA #$00 / STA $2003              ; OAMADDR = 0
$C0EA: LDA #$06 / STA $4014              ; OAM DMA from page $0600 → PPU OAM
$C0EF: LDA $00B0
$C0F2: BNE skip_periodic                 ; if $B0 set, skip the rest of frame work
$C0F4: LDA #$00 / JSR $C628              ; controller read pass 1 (player 1)
$C0F9: LDA #$01 / JSR $C628              ; controller read pass 2 (player 2)
$C0FE: JSR $C6D4                         ; (audio engine tick?)
$C101: JSR $C7A5                         ; (some other periodic update)
$C104: LDA $0089
$C107: BNE skip_clock                    ; if $89 set, skip the wall clock
$C109: ; 16-bit add $0002 to ($86 high / $85 low)  — but wait, address order:
$C109: CLC
$C10A: LDA $0086 / ADC #$02 / STA $0086  ; low byte += 2
$C112: LDA $0085 / ADC #$00 / STA $0085  ; high byte += carry
$C11A: CLC
$C11B: LDA $0084 / ADC #$02 / STA $0084  ; second counter low += 2
$C123: LDA $0083 / ADC #$00 / STA $0083  ; second counter high += carry
skip_clock:
$C12B: LDA #$00 / STA $0081              ; clear "NMI busy" semaphore
$C12E: JSR $C68A                         ; (same routine as reset — likely PPU finalize)
$C133: PLA/TAY / PLA/TAX / PLA           ; restore Y, X, A
$C138: RTI
```

The `$B0` and `$89` flags act as **frame-work gates**. `$B0` set → skip controller polling, audio, and timer (presumably during pause / cutscene / menu). `$89` set → skip the wall-clock tick (game paused at the strategic level but VBlank still keeps rendering).

The `$81` semaphore is cleared at the end of NMI. Mainline code likely sets `$81 = 1` and spin-waits for it to clear — i.e., `$81` is the classic "wait for next VBlank" handshake.

## IRQ handler ($C139–$C172) — the BRK dispatcher

This is the architectural find of the session.

```asm
$C139: PHA / TXA / PHA / TYA / PHA       ; save A, X, Y
$C13E: TSX                               ; X = SP
$C13F: LDA $0104,X                       ; load saved P from stack frame
$C142: AND #$10                          ; isolate B flag
$C144: BEQ real_irq_C16C                 ; if not BRK, fall through to plain IRQ exit
                                         ; (no MMC1 IRQ; this branch handles spurious only)

; --- BRK path: software dispatch ---
$C146: LDA #$00 / STA $0066 / STA $0067  ; clear scratch
$C14E: LDA #$C1 / PHA                    ; push return-high = $C1
$C151: LDA #$6C / PHA                    ; push return-low  = $6C
                                         ; → return address $C16C-1 wraps to $C16B
                                         ;   wait — actually the dispatch JMP doesn't
                                         ;   return; this push is the "fall-through"
                                         ;   if the dispatched task RTS's.
$C154: LDX $0050                         ; X = task ID
$C157: LDY #$03                          ; Y = stride
$C159: JSR $C6AD                         ; multiply X by 3 with carry into X high

$C15C: CLC
$C15D: TYA / ADC #$73 / STA $0068        ; low  = $73 + (X*3 lo)
$C163: TXA / ADC #$C1 / STA $0069        ; high = $C1 + (X*3 hi) + carry
$C169: JMP ($0068)                       ; INDIRECT — jump to $C173 + task_id*3

real_irq_C16C:
$C16C: NOP                               ; (also the RTS-return landing for dispatched tasks)
$C16D: PLA/TAY / PLA/TAX / PLA / RTI
```

The dispatched task lands inside a 3-byte-per-entry JMP table starting at $C173. **23 entries** before the table runs out (bytes after $C1B5 + 3 are not JMPs):

| ID | Entry | Target | Note |
|----|-------|--------|------|
|  0 | $C173 | $C000  | jumps to RESET — "soft reboot" task? |
|  1 | $C176 | $C264  | |
|  2 | $C179 | $C34B  | |
|  3 | $C17C | $C2CB  | |
|  4 | $C17F | $C34C  | (one byte after #2 — possibly a fallthrough into the same code) |
|  5 | $C182 | $C312  | |
|  6 | $C185 | $C39E  | |
|  7 | $C188 | $C339  | |
|  8 | $C18B | $C2F0  | |
|  9 | $C18E | $C3AD  | |
| 10 | $C191 | $C3CF  | |
| 11 | $C194 | $C427  | |
| 12 | $C197 | $C437  | |
| 13 | $C19A | $C4E0  | |
| 14 | $C19D | $C535  | |
| 15 | $C1A0 | $C536  | (one byte after #14 — fallthrough pair) |
| 16 | $C1A3 | $C22C  | |
| 17 | $C1A6 | $C1C3  | (very close — in-page utility) |
| 18 | $C1A9 | $C36C  | |
| 19 | $C1AC | $C1B8  | (in-page; right after table) |
| 20 | $C1AF | $C428  | |
| 21 | $C1B2 | $C60C  | |
| 22 | $C1B5 | $C5AA  | |

**All 23 targets land in bank 15 ($C000–$FFFF).** That means the dispatch table only routes inside the fixed bank — the BRK-VM is a kernel-level scheduler, not a user-level coroutine system. The actual subsystem code that bank-switches and calls into banks 0–14 lives behind these entries.

The "fallthrough pairs" (#2/#4 and #14/#15, where two entries point one byte apart) are interesting: they're a way to share most of a routine while letting the dispatcher choose the entry offset. Tightly hand-crafted.

### Why use BRK?

BRK is a 1-byte instruction (vs. JSR's 3 bytes). For a game where every subsystem boundary is a BRK, the savings are real — 23 dispatch sites becoming 1-byte yields instead of 3-byte JSRs is a 2-byte-per-call savings, and over thousands of call sites across 256 KB that adds up. The cost is the dispatcher overhead (~40 cycles per BRK), which for a turn-based strategy game is invisible.

The pattern echoes Adventure's clever reuse of hardware features and Mappy's NMI-driven kernel — same family of "use the CPU's accidental capabilities as load-bearing structure."

## Bank 0 main entry ($8000)

```asm
$8000: JMP $A778
```

A single shim. Bank 0 at $8000 immediately jumps into $A778. Inspection of $A778-onward shows **byte patterns inconsistent with raw 6502** — long runs of `E9 / CF / CC / 8D / AC / 89 / A8`-flavored data interleaved with what *look* like opcodes but produce nonsense flow when traced linearly.

**Working hypothesis:** there is a bytecode VM running in bank 0 (or possibly several banks), and $A778 is its main interpreter or program entry. The 23-entry BRK dispatcher and the bytecode VM are likely the same architecture seen from two sides: BRK from native code calls the dispatcher; the dispatcher invokes the VM for menu/script/AI logic.

If confirmed, this game runs **two layers of code**: native 6502 for the hot path (NMI, OAM, controllers, math) and a custom bytecode for the strategy layer (orders, AI, dialog, save state). That's a Koei-typical design and would explain how they fit a home-computer strategy engine into a 256 KB cartridge with a 2 KB RAM budget.

Chapter 4 is reserved for proving or disproving the bytecode-VM hypothesis. Chapter 1's job is just to flag it.

## What we have after session 1

- iNES decode confirmed; MMC1/SOROM identified.
- Reset code traced; MMC1 init sequence understood.
- NMI handler decoded — standard VBlank kernel with 2 paired wall-clocks and 2 gating flags.
- IRQ handler decoded — discovered the **23-entry BRK dispatcher** at $C173.
- Bank 0 entry $8000 shimmed into $A778; **bytecode-VM hypothesis** flagged.

What we **don't** have yet:
- The semantic role of any of the 23 dispatch IDs (just their target addresses).
- The memory map (zero-page conventions, RAM layout, SRAM layout).
- Whether $A778 onward is native code or VM bytecode.

That's Chapters 2–4.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

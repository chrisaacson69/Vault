---
status: active
created: 2026-05-11
---
# Chapter 3 — The NMI Pipeline (PPU, OAM, Controllers, Audio)

> Every 1/60s the NMI handler runs five subsystems in a strict order, bracketed by NMI-disable/enable, with all PPU register access funneled through a shadow-state API. First chapter with runtime correlation: a 1-2 second Mesen trace (912k lines) confirmed the architecture and decoded the music driver completely.

**Links:** [Chapter 1 — Boot & Dispatch](./01-boot-and-dispatch.md) · [Chapter 2 — Zero-Page Map](./02-zero-page-map.md) · [Nobunaga README](./README.md) · [NES PPU reference](../../../research/nes/ppu-reference.md) · [NES APU reference](../../../research/nes/apu-reference.md)

## The frame

The NMI fires when the PPU enters VBlank (scanline 241, ~2273 cycles before rendering resumes). The CPU has ~2273 + ~6820 = ~9000 cycles of safe PPU access before the next frame's rendering begins to read VRAM. Everything that has to touch the PPU — OAM DMA, palette updates, scroll registers — happens inside this window.

Nobunaga's NMI uses exactly **5 of those ~9000 cycles' worth of routines** in a fixed order, plus a pair of bookend operations:

1. **Disable further NMIs** (`$C54F`)
2. **OAM DMA** (sprite shadow $0600 → PPU OAM)
3. **Controller poll** (P1 to $6E, P2 to $6F)
4. **Palette upload** (gated by $0074)
5. **Music driver tick** (two passes: trigger + sequencer)
6. **Wall-clock tick** (gated by $0089)
7. **Re-enable NMI** (`$C68A`)

The two gating flags `$00B0` and `$0089` let the engine selectively skip work — `$B0` skips everything after OAM, `$89` skips just the clock. Useful for menu transitions and pause states.

## Method note: the trace

This is the first chapter with runtime correlation. Setup:

- **Mesen 2** debugger, ROM running normally on a screen with active music.
- **Trace Logger** enabled with the default format string (which already shows effective address + memory value for every indirect/indexed instruction, e.g. `LDA ($06),Y [$D1BD] = $02`).
- ~1-2 seconds captured → 912,423 lines of trace.

The trace is large but greppable. Filtering for `\[\$07[3-5][0-9A-F]\]` pulled every access into the 5-voice audio-record region; that single grep revealed the entire music driver in ~50 lines. The CDL (Code/Data Logger) was also enabled to mark code vs. data bytes, which will be folded into the labels file next session.

## The NMI handler ($C0DA-$C138) — completely named

Chapter 1 traced the structure but mis-identified three of the four JSRs. Here it is with every routine resolved:

```asm
$C0DA: PHA / TXA / PHA / TYA / PHA       ; save A, X, Y
$C0DF: LDA $2002                         ; clear VBlank flag
$C0E2: JSR $C54F                         ; NMI off (bracket)              ← was: "deferred PPU updates"
$C0E5: LDA #$00 / STA $2003              ; OAMADDR = 0
$C0EA: LDA #$06 / STA $4014              ; OAM DMA $0600 → PPU OAM
$C0EF: LDA $00B0
$C0F2: BNE skip_periodic                 ; gate: skip subsystems
$C0F4: LDA #$00 / JSR $C628              ; P1 controller poll → $6E
$C0F9: LDA #$01 / JSR $C628              ; P2 controller poll → $6F
$C0FE: JSR $C6D4                         ; palette upload (if $74 set)     ← was: "audio engine tick?"
$C101: JSR $C7A5                         ; music driver (2 passes)         ← was: "some other periodic"
$C104: LDA $0089
$C107: BNE skip_clock                    ; gate: skip wall clock
$C109-$C12A: two 16-bit counters += 2    ; wall clocks at $83/84 and $85/86
skip_clock:
$C12B: LDA #$00 / STA $0081              ; clear NMI-busy semaphore
$C12E: JSR $C68A                         ; NMI on (bracket)
$C133: PLA/TAY / PLA/TAX / PLA           ; restore Y, X, A
$C138: RTI
```

The chapter 1 errata get a dedicated section at the end.

## The PPU register-shadow API

The PPU control register ($2000 / PPUCTRL) and mask register ($2001 / PPUMASK) are **write-only** on the NES. Any RMW operation — "toggle bit 7 of PPUCTRL," "clear the rendering-enable bits of PPUMASK" — requires the CPU to keep its own shadow copy. Nobunaga puts those shadows in ZP and wraps every register access in a tiny helper API:

| ZP | PPU register | Role |
|---|---|---|
| `$0071` | $2000 PPUCTRL shadow | NMI enable, nametable base, PPUDATA increment, sprite-pattern base |
| `$0072` | $2001 PPUMASK shadow | Greyscale, BG/sprite enable, BG/sprite leftmost-8-pixels, color emphasis |

Seven routines manage them:

| Routine | Function | Code |
|---|---|---|
| `$C6A6` | write A → PPUCTRL + shadow | `sta $2000 ; sta $71 ; rts` |
| `$C570` | write A → PPUMASK + shadow | `sta $2001 ; sta $72 ; rts` |
| `$C54F` | **NMI off** (bit 7 of $71 cleared) | `lda $71 ; and #$7F ; jsr $C6A6 ; rts` |
| `$C68A` | **NMI on**  (bit 7 of $71 set) | `lda $71 ; ora #$80 ; jsr $C6A6 ; rts` |
| `$C567` | **rendering on** (bits 3,4 of $72 set) | `lda $72 ; ora #$18 ; jsr $C570 ; rts` |
| `$C69D` | **rendering off** (bits 3,4 of $72 cleared) | `lda $72 ; and #$E7 ; jsr $C570 ; rts` |
| `$C693` | **safe-PPU gate** (composite) | `jsr $C54F ; jsr $C537 ; jsr $C69D ; rts` |

The composite `$C693` is the canonical "I'm about to do a long PPU update from foreground code" preamble:

1. Disable NMI so it doesn't reentrant-fire mid-update.
2. Wait for VBlank (`$C537`) so the PPU is in a writable state.
3. Disable rendering so reads through PPUDATA don't drift.

That's the standard NES pattern (see [NES PPU reference](../../../research/nes/ppu-reference.md) — VBlank window discipline), here factored into named routines instead of inlined everywhere. **The codebase never reads $2000 or $2001 directly.** Discipline is strict and project-wide.

### `$C537` (wait-for-VBlank) and the chapter-2 $0080 mystery

```asm
b15_c537:   lda $0080
            bne done             ; if $80 != 0, skip the wait entirely
            ; (save regs, jsr $C7A5, restore regs)
            lda PPUSTATUS
            bpl spin             ; spin until bit 7 (VBlank flag) set
done:       rts
```

Two findings:

1. **`$0080` = "skip VBlank wait" flag** (chapter 2 had it as "pure toggle bit, EOR'd at b15_c376" — purpose now named).
2. **`$C7A5` is called from inside `$C537`** as "productive work during the spin." Audio ticks happen both inside the wait loop and in the NMI handler proper — the music driver runs every frame regardless of foreground state, and runs *twice* if the foreground happens to be waiting for VBlank when NMI fires. That's a feature: it keeps audio rock-solid through any heavy update.

## The palette pipeline

Palette uploads are the canonical "deferred PPU update" pattern: foreground code edits a RAM shadow, sets a dirty flag, and the next NMI does the actual transfer.

```asm
b15_c6d4:   lda $0074
            beq done                     ; nothing to do
            jsr $c69d                    ; rendering off
            lda #$3F / sta PPUADDR       ; PPUADDR = $3F00 (palette base)
            lda #$00 / sta PPUADDR
            tax                          ; X = 0
loop:       lda $0700,x                  ; read shadow byte
            sta PPUDATA                  ; → PPU palette RAM
            inx
            cpx #$20
            bne loop                     ; 32 bytes = full BG+sprite palette
            ; reset PPUADDR to $3F00 then $0000 (PPU bus address tidy-up)
            lda #$3F / sta PPUADDR ; lda #$00 / sta PPUADDR / sta PPUADDR / sta PPUADDR
            sta PPUSCROLL / sta PPUSCROLL ; scroll = 0,0
            jsr $c567                    ; rendering on
            lda #$00 / sta $0074         ; clear dirty flag
done:       rts
```

Three named ZP locations:

| ZP | Role |
|---|---|
| `$0074` | **Palette dirty flag.** Non-zero = upload pending. Cleared by `$C6D4` after upload. |
| `$0700-$071F` | **Palette shadow** — 32 bytes mirroring PPU $3F00-$3F1F. Reset-initialized to `$3E` (a real palette entry: medium grey). Foreground writes here; NMI ships to PPU. |

`$0074` resolves chapter 2's open question "name $74's subsystem." The routines near `b15_c36c` that EOR/manage $74 are the **palette setter** — they write new colors to $0700-$071F and then set $74=1 to signal NMI. Identifying that subsystem definitively is a chapter-4 task (it'll be invoked by one of the BRK dispatch entries).

Note the `$3E` reset fill: 32 grey-grey-grey palette entries. The game boots with a neutral palette until the title screen overwrites it.

The parallel reset fill of `$0090-$00AF` (also 32 bytes of `$3E`, also $0090-$00AF) remains unexplained — the trace did not touch `$0090-$00AF`, so it's either a second palette buffer used by another subsystem (overlay? menu palette?), or a different mechanism that happens to share the `$3E` default. Park for chapter 4.

## OAM DMA

```asm
$C0E5: LDA #$00 / STA $2003           ; OAMADDR = 0
$C0EA: LDA #$06 / STA $4014           ; DMA $0600-$06FF → 256 bytes of OAM
```

Standard NES OAM DMA. The CPU is suspended for 513 cycles (or 514 on odd cycle) while DMA copies 256 bytes from $0600-$06FF to PPU OAM.

This finally explains the cryptic chapter-1 reset code:

```asm
; reset $C06E-$C07C:
            lda #$F8
            sta $0600,x   ; sprite Y (off-screen)
            sta $0603,x   ; sprite X (off-screen)
            inx ×4
            ...
```

Each NES sprite is 4 bytes — Y, tile, attribute, X. Filling byte 0 (Y) and byte 3 (X) with `$F8` puts every sprite at coordinate (248, 248) — off-screen-bottom-right, so unused sprites don't draw. The stride-of-4 loop is just an optimization to clear both Y and X in one pass.

## Controller poll ($C628)

A 16-byte routine that handles both controllers via the indexed-addressing trick:

```asm
b15_c628:   tax                        ; X = A = player index (0 or 1)
            lda #$01 / sta $4016       ; strobe high
            lda #$00 / sta $4016       ; strobe low → latch
            ldy #$08                   ; 8 buttons to read
loop:       lda $4016,x                ; $4016 (P1) or $4017 (P2)
            lsr a                      ; bit 0 → carry
            ror $006e,x                ; carry → top bit of $6E (P1) or $6F (P2)
            dey
            bne loop
            rts
```

After 8 shifts the destination byte holds the canonical NES button bitfield (MSB-first):

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
|---|---|---|---|---|---|---|---|---|
| Button | A | B | Select | Start | Up | Down | Left | Right |

Two more ZP locations identified:

| ZP | Role |
|---|---|
| `$006E` | P1 button state (held; raw 8-bit field) |
| `$006F` | P2 button state (held; raw 8-bit field) |

These are **held** state with no edge detection. Just-pressed / just-released detection happens elsewhere — typically a "previous-frame snapshot" XOR'd with the current frame. The trace didn't hit that code path; presumably it lives near whichever BRK dispatch entry handles menu input.

## The music driver — two passes

Chapter 1 called this "audio engine tick?" Chapter 2 mentioned the 5×9-byte records at `$0734` (and mis-guessed "5 daimyo player slots"). Static analysis got us a hypothesis for the record layout. The trace confirmed it and, more usefully, **revealed that the driver runs in two distinct passes per frame.**

### Dispatcher ($C7A5)

The disasm6 tool got confused at $C7A5 — interpreted the leading bytes as a data table. The actual code is three instructions:

```asm
$C7A5: JSR $C7AC      ; pass 1: trigger any voice with byte0 ∈ [1..4]
$C7A8: JSR $C817      ; pass 2: tick countdown / load next note
$C7AB: RTS
```

That single `JSR $C817` is what the disassembler missed.

### Voice records ($0730-$0760)

Five 9-byte voice records at `$0734-$0760`, preceded by a 4-byte song header at `$0730-$0733`:

```
$0730: [active flag] [tempo] [song-base lo] [song-base hi]
$0734-$073C: Voice 0  (9 bytes)
$073D-$0745: Voice 1
$0746-$074E: Voice 2
$074F-$0757: Voice 3
$0758-$0760: Voice 4
```

A snapshot during gameplay (R1=Pulse1, R2=Pulse2, R3=Triangle active):

```
$0730: 81 0A AF 84   ; song-active, tempo $0A, song base $84AF
$0734: 00 0F 00 35 08 0A A6 84 00   ; V0 (idle)
$073D: 05 0F 00 7F 08 0A 57 81 05   ; V1 (Pulse1: just played, cursor $8157, count 5)
$0746: 06 0F 00 D5 08 0A 92 81 3D   ; V2 (Pulse2: just played, cursor $8192, count $3D)
$074F: 07 17 00 1D 09 0A C5 81 1D   ; V3 (Triangle: just played, cursor $81C5, count $1D)
$0758: 00 0D 00 1E 08 0A B6 84 00   ; V4 (idle)
```

### 9-byte record layout (runtime-confirmed)

| Offset | Field | Updated by | Notes |
|---|---|---|---|
| 0 | **Channel trigger** | Pass 2 ($C948) writes 1-4 → Pass 1 ($C7F7) writes 5-8 | 1=Pulse1, 2=Pulse2, 3=Triangle, 4=Noise, 0=idle, 5-8=just-played dormant |
| 1 | **APU $4000+N×4** (vol/duty) | song-start only | not re-written per note — envelope is fixed per voice |
| 2 | **APU $4001+N×4** (sweep) | song-start only | usually $00 |
| 3 | **APU $4002+N×4** (timer-lo) | Pass 2 ($C93B) per note | pitch low byte |
| 4 | **APU $4003+N×4** (timer-hi + length) | Pass 2 ($C935) per note | pitch high bits + length-counter index |
| 5 | (tempo divider?) | rarely | constant `$0A` in snapshot — purpose still unclear |
| 6 | **Song-ptr lo** | Pass 2 ($C8A9) per note | advances 1+ bytes per note |
| 7 | **Song-ptr hi** | Pass 2 ($C8B3) per note | high byte stays stable through a song |
| 8 | **Duration countdown** | Pass 2 (load: $C998, dec: $C8CB) | reaches 0 → next note loads |

### Pass 1: the trigger ($C7AC)

```asm
$C7AC:      lda #$00 / sta $0079             ; voice counter = 0
            lda #$34 / sta $7A               ; ($7A) = $0734 (voice 0 base)
            lda #$07 / sta $7B
loop:       jsr $C7DE                        ; check & play this voice
            jsr $C7C9                        ; counter++; ($7A) += 9
            lda $0079
            cmp #$05
            bne loop                         ; 5 voices
            rts
```

The per-voice check ($C7DE) reads byte 0; if `1 ≤ byte0 ≤ 4`, calls `$C7EF`:

```asm
$C7EF:      tax / dex / txa                  ; A = byte0 - 1
            clc / adc #$05                   ; A = byte0 + 4
            ldy #$00 / sta ($7A),y           ; one-shot: byte0 ← byte0+4
            txa / asl / asl / tax            ; X = (byte0-1) × 4
            ; ($0720 mute-group check — see below)
            ldy #$01
write_loop: lda ($7A),y / sta $4000,x        ; write bytes 1-4 → APU $4000+X..$4003+X
            inx / iny / cpy #$05 / bne write_loop
            rts
```

`X = (byte0-1) × 4` maps to the four APU channel bases:

| byte0 | X | APU registers written |
|---|---|---|
| 1 | 0 | $4000-$4003 (Pulse 1) |
| 2 | 4 | $4004-$4007 (Pulse 2) |
| 3 | 8 | $4008-$400B (Triangle) |
| 4 | 12 | $400C-$400F (Noise) |

After playing, byte0 becomes 5-8 (dormant); the dispatcher's `cmp #$05 / bcs skip` ensures it won't fire again until Pass 2 writes a fresh 1-4.

### Pass 2: the sequencer ($C817)

Same outer-loop shape as Pass 1, but the per-voice body decrements byte 8, and when byte 8 hits zero, loads the next note from the song data stream.

The trace caught a complete "countdown → load" sequence at frame 39653, voice 1:

| Trace | Effect |
|---|---|
| `$C8CB STA ($7A),Y [$0745]` $01→$00 | Byte 8 decrements to zero |
| `$C8A9 STA ($7A),Y [$0743]` ← $7C | **Byte 6** (song-ptr lo) ++ |
| `$C8B3 STA ($7A),Y [$0744]` ← $81 | **Byte 7** (song-ptr hi) |
| `$C935 STA ($7A),Y [$0741]` ← $08 | **Byte 4** = new APU timer-hi |
| `$C93B STA ($7A),Y [$0740]` ← $7F | **Byte 3** = new APU timer-lo |
| `$C948 STA ($7A),Y [$073D]` ← $01 | **Byte 0** = 1 → triggers Pulse1 next frame |
| `$C998 STA ($7A),Y [$0745]` ← $20 | **Byte 8** = $20 (32 frames duration) |

Then frames 39654/39655 show byte 8 of all three active voices decrementing in lockstep ($20 → $1F → ...). Voices tick independently — each has its own countdown.

### The $0720 mute-group flag

Pass 1's APU write has a gating check on `$0720`:

```asm
lda $0720
beq do_write           ; if $0720 = 0, normal write
lda $0079
cmp #$02
beq skip               ; if voice index = 2 (Triangle), skip the write
do_write: ...
```

`$0720` is a **triangle-mute flag**. When set, voice 2 (Triangle)'s APU register write is suppressed — the music driver still advances its song pointer and countdown internally (so the song stays in sync), but the triangle channel goes silent. This is how the engine ducks the triangle to play a sound effect through it without losing the music's continuation.

The trace showed `$0720` toggling 0↔1 during gameplay, while `$0721-$0724` stayed at $01 — confirming `$0720` is the mute toggle and `$0721-$0724` are "always-active" voice flags (probably enable-bits set at song start and cleared at song end).

### What the song data looks like

The song-pointer bytes ($81xx for the active song in snapshot) walk through compressed music data byte-by-byte. From the trace:

| Voice | Byte 6/7 sequence |
|---|---|
| V1 (Pulse1) | $8157 → $8159 → $815B → ... (~2 bytes/note) |
| V2 (Pulse2) | $8192 → ...  |
| V3 (Triangle) | $81C5 → $81C7 → ... |

Three separate cursors for three voice channels — i.e., the music data is **per-voice tracks**, not a single interleaved stream. Each voice's track advances independently as its countdown hits zero. The format of the bytes themselves (note value + duration? or note + length + flag?) is a chapter-4 detail.

## The wall-clock tick

```asm
$C109-$C12A:
        clc
        lda $0086 / adc #$02 / sta $0086     ; counter A low += 2
        lda $0085 / adc #$00 / sta $0085     ; counter A high += carry
        clc
        lda $0084 / adc #$02 / sta $0084     ; counter B low += 2
        lda $0083 / adc #$00 / sta $0083     ; counter B high += carry
```

Two paired 16-bit counters, each += 2 per frame, gated by `$0089`. Reset-initialized to `$04D2` = 1234 decimal (a calibration value, not random — picked deliberately, role TBD). Likely roles: in-game month/year counter, animation/timeout timer.

## Chapter 1 errata

Chapter 1's NMI walkthrough mis-identified three of the four interior JSRs. Corrections:

| Address | Chapter 1 said | Actually |
|---|---|---|
| `JSR $C54F` (at $C0E2) | "deferred PPU updates (tile/palette uploads)" | **Disable NMI re-entry** (clear bit 7 of PPUCTRL shadow) |
| `JSR $C6D4` (at $C0FE) | "audio engine tick?" | **Palette upload** gated by `$0074` |
| `JSR $C7A5` (at $C101) | "some other periodic update" | **Music driver** (two passes: trigger + sequencer) |
| `JSR $C68A` (at $C12E) | "same routine as reset — likely PPU finalize" | **Re-enable NMI** (set bit 7 of PPUCTRL shadow) |

Plus one chapter-2 erratum:

| Region | Chapter 2 said | Actually |
|---|---|---|
| `$0734 + N×9` (5 × 9-byte records) | "5 daimyo player slots" | **5 audio voice records.** Daimyo records live elsewhere. |

The mistake pattern is instructive: in chapter 1 the *structure* (4 JSRs in order, brackets, gates) was right, but the *semantic labels* were wrong without runtime evidence to constrain them. Chapter 2 saw 5 × 9-byte stride and guessed daimyo because Nobunaga is a strategy game with 5-ish warlord slots — anchored on subject-matter expectation, not code semantics. Both are predictable failure modes of static-only analysis; both are exactly what runtime correlation fixes.

## What chapter 3 establishes

- The NMI handler runs **5 named subsystems** in fixed order, bracketed by NMI off/on.
- A **PPU register shadow API** at `$0071/$0072` with 7 helpers — strictly enforced, never bypassed.
- The **palette pipeline**: `$0074` dirty flag, `$0700-$071F` shadow, `$C6D4` uploader.
- The **OAM DMA** uses page $0600, with sprite Y/X both pre-set to $F8 for off-screen idle.
- The **controller poll** at `$C628` stores held state in `$006E` / `$006F`.
- The **music driver** runs as **two passes per frame** (trigger + sequencer) over 5 voice records at `$0734`. Each record is 9 bytes with a known field layout, runtime-confirmed.
- The `$0720` byte is a **triangle-mute flag**; `$0721-$0724` are per-voice always-active flags.
- A 4-byte **song header** at `$0730-$0733` holds song-active marker + tempo + base pointer.

Plus three chapter-1 errata blocks and one chapter-2 erratum.

## Open for chapter 4

- **Music data format at $81xx / $84xx.** Three independent per-voice tracks; byte-per-byte format unknown. Likely a small bytecode (note + duration packed bytes; possibly with rest/tempo/repeat opcodes).
- **`$0090-$00AF` parallel buffer** ($3E-filled at reset alongside $0700-$071F, but never touched during the trace). Likely another deferred-PPU buffer used by a non-frame-resident subsystem.
- **`$1C/$1D` and `$1E/$1F` pointers** (init'd to $0020/$0030 at reset). Not dereferenced during this gameplay trace — probably menu/dispatch infrastructure, fired by a BRK dispatch entry.
- **The just-pressed / just-released button edge detection.** Lives downstream of the BRK dispatcher.
- **`$C757`** (called from reset, but not from NMI). Last unidentified reset-time JSR.
- **The BRK dispatcher's invocation pattern.** The trace ran 1-2 seconds (~912k cycles) and **`$0050` was never written and BRK never executed.** The BRK-VM is therefore **event-driven, not per-frame** — fired by input or AI state changes, not by the NMI cadence. That shapes chapter 4's investigation: the dispatch table is a syscall surface, not a scheduler.

## Method note — toward better tooling

This was the first chapter to use Mesen's trace logger. The 912k-line trace was grep-able and yielded full music-driver semantics in one short pass. But the trace is hard to *read* — every address is a hex number, every label is `$C7AC` rather than `audio_dispatch`. Next session's tooling improvement: build a **labels file** (Mesen `.mlb` format) that decorates the trace with every name discovered across chapters 1-3 (PPU API helpers, palette routines, audio passes, controller poll, ZP semantic labels). The CDL (Code/Data Logger) data from this run is already saved alongside the trace — folding that plus the labels file into the disasm6 output will make chapter 4's deep dives substantially faster.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

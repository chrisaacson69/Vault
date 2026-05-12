---
status: active
created: 2026-05-12
---
# Chapter 4 — The Syscall API

> The 23-entry dispatch table is a syscall surface, not a subsystem state machine. Every dispatch goes through a single callable wrapper at $F226 that copies a parameter block from a caller-supplied struct into ZP and faking a BRK via PHP + JMP($FFFE). Chapter 1's "BRK-VM" framing was wrong scope — these are OS-style primitives ($read_controller$, $palette_write$, $set_sprite$), not game subsystems.

**Links:** [Chapter 1 — Boot & Dispatch](./01-boot-and-dispatch.md) · [Chapter 2 — Zero-Page Map](./02-zero-page-map.md) · [Chapter 3 — NMI Pipeline](./03-nmi-pipeline.md) · [Nobunaga README](./README.md) · [NES PPU reference](../../../research/nes/ppu-reference.md) · [NES APU reference](../../../research/nes/apu-reference.md)

## The reframe

Chapter 1 found a 23-entry indirect-JMP table at `syscall_dispatch_table` ($C173) and named it the "BRK dispatcher," with each entry conceived as a major game subsystem. After cataloging all 23 handlers in this session, that framing collapses cleanly into a sharper one:

**The 23 entries are an OS-style syscall API.** Each handler is a 5-50 instruction routine implementing one primitive operation — read a controller, write a palette byte, blit a tile block, switch banks. Game code in banks 0-14 invokes these primitives through a uniform calling convention whenever it needs kernel services. The bank-15 fixed kernel **is** the OS; the rest of the ROM is application code that runs on it.

The syscall analogy is exact:
- A **dispatcher** turns a numbered request into a handler call
- A **parameter block** carries arguments from caller to handler
- A **return-value register** carries results back
- Each handler is **stateless** between calls; it operates on the parameters and any shared kernel state (palette buffers, audio state, PPU shadows)

## Method note

Chapter 3 introduced trace logging with `MarkEvent` breakpoints. Chapter 4's investigation used three new tooling pieces that build on that foundation:

1. **Mesen 2 Trace Logger condition filter** (`pc == $F22A || pc == $F228 || pc == $F238 || pc == $F239`). Reduces a 14-million-line raw trace to ~22k lines (4 per dispatch event), preserving exactly the moment each syscall fires. Labels render inline so the trace reads as `STA $004E,Y [brk_dispatch_id]` rather than raw hex.
2. **Dispatch event log** extracted from the trace: 6880 events with `(frame, task_id, source_struct_addr)` per row. Reveals the task-ID distribution (one syscall, $06, dominates at 92%+) and tags each invocation by structure base, exposing the family of pre-baked request templates that game code uses.
3. **Parallel handler walks** in the labeled disasm. With chapter 3's labels already in place (`nmi_off`, `palette_dirty`, `v0_trigger`, etc.), reading a handler is a matter of pattern-matching the param-block reads ($0050-$0065) against the body of the routine. Each handler decodes in 1-3 minutes.

This was the first chapter where the trace, the labels, and the asm reading all reinforced each other. Each tool's output became another tool's input — the compounding flywheel chapter 3 set up.

## The dispatch mechanism — code walkthrough

The real syscall site is `syscall_dispatch` at $F226, callable as `jsr syscall_dispatch` with a request-struct pointer in `$02/$03` (ptr1):

```asm
syscall_dispatch:                  ; $F226
            ldy #$17                ; Y = 23 (loop counter)
.copy:      lda (ptr1_lo),y         ; load source[Y] from struct at ($02/$03)
            sta $004E,y             ; store to $004E+Y
            dey
            cpy #$01
            bne .copy               ; loop until Y == 1 (so $004E and $004F are NOT touched)

            lda #$F2                ; push high byte of return addr ($F23C)
            pha
            lda #$3C                ; push low byte
            pha
            php                     ; push P (the PHP pushes with B=1, matching BRK behavior)
            jmp (irq_vector_FFFE)   ; → irq_handler ($C139); B flag set so dispatch path runs

syscall_dispatch_return:           ; $F23C — dispatched routine RTS's here
            nop
            lda brk_scratch_lo      ; copy return values from $66/$67
            sta $08                 ;   to the caller-visible $08/$09
            lda brk_scratch_hi
            sta $09
            rts
```

Six findings packed into this routine:

1. **The 22-byte parameter copy.** $0050-$0065 are filled from `(ptr1),$02..$17`. The struct's bytes 0 and 1 are not used by the dispatcher (they may carry caller-local metadata).
2. **Byte 2 of the struct ($004E+2 = $0050) becomes the task ID** that the IRQ-handler dispatcher at $C139 reads. So a "request" is identified by its byte at offset 2.
3. **The other 21 bytes ($0051-$0065) are syscall arguments.** Each handler reads whichever offsets it needs (e.g., $C39E reads $0052 for the controller index; $C2CB reads $0052/$0054/$0056/$0058/$005A for sprite Y/X/attr/tile/idx).
4. **PHP + JMP($FFFE) fakes a BRK.** PHP pushes P with the B flag set (per 6502 hardware behavior, identical to what BRK pushes). The indirect JMP through $FFFE lands in `irq_handler` ($C139). The handler's B-flag check passes, dispatch proceeds. The mechanism produces a stack frame identical to what `BRK` would have produced — same downstream code path — but is callable from a wrapper function with full control over the setup.
5. **A custom return address is pushed.** `lda #$F2 / pha / lda #$3C / pha` puts $F23C-style return on the stack so the dispatched handler's `RTS` lands in syscall_dispatch_return, not back at the BRK site. This decouples handler return from caller's stack frame.
6. **Return values flow through `$66/$67 → $08/$09`.** The dispatcher pre-clears $66/$67 at $C148, the handler stores its return into $66/$67, and `syscall_dispatch_return` copies to $08/$09 for the actual caller. Two-stage return: kernel-private (66/67) and caller-visible (08/09).

### Why this and not BRK?

Chapter 1 speculated that BRK was used as a 1-byte yield to save bytes vs. JSR. Now that we see the actual mechanism — 10 bytes (PHA+PHA+PHP+JMP indirect) per dispatch site — that hypothesis is wrong. The mechanism is *bigger* than BRK by 8 bytes.

The motivation is functional, not bytewise:

- A real `BRK $XX` would push the BRK-site PC as the return address. The dispatched routine would have to manage that. The Nobunaga design pushes a **single, central return PC** ($F23C-1) so the handler's RTS goes to one predictable cleanup site.
- The parameter copy loop runs **outside** the handler, in a callable subroutine. Each syscall site is one `jsr syscall_dispatch`, not 23 bytes of inline setup. Game code stays compact.
- The faked-BRK reuses the *existing* IRQ handler at $C139, which the chip would also enter on a real BRK or hardware IRQ. One handler, three entry mechanisms (real IRQ — but MMC1 has none; real BRK — unused; faked BRK via syscall_dispatch — the path actually taken). Maintenance economy.

## The 23-syscall catalog

Of the 23 entries, 16 were invoked during the captured trace (startup + reset → first-turn UI). The other 7 are likely combat/save/AI ticks that only fire in later game phases. Each table entry is reached as `JMP $XXXX` at `syscall_dispatch_table + id*3`:

| ID | Target | Name | Function (key params marked struct[N]) |
|---:|---|---|---|
| 0 | $C000 | (reset) | Jumps to `reset_handler`. Probably "soft reboot" / cold-restart syscall; not invoked in our trace |
| 1 | $C264 | `syscall_ppu_upload_block` | Bank-switched bulk copy from PRG → PPU. struct[2]=bank, [4:5]=src ptr, [6:7]=PPU dest, [8]=chunk count (×16 bytes) |
| 2 | $C34B | (unmapped — RTS only) | Single `RTS` at $C34B; placeholder/no-op slot |
| 3 | $C2CB | `syscall_set_sprite` | Write one OAM sprite. struct[2]=idx, [4]=X, [6]=Y, [8]=attr, [a]=tile → OAM shadow at $0600+idx*4 |
| 4 | $C34C | `syscall_palette_write` | Write 1 palette byte. struct[2]=palette idx (0-31), struct[4]=color. Writes to palette_shadow + sets palette_dirty (or to palette_alt if skip_vblank_wait is set) |
| 5 | $C312 | `syscall_fill_nametable` | Fill full 30×32 nametable with one tile byte. struct[2]=name idx, struct[4]=fill byte |
| 6 | $C39E | `syscall_read_controller` | Poll buttons. struct[2]=player idx (0/1). Returns held buttons; side effect: if any button pressed, sets skip_wallclock (game-time pauses while held) |
| 7 | $C339 | `syscall_call_bank` | Save current bank, switch to struct[2], `JSR $8000`, restore. The inter-bank call primitive |
| 8 | $C2F0 | `syscall_fill_attr_quadrant` | Fill 64-byte attribute table quadrant with one constant. PPUADDR = $23C0 + struct[2]*4, fill = struct[4] |
| 9 | $C3AD | `syscall_audio_load_voice` | Set voice config. struct[2]=voice idx, [4]=tempo_div, [6]=song_ptr_lo, [8]=song_ptr_hi → 3 bytes at v0_config + voice*3 ($0725-$0733) |
| 10 | $C3CF | `syscall_audio_control` | Audio control. struct[2]=voice idx, struct[4]=mode: 0 = silence all (clear audio state + APU); 1 = mute triangle for voice; 2 = query mute state |
| 11 | $C427 | (RTS) | Single `RTS` at $C427; another placeholder slot |
| 12 | $C437 | `syscall_ppu_blit_nobank` | Sibling of #20 (`ppu_blit_from_bank`) but enters with mode = 0 (no bank switch). Falls into the same code at $C439 |
| 13 | $C4E0 | (TBD) | 8 invocations in the trace, not yet fully walked |
| 14 | $C535 | (TBD) | Not invoked in trace |
| 15 | $C536 | (TBD) | Not invoked. Note the table fallthrough: 14 → $C535 and 15 → $C536 differ by 1 byte — they share code, with #15 entering one instruction later |
| 16 | $C22C | `syscall_memcpy_banked` | Bank-switched general memcpy with 16-bit length. struct[2]=src bank, [4:5]=src ptr, [6:7]=dest ptr, [8:9]=length |
| 17 | $C1C3 | `syscall_rng_next` | 48-bit shift-and-add transform over wall-clock state ($0083-$0088). Returns 16-bit pseudo-random in $66/$67. The game's RNG |
| 18 | $C36C | `syscall_palette_swap` | Atomically swap palette_shadow ($0700-$071F) with palette_alt ($0090-$00AF). Used for fade/transition effects |
| 19 | $C1B8 | `syscall_wait_for_nmi` | Set nmi_busy=1, spin until NMI clears it. The canonical "wait for next VBlank" primitive |
| 20 | $C428 | `syscall_ppu_blit_from_bank` | Bank-switched PPU blit. Switches to bank from struct[$E], copies block to nametable region |
| 21 | $C60C | (TBD) | Not invoked in trace |
| 22 | $C5AA | (TBD) | Not invoked in trace |

The TBD entries don't surface during startup+early UI. The trace took the game up to the first-turn cursor; chapters covering combat (5/6/7 in the planned map) will surface the remaining handlers.

### Call frequency tells the role

The dispatch event log shows striking concentration:

| Task | Events | % | Why |
|---|---:|---:|---|
| **$06** read_controller | 6342 | **92.2%** | Polled in every menu-wait loop, every prompt, every UI tick. The game spends most of its CPU waiting on input |
| $11 rng_next | 130 | 1.9% | Used wherever randomness is needed; consistent low-grade demand |
| $14 ppu_blit_from_bank | 122 | 1.8% | Screen content rendering — menus, prompts, map updates |
| $03 set_sprite | 81 | 1.2% | OAM updates for cursors, animation, UI sprites |
| $04 palette_write | 78 | 1.1% | Color changes — title-screen palette load, menu highlights |
| Others | 127 | 1.8% | Boot one-shots + low-frequency game state |

The hottest 4 syscalls together account for **97.0%** of all dispatch traffic. Game logic spends almost all its kernel-call time on input polling, with PPU updates and RNG distantly trailing.

## Helper functions worth naming

While walking the handlers, several internal helpers were identified:

- **`set_prg_bank` ($C577)** — the MMC1 bank-switch helper. Saves NMI state, writes the 5-bit serial sequence to $FFF0 (the MMC1 PRG bank register), updates `kernel_var_73` ($0073) which tracks the current bank, restores NMI state. Called by every bank-switching syscall. The "BRK + 5×STA $FFF0 + restore" sequence is canonical MMC1 bank-switching with NMI-safe wrappers around it.

- **`mul_xy_by_3` ($C6AD)** — same routine the IRQ handler uses to scale a task ID by 3 (the table stride). Reused inside handlers for similar small-N multiplications.

## Errata to chapters 1-3

This session produced four chapter-1-to-3 corrections:

| Chapter | Said | Actually |
|---|---|---|
| **1** | "BRK is the syscall instruction (1-byte yield, saves bytes vs. JSR)" | The syscall is `PHP + JMP ($FFFE)` at $F239, called via a wrapper at `syscall_dispatch` ($F226). Total cost is 10+ bytes per dispatch site (4 stack pushes + the indirect JMP + 22-byte parameter copy in the wrapper) — bigger than BRK, not smaller. The motivation is functional (central return address, parameter passing, single dispatcher entry) not bytewise. |
| **1** | "23 dispatch entries = 23 game subsystems" | 23 OS-style syscall primitives. The dispatch table is a syscall surface, not a state machine. Game subsystems live in banks 0-14; bank 15 is the kernel that provides syscall services |
| **2** | "$0090-$00AF: parallel buffer to $0700-$071F, both filled with $3E at reset — purpose TBD" | $0090-$00AF is `palette_alt`, the alt palette buffer. Used by `syscall_palette_swap` (task $12) for fade/transition effects. The two buffers are paired by design: foreground builds a new palette in palette_alt, then atomically swaps it into palette_shadow for NMI to upload |
| **3** | "Audio: $0730-$0733 is the 4-byte song header (active flag + tempo + base pointer)" | The bytes at $0730-$0733 are actually the tail of the **5×3-byte voice config array at $0725-$0733**. Each 3-byte record holds `(tempo_div, song_ptr_lo, song_ptr_hi)` per voice. `syscall_audio_load_voice` (task $09) writes these. No global song header — each voice has its own continuation state |

## Three structural insights this chapter establishes

1. **The syscall API is the boundary between bank 15 and the rest of the ROM.** Game code in banks 0-14 cannot directly touch palette state, OAM, controllers, audio, or PPU — those are all kernel-managed. The only way through is `jsr syscall_dispatch`. This is OS-style separation between user code and kernel services, in 1989, on a cartridge.

2. **The hottest syscall is input polling, by an enormous margin.** ~200 input polls per second, 92% of all kernel-call traffic. This is the signature of a turn-based strategy game: the CPU is mostly waiting for the player to do something. Combat phases (when surfaced in later chapters) will show different patterns.

3. **The dispatch event log + the call-site struct addresses are an inventory of game-code intentions.** Each invocation of `syscall_dispatch` with struct base $05XX corresponds to a specific request template in main RAM. Cataloging those templates would surface the **set of syscall sequences** the game uses — which syscall combinations form a "draw a menu" or "play a sound effect" idiom. That's a chapter 5+ direction.

## What's open for chapter 5+

- **The remaining TBD syscalls** (IDs 0, 2, 13, 14, 15, 21, 22) need traces from combat / save / AI phases to surface. The capture methodology is now reproducible: filter to `(pc == $F228 && y == 2) || pc == $F239` and play through the desired phase.
- **The static request templates** at $05B2, $05B4, $05BF, $05C7, $05CB etc. carry the syscall arguments that game code uses repeatedly. Walking the 22-byte content of each template tells us what each "macro" does (e.g., "this is the template for rendering the main map prompt").
- **The chapter-4 ZP additions** ($66/$67/$08/$09 as syscall return values) are now stable. Future chapters can rely on the calling convention without re-deriving it.
- **The Lua dispatch logger** stays in the project at `tools/dispatch-logger.lua` for the day we want caller PCs (which game routine invoked which syscall). The condition-filtered trace handles the simpler cases; Lua is reserved for when stack-walking is required.
- **The disasm6-vs-real-code disagreements** (e.g., $C7A5 misread as a data table in chapter 3) continue to be a meaningful signal axis. Whenever disasm6 emits `hex XX XX XX` where the trace shows actual execution, the bytes are code mislabeled as data — and worth a closer look.

## Method note — what the toolchain became

Going into chapter 4, we had: labels file (TOML → Mesen JSON), workspace presets (TOML → JSON), and an asm-relabeler (TOML → labeled disasm). This chapter pushed each one further:

- **`asm-relabel.py` now injects label headers** at known PRG addresses where disasm6 didn't anchor a `b15_cXXXX:` label. The labeled disasm now reads as documented code: `syscall_read_controller:` appears as its own line above the handler body. 17 new label headers injected in bank 15 alone.
- **The Mesen condition-filter syntax** is now characterized: `pc == $XXXX || pc == $YYYY || ...` works; `state.pc` does not. The filtered trace format (`STA $004E,Y [brk_dispatch_id]`) renders labels inline, making the trace human-readable without post-processing.
- **The dispatch event log** at `dispatch-events-startup-to-turn1.txt` (6880 rows, frame + task_id) is now part of the project's permanent artifacts. Future captures can produce the same format and we can cross-compare game phases.

The pattern that's emerging: **each chapter both consumes labels from the prior chapter and contributes new labels to the next one**. Chapter 3 named the NMI subsystems; that let chapter 4 read syscall handlers as `jsr nmi_off` instead of `jsr $C54F`. Chapter 4 named the syscall API; chapter 5 can read calling code as `jsr syscall_set_sprite` instead of `jsr $F226` with a struct.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

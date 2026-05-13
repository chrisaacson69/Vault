---
status: active
created: 2026-05-13
---
# Chapter 5 — The Bytecode VM

> The orchestration question — "how does the boot sequence know to do `call_bank → audio_load_voice ×3 → audio_control ×3 → palette_swap`?" — has an answer at a higher level of abstraction than chapters 1-4 reached. The 6502 kernel in bank 15 is an operating system. The game itself is a **bytecode program in banks 0-14**, interpreted by a virtual machine at $E823. Game logic, boot sequence, AI, menus, combat — all of it is VM bytecode. The kernel just provides syscall services.

**Links:** [Chapter 1 — Boot & Dispatch](./01-boot-and-dispatch.md) · [Chapter 2 — Zero-Page Map](./02-zero-page-map.md) · [Chapter 3 — NMI Pipeline](./03-nmi-pipeline.md) · [Chapter 4 — Syscall API](./04-syscall-api.md) · [Nobunaga README](./README.md)

## The orchestration question

Chapter 4 ended with a clear catalog of 23 kernel syscalls and a complete picture of *what* the kernel does. What it could not answer: **who decides which syscalls to call, and in what order?** The boot trace fires task $07, then $09 three times, then $0A three times, then $12 — clearly conducted, never random. The conductor must live somewhere outside bank 15 (since the kernel is just the orchestra), but chapter 1's quick look at bank 0 showed bytes "inconsistent with raw 6502" starting at $A778.

Following that thread led to the rest of this chapter.

## The boot path

```
RESET ($C000) → ... → JMP $8000 (bank 0 entry)
                    → JMP $A778 (skip past data)
                    → JSR $E823 (enter VM with inline bytecode at $A77B onwards)
```

Bank 0 at $8000 contains exactly three bytes of code (`4C 78 A7` = `JMP $A778`) and then ~16 KB of data. At $A778 itself, three more bytes of code (`20 23 E8` = `JSR $E823`), then *also* data — but that data is the **bytecode program** that the VM at $E823 is about to interpret. Everything after the JSR is operands and opcodes for the VM, not native 6502 instructions.

## The VM entry point ($E823)

Called as `JSR vm_entry`, with inline bytecode following:

```asm
vm_entry:                           ; $E823
    ; --- Pull 4 bytes off the stack ---
    pla / sta $08                   ; $08 = low byte of caller's return-1 (= byte before next operand)
    pla / sta $09                   ; $09 = high byte
    pla / sta ptr0_lo               ; ptr0 = previous-context pointer (from the stack)
    pla / sta ptr0_hi

    ; --- Allocate a new VM frame ---
    ldy #$07
    lda ptr1_lo / sbc #$09 / sta $0c   ; $0c/$0d = ptr1 - 9
    lda ptr1_hi / sbc #$00 / sta $0d
.save: lda (ptr0_lo),y / sta ($0c),y / dey / bpl .save
                                       ; copy 8 bytes from previous context to the new frame slot

    ldy #$01
    lda $0c / clc / adc ($08),y / sta ptr1_lo    ; ptr1 = $0c + 16-bit inline operand after JSR
    iny / lda $0d / adc ($08),y / sta ptr1_hi

    lda $08 / clc / adc #$03 / sta ptr3_lo       ; ptr3 = $08 + 3 = bytecode IP (skips JSR target + 16-bit param)
    lda $09 / adc #$00 / sta ptr3_hi

    jmp vm_dispatch                              ; → $E867
```

Two things to notice:

1. **The 4-PLA pattern is unusual.** JSR only pushed 2 bytes (the return address). The other 2 PLAs pull bytes from the stack that were placed there by either the previous VM frame or the reset code (which deliberately set SP=$FD instead of $FF — chapter 1's hint about the sentinel slot is now load-bearing).

2. **ptr1 is the VM frame pointer.** Each VM call advances it backward by 9 bytes (saving 8 bytes of previous context + reserving 1 for the new frame). The advance/restore happens on every VM call/return — it's literally the VM's stack.

## The dispatch loop ($E867)

```asm
vm_dispatch:                                     ; $E867
    ldy #$00
    lda (ptr3_lo),y                              ; fetch next bytecode byte
    inc ptr3_lo / bne + / inc ptr3_hi            ; advance IP
+:  tax
    lda vm_opcode_lo_table,x                     ; $F026
    sta ptr0_lo
    lda vm_opcode_hi_table,x                     ; $F126 (indexed as offset 256 into the same table)
    sta ptr0_hi
    jmp (ptr0_lo)                                ; → opcode handler
```

Two 256-byte tables hold the handler addresses. The 16-bit handler for opcode `op` lives at `($F126[op] << 8) | $F026[op]`. Handlers do their work and either fall back to `jmp vm_dispatch` (for the next opcode) or to a tail routine like `$EB9E` (which does extra stack adjustment before dispatching).

## The 256-entry opcode table

The full table fits in 512 bytes immediately before `syscall_dispatch` at $F226. Reading the structure:

| Opcode range | Handler page | Pattern |
|---|---|---|
| $00–$0B | $E87F–$E8AB (4 bytes each) | 12 "load offset from ptr2 + immediate $E8/$EA/.../$FE" entries; one entry per immediate value |
| $0C–$26 | $E8xx | Various opcodes; mostly fetches/stores |
| $27–$66 | $E9xx | Branches, arithmetic |
| **$60–$6F** | **$EA18 (all 16 share)** | **Opcode-as-operand encoding — 16 opcodes route to the same handler with bits 0-3 of the opcode as a 4-bit immediate** |
| **$80–$8F** | **$E918 (all 16 share)** | Same pattern, different operation |
| **$A6–$B5** | $EAxx span | Many opcodes with overlapping handlers |
| **$E9** | **$EB38 — host_call_with_adjust** | Calls native code at the next 16-bit operand, with VM stack adjustment |
| **$AC** | **$EB4E — host_call_simple** | Calls native code at the next 16-bit operand, no adjustment |
| $F8–$FF | $EFxx | "Return" / end-of-frame opcodes |

The **opcode-as-operand clusters** ($60-$6F, $80-$8F, etc.) are the classic VM-design trick of encoding small constants directly in the opcode value. A `$63` instruction is "operation X with parameter 3"; only 4 bits of operand encoded, but the same byte triples as opcode dispatch + parameter.

## The host-call mechanism (opcode $E9)

This is the bridge between bytecode and kernel.

```asm
opcode_E9_host_call:                             ; $EB38
    jsr read_word_into_ptr0                      ; $EFD5 — read 2-byte operand from bytecode → ptr0
    jsr vm_call_native                           ; $EB57 — JSR through ptr0 (with VM stack save)
    ldy #$00
    jmp tail_with_ptr1_adjust                    ; $EB9E — advance ptr1, dispatch next opcode

read_word_into_ptr0:                             ; $EFD5
    lda (ptr3_lo),y / sta ptr0_lo                ; (Y=0)
    iny / lda (ptr3_lo),y / sta ptr0_hi          ; (Y=1)
    dey / clc
    lda ptr3_lo / adc #$02 / sta ptr3_lo         ; ptr3 += 2 (consume the operand)
    bcc + / inc ptr3_hi
+:  rts

vm_call_native:                                  ; $EB57 — the magic
    ; Save VM IP into VM stack (at ptr1)
    sec / lda ptr1_lo / sbc #$02 / sta ptr1_lo
    bcs + / dec ptr1_hi
+:  lda ptr3_lo / sta (ptr1_lo),y                ; save IP low
    iny / lda ptr3_hi / sta (ptr1_lo),y          ; save IP high

    jsr indirect_jmp_trampoline                  ; $EB6B — JSR through a data block
    ; → trampoline contains `6C 00 00` = JMP ($0000)
    ; → JMP indirect through $00/$01 = ptr0
    ; → effectively a JSR to wherever ptr0 points
    ; native code runs and returns via RTS

    clc / lda ptr1_lo / adc #$02 / sta ptr1_lo   ; pop VM IP off VM stack
    bcc + / inc ptr1_hi
+:  rts

indirect_jmp_trampoline:                         ; $EB7A
    .byte $6C, $00, $00                          ; `JMP ($0000)` — the indirect target is $00/$01 (ptr0)
```

The `JSR through a data block holding JMP ($0000)` is the **6502-doesn't-have-indirect-JSR workaround**. The 6502 only has `JSR <absolute>` and `JMP (<indirect>)`, no `JSR (<indirect>)`. To call a function whose address is in a ZP pointer, you JSR to a place that does an indirect JMP. When the JMP'd-to function RTS's, it returns to the instruction after the original JSR. Three bytes of data become a one-instruction-equivalent indirect call.

## What the bytecode pattern `E9 26 F2 ...` does, decoded end-to-end

```
Bytecode: ... [prepared frame] ...  E9 26 F2  ...
```

1. **VM frame setup (earlier bytecode):** opcodes load the syscall task ID into `(ptr1),Y=2` (= byte 2 of the current frame) and any required parameters into bytes 4, 6, 8, etc. of the same frame.
2. **`E9` opcode:** dispatches to `$EB38`.
3. **`$EB38`:** reads next 2 bytes (`26 F2`) as a 16-bit address → ptr0 = $F226 (`syscall_dispatch`).
4. **`vm_call_native`:** pushes the VM IP onto the VM stack, then "JSR through ptr0" — control transfers to `syscall_dispatch` at $F226.
5. **`syscall_dispatch`:** copies bytes from `(ptr1),Y=$17..$02` into $0050+. This is the chapter-4 22-byte param copy — but the source struct **is** the VM frame at ptr1. Byte 2 of the frame (the task ID we set in step 1) lands at $0050.
6. **`syscall_dispatch`** does PHP + JMP ($FFFE) → `irq_handler` → the syscall executes → RTS through the `$F23C` fixup.
7. Control returns through `vm_call_native`'s post-RTS cleanup, then to `$EB9E` which advances ptr1 and re-enters `vm_dispatch`.

So **the syscall struct never has to be built separately** — the VM frame *is* the syscall struct. The bytecode prepares it in place, fires the host-call opcode, gets results back through `$66/$67 → $08/$09` (chapter 4's calling convention), and continues.

## What `ptr1` is, fully

Across chapters 2-5, the function of `ptr1 = $02/$03` has been gradually clarified:

| Chapter | Reading |
|---|---|
| 2 | "Pointer pair LO/HI; reset-init to $FF (forms $05FF with $03)" — generic pointer |
| 3 | (not touched) |
| 4 | "Syscall request-struct pointer — the caller passes a struct address in ptr1 before `jsr syscall_dispatch`" |
| **5** | **The VM frame pointer.** Each VM call frame is allocated at (current ptr1 - 9) bytes. The current frame at ptr1 holds: byte 2 = task ID for the next host call; bytes 4-$15 = parameters; bytes 0-1, $16-$17 = frame metadata |

The chapter-4 reading wasn't wrong; it was a partial view. From the VM's perspective, the syscall struct *and* the frame are the same memory — the VM never separates them, so the kernel can read its arguments straight out of the live VM frame.

## The architectural reframe

For all of chapters 1-4, the implicit mental model was:

> Native 6502 game code in banks 0-14 ↔ kernel services in bank 15

That model is wrong in a precise way. The correct model is:

> Bytecode program in banks 0-14 (compiled game logic) ↔ VM interpreter + kernel in bank 15

Banks 0-14 contain almost no native 6502 code. They contain VM bytecode, VM data, graphics data, and a small handful of native helpers (sometimes 10-50 bytes long, called from VM bytecode for tight inner loops). The "game" — the Sengoku-period simulation with daimyo AI, combat resolution, province management, save/load — is **all bytecode**.

This is structurally identical to:
- **Infocom's Z-machine** (1979-) — Z-code bytecode for interactive fiction
- **SCUMM** (LucasArts adventure engine, 1987-) — bytecode for adventures
- **Bushnell's "Crash" abstraction layer** (mid-1970s Atari) — micro-coded high-level operations

For a 1989 NES cartridge, this is sophisticated engineering. It enables Koei to develop strategy-game logic in a high-level form (presumably authored as VM bytecode source by tools we don't have) and reuse the kernel across multiple titles. The chapter-4 finding of "4 RTS placeholders in the syscall table" now lines up perfectly with this: Koei has a kernel template; different games populate the placeholder slots with their own primitives; the bytecode programs differ entirely.

## The implications for game logic flow

The orchestration question — "how does boot know to do `call_bank → audio_load_voice ×3 → audio_control ×3 → palette_swap`?" — answers itself:

> Because the bytecode at $A77B (start of the VM program) **is** that sequence, expressed in VM opcodes. The boot script literally enumerates these operations.

The main game loop is also bytecode. The "92% of dispatch traffic is read_controller" finding from chapter 4 is not about the **engine's** CPU budget — it's about **the bytecode program's** structure: the menu-wait code is a tight bytecode loop that polls `syscall_read_controller` and branches on the result. When the player presses an input, the bytecode dispatches to a different sequence (a screen-transition routine, a menu item handler, an AI tick). No native 6502 logic runs the menu; bytecode does.

This also explains why we couldn't find `jsr $F226` anywhere in the disasm even though syscall_dispatch is called constantly: **the calls are encoded as bytecode opcode $E9 followed by `26 F2`, not as native JSR instructions**. The 6502 disassembler can't see them because they aren't 6502 instructions.

## What's open for chapter 6

The model is now established. To actually walk a frame of game execution, we need a **VM bytecode disassembler**:

1. Read the 256-entry opcode table from the labeled disasm.
2. For each opcode, determine its handler and operand format (immediate? 16-bit literal? bytecode-relative? branch target?).
3. Walk the bytecode in bank 0 starting from $A77B, emit a VM-assembly equivalent.
4. Cross-reference against the chapter-4 dispatch event log — confirm that the bytecode at boot really does fire task $07 / $09 ×3 / $0A ×3 / $12 in that order.
5. Continue past boot to find the main loop, the screen-mode dispatcher, and the input-handling state machine.

That's the chapter 6 work product. We can also expect this disassembler tool to compound across the game-annotation series — any future Koei MMC1 title we look at will use the same VM model (per the "generic kernel" hypothesis from chapter 4), so the tool transfers directly.

The chapter 4 toolchain compounded labels across chapters; chapter 6's disassembler will compound across **games**. That's the next inflection in the project's tool flywheel.

## Method note — what made this find tractable

Chapter 5 was unblocked by three things from earlier chapters:

1. **Chapter 1's "$A778 looks like bytecode" hypothesis** was right; we just needed enough kernel context to recognize the VM dispatcher when we saw it.
2. **Chapter 4's named addresses** ($F226 = `syscall_dispatch`) made the recurring `e9 26 f2` pattern in bank 0 immediately decodable as a host-call to a known function.
3. **The labeled disasm itself** — `tab_b15_f026: ; 512 bytes` was already in the disasm6 output. We just hadn't asked the question "what indexes into this table?" until chapter 5. The data was visible the whole time; what changed was the question.

This is the third chapter where the **toolchain output became another tool's input**. Chapter 3 fed labels to chapter 4's trace; chapter 4 fed handler names to chapter 5's bytecode reading; chapter 5 will feed VM opcodes to chapter 6's bytecode disassembler. Each layer makes the next layer visible.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

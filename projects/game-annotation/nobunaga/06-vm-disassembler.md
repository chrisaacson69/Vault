---
status: active
created: 2026-05-13
---
# Chapter 6 — The VM Disassembler

> Chapter 5 documented the VM architecturally. Chapter 6 builds the tool that reads VM bytecode and translates it into a readable instruction listing — the same kind of value-multiplier the `mesen-labels.py` and `asm-relabel.py` tools provided for native code. By the end of this chapter all 256 opcodes are classified by operand format, the boot bytecode walks cleanly, and the first kernel syscall fires from a verifiable line of VM-assembly. The chapter also functions as a reference: the operand table at the bottom is the canonical map from VM opcode to handler + operand format.

**Links:** [Chapter 5 — Bytecode VM](./05-bytecode-vm.md) · [Chapter 4 — Syscall API](./04-syscall-api.md) · [Nobunaga README](./README.md)

## The methodology arc

The toolchain pattern that emerged across chapters 3-5 was: each layer of analysis produces labels and structural metadata, which become input for the next layer. Chapter 3 named the kernel routines; chapter 4 used those names to read syscall handlers; chapter 5 used the syscall API to find the VM dispatcher. Chapter 6 continues this:

> chapter 5 named the VM's dispatch mechanism → chapter 6 uses the dispatch table to disassemble all of banks 0-14.

Without chapter 5, the bytes at $A77B onwards in bank 0 look like nonsense data. With it, they read as `host_call`, `push16`, `clear_aux_ptr`, `trigger_syscall` — actual operations.

## The tool: `vm-disasm.py`

`projects/game-annotation/tools/vm-disasm.py` is a 200-line Python script. Inputs:

- The ROM file (raw, post-iNES-header bytes)
- An opcode operand-format spec (`vm-opcodes.toml` per game)
- Optionally, a labels file (`mesen-labels.toml`) for friendly address rendering

Process:

1. Extract the 256-entry handler-address table from bank 15 at PRG offsets $3F026 (low) and $3F126 (high).
2. Walk the bytecode region one opcode at a time. For each opcode, look up its operand format in the spec.
3. Consume the appropriate number of bytes from the bytecode stream and render each operand.
4. For `host_call` opcodes, peek at the first 3 bytes of the target address: if they're `20 23 E8` (= `JSR $E823`), the target is a bytecode subroutine; otherwise it's native code. Annotate output with `{bytecode}` or `{native}`.

Output example:

```
  $89A8  41                    clear_aux_ptr
  $89A9  A8 4D 6F              load_word_A8     $6F4D
  $89AC  60                    push16                              (inline operand = 0)
  $89AD  E9 03 CA 02           host_call        $CA03 {bytecode}, $02
  $89B1  AC AC 88              host_call_simple $88AC {bytecode}
```

That single block carries more information than the disasm6 view of the same address range (which was just `hex 41 a8 4d 6f 60 e9 03 ca 02`).

## The classifier: `opcode-classify.py`

> **Tooling note (2026-05-29):** the classifier, the dispatch dumper, and the handler survey were consolidated into one tool — run `tools/analyze-vm-opcodes.py classify` (also `survey` / `dispatch`). The standalone `opcode-classify.py` described below no longer exists as a separate file; the logic is unchanged.

Manually walking 256 opcode handlers to determine each one's operand format would be a chapter on its own. Instead, the project includes a classifier (`tools/analyze-vm-opcodes.py classify`) that walks each unique handler's first ~40 bytes of native code and detects calls to known operand-fetch helpers:

```python
OPERAND_FETCH_HELPERS = {
    0xEFD5: ("word", 2),    # vm_read_word_into_ptr0
    0xEFA6: ("byte", 1),
    0xEFC0: ("byte", 1),
    0xEFEC: ("byte", 1),
    0xEFBF: ("byte", 1),
    0xEF97: ("sbyte", 1),
    0xEFD3: ("byte", 1),
}
```

A handler that calls `jsr $EFD5` consumes 2 bytes from the bytecode stream (a 16-bit literal). A handler that calls `jsr $EF97` consumes 1 signed byte. A handler with no fetch calls (or just `jmp vm_dispatch`) takes 0 operand bytes.

The classifier walks instructions:

```python
# When we hit JSR abs (opcode 20):
target = rom[pos+1] | (rom[pos+2] << 8)
if target in OPERAND_FETCH_HELPERS:
    operands.append(OPERAND_FETCH_HELPERS[target][0])
```

After scanning, it reports the operand pattern for each handler. The 256 opcodes group into ~12 distinct operand formats.

### Known classifier limitations

The classifier walks both fall-through and branch paths in handlers, which can over-count operands when a handler has a conditional fetch. Specifically, opcodes `$A7` and `$A8` have handlers that look like:

```asm
$EA75: jsr vm_read_word_into_ptr0    ; reads 2 bytes (word)
$EA78: bcc $EA64                     ; branch taken in normal path
$EA7A: jsr $EFA6                     ; reads 1 byte, but only on the no-branch path
$EA64: ...                           ; common tail
```

Reading $EFD5's exit conditions confirms the branch is taken in normal execution — so $A8 reads just a word, not word+byte. The classifier sees both JSRs and reports `word_byte`; we manually override these two entries in the TOML to `word`.

Other opcodes with similar conditional-fetch patterns may also be over-counted by the classifier. As we hand-verify more, the TOML refines. The infrastructure supports this — adding a specific `[[opcode]] op = 0xXX` entry overrides the range-based defaults.

## The 256-opcode reference

After auto-classification + a few hand corrections, the operand-format distribution:

| Format | Count | Opcode ranges | Notes |
|---|---:|---|---|
| **no_operand** (no bytes after opcode) | 148 | $00-$0B (load_ptr2_offset), $0C-$3F, $40 (clear_aux_ptr), $50 (set_local_0c), $70 (NOP), $80 + $91-$9F + $CE + $EB-$FE (37 of these are trigger_syscall), $B0-$D5, $D9-$DD, $E8, $EA, $FF | The dominant category. Most operations work on VM state (ptr1 stack, $08/$09 aux pointer) and consume only the opcode |
| **opcode_operand** (4-bit value encoded in opcode) | 61 | $41-$4F (clear_aux_ptr cluster), $51-$5F (set_local_0c cluster), $60-$6F (push16), $71-$7F (add_low4_to_aux_ptr) | Four 16-opcode clusters that share a single handler each; the low 4 bits of the opcode value become an immediate |
| **byte** (1 byte after opcode) | 18 | $81, $83, $85, $87, $8E, $A0-$A3, $AD, $AF, $D6-$D7, $DE-$E2 | Individual handlers; semantic meaning TBD |
| **sbyte** (1 signed byte) | 11 | $89, $8B, $8D, $8F, $AE, $D8, $E3-$E7 | Likely conditional branches (signed offset) |
| **word** (2 bytes) | 2 | $AC (host_call_simple), $AB, plus $A7-$A8 (manual override) | Read 16-bit literal |
| **word_byte** (2+1 = 3 bytes) | 6 | $A4-$A6, $A9-$AA, $E9 (host_call) | Address + adjustment byte |
| **byte_byte** (2 bytes) | 2 | $82, $90 | TBD |
| **byte_sbyte** (1+1 = 2 bytes) | 2 | $8A, $8C | TBD |
| **byte_word_byte** (1+2+1 = 4 bytes) | 3 | $84, $86, $88 | TBD |

(The "TBD semantic meaning" entries account for ~140 individually-handled opcodes. The chapter-6 work product is **byte-aligned coverage**, not semantic decoding — that's an iterative future-session activity, dramatically accelerated by the toolchain we now have.)

### Decoded opcodes (semantic meaning known)

| Opcode | Name | Operand format | Action |
|---|---|---|---|
| $00-$0B | `load_ptr2_offset` | none (low_4_bits in opcode) | Load 16-bit from (ptr2 + signed_small_offset). The 12 handlers at $E87F + 4*N each load a different offset constant ($E8, $EA, ..., $FE) and share a common tail |
| $41-$4F + $40 | `clear_aux_ptr` | none | Set $08/$09 = 0 |
| $51-$5F + $50 | `set_local_0c` | none (low_4_bits in opcode) | Set $0C/$0D = low 4 bits of opcode (high byte = 0) |
| $60-$6F | `push16` | none (low_4_bits in opcode) | Push 16-bit value (high=0, low=opcode&$F) onto the VM stack at ptr1; ptr1 -= 2 |
| $70 | `nop` | none | Handler is literally `jmp vm_dispatch` |
| $71-$7F | `add_low4_to_aux_ptr` | none (low_4_bits in opcode) | $08/$09 += (opcode&$F) (16-bit add with carry into $09) |
| $80 / $91-$9F / $CE / $EB-$FE | `trigger_syscall_*` | none | Handler is `BRK + 00 + JMP vm_dispatch` — fires syscall_dispatch with $0050 set by earlier opcodes |
| $A7 | `load_word_A7` | word | Read 16-bit literal from bytecode |
| $A8 | `load_word_A8` | word | Read 16-bit literal from bytecode |
| $AC | `host_call_simple` | word | JSR to native function (or bytecode subroutine if target starts with `JSR vm_entry`) |
| $E9 | `host_call` | word, byte | JSR to native function; afterward ptr1 += byte (the stack-cleanup convention) |

### The trigger_syscall cluster — 37 opcodes sharing $EF92

Of all the finds in chapter 6, this is the most architecturally interesting. **37 different opcodes all map to the same handler at $EF92, which is:**

```asm
$EF92: BRK
$EF93: 00       ; (BRK signature byte; ignored)
$EF94: JMP vm_dispatch
```

When any of these opcodes execute, `BRK` fires the IRQ handler at $C139. The handler reads `$0050` (the task ID, set by earlier bytecode), dispatches through the syscall_dispatch_table, runs the syscall handler, and returns. The pushed return address from BRK is $EF94, so after the syscall returns, control falls into `JMP vm_dispatch` and continues with the next bytecode opcode.

So these 37 opcodes are **"BRK to fire the current syscall."** The differentiator across the 37 is... apparently nothing visible from the handler itself. The opcode value isn't read in the dispatch path. Hypothesis: the 37 different opcode values exist as a **stylistic redundancy** so that bytecode compilers can use different opcodes for different *semantic intents* (e.g., "fire syscall after audio setup" vs. "fire syscall after PPU setup") even though the dispatch effect is identical. Or the redundancy is a side effect of how the kernel template was generated. Either way, the **practical effect** is the same: each of these opcodes fires a syscall with whatever's in $0050.

This means the bytecode has TWO ways to fire syscalls:
- **Direct**: `E9 26 F2 XX` — opcode $E9, address $F226 = syscall_dispatch, byte XX = stack adjustment. The address operand IS syscall_dispatch.
- **Implicit**: any of the 37 `trigger_syscall_*` opcodes — fires syscall via BRK with $0050 set by earlier opcodes.

The bytecode at $89A8 uses the direct form at $89D2 (`E9 26 F2 06`). It's likely that other code paths use the implicit form.

## Walking the boot bytecode: $89A8 → $89D2

Chapter 4's dispatch event log showed that the first syscall fired at frame 4, cycle 90309, was task $07 (`call_bank`). The chapter-5 model said this fires from somewhere in the VM bytecode. Chapter 6's disassembler can show where:

```
$A77D  AC A3 89               host_call_simple   $89A3 {bytecode}    # boot enters subroutine
                                                                       # subroutine entry: JSR $E823 at $89A3, bytecode at $89A8

$89A8  41                     clear_aux_ptr                          # zero $08/$09
$89A9  A8 4D 6F               load_word_A8       $6F4D                # read 16-bit pointer
$89AC  60                     push16                                  (=0)
$89AD  E9 03 CA 02            host_call          $CA03 {bytecode}     # call another subroutine

$89B1  AC AC 88               host_call_simple   $88AC {bytecode}     # call another subroutine
$89B4  40                     clear_aux_ptr_40
$89B5  A8 E7 7F               load_word_A8       $7FE7                 # read from PRG-RAM
$89B8  89 32                  op_89_sbyte        +50                   # signed-byte instruction (branch?)
$89BA  A8 65 6D               load_word_A8       $6D65                 # read from PRG-RAM
$89BD  40                     clear_aux_ptr_40
$89BE  A8 C7 7F               load_word_A8       $7FC7                 # read from PRG-RAM
$89C1  40                     clear_aux_ptr_40
$89C2  A8 D3 7F               load_word_A8       $7FD3                 # read from PRG-RAM
$89C5  40                     clear_aux_ptr_40
$89C6  A8 D1 7F               load_word_A8       $7FD1                 # read from PRG-RAM
$89C9  AC 1E 82               host_call_simple   $821E {bytecode}     # call another subroutine
$89CC  D8 D7                  op_D8_sbyte        -41                   # signed-byte instruction
$89CE  89 60                  op_89_sbyte        +96                   # signed-byte instruction
$89D0  60                     push16                                  (=0)
$89D1  6A                     push16                                  (=10)
$89D2  E9 26 F2 06            host_call          $F226 (syscall_dispatch) {native}, $06
                                                                       # ← FIRST SYSCALL FIRES HERE
```

The pattern is unmistakable:

1. **Setup phase** (instructions before $89D2): the bytecode calls 3 subroutines ($CA03, $88AC, $821E), reads 4 values from PRG-RAM ($7FE7, $7FC7, $7FD3, $7FD1) which is the battery-backed save region, and reads one value from $6D65 (likely game-data area). The reads probably check save validity / load saved state into VM frame slots.
2. **Stack prep** ($89D0-$89D1): push16(0) + push16(10) — pushes 0 then 10 onto the VM stack.
3. **Fire syscall** ($89D2): host_call to syscall_dispatch with ptr1_adj=$06. The kernel reads `(ptr1),Y=$02` to get the task ID. Per the chapter-4 trace, this fires task $07 = `call_bank`.

The disassembler can't statically determine what task ID lands in `(ptr1),Y=$02` — that's the result of VM state mutations from all preceding opcodes plus subroutine effects. But the **call site** is now identified and verifiable.

## Architectural refinement: `host_call` targets are bytecode subroutines

Chapter 5 said `host_call` "calls native code." Chapter 6's first walk of the boot bytecode immediately surfaced a refinement: **most `host_call` targets are bytecode subroutines, not native code.** A bytecode subroutine begins with the same 3-byte stub as the boot:

```asm
$89A3: 20 23 E8        ; JSR $E823 (vm_entry)
$89A6: FE FF           ; 16-bit frame offset (here: -2)
$89A8: 41 A8 4D 6F ... ; bytecode starts here
```

When `host_call_simple $89A3` executes, the CPU JSRs through `ptr0` to $89A3. The first instruction there is `JSR $E823`, which re-enters the VM — pushing a new frame onto the VM stack, setting ptr3 to the bytecode following the stub. When that subroutine eventually returns (via an RTS from inside the VM), the 6502 stack pops back to just after the original `host_call_simple` invocation.

The disassembler classifies each `host_call` target as `{bytecode}` or `{native}` by inspecting the target's first 3 bytes. In the 80 bytes of boot bytecode at $89A8, **all 4 `host_call` targets are bytecode subroutines** ($CA03, $88AC, $821E, $89A3 itself from the parent). The only `{native}` target encountered is $F226 (syscall_dispatch) at $89D2.

This was chapter 5's hypothesis being implicit; chapter 6 makes it explicit and gives us the tooling to distinguish at every call site.

## What the toolchain achieves cumulatively

After chapter 6, the project's tool flywheel covers:

| Tool | Input | Output | Compounds across |
|---|---|---|---|
| `mesen-labels.py` | TOML labels config | Mesen workspace JSON labels | All chapters of one game |
| `mesen-workspace.py` | TOML preset config | Mesen breakpoints + watches | One investigation |
| `asm-relabel.py` | TOML labels + disasm6 output | Labeled disasm with substituted references + injected label headers | All chapters of one game |
| `vm-disasm.py` | ROM + opcode-format TOML | Annotated VM-assembly | **All games in the catalog** (any game using a similar VM) |
| `analyze-vm-opcodes.py survey` | ROM | Opcode → handler clustering report | Initial setup per game |
| `analyze-vm-opcodes.py classify` | ROM | Auto-classified operand formats | Initial setup per game |

`vm-disasm.py` is the first tool whose payoff scales across **multiple games**. The chapter-4 prediction was that Koei MMC1 titles share a kernel; if they also share the VM (which is very likely given the kernel template), the disassembler works directly on Romance of the Three Kingdoms, Genghis Khan, Bandit Kings of Ancient China, etc., with only the per-game TOML changing.

## What's open for chapter 7+

- **Semantic decoding of individual opcodes.** ~140 opcodes have known operand formats but unknown game-logic meaning. Walking each handler one-by-one in the `bank_15_labeled.asm` view, looking at what state it manipulates, gives each opcode a real name. Each session can decode 10-20 opcodes. After 7-10 sessions of this, we'd have a fully-named VM instruction set.
- **The trigger_syscall cluster mystery.** Why 37 different opcodes for the same BRK behavior? Either a stylistic redundancy or there's a side effect we haven't found. Worth a targeted runtime trace.
- **Walking the bytecode call graph.** From $A77D, we can follow `host_call_simple $89A3` → $89A8 → `host_call_simple $88AC` → $88B1 → etc. The graph of bytecode subroutines is the game's program structure. Walking it identifies the boot sequence, the screen-mode dispatcher, the main game loop, and so on.
- **The runtime-trace validation.** With the disassembler, we can predict which bytecode bytes execute in what order. Cross-checking against a Mesen trace with `pc == $E867` (the vm_dispatch instruction) confirms the model. The chapter-5 dispatch logger Lua script is the scaffolding for this.

## Method note — the chapter that wrote itself

Chapter 6's investigation took less time than chapters 4 or 5, despite covering more material. Reasons:

- **All the heavy lifting was pre-positioned.** The labels were in place; the syscall_dispatch was named; the VM entry was understood. Building the disassembler was just plumbing what we already knew.
- **Auto-classification massively shortcut the work.** Reading 256 handler routines manually would have taken weeks. The classifier reduces that to a script that runs in 50ms.
- **The disassembler output validated itself.** When we read `host_call_simple $89A3 {bytecode}` and `host_call $F226 {native}, $06`, the picture immediately matches the chapter-4 trace and chapter-5 model. No ambiguity.

The toolchain investment of chapters 3-5 paid out compound interest here. Future chapters will keep harvesting from this foundation.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

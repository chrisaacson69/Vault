---
status: active
created: 2026-05-14
---
# Chapter 8 — The VM Instruction Set: Arithmetic, Control Flow, and the 9999 Cap

> Chapter 6 gave every one of the 256 opcodes a correct operand *length* — enough to walk bytecode without losing byte-alignment — but ~140 of them still had no *meaning*. This chapter hand-decodes the core of the instruction set: the register-file load/store matrix, the full ALU (add, sub, multiply, divide, modulo, shifts, bitwise, compares), and control flow. With those decoded, VM bytecode stops being a byte-aligned mystery and starts reading like source. The chapter ends by following that capability straight into the first real game mechanic: the value-clamp routine that caps resources at **9999** — the "big number" that kept surfacing in earlier sessions.

**Links:** [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Chapter 5 — Bytecode VM](./05-bytecode-vm.md) · [Chapter 7 — SRAM Save Layer](./07-sram-save-layer.md) · [Nobunaga README](./README.md)

## The VM is a register machine

Chapter 5 called the VM "stack-based." That was half right. It *has* a data stack (ptr1), but the bulk of the work happens in **two 16-bit working registers** plus a frame-relative local array. The decoded picture:

| Zero-page | Role |
|---|---|
| `$08/$09` | **regA** — primary 16-bit accumulator |
| `$0C/$0D` | **regB** — secondary 16-bit operand register |
| `$04/$05` (ptr2) | **frame pointer** — base of the current subroutine's local array |
| `$06/$07` (ptr3) | **program counter** — points at the next bytecode byte |
| `$02/$03` (ptr1) | **data stack pointer** — grows downward; used to spill regA across calls |
| `$00/$01` (ptr0) | scratch pointer — target of indirect loads/stores and native calls |

Almost every opcode is "do something to regA, optionally using regB." Binary operators are uniformly `regA = regA OP regB`. This is why the bytecode is so dense: there are no register names to encode — the operands are implicit.

## The $00–$3F frame-local load/store matrix

The first 64 opcodes are a single, beautifully regular structure: a **4×16 grid** crossing {load, store} × {regA, regB} × {negative-offset block, positive-offset block}.

| Opcodes | Operation | Addresses |
|---|---|---|
| `$00–$0B` | `regA = ` frame local | frame[−24 .. −2] (12 slots) |
| `$0C–$0F` | `regA = ` frame local | frame[+0x0B/+0x0D/+0x0F/+0x11] |
| `$10–$1B` | `regB = ` frame local | frame[−24 .. −2] |
| `$1C–$1F` | `regB = ` frame local | frame[+0x0B .. +0x11] |
| `$20–$2B` | frame local ` = regA` | frame[−24 .. −2] |
| `$2C–$2F` | frame local ` = regA` | frame[+0x0B .. +0x11] |
| `$30–$3B` | frame local ` = regB` | frame[−24 .. −2] |
| `$3C–$3F` | frame local ` = regB` | frame[+0x0B .. +0x11] |

The negative offsets reach the caller's arguments and outer locals; the positive offsets are the current frame's own scratch. The handlers are tiny `LDY #imm / LDA (ptr2),Y` stubs sharing a common tail. In disassembly these now read as `loadA_local_neg #11`, `storeB_local_pos #1`, and so on — the bytecode's variable accesses are legible.

## The ALU ($B0–$DC)

This is the heart of the chapter. The arithmetic and logic opcodes are all no-operand; they consume regA and regB and leave the result in regA.

### Arithmetic

| Opcode | Name | Operation |
|---|---|---|
| `$BB` | `add` | regA = regA + regB |
| `$BC` | `sub` | regA = regA − regB |
| `$B5` | `mul` | regA = regA × regB (16-bit shift-add) |
| `$B6` | `div_signed` | regA = regA ÷ regB (signed) |
| `$B8` | `div_unsigned` | regA = regA ÷ regB (unsigned) |
| `$B9` | `mod_signed` | regA = regA mod regB (signed) |
| `$BA` | `mod_unsigned` | regA = regA mod regB (unsigned) |
| `$D0` / `$D1` | `incA` / `decA` | regA ± 1 |
| `$D2` | `aslA` | regA <<= 1 |
| `$8F` | `addA_imm_sbyte` | regA += sign-extended byte literal |
| `$71–$7F` | `addA_imm4` | regA += (opcode & 0x0F) |

The multiply at `$B5` ($ECF0) is a classic 16-bit shift-and-add loop. The divides at `$ED2E` are a restoring shift-subtract: quotient accumulates in regA, remainder in ptr0 — `$B8`/`$BA` simply choose which one to keep. The signed variants (`$B6`, `$B9`) wrap the unsigned core in a sign-extraction prologue (`$ED7A`) that records the result sign in `$0A`/`$0B` and negates at the end.

**This is the find that unlocks the economy.** A "fall harvest = f(town, rice, output, dams)" formula is, at the bytecode level, exactly a sequence of `loadA_local / loadB_local / mul / add / div` operations. Until this chapter those bytes were `op_BX_DX (auto-classified)`; now they are arithmetic.

### Bitwise and compares

| Opcode | Name | Operation |
|---|---|---|
| `$DA` / `$DB` / `$DC` | `bitand` / `bitor` / `bitxor` | regA = regA OP regB |
| `$CC` | `bitnot` | regA = ~regA |
| `$BD` / `$BE` / `$BF` | `shl_by_regB` / `lshr_by_regB` / `ashr_by_regB` | barrel shifts by regB count |
| `$C0`–`$C9` | `cmp_*` | signed/unsigned compares — **leave a 0/1 boolean in regA** |
| `$CA` | `is_zero` | regA = (regA == 0) |
| `$CD` | `swap_AB` | regA ↔ regB |

The compares are the key control-flow primitive. `cmp_sgt` ($C4) computes `regA = (regA > regB) ? 1 : 0`. The result is a clean boolean, designed to be consumed immediately by a conditional branch.

## Control flow ($D8, $E3–$EA, $CF)

| Opcode | Name | Operation |
|---|---|---|
| `$E3` / `$E6` | `jump_rel` | ptr3 += signed byte (unconditional) |
| `$E4` / `$E7` | `branch_nz_rel` | if regA ≠ 0: ptr3 += signed byte |
| `$E5` / `$E8` | `branch_z_rel` | if regA == 0: ptr3 += signed byte |
| `$D8` | `branch_z` | if regA == 0: ptr3 += signed byte — the dominant conditional branch |
| `$D5` | `switch` | jump-table dispatch on regA over inline (value,target) pairs |
| `$E9` / `$AC` | `host_call` / `host_call_simple` | call native code or a bytecode subroutine |
| `$DD` / `$EA` | `host_call_indirect*` | call through an address held in regA |
| `$CF` | `vm_return` | restore the caller's frame and `JMP (ptr0)` — subroutine return |

The idiom is **compare-then-branch**: a `cmp_*` opcode sets regA to 0/1, and the very next opcode is `branch_z` ($D8) or `branch_nz` ($E4). `if (x > 9999) goto clamp` compiles to exactly three opcodes: `loadB_imm_word 9999 / cmp_sgt / branch_z`.

`vm_return` ($CF) at `$EF75` copies 8 bytes of saved frame state back from `frame[0..7]` and does an indirect jump — confirming chapter 5's model that each `host_call` into a bytecode subroutine pushes a frame whose first 8 bytes are the saved caller context.

### A tooling correction: $8A and $8C are word loads

`opcode-classify.py` tagged `$8A` and `$8C` as `byte + sbyte` (2 operand bytes). The 9999-clamp sites prove otherwise: the bytes `8C 0F 27` decode as `loadB_imm_word 9999`, and `8A 0F 27` as `loadA_imm_word 9999`. The handlers ($EAB9 / $EAC8) use the variable-length-immediate fetch helper, which the classifier's straight-line walk mis-read. The operand *length* is still 2 bytes, so disassembly alignment was never wrong — only the rendering. `vm-opcodes.toml` is corrected; this is exactly the kind of conditional-fetch over-count chapter 6 flagged for `$A7`/`$A8`.

## The 9999 cap — the "big number," confirmed

Earlier sessions kept hitting a recurring large constant. Scanning the full 256 KB ROM for `0F 27` (= 9999 little-endian) returns **exactly 17 occurrences**:

- **2** are bank-3 table sentinels — the `0F 27` marker that sits immediately before each scenario's daimyo table (chapter 7).
- **2** are in bank 15 (the kernel).
- **13** are in the bytecode banks (0, 1, 2, 4, 7, 14), and every one of those follows the same shape: `loadB_imm_word 9999 / cmp_sgt / branch_z`, or `loadA_imm_word 9999 / storeA_ind_word`.

That is a **clamp-to-maximum**. 9999 is the ceiling for the game's large stats — gold and koku/rice stockpiles. Chris's intuition ("this is the max value stats can get") was correct, and the count lines up with a per-resource clamp applied across the resource-update routines rather than a single shared helper.

### A clamp routine, disassembled

Bank 1 at `$AB44` — a confirmed clamp site — now reads cleanly:

```
$AB44  loadA_local_neg #11      ; regA = local[11]            (a fief / record index)
$AB45  aslA                     ; regA *= 2                   (16-bit element stride)
$AB46  loadB_local_neg #13      ; regB = local[13]            (a table base)
$AB47  add                      ; regA = local[11]*2 + local[13]   -> element address
$AB48  loadA_ind_word           ; regA = word[that address]   (current value)
$AB49  loadB_imm_word 9999      ; regB = 9999
$AB4C  cmp_sgt                  ; regA = (value > 9999)
$AB4D  branch_z +89             ; if NOT over cap, skip the clamp
$AB4F  ...                      ; (over cap:)
$AB50  loadA_local_neg #11      ; recompute the element address
$AB53  add
$AB54  pushA                    ; push address
$AB55  loadA_imm_word 9999      ; regA = 9999
$AB58  storeA_ind_word          ; word[address] = 9999        <- CLAMP
```

`address = base + index*2`, read the value, and if it exceeds 9999 write 9999 back. Bank 2 at `$9F18` is the same idea one step earlier in a pipeline — it reads `word[ptr+4]`, **adds `local[11]` to it**, and *then* runs the 9999 check. That `value + income, capped at 9999` is a resource-accumulation step: the shape of a harvest or tax credit.

In other words, the clamp sites are not isolated guards — they are the **tails of the economic update routines**. Finding the 9999 constant found the economy's address.

## What this unlocks

Three things are now true that were not before:

1. **The disassembler renders arithmetic.** Re-running `vm-disasm.py` with the updated `vm-opcodes.toml` turns the `op_BX_DX` blanks into `mul`, `div_unsigned`, `add`, `cmp_sgt`. Any bytecode region we point it at is readable.
2. **The economy's location is known.** The resource-update routines live around the bank-1/bank-2 clamp sites (`$AB40`-ish, `$9F10`-ish). The harvest, tax, and development handlers are reachable from there.
3. **The cap is a known quantity.** 9999 is the stockpile ceiling. The per-province stats (town, rice, output, dams, loyalty, etc.) are byte-or-small-word fields with their own lower ceilings — finding *those* clamps is the same scan with different constants, and is the natural next step.

## What's open for chapter 9+

- **The fall-gold formula.** Disassemble the bank-2 `$9F10` pipeline fully: what is `word[ptr+4]`, what is `local[11]`, and where does the income value come from? That sequence, walked to its `host_call` boundaries, *is* "how gold is determined in the fall."
- **The development commands.** "Develop town," "build dams," "give rice/gold" — each is a menu handler that reads a province record, applies a formula, and clamps. Locating the menu command dispatch (a `switch` opcode, `$D5`, on the selected command index) gives the entry point to all of them. A Mesen exec-breakpoint set while choosing a menu command would pin the dispatch address in one capture.
- **The lower stat ceilings.** Re-run the constant scan for `$0064` (100), `$03E7` (999), `$00FF` (255) and correlate hits with `cmp_*` opcodes to find each per-stat clamp. This answers "what are the maximums" precisely, per field.
- **`$D6/$D7`, `$E0–$E2`, the `$8x` cluster.** A dozen-odd opcodes still have only operand lengths. They are not on the critical path for the economy, but each session can retire a few.

## Method note

This chapter is the clearest instance yet of the project's flywheel. The 9999 question was a vague "you keep hitting a big number." Answering it required (a) the disassembler from chapter 6, (b) the opcode handler table, and (c) one afternoon of hand-walking bank 15. Once the ALU was decoded, a 30-second `grep` for one constant located the game's entire economic subsystem — because in a register VM, a formula *is* its arithmetic opcodes, and a cap *is* its compare-and-store. The structure did the work; the demo just made it visible.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

---
status: active
created: 2026-05-14
---
# Chapter 9 — The Command System: How a Menu Pick Becomes a Formula

> Chapter 8 decoded the VM's instruction set and found that the economy lives in the bytecode banks. This chapter walks the bridge the project was built to cross: from a menu item the player selects, through the VM's calling convention, down into the arithmetic that actually mutates a province — and out the other side with the **hidden mechanics of a single command fully exposed.** The worked example is menu item 7, **Grow**. By the end we have its complete formula, the cost the UI never shows, the diminishing-returns curve, the silent precondition, and the cross-field redistribution — plus the structural tools (`$B9B2` command table, the calling convention, the province-access idiom) that make the *other* 33 commands a mechanical diff rather than 33 fresh investigations.

**Links:** [Chapter 8 — VM Instruction Set](./08-vm-instruction-set.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Chapter 7 — SRAM Save Layer](./07-sram-save-layer.md) · [Nobunaga README](./README.md)

This chapter is longer and less linear than the others. It earns that: walking a single command end-to-end touched the calling convention, three layers of indirection, five mis-sized opcodes, an entire secondary instruction set, and a province table the earlier chapters hadn't located. The payoff is that everything here is reusable — the next command costs a fraction of this one.

## 1. The thread: a trace, pulled

The investigation started with one Mesen capture. With the disassembler from chapter 6 in hand, the question was simply *where does a menu command live?* Logic is all bytecode; the menu dispatch is somewhere in banks 0–14, and a 21,455-line execution log isn't a map.

The trick was to trace **one instruction**: `$EB7A`, the VM's universal indirect-call trampoline (`JMP ($0000)` — every `host_call` routes through it). One trace line per call, each showing its resolved target. That turns an opaque log into a **call graph**. Picking menu item 7 once, the graph showed:

- a steady idle loop (`$D14E` + `$D772` + `syscall_dispatch`) — the cursor blink,
- a screen-open burst,
- a navigation pattern repeating per cursor move,
- and then the command-fire burst: `… $CC7B → $87F0 → $CBCD → $D6B8 → $D6DE → $D70D`.

`$87F0` was the handler. Searching the ROM for its address found it called via `host_call $87F0` from bank 1 — next to `$9D3D`, which the trace had flagged during the screen-open. Pulling *that* thread found the structure that makes the whole menu legible.

## 2. The command driver table — `$B9B2`

There is **no master `switch`**. Each menu command is its own bytecode subroutine, and their entry points sit in a pointer table at bank 1 `$B9B2` — **34 entries**. Menu item N (as numbered in-game, 1-based) is table index **N−1**. This is confirmed, not inferred: the `$EB7A` trace was taken while picking in-game item **7**, and it landed on table index **6 = `$9D3D`**.

`command-table.py` walks the table, validates every entry is a real bytecode subroutine (each starts with the `20 23 E8` `JSR vm_entry` stub), and groups entries by their opening-byte signature. The grouping is the roadmap:

- **The "raise a province stat" family** — signature `A4 5F 6F 8B 1A B5 8C 01 70 BB …` — indices **4, 5, 6, 10, 12, 13, 14, 15** (idx 6 is Grow). Eight near-identical commands.
- **The display-command family** — signature `8E xx .. E9 26 D3 02` — indices **20–32**. Twelve commands, all "select a message, call `$D326`".
- **Ten unique commands** — indices 0,1,2,3,7,8,9,11,17,19 — the special actions (war, move, cede, search, and so on).

So 34 commands collapse to roughly **13 distinct decodes**, and once one member of a family is understood the rest are a diff. `command-table.txt` is the generated reference.

## 3. The VM calling convention — the Rosetta stone

Before any handler's *data flow* is readable, you have to know how arguments pass between VM subroutines. The answer is in `vm_entry` (`$E823`), and it is the single most useful structural fact in this chapter.

A bytecode subroutine begins with a 5-byte stub:

```
20 23 E8        JSR vm_entry
ff fc           frame offset (signed 16-bit; here −4)
<bytecode...>   the actual body, at stub+5
```

When `host_call` invokes that stub, `vm_entry` runs. Stripped to essentials:

```
ptr2 (frame pointer)  = ptr1 − 9          ; ptr1 = the VM data stack pointer
ptr1 (new data stack) = ptr2 + frame_offset
ptr3 (bytecode PC)    = stub + 5
```

The consequence is the key:

> **A caller's negative frame locals are the same physical memory as the callee's positive argument slots.**

Concretely — because `vm_call_native` pushes the return PC (`ptr1 −= 2`) and then `vm_entry` sets `ptr2 = ptr1 − 9`, the callee's `frame[+0x0B]` lands exactly on the caller's data-stack top, `frame[+0x0D]` on the next word down, and so on. A caller sets up a callee's arguments by **storing into its own low locals** (`storeX_local_neg`) right before the `host_call`; the callee reads them as `loadX_local_pos` (`$0C`–`$1F`). `host_call X, +N` then advances `ptr1` by N to discard the args on return.

This is why the disassembler's `loadA_local_pos` / `storeA_local_neg` opcodes — which looked like dull register-file shuffling in chapter 8 — are actually the **argument-passing protocol**. Every `host_call` site is now readable as a function call with arguments.

## 4. The province-access idiom

A province record is **26 bytes**. The table the command handlers operate on is at SRAM **`$7001`**, and the currently-selected province's index is held in the variable **`$6F5F`**. The universal idiom for "get a pointer to the current province's record" is ten bytes:

```
A4 5F 6F     loadA_mem_word $6F5F      regA = selected province index
8B 1A        loadB_imm_byte 26         regB = 26  (record size)
B5           mul                       regA = index * 26
8C 01 70     loadB_imm_word $7001      regB = $7001  (table base)
BB           add                       regA = index*26 + $7001  -> record pointer
```

This exact sequence appears **81 times** across banks 0, 1, 2, and 15 — it is *the* province-access pattern, and recognizing it instantly orients you in any handler. (It also forced an opcode correction; see §7.)

> **Reconciliation — RESOLVED (2026-05-14, post-draft).** A live SRAM dump settled the open question. The `$7001` table is the live working province table; its records are read **little-endian** (`loadA_ind_word`'s handler `$EC9E` reads low byte first). Anchoring record 7 to a known Mikawa save confirmed the layout — and it is **not** the layout chapter 7 assumed:
>
> | byte | 0 | 2 | 4 | 6 | 8 | 10 | 12 | 14 | 16 | 18 | 20 | 22 | 24 |
> |---|---|---|---|---|---|---|---|---|---|---|---|---|---|
> | field | gold | debt | town | rice | output | dams | loyalty | wealth | men | morale | skill | arms | **header** (base koku) |
>
> The header (base koku) is the **last** field (offset 24), not the first. Sections 5a/5b below were written against the chapter-7 (header@0) layout and are corrected in **§5d**. A second dump showed `$6000` is **not** a parallel province table: `$6000–$608F` holds 144 bytes of unrelated 16-bit data and everything up to `$6D1F` is empty. So `$7001` is the sole authoritative live province table, and chapter 7's "`$6000` province table" is a misidentified address — chapter 7's record offsets should be revisited against the layout above. The §5a/5b *offsets* are correct; only the *names* were wrong.
>
> The dump also grounded `word[$6D63] = 2` (the constant Grow's effect subtracts) — `$6D5F–$6D65` is a small config block `01 01 02 32`. And `$6F0B` holds a clean 17-element permutation of 0–16, almost certainly the daimyo turn order.

## 5. Grow, fully traced

Menu item 7 is two bytecode subroutines: a **driver** (`$9D3D`) that handles the player interaction and the cost, and an **effect** (`$87F0`) that computes the actual stat changes.

### 5a. The driver — `$9D3D`

```
record = $7001 + ($6F5F * 26)            ; pointer to the selected province

if  word[record + 24] >= word[record + 8]:        ; PRECONDITION A
        show message $FDC6 ; redraw ; return       ;   blocked, silently

if  word[record + 0]  == 0:                        ; PRECONDITION B
        show message $FDD9 ; redraw ; return       ;   header is 0 -> blocked

display the prompt screen (current value of record+8)
amount = D5E9(word[record + 0], 1)                 ; number-input prompt,
                                                   ;   capped at the header value
if amount == 0:  return                            ; silent cancel

word[record + 0] = word[record + 0] - amount       ; <-- THE COST
result = $87F0(record, amount)                     ; the effect (5b)
display the result ; redraw ; return
```

Two things the menu screen never states:

- **The cost is paid in koku from the province's own header field** (`record+0`), not from the player's gold. The input prompt is even *capped* at that field's value — you literally cannot Grow more than the province's header allows.
- Two **silent preconditions** can block the command outright, each with only a flash of a message string.

### 5b. The effect — `$87F0`

`$87F0` receives `record` and `amount` as arguments (via the calling convention of §3). Its spine:

```
if amount < 1:  return 0                           ; guard

regA = sqrt( word[record+8] + amount )             ; <-- $CBCD = integer square root
regA = regA - word[$6D63]                          ; minus a global threshold/constant
... helper $D6B8 (32-bit extended-opcode math) ...

clamp a working value against ( word[record+24] - word[record+8] )

if  working / 2  >  word[record+8]:                ; one branch hard-codes...
        result = 100                               ;   ...a flat 100

# tail: redistribute
t = $D70D( word[record+12], <pct> )                ; $D70D = percentage operator
word[record+12] -= t                               ;   field@12 pays a percentage
t = $D70D( word[record+10], <pct> )
word[record+10] -= t                               ;   field@10 pays a percentage
word[record+8]  += <adjustment>
```

`$CBCD` is the find that makes Grow make sense: it is an **integer square root** — the classic restoring algorithm, two bits per iteration, try-subtract, eight iterations over a 16-bit input. So the rice field's growth is driven by `√(rice + amount)`. `$D70D` is the **percentage operator** decoded earlier this session — `base × pct ÷ 100`, computed split-by-10 so the 16-bit product never overflows.

### 5c. The hidden mechanics of Grow

Putting the driver and effect together, here is everything the in-game UI does *not* tell you about pressing "Grow":

1. **It costs koku from the province itself.** Not gold. The header field is debited, and it caps how much you can spend.
2. **The benefit has square-root diminishing returns.** Growth scales with `√(rice + amount)`. Doubling your investment yields roughly `√2 ≈ 1.41×` the effect — not `2×`. Spreading koku across many small Grows beats one large Grow.
3. **A silent precondition can block it.** If `field@24 ≥ field@8` the command refuses, with only a brief message. The player gets no standing indicator of the condition.
4. **Growing one stat costs others.** The effect's tail runs the percentage operator on `field@12` and `field@10` and **subtracts** the results. Grow is partly a *redistribution*, not pure creation.
5. **There is a flat ceiling.** One branch in the effect hard-codes `100`, a cap that overrides the computed value under a specific condition.

None of (1)–(5) is visible in the menu. This is precisely the class of opaque mechanic the project set out to surface — and it is the first concrete entry in the eventual strategy counter-graph.

### 5d. Correction — Grow with the confirmed field layout

§5a–5c above were written against chapter 7's assumed record layout (header@0). The live SRAM dump (see the reconciliation note in §4) shows the `$7001` table's real layout has **header at offset 24** and gold at offset 0. Re-stating the byte offsets the handlers actually touch, with the *confirmed* names:

| handler reference | byte offset | confirmed field |
|---|---|---|
| driver precondition B, the cost (`word[record+0]`) | 0 | **gold** |
| effect's `√` input (`word[record+8]`) | 8 | **output** |
| effect redistribution (`word[record+10]`) | 10 | **dams** |
| effect redistribution (`word[record+12]`) | 12 | **loyalty** |
| both halves' clamp/precondition (`word[record+24]`) | 24 | **header** (base koku) |

So the corrected mechanics — replacing points (1)–(5):

1. **Grow costs gold**, debited from the province's `gold` field. The input prompt is capped at the current gold; if `gold == 0` the command is blocked outright (driver precondition B).
2. **The benefit is `√(output + gold_spent)`** — Grow raises the province's **output** on a square-root curve. Doubling the gold spent yields ≈`1.41×` the gain, not `2×`; many small Grows beat one large one.
3. **A development ceiling blocks it.** Driver precondition A refuses Grow when `header ≥ output` — base koku gates how far output can be pushed.
4. **Grow silently drains loyalty and dams.** The effect's tail runs the `$D70D` percentage operator on `loyalty` and `dams` and **subtracts** the results. Raising output costs those two stats.
5. **The flat-100 branch** in the effect still stands as decoded — a hard ceiling on the working value under one condition.

The *structure* of §5a/5b — guard, sqrt, clamp, redistribution, the flat-100 branch — was correct; only the field *names* were shifted by chapter 7's layout assumption. The diff method and the calling convention are unaffected.

## 6. The extended instruction set — `$B7`

Walking Grow's helpers (`$D6B8`, `$D6DE`) surfaced a structural discovery worth recording. The opcode `$B7` is not an operation — it is an **extended-opcode prefix**. Its handler `$F246` reads the *next* byte as a sub-opcode index and dispatches through a **second ~47-entry handler table at `$F263`**. So `B7 xx` is a two-byte instruction selecting from an entire secondary instruction set, and that set holds the VM's **wide / 32-bit arithmetic** (the first extended handler, `$F2C1`, zeroes a four-byte accumulator and runs a 32-iteration loop). The helper subroutines that do precise multi-precision math are dense with `B7 xx`. Decoding the 47 extended opcodes is its own future session; for now the disassembler stays byte-aligned by consuming the one sub-opcode byte.

## 7. Opcode corrections — the `$EFBF` family

Chapter 6 built the opcode table by auto-classification and explicitly warned that the classifier would **over-count operands** for opcodes whose handlers fetch conditionally. Chapter 6 hand-fixed `$A7`/`$A8`. This chapter found the rest of the family, because a mis-sized opcode silently drifts a disassembly until a branch happens to re-sync it — and the menu drivers are branch-dense.

The fixes, all from reading handlers:

| Opcode | Was | Is | Why |
|---|---|---|---|
| `$D6` | byte | **word** — `jump_abs` | `$EBBB`: `jsr $EFBF` (word fetch) → `ptr3` |
| `$D7` | byte | **word** — `branch_nz_abs` | `$EBC5`: conditional absolute jump |
| `$D8` | sbyte | **word** — `branch_z_abs` | `$EBD1`: the dominant conditional branch |
| `$8A` | byte+sbyte | **word** — `loadA_imm_word` | `$EAB9` |
| `$8C` | byte+sbyte | **word** — `loadB_imm_word` | `$EAC8` |
| `$8E` | byte | **word** — `push_imm_word` | `$EAD3`: `jsr $EFBF` + push |
| `$A4` | word+byte | **word** — `loadA_mem_word` | `$EA43` → `$EA37` |
| `$A5` | word+byte | **word** — `loadA_mem_byte` | `$EAF9` → `$EAF0` |
| `$A6` | word+byte | **word** — `loadB_mem_word` | `$EA5C` → `$EA4B` |
| `$A9` | word+byte | **word** — `storeA_mem_byte` | `$EB19` → `$EB12` |
| `$B7` | (0-operand) | **byte** — `ext_op` prefix | `$F246`: secondary dispatch |

The common cause: every one of these uses `$EFBF` or `$EFD5` (16-bit fetch helpers), and the classifier's straight-line walk saw a *different* byte read on a not-taken path. The disassembler also gained a **control-flow-following mode** (chapter 6's was straight-line); it now follows jumps and branches, queues their targets, and stops at `vm_return`, so it stays byte-aligned through a whole subroutine and never decodes the bytes a branch jumps over.

## 8. What's open

- **Chapter-7 reconciliation — resolved.** The `$7001` table's layout is confirmed (§4 note, §5d) and differs from chapter 7's assumption; a second dump showed `$6000` is *not* a parallel province table (it's empty in a live game). Remaining action item is on chapter 7's side: its province-record offsets and the "`$6000` table" address should be revised to match the confirmed `$7001` layout.
- **The Grow family diff.** Indices 4, 5, 10, 12, 13, 14, 15 share Grow's `A4 5F 6F 8B 1A B5 …` template. With the calling convention and the province idiom known, decoding them is mechanical — expect them to differ in which field offsets they read/write and which message IDs they push. That is the bulk of the lord-command menu in one short session.
- **The display-command family.** Indices 20–32, the `8E xx / host_call $D326` group — likely the status/info screens. Cheap to sweep.
- **`$CBCD`'s siblings.** Integer sqrt is one native math primitive; the percentage operator `$D70D` is another. The harvest and combat code will lean on the same primitives — cataloguing them now pays forward.
- **The 47 extended opcodes** behind `$B7`. Not on the command-menu critical path, but the harvest's multi-precision math will need them.

## 9. Method note — why this command was expensive and the next won't be

Grow took a full session. That is not the steady-state cost; it is the **one-time cost of building the scaffolding**. This session produced: the `$EB7A` call-graph technique, the command driver table, the calling convention, the province-access idiom, eleven opcode corrections, a control-flow-following disassembler, and two decoded math primitives. Every one of those is reusable. The next command in the Grow family is a diff against `$9D3D`/`$87F0`; the next *unique* command reuses the convention and the idiom and only needs its own arithmetic read. The flywheel chapter 6 promised is now turning on game logic, not just kernel plumbing — and the thing it is producing is exactly the project's stated goal: **the honest description of a mechanic the game's interface keeps hidden.**

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

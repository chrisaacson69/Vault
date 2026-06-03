"""
Sea-16 VM → C decompiler — prototype.

Strategy:
  1. Parse a sub from a bank's disassembly listing (the *_vm.asm files).
  2. Symbolically execute: regA, regB hold C *expressions* (strings).
     Data stack holds pushed expressions. Frame locals named arg1/local1/etc.
  3. Emit C when an opcode commits (vm_return, store, branch, host_call).
  4. Structured-control-flow lite: detect simple if/else patterns from forward
     branches that converge.

This is intentionally simple: linear pass with expression folding, branches
become labels + goto initially. Pattern-recognize if/else as a post-pass.

Usage:
  py -3 vm_decompile.py <bank_vm.asm> <sub_addr_hex>
  py -3 vm_decompile.py disasm/bank_01_vm.asm 87D8
"""
import sys
import re
from pathlib import Path


# --- VM-model drift-guard (M3, 2026-06-03) ----------------------------------
# A self-check that the decompiler's per-opcode data-stack handling agrees with
# the AUDITED authority `vm_stack_effect.STACK_EFFECT` (which vm-stack-audit.py
# proves against the live ROM handler, M2). It would have caught both Pass-1/M2
# stack-model bugs: $30-$3F (modeled as a store, Δ0, vs PUSH, Δ+1) and $B2
# (modeled as PUSHL, Δ+1, vs NOP, Δ0). Drift-proof because it OBSERVES the real
# handlers (no hand-maintained parallel table): when SELF_CHECK is on, decompile()
# logs the data-stack DEPTH at the top of every instruction; check_stack_trace()
# turns those into per-opcode Δ and compares to the table. SELF_CHECK defaults
# False so the production decompile path (and decompiled/*.c) is byte-for-byte
# unaffected. The full "decompiler reads the table to DRIVE its dispatch" rewrite
# is deferred to the end-of-project VM teardown (ROADMAP); this guards against
# drift in the meantime. Run: `py -3 tools/decompile-all.py --self-check`.
SELF_CHECK = False
_STACK_TRACE = []        # appended (opcode|None, depth) during a SELF_CHECK decompile


# --- Opcode handlers: each takes (state, operand) and may emit C lines ---

class State:
    def __init__(self):
        self._regA = "?"
        self.pending_call = None  # a host_call/CALL expr parked in regA, not yet consumed
        self.pending_call_addr = 0  # its bytecode address (so a flushed stmt cites the call site)
        self.regB = "?"
        self.stack = []  # list of expressions
        self.locals = {}  # frame slot -> last expression assigned
        self.lines = []  # emitted C lines (with indent level + text)
        self.indent = 1
        self.labels_needed = set()  # branch targets that need labels
        self.cur_addr = 0

    # regA is a stack-machine accumulator. A CALL writes a call-expr into it (via
    # set_call) but emits no statement — it only surfaces in C if something READS regA
    # (store/return/branch/op) before the next WRITE. Without help, a side-effecting call
    # whose result is discarded (the next op overwrites regA) vanishes silently — which is
    # why vm_bootstrap's init_new_game_state()/audio/planner calls were invisible.
    # The property makes the dataflow explicit:
    #   - READ  (getter): the value is being used -> a pending call is CONSUMED (no extra stmt).
    #   - WRITE (setter): if a pending call is being overwritten unconsumed, it was a
    #                     statement-for-side-effects -> flush it as `expr;` before overwriting.
    @property
    def regA(self):
        self.pending_call = None
        return self._regA

    @regA.setter
    def regA(self, val):
        self.flush_pending()  # overwriting an unconsumed call -> emit it for its side effects
        self._regA = val

    def flush_pending(self):
        """Emit a parked-but-unconsumed call as a side-effect statement. Called on regA
        overwrite (setter) and at control points that don't read regA (unconditional goto,
        function end), so a discarded call is never silently lost. The statement is tagged
        with the CALL's own address, not the flush site."""
        if self.pending_call is not None:
            self.lines.append((self.pending_call_addr, self.indent, f"{self.pending_call};"))
            self.pending_call = None

    def set_call(self, expr):
        """Record a call: overwrite regA (flushing any prior dead call) and mark this one
        pending until it is consumed or itself overwritten."""
        self.regA = expr               # setter flushes a prior unconsumed call first
        self.pending_call = expr       # ...this one becomes the new pending call
        self.pending_call_addr = self.cur_addr

    def emit(self, line):
        self.lines.append((self.cur_addr, self.indent, line))


# Local frame slot naming convention:
#   loadA_local_pos with inline op 0x0C/0x0D/0x0E/0x0F → arg1/arg2/arg3/arg4
#   loadA_local_neg with inline op 0-11 → local0..local11
def local_name(opcode_low, kind):
    """kind is 'pos' (args, frame[+11/+13/+15/+17]) or 'neg' (locals)."""
    if kind == 'pos':
        # 0x0C = arg1, 0x0D = arg2, 0x0E = arg3, 0x0F = arg4
        return f"arg{opcode_low - 0x0B}"
    else:
        # 0x00..0x0B = local0..local11 (frame[-24+2*n])
        return f"local{opcode_low}"


# --- General frame-local access (signed-offset opcodes) ---
# Opcodes $81-$88 / $A0-$A3 / $90 / $DE-$DF address frame memory relative to the
# VM frame pointer vm_fp (decoded from the handlers at $EA34-$EB25: each does
# `jsr vm_addr_ptr2_plus_{sbyte,word}` -> effective addr = vm_fp + offset, then a
# load/store/push). The 12 standard WORD locals sit at vm_fp-24..vm_fp-2
# (local0..local11), so an offset landing on one renders as that name — identical
# to the quick load/store opcodes $00-$3F. Any other offset (odd byte locals, args
# above fp, big frames) renders as an explicit (fp +/- N) expression.
_WORD_SLOT = {(-24 + 2 * n): f"local{n}" for n in range(12)}


def _slot_name(off):
    """Resolve a word-aligned frame offset to its positional slot name, or None.
    Negative even offsets vm_fp-24..vm_fp-2 are local0..local11. Positive ODD
    offsets from +0x0B are the stack-passed args: arg1 = vm_fp+0x0B (=+11), then
    +2 bytes per word arg (arg2=+13, arg3=+15, arg4=+17, arg5=+19, argN=+0x0B+2*(N-1)).
    The quick opcodes $00-$3F only reach local0-11 + arg1-4; this ALSO names arg5+ and
    any arg/local reached by the GENERAL signed-offset frame opcodes ($81-$88, $DE/$DF),
    which previously rendered raw as `*(word*)(fp + N)`. (Positive offsets <0x0B are the
    frame header; even positives and odd <0x0B are not args -> None -> render raw.)"""
    name = _WORD_SLOT.get(off)
    if name:
        return name
    if off >= 0x0B and off % 2 == 1:
        return f"arg{(off - 0x0B) // 2 + 1}"
    return None


def _op_hex(operand):
    """First `$hex` literal in the operand as an unsigned int, else 0 — absolute
    addresses and word immediates (the repeated `re.search(r'\\$([0-9A-Fa-f]+)')` idiom)."""
    m = re.search(r'\$([0-9A-Fa-f]+)', operand)
    return int(m.group(1), 16) if m else 0


def _op_int(operand):
    """First signed-decimal literal in the operand as an int, else 0 — signed-byte/word
    immediates (the `re.search(r'(-?\\d+)')` idiom). NOTE: distinct from the positive-only
    `\\+?(\\d+)` the $89/$8B byte-imm arms use — those keep their own parse."""
    m = re.search(r'(-?\d+)', operand)
    return int(m.group(1)) if m else 0


def _signed_operand(operand):
    """Parse the `$XX`/`$XXXX` operand of a frame op as a signed byte/word.
    Width is taken from the hex-digit count vm-disasm.py emits (2 = signed byte,
    4 = signed word) — matches how the byte-offset ($81/83/85/87) vs word-offset
    ($82/84/86/88, $A0-A3, $90, $DE/DF) handlers fetch their operand."""
    m = re.search(r'\$([0-9A-Fa-f]+)', operand)
    if not m:
        return 0
    h = m.group(1)
    val = int(h, 16)
    bits = 4 * len(h)
    if bits and val >= (1 << (bits - 1)):
        val -= (1 << bits)
    return val


def _fp_disp(off):
    """Render a signed frame displacement as 'fp', 'fp + N', or 'fp - N'."""
    if off == 0:
        return "fp"
    return f"fp + {off}" if off > 0 else f"fp - {-off}"


def frame_word(off):
    """Word frame local at vm_fp+off (lvalue or rvalue)."""
    return _slot_name(off) or f"*(word*)({_fp_disp(off)})"


def frame_byte(off):
    """Byte frame local at vm_fp+off (lvalue or rvalue). If the offset lands on a named
    word slot (arg/local), render `*(byte*)&name` -- the slot's low byte (little-endian),
    valid as BOTH lvalue and rvalue (unlike a `(byte)name` cast) -- so byte views of a
    word arg (e.g. a char passed in arg1, read by the text engine) name the slot instead
    of a raw frame displacement. Offsets that miss a slot (high bytes, odd <0x0B) stay raw."""
    name = _slot_name(off)
    return f"*(byte*)&{name}" if name else f"*(byte*)({_fp_disp(off)})"


def frame_addr(off):
    """Address of a frame local at vm_fp+off."""
    name = _slot_name(off)
    return f"&{name}" if name else f"({_fp_disp(off)})"


# Province record field annotations (offsets in bytes, fields are words).
# Used to rewrite `*(word*)(record + N)` as `record->field`.
PROV_FIELDS = {
    0:  "gold",
    2:  "debt",
    4:  "town",
    6:  "rice",
    8:  "output",
    10: "dams",
    12: "loyalty",
    14: "wealth",
    16: "men",
    18: "morale",
    20: "skill",
    22: "arms",
    24: "header",
}

# Daimyo record field annotations (we just walked these — offsets in bytes).
DAIMYO_FIELDS = {
    0: "age",
    1: "health",
    # 2-5 still unknown (likely drive/luck/charisma/iq)
    6: "status",
}


def annotate_field_access(expr, record_var="arg1", field_map=PROV_FIELDS):
    """Rewrite *(word*)((record + N)) as record->fieldname for known offsets."""
    # Match *(word*)((record_var + N))
    pat = re.compile(rf'\*\(word\*\)\(\({re.escape(record_var)} \+ (\d+)\)\)')
    def rep(m):
        off = int(m.group(1))
        name = field_map.get(off, f"field_{off}")
        return f"{record_var}->{name}"
    return pat.sub(rep, expr)


# Rewrite byte-array accesses `*(byte*)((IDX + 0xNNNN))` as `array_label[IDX]`
# when 0xNNNN is a labeled address. Restricted to byte derefs with a non-strided
# index (no `*`), so it does NOT touch the word-stride province records
# (`(arg1 * 26) + 0x7001`) that annotate_field_access handles. This is what turns
# the per-fief/per-daimyo flag arrays (ai_war_target_flags, fief_to_daimyo_map, …)
# legible across every indexed access.
# Index = a bare identifier (local9, arg1) optionally with a call's arg-parens
# (ui_helper_d772(arg1)). NOT a parenthesized arithmetic group like (arg1 * 26),
# so word-stride record bases are excluded (they're also *(word*), not *(byte*)).
_ARRAY_ACCESS_RE = re.compile(r'\*\(byte\*\)\(\((\w+(?:\([^()]*\))?) \+ 0x([0-9A-Fa-f]{4})\)\)')
# Named-base form: once a ROM/RAM table base is resolved to its label at the load
# (e.g. loadB_imm_word $F70E -> province_to_mapid_table), the deref reads
# `*(byte*)((idx + province_to_mapid_table))`. Match that too so it still collapses
# to `table[idx]` — otherwise resolving the base degrades arr[i] to pointer math.
_ARRAY_ACCESS_NAMED_RE = re.compile(r'\*\(byte\*\)\(\((\w+(?:\([^()]*\))?) \+ ([a-z_][A-Za-z0-9_]*)\)\)')

_NAME_SET_CACHE = {}
def _label_name_set(labels):
    key = id(labels)
    s = _NAME_SET_CACHE.get(key)
    if s is None:
        s = {_label_name(labels, a) for a in labels}
        s.discard(None)
        _NAME_SET_CACHE[key] = s
    return s


def annotate_array_access(text, labels):
    if not labels:
        return text
    def rep_hex(m):
        idx, addr_hex = m.group(1), m.group(2)
        name = _label_name(labels, int(addr_hex, 16))
        return f"{name}[{idx}]" if name else m.group(0)
    text = _ARRAY_ACCESS_RE.sub(rep_hex, text)
    names = _label_name_set(labels)
    def rep_named(m):
        idx, base = m.group(1), m.group(2)
        # base is the table (a known label); guard idx isn't itself a label so we
        # never rewrite an ambiguous (label_a + label_b).
        if base in names and idx not in names:
            return f"{base}[{idx}]"
        return m.group(0)
    return _ARRAY_ACCESS_NAMED_RE.sub(rep_named, text)


# --- Spec-independent dispatch: normalize the mnemonic from the OPCODE BYTE ---
# The decompile dispatch below keys on the original ("old-spec") mnemonics. Rather
# than couple to ANY mnemonic spelling, we derive the canonical name from the
# opcode byte (bytes[0]) — invariant across spec revisions. This lets the
# decompiler consume disasm produced with EITHER the old spec or the new
# vm-disasm.py (v2 OPCODE_INFO names like LOADL_quick / CALL_abs / RETURN), since
# the opcode byte is the same regardless of how the listing labels it.
def _build_opcode_to_mnemonic():
    m = {}
    rng = lambda a, b, name: m.update({op: name for op in range(a, b + 1)})
    rng(0x00, 0x0B, 'loadA_local_neg');  rng(0x0C, 0x0F, 'loadA_local_pos')
    rng(0x10, 0x1B, 'loadB_local_neg');  rng(0x1C, 0x1F, 'loadB_local_pos')
    rng(0x20, 0x2B, 'storeA_local_neg'); rng(0x2C, 0x2F, 'storeA_local_pos')
    # $30-$3F are PUSH_quick (per OPCODE_INFO, the semantics authority), NOT storeB.
    # They push a frame slot's VALUE onto the data stack (locals for $30-$3B, args for
    # $3C-$3F = arg-forwarding to a call). The old "storeB_local" mapping (store regB ->
    # slot) was the buggy legacy mnemonic and is the root of a large share of the bogus
    # `argN = ?` / `/*stack underflow*/` markers. Oracle-confirmed (forwarder stubs +
    # $38 push local8). See [[project_nobunaga_vm_decompiler]] / ROADMAP frame-arg fix.
    rng(0x30, 0x3B, 'push_local_neg'); rng(0x3C, 0x3F, 'push_local_pos')
    rng(0x40, 0x4F, 'loadA_imm4')   # LOADL_qimm: regL = opcode & 0x0F (0..15), NOT a clear
    m[0x50] = 'setB_imm4_50';            rng(0x51, 0x5F, 'setB_imm4')
    rng(0x60, 0x6F, 'push_imm4');        m[0x70] = 'nop'
    rng(0x71, 0x7F, 'addA_imm4')
    m[0x80] = 'trigger_syscall_80'
    m[0x81] = 'op_81_byte'; m[0x82] = 'op_82_bb'; m[0x83] = 'op_83_byte'
    m[0x84] = 'op_84_bwb'; m[0x85] = 'op_85_byte'; m[0x86] = 'op_86_bwb'
    m[0x87] = 'op_87_byte'; m[0x88] = 'op_88_bwb'
    m[0x89] = 'loadA_imm_sbyte'; m[0x8A] = 'loadA_imm_word'
    m[0x8B] = 'loadB_imm_byte';  m[0x8C] = 'loadB_imm_word'
    m[0x8D] = 'op_8D_sbyte'
    m[0x8E] = 'push_imm_word';   m[0x8F] = 'addA_imm_sbyte'
    m[0x90] = 'op_90_bb'
    rng(0x91, 0x9F, 'trigger_syscall_9X')
    rng(0xA0, 0xA3, 'op_A0_A3_byte')
    # $A4-$AB absolute-memory family — AUDITED 2026-06-01 (data-walk B2 fallout).
    # Direction can't be read from the handler bytes (the $EFD5/$EFA6/$EFEC prelude sets
    # up whether $00 points at the operand-address or the register file, so $EA75 etc.
    # look like loads either way) — the OPCODE USAGE PATTERN is the only reliable arbiter.
    #   $A8: PROVEN store by the year++ (`$A48E LOADL_abs $6D9F / INC / $A492 STORE_abs`);
    #        was wrongly aliased to loadA_mem_word -> 267 dropped stores. Fixed below.
    #   $A7: 0 sites in the whole ROM (verified) — the loadA_addr_word mapping is DEAD
    #        code, harmless. NOT changed to the spec's BYTE_LOADR_abs: unused == unvalidatable.
    #   $AA (266 sites, renders via PUSH_abs) / $AB (5) / op_AA_wb: 0 // TODO residue, render OK.
    m[0xA4] = 'loadA_mem_word';  m[0xA5] = 'loadA_mem_byte'
    m[0xA6] = 'loadB_mem_word';  m[0xA7] = 'loadA_addr_word'   # $A7: 0 sites (dead)
    m[0xA8] = 'storeA_mem_word'; m[0xA9] = 'storeA_mem_byte'
    m[0xAB] = 'op_AB_word'; m[0xAD] = 'op_AD_byte'
    m[0xAC] = 'host_call_simple'; m[0xAE] = 'adjust_stack_sbyte'
    m[0xB0] = 'loadA_ind_word';  m[0xB1] = 'storeA_ind_word'
    m[0xB2] = 'nop_B2';          m[0xB3] = 'pushA';     m[0xB4] = 'popB'
    m[0xB5] = 'mul';   m[0xB6] = 'div_signed';   m[0xB7] = 'ext_op'
    m[0xB8] = 'div_unsigned'
    m[0xB9] = 'mod_signed'; m[0xBA] = 'mod_unsigned'
    m[0xBB] = 'add';   m[0xBC] = 'sub'
    m[0xBD] = 'shl_by_regB'; m[0xBE] = 'lshr_by_regB'; m[0xBF] = 'ashr_by_regB'
    m[0xC0] = 'cmp_eq'; m[0xC1] = 'cmp_ne'; m[0xC2] = 'cmp_slt'; m[0xC3] = 'cmp_sge'
    m[0xC4] = 'cmp_sgt'; m[0xC5] = 'cmp_sle'; m[0xC6] = 'cmp_uge'; m[0xC7] = 'cmp_ule'
    m[0xC8] = 'cmp_ugt'; m[0xC9] = 'cmp_ult'; m[0xCA] = 'is_zero'
    m[0xCB] = 'op_CB';   m[0xCD] = 'swap_AB'; m[0xCE] = 'trigger_syscall_CE'
    m[0xCF] = 'vm_return'
    m[0xD0] = 'incA'; m[0xD1] = 'decA'; m[0xD2] = 'aslA'
    m[0xD3] = 'loadA_ind_byte'; m[0xD4] = 'storeA_ind_byte'; m[0xD5] = 'switch'
    m[0xD6] = 'jump_abs'; m[0xD7] = 'branch_nz_abs'; m[0xD8] = 'branch_z_abs'
    m[0xD9] = 'switch'   # SWITCH_noncontig (vm-disasm decodes the table into the comment)
    m[0xDA] = 'bitand'; m[0xDB] = 'bitor'; m[0xDC] = 'bitxor'
    m[0xDD] = 'host_call_indirect_simple'
    m[0xDE] = 'loadA_frameaddr'; m[0xDF] = 'loadB_frameaddr'
    m[0xE0] = 'op_E0_byte'; m[0xE1] = 'op_E1_byte'; m[0xE2] = 'op_E2_byte'
    m[0xE4] = 'branch_nz_rel'; m[0xE5] = 'branch_z_rel'; m[0xE6] = 'jump_rel_fwd'
    m[0xE7] = 'branch_nz_rel_fwd'; m[0xE8] = 'branch_z_rel_fwd'
    m[0xE9] = 'host_call'; m[0xEA] = 'host_call_indirect'
    for op in (0xEC, 0xED, 0xEE, 0xEF, 0xF2, 0xF3, 0xF4, 0xF6, 0xF7, 0xF9, 0xFA, 0xFB, 0xFE):
        m[op] = 'trigger_syscall_EB_FE'
    m[0xFF] = 'op_FF'
    return m

OPCODE_TO_MNEMONIC = _build_opcode_to_mnemonic()


# ext_op_table ($F263) — VM opcode $B7 ('ext_op'). index -> handler CPU addr.
# Decoded from this ROM via ext_op_dispatch ($F246): the dispatcher does asl/tax then
# LDA $F261,X, so handler(N) = little-endian word at $F261 + 2*N. Hence N=$01 = umul32,
# N=$00 = $0000 (the unused jmp-operand slot). Cross-verified against the table bytes +
# dispatcher addressing 2026-05-31 (corrects the ROADMAP's off-by-one map). Names resolve
# through mesen-labels.toml [prg.bank15] (Session A walk).
EXT_OP_TABLE = {
    0x00: 0x0000, 0x01: 0xF2C1, 0x02: 0xF2F0, 0x03: 0xF37F, 0x04: 0xF38C,
    0x05: 0xF427, 0x06: 0xF446, 0x07: 0xF457, 0x08: 0xF467, 0x09: 0xF495,
    0x0A: 0xF47E, 0x0B: 0xF4AC, 0x0C: 0xF54D, 0x0D: 0xF55B, 0x0E: 0xF569,
    0x0F: 0xF577, 0x10: 0xF57C, 0x11: 0xF581, 0x12: 0xF586, 0x13: 0xF58B,
    0x14: 0xF5A3, 0x15: 0xF5AC, 0x16: 0xF5C2, 0x17: 0xF531, 0x18: 0xF4F4,
    0x19: 0xF500, 0x1A: 0xF53F, 0x1B: 0xF51A, 0x1C: 0xF515, 0x1D: 0xF43B,
    0x1E: 0xF36B, 0x1F: 0xF399, 0x20: 0xF3B5, 0x21: 0xF3F7, 0x22: 0xF403,
    0x23: 0xF40F, 0x24: 0xF41B, 0x25: 0xF4E9, 0x26: 0xF4EF, 0x27: 0xF4F3,
    0x28: 0xF433, 0x29: 0xF475, 0x2A: 0xF4A3, 0x2B: 0xF48C, 0x2C: 0xF4BA,
    0x2D: 0xF3DB, 0x2E: 0xF2FB, 0x2F: 0xF362,
}


# Kernel syscall table — VM calls $F226 (syscall_dispatch) via CALL_abs_imm1; the
# 1-byte immediate IS the syscall ID, pushed LAST (right before the call), so under
# the reverse-push display convention (M3, 2026-06-03) it renders as the FIRST
# argument of the emitted `syscall_dispatch(...)` expression. Resolve it to the
# handler name (the
# 23-entry surface catalogued in 04-syscall-api.md). IDs 2/11/14/15 are RTS
# placeholder slots — deliberately ABSENT so they stay `syscall_dispatch(…, N)`
# (honest "unused slot" signal) rather than getting a fake name.
SYSCALL_TABLE = {
    0:  "syscall_reset",
    1:  "syscall_ppu_upload_block",
    3:  "syscall_set_sprite",
    4:  "syscall_palette_write",
    5:  "syscall_fill_nametable",
    6:  "syscall_read_controller",
    7:  "syscall_call_bank",
    8:  "syscall_fill_attr_quadrant",
    9:  "syscall_audio_load_voice",
    10: "syscall_audio_control",
    12: "syscall_ppu_blit_nobank",
    13: "syscall_ppu_render_rect",
    16: "syscall_memcpy_banked",
    17: "syscall_rng_next",
    18: "syscall_palette_swap",
    19: "syscall_wait_for_nmi",
    20: "syscall_ppu_blit_from_bank",
    21: "syscall_set_chr_bank0_reg",
    22: "syscall_sram_block_with_checksum",
}


def _as_int(tok):
    """Parse a C integer literal token ('6', '0x16', '22') -> int, else None."""
    tok = tok.strip()
    try:
        return int(tok, 16) if tok.lower().startswith('0x') else int(tok, 10)
    except ValueError:
        return None


def _split_top_level(s):
    """Split a comma-separated arg list on TOP-LEVEL commas only (respects nested
    parens, so `syscall_dispatch(a, foo(x, y), 6)` splits into 3, not 4)."""
    args, depth, start = [], 0, 0
    for i, c in enumerate(s):
        if c == '(':
            depth += 1
        elif c == ')':
            depth -= 1
        elif c == ',' and depth == 0:
            args.append(s[start:i])
            start = i + 1
    args.append(s[start:])
    return args


def annotate_syscall(text):
    """Rewrite `syscall_dispatch(ID, arg…)` -> `syscall_<name>(arg…)`.

    The LEADING argument is the kernel syscall ID (the CALL_abs_imm1 immediate to
    $F226). It's the last-pushed value, so the reverse-push display convention (M3)
    puts it first. Resolve it through SYSCALL_TABLE and drop it from the visible arg
    list, leaving the handler's actual parameters. Handles nested syscalls and
    balanced parens; leaves unknown/placeholder IDs (and non-literal leading args)
    untouched.
    """
    needle = "syscall_dispatch("
    out, i = [], 0
    while True:
        j = text.find(needle, i)
        if j < 0:
            out.append(text[i:])
            break
        out.append(text[i:j])
        # Walk to the matching close paren.
        k, depth = j + len(needle), 1
        start = k
        while k < len(text) and depth:
            depth += (text[k] == '(') - (text[k] == ')')
            k += 1
        if depth != 0:                      # unbalanced — bail, emit verbatim
            out.append(text[j:])
            break
        args = _split_top_level(text[start:k - 1])
        id_val = _as_int(args[0]) if args else None
        name = SYSCALL_TABLE.get(id_val)
        if name:
            rest = ", ".join(a.strip() for a in args[1:])
            out.append(f"{name}({rest})")
        else:
            out.append(text[j:k])           # keep raw dispatch for unmapped IDs
        i = k
    return "".join(out)


# Parse a line of the disasm output. Returns (addr, opcode_byte, mnemonic, inline_op, comment)
LINE_RE = re.compile(
    r'^\s*[>]?\$([0-9A-Fa-f]{4})\s+([0-9A-Fa-f]{2}(?:\s+[0-9A-Fa-f]{2})*)\s+(\S+)(.*)$'
)


def parse_listing(filepath, sub_addr):
    """Extract the lines of one sub from a bank_NN_vm.asm file."""
    sub_header = f"; sub ${sub_addr:04X}"
    in_sub = False
    body_addr = None
    instructions = []  # (addr, bytes, mnemonic, operand_repr, comment)
    for line in Path(filepath).read_text(encoding='utf-8', errors='ignore').splitlines():
        if line.startswith(';'):
            if sub_header in line:
                in_sub = True
                # Parse "body @ $XXXX"
                m = re.search(r'body @ \$([0-9A-Fa-f]{4})', line)
                if m:
                    body_addr = int(m.group(1), 16)
                continue
            if in_sub and "; sub $" in line:
                # next sub — done
                break
            continue
        if not in_sub:
            continue
        if "; ===" in line:
            continue
        m = LINE_RE.match(line)
        if not m:
            continue
        addr = int(m.group(1), 16)
        bytes_hex = m.group(2).split()
        mnemonic = m.group(3)
        rest = m.group(4).strip()
        # Parse operand
        operand_repr = None
        # Operand is everything before the ";" comment marker
        if ';' in rest:
            operand_repr, comment = rest.split(';', 1)
            operand_repr = operand_repr.strip()
            comment = comment.strip()
        else:
            operand_repr = rest.strip()
            comment = ""
        raw_bytes = [int(b, 16) for b in bytes_hex]
        # Normalize the mnemonic from the opcode byte — spec-independent, so this
        # works whether the listing used old-spec names or vm-disasm.py's v2 names.
        canonical = OPCODE_TO_MNEMONIC.get(raw_bytes[0], mnemonic)
        instructions.append({
            'addr': addr,
            'bytes': raw_bytes,
            'mnemonic': canonical,
            'operand': operand_repr,
            'comment': comment,
        })
    return body_addr, instructions


def _mem_name(operand, addr, labels):
    """Name an absolute-memory operand. Precedence: the disasm's own inline
    `(label)` -> the toml labels dict (covers [ram]/SRAM and data addresses, since
    load_labels() reads every "0xNNNN" line regardless of section) -> mem_XXXX.
    This is the variable-side twin of function naming: a name added to the toml's
    [ram] block surfaces here on the next decompile-all, no asm regen required."""
    label_m = re.search(r'\(([a-z_][a-z0-9_]*)\)', operand)
    if label_m:
        return label_m.group(1)
    return _label_name(labels, addr) or f"mem_{addr:04X}"


def _label_name(labels, addr):
    """Look up a label name for `addr`. Accepts either addr->name (str) or
    addr->(name, comment) (the nobunaga_vm.labels shape). Returns None if absent.
    Sanitizes to a valid C identifier."""
    if not labels:
        return None
    v = labels.get(addr)
    if v is None:
        return None
    name = v[0] if isinstance(v, tuple) else v
    name = re.sub(r'[^A-Za-z0-9_]', '_', name)
    if name and name[0].isdigit():
        name = "_" + name
    return name or None


def _imm_word_repr(val, labels):
    """Render a 16-bit immediate. ROM pointers ($8000+) resolve to their label
    (string/table/code-pointer name) — this is the B1 ROM-data surface. RAM bases
    ($6xxx/$7xxx) are deliberately LEFT as hex so the downstream annotate_array_access
    pass can still turn `(idx + 0x6CF7)` into `province_ai_state[idx]`; resolving them
    here would pre-empt that and degrade `arr[i]` to raw pointer math. `labels` is the
    per-bank dict, so a $BXXX string resolves to the right bank's name."""
    if val >= 0x8000:
        nm = _label_name(labels, val)
        if nm:
            return nm
    return str(val) if val < 256 else f"0x{val:04X}"


# The four quick-opcode families that address a frame ARG slot (vs a local): the
# low nibble 0x0C-0x0F selects arg1..arg4 (fp+0x0B/0D/0F/11). See local_name('pos').
_POS_ARG_MNEMONICS = frozenset({
    'loadA_local_pos', 'loadB_local_pos', 'storeA_local_pos', 'push_local_pos',
})


# General signed-offset frame opcodes that render a slot BY NAME (frame_word/_byte/_addr
# resolve via _slot_name) — so an arg reached only through one of these is still named
# argN and must be counted. Includes the byte ops ($A0-$A3): they now name the slot too
# (`*(byte*)&argN`), so a byte-only arg would otherwise leave the signature under-declared.
_GEN_FRAME_MNEMONICS = frozenset({
    'op_81_byte', 'op_82_bb', 'op_83_byte', 'op_84_bwb',
    'op_85_byte', 'op_86_bwb', 'op_87_byte', 'op_88_bwb',
    'loadA_frameaddr', 'loadB_frameaddr', 'op_A0_A3_byte',
})


def _body_arg_count(instructions):
    """Highest arg slot the body references, i.e. the real parameter count (0 -> `void`).
    Counts every access path that NAMES an arg (so the count == what renders as argN):
    the quick arg-opcodes (low nibble 0x0C-0x0F -> arg1..arg4) AND the general
    signed-offset frame opcodes (word $81-$88/$DE/$DF + byte $A0-$A3) landing on a
    positive odd offset >= +0x0B (arg5+ live ONLY here -- the quick opcodes top out at
    arg4; subs reach ~6 args)."""
    n = 0
    for ins in instructions:
        mn = ins['mnemonic']
        if mn in _POS_ARG_MNEMONICS:
            low = ins['bytes'][0] & 0x0F
            if low >= 0x0C:                       # 0x0C..0x0F -> arg1..arg4
                n = max(n, low - 0x0B)
        elif mn in _GEN_FRAME_MNEMONICS:
            off = _signed_operand(ins['operand'])
            if off >= 0x0B and off % 2 == 1:      # +0x0B,+0x0D,... -> arg1,arg2,...
                n = max(n, (off - 0x0B) // 2 + 1)
    return n


# --- var-walk: per-(sub, slot) semantic names for args/locals (M4, 2026-06-03) ---
# The variable-side twin of the label table. The decompiler names frame slots
# positionally (arg1..arg4, local0..local11); var-walk replaces those with role
# names (fief, amount, gain, …) recovered by usage-role inference + caller
# propagation. Storage lives in mesen-labels.toml as `[vars.bankN."0xADDR"]`
# sections (ADDR = the sub's stub address), one `slot = { name = "...", comment }`
# line per renamed slot. Regex-parsed (no tomllib dep), exactly like load_labels;
# the slot lines don't match the `"0x..."=` label regex so the label loaders ignore
# them, and the section header resets the `[prg.bankN]` collectors (which bail on any
# non-prg `[`), so the two tables never interfere.
def load_var_names(toml_path):
    """Parse `[vars.bankN."0xADDR"]` sections -> {(bank, addr): {slot: name}}.
    Slot keys are positional tokens (`arg1`/`localN`, bare) OR far-frame displacement
    keys (`"fp-38"`/`"fp+40"`, quoted) — the latter for spill locals the disassembler
    renders as raw `*(word*)(fp - 38)` rather than one of the 12 standard slots."""
    text = Path(toml_path).read_text(encoding="utf-8")
    sec_re = re.compile(r'^\s*\[vars\.bank(\d+)\."0x([0-9A-Fa-f]+)"\]')
    slot_re = re.compile(r'^\s*(?:([A-Za-z_]\w*)|"(fp[+-]\d+)")\s*=\s*\{\s*name\s*=\s*"([^"]+)"')
    out, cur = {}, None
    for line in text.splitlines():
        m = sec_re.match(line)
        if m:
            cur = (int(m.group(1)), int(m.group(2), 16))
            out.setdefault(cur, {})
            continue
        if line.lstrip().startswith('['):       # left the vars sections
            cur = None
            continue
        if cur is not None:
            sm = slot_re.match(line)
            if sm:
                out[cur][sm.group(1) or sm.group(2)] = sm.group(3)
    return out


# Far-frame slot key -> the exact displacement string vm-disasm renders (`_fp_disp`).
_FAR_KEY_RE = re.compile(r'fp([+-])(\d+)$')


def _far_disp(key):
    """`'fp-38'` -> `'fp - 38'` (the literal `_fp_disp` form), or None if not a far key."""
    m = _FAR_KEY_RE.match(key)
    return f"fp {m.group(1)} {int(m.group(2))}" if m else None


def apply_var_names(text, vmap):
    """Substitute frame-slot placeholders with their semantic names. Run LAST in the
    emit pipeline — after annotate_field_access et al., which key on the literal
    arg1..arg4, so `arg1->output` is already formed and just gets its base renamed.

    Two slot classes, disjoint text:
      • Positional tokens (`arg1`/`localN`): word-bounded single-pass alternation
        (no cascade — `local1` never eats `local11`).
      • Far-frame slots (`fp-38`): replace the WHOLE rendered lvalue/rvalue. Every
        `_fp_disp` form ends in `)`, so the displacement is closing-paren-anchored
        (no `fp - 3` vs `fp - 38` prefix collision). Deref forms for ALL keys go
        first, THEN the bare address-of form — so the `(fp - 38)` inside
        `*(word*)(fp - 38)` isn't eaten before its deref match."""
    if not vmap:
        return text
    pos = {k: v for k, v in vmap.items() if not k.startswith("fp")}
    far = {d: vmap[k] for k in vmap if (d := _far_disp(k))}
    if pos:
        keys = sorted(pos, key=len, reverse=True)
        pat = re.compile(r'\b(' + '|'.join(re.escape(k) for k in keys) + r')\b')
        text = pat.sub(lambda m: pos[m.group(1)], text)
    for disp, name in far.items():                    # 1) typed derefs (word + byte)
        text = text.replace(f"*(word*)({disp})", name).replace(f"*(byte*)({disp})", name)
    for disp, name in far.items():                    # 2) bare address-of, after derefs gone
        text = text.replace(f"({disp})", f"&{name}")
    return text


# --- Emission families: data-driven dispatch for the mechanical opcodes (A, teardown) ---
# The ~370-line dispatch in decompile() was a flat if/elif on mnemonics where ~50 arms
# were near-identical "regA = <formula of regA/regB>" lines. Those collapse to these
# tables + one generic block each, so the whole arithmetic/compare/logic family reads at
# a glance and a new op is a one-line table entry (portable to another Sea-16 title by
# swapping the table, not editing control flow). The genuinely-distinct opcodes
# (host_call/switch/ext_op/frame access/branches/calls) stay as explicit handlers below.
#
# _BINOP: `regA = (regA <op> regB)`. cast = how operands are signedness-cast:
#   'none' signed, 'both' both `(unsigned)`, 'lhs' only the left (logical right-shift).
_BINOP = {
    # signed / no cast
    'add': ('+', 'none'), 'sub': ('-', 'none'), 'mul': ('*', 'none'),
    'div_signed': ('/', 'none'), 'mod_signed': ('%', 'none'),
    'cmp_slt': ('<', 'none'), 'cmp_sgt': ('>', 'none'), 'cmp_sle': ('<=', 'none'),
    'cmp_sge': ('>=', 'none'), 'cmp_eq': ('==', 'none'), 'cmp_ne': ('!=', 'none'),
    'bitand': ('&', 'none'), 'bitor': ('|', 'none'), 'bitxor': ('^', 'none'),
    'shl_by_regB': ('<<', 'none'), 'shr_by_regB': ('>>', 'none'), 'ashr_by_regB': ('>>', 'none'),
    # unsigned (both operands cast)
    'div': ('/', 'both'), 'div_unsigned': ('/', 'both'), 'mod_unsigned': ('%', 'both'),
    'cmp_uge': ('>=', 'both'), 'cmp_ule': ('<=', 'both'),
    'cmp_ugt': ('>', 'both'), 'cmp_ult': ('<', 'both'),
    # logical right shift: only the left operand is cast unsigned
    'lshr_by_regB': ('>>', 'lhs'),
}

# _UNARY_A: `regA = <template>` where {A} is the current regA expression. One generic
# block replaces the inc/dec/shift-by-1/zero-test/negate/deref arms.
_UNARY_A = {
    'incA': '({A} + 1)', 'decA': '({A} - 1)',
    'aslA': '({A} << 1)', 'lsrA': '({A} >> 1)',
    'is_zero': '({A} == 0)', 'op_CB': '(-{A})',
    'loadA_ind_byte': '*(byte*)({A})', 'loadA_ind_word': '*(word*)({A})',
}


def decompile(filepath, sub_addr, labels=None, var_names=None):
    body_addr, instructions = parse_listing(filepath, sub_addr)
    if not instructions:
        print(f"// sub ${sub_addr:04X} not found in {filepath}")
        return

    state = State()
    # Name the function from its mesen label when one exists (header + the
    # `sub_XXXX(...)` declaration). Falls back to sub_XXXX for anonymous subs.
    fn_name = _label_name(labels, sub_addr) or f"sub_{sub_addr:04X}"
    print(f"// Decompiled from {filepath} sub ${sub_addr:04X}")
    if fn_name != f"sub_{sub_addr:04X}":
        print(f"// ${sub_addr:04X} {fn_name}")
    print(f"// (body @ ${body_addr:04X})")
    print()
    # Real arg count (M3, 2026-06-03 — replaces the hardcoded arg1..arg4). The
    # callee names its params arg1..arg4 = frame slots fp+0x0B/0D/0F/11, reached by
    # the quick arg-opcodes (low nibble 0x0C-0x0F across the load/store/push families).
    # The signature declares exactly the highest arg slot the BODY references — a
    # deterministic, per-sub measure that keeps bank_NN.c and the merged all_banks.c
    # byte-identical (no cross-bank caller pre-pass / global state). It names exactly
    # the args var-walk (M4) will rename. Caller-arity (the $E9 adj byte) is a possible
    # future cross-check but is NOT the authority here (it would couple the two views).
    arg_count = _body_arg_count(instructions)
    params = ", ".join(f"word arg{i}" for i in range(1, arg_count + 1)) or "void"
    params = apply_var_names(params, var_names)   # var-walk: rename args in the signature
    print(f"word {fn_name}({params}) {{")

    # First pass: find branch targets (need labels)
    branch_targets = set()
    for ins in instructions:
        if 'branch' in ins['mnemonic'] or 'jump' in ins['mnemonic']:
            m = re.search(r'\$([0-9A-Fa-f]{4})', ins['operand'])
            if m:
                branch_targets.add(int(m.group(1), 16))
        elif ins['mnemonic'] == 'switch':
            # Every case + default target (from the decoded "SWITCH …" comment).
            for t in re.findall(r'=>\$([0-9A-Fa-f]{4})', ins['comment']):
                branch_targets.add(int(t, 16))

    # Second pass: decompile
    for ins in instructions:
        state.cur_addr = ins['addr']
        mnem = ins['mnemonic']
        operand = ins['operand']
        comment = ins['comment']
        opcode = ins['bytes'][0]

        # Drift-guard: record data-stack depth at the TOP of each instruction (so
        # per-op Δ = depth[next] - depth[this], which is `continue`-proof). Off by
        # default → no effect on the emitted C. State is fresh per sub, so each
        # sub's trace starts at depth 0 and is bounded by its terminal marker below.
        if SELF_CHECK:
            _STACK_TRACE.append((opcode, len(state.stack)))

        # Label for branch targets
        if ins['addr'] in branch_targets:
            state.lines.append((ins['addr'], 0, f"L_{ins['addr']:04X}:"))

        # === Frame local loads ===
        if mnem == 'loadA_local_pos':
            state.regA = local_name(opcode & 0x0F, 'pos')
        elif mnem == 'loadB_local_pos':
            state.regB = local_name(opcode & 0x0F, 'pos')
        elif mnem == 'loadA_local_neg':
            state.regA = local_name(opcode & 0x0F, 'neg')
        elif mnem == 'loadB_local_neg':
            state.regB = local_name(opcode & 0x0F, 'neg')
        elif mnem == 'storeA_local_pos':
            name = local_name(opcode & 0x0F, 'pos')
            state.emit(f"{name} = {state.regA};")
        elif mnem == 'storeA_local_neg':
            name = local_name(opcode & 0x0F, 'neg')
            state.emit(f"{name} = {state.regA};")
            state.locals[opcode & 0x0F] = state.regA
        elif mnem == 'push_local_neg':
            # $30-$3B PUSH_quick: push a frame LOCAL's value onto the data stack.
            # (Oracle-confirmed: $38 pushes local8, sp -= 2 — not a store of regB.)
            state.stack.append(local_name(opcode & 0x0F, 'neg'))
        elif mnem == 'push_local_pos':
            # $3C-$3F PUSH_quick: push a frame ARG's value (arg-forwarding to a call).
            # Oracle-confirmed on the syscall wrapper stubs ($CBBD memcpy_banked forwarder):
            # $3C pushes arg1 (fp+0x0B) ... $3F pushes arg4 (fp+0x11).
            state.stack.append(local_name(opcode & 0x0F, 'pos'))

        # === Immediates ===
        elif mnem == 'loadA_imm_word':
            state.regA = _imm_word_repr(_op_hex(operand), labels)
        elif mnem == 'loadB_imm_word':
            state.regB = _imm_word_repr(_op_hex(operand), labels)
        elif mnem == 'loadA_imm_byte':
            m = re.search(r'\+?(\d+)', operand)
            state.regA = str(int(m.group(1)) if m else 0)
        elif mnem == 'loadB_imm_byte':
            m = re.search(r'\+?(\d+)', operand)
            state.regB = str(int(m.group(1)) if m else 0)
        elif mnem == 'setB_imm4':
            state.regB = str(opcode & 0x0F)
        elif mnem == 'addA_imm4':
            state.regA = f"({state.regA} + {opcode & 0x0F})"
        elif mnem == 'addA_imm_sbyte':
            state.regA = f"({state.regA} + {_op_int(operand)})"
        elif mnem == 'loadA_imm_sbyte':
            state.regA = str(_op_int(operand))
        elif mnem == 'loadB_imm_sbyte':
            state.regB = str(_op_int(operand))
        elif mnem == 'loadA_mem_word':
            state.regA = _mem_name(operand, _op_hex(operand), labels)
        elif mnem == 'loadB_mem_word':
            state.regB = _mem_name(operand, _op_hex(operand), labels)
        elif mnem in _UNARY_A:
            # Unary register ops -> regA = f(regA). Table-driven; see _UNARY_A.
            state.regA = _UNARY_A[mnem].format(A=state.regA)
        elif mnem in _BINOP:
            # All binary register ops -> regA = (regA <op> regB). Table-driven; see _BINOP.
            op, cast = _BINOP[mnem]
            a = f"(unsigned){state.regA}" if cast != 'none' else state.regA
            b = f"(unsigned){state.regB}" if cast == 'both' else state.regB
            state.regA = f"({a} {op} {b})"

        # === Pointer dereferences (loads are table-driven via _UNARY_A above) ===
        elif mnem == 'storeA_ind_byte':
            # regB has the pointer (from stack); regA is the value
            ptr = state.stack.pop() if state.stack else state.regB
            state.emit(f"*(byte*)({ptr}) = {state.regA};")
        elif mnem == 'storeA_ind_word':
            ptr = state.stack.pop() if state.stack else state.regB
            state.emit(f"*(word*)({ptr}) = {state.regA};")

        # === Stack ===
        elif mnem == 'pushA':
            state.stack.append(state.regA)
        elif mnem == 'popB':
            if state.stack:
                state.regB = state.stack.pop()
        elif mnem == 'push_imm4':
            state.stack.append(str(opcode & 0x0F))
        elif mnem == 'push_imm_sbyte':
            state.stack.append(str(_op_int(operand)))
        elif mnem == 'op_8D_sbyte':
            # $8D BYTE_PUSH_imm1 — push a 1-byte immediate (operand rendered "+NN").
            state.stack.append(str(_op_int(operand)))
        elif mnem == 'push_imm_word':
            # $8E PUSH_imm2 — push a 2-byte immediate (usually a table/struct
            # pointer; the label names that address, so push it by name).
            label_m = re.search(r'\(([a-z_][a-z0-9_]*)\)', operand)
            state.stack.append(label_m.group(1) if label_m else _imm_word_repr(_op_hex(operand), labels))
        elif mnem == 'PUSH_abs':
            # $AA PUSH_abs — push the VALUE stored at an absolute address.
            state.stack.append(_mem_name(operand, _op_hex(operand), labels))

        # === Logic / misc (binary & unary register ops table-driven above) ===
        elif mnem == 'swap_AB':
            state.regA, state.regB = state.regB, state.regA
        elif mnem == 'loadA_imm4':
            # $40-$4F LOADL_qimm: regL = low nibble (0..15). $40 == 0 (was a "clearA"
            # special case); $41-$4F carry a real immediate the old handler dropped.
            state.regA = str(opcode & 0x0F)

        # === Branches & control flow ===
        elif mnem == 'branch_z_abs':
            m = re.search(r'\$([0-9A-Fa-f]{4})', operand)
            tgt = int(m.group(1), 16) if m else 0
            state.emit(f"if (!({state.regA})) goto L_{tgt:04X};")
        elif mnem == 'branch_nz_abs':
            m = re.search(r'\$([0-9A-Fa-f]{4})', operand)
            tgt = int(m.group(1), 16) if m else 0
            state.emit(f"if ({state.regA}) goto L_{tgt:04X};")
        elif mnem == 'jump_abs':
            m = re.search(r'\$([0-9A-Fa-f]{4})', operand)
            tgt = int(m.group(1), 16) if m else 0
            state.flush_pending()  # goto doesn't read regA — emit a pending call before it
            state.emit(f"goto L_{tgt:04X};")
        elif mnem == 'vm_return':
            state.emit(f"return {state.regA};")
        elif mnem == 'switch':
            # vm-disasm decoded the jump table into the comment:
            #   "SWITCH <key>=>$<tgt> ... default=>$<tgt>"
            # regA holds the switched value. Emit a C switch of goto-cases.
            pairs = re.findall(r'(-?\d+)=>\$([0-9A-Fa-f]{4})', comment)
            dflt = re.search(r'default=>\$([0-9A-Fa-f]{4})', comment)
            if pairs:
                state.emit(f"switch ({state.regA}) {{")
                state.indent += 1
                for key, tgt in pairs:
                    state.emit(f"case {key}: goto L_{int(tgt, 16):04X};")
                if dflt:
                    state.emit(f"default: goto L_{int(dflt.group(1), 16):04X};")
                state.indent -= 1
                state.emit("}")
            else:
                state.emit(f"// TODO: switch {operand}")

        # === Host calls ===
        elif mnem == 'host_call' or mnem == 'host_call_simple':
            # Operand format: "$XXXX [label] {kind}, $YY" or "$XXXX {kind}"
            m = re.search(r'\$([0-9A-Fa-f]{4})', operand)
            tgt = int(m.group(1), 16) if m else 0
            # Extract bytes-popped from "...{kind}, $NN" suffix — N bytes = N/2 args
            ptr1_m = re.search(r',\s*\$([0-9A-Fa-f]+)\s*$', operand)
            bytes_popped = int(ptr1_m.group(1), 16) if ptr1_m else 0
            # Try to extract label: prefer the disasm operand's inline (label),
            # else fall back to the mesen labels dict, else sub_XXXX.
            label_m = re.search(r'\(([a-z_][a-z0-9_]*)\)', operand)
            if label_m:
                fname = label_m.group(1)
            else:
                fname = _label_name(labels, tgt) or f"sub_{tgt:04X}"
            # Known host_call arities (override the bytes-popped estimate)
            arity_map = {
                0xCBCD: 1,  # sqrt_int(x)
                0xD6B8: 3,  # math32_3arg(a,b,c)
                0xD6DE: 2,  # math32_2arg(a,b)
                0xD70D: 2,  # pct_op(b, p) — base, percent
                0xCA52: 1,  # rng_mod(max)
                0xD7CD: 1,  # daimyo_record_ptr(idx)
            }
            arity = arity_map.get(tgt, bytes_popped // 2)
            # Pop args in LIFO (top-of-stack first). The VM pushes call args
            # right-to-left, so the LAST-pushed word is the callee's arg1 (frame slot
            # fp+0x0B) — i.e. the FIRST popped here. Displaying them in pop order
            # therefore matches the callee's param numbering arg1, arg2, …, which is
            # what var-walk caller-propagation needs (M3 reverse-push fix, 2026-06-03;
            # this list used to be .reverse()d, inverting call-site order vs the body
            # and forcing the mental flip in math32_3arg(c,b,a) etc.).
            args = [state.stack.pop() if state.stack else "/*stack underflow*/ regA"
                    for _ in range(arity)]
            state.set_call(f"{fname}({', '.join(args)})" if args else f"{fname}()")

        # === Indirect host calls — VM opcodes $EA / $DD (call through regA) ===
        # The callee address is computed (in regA), not an inline label. $EA carries a
        # ptr1-adjust byte (= bytes popped, like $E9); $DD takes none (like $AC). Args
        # come off the VM stack, same as host_call.
        elif mnem in ('host_call_indirect', 'host_call_indirect_simple'):
            callee = state.regA
            bp = re.search(r'\$([0-9A-Fa-f]+)', operand)
            arity = (int(bp.group(1), 16) // 2) if bp else 0
            # Pop in LIFO so arg1 (last-pushed, fp+0x0B) prints first — see the
            # host_call note above (M3 reverse-push fix).
            args = [state.stack.pop() if state.stack else "/*stack underflow*/ regA"
                    for _ in range(arity)]
            state.set_call(f"(*({callee}))({', '.join(args)})")

        # === Extended (32-bit / bitfield) ops — VM opcode $B7 ('ext_op') ===
        # The operand is the ext-op INDEX byte ("$NN"). Resolve it through EXT_OP_TABLE
        # to a handler address, then name it via the mesen labels (Session A walk).
        # ext_ops form a postfix stack-machine sequence on the A/B register file
        # ($08-$0F), so we name the operation rather than fake an f(regA,regB) call.
        # EXCEPT $18/$19 (load_a32/b32_from_ptr3): these carry a 4-byte inline LE
        # immediate (vm-disasm.py gives the instruction length 6), so render the load.
        elif mnem == 'ext_op':
            m = re.search(r'\$([0-9A-Fa-f]+)', operand)
            idx = int(m.group(1), 16) if m else -1
            b = ins['bytes']
            if idx in (0x18, 0x19) and len(b) >= 6:
                imm = b[2] | (b[3] << 8) | (b[4] << 16) | (b[5] << 24)
                lit = str(imm) if imm < 256 else f"0x{imm:08X}"
                if idx == 0x18:   # load_a32_from_ptr3
                    state.regA = lit
                else:             # $19 load_b32_from_ptr3
                    state.regB = lit
            else:
                haddr = EXT_OP_TABLE.get(idx)
                if haddr:
                    name = _label_name(labels, haddr) or f"ext_op_{haddr:04X}"
                    state.emit(f"// ext_op {name}")
                else:
                    state.emit(f"// ext_op ${idx:02X} (unmapped)")

        # === General frame-local access (vm_fp + signed offset) ===
        # Decoded from the handlers $EA34-$EB25 (see _WORD_SLOT/frame_* helpers).
        # $81/$82 word load -> A; $83/$84 word load -> B; $85/$86 store A -> word;
        # $87/$88 push word; $A0-$A3 byte load/store/push; $90 add-imm16; $DE/$DF
        # frame-address; $50 setB=0.
        elif mnem in ('op_81_byte', 'op_82_bb'):
            state.regA = frame_word(_signed_operand(operand))
        elif mnem in ('op_83_byte', 'op_84_bwb'):
            state.regB = frame_word(_signed_operand(operand))
        elif mnem in ('op_85_byte', 'op_86_bwb'):
            state.emit(f"{frame_word(_signed_operand(operand))} = {state.regA};")
        elif mnem in ('op_87_byte', 'op_88_bwb'):
            state.stack.append(frame_word(_signed_operand(operand)))
        elif mnem == 'op_A0_A3_byte':
            off = _signed_operand(operand)
            sel = opcode & 0x03
            if sel == 0:      # $A0 byte load -> A
                state.regA = frame_byte(off)
            elif sel == 1:    # $A1 byte load -> B
                state.regB = frame_byte(off)
            elif sel == 2:    # $A2 store A -> byte
                state.emit(f"{frame_byte(off)} = {state.regA};")
            else:             # $A3 push byte
                state.stack.append(frame_byte(off))
        elif mnem == 'loadA_frameaddr':
            state.regA = frame_addr(_signed_operand(operand))
        elif mnem == 'loadB_frameaddr':
            state.regB = frame_addr(_signed_operand(operand))
        elif mnem == 'op_90_bb':
            # $90: regA += imm16 (handler falls into the addA tail at $EADC).
            val = _signed_operand(operand)
            sign = '+' if val >= 0 else '-'
            state.regA = f"({state.regA} {sign} {abs(val)})"
        elif mnem == 'setB_imm4_50':
            # $50: dedicated handler stores Y(=0) into regB.
            state.regB = "0"

        # === Misc register ops (binary & unary register ops table-driven above) ===
        elif mnem == 'nop_B2':
            # $B2 is a NOP (no stack/reg effect, length 1) — ORACLE-CONFIRMED 2026-06-03
            # via a synthetic micro-test through the real ROM handler (dSP=0, regL/regR
            # unchanged, pc+1). Resolves the M2 NOP-vs-PUSHL dispute: it was modeled here
            # as PUSHL(regA), which was wrong (harmless only because $B2 is never emitted
            # in this ROM — 0 occurrences across banks 0/1/2/15). OPCODE_INFO / v2 toml
            # ("NOP") were right. Left as an explicit no-op so the model is correct if a
            # $B2 ever turns up. See vm-stack-audit.py `validate_nop_b2`.
            pass

        # === Absolute byte memory (byte mirrors of loadA_mem_word/store) ===
        elif mnem == 'loadA_mem_byte':
            state.regA = _mem_name(operand, _op_hex(operand), labels)
        elif mnem == 'storeA_mem_word':
            # $A8 STORE_abs — store regA's WORD to an absolute address. (Was wrongly
            # mapped to loadA_mem_word: every $A8 store rendered as a phantom read.
            # PROVEN $A8=store by the year++ at $A48E LOADL_abs / INC / $A492 STORE_abs.)
            # regA is the SOURCE and is left unchanged by the store.
            state.emit(f"{_mem_name(operand, _op_hex(operand), labels)} = {state.regA};")
        elif mnem == 'storeA_mem_byte':
            state.emit(f"{_mem_name(operand, _op_hex(operand), labels)} = {state.regA};")

        # === Misc ===
        else:
            state.emit(f"// TODO: {mnem} {operand}".strip())

    if SELF_CHECK:           # terminal marker: closes this sub's trace (Δ of its last op)
        _STACK_TRACE.append((None, len(state.stack)))

    state.flush_pending()  # function end: don't lose a trailing discarded call

    # Post-pass: detect simple if/else patterns and structure them.
    # Pattern A (if-then):
    #     if (!(C)) goto L_X;
    #     <body>            ← straight-line, no branches
    #   L_X:
    # Becomes:
    #     if (C) {
    #         <body>
    #     }
    # Pattern B (if-then-else):
    #     if (!(C)) goto L_X;
    #     <then-body>
    #     goto L_Y;
    #   L_X:
    #     <else-body>
    #   L_Y:
    structured = structure_lines(state.lines)

    # Emit lines with field-name annotation
    for addr, indent, text in structured:
        text = annotate_field_access(text, "arg1", PROV_FIELDS)
        for n in range(2, 5):
            text = annotate_field_access(text, f"arg{n}", PROV_FIELDS)
        text = annotate_array_access(text, labels)
        text = annotate_syscall(text)
        text = simplify_expression(text)
        text = apply_var_names(text, var_names)   # var-walk: LAST, so arg1->output -> fief->output
        if text.endswith(':') and not text.startswith('//'):
            print(f"{text}")
        elif text.startswith('//'):
            print(f"{'    ' * indent}{text}")
        else:
            print(f"{'    ' * indent}{text}    // ${addr:04X}" if addr else f"{'    ' * indent}{text}")
    print("}")


# Simplification rewrites: undo doubly-negated conditions, fold (X + 0), etc.
SIMPLIFY_RULES = [
    (re.compile(r'\(0 - ([a-zA-Z_0-9]+)\)'), r'(-\1)'),
    (re.compile(r'\(([a-zA-Z_0-9]+) \+ 0\)'), r'\1'),
    (re.compile(r'!\(\(([^()]+) < ([^()]+)\)\)'), r'(\1 >= \2)'),
    (re.compile(r'!\(\(([^()]+) > ([^()]+)\)\)'), r'(\1 <= \2)'),
    (re.compile(r'!\(\(([^()]+) == ([^()]+)\)\)'), r'(\1 != \2)'),
    (re.compile(r'!\(\(([^()]+) != ([^()]+)\)\)'), r'(\1 == \2)'),
]


def invert_condition(cond):
    """Negate a condition expression for early-return rewrite."""
    cond = cond.strip()
    # If wrapped in outer parens, strip
    if cond.startswith('(') and cond.endswith(')'):
        cond = cond[1:-1]
    invs = [
        ('<', '>='), ('>', '<='), ('<=', '>'), ('>=', '<'),
        ('==', '!='), ('!=', '=='),
    ]
    for op, inv in invs:
        # Match strict op (space-bounded)
        pat = re.compile(rf'^(.+?)\s+{re.escape(op)}\s+(.+?)$')
        m = pat.match(cond)
        if m:
            return f"({m.group(1)} {inv} {m.group(2)})"
    # Fallback: !cond
    return f"!({cond})"


def simplify_expression(text):
    """Apply simple algebraic and logical simplifications."""
    for pat, rep in SIMPLIFY_RULES:
        for _ in range(3):  # apply up to 3 times for nested
            new = pat.sub(rep, text)
            if new == text: break
            text = new
    return text


def structure_lines(lines):
    """Recognize simple if-then-else patterns and convert goto → structured C.

    lines: list of (addr, indent, text) tuples.
    Returns: same shape, with if/else/closing-brace inserted where applicable.
    """
    # Index lines by what label they emit (e.g., "L_87FD:") and by address.
    out = []
    label_to_pos = {}
    for i, (addr, ind, text) in enumerate(lines):
        m = re.match(r'L_([0-9A-Fa-f]{4}):', text.strip())
        if m:
            label_to_pos[m.group(1).upper()] = i

    # First pre-pass: recognize "early return" idiom.
    #   if (cond) goto L_X;     <- if (cond) goto L_X then fall-through is the "else"
    #   <fall-through body — typically a single return>
    # L_X:
    #   <main body>
    # → Replace with: if (!cond) <fall-through body>;  remove L_X label.
    cleaned = []
    i = 0
    while i < len(lines):
        addr, ind, text = lines[i]
        m = re.match(r'if \((.+)\) goto L_([0-9A-Fa-f]{4});', text.strip())
        if m and i + 2 < len(lines):
            cond = m.group(1)
            tgt = m.group(2).upper()
            # Check if next line is a simple return, and the line after is the label
            next_text = lines[i + 1][2].strip()
            label_text = lines[i + 2][2].strip()
            ret_match = re.match(r'return (.+);$', next_text)
            label_match = re.match(rf'L_{tgt}:$', label_text)
            if ret_match and label_match:
                # Early-return idiom found
                neg_cond = invert_condition(cond)
                cleaned.append((addr, ind, f"if ({neg_cond}) return {ret_match.group(1)};"))
                i += 3  # skip the goto, return, and label
                continue
        cleaned.append(lines[i])
        i += 1
    lines = cleaned

    # Rebuild label index after cleaning
    label_to_pos = {}
    for i, (addr, ind, text) in enumerate(lines):
        m = re.match(r'L_([0-9A-Fa-f]{4}):', text.strip())
        if m:
            label_to_pos[m.group(1).upper()] = i

    i = 0
    indent_stack = [1]  # current indent depth
    pending_close = []  # list of (at_pos, indent_to_drop_to) -- emit '}' before this line
    while i < len(lines):
        addr, ind, text = lines[i]

        # Check if we should emit a closing brace before this line
        while pending_close and pending_close[-1][0] == i:
            close_indent = pending_close.pop()[1]
            out.append((0, close_indent, "}"))

        # Pattern: "if (!(cond)) goto L_X;" — try to convert to "if (cond) {" structure
        m = re.match(r'if \(!\((.+)\)\) goto L_([0-9A-Fa-f]{4});', text.strip())
        if m and m.group(2).upper() in label_to_pos:
            cond = m.group(1)
            tgt_pos = label_to_pos[m.group(2).upper()]
            # Only convert if target is FORWARD (positive direction) and there's no
            # branch ESCAPING the range [i+1, tgt_pos)
            if tgt_pos > i:
                # Check escape branches within [i+1, tgt_pos-1]
                escapes = False
                last_in_block = lines[tgt_pos - 1]
                else_target = None
                for j in range(i + 1, tgt_pos):
                    txt = lines[j][2]
                    bm = re.search(r'goto L_([0-9A-Fa-f]{4})', txt)
                    if bm:
                        tgt2 = bm.group(1).upper()
                        if label_to_pos.get(tgt2, -1) > tgt_pos:
                            # Forward goto past the if-end → potential else
                            if j == tgt_pos - 1 and 'if' not in txt:
                                # Last line is unconditional goto: it's an if/else
                                else_target = tgt2
                            else:
                                escapes = True
                                break
                        elif label_to_pos.get(tgt2, -1) < i:
                            # Backward goto → loop or complex flow
                            escapes = True
                            break
                if not escapes:
                    out.append((addr, ind, f"if ({cond}) {{"))
                    indent_stack.append(ind + 1)
                    if else_target:
                        # Close at end of then-body, open else at L_X, close else at else_target
                        else_pos = label_to_pos[else_target]
                        pending_close.append((tgt_pos, ind))  # close then-block at L_X
                        # We'll inject "} else {" at that label
                        # For now, just mark it for the label-emitter below
                        # Strip the trailing "goto L_else_target;" from the last line of then-block
                        i += 1
                        # Emit body of then-block minus the trailing goto
                        for k in range(i, tgt_pos - 1):
                            out.append(lines[k])
                        # Mark: when we hit tgt_pos (L_X label), emit "} else {"
                        # Then close at else_pos.
                        # Quick hack: just emit close, the label, then "else {"
                        out.append((0, ind, "} else {"))
                        for k in range(tgt_pos, else_pos):
                            # Skip the label line itself
                            if k == tgt_pos and re.match(r'L_', lines[k][2].strip()):
                                continue
                            out.append(lines[k])
                        out.append((0, ind, "}"))
                        i = else_pos
                        continue
                    else:
                        pending_close.append((tgt_pos, ind))
                        i += 1
                        continue

        out.append((addr, ind, text))
        i += 1

    # Emit any trailing closing braces
    while pending_close:
        close_indent = pending_close.pop()[1]
        out.append((0, close_indent, "}"))

    return out


# Opcodes whose decompiler model legitimately diverges from the runtime data-stack
# delta and so are NOT gated by the drift-guard (documented, not silently skipped).
# Populated empirically from the first clean run; each entry says WHY the decompiler's
# observed Δ differs from STACK_EFFECT (it's an abstraction, not a faithful VM stack).
_SELF_CHECK_EXCLUDE = {
    # (none yet — added with a reason if the first run surfaces a benign divergence)
}


def check_stack_trace():
    """Compare the SELF_CHECK trace (observed data-stack Δ per opcode, from the REAL
    handlers) against the audited `vm_stack_effect.STACK_EFFECT`. Returns
    (mismatches, observed) where mismatches is a list of (op, expected, got, mnem).

    Only GATED classes (data/push/pop/store) are checked — their data-stack Δ is
    branch-independent and must equal pushes-pops. call/return/control/probe/ext are
    skipped (the decompiler models calls via variable arity / registers, not a fixed
    data-stack Δ). See _SELF_CHECK_EXCLUDE for documented per-opcode carve-outs."""
    from collections import defaultdict
    from vm_stack_effect import STACK_EFFECT, GATED_CLASSES
    observed = defaultdict(set)
    for i in range(len(_STACK_TRACE) - 1):
        op, depth = _STACK_TRACE[i]
        if op is None:                       # terminal marker — don't pair across subs
            continue
        observed[op].add(_STACK_TRACE[i + 1][1] - depth)
    mismatches = []
    for op, deltas in sorted(observed.items()):
        if op in _SELF_CHECK_EXCLUDE:
            continue
        eff = STACK_EFFECT.get(op)
        if eff is None or eff.cls not in GATED_CLASSES:
            continue
        expected = eff.pushes - eff.pops    # net words onto the data stack
        if deltas != {expected}:
            mismatches.append((op, expected, sorted(deltas), eff.mnem))
    return mismatches, observed


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return
    filepath = sys.argv[1]
    sub_addr = int(sys.argv[2], 16)
    # Load mesen labels so standalone runs name functions like the batch driver.
    labels = None
    try:
        from nobunaga_vm import load_labels
        labels = load_labels()
    except Exception:
        pass
    # Var-walk names: bank inferred from the listing filename (bank_NN_vm.asm).
    var_names = None
    try:
        toml = Path(__file__).parent.parent / "mesen-labels.toml"
        bm = re.search(r'bank_(\d+)', filepath)
        if bm:
            var_names = load_var_names(toml).get((int(bm.group(1)), sub_addr))
    except Exception:
        pass
    decompile(filepath, sub_addr, labels, var_names=var_names)


if __name__ == "__main__":
    main()

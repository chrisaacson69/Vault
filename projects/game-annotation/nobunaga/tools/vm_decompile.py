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


# --- Opcode handlers: each takes (state, operand) and may emit C lines ---

class State:
    def __init__(self):
        self.regA = "?"
        self.regB = "?"
        self.stack = []  # list of expressions
        self.locals = {}  # frame slot -> last expression assigned
        self.lines = []  # emitted C lines (with indent level + text)
        self.indent = 1
        self.labels_needed = set()  # branch targets that need labels
        self.cur_addr = 0
        # Track recent frame writes (for implicit-arg-via-shadow calling convention)
        self.recent_pos_writes = {}  # slot index -> last expression written

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
        instructions.append({
            'addr': addr,
            'bytes': [int(b, 16) for b in bytes_hex],
            'mnemonic': mnemonic,
            'operand': operand_repr,
            'comment': comment,
        })
    return body_addr, instructions


def decompile(filepath, sub_addr):
    body_addr, instructions = parse_listing(filepath, sub_addr)
    if not instructions:
        print(f"// sub ${sub_addr:04X} not found in {filepath}")
        return

    state = State()
    print(f"// Decompiled from {filepath} sub ${sub_addr:04X}")
    print(f"// (body @ ${body_addr:04X})")
    print()
    print(f"word sub_{sub_addr:04X}(word arg1, word arg2, word arg3, word arg4) {{")

    # First pass: find branch targets (need labels)
    branch_targets = set()
    for ins in instructions:
        if 'branch' in ins['mnemonic'] or 'jump' in ins['mnemonic']:
            m = re.search(r'\$([0-9A-Fa-f]{4})', ins['operand'])
            if m:
                branch_targets.add(int(m.group(1), 16))

    # Second pass: decompile
    for ins in instructions:
        state.cur_addr = ins['addr']
        mnem = ins['mnemonic']
        operand = ins['operand']
        opcode = ins['bytes'][0]

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
        elif mnem == 'storeB_local_neg':
            name = local_name(opcode & 0x0F, 'neg')
            state.emit(f"{name} = {state.regB};")
        elif mnem == 'storeB_local_pos':
            name = local_name(opcode & 0x0F, 'pos')
            state.emit(f"{name} = {state.regB};")
            # Track for implicit-arg-via-shadow on the next host_call
            state.recent_pos_writes[opcode & 0x0F] = state.regB

        # === Immediates ===
        elif mnem == 'loadA_imm_word':
            m = re.search(r'\$([0-9A-Fa-f]+)', operand)
            val = int(m.group(1), 16) if m else 0
            state.regA = f"0x{val:04X}"
            if val < 256:
                state.regA = str(val)
        elif mnem == 'loadB_imm_word':
            m = re.search(r'\$([0-9A-Fa-f]+)', operand)
            val = int(m.group(1), 16) if m else 0
            state.regB = f"0x{val:04X}"
        elif mnem == 'loadA_imm_byte':
            m = re.search(r'\+?(\d+)', operand)
            val = int(m.group(1)) if m else 0
            state.regA = str(val)
        elif mnem == 'loadB_imm_byte':
            m = re.search(r'\+?(\d+)', operand)
            val = int(m.group(1)) if m else 0
            state.regB = str(val)
        elif mnem == 'setB_imm4':
            val = opcode & 0x0F
            state.regB = str(val)
        elif mnem == 'addA_imm4':
            val = opcode & 0x0F
            state.regA = f"({state.regA} + {val})"
        elif mnem == 'addA_imm_sbyte':
            m = re.search(r'(-?\d+)', operand)
            val = int(m.group(1)) if m else 0
            state.regA = f"({state.regA} + {val})"
        elif mnem == 'loadA_imm_sbyte':
            m = re.search(r'(-?\d+)', operand)
            val = int(m.group(1)) if m else 0
            state.regA = str(val)
        elif mnem == 'loadB_imm_sbyte':
            m = re.search(r'(-?\d+)', operand)
            val = int(m.group(1)) if m else 0
            state.regB = str(val)
        elif mnem == 'loadA_mem_word':
            m = re.search(r'\$([0-9A-Fa-f]+)', operand)
            addr = int(m.group(1), 16) if m else 0
            # Try to extract label
            label_m = re.search(r'\(([a-z_][a-z0-9_]*)\)', operand)
            name = label_m.group(1) if label_m else f"mem_{addr:04X}"
            state.regA = name
        elif mnem == 'loadB_mem_word':
            m = re.search(r'\$([0-9A-Fa-f]+)', operand)
            addr = int(m.group(1), 16) if m else 0
            label_m = re.search(r'\(([a-z_][a-z0-9_]*)\)', operand)
            name = label_m.group(1) if label_m else f"mem_{addr:04X}"
            state.regB = name
        elif mnem == 'aslA':
            state.regA = f"({state.regA} << 1)"
        elif mnem == 'lsrA':
            state.regA = f"({state.regA} >> 1)"
        elif mnem == 'shl_by_regB':
            state.regA = f"({state.regA} << {state.regB})"
        elif mnem == 'shr_by_regB':
            state.regA = f"({state.regA} >> {state.regB})"
        elif mnem == 'div_signed':
            state.regA = f"({state.regA} / {state.regB})"
        elif mnem == 'div':
            state.regA = f"((unsigned){state.regA} / (unsigned){state.regB})"
        elif mnem == 'mod_signed':
            state.regA = f"({state.regA} % {state.regB})"

        # === Pointer dereferences ===
        elif mnem == 'loadA_ind_byte':
            state.regA = f"*(byte*)({state.regA})"
        elif mnem == 'loadA_ind_word':
            state.regA = f"*(word*)({state.regA})"
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
            val = opcode & 0x0F
            state.stack.append(str(val))
        elif mnem == 'push_imm_sbyte':
            m = re.search(r'(-?\d+)', operand)
            val = int(m.group(1)) if m else 0
            state.stack.append(str(val))

        # === Arithmetic ===
        elif mnem == 'add':
            state.regA = f"({state.regA} + {state.regB})"
        elif mnem == 'sub':
            state.regA = f"({state.regA} - {state.regB})"
        elif mnem == 'mul':
            state.regA = f"({state.regA} * {state.regB})"
        elif mnem == 'div':
            state.regA = f"({state.regA} / {state.regB})"
        elif mnem == 'incA':
            state.regA = f"({state.regA} + 1)"
        elif mnem == 'decA':
            state.regA = f"({state.regA} - 1)"

        # === Comparisons ===
        elif mnem == 'cmp_slt':
            state.regA = f"({state.regA} < {state.regB})"
        elif mnem == 'cmp_sgt':
            state.regA = f"({state.regA} > {state.regB})"
        elif mnem == 'cmp_sle':
            state.regA = f"({state.regA} <= {state.regB})"
        elif mnem == 'cmp_uge':
            state.regA = f"((unsigned){state.regA} >= (unsigned){state.regB})"
        elif mnem == 'cmp_ule':
            state.regA = f"((unsigned){state.regA} <= (unsigned){state.regB})"
        elif mnem == 'cmp_eq':
            state.regA = f"({state.regA} == {state.regB})"
        elif mnem == 'cmp_ne':
            state.regA = f"({state.regA} != {state.regB})"

        # === Logic ===
        elif mnem == 'bitand':
            state.regA = f"({state.regA} & {state.regB})"
        elif mnem == 'bitor':
            state.regA = f"({state.regA} | {state.regB})"
        elif mnem == 'swap_AB':
            state.regA, state.regB = state.regB, state.regA
        elif mnem in ('clearA', 'clearA_40'):
            state.regA = "0"

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
            state.emit(f"goto L_{tgt:04X};")
        elif mnem == 'vm_return':
            state.emit(f"return {state.regA};")

        # === Host calls ===
        elif mnem == 'host_call' or mnem == 'host_call_simple':
            # Operand format: "$XXXX [label] {kind}, $YY" or "$XXXX {kind}"
            m = re.search(r'\$([0-9A-Fa-f]{4})', operand)
            tgt = int(m.group(1), 16) if m else 0
            # Extract bytes-popped from "...{kind}, $NN" suffix — N bytes = N/2 args
            ptr1_m = re.search(r',\s*\$([0-9A-Fa-f]+)\s*$', operand)
            bytes_popped = int(ptr1_m.group(1), 16) if ptr1_m else 0
            # Try to extract label
            label_m = re.search(r'\(([a-z_][a-z0-9_]*)\)', operand)
            fname = label_m.group(1) if label_m else f"sub_{tgt:04X}"
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
            args = []
            for _ in range(arity):
                if state.stack:
                    args.append(state.stack.pop())
                else:
                    # Stack underflow: implicit arg via recent frame-slot shadow write.
                    # If storeB_local_pos was used just before, that value is the implicit arg.
                    if state.recent_pos_writes:
                        # Use most-recently-written pos slot (heuristic)
                        slot = sorted(state.recent_pos_writes.keys())[-1]
                        args.append(f"/*via arg{slot - 0x0B}*/ {state.recent_pos_writes[slot]}")
                    else:
                        args.append(f"/*stack underflow*/ regA")
            args.reverse()
            state.recent_pos_writes.clear()  # consumed
            if not args:
                state.regA = f"{fname}()"
            else:
                state.regA = f"{fname}({', '.join(args)})"

        # === Misc ===
        else:
            state.emit(f"// TODO: {mnem} {operand}".strip())

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
        text = simplify_expression(text)
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


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return
    filepath = sys.argv[1]
    sub_addr = int(sys.argv[2], 16)
    decompile(filepath, sub_addr)


if __name__ == "__main__":
    main()

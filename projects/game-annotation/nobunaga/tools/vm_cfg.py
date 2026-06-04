"""
tools/vm_cfg.py — Control-flow-graph extractor + C-line-list lowering.

CFG epic, Phase 0 (the honesty gate that licenses every structuring fold).

Two CFGs over ONE key space. The key space is BYTECODE ADDRESSES, because the
decompiler renders every branch target as a label `L_XXXX:` whose XXXX *is* the
bytecode target address (vm_decompile.decompile), and every `goto L_XXXX` /
`case N: goto L_XXXX` references that same address. So the C control flow and the
bytecode control flow live in the same coordinate system — no name-matching, no
synthetic labels, no fuzzy alignment.

  bytecode_cfg(instructions)      -> (cfg, leaders)
      The GROUND TRUTH basic-block graph, built straight from the decoded
      bytecode. cfg = {leader_addr: frozenset(succ)}; succ entries are leader
      addrs or the EXIT sentinel. leaders = sorted block-start addresses.

  lower_c_to_cfg(lines, leaders)  -> cfg
      Lowers a (addr, indent, text) C line list — the RAW goto witness OR the
      STRUCTURED if/while/switch form — to the SAME block graph, by interpreting
      its control flow against the shared `leaders` partition.

The equivalence gate (tools/vm-cfg-gate.py) asserts lower_c_to_cfg(...) == cfg for
every sub: a structuring transform is honest iff it preserves the CFG. Where a
transform can't be proven CFG-preserving, the decompiler keeps an honest `goto`
(which lowers trivially), so fidelity rises monotonically and is never wrong.

Granularity note — why this is robust to expression folding: most VM instructions
(loads, immediates, register ops) emit NO C line; they fold into the next
committing statement's expression. So C statement addresses are a SUBSET of
bytecode instruction addresses. We never compare per-instruction; we collapse both
sides to the basic-block partition via block_of(addr) (= largest leader <= addr).
A basic block that emits NO statement at all (a branch target whose every
instruction folds, then falls through) has exactly one honest C reading —
fall through to the next block — which is reconstructed from `leaders` alone (a
folded block cannot branch, because a branch always emits a statement).
"""
import bisect
import re

EXIT = "EXIT"   # sentinel successor: control leaves the sub (return / fall off end)


# --- branch/switch/return recognition on the decoded bytecode -----------------
# Mirrors the control opcodes vm_decompile.decompile() emits: branch_z/nz_abs ->
# conditional, jump_abs -> unconditional, switch -> computed (case+default targets),
# vm_return -> EXIT. Everything else falls through to addr+len.
_COND_BRANCH = frozenset({'branch_z_abs', 'branch_nz_abs'})
_UNCOND_JUMP = frozenset({'jump_abs'})


def _target(ins):
    """The $XXXX absolute target in a branch/jump operand, or None."""
    m = re.search(r'\$([0-9A-Fa-f]{4})', ins['operand'] or '')
    return int(m.group(1), 16) if m else None


def _switch_targets(ins):
    """(case+default target addrs, has_default) decoded from a switch's comment,
    where vm-disasm wrote `<key>=>$<tgt> ... default=>$<tgt>`."""
    tgts = {int(t, 16) for t in re.findall(r'=>\$([0-9A-Fa-f]{4})', ins['comment'] or '')}
    has_default = 'default=>$' in (ins['comment'] or '')
    return tgts, has_default


def _instr_succ(instructions):
    """Per-instruction successor sets keyed by addr (entries: addr or EXIT), plus
    the diagnostic list of any unrecognised 'branch'/'jump' mnemonics encountered."""
    addrs = [ins['addr'] for ins in instructions]
    addr_set = set(addrs)
    by_addr = {ins['addr']: ins for ins in instructions}
    unknown = []

    def fallthrough(ins):
        nxt = ins['addr'] + len(ins['bytes'])
        return nxt if nxt in addr_set else EXIT

    succ = {}
    for ins in instructions:
        a, mn = ins['addr'], ins['mnemonic']
        if mn == 'vm_return':
            succ[a] = {EXIT}
        elif mn in _UNCOND_JUMP:
            t = _target(ins)
            succ[a] = {t if t is not None else EXIT}
        elif mn in _COND_BRANCH:
            t = _target(ins)
            succ[a] = {t if t is not None else EXIT, fallthrough(ins)}
        elif mn == 'switch':
            tgts, has_default = _switch_targets(ins)
            s = set(tgts)
            if not has_default:
                s.add(fallthrough(ins))   # unmatched selector falls past the switch
            succ[a] = s or {fallthrough(ins)}
        else:
            # Defensive: surface any other control-shaped mnemonic instead of silently
            # mismodelling it (the gate then fails loudly rather than passing a lie).
            if 'branch' in mn:
                t = _target(ins)
                succ[a] = {t if t is not None else EXIT, fallthrough(ins)}
                unknown.append((a, mn))
            elif 'jump' in mn:
                t = _target(ins)
                succ[a] = {t if t is not None else EXIT}
                unknown.append((a, mn))
            else:
                succ[a] = {fallthrough(ins)}
    return succ, addrs, by_addr, unknown


def _leaders(instructions, succ):
    """Basic-block leaders: the entry, every branch/switch target, and every
    instruction that immediately follows a control transfer."""
    addr_set = {ins['addr'] for ins in instructions}
    leaders = {instructions[0]['addr']}
    for ins in instructions:
        a, mn = ins['addr'], ins['mnemonic']
        transfers = (mn == 'vm_return' or mn in _UNCOND_JUMP or mn in _COND_BRANCH
                     or mn == 'switch' or 'branch' in mn or 'jump' in mn)
        if not transfers:
            continue
        for s in succ[a]:
            if s is not EXIT and s in addr_set:
                leaders.add(s)
        nxt = a + len(ins['bytes'])
        if nxt in addr_set:
            leaders.add(nxt)          # the instruction after a transfer starts a block
    return sorted(leaders)


def _block_of_fn(leaders_sorted):
    """addr -> the leader of the block containing it (largest leader <= addr)."""
    def block_of(a):
        i = bisect.bisect_right(leaders_sorted, a) - 1
        return leaders_sorted[i] if i >= 0 else leaders_sorted[0]
    return block_of


def bytecode_cfg(instructions):
    """Ground-truth basic-block CFG. Returns (cfg, leaders) where
    cfg = {leader: frozenset(succ leaders / EXIT)} and leaders is sorted."""
    if not instructions:
        return {}, []
    succ, addrs, by_addr, _unknown = _instr_succ(instructions)
    leaders = _leaders(instructions, succ)
    block_of = _block_of_fn(leaders)

    cfg = {}
    for idx, L in enumerate(leaders):
        hi = leaders[idx + 1] if idx + 1 < len(leaders) else None
        # terminator = the last instruction inside [L, hi)
        term = None
        for a in addrs:
            if a < L:
                continue
            if hi is not None and a >= hi:
                break
            term = a
        out = succ[term] if term is not None else {EXIT}
        cfg[L] = frozenset(EXIT if s is EXIT else block_of(s) for s in out)
    return cfg, leaders


def unknown_control_mnemonics(instructions):
    """Expose any unrecognised control-shaped mnemonics for the gate to report."""
    if not instructions:
        return []
    succ, *_rest, unknown = _instr_succ(instructions)
    return unknown


# --- lowering a C line list (raw goto OR structured) to the block CFG ----------

def _classify_stmt(text):
    """(kind, target_addr) for a leaf C statement. kinds:
    goto / ifgoto (cond -> target, else fall) / return / ifreturn (cond -> EXIT,
    else fall) / plain (sequential fall-through)."""
    t = text.strip()
    m = re.match(r'goto L_([0-9A-Fa-f]{4});$', t)
    if m:
        return 'goto', int(m.group(1), 16)
    m = re.match(r'if \(.+\) goto L_([0-9A-Fa-f]{4});$', t)   # if(C) and if(!(C))
    if m:
        return 'ifgoto', int(m.group(1), 16)
    if re.match(r'return\b', t):
        return 'return', None
    if re.match(r'if \(.+\) return\b', t):       # structure_lines early-return idiom
        return 'ifreturn', None
    return 'plain', None


_RE_IF_OPEN     = re.compile(r'if \((.+)\) \{$')
_RE_WHILE_OPEN  = re.compile(r'while \((.+)\) \{$')
_RE_SWITCH_OPEN = re.compile(r'switch \((.+)\) \{$')
_RE_DOWHILE_CLOSE = re.compile(r'\} while \((.+)\);$')
_RE_LABEL       = re.compile(r'L_[0-9A-Fa-f]{4}:$')
_RE_SWITCH_CASE = re.compile(r'(case -?\d+|default): goto L_([0-9A-Fa-f]{4});$')


def _parse_switch(lines, i):
    """Parse a `switch (...) {` body of `case/default: goto L_X;` lines up to `}`.
    Returns (node, next_index). node = ('SWITCH', sw_addr, frozenset(targets), has_default)."""
    sw_addr = lines[i][0]
    i += 1
    targets, has_default = set(), False
    while i < len(lines):
        t = lines[i][2].strip()
        if t == '}':
            i += 1
            break
        m = _RE_SWITCH_CASE.match(t)
        if m:
            targets.add(int(m.group(2), 16))
            if m.group(1) == 'default':
                has_default = True
        i += 1
    return ('SWITCH', sw_addr, frozenset(targets), has_default), i


def _parse_seq(lines, i):
    """Recursive-descent parse of a brace-delimited sequence. Returns
    (nodes, next_index, closer) where closer is '}', 'else', ('dowhile', cond),
    or 'eof'. Labels and comments are skipped (labels are redundant with the
    target-address coordinate system; comments carry no control flow)."""
    nodes = []
    while i < len(lines):
        addr, _ind, text = lines[i]
        t = text.strip()
        if t == '}':
            return nodes, i + 1, '}'
        if t == '} else {':
            return nodes, i + 1, 'else'
        m = _RE_DOWHILE_CLOSE.match(t)
        if m:
            return nodes, i + 1, ('dowhile', m.group(1))
        if _RE_LABEL.match(t) or t.startswith('//'):
            i += 1
            continue
        if _RE_SWITCH_OPEN.match(t):
            node, i = _parse_switch(lines, i)
            nodes.append(node)
            continue
        m = _RE_IF_OPEN.match(t)
        if m:
            then_nodes, i, closer = _parse_seq(lines, i + 1)
            els = None
            if closer == 'else':
                els, i, _closer2 = _parse_seq(lines, i)
            nodes.append(('IF', addr, m.group(1), then_nodes, els))
            continue
        m = _RE_WHILE_OPEN.match(t)
        if m:
            body, i, _closer = _parse_seq(lines, i + 1)
            nodes.append(('WHILE', addr, m.group(1), body))
            continue
        if t == 'do {':
            body, i, closer = _parse_seq(lines, i + 1)
            cond = closer[1] if isinstance(closer, tuple) else '?'
            nodes.append(('DOWHILE', addr, cond, body))
            continue
        nodes.append(('STMT', addr, t))
        i += 1
    return nodes, i, 'eof'


def lower_goto_cfg(lines, leaders):
    """Lower a RAW goto/label line list (no structured braces) to the block CFG.

    Per-block + ADDRESS-based, which makes it robust to two things a lexical /
    line-order walk gets wrong:
      * the decompiler's out-of-order flushed-call lines — a side-effecting CALL
        whose result is discarded is emitted at its FLUSH point (a later line) but
        tagged with its own EARLIER address (State.flush_pending); and
      * folded statement-less blocks — a branch target whose every instruction
        folds into an expression emits no line at all.
    In both cases fall-through must target the NEXT LEADER BY ADDRESS, never the
    block of the next emitted line. A block's successors are fixed by its single
    control terminator (goto / if-goto / return / switch), else it falls through.
    This is the witness-faithfulness gate (lower(raw) == bytecode_cfg).
    """
    if not leaders:
        return {}
    block_of = _block_of_fn(leaders)
    next_leader = {leaders[i]: (leaders[i + 1] if i + 1 < len(leaders) else EXIT)
                   for i in range(len(leaders))}
    blocks = {L: [] for L in leaders}
    for addr, _ind, text in lines:
        t = text.strip()
        if not t or t.startswith('//') or _RE_LABEL.match(t):
            continue
        if t == '}' or t == '} else {' or t.endswith('{') or _RE_DOWHILE_CLOSE.match(t):
            continue   # structured scaffolding has no place in the raw form; ignore defensively
        blocks[block_of(addr)].append(t)

    cfg = {}
    for L in leaders:
        succ = None
        sw_targets, sw_has_default, is_switch = set(), False, False
        for t in blocks[L]:
            mc = _RE_SWITCH_CASE.match(t)
            if mc:
                is_switch = True
                sw_targets.add(int(mc.group(2), 16))
                if mc.group(1) == 'default':
                    sw_has_default = True
                continue
            cl, tgt = _classify_stmt(t)
            if cl == 'goto':
                succ = {block_of(tgt)}
            elif cl == 'ifgoto':
                succ = {block_of(tgt), next_leader[L]}
            elif cl == 'return':
                succ = {EXIT}
            elif cl == 'ifreturn':
                succ = {EXIT, next_leader[L]}
            # plain statements contribute no edge; the block still falls through
        if is_switch:
            succ = {block_of(x) for x in sw_targets}
            if not sw_has_default:
                succ.add(next_leader[L])
        if succ is None:
            succ = {next_leader[L]}     # no terminator transfer => fall through
        cfg[L] = frozenset(succ)
    return cfg


def lower_c_to_cfg(lines, leaders):
    """Lower a (addr, indent, text) C line list to the block CFG over `leaders`.

    Returns {leader: frozenset(succ leaders / EXIT)}. Built by a structured
    interpreter over the brace tree: each construct contributes the exact edges
    its control flow induces, all collapsed to blocks via block_of. Statement-less
    blocks (everything folded) get their fall-through reconstructed from `leaders`.
    """
    if not leaders:
        return {}
    block_of = _block_of_fn(leaders)
    leader_set = set(leaders)
    edges = {}

    def add(src_block, dst):
        edges.setdefault(src_block, set()).add(dst)

    def node_entry(node, cont):
        """The block control enters when it reaches `node` (cont if node is None)."""
        if node is None:
            return cont
        return block_of(node[1])

    def seq_entry(seq, cont):
        return node_entry(seq[0], cont) if seq else cont

    def flow(seq, cont):
        """Wire a sibling sequence; `cont` = block/EXIT it flows to when done.
        Returns the sequence's entry block."""
        for idx, node in enumerate(seq):
            nxt = seq_entry(seq[idx + 1:], cont)
            flow_node(node, nxt)
        return seq_entry(seq, cont)

    def flow_node(node, nxt_block):
        kind = node[0]
        if kind == 'STMT':
            addr, text = node[1], node[2]
            bt = block_of(addr)
            cl, tgt = _classify_stmt(text)
            if cl == 'goto':
                add(bt, block_of(tgt))
            elif cl == 'ifgoto':
                add(bt, block_of(tgt))
                add(bt, nxt_block)
            elif cl == 'return':
                add(bt, EXIT)
            elif cl == 'ifreturn':
                add(bt, EXIT)
                add(bt, nxt_block)
            else:   # plain statement: only a boundary fall-through is a real edge
                if nxt_block != bt:
                    add(bt, nxt_block)
            return bt
        if kind == 'IF':
            _, addr, _cond, then, els = node
            bt = block_of(addr)
            then_entry = flow(then, nxt_block)
            if els is not None:
                else_entry = flow(els, nxt_block)
                add(bt, then_entry)
                add(bt, else_entry)
            else:
                add(bt, then_entry)
                add(bt, nxt_block)
            return bt
        if kind == 'WHILE':
            _, addr, _cond, body = node
            bt = block_of(addr)
            body_entry = flow(body, bt)     # body loops back to the header test
            add(bt, body_entry)
            add(bt, nxt_block)
            return bt
        if kind == 'DOWHILE':
            # do { body } while(C): test is at the body's EXIT, not the header.
            # No do-while is emitted before Phase 1; modelled as body that loops
            # to its own entry with an exit to nxt_block (refined when generated).
            _, _addr, _cond, body = node
            body_entry = flow(body, nxt_block)
            return body_entry
        if kind == 'SWITCH':
            _, addr, targets, has_default = node
            bt = block_of(addr)
            for X in targets:
                add(bt, block_of(X))
            if not has_default:
                add(bt, nxt_block)
            return bt
        raise AssertionError(f"unknown node kind {kind!r}")

    nodes, _i, _closer = _parse_seq(lines, 0)
    flow(nodes, EXIT)

    # Statement-less / comment-only blocks emitted no edge: a folded block cannot
    # branch (a branch always emits a statement), so its only honest reading is
    # fall-through to the next block (or EXIT past the end). Reconstruct from leaders.
    for idx, L in enumerate(leaders):
        if L not in edges:
            nxt = leaders[idx + 1] if idx + 1 < len(leaders) else EXIT
            edges[L] = {nxt}

    return {L: frozenset(s) for L, s in edges.items()}


def _selftest(bank, sub_hex):
    """Eyeball one sub: print its bytecode CFG vs the lowered raw/structured CFGs."""
    import io
    import importlib.util
    from contextlib import redirect_stdout
    from pathlib import Path
    import tempfile
    here = Path(__file__).parent
    import sys
    sys.path.insert(0, str(here))
    da = importlib.util.spec_from_file_location("decompile_all", here / "decompile-all.py")
    dam = importlib.util.module_from_spec(da)
    da.loader.exec_module(dam)
    import vm_decompile
    sub = int(sub_hex, 16)
    with tempfile.TemporaryDirectory() as td:
        captured = {}

        def on_sub(stub, collect):
            if stub == sub:
                captured.update(collect)
        dam.bank_subs(bank, Path(td), on_sub=on_sub)
    if not captured:
        print(f"sub ${sub:04X} not found in bank {bank}")
        return
    bc, leaders = bytecode_cfg(captured['instructions'])
    cc_raw = lower_goto_cfg(captured['raw'], leaders)
    cc_str = lower_c_to_cfg(captured['structured'], leaders)

    def show(name, cfg):
        print(f"\n{name}:")
        for L in sorted(cfg, key=lambda x: (x is EXIT, x)):
            succ = ", ".join(s if s is EXIT else f"${s:04X}" for s in sorted(
                cfg[L], key=lambda x: (x is EXIT, x)))
            print(f"  ${L:04X} -> {{{succ}}}")
    show("bytecode_cfg", bc)
    show("lower(raw)", cc_raw)
    show("lower(structured)", cc_str)
    print(f"\nraw == bytecode:        {cc_raw == bc}")
    print(f"structured == bytecode: {cc_str == bc}")


if __name__ == "__main__":
    import sys
    if len(sys.argv) == 3:
        _selftest(int(sys.argv[1]), sys.argv[2])
    else:
        print("usage: py -3 tools/vm_cfg.py <bank> <sub_hex>   (CFG self-test for one sub)")

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


# --- dominators / natural loops (the Phase-1 loop-structuring substrate) --------
# Standard iterative dataflow over the block CFG. Keyed on leader addrs + EXIT, the
# same coordinate system everything else here uses. These let the decompiler find
# the back edges that become `while`/`do-while` and the loop bodies they enclose.

def dominators(cfg, entry):
    """dom[n] = set of blocks that dominate n (every path entry->n passes through
    them). Iterative fixpoint; cfg = {leader: frozenset(succ)} incl. the EXIT node."""
    nodes = set(cfg) | {EXIT}
    preds = {n: set() for n in nodes}
    for n, succ in cfg.items():
        for s in succ:
            preds.setdefault(s, set()).add(n)
    dom = {n: set(nodes) for n in nodes}
    dom[entry] = {entry}
    changed = True
    while changed:
        changed = False
        for n in nodes:
            if n == entry:
                continue
            new = set(nodes)
            for p in preds[n]:
                new &= dom[p]
            new.add(n)
            if new != dom[n]:
                dom[n] = new
                changed = True
    return dom


def back_edges(cfg, entry):
    """The list of (u, h) edges where h dominates u — i.e. u->h closes a loop whose
    header is h. (Requires a reducible region for h to be the natural header; the
    natural_loop builder below is only meaningful on these.) Returns (edges, dom)."""
    dom = dominators(cfg, entry)
    edges = []
    for u, succ in cfg.items():
        for h in succ:
            if h is not EXIT and h in dom.get(u, ()):
                edges.append((u, h))
    return edges, dom


def natural_loop(u, h, cfg):
    """The natural loop of back edge u->h: {h} plus every node that can reach u
    without going through h. Standard backward worklist seeded from u and stopping at
    h — h is added up front and never pushed, so its own predecessors stay OUT (the
    header is the loop's single entry). A self-loop (u == h) is just {h}."""
    preds = {n: set() for n in cfg}
    for n, succ in cfg.items():
        for s in succ:
            if s is not EXIT:
                preds.setdefault(s, set()).add(n)
    loop = {h}
    if u != h:
        loop.add(u)
        work = [u]
        while work:
            n = work.pop()
            for p in preds.get(n, ()):
                if p not in loop:
                    loop.add(p)
                    work.append(p)
    return loop


# --- lowering a C line list (raw goto OR structured) to the block CFG ----------

def _classify_stmt(text):
    """(kind, target_addr) for a leaf C statement. kinds:
    goto / ifgoto (cond -> target, else fall) / return / ifreturn (cond -> EXIT,
    else fall) / break / continue / ifbreak / ifcontinue (target is the enclosing
    loop's exit / header, resolved by the caller via loop context, so target_addr is
    None here) / plain (sequential fall-through)."""
    t = text.strip()
    m = re.match(r'goto L_([0-9A-Fa-f]{4});$', t)
    if m:
        return 'goto', int(m.group(1), 16)
    m = re.match(r'if \(.+\) goto L_([0-9A-Fa-f]{4});$', t)   # if(C) and if(!(C))
    if m:
        return 'ifgoto', int(m.group(1), 16)
    if t == 'break;':
        return 'break', None
    if t == 'continue;':
        return 'continue', None
    if re.match(r'if \(.+\) break;$', t):
        return 'ifbreak', None
    if re.match(r'if \(.+\) continue;$', t):
        return 'ifcontinue', None
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


# --- true/false edge labels (catch a guard inversion / then-else swap) ----------
# The unlabelled CFG above treats a conditional block's two successors as an
# unordered set, so a fold that SWAPS the then/else bodies (or inverts the guard
# without compensating) preserves the edge SET and slips through. The fix: record,
# per 2-way conditional block, an ORIENTED (taken, fall) pair — taken = where control
# goes when the condition is TRUE — with all negation folded out so semantically equal
# guards compare equal. A branch condition is atomic here (the VM tests one regA value
# per branch), so it is either a bare value or a single `LHS op RHS` comparison; the
# only condition rewrites structuring performs are outer `!(...)` toggling and the
# comparison-operator flips in invert_condition (`<`<->`>=`, `>`<->`<=`, `==`<->`!=`).
# _canon_cond peels both into a parity bit, so raw and structured agree iff the routing
# is the same boolean function — and disagree exactly on a real swap.

_CMP_NEG = {'>=': '<', '<=': '>', '!=': '==', '<': '>=', '>': '<=', '==': '!='}
_RE_CMP = re.compile(r'^(.*?)\s*(<=|>=|==|!=|<|>)\s*(.*)$')


def _balanced_to_end(s, open_idx):
    """True iff the '(' at s[open_idx] has its matching ')' at the final char of s."""
    depth = 0
    for i in range(open_idx, len(s)):
        if s[i] == '(':
            depth += 1
        elif s[i] == ')':
            depth -= 1
            if depth == 0:
                return i == len(s) - 1
    return False


def _canon_cond(cond):
    """Canonicalise a branch condition to (base_text, parity). parity counts the
    negations folded out — outer `!(...)` wrappers AND a negated comparison operator —
    so two conditions that are boolean negations of each other share a base and differ
    in parity by exactly 1. Only parity is used by the orientation check; base is
    returned for diagnostics."""
    c = (cond or '').strip()
    parity = 0
    changed = True
    while changed:                                  # peel outer !(...) and redundant ( )
        changed = False
        if c.startswith('!(') and _balanced_to_end(c, 1):
            c, parity, changed = c[2:-1].strip(), parity ^ 1, True
        elif c.startswith('(') and _balanced_to_end(c, 0):
            c, changed = c[1:-1].strip(), True
    m = _RE_CMP.match(c)                             # single top-level comparison?
    if m:
        lhs, op, rhs = m.group(1).strip(), m.group(2), m.group(3).strip()
        if op in ('>=', '<=', '!='):                # fold negated op to its canonical mate
            op, parity = _CMP_NEG[op], parity ^ 1
        c = f"{lhs} {op} {rhs}"
    return c, parity


def _record_orient(orient, L, cond, taken, fall):
    """Store the parity-folded oriented edge for conditional block L: after folding the
    guard's negations out, `taken` is the TRUE side and `fall` the FALSE side."""
    if orient is None:
        return
    _base, parity = _canon_cond(cond)
    if parity:
        taken, fall = fall, taken
    orient[L] = (taken, fall)


def lower_goto_cfg(lines, leaders, orient=None):
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
                mcnd = re.match(r'if \((.+)\) goto', t)
                _record_orient(orient, L, mcnd.group(1), block_of(tgt), next_leader[L])
            elif cl == 'return':
                succ = {EXIT}
            elif cl == 'ifreturn':
                succ = {EXIT, next_leader[L]}
                mcnd = re.match(r'if \((.+)\) return', t)
                _record_orient(orient, L, mcnd.group(1), EXIT, next_leader[L])
            # plain statements contribute no edge; the block still falls through
        if is_switch:
            succ = {block_of(x) for x in sw_targets}
            if not sw_has_default:
                succ.add(next_leader[L])
        if succ is None:
            succ = {next_leader[L]}     # no terminator transfer => fall through
        cfg[L] = frozenset(succ)
    return cfg


def _is_scaffold(t):
    """A stripped line that carries no control AND no observable effect: blank,
    comment, label, or a brace/keyword opener/closer."""
    return (not t or t.startswith('//') or _RE_LABEL.match(t) is not None
            or t == '}' or t == '} else {' or t.endswith('{')
            or _RE_DOWHILE_CLOSE.match(t) is not None)


def _opens_block(t):
    """A construct-OPENER (`if (C) {`, `while (C) {`, `switch (E) {`, `do {`). These
    end in `{` (so _is_scaffold calls them scaffold for the 'no effect' question) but
    they DO start a basic block — the header's condition-evaluation lives here. The
    while-loop lowering must count them when locating a body's first/last block."""
    return (_RE_IF_OPEN.match(t) is not None or _RE_WHILE_OPEN.match(t) is not None
            or _RE_SWITCH_OPEN.match(t) is not None or t == 'do {')


def _occupies_block(t):
    """A line that starts/holds a basic block: any non-scaffold statement, OR a
    construct opener (which is scaffold for the 'no effect' test but still begins a
    block — the header's condition lives there)."""
    return (not _is_scaffold(t)) or _opens_block(t)


def _loop_body_leaders(lines, open_idx, close_idx, block_of, leaders=None):
    """The basic-block leaders touched by a loop's body (the lines strictly between its
    opener `open_idx` and closer `close_idx`), counting label-only lines (whose addr IS
    a leader) and folded openers. Used to map each body block to its enclosing loop so a
    `break`/`continue` inside it resolves to that loop's exit/header.

    Line-LESS interior blocks are filled in: a basic block inside the body's address
    span that emits NO C line (e.g. a folded then-body tail with all instructions
    absorbed into an expression) is still part of the loop. Omitting it makes the
    rotated-while body-redirect misread it as an OUTSIDE block falling into the loop and
    wrongly route it through the header. `leaders` must be passed to enable the fill."""
    bls = set()
    for k in range(open_idx + 1, close_idx):
        t = lines[k][2].strip()
        m = _RE_LABEL.match(t)
        if m:
            bls.add(int(t[2:6], 16))
        elif _occupies_block(t):
            bls.add(block_of(lines[k][0]))
    if leaders and bls:
        lo, hi = min(bls), max(bls)
        bls.update(L for L in leaders if lo < L < hi)
    return bls


def _match_constructs(lines):
    """Brace-match the structured if/while/switch/do blocks. Returns (ifs, whiles)
    where ifs = [(header_addr, header_idx, else_idx|None, closer_idx)] and
    whiles = [(header_addr, header_idx, closer_idx)]; dowhiles =
    [(do_addr, do_idx, close_addr, close_idx)]. Switches are handled per-block via
    their case lines, so they're matched only to keep the brace stack balanced."""
    ifs, whiles, dowhiles, stack = [], [], [], []
    for idx, (addr, _ind, text) in enumerate(lines):
        t = text.strip()
        if _RE_IF_OPEN.match(t):
            stack.append(['if', addr, idx, None])
        elif _RE_WHILE_OPEN.match(t):
            stack.append(['while', addr, idx])
        elif _RE_SWITCH_OPEN.match(t):
            stack.append(['switch', addr, idx])
        elif t == 'do {':
            stack.append(['do', addr, idx])
        elif t == '} else {':
            if stack and stack[-1][0] == 'if':
                stack[-1][3] = idx
        elif _RE_DOWHILE_CLOSE.match(t):
            if stack and stack[-1][0] == 'do':
                top = stack.pop()
                # do_addr (the `do {` line = loop header) + close_addr (the
                # `} while(C);` line = the tail TEST instruction's addr).
                dowhiles.append((top[1], top[2], addr, idx))
        elif t == '}':
            if not stack:
                continue
            top = stack.pop()
            if top[0] == 'if':
                ifs.append((top[1], top[2], top[3], idx))
            elif top[0] == 'while':
                whiles.append((top[1], top[2], idx))
    return ifs, whiles, dowhiles


def _span_max_leader(lines, lo, hi, block_of):
    """The highest basic-block LEADER touched by lines[lo:hi], counting both real
    statements (via block_of) and label lines `L_XXXX:` (whose addr IS a leader).
    Labels matter: an empty / folded arm contributes no real statement but its label
    still marks the leader, so the merge / else-start lands past it. None if empty."""
    best = None
    for k in range(lo, hi):
        addr, _i, text = lines[k]
        t = text.strip()
        m = _RE_LABEL.match(t)
        if m:
            L = int(t[2:6], 16)
        elif _is_scaffold(t) and not _opens_block(t):
            continue                       # openers (`do {`, `if (C) {`, …) start a block
        else:
            L = block_of(addr)
        best = L if best is None else max(best, L)
    return best


def lower_struct_cfg(lines, leaders, orient=None):
    """Lower the STRUCTURED C (if/while/switch + braces) to the block CFG over
    `leaders`. Per-block + ADDRESS-based like lower_goto_cfg (same robustness to
    flushed-call reordering / folded blocks), except a block whose branch became an
    if/while HEADER takes its edges from the brace structure:
      if(C){then}            : header -> { next_leader(header) [then], merge }
      if(C){then}else{else}  : header -> { next_leader(header) [then], else_start }
      while(C){body}         : header -> { next_leader(header) [body], exit };  body-tail -> header
    Merge / else-start / exit are computed from the next leader AFTER the relevant
    span by address, so an empty or folded arm still resolves (and contraction then
    absorbs the routing blocks). Non-header blocks fall back to the per-block scan."""
    if not leaders:
        return {}
    block_of = _block_of_fn(leaders)
    next_leader = {leaders[i]: (leaders[i + 1] if i + 1 < len(leaders) else EXIT)
                   for i in range(len(leaders))}
    ifs, whiles, dowhiles = _match_constructs(lines)

    header_edges, back_edges, tail_redirect, dowhile_edges = {}, {}, {}, {}
    # A loop body-TAIL block falls off the bottom `}` back to the loop HEADER, not to the
    # block after the loop. For a rotated `while(C)` next_leader[tail] already IS the
    # header (the test sits right after the body by address), so this was invisible; for
    # `while(1)` (tail at the end, header at the top) it matters — modelling the fall as
    # next_leader fabricated a spurious exit edge that let a bad fold pass. fall_of()
    # routes a tail's fall to the header.
    tail_fall_to_header = {}
    while_bodies = []   # (header_block, frozenset(body_leaders)) per while construct

    def span_after(lo, hi, header_block):
        """Block reached just past the line span [lo,hi): the leader following the
        HIGHEST leader the span touches. Falls to the header's own next leader when
        the span is empty."""
        top = _span_max_leader(lines, lo, hi, block_of)
        return next_leader[top] if top is not None else next_leader[header_block]

    for header_addr, h_idx, else_idx, close_idx in ifs:
        hb = block_of(header_addr)
        then_true = next_leader[hb]                    # then-body starts right after header
        _ifcond = _RE_IF_OPEN.match(lines[h_idx][2].strip())
        _ifcond = _ifcond.group(1) if _ifcond else ''
        if else_idx is None:
            merge = span_after(h_idx + 1, close_idx, hb)   # block past the whole if
            header_edges[hb] = {then_true, merge}
            _record_orient(orient, hb, _ifcond, then_true, merge)
        else:
            then_top = _span_max_leader(lines, h_idx + 1, else_idx, block_of)
            else_start = next_leader[then_top] if then_top is not None else next_leader[hb]
            # merge = the block past the ELSE body (which begins at else_start). An empty
            # else contributes no leader of its own, so fall back to else_start itself.
            else_top = _span_max_leader(lines, else_idx + 1, close_idx, block_of)
            if else_top is None:
                else_top = else_start
            merge = next_leader[else_top]
            header_edges[hb] = {then_true, else_start}
            _record_orient(orient, hb, _ifcond, then_true, else_start)
            # structure_lines stripped the then-body's trailing `goto L_merge`, so its
            # tail block must JUMP to the merge, not fall lexically into the else.
            if then_top is not None and then_top != hb:
                tail_redirect[then_top] = merge

    loop_meta = []   # (span, header_block, exit_block, frozenset(body_leaders)) per loop

    def first_real_block(lo, hi):
        """Block of the first block-occupying line in lines[lo:hi], else None."""
        for k in range(lo, hi):
            if _occupies_block(lines[k][2].strip()):
                return block_of(lines[k][0])
        return None

    def last_real_block(lo, hi):
        """Block of the last block-occupying line in lines[lo:hi], else None."""
        for k in range(hi - 1, lo - 1, -1):
            if _occupies_block(lines[k][2].strip()):
                return block_of(lines[k][0])
        return None

    def tail_falls_off(lo, hi):
        """True if the body's last statement can FALL off the bottom `}` (back to the
        loop top). An UNCONDITIONAL terminator (goto/return/break/continue, or a switch
        whose cases dispatch every path) cannot — its edge is already explicit, so the
        implicit body_tail->header back-edge must NOT be added (the menu-loop case: a
        tail `goto L_x` that targets a continue block would otherwise fabricate a
        spurious header edge). A conditional terminator (`if(C) goto/…`) or a plain
        statement DOES fall through, so the back-edge is kept."""
        for k in range(hi - 1, lo - 1, -1):
            t = lines[k][2].strip()
            if _is_scaffold(t):
                continue
            if _RE_SWITCH_CASE.match(t):
                return False
            cl, _ = _classify_stmt(t)
            return cl not in ('goto', 'return', 'break', 'continue')
        return True

    for header_addr, h_idx, close_idx in whiles:
        # POSITION-based (not next_leader): the loop emitter rotates the test to the
        # top, so the body's entry/tail are wherever the brace contents sit in the
        # listing — NOT necessarily the leader right after the header by address.
        #   while(C){body}: header -> { body_entry, exit }; body_tail -> header
        hb = block_of(header_addr)
        body_tail = last_real_block(h_idx + 1, close_idx)
        exit_blk = first_real_block(close_idx + 1, len(lines))
        if exit_blk is None:
            exit_blk = EXIT
        _wcond = _RE_WHILE_OPEN.match(lines[h_idx][2].strip())
        wcond = _wcond.group(1) if _wcond else ''
        if wcond == '1':
            # while(1) infinite loop: the opener adds NO condition edge — hb IS the loop
            # top, a normal body block (the switch / first statement) whose own edges the
            # per-block scan supplies. Register only the loop CONTEXT (break->exit,
            # continue->hb) and the fall-off back edge; hb stays in the body-leader set.
            bls = _loop_body_leaders(lines, h_idx, close_idx, block_of, leaders)
            if body_tail is not None and body_tail != hb and tail_falls_off(h_idx + 1, close_idx):
                back_edges.setdefault(body_tail, set()).add(hb)
                tail_fall_to_header[body_tail] = hb
            loop_meta.append((close_idx - h_idx, hb, exit_blk, frozenset(bls)))
            continue
        body_entry = first_real_block(h_idx + 1, close_idx)
        if body_entry is None:          # degenerate empty body: header just gates exit
            body_entry = exit_blk
        header_edges[hb] = {body_entry, exit_blk}
        _record_orient(orient, hb, wcond, body_entry, exit_blk)
        if body_tail is not None and body_tail != hb and tail_falls_off(h_idx + 1, close_idx):
            back_edges.setdefault(body_tail, set()).add(hb)   # body tail loops back
            tail_fall_to_header[body_tail] = hb
        # Body leaders (incl. label-only / folded ones): a rotated while hoists the
        # bottom test above the body, so any block OUTSIDE the loop whose address-next
        # leader lands INSIDE the body must instead enter via the header (the dropped
        # entry-guard `goto L_h` used to make that explicit). Recorded for the
        # fall-through fix below — keeps the address-based lowering otherwise intact.
        bls = _loop_body_leaders(lines, h_idx, close_idx, block_of, leaders)
        bls.discard(hb)
        while_bodies.append((hb, frozenset(bls)))
        loop_meta.append((close_idx - h_idx, hb, exit_blk, frozenset(bls)))

    for do_addr, _do_idx, close_addr, close_idx in dowhiles:
        # do { body } while (C);  — NO hoist (test stays at the bottom where it is).
        # The tail block (where the `} while(C);` test lives) branches back to the
        # header on continue, else falls to the block after the construct.
        hb = block_of(do_addr)
        ub = block_of(close_addr)
        exit_blk = first_real_block(close_idx + 1, len(lines))
        if exit_blk is None:
            exit_blk = EXIT
        dowhile_edges[ub] = {hb, exit_blk}
        _dcond = _RE_DOWHILE_CLOSE.match(lines[close_idx][2].strip())
        _record_orient(orient, ub, _dcond.group(1) if _dcond else '', hb, exit_blk)
        dbls = _loop_body_leaders(lines, _do_idx, close_idx, block_of, leaders)
        # KEEP the header block hb in the loop context (unlike the top-test `while`, whose
        # header is special-cased via header_edges). A two-test do-while puts its exit-test
        # `if (C) break;` INSIDE the header block; that block is lowered by the per-statement
        # scan, so it needs loop_ctx[hb] = (hb, exit) for the break to resolve to the loop
        # exit (else the header loses its exit edge -> CFG divergence). Harmless for plain
        # do-whiles (header has no break/continue) and for self-loops (hb == ub is special-
        # cased via dowhile_edges before the scan).
        loop_meta.append((close_idx - _do_idx, hb, exit_blk, frozenset(dbls)))

    # Map each body block to its INNERMOST enclosing loop (largest span first so the
    # smallest/innermost overwrites) — the context a `break`/`continue` resolves against:
    # break -> that loop's exit block, continue -> its header block.
    loop_ctx = {}
    for _span, hb_, exit_, bls_ in sorted(loop_meta, key=lambda m: -m[0]):
        for L in bls_:
            loop_ctx[L] = (hb_, exit_)

    blocks = {L: [] for L in leaders}
    for addr, _ind, text in lines:
        t = text.strip()
        if _is_scaffold(t):
            continue
        blocks[block_of(addr)].append(t)

    cfg = {}
    for L in leaders:
        if L in header_edges:
            cfg[L] = frozenset(header_edges[L] | back_edges.get(L, set()))
            continue
        if L in dowhile_edges:
            cfg[L] = frozenset(dowhile_edges[L] | back_edges.get(L, set()))
            continue
        succ = None
        sw_targets, sw_has_default, is_switch = set(), False, False
        # The block's fall-through (not-taken / no-terminator) edge: the loop header if L
        # is a body tail, else the address-next leader. (goto/jmp TARGETS are unaffected.)
        fall_thru = tail_fall_to_header.get(L, next_leader[L])
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
                succ = {block_of(tgt), fall_thru}
                mcnd = re.match(r'if \((.+)\) goto', t)
                _record_orient(orient, L, mcnd.group(1), block_of(tgt), fall_thru)
            elif cl in ('break', 'continue', 'ifbreak', 'ifcontinue'):
                ctx = loop_ctx.get(L)
                if ctx is not None:
                    hb_, exit_ = ctx
                    jmp = exit_ if cl in ('break', 'ifbreak') else hb_
                    if cl in ('break', 'continue'):
                        succ = {jmp}
                    else:
                        succ = {jmp, fall_thru}
                        kw = 'break' if cl == 'ifbreak' else 'continue'
                        mcnd = re.match(rf'if \((.+)\) {kw}', t)
                        _record_orient(orient, L, mcnd.group(1), jmp, fall_thru)
            elif cl == 'return':
                succ = {EXIT}
            elif cl == 'ifreturn':
                succ = {EXIT, fall_thru}
                mcnd = re.match(r'if \((.+)\) return', t)
                _record_orient(orient, L, mcnd.group(1), EXIT, fall_thru)
        if is_switch:
            succ = {block_of(x) for x in sw_targets}
            if not sw_has_default:
                succ.add(fall_thru)
        if succ is None:
            # fall-through: if-else then-tail -> merge, else the (tail-aware) fall — but a
            # block falling into a HOISTED while body must enter via the header (you can't
            # fall into the middle of a rotated loop).
            fall = tail_redirect.get(L)
            if fall is None:
                fall = fall_thru
                for hb2, bls in while_bodies:
                    if fall in bls and L not in bls and L != hb2:
                        fall = hb2
                        break
            succ = {fall}
        cfg[L] = frozenset(succ | back_edges.get(L, set()))
    return cfg


def observable_blocks(lines, leaders):
    """Leaders whose block contains an observable side-effect statement (a store /
    call / assignment — anything that is NOT pure control or scaffold). These blocks
    are PRESERVED by contract(); routing-only and bare-`return` blocks are not, so
    they get bypassed. (A `return` alone is intentionally not "observable" — that is
    exactly what lets a bare return block fold into its branch, the early-return idiom.)"""
    block_of = _block_of_fn(leaders)
    obs = set()
    for addr, _ind, text in lines:
        t = text.strip()
        if _is_scaffold(t) or _RE_SWITCH_CASE.match(t):
            continue
        cl, _tgt = _classify_stmt(t)
        if cl in ('goto', 'ifgoto', 'return', 'ifreturn',
                  'break', 'continue', 'ifbreak', 'ifcontinue'):
            continue
        obs.add(block_of(addr))     # a plain statement = real side effect
    return obs


def contract(cfg, observable, entry, orient=None):
    """Normalise a CFG by bypassing pure-routing blocks: any non-entry, non-observable
    block with a SINGLE successor (goto-only / empty fall-through / bare-`return`→EXIT)
    is removed and its predecessors rewired through it. Applied identically to both
    sides, this is the equivalence relation that ACCEPTS the behaviour-preserving folds
    structure_lines performs (early-return merges a return block; empty-arm if/else
    collapses a routing diamond) while still distinguishing any MISROUTE between
    observable (side-effecting) blocks. Returns the contracted CFG.

    If `orient` (a {cond_block: (taken, fall)} map of true/false edge labels) is given, it
    is rewired IN LOCKSTEP with the edges — each removed B->t bypass replaces B with t in
    every label too. Conditional blocks have 2 successors so are never themselves removed,
    so their labels survive and end up pointing at exactly the contracted graph's nodes.
    Doing this through contract() (not a separate resolver) is what keeps the orientation
    consistent with the contracted CFG on loop tails / mid-contraction self-loops."""
    g = {L: set(s) for L, s in cfg.items()}
    changed = True
    while changed:
        changed = False
        for B in list(g):
            if B is EXIT or B == entry or B in observable:
                continue
            succ = g.get(B)
            if succ is None or len(succ) != 1:
                continue
            (t,) = tuple(succ)
            if t == B:                          # self-loop: not a router
                continue
            for X in g:
                if B in g[X]:
                    g[X] = (g[X] - {B}) | {t}
            if orient is not None:
                for L, (tk, fl) in list(orient.items()):
                    if tk == B or fl == B:
                        orient[L] = (t if tk == B else tk, t if fl == B else fl)
            del g[B]
            changed = True
            break
    return {L: frozenset(s) for L, s in g.items()}


def structured_equivalent(raw_lines, struct_lines, leaders):
    """The structured-equivalence gate: True iff the STRUCTURED form has the
    same control flow as the RAW witness (= the bytecode, proven). Two checks:
      (1) contract()ed CFGs are equal — same routing between observable blocks; and
      (2) every conditional's TRUE/FALSE orientation agrees — so a then/else swap or a
          guard inversion (same two targets, wrong side) is caught, which the unlabelled
          edge SET in (1) would miss.
    Returns (ok, contracted_raw, contracted_struct) for reporting."""
    if not leaders:
        return True, {}, {}
    entry = leaders[0]
    or_raw, or_str = {}, {}
    cfg_raw = lower_goto_cfg(raw_lines, leaders, orient=or_raw)
    cfg_str = lower_struct_cfg(struct_lines, leaders, orient=or_str)
    n_raw = contract(cfg_raw, observable_blocks(raw_lines, leaders), entry, orient=or_raw)
    n_str = contract(cfg_str, observable_blocks(struct_lines, leaders), entry, orient=or_str)
    if n_raw != n_str:
        return False, n_raw, n_str
    # true/false edge-label check: contract() rewired each conditional's (taken, fall) to
    # the contracted graph's nodes; drop the vacuous (taken == fall) ones and compare. A
    # then/else swap or guard inversion shows up here as a true/false target mismatch.
    fo_raw = {L: tf for L, tf in or_raw.items() if tf[0] != tf[1]}
    fo_str = {L: tf for L, tf in or_str.items() if tf[0] != tf[1]}
    return fo_raw == fo_str, n_raw, n_str


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
    cc_str = lower_struct_cfg(captured['structured'], leaders)
    ok, n_raw, n_str = structured_equivalent(captured['raw'], captured['structured'], leaders)

    def show(name, cfg):
        print(f"\n{name}:")
        for L in sorted(cfg, key=lambda x: (x is EXIT, x)):
            succ = ", ".join(s if s is EXIT else f"${s:04X}" for s in sorted(
                cfg[L], key=lambda x: (x is EXIT, x)))
            print(f"  ${L:04X} -> {{{succ}}}")
    show("bytecode_cfg", bc)
    show("lower(raw)", cc_raw)
    show("lower(structured)", cc_str)
    show("contracted raw", n_raw)
    show("contracted structured", n_str)
    print(f"\nraw == bytecode:            {cc_raw == bc}")
    print(f"structured ~= raw (contract): {ok}")


if __name__ == "__main__":
    import sys
    if len(sys.argv) == 3:
        _selftest(int(sys.argv[1]), sys.argv[2])
    else:
        print("usage: py -3 tools/vm_cfg.py <bank> <sub_hex>   (CFG self-test for one sub)")

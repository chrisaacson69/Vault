"""
tools/probe-switch-shapes.py — classify every `switch` in the 4 code banks by whether
its case bodies form a CLEAN dispatch region (Phase-3 switch-body-inlining foldability).

A switch is CLEANLY INLINABLE iff, over the bytecode CFG:
  - the case-target blocks are pairwise distinct, and
  - each case region R_i (blocks reachable from target T_i, barriered at the merge M and
    at EXIT, not crossing the switch block S or another case target) is SINGLE-ENTRY: the
    only edge into R_i from outside is S -> T_i (no other block jumps into the middle of a
    case body — i.e. no shared tails / inter-case fall-through), and
  - regions are pairwise DISJOINT, and every region's only out-of-region successors are
    M (the common merge = immediate post-dominator of S) or EXIT.

Anything else (shared case tails, a case that falls into the default, a case body that is
also a jump target from elsewhere) stays as goto-cases — exactly Phase 3's "fall through
irregularly -> leave as goto-cases" guard.

Usage: py -3 tools/probe-switch-shapes.py [--banks 0,1,2,15] [--verbose]
"""
import argparse
import importlib.util
import io
import sys
import tempfile
from contextlib import redirect_stdout
from pathlib import Path

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))

import vm_cfg
from vm_cfg import EXIT, bytecode_cfg, _block_of_fn, dominators

_da_spec = importlib.util.spec_from_file_location("decompile_all", HERE / "decompile-all.py")
decompile_all = importlib.util.module_from_spec(_da_spec)
_da_spec.loader.exec_module(decompile_all)

CODE_BANKS = [0, 1, 2, 15]


def _predecessors(cfg):
    preds = {}
    for L, succ in cfg.items():
        for s in succ:
            if s is not EXIT:
                preds.setdefault(s, set()).add(L)
    return preds


def _post_dominators(cfg, exits):
    """Post-dominators: pdom(EXIT)={EXIT}; pdom(n) = {n} ∪ ∩ pdom(successors)."""
    nodes = set(cfg) | {EXIT}
    all_n = set(nodes)
    pdom = {n: set(all_n) for n in nodes}
    pdom[EXIT] = {EXIT}
    changed = True
    while changed:
        changed = False
        for n in cfg:
            succ = [s for s in cfg[n]]
            inter = set(all_n)
            for s in succ:
                inter &= pdom.get(s, {EXIT})
            new = {n} | inter
            if new != pdom[n]:
                pdom[n] = new
                changed = True
    return pdom


def _region(cfg, entry, barriers):
    """Blocks reachable forward from `entry`, stopping at any block in `barriers` and at
    EXIT (barriers themselves are NOT included)."""
    seen, stack = set(), [entry]
    while stack:
        b = stack.pop()
        if b is EXIT or b in barriers or b in seen:
            continue
        seen.add(b)
        for s in cfg.get(b, ()):
            if s is not EXIT and s not in barriers and s not in seen:
                stack.append(s)
    return seen


def classify_switch(cfg, leaders, S, case_tgts, has_default, fall, dom):
    """Classify a switch's foldability into a native C switch.

    Returns (tier, reason, info) where tier is:
      'goto'        — a case-target block is NOT dominated by the switch block S, i.e. it
                      is entered from OUTSIDE the switch (a jump elsewhere in the function
                      lands mid-case). NOT expressible as a C switch without a goto into the
                      body — stays goto-cases (the epic's sanctioned honest goto).
      'formalizable'— every case target is S-dominated => the whole dispatch region is
                      single-entry (only S enters it). The case BODIES can move INSIDE the
                      braces as a native C `switch` using fall-through + break (+ at most a
                      few internal gotos for non-adjacent edges). This is the real Phase-3
                      target — C switch is first-class, and fall-through expresses the
                      shared tails / ladders my earlier 'clean break' metric wrongly rejected.
      'clean'       — formalizable AND each case body is a separate block converging on one
                      merge with NO inter-case fall-through (the trivial pure-break subset).
    """
    block_of = _block_of_fn(leaders)
    case_blocks = sorted(set(block_of(t) for t in case_tgts))
    info = {'cases': case_blocks}

    # Single-entry test: is every case-target block dominated by S? If S dominates b, the
    # ONLY way into b is through S (no external jump into the case body). If any target is
    # not S-dominated, an outside edge enters it => not a C-switch without goto.
    external = [b for b in case_blocks if S not in dom.get(b, set())]
    if external:
        return 'goto', (f"case body ${external[0]:04X} entered from outside the switch "
                        f"(not S-dominated)"), info

    # Merge = immediate post-dominator of S.
    pdom = _post_dominators(cfg, {EXIT})
    cand = [b for b in pdom.get(S, set()) if b != S]
    M = None
    for b in cand:
        if all((b in pdom.get(c, {EXIT}) or c is EXIT or c == b) for c in cand):
            M = b
            break
    info['merge'] = M

    # Pure-break subset: case regions disjoint + each exits only to M/EXIT (no fall-through
    # between cases). Same as the old 'clean' metric — now just a sub-tier of formalizable.
    barriers = set(case_blocks) | {S}
    if M is not None and M is not EXIT:
        barriers.add(M)
    regions = {t: _region(cfg, t, barriers - {t}) for t in case_blocks}
    seen, disjoint = set(), True
    for t, R in regions.items():
        if R & seen:
            disjoint = False
            break
        seen |= R
    pure_break = disjoint
    if disjoint:
        for t, R in regions.items():
            for b in R:
                for s in cfg.get(b, ()):
                    if s is EXIT or s in R or (M is not None and s == M):
                        continue
                    pure_break = False
    info['regions'] = {t: sorted(R) for t, R in regions.items()}
    return ('clean' if pure_break else 'formalizable'), "single-entry dispatch", info


def run(banks, verbose=False):
    tiers = {'clean': [], 'formalizable': [], 'goto': []}
    with tempfile.TemporaryDirectory() as td:
        for bank in banks:
            results = {}

            def on_sub(stub, collect, _r=results):
                _r[stub] = collect

            buf = io.StringIO()
            with redirect_stdout(buf):
                decompile_all.bank_subs(bank, Path(td), on_sub=on_sub)

            for stub, collect in sorted(results.items()):
                instrs = collect['instructions']
                sw = [i for i in instrs if i['mnemonic'] == 'switch']
                if not sw:
                    continue
                cfg, leaders = bytecode_cfg(instrs)
                block_of = _block_of_fn(leaders)
                dom = dominators(cfg, leaders[0])
                for ins in sw:
                    S = block_of(ins['addr'])
                    tgts, has_default = vm_cfg._switch_targets(ins)
                    nxt = ins['addr'] + len(ins['bytes'])
                    fall = nxt if nxt in {x['addr'] for x in instrs} else EXIT
                    tier, reason, info = classify_switch(
                        cfg, leaders, S, sorted(tgts), has_default, fall, dom)
                    tiers[tier].append((bank, stub, ins['addr'], len(tgts), reason, info))

    n_clean, n_form, n_goto = len(tiers['clean']), len(tiers['formalizable']), len(tiers['goto'])
    total = n_clean + n_form + n_goto
    formalizable_total = n_clean + n_form
    print(f"\n{total} switch sites in banks {banks}:")
    print(f"  {formalizable_total} FORMALIZABLE as native C switch (bodies move inside the "
          f"braces; fall-through + break)")
    print(f"     of which {n_clean} are pure-break (trivial), {n_form} need fall-through / "
          f"internal goto")
    print(f"  {n_goto} stay goto-cases (a case body is entered from OUTSIDE the switch — "
          f"honest goto)\n")

    def _mfmt(m):
        return 'EXIT' if m is EXIT else ('?' if m is None else f'${m:04X}')
    for tier, title in (('clean', "PURE-BREAK (trivial, converge on merge)"),
                        ('formalizable', "FALL-THROUGH / INTERNAL-GOTO (the bulk of Phase 3)"),
                        ('goto', "STAY GOTO-CASES (entered from outside — irreducible)")):
        print(f"{title}:")
        for bank, stub, addr, ncase, reason, info in tiers[tier]:
            extra = f"  merge={_mfmt(info.get('merge'))}" if 'merge' in info else f"  — {reason}"
            print(f"  b{bank} sub ${stub:04X}  switch@${addr:04X}  {ncase} cases{extra}")
        print()
    return tiers


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--banks", default=",".join(map(str, CODE_BANKS)))
    ap.add_argument("--verbose", action="store_true")
    args = ap.parse_args()
    banks = [int(b, 0) for b in args.banks.split(",") if b.strip()]
    run(banks, args.verbose)


if __name__ == "__main__":
    main()

"""
tools/probe-residue-cause.py — decide atom 1 (terminal-dup) vs atom 2 (switch) by EVIDENCE.

The 57 behind-V1 subs carry 220 recoverable gotos. Two candidate atoms compete for the
work: (1) multi-statement TERMINAL-block duplication (the self_gate / $AD38 family — needs
the address-based gate to accept a duplicated terminal-ending block), and (2) the atom-4
SWITCH shared-exit fold (the 36-switch cluster). This probe classifies every remaining V2
goto in every behind-V1 sub by which atom would OWN it, so the lever is measured, not guessed.

Per goto `L_T` emitted from source block `s`:
  * SWITCH    — s or T belongs to a switch dispatch's territory (dispatch block or a case target)
  * TERMINAL  — T's block flows only to EXIT (ends in return/break): the dup family. Sub-split by
                whether T is SHARED (>=2 preds, needs DUPLICATION) vs single-pred (plain inline) and
                whether it's multi-statement (the part the 1-line guard inline can't already do).
  * OTHER     — a non-terminal shared continuation / loop-edge cut (neither atom owns it)

Usage:  py -3 tools/probe-residue-cause.py [--banks 0,1,2,15] [--detail]
"""
import argparse
import importlib.util
import io
import re
import sys
import tempfile
from collections import defaultdict
from contextlib import redirect_stdout
from pathlib import Path

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))

import vm_cfg
import vm_decompile
_da = importlib.util.spec_from_file_location("decompile_all", HERE / "decompile-all.py")
decompile_all = importlib.util.module_from_spec(_da)
_da.loader.exec_module(decompile_all)

CODE_BANKS = [0, 1, 2, 15]
_GOTO = re.compile(r'\bgoto L_([0-9A-Fa-f]{4});')


def _collect(banks, v2):
    saved = vm_decompile.STRUCTURE_V2
    vm_decompile.STRUCTURE_V2 = v2
    out = {}
    try:
        with tempfile.TemporaryDirectory() as td:
            for bank in banks:
                def on_sub(stub, collect, _bank=bank):
                    out[(_bank, stub)] = collect
                with redirect_stdout(io.StringIO()):
                    decompile_all.bank_subs(bank, Path(td), on_sub=on_sub)
    finally:
        vm_decompile.STRUCTURE_V2 = saved
    return out


def _goto_count(lines):
    return sum(1 for _a, _i, t in lines if _GOTO.search(t))


def sub_shape(instructions, raw_lines):
    """SHAPE flags for one sub, computed from its bytecode CFG (independent of whether V2
    flat-bailed — so a self_gate sub's cause is read from structure, not its raw goto dump):
      switch          — has >=1 switch dispatch (atom-2 reach)
      shared_terminal — has a multi-statement block flowing only to EXIT with >=2 preds
                        (the $AD38 tail-duplication target atom-1 needs; >=2 stmts is the part
                        the existing 1-line return-guard inline can't already collapse)
    Returns (flags:set, n_switch, n_shared_terminal_blocks)."""
    import vm_reduce
    cfg, leaders = vm_cfg.bytecode_cfg(instructions)
    if not leaders:
        return set(), 0, 0
    buckets = vm_reduce._partition(raw_lines, leaders)
    info = {L: vm_reduce._parse_block(buckets[L]) for L in leaders}
    preds = defaultdict(set)
    for u, ss in cfg.items():
        for s in ss:
            preds[s].add(u)
    n_switch = len(vm_cfg.switch_dispatches(instructions))
    shared_term = 0
    for L in leaders:
        if cfg.get(L) == frozenset({vm_cfg.EXIT}) and len(preds[L]) >= 2:
            stmts = info[L][0]                       # real block-occupying statements
            if len(stmts) >= 2:                      # multi-stmt -> needs DUPLICATION, not 1-line inline
                shared_term += 1
    flags = set()
    if n_switch:
        flags.add('switch')
    if shared_term:
        flags.add('shared_terminal')
    return flags, n_switch, shared_term


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--banks", default=",".join(map(str, CODE_BANKS)))
    ap.add_argument("--detail", action="store_true", help="per-sub family breakdown")
    args = ap.parse_args()
    banks = [int(b, 0) for b in args.banks.split(",") if b.strip()]

    v1 = _collect(banks, v2=False)
    v2 = _collect(banks, v2=True)

    behind = []
    for key in sorted(v1):
        v1g = _goto_count(v1[key]['structured'])
        v2g = _goto_count(v2[key].get('structured', v1[key]['raw']))
        if v2g > v1g:
            behind.append((key, v1g, v2g))

    # cross-tab the recoverable GAIN (v2-v1) by which atom(s) are RELEVANT to each sub's shape
    bucket_gain = defaultdict(int)
    bucket_subs = defaultdict(int)
    rows = []
    for (bank, stub), v1g, v2g in behind:
        c2 = v2[(bank, stub)]
        flags, n_sw, n_term = sub_shape(c2['instructions'], c2['raw'])
        gain = v2g - v1g
        if flags == {'switch'}:
            b = 'switch_only'
        elif flags == {'shared_terminal'}:
            b = 'terminal_only'
        elif flags == {'switch', 'shared_terminal'}:
            b = 'both'
        else:
            b = 'neither'
        bucket_gain[b] += gain
        bucket_subs[b] += 1
        rows.append((bank, stub, v1g, v2g, gain, b, n_sw, n_term))

    total_gain = sum(r[4] for r in rows)
    print(f"\nRESIDUE-CAUSE PROBE over {len(behind)} behind-V1 subs "
          f"({total_gain} recoverable gotos)\n")
    print("Which atom is RELEVANT to each behind sub (by CFG shape), gain = V2-V1 recoverable:")
    print(f"  {'relevant atom':<16}{'subs':>5}{'gain':>7}   reach")
    labels = {'switch_only': 'atom-2 only', 'terminal_only': 'atom-1 only',
              'both': 'atom-1 OR 2', 'neither': 'NEITHER (cross-edge/layout)'}
    for b in ('terminal_only', 'switch_only', 'both', 'neither'):
        print(f"  {b:<16}{bucket_subs[b]:>5}{bucket_gain[b]:>7}   {labels[b]}")
    print(f"  {'TOTAL':<16}{len(behind):>5}{total_gain:>7}")

    # marginal reach of each atom alone (a 'both' sub counts toward either)
    a1 = bucket_gain['terminal_only'] + bucket_gain['both']
    a1s = bucket_subs['terminal_only'] + bucket_subs['both']
    a2 = bucket_gain['switch_only'] + bucket_gain['both']
    a2s = bucket_subs['switch_only'] + bucket_subs['both']
    print(f"\n  atom-1 (terminal-dup) RELEVANT to {a1s} subs / up to {a1} recoverable gotos")
    print(f"  atom-2 (switch)       RELEVANT to {a2s} subs / up to {a2} recoverable gotos")
    print(f"  NEITHER atom (cross-edge / address-layout): "
          f"{bucket_subs['neither']} subs / {bucket_gain['neither']} gotos")

    if args.detail:
        print("\nper-sub (sorted by gain):")
        for bank, stub, v1g, v2g, gain, b, n_sw, n_term in sorted(rows, key=lambda r: -r[4]):
            print(f"  b{bank} ${stub:04X}  V1 {v1g:>2} V2 {v2g:>2} (+{gain:>2})  "
                  f"{b:<14} switch={n_sw} shared_term={n_term}")


if __name__ == "__main__":
    main()

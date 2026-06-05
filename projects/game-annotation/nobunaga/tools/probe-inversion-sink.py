"""
tools/probe-inversion-sink.py — classify each RESIDUE goto SINK vs NON-SINK.

The lowering-atlas cross-jump experiment (2026-06-05) proved a typical compiler cross-jumps
SINK suffixes only: the inverse (tail-duplication) is provably sound AND address-monotonic for a
sink, but a NON-SINK shared merge is not freely duplicable. So the question that decides the NA1
plan is: are the residue's `goto L_T` inversions SINK-targeted (=> the narrow sink-dup atom is the
whole game) or NON-SINK (=> a separate, harder problem)?

This probe walks every `goto L_T` line in the behind-V1 subs and classifies the TARGET block T by
its forward cone (computed from the bytecode CFG, independent of how V2 emitted it):

  loop     — the goto is a back-edge (T dominates the source block): a continue/loop latch, not a
             cross-jump artifact.
  sink     — T reaches EXIT and its WHOLE forward cone is dominated by T and acyclic: a private
             terminal cone. Duplicating it into each predecessor is sound + address-monotonic.
             == the compiler-proven reversible cross-jump inverse.
  nonsink  — T reaches EXIT but some block in the cone has a FOREIGN predecessor (not T-dominated)
             or the cone contains a loop: a non-terminal shared merge. Dup pushes the problem on.
  noexit   — T's cone doesn't cleanly reach EXIT (unusual; reported separately).

Usage:  py -3 tools/probe-inversion-sink.py [--banks 0,1,2,15] [--detail]
"""
import argparse
import bisect
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


def _reach(T, cfg):
    """Forward-reachable set from T (includes EXIT, excludes nothing)."""
    seen, work = {T}, [T]
    while work:
        n = work.pop()
        for s in cfg.get(n, ()):
            if s not in seen:
                seen.add(s)
                work.append(s)
    return seen


def classify(T, src_block, cfg, dom, be_targets):
    """Classify goto target T relative to its source block."""
    if T not in cfg:
        return 'other'
    # back-edge / loop latch: T dominates the source (the goto closes or re-enters a loop)
    if src_block is not None and T in dom.get(src_block, ()):
        return 'loop'
    reach = _reach(T, cfg)
    if vm_cfg.EXIT not in reach:
        return 'noexit'
    cone = reach - {vm_cfg.EXIT}
    # a loop inside the cone (a back-edge target sits in the cone) => not a free terminal cone
    if be_targets & cone - {T}:
        return 'nonsink'
    # SINK iff the whole terminal cone is privately dominated by T (no foreign predecessor merges in)
    if all(T in dom.get(B, ()) for B in cone):
        return 'sink'
    return 'nonsink'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--banks", default=",".join(map(str, CODE_BANKS)))
    ap.add_argument("--detail", action="store_true", help="per-sub goto breakdown")
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

    def classify_lines(lines, cfg, leaders, dom, be_targets):
        """Tally goto lines by target category; also split back/forward."""
        per = defaultdict(int)
        bf = defaultdict(lambda: defaultdict(int))
        for a, _i, t in lines:
            m = _GOTO.search(t)
            if not m:
                continue
            T = int(m.group(1), 16)
            j = bisect.bisect_right(leaders, a) - 1
            src_block = leaders[j] if j >= 0 else None
            c = classify(T, src_block, cfg, dom, be_targets)
            per[c] += 1
            bf[c]['back' if T <= a else 'fwd'] += 1
        return per, bf

    v2_cat = defaultdict(int)
    v1_cat = defaultdict(int)
    rec_cat = defaultdict(int)         # recoverable = max(0, v2-v1) per sub per category
    cat_subs = defaultdict(set)
    fwd_back = defaultdict(lambda: defaultdict(int))   # over V2
    rows = []
    for (bank, stub), v1g, v2g in behind:
        c2 = v2[(bank, stub)]
        cfg, leaders = vm_cfg.bytecode_cfg(c2['instructions'])
        if not leaders:
            continue
        entry = leaders[0]
        dom = vm_cfg.dominators(cfg, entry)
        be, _ = vm_cfg.back_edges(cfg, entry)
        be_targets = {h for _u, h in be}
        p2, bf2 = classify_lines(c2['structured'], cfg, leaders, dom, be_targets)
        p1, _ = classify_lines(v1[(bank, stub)]['structured'], cfg, leaders, dom, be_targets)
        for c, n in p2.items():
            v2_cat[c] += n
            cat_subs[c].add((bank, stub))
            for d in ('back', 'fwd'):
                fwd_back[c][d] += bf2[c][d]
        for c, n in p1.items():
            v1_cat[c] += n
        for c in set(p1) | set(p2):
            rec_cat[c] += max(0, p2[c] - p1[c])     # gotos V2 emits beyond V1 for this target class
        rows.append((bank, stub, v1g, v2g, dict(p2)))

    total = sum(v2_cat.values())
    print(f"\nINVERSION-SINK PROBE over {len(behind)} behind-V1 subs "
          f"({total} V2 goto lines; CFG-derived target classes)\n")
    print(f"  {'target cone':<10}{'V2':>5}{'V1':>5}{'recov':>7}{'subs':>6}{'back':>6}{'fwd':>5}"
          f"   meaning")
    meaning = {
        'sink':    'reversible by sink-dup (compiler-proven, narrow gate)',
        'nonsink': 'non-terminal shared merge (separate, harder)',
        'loop':    'loop latch / continue (not a cross-jump)',
        'noexit':  "cone doesn't reach EXIT cleanly",
        'other':   'target not a CFG leader',
    }
    for c in ('sink', 'nonsink', 'loop', 'noexit', 'other'):
        if v2_cat[c] or c in ('sink', 'nonsink'):
            print(f"  {c:<10}{v2_cat[c]:>5}{v1_cat[c]:>5}{rec_cat[c]:>7}{len(cat_subs[c]):>6}"
                  f"{fwd_back[c]['back']:>6}{fwd_back[c]['fwd']:>5}   {meaning[c]}")
    print(f"  {'TOTAL':<10}{total:>5}{sum(v1_cat.values()):>5}{sum(rec_cat.values()):>7}"
          f"{len(behind):>6}")

    rs, rn = rec_cat['sink'], rec_cat['nonsink']
    rcj = rs + rn
    if rcj:
        print(f"\n  RECOVERABLE merge gotos (V2 excess over V1): "
              f"{rs} SINK ({100*rs//rcj}%) vs {rn} non-sink ({100*rn//rcj}%).")
    print("  => sink-dominated recoverable => narrow sink-dup atom is the lever; "
          "non-sink-dominated => the residue is NOT mostly cross-jump.")

    if args.detail:
        print("\nper-sub (behind-V1, by gain):")
        for bank, stub, v1g, v2g, per in sorted(rows, key=lambda r: -(r[3] - r[2])):
            br = " ".join(f"{k}={v}" for k, v in sorted(per.items()))
            print(f"  b{bank} ${stub:04X}  V1 {v1g:>2} V2 {v2g:>2} (+{v2g-v1g:>2})  [{br}]")


if __name__ == "__main__":
    main()

"""
tools/probe-bail-audit.py — audit the region-reducer's bail guards (atom-log discipline).

The atom-3 lesson (2026-06-05): some `_NotReducible` bails in `vm_reduce` are GENUINE soundness
invariants; others were untested "the gate can't handle this" GUESSES that the gate actually CAN
handle. Because `reduce()` self-validates every output against the CFG-equivalence gate, suppressing
a guard is SAFE — a wrong guess shows up as a gate-reject / worse fold, a correct removal as a win.

This probe suppresses each AUDITABLE guard (one whose fall-through builds a CFG-validatable node —
NOT a semantic guard like `compound_pretest`, which the CFG gate can't police, nor a crash/loop-risk
guard like `cross_edge_top`) one at a time via `vm_reduce._AUDIT_SKIP`, and reports the corpus
goto delta + how many subs got WORSE. Read it as: Δ<0 with 0 worse = the guard is over-conservative
(remove or refine it); Δ>0 or subs-worse = the guard is genuine (the gate really does reject).

Usage:  py -3 tools/probe-bail-audit.py
"""
import io
import importlib.util
import re
import sys
import tempfile
from contextlib import redirect_stdout
from pathlib import Path

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
import vm_decompile
import vm_reduce

_da = importlib.util.spec_from_file_location("decompile_all", HERE / "decompile-all.py")
decompile_all = importlib.util.module_from_spec(_da)
_da.loader.exec_module(decompile_all)

_GOTO = re.compile(r'goto L_[0-9A-Fa-f]{4};')

# Guards whose fall-through builds a CFG-validatable node (so suppression is gate-safe). Keep this
# list in sync with the `_audit_bail('...')` call sites in vm_reduce.py.
AUDITABLE = ['goto_past_merge', 'empty_then', 'else_before_then', 'arm_order',
             'merge_not_adjacent', 'exit_is_dowhile_latch']


def _collect():
    vm_decompile.STRUCTURE_V2 = True
    out = {}
    with tempfile.TemporaryDirectory() as td:
        for b in [0, 1, 2, 15]:
            def on(s, c, _b=b):
                out[(_b, s)] = c
            with redirect_stdout(io.StringIO()):
                decompile_all.bank_subs(b, Path(td), on_sub=on)
    return {k: sum(1 for _a, _i, t in c['structured'] if _GOTO.search(t)) for k, c in out.items()}


def _measure(skip):
    vm_reduce._AUDIT_SKIP = set(skip)
    try:
        return _collect()
    finally:
        vm_reduce._AUDIT_SKIP = set()


def main():
    base = _measure([])
    btot = sum(base.values())
    print(f"baseline (no guard suppressed): {btot} gotos\n")
    print("%-24s %6s %7s %6s  %s" % ("guard suppressed", "gotos", "delta", "worse", "worse-subs"))
    for rs in AUDITABLE:
        r = _measure([rs])
        tot = sum(r.values())
        worse = [(k, base[k], r[k]) for k in base if r[k] > base[k]]
        ws = ', '.join('b%s$%04X:%d->%d' % (k[0], k[1], a, b) for k, a, b in worse[:4])
        print("%-24s %6d %+7d %6d  %s" % (rs, tot, tot - btot, len(worse), ws))


if __name__ == "__main__":
    main()

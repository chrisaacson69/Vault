"""
tools/v2-corpus.py — the REGION-REDUCER (V2) regression oracle (CFG epic).

Runs every sub through BOTH structurers and compares:
  * V1 = the template menagerie (structure_loops + structure_lines + structure_switches)
  * V2 = the region reducer (vm_reduce, behind vm_decompile.STRUCTURE_V2)

For each sub it categorises the V2 output (folded / honest-goto / gate-reject) and
diffs it against V1 — the metric that drives the build ladder: V2 must structure the
corpus AT LEAST as well as the templates (goto-count <= V1's on every sub) with every
gate green, then it can become the default and the templates get deleted.

This is wired at RUNG 0 (V2 = passthrough) so the oracle is proven BEFORE any rule can
introduce a bug. At rung 0 the expected picture is: V2 folds nothing (every sub ==
raw), V1 folds its ~277 subs, and the "behind V1" count = the number of subs V1 folds.
Each subsequent rung drives that count toward 0.

A V2 fold that breaks the CFG gate becomes a gated_fallback (honest goto), never a
crash — so "gate-reject" counts rule bugs to fix, it is not a hard failure here. The
HARD gate is tools/vm-cfg-gate.py (run it with STRUCTURE_V2 set to validate V2).

Usage:
  py -3 tools/v2-corpus.py [--banks 0,1,2,15]      # corpus summary + per-bank table
  py -3 tools/v2-corpus.py --behind                 # list the subs V2 is still behind V1 on
  py -3 tools/v2-corpus.py --sub 0xE76F [--bank 15] # side-by-side V1 vs V2 for one sub
"""
import argparse
import importlib.util
import io
import re
import sys
import tempfile
from contextlib import redirect_stdout
from pathlib import Path

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))

import vm_cfg
import vm_decompile
_da_spec = importlib.util.spec_from_file_location("decompile_all", HERE / "decompile-all.py")
decompile_all = importlib.util.module_from_spec(_da_spec)
_da_spec.loader.exec_module(decompile_all)

CODE_BANKS = [0, 1, 2, 15]
_GOTO = re.compile(r'\bgoto L_[0-9A-Fa-f]{4};')


def _goto_count(lines):
    return sum(1 for _a, _i, t in lines if _GOTO.search(t))


def _label_count(lines):
    return sum(1 for _a, _i, t in lines if vm_cfg._RE_LABEL.match(t.strip()))


def _collect(banks, v2):
    """Decompile every sub in `banks` with the V2 reducer (v2=True) or the V1 templates
    (v2=False). Returns {(bank, stub): collect}. Restores the flag after."""
    saved = vm_decompile.STRUCTURE_V2
    vm_decompile.STRUCTURE_V2 = v2
    out = {}
    try:
        with tempfile.TemporaryDirectory() as td:
            for bank in banks:
                def on_sub(stub, collect, _bank=bank):
                    out[(_bank, stub)] = collect
                buf = io.StringIO()
                with redirect_stdout(buf):
                    decompile_all.bank_subs(bank, Path(td), on_sub=on_sub)
    finally:
        vm_decompile.STRUCTURE_V2 = saved
    return out


def _render(lines):
    """Re-render a (addr, indent, text) line list to text (indent-only, no annotation —
    enough to eyeball structure in --sub mode)."""
    return "\n".join(f"{'    ' * ind}{t}" for _a, ind, t in lines)


def run(banks):
    v1 = _collect(banks, v2=False)
    v2 = _collect(banks, v2=True)

    rows = []                       # (bank, stub, raw_g, v1_g, v2_g, v2_state, behind)
    for key in sorted(v1):
        bank, stub = key
        c1, c2 = v1[key], v2.get(key, {})
        raw_g = _goto_count(c1['raw'])
        v1_g = _goto_count(c1['structured'])
        v2_g = _goto_count(c2.get('structured', c1['raw']))
        if c2.get('gated_fallback'):
            state = 'gate-reject'
        elif c2.get('structured') == c2.get('raw'):
            state = 'honest-goto'
        else:
            state = 'folded'
        behind = v2_g > v1_g        # V2 left more gotos than the templates did
        rows.append((bank, stub, raw_g, v1_g, v2_g, state, behind))

    n = len(rows)
    folded = sum(1 for r in rows if r[5] == 'folded')
    honest = sum(1 for r in rows if r[5] == 'honest-goto')
    reject = sum(1 for r in rows if r[5] == 'gate-reject')
    behind = [r for r in rows if r[6]]
    raw_tot = sum(r[2] for r in rows)
    v1_tot = sum(r[3] for r in rows)
    v2_tot = sum(r[4] for r in rows)
    v1_subs_folded = sum(1 for r in rows if r[3] < r[2])

    print(f"\nV2 region-reducer corpus over {n} subs in banks {banks}:\n")
    print(f"  V2 state:   folded {folded}   honest-goto {honest}   gate-reject {reject}")
    print(f"  goto total: raw {raw_tot}   V1(templates) {v1_tot}   V2(reducer) {v2_tot}")
    print(f"  V1 folds {v1_subs_folded} subs below raw; V2 folds {sum(1 for r in rows if r[4] < r[2])}")
    print(f"  BEHIND V1 (V2 left more gotos than templates): {len(behind)} subs"
          + ("  <- the build-ladder work-list (target 0)" if behind else "  — V2 >= templates everywhere"))

    # per-bank breakdown
    print("\n  bank   subs  folded  honest  reject   raw_g   V1_g   V2_g")
    for bank in banks:
        br = [r for r in rows if r[0] == bank]
        if not br:
            continue
        print(f"  {bank:>4}  {len(br):>5}  {sum(1 for r in br if r[5]=='folded'):>6}  "
              f"{sum(1 for r in br if r[5]=='honest-goto'):>6}  "
              f"{sum(1 for r in br if r[5]=='gate-reject'):>6}  "
              f"{sum(r[2] for r in br):>6}  {sum(r[3] for r in br):>5}  {sum(r[4] for r in br):>5}")
    return rows, behind


def show_behind(rows, behind):
    print(f"\n{len(behind)} subs where V2 is behind V1 (more gotos than the templates leave):")
    for bank, stub, raw_g, v1_g, v2_g, state, _b in sorted(behind, key=lambda r: r[3] - r[4]):
        print(f"  b{bank} ${stub:04X}   raw {raw_g:>3}  V1 {v1_g:>3}  V2 {v2_g:>3}   ({state})")


def show_sub(banks, target, bank_hint):
    bset = [bank_hint] if bank_hint is not None else banks
    v1 = _collect(bset, v2=False)
    v2 = _collect(bset, v2=True)
    key = next((k for k in v1 if k[1] == target), None)
    if key is None:
        print(f"sub ${target:04X} not found in banks {bset}")
        return
    bank, stub = key
    print(f"=== bank {bank} ${stub:04X} ===\n")
    print(f"--- V1 templates (gotos {_goto_count(v1[key]['structured'])}, "
          f"fallback={v1[key].get('gated_fallback')}) ---")
    print(_render(v1[key]['structured']))
    c2 = v2[key]
    print(f"\n--- V2 reducer (gotos {_goto_count(c2['structured'])}, "
          f"fallback={c2.get('gated_fallback')}) ---")
    print(_render(c2['structured']))


def main():
    ap = argparse.ArgumentParser(description="V2 region-reducer regression oracle")
    ap.add_argument("--banks", default=",".join(map(str, CODE_BANKS)))
    ap.add_argument("--behind", action="store_true", help="list the subs V2 is still behind V1 on")
    ap.add_argument("--sub", help="side-by-side V1 vs V2 for one sub (hex addr, e.g. 0xE76F)")
    ap.add_argument("--bank", type=int, help="restrict --sub lookup to this bank")
    args = ap.parse_args()
    banks = [int(b, 0) for b in args.banks.split(",") if b.strip()]
    if args.sub:
        show_sub(banks, int(args.sub, 0), args.bank)
        return
    rows, behind = run(banks)
    if args.behind:
        show_behind(rows, behind)


if __name__ == "__main__":
    main()

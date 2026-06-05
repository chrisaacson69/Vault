"""tools/probe-cfg-reducibility.py — the census that distinguishes IRREDUCIBLE control flow
from reducible-code-rendered-with-gotos (a missing inverse-lowering "atom").

WHY THIS EXISTS
  The V2 region-reducer epic spent sessions 7a-7g building local fallbacks for what it called
  "genuinely irreducible residue." This census tests that premise directly. A CFG is FORMALLY
  REDUCIBLE iff removing its dominator back-edges (edges u->h where h dominates u) leaves a DAG
  — i.e. every retreating edge is a natural back-edge, there are no multiple-entry loops. A
  reducible graph ALWAYS has a goto-free structured form; if V2 still emits gotos on it, the
  gotos mark a MISSING ATOM (an inverse-lowering we haven't written — e.g. branch-to-return =>
  `if (!c) return;`), NOT irreducibility.

  Result (2026-06-04): all 495 subs reducible, 0 irreducible; all 59 behind-V1 subs reducible.
  So the "irreducible residue" does not exist — the engine is structured-source-shaped and a
  complete bottom-up atom table decompiles it fully. See ../decompiler-bottom-up-thesis.md.

  Re-run as atoms land: a real atom moves SEVERAL subs out of "behind"; a 1-off moves one. That
  is the convergence gate for the bottom-up build.

USAGE
  py -3 tools/probe-cfg-reducibility.py            # census + behind-V1 cross-tab + test cases
"""
import importlib.util
import io
import re
import sys
import tempfile
from collections import deque
from contextlib import redirect_stdout
from pathlib import Path

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
import vm_cfg
import vm_decompile

_spec = importlib.util.spec_from_file_location("decompile_all", HERE / "decompile-all.py")
decompile_all = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(decompile_all)

BANKS = [0, 1, 2, 15]
_GOTO = re.compile(r'\bgoto L_[0-9A-Fa-f]{4};')


def _goto_count(lines):
    return sum(1 for _a, _i, t in lines if _GOTO.search(t))


def _is_acyclic(g):
    """Kahn topological peel — True iff the successor graph `g` (dict node->list) is a DAG."""
    indeg = {u: 0 for u in g}
    for u in g:
        for v in g[u]:
            if v in indeg:
                indeg[v] += 1
    q = deque(u for u in g if indeg[u] == 0)
    seen = 0
    while q:
        u = q.popleft(); seen += 1
        for v in g[u]:
            if v in indeg:
                indeg[v] -= 1
                if indeg[v] == 0:
                    q.append(v)
    return seen == len(g)


def is_reducible(cfg, leaders):
    """Reducible iff removing the dominator back-edges (h dominates u) leaves a DAG."""
    back = set(vm_cfg.back_edges(cfg, leaders[0])[0])
    g = {u: [v for v in cfg[u] if v is not vm_cfg.EXIT and (u, v) not in back] for u in cfg}
    return _is_acyclic(g)


def shared_return_preds(cfg):
    """Count return-blocks (EXIT among successors) with >1 predecessor — the guard-chain /
    early-return signature that top-down mislabels 'cross-edge' and bottom-up renders as a
    sequence of `if (!c) return;` guards. A rough fingerprint for that atom's cluster."""
    rets = {L for L in cfg if vm_cfg.EXIT in cfg[L]}
    preds = {L: 0 for L in cfg}
    for u in cfg:
        for v in cfg[u]:
            if v in preds:
                preds[v] += 1
    return sum(1 for r in rets if preds[r] > 1)


def _collect(v2):
    saved = vm_decompile.STRUCTURE_V2
    vm_decompile.STRUCTURE_V2 = v2
    out = {}
    try:
        with tempfile.TemporaryDirectory() as td:
            for bank in BANKS:
                with redirect_stdout(io.StringIO()):
                    decompile_all.bank_subs(
                        bank, Path(td),
                        on_sub=lambda s, c, _b=bank: out.__setitem__((_b, s), c))
    finally:
        vm_decompile.STRUCTURE_V2 = saved
    return out


def main():
    v1 = _collect(False)
    v2 = _collect(True)

    n_red = n_irr = 0
    behind = []
    for key in sorted(v1):
        bank, stub = key
        c1, c2 = v1[key], v2.get(key, {})
        cfg, leaders = vm_cfg.bytecode_cfg(c1['instructions'])
        red = is_reducible(cfg, leaders)
        n_red += red
        n_irr += (not red)
        v1g = _goto_count(c1['structured'])
        v2g = _goto_count(c2.get('structured', c1['raw']))
        if v2g > v1g:
            behind.append((bank, stub, v1g, v2g, red, shared_return_preds(cfg)))

    print(f"\nREDUCIBILITY CENSUS over {len(v1)} subs:")
    print(f"  reducible:   {n_red}  ({100 * n_red / len(v1):.1f}%)")
    print(f"  irreducible: {n_irr}  ({100 * n_irr / len(v1):.1f}%)"
          + ("" if n_irr else "   <- no irreducible control flow exists in the engine"))

    br = sum(1 for r in behind if r[4])
    print(f"\nBEHIND-V1: {len(behind)} subs"
          f"   reducible (missing-atom) {br}   irreducible (genuine residue) {len(behind) - br}")

    print("\nReducible-but-behind, by goto gap (where a missing atom costs most — test cases):")
    print(f"  {'sub':<12} {'V1':>4} {'V2':>4} {'gap':>4} {'shared-ret':>10}")
    for bank, stub, v1g, v2g, _red, srp in sorted(
            (r for r in behind if r[4]), key=lambda r: -(r[3] - r[2]))[:18]:
        print(f"  b{bank} ${stub:04X}   {v1g:>4} {v2g:>4} {v2g - v1g:>4} {srp:>10}")

    if len(behind) - br:
        print("\nIrreducible-and-behind (genuine residue — honest gotos are correct here):")
        for bank, stub, v1g, v2g, red, _srp in sorted(
                (r for r in behind if not r[4]), key=lambda r: -(r[3] - r[2])):
            print(f"  b{bank} ${stub:04X}   V1 {v1g:>3}  V2 {v2g:>3}  (gap {v2g - v1g})")


if __name__ == "__main__":
    main()

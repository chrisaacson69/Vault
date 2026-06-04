"""
tools/vm-cfg-gate.py — the CFG equivalence gate (control-flow structuring epic, Phase 0).

Runs the whole 4-bank codebase through two checks:

  (1) WITNESS FAITHFULNESS (hard gate, exit 1 on any failure):
      lower_c_to_cfg(RAW goto witness) == bytecode_cfg, for every sub.
      Proves `decompile-all.py --raw` emits a CFG-faithful round-trip witness — the
      reversibility guarantee. Also validates the bytecode CFG extractor on real data.
      Plus: no unrecognised control-shaped mnemonics slipped through.

  (2) STRUCTURED EQUIVALENCE (informational in Phase 0):
      lower_c_to_cfg(STRUCTURED) vs bytecode_cfg. Reports how many subs match exactly
      and characterises the residue. structure_lines already performs destructive folds
      (early-return merges a return block; empty-arm if/else collapses a diamond) that
      change the block partition while preserving behaviour — so the EXACT block gate is
      deliberately too strict here. The precise equivalence relation that licenses Phase 1+
      folds (contraction of pure-routing blocks, return-value-carrying EXIT edges,
      true/false edge labels to catch condition inversion) is the next decision to lock.

Usage:
  py -3 tools/vm-cfg-gate.py [--banks 0,1,2,15] [--verbose] [--show-structured]
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
_da_spec = importlib.util.spec_from_file_location("decompile_all", HERE / "decompile-all.py")
decompile_all = importlib.util.module_from_spec(_da_spec)
_da_spec.loader.exec_module(decompile_all)

CODE_BANKS = [0, 1, 2, 15]


def _fmt(cfg):
    parts = []
    for L in sorted(cfg, key=lambda x: (x is vm_cfg.EXIT, x)):
        succ = ",".join(s if s is vm_cfg.EXIT else f"${s:04X}"
                        for s in sorted(cfg[L], key=lambda x: (x is vm_cfg.EXIT, x)))
        parts.append(f"    ${L:04X} -> {{{succ}}}")
    return "\n".join(parts)


def run(banks, verbose=False, show_structured=False):
    raw_fail = []        # (bank, sub) where lower(raw) != bytecode  — the HARD gate
    struct_diff = []     # (bank, sub) where lower(structured) != bytecode — informational
    unknown_mn = []      # (bank, sub, addr, mnemonic) — unrecognised control op
    n_subs = 0

    with tempfile.TemporaryDirectory() as td:
        for bank in banks:
            results = {}

            def on_sub(stub, collect, _bank=bank, _results=results):
                _results[stub] = collect

            buf = io.StringIO()
            with redirect_stdout(buf):
                decompile_all.bank_subs(bank, Path(td), on_sub=on_sub)

            for stub, collect in sorted(results.items()):
                n_subs += 1
                instrs = collect['instructions']
                bc, leaders = vm_cfg.bytecode_cfg(instrs)
                for a, mn in vm_cfg.unknown_control_mnemonics(instrs):
                    unknown_mn.append((bank, stub, a, mn))
                cc_raw = vm_cfg.lower_goto_cfg(collect['raw'], leaders)
                cc_str = vm_cfg.lower_c_to_cfg(collect['structured'], leaders)
                if cc_raw != bc:
                    raw_fail.append((bank, stub))
                    if verbose:
                        print(f"\nRAW != bytecode  bank {bank} ${stub:04X}")
                        print("  bytecode:\n" + _fmt(bc))
                        print("  lower(raw):\n" + _fmt(cc_raw))
                if cc_str != bc:
                    struct_diff.append((bank, stub))
                    if show_structured:
                        print(f"\nSTRUCT != bytecode  bank {bank} ${stub:04X}")
                        print("  bytecode:\n" + _fmt(bc))
                        print("  lower(structured):\n" + _fmt(cc_str))

    print(f"\nCFG gate over {n_subs} subs in banks {banks}:")
    print(f"  (1) witness faithfulness  lower(raw) == bytecode : "
          f"{n_subs - len(raw_fail)}/{n_subs} pass"
          + ("" if not raw_fail else f"  — {len(raw_fail)} FAIL"))
    print(f"  (2) structured exact-match lower(struct) == bytecode: "
          f"{n_subs - len(struct_diff)}/{n_subs} exact "
          f"({len(struct_diff)} differ by destructive folds — informational)")
    if unknown_mn:
        print(f"  ! {len(unknown_mn)} unrecognised control mnemonic(s):")
        for bank, sub, a, mn in unknown_mn[:20]:
            print(f"      bank {bank} ${sub:04X} @ ${a:04X}: {mn}")

    hard_fail = bool(raw_fail) or bool(unknown_mn)
    if hard_fail:
        print("\nHARD GATE FAILED.")
        if raw_fail:
            print("  raw-witness CFG diverged from bytecode at: "
                  + ", ".join(f"b{b}/${s:04X}" for b, s in raw_fail[:20]))
        return 1
    print("\nHARD GATE CLEAN — the --raw witness is CFG-faithful to the bytecode "
          "across the whole codebase.")
    return 0


def main():
    ap = argparse.ArgumentParser(description="CFG equivalence gate (Phase 0)")
    ap.add_argument("--banks", default=",".join(map(str, CODE_BANKS)))
    ap.add_argument("--verbose", action="store_true", help="dump each raw-gate failure")
    ap.add_argument("--show-structured", action="store_true",
                    help="dump each structured/bytecode difference (informational)")
    args = ap.parse_args()
    banks = [int(b, 0) for b in args.banks.split(",") if b.strip()]
    sys.exit(run(banks, args.verbose, args.show_structured))


if __name__ == "__main__":
    main()

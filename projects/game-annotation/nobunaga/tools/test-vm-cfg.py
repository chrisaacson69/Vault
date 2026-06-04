"""
tools/test-vm-cfg.py — non-vacuousness tests for the CFG equivalence relation.

A gate that always says "equivalent" is worthless. These tests prove the relation
(vm_cfg.structured_equivalent / contract) actually REJECTS a control-flow change:
inject a misroute into a real sub's structured form and assert the gate flags it,
while the untouched form passes. Run: py -3 tools/test-vm-cfg.py
"""
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
_spec = importlib.util.spec_from_file_location("decompile_all", HERE / "decompile-all.py")
decompile_all = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(decompile_all)


def _grab(bank, sub):
    """Decompile one sub and return its collect dict (raw + structured + instructions)."""
    cap = {}
    with tempfile.TemporaryDirectory() as td:
        with redirect_stdout(io.StringIO()):
            decompile_all.bank_subs(bank, Path(td),
                                    on_sub=lambda s, c: cap.update(c) if s == sub else None)
    assert cap, f"sub ${sub:04X} not found in bank {bank}"
    return cap


def _retarget_one_goto(lines, leaders):
    """Return a copy of `lines` with the FIRST goto/if-goto retargeted to a different
    leader (a deliberate misroute), plus (old, new) for reporting. None if no goto."""
    leader_set = [L for L in leaders]
    for i, (addr, ind, text) in enumerate(lines):
        m = re.search(r'goto L_([0-9A-Fa-f]{4});', text)
        if not m:
            continue
        old = int(m.group(1), 16)
        new = next((L for L in leader_set if L != old), None)
        if new is None:
            continue
        mutated = list(lines)
        mutated[i] = (addr, ind, text.replace(f"L_{old:04X}", f"L_{new:04X}"))
        return mutated, old, new
    return None, None, None


def main():
    passed = failed = 0

    def check(name, cond):
        nonlocal passed, failed
        if cond:
            passed += 1
            print(f"  PASS  {name}")
        else:
            failed += 1
            print(f"  FAIL  {name}")

    # A couple of real subs that carry structure (if/else, loops).
    for bank, sub in [(1, 0x87F0), (0, 0xA778), (15, 0xCF98)]:
        cap = _grab(bank, sub)
        _bc, leaders = vm_cfg.bytecode_cfg(cap['instructions'])
        raw, struct = cap['raw'], cap['structured']

        # 1) The real (gated) structured form must be judged equivalent to the witness.
        ok, _, _ = vm_cfg.structured_equivalent(raw, struct, leaders)
        check(f"b{bank}/${sub:04X}: emitted structured ~= raw", ok)

        # 2) A deliberate misroute in the RAW form must be REJECTED (proves non-vacuous).
        mutated, old, new = _retarget_one_goto(raw, leaders)
        if mutated is not None:
            bad, _, _ = vm_cfg.structured_equivalent(raw, mutated, leaders)
            check(f"b{bank}/${sub:04X}: misroute L_{old:04X}->L_{new:04X} REJECTED", not bad)

        # 3) Identity must always pass (sanity that the relation isn't trivially false).
        same, _, _ = vm_cfg.structured_equivalent(raw, raw, leaders)
        check(f"b{bank}/${sub:04X}: raw ~= raw (identity)", same)

    # Phase 1 (loop folding): subs whose `structure_loops` emits a real `while`.
    # The gate must (a) accept the genuine fold and (b) reject a loop turned into a
    # non-loop — replacing `while (` with `if (` deletes the back edge, a CFG change
    # the contraction relation MUST catch (else loops could silently degrade to ifs).
    for bank, sub in [(0, 0x947A), (0, 0x9E9D), (0, 0xA742)]:
        cap = _grab(bank, sub)
        _bc, leaders = vm_cfg.bytecode_cfg(cap['instructions'])
        raw, struct = cap['raw'], cap['structured']
        has_while = any('while (' in t for _a, _i, t in struct)
        check(f"b{bank}/${sub:04X}: folded a while", has_while)

        ok, _, _ = vm_cfg.structured_equivalent(raw, struct, leaders)
        check(f"b{bank}/${sub:04X}: while fold ~= raw", ok)

        deloop = [(a, i, t.replace('while (', 'if (', 1)) for a, i, t in struct]
        bad, _, _ = vm_cfg.structured_equivalent(raw, deloop, leaders)
        check(f"b{bank}/${sub:04X}: while->if (back edge dropped) REJECTED", not bad)

    print(f"\n{passed} passed, {failed} failed")
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main()

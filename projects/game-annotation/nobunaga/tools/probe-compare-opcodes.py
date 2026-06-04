#!/usr/bin/env python3
"""Oracle validator for the VM compare opcodes ($C0-$C9) — the PRIMITIVE-LAYER guard
that the CFG / round-trip / drift gates structurally CANNOT catch.

Why a dedicated probe: a wrong compare DIRECTION (e.g. rendering `>=` where the handler
means `<`) changes neither the bytecode (round-trip is byte-identical) nor the control-flow
graph (the CFG gate's orientation labels flip CONSISTENTLY on both the raw and structured
forms, since both come from the same decompiler) — so every existing gate stays green while
the decompiled C lies about every threshold, loop bound and guard. The only ground truth is
the live ROM handler. This was real: C3/C5 had le<->ge swapped and C6/C9 had lt<->ge swapped,
rendering four comparisons backwards across the whole codebase ([[feedback_foundation_discipline_early]]).

What it does: drives each opcode through the REAL handler (`step_one_vm_op`) with a small
matrix of (regL, regR) pairs chosen to pin down BOTH the operator AND the signedness
(positive pair for direction; -1 vs 1 for signed-vs-unsigned), classifies the observed
truth vector against the 10 candidate predicates, and asserts it matches BOTH:
  (a) the decompiler's opcode->mnemonic map + _BINOP symbol/signedness, AND
  (b) vm-opcodes-v2.toml's SCMP*/UCMP* mnemonic.
Exit 1 on ANY disagreement, so it doubles as a regression guard (run it after touching the
compare map, the _BINOP table, or the toml).

Usage: py -3 tools/probe-compare-opcodes.py [-v]
"""
import argparse
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
from nobunaga_vm import NobunagaVM
import vm_decompile

FP, SP = 0x0500, 0x04C0

# (label, regL, regR). Chosen so the 10 candidate predicates all produce DISTINCT truth
# vectors: 3<6 / 6>3 / 6==6 fix the direction; (-1,1)/(1,-1) split signed from unsigned.
MATRIX = [("3<6", 3, 6), ("6>3", 6, 3), ("6==6", 6, 6), ("-1,1", 0xFFFF, 1), ("1,-1", 1, 0xFFFF)]


def _s(v):
    return v - 0x10000 if v >= 0x8000 else v


PREDS = {
    'eq':  lambda l, r: l == r,
    'ne':  lambda l, r: l != r,
    'slt': lambda l, r: _s(l) < _s(r),  'sle': lambda l, r: _s(l) <= _s(r),
    'sgt': lambda l, r: _s(l) > _s(r),  'sge': lambda l, r: _s(l) >= _s(r),
    'ult': lambda l, r: l < r,          'ule': lambda l, r: l <= r,
    'ugt': lambda l, r: l > r,          'uge': lambda l, r: l >= r,
}
# canonical: predicate key -> (decompiler mnemonic, C symbol, signedness, toml mnemonic)
CANON = {
    'eq':  ('cmp_eq', '==', 'none', 'CMPEQ'),  'ne': ('cmp_ne', '!=', 'none', 'CMPNE'),
    'slt': ('cmp_slt', '<', 'none', 'SCMPLT'), 'sle': ('cmp_sle', '<=', 'none', 'SCMPLE'),
    'sgt': ('cmp_sgt', '>', 'none', 'SCMPGT'), 'sge': ('cmp_sge', '>=', 'none', 'SCMPGE'),
    'ult': ('cmp_ult', '<', 'both', 'UCMPLT'), 'ule': ('cmp_ule', '<=', 'both', 'UCMPLE'),
    'ugt': ('cmp_ugt', '>', 'both', 'UCMPGT'), 'uge': ('cmp_uge', '>=', 'both', 'UCMPGE'),
}
OPS = range(0xC0, 0xCA)   # $C0-$C9 are the binary compares ($CA is is_zero, unary)


def _truth_vec(pred):
    return tuple(1 if PREDS[pred](l, r) else 0 for _, l, r in MATRIX)


def oracle(vm, op):
    """Run one compare opcode through the real handler for each matrix pair -> truth vector."""
    out = []
    for _, l, r in MATRIX:
        for a in range(0x0400, 0x0540):
            vm.mem.write(a, 0)
        vm.mem.write(0x0400, op)
        vm.vm_fp, vm.vm_sp = FP, SP
        vm.regL, vm.regR = l & 0xFFFF, r & 0xFFFF
        vm.vm_pc = 0x0400
        vm.vm_call_depth = 0
        vm.cpu.pc = vm.DISPATCHER_ADDR
        try:
            vm.step_one_vm_op(max_cpu_steps=4000)
        except Exception as ex:
            return None, f"exec_error:{type(ex).__name__}"
        out.append(1 if vm.regL else 0)
    return tuple(out), None


def _toml_mnemonics():
    """Best-effort parse of vm-opcodes-v2.toml: {opcode:int -> mnemonic:str}."""
    res = {}
    path = HERE / "vm-opcodes-v2.toml"
    if not path.exists():
        return res
    cur = None
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        s = line.strip()
        if s.startswith("[op_") and s.endswith("]"):
            try:
                cur = int(s[4:-1], 16)
            except ValueError:
                cur = None
        elif cur is not None and s.startswith("mnemonic"):
            res[cur] = s.split("=", 1)[1].strip().strip('"')
    return res


def main():
    ap = argparse.ArgumentParser(description="Oracle validator for VM compare opcodes")
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args()

    vm = NobunagaVM()
    vm.switch_bank(2)
    dec_map = vm_decompile.OPCODE_TO_MNEMONIC
    binop = vm_decompile._BINOP
    toml = _toml_mnemonics()
    # invert: truth vector -> predicate key (vectors are distinct by construction)
    vec2pred = {_truth_vec(p): p for p in PREDS}

    bad = 0
    print(f"Compare-opcode oracle check ($C0-$C9), {len(MATRIX)} probes each:")
    for op in OPS:
        vec, err = oracle(vm, op)
        if err:
            print(f"  ${op:02X}: ORACLE FAIL ({err})")
            bad += 1
            continue
        truth = vec2pred.get(vec)
        if truth is None:
            print(f"  ${op:02X}: {vec} -> NOT a recognized compare (unexpected)")
            bad += 1
            continue
        want_mn, want_sym, want_sign, want_toml = CANON[truth]
        got_mn = dec_map.get(op, "<none>")
        got_sym, got_sign = binop.get(got_mn, ("<?>", "<?>"))
        got_toml = toml.get(op, "<none>")
        ok_dec = (got_mn == want_mn and got_sym == want_sym and got_sign == want_sign)
        ok_toml = (got_toml == want_toml) if toml else True
        flag = "OK " if (ok_dec and ok_toml) else "BAD"
        if flag == "BAD":
            bad += 1
        if args.verbose or flag == "BAD":
            detail = f"oracle={truth}({want_sym}/{want_sign})  decompiler={got_mn}({got_sym}/{got_sign})"
            if toml:
                detail += f"  toml={got_toml}(want {want_toml})"
            print(f"  ${op:02X}: {flag}  {detail}")
    if not args.verbose and bad == 0:
        print("  all $C0-$C9 match the oracle (decompiler map + _BINOP + toml)")

    if bad:
        print(f"\nFAIL: {bad} compare opcode(s) disagree with the live ROM handler.")
        sys.exit(1)
    print("\nPASS: every compare opcode's rendered direction + signedness matches the oracle.")


if __name__ == "__main__":
    main()

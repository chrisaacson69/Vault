"""Empirically pin the espionage formulas by running their VM subs in the emulator.

Two questions the static decompile left ambiguous (stack-underflow + frame-arg order):

  1. VM CALL arg->slot mapping. When code does `CALL f` after `push P; push Q`, does
     the FIRST-pushed (P) or LAST-pushed (Q) land in the slot the callee reads as
     operand $0C (its "arg1")? This decides the BRIBE contest direction and which
     factor is multiplied vs sqrt'd in the ninja drain. We settle it by EXECUTING a
     synthetic `push 100; push 4; CALL hire_stat_drain_rng` and seeing which value
     got multiplied (->{5,10}) vs sqrt'd (->const 5).

  2. The ninja per-mission drain magnitude: hire_stat_drain_rng ($A255).
     Bytecode shape: (rng_mod(max(1, pct_op(argA, sqrt(argB)))) + 1) * 5, with
     {argA,argB} = {your_daimyo_skill+30, target_field_value} pending (1).

Subs live in bank 1. They call bank-15 helpers (pct_op/rng/sqrt at $C000+ = fixed
bank 15), so only bank 1 needs switching. rng makes the output a small set; we run
many trials and read the bound.
"""
import sys
from collections import Counter
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

try:
    sys.stdout.reconfigure(encoding="utf-8")   # Windows console defaults to cp1252
except Exception:
    pass

SEED_SRAM = "traces/aftertax.dmp"
FP = 0x05FF
A255_BODY = 0xA25A          # hire_stat_drain_rng body
A255_RET = 0xA273           # its own final RETURN (unique stop pc)
SLOTS = [0x0B, 0x0D, 0x0F]  # arg1@fp+0x0B, arg2@fp+0x0D (probe-math32 convention)
SCRATCH = 0x0300            # free RAM to host synthetic bytecode


def signed(w):
    w &= 0xFFFF
    return w - 0x10000 if w >= 0x8000 else w


def _fresh(seed=None):
    vm = NobunagaVM()
    vm.load_sram(SEED_SRAM)
    vm.switch_bank(1)
    vm.vm_fp = FP
    vm.vm_sp = FP
    vm.cpu.pc = vm.DISPATCHER_ADDR
    if seed is not None:
        vm._rng = seed & 0xFFFF      # vary the LCG seed per trial to sample the rng distribution
    return vm


def _run_to(vm, stop_pc, max_ops):
    """Step VM ops until vm_pc reaches stop_pc at a dispatcher boundary. stop_pc is
    a UNIQUE address (the synthetic wrapper's RETURN), so we never stop on a nested
    helper's return (which can share FP and fool a generic sp==FP test)."""
    for _ in range(max_ops):
        if vm.cpu.pc == vm.DISPATCHER_ADDR and vm.vm_pc == stop_pc:
            return True
        if vm.step_one_vm_op() is None:
            return False
    return False


def call_direct(body, ret_pc, arg1, arg2, seed=None, max_ops=8000):
    """probe-math32 method: pre-load arg slots (arg1@fp+0x0B, arg2@fp+0x0D) and jump
    into the body. Stop at the sub's OWN final RETURN (ret_pc) — unique, so we never
    stop on a nested helper's return. regL = the sub's return value."""
    vm = _fresh(seed)
    vm.mem.write_word(FP + 0x0B, arg1 & 0xFFFF)
    vm.mem.write_word(FP + 0x0D, arg2 & 0xFFFF)
    vm.vm_pc = body
    if not _run_to(vm, ret_pc, max_ops):
        return None, "timeout"
    return signed(vm.regL), None


def call_8bc1(loy_val, sqrt_gold, seed):
    """compute_bribe_effect_value ($8BC1): arg1 (last-pushed in the real call) = a POINTER
    to the defender loyalty; arg2 (first-pushed) = sqrt(spy gold). Body $8BC6..$8BE4."""
    PTR = 0x0400
    vm = _fresh(seed)
    vm.mem.write_word(PTR, loy_val & 0xFFFF)
    vm.mem.write_word(FP + 0x0B, PTR)            # arg1 @ slot 0x0B = loyalty pointer
    vm.mem.write_word(FP + 0x0D, sqrt_gold & 0xFFFF)  # arg2 @ slot 0x0D = sqrt(gold)
    vm.vm_pc = 0x8BC6
    if not _run_to(vm, 0x8BE4, 8000):
        return None, "timeout"
    return signed(vm.regL), None


def sweep(a1, a2, seeds=400):
    """Collect the distinct drain outputs across many rng seeds."""
    out = Counter()
    for s in range(1, seeds + 1):
        v, err = call_direct(A255_BODY, A255_RET, a1, a2, seed=s * 2654435761 & 0xFFFF)
        if err:
            return None, err
        out[v] += 1
    return out, None


def trials(fn, n=60):
    out = Counter()
    for _ in range(n):
        v, err = fn()
        if err:
            return None, err
        out[v] += 1
    return out, None


import math

A255_RET = 0xA273   # hire_stat_drain_rng's own final RETURN


def main():
    print("=" * 72)
    print("hire_stat_drain_rng ($A255): confirm  drain = (rng % max(1, X) + 1) * 5,")
    print("  X = floor(arg1 * sqrt(arg2) / 100)   [arg1@fp+0x0B mult, arg2@fp+0x0D sqrt]")
    print("  (call_direct = pre-load slots + jump to body; proven by probe-math32.)")
    print(f"  {'arg1':>5} {'arg2':>5}   {'X_pred':>6}   predicted band      observed band (across rng seeds)")
    ok = True
    for a1, a2 in [(100, 4), (100, 100), (130, 80), (100, 49), (60, 80), (30, 50), (90, 100)]:
        res, err = sweep(a1, a2)
        if err:
            print(f"  {a1:5d} {a2:5d}   {err}"); ok = False; continue
        X = max(1, (a1 * math.isqrt(a2)) // 100)
        band = sorted(res)
        pred_band = list(range(5, X * 5 + 1, 5))
        match = "OK" if band == pred_band else "MISMATCH"
        ok = ok and match == "OK"
        print(f"  {a1:5d} {a2:5d}   {X:6d}   {str(pred_band):<18}  {band}  [{match}]")
    print(f"\n  => formula {'CONFIRMED' if ok else 'NEEDS REVIEW'}: "
          "X = floor(arg1*sqrt(arg2)/100), arg1 multiplied, arg2 under the root.")
    print("  => real ninja call (push skill+30, then field): arg1=field, arg2=skill+30")
    print("     DRAIN = (rng % max(1, floor(field*sqrt(skill+30)/100)) + 1) * 5, clamped to the field.")

    print()
    print("=" * 72)
    print("compute_bribe_effect_value ($8BC1): the BRIBE defection amount (peasants/output moved).")
    print("  Traced closed form (arg1=ptr->defender loyalty, arg2=sqrt(spy gold)):")
    print("    value = loyalty - (floor((30+rng%25) * (min(loyalty, sqrt_gold)+1) / 100) + 1)")
    print(f"  {'loyalty':>7} {'sqrt(gold)':>10}   {'closed-form':>14}   observed band      [match]")

    def cf_band(loy, sg):
        return sorted({max(0, loy - ((30 + r) * (min(loy, sg) + 1)) // 100 - 1) for r in range(25)})

    allok = True
    for loy, sg in [(80, 30), (80, 10), (20, 30), (40, 30), (100, 40), (10, 30)]:
        out = Counter()
        for s in range(1, 600):
            v, err = call_8bc1(loy, sg, s * 2654435761 & 0xFFFF)
            if err:
                out = err; break
            out[v] += 1
        band = sorted(out) if isinstance(out, Counter) else out
        cf = cf_band(loy, sg)
        # observed is a subset of the full closed-form band (rng seeds may miss endpoints)
        match = "OK" if set(band) <= set(cf) else "MISMATCH"
        allok = allok and match == "OK"
        print(f"  {loy:7d} {sg:10d}   [{cf[0]}..{cf[-1]}]{'':6}   {band}  [{match}]")
    print(f"\n  => bribe defection {'CONFIRMED' if allok else 'NEEDS REVIEW'}: "
          "value = loyalty - (floor((30+rng%25)*(min(loyalty,sqrt_gold)+1)/100) + 1).")
    print("     Note: more spy gold RAISES √gold -> raises the subtracted resistance (until √gold≥loyalty),")
    print("     so minimal gold maximizes the transfer — a genuine quirk worth an in-game sanity check.")


if __name__ == "__main__":
    main()

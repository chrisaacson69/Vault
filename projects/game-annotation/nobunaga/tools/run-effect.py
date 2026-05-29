"""
Generic effect runner — point at any VM sub with a PRE SRAM dump, capture
helper host_call args, dump the post-state diff.

Usage:
    py -3 run-effect.py <effect> <sram_pre> [amount]
where <effect> is one of:
    grow      ($87F0, bank 1) — uses given gold_amount
    build     ($88A6, bank 1) — uses given gold_amount
    dam       ($87D8, bank 1) — uses given gold_amount
    give_a    ($A93A, bank 1) — variant A
    give_b    ($A95E, bank 1) — variant B
    give_c    ($A9D5, bank 1) — variant C
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

EFFECTS = {
    "grow":   {"entry": 0x87F0, "body": 0x87F5, "frame_off": -4, "bank": 1},
    "build":  {"entry": 0x88A6, "body": 0x88AB, "frame_off": -4, "bank": 1},
    "dam":    {"entry": 0x9B7E, "body": 0x9B83, "frame_off": -8, "bank": 1},   # driver_dam, not the sqrt helper
    "dam_helper": {"entry": 0x87D8, "body": 0x87DD, "frame_off": 0, "bank": 1},
    "give":   {"entry": 0xAA1F, "body": 0xAA24, "frame_off": -6, "bank": 1},   # driver_give (the real Give command)
    "give_a": {"entry": 0xA93A, "body": 0xA93F, "frame_off":  0, "bank": 1},  # validator wrapper
    "give_b": {"entry": 0xA95E, "body": 0xA963, "frame_off":  0, "bank": 1},
    "give_c": {"entry": 0xA9D5, "body": 0xA9DA, "frame_off":  0, "bank": 1},
}

WATCHED = {
    0xCBCD: ("sqrt_int",     1),
    0xD6B8: ("math32_3arg",  3),
    0xD6DE: ("math32_2arg",  2),
    0xD70D: ("pct_op",       2),
}

FIELDS = ["gold", "?", "town", "rice", "output", "dams",
          "loyalty", "wealth", "men", "morale", "skill", "arms", "header"]


def install_hook(vm, captured):
    """Patch step_one_vm_op to capture args to watched host_calls."""
    original = vm.step_one_vm_op
    def hook():
        if vm.cpu.pc == vm.DISPATCHER_ADDR:
            op = vm.mem.read(vm.vm_pc)
            if op == 0xE9:  # CALL_abs_imm1
                tgt = vm.mem.read_word(vm.vm_pc + 1)
                if tgt in WATCHED:
                    name, n = WATCHED[tgt]
                    sp = vm.vm_sp
                    raw = [vm.mem.read_word(sp + 2*i) for i in range(n)]
                    args = list(reversed(raw))  # arg1..argN order
                    captured.append((vm.vm_pc, name, args))
                    print(f"  ${vm.vm_pc:04X}  {name}({', '.join(str(a) for a in args)})")
        return original()
    vm.step_one_vm_op = hook


def read_fief_state(vm, sel):
    base = 0x7001 + sel * 26
    state = {}
    for i, f in enumerate(FIELDS):
        if f == "?": continue
        state[f] = vm.mem.read_word(base + i*2)
    return state


def run_effect(effect_name, sram_path, amount=100):
    cfg = EFFECTS[effect_name]
    vm = NobunagaVM()
    vm.load_sram(sram_path)
    sel = vm.mem.read(0x6F5F)
    base = 0x7001 + sel * 26
    pre = read_fief_state(vm, sel)
    print(f"=== {effect_name} on fief {sel} (record_ptr=${base:04X}) ===")
    print(f"Pre-state: {pre}")
    print(f"Amount: {amount}")
    print()

    captured = []
    install_hook(vm, captured)
    vm.switch_bank(cfg["bank"])
    vm.trace_enabled = True

    # Manual frame setup (bypass CALL prologue):
    fp = 0x05FF
    vm.vm_fp = fp
    vm.vm_sp = fp + cfg["frame_off"]  # allocate locals (negative frame_off)
    vm.mem.write_word(fp + 11, base)    # arg1 = record_ptr
    vm.mem.write_word(fp + 13, amount)  # arg2 = amount
    vm.vm_pc = cfg["body"]
    vm.cpu.pc = vm.DISPATCHER_ADDR

    print("host_calls captured:")
    try:
        vm.run_until_outermost_return(max_ops=500)
    except Exception as e:
        print(f"  (crash: {e})")

    post = read_fief_state(vm, sel)
    deltas = {f: post[f] - pre[f] for f in pre if post[f] != pre[f]}
    print(f"\nDeltas: {deltas}")
    print(f"regL (return value): {vm.regL}")
    print()


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return
    effect = sys.argv[1]
    sram = sys.argv[2]
    amount = int(sys.argv[3]) if len(sys.argv) > 3 else 100
    run_effect(effect, sram, amount)


if __name__ == "__main__":
    main()

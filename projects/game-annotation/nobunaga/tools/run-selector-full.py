"""Run the combat selector fully, with CF-depth tracking and host-call stubs."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM


def stub_returning(value):
    """Make a stub that just returns a fixed value."""
    def stub(vm):
        return value
    return stub


def main():
    vm = NobunagaVM()
    vm.load_sram("traces/b2-startbattle.dmp")
    vm.switch_bank(2)
    vm.vm_pc = 0x967A
    vm.cpu.pc = vm.DISPATCHER_ADDR
    vm.mem.write(0x7BE8, 0)  # clear combat-active flag

    # Install stubs for "UI noise" subs we don't want to actually execute.
    # Most return 0; some need specific behavior we'd add over time.
    UI_STUBS = {
        0xCC35: 0,   # marry_helper_cc35 — UI/dialog
        0xCC7B: 0,   # ui_helper_cc7b
        0xCEC4: 0,   # redraw_window
        0xCFD4: 0,   # ui_helper_cfd4
        0xD134: 0,   # ui_helper_d134 (printf)
        0xD77E: 0,   # ui_helper_d77e
        0xD7EA: 0,   # ui_helper_d7ea
        0xCA52: 5,   # rng_mod — return deterministic 5 for now (could be 0..arg-1)
        0xCB4C: 0,   # placeholder; we'll replace with proper abs() shortly
    }
    for addr, val in UI_STUBS.items():
        vm.install_stub(addr, stub_returning(val))

    # abs() — replace stub with real implementation
    def abs_stub(vm):
        # Argument is popped from VM stack; result in regL
        sp = vm.vm_sp
        # Top of descending stack: value at sp+1..sp+2
        lo = vm.mem.read((sp + 1) & 0xFFFF)
        hi = vm.mem.read((sp + 2) & 0xFFFF)
        val = lo | (hi << 8)
        if val >= 0x8000: val = 0x10000 - val  # abs of signed 16-bit
        # Caller will sp_adj=#$02 (already done by stub mechanism)
        return val
    vm.install_stub(0xCB4C, abs_stub)

    vm.trace_enabled = True
    print(f"Running selector $9675 (Hida v Shinano, atk={vm.mem.read(0x6F5F)}, def={vm.mem.read(0x6F63)})")
    print()

    ok = vm.run_until_outermost_return(max_ops=1000)
    print(f"Run {'completed' if ok else 'TIMED OUT'} (call_depth = {vm.vm_call_depth})")
    print()
    print("Last 40 trace lines:")
    for line in vm.trace_log[-40:]:
        print(line)
    print()
    print(f"FINAL: regL = ${vm.regL:04X} = {vm.regL}")
    print(f"  $6FF6 = ${vm.mem.read_word(0x6FF6):04X}")
    print(f"  $6FF8 = ${vm.mem.read_word(0x6FF8):04X}")
    print(f"  $6FFA = ${vm.mem.read_word(0x6FFA):04X}")
    print(f"  $6FFC = ${vm.mem.read_word(0x6FFC):04X}")
    print()
    print(f"Predicted (Hida v Shinano, A-dominates atk-wins-A branch):")
    print(f"  scratch tag $6FF6 = 7, return value = 4")


if __name__ == "__main__":
    main()

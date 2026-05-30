"""Run a battle-init / map routine in-VM and inspect the staging buffer + syscalls.

The kernel syscall layer now lives in nobunaga_vm (intercepts $F226, emulates the
simple syscalls, stubs PPU/audio/input, logs everything). This harness just drives
a sub through the real CALL mechanism (so the frame prologue runs) and reports.

NOTE (2026-05-30): $885E is the staging->PPU RENDER driver, NOT the ROM->SRAM
populator (it READS $7BFD and blits via syscall $14 ppu_blit_from_bank). The
routine that WRITES the staging buffer is still unfound — see ROADMAP step 2'.
This harness is the tool for testing candidates once found.

Usage: py probe-map-emit.py [sram.dmp] [entry_hex]
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM

ARGS = [a for a in sys.argv[1:] if not a.startswith("--")]
SRAM = ARGS[0] if ARGS else "traces/mino-save-ram.dmp"
ENTRY = int(ARGS[1], 16) if len(ARGS) > 1 else 0x885E
BANK = 2
BUF_LO, BUF_HI = 0x7B40, 0x7FFF
STUB_PC = 0x0300


def snapshot(vm, lo, hi):
    return bytes(vm.mem.read(a) for a in range(lo, hi + 1))


def main():
    vm = NobunagaVM()
    vm.load_sram(SRAM)
    vm.switch_bank(BANK)

    prov, mode = vm.mem.read(0x6F63), vm.mem.read(0x6FFE)
    print(f"Seed {Path(SRAM).name}: $6F63 (province)={prov}  $6FFE (mode)={mode}  entry=${ENTRY:04X}")

    original = snapshot(vm, BUF_LO, BUF_HI)
    nz = sum(1 for b in original if b)
    print(f"Staging buffer ${BUF_LO:04X}-${BUF_HI:04X}: {nz} nonzero bytes (target)")
    for a in range(BUF_LO, BUF_HI + 1):
        vm.mem.write(a, 0)

    # Inject `AC <entry> CF` and run via the real CALL mechanism (proper frame).
    vm.mem.write(STUB_PC, 0xAC)
    vm.mem.write(STUB_PC + 1, ENTRY & 0xFF)
    vm.mem.write(STUB_PC + 2, (ENTRY >> 8) & 0xFF)
    vm.mem.write(STUB_PC + 3, 0xCF)
    vm.vm_pc = STUB_PC
    vm.cpu.pc = vm.DISPATCHER_ADDR

    vm.mem.trace_writes = True
    print(f"\nRunning ${ENTRY:04X} (built-in syscall layer)...")
    try:
        ok = vm.run_until_outermost_return(max_ops=300000)
        print(f"  ok={ok}, regL=${vm.regL:04X}, vm_pc=${vm.vm_pc:04X}, depth={vm.vm_call_depth}")
    except Exception as e:
        print(f"  stopped: {e}  (CPU PC=${vm.cpu.pc:04X}, VM PC=${vm.vm_pc:04X})")

    # Syscall summary (counts by task), flagging any TODO ones that fired.
    from collections import Counter
    counts = Counter((t, n, k) for t, n, k in vm.syscall_log)
    print(f"\nSyscalls fired ({len(vm.syscall_log)} total):")
    for (t, n, k), c in sorted(counts.items()):
        flag = "  <-- TODO (unresolved)" if k == "TODO" else ""
        print(f"  ${t:02X} {n:<20} {k:<4} x{c}{flag}")

    new = snapshot(vm, BUF_LO, BUF_HI)
    match = sum(1 for o, n in zip(original, new) if o == n)
    repro = sum(1 for o, n in zip(original, new) if o == n and o != 0)
    print(f"\nBuffer reproduction: {match}/{len(original)} identical; {repro}/{nz} nonzero reproduced.")
    if repro == nz and nz:
        print("  EXACT MATCH on nonzero bytes — populator reproduced.")


if __name__ == "__main__":
    main()

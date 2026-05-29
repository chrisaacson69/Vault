"""Run effect_grow through the emulator, capture pct_op args."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM


def main():
    vm = NobunagaVM()
    vm.load_sram("traces/spring-1567-grow_PRE.dmp")

    # Identify which fief is selected
    sel = vm.mem.read(0x6F5F)
    print(f"Selected fief: ${sel:02X} ({sel})")
    print(f"Pre-state for fief {sel}:")
    base = 0x7001 + sel * 26
    fields = ["gold", "?", "town", "rice", "output", "dams",
              "loyalty", "wealth", "men", "morale", "skill", "arms", "header"]
    pre = {}
    for i, f in enumerate(fields):
        cpu = base + i*2
        val = vm.mem.read_word(cpu)
        pre[f] = val
        print(f"  {f:8} (${cpu:04X}) = {val}")
    print()

    # Now we need to call effect_grow with the right args.
    # Args: arg1 = record_ptr, arg2 = gold_amount
    # Let's test with several amounts to see how the drain scales
    record_ptr = base  # 0x7001 + sel*26
    amount = 100       # try with 100 gold

    # Watch list: addr -> (name, n_args)
    WATCHED = {
        0xCBCD: ("sqrt_int",     1),
        0xD6B8: ("math32_3arg",  3),
        0xD6DE: ("math32_2arg",  2),
        0xD70D: ("pct_op",       2),
    }
    captured_calls = []
    original_step = vm.step_one_vm_op

    def step_with_trace():
        # Peek at upcoming opcode
        if vm.cpu.pc == vm.DISPATCHER_ADDR:
            op = vm.mem.read(vm.vm_pc)
            if op == 0xE9:  # CALL_abs_imm1
                tgt = vm.mem.read(vm.vm_pc + 1) | (vm.mem.read(vm.vm_pc + 2) << 8)
                if tgt in WATCHED:
                    name, n_args = WATCHED[tgt]
                    # Args are on VM data stack. SP points to LSB of last (newest) item.
                    # Args were pushed in order arg1, arg2, arg3... so arg_N is at top.
                    sp = vm.vm_sp
                    args = []
                    for i in range(n_args):
                        # arg(n_args - i) is at sp + 2*i
                        # i.e., arg(n_args) at sp, arg(n_args-1) at sp+2, ...
                        a = sp + 2 * i
                        v = vm.mem.read(a & 0xFFFF) | (vm.mem.read((a + 1) & 0xFFFF) << 8)
                        args.append(v)
                    # args is now [arg_N, arg_N-1, ..., arg_1]; reverse to [arg_1, ..., arg_N]
                    args = list(reversed(args))
                    captured_calls.append((vm.vm_pc, name, args))
                    arg_str = ", ".join(f"${a:04X}({a})" for a in args)
                    print(f"  ${vm.vm_pc:04X} call {name}({arg_str})")
        return original_step()

    vm.step_one_vm_op = step_with_trace
    vm.switch_bank(1)
    vm.trace_enabled = True

    # We can't easily CALL effect_grow without going through its CALL prologue.
    # Easiest: simulate the caller by pushing args + jumping to the sub's CALL handler.
    # But that's complex. Instead, just set VM PC to inside effect_grow's body
    # AFTER its prologue, and arrange the frame so args are accessible.
    #
    # effect_grow at $87F0, body at $87F5, frame_off=-4 (2 word locals)
    # When called:
    #   - args pushed: arg1=record_ptr, arg2=amount
    #   - CALL pushes save state, FP = SP, SP -= 4 (alloc locals)
    #
    # We'll set up manually: FP=$05FF, push args at $05FB and $05FD,
    # set SP = $05FB - 4 = $05F7 (after locals), and run from body.

    fp = 0x05FF
    # Push arg1 (record_ptr) at FP-4 = 0x05FB (so frame[+11] = $05FB... no wait)
    # Actually frame layout: fp+11 = arg1. So arg1 stored at fp+11.
    # Hmm but that means we should set FP such that fp+11 points to arg1.
    # Easier: skip the prologue, just write args directly to expected addresses.
    #
    # For pct_op (the call we care about), arg1=fp+11, arg2=fp+13 within pct_op's frame.
    # When pct_op is called, the PUSH ones from effect_grow become its args.
    # The trace hook above captures them from the VM stack pre-call.
    # So we just need pct_op to RECEIVE args correctly, which works as long as
    # effect_grow does its PUSH ARG sequence correctly.
    #
    # To run effect_grow at $87F5 with correct frame setup, we need to:
    # 1. Allocate locals (frame_off=-4 → SP = FP - 4)
    # 2. Place args 'logically' at FP+11 and FP+13
    # 3. Set VM PC to body $87F5
    # Args at fp+11 = $05FF + 11 = $060A and $060C — but our SRAM goes to $07FF;
    # $060A is in RAM ($0000-$1FFF), accessible.

    vm.vm_fp = fp
    vm.vm_sp = fp - 4  # allocate 4 bytes of locals
    # Write arg1 (record_ptr) at fp+11 = 0x060A
    vm.mem.write_word(fp + 11, record_ptr)
    # Write arg2 (amount) at fp+13 = 0x060C
    vm.mem.write_word(fp + 13, amount)
    vm.vm_pc = 0x87F5
    vm.cpu.pc = vm.DISPATCHER_ADDR

    print(f"Running effect_grow(record_ptr=${record_ptr:04X}, amount={amount})...")
    print()
    try:
        ok = vm.run_until_outermost_return(max_ops=500)
    except Exception as e:
        print(f"\n(crash: {e} — saving partial trace)")
        ok = False
    print(f"\nRun: {ok}, regL = {vm.regL} (= return value = gain/2 per chapter notes)")
    print()
    # Show changed fields
    print("Post-state for fief, deltas:")
    for f in fields:
        if f == "?": continue
        idx = fields.index(f)
        cpu = base + idx*2
        post = vm.mem.read_word(cpu)
        delta = post - pre[f]
        if delta != 0:
            print(f"  {f:8}: {pre[f]} -> {post} (delta {delta:+d})")
    print()
    print(f"\nAll captured calls ({len(captured_calls)}):")
    for vmpc, name, args in captured_calls:
        arg_str = ", ".join(str(a) for a in args)
        print(f"  ${vmpc:04X}  {name}({arg_str})")

    # Save full opcode trace to file (too big for stdout)
    Path("traces/grow-trace.txt").write_text("\n".join(vm.trace_log))
    print(f"\nFull trace saved to traces/grow-trace.txt ({len(vm.trace_log)} ops)")
    # Show the bytecode around the second pct_op call (to see where '13' comes from)
    print("\nLast 30 trace lines (around the pct_op calls):")
    pct_idx = None
    for i, line in enumerate(vm.trace_log):
        if "CALL_abs_imm1 $D70D" in line or "8854" in line[:8]:
            pct_idx = i
            break
    if pct_idx:
        start = max(0, pct_idx - 25)
        for line in vm.trace_log[start:pct_idx + 5]:
            print(line)


if __name__ == "__main__":
    main()

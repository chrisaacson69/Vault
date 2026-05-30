"""
driver-call-index.py — for each lord-command driver in bank 1, list every
host_call target reached on a flow-walk of the driver's body. The output
is the "what each driver actually calls" map that drives the per-command
effect-formula decode pass.

Reads disasm/bank_01_vm.asm (produced by `vm-disasm.py --dump-bank 1 ...`)
and parses it; no ROM access needed.

A target is classified as:
    EFFECT    bank-1 bytecode sub, used by only this driver
    SHARED    bank-1 bytecode sub, used by 2+ drivers (UI / diplomacy / etc.)
    BANK15    target in $C000-$FFFF (kernel / native)
    OTHER     target outside bank 1 or unresolved
"""

import re
from collections import defaultdict
from pathlib import Path

PROJ = Path(__file__).resolve().parent.parent      # project root (works from any CWD)
DUMP = PROJ / "disasm/bank_01_vm.asm"
TABLE = PROJ / "command-table.txt"

SUB_HEADER_RE = re.compile(r"; sub \$([0-9A-F]{4})")
INSN_RE = re.compile(r"^ [> ]\$([0-9A-F]{4})  ")
HOST_CALL_RE = re.compile(r"host_call(?:_simple)?\s+\$([0-9A-F]{4})")

# Parse the command table for driver -> command-name mapping.
DRIVER_NAMES = {}
for line in TABLE.read_text().splitlines():
    m = re.match(r"\s*\d+\s+\d+\s+(\S+)\s+\$([0-9A-F]{4})", line)
    if m:
        DRIVER_NAMES[m.group(2)] = m.group(1)


def parse_subs(text):
    """Return {sub_addr_hex: [(insn_addr_hex, line)]} for every sub."""
    subs = {}
    cur = None
    for line in text.splitlines():
        h = SUB_HEADER_RE.match(line)
        if h:
            cur = h.group(1)
            subs[cur] = []
            continue
        i = INSN_RE.match(line)
        if i and cur is not None:
            subs[cur].append((i.group(1), line))
    return subs


def host_calls(insns):
    """Outbound host_call target addresses (as hex strings, in encounter order)."""
    out = []
    for _, line in insns:
        m = HOST_CALL_RE.search(line)
        if m:
            out.append(m.group(1))
    return out


def classify(target_hex, sub_addrs, call_counts):
    v = int(target_hex, 16)
    if v >= 0xC000:
        return "BANK15"
    if 0x8000 <= v <= 0xBFFF:
        if target_hex in sub_addrs:
            return "SHARED" if call_counts[target_hex] >= 2 else "EFFECT"
        return "OTHER"
    return "OTHER"


def main():
    text = DUMP.read_text(encoding="utf-8")
    subs = parse_subs(text)
    sub_addrs = set(subs)

    # Count how many drivers call each bank-1 sub (for SHARED detection).
    driver_addrs = list(DRIVER_NAMES)
    call_counts = defaultdict(int)
    for drv in driver_addrs:
        if drv not in subs:
            continue
        for tgt in set(host_calls(subs[drv])):
            call_counts[tgt] += 1

    print("Driver -> outbound host_call map (bank 1)")
    print("=" * 78)
    for drv in driver_addrs:
        name = DRIVER_NAMES[drv]
        insns = subs.get(drv, [])
        calls = host_calls(insns)
        uniq = []
        seen = set()
        for c in calls:
            if c not in seen:
                seen.add(c)
                uniq.append(c)
        print(f"\n${drv}  {name:14s}  ({len(insns)} insns, "
              f"{len(calls)} host_calls, {len(uniq)} unique)")
        for tgt in uniq:
            cls = classify(tgt, sub_addrs, call_counts)
            shared_note = ""
            if cls == "SHARED":
                shared_note = f" (used by {call_counts[tgt]} drivers)"
            print(f"    -> ${tgt}  [{cls}]{shared_note}")

    print()
    print("=" * 78)
    print("EFFECT handlers (each called by exactly one driver):")
    effects = []
    for tgt, n in sorted(call_counts.items()):
        if n == 1 and tgt in sub_addrs and not any(tgt == d for d in driver_addrs):
            for drv in driver_addrs:
                if tgt in host_calls(subs.get(drv, [])):
                    effects.append((drv, DRIVER_NAMES[drv], tgt))
                    break
    for drv, name, tgt in effects:
        print(f"  ${tgt}  <- ${drv} {name}")
    print(f"\nTotal candidate effect handlers: {len(effects)}")

    print()
    print("SHARED helpers (2+ drivers):")
    for tgt, n in sorted(call_counts.items(), key=lambda x: -x[1]):
        if n >= 2:
            print(f"  ${tgt}  used by {n} drivers")


if __name__ == "__main__":
    main()

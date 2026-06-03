#!/usr/bin/env py -3
"""var-walk-prep.py — assemble the NEXT var-walk batch's Workflow args, deterministically.

The variable-side twin of label-walk-prep.py. label-walk names anonymous SUBS; var-walk
names the positional frame SLOTS (arg1..arg4 / local0..local11) of subs we ALREADY understand,
turning `effect_grow(arg1, arg2)` / `local11` into `effect_grow(fief, amount)` / `gain`.

Target selection (why it differs from label-walk):
  - Targets are NAMED subs (real functional name, not sub_XXXX/helper_XXXX) — role-inference
    needs to know what the function DOES. Anon subs are skipped (name them with /label-walk first).
  - ...that still carry ≥1 POSITIONAL slot (arg/local) in the decompiled C, and
  - ...have NO `[vars.bankN."0xADDR"]` section yet (one section per sub = "processed once",
    even when some slots are intentionally left positional as scratch — same once-through model
    as label-walk's anon->named).
Re-running after each committed batch returns the next un-done named subs, so "first K" walks
the whole bank with no manual cursor (naming a sub adds its [vars.*] section -> it drops out).

Order: leaves-first (cluster-anon-subs.callgraph_order) so a caller is var-named when its callees
already are (caller-propagation reads the expression each caller pushes into a slot).

Emits:  { bank, subs: [{addr, name, slots:[...]}], seeds: "<vocabulary>" }
Print modes: --json emits ONLY the args object (pipe into the Workflow); default = human summary
+ remaining-named count (0 => the bank's named subs are all var-walked).

Usage:
  py -3 tools/var-walk-prep.py <bank> [--batch N] [--landmarks "text"] [--json]
"""
import argparse
import json
import re
from importlib import import_module
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TOML = ROOT / "mesen-labels.toml"
_cluster = import_module("cluster-anon-subs")

# Every sub (named or anon) emits a "// (body @ $XXXX)" line; a NAMED sub additionally
# has a "// $STUB name" line directly above it. We slice the .c on the body markers, then
# read the line above each to recover (stub addr, name) — anon subs (no such line) are skipped.
BODY_RE = re.compile(r'^// \(body @ \$[0-9A-Fa-f]{4}\)', re.M)
NAMED_HDR_RE = re.compile(r'^// \$([0-9A-Fa-f]{4}) (\S.*)$')
SLOT_RE = re.compile(r'\b(arg[1-4]|local\d+)\b')
ANON_RE = re.compile(r'^(?:sub|helper)_[0-9A-Fa-f]+$')


def _slot_key(s):
    return (0 if s.startswith("arg") else 1, int(re.search(r'\d+', s).group()))


def parse_named_subs(bank):
    """[{addr, name, slots}] for every NAMED sub in bank_NN.c that still has positional slots."""
    text = (ROOT / "decompiled" / f"bank_{bank:02d}.c").read_text(encoding="utf-8")
    starts = [m.start() for m in BODY_RE.finditer(text)]
    out = []
    for i, s in enumerate(starts):
        end = starts[i + 1] if i + 1 < len(starts) else len(text)
        chunk = text[s:end]
        line_start = text.rfind("\n", 0, s - 1) + 1     # start of the line above the body marker
        m = NAMED_HDR_RE.match(text[line_start:s].strip())
        if not m:
            continue                                     # anon sub — no name header
        addr, name = m.group(1).upper(), m.group(2).strip()
        if ANON_RE.match(name):
            continue
        slots = sorted(set(SLOT_RE.findall(chunk)), key=_slot_key)
        if slots:
            out.append({"addr": addr, "name": name, "slots": slots})
    return out


def done_addrs(bank):
    """Stub addrs that already have a [vars.bankN."0xADDR"] section (processed)."""
    text = TOML.read_text(encoding="utf-8")
    return {m.group(1).upper()
            for m in re.finditer(rf'\[vars\.bank{bank}\."0x([0-9A-Fa-f]+)"\]', text)}


DEFAULT_SEEDS = (
    "ROLE-INFERENCE VOCABULARY (name a slot by what it HOLDS, not its number):\n"
    "- A slot dereferenced as `slot->output`/`->loyalty`/`->men`/`->header` etc. is a PROVINCE "
    "RECORD pointer -> name it `fief` (or `donor`/`target` if the sub clearly distinguishes two). "
    "Province record: gold@+0,debt@+2,town@+4,rice@+6,output@+8,dams@+10,loyalty@+12,wealth@+14,"
    "men@+16,morale@+18,skill@+20,arms@+22,header@+24 (16-bit LE, $7001+idx*26).\n"
    "- `daimyo_record_ptr(slot)` arg or `slot->age`/`->health` -> daimyo index/record (`daimyo`).\n"
    "- `pct_op(base, slot)` 2nd arg is a PERCENT; `pct_op(slot, p)` 1st is the base being scaled.\n"
    "- `math32_3arg(a,b,c)=floor(ab/c)`, `math32_2arg(a,b)=floor(100a/(a+b))`, `sqrt_int(x)`, "
    "`rng_mod(max)` -> name args by their formula role (amount, rate, divisor, ...).\n"
    "- A slot used as a loop bound/index (`while (slot < N)`, `arr[slot]`) -> `i`/`idx`/`count`.\n"
    "- A slot that ACCUMULATES (`slot = slot + x` across iterations) -> `total`/`sum`/`gain`.\n"
    "CONSERVATISM RULE (non-negotiable): name a slot ONLY if it has ONE coherent role across the "
    "whole sub. A slot REUSED for two disjoint things (e.g. headroom, THEN a drain%) must be LEFT "
    "POSITIONAL (verdict REFUTED) — that is the honest 'this is scratch' signal, not a failure."
)


def main():
    ap = argparse.ArgumentParser(description="Assemble the next var-walk batch's Workflow args.")
    ap.add_argument("bank", type=lambda x: int(x, 0))
    ap.add_argument("--batch", type=int, default=8, help="named subs per batch (default 8)")
    ap.add_argument("--landmarks", default="", help="bank-specific context prepended to seeds")
    ap.add_argument("--json", action="store_true", help="emit ONLY the {bank,subs,seeds} args object")
    a = ap.parse_args()

    named = parse_named_subs(a.bank)
    done = done_addrs(a.bank)
    targets = [s for s in named if s["addr"] not in done]
    remaining = len(targets)
    if remaining == 0:
        if a.json:
            print(json.dumps({"bank": a.bank, "subs": [], "seeds": "", "done": True}))
        else:
            print(f"bank_{a.bank:02d}: 0 named subs with un-walked slots — VAR-WALK COMPLETE for this bank.")
        return

    ordered_addrs = _cluster.callgraph_order(a.bank, [int(s["addr"], 16) for s in targets])
    by_addr = {s["addr"]: s for s in targets}
    ordered = [by_addr[f"{a_:04X}"] for a_ in ordered_addrs if f"{a_:04X}" in by_addr]
    batch = ordered[:a.batch]

    seeds = (a.landmarks.strip() + "\n\n" if a.landmarks else "") + DEFAULT_SEEDS
    args_obj = {"bank": a.bank, "subs": batch, "seeds": seeds}
    if a.json:
        print(json.dumps(args_obj))
        return

    print(f"bank_{a.bank:02d}: {remaining} named subs with un-walked slots "
          f"({len(named) - remaining} already done); this batch = {len(batch)}:")
    for s in batch:
        print(f"  ${s['addr']} {s['name']:<34} slots: {' '.join(s['slots'])}")
    print(f"\nRun:  py -3 tools/var-walk-prep.py {a.bank} --batch {a.batch}"
          + (' --landmarks "..."' if a.landmarks else "") + " --json   then pass to the var-walk Workflow.")


if __name__ == "__main__":
    main()

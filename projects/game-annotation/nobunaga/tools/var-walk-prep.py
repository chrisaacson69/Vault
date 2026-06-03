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
# Far-frame spill locals the disassembler renders raw: *(word|byte*)(fp ± N) / (fp ± N).
FAR_RE = re.compile(r'\*\((?:word|byte)\*\)\(fp ([+-]) (\d+)\)|\(fp ([+-]) (\d+)\)')


def _slot_key(s):
    return (0 if s.startswith("arg") else 1, int(re.search(r'\d+', s).group()))


def far_slots(chunk):
    """Sorted far-frame spill-local keys (`fp-38`) in a sub body — NEGATIVE offsets only.
    In this VM locals grow DOWNWARD from fp (the 12 standard slots are fp-24..fp-2), so every
    POSITIVE offset is an arg (arg1=fp+11, arg2=+13, …, arg5=+19, …, via the general opcode) or
    frame-header, NOT a spill local — those are handled by the arg system / the arg-render fix
    ticket, never named as far keys here."""
    keys = set()
    for m in FAR_RE.finditer(chunk):
        sign, num = (m.group(1), m.group(2)) if m.group(1) else (m.group(3), m.group(4))
        if sign == "-":
            keys.add(f"fp-{num}")
    return sorted(keys, key=lambda k: int(k[2:]))


def recorded_slots(bank):
    """{addr: {slot keys already recorded}} from the toml [vars.bankN.*] sections — named
    (`slot = {`/`"fp-N" = {`) OR left-positional (`# slot left positional`). For --far's
    per-SLOT done-tracking: a sub WITH a section is still a target if it has new far slots."""
    text = TOML.read_text(encoding="utf-8")
    sec_re = re.compile(rf'\[vars\.bank{bank}\."0x([0-9A-Fa-f]+)"\]')
    key_re = re.compile(r'^\s*(?:"(fp[+-]\d+)"|(arg[1-4]|local\d+))\s*=')
    pos_re = re.compile(r'^\s*#\s*((?:fp[+-]\d+)|arg[1-4]|local\d+)\s+left positional')
    out, cur = {}, None
    for line in text.splitlines():
        m = sec_re.search(line)
        if m:
            cur = m.group(1).upper(); out.setdefault(cur, set()); continue
        if line.lstrip().startswith("[") and "vars.bank" not in line:
            cur = None; continue
        if cur is None:
            continue
        km = key_re.match(line)
        if km:
            out[cur].add(km.group(1) or km.group(2)); continue
        pm = pos_re.match(line)
        if pm:
            out[cur].add(pm.group(1))
    return out


def parse_named_subs(bank, far=False, recorded=None):
    """[{addr, name, slots}] for every NAMED sub in bank_NN.c with un-done slots.
    far=False -> positional slots (arg/localN). far=True -> far-frame slots (fp±N)
    minus those already recorded in the sub's [vars.*] section (`recorded`)."""
    recorded = recorded or {}
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
        if far:
            slots = [k for k in far_slots(chunk) if k not in recorded.get(addr, set())]
        else:
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

FAR_SEEDS = (
    "\n\nFAR-FRAME SPILL LOCALS (this batch): the slots are keys like `fp-38`/`fp+40`, rendered in "
    "the C as raw `*(word*)(fp - 38)` (a word lvalue/rvalue), `*(byte*)(fp - 38)` (a byte), or "
    "`(fp - 38)` (its ADDRESS, e.g. `f(&buf)` after naming). They are ordinary frame locals that "
    "just landed outside the 12 standard slots (big frame / byte width / odd alignment) — name them "
    "by the SAME role-inference. Common far-local roles: a buffer a syscall/memcpy COPIES INTO "
    "(`syscall16_sram_wrap(8, src, (fp-44), 4)` -> `(fp-44)` is a 4-byte struct buffer — name by "
    "its contents); a pointer walked field-wise (`*(word*)((fp-40)+2)`); a loop counter/index in a "
    "kernel sub. Report the slot in the SAME `fp-38` key form. Conservatism rule still applies."
)


def main():
    ap = argparse.ArgumentParser(description="Assemble the next var-walk batch's Workflow args.")
    ap.add_argument("bank", type=lambda x: int(x, 0))
    ap.add_argument("--batch", type=int, default=8, help="named subs per batch (default 8)")
    ap.add_argument("--name-match", default="", metavar="REGEX",
                    help="restrict targets to subs whose NAME matches this regex (the 'keystones only' lever)")
    ap.add_argument("--name-exclude", default="", metavar="REGEX",
                    help="drop targets whose NAME matches this regex (e.g. display/UI subs)")
    ap.add_argument("--only", default="", metavar="ADDRS",
                    help="restrict targets to these comma-separated stub addrs (e.g. 87F0,88A6)")
    ap.add_argument("--far", action="store_true",
                    help="FAR-FRAME mode: surface raw *(word*)(fp±N) spill locals (keys fp-38/fp+40) "
                         "instead of positional slots; done-tracking is per-SLOT, so already-swept subs "
                         "re-surface for their un-named far slots (pair with var-walk-apply --merge)")
    ap.add_argument("--landmarks", default="", help="bank-specific context prepended to seeds")
    ap.add_argument("--json", action="store_true", help="emit ONLY the {bank,subs,seeds} args object")
    a = ap.parse_args()

    if a.far:
        named = parse_named_subs(a.bank, far=True, recorded=recorded_slots(a.bank))
        targets = list(named)                            # per-slot done-tracking already applied
    else:
        named = parse_named_subs(a.bank)
        done = done_addrs(a.bank)
        targets = [s for s in named if s["addr"] not in done]
    if a.name_match:
        rx = re.compile(a.name_match)
        targets = [s for s in targets if rx.search(s["name"])]
    if a.name_exclude:
        rxx = re.compile(a.name_exclude)
        targets = [s for s in targets if not rxx.search(s["name"])]
    if a.only:
        want = {norm.strip().lstrip("$").replace("0x", "").upper().zfill(4) for norm in a.only.split(",") if norm.strip()}
        targets = [s for s in targets if s["addr"] in want]
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

    seeds = (a.landmarks.strip() + "\n\n" if a.landmarks else "") + DEFAULT_SEEDS + (FAR_SEEDS if a.far else "")
    args_obj = {"bank": a.bank, "subs": batch, "seeds": seeds, "far": a.far}
    if a.json:
        print(json.dumps(args_obj))
        return

    kind = "far-frame slots" if a.far else "positional slots"
    print(f"bank_{a.bank:02d} [{kind}]: {remaining} named subs with un-walked slots "
          f"({len(named) - remaining} already done); this batch = {len(batch)}:")
    for s in batch:
        print(f"  ${s['addr']} {s['name']:<34} slots: {' '.join(s['slots'])}")
    apply_hint = "var-walk-apply.py <bank> <json> --merge" if a.far else "var-walk-apply.py <bank> <json>"
    print(f"\nRun:  py -3 tools/var-walk-prep.py {a.bank}{' --far' if a.far else ''} --batch {a.batch}"
          + (' --landmarks "..."' if a.landmarks else "") + " --json   then the var-walk Workflow"
          + f"\n      then  py -3 tools/{apply_hint}")


if __name__ == "__main__":
    main()

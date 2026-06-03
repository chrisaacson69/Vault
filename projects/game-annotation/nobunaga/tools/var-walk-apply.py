#!/usr/bin/env py -3
"""var-walk-apply.py — the DETERMINISTIC root-writer for the var-walk loop.

The variable-side twin of label-walk-apply.py. Consumes a var-walk Workflow's returned JSON
and mechanically does the glue between batches:
  1. WRITE per-sub `[vars.bankN."0xADDR"]` sections into mesen-labels.toml — one
     `slot = { name = "...", comment = "..." }` line per CONFIRMED/AMENDED slot. REFUTED slots
     are DROPPED (left positional = the honest scratch signal), recorded only as a `# left
     positional` comment so the sub still counts as processed (won't recur next batch).
  2. REGEN: py -3 tools/decompile-all.py  (var names feed vm_decompile; .mlb/.asm don't carry
     frame-slot names, so mesen-labels.py is intentionally NOT re-run.)
  3. GUARD (HARD FAIL, exit 2): only decompiled/bank_NN.c AND all_banks.c may change (var renames
     hit the per-bank file AND the merged view — that is EXPECTED, unlike label-walk), and each
     diff must be PURE RENAMES (identifier swaps only, zero logic lines).
  4. COMMIT (with --commit): toml + both .c files, templated message + tally.

Verification flows lateral (the Workflow's independent bytecode/caller verifier IS the check);
this script's only job is the deterministic write + the hard regen guard. See SKILL.md and
[[feedback_verification_independence_is_altitude]] / [[feedback_mechanical_vs_analytical_fanout]].

Input JSON (Workflow output file or bare): { bank, verified: [ {addr, name?, slots: [
  {slot, final_name, verdict, confidence, summary?} ]} ] }.

Usage:
  py -3 tools/var-walk-apply.py <bank> <workflow-output.json> [--commit] [--no-regen] [--dry-run]
"""
import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

from walk_guard import snapshot_decompiled, find_guard_violations

ROOT = Path(__file__).resolve().parent.parent
TOML = ROOT / "mesen-labels.toml"
DECOMPILED = ROOT / "decompiled"
SLOT_RE = re.compile(r'^(arg[1-4]|local\d+|fp[+-]\d+)$')   # positional OR far-frame (fp±N)


def die(msg, code=2):
    print(f"\n[var-walk-apply] FAIL: {msg}", file=sys.stderr)
    sys.exit(code)


def load_verified(path):
    obj = json.loads(Path(path).read_text(encoding="utf-8"))
    if "verified" in obj:
        data = obj
    elif "result" in obj and isinstance(obj["result"], dict) and "verified" in obj["result"]:
        data = obj["result"]
    else:
        die("input JSON has no 'verified' array (expected Workflow output or {bank,verified:[...]})")
    return data.get("bank"), data["verified"]


def norm_addr(a):
    return a.lstrip("$").replace("0x", "").replace("0X", "").upper().zfill(4)


def toml_escape(s):
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", " ").replace("\r", " ").strip()


def render_block(bank, v):
    addr = norm_addr(v["addr"])
    head = f'[vars.bank{bank}."0x{addr}"]'
    body = []
    if v.get("name"):
        body.append(f"# {v['name']}")
    n_named, seen = 0, set()
    for s in v.get("slots", []):
        slot = s.get("slot", "").strip()
        if not SLOT_RE.match(slot):
            die(f"sub ${addr}: bad slot token '{slot}'")
        if s.get("verdict") == "REFUTED":
            body.append(f"# {slot} left positional — {toml_escape(s.get('summary',''))[:120]}")
            continue
        name = s.get("final_name", "").strip()
        if not re.match(r'^[A-Za-z_]\w*$', name):
            die(f"sub ${addr} slot {slot}: bad final_name '{name}'")
        if name in seen:
            die(f"sub ${addr}: two slots share name '{name}'")
        seen.add(name)
        comment = f"[{s.get('confidence','?')}] {toml_escape(s.get('summary',''))}"
        key = f'"{slot}"' if slot.startswith("fp") else slot   # far-frame keys quote (+ isn't a bare-key char)
        body.append(f'{key} = {{ name = "{name}", comment = "{comment}" }}')
        n_named += 1
    return addr, n_named, head + "\n" + "\n".join(body) + "\n"


def existing_var_addrs(text, bank):
    return {m.group(1).upper()
            for m in re.finditer(rf'\[vars\.bank{bank}\."0x([0-9A-Fa-f]+)"\]', text)}


def run(cmd):
    return subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)


def regen():
    r = run(["py", "-3", "tools/decompile-all.py"])
    if r.returncode != 0:
        die(f"regen failed: decompile-all.py\n{r.stdout}\n{r.stderr}")


def assert_guard(bank, before):
    """Var renames legitimately touch ONLY decompiled/bank_NN.c AND the merged all_banks.c, and
    each change must be a pure identifier rename. `before` = snapshot taken before regen.
    Shared guard logic lives in walk_guard (same check label-walk-apply uses)."""
    allowed = {f"bank_{bank:02d}.c", "all_banks.c"}
    others, nonrename = find_guard_violations(before, snapshot_decompiled(DECOMPILED), allowed)
    if others:
        die("unexpected decompiled files changed (a var name leaked banks?):\n  "
            + "\n  ".join(others))
    if nonrename:
        die(f"{nonrename[0]} change is NOT a pure rename (logic/structure changed) — "
            "inspect, do NOT commit.")


def main():
    ap = argparse.ArgumentParser(description="Apply var-walk Workflow output: write [vars.*] + regen guard + commit.")
    ap.add_argument("bank", type=lambda x: int(x, 0))
    ap.add_argument("json", help="Workflow output JSON (full task output file or {bank,verified})")
    ap.add_argument("--commit", action="store_true", help="git commit on a clean guard")
    ap.add_argument("--no-regen", action="store_true", help="write toml only (skip regen+guard)")
    ap.add_argument("--dry-run", action="store_true", help="print the sections that WOULD be written")
    a = ap.parse_args()

    jbank, verified = load_verified(a.json)
    if jbank is not None and int(jbank) != a.bank:
        die(f"bank mismatch: arg={a.bank} but JSON says bank={jbank}")
    if not verified:
        die("no verified entries to write", code=1)

    blocks, addrs, total_named, total_subs = [], [], 0, 0
    for v in verified:
        addr, n_named, block = render_block(a.bank, v)
        addrs.append(addr)
        blocks.append(block)
        total_named += n_named
        total_subs += 1
    dup = {x for x in addrs if addrs.count(x) > 1}
    if dup:
        die(f"duplicate sub addresses in the batch: {sorted(dup)}")

    print(f"bank_{a.bank:02d}: {total_subs} subs, {total_named} slots named "
          f"({sum(1 for v in verified for s in v.get('slots',[]) if s.get('verdict')=='REFUTED')} left positional)")
    if a.dry_run:
        print("\n".join(blocks))
        return

    text = TOML.read_text(encoding="utf-8")
    have = existing_var_addrs(text, a.bank)
    clash = sorted(set(addrs) & have)
    if clash:
        die(f"these subs already have a [vars.bank{a.bank}.*] section: {clash}\n"
            "var-walk processes each sub once; resolve before re-writing.")

    header = (f"\n# --- bank-{a.bank:02d} var-walk batch via var-walk-apply.py "
              f"({total_subs} subs / {total_named} slots) ---\n"
              f"# propose@C (role + caller-propagation) -> independent verify@bytecode; names are the verifier's.\n")
    text = text.rstrip("\n") + "\n" + header + "\n".join(blocks) + "\n"
    TOML.write_text(text, encoding="utf-8")
    print(f"wrote {total_subs} [vars.bank{a.bank}.*] sections ({total_named} slot names)")

    if a.no_regen:
        print("--no-regen: skipped regen+guard (toml written; run the guard before committing).")
        return

    before = snapshot_decompiled(DECOMPILED)
    regen()
    assert_guard(a.bank, before)
    print(f"guard PASS: only bank_{a.bank:02d}.c + all_banks.c changed, both pure renames.")

    if not a.commit:
        print("guard clean. Re-run with --commit to commit (or commit manually).")
        return

    files = ["mesen-labels.toml", f"decompiled/bank_{a.bank:02d}.c", "decompiled/all_banks.c"]
    run(["git", "add"] + files)
    msg = (f"Nobunaga: var-walk bank_{a.bank:02d} batch — {total_named} slots named across {total_subs} subs\n\n"
           f"Frame args/locals renamed by role-inference + caller-propagation\n"
           f"(propose@C -> independent verify@bytecode), written by var-walk-apply.py.\n"
           f"Regen guard clean: only bank_{a.bank:02d}.c + all_banks.c changed, pure renames.\n\n"
           f"Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>")
    r = run(["git", "commit", "-m", msg])
    if r.returncode != 0:
        die(f"git commit failed:\n{r.stdout}\n{r.stderr}", code=3)
    print(r.stdout.strip().splitlines()[-1] if r.stdout.strip() else "committed.")


if __name__ == "__main__":
    main()

#!/usr/bin/env py -3
"""label-walk-apply.py — the DETERMINISTIC root-writer for the label-walk loop.

Consumes a label-walk Workflow's returned JSON and does, mechanically, the four steps the
coordinator used to do by hand between every batch (the slow, error-prone glue):
  1. WRITE survivors into mesen-labels.toml `[prg.bankN]` (formatted entries, verdict/
     confidence-flagged comments, REFUTED -> helper_<addr>, dedup + collision guard).
  2. REGEN: py -3 tools/mesen-labels.py --mlb --asm  +  py -3 tools/decompile-all.py
  3. GUARD (HARD FAIL, exit 2): only decompiled/bank_NN.c may change (no cross-bank bleed),
     and its diff must be PURE RENAMES (sub_XXXX -> name, zero logic lines).
  4. COMMIT (with --commit): toml + .mlb + decompiled/bank_NN.c, templated message + tally.

The verifier IS the check (lateral, lower-altitude bytecode) — auto-writing its names is MORE
faithful to the architecture than a coordinator self-review (which rubber-stamps). The only
gate that matters is the deterministic guard, and this makes it a hard assertion, not eyeballing.
See SKILL.md, [[feedback_verification_independence_is_altitude]], [[feedback_mechanical_vs_analytical_fanout]].

Input JSON: either the Workflow's full output file ({result:{bank,verified:[...]}}) or a bare
{bank,verified:[...]}. Each verified entry: {addr, final_name, verdict, confidence, summary?, evidence?}.

Usage:
  py -3 tools/label-walk-apply.py <bank> <workflow-output.json> [--commit] [--no-regen] [--dry-run]
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
MLB = ROOT / "Nobunaga's Ambition (USA).mlb"
DECOMPILED = ROOT / "decompiled"


def die(msg, code=2):
    print(f"\n[label-walk-apply] FAIL: {msg}", file=sys.stderr)
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


def entry_line(v):
    addr = norm_addr(v["addr"])
    verdict = v.get("verdict", "?")
    conf = v.get("confidence", "?")
    name = v["final_name"]
    if verdict == "REFUTED":                       # honest non-guess, never invent a purpose
        name = f"helper_{addr.lower()}"
    # comment = the verifier's one-line summary (clean conclusion); fall back to truncated evidence
    body = v.get("summary") or v.get("evidence", "")
    body = re.sub(r"^\s*Bytecode\s*@?\s*\$?[0-9A-Fa-f]{4}[:\s-]*", "", body)  # strip trace preamble
    if not v.get("summary") and len(body) > 280:
        body = body[:277].rstrip() + "..."
    comment = f"[{conf} {verdict}] {toml_escape(body)}"
    return addr, name, f'"0x{addr}" = {{ name = "{name}", comment = "{comment}" }}'


def section_bounds(text, bank):
    head = f"[prg.bank{bank}]"
    i = text.find(head)
    if i < 0:
        die(f"section {head} not found in mesen-labels.toml")
    # section ends at the next top-level [section] header or EOF
    nxt = re.search(r"\n\[[^\]]+\]", text[i + len(head):])
    j = (i + len(head) + nxt.start()) if nxt else len(text)
    return i, j


def existing_addrs(section_text):
    return {m.group(1).upper() for m in re.finditer(r'"0x([0-9A-Fa-f]{4})"\s*=', section_text)}


def run(cmd):
    return subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)


def regen():
    for cmd in (["py", "-3", "tools/mesen-labels.py", "--mlb", "--asm"],
                ["py", "-3", "tools/decompile-all.py"]):
        r = run(cmd)
        if r.returncode != 0:
            die(f"regen step failed: {' '.join(cmd)}\n{r.stdout}\n{r.stderr}")


def assert_pure_rename(bank, before):
    """A sub rename legitimately touches decompiled/bank_NN.c AND the merged all_banks.c, and
    each change must be a pure identifier rename. `before` = snapshot taken before regen.
    Snapshot-vs-pre-regen (NOT git-diff-vs-HEAD) so a dirty tree can't false-positive; shared
    guard logic lives in walk_guard (same check var-walk-apply uses). Backported 2026-06-03."""
    allowed = {f"bank_{bank:02d}.c", "all_banks.c"}
    others, nonrename = find_guard_violations(before, snapshot_decompiled(DECOMPILED), allowed)
    if others:
        die(f"cross-bank BLEED — these decompiled files changed besides bank_{bank:02d}.c "
            "(+ the merged all_banks.c):\n  " + "\n  ".join(others)
            + "\nA switchable-window label leaked banks; fix the section, do NOT commit.")
    if nonrename:
        die(f"{nonrename[0]} diff is NOT a pure rename (logic changed) — inspect, do NOT commit.")


def main():
    ap = argparse.ArgumentParser(description="Apply label-walk Workflow output: write toml + regen guard + commit.")
    ap.add_argument("bank", type=lambda x: int(x, 0))
    ap.add_argument("json", help="Workflow output JSON (full task output file or {bank,verified})")
    ap.add_argument("--commit", action="store_true", help="git commit on a clean guard")
    ap.add_argument("--no-regen", action="store_true", help="write toml only (skip regen+guard); for inspection")
    ap.add_argument("--dry-run", action="store_true", help="print the entries that WOULD be written, change nothing")
    a = ap.parse_args()

    jbank, verified = load_verified(a.json)
    if jbank is not None and int(jbank) != a.bank:
        die(f"bank mismatch: arg={a.bank} but JSON says bank={jbank}")
    if not verified:
        die("no verified entries to write", code=1)

    lines, addrs, tally = [], [], {}
    for v in verified:
        addr, name, line = entry_line(v)
        addrs.append(addr)
        lines.append(line)
        tally[v.get("verdict", "?")] = tally.get(v.get("verdict", "?"), 0) + 1
    dup = {x for x in addrs if addrs.count(x) > 1}
    if dup:
        die(f"duplicate addresses in the batch: {sorted(dup)}")

    tally_str = " / ".join(f"{tally.get(k,0)} {k[:4]}" for k in ("CONFIRMED", "AMENDED", "REFUTED") if tally.get(k))
    print(f"bank_{a.bank:02d}: {len(verified)} entries ({tally_str})")
    if a.dry_run:
        print("\n".join(lines))
        return

    text = TOML.read_text(encoding="utf-8")
    i, j = section_bounds(text, a.bank)
    have = existing_addrs(text[i:j])
    clash = sorted(set(addrs) & have)
    if clash:
        die(f"address collision — these are already labeled in [prg.bank{a.bank}]: {clash}\n"
            "Resolve (rename/skip) before writing; the walk targets ANON subs only.")

    header = (f"\n# --- bank-{a.bank:02d} label-walk batch via label-walk-apply.py "
              f"({tally_str}) ---\n# propose@C -> independent verify@bytecode; names are the verifier's. ")
    block = header + "\n" + "\n".join(lines) + "\n"
    text = text[:j].rstrip("\n") + "\n" + block + text[j:]
    TOML.write_text(text, encoding="utf-8")
    print(f"wrote {len(lines)} entries to [prg.bank{a.bank}]")

    if a.no_regen:
        print("--no-regen: skipped regen+guard (toml written; run the guard before committing).")
        return

    before = snapshot_decompiled(DECOMPILED)
    regen()
    assert_pure_rename(a.bank, before)
    print(f"guard PASS: only bank_{a.bank:02d}.c + all_banks.c changed, both pure renames.")

    if not a.commit:
        print("guard clean. Re-run with --commit to commit (or commit manually).")
        return

    files = ["mesen-labels.toml", "Nobunaga's Ambition (USA).mlb",
             f"decompiled/bank_{a.bank:02d}.c", "decompiled/all_banks.c"]
    run(["git", "add"] + files)
    msg = (f"Nobunaga: label-walk bank_{a.bank:02d} batch — {len(verified)} named ({tally_str})\n\n"
           f"Names from the label-walk skill (propose@C -> independent verify@bytecode),\n"
           f"written by label-walk-apply.py. Regen guard clean: only bank_{a.bank:02d}.c\n"
           f"+ all_banks.c changed, both pure renames.\n\n"
           f"Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>")
    r = run(["git", "commit", "-m", msg])
    if r.returncode != 0:
        die(f"git commit failed:\n{r.stdout}\n{r.stderr}", code=3)
    print(r.stdout.strip().splitlines()[-1] if r.stdout.strip() else "committed.")


if __name__ == "__main__":
    main()

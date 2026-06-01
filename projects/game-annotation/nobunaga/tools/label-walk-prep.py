#!/usr/bin/env py -3
"""label-walk-prep.py — assemble the NEXT label-walk batch's Workflow args, deterministically.

The other half of removing the per-batch hand-work (see label-walk-apply.py). Each batch the
coordinator used to (a) re-cluster, (b) pull every already-named sub out of the toml by hand to
build the `seeds` string. Both are mechanical. This emits a ready-to-use Workflow args object:

  { bank, clusters: [<first K leaves-first clusters of the remaining anon>], seeds: "<text>" }

- clusters: leaves-first (cluster-anon-subs.py --by-callgraph), first K taken as this batch.
  Because naming removes anon subs, re-running after each committed batch always returns the
  next un-done leaves — so "first K" walks the whole bank across batches with no manual cursor.
- seeds: AUTO-built = every already-named sub in this bank (addr name) from mesen-labels.toml,
  the mechanical bulk. Bank-specific LANDMARK context (combat $-addrs, formula anchors) is the
  one analytical bit — pass it once via --landmarks and it's prepended.

Print modes: --json emits ONLY the args object (pipe straight into the Workflow call); default
prints a human summary + the remaining-anon count (0 => the bank is done).

Usage:
  py -3 tools/label-walk-prep.py <bank> [--batch-clusters K] [--size N] [--landmarks "text"] [--json]
"""
import argparse
import json
import re
from importlib import import_module
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TOML = ROOT / "mesen-labels.toml"
_cluster = import_module("cluster-anon-subs")


def named_subs(bank):
    """(addr, name) for every labeled sub in this bank's code window, from the toml — the
    seed bulk. Switchable banks (0/1/2): $8000-$BFFF. Fixed bank 15: $C000-$FFFF."""
    text = TOML.read_text(encoding="utf-8")
    head = f"[prg.bank{bank}]"
    i = text.find(head)
    if i < 0:
        return []
    nxt = re.search(r"\n\[[^\]]+\]", text[i + len(head):])
    section = text[i:(i + len(head) + nxt.start()) if nxt else len(text)]
    lo, hi = (0xC000, 0xFFFF) if bank == 15 else (0x8000, 0xBFFF)
    out = []
    for m in re.finditer(r'"0x([0-9A-Fa-f]{4})"\s*=\s*\{\s*name\s*=\s*"([^"]+)"', section):
        a = int(m.group(1), 16)
        if lo <= a <= hi:
            out.append((m.group(1).upper(), m.group(2)))
    return out


def main():
    ap = argparse.ArgumentParser(description="Assemble the next label-walk batch's Workflow args.")
    ap.add_argument("bank", type=lambda x: int(x, 0))
    ap.add_argument("--batch-clusters", type=int, default=3, help="clusters per batch (default 3, ~21 subs)")
    ap.add_argument("--size", type=int, default=7, help="target subs per cluster (default 7)")
    ap.add_argument("--landmarks", default="", help="bank-specific context to prepend to seeds (pass once per bank)")
    ap.add_argument("--json", action="store_true", help="emit ONLY the {bank,clusters,seeds} args object")
    a = ap.parse_args()

    addrs = _cluster.anon_addrs(a.bank)
    remaining = len(addrs)
    if remaining == 0:
        if a.json:
            print(json.dumps({"bank": a.bank, "clusters": [], "seeds": "", "done": True}))
        else:
            print(f"bank_{a.bank:02d}: 0 anon subs remaining — BANK COMPLETE.")
        return

    ordered = _cluster.callgraph_order(a.bank, addrs)
    all_clusters = _cluster.cluster(ordered, a.size)
    batch = all_clusters[:a.batch_clusters]
    batch_n = sum(len(c["addrs"]) for c in batch)

    named = named_subs(a.bank)
    seed_lines = "; ".join(f"{addr} {name}" for addr, name in named)
    seeds = ""
    if a.landmarks:
        seeds += a.landmarks.strip() + "\n\n"
    seeds += f"ALL {len(named)} already-named subs in bank_{a.bank:02d} (lean on as callees/neighbors): {seed_lines}"

    args_obj = {"bank": a.bank, "clusters": batch, "seeds": seeds}
    if a.json:
        print(json.dumps(args_obj))
        return

    print(f"bank_{a.bank:02d}: {remaining} anon remaining in {len(all_clusters)} clusters; "
          f"this batch = {len(batch)} clusters / {batch_n} subs:")
    for c in batch:
        print(f"  {c['name']:<16} ({len(c['addrs'])}): {' '.join('$'+x for x in c['addrs'])}")
    print(f"seeds: {len(named)} named subs auto-pulled" + (" + landmarks" if a.landmarks else "")
          + f"  ({len(seeds)} chars)")
    print(f"\nRun:  py -3 tools/label-walk-prep.py {a.bank} --batch-clusters {a.batch_clusters}"
          + (' --landmarks "..."' if a.landmarks else "") + " --json   then pass to the label-walk Workflow.")


if __name__ == "__main__":
    main()

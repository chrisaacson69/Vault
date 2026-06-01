#!/usr/bin/env py -3
"""cluster-anon-subs.py — group a bank's anonymous decompiled subs into address-proximity
clusters for the label-walk pipeline.

This is the GENERALIZATION of the hand-coded CLUSTERS list in the bank01-label-walk Workflow
(the one piece that was bank-specific). Pass it any bank; it reads the committed
`decompiled/bank_<NN>.c`, finds every still-anonymous `word sub_XXXX(` definition, and buckets
them by sorted address into clusters of ~N. Deterministic: same C -> same clusters.

Address proximity is a good proxy because the assembler emits related routines contiguously
(call-graph community detection is a possible v2). A cluster becomes one PROPOSER agent's batch
in the Workflow (scan -> symbol-table stage); see ROADMAP "label-walk skill".

Usage:
  py -3 tools/cluster-anon-subs.py <bank> [--size N]   # human summary (default N=7)
  py -3 tools/cluster-anon-subs.py <bank> --json        # JSON for the Workflow `args`
"""
import argparse
import json
import re
from pathlib import Path

ROOT = Path(__file__).parent.parent


def anon_addrs(bank):
    p = ROOT / "decompiled" / f"bank_{bank:02d}.c"
    text = p.read_text(encoding="utf-8")
    return sorted({int(a, 16) for a in re.findall(r'^word sub_([0-9A-Fa-f]+)\(', text, re.M)})


def cluster(addrs, size):
    out = []
    for i in range(0, len(addrs), size):
        chunk = addrs[i:i + size]
        out.append({"name": f"g_{chunk[0]:04X}_{chunk[-1]:04X}",
                    "addrs": [f"{a:04X}" for a in chunk]})
    return out


def main():
    ap = argparse.ArgumentParser(description="Cluster a bank's anonymous subs for the label-walk.")
    ap.add_argument("bank", type=lambda x: int(x, 0), help="bank number (0,1,2,15)")
    ap.add_argument("--size", type=int, default=7, help="target subs per cluster (default 7)")
    ap.add_argument("--json", action="store_true", help="emit JSON (for Workflow args) instead of a summary")
    a = ap.parse_args()

    addrs = anon_addrs(a.bank)
    clusters = cluster(addrs, a.size)
    if a.json:
        print(json.dumps(clusters))
    else:
        print(f"bank_{a.bank:02d}: {len(addrs)} anon subs -> {len(clusters)} clusters (~{a.size} each)")
        for c in clusters:
            print(f"  {c['name']:<16} ({len(c['addrs'])}): {' '.join('$'+x for x in c['addrs'])}")


if __name__ == "__main__":
    main()

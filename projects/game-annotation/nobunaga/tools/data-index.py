#!/usr/bin/env python3
"""data-index.py - give every empirical capture provenance, at capture time.

The traces/ pile became hard to use because dumps were captured WITHOUT context
("what is this file?" is unanswerable later). This is the fix: a tiny index that
records WHAT each file is and WHY it was taken, written when the data is created.

Index file: traces/INDEX.tsv  (tab-separated: file, date, kind, size_bytes, note)
  kind is inferred from extension: .dmp=memory  .txt=trace  .sav/.mss=state

Usage (from anywhere - paths resolve to the project):
    python data-index.py add <file> --note "what this is / what question it answers"
    python data-index.py scan          # list traces/ files NOT yet in the index (the backlog)
    python data-index.py auto [--dry-run]  # bulk-register backlog files whose name matches a
                                           # known convention (note derived from the name);
                                           # leaves only genuine unknowns in `scan`.
    python data-index.py show          # print the index, newest first
    python data-index.py show --orphans # index rows whose file no longer exists

capture-test.py calls `add` automatically on every snap, so memory dumps are
self-registering. Run `add` by hand for Mesen trace .txt files and savestates.
`auto` is for the legacy backlog: it reads provenance from the filename convention
(see traces/README.md) - notes are marked "name-derived" since they record what the
name asserts, not a re-verified fact.
"""
import argparse
import os
import re
import sys
from datetime import datetime
from pathlib import Path

HERE = Path(__file__).resolve().parent
PROJ = HERE.parent
TRACES = PROJ / "traces"
INDEX = TRACES / "INDEX.tsv"
HEADER = "file\tdate\tkind\tsize_bytes\tnote"

KIND = {".dmp": "memory", ".txt": "trace", ".sav": "state", ".mss": "state", ".gz": "trace"}


def _rows():
    if not INDEX.exists():
        return []
    lines = INDEX.read_text(encoding="utf-8").splitlines()
    return [l for l in lines[1:] if l.strip()]  # skip header


def _indexed_files():
    return {r.split("\t", 1)[0] for r in _rows()}


def add(path, note):
    f = Path(path)
    name = f.name
    # accept a bare filename (assume it's in traces/) or a full path
    full = f if f.is_absolute() or f.exists() else (TRACES / name)
    size = full.stat().st_size if full.exists() else 0
    kind = KIND.get(full.suffix.lower(), "other")
    date = datetime.now().strftime("%Y-%m-%d")
    note = (note or "").replace("\t", " ").replace("\n", " ").strip()

    rows = [r for r in _rows() if r.split("\t", 1)[0] != name]  # replace existing
    rows.append(f"{name}\t{date}\t{kind}\t{size}\t{note}")
    TRACES.mkdir(exist_ok=True)
    INDEX.write_text(HEADER + "\n" + "\n".join(rows) + "\n", encoding="utf-8")
    print(f"indexed: {name}  [{kind}, {size} B]  {note!r}")


def classify(name):
    """Derive a provenance note from the filename convention, or None if unrecognized.

    Notes are explicitly name-derived (they record what the name asserts). Order
    matters - most specific patterns first. Mirrors traces/README.md "What's here".
    """
    n = name
    season = r"(spring|summer|fall|winter)"

    if n.endswith("-combat-init.txt.gz") or n.endswith("-combat-init.txt"):
        fief = n.split("-combat-init")[0]
        return f"name-derived: per-fief combat-init execution trace ({fief}); gzipped cold storage. Companion to {fief}-save-ram.dmp."
    if re.search(r"-trace\.txt(\.gz)?$", n):
        return "name-derived: full turn/run execution trace (gzipped cold storage)."
    if n.endswith("-ppu-memory.dmp"):
        fief = n[:-len("-ppu-memory.dmp")]
        return f"name-derived: per-fief PPU dump ({fief}, 16 KB) -> input to render-fief-from-ppu.py."
    if n.endswith("-save-ram.dmp"):
        fief = n[:-len("-save-ram.dmp")]
        return f"name-derived: per-fief SRAM snapshot ({fief})."
    if n.endswith("-internal-ram.dmp"):
        tag = n[:-len("-internal-ram.dmp")]
        return f"name-derived: CPU internal RAM dump ({tag}, 2 KB)."
    if n.endswith("_PRE.dmp"):
        return f"name-derived: command-test PRE snapshot (legacy, pre-auto-registration) - all-17-fief state before '{n[:-len('_PRE.dmp')]}'."
    if n.endswith("_POST.dmp"):
        return f"name-derived: command-test POST snapshot (legacy) - all-17-fief state after '{n[:-len('_POST.dmp')]}'."
    if n.startswith(("b2-", "b3-")) and n.endswith(".dmp"):
        return f"name-derived: bank-{n[1]} battle-state dump ({n[:-4]})."
    if n.startswith("battle") and n.endswith(".dmp"):
        return f"name-derived: battle checkpoint ({n[:-4]})."
    if re.match(season + r"[-]?\d{4}", n) or re.search(season + r"-(turn|snapshot|trained|baseline|consolidate)", n):
        return f"name-derived: seasonal game-state checkpoint ({n})."
    if n.endswith(".mss"):
        return f"name-derived: Mesen savestate ({n})."
    if n.endswith(".sav"):
        return f"name-derived: battery/SRAM save ({n})."
    if ("sram" in n or n.endswith("-ram.dmp")) and n.endswith((".dmp", ".sav")):
        return f"name-derived: game-state SRAM snapshot ({n})."
    if n.endswith(".txt"):
        return f"name-derived: text dump/hexdump ({n}) - inspect contents before relying."
    if n.endswith(".dmp"):
        return f"name-derived: game-state memory dump ({n}) - provenance from name only; verify if relied upon."
    return None


def _backlog():
    have = _indexed_files()
    on_disk = {p.name for p in TRACES.iterdir()
               if p.is_file() and p.name not in ("INDEX.tsv", "README.md")}
    return sorted(on_disk - have)


def auto(dry_run=False):
    missing = _backlog()
    if not missing:
        print("All capture files are indexed. OK")
        return
    date = datetime.now().strftime("%Y-%m-%d")
    rows = _rows()
    matched, unknown = [], []
    for name in missing:
        note = classify(name)
        if note is None:
            unknown.append(name)
            continue
        size = (TRACES / name).stat().st_size
        kind = KIND.get(Path(name).suffix.lower(), "other")
        matched.append((name, kind, size, note))

    print(f"{'(dry run) would register' if dry_run else 'registered'} {len(matched)} file(s) by convention:")
    for name, kind, size, note in matched:
        print(f"  {name}  [{kind}]  {note}")

    if not dry_run and matched:
        rows = [r for r in rows if r.split("\t", 1)[0] not in {m[0] for m in matched}]
        rows += [f"{name}\t{date}\t{kind}\t{size}\t{note}" for name, kind, size, note in matched]
        TRACES.mkdir(exist_ok=True)
        INDEX.write_text(HEADER + "\n" + "\n".join(rows) + "\n", encoding="utf-8")

    if unknown:
        print(f"\n{len(unknown)} file(s) unrecognized - triage by hand (add a note or purge):")
        for name in unknown:
            print(f"  {(TRACES / name).stat().st_size:>12,}  {name}")
    else:
        print("\nNo unrecognized files remain. OK")


def scan():
    have = _indexed_files()
    on_disk = {p.name for p in TRACES.iterdir()
               if p.is_file() and p.name != "INDEX.tsv" and p.name != "README.md"}
    missing = sorted(on_disk - have)
    if not missing:
        print("All capture files are indexed. OK")
        return
    print(f"{len(missing)} un-contextualized file(s) in traces/ (add a note or purge):")
    for name in missing:
        size = (TRACES / name).stat().st_size
        print(f"  {size:>12,}  {name}")


def show(orphans=False):
    rows = _rows()
    if orphans:
        rows = [r for r in rows if not (TRACES / r.split("\t", 1)[0]).exists()]
        print("Index rows whose file is gone:" if rows else "No orphan rows. OK")
    print(HEADER)
    for r in sorted(rows, key=lambda x: x.split("\t")[1], reverse=True):
        print(r)


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    a = sub.add_parser("add"); a.add_argument("file"); a.add_argument("--note", default="")
    sub.add_parser("scan")
    au = sub.add_parser("auto"); au.add_argument("--dry-run", action="store_true")
    s = sub.add_parser("show"); s.add_argument("--orphans", action="store_true")
    args = ap.parse_args()
    if args.cmd == "add":
        add(args.file, args.note)
    elif args.cmd == "scan":
        scan()
    elif args.cmd == "auto":
        auto(dry_run=args.dry_run)
    elif args.cmd == "show":
        show(orphans=args.orphans)


if __name__ == "__main__":
    main()

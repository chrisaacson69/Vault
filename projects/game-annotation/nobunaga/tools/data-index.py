#!/usr/bin/env python3
"""data-index.py — give every empirical capture provenance, at capture time.

The traces/ pile became hard to use because dumps were captured WITHOUT context
("what is this file?" is unanswerable later). This is the fix: a tiny index that
records WHAT each file is and WHY it was taken, written when the data is created.

Index file: traces/INDEX.tsv  (tab-separated: file, date, kind, size_bytes, note)
  kind is inferred from extension: .dmp=memory  .txt=trace  .sav/.mss=state

Usage (from anywhere — paths resolve to the project):
    python data-index.py add <file> --note "what this is / what question it answers"
    python data-index.py scan          # list traces/ files NOT yet in the index (the backlog)
    python data-index.py show          # print the index, newest first
    python data-index.py show --orphans # index rows whose file no longer exists

capture-test.py calls `add` automatically on every snap, so memory dumps are
self-registering. Run `add` by hand for Mesen trace .txt files and savestates.
"""
import argparse
import os
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


def scan():
    have = _indexed_files()
    on_disk = {p.name for p in TRACES.iterdir()
               if p.is_file() and p.name != "INDEX.tsv" and p.name != "README.md"}
    missing = sorted(on_disk - have)
    if not missing:
        print("All capture files are indexed. ✓")
        return
    print(f"{len(missing)} un-contextualized file(s) in traces/ (add a note or purge):")
    for name in missing:
        size = (TRACES / name).stat().st_size
        print(f"  {size:>12,}  {name}")


def show(orphans=False):
    rows = _rows()
    if orphans:
        rows = [r for r in rows if not (TRACES / r.split("\t", 1)[0]).exists()]
        print("Index rows whose file is gone:" if rows else "No orphan rows. ✓")
    print(HEADER)
    for r in sorted(rows, key=lambda x: x.split("\t")[1], reverse=True):
        print(r)


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    a = sub.add_parser("add"); a.add_argument("file"); a.add_argument("--note", default="")
    sub.add_parser("scan")
    s = sub.add_parser("show"); s.add_argument("--orphans", action="store_true")
    args = ap.parse_args()
    if args.cmd == "add":
        add(args.file, args.note)
    elif args.cmd == "scan":
        scan()
    elif args.cmd == "show":
        show(orphans=args.orphans)


if __name__ == "__main__":
    main()

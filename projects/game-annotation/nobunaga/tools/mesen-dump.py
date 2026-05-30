#!/usr/bin/env python3
"""Resolve / fetch Mesen debugger output by convention, so a battle dump is one
command away instead of a manual hunt.

Mesen writes its dumps to a fixed Debugger folder (below). Conventions (Chris,
2026-05-30):
  *.dmp  = SRAM image (8 KB, based at $6000)        e.g. "Nobunaga's Ambition (USA) - NesSaveRam.dmp"
  *.txt  = trace log                                 e.g. "Nobunaga's Ambition (USA).txt"
  no name given -> the most recent file of that type (by mtime)

Usage:
  py mesen-dump.py list                       # recent dumps + tracelogs, newest first
  py mesen-dump.py path [name] [--trace]       # print the resolved absolute path (latest if no name)
  py mesen-dump.py get  [name] [--trace]       # copy into traces/ + register provenance; print local path

`name` is a case-insensitive substring (e.g. "tanmba" matches "TanmbaBattle.dmp").
--trace selects *.txt tracelogs; default is *.dmp SRAM.
"""
import os, sys, shutil, time, subprocess
from pathlib import Path

MESEN_DIR = Path(r"C:\Users\Chris.Isaacson\AppData\Local\Microsoft\WinGet\Packages"
                 r"\SourMesen.Mesen2_Microsoft.Winget.Source_8wekyb3d8bbwe\Debugger")
HERE = Path(__file__).parent
TRACES = HERE.parent / "traces"


def _candidates(trace=False):
    if not MESEN_DIR.is_dir():
        sys.exit(f"Mesen Debugger dir not found: {MESEN_DIR}")
    ext = ".txt" if trace else ".dmp"
    fs = [p for p in MESEN_DIR.iterdir() if p.is_file() and p.suffix.lower() == ext]
    return sorted(fs, key=lambda p: p.stat().st_mtime, reverse=True)


def resolve(name=None, trace=False):
    fs = _candidates(trace)
    if name:
        matches = [p for p in fs if name.lower() in p.name.lower()]
        if not matches:
            sys.exit(f"No {'tracelog' if trace else 'SRAM'} matching '{name}' in {MESEN_DIR}")
        return matches[0]                      # newest match
    if not fs:
        sys.exit(f"No {'*.txt' if trace else '*.dmp'} files in {MESEN_DIR}")
    return fs[0]                               # newest of type


def cmd_list():
    for trace, kind in ((False, "SRAM (.dmp)"), (True, "tracelog (.txt)")):
        fs = _candidates(trace)
        print(f"\n=== {kind} — newest first ===")
        for p in fs[:12]:
            st = p.stat()
            print(f"  {time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(st.st_mtime))}"
                  f"  {st.st_size:>7}  {p.name}")


def cmd_path(name, trace):
    print(resolve(name, trace))


def cmd_get(name, trace):
    src = resolve(name, trace)
    TRACES.mkdir(exist_ok=True)
    dst = TRACES / src.name
    shutil.copyfile(src, dst)
    print(f"copied {src.name}  ->  {dst}")
    # Best-effort provenance registration (the project's anti-drift discipline:
    # never leave a capture un-noted). Non-fatal if data-index changes shape.
    note = f"Mesen {'tracelog' if trace else 'SRAM'} fetched from Debugger dir"
    try:
        subprocess.run([sys.executable, str(HERE / "data-index.py"), "add", str(dst),
                        "--note", note], check=False)
    except Exception as e:
        print(f"  (provenance registration skipped: {e})")
    print(dst)


def main():
    args = sys.argv[1:]
    trace = "--trace" in args
    args = [a for a in args if a != "--trace"]
    sub = args[0] if args else "list"
    name = args[1] if len(args) > 1 else None
    if sub == "list":   cmd_list()
    elif sub == "path": cmd_path(name, trace)
    elif sub == "get":  cmd_get(name, trace)
    else:               sys.exit(__doc__)


if __name__ == "__main__":
    main()

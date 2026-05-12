r"""
mesen-workspace.py — Apply a workspace preset (watches + breakpoints) to a Mesen 2 workspace JSON.

Unlike mesen-labels.py (which adds labels that persist as part of game documentation),
this tool sets the workspace's watch list and breakpoint set from a named investigation
preset. Use it to set up reproducible debug sessions: an "audio-trace" preset, a
"brk-trace" preset, etc.

Default behavior is REPLACE: the existing watches and breakpoints are overwritten with
the preset's contents. Use --append to add on top of whatever's already there.

Usage:
    python mesen-workspace.py <preset.toml>
    python mesen-workspace.py <preset.toml> --append
    python mesen-workspace.py <preset.toml> --dry-run

Preset TOML format:

    [meta]
    rom_name = "Nobunaga's Ambition (USA)"

    [preset]
    name = "audio-trace"
    description = "Watch voice records; mark all writes to $0720-$0760"

    [watches]
    expressions = [
        "[song_active]",
        "[v0_trigger]",
        "[brk_dispatch_id]",
    ]

    [[breakpoints]]
    type = "write"             # read | write | exec | rw | rwx
    start = 0x0734
    end = 0x0760               # optional; defaults to start
    mark_only = true           # true = log to trace; false = pause emulator
    memory_type = "ram"        # ram (default) | prg
    bank = 0                   # required when memory_type = "prg"
    condition = ""             # optional Mesen condition expression
    comment = "what this is for"   # documentary only; Mesen JSON has no slot for it

Watch expressions follow Mesen syntax: $XX hex literals, decimals, or [label_name] for
labels that exist in the workspace (run mesen-labels.py first to make them available).
"""

import argparse
import json
import os
import shutil
import sys
import tomllib
from pathlib import Path

DEFAULT_MESEN_DEBUGGER_GLOB = "Microsoft/WinGet/Packages/SourMesen.Mesen2_*/Debugger"

BREAK_TYPE_FLAGS = {
    # name : (BreakOnRead, BreakOnWrite, BreakOnExec)
    "read":  (True,  False, False),
    "write": (False, True,  False),
    "exec":  (False, False, True),
    "rw":    (True,  True,  False),
    "rwx":   (True,  True,  True),
}


def find_default_workspace(rom_name: str) -> Path | None:
    local_appdata = os.environ.get("LOCALAPPDATA")
    if not local_appdata:
        return None
    root = Path(local_appdata)
    for candidate in root.glob(f"{DEFAULT_MESEN_DEBUGGER_GLOB}/{rom_name}.json"):
        return candidate
    return None


def cpu_to_prg_offset(cpu_addr: int, bank_idx: int, bank_size: int) -> int:
    return bank_idx * bank_size + (cpu_addr & (bank_size - 1))


def build_breakpoint(entry: dict, default_bank_size: int) -> dict:
    bp_type = entry.get("type", "write")
    if bp_type not in BREAK_TYPE_FLAGS:
        raise ValueError(
            f"unknown breakpoint type {bp_type!r}; use one of {list(BREAK_TYPE_FLAGS)}"
        )
    read, write, exec_ = BREAK_TYPE_FLAGS[bp_type]

    mem_type_str = entry.get("memory_type", "ram").lower()
    if mem_type_str == "ram":
        memory_type = "NesMemory"
        start = int(entry["start"])
        end = int(entry.get("end", start))
    elif mem_type_str == "prg":
        memory_type = "NesPrgRom"
        bank = entry.get("bank")
        if bank is None:
            raise ValueError("memory_type='prg' requires a 'bank' field")
        bank_size = int(entry.get("bank_size", default_bank_size))
        start = cpu_to_prg_offset(int(entry["start"]), int(bank), bank_size)
        end_cpu = int(entry.get("end", entry["start"]))
        end = cpu_to_prg_offset(end_cpu, int(bank), bank_size)
    else:
        raise ValueError(f"unknown memory_type {mem_type_str!r}; use 'ram' or 'prg'")

    return {
        "BreakOnRead": read,
        "BreakOnWrite": write,
        "BreakOnExec": exec_,
        "Forbid": False,
        "Enabled": True,
        "MarkEvent": bool(entry.get("mark_only", True)),
        "IgnoreDummyOperations": True,
        "MemoryType": memory_type,
        "StartAddress": start,
        "EndAddress": end,
        "CpuType": "Nes",
        "AnyAddress": False,
        "IsAssert": False,
        "Condition": entry.get("condition", ""),
    }


def describe_breakpoint(bp: dict) -> str:
    sym = "".join([
        "R" if bp["BreakOnRead"] else "-",
        "W" if bp["BreakOnWrite"] else "-",
        "X" if bp["BreakOnExec"] else "-",
    ])
    mark = "MARK" if bp["MarkEvent"] else "STOP"
    if bp["StartAddress"] == bp["EndAddress"]:
        rng = f"${bp['StartAddress']:04X}"
    else:
        rng = f"${bp['StartAddress']:04X}-${bp['EndAddress']:04X}"
    cond = f"  cond={bp['Condition']}" if bp["Condition"] else ""
    return f"bp {sym} {mark} {rng} ({bp['MemoryType']}){cond}"


def main() -> int:
    parser = argparse.ArgumentParser(description="Apply a Mesen 2 workspace preset.")
    parser.add_argument("config", type=Path, help="Path to the TOML preset config.")
    parser.add_argument("--workspace", type=Path,
                        help="Path to the Mesen workspace JSON. Auto-detected if omitted.")
    parser.add_argument("--dry-run", action="store_true",
                        help="Print what would be written without modifying anything.")
    parser.add_argument("--no-backup", action="store_true")
    parser.add_argument("--append", action="store_true",
                        help="Append to existing watches/breakpoints instead of replacing them.")
    args = parser.parse_args()

    if not args.config.exists():
        print(f"error: config file not found: {args.config}", file=sys.stderr)
        return 2

    with args.config.open("rb") as f:
        config = tomllib.load(f)

    rom_name = config.get("meta", {}).get("rom_name")
    if not rom_name:
        print("error: config must define [meta].rom_name", file=sys.stderr)
        return 2

    default_bank_size = config.get("meta", {}).get("prg_bank_size", 0x4000)

    workspace_path = args.workspace
    if workspace_path is None:
        workspace_path = find_default_workspace(rom_name)
        if workspace_path is None:
            print(f"error: could not auto-locate workspace JSON for '{rom_name}'", file=sys.stderr)
            return 2
        print(f"  workspace: {workspace_path}")

    if not workspace_path.exists():
        print(f"error: workspace JSON not found: {workspace_path}", file=sys.stderr)
        return 2

    workspace = json.loads(workspace_path.read_text(encoding="utf-8-sig"))
    nes_workspace = workspace.get("WorkspaceByCpu", {}).get("Nes")
    if nes_workspace is None:
        print("error: workspace JSON has no WorkspaceByCpu.Nes section", file=sys.stderr)
        return 2

    new_watches = list(config.get("watches", {}).get("expressions", []))
    new_breakpoints = [build_breakpoint(e, default_bank_size)
                       for e in config.get("breakpoints", [])]

    preset_name = config.get("preset", {}).get("name", "<unnamed>")
    preset_desc = config.get("preset", {}).get("description", "")
    print(f"  preset:    {preset_name}")
    if preset_desc:
        print(f"             {preset_desc}")

    existing_watches = list(nes_workspace.get("WatchEntries", []))
    existing_breakpoints = list(nes_workspace.get("Breakpoints", []))

    if args.append:
        merged_watches = existing_watches + new_watches
        merged_breakpoints = existing_breakpoints + new_breakpoints
        print(f"  watches:   appending {len(new_watches)} -> total {len(merged_watches)}")
        print(f"  breakpts:  appending {len(new_breakpoints)} -> total {len(merged_breakpoints)}")
    else:
        merged_watches = new_watches
        merged_breakpoints = new_breakpoints
        print(f"  watches:   replacing {len(existing_watches)} -> {len(new_watches)}")
        print(f"  breakpts:  replacing {len(existing_breakpoints)} -> {len(new_breakpoints)}")

    if args.dry_run:
        print("\n(dry-run; no changes written)")
        for w in new_watches:
            print(f"    watch: {w}")
        for bp in new_breakpoints:
            print(f"    {describe_breakpoint(bp)}")
        return 0

    if not args.no_backup:
        backup_path = workspace_path.with_suffix(".json.bak")
        shutil.copy2(workspace_path, backup_path)
        print(f"  backup written: {backup_path}")

    nes_workspace["WatchEntries"] = merged_watches
    nes_workspace["Breakpoints"] = merged_breakpoints
    workspace_path.write_text(
        json.dumps(workspace, indent=2, ensure_ascii=False),
        encoding="utf-8-sig",
    )
    print(f"  wrote: {workspace_path}")
    print("\nclose Mesen 2 before running; Mesen rewrites the workspace JSON on shutdown")
    print("and will overwrite the preset.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

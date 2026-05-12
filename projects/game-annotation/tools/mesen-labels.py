r"""
mesen-labels.py — Inject named labels into a Mesen 2 workspace JSON.

Reads a TOML config of named addresses (RAM and PRG-ROM) and merges them into
the Mesen 2 per-game workspace JSON. Mesen's built-in register labels and any
manually-added labels at addresses we don't touch are preserved.

Mesen 2 stores per-game state in a Debugger folder; on Windows under WinGet the
default path is something like
    %LOCALAPPDATA%\Microsoft\WinGet\Packages\SourMesen.Mesen2_*\Debugger\
The workspace file is named "<ROM filename without .nes>.json".

Usage:
    python mesen-labels.py <config.toml>
    python mesen-labels.py <config.toml> --workspace "C:\\path\\to\\ROM.json"
    python mesen-labels.py <config.toml> --dry-run

The config TOML format:

    [meta]
    rom_name = "Nobunaga's Ambition (USA)"   # used to locate the workspace JSON
    prg_bank_size = 0x4000                   # default: 0x4000 (16 KB, standard MMC)

    [ram]                                    # $0000-$07FF NES CPU memory
    "0x0050" = { name = "brk_dispatch_id", comment = "Task ID for next BRK" }
    "0x0074" = { name = "palette_dirty" }    # comment optional

    [prg.bank15]                             # PRG-ROM offsets for bank 15
    "0xC54F" = { name = "nmi_off", comment = "Clear bit 7 of PPUCTRL shadow" }
    "0xC7A5" = { name = "music_driver" }

Multi-line comments are supported via TOML's triple-quoted strings.
"""

import argparse
import json
import os
import shutil
import sys
import tomllib
from pathlib import Path

DEFAULT_MESEN_DEBUGGER_GLOB = (
    "Microsoft/WinGet/Packages/SourMesen.Mesen2_*/Debugger"
)


def find_default_workspace(rom_name: str) -> Path | None:
    """Search the standard WinGet install location for the workspace JSON."""
    local_appdata = os.environ.get("LOCALAPPDATA")
    if not local_appdata:
        return None
    root = Path(local_appdata)
    for candidate in root.glob(f"{DEFAULT_MESEN_DEBUGGER_GLOB}/{rom_name}.json"):
        return candidate
    return None


def cpu_to_prg_offset(cpu_addr: int, bank_idx: int, bank_size: int) -> int:
    """Convert a CPU-visible address + bank index to a PRG-ROM file offset.

    Works for standard 16 KB bank schemes (NROM, MMC1, MMC3 PRG, etc.):
    the low log2(bank_size) bits of the CPU address index into the bank.
    """
    bank_mask = bank_size - 1
    return bank_idx * bank_size + (cpu_addr & bank_mask)


def parse_hex_key(key: str) -> int:
    """Parse a TOML string key like '0xC54F' or '0x50' to an int."""
    key = key.strip()
    if key.startswith("0x") or key.startswith("0X"):
        return int(key, 16)
    return int(key, 0)


def build_labels(config: dict) -> list[dict]:
    """Return Mesen-format label entries from a parsed TOML config."""
    bank_size = config.get("meta", {}).get("prg_bank_size", 0x4000)
    out: list[dict] = []

    # RAM labels (CPU memory $0000-$07FF)
    for hex_key, info in config.get("ram", {}).items():
        addr = parse_hex_key(hex_key)
        out.append({
            "Address": addr,
            "MemoryType": "NesMemory",
            "Label": info["name"],
            "Comment": info.get("comment", ""),
            "Flags": "None",
            "Length": int(info.get("length", 1)),
        })

    # PRG-ROM labels (under [prg.bankN])
    for bank_key, entries in config.get("prg", {}).items():
        if not bank_key.startswith("bank"):
            print(f"  warning: unexpected [prg.{bank_key}] section, skipping", file=sys.stderr)
            continue
        try:
            bank_idx = int(bank_key.removeprefix("bank"))
        except ValueError:
            print(f"  warning: cannot parse bank index from '{bank_key}', skipping", file=sys.stderr)
            continue
        for hex_key, info in entries.items():
            cpu_addr = parse_hex_key(hex_key)
            prg_offset = cpu_to_prg_offset(cpu_addr, bank_idx, bank_size)
            out.append({
                "Address": prg_offset,
                "MemoryType": "NesPrgRom",
                "Label": info["name"],
                "Comment": info.get("comment", ""),
                "Flags": "None",
                "Length": int(info.get("length", 1)),
            })

    return out


def merge_labels(existing: list[dict], new: list[dict]) -> tuple[list[dict], int]:
    """Drop any existing label whose (Address, MemoryType) is in `new`, then append `new`.

    Returns (merged_list, num_existing_replaced).
    """
    keys_to_replace = {(l["Address"], l["MemoryType"]) for l in new}
    replaced = sum(1 for l in existing if (l["Address"], l["MemoryType"]) in keys_to_replace)
    kept = [l for l in existing if (l["Address"], l["MemoryType"]) not in keys_to_replace]
    return kept + new, replaced


def main() -> int:
    parser = argparse.ArgumentParser(description="Inject labels into a Mesen 2 workspace JSON.")
    parser.add_argument("config", type=Path, help="Path to the TOML labels config.")
    parser.add_argument(
        "--workspace", type=Path,
        help="Path to the Mesen workspace JSON. Auto-detected from [meta].rom_name if omitted.",
    )
    parser.add_argument(
        "--dry-run", action="store_true",
        help="Print what would be written, don't modify the workspace JSON.",
    )
    parser.add_argument(
        "--no-backup", action="store_true",
        help="Skip writing a .bak file before overwriting the workspace JSON.",
    )
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

    workspace_path = args.workspace
    if workspace_path is None:
        workspace_path = find_default_workspace(rom_name)
        if workspace_path is None:
            print(
                f"error: could not auto-locate workspace JSON for '{rom_name}'.\n"
                f"       pass --workspace explicitly.",
                file=sys.stderr,
            )
            return 2
        print(f"  workspace: {workspace_path}")

    if not workspace_path.exists():
        print(f"error: workspace JSON not found: {workspace_path}", file=sys.stderr)
        print("       open the ROM in Mesen 2 once to generate it.", file=sys.stderr)
        return 2

    # Mesen writes the workspace JSON with a UTF-8 BOM.
    workspace = json.loads(workspace_path.read_text(encoding="utf-8-sig"))
    nes_workspace = workspace.get("WorkspaceByCpu", {}).get("Nes")
    if nes_workspace is None:
        print("error: workspace JSON has no WorkspaceByCpu.Nes section", file=sys.stderr)
        return 2

    new_labels = build_labels(config)
    existing = nes_workspace.get("Labels", [])
    merged, replaced = merge_labels(existing, new_labels)

    preserved = len(merged) - len(new_labels)
    print(f"  labels to write:     {len(new_labels)}")
    print(f"  existing replaced:   {replaced}")
    print(f"  existing preserved:  {preserved}  (Mesen built-ins + user-added)")

    if args.dry_run:
        print("\n(dry-run; no changes written)")
        for label in new_labels:
            mt = "PRG" if label["MemoryType"] == "NesPrgRom" else "RAM"
            print(f"    {mt} ${label['Address']:06X}  {label['Label']}")
        return 0

    if not args.no_backup:
        backup_path = workspace_path.with_suffix(".json.bak")
        shutil.copy2(workspace_path, backup_path)
        print(f"  backup written:      {backup_path}")

    nes_workspace["Labels"] = merged
    # Write back with the same UTF-8 BOM Mesen uses, so it doesn't see the file as changed-encoding.
    workspace_path.write_text(
        json.dumps(workspace, indent=2, ensure_ascii=False),
        encoding="utf-8-sig",
    )
    print(f"  wrote: {workspace_path}")
    print("\nremember to close Mesen 2 before running this; Mesen rewrites the")
    print("workspace JSON on shutdown and will overwrite these labels.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

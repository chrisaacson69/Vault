"""
dump-defaults.py — Extract Nobunaga's Ambition ROM defaults tables to a reference file.

Bank 3 of the ROM holds the static "new game" templates for both scenarios:
each scenario has a province-defaults table, secondary per-province tables,
a daimyo-defaults table, and parallel name tables for daimyos and provinces.

This tool walks all of them and emits a structured text reference.

Usage:  python dump-defaults.py <rom> [output.txt]
"""
import sys

rom = open(sys.argv[1], "rb").read()[16:]   # strip iNES header
out_path = sys.argv[2] if len(sys.argv) > 2 else "rom-defaults.txt"

def cpu_to_prg(cpu, bank=3):
    return (cpu - 0x8000) + bank * 0x4000

def rd16le(cpu):
    o = cpu_to_prg(cpu)
    return rom[o] | (rom[o+1] << 8)

def rd16be(cpu):
    o = cpu_to_prg(cpu)
    return (rom[o] << 8) | rom[o+1]

def read_name(cpu, slot_len):
    """Read a fixed-length name slot, trimming nulls."""
    o = cpu_to_prg(cpu)
    raw = rom[o:o+slot_len]
    end = raw.find(0)
    if end < 0:
        end = slot_len
    return raw[:end].decode("ascii", errors="replace")

# Name-slot lengths differ: daimyo names are 9-byte slots, province names 10-byte.
DAIMYO_NAME_SLOT = 9
PROVINCE_NAME_SLOT = 10

# Province record: 26 bytes = 13 x 16-bit LE.
# Field 0 = header (base koku). Fields 1-12 = gold, debt, town, rice, output,
# dams, loyalty, wealth, men, morale, skill, arms. (LE in ROM; SRAM is BE.)
PROV_FIELDS = ["header", "gold", "debt", "town", "rice", "output",
               "dams", "loyalty", "wealth", "men", "morale", "skill", "arms"]

def read_province_record(cpu):
    return [rd16le(cpu + i*2) for i in range(13)]

# Daimyo record: 7 bytes = age, Health, Drive, Luck, Charisma, IQ, status.
DAIMYO_FIELDS = ["age", "health", "drive", "luck", "charisma", "iq", "status"]

def read_daimyo_record(cpu):
    o = cpu_to_prg(cpu)
    return list(rom[o:o+7])

# --- Scenario table anchors (verified by inspection) ---
# IMPORTANT — daimyo/province index alignment:
#   daimyo[N] owns province[N] at game start (verified: all 16 pairings in the
#   17-fief scenario are historically accurate — Uesugi/Echigo, Tokugawa/Mikawa,
#   Oda/Owari, etc.). The daimyo table has ONE special leading record (the
#   "$xx32" slot, named "Hatakeyama" / "Kakizaki" — a neutral/ronin/template
#   entry, NOT a player clan), so the REAL daimyo table starts 7 bytes after the
#   0F 27 marker + 7 (i.e. marker is at $xx30, special record $xx32, real table
#   $xx39). The daimyo NAME table likewise has the special name first, so the
#   real names start 9 bytes in.
SCENARIOS = {
    "50-fief": {
        "province_defaults": 0x901C,
        "province_count": 50,
        "daimyo_special": 0x9532,    # the leading special record
        "daimyo_defaults": 0x9539,   # real daimyo table (matches province[N])
        "daimyo_count": 50,
        "daimyo_name_special": 0x97AB,
        "daimyo_names": 0x97B4,      # 9-byte slots, real names
        # Province NAME table has a special leading slot too ("Ezo" @ $9988),
        # exactly like the daimyo table. Real index 0 ("Mutsu") starts at $9992.
        # (An earlier $99E2 anchor was 8 slots too late and created a phantom
        # +8 name/stats offset — see verify-50fief-align.py.)
        "province_name_special": 0x9988,
        "province_names": 0x9992,    # 10-byte slots, real names
    },
    "17-fief": {
        "province_defaults": 0xB01C,
        "province_count": 17,
        "daimyo_special": 0xB532,
        "daimyo_defaults": 0xB539,
        "daimyo_count": 17,
        "daimyo_name_special": 0xB7AB,
        "daimyo_names": 0xB7B4,
        "province_names": 0xB992,
    },
}

lines = []
def emit(s=""):
    lines.append(s)

emit("Nobunaga's Ambition (USA) — ROM defaults reference")
emit("Extracted by dump-defaults.py from bank 3.")
emit("Province records: 26 bytes, 13x 16-bit LE. Daimyo records: 7 bytes.")
emit("NOTE: ROM stores 16-bit values little-endian; SRAM stores them big-endian")
emit("      (the boot bytecode byte-swaps during new-game initialization).")
emit("=" * 78)

for scen_name, cfg in SCENARIOS.items():
    emit()
    emit(f"### SCENARIO: {scen_name} ###")
    emit()

    # --- Province defaults ---
    emit(f"-- Province defaults table @ ${cfg['province_defaults']:04X} "
         f"({cfg['province_count']} records x 26 bytes) --")
    emit(f"{'idx':>3}  {'name':<12} " + " ".join(f"{f:>7}" for f in PROV_FIELDS))
    pbase = cfg["province_defaults"]
    nbase = cfg["province_names"]
    for i in range(cfg["province_count"]):
        rec = read_province_record(pbase + i*26)
        name = read_name(nbase + i*PROVINCE_NAME_SLOT, PROVINCE_NAME_SLOT)
        emit(f"{i:>3}  {name:<12} " + " ".join(f"{v:>7}" for v in rec))

    # --- Daimyo defaults ---
    emit()
    # The leading special record (not a player clan)
    sp_rec = read_daimyo_record(cfg["daimyo_special"])
    sp_name = read_name(cfg["daimyo_name_special"], DAIMYO_NAME_SLOT)
    emit(f"-- Daimyo special/leading record @ ${cfg['daimyo_special']:04X} "
         f"(name '{sp_name}') — neutral/ronin/template slot, NOT index 0 --")
    emit(f"     {sp_name:<12} " + " ".join(f"{v:>9}" for v in sp_rec))
    emit()
    emit(f"-- Daimyo defaults table @ ${cfg['daimyo_defaults']:04X} "
         f"({cfg['daimyo_count']} records x 7 bytes) — daimyo[N] owns province[N] --")
    emit(f"{'idx':>3}  {'clan':<12} " + " ".join(f"{f:>9}" for f in DAIMYO_FIELDS)
         + "   owns_province")
    dbase = cfg["daimyo_defaults"]
    dnbase = cfg["daimyo_names"]
    pnbase = cfg["province_names"]
    for i in range(cfg["daimyo_count"]):
        rec = read_daimyo_record(dbase + i*7)
        name = read_name(dnbase + i*DAIMYO_NAME_SLOT, DAIMYO_NAME_SLOT)
        prov = read_name(pnbase + i*PROVINCE_NAME_SLOT, PROVINCE_NAME_SLOT)
        emit(f"{i:>3}  {name:<12} " + " ".join(f"{v:>9}" for v in rec)
             + f"   {prov}")

with open(out_path, "w", encoding="utf-8") as f:
    f.write("\n".join(lines) + "\n")

print(f"Wrote {out_path} ({len(lines)} lines)")
# Echo a preview
for ln in lines[:30]:
    print("  " + ln)

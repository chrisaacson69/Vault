"""Locate daimyo defaults + name tables in PRG-ROM."""
data = open("Nobunaga's Ambition (USA).nes", "rb").read()
prg = data[16:]

def prg_to_cpu(off):
    bank = off // 0x4000
    within = off % 0x4000
    if bank == 15:
        return bank, 0xC000 + within
    return bank, 0x8000 + within

# --- 1. Daimyo name strings ---
# Known names: Tokugawa, Hatakeyama, Uesugi, Hojo, Imagawa, Takeda, Oda...
print("=== Daimyo/clan name strings in ROM ===")
for name in [b"Tokugawa", b"Hatakeya", b"Uesugi", b"Imagawa", b"Takeda", b"Nobunaga", b"Oda"]:
    positions = []
    pos = 0
    while True:
        i = prg.find(name, pos)
        if i < 0: break
        positions.append(i)
        pos = i + 1
    for p in positions:
        bank, cpu = prg_to_cpu(p)
        print(f"  '{name.decode()}' @ PRG ${p:05X} (bank {bank} CPU ${cpu:04X})")

# --- 2. Province name strings ---
print()
print("=== Province name strings in ROM ===")
for name in [b"Mikawa", b"Echigo", b"Owari", b"Musashi", b"Settsu"]:
    positions = []
    pos = 0
    while True:
        i = prg.find(name, pos)
        if i < 0: break
        positions.append(i)
        pos = i + 1
    for p in positions:
        bank, cpu = prg_to_cpu(p)
        print(f"  '{name.decode()}' @ PRG ${p:05X} (bank {bank} CPU ${cpu:04X})")

# --- 3. Daimyo stat defaults ---
# From SRAM (17-fief): Uesugi rec was age=$1E, H=$57, D=$6F, then L/Ch/IQ varied.
# But ROM defaults won't have drifted. Hojo: age=$16. Imagawa: age=$29.
# Try the distinctive age+health pairs. Uesugi $1E $57, Imagawa $29 $39.
print()
print("=== Daimyo stat default candidates (age+health pairs) ===")
for label, sig in [
    ("Uesugi age+H ($1E $57)", bytes([0x1E, 0x57])),
    ("Imagawa age+H ($29 $39)", bytes([0x29, 0x39])),
    ("Hojo age $16", bytes([0x16, 0x60])),
    ("Tsutsui young age $0B", bytes([0x0B, 0x5B])),
]:
    positions = []
    pos = 0
    while True:
        i = prg.find(sig, pos)
        if i < 0: break
        positions.append(i)
        pos = i + 1
    hits = []
    for p in positions[:8]:
        bank, cpu = prg_to_cpu(p)
        hits.append(f"bank{bank}/${cpu:04X}")
    print(f"  {label}: {len(positions)} matches: {hits}")

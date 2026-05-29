"""Search PRG-ROM for the initial Mikawa (and other fief) base-stats table."""
data = open("Nobunaga's Ambition (USA).nes", "rb").read()
prg = data[16:]  # skip iNES header (16 bytes)

# Turn-1 Mikawa values reported by user: gold=69, debt=0, town=66, rice=75, output=80, dams=80, loyalty=76, wealth=77, men=71, morale=75, skill=74, arms=73
# Distinctive: output=80 + dams=80 (two 80s in a row), loyalty=76, wealth=77 (76+77 = adjacent)

# 1-byte signatures
sigs_1byte = {
    "town,rice (42 4B)": bytes([0x42, 0x4B]),
    "output,dams (50 50)": bytes([0x50, 0x50]),
    "loyalty,wealth (4C 4D)": bytes([0x4C, 0x4D]),
    "men,morale,skill,arms (47 4B 4A 49)": bytes([0x47, 0x4B, 0x4A, 0x49]),
    "morale,skill,arms (4B 4A 49)": bytes([0x4B, 0x4A, 0x49]),
}

print("=== 1-byte stat signatures in full ROM ===")
for label, sig in sigs_1byte.items():
    positions = []
    pos = 0
    while True:
        i = prg.find(sig, pos)
        if i < 0: break
        positions.append(i)
        pos = i + 1
    bank_hits = {}
    for p in positions:
        bank = p // 0x4000
        bank_hits.setdefault(bank, []).append(p)
    print(f"  {label}: {len(positions)} matches across {len(bank_hits)} banks")
    for bank, ps in list(bank_hits.items())[:3]:
        examples = ps[:3]
        print(f"    bank {bank}: {len(ps)} hits, e.g. {[hex(p) for p in examples]}")

print()
print("=== 16-bit BE versions ===")
sigs_16be = {
    "men,morale,skill,arms (00 47 00 4B 00 4A 00 49)": bytes([0x00, 0x47, 0x00, 0x4B, 0x00, 0x4A, 0x00, 0x49]),
    "loyalty,wealth (00 4C 00 4D)": bytes([0x00, 0x4C, 0x00, 0x4D]),
    "output,dams (00 50 00 50)": bytes([0x00, 0x50, 0x00, 0x50]),
}
for label, sig in sigs_16be.items():
    positions = []
    pos = 0
    while True:
        i = prg.find(sig, pos)
        if i < 0: break
        positions.append(i)
        pos = i + 1
    if positions:
        for p in positions[:5]:
            bank = p // 0x4000
            cpu_addr = 0x8000 + (p % 0x4000) if bank != 15 else 0xC000 + (p % 0x4000)
            print(f"  {label}: PRG ${p:05X} (bank {bank} CPU ${cpu_addr:04X})")
    else:
        print(f"  {label}: 0 matches")

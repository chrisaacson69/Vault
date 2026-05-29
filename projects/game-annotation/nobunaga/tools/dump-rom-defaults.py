"""Dump the province defaults table in bank 3."""
data = open("Nobunaga's Ambition (USA).nes", "rb").read()
prg = data[16:]

# Bank 3 starts at PRG offset 3*0x4000 = 0xC000
# CPU $9265 -> PRG offset 0x9265 - 0x8000 + 0xC000 = 0xD265
# Show $9200-$92FF area (one full page around the match)
for cpu_addr in range(0x9200, 0x9300, 16):
    prg_off = (cpu_addr - 0x8000) + 0xC000
    row = prg[prg_off:prg_off + 16]
    hex_str = ' '.join(f"{b:02X}" for b in row)
    print(f"  ${cpu_addr:04X} (PRG ${prg_off:05X}): {hex_str}")

print()
print("=== As 16-bit BE values from $9240 to $929F ===")
for cpu_addr in range(0x9240, 0x92A0, 2):
    prg_off = (cpu_addr - 0x8000) + 0xC000
    val = (prg[prg_off] << 8) | prg[prg_off+1]
    print(f"  ${cpu_addr:04X}: ${val:04X} = {val:5d}")

print()
print("=== Looking at $B0xx area too (likely 50-fief scenario defaults) ===")
for cpu_addr in range(0xB080, 0xB100, 16):
    prg_off = (cpu_addr - 0x8000) + 0xC000
    row = prg[prg_off:prg_off + 16]
    hex_str = ' '.join(f"{b:02X}" for b in row)
    print(f"  ${cpu_addr:04X}: {hex_str}")

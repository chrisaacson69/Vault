"""Map the 17-fief scenario tables in the $B0xx region of bank 3."""
data = open("Nobunaga's Ambition (USA).nes", "rb").read()
prg = data[16:]

def cpu_to_prg(cpu):
    return (cpu - 0x8000) + 3 * 0x4000  # bank 3

# Province defaults header candidates in $B000-$B400
print("=== 17-fief province-defaults headers ($B000-$B400) ===")
prev = None
count = 0
for cpu in range(0xB000, 0xB400, 2):
    off = cpu_to_prg(cpu)
    val = prg[off] | (prg[off+1] << 8)
    if 256 <= val <= 4000:
        delta = (cpu - prev) if prev else 0
        if delta == 26 or prev is None:
            count += 1
        print(f"  ${cpu:04X}: ${val:04X} = {val:5d}  (delta {delta})")
        prev = cpu
print(f"  -> ~{count} province records detected")

# Daimyo defaults: look for 7-byte records. Scan $B400-$B800 for the $0F27 marker
# (the 50-fief daimyo table started with 0F 27).
print()
print("=== Searching $B400-$B800 for daimyo table marker (0F 27) ===")
for cpu in range(0xB400, 0xB800):
    off = cpu_to_prg(cpu)
    if prg[off] == 0x0F and prg[off+1] == 0x27:
        print(f"  0F 27 marker @ ${cpu:04X}")

print()
print("=== Hex dump $B400-$B7C0 (daimyo defaults + start of names) ===")
for cpu in range(0xB400, 0xB7C0, 16):
    off = cpu_to_prg(cpu)
    row = prg[off:off+16]
    ascii_str = ''.join(chr(b) if 0x20 <= b <= 0x7E else '.' for b in row)
    print(f"  ${cpu:04X}: " + ' '.join(f'{b:02X}' for b in row) + f"  |{ascii_str}|")

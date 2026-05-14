"""Map bank 3's table layout — find table boundaries."""
data = open("Nobunaga's Ambition (USA).nes", "rb").read()
prg = data[16:]

def cpu_to_prg(cpu):
    return (cpu - 0x8000) + 3 * 0x4000  # bank 3

# Province defaults: 26-byte records. We found Mikawa at $9258.
# Find the table start by scanning backward — records have a 16-bit header then 24 bytes.
# The $E8 03 pattern (= 1000) appeared as a recurring header. Let's find all $03 high-byte
# 16-bit values that could be headers, in the $9000-$9300 range.
print("=== Province-defaults header candidates ($9000-$9420) ===")
print("(16-bit LE values 256-4000, which look like base-koku headers)")
prev = None
for cpu in range(0x9000, 0x9420, 2):
    off = cpu_to_prg(cpu)
    val = prg[off] | (prg[off+1] << 8)  # little-endian
    if 256 <= val <= 4000:
        delta = (cpu - prev) if prev else 0
        print(f"  ${cpu:04X}: ${val:04X} = {val:5d}   (delta from prev: {delta})")
        prev = cpu

print()
print("=== Hex dump $9240-$9420 (province defaults table area) ===")
for cpu in range(0x9240, 0x9420, 16):
    off = cpu_to_prg(cpu)
    row = prg[off:off+16]
    print(f"  ${cpu:04X}: " + ' '.join(f'{b:02X}' for b in row))

print()
print("=== Hex dump $9420-$9880 (between province defaults and daimyo names) ===")
for cpu in range(0x9420, 0x9880, 16):
    off = cpu_to_prg(cpu)
    row = prg[off:off+16]
    ascii_str = ''.join(chr(b) if 0x20 <= b <= 0x7E else '.' for b in row)
    print(f"  ${cpu:04X}: " + ' '.join(f'{b:02X}' for b in row) + f"  |{ascii_str}|")

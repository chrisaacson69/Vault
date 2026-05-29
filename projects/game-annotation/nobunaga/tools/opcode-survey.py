"""Dump the full opcode -> handler mapping and cluster by handler."""
import sys
from collections import defaultdict

rom = open(sys.argv[1], "rb").read()[16:]  # strip iNES header
lo = rom[0x3F026:0x3F126]
hi = rom[0x3F126:0x3F226]

# Build opcode -> handler map
opcodes = [(hi[i] << 8) | lo[i] for i in range(256)]

# Cluster: handler -> list of opcodes that use it
clusters = defaultdict(list)
for op, h in enumerate(opcodes):
    clusters[h].append(op)

# Sort by frequency (most opcodes first) so we tackle high-value handlers first
print(f"Total unique handlers: {len(clusters)}\n")
print(f"{'handler':<8} {'count':>5}  opcodes (hex)")
for h, ops in sorted(clusters.items(), key=lambda x: -len(x[1])):
    op_strs = []
    # Compress consecutive ranges
    if len(ops) == 1:
        op_strs = [f"${ops[0]:02X}"]
    else:
        start = ops[0]
        prev = ops[0]
        for o in ops[1:]:
            if o == prev + 1:
                prev = o
            else:
                op_strs.append(f"${start:02X}" if start == prev else f"${start:02X}-${prev:02X}")
                start = prev = o
        op_strs.append(f"${start:02X}" if start == prev else f"${start:02X}-${prev:02X}")
    print(f"${h:04X}    {len(ops):>5}  {' '.join(op_strs)}")

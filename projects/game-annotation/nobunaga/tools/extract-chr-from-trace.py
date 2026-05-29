#!/usr/bin/env python3
"""Reconstruct CHR-RAM from a Mesen trace's $C293/$C29C/$C2A1 events.

The bulk uploader sets PPU addr via $C293 (high) and $C29C (low),
then writes bytes one at a time via $C2A1. Reading the trace in order
lets us reconstruct the full CHR pattern table at PPU $1000-$1FFF.
"""
import os, re

TRACE = r"C:\Users\Chris.Isaacson\AppData\Local\Microsoft\WinGet\Packages\SourMesen.Mesen2_Microsoft.Winget.Source_8wekyb3d8bbwe\Debugger\Nobunaga's Ambition (USA).txt"

PC_RE = re.compile(r"^([0-9A-F]{4}) ")
A_RE  = re.compile(r"\bA:([0-9A-F]{2})")
EQ_RE = re.compile(r"= \$([0-9A-F]{2})")

# Track PPU address as $C293 (hi) and $C29C (lo) writes happen, then accumulate bytes
ppu_hi = 0
ppu_lo = 0
ppu_addr = 0
chr_data = bytearray(0x2000)  # PPU $0000-$1FFF range we care about

with open(TRACE, encoding='latin-1') as f:
    for line in f:
        pc_m = PC_RE.match(line)
        if not pc_m: continue
        pc = pc_m.group(1)

        if pc == 'C293':
            # LDA $006B — high byte of PPU dest
            m = EQ_RE.search(line)
            if m: ppu_hi = int(m.group(1), 16)
        elif pc == 'C299':
            # LDA $006A — low byte of PPU dest (next instr stores to $2006)
            m = EQ_RE.search(line)
            if m:
                ppu_lo = int(m.group(1), 16)
                ppu_addr = (ppu_hi << 8) | ppu_lo
        elif pc == 'C2A1':
            a_m = A_RE.search(line)
            if a_m:
                byte = int(a_m.group(1), 16)
                if ppu_addr < 0x2000:   # CHR-RAM range
                    chr_data[ppu_addr] = byte
                ppu_addr = (ppu_addr + 1) & 0x3FFF

# Save to a file the renderer can read
here = os.path.dirname(os.path.abspath(__file__))
out = os.path.join(here, 'title-chr.bin')
with open(out, 'wb') as f:
    # Save the PPU $1000-$1FFF range (4 KB)
    f.write(chr_data[0x1000:0x2000])
print(f"Wrote {out}  (4096 bytes from PPU $1000-$1FFF reconstructed from trace)")

# Sanity check — how many bytes got written
written = sum(1 for b in chr_data[0x1000:0x2000] if b != 0)
print(f"  {written} of 4096 bytes are non-zero")

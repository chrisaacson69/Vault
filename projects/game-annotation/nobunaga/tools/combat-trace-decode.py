#!/usr/bin/env python3
"""Parse the combat trace and reconstruct nametable writes + bulk uploads.

Trace format (filtered):
  PC  MNEMONIC  ...  A:NN X:NN Y:NN  S:NN  P:flags  Fr:NNNN  Cycle:NNNN  BC:bytes
"""
import os, re, sys, gzip

here = os.path.dirname(os.path.abspath(__file__))
# Default = Mesen's live trace; pass a path (incl. an archived traces/*.txt[.gz]) to decode that instead.
DEFAULT_TRACE = r"C:\Users\Chris.Isaacson\AppData\Local\Microsoft\WinGet\Packages\SourMesen.Mesen2_Microsoft.Winget.Source_8wekyb3d8bbwe\Debugger\Nobunaga's Ambition (USA).txt"
TRACE = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_TRACE


def _open_trace(path):
    """Transparent gzip: archived traces can be gzipped without breaking decode."""
    if str(path).endswith(".gz"):
        return gzip.open(path, "rt", encoding="latin-1")
    return open(path, encoding="latin-1")

# Regexes
PC_RE   = re.compile(r"^([0-9A-F]{4}) ")
A_RE    = re.compile(r"\bA:([0-9A-F]{2})")
FR_RE   = re.compile(r"\bFr:(\d+)")
ADDR_RE = re.compile(r"\[\$([0-9A-F]{4})\]")  # the [$XXXX] resolved-address in trace
EQ_RE   = re.compile(r"= \$([0-9A-F]{2})")    # "= $XX" old value

# Group events into "row uploads" each starting with $C480
events = []
current_row = None
bulk_blocks = []
current_bulk = None

with _open_trace(TRACE) as f:
    for line in f:
        pc_m = PC_RE.match(line)
        if not pc_m: continue
        pc = pc_m.group(1)
        a_m = A_RE.search(line)
        a_val = int(a_m.group(1), 16) if a_m else None
        fr_m = FR_RE.search(line)
        fr = int(fr_m.group(1)) if fr_m else None
        eq_m = EQ_RE.search(line)
        addr_m = ADDR_RE.search(line)

        if pc == 'C480':
            # Start of a new row upload — save the previous one first
            if current_row is not None:
                events.append(current_row)
            current_row = {'fr_start': fr, 'ppu_hi': None, 'ppu_lo': None, 'bytes': [], 'sources': []}
            # The trace shows "LDA $0068 = $XX" where $XX is the value read into A
            if eq_m:
                current_row['ppu_hi'] = int(eq_m.group(1), 16)
        elif pc == 'C486':
            if eq_m and current_row is not None:
                current_row['ppu_lo'] = int(eq_m.group(1), 16)
        elif pc == 'C49A':
            # LDA ($5C,X) [$XXXX] — source address resolved
            if addr_m and current_row is not None:
                current_row['sources'].append(int(addr_m.group(1), 16))
        elif pc == 'C4B5':
            # The byte being written = A register
            if a_val is not None and current_row is not None:
                current_row['bytes'].append(a_val)
        elif pc == 'C293':
            if current_bulk is not None:
                bulk_blocks.append(current_bulk)
            current_bulk = {'fr_start': fr, 'ppu_hi': None, 'ppu_lo': None, 'bytes': [], 'sources': []}
            if eq_m:
                current_bulk['ppu_hi'] = int(eq_m.group(1), 16)
        elif pc == 'C299':
            if eq_m and current_bulk is not None:
                current_bulk['ppu_lo'] = int(eq_m.group(1), 16)
        elif pc == 'C29F':
            if addr_m and current_bulk is not None:
                current_bulk['sources'].append(int(addr_m.group(1), 16))
        elif pc == 'C2A1':
            if a_val is not None and current_bulk is not None:
                current_bulk['bytes'].append(a_val)

# Flush
if current_row is not None: events.append(current_row)
if current_bulk is not None: bulk_blocks.append(current_bulk)

print(f"Parsed {len(events)} row uploads and {len(bulk_blocks)} bulk blocks")
print()

# Group row uploads into "scenes" — a scene is a sequence of row uploads with
# no big frame gaps (or no bulk uploads breaking them up).
print("=== Row uploads, summary ===")
print(f"{'#':>4} {'Fr':>6} {'PPU':>6} {'Len':>4} {'Mode':>5}  {'src start':>10}  bytes (first 16)")
for i, e in enumerate(events):
    if e['ppu_hi'] is None or e['ppu_lo'] is None: continue
    ppu = (e['ppu_hi'] << 8) | e['ppu_lo']
    n = len(e['bytes'])
    mode = "IDX" if e['sources'] else "FILL"
    src = f"${e['sources'][0]:04X}" if e['sources'] else "—"
    head = ' '.join(f"{b:02X}" for b in e['bytes'][:16])
    print(f"{i:>4} {e['fr_start']:>6} ${ppu:04X} {n:>4} {mode:>5}  {src:>10}  {head}")

print()
print("=== Bulk blocks, summary ===")
print(f"{'#':>4} {'Fr':>6} {'PPU':>6} {'Len':>5}  {'src start':>10}")
for i, b in enumerate(bulk_blocks):
    if b['ppu_hi'] is None or b['ppu_lo'] is None: continue
    ppu = (b['ppu_hi'] << 8) | b['ppu_lo']
    n = len(b['bytes'])
    src = f"${b['sources'][0]:04X}" if b['sources'] else "—"
    print(f"{i:>4} {b['fr_start']:>6} ${ppu:04X} {n:>5}  {src:>10}")

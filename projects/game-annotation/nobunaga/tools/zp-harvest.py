#!/usr/bin/env python3
"""
Harvest zero-page usage statistics from disasm6 output.

Walks every bank_NN.asm file in the current directory and tallies:
  - reads, writes, RMW operations per ZP address
  - indirect-mode and indexed-mode access counts
  - which banks touch each address
  - representative source lines for context

Usage:
    cd projects/game-annotation/nobunaga/disasm
    python3 ../tools/zp-harvest.py

Output: sorted table of ZP usage by total access count.
"""
import re
import glob
from collections import defaultdict

READ_OPS = {'lda', 'ldx', 'ldy', 'bit', 'cmp', 'cpx', 'cpy',
            'adc', 'sbc', 'and', 'ora', 'eor'}
WRITE_OPS = {'sta', 'stx', 'sty'}
RMW_OPS = {'inc', 'dec', 'asl', 'lsr', 'rol', 'ror'}
ALL_OPS = READ_OPS | WRITE_OPS | RMW_OPS

# 2-byte ZP form, e.g. `sta $73` or `lda ($73),y`
PAT_ZP = re.compile(
    r'\b(' + '|'.join(ALL_OPS) + r')\s+(\(?)\$([0-9a-f]{2})\b',
    re.IGNORECASE,
)
# 3-byte absolute form targeting ZP, e.g. `sta $0073`
PAT_ABS = re.compile(
    r'\b(' + '|'.join(ALL_OPS) + r')\s+\$00([0-9a-f]{2})\b',
    re.IGNORECASE,
)


def classify(op):
    op = op.lower()
    if op in READ_OPS:
        return 'r'
    if op in WRITE_OPS:
        return 'w'
    return 'rmw'


def main():
    stats = defaultdict(lambda: {
        'r': 0, 'w': 0, 'rmw': 0, 'ind': 0, 'idx': 0,
        'banks': set(), 'examples': [],
    })
    files = sorted(glob.glob('bank_*.asm'))
    if not files:
        raise SystemExit('no bank_NN.asm files in cwd — run from disasm/')
    for fname in files:
        bank = int(re.search(r'bank_(\d+)', fname).group(1))
        with open(fname) as f:
            for line in f:
                for m in PAT_ZP.finditer(line):
                    op = m.group(1)
                    indirect = m.group(2) == '('
                    addr = int(m.group(3), 16)
                    record(stats, addr, bank, op, line, indirect, m.end())
                for m in PAT_ABS.finditer(line):
                    op = m.group(1)
                    addr = int(m.group(2), 16)
                    record(stats, addr, bank, op, line, False, m.end(), absform=True)
    print_table(stats)


def record(stats, addr, bank, op, line, indirect, after_match, absform=False):
    cls = classify(op)
    stats[addr][cls] += 1
    if indirect:
        stats[addr]['ind'] += 1
    if ',x' in line.lower()[after_match:after_match + 4] or \
       ',y' in line.lower()[after_match:after_match + 4]:
        stats[addr]['idx'] += 1
    stats[addr]['banks'].add(bank)
    if len(stats[addr]['examples']) < 3:
        marker = f'b{bank:02d}{"*" if absform else ""}'
        stats[addr]['examples'].append(f'{marker}: {line.strip()[:70]}')


def print_table(stats):
    print(f'ZP usage across all banks ({len(stats)} addresses touched)')
    print(f'{"Addr":6} {"R":>5} {"W":>5} {"RMW":>5} {"ind":>4} {"idx":>4} {"banks":<22} example')
    print('-' * 120)
    items = sorted(stats.items(),
                   key=lambda kv: -(kv[1]['r'] + kv[1]['w'] + kv[1]['rmw']))
    for addr, s in items:
        total = s['r'] + s['w'] + s['rmw']
        if total == 0:
            continue
        banks = ','.join(str(b) for b in sorted(s['banks']))
        example = s['examples'][0] if s['examples'] else ''
        print(f'${addr:02X}    {s["r"]:5d} {s["w"]:5d} {s["rmw"]:5d} '
              f'{s["ind"]:>4d} {s["idx"]:>4d} {banks:<22} {example}')


if __name__ == '__main__':
    main()

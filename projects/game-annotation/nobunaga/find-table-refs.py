#!/usr/bin/env python3
"""Find every reference to a given little-endian word in the ROM."""
import sys, os

rom_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Nobunaga's Ambition (USA).nes")
with open(rom_path, 'rb') as f:
    data = f.read()
rom = data[16:]   # skip iNES header

PRG_BANK = 0x4000

def find_word(word, label):
    le = bytes([word & 0xFF, (word >> 8) & 0xFF])
    print(f"\n=== References to ${word:04X} ({label}) ===")
    for i in range(len(rom) - 1):
        if rom[i:i+2] == le:
            bank = i // PRG_BANK
            offset = i % PRG_BANK
            cpu = 0x8000 + offset if bank < 15 else 0xC000 + offset
            print(f"  PRG ${i:05X}  bank {bank:2d}  CPU ${cpu:04X}")

# Key candidate addresses to look up
for word, name in [
    (0xA57E, "tactical map cell-index table base (ch 15)"),
    (0x7BFD, "SRAM staging buffer start (combat trace)"),
    (0xA05E, "per-fief CHR-RAM source (combat trace)"),
    (0x1550, "CHR-RAM destination for combat tiles"),
    (0x822A, "combat-screen entry stub (ch 15)"),
    (0xDC88, "cell reader (ch 15)"),
    (0xCBBD, "metatile renderer (chapter 14 guess)"),
]:
    find_word(word, name)

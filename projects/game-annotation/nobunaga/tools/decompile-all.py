"""Decompile-all driver — the "see the whole picture" payoff (EPIC step 3b/4).

Persists `decompiled/bank_NN.c`: every bytecode subroutine in the 4 CODE banks
(0, 1, 2, 15 — banks 03-14 are data, 0 bytecode subs), decompiled to readable C.
Deterministic: fixed ROM -> identical C forever, so this is run ONCE and the .c
files are committed. Reading the engine becomes opening a file, never re-running
a tool. Regenerate only when vm-disasm.py or vm_decompile.py themselves improve.

Pipeline (all execution-validated, see ROADMAP / project_nobunaga_vm_disasm_recovered):
  vm-disasm.py  ROM -> v2 VM-asm listing (correct lengths, recursive-descent subs)
  vm_decompile.py  listing -> C  (spec-agnostic: dispatch keyed on the opcode byte)

Usage:
  py -3 tools/decompile-all.py                 # all 4 code banks -> decompiled/
  py -3 tools/decompile-all.py --banks 1       # one bank
  py -3 tools/decompile-all.py --out-dir foo   # alternate output dir
"""

import argparse
import io
import importlib.util
import re
import sys
import tempfile
from contextlib import redirect_stdout
from pathlib import Path

HERE = Path(__file__).parent
ROOT = HERE.parent
sys.path.insert(0, str(HERE))

LABELS_TOML = ROOT / "mesen-labels.toml"


def _switchable_section_labels():
    """Per-bank names for the switchable $8000-$BFFF window, parsed straight from the
    [prg.bankN] toml sections. Returns (bank_names, sectioned):
      bank_names[bank][addr] = name  — the authoritative name for that addr IN that bank
      sectioned = {addr, ...}        — every window addr that appears in ANY [prg.bankN]

    Banks 0/1/2 share the $8000-$BFFF CPU window, and the SAME CPU address can hold a
    DIFFERENT function in each bank (different ROM bytes at the same address — e.g. $8003
    is display_fullscreen_graphic_sequence in bank 0 but prompt_message_and_redraw in
    bank 1). `nobunaga_vm.load_labels()` flattens the toml to {addr: name}, which (a)
    discards the section AND (b) keeps only one name per address — so the decompiler was
    both bank-blind and dual-bank-blind for the window (bug surfaced 2026-05-31 by the
    regen guard for the section problem; the dual-bank case surfaced 2026-06-01 by the
    bank_00 label-walk: $8003/$8DE1 stayed anon because bank 1's entries shadowed bank 0's).
    Keying names by (bank, addr) resolves both: each bank's C uses its own section's name.

    RAM/ZP (<$8000) and fixed bank-15 ($C000+) labels are bank-independent and stay global
    (applied from vm.labels), so they are intentionally not collected here. ~73 $C000+
    labels mis-filed under [prg.bank0] are >= $C000, fall outside the window, remain global.
    """
    text = LABELS_TOML.read_text(encoding="utf-8")
    sec_re = re.compile(r'^\s*\[prg\.bank(\d+)\]')
    lbl_re = re.compile(r'"0x([0-9A-Fa-f]+)"\s*=\s*\{\s*name\s*=\s*"([^"]*)"')
    bank_names, sectioned, cur = {}, set(), None
    for line in text.splitlines():
        m = sec_re.match(line)
        if m:
            cur = int(m.group(1)); continue
        if line.lstrip().startswith('['):      # left the prg.bankN sections
            cur = None; continue
        m = lbl_re.search(line)
        if m and cur is not None:
            addr = int(m.group(1), 16)
            if 0x8000 <= addr < 0xC000:
                bank_names.setdefault(cur, {})[addr] = m.group(2)
                sectioned.add(addr)
    return bank_names, sectioned


SWITCHABLE_NAMES, SECTIONED_WINDOW = _switchable_section_labels()


def _load(name, filename):
    spec = importlib.util.spec_from_file_location(name, HERE / filename)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


vmdisasm = _load("vmdisasm", "vm-disasm.py")
import vm_decompile  # underscore name → importable directly
from nobunaga_vm import NobunagaVM

CODE_BANKS = [0, 1, 2, 15]   # the only banks containing bytecode (rest are data)


def bank_subs(bank, tmp_dir):
    """Decompile every sub in `bank`, returning (labels, subs, misaligned) where
    subs = [(stub_addr, sub_c_text), ...]. The shared decompile core of the per-bank
    writer (`decompile_bank`) AND the merged PRG view (`decompile-merged.py`), so both
    produce byte-identical C from the same pipeline (single source of truth).

    Bank-aware label set: global labels (<$8000 RAM/ZP, >=$C000 fixed bank 15) and any
    window addr with NO [prg.bankN] section entry come from the flattened vm.labels (the
    latter preserves prior default-keep behavior). For the switchable $8000-$BFFF window,
    names come from THIS bank's toml section (SWITCHABLE_NAMES[bank]) — never the flattened
    dict, which holds only one name per address and would bleed another bank's name onto a
    CPU address that legitimately holds a different function in each bank.
    """
    vm = NobunagaVM()
    vm.switch_bank(bank)
    mem = vm.mem
    base, size = vmdisasm.bank_range(bank)
    stubs = vmdisasm.find_stubs(mem, base, size)
    labels = {a: n for a, (n, _c) in vm.labels.items()
              if not (0x8000 <= a < 0xC000) or a not in SECTIONED_WINDOW}
    labels.update(SWITCHABLE_NAMES.get(bank, {}))

    # Render the execution-validated v2 listing for this bank (intermediate; not
    # committed — vm-disasm.py regenerates it deterministically on demand).
    listing, misaligned = vmdisasm.render(bank, stubs, mem, labels, len(vm.labels))
    asm_path = tmp_dir / f"bank_{bank:02d}_vm.v2.asm"
    asm_path.write_text(listing, encoding="utf-8")

    # Decompile each sub (vm_decompile prints to stdout — capture per sub). Drop the
    # per-sub "// Decompiled from <path>" line: it names the ephemeral temp listing
    # (non-deterministic path) and is redundant with the bank header.
    subs = []
    for stub in stubs:
        buf = io.StringIO()
        with redirect_stdout(buf):
            vm_decompile.decompile(str(asm_path), stub, labels)
        sub_c = "\n".join(l for l in buf.getvalue().splitlines()
                          if not l.startswith("// Decompiled from"))
        subs.append((stub, sub_c.rstrip("\n")))
    return labels, subs, misaligned


def decompile_bank(bank, out_dir, tmp_dir):
    """Decompile every sub in `bank` → out_dir/bank_NN.c. Returns (n_subs, n_lines)."""
    _labels, subs, misaligned = bank_subs(bank, tmp_dir)
    parts = [
        f"// ============================================================",
        f"// decompiled/bank_{bank:02d}.c  —  GENERATED by tools/decompile-all.py",
        f"// {len(subs)} bytecode subroutines from bank {bank} of "
        f"Nobunaga's Ambition (USA).nes",
        f"// Deterministic (fixed ROM -> identical C). DO NOT hand-edit — "
        f"regenerate via the tool.",
        f"// Pipeline: vm-disasm.py (v2, execution-validated lengths) -> "
        f"vm_decompile.py (opcode-keyed).",
        f"// ============================================================",
        "",
    ]
    if misaligned:
        parts.append(f"// WARNING: {misaligned} subs did not tile cleanly "
                     f"(see vm-disasm.py --check {bank}).\n")

    for _stub, sub_c in subs:
        parts.append(sub_c)
        parts.append("")  # blank line between subs

    text = "\n".join(parts) + "\n"
    out_path = out_dir / f"bank_{bank:02d}.c"
    out_path.write_text(text, encoding="utf-8")
    return len(subs), text.count("\n")


def main():
    ap = argparse.ArgumentParser(description="Decompile-all driver")
    ap.add_argument("--banks", default=",".join(map(str, CODE_BANKS)),
                    help="comma-separated bank list (default: the 4 code banks)")
    ap.add_argument("--out-dir", default=str(ROOT / "decompiled"),
                    help="output directory for bank_NN.c (default: ./decompiled)")
    ap.add_argument("--no-merged", action="store_true",
                    help="skip the merged PRG-keyed all_banks.c view (auto-built when the "
                         "full default bank set is decompiled; see decompile-merged.py)")
    args = ap.parse_args()

    banks = [int(b, 0) for b in args.banks.split(",") if b.strip()]
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    total_subs = total_lines = 0
    # Intermediate v2 listings are regenerable (vm-disasm.py is deterministic), so
    # they live in an ephemeral temp dir — only the .c files are persisted.
    with tempfile.TemporaryDirectory() as td:
        tmp_dir = Path(td)
        for bank in banks:
            n_subs, n_lines = decompile_bank(bank, out_dir, tmp_dir)
            total_subs += n_subs
            total_lines += n_lines
            print(f"  bank {bank:>2}: {n_subs:>3} subs -> "
                  f"{out_dir.name}/bank_{bank:02d}.c ({n_lines} lines)")
    print(f"\nDecompiled {total_subs} subroutines across {len(banks)} banks "
          f"({total_lines} lines of C) -> {out_dir}/")

    # Also regenerate the merged PRG-keyed view so it never drifts from the per-bank
    # files — a single `decompile-all.py` run keeps both in sync. Only when the full
    # default bank set was requested (a partial --banks run is a per-bank iteration;
    # the merged view is always all 4 code banks). Lazy import avoids a circular load.
    if not args.no_merged and banks == CODE_BANKS:
        merged = _load("decompile_merged", "decompile-merged.py")
        records, warnings = merged.build(bank_subs)
        merged_path = out_dir / "all_banks.c"
        merged_path.write_text(merged.render(records, warnings), encoding="utf-8")
        print(f"Merged PRG-keyed view: {len(records)} subs -> "
              f"{out_dir.name}/all_banks.c")
        for w in warnings:
            print(f"  warning: {w}")


if __name__ == "__main__":
    main()

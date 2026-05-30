#!/usr/bin/env python3
"""Render a fief's tactical map straight from ROM — no SaveRam capture needed.

Proven 2026-05-30: the map-populate routine (bank-2 sub $8903) reads only a tiny
input set — province ($6F63/$6F64) + a scenario fief-count constant ($6D9D, =17 for
the base 17-fief scenario, 50 for the 50-fief scenario) — and pulls the cell data
from ROM (province -> $F70E[province] map_id -> $A57E + map_id*55 in bank 4). Seeding
just those bytes into a blank SRAM and running $8903 reproduces the real staging
buffer at $7BFD byte-for-byte (1027/1027 vs a SaveRam-seeded run, Mino).

So: seed -> run $8903 -> the populated $7BFD IS the tactical map. We then hand it to
render-from-sram.py's decoder (the single source of truth for the $B100 metatile
dictionary and the 11x5 isometric grid layout).

Usage:
  py render-rom-to-map.py <province> [--scenario 17|50] [--label "..."] [--out name.png]
  py render-rom-to-map.py --sram <dump.dmp>   # read province + $6D9D FROM a dump, but
                                              # render the map from ROM (validation mode:
                                              # compare against render-from-sram.py <dump>)

Validation against a live battle: capture a SaveRam at the battle, then
  py probe-map-emit.py <dump> 8903            # rigorous: does $8903 reproduce the dump's $7BFD?
  py render-rom-to-map.py --sram <dump>       # our ROM-sourced render
  py render-from-sram.py <dump> 6000          # the actual captured render
and diff the two images / grids.
"""
import os, sys, importlib.util
from pathlib import Path

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
from nobunaga_vm import NobunagaVM

# Import render-from-sram.py despite the hyphenated filename (importlib, not `import`).
_spec = importlib.util.spec_from_file_location("render_from_sram", HERE / "render-from-sram.py")
rfs = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(rfs)

POPULATE_ENTRY = 0x8903   # bank-2 map-populate sub


def populate_from_rom(province, scenario=17):
    """Run $8903 with a blank SRAM seeded only with province + scenario constant.
    Returns the full 8 KB SRAM ($6000-$7FFF) with $7BFD populated from ROM."""
    vm = NobunagaVM()
    vm.switch_bank(2)                      # populate sub lives in bank 2; SRAM defaults to zeros
    vm.mem.write_word(0x6F63, province)    # province index (16-bit LE)
    vm.mem.write_word(0x6D9D, scenario)    # scenario fief-count / 17-vs-50 selector
    # Inject `AC <entry> CF` (CALL $8903 / RETURN) and run via the real frame prologue.
    vm.mem.write(0x300, 0xAC)
    vm.mem.write(0x301, POPULATE_ENTRY & 0xFF)
    vm.mem.write(0x302, (POPULATE_ENTRY >> 8) & 0xFF)
    vm.mem.write(0x303, 0xCF)
    vm.vm_pc = 0x300
    vm.cpu.pc = vm.DISPATCHER_ADDR
    ok = vm.run_until_outermost_return(max_ops=300000)
    todo = sorted({(t, n) for t, n, k in vm.syscall_log if k == "TODO"})
    return bytes(vm.mem.read(0x6000 + i) for i in range(0x2000)), ok, todo


def main():
    args = sys.argv[1:]
    province = scenario = None
    label = out = None
    if "--sram" in args:
        dump = args[args.index("--sram") + 1]
        data = Path(dump).read_bytes()
        # dump is an 8 KB SRAM image based at $6000
        province = data[0x6F63 - 0x6000] | (data[0x6F64 - 0x6000] << 8)
        scenario = data[0x6D9D - 0x6000] | (data[0x6D9E - 0x6000] << 8)
        label = label or f"ROM render of {Path(dump).name} (prov {province}, scen {scenario})"
        out = out or f"rom-{Path(dump).stem}.png"
        print(f"--sram {dump}: province={province} scenario(\$6D9D)={scenario}")
    else:
        province = int(args[0])
        scenario = int(args[args.index("--scenario") + 1]) if "--scenario" in args else 17
    if "--label" in args: label = args[args.index("--label") + 1]
    if "--out" in args:   out = args[args.index("--out") + 1]
    label = label or f"Province {province} (scenario {scenario}) — from ROM"
    out = out or f"rom-prov{province}-scen{scenario}.png"

    print(f"Populating province {province} (scenario {scenario}) from ROM via $8903...")
    sram, ok, todo = populate_from_rom(province, scenario)
    nz = sum(1 for b in sram[0x7BFD - 0x6000:] if b)
    print(f"  $8903 ok={ok}, {nz} nonzero bytes in $7BFD grid region")
    if todo:
        print(f"  WARNING — unresolved (TODO) syscalls fired: {todo}")
        print("    (a new scenario/path may need one implemented — see ROADMAP Open list)")

    # Write the populated SRAM where the decoder can read it, render, then clean up
    # the scratch dump (the ROM render is reproducible — no need to keep it around,
    # and a stray _rom_*.dmp would otherwise show up in the data-index scan).
    tmp = HERE.parent / "traces" / f"_rom_prov{province}_scen{scenario}.dmp"
    tmp.write_bytes(sram)
    try:
        rfs.render(str(tmp), out, label, dump_base=0x6000)
    finally:
        tmp.unlink(missing_ok=True)


if __name__ == "__main__":
    main()

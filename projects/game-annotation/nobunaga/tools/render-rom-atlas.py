#!/usr/bin/env python3
"""Render the WHOLE 50-fief tactical atlas straight from ROM — no captures.

Loops every province through the proven ROM->Map pipeline (seed province + $6D9D
=50 -> run populate $8903 -> decode $7BFD), writes one PNG per fief into
atlas/rom-50/, and prints a terrain-distribution summary table (the first time we
have all 50 tactical-map compositions without playing to 50 battles).

Validated cell-exact on Mino (17-fief), Tanba + Ezo (50-fief). See ROADMAP.

Usage:
  py render-rom-atlas.py [--scenario 17|50] [--count N]
"""
import sys, re, ast, io, contextlib, importlib.util
from pathlib import Path

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))


def _load(modname, filename):
    spec = importlib.util.spec_from_file_location(modname, HERE / filename)
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m

r2m = _load("render_rom_to_map", "render-rom-to-map.py")
rfs = _load("render_from_sram", "render-from-sram.py")

# Single source of truth for the 50 province names: parse NAMES out of
# adjacency-50.py without importing it (it has no __main__ guard / side effects).
_txt = (HERE / "adjacency-50.py").read_text(encoding="utf-8", errors="replace")
_m = re.search(r"NAMES\s*=\s*(\[.*?\])", _txt, re.DOTALL)
NAMES = ast.literal_eval(_m.group(1)) if _m else [f"prov{i}" for i in range(50)]

GLYPH = {'A': 'clear', 'B': 'forest', 'C': 'mountain', 'D': 'castle',
         'E': 'water', 'F': 'town', '.': 'void', '?': 'UNKNOWN'}


def grid_of(sram):
    def cell(a): return bytes(sram[a - 0x6000 + i] for i in range(16))
    return [[rfs.identify(cell(0x7BFD + c * 88 + (8 if c & 1 else 0) + r * 16))
             for c in range(11)] for r in range(5)]


def main():
    args = sys.argv[1:]
    scenario = int(args[args.index("--scenario") + 1]) if "--scenario" in args else 50
    count = int(args[args.index("--count") + 1]) if "--count" in args else (50 if scenario == 50 else 17)
    outdir = HERE / "atlas" / ("rom-50" if scenario == 50 else "rom-17")
    outdir.mkdir(parents=True, exist_ok=True)

    print(f"Rendering {count} fiefs (scenario {scenario}) from ROM -> {outdir}\n")
    print(f"{'#':>2}  {'fief':<10} {'cl':>3}{'fo':>3}{'mt':>3}{'wt':>3}{'ca':>3}{'tn':>3}{'vd':>3}{'?':>3}  flags")
    rows, anomalies = [], []
    tmp = HERE.parent / "traces" / "_rom_atlas_scratch.dmp"
    for p in range(count):
        name = NAMES[p] if p < len(NAMES) else f"prov{p}"
        sram, ok, todo = r2m.populate_from_rom(p, scenario)
        g = grid_of(sram)
        flat = [g[r][c] for r in range(5) for c in range(11)]
        cnt = {k: flat.count(k) for k in "ABCDEF.?"}
        flags = []
        if not ok: flags.append("RUN-FAIL")
        if todo: flags.append("TODO:" + ",".join(n for _, n in todo))
        if cnt['?']: flags.append(f"{cnt['?']}-unknown")
        if cnt['D'] != 1: flags.append(f"castle={cnt['D']}")
        if flags: anomalies.append((p, name, flags))
        print(f"{p:>2}  {name:<10} {cnt['A']:>3}{cnt['B']:>3}{cnt['C']:>3}{cnt['E']:>3}"
              f"{cnt['D']:>3}{cnt['F']:>3}{cnt['.']:>3}{cnt['?']:>3}  {' '.join(flags)}")
        # Render PNG via the shared decoder.
        tmp.write_bytes(sram)
        try:
            with contextlib.redirect_stdout(io.StringIO()):   # render() is chatty; mute it
                rfs.render(str(tmp), str(outdir / f"{p:02d}-{name}.png"),
                           f"{name} (prov {p}, {scenario}-fief) — from ROM", dump_base=0x6000)
        except Exception as e:
            print(f"      render error: {e}")
        rows.append((p, name, cnt, ok, todo))
    tmp.unlink(missing_ok=True)

    print(f"\nDone: {count} fiefs -> {outdir}")
    if anomalies:
        print(f"\n{len(anomalies)} fief(s) flagged for review:")
        for p, name, flags in anomalies:
            print(f"  #{p} {name}: {', '.join(flags)}")
    else:
        print("No anomalies — every fief rendered clean, 1 castle each, no unknown cells.")


if __name__ == "__main__":
    main()

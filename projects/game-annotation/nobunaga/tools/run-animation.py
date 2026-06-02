"""
run-animation.py — pull a command/event ANIMATION out of the ROM and render it,
purely from ROM bytes (no Mesen capture).

The game's animations are a small bytecode SCRIPTING VM:
  - `ui_helper_e80c(id)` stores the animation id at $7FCB, then calls bank 14.
  - bank-14 entry `$80AD` reads $7FCB, indexes a 5-byte descriptor table at
    bank-14 $AF80  -> {byte chr/data bank, word data_src, word command_stream}.
  - it loads the data block, writes the palette, uploads the base CHR, then runs
    a 22-opcode command stream that drives sprite frames (set_sprite -> OAM),
    palette cycles, sound (bank 10) and frame delays.

This tool drives `$80AD` in the headless VM (tools/nobunaga_vm), intercepts the
graphics syscalls to maintain a Python PPU model (CHR-RAM + palette + OAM),
snapshots a frame at each present point (prompt_redraw / delay_loop), and renders
each frame's sprites with the real NES palette -> PNG frames + an animated GIF.

Usage:
    py -3 tools/run-animation.py <id> [--sram traces/X.dmp] [--out atlas/anim]
                                 [--pt 0|1] [--h 8|16] [--scale N] [--trace]
    py -3 tools/run-animation.py --list      # dump the descriptor table

Animation ids (descriptor table $AF80): 9 = Grow. (others TBD as labeled.)
"""
import sys, argparse
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from nobunaga_vm import NobunagaVM
from PIL import Image

# Reusable from render-portrait.py (kept local to avoid a hard import dep).
NES_PALETTE = [
    (124,124,124),(0,0,252),(0,0,188),(68,40,188),(148,0,132),(168,0,32),(168,16,0),(136,20,0),
    (80,48,0),(0,120,0),(0,104,0),(0,88,0),(0,64,88),(0,0,0),(0,0,0),(0,0,0),
    (188,188,188),(0,120,248),(0,88,248),(104,68,252),(216,0,204),(228,0,88),(248,56,0),(228,92,16),
    (172,124,0),(0,184,0),(0,168,0),(0,168,68),(0,136,136),(0,0,0),(0,0,0),(0,0,0),
    (248,248,248),(60,188,252),(104,136,252),(152,120,248),(248,120,248),(248,88,152),(248,120,88),(252,160,68),
    (248,184,0),(184,248,24),(88,216,84),(88,248,152),(0,232,216),(120,120,120),(0,0,0),(0,0,0),
    (252,252,252),(164,228,252),(184,184,248),(216,184,248),(248,184,248),(248,164,192),(240,208,176),(252,224,168),
    (248,216,120),(216,248,120),(152,248,176),(176,248,204),(156,252,240),(248,212,252),(0,0,0),(0,0,0),
]

ANIM_DESC = 0xAF80     # bank 14, 5 bytes/entry: {bank, data_src(LE), stream(LE)}
ANIM_BANK = 14
ADDR_7FCB = 0x7FCB     # animation-id selector (written by ui_helper_e80c)
PPU_UPLOAD_WRAP = 0xCF7C   # ppu_upload_block_wrap(bank, src, dst_ppu, count)
DELAY_LOOP = 0xD73E
PROMPT_REDRAW = 0x8003
OAM_SHADOW = 0x0600    # set_sprite ($03) target: [Y, tile, attr, X] * 64
PAL_SHADOW = 0x0700    # palette_write ($04) target: 32 entries


def descriptor(vm, aid):
    base = ANIM_DESC + aid * 5
    b = [vm.read_banked(ANIM_BANK, (base + i) & 0xFFFF) for i in range(5)]
    return b[0], b[1] | (b[2] << 8), b[3] | (b[4] << 8)


def list_descriptors(vm):
    print("id  bank  data_src  stream")
    for aid in range(34):
        bank, src, stream = descriptor(vm, aid)
        mark = "  <- Grow" if aid == 9 else ""
        print(f"{aid:2d}   {bank:2d}    ${src:04X}     ${stream:04X}{mark}")


def decode_tile(chr_ram, addr, pal4):
    """2bpp tile at byte `addr` in chr_ram -> 8x8 list of (rgb, opaque?) using a 4-color palette."""
    out = []
    for y in range(8):
        p0 = chr_ram[(addr + y) & 0x1FFF]
        p1 = chr_ram[(addr + y + 8) & 0x1FFF]
        for x in range(8):
            v = ((p0 >> (7 - x)) & 1) | (((p1 >> (7 - x)) & 1) << 1)
            out.append((pal4[v], v != 0))   # color 0 = transparent for sprites
    return out


def run(aid, sram, pt_base, sprite_h, scale, trace, out_prefix):
    vm = NobunagaVM()
    vm.load_sram(sram)
    sel = vm.mem.read(0x6F5F)
    vm.mem.write(ADDR_7FCB, aid)

    bank, src, stream = descriptor(vm, aid)
    print(f"=== animation id {aid}: bank {bank}, data ${src:04X}, stream ${stream:04X} "
          f"(fief {sel}) ===")

    # --- Python PPU model ---
    chr_ram = bytearray(0x2000)          # two pattern tables
    frames = []                          # list of (oam_copy, pal_copy, chr_copy)
    state = {"uploads": 0, "present": 0}

    vm.switch_bank(ANIM_BANK)
    fp = 0x05FF
    vm.vm_fp = fp
    vm.vm_sp = (fp - 53) & 0xFFFF        # $80AD frame_off = -53
    vm.vm_pc = 0x80B2                    # body (skip prologue)
    vm.cpu.pc = vm.DISPATCHER_ADDR

    def snapshot():
        oam = bytes(vm.mem.read(OAM_SHADOW + i) for i in range(0x100))
        pal = bytes(vm.mem.read(PAL_SHADOW + i) for i in range(0x20))
        # dedupe identical consecutive frames (the loop redraws even when idle)
        if frames and frames[-1][0] == oam and frames[-1][1] == pal:
            return
        frames.append((oam, pal, bytes(chr_ram)))
        state["present"] += 1

    orig = vm.step_one_vm_op
    def hook():
        if vm.cpu.pc == vm.DISPATCHER_ADDR and vm.mem.read(vm.vm_pc) == 0xE9:
            tgt = vm.mem.read_word(vm.vm_pc + 1)
            sp = vm.vm_sp
            if tgt == PPU_UPLOAD_WRAP:
                ub, usrc, udst, ucnt = (vm.mem.read_word(sp), vm.mem.read_word(sp+2),
                                        vm.mem.read_word(sp+4), vm.mem.read_word(sp+6))
                nbytes = (ucnt & 0xFFFF) * 16   # count is in TILES (16 bytes/tile)
                for i in range(nbytes):
                    chr_ram[(udst + i) & 0x1FFF] = vm.read_banked(ub, (usrc + i) & 0xFFFF)
                state["uploads"] += 1
                if trace:
                    print(f"  upload  bank={ub} src=${usrc:04X} -> PPU ${udst:04X} x{ucnt} tiles")
            elif tgt in (DELAY_LOOP, PROMPT_REDRAW):
                snapshot()
                if trace:
                    print(f"  present @ ${'delay' if tgt==DELAY_LOOP else 'redraw'} "
                          f"frame#{state['present']}")
        return orig()
    vm.step_one_vm_op = hook

    try:
        vm.run_until_outermost_return(max_ops=200000)
    except Exception as e:
        print(f"  (stopped: {e})")
    snapshot()  # final

    print(f"uploads={state['uploads']}  frames={len(frames)}")
    if not frames:
        print("no frames captured"); return

    # --- render ---
    imgs = []
    for fi, (oam, pal, chr_snap) in enumerate(frames):
        active = [i for i in range(64) if oam[i*4] < 0xEF]
        canvas = Image.new("RGB", (256, 240), NES_PALETTE[pal[0] & 0x3F])
        px = canvas.load()
        for i in active:
            y, tile, attr, x = oam[i*4], oam[i*4+1], oam[i*4+2], oam[i*4+3]
            palsel = 0x10 + (attr & 3) * 4   # sprite palettes live at $3F10+
            pal4 = [NES_PALETTE[pal[palsel + k] & 0x3F] for k in range(4)]
            flipx, flipy = attr & 0x40, attr & 0x80
            rows = 2 if sprite_h == 16 else 1
            for r in range(rows):
                t = (tile & 0xFE) + r if sprite_h == 16 else tile
                addr = pt_base + t * 16
                tpx = decode_tile(chr_snap, addr, pal4)
                for ty in range(8):
                    for tx in range(8):
                        rgb, op = tpx[ty*8 + tx]
                        if not op:
                            continue
                        sx = x + (7 - tx if flipx else tx)
                        sy = y + r*8 + (7 - ty if flipy else ty)
                        if 0 <= sx < 256 and 0 <= sy < 240:
                            px[sx, sy] = rgb
        imgs.append(canvas)
        if trace:
            print(f"  frame {fi}: {len(active)} sprites")

    Path(out_prefix).parent.mkdir(parents=True, exist_ok=True)
    # crop to the sprite bounding box (+8px margin) so the GIF isn't mostly empty
    bbox = None
    for im in imgs:
        b = im.getbbox()
        if b:
            bbox = b if bbox is None else (min(bbox[0], b[0]), min(bbox[1], b[1]),
                                           max(bbox[2], b[2]), max(bbox[3], b[3]))
    if bbox:
        pad = 8
        bbox = (max(0, bbox[0]-pad), max(0, bbox[1]-pad),
                min(256, bbox[2]+pad), min(240, bbox[3]+pad))
        imgs = [im.crop(bbox) for im in imgs]

    w, h = imgs[0].size
    big = [im.resize((w*scale, h*scale), Image.NEAREST) for im in imgs]
    big[0].save(f"{out_prefix}.gif", save_all=True, append_images=big[1:],
                duration=120, loop=0, disposal=2)
    # contact sheet of frames
    cols = min(8, len(big))
    import math
    rows = math.ceil(len(big) / cols)
    sheet = Image.new("RGB", (cols*(w*scale+4), rows*(h*scale+4)), (40,40,40))
    for i, im in enumerate(big):
        sheet.paste(im, ((i % cols)*(w*scale+4)+2, (i // cols)*(h*scale+4)+2))
    sheet.save(f"{out_prefix}-frames.png")
    print(f"wrote {out_prefix}.gif ({len(big)} frames, {w}x{h}) + -frames.png")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("id", nargs="?", type=int)
    ap.add_argument("--sram", default="traces/exp-fall-1560-start.dmp")
    ap.add_argument("--out", default="atlas/anim")
    ap.add_argument("--pt", type=int, default=0, choices=(0, 1))
    ap.add_argument("--h", type=int, default=8, choices=(8, 16))
    ap.add_argument("--scale", type=int, default=3)
    ap.add_argument("--trace", action="store_true")
    ap.add_argument("--list", action="store_true")
    a = ap.parse_args()
    vm0 = NobunagaVM()
    if a.list:
        list_descriptors(vm0); return
    if a.id is None:
        ap.error("need an animation id (or --list)")
    out = f"{a.out}-{a.id}"
    run(a.id, a.sram, a.pt * 0x1000, a.h, a.scale, a.trace, out)


if __name__ == "__main__":
    main()

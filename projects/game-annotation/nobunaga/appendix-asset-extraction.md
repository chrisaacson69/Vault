---
status: active
created: 2026-06-01
---
# Appendix — True-Color ROM Asset Extraction
> How to pull any graphic out of the ROM and render it in the game's real NES colors, by following the game's own data path. Proven on the daimyo portraits (2026-06-01, `tools/render-portrait.py anthology`); this is the reusable recipe + the candidate-asset inventory.

**Links:** [tools/README](./tools/README.md) · [16-tactical-map-render](./16-tactical-map-render.md) · [project_nobunaga_visual_extraction] · [project_nobunaga_daimyo_portraits]

## Why this works

This cart is **CHR-RAM** (iNES byte5 = 0): tile bitmaps are not static in the ROM at fixed PPU addresses — the CPU **uploads** them at runtime. So you can't just `dd` a CHR bank and get a picture. Every on-screen graphic is assembled from three pieces the code moves around, and to render it faithfully you reconstruct the same three pieces the game does. The decompiled code (all 4 banks named, `decompiled/all_banks.c`) tells you where each piece lives.

## An NES CHR-RAM asset = three pieces

| Piece | What it is | How the game moves it | Where it lives |
|---|---|---|---|
| **CHR tiles** | the pixels — 8×8, **2bpp** (16 bytes/tile: 2 bitplanes) | `ppu_upload_block_wrap` ($CF7C) = `syscall_dispatch(…,1)` PRG→PPU bulk copy | a graphics bank; located via a **descriptor** the upload indexes `{bank, count, src_ptr}` |
| **Tile-index map** | which CHR tile goes in each screen cell (the nametable layout) | `ppu_blit_from_bank_wrap` ($CC54) = `syscall_dispatch(…,20)` | usually a **per-asset table** (e.g. portraits: `$B144 + id*36`), or built in SRAM at runtime |
| **Palette** | 4 NES master-palette indices (per 4-color set) → PPU `$3F00` | `palette_write_wrap` ($CF8B) → shadow `$0700` → NMI blit | a small ROM table read just before the draw (portraits: `$F7CC`) |

Render = decode each referenced CHR tile (2bpp → 4 palette slots) → place it per the tile-index map → color the 4 slots via the NES master palette. That's it.

## The recipe (repeatable)

1. **Find the draw routine.** Grep `decompiled/all_banks.c` for the asset's screen, or scan the **graphics entry points** (the 27 functions that call `ppu_upload_block_wrap` / `ppu_blit_from_bank_wrap` / `palette_write_wrap` — see inventory below).
2. **Read the BYTECODE of the upload/blit calls, not just the C.** ⚠️ The decompiler's host-call arg capture is **lossy** (it renders `?` / duplicate args). `py -3 tools/vm-disasm.py <bank> --stdout` and read the real `PUSH`/`CALL_abs_imm1` sequence — the true `{bank, src, count}`, the map pointer, and the dimensions are only reliable there. *(The portrait layout bug — a per-id `*36` map mistaken for a fixed table — was invisible in the C and obvious in the bytecode.)*
3. **Resolve cross-bank pointers by the upload's BANK ARG, not the pointer's operand bank.** ⚠️ `$8000-$BFFF` is the switchable MMC1 window, so the decompiler resolves a `$BBxx` operand to whatever string/data sits there in the *current* bank (e.g. portraits' `$BBD0` mis-resolved to `msg_ng_to_pieces`). The real source bank is the `bank` argument passed to the upload/blit syscall. Use the PRG offset (`bank*0x4000 + (cpu&0x3FFF)`) as the true identity. This is the #1 recurring trap (same as the bank-8 face tables, [[feedback_documented_vs_actual_behavior]]).
4. **Decode + assemble.** Reuse the primitives in `tools/render-portrait.py`: `NES_PALETTE` (64-color 2C02 master table) and the 2bpp tile decoder. Read the palette indices from the ROM table (don't hardcode), so the output is the game's true color.
5. **Validate against a real screenshot.** Render one known asset and diff against an emulator/game capture. The portrait crack's *final* bug (per-id map) survived a plausible-looking first render and was only caught by comparing Miyoshi to a real screenshot. **Always ground the last mile on a capture.**

### Worked example — daimyo portraits (preset path)
`draw_daimyo_portrait` ($E76F): palette ← `$F7CC` (4 idx `0x3E/0x38/0x28/0x30`); CHR ← descriptor table **bank 8 `$BBD0`** (4 B/entry `{bank, count, src}`, indexed by `fief_to_mapid(fief)`), portraits packed in **banks 7-8**, uploaded to `$15B0` = PT1 tile `0x5B`; layout ← **per-portrait** 6×6 map at **bank 8 `$B144` + mapid*36**; map cell `v` → tile `v-0x5B`. Output: `tools/render-portrait.py anthology` → `atlas/daimyo-anthology-{17,50}.png`, validated vs a game Miyoshi screenshot. Full detail: [[project_nobunaga_daimyo_portraits]].

## Candidate assets (the graphics entry points)

The 27 functions that emit graphics, grouped by asset. **✅ done · ◐ partial · ○ open.** Each is a ready target for this recipe.

- **Portraits** — `draw_daimyo_portrait` ✅ (preset, historical). `unpack_composite_face_record` ✅ (composite/generated daimyo: base-5 face code `$6EB1` → 4 feature digits → bank-8 CHR tables + **bank-9** tile-index maps `$AE34/$AE70/$AE8E/$AEAC`; rendered by `render-portrait.py random`, which also rolls a name via `generate_daimyo_name $DCB2` = syllable tables `$F930`+`$F95D`). Worked example of an asset whose tile-map is a *separate* bank from its CHR — the bank-9 map was the catch (the C is lossy; the syscall's bank-arg told the truth, same as gotcha #3).
- **Title / boot / cinematics** — `render_boot_title_screens` ○, `display_fullscreen_graphic_sequence` ○ (logo + ending/cutscene blobs; `atlas/title-screen.png` exists from an earlier method — re-do via this recipe for color + the full sequence).
- **Tactical map tiles** — `map_render_driver`, `upload_map_cell_tiles`, `build_blit_fief_tile_block` (per-fief 6×6 tile block at `$B144` *in bank 2*), `draw_tactical_terrain_feature`, `map_helper_e5f2`. ◐ The 50-fief map atlas already renders via `render-rom-to-map.py` (the RUN-the-populate approach), but in placeholder color — this recipe would give true palette.
- **Combat UI** — `render_combat_map_screen` (palette table `$B55A`), `draw_combat_roster_window`, `draw_unit_count_digits` (the unit-count font), `announce_battle_outcome_retreat_or_won`, `battle_setup_select_province_phase`. ○
- **Windows / UI / font** — `redraw_window`, `fief_select_input_loop`, `ui_helper_cd20`, `daimyo_creation_stat_roll_screen`, `effect_view_a`/`effect_view_b`. ○ (the text font + window chrome live here.)

## Two paths to "from ROM bytes"

- **Static extraction (what the portrait tool does):** read the descriptor/map/palette tables directly and assemble in Python. Fast, inspectable, deterministic. Best when the layout is a static table.
- **Run-the-code (emulator):** when the layout is built at runtime (e.g. the composite portrait writes its map to SRAM; the tactical map is expanded by `map_populate $8903`), run the routine in `nobunaga_vm` and read the result — the precedent is `render-rom-to-map.py`. Combine: a future **"render graphics bits from code"** tool (ROADMAP) would intercept any `ppu_upload_block`/blit call site, capture the `(bank, src, count)` + nametable it produces, and render — subsuming this hand-rolled recipe for every asset above. The cross-bank bank-arg resolution (step 3) is the shared primitive.

## Reusable primitives (in `tools/render-portrait.py`)
- `NES_PALETTE` — 64-entry 2C02 master palette (index → RGB). Copy for any renderer.
- 2bpp tile decoder (`_decode_tile_pal`) — 16 bytes → 8×8 pixels via 2 bitplanes.
- `prg(cpu, bank)` — the PRG-offset identity for cross-bank reads.

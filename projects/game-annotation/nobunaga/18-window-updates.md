---
status: active
created: 2026-05-20
---
# Chapter 18 — The Window Update Model: How a Turn-Based Game Renders

> Chapter 16 mapped the render pipeline assuming each scene was a discrete bundle of (nametable + attribute + CHR + palette) that gets uploaded en masse. Reality is more interesting: most of NA1's rendering is **incremental "window" updates** — small, targeted writes to specific nametable regions while everything else stays the same. The full pipeline runs only at major scene transitions (start-of-game, fief change, combat start). The rest of the time, the engine is just mutating chunks of the existing nametable to update cursors, stat values, prompt text, animation frames, and combat positions. This chapter walks the two scene-bundling patterns we observed, the runtime initialization path for non-bundled scenes, and the implication: **NA1 is fundamentally a menu-driven game whose visual output is a continuously-modified nametable, not a sequence of independent rendered scenes**.

**Links:** [Chapter 16 — Render Pipeline](./16-tactical-map-render.md) · [Chapter 17 — Damage Formula](./17-damage-formula.md) · [Nobunaga README](./README.md)

## The two scene-bundling patterns observed

Across the scenes we've extracted, two distinct storage strategies emerged:

### Pattern A: Contiguous ROM bundle (KOEI copyright splash)

```
bank-0 $A84A  ┌──────────────────────────────────┐
              │  64 B   attribute table          │
$A88A         ├──────────────────────────────────┤
              │  960 B  nametable                │
$AC4A         ├──────────────────────────────────┤
              │  4 KB   CHR pattern data         │
$BC4A         └──────────────────────────────────┘
              + 16 B palette stored at $B862 (inside the CHR range)
```

**All four assets packed contiguously** in one bank (the 16-byte palette is the lone exception). A scene-descriptor table somewhere would just need 4 pointers + 1 bank number to fully describe this scene. **Fully recoverable from ROM alone** — no runtime initialization needed beyond a single bulk-copy syscall.

This pattern is appropriate for **read-only, non-interactive scenes**: title splashes, credits, "Game Over" screens. The bundle is opaque to gameplay — nothing modifies it.

### Pattern B: Bank-segmented with runtime initialization (NA1 main title)

```
bank-6 $8000  ┌──────────────────────────────────┐
              │  4 B    scene-meta header        │  (purpose TBD)
$8004         ├──────────────────────────────────┤
              │  ~700 B nametable delta          │  (rows 9-29 only;
              │                                  │   rows 0-8 reused from prev scene)
$82xx         ├──────────────────────────────────┤
              │  CHR tile patches                │  (scattered, per-tile)
              │  ...                             │
$8424         │  (individual tiles addressable)  │
              └──────────────────────────────────┘
   + palette/attribute set up at runtime by VM bytecode:
     - 16 × `loadA_imm_byte` + `storeA_mem_byte` to $0700-$070F  → palette shadow
     - 64 × similar pattern to PPU-attribute-table-shadow region
```

**Only the differential data is stored**. Reused nametable rows from the previous scene stay in PPU RAM. New rows get patched in. CHR tiles get individually uploaded for the cells that change. Palette and attribute table are reconstructed by VM code rather than memcpy'd.

This pattern is appropriate for **interactive scenes that share UI scaffolding** — they reuse the parent scene's layout and only update the deltas.

## The window-update model in steady state

After a scene has loaded, the rendering pipeline doesn't stop — it just shifts modes. Every frame, the renderer is potentially called to update **a small region** of the existing nametable:

```
                      ┌─────────────────────────────────────┐
                      │      Existing PPU nametable         │
                      │      (768 bytes, mostly stable)     │
                      └─────────┬───────────────────────────┘
                                │
            ┌───────────────────┼───────────────────┐
            ▼                   ▼                   ▼
       cursor blink       stat-value update    animation frame
       (1-2 tiles)        (4-8 tiles)          (8-16 tiles)
            │                   │                   │
            ▼                   ▼                   ▼
       $C480 row uploader called with small length parameter
                                │
                                ▼
                      PPU nametable mutated in place
```

The single uploader handles all of these. The parameter `$0075` (row length, normally 32) is just set to a smaller value for partial-row updates. With `$0082 = 0` (constant-fill mode) the engine can clear regions; with non-zero source pointer it can write text/glyphs.

## Examples of window updates we've now seen

The visual layer reveals this pattern everywhere we look:

1. **Cursor blink on prompts** — the "(Y/N)?" cursor visible on the title screen and every strategic-command prompt. A single tile (the cursor caret) writes between two values periodically. Implementation: `$C480` with 1-byte length to flip the cursor tile on/off.

2. **"Controller 1" display** on title screen — looks static but is dynamically composed. The text is written once when the title scene loads, but the **same routine** can update it (e.g., during 2-player mode where it might switch to "Controller 2"). Implementation: a few `$C480` calls to write the 11-character string.

3. **Strategic command result display** (chapter 9) — after a command like "Grow" executes, the affected province's stat values update on screen. The whole status panel doesn't redraw; only the changed stat values get rewritten. Implementation: `$C480` with 2-4 byte length for each updated digit.

4. **Combat unit positions** (chapter 17) — every combat day, units move on the tactical map. The bytes at specific nametable positions get rewritten with the new tile indices (terrain underneath + unit overlay). Only those positions update; rest of the map stays. Implementation: `$C480` writing 4-byte cell rows for each moved cell, called by the bytecode that drives unit movement.

5. **Combat stat-bar updates** — the displayed strength values (chapter 17's `$6FBC` array updates) drive on-screen number changes. Each strength change triggers a digit-tile update. Implementation: a `$ECBE` storeA_ind_word per strength-array update, plus a `$C480` to refresh the corresponding screen position.

6. **Province-name banner during turn transition** — when the active player switches, a banner shows the new daimyo's name. This is a `$C480` filling rows with text-tile indices. The rest of the screen (map, status panel) stays.

7. **The /30 displayed strength carry** (chapter 17) — when a unit takes enough sub-display damage to push its displayed strength down by 1, the engine writes the new digit tile to the screen. A single-tile update.

## Implication: NA1 is a long-running mutation of one big array

Most of the gameplay loop in NA1 has the structure:

```python
load_initial_scene()   # full pipeline pass — bundle + runtime init
loop:
    wait_for_input()
    update_game_state()
    for each visible value that changed:
        $C480(addr, new_bytes, length)   # window update only
    optional: trigger sub-screen (full reload + return)
```

The "complete redraws" you noted only happen at:
- **Boot/game-start** (full pipeline, one-time)
- **Phase transitions** (player-turn ↔ AI-turn ↔ event)
- **Scene type changes** (strategy ↔ combat ↔ event-message)
- **Major UI mode shifts** (main menu ↔ command submenu ↔ result display)

Even then, "complete redraw" often means **swapping to a new scene bundle while keeping the CHR-RAM populated** — the engine just sends a new nametable + attribute + possibly some CHR tile patches, and the existing 256 tiles still in PPU memory mostly remain valid.

## What this changes about asset extraction

The chapter-16 model ("scene = 4 contiguous ROM blocks") works for Pattern A scenes. For Pattern B scenes (everything interactive), full ROM-only extraction requires:

1. **Find the scene's VM bytecode entry point** — typically a routine that runs once when entering the scene
2. **Walk the bytecode** looking for:
   - Bulk-copy syscalls with source pointers in the scene's bank (these point to the stored nametable/CHR data)
   - `loadA_imm_byte / storeA_mem_byte` sequences targeting palette shadow ($0700-$071F) — the palette gets initialized here
   - Similar sequences for attribute table
3. **Reconstruct the runtime state** by simulating the bytecode's writes

Doable but a chapter-worth of analysis per scene.

### Erratum (2026-05-20): tactical maps are fully ROM-extractable

For **tactical maps specifically**, no PPU dump is needed — the full 11×5 battlefield reconstructs cleanly from ROM. Demonstrated 2026-05-20 by rendering Mino's complete 44×22 NES-tile isometric map (`render-mino-full.py`) using only:
- The 55-byte cell array (per-fief in some bank, locatable)
- The metatile dictionary at bank-2 `$B100` (ROM)
- The terrain dictionary (decoded in chapter 17: A/B/C/D/F)
- The isometric stagger formula (chapter 16: odd cols +8 byte / +2 NES row offset)

The rendered output shows the full Mino battlefield with the castle, town, mountain ridges, and forest borders — content the in-game view NEVER shows simultaneously since the game presents only one 5×5 section at a time. **The full map exists only in the engine's data structures and our reconstruction; the player never sees this view in-game.**

For per-fief graphic fidelity, the per-fief CHR (at `$A05E + offset` in some identifiable bank) and per-fief palette would replace the stylized terrain colors with actual NES tile graphics. With all 17 fief CHR banks identified, a complete tactical atlas becomes a one-pass extraction job.

The "PPU dumps are fastest" caveat applies only to:
- **Dynamic on-screen state** — unit positions, currently-active window, prompt state — these live in SRAM/PPU at runtime, not ROM
- **Pattern-B palette/attribute initialization** — until the scene-init bytecode is walked, easier to dump than reconstruct

## What this also explains

The **"per-tile CHR upload" pattern** we saw during the title-screen transition (258 individual `$C293` calls each uploading 16 bytes, rather than one big 4 KB transfer) now makes architectural sense: the engine was **patching specific tiles** that needed to change for the new scene, while leaving tiles that the title scene REUSES from the copyright scene's CHR untouched. The "scattered ROM sources" we saw weren't random — each was the ROM location of one specific tile-graphic patch.

This is the same compression strategy as **the partial nametable update**: only store/transfer what's different from the previous state. The previous state stays in PPU memory; the engine just patches the deltas.

## The architectural beauty

This is a remarkably efficient design for a 1989 cartridge with 256 KB ROM and 2 KB CPU RAM:

- **ROM footprint per scene**: minimal — only the deltas vs. prior scene
- **CPU per frame**: minimal — only the window-update bytecode runs, not a full screen redraw
- **VRAM bandwidth**: minimal — only changed bytes get transferred
- **Code reuse**: enormous — one row-uploader (`$C480`) handles cursors, stat updates, scene transitions, combat animations, everything

The result: a turn-based strategy game that **feels visually rich and responsive** despite running on a CPU that takes 11 cycles to read a single nametable byte and a console with no hardware acceleration beyond OAM DMA.

The pattern recurs in every Koei strategy game of the era — *Romance of the Three Kingdoms*, *Genghis Khan*, *Bandit Kings of Ancient China* all use it. It's a core part of Koei's house style for stat-heavy menu-driven simulations, and it's the visual-layer cousin of the **VM as soft 16-bit CPU** finding from chapter 17 (one engine, many games).

## Open items

- **Find the scene-init routine for the NA1 title** — walk its bytecode to extract the palette + attribute setup explicitly. Would prove the runtime-init hypothesis concretely.
- **Find the scene-descriptor table** (if one exists) — a lookup somewhere that maps scene-ID → (bank, nametable-ptr, CHR-patches, init-routine-addr). This would unlock ROM-only extraction at scale.
- **The 4-byte header at bank-6 `$8000`** (`4C 00 00 00`) — pin its semantics. Likely either a JMP instruction (treats bank as executable code that includes data) or scene metadata.
- **Compress-vs-runtime tradeoff per scene type** — categorize all the game's screens (title, command menu, status, world map, fief tactical map, event messages, save/load) by which bundling pattern they use. The pattern probably correlates with **scene mutability** (read-only = Pattern A; interactive = Pattern B).

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

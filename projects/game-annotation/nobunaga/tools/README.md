---
status: active
created: 2026-05-29
---
# tools/ — Registry
> The catalog of every script here, so sessions invoke instead of rebuild. **Status legend:** ✅ canonical (use this) · 🔁 has duplicate/variant siblings (consolidation pending — see [ROADMAP](../ROADMAP.md) Phase 3) · 🧪 one-shot/discovery (did its job; keep for provenance, don't extend) · ⚠️ gap/broken. Initial pass 2026-05-29 from a full inventory; entries marked 🔎 need a purpose re-confirm before anyone relies on them.

## Core VM / emulator infrastructure
| Script | Status | Purpose |
|---|---|---|
| `nobunaga_vm.py` | ✅ | VM + 6502 runner; loads SRAM, switches banks, symbolic trace via `mesen-labels.toml`. The "ask the ROM" tool. |
| `cpu6502.py` | ✅ | MOS 6502 interpreter backing the VM runner. |
| `vm_decompile.py` | ✅ | Bytecode → readable C. Default path for new routine investigations. |
| `econ_sim.py` | ✅ | Verified economy simulator (Grow/Build/Give/Dam/harvest). |
| `analyze-vm-opcodes.py` | ✅ | Opcode dispatch-table analysis, 3 modes: `survey` (handler clustering), `dispatch` (handler byte dumps), `classify` (operand-fetch patterns). **Merged the opcode trio (dump-dispatch/opcode-classify/opcode-survey), 2026-05-29** — output verified byte-identical. |

## Command / effect testing
| Script | Status | Purpose |
|---|---|---|
| `capture-test.py` | ✅ | PRE/POST snapshot manager (the snap protocol in [commands/README](../commands/README.md)). Auto-registers each snap via `data-index.py`; pass `--note` for provenance. *(moved from root → tools/, 2026-05-29)* |
| `data-index.py` | ✅ | Provenance index for empirical captures (`add`/`scan`/`show`) → `traces/INDEX.tsv`. The fix for "what is this dump?" — see [traces/README](../traces/README.md). |
| `run-effect.py` | ✅ | Generic effect-handler runner (`grow`/`build`/`dam`/`give…`); captures host_call args (sqrt_int/math32/pct_op). **Absorbed `run-grow.py`, 2026-05-29** — use `run-effect.py grow <pre> [amount]`. ⚠️ **reverses captured args for display** — true frame order is the reverse (see probe-math32). |
| `probe-map-emit.py` | 🧪 | Harness w/ a working **syscall layer**: intercepts `host_call $F226`, reads the param struct from `vm_sp` (`struct[0]`=task id), dispatches — emulates `memcpy_banked`($10)/`rng`($11), stubs `wait_for_nmi`($13)/PPU, auto-stubs+logs unknowns. Runs `$885E` clean. **Finding: `$885E` is the staging→PPU *render* driver, not the ROM→SRAM populator** (task `$14`=ppu_blit reads `struct[12]` staging ptr → PPUDATA). Real emit still unfound — see ROADMAP step 2'. Promote the syscall layer into `nobunaga_vm` next. |
| `probe-math32.py` | ✅ | Probes the 3 VM arithmetic helpers (`math32_3arg`/`math32_2arg`/`pct_op`) in the emulator with controlled args. **Cracked the ext-op blocker 2026-05-29**: `pct_op=⌊ab/100⌋`, `math32_3arg=⌊ab/c⌋`, `math32_2arg=⌊100a/(a+b)⌋`. Self-documents its conclusions. |
| `run-selector-full.py` | 🧪 | Combat-selector ($9675) runner with host-call stub framework — provenance for the combat-damage-formula crack. Kept as the one selector runner; 4 thinner trace iterations retired 2026-05-29. |
| `daimyo-table.py` | ✅ | Extract daimyo personality/stat table. |
| `command-table.py` | ✅ | Walk lord-command driver pointer table at `$B9B2` → `command-table.txt`. |
| `driver-call-index.py` | ✅ | For each lord-command driver, list every host_call it reaches (EFFECT/SHARED/BANK15) — drives the per-command formula pass. Reads `disasm/bank_01_vm.asm`. *(moved from root → tools/, 2026-05-29)* |

## SRAM / combat decode
| Script | Status | Purpose |
|---|---|---|
| `analyze-sram.py` | ✅ | Analyze an 8 KB SRAM `.dmp`, 2 modes: `structure` (byte distribution / runs / page summaries) and `detail` (ASCII strings / record stride-fitting / region dumps). **Merged sram-analyze + sram-detail, 2026-05-29** — verified byte-identical. |
| `sram-decode-province.py` | ✅ | Decode the live 17×26 province table from an SRAM dump; `--diff <other>` for PRE/POST. The decoder `capture-test.py diff` calls. *(moved from root → tools/, 2026-05-29)* |
| `combat-trace-decode.py` | ✅ | Decode the large `*-combat-init.txt` traces. |
| `sram-decode.py` | 🧪 | Discovery one-shot: located the `$7BFE` tactical staging buffer + metatile patterns. **Its input `sram_dump.txt` no longer exists; finding is canonical in `render-from-sram.py`.** Kept for provenance only. |
| `combat-map-decode.py` | 🧪 | Discovery one-shot: reconstructed the tactical nametable from a Mesen *trace* (not SRAM — wrong cluster). Superseded by `combat-trace-decode.py`. Hardcoded trace path. Provenance only. |

## Rendering
| Script | Status | Purpose |
|---|---|---|
| `render-atlas.py` | ⚠️🧪 | **INVALIDATED — produces WRONG maps.** Reads bank-4 `$A57E` as a "cell-index table," but that hypothesis was disproven (2026-05-21) and re-verified 2026-05-29: its Mino = `{town:18, forest:35}` vs ground-truth `15 clear/26 forest/12 mountain`. Tactical maps are **VM-bytecode-emitted at battle init**, not a static table. Use `render-fief-from-ppu.py` for accurate maps. Kept as provenance for the dead-end. |
| `render-from-sram.py` | ✅ | Tactical map from SRAM `$7BFD` staging buffer. |
| `render-strategic-atlas.py` | ✅ | 17-fief: composites the 17 tactical-map PNGs at geographic positions + adjacency overlay. *Not a `-50` twin — see note below.* |
| `render-strategic-50.py` | ✅ | 50-fief: node-link graph of the `$8004` adjacency table at approx-Japan positions (for eyeball verification). **Different render, different artifact** from the 17 atlas — `--variant` merge rejected 2026-05-29 (pure churn; both are fixed-output references). |
| `render-fief-from-ppu.py <fief>` | ✅ | Parameterized fief PPU renderer (`--list` shows available dumps). **Replaced the 16 per-fief `render-<fief>-from-ppu.py` copies, 2026-05-29.** |
| `render-mino-full.py`, `render-iga-full.py` | 🔁 | Full-map-from-SRAM variants → generalize (still pending). |
| `title-render.py` | ✅🧪 | Title-screen renderer, ROM-sourced CHR (`$AC4A`) → grayscale PPM. Canonical of the title one-shots; **`render-title2.py` retired 2026-05-29** (placeholder palette, depended on extracted intermediates). |
| `title-nametable.py`, `title-tiles-extract.py`, `find-title-assets.py`, `extract-chr-from-trace.py` | 🧪 | Title-screen one-shots (asset located + rendered; keep for provenance). |

## Strategic / scenario analysis
| Script | Status | Purpose |
|---|---|---|
| `adjacency.py` | ✅ | 17-fief adjacency from bank-4 `$8300` → `adjacency.txt`. |
| `adjacency-50.py` | ✅ | 50-fief adjacency from bank-4 `$8004` → `adjacency-50.txt` (+ names, degree stats, historical sanity checks). **Different table + artifact** from the 17 dumper — `--variant` merge rejected 2026-05-29 (different province numbering, output format; tables fixed & located → zero maintenance surface). |
| `find-adjacency-50.py` | 🧪 | Located the 50-fief table offset (done). |
| `fief-analysis-50.py` | ✅ | 50-fief **bulk** table: per-fief aggregates (Econ/Army/Daimyo geomeans) + neighbor threat/prey/ignition/backfield for all 50. |
| `profile-fief-50.py` | ✅ | 50-fief **drill-down**: full play-profile for named fief(s) (`py profile-fief-50.py Ezo Noto …`). Distinct granularity from the bulk table — both canonical, not duplicates. |
| `verify-17-subset-of-50.py` | 🧪 | Confirmed 17⊂50 (done). |
| `tier-analysis.py` | ✅ | Fief tier heuristic. |

## Lua (Mesen 2 runtime)
| Script | Status | Purpose |
|---|---|---|
| `dispatch-logger.lua` | ✅ | Log bytecode dispatch at `$E867` (console v1 / CSV v2). |
| `dashboard.lua` | ✅ | Live econ/army overlay during play. |
| `ai-war-logger.lua` | ✅ | Empirical AI war-target measurement (hooks `$B79B`). |
| `vm-trace.lua` | 🔁 | Lower-level VM trace; overlaps `dispatch-logger`. |
| `test-overlay.lua` | 🧪 | Diagnostic overlay. |

## Discovery / one-shots (🧪 — keep for provenance, don't extend)
`find-cell-table.py` · `find-table-refs.py` · `find-market.py` · `find-mikawa.py` · `find-tokugawa.py` · `find-tokugawa2.py` · `find-rom-defaults.py` · `dump-rom-defaults.py` · `dump-defaults.py` · `locate-tables.py` · `secondary-tables.py` · `map-17fief.py` · `map-bank3.py` · `paste-analyze.py` · `paste-full.py` · `zp-harvest.py` · `ui-strings.py`
> These located a specific table/value once. Their *output* (in `mesen-labels.toml` / the `.txt` data files) is the artifact; the scripts are provenance.

## Tests
`test-cpu6502.py` ✅ · `test-dispatcher.py` ✅ · `test-loadl-quick.py` 🧪 · `debug-trace.py` 🧪

## Reference
| File | Purpose |
|---|---|
| `sea16-reference.c` | NovaSquirrel's Sea-16 VM interpreter (external reference). |
| `EXTERNAL.md` | Pointer to external `nes-disasm6` tool. |
| `vm-opcodes-v2.toml` | ✅ Canonical opcode spec (no v1 exists). |
| `presets/*.toml` | Mesen 2 debug-session presets (audio-trace, brk-trace). |

## ⚠️ Known gaps
- **`mesen-labels.py` is referenced by `mesen-labels.toml` but does not exist.** Either (re)write the applier or fix the toml header. Until then, labels are applied manually.
- **`vm-disasm.py` (bulk VM disassembler, documented ch6) is missing** — the 4 existing `disasm/*_vm.asm` files prove it ran once; recover from ch6 and save it. Prerequisite for the "see the whole picture" decode epic. See [ROADMAP](../ROADMAP.md).
- Consolidation pass **complete 2026-05-29**: opcode trio → `analyze-vm-opcodes.py`; sram pair → `analyze-sram.py`; 4 selector iterations + `run-grow.py` + `render-title2.py` retired. The remaining 🔎 re-confirms resolved (the 17/50 "twins" and the two `*-fief-50` profilers are parallel canonical tools, not collapse targets — see their rows). Only `render-mino/iga-full` generalization still pending.

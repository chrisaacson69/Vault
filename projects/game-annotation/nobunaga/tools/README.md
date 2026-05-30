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
| `dump-dispatch.py` | 🔁 | Extract opcode→handler dispatch table from `$F026/$F126`. Overlaps `opcode-classify`/`opcode-survey` → merge to one `analyze-vm-opcodes.py`. |
| `opcode-classify.py` | 🔁 | Auto-classify operand fetch patterns. (see above) |
| `opcode-survey.py` | 🔁 | Cluster opcodes by handler/frequency. (see above) |

## Command / effect testing
| Script | Status | Purpose |
|---|---|---|
| `capture-test.py` | ✅ | PRE/POST snapshot manager (the snap protocol in [commands/README](../commands/README.md)). Auto-registers each snap via `data-index.py`; pass `--note` for provenance. *(moved from root → tools/, 2026-05-29)* |
| `data-index.py` | ✅ | Provenance index for empirical captures (`add`/`scan`/`show`) → `traces/INDEX.tsv`. The fix for "what is this dump?" — see [traces/README](../traces/README.md). |
| `run-effect.py` | ✅ | Generic effect-handler runner (Grow/Dam/Build/Give); captures host_call args. |
| `run-grow.py` | 🔁 | Grow-specialized variant of `run-effect.py` → fold into it with an effect arg. |
| `daimyo-table.py` | ✅ | Extract daimyo personality/stat table. |
| `command-table.py` | ✅ | Walk lord-command driver pointer table at `$B9B2` → `command-table.txt`. |
| `driver-call-index.py` | ✅ | For each lord-command driver, list every host_call it reaches (EFFECT/SHARED/BANK15) — drives the per-command formula pass. Reads `disasm/bank_01_vm.asm`. *(moved from root → tools/, 2026-05-29)* |

## SRAM / combat decode
| Script | Status | Purpose |
|---|---|---|
| `sram-analyze.py` | 🔁 | Parse SRAM structure / field offsets. Overlaps `sram-detail`/`sram-decode`/`combat-map-decode` → merge to `analyze-sram.py --mode fields|detail|landmarks|tactical`. |
| `sram-detail.py` | 🔁 | Field-level fief-record inspection. (see above) |
| `sram-decode.py` | 🔁 | Find landmark strings / metatile patterns. (see above) |
| `combat-map-decode.py` | 🔁 | Decode tactical metatiles from `$7BFD` buffer. (see above) |
| `sram-decode-province.py` | ✅ | Decode the live 17×26 province table from an SRAM dump; `--diff <other>` for PRE/POST. The decoder `capture-test.py diff` calls. *(moved from root → tools/, 2026-05-29)* |
| `combat-trace-decode.py` | ✅ | Decode the large `*-combat-init.txt` traces. |

## Rendering
| Script | Status | Purpose |
|---|---|---|
| `render-atlas.py` | ✅ | All-17-fief overview grid from bank-4 cell data. |
| `render-from-sram.py` | ✅ | Tactical map from SRAM `$7BFD` staging buffer. |
| `render-strategic-atlas.py` | 🔁 | Province map + adjacency overlay (17). `-50` twin → `--variant`. |
| `render-strategic-50.py` | 🔁 | 50-fief strategic map. (see above) |
| `render-fief-from-ppu.py <fief>` | ✅ | Parameterized fief PPU renderer (`--list` shows available dumps). **Replaced the 16 per-fief `render-<fief>-from-ppu.py` copies, 2026-05-29.** |
| `render-mino-full.py`, `render-iga-full.py` | 🔁 | Full-map-from-SRAM variants → generalize. |
| `title-render.py` / `render-title2.py` | 🔁🔎 | Two title renderers; **confirm which is canonical** before removing the other. |
| `title-nametable.py`, `title-tiles-extract.py`, `find-title-assets.py`, `extract-chr-from-trace.py` | 🧪 | Title-screen one-shots (asset located + rendered; keep for provenance). |

## Strategic / scenario analysis
| Script | Status | Purpose |
|---|---|---|
| `adjacency.py` | ✅ | 17-fief adjacency from bank-4 `$8300` → `adjacency.txt`. |
| `adjacency-50.py` | 🔁 | 50-fief adjacency → `adjacency-50.txt`. Merge under `--variant`. |
| `find-adjacency-50.py` | 🧪 | Located the 50-fief table offset (done). |
| `fief-analysis-50.py` / `profile-fief-50.py` | 🔁🔎 | 50-fief stat profilers; confirm which is canonical. |
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
- Counts above are from one inventory pass; 🔎 entries need a purpose re-confirm.

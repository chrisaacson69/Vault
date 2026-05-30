---
status: active
created: 2026-05-29
---
# ROADMAP — Living Frontier Ledger
> The persistent, dynamic task ledger for an exploratory project. Survives across sessions (unlike a session's scratch task list). Update it at the end of every session: move items between **Inbox / Now / Open / Parked / Done**. This is where "what were we doing?" gets answered without re-deriving it.

## Inbox — capture diversions here, DON'T chase them
> The rule (Chris's): when something shiny appears mid-session, it gets a ticket here — it does **not** hijack the current focus. "Ooh, something new!" → write it down, keep going. Triage Inbox → Open/Parked at session end. A diversion captured is free; a diversion chased costs the thread.

- **B7 extended-opcode table — CHECK NESDEV FORUMS before deriving** (Chris, 2026-05-29) — the ~47-entry `B7` 32-bit op table ($F263) is probably already documented on the nesdev forums (the disasm cites thread t=15931 for the base opcode spec). We don't need it anyway — the 3 composite helpers ([[project_nobunaga_math32_cracked]]) are the formula interface — but if a session ever wants the individual sub-ops, search the forum first, don't re-trace from the ROM.
- **`commands/` Index status column is stale** (noticed 2026-05-29) — it still reads Grow "pct=20 provisional", Dam/Train/Rest "stub", Build "prepped", Hire "test pending", but `econ_sim.py` + memory have these **verified** (Grow full formula, Train, Give-Men, tax penalty all cracked). The per-command test logs were never back-updated after the formulas closed. Fix opportunistically when touching a command; Dam's constants will close once math32 is decoded. Also: only the 7 economic commands have files — Move/War/Send/Bribe/Loan live in the combat chapters, not here.

## Now — current frontier
> **The tooling-discipline meta-project is COMPLETE** (2026-05-29) — full record in Done below. The frontier returns to the *engine itself*. Teed up (not yet started):
- **▶ NEXT: recover `vm-disasm.py`** — the bulk VM disassembler (documented ch6) drifted out of `tools/`; the 4 existing `disasm/*_vm.asm` files prove it ran once. This is **deterministic recovery, not open research**, and it's the prerequisite for the "see the whole picture" decode epic. *Single highest-value next step.* See Open (gap) + the EPIC.

<details><summary>Completed meta-project checklist (2026-05-29) — kept for the audit trail</summary>

- **Tooling-discipline pass (this project's project)** — making NA1 stop drifting. DONE 2026-05-29:
  - [x] Phase 1 — registration layer: `CONTEXT.md`, `tools/README.md`, `traces/README.md`, this file.
  - [x] Phase 2 — `/nobunaga` dispatcher skill over the deterministic tools (anti-drift Rule 0 baked in).
  - [x] Phase 3 — script consolidation **COMPLETE 2026-05-29**. 16 `render-*-from-ppu.py` → `render-fief-from-ppu.py <fief>`; 3 stray scripts relocated. Then: opcode trio → `analyze-vm-opcodes.py` (output verified byte-identical); SRAM pair → `analyze-sram.py` (byte-identical); `run-grow.py` folded into `run-effect.py grow`; 4 selector iterations retired (kept `run-selector-full.py` for provenance); `render-title2.py` retired (kept ROM-sourced `title-render.py`). Net **−11 scripts, +2**. The 17/50 "twins" (adjacency, strategic-render) and the two `*-fief-50` profilers were re-examined and **kept as parallel canonical tools** — different tables/artifacts/granularity, `--variant` merge rejected as pure churn (see tools/README rows). Only `render-mino/iga-full` generalization remains pending (low priority).
  - [x] Phase 4 — trace bloat **gzipped** (not deleted — they're empirical, not regenerable): ~2.9 GB → ~250 MB, lossless; `combat-trace-decode.py` reads `.gz` transparently.
  - [x] **Data-provenance system** — `tools/data-index.py` + `traces/INDEX.tsv`; `capture-test.py` auto-registers snaps. New captures are self-documenting.
  - [x] **Backlog triaged & cleared 2026-05-29.** Added `data-index.py auto` (classifies by the documented naming convention). All **145** legacy dumps registered with name-derived notes; **0 unrecognized, nothing to purge** — the ROADMAP's "provenance mostly lost" premise was pessimistic; the naming convention had preserved it. `scan` is now clean and will only flag genuinely new un-noted captures (the cry-wolf failure is averted).

</details>

## Open — questions & blockers
- ~~**`math32_3arg` / `math32_2arg` ext-opcodes**~~ — **CRACKED 2026-05-29** via `tools/probe-math32.py` (emulator probe, all vectors matched): `pct_op(a,b)=⌊ab/100⌋`, `math32_3arg(a,b,c)=⌊ab/c⌋`, `math32_2arg(a,b)=⌊100a/(a+b)⌋`. The ~47-entry B7 ext-op table was NOT decoded and didn't need to be — these 3 composite helpers are the interface every formula calls. **Now unblocks** (downstream refinements): exact **Dam constants**, the **AI war scorer** magnitudes, remaining **combat** magnitudes, and a re-check of the grow-drain factor (math32_2arg gives `100·gain/(gain+output)` — twice the empirical `50·…` fit; verify how the grow handler scales it).
- **Dam formula** — partial; output-coupling derived, exact constants pending (needs the ext-op unlock or a clean isolated test). See [commands/dam.md](./commands/dam.md).
- **Combat damage** — 2 of 4 quadrants confirmed via Lua; 2 remain. See ch17 + [[project_nobunaga_combat_damage_formula_decoded]].
- **AI war scorer** (`sub_B6B4` via `$B79B`) — RNG-weighted, not argmax-weakness; hits the ext-op wall too. See [[project_nobunaga_ai_war_architecture]].
- **`mesen-labels.py` missing** — the applier referenced by `mesen-labels.toml` doesn't exist; (re)write it or fix the header.
- **`vm-disasm.py` missing** — the bulk VM disassembler (documented ch6, produces `disasm/bank_NN_vm.asm`) is NOT in `tools/`. The 4 existing `_vm.asm` files prove it ran once; the tool drifted away. **Recover from ch6 + save it** — prerequisite for the whole-picture epic below.

### EPIC: "See the whole picture" — full bytecode→C decode, PERSISTED
> The core gap (Chris, 2026-05-29): **the C decompiler output is never stored — we regenerate it every session.** It's deterministic (fixed ROM → identical C forever), so re-deriving it is pure waste — the SRT-cleaning tell on the project's most valuable output. The fix this whole restructure was designed for: **decompile once, commit the `.c`, read it like a codebase.**
> Status verified 2026-05-29: VM-disasm covers only **4 of 16 banks** (00/01/02/15); C decompile is per-subroutine and ephemeral. No persisted whole-bank C exists.
- [ ] 1. Recover/rebuild `vm-disasm.py` and save it (see gap above).
- [ ] 2. Dump banks **03–14** → `bank_NN_vm.asm` for all 16. Reveals code-vs-data split per bank.
- [ ] 3. Wrap `vm_decompile.py` (one-sub-at-a-time) into a **decompile-all** driver. Entry points from the dispatch table + `driver-call-index.py` (recursive-descent = accurate code; unreached bytes = data).
- [ ] 4. **Persist the output: commit `decompiled/bank_NN.c` to git.** Reading the engine = opening a file, never re-running the tool. Regenerate only if the decompiler itself improves.
- [ ] 5. THEN drill down per question against the stored C. *Blocker: data interleaved with code — entry-point decode handles most; mark ambiguous regions.*

### EPIC: 50-fief map data from ROM (not SRAM) — REScOPED 2026-05-29
> Goal unchanged: render all 50 maps without hand-capturing 50 SRAM dumps. But the premise changed.
> **Verified finding ([[project_nobunaga_cell_encoding_vm]], re-confirmed 2026-05-29):** there is NO static map table. Tactical maps are **emitted byte-by-byte by per-fief VM bytecode at battle init** (load metatile → store to `$7BFD`). The bank-4 `$A57E` table `render-atlas.py` reads is a disproven dead-end — that renderer is now flagged ⚠️ INVALIDATED.
> **The unblock:** the 2026-05-21 memory scoped the programmatic path as "multi-day — build a partial VM interpreter." **That interpreter now exists** (`nobunaga_vm.py`, the one that cracked math32).
>
> **PROGRESS 2026-05-29 — ROM→SRAM emit routine LOCATED + partially decoded:**
> - Key finding: the captured `*-combat-init.txt.gz` traces are **render-phase (SRAM→PPU), taken AFTER the map was loaded** — they contain ZERO staging-buffer writes. That's *why* ROM→SRAM was never decoded; no existing artifact holds it. It had to be found in code.
> - The emit routine is **bank-2 VM sub `$885E`** (also `$8942`; confirms the memory's `$894A` lead). It loops 5 rows, computes `dest = $7BFD + …·88 + offset` (88 = the known col stride), and `host_call $CC54` does the metatile-pattern copy.
> - `vm_decompile.py` of `$885E` shows the **map source is selected by `$6F63` (defending province = which fief's map) + `$6FFE` (mode), via pointers around `$B540`–`$B547` (bank 2)**. So the per-fief map table is `$B540`-area, province-indexed — NOT the disproven bank-4 `$A57E`.
- [ ] 1. Characterize the `$B540`-area table (pointer table? per-fief encoding?) + decode `host_call $CC54` (the metatile copy). This is the remaining ROM→SRAM unknown.
- [x] **Syscall layer built + working** (`probe-map-emit.py`, 2026-05-29/30). Intercepts `host_call $F226`, reads the param struct from the VM stack (`$02/$03`=`vm_sp`; `struct[0]`=task id — NOT the host_call adj byte, which is the struct-pop size), dispatches by task id. With it the emit path runs **clean, no hang** (the earlier crashes were just unresolved syscalls — `wait_for_nmi` spinning, the blit losing sync). Decoded syscalls so far: `$10` memcpy_banked, `$11` rng_next, `$13` wait_for_nmi (stub), **`$14` ppu_blit_from_bank** ($C428: reads tile bytes from SRAM pointer `struct[12]` → writes `PPUDATA`). Unknown ids auto-stub + log → fill in the ~32 over time. **Promote this layer into `nobunaga_vm` next** (it's reusable core capability).
- [!] **COURSE CORRECTION (2026-05-30): `$885E` is the RENDER driver (SRAM staging → PPU), NOT the ROM→SRAM populator.** It was found via its `$7BFD` references, but those are *reads* — it walks the staging buffer ($7BFD + col*88) and blits each column to PPU via task `$14` (which reads `struct[12]`=`$7D05` staging ptr → `PPUDATA`). In the Mino dump the staging buffer was *already* populated (1048 nonzero) before `$885E` ran. So the actual ROM→SRAM step is a **different, still-unfound routine.**
- [ ] 2'. **Re-find the real emit: search for code that WRITES `$7B40-$7FFF`** (stores via a pointer set to `$7B4x`, or a `memcpy_banked` task-$10 call with dst in range), not reads it. The mino combat-init traces are render-phase (post-populate), so the populator runs even earlier — likely needs static search of the bytecode for staging-buffer *destination* writes. Then reproduce + verify vs Mino grid.
- [ ] 3. Generalize: drive `$885E` per province → `render-all-maps.py`. Then confirm whether 50-fief mode reuses this machinery (separate scenario) before claiming all 50.

## Parked — intentional, not forgotten
- **Chapter 19** — combat resolution (commander death, retreats, supplies). Planned; combat terminators already understood ([[project_nobunaga_combat_terminators_and_illness]]).
- **Synthesis chapter** — bytecode → strategy counter-graph / dominance frontier. The payoff chapter; waits until mechanics are fully mapped.
- **Appendix** — per-command effect formulas + AI thresholds + adjacency; ongoing accretion.
- **Visual atlas** — render all 17 tactical maps + strategic map for the synthesis ([[project_nobunaga_visual_extraction]]).

## Done — recent (newest first; trim to ~15, full history is in chapters + git)
- **Kernel syscall layer promoted into `nobunaga_vm`** (2026-05-30) — intercepts `host_call $F226`, dispatches the 23-entry `$C173` table by task id (read from `vm_sp`; bank-switch emulated by reading the target ROM page directly). **16/23 resolved:** 6 emulated (memcpy_banked, rng, set_sprite, palette_write, palette_swap, audio_load_voice), 10 stubbed (PPU/audio/input/nmi-wait/chr — moot headless). No regression (cpu6502/dispatcher tests + math32 still exact). Bytecode no longer hangs on syscalls. See [[project_nobunaga_emulator_tools]].
- **math32 ext-op blocker CRACKED** (2026-05-29) — `pct_op`/`math32_3arg`/`math32_2arg` derived + emulator-verified via `probe-math32.py`. The standing magnitude blocker across Dam/AI/combat is gone; the B7 table stayed unopened (helpers were the real interface).
- **Tooling-discipline meta-project COMPLETE** (2026-05-29) — registration layer (CONTEXT + 3 registries), `/nobunaga` skill, script consolidation (−11/+2, every merge output-verified), trace gzip (2.9 GB→250 MB lossless), data-provenance system + `data-index.py auto` (145 legacy dumps contextualized → backlog clean). The anti-drift thesis applied to its own toolchain.
- 50-fief adjacency cracked, verified 5 ways ([[project_nobunaga_50fief_adjacency]]).
- Full NA1 economy engine unified (Grow/Build/Give/harvest verified; Dam partial) ([[project_nobunaga_full_econ_engine]]).
- Natural-death + event-spawn formulas cracked.
- VM bytecode → C decompiler operational ([[project_nobunaga_vm_decompiler]]).
- Combat architecture mapped end-to-end (bank-2 walk).
- Chapters 1–18 drafted (see [README.md](./README.md) chapter map for per-chapter status).

## How to use this file
End each session by asking the [[notes/claude-code-skill-engineering]] compounding question, applied to *plans*: did anything move? Promote/park/close items here. An item that's been in **Open** for many sessions with no progress is a signal — either it's blocked on one thing (name it) or it's actually Parked (be honest).

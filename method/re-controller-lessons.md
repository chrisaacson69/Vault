---
status: draft
created: 2026-10-26
published: false
layout: layouts/page.njk
title: "RE Build Tool Lessons"
---
# RE Build Tool — lessons, by phase
> What the disassembly projects learned about *how* to run one, harvested 2026-10-26 from the memory store,
> the vault's method and research pages, the walk skills and the title repos' entry docs. Each is one line;
> the [build tool](./re-controller.md) cites these phase by phase. A reference page: read the phase you are in.
> *Sources:* a lesson citing `/label-walk`, `/data-walk` or `/var-walk` came from those vault skills, retired
> 2026-10-26 into emu-harness (`PHASES.md` §5, `workflows/`); one citing `/nobunaga` came from the skill now in
> the na1-decompiler repo.

**Links:** [The RE Build Tool](./re-controller.md)

**Source keys.** `mem:<slug>` = a memory topic file (local, not in this repo). `<repo>:<path>` = a title
repo by logical name (resolve through `.claude/local-paths.md`). Vault pages are linked. Kind:
**R** rule, **P** pitfall, **O** oracle.

## Classify
- **R** Classify before method: turn-based → walkable call tree bottom-up; real-time → resolve dispatch first (trace + jump tables, ALL entries). *"Transportability of the skill ≠ transportability of the plan."* — mem:feedback_architecture_first_re, [SDK](../projects/CLAUDE.md), game-annotation:mappy/09
- **R** Qualify by the artifacts present, never by publisher or console: NA1-SNES is native while its KOEI siblings run the VM. — `/label-walk`, [NA1 SNES port](../research/gaming/na1-snes-native-port.md)
- **O** VM vs native by fingerprint: fetch-decode loop, 256-entry dispatch, per-routine trampoline, 0-conflict native reach. — [NA1 SNES port](../research/gaming/na1-snes-native-port.md), AeroBiz-decompiler:CONTEXT.md
- **R** When the static↔runtime join is broken (DOS relocation, overlays), go data-first. — [Data-First RE](./data-first-re.md)
- **R** Unfamiliar hardware: find the portable interpreter and anchor it against a known sibling (only for portable engines). — [Rosetta Stone](./rosetta-stone-method.md)
- **P** Engine ≠ configuration: L'Empereur has NA2's engine and a GemFire-era syscall vector. — LEmp-decompiler:docs/03
- **R** Build our own decompiler for a bespoke VM; use Ghidra-class tools only as a second reader of native code. — [REA teardown](../research/reverse-engineering/rea-candidate-tool.md), [Transpilation as Grounding](../research/transpilation-as-grounding.md)
- **O** SNES: re-detect mapping per cart (checksum ⊕ complement = $FFFF + map byte); M/X widths are right when RESET's stream lands on real registers. — [SNES teardown](../research/gaming/snes-cartridge-teardown.md)

## Recon
- **R/O** Fingerprint against the closest sibling (reset bytes, dispatcher invariant, stubs), seed the profile from it; acid test: every bytecode bank tiles with 0 decode errors. — GemFire-decompiler:docs/00-recon.md, LEmp-decompiler:README.md
- **P** "0 errors" is vacuous unless the walker can fail: add ownership conflicts, dead-opcode detection, a raising bind(). *"A checker with no failure mode for an error class certifies nothing about that class."* — AeroBiz-decompiler:docs/00-recon.md §8, mem:feedback_common_mode_shared_tool_error
- **R** On each new title, re-derive the shared toolchain's load-bearing assumptions from the lowest artifact (executing handlers) and fix the toolchain BEFORE walking: AeroBiz found `$D8` mis-decoded in two shipped titles. — AeroBiz-decompiler:CONTEXT.md, mem:project_aerobiz_snes_decompiler
- **R** Derive operand sizes by following fetch-helper callees on all paths; never hand-list them. — mem:area_re_method
- **O** A recon can be a derive/refute workflow (7 derive families, 8 refuting lenses, a critic), each check re-runnable. — AeroBiz-decompiler:docs/00-recon.md
- **R** Read module manifests from the ROM's own archive, never a hand table. — [GemFire SNES](../research/gaming/gemfire-snes-decompiled.md)
- **P** Recon corrections can be wrong too (ROTK2-SNES #8 retracted #4–7, #9 retracted #8). — mem:area_projects_active
- **P** Verify each bank's run window from evidence: six profiles had the sound bank at `$A000`. — emu-harness:MIGRATION.md (revisits)
- **P/O** Census the fixed bank for a second VM-entry stub: it is a native-call ABI (`$E2E3`), not a dialect; "sane signatures + garbage bodies" is the tell. — mem:project_koei_e2e3_native_trampoline

## Code discovery
- **R** Native floor first: enumerate the fixed region, match by relocation-invariant signature against ALL siblings, hand-read the residue. — GemFire-decompiler:docs/walk-method.md, emu-harness rows D/E
- **P** About a third of native "residue" is phantoms (`20 xx xx` in data, mid-instruction): drop or mark DATA, never name. — mem:feedback_no_placeholder_names
- **O** Seeded descent beats a linear sweep, which calls ~2/3 of data "code". — emu-harness row B
- **P** Census every call method (trampolines, run-bank syscall, co-resident direct calls, fn pointers). Chris: *"don't rely on one call method"*; UW's "0 subsystem edges" was 34. — GemFire walk-method, UW-decompile:docs/08, emu-harness row H
- **P** "100% of the walk ≠ 100% of the program" when dispatch is indirect: NA1-SNES's 715/715 missed ~94 verbs. — [blind regrade](../research/gaming/na1-nes-snes-blind-regrade.md)
- **R** Real-time: trace (30%) → descent (60%) → idiom jump-table sweep (96.7%) → call graph. — game-annotation:mappy/09, emu-harness row R
- **P** A true entry carries the prologue; scan-seeding inflated ROTK2-SNES counts; a header is not the sub (L'Empereur bank 13, SNES body at +5). — mem:area_projects_active, LEmp-decompiler:docs/03
- **O** Walker conflicts are the correctness signal; mark ambiguous regions instead of guessing. — [Transpilation as Grounding](../research/transpilation-as-grounding.md)
- **R** A code label sits on an instruction start, never an operand byte. — mem:feedback_labels_mark_code_start
- **P** A consumer regex on an obsolete mnemonic silently emptied a call graph ("leaves-first" was address order). — mem:project_nobunaga_label_walk_skill
- **P/O** A gate nobody measured certifies nothing: counting walker conflicts (overlaps + halts) for the first time found the idiom passes *making* phantoms, one already named. Explain each conflict by idiom (`BIT`-skip, dead path) or it counts. — [build tool, Mappy revisit](./re-controller.md#first-revisit-mappy-2026-10-26)
- **P** A table reader must stop at its own handler and at executed code: Mappy's `$C356` read its last handler's first instruction as a 20th entry. — same
- **P** A JSR to a dispatcher that pulls its return address never returns; the bytes after it are a table (18 handlers hidden). An "install" is a handler only if a `JMP (ind)` reads its variable. — same
- **O** A 2-byte "routine" with JSR callers is usually a fall-through entry, not a phantom: the trace decides before anything is marked DATA. — same

## Data (the pure lane runs before naming)
- **R** Front-load pure-oracle data: string scan, manual schema, ~25 hot RAM globals; provenance walk later. Chris: *"labeling data goes a long way to making the code clear … higher in the pipeline."* — mem:feedback_data_labeling_earlier_in_pipeline
- **R** Three lanes: ORACLE and PROVENANCE deterministic (zero agents), ANALYTICAL through propose→verify. — `/data-walk`
- **O** The official manual is the schema oracle for what fields mean; where it contradicts itself, the code decides. — mem:feedback_manual_as_schema_oracle
- **P** Schemas don't transfer between sibling engines (NA1's default mislabelled 26 BK subs); keep `field+N` until code proves it. — mem:feedback_manual_as_schema_oracle
- **O** Confirm a field when a data value and a code role agree (ideally plus the manual); pin offsets on a caught write. — GemFire walk-method, LEmp-decompiler:docs/03
- **P** ROM and SRAM are two representations of one record; frame locals are invisible to static grep. — na1-decompiler:CONTEXT.md
- **R/P** Name the dedicated semantic globals; leave the scratch register file generic. — [KOEI SNES VM](../research/gaming/koei-snes-portable-vm.md)
- **O** A probed field is a hypothesis until an artifact the probe didn't produce confirms it. — [Data-First RE](./data-first-re.md)
- **R/P** Perturbation discipline: stored vs derived, one variable per test; a range check is not a semantic check. — [Data-First RE](./data-first-re.md)
- **P** One or two matching observations can be coincidence (NA1 "pct=20"). — mem:project_nobunaga_pct20_constant
- **R** Stop the data phase when every region has a start and a kind. Readable data (text, records) gets names; opaque data (level, sound, graphics, jump tables) only needs where it starts, and the code that reads it implies what it is. Chris: *"it doesn't have to be perfect, enough that the code walk knows it is data and figures out what to do with it."* — [build tool, Mappy revisit](./re-controller.md#first-revisit-mappy-2026-10-26)
- **O** Native data: run the game's own walkers headless on a read-logging bus. The bytes they read are the blob's exact extent, the PPU cells they write are its text; drive the sound engine one trigger at a time for the music. No grammar re-implemented. — [build tool, Mappy revisit](./re-controller.md#first-revisit-mappy-2026-10-26)
- **P** An xref that sweeps label spans decodes data as code: Mappy's had 33% false var-routine links, and names were built on them. Decode only discover's instruction starts. — same
- **O** A record field's role is proven when a value class and a code load agree (even values only + `ldy #$0F / lda (ptr),y / tax / lda tbl,x` = the state index); a lo/hi pair by a carry test over frames. Slot-0 per-address names are copies of the record and drift from it. — same
- **P** Read hardware facts from the code, not convention: Mappy's shadow OAM is `$0700` (its `sta OAMDMA`), and correlating against `$0200` produced noise. — same

## Structure
- **R** Foundation discipline early: verify the primitive layer against the oracle before building on it ($30–$3F fix cleared 996 sites). Chris: *"think how easy things would be if we had it right early on."* — mem:feedback_foundation_discipline_early
- **O/P** Probe each primitive (compares, shifts, signedness) against the live handler; 323 inverted compares passed every structural gate. — mem:feedback_foundation_discipline_early
- **O** VM ladder: byte-identical round-trip → per-opcode stack-effect audit → decompiler self-check. — na1-decompiler:CONTEXT.md
- **O** Ground the opcode table in three independent sources. — mem:project_nobunaga_vm_interpreter_project
- **R** Transpile the weak language deterministically to C; let the LLM reason in C. — [Transpilation as Grounding](../research/transpilation-as-grounding.md)
- **R** Readability has no lower oracle: ground it as transfer fidelity; goto-count is a Goodhart trap. — mem:feedback_two_oracles_readability, [Repairing LLM Code](../research/repairing-llm-code.md)
- **R** Structure with DREAM-style conditions, honest gotos on irreducible regions, fold gated on CFG equivalence; stop at good enough. — [DREAM](../research/reverse-engineering/dream-goto-free-structuring.md), emu-harness row G
- **P** A gate passed 37 non-compilable subs: add an emit-integrity certifier (or recompile round-trip). — mem:feedback_two_oracles_readability
- **P** Stack VM: unconsumed call results vanished from the C (+1,418 calls recovered later). — na1-decompiler:ROADMAP.md
- **P** The lossy C invites over-reading; LLM readers read wrong structure at high confidence. — [blind regrade](../research/gaming/na1-nes-snes-blind-regrade.md)
- **R** Install a gate the moment you can name a ground truth and a cheap check; when one wall rejects N tries, run a divergent tournament. — [Anchor Method](./anchor-method.md)
- **R** Native call graphs need typed edges, not just JSR: a routine that rolls into the next ("flows-into"), tail jumps, table and inline dispatch, task switches. Walk each routine's own flow with the other entries as stops; a halt at an entry is the roll-into, unless it lies past an always-taken branch. — [build tool, Mappy revisit](./re-controller.md#first-revisit-mappy-2026-10-26)
- **O** A hand-drawn call tree from the vectors is an independent grader for the generated graph: Chris's (31 pairs) matched 27 direct and 4 via one roll-into, and caught two edge bugs. — same

## Naming
- **R** RE is multi-pass compilation backwards: the toml is the symbol table, regen between batches is the fixpoint. — mem:feedback_re_is_multipass_compilation
- **R** Leaves first; the frontier is unnamed routines whose callees are all named; stop at known. — `/label-walk`, GemFire walk-method
- **O** Then walk top-down to verify: *"a routine's first ops lie about its role."* — game-annotation:mappy/09
- **O/R** Propose from the C, verify at the bytecode, root writes survivors (the verifier corrected 29/50 in NA1 bank 1); with no lower oracle, STOP. — mem:feedback_verification_independence_is_altitude
- **R** Prep/apply deterministic behind a hard guard (only the target file, pure renames, exit 2 = stop). — `/label-walk`
- **P** The label identity in a switchable window is the PRG offset; WRAM overlays need a per-module namespace. — na1-decompiler:CONTEXT.md
- **R** Generic-first: *"vague-but-correct beats specific-but-wrong."* — GemFire walk-method
- **R** No address-keyed placeholders. Chris: *"this seems like a miss than the truth."* — mem:feedback_no_placeholder_names
- **R** Name for what a routine does at its own level; tools find twins, inference picks the name, a lower artifact settles conflicts. — mem:feedback_routine_names_inference_over_tool
- **R** Never overwrite a name in apply; a rename is a separate edit. — AeroBiz-decompiler:docs/walk
- **P** Recursive routines never reach the frontier: name them directly. — mem:area_projects_active
- **R** Label as you go is a goal: "did I name what I found?" is a session-exit item. — mem:feedback_label_as_you_go_is_a_goal
- **R/P** var-walk: name a slot only for one coherent role; single-agent mode loses independence. — `/var-walk`

## Presentation
- **R** Ship the source ladder (asm → labelled → bytecode → raw C → structured C), regenerated by shared tools; readable by default, raw as witness. — [GemFire SNES](../research/gaming/gemfire-snes-decompiled.md)
- **R** The derived C is a deliverable; stack reconstruction is easy, structuring is an epic. — mem:feedback_derived_artifact_is_also_a_deliverable
- **R** A comment's value is its distance to the oracle; mark `WHY:`/`AGENT:` so chatter strips. — mem:comment_oracle_distance
- **R** Annotate real-time games around the dispatch tables (the machine's model). — mem:feedback_architecture_first_re
- **R** Publish conversions and analysis, never the ROM or manual. — [AI Decomp Wave](../research/ai-decomp-wave.md)

## Assets
- **R/P** Render from ROM bytes with the real upload args; capture at runtime when a static hunt fails. — na1-decompiler:ROADMAP.md
- **R** Title tools call the library for formats, decode, palettes and PPU rules (four palette copies, one wrong). — mem:feedback_title_tools_call_the_library
- **O** The render oracle is the live PPU, through the virtual-canvas contract. — emu-harness rows O, O4

## Live verification
- **O** Run the game's own routine on the verified CPU over live RAM for every input, then plant a fault (Zelda 128/128 vs 4 walked). — mem:code_run_as_oracle
- **R** Read data and code first, experiment to confirm. Chris: *"I would jump straight to the data!"* — [Zelda](../research/gaming/zelda-ai-speedrun-harness.md)
- **O** Ask the ROM: load SRAM, set the VM, run the handler; the snap protocol for command effects. — `/nobunaga`
- **P** Fix the instrument, not the game: calibrate a detector on a known answer first. — [Zelda](../research/gaming/zelda-ai-speedrun-harness.md)
- **R** Oracle tests prove reach: assert branch coverage, plant a mutation, fail on an empty glob. — mem:feedback_oracle_tests_prove_reach
- **P** Mesen Lua: a nil callback enum never fires; keep lockstep; a cross-emulator desync is a finding. — mem:reference_mesen2_lua_api
- **P** Search hides bugs; an impossible failure means question the harness first. — [Zelda](../research/gaming/zelda-ai-speedrun-harness.md)
- **R** Never capture the screen; the emulator renders its own frame. — kernel rule

## Project process
- **R** Rule 0: read CONTEXT, the tool registry, the provenance registry, the ROADMAP before building; never hard-delete empirical dumps. — `/nobunaga`, mem:project_nobunaga_registration_layer
- **R** One task per session, ending with a concrete "next session" entry. — mem:feedback_task_specific_sessions
- **R** *"A diversion captured is free; a diversion chased costs the thread."* — na1-decompiler:ROADMAP.md
- **R** The coordinator is the single writer; sub-agents return pointers to artifacts, not claims. — mem:feedback_coordinator_subagent_context_transfer
- **R** Mechanical work → a deterministic generator; unknown reads → fan-out. — mem:feedback_mechanical_vs_analytical_fanout
- **R** Factor a shared library the moment a second title needs it; *"title-specific means really title-specific."* — emu-harness:MIGRATION.md
- **R** Consolidating copies: the oracle is correctness against the lower artifact, not agreement. — emu-harness:MIGRATION.md
- **R** Toolset first, revisits later, one session each: *"otherwise we will keep looping."* — mem:feedback_toolset_first_revisits_later
- **P** Regenerate committed outputs after tool changes; never let a generator clobber curated files. — emu-harness:MIGRATION.md
- **R** Rules carry their scar ("Bit us: …"); dead ends become DO-NOT-RETRY lines. — mem:feedback_scar_ledger_config
- **R** Findings flow back to the vault; check open questions before filing anything new. — [Vault manual](../CLAUDE.md)

## Grounding and verification
- **R** Never fabricate; convert rather than rebuild. — mem:feedback_fabrication_over_grounding
- **R** Silent tool failure: verify canonical edits with a second tool. — mem:feedback_silent_tool_failure_hallucination
- **R** Independence comes from altitude (a lower artifact), not headcount. — mem:feedback_verification_independence_is_altitude
- **R** A second pass surfaces the first pass's mistakes; a shared tool's common-mode error needs re-derivation. — mem:feedback_common_mode_shared_tool_error
- **O** With a second independent artifact, create blind, then grade both. — mem:feedback_rederive_then_grade
- **R** When derivations disagree, diff what each froze; a perfect score is a red flag. — mem:feedback_frozen_assumption_beats_higher_score
- **R** Zero yield means a wrong path. Chris: *"we chased after ghosts and the space just constantly grew."* — mem:feedback_zero_yield_wrong_path
- **R** A learned fact carries its cause or it isn't recorded. — mem:feedback_learned_fact_carries_cause
- **R** Oracles are adopted, not discovered. Chris: *"an 'oracle' is only the best we know so far."* — mem:contract_vs_substrate_oracle_standard
- **O** Grounding rank: self-decoded ROM verified against play > community disassembly > fan RAM maps > walkthroughs. — [Zelda](../research/gaming/zelda-ai-speedrun-harness.md)
- **R** If verifiers reject a premise you fed them, you were wrong, not them. — `/label-walk`
- **R** Early errors compound; re-walk once the landscape is clear. Chris: *"The first decompile I ended up doing 3x."* — [Zelda](../research/gaming/zelda-ai-speedrun-harness.md)

## Order of work as practised
- **NA1** (discovered, not planned): play and probes → realised VM → opcode table → emulator → decompiler → kernel walk → label/data/var walks → structuring. Paid for late foundation bugs, early formula "cracks", a 3x decompile and the data walk last.
- **KOEI NES family**: recon/fingerprint → native floor → (from BK) strings + manual schema → bytecode walk leaves-first → in-bank natives → data walk → chapters. Paid for NA1's default schema in BK, an excluded bank in L'Empereur, wrong windows in six titles, a forked native floor.
- **KOEI SNES**: header → RESET → classify → dispatch → syscalls → opcodes → walker → archive → call graph → bottom-up + top-down → data → source. AeroBiz set the corrected order: re-derive and execute the shared tool's assumptions first.
- **Native**: Mappy trace → descent → jump tables → call graph → bottom-up → top-down → fields, the published disassembly read last. Zelda: data and code first, the ROM's own routine as the oracle.

## Tags
[reverse-engineering](../tags/reverse-engineering.md) · [methodology](../tags/methodology.md)

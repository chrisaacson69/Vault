---
status: active
created: 2026-10-26
published: false
layout: layouts/page.njk
title: "The RE Build Tool"
---
# The RE Build Tool — an LLM interface to the toolset, plus a phase plan
> The emu-harness consolidation (rows A–R, closed 2026-10-26) gave every disassembly project one tool
> library. What is missing is a **build tool** (first called the controller): an agent-facing guide that knows the
> order of work, what proves each phase done, and where each project stands. It mirrors
> [CyborgDJ as Controller](../research/cyborgdj-inference-interface.md): the library is the tool
> surface (MCP-shaped), inference holds the plan, deterministic code does the busywork. **Chris's
> decisions of 2026-10-26 are below. Built 2026-10-26:** the manual (emu-harness `PHASES.md`), the phase
> table (`emu_harness/build/phase_table.toml`), the first verb `status`, and the roadmap template; first trial
> on Mappy (see [Built](#built-2026-10-26)).

**Links:** [Lessons, by phase](./re-controller-lessons.md) (the ~90 lessons this folds in, with sources) ·
[CyborgDJ as Controller](../research/cyborgdj-inference-interface.md) (the same pattern for DJ work) ·
[The Anchor Method](./anchor-method.md) (every phase ends at a gate) · [Data-First RE](./data-first-re.md) ·
[The Rosetta Stone Method](./rosetta-stone-method.md) · [Building Swarms](./swarm-construction-rules.md) ·
[REA teardown](../research/reverse-engineering/rea-candidate-tool.md) (inference driving RE tools over MCP) ·
[An AI Speedruns NES Zelda](../research/gaming/zelda-ai-speedrun-harness.md) ·
[Project SDK](../projects/CLAUDE.md) · the walks (emu-harness `PHASES.md` §5, `workflows/`) ·
[emu-harness](../projects/game-annotation/emu-harness/README.md) (`MIGRATION.md` = the row table and the revisit list)

## The idea, in Chris's words
> *"less python, and more agent instructions.. what order to use the tools, how to breakdown everything.. a
> guide to walk along the projects."* — and, on the CyborgDJ parallel: *"the idea of an LLM interface to the
> library as well as an instruction plan is exactly what I had in mind."* (2026-10-26)

## Two halves
| CyborgDJ | RE controller | State |
|---|---|---|
| dj-score / dj-render: one service per use case | emu-harness rows A–R | built; ~40 modules, each with its own CLI |
| MCP verbs over the services | **one verb set, JSON out, per project** | to build (half 1) |
| Inference holds the set; deterministic render/verify | **a phase plan with a gate per phase** | to write (half 2) |
| Knob sweeps: inference configures, code turns | walks: inference names, guards and regen check | built as the walk skills |

## Half 1 — the tool surface
One entry point, `py -3.14 -m emu_harness <verb> <project> [--json]`. It resolves the project by
logical name and its profile, and returns records rather than prose. An MCP server is the same verbs
in a different package. The CyborgDJ page's open question applies unchanged: *the server is packaging,
the substrate is the value*, so CLI-with-JSON first and MCP when a non-shell client needs it.

| Verb | Phase | Library |
|---|---|---|
| `status` | all | the project's phase table (below) |
| `classify` | 0 | `machines/{nes,snes}` header/mapper; VM fingerprint (`vm/koei` titles, native floor) |
| `recon` | 1 | vectors, bank windows (`machines/nes/memory.window_votes`), `passes/strings`, records |
| `discover` | 2 | `cpu/m6502/descent`; VM: `vm/koei` native floor + decode; native: `cpu/m6502/coverage` + `passes/native` |
| `callgraph`, `order`, `frontier` | 3 | `passes/callgraph`, `walk/prep` |
| `xref`, `strings`, `fields` | data | `vm/koei/nes/dataxref`, `passes/strings`, `passes/native.field_census` |
| `apply` (guarded) | naming | `walk/guard` (the walk skills call it) |
| `decompile`, `listing`, `labels` | presentation | `vm/koei` decompiler + gates, `passes/listing`, `backends/mesen/labels` |
| `render` | assets | `machines/nes/ppu` + `canvas`, `vm/koei/nes/assets` |
| `run`, `watch`, `snapshot`, `trace` | live | `backends/mesen`, `machines/nes/live`, `machines/nes/trace`, `machines/nes/bus` |

## Half 2 — the phase plan
Every phase names its tools and the **gate** that proves it done. Inference is spent only where a lower
artifact can check it, and sequentially.

| # | Phase | VM track (KOEI) | Native track | Gate (exit) |
|---|---|---|---|---|
| 0 | **Classify** | fingerprint: fetch-decode loop, 256-entry dispatch, trampoline | turn-based or real-time; is the static↔runtime join cheap? | the one fact that dictates the method, written down with its evidence |
| 1 | **Recon** | match the closest sibling, seed the profile; **re-derive the shared toolchain's assumptions on this title** | vectors, mapper, bank windows | every bytecode bank tiles with 0 errors *from a walker that can fail*; windows from evidence |
| 2 | **Code discovery** | native floor (signatures vs ALL siblings), census every call method | trace → descent → dispatch / stored-pointer / pointer-table passes | 0 walker conflicts; every jump table read in full; phantoms dropped |
| 3 | **Data, pure lane** | strings, manual→schema, ~20 hot globals | same | oracle lanes deterministic; schema per title, offsets `field+N` until code proves them |
| 4 | **Structure** | call graph, leaves-first order | same | primitives probed against the live handler; round-trip byte-identical |
| 5 | **Naming** | label → data (provenance + analytical) → var walks; bottom-up, then top-down verify | same | proposals verified at a lower artifact; the guard holds; no placeholder names |
| 6 | **Presentation** | the source ladder: asm → labelled → bytecode → raw C → structured C | asm → labelled | regenerated by shared tools; structuring "good enough" (G1) |
| 7 | **Assets** | render from ROM via the library | same | matches the live PPU |
| 8 | **Live verification** (a source of oracles from phase 1 on) | snap protocol, run the handler | run the game's own routine over live RAM, every input | a planted fault fails the check |

Each phase also ends with **register and hand back**: update the project's state, flow findings to the
vault, and write a "next session" entry. One phase or one revisit per session.

## Per-project state
Each project keeps its own **roadmap of where it is**: a phase table (phase, status done / partial / n.a.,
the gate's last result and date, the emu-harness commit it ran on, open revisit items). The tool reads it
(`status`) and starts a session at the first phase that isn't done, or whose gate is stale against the
current toolset. The tool and its manual live in emu-harness; nothing project-specific lives there.

## Decisions (Chris, 2026-10-26)
- **Homes.** The phase manual and the tool live in **emu-harness**, outside the title repos (each
  disassembly is its own project, as CyborgDJ sits outside its libraries). **Per-project state lives in
  each project**: a roadmap of where it is. *"I get that I said 'controller', but it is basically a build
  tool for each project."*
- **Sessions and agents.** One project per session. An agent per phase is fine; spamming agents for
  inference is not. The trouble was the tokens/hour cap: agents burned it fast *and* used more tokens in
  total. *"rather have high-quality inference sequentally than burn tokens on cross talk."* Waiting for a
  linear pass is acceptable.
- **Interface.** Keep it simple (a CLI) while trying it out. It may replace some existing skills.
- **Oracles.** The aim is to **become the oracle**; sources are often untrustworthy. The failure seen most
  was the tool **copying oracle code instead of deriving fresh**. So a reference grades a finished
  derivation and is never its input, and a disagreement is settled by the lower artifact, which can
  show the reference was wrong. *"often the goal is to become the oracle as often the source is not
  trustworthy."*
- **Naming.** Bottom-up, then a top-down verify: that gave the best quality and may be enough. Whether a
  third pass adds value is open. **No generic names** where avoidable.
- **Fix now or defer.** Fix the toolset now; project revisits come later.

## Built (2026-10-26)
- **Manual:** emu-harness `PHASES.md`: per phase, the commands (CLIs where they exist; *library* where a
  title tool calls the function, each a candidate verb), the gate, and the lessons from the
  [lessons page](./re-controller-lessons.md). A test holds its headings and gate lines to `phase_table.toml`.
- **`py -3.14 -m emu_harness status <project> [--json]`** reads `<project>/re-roadmap.toml` and starts
  the session at the first phase not done, or done with a **stale** gate: each phase lists the library
  paths its gate depends on, and a commit after the gate's recorded emu-harness commit that touches
  them makes it stale (git is asked; "unknown" never reads as fresh). The project is a folder by the
  sibling convention (`mappy-decompiler`; until 2026-10-27 Mappy sat one level inside a sibling, `game-annotation/mappy`).
- **Trial, Mappy** (emu-harness `24f306e`..`0c8f8a0`, game-annotation `c167ed0`..): classify and recon re-checked on
  the library; discover, data, naming, assets, live partial; structure stale (row R touched its tools);
  9 open revisits, 4 of them new from filling the roadmap (named phantoms, address-keyed names,
  `render_level`'s path hacks, a README CRC32 that matches no CRC of the dump). Start: discover.
- **Format notes from the trial:** the gate's "every jump table / 0 conflicts" parts were never measured
  on Mappy, so "partial" is the honest status for most phases of a project built before the gates existed
  (expected: the roadmap is how the tool directs the project, not a grade). **Directing rule added:** an
  open revisit on a *done* phase moves the start there, since the item contests the gate (earliest phase
  first), so Mappy starts at recon.
- **Fixed in the trial (Chris: a reused tool should be fixed):** Mappy's `render_level.py` ran on
  nes-render and NA1's CPU through `sys.path`, with a private bus and PPU stub. The PPU register model
  became `machines/nes/ppuport.PPUPort` (shared with `trace.PPUWrites`, identical on 12 NA1 traces) and
  plugs into `Bus(ppu=)`; all 16 rounds are identical in VRAM and pixels. The change staled Mappy's
  discover gate (its tracer runs on `Bus`), which is the staleness check working.
- **Naming hazard:** `phases.toml` beside `PHASES.md` shared a stem on a case-insensitive disk, and a
  `.bak` of one overwrote the other; renamed `phase_table.toml`.

## First revisit: Mappy (2026-10-26)
The tool directed it (`status` → recon, then discover), one gate at a time. emu-harness `4eb3022`,
game-annotation `063687f`, `06b32e6`.
- **Recon:** the README CRC32 that matched no CRC of our dump is the same ROM. PRG and CHR are
  byte-identical; only the iNES header differs (NES 2.0 vs 1.0).
- **Discover, done.** The gate had never been *measured*, and measuring it found the passes making
  phantoms. 19 walker conflicts → 4, all named by `passes.native.explain` (3 `BIT`-skip handler trios,
  1 dead path after `bne`/`beq`). Two table reads ran one word into the next routine and invented
  `$EEA9` and `$FA3F`; **`$EEA9` had been given a name** (`init_object_slots_strided`) by the June
  walk. All 4 "stored-pointer installs" were data pointers, counters or a mis-pair. A JSR to a
  return-address-popping dispatcher hid an inline table of **18 handlers** nobody had found. Code
  recall vs the published disassembly 96.9% → 99.4%, graded after.
- **The revisit list was wrong too:** 2 of the 3 listed "phantoms" are real fall-through entries
  (traced, with JSR callers). The lower artifact settled it, as the oracle rule says.
- **Papercut, fixed** (emu-harness `0964b69`): `status mappy` now finds a project one level inside a sibling repo (`game-annotation/mappy`), and refuses two matches.
- **Data, done** (game-annotation `915da27`). Every lane ran the game's own code headless: the text
  writers over each table index, the attract demo, and the sound engine one voice at a time, on a
  read-logging bus. That gives exact data extents (3,996 of 5,541 non-code bytes) and the screen text.
  The object record was proven by a carry test over demo frames plus the draw code (X/Y were swapped
  in the per-address names). **The xref tool had been decoding data as code: 33% of its links were
  false**, which is where names like `$7B` = "draw_data_ptr" (really the items-left counter) came from.
  The sound engine had been named as an object system. Library candidate: the read-logging `Bus`.
- **Structure, done** (game-annotation `5fb573c`, emu-harness `2f252ef`). A call graph with **typed
  edges**: call, jmp, flows-into (one routine rolls into the next), dispatch, inline, task. Each routine
  is walked by its own flow with every other entry as a stop; 275/275 reached (was 64%). Chris drew a
  call tree by hand from the vectors before seeing it; graded against that, 27 of 31 pairs are direct
  edges and 4 pass through one roll-into, and it exposed two edge bugs. The graph also renders as an
  interactive call-tree page (generated from `call_graph.json`).
- **Naming, in progress** (game-annotation `ef9093a`). Three guarded batches (renames only, every listing byte
  unchanged): 26 renames, 21 new labels. **The better coverage made the code nameable.** `$C141` had been
  read as a table-overrun artifact; once the overrun was fixed it was plainly the game thread's frame
  yield, with 15 callers. That exposed Mappy's two threads with two stacks (Chris: the render loop draws at
  vblank, the engine runs when it is not drawing); chapter 1's "one stack" is corrected. The sound engine
  and its 18 stream opcodes are named, checked against every stream's ending. The top-down pass over the
  render thread renamed 6, among them `flush_dirty_attribute_bytes` (it never cleared anything). The game
  thread's top-down pass and the variable names come next.
- **Variables, first pass** (game-annotation `b03ad18`). 25 renamed, 10 dropped (no instruction touches
  them). The pause flag was proven by its sprites: the row at `$C123` spells PAUSE in the sprite pattern
  table. Shared names went from 22 to 18; the rest are gameplay state, to be named with the game thread.
- **Game thread, top-down chunks 1-3** (game-annotation `35ec83e`, `fb346cc`): the skeleton, the per-frame
  update, score and HUD, and the draw path. 28 routines and 17 variables.
- **Naming sent discover back** (emu-harness `df306f6`, game-annotation `ecc2a29`). Before naming the object
  states, a Mesen write-watch on the 9 state bytes logged each writer's PC. The player's state-10 writer ran
  inside "data": 63 bytes of door handlers behind a shared `JMP ($001C)` stub reached by JSR, with the table
  loaded in the caller, out of the back-scan's reach. The library now resolves such a stub at each caller.
  Recall went from 99.4% to 100.0%, and a CDL over three play logs now finds no executed byte left
  undecoded. **A later phase is an oracle for an earlier one:** the gate passed at 99.4%, and only naming,
  by asking who writes a byte, found the hole.
- **The object state machine** (game-annotation `2e9be69`). 42 renames and 5 new labels: the 21 handlers by
  state, the shared transitions, the doors, the door wave and the dropped objects. The evidence was the code
  plus a census of three play logs (each state's runs and successors, and each write with its writer's PC).
  Two old names were wrong about *who*: `player_caught` holds only for slot 0, and
  `check_object_player_collision` never involves the player. Graded after against the published
  disassembly's 13 state comments: no disagreement, and 10 states it leaves blank are now named.
- **The bonus-round table** (game-annotation `d1fa1c6`). No play log reaches a bonus round, so the census
  gained a warp: poke one byte (the round number) so that clearing round 1 enters a bonus round, and poke
  the player onto the goal to reach the last two states. **A warp is evidence for what a handler does, not
  for how the game gets there**, so the gate records it as a warp. Graded after: 10/10 agree. That includes
  a state the sibling calls "unused", for which the census and a code scan had independently found no writer.
- **The game thread, done** (game-annotation `7d4718c`..`461d276`, chunks 4-9). All 234 routines were
  checked against their code, grouped by subsystem rather than by depth: round setup, the per-frame
  updaters, physics, the flows around a round, the draw path, and the leaves. The code explained the game's
  rules: the 10 items are fixed and the doors are what change per round, trampolines heal when the player
  touches a floor, a cat aims at the player's floor and uses a ROM byte as its RNG, the bonus round lasts
  2,220 frames, and the last four stages repeat forever. It also turned up an unreachable invincibility
  switch. **A checked keep must be recorded:** until `apply_names` wrote "Kept", a name someone had verified
  looked exactly like one nobody had read, so a coverage count could not tell them apart. The earlier pass's
  34 render-thread and sound routines still carry that gap.
- **The ROM data, named** (game-annotation `3e10dee`..`008cbb7`). `/data-walk` ran on Mappy by *shape*, not
  by filename. Its frontier tools are NA1's, so Mappy got its own: one lists every absolute operand into
  undecoded PRG, with the named routines that read it (58 elements → 0). The other follows each labelled
  pointer table to its blobs, taking the table's length from what its reader indexes (106 blobs). All of
  it is provenance naming with no agents. Two presentation gaps surfaced on the way, both from Chris's
  eye or the guard: the 6502 vectors printed as `.byte`, and the listing began at the first routine, so
  the 49-byte copyright at `$C000` was missing. That copyright is also the cat AI's random source.
  **Check that a listing shows every byte exactly once**: here the only repeats are the three known
  bit-skip overlaps.
- **Variables, round 2** (game-annotation `e848d4e`). No variable name is shared any more (18 names had
  covered 37 addresses), and unnamed touched addresses went from 90 to 5, each explained (one is a
  bit-skip operand, not a variable). The game-thread naming made this mostly transcription: the proven
  meanings were already in the routine notes. Two conventions came out of it: table fields are named by
  table and offset (`door_kind`, `tramp_bounces_left`), and absolute references to one slot get a slot name
  (`slot2_cooldown`). One general catch: `$00` read as `lda $00,x` is zero page indexed by an address held in
  X, not a pointer, and naming it so makes `bcd_add` read correctly.
- **Naming done** (game-annotation `f7ad739`, Chris): no placeholder names and no open revisits; names that are
  only provenance stay generic but correct. Assets come next, starting with the sound.
- **Assets: the sound** (emu-harness `32244c3`, game-annotation `37eed53`). The game's sound engine runs headless,
  and its APU stream was checked against Mesen **write for write** before anything was synthesized: replay the
  game's triggers and engine calls in cycle order, then compare 14,045 writes. **Check the input before building the
  player.** The synthesizer is generic (emu-harness `machines.nes.apu`, every constant from nesdev, tested against
  its formulas), so NA1 gets it free. One finding came along: the note table is one chromatic octave, A1 to G#2,
  within 3 cents.
- **Assets: the pictures** (game-annotation `6a1d564`..`883ea2d`). Every labelled picture and sprite pose is drawn by
  the ROM's own routines, headless, in the game's palettes. The pictures named what the code could not: the "dropped
  objects" are bells, the bonus goal is a balloon with Goro inside, the late chaser is a coin (Chris confirmed). The
  listing now carries ASCII art and decoded text under each label, Adventure-style. **A tool should find things by
  address, not by name:** renaming the pictures broke the first gallery, which had parsed label names.
- **Data-structure comments** (game-annotation `9107678`): the listing opens with a RAM-structures header generated
  from vars.toml, and each ROM table carries its layout. **Comments generated from the symbol files cannot drift**
  from them. Hand-written ones could. All three repos pushed.
- **Live verification and the assets gate: Mappy done** (emu-harness `454ec4a`, game-annotation `950eb9d`).
  - **Live.** The game's own per-object step runs headless from every live RAM dump and reproduces the next one:
    425,547 steps identical over 10 runs. Poked warps reach every state play never does, and a one-instruction
    planted fault is caught.
  - **Assets.** Just after each round type's load, live VRAM equals the game's own loaders run headless, byte for
    byte, and Mesen's screenshot equals the library's frame pixel for pixel.
  - **What the 15 leftover differences turned out to be.** First, blink phases. Instead of whitelisting them, the
    run replays the game's own per-frame drawers with the frame counter, which needed the queue's one-frame lag
    measured on Mesen. Second, a timed HUD split. Third, a sprite-priority rule the library had wrong. The last
    two are now library fixes with tests. **Explain a residual difference by running more of the game, not by
    listing exceptions.**
  - A bonus round moves at once, so its snapshot frame is the one quiet frame, and the suite records why.
  - Chapter 10 summarizes the pass and corrects chapters 7-9. Chapter 9's "object animation VM" was the sound
    engine.

## Second revisit: NA1 (2026-10-27)
NA1 was the early attempt that set many of the rules, and it is the most worked-out title. It is also the
**root of the KOEI oracle chain**: every later title took its native names from NA1, so nothing had ever
graded NA1 (`native_floor` refuses it by design). Chris's aim for the revisit: check that the harness was
isolated properly. emu-harness `47e7f66`, na1-decompiler `38387b5`.
- **Filling the roadmap re-ran the vm gates**, and one failed. `cfg_gate` diverges on 3 of 499 subs, all
  three June "CERTIFIED" ext-op folds. Run on the ROM at the branch edges: `scale_div10_capcheck` is
  `ab > 10c ? 0xFFFF : ⌊ab/10⌋` (the certified `⌊ab/10⌋ >= c` fails 6 of 8 edge inputs), and `math32_3arg`
  returns `0xFFFF` for `c = 0` (the C divides by zero). The June grid had 9 points and none on a branch
  edge. The same formulas live in the simulator, so it is an open structure revisit. **A gate passes only
  if it can fail**, now found on the project that taught it.
- **Recon, done.** The listed revisit (retire a legacy opcode table "still read" by two tools) had the
  wrong premise, as Mappy's phantom list did: nothing read it. The real break was elsewhere. The appendix
  generator read a data file through the `na1dream` alias, and **an alias forwards modules, not package
  data**. It now reads the library's path, and the regenerated appendix picks up 4 operand lengths that
  row F2 measured on the handlers.
- **A guard had gone missing in a refactor.** The probe that caught NA1's 323 inverted compares (June) had
  been atticked as "archaeology" and no longer imported, and no harness gate checks compare direction:
  round-trip and CFG gates stay green while the C inverts every threshold. It is now
  `gates.compare_probe` (any title: 9/9, 90/90, with a planted swap in the tests). **An attic can hold
  guards, not just history:** the rest of NA1's attic is a revisit. Its table half used to pass silently
  when the table was missing; that half fails now.
- **A hand edit to a generated file** (`$A8`'s description) would have been lost on regeneration. It
  moved into the source table.
- **The entry doc drifted:** CONTEXT.md, the read-first file, routes to 6 tools that no longer exist. Open
  as a presentation revisit.
- **The 6502 half was the gap** (Chris: *"we seem to be able to document the KOEI code well, but not the
  6502"*). The labeled 6502 listing stays, regenerated by the shared tools, with bytecode shown as a pointer
  into the VM listing rather than as large data sections.
- **Discover, done** (emu-harness `4ed0685`, na1-decompiler `ca21d44`). In a KOEI fixed bank, native code
  and bytecode interleave, so the walk first masks the 135 bytecode bodies, using the round-trip encoder's
  extents. 335 native routines. Then **every PC in NA1's 14 old Mesen traces** (30.3 M fixed-bank steps,
  captured in June for other reasons) must be an instruction start or a bytecode stub: 0 holes. That check
  found the one piece of code nothing reached: `$F23C`, where every syscall returns. A syscall is a
  software interrupt (`PHP`, `JMP ($FFFE)`), so only `RTI` reaches it. **Old captures are a CDL you already
  have.**
- **Grading the root.** NA1 was graded against ro3k, and the bytes settled each disagreement:
  157/157 VM-handler names sit at their opcode's handler, and all 10 32-bit compare names hold on the live
  handler. One NA1 name was wrong (the illegal-opcode `BRK`, called a syscall trigger). Going the other way,
  **10 compare names in na2, bk and GemFire point the wrong way**. They were inherited from NA1 by
  signature, because a compare and its operand-swapped twin look identical to a fingerprint, and each
  carries a dedup suffix that gives it away. `compare_probe` now checks 32-bit compares on every title.
  **A fingerprint can carry a name, but it cannot carry a direction.**
- **The instrument was wrong twice and was checked each time:** a 32-bit readback that leaked the input's
  high word, and na2's profile pointing two entries past its real ext-op table. Read the table from the
  code that indexes it. The orphans were 5 dead library subs and 2 phantoms. A tighter phantom rule would
  drop real routines in 8 other titles, so it is logged with its numbers rather than applied.
- **Why KOEI's syscalls return by `RTI`** (Chris): the MMC1 carts never raise an IRQ, so KOEI used the IRQ/BRK
  vector as the syscall entry. Later titles (NA2, BK) moved to a private vector at `$FFF8`, which kept
  machines with working interrupts compatible.
- **Data, done** (na1-decompiler `ed1d865`, `4cba60c`). Writing even one name needed `source/` regenerated
  first. The regen script passed absolute paths, which put this machine's directory layout into ~1,000
  lines, and the engine writes no "do not hand-edit" banner. Both are fixed: 68 lines, each explained,
  and two runs give identical output. **Read a regen's diff by kind before committing it.** The lanes went
  to zero: 21 strings, 4 "tables" (3 of them short strings the lane misread as binary), and 10 of 20 hot
  RAM addresses, the other 10 being record fields. Names came from each address's readers:
  `player_daimyo` (compared with `fief_owner` where the game prints "Control %d") and `sram_save_signature`
  (compared with "KOEI"). One guess was wrong and the readers caught it: `$6193` is the relations matrix,
  and its 50 × 8 offset was a coincidence.
- **A data name changes rendering, not just a token** (`mem_7FE1` → name, `*(byte*)((i+X))` → `name[i]`).
  The engine's negation folding is textual too, so naming an operand flipped `!(a == b)` into `a != b`. The
  data apply checks each name against the literal it replaced, with those forms canonicalized for the named
  addresses only. A label planted on a code address fails it. The textual inverter goes to structure:
  a first-match split could invert the wrong operator. Next: structure, starting with the ext-op formulas.

## Tensions, as resolved
1. Sibling oracles: grade after, never derive from; the derivation aims to replace the reference.
2. Agents: sequential inference by default, an agent per phase at most.
3. Who writes: the verified survivors of the bottom-up + top-down passes; a third pass only if it earns it.
4. Refuted names: mechanism or provenance names, never address keys.
5. Fix now or defer: toolset now, projects at their revisit.
6. Data walk placement: the pure lane early, provenance and analytical walks in naming.

## Open Questions
- ~~Home: manual in emu-harness beside `MIGRATION.md`, skill in the vault (like `/label-walk`)? Or both here?~~ **Resolved 2026-10-26** → [Decisions](#decisions-chris-2026-10-26): manual and tool in emu-harness, state in each project.
- ~~State: `CONTEXT.md` block (human-first) or a machine-readable file the controller updates?~~ **Resolved 2026-10-26** → [Decisions](#decisions-chris-2026-10-26): each project keeps its own roadmap of where it is.
- ~~Autonomy: advisory first (one phase per session), driving later once the phase table has proved itself?~~ **Resolved 2026-10-26** → [Decisions](#decisions-chris-2026-10-26): one project per session, sequential inference.
- ~~Is a CLI with JSON enough for Claude Code, or does the RE side want MCP from the start (claude.ai use)?~~ **Resolved 2026-10-26** → [Decisions](#decisions-chris-2026-10-26): keep it simple while trying it out.
- ~~Which existing skills does the build tool replace (`/label-walk`, `/data-walk`, `/var-walk`, `/nobunaga`)?~~ **Resolved 2026-10-26** → all four leave the vault. The walks' method is emu-harness `PHASES.md` §5 and their Workflow scripts `workflows/`, with each title's facts in its `walk-context.json` (NA1's first; the old scripts' NA1 paths had gone stale). `/nobunaga` is NA1's own tool surface, so it moved into that repo.
- Does a third naming pass, after bottom-up and top-down, add value?
- Should an early breakdown (Mappy, Adventure, Utopia, M.U.L.E. inside `game-annotation`) get its own repo, as
  the KOEI titles did? Chris (2026-10-26): *"these early breakdowns did not get their own project folders, and
  this might be a mistake."* For now `status` finds them inside their monorepo.

## Tags
[reverse-engineering](../tags/reverse-engineering.md) · [methodology](../tags/methodology.md) · [agent-teams](../tags/agent-teams.md) · [claude](../tags/claude.md)

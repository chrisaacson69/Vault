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
[Project SDK](../projects/CLAUDE.md) · skills `/label-walk`, `/data-walk`, `/var-walk` ·
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
  sibling convention (`game-annotation/mappy`).
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
- **Papercut:** `status mappy` does not resolve the logical name; it needs `../game-annotation/mappy`.
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
- Which existing skills does the build tool replace (`/label-walk`, `/data-walk`, `/var-walk`, `/nobunaga`)?
- Does a third naming pass, after bottom-up and top-down, add value?

## Tags
[reverse-engineering](../tags/reverse-engineering.md) · [methodology](../tags/methodology.md) · [agent-teams](../tags/agent-teams.md) · [claude](../tags/claude.md)

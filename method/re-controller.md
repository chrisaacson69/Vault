---
status: draft
created: 2026-10-26
published: false
layout: layouts/page.njk
title: "The RE Controller"
---
# The RE Controller — an LLM interface to the toolset, plus a phase plan
> The emu-harness consolidation (rows A–R, closed 2026-10-26) gave every disassembly project one tool
> library. What is missing is the **controller**: an agent-facing guide that knows the order of work,
> what proves each phase done, and where each project stands. It mirrors
> [CyborgDJ as Controller](../research/cyborgdj-inference-interface.md): the library is the tool
> surface (MCP-shaped), inference holds the plan, deterministic code does the busywork. **Draft for review;
> nothing built yet.**

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
artifact can check it.

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
A phase table in each repo's `CONTEXT.md`: phase, status (done / partial / n.a.), the gate's last result
and date, the emu-harness commit it ran on, and open revisit items. `status` reads it; a session
starts from the first phase that isn't done, or whose gate is stale against the current toolset.

## Tensions to decide (from the harvest)
1. **Sibling oracles.** "Use the NES oracle earlier" vs "derive blind, then grade". *Proposed:* consult
   the sibling as a **check after each derivation**, never as derivation input.
2. **Agents.** The walk skills fan out; GemFire/BK walked strictly sequentially; Chris saw a week's tokens
   burn in two days. *Proposed:* sequential by default, fan out only for genuinely-unknown reads in bulk.
3. **Who writes.** Auto-write the verifier's survivors, or the coordinator re-grounds each one first?
4. **Refuted names.** A mechanism or provenance name is fine; an information-free address key is not.
5. **Fix now or defer.** Toolset bugs are the foundation and get fixed now; project artifacts wait for
   their revisit.
6. **Data walk placement.** Already reconciled: the pure lane goes early (phase 3), provenance and
   analytical walks go in naming (phase 5).

## First use
The per-project revisits in emu-harness `MIGRATION.md`, one session each: "controller, audit UW" walks
UW's phases, reruns each gate on the finished toolset, and works the logged items as known findings.

## Open Questions
- Home: manual in emu-harness beside `MIGRATION.md`, skill in the vault (like `/label-walk`)? Or both here?
- State: `CONTEXT.md` block (human-first) or a machine-readable file the controller updates?
- Autonomy: advisory first (one phase per session), driving later once the phase table has proved itself?
- Is a CLI with JSON enough for Claude Code, or does the RE side want MCP from the start (claude.ai use)?

## Tags
[reverse-engineering](../tags/reverse-engineering.md) · [methodology](../tags/methodology.md) · [agent-teams](../tags/agent-teams.md) · [claude](../tags/claude.md)

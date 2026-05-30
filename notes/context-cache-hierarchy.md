---
status: active
created: 2026-05-29
---
# The Context Cache Hierarchy — Memory Layers, Eviction, and Drift
> Claude Code's memory layers map cleanly onto a CPU cache hierarchy. A cache works because it has an eviction policy. This memory system has a promotion path and no eviction path — which is exactly where the drift comes from.

**Links:** [Karpathy LLM Wiki Convergence](./karpathy-llm-wiki-convergence.md), [Working With Claude](./working-with-claude.md), [Claude Code Skill Engineering](./claude-code-skill-engineering.md), [Principled LLM Code](../research/principled-llm-code.md)

## The layer map

| Cache level | Claude Code layer | Property that must hold | Changes |
|---|---|---|---|
| L1 (registers) | active conversation | ephemeral, fastest | every turn |
| L2/L3 (hot) | `CLAUDE.md` + `MEMORY.md` index | **always loaded, hard size budget** | rarely (firmware) |
| System RAM | `memory/*.md` topic files, skills, shared lib | recalled / invoked on relevance | per-topic |
| Disk | the vault itself (`INDEX.md` → pages) | unbounded, retrieved on demand | constantly |

The analogy isn't just illustrative — it's **diagnostic.** It tells you exactly where the drift lives.

## The diagnosis: promotion without eviction

A cache works because it has an **eviction policy**. This memory system has a promotion path (things get added, things get pinned) and **no eviction path.** That single asymmetry is the entire drift mechanism.

Things creep *upward*:
- Detail that belongs in a topic file (RAM) ends up baked into a `MEMORY.md` line (L2).
- Project state that belongs in a topic file ends up in `CLAUDE.md` (firmware).

Promotion without eviction is the textbook definition of **cache thrash.** Nothing ever pushes content back down, so the hot layer bloats until it stops fitting — and a hot layer that doesn't fit loads *partially*, which makes recall nondeterministic. That is "drift now and then," mechanically.

## The live bug (2026-05-29)

This was happening in-session when these notes were written. The harness reported at startup:

> `MEMORY.md is 28.9KB (limit 24.4KB) — only part of it was loaded.`

81 index entries averaging ~357 chars each. Many were 300–400-char *paragraphs* (the M.U.L.E. entry, the combat-terminators entry) — **content sitting in the index layer.** Data was put in L2; L2 thrashed; intent got lost. Not model degradation — a lookup table that stopped fitting in cache. Fixed the same day by trimming every line to a ~120-char pointer (link + distinctive hook); the detail already lives in the topic file each line points to.

## The placement rule

The confusion — "what layer do I keep this on?" — has a decision rule the cache analogy hands you for free. **Promote by access-frequency × stability, not by importance.**

- **`CLAUDE.md` (firmware):** only what's true *every* session AND stable. Conventions, structure, how-to-work. **Not** findings, not project state.
- **`MEMORY.md` (L2 index):** one-line pointers, hard budget. It's a *lookup table, not storage.* The moment a line carries content instead of a pointer, you've put data in the index and it thrashes. Keep the distinctive keyword in the hook so recall still triggers; push everything else down.
- **`memory/*.md` (RAM):** the actual facts, one per file, recalled on relevance.
- **Vault pages (disk):** unbounded, reached via `INDEX.md`.

The recurring failure is always the same shape: **content creeping up the hierarchy.** The fix is always the same: push it back down and leave a pointer.

## The missing janitor

"Do we need more healthchecks?" — No, a *different* one. `/vault-heartbeat` lints the **disk** (broken links, stubs, tag mismatches). Nothing lints the **cache.** The hot-layer janitor doesn't exist yet. A memory-hygiene check should enforce:

1. **Budget** — `MEMORY.md` under its KB limit, with headroom.
2. **Entry length** — flag any index line over ~200 chars (it's carrying content, not pointing).
3. **Pointer-not-content lint** — does the line *route to* a fact, or *is it* the fact?
4. **Dedup** — two memories covering the same fact → merge.
5. **Staleness** — memories whose named files/flags no longer exist → demote or delete.

A cache needs a janitor with an eviction policy. Right now nothing evicts — so build the eviction policy as a check and run it on the heartbeat cadence.

## Why this matters beyond bookkeeping

This is the same persistence argument as [Principled LLM Code](../research/principled-llm-code.md), one level down: the architecture only holds if the *layer that stores the architecture* is itself maintained. An unmanaged memory hierarchy drifts for the identical reason an unmanaged codebase accretes — the **verification-layer thesis** applies to the verification layer's own plumbing. [Karpathy's convergence](./karpathy-llm-wiki-convergence.md) got the *layers* right but stopped before the *eviction* question; this is the next turn of that screw.

## Tags

[ai](../tags/ai.md), [cyborg](../tags/cyborg.md), [software-engineering](../tags/software-engineering.md)

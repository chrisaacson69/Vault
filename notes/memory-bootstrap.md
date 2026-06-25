---
status: active
created: 2026-06-25
published: true
layout: layouts/page.njk
title: "Memory Subsystem — Cold-Start Bootstrap"
---
# Memory Subsystem — Cold-Start Bootstrap

> How to stand up the OS memory scheduler **from zero** on a fresh instance when nothing
> transferred. This is the *cold-start* path; for **carrying an existing memory across machines**
> (the normal case), use the 7z transfer in [New Machine Migration](./new-machine-migration.md).
> The memory subsystem normally **persists across all sessions** on a machine and is never recreated
> — this page exists only so a brand-new instance with an empty `~/.claude` can rebuild a valid one.

**Links:** [New Machine Migration](./new-machine-migration.md), [Context Cache Hierarchy](./context-cache-hierarchy.md), [vault CLAUDE.md → "Memory subsystem"](../CLAUDE.md)

The *architecture & maintenance discipline* (the three tiers, eviction, placement = frequency × stability,
spawn/harvest/crystallize) lives in [CLAUDE.md → "Memory subsystem"](../CLAUDE.md) and is not repeated here.
This page is only the missing piece: the on-disk **location, file schema, and seed templates** needed to
*author* the files — which previously existed only in the harness-injected prompt, not in the repo.

## 1. Where it lives

```
~/.claude/projects/<vault-slug>/memory/
```

`<vault-slug>` is the vault's working-directory path with the separators `: \ / .` each replaced by `-`
(e.g. `C:\Users\Chris.Isaacson\Vault` → `C--Users-Chris-Isaacson-Vault`). The harness derives this slug
automatically from the project cwd; the authoritative value is whatever directory it creates under
`~/.claude/projects/`. If unsure, list that folder and match the slugified cwd. This directory is
**machine-local and never committed** (it holds private politics/career/personal pages).

## 2. File types (encoded in BOTH the filename prefix and `metadata.type`)

| Prefix | `metadata.type` | What | Tier |
|--------|-----------------|------|------|
| `MEMORY.md` | — | the global router, **pointers only** | 1 |
| `area_*.md` | `reference` | per-area index, surfaced by recall via its `description:` | 2 |
| `feedback_*.md` | `feedback` | a working-discipline lesson (with **Why:** / **How to apply:**) | 3 |
| `project_*.md` | `project` | an ongoing-work / result fact | 3 |
| `user_*.md` | `user` | who Chris is / a durable preference | 3 |
| `reference_*.md` | `reference` | a pointer to an external resource | 3 |

## 3. Topic-file schema (tier 3 — one fact per file)

```markdown
---
name: <short-kebab-case-slug>          # matches the filename without .md
description: <one-line summary — this is what recall matches on, so make it findable>
metadata:
  type: user | feedback | project | reference
---

<the fact. For feedback/project, follow with:>

**Why:** <the reason it matters>

**How to apply:** <the operational rule> Link related memories with [[their-name]].
```

> Note: live files auto-created by the harness may also carry `metadata.node_type: memory` and an
> `originSessionId:` — these are harness-added and optional; the canonical *hand-authored* schema is just
> `name` / `description` / `metadata.type`.

## 4. Area-index schema (tier 2 — one per area)

```markdown
---
name: area_<area>
description: <what this area covers + WHEN to recall it — recall keys off this line>
metadata:
  type: reference
---

# Area index: <Area Name>

- [<Title>](<topic_file.md>) — <≤200-char one-line hook pointing at the topic file>
- ...
```

## 5. `MEMORY.md` seed (tier 1 — pointers only, loads every session)

Minimum viable router. Keep it under the ~24 KB load cap; **never** put content or rules here — it routes.

```markdown
# MEMORY — global orchestrator (POINTERS ONLY)

This file loads every session regardless of cwd, so it stays lean: it routes to the relevant area,
and the area's store carries the specifics. Tiers: this router → area indexes → long-term stores
(root CLAUDE.md for behavioral law, vault .md pages for knowledge, per-repo CLAUDE.md for code).

## Always-on (the few that must be hot every session)
- **Grounding discipline (#1 rule):** never fabricate; reuse/convert > rebuild; missing grounding → find it or ask. Full text: root CLAUDE.md → "Grounding Discipline".
- **Who Chris is + how to work:** structure over demos, architecture IS the product, quality-not-volume. Root CLAUDE.md → "Operating Context".

## Areas (route → read the store → continue)
- **<Area>** → [[area_<area>]] (<count>); store = <where the specifics live>.

<!-- Maintenance: pointers-only. Full derive-&-maintain discipline = vault CLAUDE.md "Memory subsystem". -->
```

## 6. Procedure

1. Create the directory in §1.
2. Write `MEMORY.md` from the §5 seed (just the two always-on facts + empty Areas list).
3. As findings appear, mint topic files (§3) and register each as a one-line pointer in its area index
   (§4) — **never** in `MEMORY.md`. Create an area index the first time an area gets a finding.
4. The committed vault is the deep store: a cold memory can be **re-grown** by reading `INDEX.md` and
   recent `research/` pages and re-crystallizing the durable theses — slower than a transfer, but the
   knowledge is recoverable because it was harvested up to the vault in the first place.

## Tags
[meta-musing](../tags/meta-musing.md)

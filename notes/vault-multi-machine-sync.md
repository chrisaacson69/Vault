---
status: active
created: 2026-08-26
published: true
layout: layouts/page.njk
title: "Vault Multi-Machine Sync — Branching, Divergence, and Merge Resolution"
---
# Vault Multi-Machine Sync — Branching, Divergence, and Merge Resolution
> The vault runs on two machines and commits straight to `master` on both. That's the right call for a single-author knowledge repo — but it means divergence is resolved by *merge*, not by review. Most of the conflict surface is **derived files**, which are re-generated rather than hand-merged.

**Links:** [New Machine Migration](./new-machine-migration.md) (the one-way transition runbook this is the ongoing sibling to), [Memory Subsystem — Cold-Start Bootstrap](./memory-bootstrap.md), [Author Web, Derive Hierarchy](../method/author-web-derive-hierarchy.md), [The Context Cache Hierarchy](./context-cache-hierarchy.md)

## Why no branches

Branches exist to stage work for review before it reaches a shared trunk. This vault has one author, no PR flow, and a linear `master` history — so a branch adds a merge step and buys nothing. **Commit direct to `master`.** The safeguards that would normally live in review live elsewhere: the `raw/` immutability hook, the INDEX drift gate, `/vault-heartbeat`, and the derive-tools that can rebuild any generated file from the pages.

The cost of that choice is that **two machines diverge on the same branch**, and there is no reviewer in between. Hence this page.

## The actual failure mode: mutual non-publishing

Divergence is cheap to fix and expensive to postpone. The trap is both machines accumulating unpushed commits from a shared base — then neither can fast-forward and every append-heavy file collides at once.

**State on 2026-08-26** (recorded because it's the exact shape of the problem):

| | |
|---|---|
| `origin/master` | `73d74f7`, 2026-08-18 |
| This machine | **21 ahead, 0 behind** — nothing pushed since |
| Other machine | ran `/vault-heartbeat`, added content, **also unpushed** |

Both diverged from the same base and neither published. `git fetch` reaches GitHub fine (only YouTube is SNI-blocked here), so nothing technical was stopping it.

**The cheap move, while it's still available:** push the machine that is *strictly ahead* first. `origin` fast-forwards with zero conflict, and the other machine then has only its own work to reconcile onto a published base — a **one-sided** merge instead of a two-sided one. Do this before the other machine's changes grow.

**Standing habit that prevents all of it:** push at the end of any session that commits. An unpushed vault is a vault with an unowned second copy.

## Conflict taxonomy — resolve by class, not file by file

Almost none of this needs careful hand-merging, because most of what the heartbeat writes is *derived*. This is [Author Web, Derive Hierarchy](../method/author-web-derive-hierarchy.md) applied to merges: **anything the tools can regenerate should be resolved by regenerating it.**

| Class | Files | Resolution |
|---|---|---|
| **Derived** | `tags/*.md`, `tags/_index.md` | Take **either** side to clear the conflict, then re-derive (below). Never hand-merge — a hand-merged index is unverified. |
| **Append-only** | `logs/CHANGELOG.md` | `merge=union` in `.gitattributes` concatenates both sides automatically. Review ordering afterwards — union doesn't sort. |
| **Authored, append-heavy** | `INDEX.md`, `method/README.md`, area READMEs | Genuine conflicts, but both sides' entries are *wanted*: **keep both hunks**, don't choose. Then verify nothing was dropped. |
| **Immutable** | `raw/**` | Cannot conflict by construction — new captures only, and the `PreToolUse` hook blocks edits to existing ones. |
| **Authored pages** | `research/`, `notes/`, `method/` | Two machines rarely touch the same page. When they do, it's a real editorial merge — read both. |
| **Outside git entirely** | `~/.claude/.../memory/` | See the gap below. Git will not merge this and will not warn you. |

## The regeneration sequence

Order matters — each layer derives from the one below, per `/vault-heartbeat` §1c:

```bash
# after resolving derived-file conflicts with either side
py -3 tools/vault-tagindex.py --write   # pages' ## Tags  ->  tags/<tag>.md
py -3 tools/tag-counts.py    --write    # tags/<tag>.md   ->  counts in tags/_index.md
```

## Post-merge verification

A merge is not done when it compiles; it's done when the derive-layer agrees with the pages:

```bash
py -3 tools/vault-fix-links.py     # dry-run: 0 new broken links
py -3 tools/vault-graph.py         # orphans / structural drift
py -3 tools/vault-tagindex.py      # dry-run: should report 0 changes after regenerating
```

Then run `/vault-heartbeat` — its §1 structural scan is the acceptance test for a merged vault, and `logs/index-drift.log` records pages the Stop-hook caught being left out of `INDEX.md`.

## Two gaps worth knowing about

**1. `memory/` does not sync.** The memory subsystem lives in `~/.claude/projects/<vault>/memory/`, **outside the repo**. Git will neither merge it nor tell you it diverged. If the other machine's heartbeat updated area indexes or topic files, that work is stranded on that machine and is invisible to every check on this page. [New Machine Migration](./new-machine-migration.md) covers *transferring* `~/.claude/` once, and [memory-bootstrap.md](./memory-bootstrap.md) covers recreating it from zero — neither covers *ongoing two-way sync*, which remains unsolved. Until it is, treat one machine as the memory authority and re-derive on the other, or diff the two `memory/` trees by hand after a merge.

**2. Line endings were an unguarded footgun.** Both machines currently run `core.autocrlf=true` and every committed blob is LF (verified 2026-08-26), so nothing is wrong today. But there was no `.gitattributes`, and a clone with `core.autocrlf=false` would start committing CRLF blobs — after which a merge conflicts on *every line of every file*, which reads as catastrophic divergence rather than as a settings mismatch. Now pinned with `* text=auto`. Because the repo was already all-LF, adding it renormalized nothing.

## Open Questions

1. **How should `memory/` sync?** Options: a private repo, a symlink into the vault under a gitignored path (defeats the point), or accepting one-machine-authority and re-deriving. Unresolved, and it's the only piece of the system with no story at all.
2. **Is `merge=union` right for `CHANGELOG.md`?** It never conflicts, but it can interleave two machines' entries out of date order. Better than a conflict; unclear whether it's better than a dated-section convention that makes collisions structurally impossible.
3. **Should the heartbeat refuse to run on an unpushed divergent tree?** It's the natural enforcement point — it already reads git state for the GitHub check — and it would turn "remember to push" from a habit into a gate. Same request-vs-rule distinction as the `raw/` hook.

## Tags

[workflow](../tags/workflow.md), [tools](../tags/tools.md), [methodology](../tags/methodology.md)

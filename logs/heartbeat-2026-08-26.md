---
status: completed
created: 2026-08-26
---
# Vault Heartbeat — 2026-08-26
> First recorded heartbeat. Structural pass clean after repair; tag layer went 35 discrepancies → 0; the skill's own two checks were found buggy and fixed. **This file is the baseline date for the next run's incremental scope.**

**Links:** [vault-heartbeat skill](../.claude/skills/vault-heartbeat/SKILL.md), [Vault manual](../CLAUDE.md), [INDEX](../INDEX.md)

## Fixed this run

- **Broken source links** — `research/claude-opus-4-6.md` pointed at `./transcript1_clean.txt` / `./transcript2_clean.txt`; the files live in `raw/videos/`. A page whose Sources section can't reach its sources is the Grounding Discipline failing quietly. Repointed. `.claude/skills/debate-review/SKILL.md:78` was one level short to `the-fallacy-fallacy.md`; fixed.
- **Tag layer, 35 discrepancies → 0.** 6 tag files (`agent-teams`, `battletech`, `compilers`, `fiction`, `koei`, `projects`) existed but were unregistered in `tags/_index.md` — the append-without-integrate failure the manual names, which makes a tag *unfindable*. Registered, and `_index.md` rebuilt with true counts (also now alphabetical).
- **39 pages / 55 pairs repaired.** The diagnosis that mattered: **the tag files were right and the pages had lost their `## Tags` entries** — `research/nes/*` not carrying `nes`, the KOEI gaming pages not carrying `koei`, `praxis-agent-teams` not carrying `agent-teams`. Evicting the back-links (the tempting read of "count mismatch") would have destroyed a correct index. Rule recorded in the skill: *when a ghost's file still exists, repair the page, not the tag file.*
- **11 missing back-links** added to tag files; 2 spurious ones reverted (see below).

## The skill was auditing with two broken checks

Both are now fixed in `SKILL.md`, and the deterministic checkers are **saved as scripts** so they stop being re-derived (and re-broken) each run:

| Check | Bug | Fix |
|---|---|---|
| **1.5c raw coverage** | Matched by **filename only** → flagged 75 of 194 source groups. Spot-checking four clusters (`peikoff-hop-*`, `mcfadden-*` battlezone/stellar7, all 8 `wordwar-results-*`, the hangman substack) found **all four fully processed** — pages cite by URL or under an unrelated page name. ~70% false-positive. | Three passes: collapse sibling formats → match by URL → match by topic keyword. Report only what survives all three, and say which passes ran. |
| **1g canary** | Flagged Claude Code's own `file-history/` backups and session `.jsonl` transcripts as violations. They match every token every run — turning a real invariant into noise trains the reader to ignore a genuine FAIL. | Exclude generated state; check authored files only. |
| **1c tags** (added) | Checked two sets, missing the ghost/missing split; counted tag links appearing anywhere in a page. | Three-set check; **a tag counts only inside the `## Tags` section** — body prose legitimately links tag files (`CLAUDE.md`'s example, the Dataview note) and counting those *invents* tags. Tag→tag "related" links excluded. |

New: `.claude/skills/vault-heartbeat/scripts/check.py` (read-only) and `repair-tags.py` (dry-run by default).

**The section rule caught its own predecessor's mistake.** My looser first pass added `game-theory` back-links for `wilson-christians-right-to-rule` and `wilson-rights-dont-exist-only-force`; under the correct rule those are deliberate *inline cross-references* in body prose ("the convention/procedure layer"), not tag declarations. Both reverted. Whether those two pages *should* carry `game-theory` is a content judgment left for Chris — see Open Questions.

## Still open (not actioned)

- **Genuinely unprocessed raw** (survived all three passes): `raw/debates/wilson-dillahunty.*` (548 KB, the largest uncovered source — no page anywhere); `raw/videos/2026-05-23 self-improving-claude-knowledge-base.txt` (37 KB, and directly on-topic for this vault's own method); `raw/articles/ancapjustice.txt` (12 KB); plus 5 opaque-ID files (`ShusuVq32hc`, `BCh-OXkY-5o`, `part1/2/3`, `transcript-vwtri2rITro`) that may be duplicates already processed under other names.
- **15 one-directional cross-links** from the three newest pages; `research/llm-grounding-problem.md` links out to 5 economics pages written in the *same session* that never linked back.
- **12 stale time-sensitive pages** (>90 days, model/pricing claims): `claude-opus-4-6.md`, `claude-code-cloud-vm.md`, `level-6-direct-execution.md`, `llm-praxeology.md`, `llm-game-benchmark.md`, `context-cache-hierarchy.md` and others.
- **Bloat vs. the manual's 60–80-line hub rule**: `research/gaming/README.md` (144), `research/debates/README.md` (141), `master-of-magic/README.md` (147), `tools/README.md` (104). Non-hub >500 lines: `catan-47k-empirical` (736), `moo1/optimal-strategy` (715), `industrial-revolution-political-transformation` (686), `poverty-exploitation-prep` (618), `llm-agents-across-games` (616), + 3 debate pages.
- **1 stub**: `research/cognitive-vs-motor.md` — now load-bearing (cited by `llm-grounding-problem.md`).

## Clean

INDEX.md 407 relative links / 0 broken · canary placement PASS (each token = kernel table + its own layer file) · index-drift gate healthy (48 firings Jun 5 / Jul 25 / Aug 18, **zero pages still unindexed** — every nudge actioned, no `/vault-sync` sweep needed) · provenance clean on all 20 pages changed since 2026-08-23 · no open PRs across 14 repos.

## Scope

**Audited:** full structural pass (links vault-wide, stubs, tags, bloat, drift log, canary) + semantic pass on all 20 pages changed since 2026-08-23 + topic-verification of 20 raw clusters.
**Not audited:** cross-cluster contradiction detection (1.5b) and the rotating ~10-page older sample — no prior heartbeat report existed, so there was no baseline date to diff from. **This file supplies it for next time.**

## Open Questions

- Should `wilson-christians-right-to-rule.md` and `wilson-rights-dont-exist-only-force.md` actually carry the `game-theory` tag? Both make a substantive convention-as-equilibrium argument; currently they only cross-reference it inline.
- Should `vault-ingest` write a `**Source:**` line naming the real `raw/` path into every page it creates? That converts 1.5c's three-pass heuristic into an exact lookup and permanently retires the false-positive problem.

## Tags

[methodology](../tags/methodology.md) · [workflow](../tags/workflow.md) · [tools](../tags/tools.md)

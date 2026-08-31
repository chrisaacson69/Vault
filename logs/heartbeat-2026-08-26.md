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

### Correction — most of those checkers already existed, in `tools/`

The first version of this report claimed two new scripts, `check.py` and `repair-tags.py`. **They were
rebuilds.** `tools/` already held `vault-graph.py` (broken links + ledger reciprocity + orphans),
`vault-tagindex.py` (derive `tags/<tag>.md` from each page's `## Tags`), `tag-counts.py` (recompute
`_index.md` counts), `vault-fix-links.py`, and `vault-backlinks.py` — all indexed in `tools/README.md`,
all implementing [author-web-derive-hierarchy](../method/author-web-derive-hierarchy.md)'s *derive, never
hand-maintain* rule. `/vault-sync` already routed to `tag-counts.py`.

The rebuilds were worse: mine appended bare `- [Title](path)` back-links where `vault-tagindex.py`
preserves curated one-liners, and when the real tools were finally run they found live drift mine had
just declared clean (`tags/debates.md` +3, `tags/epistemology.md` +1, two counts off). Both were deleted;
the residual drift was fixed with `vault-tagindex.py --write` then `tag-counts.py --write`.

**Root cause, and it is the vault's own predicted failure mode:** `tools/README.md` was a good index —
this skill just never pointed at it (`grep -c "tools/"` on the heartbeat SKILL returned **0**). A
capability nothing routes to is unfindable, and unfindable capability gets rebuilt. Fixed in both
directions: the heartbeat now opens with a "read `tools/README.md` first" block, and `tools/README.md`
now names its consumer skills. *Reuse requires findability — protect the meta-tool.*

Kept: `.claude/skills/vault-heartbeat/scripts/heartbeat-checks.py`, reduced to the **two** checks
`tools/` genuinely lacks — raw-coverage pass 1, and the tag-ghost direction `vault-tagindex.py` leaves
alone (it prunes entries whose target is *gone*, not ones whose target still exists but stopped
declaring the tag).

**The section rule caught its own predecessor's mistake.** My looser first pass added `game-theory` back-links for `wilson-christians-right-to-rule` and `wilson-rights-dont-exist-only-force`; under the correct rule those are deliberate *inline cross-references* in body prose ("the convention/procedure layer"), not tag declarations. Both reverted. Whether those two pages *should* carry `game-theory` is a content judgment left for Chris — see Open Questions.

## Still open (not actioned)

- **Genuinely unprocessed raw** (survived all three passes): `raw/debates/wilson-dillahunty.*` (548 KB, the largest uncovered source — no page anywhere); `raw/videos/2026-05-23 self-improving-claude-knowledge-base.txt` (37 KB, and directly on-topic for this vault's own method); `raw/articles/ancapjustice.txt` (12 KB); plus 5 opaque-ID files (`ShusuVq32hc`, `BCh-OXkY-5o`, `part1/2/3`, `transcript-vwtri2rITro`) that may be duplicates already processed under other names.
- ~~**15 one-directional cross-links** from the three newest pages.~~ **Not a defect — measured, then decided (2026-08-26).** Vault-wide, **1106 of 1498 `**Links:**` edges are one-directional (74%)**; counting every inline body link, 2104 of 3250 (65%). At that rate strict bidirectionality is not a rule anyone follows, and hand-reciprocating it is precisely what [author-web-derive-hierarchy](../method/author-web-derive-hierarchy.md) forbids: *"every reciprocal link, ledger entry, and INDEX/tag update is a deterministic function of forward-links + frontmatter. That's index maintenance — the engine's job, not the author's."*
  **The distinction that resolves it is the same one the tag fix turned on:** a `**Links:**` entry is an authored claim that *this page is in conversation with that one* — directional by intent, and 74% asymmetry is what a curated relation looks like, not rot. A **backlink** is the derived reverse view, and it should be generated. `tools/vault-backlinks.py` already generates it and is **deliberately held back**: a dry run touches 193 pages, it duplicates Obsidian's native backlinks pane, and it fights the keep-pages-lean rule. That call stands. What *is* enforced is the narrower, genuinely load-bearing case — **specimen↔thesis ledger reciprocity**, which `vault-graph.py` gates as `[HARD]` and currently reports **0 violations**.
- **12 stale time-sensitive pages** (>90 days, model/pricing claims): `claude-opus-4-6.md`, `claude-code-cloud-vm.md`, `level-6-direct-execution.md`, `llm-praxeology.md`, `llm-game-benchmark.md`, `context-cache-hierarchy.md` and others.
- **Bloat vs. the manual's 60–80-line hub rule**: `research/gaming/README.md` (144), `research/debates/README.md` (141), `master-of-magic/README.md` (147), `tools/README.md` (104). Non-hub >500 lines: `catan-47k-empirical` (736), `moo1/optimal-strategy` (715), `industrial-revolution-political-transformation` (686), `poverty-exploitation-prep` (618), `llm-agents-across-games` (616), + 3 debate pages.
- **1 stub**: `research/cognitive-vs-motor.md` — now load-bearing (cited by `llm-grounding-problem.md`).

## Clean

INDEX.md 407 relative links / 0 broken · canary placement PASS (each token = kernel table + its own layer file) · index-drift gate healthy (48 firings Jun 5 / Jul 25 / Aug 18, **zero pages still unindexed** — every nudge actioned, no `/vault-sync` sweep needed) · provenance clean on all 20 pages changed since 2026-08-23 · no open PRs across 14 repos.

## Scope

**Audited:** full structural pass (links vault-wide, stubs, tags, bloat, drift log, canary) + semantic pass on all 20 pages changed since 2026-08-23 + topic-verification of 20 raw clusters.
**Not audited:** cross-cluster contradiction detection (1.5b) and the rotating ~10-page older sample — no prior heartbeat report existed, so there was no baseline date to diff from. **This file supplies it for next time.**

## Open Questions

*(both resolved same-day, 2026-08-26 — kept here as the record of what was decided and why)*

- ~~Should `wilson-christians-right-to-rule.md` and `wilson-rights-dont-exist-only-force.md` carry the `game-theory` tag?~~ **No** (Chris): the tie is broad at best. Both pages reference the convention-as-equilibrium idea in passing, which is what an *inline cross-link* is for; a tag asserts the page is **about** that subject. Left untagged, and the inline links stand. This is the section rule working as intended — a tag is a claim of aboutness, not of mention.
- ~~Should `vault-ingest` write a `**Source:**` line naming the real `raw/` path?~~ **Yes, done** (Chris). Spec added to `.claude/shared/vault-page.md` → "The `**Source:**` line" so *every* page-creating skill inherits it, and made mandatory step 4 of `vault-ingest` — including when an ingest **enriches an existing page**, since a second source is the easy one to lose. Heartbeat 1.5c gains a **pass 0** exact lookup that runs before the fuzzy passes. Pages predating this have no line, so the heuristic still covers the backlog; the metric to watch is the *share resolvable by pass 0 climbing over time* — if it stalls, the ingest step is being skipped, which is a more useful finding than any single uncovered file.

## Tags

[methodology](../tags/methodology.md) · [workflow](../tags/workflow.md) · [tools](../tags/tools.md)

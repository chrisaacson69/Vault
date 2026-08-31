---
name: vault-heartbeat
description: Proactive health check — structural scan (broken links, stale stubs, tag mismatches, missing cross-links) PLUS a semantic/grounding audit (unsourced claims, contradictions, raw coverage, gaps/new-article candidates); check GitHub repos for open PRs, failing checks, and review requests. Use when the user says "heartbeat", "health check", "vault check", "what needs attention", or on a scheduled trigger.
user-invocable: true
allowed-tools: Read, Edit, Glob, Grep, Bash
---

## Vault Heartbeat Procedure

The vault lives at `C:\Users\Chris.Isaacson\Vault`. GitHub repos live under `C:\Users\Chris.Isaacson\source\repos\`.

Run both checks below and produce a single concise report.

### STOP — read `tools/README.md` before writing a single check

**Most of this audit is already built.** `tools/` holds the deterministic checkers, they are indexed in
[`tools/README.md`](../../../tools/README.md), and they implement
[method/author-web-derive-hierarchy.md](../../../method/author-web-derive-hierarchy.md): *the index is
derived by tooling, never hand-maintained.* Run them **first**, and treat their output as ground truth:

```bash
py -3 tools/vault-graph.py         # 1a + 1d: broken links, ledger reciprocity, orphans. The gate.
py -3 tools/vault-fix-links.py     # repair broken links by unique-basename match (--write to apply)
py -3 tools/vault-tagindex.py      # 1c: derive tags/<tag>.md from each page's `## Tags` (--write)
py -3 tools/tag-counts.py          # 1c: recompute `- N files` in tags/_index.md (--write)
py -3 tools/vault-backlinks.py     # materialize derived Backlinks sections (--write)
```

Order matters: pages → `vault-tagindex.py` → `tag-counts.py`. Each layer derives from the one below.

Only two checks are genuinely missing from `tools/`, and they live here:

```bash
py -3 .claude/skills/vault-heartbeat/scripts/heartbeat-checks.py [raw|ghosts|all]   # read-only
```

**This routing block exists because it failed.** On 2026-08-26 a heartbeat hand-rolled its own
broken-link, tag-count and tag-index checkers — all five tools already existed, `tools/README.md`
already indexed them, and `vault-sync` already routed to `tag-counts.py`; this skill mentioned `tools/`
zero times, so the run never looked. The rebuilds were *worse* (bare back-links where
`vault-tagindex.py` preserves curated one-liners) and disagreed with the real tools on live drift.
That is the #1 rule — reuse/convert > rebuild — failing for the exact reason the vault manual predicts:
**a capability nothing routes to is unfindable, and unfindable capability gets rebuilt.**

`grep -P` is unavailable in this Git Bash locale; use `py -3`, per the kernel's silent-tool-failure rule.
The remaining checks (1b, 1e, 1f, 1g, 1.5a/b/d/e) are still done by hand.

### 1. Vault Health Check

#### 1a. Broken Links
- Read `Vault/INDEX.md` and extract all relative file paths.
- Verify each path resolves to an existing file.
- Report any broken links with the source line.

#### 1b. Stale Stubs
- Scan all `.md` files in `research/` and `notes/` for stub markers: `(stub)` in INDEX.md entries, or files under 500 bytes with no substantive content beyond frontmatter.
- List stubs with their age (file modification date).

#### 1c. Tag Integrity
Check **three** sets, not two — the declared count, the tag file's back-links, and **real usage**
(pages whose `## Tags` section links to `tags/<name>.md`). Two-way checking misses the common failure.
- Tag files on disk vs. entries in `tags/_index.md` — an unregistered tag file is *unfindable*, which is
  the append-without-integrate failure the vault `CLAUDE.md` names.
- Declared count vs. actual back-links in each tag file.
- Back-links vs. real usage, **in both directions**: a *ghost* (tag file lists a page that no longer
  carries the tag) and a *missing* (page carries the tag, tag file doesn't list it).

**When a ghost's file still exists, the tag file is usually right and the page lost its `## Tags` entry
— repair the page, don't evict the back-link.** Measured 2026-08-26: 39 pages / 55 pairs, and every one
belonged on the page (`research/nes/*` missing `nes`, KOEI pages missing `koei`). Evicting would have
destroyed a correct index. Only evict when the target file is genuinely gone or the tag is wrong.

Two known false positives — exclude both or they re-report forever:
- **tag→tag "related tag" links** (e.g. `constitutional-law` → `libertarian-law`) are legitimate, not
  page back-links. Drop any link resolving inside `tags/`.
- **documentation examples**, not real tags: `CLAUDE.md`, `projects/_template.md`, and
  `notes/obsidian-plugin-setup.md` all spell out `[tag](../tags/x.md)` to *describe* the convention.

#### 1d. Missing Cross-Links
- Sample up to 10 recently modified research pages.
- For each, check if pages it references via markdown links also link back.
- Report one-directional links that should be bidirectional.

#### 1e. Bloated Pages
- Find all `.md` files over 100 lines that are overview/hub pages (contain a "Sub-Topics" or "Sub-Pages" section, or are named README.md with sub-directories).
- These are candidates for splitting — the content should be in sub-pages, not the overview.
- Also flag any non-overview page over 500 lines as potentially too large.
- Report with line count and suggested action (split into sub-pages).

#### 1f. Index-Drift Frequency (frequency-as-signal)
- Read `logs/index-drift.log` (written by the Stop-hook soft gate each time a new page was left out of INDEX.md). Count entries since the last heartbeat.
- A **few** firings = normal (you indexed them after the nudge). **Many** firings = drift is accumulating faster than it's integrated → recommend a dedicated `/vault-sync` cleanup pass. Report the count and the recommendation.
- The rate is the health metric here, not any single entry.

#### 1g. Config-Load Canary Integrity (detects the silent-load failure)
The kernel `~/.claude/CLAUDE.md` defines four canary tokens, one per config layer. This check does **not**
test whether they loaded this session (that's the in-session check, done from the kernel) — it asserts the
**placement invariant** that makes the in-session check trustworthy.

Read the four token literals out of the kernel's table, then grep for **each full literal** (not the
`-LOADED` substring — prose legitimately says `*-LOADED`) across `~/.claude/` including the memory dir,
the vault root, `Vault/projects/`, and `Vault/.claude/`.

**Exclude Claude Code's own generated state — it is not authored config and is never injected as rules:**
`~/.claude/projects/**/*.jsonl` (session transcripts, which necessarily quote the tokens because the
config was loaded into them) and `~/.claude/file-history/**` (pre-edit backups of the very layer files
being checked). Both match every token on every run; counting them turns a real invariant into noise
that trains the reader to ignore a genuine FAIL. Add `--exclude-dir=file-history --exclude-dir=projects`
or filter the hit list to authored files only.

**Each token must resolve to exactly two files:** the kernel `~/.claude/CLAUDE.md` (which carries the table
and is the checker) and its own layer file — `Vault/CLAUDE.md`, `memory/MEMORY.md`, or
`Vault/projects/CLAUDE.md` respectively.

- **A hit in any other file = FAIL.** This is the important direction. Memory topic files, area indexes,
  hooks, skills, and `settings*.json` all get injected into context — one that spells a token out makes the
  in-session check pass unconditionally, which is worse than having no canary. Describe tokens as
  `*-LOADED` in prose; never reproduce a literal outside its own layer file.
- **A layer file missing its token = FAIL** the other way: the canary now reads as a load failure every
  session and will be learned as noise. Restore it from the kernel table.

Report per-file hits and PASS/FAIL. Cheap — run it every heartbeat. (This check earned its keep on the day
it was written: it caught five files per token in its own first implementation.)

### 1.5 Semantic / Grounding Audit (credit-heavy — the self-improving layer)

This is the analytical pass that keeps the feedback loop compounding **signal, not error** — without it, a slightly-wrong page gets cited by the next page and the mistake propagates (drift). It reads page *bodies*, not just structure, so it's expensive. **Scope it incrementally:**
- Audit every page added/modified since the last heartbeat — derive the set from `git -C C:/Users/Chris.Isaacson/Vault log --since="<last run date>" --name-only --pretty=format: -- '*.md'` (last-run date = the date of the most recent heartbeat report in `logs/`; if none, audit a sample).
- Plus a **rotating sample of ~10 older pages** so the whole vault gets covered over time.
- **State what was and wasn't scoped** in the report — no silent truncation.

For the scoped pages:

#### 1.5a Source Provenance (the anti-fabrication catch)
- Flag substantive factual/empirical claims with **no traceable source** — no `**Source:**`/`**Links:**` to `raw/` or an external citation, no inline attribution.
- This is the after-the-fact enforcement of the CLAUDE.md Grounding Discipline: a claim nothing backs is a candidate fabrication. Report `page — claim`.

#### 1.5b Contradictions (drift detection)
- Within each topic cluster (shared tag / linked neighborhood), flag pages asserting conflicting facts or conclusions.
- A KB disagreeing with itself is drift. Reconcile toward the better-grounded artifact (diff toward the lower oracle where one exists — see `research/repairing-llm-code.md`).

#### 1.5c Raw Coverage (derived — no registry)

**Filename matching alone does NOT work — it is ~70% false-positive.** Measured 2026-08-26: a naive
filename grep flagged 75 of 194 source groups as uncovered; spot-checking four clusters (the
`peikoff-hop-*` lectures, the `mcfadden-*` battlezone/stellar7 listings, all 8 `wordwar-results-*`
transcripts, the hangman substack capture) found **all four fully processed**. Pages legitimately cite
a source by its **URL**, or under a **page name that shares no token with the filename** — so a
filename miss is not evidence of a gap. Run all three passes and only report what survives all three:

1. **Collapse sibling formats first.** `foo.en.vtt`, `foo.en-orig.srv1`, `foo.info.json`, `foo_clean.txt`
   and `foo-raw.txt` are one source, not five. Strip the `(.en|-orig|_clean|-clean|_raw|-raw|.info)`
   suffix chain plus the media extension, and group by `(directory, stem)`. A group is covered if
   **any** member is cited.
2. **Then match by URL.** Grep the raw file's `source:` URL / YouTube ID across all pages. Captures
   whose page cites the link rather than the local path are covered.
3. **Then match by topic.** For each still-unmatched group, grep 2–3 distinctive content keywords
   (author surname, debate participants, subject term) across `research/ notes/ career/ method/`.
   A topic hit means processed-under-another-name — covered.

Report only groups surviving all three, and **say which passes were run** — an unqualified "N uncovered"
from pass 1 alone is a fabricated finding, exactly the failure the Grounding Discipline forbids.

**Pass 0 — the exact lookup, try this first.** As of 2026-08-26 `vault-ingest` step 4 stamps a
`**Source:**` line naming the real `raw/` path into every page it creates or enriches (spec in
`.claude/shared/vault-page.md`). So: grep all `**Source:**` / `## Sources` blocks for the raw path
first, and treat a hit as definitive coverage. Only groups that pass 0 misses go on to passes 1–3.

Pages predating that change have no `**Source:**` line, so the fuzzy passes remain necessary for the
backlog — but the **share of raw sources resolvable by pass 0 should climb over time**. If it isn't
climbing, the ingest step is being skipped: report that, because it is the more useful finding than
any individual uncovered file.

#### 1.5d Gap Analysis / New-Article Candidates (completeness critic)
- Per major tag/cluster, name what's conspicuously missing and propose new-article candidates.
- This is where most of the value is: the KB telling you what it doesn't yet know.

#### 1.5e Content Staleness
- Flag pages whose substantive claims are time-sensitive (capability/pricing/"latest model" refs) AND older than ~90 days, for a freshness pass. Evergreen pages (philosophy, math) are exempt.

### 2. GitHub Activity Check

Run these `gh` commands for each repo the user cares about (default: all repos under `source/repos/` that are git repositories):

#### 2a. Open PRs Needing Attention
```bash
gh pr list --repo OWNER/REPO --state open --json number,title,updatedAt,reviewDecision,checks
```
- Flag PRs with failing checks.
- Flag PRs awaiting review for more than 24 hours.
- Flag PRs with requested changes not yet addressed.

#### 2b. Recent Activity
```bash
gh pr list --repo OWNER/REPO --state merged --json number,title,mergedAt --limit 5
```
- List recently merged PRs (last 7 days) as an FYI.

### 3. Report Format

Output a concise report grouped by urgency:

```
## Needs Attention
- [items requiring action — broken links, failing PRs, tag mismatches, unsourced claims, contradictions]

## Grounding & Drift
- [provenance gaps, contradictions to reconcile, uncovered raw files, stale time-sensitive claims]

## Gaps & Candidates
- [new-article candidates, conspicuous holes per cluster]

## Worth a Look
- [stubs, stale stubs, missing cross-links, PRs awaiting review]

## All Clear
- [areas with no issues — just a brief confirmation]

## Scope this run
- [what was audited (changed-since-last + sample) and what was NOT — no silent truncation]
```

Keep it short. No item needs more than one line. If everything is clean, say so.

### 4. Two-phase behavior (interactive vs. scheduled)

**Interactive run** (user said "heartbeat"/"health check"): after the report, use `AskUserQuestion` to ask which findings to action *this session* — fix provenance gaps, reconcile contradictions, ingest uncovered raw files, draft candidate articles. Then do the chosen actions.

**Scheduled / unattended run** (invoked as `/vault-heartbeat scheduled`, e.g. by the monthly Task Scheduler job, or any headless `-p` run): **report only — do NOT edit the wiki.** Write the report to `logs/heartbeat-YYYY-MM-DD.md` and stop. The human reviews and actions later. This is the safety rule that keeps the self-improving loop from writing its own mistakes back unsupervised: the audit runs automatically, but the *write-back stays human-gated*.

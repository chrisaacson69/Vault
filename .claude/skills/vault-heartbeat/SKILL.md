---
name: vault-heartbeat
description: Proactive health check — structural scan (broken links, stale stubs, tag mismatches, missing cross-links) PLUS a semantic/grounding audit (unsourced claims, contradictions, raw coverage, gaps/new-article candidates); check GitHub repos for open PRs, failing checks, and review requests. Use when the user says "heartbeat", "health check", "vault check", "what needs attention", or on a scheduled trigger.
user-invocable: true
allowed-tools: Read, Edit, Glob, Grep, Bash
---

## Vault Heartbeat Procedure

The vault lives at `C:\Users\Chris.Isaacson\Vault`. GitHub repos live under `C:\Users\Chris.Isaacson\source\repos\`.

Run both checks below and produce a single concise report.

### 1. Vault Health Check

#### 1a. Broken Links
- Read `Vault/INDEX.md` and extract all relative file paths.
- Verify each path resolves to an existing file.
- Report any broken links with the source line.

#### 1b. Stale Stubs
- Scan all `.md` files in `research/` and `notes/` for stub markers: `(stub)` in INDEX.md entries, or files under 500 bytes with no substantive content beyond frontmatter.
- List stubs with their age (file modification date).

#### 1c. Tag Integrity
- For each tag file in `Vault/tags/`, count the actual back-link entries.
- Compare against the count listed in `Vault/tags/_index.md`.
- Report any mismatches.

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
- For each file in `raw/`, check whether its source is cited anywhere in the wiki: grep its frontmatter `source:` URL (or title slug) across all `.md` pages.
- Flag raw inputs never referenced — captured but never processed.

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

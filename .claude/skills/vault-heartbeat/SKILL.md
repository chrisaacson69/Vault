---
name: vault-heartbeat
description: Proactive health check — scan the vault for broken links, stale stubs, tag mismatches, and missing cross-links; check GitHub repos for open PRs, failing checks, and review requests. Use when the user says "heartbeat", "health check", "vault check", "what needs attention", or on a scheduled trigger.
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
- [items requiring action — broken links, failing PRs, tag mismatches]

## Worth a Look
- [stubs, stale items, missing cross-links, PRs awaiting review]

## All Clear
- [areas with no issues — just a brief confirmation]
```

Keep it short. No item needs more than one line. If everything is clean, say so.

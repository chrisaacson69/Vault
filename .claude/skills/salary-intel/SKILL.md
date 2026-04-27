---
name: salary-intel
description: Research salary data for a specific role and location — aggregates multiple sources into a cross-referenced compensation analysis. Use when the user says "salary for", "what does X pay", "comp analysis", or "salary-intel".
user-invocable: true
allowed-tools: Read, Write, Edit, Grep, Glob, Bash, Agent, WebFetch, WebSearch
---

## Salary Intelligence Agent

Base directory: `C:\Users\Chris.Isaacson\Vault`

**Shared procedures:** Follow [web-research.md](../../shared/web-research.md) for all search and synthesis operations. Follow [vault-page.md](../../shared/vault-page.md) for page creation conventions.

### 1. Parse Input

Extract from the user's request:
- **Role title** (e.g., "Director of AI Engineering", "Senior AI Engineer")
- **Location** (e.g., "Denver", "Remote US", "San Francisco")
- **Experience level** if mentioned

If not specified, check `career/active-postings.md` and `career/role-landscape.md` for current target roles.

### 2. Search Multiple Sources

Using web-research.md search methodology, target these salary-specific sources:

| Source | What It Provides | Reliability |
|---|---|---|
| Levels.fyi | Verified total comp at tech companies | High for big tech, sparse elsewhere |
| Glassdoor | Base + total comp ranges, company-specific | Tends to inflate, especially bonuses |
| Salary.com | Percentile breakdowns (10th-90th) | Conservative, often base-only |
| ZipRecruiter | Average + range | Broad but noisy |
| BLS / OES | Government data, metro-level | Authoritative but lags 12-18 months |
| Posted job ranges | Legally required in many states | Most reliable current data |

Also search for AI-specific salary premiums (25-45% over general SWE).

### 3. Cross-Reference Vault

Read these for existing data:
- `career/role-landscape.md` — baseline salary tables
- `career/active-postings.md` — specific posted ranges

### 4. Write Report

Save to `career/salary-report-<role-slug>.md` following vault-page.md conventions.

Include these sections:
- **Summary table** — base range, total comp range, median, AI premium estimate, source count
- **By percentile** — 10th/25th/50th/75th/90th with source attribution
- **By company tier** — FAANG, mid-tier, enterprise, startup
- **Regional adjustment** — location vs national average
- **Source reliability notes** — which sources agreed/diverged, known biases
- **Negotiation context** — market conditions, demand signals

Tag with `[career](../tags/career.md)`.

### 5. Caveats

Always note: total comp can be 1.5-2x base at tech companies; data decays fast (date each source); AI skills carry premiums most tools don't break out.

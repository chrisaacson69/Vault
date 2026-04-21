# Web Research — Shared Procedures

Reusable procedures for any skill that needs to search the web, fetch content, and synthesize findings. Referenced by multiple skills to ensure consistent behavior.

## Search Methodology

### Multi-Source Search

Never rely on a single source. For any research question:

1. **Run at least 3 search queries** with different phrasings
2. **Target specific sites** where relevant: `site:levels.fyi`, `site:glassdoor.com`, `site:github.com`
3. **Cross-reference findings** — if two sources agree, note the consensus. If they disagree, note the divergence and which is more reliable.
4. **Prefer primary sources** — job postings over salary aggregators, engineering blogs over press releases, official docs over tutorials

### Search Patterns by Purpose

| Purpose | Query Pattern | Priority Sources |
|---|---|---|
| Salary data | `"<role>" salary "<location>" <year>` | Levels.fyi, Glassdoor, Salary.com, BLS, posted ranges |
| Company research | `"<company>" AI engineering blog`, `"<company>" tech stack` | Engineering blogs, GitHub orgs, job postings, press |
| Job postings | `"<role>" "<location>" remote`, `site:linkedin.com "<role>"` | LinkedIn, Indeed, Glassdoor, company careers pages |
| Industry trends | `"<topic>" <year> survey report` | Pragmatic Engineer, Gartner, industry surveys |
| Technical tools | `"<tool>" tutorial documentation getting started` | Official docs, GitHub READMEs, Stack Overflow |

### Using WebSearch and WebFetch

- **WebSearch** for discovery — finding URLs and summaries
- **WebFetch** for depth — reading full page content from a known URL
- **Agent with WebSearch** for parallel queries — when you need 3+ searches simultaneously, launch agents to run them concurrently

### Handling Failures

- **Bot-blocked / 403:** Note the failure, try an alternative source, tell the user if critical content is inaccessible
- **Paywall:** Note what's visible, suggest the user access directly if the content is critical
- **Stale data:** Always check the date of sources. Salary data older than 12 months is suspect. Job postings older than 30 days may be filled.
- **Never fabricate:** If you can't find data, say so. Don't extrapolate from insufficient evidence.

## Content Extraction

When fetching a page with WebFetch:

1. **Extract the useful content** — strip navigation, ads, footers, sidebars
2. **Preserve structure** — keep headings, lists, tables, code blocks
3. **Note the source** — always record the URL and access date
4. **Quote directly** when the exact wording matters (job posting requirements, salary ranges, company statements)
5. **Summarize** when the volume is high and the specific wording doesn't matter

## Synthesis

When combining findings from multiple sources:

1. **Lead with the consensus** — what do most sources agree on?
2. **Note outliers** — which source says something different, and why?
3. **Assess reliability** — Glassdoor inflates salaries. LinkedIn job counts include duplicates. Press releases are marketing. Weight accordingly.
4. **Date everything** — note when each source was published or last updated
5. **Cite sources** — include URLs so the user can verify

# Web Fetch — Handler

Mid-level handler for fetching and extracting content from websites. Called by content-extract.md dispatcher for article URLs, and by web-research.md for deep-reading specific pages.

**Current specific tool:** `WebFetch` (Claude Code built-in)
**Future specific tool:** Playwright (browser automation — for dynamic sites, login-required content, job boards)

## Basic Fetch

Use WebFetch to retrieve a URL as markdown:
- Extracts main content automatically
- Strips navigation, ads, footers, sidebars
- Preserves headings, lists, tables, code blocks

## Content Cleaning

After fetching:
1. **Remove boilerplate** — cookie notices, subscription prompts, share buttons
2. **Preserve structure** — keep semantic HTML structure (headings, lists, tables)
3. **Note metadata** — extract title, author, publication date where visible
4. **Quote selectively** — preserve exact wording for facts and figures; summarize for context

## Failure Handling

| Failure | Cause | Action |
|---|---|---|
| 403 / bot-blocked | Site rejects automated requests | Tell user to use Web Clipper (`Alt+Shift+O`) to clip manually to `raw/` |
| Paywall | Content behind subscription | Note what's visible; suggest user access directly |
| Dynamic content | JavaScript-rendered page | Future: Playwright handler. Current: Web Clipper fallback |
| Empty/minimal content | SPA or heavy JS framework | Same as dynamic content |
| Timeout | Slow server or large page | Retry once, then fallback |

**Critical rule:** Never fabricate content from a failed fetch. If you can't access the page, say so.

## Raw File Output

When saving fetched content to `raw/`:

```yaml
---
source: <URL>
author: <extracted if available>
title: <page title>
clipped: <today YYYY-MM-DD>
type: article
---

<extracted content>
```

## Future: Playwright Handler

When Playwright support is added, it will handle:
- **Job board scraping** — Indeed, LinkedIn, Glassdoor (dynamic rendering)
- **Login-required content** — sites needing authentication
- **Interactive pages** — content loaded via JavaScript
- **Screenshot capture** — visual snapshots for reference

The dispatcher (content-extract.md) routes to Playwright when WebFetch fails on known dynamic sites, or when the skill specifically requests browser automation. WebFetch remains the default for its speed and simplicity.

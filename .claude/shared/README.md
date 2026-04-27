# Shared Skill Library

Reusable instruction modules referenced by multiple skills. Organized in layers — dispatchers route to handlers, handlers use specific tools.

## Architecture

```
Skills (user-facing)
  vault-ingest, debate-review, salary-intel, company-research, career-slides, ...
    │
    ▼
Dispatchers (shared/ — high-level routing)
  content-extract.md  → "what kind of source is this?" → route to handler
  web-research.md     → "how to search, evaluate, synthesize" → methodology
  vault-page.md       → "how to create/update vault pages" → conventions
    │
    ├──────────────────────────────────┐
    ▼                                  ▼
Handlers (shared/ — mid-level)    MCP Servers (when tools earn it)
  web-fetch.md                      future: vault-tools, job-scraper
  video-extract.md                  see: mcp-servers.md for decision framework
    │                                  │
    ▼                                  ▼
Specific Tools (system-level)     External APIs
  yt-dlp, WebFetch, WebSearch       job boards, salary APIs, etc.
  ffmpeg, Marp CLI, Rhubarb
```

## Decision Frameworks

- [mcp-servers.md](./mcp-servers.md) — when to build an MCP server vs. Bash vs. shared instructions
- [connectors.md](./connectors.md) — external communication channels (WhatsApp, email, Slack, GitHub)

## Design Principles

1. **Dispatchers stay stable** — new capabilities are added at the handler/tool level
2. **Handlers are swappable** — replacing WebFetch with Playwright for a specific site doesn't change the dispatcher
3. **Specific tools prove themselves** — yt-dlp earned its place by working reliably across vault-ingest and debate-review. New tools earn their place the same way.
4. **Fix once, benefit everywhere** — improving web-fetch.md helps every skill that fetches web content
5. **Graduate, don't prematurely promote** — MCP servers are overhead. Only build one when the lower layers create real friction.

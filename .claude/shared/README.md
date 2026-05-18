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
6. **Code over tokens** — if logic is deterministic and would otherwise be regenerated per session, save it as a script in [`scripts/`](./scripts/) and point at it from the relevant shared doc. Tokens are stochastic; code is deterministic. Established 2026-05-17 with `clean-srt.js` and `yt-meta.js` replacing per-ingest regenerated Node code.

## Invocation flag discipline (for new skills)

Every SKILL.md frontmatter can carry two flags that govern who can invoke the skill: the user (via `/`-menu), the model (auto-invocation based on the description), or both. Default behavior is "both" (`user-invocable: true`, no `disable-model-invocation` flag set). The table below is the forward-looking rule for any new skill — existing skills are correct as-is for their action class.

| Action class | `user-invocable` | `disable-model-invocation` | Example |
|---|---|---|---|
| **Read-only / synthesis** | `true` | `false` (default) | context-brief, debate-review, salary-intel, company-research |
| **Vault-local write** | `true` | `false` (default) | vault-ingest, vault-sync, vault-heartbeat, career-slides |
| **External effect** (push, send, deploy) | `true` | **`true`** | future: a `/publish-skills-repo` skill that pushes to GitHub |
| **Internal sub-skill** (dispatcher-only) | **`false`** | `false` | future: agent-only helpers a top-level skill orchestrates |

**Rule of thumb:** if the wrong invocation by the model would have effects outside the local working directory and would be hard to reverse, set `disable-model-invocation: true` so only the human can trigger it. The default-on behavior is fine for vault-local work; cross system-boundary work earns the gate.

# MCP Servers — When and How to Build Them

Decision framework for when to create an MCP (Model Context Protocol) server vs. using existing tools. MCP servers extend Claude Code with custom callable tools that work like native tools — no Bash wrapping, structured inputs/outputs, discoverable via the tool system.

## The Tool Hierarchy

```
MCP Server Tools          ← Claude calls directly, structured I/O, stateful
  ↑ build when...
Shared Library (.claude/shared/)  ← Claude reads instructions, follows procedures  
  ↑ formalize when...
Bash one-liners           ← Claude shells out, text I/O, stateless
  ↑ start here
```

**Start at the bottom. Move up when the lower layer creates friction.**

## When to Build an MCP Server

Build an MCP server when a capability meets **2+ of these criteria**:

| Criterion | Why It Matters |
|---|---|
| **Called frequently across skills** | Bash invocation overhead adds up; a native tool is faster to call and reason about |
| **Needs structured input/output** | Bash returns text that Claude must parse; MCP tools return typed data |
| **Maintains state across calls** | Bash is stateless; MCP servers can hold connections, caches, sessions |
| **Wraps a complex API** | Better to expose a clean tool interface than have Claude construct curl/API calls |
| **Error handling matters** | MCP tools can return structured errors Claude can reason about; Bash returns exit codes |
| **Would benefit other projects** | MCP servers are portable across repos; shared instructions are vault-specific |

## When NOT to Build an MCP Server

Stay with Bash or shared instructions when:

- **One-off or rare usage** — the overhead of building a server isn't justified
- **Simple CLI tool** — `yt-dlp`, `ffmpeg`, `marp` work fine via Bash; wrapping them adds indirection without benefit
- **The tool already exists** — WebFetch, WebSearch, Read, Grep are built-in and excellent
- **Instructions are sufficient** — if Claude can follow a procedure reliably from a shared .md file, that's simpler

## MCP Server Candidates for This Vault

Based on current usage patterns, these are candidates that could earn MCP server status:

### Near-term (proven need)

| Candidate | Current Method | Why MCP Would Help |
|---|---|---|
| **Job board scraper** | WebSearch (not built yet) | Structured job posting data (title, company, salary, location, URL) instead of raw search results. Could maintain a cache of seen postings to avoid duplicates. |
| **Salary aggregator** | WebSearch + manual synthesis | Return structured salary data (percentiles, by region) from multiple sources in a single call. Cache results across sessions. |
| **Vault query** | Grep + Read + INDEX.md | A tool that takes a topic and returns relevant vault pages with summaries. Faster than Claude searching manually each time. |

### Future (as patterns emerge)

| Candidate | Trigger to Build |
|---|---|
| **Playwright browser automation** | When WebFetch failures become frequent enough that browser automation is needed regularly |
| **GitHub project tracker** | When monitoring multiple repos/PRs/issues becomes a daily task |
| **Calendar/scheduling** | When interview scheduling automation is needed |
| **Resume generator** | When the vault-to-resume pipeline is used frequently enough to warrant a tool |

## How to Build an MCP Server

### Architecture

```
my-mcp-server/
  package.json          ← or pyproject.toml for Python
  src/
    index.ts            ← server entry point
    tools/
      search-jobs.ts    ← individual tool implementations
      get-salary.ts
  README.md
```

### Registration

Add to Claude Code settings (`.claude/settings.json` or user settings):

```json
{
  "mcpServers": {
    "vault-tools": {
      "command": "node",
      "args": ["path/to/server/dist/index.js"],
      "env": {}
    }
  }
}
```

### Key Design Principles

1. **One server, multiple tools** — group related tools in a single server (e.g., all job-search tools in one server)
2. **Structured inputs and outputs** — define clear JSON schemas for parameters and return values
3. **Idempotent where possible** — calling the same tool twice with the same input should be safe
4. **Cache intelligently** — salary data doesn't change hourly; job postings do. Cache accordingly.
5. **Fail gracefully** — return structured errors Claude can reason about, not stack traces
6. **Document the tools** — good descriptions help Claude choose the right tool without being told

### The Graduation Path

```
1. Start with Bash: yt-dlp --skip-download --print title "URL"
2. Formalize in shared/: video-extract.md documents the full procedure
3. If called constantly with parsing overhead: build MCP server with get_video_metadata tool
```

Not everything graduates. yt-dlp works great via Bash — the shared instructions handle the complexity. But if we're calling a job board API 50 times a session and parsing JSON each time, that's when an MCP server earns its place.

## Relationship to Shared Library

MCP servers and shared instructions are complementary, not competing:

- **Shared instructions** = methodology, decision trees, conventions (how to think)
- **MCP tools** = callable capabilities with structured I/O (how to act)

A skill might reference `web-research.md` for search methodology AND call an MCP tool for structured salary data. The instruction tells Claude what to search for; the tool does the actual fetching and parsing.

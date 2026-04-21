---
status: active
created: 2026-04-09
---
# iPad + Claude + Vault Setup
> Getting the vault accessible from iPad. May delete this once everything is configured.

**Links:** [Working With Claude](./working-with-claude.md)

## Current iPad Apps
- **Obsidian** — vault viewer/editor, synced via GitSync
- **GitSync** — syncs vault repo to `On My iPad > Obsidian`
- **Claude app** (native, not Safari) — may have more functionality than web
- **Files app** — can see both Obsidian and Claude folders

## Option 1: Remote Control (best — full CLI from iPad)

This is the desktop CLI experience on the tablet. Claude runs locally on the Windows PC; the iPad app is a window into it. Full CLAUDE.md, vault filesystem, skills, MCP servers.

### Setup on Windows
```bash
# From the vault directory
cd C:\Users\Chris.Isaacson\vault
claude --remote-control "Vault Session"
```
- Press spacebar to show QR code
- Or copy the session URL

### Connect from iPad
- Open Claude app → Code tab → find the session by name (green dot = online)
- Or scan the QR code from the Claude app
- Or open the session URL in Safari

### Requirements
- Claude Code v2.1.51+ (`claude --version` to check)
- Logged in via `/login` (not API key)
- Pro/Max/Team/Enterprise plan
- PC must stay awake (~10 min network timeout kills session)

### Potential blocker
Machine policies may block this. Test and see. If corporate firewall blocks the websocket connection, this won't work.

### Solving the "PC sleeps" problem
Run Remote Control on a persistent cloud VM instead of your Windows PC. See [Claude Code on a Persistent Cloud VM](../research/claude-code-cloud-vm.md) for full setup — Hetzner CX22 at ~$4/month, tmux + OAuth login, always-on.

### Quick commands once connected
```
/remote-control "Vault Session"    # from existing session
/rc                                 # shorthand
/rename "New Name"                  # rename session
```

## Option 2: claude.ai/code (cloud — no PC needed)

Already partially working — this is what happened when you connected to the vault repo and it read CLAUDE.md.

### How it works
1. Open `claude.ai/code` in Safari or Claude app
2. Select the vault repo from GitHub
3. Claude clones repo into a fresh cloud VM (4 vCPU, 16GB RAM, 30GB disk)
4. Reads CLAUDE.md, .claude/skills/, .claude/settings.json — everything committed
5. Can read, write, commit, push to GitHub
6. Sessions persist — close browser, come back later

### Environments
Environments configure cloud sessions. The "default" was auto-created.

To create a Vault environment:
1. In claude.ai/code, click the environment name → "Add environment"
2. Name: "Vault"
3. Network access: "Trusted" (default — package registries + GitHub)
4. Setup script (runs at VM start):
```bash
#!/bin/bash
# Install vault tools
pip install yt-dlp 2>/dev/null
npm install -g @marp-team/marp-cli 2>/dev/null
```

### Limitations
- Fresh VM each session (packages don't persist without setup script)
- No local MCP servers
- No access to local filesystem (only the cloned repo)
- Can't use tools that require local machine access

## Option 3: Claude Projects (thinking/discussing)

For conversations with vault context where you don't need to edit files.

### Setup
1. Open claude.ai (web or app) → Projects → New Project
2. Name: "Vault"
3. Set project instructions — paste CLAUDE.md content
4. Upload key files to knowledge base:
   - INDEX.md (rename to .txt or paste directly)
   - Key research pages you're currently working on
5. Every chat in this project has vault context

### Limits
- 30 MB per file, unlimited files
- .md files: rename to .txt or paste content directly
- Free: 5 projects max. Pro/Max: unlimited.
- Must manually update when vault changes significantly

## Recommended Workflow

| Task | Use |
|---|---|
| Full vault work (edit, commit, push, skills) | Remote Control if PC is on, otherwise claude.ai/code |
| Quick questions about vault content | Claude app + attach files from Obsidian folder |
| Brainstorming, debate analysis, thinking | Claude Project "Vault" |
| Reading/browsing the vault | Obsidian on iPad (GitSync) |

## Tags

[ai](../tags/ai.md)

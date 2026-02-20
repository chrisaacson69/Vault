# Working With Claude — Setup, Tools, and Workflow
> Accumulated tips for working with Claude across devices and interfaces. Read this at the start of each session for context.

**Status:** active
**Created:** 2026-02-20
**Links:** [Vault Index](../INDEX.md), [Camelot From YouTube](../projects/camelot-from-youtube/README.md)

## Interfaces

Chris works with Claude through multiple interfaces. Each has different capabilities:

### Claude Chat (claude.ai / Claude App)
- **Best for:** Thinking, discussing ideas, drafting vault content, research conversations
- **Has:** Python, bash, ffmpeg, Java 21 runtime, file creation, web search
- **Does NOT have:** Network access from the Linux container (can't pip install, can't clone repos, can't download from URLs), persistent state between sessions (container resets every time)
- **File workflow:** Claude creates files → user downloads via **Artifacts** (which allow direct download to device) → uploads to GitHub or saves locally
- **Getting vault context:** Upload the vault as a zip (GitHub repo page → green "Code" button → "Download ZIP") at the start of a session. Claude should then read `CLAUDE.md` and `INDEX.md` first.

### Claude Code (in Claude App → "Code" tab)
- **Best for:** Execution — running code, installing packages, pushing to GitHub, anything that needs network access or persistence
- **Has:** Network access, GitHub integration, can clone/commit/push, can install packages (pip, npm), can run full project pipelines
- **Use for:** Vault updates (create files and push directly), running projects like Camelot (needs librosa, yt-dlp), any task that needs to touch external services
- **Prompt template for vault work:**
  ```
  Clone https://github.com/chrisaacson69/Vault.git and read CLAUDE.md and INDEX.md.
  [then describe what you need]
  ```

### Claude Code on PC (CLI)
- **Best for:** Heavy development, multi-file refactors, long coding sessions
- **Has:** Everything Claude Code on tablet has, plus full access to local filesystem, local tools, and local project state
- **The most capable interface** — use for major vault reorganizations, project development, anything requiring sustained multi-file work

## Device-Specific Notes

### iPad / Tablet
- GitHub's mobile web interface is limited for multi-file uploads — prefer Claude Code for pushing to the vault
- Artifacts in Claude Chat allow direct file download to the device — use this when Claude Code isn't appropriate
- DOSBox and Java JVM apps don't work well on iOS (JIT restrictions, touch control issues)
- Working Copy (paid iOS app) is an option for Git access but Claude Code may make it unnecessary
- Obsidian with Git plugin is a potential future option for a nicer editing/viewing experience on the vault — the vault's markdown structure is fully Obsidian-compatible with zero changes needed

## Tips and Tricks
- **Artifacts download:** In Claude Chat, files created as artifacts can be downloaded directly to the device. Use this for vault files when Claude Code isn't available.
- **Zip upload for context:** Fastest way to give Claude Chat full vault context is uploading the repo zip. GitHub → Code → Download ZIP → upload to chat.
- **Prompt for continuity:** When starting a new session, paste a summary of where the last session left off. The container has no memory between sessions.
- **Division of labor:** Use Chat for thinking and drafting, Code for executing and pushing. This mirrors the cyborg model — Chat is the creative/strategic side, Code is the execution side.

## Session History

### 2026-02-20 — Tablet Workflow Setup + Gaming Research
- Established the tablet workflow: Chat for drafting, Code for GitHub pushes
- Discovered Claude Code in the Claude App with GitHub integration
- Discovered Artifacts download trick for getting files to device
- Drafted `research/gaming/README.md` — gaming as interactive laboratories for systems thinking
- Drafted `research/gaming/multiplayer-coalition-problem.md` — coalition dynamics across Slay, Risk, and Monopoly; interest rate framework; phase decomposition; Stockfish architecture as template
- Updated INDEX.md, tag files (games, game-ai, economics, mathematics, simulation, _index)
- Discussed running Camelot on tablet — needs Claude Code for network access (librosa, yt-dlp)

## Tags
[ai](../tags/ai.md), [cyborg](../tags/cyborg.md)

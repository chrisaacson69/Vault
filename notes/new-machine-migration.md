---
status: active
created: 2026-05-01
---
# New Machine Migration

> Transition runbook: moving the vault + project ecosystem to the new Intel 725 (32 GB RAM, RTX 5060 16 GB VRAM, 2 TB SSD, Win 11). Captures what was pushed, what was deferred, and the bootstrap sequence for the new machine.

**Links:** [Working with Claude](./working-with-claude.md), [iPad Claude Setup](./ipad-claude-setup.md)

## What's Pushed (as of 2026-05-01)

All work below lives on GitHub under `chrisaacson69/`. Cloning the vault + these repos restores the full working state.

### Self-owned repos (clean, pushed)
- Vault — this repo
- animation-studio, animation-studio-pod
- batch-resize, order-playlist
- battletech-sim
- camelot_from_youtube — DJ track analyzer (mp3 + analysis caches gitignored)
- CyborgDJ — DJ-set assembler (output/, reverse-engineer/, rubberband-bin/, music files gitignored)
- masterofmagic
- monopoly
- monopyly (fork) — +1100-line markov_ai expansion (large *_results.json gitignored)
- moo1-opening-optimizer
- pytorch-audio-learning, pytorch-learning
- slay, slay-c
- triangular-arbitrage
- youtube-migration

### Third-party (re-clone fresh on new machine)
- pytorch — was wrangled to work past machine policy + Python 3.14, may need re-wrangling
- yt-dlp — only local diff was `.claude/` + `CLAUDE.md`, not worth a fork
- monopyly upstream is a fork already, push goes to chrisaacson69 fork

## Critical: The `.claude/` Folder

GitHub does NOT carry `~/.claude/`. This is the single most important migration artifact after the code:
- **memory/** — auto-memory across sessions (who Chris is, preferences, project context)
- **skills/** — custom slash commands (/career-slides, /vault-ingest, /vault-heartbeat, etc.)
- **settings.json** / **settings.local.json** — permissions, hooks, env vars
- **keybindings.json** — custom shortcuts

Without this, the new machine starts cold — no continuity, no skills, no remembered context.

**Chosen transfer method: encrypted 7z via Google Drive.**

On the old machine:
```powershell
# One-time install if needed
winget install --id 7zip.7zip --exact

# Run the backup script (prompts twice for password — write it down!)
powershell -File $HOME\bin\backup-claude.ps1
```

This produces `~/Downloads/claude-backup-<date>.7z` (~60–80 MB compressed, AES-256, filenames encrypted). Drag-drop into [drive.google.com](https://drive.google.com).

The script excludes `telemetry/`, `debug/`, `cache/`, `paste-cache/` — local-only noise.

**Other transfer options if Drive is blocked:**
- USB stick — guaranteed to work
- Home network copy — SMB share or `scp`
- Private GitHub gist with the encrypted .7z attached

**Verify after copy:** open Claude Code on the new machine, ask "what do you know about me?" — if it recalls the verification-layer thesis or the 6502 annotation series without prompting, memory transferred.

## Deferred — Decide Later

These were intentionally NOT migrated. Revisit when needed:

| Item | Status | Why deferred |
|------|--------|--------------|
| `~/source/repos/docs/repos/BattleTech` (2.5M, no git) | Local-only | Pre-AI unit-compare project, reference for battletech-sim |
| `~/source/repos/docs/repos/Drag` (no git) | Local-only | Ahl BASIC port, small |
| `~/source/repos/docs/repos/{Librosa,fetch_audio_features,music,plot_chroma,tunebat_scrape}` | Local-only | Exploratory starter projects for camelot_from_youtube |
| `~/source/repos/docs/repos/Monopoly-Bot-Richup.io` | Upstream + local mods | Has unfinished `richup-integration/`. Needs `gh repo fork` first |
| `~/source/repos/codebase` | No remote, 5 dirty | Unknown content, needs review |
| `~/car-finder`, `~/ansel`, `~/bin` | Local-only | No git anywhere |

**The old machine isn't going away soon**, so any of these can be pulled across the home network when needed.

## New Machine Bootstrap Sequence

### 1. Install core tools

Use `--exact` so winget doesn't fuzzy-match. IDs are case-sensitive:

```powershell
winget install --id Git.Git --exact
winget install --id GitHub.cli --exact
winget install --id Anthropic.ClaudeCode --exact   # the CLI, NOT Anthropic.Claude (that's the desktop chat app)
winget install --id Python.Python.3.13 --exact
winget install --id OpenJS.NodeJS --exact          # or OpenJS.NodeJS.LTS for the long-term-support build
winget install --id yt-dlp.yt-dlp --exact
```

Optional / project-specific:
- ffmpeg (camelot, cyborgdj): `winget install --id Gyan.FFmpeg --exact`
- CUDA toolkit (RTX 5060): download from NVIDIA, match PyTorch's CUDA version

**Finding more package IDs:** `winget search <keyword>` lists matches with their IDs, or browse [winget.run](https://winget.run) for a searchable web catalog.

### 2. GitHub auth

```powershell
gh auth login
# choose HTTPS, browser flow
```

### 3. Clone the vault FIRST

The vault contains all the project pointers and this runbook itself.

```powershell
mkdir $HOME\Vault -Force
cd $HOME
gh repo clone chrisaacson69/Vault Vault
```

### 4. Restore `~/.claude/`

Download `claude-backup-<date>.7z` from Google Drive to `~\Downloads\`, then extract:

```powershell
winget install --id 7zip.7zip --exact   # if not already installed
cd $HOME\Downloads
& 'C:\Program Files\7-Zip\7z.exe' x claude-backup-<date>.7z -o$HOME\
# enter the password when prompted
```

After extracting, **delete the Drive copy** — it contains your settings + tokens.

Verify:
```powershell
ls $HOME\.claude\projects
ls $HOME\.claude\projects\C--Users-*-Vault\memory
```
You should see `MEMORY.md` and a pile of `*.md` files.

### 5. Clone code repos

```powershell
mkdir $HOME\source\repos\docs\repos -Force
cd $HOME\source\repos\docs\repos
$repos = @(
  'animation-studio','animation-studio-pod','batch-resize','battletech-sim',
  'camelot_from_youtube','CyborgDJ','masterofmagic','monopoly','monopyly',
  'moo1-opening-optimizer','order-playlist','pytorch-audio-learning',
  'pytorch-learning','slay','slay-c','triangular-arbitrage','youtube-migration'
)
foreach ($r in $repos) { gh repo clone "chrisaacson69/$r" }

# Third-party
gh repo clone pytorch/pytorch
gh repo clone yt-dlp/yt-dlp
```

### 6. Per-project setup

Most Python projects have `requirements.txt` or `pyproject.toml`. Standard pattern:

```powershell
cd <project>
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

Notes:
- **camelot_from_youtube** — needs ffmpeg + librosa stack. Check `.env.example` and recreate `.env`.
- **CyborgDJ** — needs rubberband binary; download fresh, extract to `rubberband-bin/`.
- **animation-studio-pod** — Docker image for RunPod, no local install needed unless building.
- **pytorch** — may need wrangling for Python 3.14 + machine policy again. The new machine has fewer policies, so this might just work.

### 7. Smoke test

```powershell
# Vault works
cd $HOME\Vault
git pull

# Claude Code remembers you
claude
# ask: "what do you know about me?"

# A project runs
cd $HOME\source\repos\docs\repos\triangular-arbitrage
.\.venv\Scripts\Activate.ps1
python -m <entrypoint>
```

## Things to Do BEFORE Leaving the Old Machine

- [ ] Final `git status` sweep across all repos — anything dirty that's worth?
- [ ] Verify `.claude/` was actually copied (not just queued, actually arrived)
- [ ] Note the auth tokens that need re-issuing (gh, anthropic API key if separate, any cloud credentials)
- [ ] Check `~/source/repos/codebase` (the no-remote dirty repo) — decide: discard, push to private, or copy raw
- [ ] If `Monopoly-Bot-Richup.io/richup-integration/` matters: fork upstream, commit, push, then it joins the GitHub flow
- [ ] Decide on local-only folders (BattleTech, Drag, music explorations, car-finder, ansel, bin) — push to private repos OR copy raw OR abandon

## Recovery Notes

- If `gh repo clone` fails, fall back to `git clone https://github.com/chrisaacson69/<repo>.git`.
- If memory doesn't transfer, the vault itself contains a lot of the same context — Claude can rebuild memory by reading INDEX.md and recent files. Slower, but recoverable.
- If a project's deps don't install, check the matching vault stub at `projects/<name>/README.md` — many list specific tooling notes.

## Tags
[meta-musing](../tags/meta-musing.md)

---
status: active
created: 2026-04-09
---
# Claude Code on a Persistent Cloud VM
> Running Claude Code CLI on an always-on Linux VM so Remote Control works from iPad anytime.

**Links:** [iPad + Claude Setup](../notes/ipad-claude-setup.md), [Working With Claude](../notes/working-with-claude.md), [The Cyborg Model](./cyborg-model.md)

## The Problem

Remote Control requires a running `claude` process on a machine. The Windows PC sleeps, corporate firewalls may block websockets, and the ~10-minute network timeout kills the session. A persistent cloud VM solves all three.

## Architecture

```
iPad (Claude app / safari) 
  → claude.ai/code (Remote Control UI)
  → Anthropic API (TLS relay)
  → Cloud VM (tmux → claude remote-control)
  → vault repo (git clone)
```

All traffic is outbound HTTPS from the VM. No inbound ports needed.

## 1. Can Claude Code Run on Headless Linux?

**Yes.** Confirmed working on Debian 12 headless (no display server) via SSH + tmux ([GitHub issue #29479](https://github.com/anthropics/claude-code/issues/29479)). The setup:

- **OS:** Debian 12 or Ubuntu 22.04+
- **Install:** Native CLI installer (no Node.js required since the native binary):
  ```bash
  curl -fsSL https://claude.ai/install.sh | sh
  ```
  Installs to `~/.local/bin/claude`, auto-updates in background.
- **Minimum specs:** 1 vCPU, 2 GB RAM, 10 GB disk (the vault is small)
- **Session manager:** tmux or screen (required — keeps process alive after SSH disconnect)

## 2. Authentication — The Critical Constraint

**Remote Control requires OAuth login, not API keys.** This is the single most important constraint.

| Auth Method | Remote Control? | How to Set Up on Headless |
|---|---|---|
| `/login` (OAuth) | Yes | Run `claude`, it prints a URL; open that URL in a browser on any device; complete login; token flows back to CLI |
| `ANTHROPIC_API_KEY` | No | `export ANTHROPIC_API_KEY=sk-...` — works for headless Claude but NOT Remote Control |
| `claude setup-token` | No | Generates a 1-year OAuth token, but scoped to inference only — explicitly "cannot establish Remote Control sessions" |

**Workflow for headless auth:**
1. SSH into VM
2. Run `claude` — it prints a login URL (no browser opens)
3. Copy URL, paste into iPad/phone browser
4. Complete OAuth on claude.ai
5. Token persists in `~/.claude/.credentials.json` (mode 0600)
6. Only need to redo if you `/logout` or token expires

**Requires:** Pro, Max, Team, or Enterprise plan.

## 3. Running Remote Control in tmux

```bash
# SSH into VM
ssh user@vm-ip

# Start or attach tmux
tmux new -s vault || tmux attach -t vault

# Navigate to vault
cd ~/vault

# Start Remote Control (server mode — best for this use case)
claude remote-control --name "Vault" --spawn session

# Press spacebar to show QR code
# Or copy the session URL
```

The `--spawn session` flag limits to one session (simpler). Omit it for multi-session.

**Known limitation:** `claude remote-control` currently requires a TTY. Cannot run as a systemd service or via nohup. tmux/screen is the workaround. A `--headless` flag is requested ([GitHub issue #30447](https://github.com/anthropics/claude-code/issues/30447)) but not yet implemented.

### Keep-Alive Script

```bash
#!/bin/bash
# ~/start-vault-rc.sh
# Run inside tmux. Restarts Remote Control if it exits.
while true; do
  cd ~/vault && git pull --ff-only
  claude remote-control --name "Vault" --spawn session
  echo "Session exited at $(date). Restarting in 10s..."
  sleep 10
done
```

## 4. Git Sync

```bash
# Initial clone
git clone https://github.com/chrisaacson69/vault.git ~/vault

# Auth via SSH key (recommended) or GitHub CLI
ssh-keygen -t ed25519 -C "vault-vm"
# Add public key to GitHub → Settings → SSH Keys

# Or use gh CLI
gh auth login  # device code flow — works headless
```

For two-way sync (VM edits + local edits), just use git normally. The VM and local PC are both working copies of the same repo. Push from whichever you edit on; pull on the other.

## 5. Cheapest Always-On VM Options

| Provider | Plan | Specs | Monthly Cost | Notes |
|---|---|---|---|---|
| **Hetzner Cloud CX22** | Shared vCPU | 2 vCPU, 4 GB RAM, 40 GB SSD | ~$4.15 (€3.79) | Best value. EU + US regions. 20 TB traffic |
| **Vultr** | Cloud Compute | 1 vCPU, 1 GB RAM, 25 GB SSD | $2.50 | Cheapest entry point |
| **AWS Lightsail** | Nano | 1 vCPU, 512 MB RAM, 20 GB SSD | $3.50 | May be tight on RAM |
| **Linode (Akamai)** | Nanode | 1 vCPU, 1 GB RAM, 25 GB SSD | $5.00 | Solid reliability |
| **DigitalOcean** | Basic Droplet | 1 vCPU, 1 GB RAM, 25 GB SSD | $6.00 | Good docs, easy setup |
| **Fly.io** | Shared 256MB | shared vCPU, 256 MB RAM | ~$2/mo + $2 IPv4 | Too little RAM |
| **GitHub Codespaces** | 2-core | 2 vCPU, 8 GB RAM | **$129.60** if always-on | Terrible for 24/7 |

### Recommendation: Hetzner CX22 at ~$4/month

- 2 vCPU and 4 GB RAM is more than enough
- EU and US data centers
- Included IPv4 and 20 TB traffic
- Ubuntu or Debian image available at creation

Vultr at $2.50 works too but Hetzner gives 4x the RAM for $1.65 more.

## 6. Why NOT GitHub Codespaces

- **Cost:** $0.18/hr compute = $129.60/month always-on. Designed for dev sessions, not persistent servers.
- **Timeout:** Default 30-min idle timeout. Can be extended but compute still bills.
- **Overkill:** 8 GB RAM for running a CLI tool on a text repo.
- **Verdict:** Use Codespaces for claude.ai/code (cloud sessions). Use a VPS for Remote Control.

## 7. Docker Option

Anthropic publishes an official image: `ghcr.io/anthropics/claude-code:latest` (487 MB, multi-arch).

```bash
docker run -it \
  -v ~/vault:/workspace \
  -e ANTHROPIC_API_KEY=sk-... \
  ghcr.io/anthropics/claude-code:latest
```

However, for the Remote Control use case, Docker adds complexity without benefit:
- Still need OAuth (not API key) for Remote Control
- Still need tmux or equivalent for TTY
- A plain VM with `claude` installed directly is simpler
- Docker is better for isolated CI/CD or multi-project sandboxing

## 8. Complete Setup Checklist

1. **Create VM:** Hetzner CX22, Ubuntu 24.04, SSH key auth
2. **SSH in:** `ssh root@<ip>` → create non-root user
3. **Install Claude Code:**
   ```bash
   curl -fsSL https://claude.ai/install.sh | sh
   ```
4. **Install tmux:** `apt install tmux`
5. **Clone vault:**
   ```bash
   gh auth login  # or set up SSH key
   git clone git@github.com:chrisaacson69/vault.git ~/vault
   ```
6. **Authenticate Claude Code:**
   ```bash
   cd ~/vault
   claude
   # Copy the URL it prints → open on iPad → complete OAuth
   ```
7. **Start Remote Control:**
   ```bash
   tmux new -s vault
   cd ~/vault
   claude remote-control --name "Vault"
   # Ctrl-B D to detach
   ```
8. **Connect from iPad:** Open Claude app → Code tab → find "Vault" session (green dot)

Total recurring cost: ~$4/month (Hetzner) + existing Claude Max subscription.

## 9. Alternatives to Consider

- **Dispatch (via Claude Desktop):** Send tasks from phone to Desktop on your PC. Requires PC to be on. Same sleep problem.
- **claude.ai/code (cloud sessions):** No local machine needed. Fresh VM per session. Good for one-off tasks. No MCP, no local tools. Already documented in [iPad setup](../notes/ipad-claude-setup.md).
- **Channels (Telegram/Discord):** Push events to a running Claude session. Requires the session to be running somewhere — same need for a persistent VM.

## Open Questions

- Does the OAuth token survive VM reboots? (Should — stored in `~/.claude/.credentials.json`)
- How long before the OAuth refresh token expires? (No documented expiry for `/login` tokens beyond "re-auth if you `/logout`")
- Will the `--headless` flag ship? ([#30447](https://github.com/anthropics/claude-code/issues/30447) — open, 18 upvotes, marked stale)
- Can Tailscale replace SSH for VM access? (Yes, simpler than managing SSH keys)

## Tags

[ai](../tags/ai.md)

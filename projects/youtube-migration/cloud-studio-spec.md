# Cloud Studio — RunPod VM Setup Spec
> One VM, every tool, every device. The complete YouTube production environment.

**Status:** active — VM live, core pipeline verified
**Created:** 2026-03-23
**Links:** [YouTube Migration](./README.md), [Episode 1 Script](./scripts/ep01-you-dont-know-what-logic-is.md)

---

## The Concept

A single RunPod VM that serves as the complete production studio:
- Claude Code for writing/iterating
- Manim for math animations
- Stable Diffusion / Flux for character art and scene generation
- Video compositing and encoding
- Direct YouTube upload
- The vault (git cloned) for reference and publishing
- Accessible from any device (work laptop, iPad, phone) via SSH

No sync issues. No file transfers. No enterprise policy conflicts. Everything lives on the VM.

## VM Spec

| Setting | Value | Why |
|---------|-------|-----|
| GPU | RTX 3090 (24GB) or RTX 4090 (24GB) | SD/Flux needs VRAM; 3090 is cheapest with 24GB |
| Provider | RunPod Community Cloud | Best price/performance for GPU |
| vCPU | 8+ cores | Manim rendering, ffmpeg encoding |
| RAM | 32GB+ | SD models + video processing |
| Disk | 100GB+ container disk | OS + tools + active projects |
| Persistent Volume | 50-100GB network volume | Vault, rendered outputs, model files that survive pod restarts |
| Template | Ubuntu 22.04 base or RunPod PyTorch template | Clean starting point with CUDA pre-configured |

**Estimated cost:** ~$0.20-0.30/hr (RTX 3090 community). At 40 hrs/week = ~$32-48/month.

## Installation Checklist

### Phase 1: Core Environment

```bash
# System basics
apt-get update && apt-get install -y \
    git curl wget tmux htop ffmpeg \
    build-essential pkg-config \
    libpango1.0-dev libcairo2-dev \
    python3-pip python3-venv nodejs npm

# Claude Code
npm install -g @anthropic-ai/claude-code

# Python environment
python3 -m venv /workspace/venv
source /workspace/venv/bin/activate

# Manim
pip install manim

# Verify
manim --version
claude --version
ffmpeg -version
```

### Phase 2: AI Image Generation (Stable Diffusion / Flux)

```bash
# ComfyUI (node-based SD/Flux interface — more flexible than WebUI)
cd /workspace
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
pip install -r requirements.txt

# Download models (to persistent volume so they survive restarts)
mkdir -p /workspace/models/checkpoints
mkdir -p /workspace/models/loras

# SDXL base (for general image gen)
# wget -O /workspace/models/checkpoints/sdxl_base.safetensors [URL]

# Flux-dev (for high-quality character art)
# wget -O /workspace/models/checkpoints/flux-dev.safetensors [URL]
# Note: Flux models are ~12GB. Download once to persistent volume.

# Start ComfyUI (accessible via browser on forwarded port)
# python main.py --listen 0.0.0.0 --port 8188
```

### Phase 3: Video Production Tools

```bash
# yt-dlp (for downloading reference material)
pip install yt-dlp

# youtube-transcript-api (for transcript fetching)
pip install youtube-transcript-api

# youtubeuploader (direct upload to YouTube)
# Download Go binary from: https://github.com/porjo/youtubeuploader
# One-time OAuth setup required (browser-based)

# ImageMagick (image manipulation)
apt-get install -y imagemagick

# sox (audio processing)
apt-get install -y sox libsox-fmt-all
```

### Phase 4: Character Animation Tools

```bash
# Cutout animation — tools to explore:

# 1. Pango + Cairo (already installed for Manim)
#    Can render text overlays and simple shapes programmatically

# 2. Pillow (Python image manipulation)
pip install Pillow

# 3. MoviePy (Python video editing/compositing)
pip install moviepy

# 4. OpenCV (image processing, face detection for lip-sync alignment)
pip install opencv-python

# 5. rhubarb-lip-sync (automatic lip-sync from audio)
#    Analyzes audio and outputs mouth shape timecodes
#    https://github.com/DanielSWolf/rhubarb-lip-sync
#    Download binary for Linux

# 6. Remotion (React-based video generation — if we want web-based approach)
#    npm install -g remotion
#    Renders video from React components — potentially cleaner than Manim for
#    non-math content (cutout characters, text cards, transitions)
```

### Phase 5: Vault and Project Setup

```bash
# Clone vault
cd /workspace
git clone https://github.com/chrisaacson69/Vault.git

# Clone Monopoly project (if needed)
git clone https://github.com/chrisaacson69/monopoly.git

# Set up git identity
git config --global user.name "Chris Isaacson"
git config --global user.email "[email]"

# YouTube Migration project files are inside the vault:
# /workspace/Vault/projects/youtube-migration/scripts/
# /workspace/Vault/projects/youtube-migration/manim/
```

## Production Pipeline

### The Full Episode Pipeline

```
┌─────────────────────────────────────────────────────┐
│                   RunPod VM                          │
│                                                      │
│  1. WRITE ──→ Claude Code edits script + Manim code  │
│                                                      │
│  2. GENERATE ──→ ComfyUI/SD creates character art    │
│         └──→ AI generates scene backgrounds           │
│         └──→ Export as PNG layers (head, body, mouths)│
│                                                      │
│  3. ANIMATE ──→ Manim renders math/logic scenes      │
│         └──→ Python/MoviePy composites characters     │
│         └──→ rhubarb-lip-sync generates mouth timings │
│                                                      │
│  4. RECORD ──→ Upload voiceover WAV from any device   │
│                                                      │
│  5. COMPOSITE ──→ ffmpeg/MoviePy combines:            │
│         • Manim renders                               │
│         • Character animation layers                  │
│         • Voiceover audio                             │
│         • Background music                            │
│         • Transitions                                 │
│                                                      │
│  6. REVIEW ──→ Download preview MP4 or view via noVNC │
│                                                      │
│  7. PUBLISH ──→ youtubeuploader pushes to YouTube     │
│                                                      │
│  8. COMMIT ──→ git push scripts/assets to GitHub      │
│                                                      │
└─────────────────────────────────────────────────────┘
         ↑                              ↑
    SSH/Terminal                    Browser/noVNC
    (Claude Code)                  (ComfyUI, review)
         ↑                              ↑
┌─────────────┐                ┌─────────────┐
│ Work laptop │                │    iPad      │
│   Phone     │                │   Tablet     │
│  Any device │                │              │
└─────────────┘                └─────────────┘
```

### Per-Asset Production

**Manim scenes (math/logic animations):**
```
Claude writes .py → manim -qh scene.py → output MP4
```

**Character art (Terrance & Phillip style cutouts):**
```
ComfyUI generates character in consistent style
→ Photoshop/GIMP/Python separates into layers (head, body, arms)
→ Generate 4 mouth variants per character
→ Save as PNG assets in /workspace/assets/characters/
```

**Character animation (lip-sync):**
```
rhubarb-lip-sync analyzes voiceover.wav → mouth_timecodes.json
Python script reads timecodes → composites mouth PNGs onto character body
→ Renders character animation MP4 synced to audio
```

**Scene composition:**
```
ffmpeg merges:
  - Background (AI generated or solid color)
  - Character animation layer (transparent PNG sequence)
  - Manim render layer (transparent or composited)
  - Voiceover audio track
  - Music track (ducked under voiceover)
→ Final scene MP4
```

**Episode assembly:**
```
ffmpeg concat:
  scene_01_cold_open.mp4
  scene_02_agora.mp4
  scene_03_syllogism.mp4
  ...
→ episode_01_final.mp4
→ youtubeuploader → YouTube
```

## Tools to Explore Further

### Character Animation (the big unknown)

The Terrance & Phillip style cutout animation is the least-solved part of the pipeline. Options to test:

| Tool | What it does | Complexity | Quality |
|------|-------------|-----------|---------|
| **MoviePy + Pillow** | Python script swaps mouth PNGs on timer | Low | Basic but functional |
| **rhubarb-lip-sync** | Auto-detects mouth shapes from audio | Medium | Good lip-sync |
| **Remotion** | React components rendered as video | Medium-High | Very flexible |
| **Adobe Character Animator** | Auto lip-sync from webcam/audio | High (needs Adobe) | Professional |
| **Live2D Cubism** | 2D character rigging | High | Very smooth |
| **Custom Manim scenes** | Characters built as Manim objects | Medium | Matches math scenes perfectly |

**Recommendation:** Start with **MoviePy + rhubarb-lip-sync**. It's all Python, runs on the VM, Claude can script it. If it looks too janky, upgrade to Remotion or explore Live2D later.

### AI Scene Generation

For backgrounds and scene art (the Greek agora, Aristotle's study, etc.):

| Tool | What it does | On our VM? |
|------|-------------|-----------|
| **ComfyUI + SDXL/Flux** | Generate consistent-style backgrounds | Yes — 24GB VRAM handles this easily |
| **IP-Adapter** | Style transfer — generate new scenes in same art style | Yes — ComfyUI node |
| **ControlNet** | Guide generation with line art / depth maps | Yes — ComfyUI node |

The workflow: generate one "key frame" background per scene in a consistent art style. Use IP-Adapter to maintain style consistency across scenes. Animate with Ken Burns effect (pan/zoom) in ffmpeg.

### Audio

| Tool | What it does | Notes |
|------|-------------|-------|
| **Audacity** (if GUI available) | Record + edit voiceover | Needs noVNC |
| **sox** (CLI) | Audio processing, noise reduction | CLI — Claude can script |
| **ffmpeg** | Audio mixing, ducking music under voice | CLI — Claude can script |
| **Free music** | Kevin MacLeod, YouTube Audio Library | Download to VM |

**Voiceover recording** is the one thing that probably stays on your local device (laptop/phone with a mic). Record WAV, upload to VM via scp/rsync. Everything after that happens on the VM.

## Persistent Volume Layout

```
/workspace/                          # RunPod workspace (container disk)
├── venv/                            # Python virtual environment
├── ComfyUI/                         # Stable Diffusion interface
├── Vault/                           # Git clone of vault
├── monopoly/                        # Git clone of Monopoly project
└── studio/                          # YouTube production workspace
    ├── assets/
    │   ├── characters/              # Character PNGs (head, body, mouth variants)
    │   │   ├── aristotle/
    │   │   ├── socrates/
    │   │   ├── sophist/
    │   │   └── ...
    │   ├── backgrounds/             # AI-generated scene backgrounds
    │   ├── music/                   # Background music tracks
    │   └── fonts/                   # Custom fonts if needed
    ├── episodes/
    │   ├── ep01/
    │   │   ├── scenes/              # Individual rendered scenes
    │   │   ├── voiceover/           # Recorded audio
    │   │   ├── composite/           # Assembled scenes
    │   │   └── final/               # Final episode MP4
    │   ├── ep02/
    │   └── ...
    ├── scripts/                     # Manim .py files (also in vault)
    └── tools/                       # Helper scripts, automation
```

The `/workspace/` on RunPod persists within the container. For data that MUST survive pod restarts, use a RunPod Network Volume mounted at `/workspace/persistent/` and put models + finished renders there.

## First Session Checklist

1. [x] Spin up RTX 3090 community instance — NVIDIA driver 580, CUDA 13.0
2. [x] Run Phase 1 install (core environment) — Manim 0.20.1, ffmpeg 4.4.2, Python 3.11, Node 20
3. [x] Verify Claude Code works via SSH
4. [x] Clone vault, verify git push works
5. [x] Install Manim, render ep01_syllogism.py — all 3 scenes rendered (Syllogism, ThreeLaws, LightSwitchDimmer)
6. [x] Run Phase 2 install (ComfyUI + download one SD model) — SDXL base 1.0 downloaded
7. [x] Generate a test character image — test_aristotle.png generated via SDXL
8. [x] Install rhubarb-lip-sync, test with a sample audio file
9. [x] Test MoviePy character compositing with a simple script — test_composite.mp4 produced
10. [x] Install youtubeuploader, do OAuth setup — client_secrets.json + request.token present
11. [ ] Record a 10-second test voiceover, upload to VM, composite with a Manim scene
12. [ ] Upload test video to YouTube (unlisted)
13. [ ] Celebrate — the pipeline works

## Cost Estimate

| Item | Monthly cost |
|------|-------------|
| RunPod RTX 3090 @ 40 hrs/week | ~$32-48 |
| Persistent volume (100GB) | ~$7 |
| **Total** | **~$39-55/month** |

Compare: RTX 4070 Ti Super GPU alone = $1,300+. Break-even = ~24-33 months. By then, GPU prices will have normalized and you can build the desktop.

## Tags
[youtube](../../tags/youtube.md), [projects](../../tags/projects.md)

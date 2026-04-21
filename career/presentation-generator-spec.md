---
status: active
created: 2026-04-15
---
# Live Presentation Generator — Technical Spec
> Type a prompt during a live interview, watch the slideshow appear. The generation IS the presentation.

**Links:** [Tools Roadmap](./tools-roadmap.md), [Career Strategy](./strategy.md), [Level 6 — Direct Execution](../research/level-6-direct-execution.md)

## Important: CLI/Browser Only

Marp slides must be presented via the CLI preview window (`marp -p`) or HTML export opened in a browser — **never** through the Obsidian Marp Slides plugin. The Obsidian plugin renders inline in a note pane, which looks cramped and fights with Obsidian's own CSS. This was originally why Marp was rejected as "not clean enough." The browser/CLI output is dramatically better — full-screen, proper theme rendering, clean presentation mode.

## The Live Demo Use Case

During an interview, you have a Marp preview window open (watch mode). You type a prompt into Claude Code. Claude reads vault pages, writes the markdown, and slides materialize in real-time in the preview window. The interviewer watches it happen. Then you present the slides it just made. The process proves the thesis before a word is spoken.

## Technical Approach — Dual Output

### Live Demo (Marp Watch Mode)

- Pre-start: `marp -w -p ./interview-slides.md` — opens preview window, watches for changes
- Claude Code skill writes Marp markdown → preview auto-refreshes in ~1.2 seconds
- Custom CSS theme for professional appearance (dark background, branded fonts/colors)
- Supports code blocks (syntax highlighted via Prism/Shiki), tables, math (KaTeX), split layouts

### Takeaway Copy (python-pptx)

- python-pptx generates a native .pptx in ~59ms from a pre-designed template
- Professional PowerPoint template with proper layouts, fonts, branding
- Hand to the interviewer as a polished PPTX they can open natively
- Same content source, different output format

## Benchmark Data (Windows 11)

| Tool | Format | Time (10 slides) | Quality |
|---|---|---|---|
| python-pptx | .pptx | 59ms | Template-dependent — needs designed template |
| Marp CLI | .html | 1,216ms | Professional with custom theme |
| Marp CLI | .pptx | 4,866ms | Acceptable but not native PowerPoint quality |
| RevealJS | static HTML | 5,863ms | Beautiful but 68-file directory, needs server |
| Slidev | dev server | 3-5s boot | Highest quality but requires Vite, overkill for generation |
| Google Slides API | cloud | 3-8s | Requires internet + auth — too many failure modes |

## Why Marp for Live, python-pptx for Takeaway

**The Marp concern:** previous experience showed Marp slides weren't as clean as expected in export. The issue was likely the default theme, not the tool. A custom CSS theme with professional fonts, dark background, and branded colors transforms the output. The watch mode — slides appearing as Claude writes — is a feature no other tool offers.

**The python-pptx complement:** for the PPTX copy the interviewer takes home, python-pptx with a pre-designed PowerPoint template produces native quality. No Marp rendering artifacts, no font substitution issues. Same content, professional delivery format.

**Rejected alternatives:**
- **RevealJS** — 68-file output directory, requires server for best experience. Higher visual ceiling but too much friction for live generation
- **Slidev** — highest quality but requires full Vite dev server. 15-60s cold start. Built for prepared talks, wrong for live generation
- **Google Slides API** — internet-dependent, OAuth2 required, corporate firewalls may block. Too many failure modes for live demo

## Existing Resources

| Resource | What It Is |
|---|---|
| [marp-ai-slide-generator](https://github.com/itarutomy97/marp-ai-slide-generator) | JSON-based Marp generation with AI agents |
| [freeCodeCamp: Claude Code + Marp](https://www.freecodecamp.org/news/how-to-use-claude-code-and-marp-to-think-through-presentations/) | Workflow article — documents exactly this pattern |
| [MCP Marp skill](https://mcpmarket.com/tools/skills/marp-presentation-generator) | Claude Code skill with interview phase + generation phase |
| [Marp community themes](https://rnd195.github.io/marp-community-themes/) | Gradient, dark, business, tech themes |
| [robonuggets/marp-slides](https://github.com/robonuggets/marp-slides) | Another Claude Code Marp skill |

## Slides-to-Video Pipeline

Tested 2026-04-15. The full chain runs locally, no GPU required:

```
Marp markdown → PNG export (--images png --image-scale 2) → ffmpeg composite → MP4
```

**What works now:**
- `marp --images png --image-scale 2 slides.md` → one PNG per slide at 2560x1440
- ffmpeg concatenates with fade transitions → clean MP4 in seconds
- Output is visually identical to the slideshow — same theme, same rendering quality

**What's left is coloring, not engineering:**
- Per-slide timing (some slides need 8 seconds, others need 15)
- Transition style (fade, cut, wipe)
- Pacing to match narration when audio is added
- Background music level

**Three tiers for video production:**

| Tier | What | Tools | Where It Runs |
|---|---|---|---|
| 1. Narrated slideshow | Slide PNGs + timed transitions + TTS/recorded narration + background music | Marp CLI, ffmpeg | Local, seconds |
| 2. Slides + character | Tier 1 + character overlay in corner doing lip-sync | + Rhubarb, Fish Speech, composite_lipsync.py | RunPod, minutes |
| 3. Full generative | AI-generated visuals, animated transitions, dynamic scenes | + ComfyUI, AnimateDiff | RunPod GPU, minutes per clip |

Tier 2 is the sweet spot for career demos — uses the existing [animation-studio](https://github.com/chrisaacson69/animation-studio) pipeline and produces a format familiar from YouTube explainer channels.

**Tier 1 ffmpeg command (tested):**
```bash
ffmpeg -y \
  -loop 1 -t <seconds> -i slide.001.png \
  -loop 1 -t <seconds> -i slide.002.png \
  ...
  -filter_complex "[0:v]fade=t=out:st=<T-1>:d=1[v0]; \
    [1:v]fade=t=in:st=0:d=1,fade=t=out:st=<T-1>:d=1[v1]; \
    ... \
    [v0][v1]...concat=n=N:v=1:a=0[out]" \
  -map "[out]" -c:v libx264 -pix_fmt yuv420p -r 24 output.mp4
```

Per-slide timing is controlled by the `-t` parameter on each input. The skill should accept a timing array alongside the content.

## Build Plan

1. Design custom Marp CSS theme (professional, dark, branded)
2. Design PowerPoint template with placeholder layouts for python-pptx
3. Build Claude Code skill: reads vault pages → generates Marp markdown + PPTX
4. Test the live demo workflow end-to-end
5. Add video generation mode: Marp → PNGs → ffmpeg composite with per-slide timing
6. Add narration mode: generate script → TTS → sync timing to audio duration

## Tags

[ai](../tags/ai.md), [career](../tags/career.md)

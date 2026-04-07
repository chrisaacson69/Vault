---
tags: [tools, workflow, transcription]
created: 2026-04-02
---

# yt-dlp Transcript Workflow

## The Problem

Sites like Rumble don't auto-generate captions the way YouTube does. For long livestreams, you often only need a transcript of a specific segment.

## Segment + Transcribe Workflow

```bash
# 1. Download only the portion you need (audio only)
yt-dlp --download-sections "*1:30:00-2:00:00" -x --audio-format mp3 "VIDEO_URL" -o segment.mp3

# 2. Transcribe with Whisper
whisper segment.mp3 --model medium --language en
```

### Notes
- `--download-sections` takes `*START-END` format (e.g., `*10:00-25:00` or `*1:30:00-2:00:00`)
- Scrub through the video in-browser first to find the timestamps you want
- Whisper runs well on GPU (RunPod) for long segments
- Check if subtitles already exist before transcribing: `yt-dlp --list-subs "URL"`

## Full video transcript (no segmenting)

```bash
# YouTube — grab existing auto-captions
yt-dlp --write-auto-sub --sub-lang en --skip-download "YOUTUBE_URL"

# Any site — download audio and transcribe
yt-dlp -x --audio-format mp3 "VIDEO_URL" -o audio.mp3
whisper audio.mp3 --model medium --language en
```

## Notable Sites Supported by yt-dlp

**Video Platforms:** YouTube, Vimeo, Dailymotion, Rumble, Bilibili, PeerTube

**Social Media:** Twitter/X, Facebook, Instagram, TikTok, Reddit, LinkedIn

**Live Streaming:** Twitch (live + VODs + clips), Kick

**Audio / Music:** SoundCloud, Bandcamp, Mixcloud, Audiomack

**News / Media:** BBC, CNN, NBC, CBS, ABC, NPR, ARD/ZDF, France TV, NHK

**Education:** TED, Khan Academy, Coursera, Udemy

**Podcasts:** Spotify (podcasts only), Apple Podcasts

**Other:** Internet Archive, Google Drive, Dropbox, Imgur, Niconico

Full list: 1,000+ extractors. Run `yt-dlp --list-extractors` to see all.

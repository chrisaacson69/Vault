# Video Extraction — Handler

Mid-level handler for extracting content from video sources. Called by content-extract.md dispatcher when a video URL is detected.

**Specific tool:** `yt-dlp` (supports YouTube, Rumble, and 1000+ sites)

## Metadata Extraction

```bash
yt-dlp --skip-download --print title --print channel --print duration_string --print upload_date "URL"
```

Returns: title, channel name, duration, upload date (one per line).

## Transcript Download

Try auto-generated captions first, fall back to manual:

```bash
# Auto-generated captions (most common)
yt-dlp --write-auto-sub --sub-lang en --sub-format srt --skip-download -o "/tmp/transcript" "URL"

# Manual subtitles (if auto unavailable)
yt-dlp --write-sub --sub-lang en --sub-format srt --skip-download -o "/tmp/transcript" "URL"
```

## SRT Cleaning

Auto-generated SRT files need cleaning before processing:

1. **Remove sequence numbers** — lines containing only a digit
2. **Remove timestamp lines** — lines matching `HH:MM:SS,mmm --> HH:MM:SS,mmm`
3. **Remove duplicate lines** — auto-captions often repeat phrases across segments
4. **Remove formatting tags** — strip `<font>`, `<i>`, alignment tags
5. **Join into paragraphs** — group sentences into flowing text, roughly by natural pauses

## Audio Download (for lip-sync pipeline)

When audio is needed for Rhubarb lip-sync or TTS comparison:

```bash
# Download audio only as WAV
yt-dlp -x --audio-format wav -o "/tmp/audio" "URL"
```

## Raw File Frontmatter

Save extracted content to `raw/videos/` (or `raw/debates/` for debate content):

```yaml
---
source: <URL>
author: <channel name>
title: <video title>
clipped: <today YYYY-MM-DD>
published: <upload date>
type: youtube
---
```

## Failure Modes

- **No captions available:** Tell the user. Suggest downloading audio and using Whisper for transcription (see notes/yt-dlp-transcript-workflow.md for the full workflow).
- **Geo-blocked / age-restricted:** Note the failure. The user may need to provide cookies or use a different approach.
- **Live stream / premiere:** May not have captions yet. Check back later.

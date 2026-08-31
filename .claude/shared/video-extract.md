# Video Extraction — Handler

Mid-level handler for extracting content from video sources. Called by content-extract.md dispatcher when a video URL is detected.

**Specific tool:** `yt-dlp` (supports YouTube, Rumble, and 1000+ sites)

## Metadata Extraction

Two equivalent paths depending on whether you already have `info.json`:

**If you have the info.json file** (you do, if you used `--write-info-json` below) — run the saved script:

```bash
node .claude/shared/scripts/yt-meta.js <path-to-info.json>
```

Prints a JSON object with title, uploader, channel, upload_date, duration, view_count, and a truncated description. Pass `--desc-chars=N` to change the description length.

**If you only need a quick header from yt-dlp directly:**

```bash
yt-dlp --skip-download --print title --print channel --print duration_string --print upload_date "URL"
```

## Transcript Download

Try auto-generated captions first, fall back to manual:

```bash
# Auto-generated captions (most common)
yt-dlp --write-auto-sub --sub-lang en --sub-format srt --skip-download -o "/tmp/transcript" "URL"

# Manual subtitles (if auto unavailable)
yt-dlp --write-sub --sub-lang en --sub-format srt --skip-download -o "/tmp/transcript" "URL"
```

## SRT Cleaning

Run the saved script:

```bash
node .claude/shared/scripts/clean-srt.js <input.srt> <output.txt>
```

It strips SRT sequence numbers, timestamp lines, and consecutive duplicates (auto-captions repeat phrases across segments), then joins the remainder into a flat single-paragraph transcript with collapsed whitespace.

The script is deterministic and replaces the previous per-ingest regeneration of equivalent inline Node code. If you ever need to extend it (e.g., to preserve paragraph breaks, or to filter out `<font>` / `<i>` formatting tags), edit the script — don't regenerate the logic.

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

## Fallback: yt-dlp cannot connect at all (SNI-blocked network)

On a network that blocks `www.youtube.com` by SNI — symptom: **every** TCP client
(`yt-dlp`, `curl`, `WebFetch`) dies at the TLS handshake with `SSLV3_ALERT_HANDSHAKE_FAILURE`
or schannel `SEC_E_ILLEGAL_MESSAGE`, while `youtu.be` and `youtube-nocookie.com` work —
**do not debug yt-dlp.** It has no HTTP/3 backend, so no version and no flag can help
(`-U`, rebuild, `--impersonate`, `--legacy-server-connect` all tested and failed).

Use the saved tool, which drives Chrome over QUIC via CDP:

```bash
py -3 tools/fetch-youtube-transcript.py "<url-or-id>" "raw/videos/YYYY-MM-DD slug.txt"
```

It clears three separate walls — QUIC transport, capturing the player's own POT-bearing
caption URL, and a **User-Agent override without which YouTube returns an empty 200 to
headless Chrome**. That last one is the trap: the request *succeeds* with a 0-byte body,
so it reads as "no captions" rather than as a block. Full reasoning is in the tool's
docstring; provenance in memory `feedback_yt_dlp_transcripts`.

Metadata only (no captions needed) is cheaper via `youtube-nocookie.com` + a
`Host: www.youtube.com` header — no browser required.

## Failure Modes

- **No captions available:** Tell the user. Suggest downloading audio and using Whisper for transcription (see notes/yt-dlp-transcript-workflow.md for the full workflow).
- **Caption request returns HTTP 200 with 0 bytes:** not a network failure and not "no captions" — it is headless-browser detection (`cbr=HeadlessChrome` in the request) or a pre-roll ad playing. Both are handled by `tools/fetch-youtube-transcript.py`.
- **Geo-blocked / age-restricted:** Note the failure. The user may need to provide cookies or use a different approach.
- **Live stream / premiere:** May not have captions yet. Check back later.

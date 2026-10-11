#!/usr/bin/env node
// clean-srt.js — convert a YouTube auto-caption SRT or VTT into a flat, deduplicated transcript.
//
// Usage:
//   node clean-srt.js <input.srt|input.vtt> <output.txt> [--stamp=SECONDS]
//
// --stamp=N  (opt-in) insert a "[H:MM:SS]" marker before the first caption line of each
//            N-second window, so long VODs stay citable by time. Default output is unchanged.
//
// Strips:
//   - SRT sequence numbers (lines that are only digits)
//   - SRT/VTT timestamp lines (matching "HH:MM:SS,mmm --> HH:MM:SS,mmm")
//   - WEBVTT header lines ("WEBVTT", "Kind: ...", "Language: ...")
//   - Inline markup tags (<c>, </c>, <00:00:01.680>, <i>, <font ...>) — YouTube's
//     auto-VTT carries per-word timing tags that must go BEFORE dedup, or the
//     rolling-caption repeats never compare equal and dedup silently no-ops.
//   - Consecutive duplicate lines (auto-captions repeat phrases across segments)
//
// Joins the remainder into a single flat paragraph with collapsed whitespace.
// Prints the output character count to stderr.

const fs = require('fs');

const [, , inputPath, outputPath, ...flags] = process.argv;
const stampFlag = flags.find(f => f.startsWith('--stamp='));
const stampEvery = stampFlag ? Number(stampFlag.slice(8)) : 0;
const toSec = t => { const m = t.match(/(\d+):(\d+):(\d+)/); return m ? +m[1] * 3600 + +m[2] * 60 + +m[3] : 0; };
const fmt = s => `${Math.floor(s / 3600)}:${String(Math.floor(s / 60) % 60).padStart(2, '0')}:${String(s % 60).padStart(2, '0')}`;
let curSec = 0, lastBucket = -1;
if (!inputPath || !outputPath) {
  console.error('Usage: node clean-srt.js <input.srt> <output.txt>');
  process.exit(1);
}

const raw = fs.readFileSync(inputPath, 'utf8');
const lines = raw.split(/\r?\n/);
const kept = [];
for (const l of lines) {
  if (!l) continue;
  if (/^\d+$/.test(l)) continue;
  if (/-->/.test(l)) { curSec = toSec(l); continue; }
  if (/^(WEBVTT|Kind:|Language:)/.test(l)) continue;
  // Strip inline markup before the dedup pass below — per-word <00:00:01.680><c>word</c>
  // timing tags differ on every repeat of the same rolling caption line.
  let stripped = l.replace(/<[^>]*>/g, '');
  // Decode HTML entities AFTER tag-stripping (so &lt;i&gt; text isn't re-read as a tag).
  // Matters for speaker-change markers: YouTube renders them as "&gt;&gt;" -> ">>".
  stripped = stripped
    .replace(/&gt;/g, '>')
    .replace(/&lt;/g, '<')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&nbsp;/g, ' ')
    .replace(/&amp;/g, '&');
  stripped = stripped.replace(/\s+/g, ' ').trim();
  if (!stripped) continue;
  if (stampEvery) {
    const bucket = Math.floor(curSec / stampEvery);
    if (bucket !== lastBucket && kept[kept.length - 1] !== stripped) {
      lastBucket = bucket;
      kept.push(`\n[${fmt(bucket * stampEvery)}]`);
    }
  }
  kept.push(stripped);
}

const deduped = [];
for (const l of kept) {
  if (deduped[deduped.length - 1] !== l) deduped.push(l);
}

const flat = stampEvery
  ? deduped.join(' ').replace(/[ \t]+/g, ' ').replace(/ ?\n ?/g, '\n').trim()
  : deduped.join(' ').replace(/\s+/g, ' ').trim();
fs.writeFileSync(outputPath, flat);
console.error(`wrote ${flat.length} chars to ${outputPath}`);

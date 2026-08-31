#!/usr/bin/env node
// clean-srt.js — convert a YouTube auto-caption SRT or VTT into a flat, deduplicated transcript.
//
// Usage:
//   node clean-srt.js <input.srt|input.vtt> <output.txt>
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

const [, , inputPath, outputPath] = process.argv;
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
  if (/-->/.test(l)) continue;
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
  kept.push(stripped);
}

const deduped = [];
for (const l of kept) {
  if (deduped[deduped.length - 1] !== l) deduped.push(l);
}

const flat = deduped.join(' ').replace(/\s+/g, ' ').trim();
fs.writeFileSync(outputPath, flat);
console.error(`wrote ${flat.length} chars to ${outputPath}`);

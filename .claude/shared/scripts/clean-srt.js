#!/usr/bin/env node
// clean-srt.js — convert a YouTube auto-caption SRT into a flat, deduplicated transcript.
//
// Usage:
//   node clean-srt.js <input.srt> <output.txt>
//
// Strips:
//   - SRT sequence numbers (lines that are only digits)
//   - SRT timestamp lines (matching "HH:MM:SS,mmm --> HH:MM:SS,mmm")
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
  kept.push(l);
}

const deduped = [];
for (const l of kept) {
  if (deduped[deduped.length - 1] !== l) deduped.push(l);
}

const flat = deduped.join(' ').replace(/\s+/g, ' ').trim();
fs.writeFileSync(outputPath, flat);
console.error(`wrote ${flat.length} chars to ${outputPath}`);

#!/usr/bin/env node
// slice-vtt.js — extract a time range from a WebVTT/SRT caption file, preserving cue structure.
//
// Usage:
//   node slice-vtt.js <input.vtt> <start> <end> <output.vtt>
//   node slice-vtt.js stream.en.vtt 1:17:45 1:50:00 segment.vtt
//
// Times accept H:MM:SS, MM:SS, or plain seconds. `end` may be "-" for "to the end".
//
// Why this exists: clean-srt.js strips timestamps, so slicing MUST happen first. Long
// livestreams (4h+) need the relevant segment isolated before the transcript is usable —
// this is the standard first step of a debate/video review with a start timestamp.
//
// A cue is kept when its START time falls within [start, end).

const fs = require('fs');

const [, , inputPath, startArg, endArg, outputPath] = process.argv;
if (!inputPath || !startArg || !endArg || !outputPath) {
  console.error('Usage: node slice-vtt.js <input.vtt> <start> <end|-> <output.vtt>');
  process.exit(1);
}

function parseTime(t) {
  if (t === '-') return Infinity;
  const parts = String(t).split(':').map(Number);
  if (parts.some(isNaN)) { console.error(`bad time: ${t}`); process.exit(1); }
  return parts.reduce((acc, p) => acc * 60 + p, 0);
}

const start = parseTime(startArg);
const end = parseTime(endArg);
if (end <= start) { console.error('end must be after start'); process.exit(1); }

const raw = fs.readFileSync(inputPath, 'utf8');
// Cue timing lines look like: 00:01:02.345 --> 00:01:05.678 [settings]
const TIMING = /^(\d{1,2}:)?\d{1,2}:\d{2}[.,]\d{1,3}\s+-->/;

function cueStartSeconds(line) {
  const stamp = line.split('-->')[0].trim().replace(',', '.');
  const parts = stamp.split(':').map(Number);
  return parts.reduce((acc, p) => acc * 60 + p, 0);
}

const lines = raw.split(/\r?\n/);
const out = [];
let keeping = false;
let sawAnyCue = false;

for (const line of lines) {
  if (TIMING.test(line)) {
    sawAnyCue = true;
    const t = cueStartSeconds(line);
    keeping = t >= start && t < end;
    if (keeping) out.push(line);
    continue;
  }
  // Header lines before the first cue are always preserved.
  if (!sawAnyCue) { out.push(line); continue; }
  if (keeping) out.push(line);
}

if (!sawAnyCue) {
  console.error('WARNING: no cue timing lines found — is this really a VTT/SRT file?');
  process.exit(2);
}

const kept = out.filter((l) => TIMING.test(l)).length;
if (kept === 0) {
  console.error(`WARNING: 0 cues in range ${startArg}..${endArg} — check the timestamps.`);
  process.exit(3);
}

fs.writeFileSync(outputPath, out.join('\n'));
console.error(`kept ${kept} cues (${startArg} -> ${endArg}) -> ${outputPath}`);

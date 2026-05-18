#!/usr/bin/env node
// yt-meta.js — extract the fields we actually use from a yt-dlp info.json.
//
// Usage:
//   node yt-meta.js <info.json> [--desc-chars=2000]
//
// Prints a JSON object with: title, uploader, channel, upload_date, duration,
// view_count, and a truncated description. Default description truncation is 1500 chars.

const fs = require('fs');
const path = require('path');

const [, , inputPath, ...rest] = process.argv;
if (!inputPath) {
  console.error('Usage: node yt-meta.js <info.json> [--desc-chars=N]');
  process.exit(1);
}

let descChars = 1500;
for (const arg of rest) {
  const m = arg.match(/^--desc-chars=(\d+)$/);
  if (m) descChars = parseInt(m[1], 10);
}

const data = JSON.parse(fs.readFileSync(path.resolve(inputPath), 'utf8'));
const out = {
  title: data.title,
  uploader: data.uploader,
  channel: data.channel,
  upload_date: data.upload_date,
  duration: data.duration,
  view_count: data.view_count,
  description: typeof data.description === 'string' ? data.description.slice(0, descChars) : null,
};

console.log(JSON.stringify(out, null, 2));

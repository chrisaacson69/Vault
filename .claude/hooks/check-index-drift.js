#!/usr/bin/env node
// Stop hook: SOFT reminder when a new wiki page exists but isn't in INDEX.md yet.
// "The index keeps getting pushed aside" — this binds the reminder to the session boundary.
//
// Scope is deliberately high-precision to stay SOFT (no per-edit nagging): it only fires for
// NEW (untracked/added) .md pages under content dirs whose path/basename is absent from INDEX.md.
// Prose edits to existing pages do NOT trigger it. Guarded by stop_hook_active so it fires at
// most once per stop (never loops). Non-fatal on any error (exit 0).

const path = require('path');
const fs = require('fs');
const { execSync } = require('child_process');

let input = '';
process.stdin.on('data', (d) => (input += d));
process.stdin.on('end', () => {
  let data = {};
  try {
    data = JSON.parse(input);
  } catch {
    process.exit(0);
  }
  if (data.stop_hook_active) process.exit(0); // already nudged once this stop — don't loop

  const root = path.resolve(__dirname, '..', '..');

  let porcelain = '';
  try {
    porcelain = execSync('git status --porcelain', { cwd: root, encoding: 'utf8' });
  } catch {
    process.exit(0); // not a git repo / git unavailable — say nothing
  }

  const contentDirs = ['research/', 'notes/', 'career/', 'projects/', 'tasks/'];
  const newPages = [];
  for (const line of porcelain.split('\n')) {
    if (!line) continue;
    const status = line.slice(0, 2);
    let file = line.slice(3).trim().replace(/^"|"$/g, '');
    if (!file.endsWith('.md')) continue;
    const isNew = status.includes('?') || status.includes('A'); // untracked or added
    if (!isNew) continue;
    const norm = file.replace(/\\/g, '/');
    if (contentDirs.some((d) => norm.startsWith(d))) newPages.push(norm);
  }
  if (!newPages.length) process.exit(0);

  let index = '';
  try {
    index = fs.readFileSync(path.join(root, 'INDEX.md'), 'utf8');
  } catch {
    /* no index — fall through, everything counts as unindexed */
  }
  const unindexed = newPages.filter((p) => {
    const base = p.split('/').pop();
    return !index.includes(p) && !index.includes(base);
  });
  if (!unindexed.length) process.exit(0);

  // Log each firing — the RATE is a health signal: frequent firings = drift accumulating
  // faster than it's integrated = time for a cleanup pass. The monthly heartbeat reads this log.
  try {
    const logsDir = path.join(root, 'logs');
    fs.mkdirSync(logsDir, { recursive: true });
    fs.appendFileSync(
      path.join(logsDir, 'index-drift.log'),
      new Date().toISOString() + '\t' + unindexed.join(', ') + '\n'
    );
  } catch {
    /* best-effort */
  }

  const list = unindexed.slice(0, 5).join(', ') + (unindexed.length > 5 ? ` (+${unindexed.length - 5} more)` : '');
  const msg =
    `Index-drift check: ${unindexed.length} new page(s) not yet in INDEX.md — ${list}. ` +
    `Before finishing, add the INDEX entry + tag back-links (run /vault-sync), or tell the user they're unindexed. ` +
    `(Soft reminder — you may still stop.)`;

  process.stdout.write(
    JSON.stringify({ hookSpecificOutput: { hookEventName: 'Stop', additionalContext: msg } })
  );
  process.exit(0);
});

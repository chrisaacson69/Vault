#!/usr/bin/env node
// PreToolUse guardrail: make raw/ the IMMUTABLE source of truth at the tool level.
// The CLAUDE.md Grounding Discipline says "raw files are immutable" — this turns that
// request into a rule the agent cannot bypass.
//
// Immutable means EXISTING sources never change — NOT that raw/ is frozen. New capture is
// the whole point of raw/, so:
//   - Edit / MultiEdit / NotebookEdit on a file under raw/        -> DENY (always a modification)
//   - Write to an EXISTING file under raw/ (overwrite)            -> DENY
//   - Write to a NEW path under raw/ (fresh capture / ingestion)  -> ALLOW
//
// Contract (Claude Code PreToolUse hook): reads JSON on stdin; target at tool_input.file_path;
// emits a JSON "deny" decision to block; exits 0 either way. No jq, no machine-specific path
// (vault root is derived from this script's own location).

const path = require('path');
const fs = require('fs');

let input = '';
process.stdin.on('data', (d) => (input += d));
process.stdin.on('end', () => {
  let data;
  try {
    data = JSON.parse(input);
  } catch {
    process.exit(0); // not parseable — let normal flow proceed
  }

  const tool = data && data.tool_name;
  const fp = data && data.tool_input && data.tool_input.file_path;
  if (!fp) process.exit(0);

  // Vault root = two levels up from .claude/hooks/. raw/ is directly under it.
  const rawDir = path.resolve(__dirname, '..', '..', 'raw');
  const resolved = path.resolve(fp);

  // Is `resolved` inside rawDir? (path.relative handles Windows drive/case semantics.)
  const rel = path.relative(rawDir, resolved);
  const insideRaw = rel === '' || (!rel.startsWith('..') && !path.isAbsolute(rel));
  if (!insideRaw) process.exit(0);

  // Allow creating a NEW file under raw/ (capture/ingestion). Block everything else.
  const isWrite = tool === 'Write';
  const exists = fs.existsSync(resolved);
  if (isWrite && !exists) process.exit(0); // fresh capture — allowed

  const verb = isWrite ? 'overwrite' : 'modify';
  process.stdout.write(
    JSON.stringify({
      hookSpecificOutput: {
        hookEventName: 'PreToolUse',
        permissionDecision: 'deny',
        permissionDecisionReason:
          `raw/ is the IMMUTABLE source of truth — you may not ${verb} an existing file under raw/ ` +
          '(CLAUDE.md Grounding Discipline). Creating a NEW file under raw/ is allowed (that is capture/ingestion). ' +
          'To change processed content, edit the wiki/research page derived from this source, not the source itself.',
      },
    })
  );
  process.exit(0);
});

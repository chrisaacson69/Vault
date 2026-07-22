#!/bin/bash
# Vault session-start hook — injects dynamic context into every session.
# Keeps output tight: ~200 tokens max.
# Demo mode: when .claude/demo-mode flag exists, triggers /context-brief on startup.
#
# RELOCATABLE — never hardcode a path here. The vault root is derived, in order:
#   1. $CLAUDE_PROJECT_DIR, which the SessionStart registration already provides.
#   2. this script's own location (.claude/hooks/ -> up two) if run directly.
# Same rule the JS hooks use (path.resolve(__dirname, '..', '..')). A hardcoded
# root is what silently broke this hook across the 2026-07 machine migration.

if [ -n "$CLAUDE_PROJECT_DIR" ]; then
  VAULT="$CLAUDE_PROJECT_DIR"
else
  VAULT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
fi

# Fail loudly rather than emitting a confidently-empty context block.
if [ ! -f "$VAULT/INDEX.md" ]; then
  echo "## Vault Session Context"
  echo ""
  echo "**Hook error:** derived vault root \`$VAULT\` has no INDEX.md — context skipped."
  exit 0
fi

# Check for demo mode
if [ -f "$VAULT/.claude/demo-mode" ]; then
  echo "## DEMO MODE ACTIVE"
  echo ""
  echo "**Cross-session memory demonstration is ON.** Run /context-brief now to display"
  echo "full knowledge sources for the observer. All responses will cite their sources."
  echo ""
  echo "To deactivate: \`rm \$CLAUDE_PROJECT_DIR/.claude/demo-mode\`"
  echo ""
fi

echo "## Vault Session Context"
echo ""

# Recent work — last 5 modified research/notes files
echo "### Recent Work"
find "$VAULT/research" "$VAULT/notes" -name "*.md" -mtime -7 -printf "%T@ %p\n" 2>/dev/null \
  | sort -rn | head -5 | while read ts path; do
    rel=${path#$VAULT/}
    echo "- $rel"
  done
echo ""

# Stubs count
STUBS=$(grep -c "(stub)" "$VAULT/INDEX.md" 2>/dev/null || echo 0)
echo "### Vault Health"
echo "- $STUBS stubs in INDEX.md"

# Tag count
TAGS=$(ls "$VAULT/tags/"*.md 2>/dev/null | grep -v _index | wc -l)
PAGES=$(find "$VAULT/research" "$VAULT/notes" -name "*.md" 2>/dev/null | wc -l)
echo "- $TAGS tags, $PAGES research/notes pages"
echo ""

# Active projects — recent activity in vault project READMEs.
# Status lives in YAML frontmatter (`status: active`), per CLAUDE.md conventions —
# NOT the old `**Status:**` body line, which is why this used to print bare names.
echo "### Active Projects"
find "$VAULT/projects" -name "README.md" -mtime -14 -printf "%T@ %p\n" 2>/dev/null \
  | sort -rn | head -5 | while read ts path; do
    dir=$(dirname "$path")
    name=$(basename "$dir")
    status=$(sed -n '1,10p' "$path" 2>/dev/null | grep -m1 '^status:' | sed 's/^status:[[:space:]]*//')
    echo "- $name${status:+ ($status)}"
  done
echo ""

# Available skills
echo "### Available Skills"
for skill_dir in "$VAULT/.claude/skills"/*/; do
  if [ -f "$skill_dir/SKILL.md" ]; then
    name=$(basename "$skill_dir")
    desc=$(grep "^description:" "$skill_dir/SKILL.md" | head -1 | sed 's/^description: //')
    echo "- /$name — ${desc:0:80}"
  fi
done
echo ""

# GitHub — derive the repo from THIS repo's origin remote. The previous version
# queried a hardcoded `chrisaacson69/codebase`, which has no GitHub remote at all,
# so this block silently returned nothing on every run.
if command -v gh &>/dev/null; then
  SLUG=$(git -C "$VAULT" remote get-url origin 2>/dev/null \
    | sed -E 's#^git@[^:]+:##; s#^https?://[^/]+/##; s#\.git$##')
  if [ -n "$SLUG" ]; then
    OPEN_PRS=$(gh pr list --repo "$SLUG" --state open --limit 3 \
      --json number,title --jq '.[] | "- PR #\(.number): \(.title)"' 2>/dev/null)
    if [ -n "$OPEN_PRS" ]; then
      echo "### GitHub ($SLUG)"
      echo "$OPEN_PRS"
    fi
  fi
fi

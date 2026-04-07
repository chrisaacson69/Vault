#!/bin/bash
# Vault session-start hook — injects dynamic context into every session.
# Keeps output tight: ~200 tokens max.

VAULT="C:/Users/Chris.Isaacson/Vault"

echo "## Vault Session Context"
echo ""

# Recent work — last 5 modified research/notes files
echo "### Recent Work"
find "$VAULT/research" "$VAULT/notes" -name "*.md" -mtime -7 -printf "%T@ %p\n" 2>/dev/null \
  | sort -rn | head -5 | while read ts path; do
    name=$(basename "$path" .md)
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

# Active projects — recent activity in vault project READMEs
echo "### Active Projects"
find "$VAULT/projects" -name "README.md" -mtime -14 -printf "%T@ %p\n" 2>/dev/null \
  | sort -rn | head -5 | while read ts path; do
    dir=$(dirname "$path")
    name=$(basename "$dir")
    status=$(grep -oP '(?<=\*\*Status:\*\* )\S+' "$path" 2>/dev/null | head -1)
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

# GitHub PR status
if command -v gh &>/dev/null; then
  echo "### GitHub (codebase)"
  OPEN_PRS=$(gh pr list --repo chrisaacson69/codebase --state open --json number,title --limit 3 2>/dev/null)
  if [ -n "$OPEN_PRS" ] && [ "$OPEN_PRS" != "[]" ]; then
    echo "$OPEN_PRS" | python3 -c "
import sys, json
prs = json.load(sys.stdin)
for pr in prs:
    print(f\"- PR #{pr['number']}: {pr['title']}\")
" 2>/dev/null
  else
    echo "- No open PRs"
  fi
fi

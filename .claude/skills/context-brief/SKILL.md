---
name: context-brief
description: Display everything Claude knows about the vault, the user, and recent activity — narrated explicitly so an observer can see the cross-session intelligence at work. Use when the user says "context brief", "what do you know", "show context", "explicit mode", or wants to demonstrate vault memory to an audience.
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash
---

## Context Brief — Explicit Knowledge Display

This skill makes Claude's cross-session intelligence visible. Instead of quietly using context, it narrates every source of knowledge so an observer can see the architecture working.

**Purpose:** Demo-friendly display of how the vault provides continuity across sessions without manual re-explanation.

### 1. Identity & User Context

Read all memory files from the memory directory:
```
C:\Users\Chris.Isaacson\.claude\projects\C--Users-Chris-Isaacson-Vault\memory\
```

For each memory file found:
- State its type (user, feedback, project, reference)
- Quote the key insight it provides
- Explain how it changes behavior ("Because of this, I will..." / "This means I know to...")

Format as:
```
## Who I'm Working With
**Source:** memory/user_*.md

<findings>

## How I've Been Asked to Work
**Source:** memory/feedback_*.md

<findings>
```

### 2. Vault Awareness

Read `INDEX.md` and report:
- Total page count and section breakdown
- Most recently updated sections
- Any sections with stubs or gaps

Read `CLAUDE.md` (first 50 lines) and summarize:
- What conventions are defined
- What folder purposes are listed

Format as:
```
## What I Know About This Vault
**Source:** INDEX.md, CLAUDE.md

- <N> pages across <M> sections
- Sections: <list with counts>
- Conventions: <key points>
```

### 3. Recent Activity (Cross-Session Detection)

Run these git commands:
```bash
git log --oneline -10 --format="%h %s (%ar)"
git diff --name-only HEAD~3..HEAD
git status --short
```

For each recent commit:
- State what changed and when
- If changes were made in a different session, explicitly say: "This was done in a previous session — I can see it because..."

Format as:
```
## Recent Activity (Cross-Session)
**Source:** git log, git diff

- <commit>: <what changed> — <time ago>
  → This tells me: <insight>
```

### 4. Active Projects & State

Read the startup hook output if available, or scan:
- `projects/` for active project READMEs
- `career/` for current career section state
- `tasks/active.md` for any tracked tasks

Format as:
```
## Active Work
**Source:** project READMEs, career section, tasks

- <project>: <status> — <what I know about it>
```

### 5. Session Handoff Signals

Check for any explicit session handoff signals:
- Recent memory files (modified in last 24 hours)
- Uncommitted changes (work in progress from another session)
- New files not yet in INDEX.md

Format as:
```
## What Changed Since Last Session
**Source:** file modification times, git status

- <signal>: <what it means>
```

### 6. Skills Available

List all skills in `.claude/skills/` with one-line descriptions:

```
## What I Can Do
**Source:** .claude/skills/

- /skill-name — description
```

### Output Format

Present the entire brief as a single flowing report. Use the `**Source:**` citations on every section so an observer can see exactly where each piece of knowledge comes from. 

End with:
```
---
*This brief was generated from persistent vault infrastructure — CLAUDE.md, memory files, 
git history, and the vault's cross-linked page structure. No manual re-explanation was needed. 
Each new session inherits this context automatically.*
```

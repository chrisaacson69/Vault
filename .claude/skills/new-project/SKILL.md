---
name: new-project
description: Scaffold a new vault project across all five registration artifacts in the correct order (local repo, GitHub remote, local-paths resolver entry, projects/ pointer page, INDEX.md line), or audit existing projects for partial registration. Use when the user says "new project", "start a project", "scaffold a project", "register this repo in the vault", "audit projects", "check project registration", or "which projects are missing a remote".
user-invocable: true
---

# new-project — create a project so it survives the second machine

A project is a **package**: an external repo, referenced by logical name, pointed at from the vault.
The architecture is in [`projects/CLAUDE.md`](../../../projects/CLAUDE.md) (the SDK) — this skill only
mechanizes it so registration can't come out partial.

## The failure this exists to prevent

**Partial registration.** A vault pointer page for a repo that has no remote and no resolver entry
describes a project that exists on exactly one machine: unbackupable, and invisible from every other
instance. Observed with `democracy3-solver` — page committed 2026-08-30 reading *"Remote: none yet
(local-only)"*, remote published only afterward, still no clone or resolver row on the second machine.
From that machine the project looked empty. It wasn't; it was a working solver.

**The remote is artifact #2, not a later chore.** Ordering is the whole point.

## Audit first (always cheap, no arguments)

```
py -3.14 .claude/skills/new-project/scripts/verify_projects.py            # full table
py -3.14 .claude/skills/new-project/scripts/verify_projects.py --quiet    # only problems
py -3.14 .claude/skills/new-project/scripts/verify_projects.py --network  # also check each remote resolves
py -3.14 .claude/skills/new-project/scripts/verify_projects.py --lint NAME # class-3 lint one clone
py -3.14 .claude/skills/new-project/scripts/verify_projects.py --suggest-resolver  # rows for found-but-unregistered clones
```

**"Not here" is not "missing."** Not every repo comes down on every machine. A clone absent from
this instance is a *defect* only when nothing backs it up — no remote means it exists nowhere,
which is how `elite-decompiler` was found with no `.git` at all. With a remote, the code is safe
and simply lives elsewhere; the audit reports that separately and does not count it against you.

Exit 0 = no registration defects; exit 1 = a real one. Note `py -3` may resolve to an old
interpreter — the script needs >= 3.9, but project code often needs newer; check `py -0p`.

**Where clones are looked for.** The resolver row first; then the directories listed under
`## Repo search roots` in `.claude/local-paths.md`. Those roots live in the gitignored resolver, not
in this script, because the script is tracked and the vault repo is public — a machine path here
would be the class-1 violation the skill exists to prevent. Directory names are matched
case- and punctuation-insensitively (`batch-resize` finds `batch_resize`), but never by abbreviation:
`battletech-simulator` will not match `battletech-sim`. Real name drift needs a real resolver row.

## Creating a project — five artifacts, this order

1. **Local repo** at `../<name>` (sibling of the vault). `git init`; write `CLAUDE.md` (app-local rules,
   referencing the kernel + the SDK), `.gitignore`, `README.md`; first commit.
2. **GitHub remote — immediately.** Default **public**, matching every existing repo. Creating a repo is
   outward-facing and hard to undo, so *confirm with Chris before running it*:
   `gh repo create <name> --public --source=. --remote=origin --push`

   > **This step is gated by the harness, not by prose.** `~/.claude/settings.json` carries an `ask`
   > rule on `gh repo create` / `delete` / `edit` (both shells), and `ask` overrides `allow`, so the
   > command prompts however it is reached. That is why this skill is model-invocable again: the gate
   > moved from *who may start the skill* to *what the dangerous step may do*, which also covers
   > running `gh` directly — the path the old `disable-model-invocation` flag never protected.
   > Before publishing, check the repo's `.gitignore` **and its history** (`git log --all --name-only`):
   > an ignore rule protects the working tree, not what was already committed.
   If the work is sourced from an employer or private codebase, use `--private` — and see the vault
   `CLAUDE.md` warning about `raw/` and identifiers.
3. **Resolver entry** — add a row to `.claude/local-paths.md` (gitignored, per-machine):
   ```
   | `<name>` | `<abs local path>` | `chrisaacson69/<name>` *(public)* | `README.md`, then ... |
   ```
4. **Vault pointer page** — `projects/<name>/README.md`: frontmatter (`status`, `created`), one-line
   summary, then logical name + `../<name>` sibling path + GitHub URL + stack, `**Links:**`, and a
   `## Tags` section. **Pointer only** — no project content (see the SDK's three-way split).
5. **INDEX.md** — register it. Run `/vault-sync`.

Then re-run the audit. If it doesn't come back clean, the project is not created yet.

## The three pointer classes — do not collapse them

| Class | Where | Tracked? | Form |
|---|---|---|---|
| vault → project | vault pages | **yes** (public) | logical name + GitHub URL + `../<name>`; **never an absolute path** |
| machine resolver | `.claude/local-paths.md` | **no** (gitignored) | absolute path, per-instance |
| inside the project | the project repo | **yes** | **relative** — a fresh clone must be self-contained |

Class 3 is the one that silently rots: a tracked script with `Path.home() / "OneDrive/..."` runs on the
author's machine and nowhere else. `--lint` finds these. Machine-specific values belong in a gitignored
`config.toml` with a committed `config.example.toml` beside it. Test fixtures belong **in** the repo,
referenced relatively — that is what makes a clone runnable.

## Composes with

`/vault-sync` (step 5, and after any page edit) · `/vault-heartbeat` (run the audit as part of a health
check) · `projects/CLAUDE.md` (the SDK this mechanizes).

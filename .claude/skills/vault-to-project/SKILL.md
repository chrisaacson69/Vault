---
name: vault-to-project
description: Transfer vault research into a project's CLAUDE.md so the project has the theory, frameworks, and findings it needs without redoing analysis. Use when the user says "sync vault to project", "transfer vault research to [project]", "update project context from vault", or wants to connect vault ideas to implementation.
user-invocable: true
allowed-tools: Read, Edit, Write, Glob, Grep, Agent
---

## Vault-to-Project Transfer Procedure

The vault lives at `C:\Users\Chris.Isaacson\Vault`. Projects live under `C:\Users\Chris.Isaacson\source\repos\`.

The rule: **cross-link, don't duplicate.** The vault is the source of truth. Projects get summaries + pointers, not full copies.

### 1. Identify the Target Project and Relevant Research

Ask the user (if not already specified):
- Which project? (repo name or path)
- Which vault research? (specific pages, tags, or topic areas)

Read the project's existing CLAUDE.md to understand what's already there.

### 2. Read the Vault Research

Read each relevant vault page. For each, extract:
- **Core thesis** — 1-2 sentence summary
- **Key frameworks** — named concepts, formulas, decision rules
- **Empirical findings** — numbers, thresholds, validated results
- **Architectural insights** — patterns that should shape implementation
- **Open questions** — unresolved issues that may affect the project

### 3. Build the Theory→Implementation Map

For each vault concept that maps to project code:
- Identify the target module/file/component
- Write a concise mapping: what the vault says → how the project should use it
- Include any scoring functions, algorithms, or decision criteria in pseudocode

### 4. Update the Project's CLAUDE.md

Follow the established convention:

**If the project has no CLAUDE.md yet**, create one with this structure:
```markdown
# Project Name

**Vault:** `C:\Users\Chris.Isaacson\Vault\projects\<project-slug>\README.md`

## Overview
One-line description.

## Vault Research Context
### [Framework/Topic Name]
**Source:** [Page Title](vault-path) — one-line summary
**Key insight:** What matters for this project
**Maps to:** `module/file.ext` — how it's used in code

## Project Structure
(file tree if useful)

## How to Run
(setup/execution commands)
```

**If the project already has a CLAUDE.md**, update it:
- Add or update the `## Vault Research Context` section
- Preserve all existing content — don't overwrite project-specific docs
- Add new vault references alongside existing ones
- Update any stale references if vault pages have changed

### 5. Update the Vault Side

Ensure bidirectional linking:
- Check that the vault project README (`Vault/projects/<slug>/README.md`) exists
- If it references code modules, verify those references are current
- Add any new cross-links from vault research pages back to the project

### 6. Report What Changed

Summarize for the user:
- Which vault pages were consulted
- What was added/updated in the project's CLAUDE.md
- Any vault pages that need updating based on what the project has learned
- Any gaps — vault research that's missing but would help the project

### Guidelines

- **Summaries, not copies.** A vault-to-project entry should be 3-5 lines max per concept. The full argument lives in the vault.
- **Always link back.** Every summary must include a path to its vault source page.
- **Preserve voice.** Match the existing CLAUDE.md style of the project.
- **Flag staleness.** If vault research has evolved since the project's last sync, note what changed.
- **Implementation over theory.** Focus on what the project *needs to build with*, not the full intellectual journey.

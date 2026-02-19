# Vault — Personal Knowledge & Project System

This is Chris's personal vault for tracking projects, research, notes, tasks, goals, and logs.

## System Design

This vault uses a folder structure with **cross-linking** to function as a knowledge network rather than a strict hierarchy. Every file can link to any other file using relative markdown links.

### Conventions

- **Links between files**: Use relative markdown links, e.g. `[Project Name](./projects/my-project.md)`
- **Tags**: Each file may include a `## Tags` section at the bottom listing relevant tags as links to tag index files, e.g. `[python](./tags/python.md)`. Tag files in `/tags/` collect reverse-links to everything with that tag.
- **Front matter**: Files begin with a heading and a brief summary line, then optionally a metadata block:
  ```
  # Title
  > One-line summary

  **Status:** active | paused | completed | archived
  **Created:** YYYY-MM-DD
  **Links:** [related item](./path/to/file.md), [another](./path/to/other.md)
  ```

### Folder Purposes

| Folder       | What goes here                                      |
|-------------|-----------------------------------------------------|
| `projects/` | Active and past projects (code, personal, creative) |
| `research/` | Topics being explored, learning notes, references   |
| `notes/`    | Quick captures, ideas, standalone thoughts          |
| `tasks/`    | Goals, to-do tracking, milestones                   |
| `logs/`     | Session logs, journals, progress entries            |
| `tags/`     | Auto-maintained tag index files for cross-referencing|

### How Claude Should Work With This Vault

1. **Always check INDEX.md first** when looking for existing content — it's the master map.
2. **Cross-link aggressively** — when creating or updating a file, link it to related files and update their link sections too.
3. **Maintain tag indexes** — when tagging a file, ensure the corresponding tag file in `/tags/` has a back-link.
4. **Keep INDEX.md current** — add new files to the index when they're created.
5. **Prefer updating over duplicating** — search for existing notes on a topic before creating new ones.
6. **Use consistent formatting** — follow the front matter and conventions above.
7. **Log sessions when significant** — if a conversation covers substantial ground, offer to create a log entry.

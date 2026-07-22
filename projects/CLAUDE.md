# `projects/` — the project SDK (how to do a project)

This partition is the OS **process table**: pointer pages to the running apps (external repos), plus the
rules for building/running one. The knowledge partition (`research/`) is for *hypotheses*; this partition
is for *execution*. The lessons about **how to work with AI on a project** live here — they're the SDK,
not abstract knowledge. (Loads when working under `projects/`; from a vault-root session, read it when you
start project work. The cross-boundary essentials are already in the user-global kernel.)

## Projects are a package library with dependencies

A project is a **package**: a self-contained external repo with declared dependencies on other packages.
Nesting is a dependency tree, not folders:

```
projects/ → game-annotation → nes → koei → <game>      (taxonomy of apps)
            game-annotation  depends on  koei-nes (shared engine lib)  depends on  nes-render (generic PPU)
            <game repo>      depends on  koei-nes, nes-render
```

- **Global pointers (logical names):** the committed vault page refers to each repo by *logical name +
  GitHub URL* and the relative sibling convention `../<name>` — portable identity, never an absolute path.
- **Local resolution (per-machine):** the absolute mount is resolved via gitignored `.claude/local-paths.md`
  (the OS "device manager"). Missing entry → ask, don't guess. *This is the nested-repo solution — same as a
  package manager: logical deps in the manifest, resolved to local mounts.*
- **Shared libs are real dependencies, factored out the moment a second app needs them** (the `nes-render`
  PPU core graduated out of NA1 when Mappy needed it; `koei-nes` is the shared KOEI engine layer). Reuse >
  rebuild; a shared lib has exactly one home and everything points at it.

## The SDK — rules for running a project

(Universal rules — grounding, verification-independence, classify-before-method — are kernel; see user-global
`~/.claude/CLAUDE.md`. These are the *project-execution* additions. Provenance + the full lesson set: memory
`area_re_method` and `area_vault_system`.)

- **Classify the problem before the method.** The architecture dictates the approach before any code is read
  (e.g. ROM RE: turn-based = walkable call tree vs real-time = data-driven dispatch). [[feedback_architecture_first_re]]
- **RE is multi-pass compilation, backwards:** scan → symbol-table → link → typecheck. A `.toml`/registry IS
  the symbol table; everything downstream points at it. Pipelines: `/label-walk`, `/data-walk`, `/var-walk`.
- **Reuse/convert > rebuild; one source of truth.** Drift = re-derivation; the cure is point-to-artifact
  (eviction + registration are the twin janitors). Transpile weak formal languages to a grounded one to verify.
- **Single writer + verifier; coordinator holds context** and injects a curated working-set to subagents.
  Mechanical work → a deterministic generator; genuinely-unknown reads → fan out agents (throttle in waves).
- **Label as you go is a GOAL, not cleanup** — name every address/table/var back into the registry before
  session end. Scope sessions to ONE task; registries make breaking cheap.
- **Findings flow BACK to the vault.** A confirmed result or reusable pattern is *harvested* up: a topic memory
  + its area index, or a `research/` page (the thesis), with the project as its dated specimen. Don't let
  knowledge die in the app repo. (Flow ops: spawn ↓ / harvest ↑ / crystallize ↑, each registering its link.)

## Adding / pointing to a project

A `projects/<name>.md` (or subfolder) page is the **pointer** (logical name + GitHub URL + `../sibling` +
one-line status). The repo itself carries its own `CLAUDE.md`/`CONTEXT.md` (its app-local rules) and should
reference this SDK + the kernel. Register new projects in `INDEX.md` (run `/vault-sync`).

### Where project content goes — the three-way split (decided 2026-07-20)

Project work generates three kinds of text, and each has exactly **one** home. Sending any of them to
`INDEX.md` is the failure mode, because the index is a **router**, not a store.

| Kind of content | Test | Home |
|---|---|---|
| **ROM/app specifics** — addresses, table layouts, per-chapter walkthroughs, formulas | *Only meaningful for this title* | **The repo** (`docs/`, `CONTEXT.md`, `ROADMAP.md`) |
| **Theses it sparked** — findings that hold beyond this title | *Would a reader of another game care?* | **`research/`**, with the project as a dated specimen |
| **Identity + status** — logical name, URL, sibling path, one-line state | *How do I find the thing?* | **The `projects/` pointer page**, and one line in `INDEX.md` |

**Chris's rule:** *"promote it to research and let the project entries just be pointers."* If content is
**just about the game**, it belongs in the repo; if it **applies more broadly**, it is research. The
pointer page never becomes a third store.

**The diagnostic that catches a violation** (found live on the NA1 entry, 2026-07-20): an INDEX entry
had grown to **6,743 bytes — four times the size of the page it pointed to** — and had gone *stale*,
listing 12 chapters while the repo had reached 17. Two smells, either of which means the router is
being used as a store:

- the **index entry is longer than its target page**, or
- the **index entry lags the canonical store**.

**Fix by eviction, not by trimming.** Before deleting anything, confirm the content exists in its
proper home (resolve the repo via `.claude/local-paths.md` and *look*), confirm the generalisable
findings were already promoted to `research/`, then replace the entry with a one-line pointer.
Trimming without that check destroys the only copy — which is exactly what a blind sweep would have
done here. *Promotion without eviction* is what created the drift in the first place.

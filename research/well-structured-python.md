---
status: active
created: 2026-10-21
published: true
layout: layouts/page.njk
title: "Well-Structured Python at Scale"
---
# Well-Structured Python at Scale
> Python programs stay small and single-purpose not because the language is a "scripting language" but because nothing in it *enforces* structure. Large, well-structured Python is Python **plus a constitution plus checkers** — the structure is imposed by convention and tooling, and the industry has converged on what both look like.

**Links:** [Practicality vs. Precision — Principled LLM Code](./principled-llm-code.md) — the general thesis (accretion → big ball of mud; persistence is the fix); this page is its Python instance, [Repairing LLM Code — The Two Oracles](./repairing-llm-code.md), [Conservation of Complexity](../notes/conservation-of-complexity.md), [Camelot From YouTube](../projects/camelot-from-youtube/README.md) — first specimen, [dj-score](../projects/dj-score/README.md) — the specimen's target library, [CyborgDJ](../projects/cyborgdj/README.md), [emu-harness](../projects/game-annotation/emu-harness/README.md) — a plug-in shaped tool (backends × machines)

## 1. Limits → causes → remedies

**The limit is not the language.** Instagram's server is "a several-million-line Python monolith" ([Meyer, *Strict Modules*, 2019](https://instagram-engineering.com/python-at-scale-strict-modules-c0bb9245c834)); Kraken's Django monolith is 27,637 modules worked on by ~400 developers ([Seddon, EuroPython blog, 2023](https://blog.europython.eu/kraken-technologies-how-we-organize-our-very-large-pythonmonolith/)); Dropbox typed "over 4 million lines" ([Lehtosalo, 2019](https://dropbox.tech/application/our-journey-to-type-checking-4-million-lines-of-python)).

**The cause is the absent enforcement.** No compiler checks types; every module is importable from everywhere; nothing is private; a file can grow without limit. A 50-line script and a 2M-line system are written identically — so the default trajectory is Foote & Yoder's *Big Ball of Mud* (PLoP 1997; *PLoPD4*, 2000 — [laputan.org/mud](https://www.laputan.org/mud/)). Cosmic Python's framing: *"A big ball of mud is the natural state of software."* The symptom is "sameness of function" — UI handlers doing domain logic, logic classes doing I/O.

**The remedy is to supply what the language omits** — each row below replaces a missing language feature with a convention + a checker:

| Missing from the language | Supplied by | Checker |
|---|---|---|
| a package boundary | one installable package, `src` layout, `pyproject.toml` ([PEP 621](https://peps.python.org/pep-0621/)) | the install itself |
| a compiler / type system | type hints + `@dataclass` instead of dicts | mypy / pyright in CI |
| interfaces | `typing.Protocol` ports ([PEP 544](https://peps.python.org/pep-0544/)) — structural, no inheritance | the type checker |
| visibility / layering | dependency direction (domain ← services ← adapters/entrypoints) | **import-linter**, **tach** |
| an extension mechanism | registry + plugins; entry points ([PyPA spec](https://packaging.python.org/en/latest/specifications/entry-points/)) | the loader |
| a spec | the test suite (fakes, not mocks) | pytest |

## 2. What it looks like

```
myapp/
  pyproject.toml        # metadata, deps, tool config — one place
  src/myapp/            # src layout: tests can't import the working copy by accident
    __init__.py         # the PUBLIC API — re-export what callers may use
    domain/             # pure logic: dataclasses, rules, no I/O
    services/           # use cases: one function per user action, orchestrates domain via ports
    adapters/           # the outside world: files, DB, HTTP, audio, emulators
    entrypoints/        # CLI / GUI / web — thin: parse input, call a service
    bootstrap.py        # composition root — the ONE place concrete adapters get wired in
    config.py           # env-derived values, read via functions; only bootstrap imports it
  tests/unit/  tests/integration/  tests/e2e/
```

This matches Cosmic Python's [template](https://www.cosmicpython.com/book/appendix_project_structure.html) (`domain` / `service_layer` / `adapters` / `entrypoints`) with `bootstrap.py` from [ch. 13](https://www.cosmicpython.com/book/chapter_13_dependency_injection.html). Why `src/`: the current directory is first on `sys.path`, so a flat layout silently imports the dev copy and hides packaging mistakes ([Packaging Guide](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/)).

**The one rule that matters most: dependencies point inward.** `domain` imports nothing from the outer layers. Circular imports are usually a *symptom* of violating this — a boundary bug, not something to patch with a function-local import.

## 3. Cosmic Python, distilled — and when *not* to

*Architecture Patterns with Python* (Percival & Gregory, 2020; [free online](https://www.cosmicpython.com/book/preface.html)). Thesis: dependency inversion — business logic and infrastructure depend on abstractions, so each can change independently; Flask/SQLAlchemy become "minor implementation details." **The book is unusually honest about cost** — every chapter ends in a pros/cons table, and the repeated warning is *simple CRUD doesn't need this*.

| Pattern | Solves | Skip it when |
|---|---|---|
| Domain model | rules scattered and unreadable | logic is trivial |
| Functional core, imperative shell ([ch. 3](https://www.cosmicpython.com/book/chapter_03_abstractions.html)) | I/O tangled with decisions; mock.patch tests | — (always cheap) |
| Service layer ([ch. 4](https://www.cosmicpython.com/book/chapter_04_service_layer.html)) | no single home for use cases; HTTP/UI holding logic | controllers can hold it ("fat models, thin controllers") |
| Repository / Unit of Work | storage coupled to logic; transaction boundaries implicit | the ORM already abstracts it; no persistence to speak of |
| Aggregate | invariants across many objects; concurrency | single-user, no shared state |
| Events + message bus ([ch. 8–9](https://www.cosmicpython.com/book/chapter_08_events_and_message_bus.html)) | side-effect "goop" (email, logging) wedged into features | flow becomes implicit and hard to trace |
| CQRS ([ch. 12](https://www.cosmicpython.com/book/chapter_12_cqrs.html)) | reads and writes with different needs | reads and writes share concepts |
| DI via `bootstrap.py` | hidden dependencies, import-time globals | — frameworks only pay off with deep dependency chains |

Heuristics worth keeping: a function whose description needs "and" or "then" has two responsibilities; "*when* X, *then* Y" phrasing is an event. *"Make the change easy; then make the easy change."* Fakes over mocks — **if an abstraction is hard to fake, it is too complicated.** Every line of test code is coupling.

## 4. Getting there from an existing mess

From the [epilogue](https://www.cosmicpython.com/book/epilogue_1_how_to_get_there_from_here.html) — the part that matters for a pile of one-off tools:

1. **Start from the problem, not the pattern** — hard to change? slow? buggy? Pay it as an "architecture tax" on feature work.
2. **List the use cases** (every UI action, every CLI command), give each an imperative name, and give each **a single home** in a service layer. Prefer duplication over use cases calling use cases.
3. **Move I/O out of the core** into those use cases (functional core, imperative shell). Get legacy code under test first (Feathers).
4. **Extract by copy → repoint → delete** — never edit in place across a boundary.
5. **Small steps, no ocean-boiling** — pick a specific problem, take local wins, move on if it's too hard (advice credited in the epilogue to David Seddon — same name as import-linter's author; not checked that the book means the same person).
6. Appendix C is the proof of payoff: once the service layer existed, adding a new CSV-driven CLI reused domain and service code *unchanged*.

## 5. Exemplars (grounded 2026-10-21)

- **Kraken / import-linter** — layers `clients → territories → core`, 40+ contracts, 15 ignored imports left ([blog](https://blog.europython.eu/kraken-technologies-how-we-organize-our-very-large-pythonmonolith/)). Contract types: forbidden, protected, layers, independence, acyclic-siblings, custom ([docs](https://import-linter.readthedocs.io/en/stable/)). **This is a machine-checked architecture constitution** — the mechanism of [Principled LLM Code](./principled-llm-code.md) in shipping form.
- **tach** — Rust-backed boundary enforcer for "modular monoliths": declared deps only, public interfaces only, no cycles ([repo](https://github.com/gauge-sh/tach)).
- **Dropbox / mypy** — gradual typing: ~420k lines annotated by end-2016, ~4M in about three years; Guido van Rossum was on the 3-person mypy team ([post](https://dropbox.tech/application/our-journey-to-type-checking-4-million-lines-of-python)).
- **Instagram** — LibCST is "the heart of many of our internal linting and automated refactoring tools" ([Woodruff, 2019](https://instagram-engineering.com/static-analysis-at-scale-an-instagram-story-8f498ab71a0c)); *strict modules* forbid import-time side effects. *(Quotes via search snippets — the blog was unreachable; re-check before quoting verbatim.)*
- **Home Assistant** — each integration is a package `components/<domain>/` with required `manifest.json` + `__init__.py`; platforms (`sensor.py`, `light.py`) loaded by name ([file structure](https://contributors.home-assistant.io/core/integrations/file-structure/)). ~1,548 component folders on `dev` (our count via the GitHub API, not an official figure).
- **pytest / pluggy** — pluggy is "the crystallized core of plugin management and hook calling for pytest" ([docs](https://pluggy.readthedocs.io/en/stable/)).
- **Zulip** — "essentially the entire codebase" type-annotated, mypy + django-stubs in CI, `Any`/`cast`/bare ignores discouraged ([docs](https://zulip.readthedocs.io/en/latest/testing/mypy.html)).

## 6. Anti-patterns (the smells of accretion)

- `utils.py` / `helpers.py` as a dumping ground — the one-use-tool pile hidden in a single file.
- God files and "Manager" classes; deep Java-style inheritance where a Protocol and a function would do.
- Dicts threaded through five layers — nobody knows the shape, so nobody can refactor it.
- Config, globals, sessions created at import time — import order becomes behavior.
- Near-duplicate modules with swapped names (`detect_events` / `event_detect`) — re-derivation drift ([Principled LLM Code §3](./principled-llm-code.md)).

## 7. Specimens

- **[Camelot From YouTube](../projects/camelot-from-youtube/README.md)** (first attempt; snapshot 2026-10-21) — began as CLI key-detection tools; extracting functionality made a GUI possible, "going in the right direction" but never felt well structured. Surface read: 24 top-level `.py` files (~14.3k lines), flat layout, no `pyproject`, no `tests/`; two files hold ~42% of the code (`audio_ui.py` 3,449, `camelot_from_youtube.py` 2,585); name-twins `detect_events.py` / `event_detect.py` / `detect_stem_events.py` and three `visualize_*` modules. **Target shape (Chris, 2026-10-21):** CLI tools are fine — *but they must share one library*; many of the tools are variations on one theme, and some are likely obsolete, superseded by better methods found later. So the audit sorts tools into *keep as thin entrypoint* / *fold into library* / *retire*. Note it is an *analysis pipeline*, not a transactional app — repository/UoW/aggregates/CQRS are likely overkill; layering, functional core, service layer, `bootstrap.py`, and fakes are the applicable subset.
  **Audit done (2026-10-21):** the variations-on-a-theme are measurable — `detect_bpm_and_beats` byte-identical in three files, six separate `beat_track` call sites, the downbeat scorers copied into two files, three readers of one undocumented cache schema, three generations of the event detector; matplotlib imported at module level by the analysis code. Outcome: the library is a **new repo, [dj-score](../projects/dj-score/README.md)**, and camelot stays the UI (an app that depends on it, as CyborgDJ will). Verdicts per tool + the copy → repoint → delete order live in the repo's `MIGRATION.md` (single source). Constitution from day one: one import-linter `layers` contract + one `forbidden` contract (core never imports matplotlib/tk/pygame/torch/pyrekordbox/IO), each checked to actually fire on a planted violation. This partly answers the first two Open Questions; whether it stops accretion across sessions is now testable.
- **The decompiler family** (candidate next specimen; Chris, 2026-10-21) — "several independent but highly correlated tools": the per-game KOEI repos (`na1`, `ro3k`, `gk`, `na2`, `rot3k2`, `bk`, `GemFire`, `LEmp`), the SNES line, `game-annotation`. A shared layer already exists in part — `koei-nes` (engine/VM toolchain) and `nes-render` (PPU) graduated out per the projects SDK — so the audit question differs from camelot's: not "extract a library" but "what is still re-derived per game repo that should live in the shared layer, and which per-game tools are variations on a theme". Same method: imports + use cases per tool, measured duplication across repos, keep / fold / retire, one constitution.
- **Infinite Lagrange tooling** — another "collection of one-off tools instead of a shared environment" (Chris, 2026-10-21). Not on this machine and not yet registered in the vault.
- **Counter-specimen:** the libraries these projects *consume* (librosa, pytest, …) are structured well because they are designed as plug-ins for other people's code — the external consumer is the enforcement.

## Open Questions

- What is the minimum constitution for a solo/LLM-assisted repo — `pyproject` + mypy + one import-linter `layers` contract? Is that enough to stop accretion across sessions?
- Can an import-linter/tach contract serve as the "persistent spec" an LLM refactors *toward* (the open question on [Principled LLM Code](./principled-llm-code.md))? Camelot is the test.
- For pipeline-shaped tools (audio analysis, ROM RE tooling), what replaces the repository/UoW layer — is the "domain" the pure analysis functions and the "adapters" the file/audio/emulator I/O?
- Should shared tooling across sibling repos (the Infinite Lagrange tools, the DJ suite) become one installable package with plug-ins, per the [projects SDK](../projects/CLAUDE.md) "shared libs are real dependencies" rule?

## Tags

[python](../tags/python.md), [software-engineering](../tags/software-engineering.md)

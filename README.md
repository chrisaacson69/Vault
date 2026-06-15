# Vault

A personal knowledge system for tracking projects, research, notes, and tasks — organized as a cross-linked markdown network.

## What This Is

This vault is a flat-file knowledge base. Every document is a markdown file. Documents link to each other with relative paths, forming a navigable graph rather than a rigid hierarchy. A tag system provides cross-cutting views across topics.

The [INDEX](./INDEX.md) is the master map — start there.

## Structure

| Folder | Purpose |
|--------|---------|
| `projects/` | Code projects — active, completed, and archived (code lives in separate repos; pages link to them) |
| `research/` | Topics being explored: philosophy, economics, AI/computation, gaming & game theory |
| `career/` | AI/career lessons learned — roles, strategy, what works and what doesn't |
| `method/` | Playbooks for running hard, agent-driven projects without drifting |
| `notes/` | Standalone ideas, observations, sketches, and personal writing |
| `tasks/` | Goals and to-do tracking |
| `raw/` | Unprocessed source material for ingestion (transcripts, articles, PDFs) |
| `tags/` | Tag index files with back-links for cross-referencing |

## Conventions

- **Front matter**: YAML for queryable metadata (`status: active | paused | completed | archived`, `created: YYYY-MM-DD`), followed by a `# Title`, a `> one-line summary`, and a `**Links:**` line of related pages.
- **Cross-links**: relative markdown paths, e.g. `[Topic](./research/gaming/README.md)` — clickable and graph-visible.
- **Tags**: a `## Tags` section at the bottom links to index files in `/tags/`, which collect reverse-links to everything with that tag.
- **Keep pages lean**: overview/README pages stay ~60–80 lines of summaries and pointers; full arguments and detail go in sub-pages. Point, don't dump.

See [`CLAUDE.md`](./CLAUDE.md) for the full working conventions (raw-ingestion workflow, Marp slide decks, how the AI assistant maintains the vault).

## Projects

Code lives in separate repos. Each vault project page links to its GitHub repo via a `**Repo:**` field.

| Project | Description | Repo |
|---------|-------------|------|
| [Game Annotation (NA1 + more)](./projects/game-annotation/README.md) | Documenting classic game source at the system level; flagship is the Nobunaga's Ambition (NES) bytecode-VM decompiler | [na1-decompiler](https://github.com/chrisaacson69/na1-decompiler) *(private)* |
| [Camelot From YouTube](./projects/camelot-from-youtube/README.md) | DJ track analysis — BPM, key, events, Rekordbox export | [camelot_from_youtube](https://github.com/chrisaacson69/camelot_from_youtube) |
| [CyborgDJ](./projects/cyborgdj/README.md) | Programmatic DJ mixing engine — JSON spec in, mixed audio out | [cyborgdj](https://github.com/chrisaacson69/cyborgdj) |
| [Monopoly](./projects/monopoly/README.md) | Monopoly AI — Markov chains, EPT valuation, strategic trading | [monopoly](https://github.com/chrisaacson69/monopoly) |
| [Slay](./projects/slay/README.md) | Hex strategy game with alpha-beta AI (Python) | [slay](https://github.com/chrisaacson69/slay) |
| [Slay-C](./projects/slay-c/README.md) | C port of Slay for performance and deep search | [slay-c](https://github.com/chrisaacson69/slay-c) |
| [YouTube Migration](./projects/youtube-migration/README.md) | Episode scripts, Manim scenes, shared animation tooling | [youtube-migration](https://github.com/chrisaacson69/youtube-migration) |
| [MOO1 Opening Optimizer](./projects/moo1-opening-optimizer/README.md) | Master of Orion 1 opening-theory economic simulator | [moo1-opening-optimizer](https://github.com/chrisaacson69/moo1-opening-optimizer) |
| [BattleTech Simulator](./projects/battletech-simulator/README.md) | Monte Carlo combat sim to derive empirical BattleValue | [battletech-sim](https://github.com/chrisaacson69/battletech-sim) |
| [pygone](./projects/pygone/README.md) | A 4 KB chess engine torn down — the inverse of the decompiler work | [pygone](https://github.com/chrisaacson69/pygone) *(private)* |
| [Triangular Arbitrage](./projects/triangular-arbitrage/README.md) | Currency/crypto arbitrage detection | [triangular-arbitrage](https://github.com/chrisaacson69/triangular-arbitrage) |
| [Order Playlist](./projects/order-playlist/README.md) | DJ playlist optimizer using Camelot harmonic mixing | [order-playlist](https://github.com/chrisaacson69/order-playlist) |
| [Batch Resize](./projects/batch-resize/README.md) | CLI image batch resizer | [batch-resize](https://github.com/chrisaacson69/batch-resize) |
| [PyTorch Learning](./projects/pytorch-learning/README.md) | PyTorch fundamentals tutorial series | [pytorch-learning](https://github.com/chrisaacson69/pytorch-learning) |
| [PyTorch Audio Learning](./projects/pytorch-audio-learning/README.md) | TorchAudio tutorial series | [pytorch-audio-learning](https://github.com/chrisaacson69/pytorch-audio-learning) |

Vault-only project pages (concept/planning, no separate repo): [DJ Set 1](./projects/dj-set-1/README.md), [Set Mastering](./projects/set-mastering/README.md), [OOP Neurons](./projects/oop-neurons/README.md), [New Cycle](./projects/new-cycle/README.md). See the [INDEX](./INDEX.md) for the complete list.

## Research

The bulk of the vault. Major clusters (full detail in the [INDEX](./INDEX.md)):

- [Philosophy](./research/philosophy/README.md) — morality, logic & math, epistemology, legal theory, metaphysics, civilizational dynamics; the [Four Trunks](./research/philosophy/the-four-trunks.md) organize it
- [Economics](./research/economics/README.md) — value, profit, risk, business cycles, the accounting-identities-aren't-models series
- [Gaming & Game Theory](./research/gaming/README.md) — games as laboratories for systems thinking: [MIRR 4X framework](./research/gaming/mirr-4x-framework.md), [BattleValue](./research/gaming/battle-value.md), [randomness as termination (N≥3)](./research/gaming/n3-termination-and-randomization.md), [the dominance-frontier lens](./research/dominance-frontier-lens.md)
- AI & Computation — [the Cyborg Model](./research/cyborg-model.md), [the LLM Grounding Problem](./research/llm-grounding-problem.md), [planner-LM composites](./research/planner-lm-composites.md), [energy-based models](./research/energy-based-models.md), [transpilation as grounding](./research/transpilation-as-grounding.md)
- [Online Debates](./research/debates/README.md) — extracting signal from "bloodsports" debate spectacle

## Method

[Method — a library of good procedure](./method/README.md): how to run hard, agent-driven projects without drifting — the [Anchor Method](./method/anchor-method.md), the [Specimen & Thesis two-altitude ledger](./method/specimen-and-thesis.md), and [Author Web, Derive Hierarchy](./method/author-web-derive-hierarchy.md).

## Tools

This vault is maintained collaboratively with [Claude Code](https://claude.com/claude-code). The root [`CLAUDE.md`](./CLAUDE.md) provides conventions and instructions for the AI assistant. The public site is built with [Eleventy](https://www.11ty.dev/) and auto-deploys to [GitHub Pages](https://chrisaacson69.github.io/Vault/) on every push to `master`.

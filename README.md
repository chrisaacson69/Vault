# Vault

A personal knowledge system for tracking projects, research, notes, and tasks — organized as a cross-linked markdown network.

## What This Is

This vault is a flat-file knowledge base. Every document is a markdown file. Documents link to each other with relative paths, forming a navigable graph rather than a rigid hierarchy. A tag system provides cross-cutting views across topics.

The [INDEX](./INDEX.md) is the master map — start there.

## Structure

| Folder | Purpose |
|--------|---------|
| `projects/` | Code projects — active, completed, and archived |
| `research/` | Topics being explored: economics, philosophy, AI, crypto |
| `notes/` | Standalone ideas, observations, and personal writing |
| `tasks/` | Goals and to-do tracking |
| `logs/` | Session journals and progress entries |
| `tags/` | Tag index files with back-links for cross-referencing |

## Conventions

- Files start with a `# Title`, a `> one-line summary`, and optional metadata (`Status`, `Created`, `Links`)
- Cross-links use relative markdown paths: `[Topic](./research/topic.md)`
- Tags are listed at the bottom of files and point to index files in `/tags/`
- Tag files collect reverse-links to everything with that tag

## Projects

Code lives in separate repos. Each vault project page links to its GitHub repo via a `**Repo:**` field.

| Project | Description | Repo |
|---------|-------------|------|
| [Camelot From YouTube](./projects/camelot-from-youtube/README.md) | DJ track analysis — BPM, key, events, Rekordbox export | [camelot_from_youtube](https://github.com/chrisaacson69/camelot_from_youtube) |
| [Monopoly](./projects/monopoly/README.md) | Monopoly AI — Markov chains, EPT valuation, strategic trading | [monopoly](https://github.com/chrisaacson69/monopoly) |
| [Slay](./projects/slay/README.md) | Hex strategy game with alpha-beta AI (Python) | [slay](https://github.com/chrisaacson69/slay) |
| [Slay-C](./projects/slay-c/README.md) | C port of Slay for performance and deep search | [slay-c](https://github.com/chrisaacson69/slay-c) |
| [Triangular Arbitrage](./projects/triangular-arbitrage/README.md) | Currency/crypto arbitrage detection | [triangular-arbitrage](https://github.com/chrisaacson69/triangular-arbitrage) |
| [Order Playlist](./projects/order-playlist/README.md) | DJ playlist optimizer using Camelot harmonic mixing | [order-playlist](https://github.com/chrisaacson69/order-playlist) |
| [Batch Resize](./projects/batch-resize/README.md) | CLI image batch resizer | [batch-resize](https://github.com/chrisaacson69/batch-resize) |
| [PyTorch Learning](./projects/pytorch-learning/README.md) | PyTorch fundamentals tutorial series | [pytorch-learning](https://github.com/chrisaacson69/pytorch-learning) |
| [PyTorch Audio Learning](./projects/pytorch-audio-learning/README.md) | TorchAudio tutorial series | [pytorch-audio-learning](https://github.com/chrisaacson69/pytorch-audio-learning) |

## Research Topics

- [Economics](./research/economics/README.md) — utility theory, profit, risk, entrepreneurship, agent teams
- [Philosophy](./research/philosophy/README.md) — morality, logic, epistemology, legal theory, civilizational cycles
- [The Cyborg Model](./research/cyborg-model.md) — human/AI collaboration via comparative advantage
- [The LLM Grounding Problem](./research/llm-grounding-problem.md) — why LLMs can be talked out of physical reality
- [Claude Opus 4.6](./research/claude-opus-4-6.md) — capabilities, benchmarks, deployments

## Tools

This vault is maintained collaboratively with [Claude Code](https://claude.ai/claude-code). A `CLAUDE.md` file at the root provides conventions and instructions for the AI assistant. The vault is navigated, updated, and cross-linked during working sessions.

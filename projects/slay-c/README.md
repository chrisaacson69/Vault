# Slay-C
> C port of the Slay hex strategy engine — performance-focused, headless, with alpha-beta search and AI arena.

**Status:** active
**Created:** 2026-02
**Repo:** `https://github.com/chrisaacson69/slay-c`
**Links:** [Slay (Python)](../slay/README.md), [Vault Index](../../INDEX.md)

## Overview

C11 rewrite of the [Slay](../slay/README.md) Python engine, targeting raw performance for deep search and large-scale AI self-play. Fully headless — no renderer, just engine + AI + arena. Compiles with GCC (make / make debug).

### Architecture

- **`hex_grid`** — hex grid storage, adjacency, land/water
- **`territory`** — territory detection and economy (income, upkeep)
- **`units`** — unit types, placement, combat resolution
- **`game_state`** — full game state with clone support for tree search
- **`actions`** — legal move generation and application
- **`search`** — alpha-beta with iterative deepening, apply/undo, evaluation functions
- **`arena`** — AI vs AI match runner with seed control and side-swapping
- **`rng`** — deterministic PRNG for reproducible games

### AI Players

- **RandomAI** — uniform random legal moves
- **GreedyAI** — 1-ply lookahead with rich evaluation (territory size, income, unit strength)
- **AlphaBetaAI** — iterative-deepening alpha-beta with time limits and configurable max depth

### CLI

```
slay.exe --benchmark [--seed N] [--map-size small|medium|large] [--max-depth N]
slay.exe --arena --ai1 TYPE --ai2 TYPE [--matches N] [--verbose] [--map-size SIZE]
```

## Tags
[c](../../tags/c.md), [ai](../../tags/ai.md), [game-ai](../../tags/game-ai.md), [games](../../tags/games.md)

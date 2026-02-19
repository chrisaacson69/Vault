# Slay
> Hex-based strategy game recreation with AI player development.

**Status:** active
**Created:** 2026-02-12
**Repo:** `https://github.com/chrisaacson69/slay`
**Links:** [Slay-C (C port)](../slay-c/README.md), [Vault Index](../../INDEX.md)

## Overview

Recreation of [Slay](https://www.windowsgames.co.uk/slay.html), a turn-based hex strategy game where players expand territories, manage economies, and command units to eliminate opponents. The goal is a clean headless engine suitable for AI self-play and tree-based search.

Reference: [OpenSlay (Java)](https://github.com/jmseren/OpenSlay) — ~65-70% complete recreation, used for rules reference.

**Key design**: Engine is fully separated from renderer. The engine can run headless for self-play, AI training, and testing. `GameState.clone()` supports tree-based search.

## Roadmap

- [x] Core engine (units, grid, territories, combat, actions)
- [x] Pygame-ce renderer with hex grid display
- [x] Random AI baseline
- [x] Greedy heuristic AI
- [x] Alpha-beta tree search AI
- [x] AI vs AI arena
- [ ] Improve map generation (multi-player, balanced starts)
- [ ] Polish renderer (sprites, animations, territory info panel)
- [ ] Headless self-play harness for AI training
- [ ] Performance optimization for deep search

See full architecture, mechanics, and running instructions in the repo README.

## Tags
[python](../../tags/python.md), [ai](../../tags/ai.md), [games](../../tags/games.md)

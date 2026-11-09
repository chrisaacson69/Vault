---
captured: 2026-11-08
kind: source-manifest
purpose: ground the sim-channels "principles are situation-dependent" thesis (Catan road claims, seed vs skill)
---
# Catan — longest-road and seed-vs-skill sources (2026-11-08)

Extractions, not full texts: the Wargamer article is copyrighted, so only facts and short quotes are recorded here, enough to re-fetch and re-check. Fetched via WebFetch on 2026-11-08.

## 1. Wargamer — "Board game fan simulated 36,000 games of Catan and discovered roads are OP"

- **URL:** https://www.wargamer.com/catan/fan-simulated-36000-games
- **Author / date:** Matt Bassil, updated 2026-04-28.
- **Simulation by:** Reddit user Hot-Rooster1675, posted to r/boardgames; built with Claude's help.
- **Scale:** 36,000 games, across "a variety of board states and player counts".
- **Players:** four fixed strategies that never adapt: BalancedBuilder (pips and variety), OreWheatSheep (cities and dev cards), RoadBuilder (longest road), PortRusher (ports and matching resources). Trading uses "quite simple logic".
- **Findings as reported:**
  - 56–61% of all wins went to the longest-road holder.
  - Games with a longest road were significantly shorter.
  - No single strategy won overall; each had an advantage in different starting situations.
  - Wheat was "the best resource"; the biggest gap between winners and losers was wheat production.
  - Starting pips gave no advantage.
- **Caveats stated:** simplified trading with no politicking; fixed strategies; the creator plans to address both.
- **Cross-reference:** Forced Win's Catan video rebuts this simulation at [3:33–3:44] of `raw/videos/2026-10-27 forced-win-catan-3-7m-games.md`.

## 2. Goodman, Perez-Liebana & Lucas — "Seeding for Success: Skill and Stochasticity in Tabletop Games"

- **URL:** https://arxiv.org/abs/2503.02686 (HTML: https://arxiv.org/html/2503.02686v1)
- **Venue:** IEEE Transactions on Games, 2025. arXiv v1 submitted 2025-03-04. CC BY 4.0.
- **Method:** 15 tabletop games, each with 200 sampled seeds × 1,000 games per seed. Game seed fixed within a set; agent seeds vary. Skill ladder: Information Set MCTS at 2 / 10 / 50 / 250 ms per decision, plus a random agent. Individual sources of randomness (map, dice, decks) get their own seeds to isolate them.
- **Catan specifics:**
  - 3 players. MCTS at 50 ms with a state-value heuristic learned through expert iteration; the plain 50 ms MCTS without it was "very poor at the game".
  - Randomness by source (Table IV): All: span 0.70, trimmed span 0.51. **Map: trimmed span 0.31, outliers 0.49. Dice: trimmed span 0.11, outliers 0.28.** The map layout drives outcomes more than the dice.
  - First player: 22% mean win rate, but "95% of games have an underlying win rate between 4% and 56%". The seat's value depends on the board.
  - With random agents "the seed has no impact on the outcome"; the seed effect appears only with competent agents.
  - **Not discussed:** longest road, largest army, cities.
- **Cross-game conclusions:**
  - Seed impact generally **rises with agent skill**: "the more skilled the agents, the more innate game randomness skews the expected result in any one game."
  - Some seeds are non-monotonic in skill: the first-player advantage reverses at some budget levels.
  - Trimmed span and outlier share are the robust metrics; entropy can mislead.
  - A large random component does not make a game "bad".

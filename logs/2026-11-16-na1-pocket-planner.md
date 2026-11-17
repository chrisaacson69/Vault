# Session log — NA1: the pocket planner, hubs, and the opening wall (2026-11-16)

Continues [the skill wall](./2026-11-13-na1-assassination-skill-wall.md). Chris: *a better planner that could look ahead well enough to know if it can create pockets of fiefs with no enemies, so it would be able to have more focus on a frontline.* The numbers are in **`na1-decompiler/docs/synthesis-frontier.md` #60**; this is the map.

## What happened
- **The map read statically.** Back line takes 3-5 conquests from any start. The Kinki corner is the best pocket: 4 interior fiefs behind a 2-fief front. The greedy expander's 2-conquest lookahead seemed too short to see one.
- **Chris's matrix question.** Powers of the adjacency matrix count walks, and A^N first has no zero at N = 5, the map's diameter. The top eigenvector ranks exposure: Mino and Shinano at the top, Noto and Settsu at the bottom.
- **Chris's correction: hubs are strong owned, weak alone.** Holding Kaga, Shinano and Echigo, then taking Musashi, Suruga, Mikawa and Noto, adds a back fief with each conquest while the front stays at 3. The army bill charges a fief for its largest enemy neighbour, not the sum, so a hub pays one garrison for several borders. On opening order (Echigo → Kaga or the reverse; Honganji's 30% tax cap): *not sure "hub first" works either, but it might be worth a go.*
- **The pocket planner** (`expand.POCKET`, off by default): the goal empire within 4 conquests with the fewest men per back-line fief gained. **Skill 3: neutral.** Only 4 of 340 games hold a second fief by year 10, and the median first conquest is in year 19, so there is nothing to plan with.
- **Opening-line race at skill 2**, where the first conquest comes in year 13 (Chris: *this can better test the picker logic*). Chris's trio line led on 60 seeds (11 vs 6 unified). **On 200 fresh seeds it did not hold**: the planner tied greedy (46 vs 48), forced lines cost about 10 unifications through invasion, and hub first was worst in both samples, though only weakly. The greedy expander already ranks moves by interior fiefs created. **The wall is tempo, not horizon.**
- Chris: the Honganji 30% cap has been confirmed in several earlier sessions; no need to re-check it.

## Tools
- `expand.POCKET` / `POCKET_DEPTH` / `POCKET_STRICT` / `POCKET_KEEP`, `expand.LINE`; `long_game --pocket N --pocket-strict --staging --line`.
- `na1sim.pockets`: `table`, `walks`, `trace`, `race`.
- `long_game` fix: `POCKET` is set on every job, because the process pool reuses workers.

## Commits
na1-decompiler `main`, pushed: `7e8fcc0` (#60). Vault: this log, the [margin page](../research/gaming/margin-sets-player-intelligence.md) (skill-wall paragraph rewritten, its planner question resolved).

## Open
- **Next: the opening tempo.** What lets a one-fief player strike before year ~10 at skills 2-3? For example, hire straight to the attack and accept being huntable for a few seasons.
- The multi-fief, multi-turn late war (#59).
- Carried over: the ev odds table was measured at skill 1; the Hatakeyama pact test (#49); the unexplained rice +56.

**Continued in [grow or strike, the economy floor, and the mid-game stall](./2026-11-17-na1-grow-or-strike.md)** (#61; the opening tempo above is answered there).

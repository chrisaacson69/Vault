# Handoff — NA1 battle harness and combat player (2026-11-10)

## Goal
Build a battle harness in `na1-decompiler` that replays the saved start of every battle a human player defends. Use it to measure deployment policies: the pocket, partial cover with a strike unit, and turtling, each chosen by the attacker's days of food. Start with Saito (Mino, fief 8).

## Read first (pointers, not repeated here)
- **`docs/synthesis-frontier.md` #42** is the spec. It covers how each side deploys (from the ROM), the AI retreat and the `no_retreat` knob, how Saito wins (big armies starve), the doctrine (rice rule first: delay or decapitate), and the blanket and pocket geometry at Mino. #41 covers today's economic work (rice rule, `reader_policy`, Rokkaku).
- **Commits (`main`, pushed):** `dcf4c0a`, `b6472e6`, `8a47a43`, `0c10ece`, `05ad841`, `71cc622`, `55fcbba`, `a297610`.
- **Code:**
  - `tools/na1sim/tactical.py`: the whole battle engine.
    - Driver and deployment: `run_tactical_battle`, `deploy_both_sides_units_loop`, `ai_place_combat_units_random_or_smart`, `rng_search_combat_rect_for_unit_cell` (the attacker's commander rule), `ai_place_unit_in_free_slot_resolve_coords` (bodyguards).
    - Arena and placement rules: `set_combat_arena_rect_by_approach` (the entry strip), `tile_blocked_for_placement` (no cells next to the castle seat).
    - Ending the battle: `check_commander_alive_both_sides`, `ai_claim_province_when_strong_enough` (the retreat), `dispatch_battle_resolution`, `apply_conquest_outcome`.
  - `tools/na1sim/deaths.py`: game runner and death logging; `--opening k=v` sets `policy.OPENING` knobs; `--tail expand|reaction|reader`.
  - Decompiled ROM C: `source/4-c/bank_02.c` (e.g. `deploy_both_sides_units_loop` $9B07, `battle_init_driver` $AFE1, `player_interactive_unit_move_loop` $9A18). Docs: `docs/14-combat-overview.md`, `docs/17-damage-formula.md`, `docs/21-combat-resolution.md`.
- **Throwaway probe scripts from this session** were inline heredocs and are not saved. The pocket search, the blanket search and the battle-outcome logger are each about 40 lines; rebuild them as harness tools rather than hunting for them.

## Current state
- **Committed and pushed:**
  - The sim's human defender still deploys and fights with the AI logic. There is no player combat policy yet ("by design" in `resolve_battle`).
  - `no_retreat` (off by default) only stops the AI retreat for the human side.
- **Rules from Chris (not in the ROM docs):**
  - Every unit moves exactly 1 hex per turn.
  - The grid's columns are offset by half a row, which gives 6 neighbours.
  - Units take orders in slot order, 1 through 5.
  - The map is 55 cells and the battle lasts 30 days, so the setup's dice decide most of a battle.
- **Measured (AI fighting Saito's side, 300 seeds):** 36 of 300 invasions won. Attackers of 60–80 men are nearly unbeatable (1 of 61). Attackers of 120+ men starve (12 of 23 lost). Battles against attackers under 60 men are the decapitation target (17 of 66 won now).
- **Nothing uncommitted.** The scratchpad JSONs are disposable.

## Open questions (Chris to decide, or the harness to measure)
1. **What counts as a battle "start" to save?** The state just before `deploy_both_sides_units_loop`: memory snapshot, RNG state, `m.selected` / `m.defending`. Is replaying from there with different defender placements faithful enough? Placement changes the RNG draws that follow it.
2. **Strike odds:** can a strike unit beat a commander holding about 70% of the army (base split 50/5/5/5/5), or does the player need to change the split with Assign (the strategic command) first?
3. **The enemy commander's day-1 response** once our strikers step next to the pocket. This comes from the AI action chain (`ai_choose_combat_action_by_battle_strength`); read it or measure it.
4. **The human side's day-to-day tactics after deployment.** Keep the AI logic plus `no_retreat`, or script a strike? Start minimal: scripted strike on days 1–2, AI after that.
5. **Gate threshold:** what number of days of the attacker's food (rice ÷ (men ÷ 30)) separates turtle from decapitate? The proposal is about 30 (the battle length).
6. **Where the "spend Saito's men in the siege" tactic fits** (#42 doctrine). It's a later variant.

## Where to start
1. **Capture:** hook `run_tactical_battle` where the defender is `PLAYER_DIRECT` and the attacker isn't 50 (rebels). Save a snapshot plus RNG state per battle; for Saito that's about 300 starts over 300 seeds. Check that a plain replay of each snapshot reproduces the original outcome before testing any alternative.
2. **Placement override:** add a defender-placement hook used in place of `ai_place_combat_units_random_or_smart` when `cur_combat_side == 1` and the side is human. The first generator is the pocket search (#42: hole with 3+ open neighbours, most strikers two hexes out, commander on the seat). Then add a scripted day-1 step and day-2 attack on the enemy commander's cell.
3. **Score:** win rate per placement policy against the baseline, on the same saved starts (paired). Split by attacker and by days of food.

## Skills to invoke
- `/grill-me` before step 2 if the strike script's design is unclear (open questions 3–4).
- `/handoff` again at the end. At session end the vault rules also apply: push the repo, and log to the vault if significant (`/vault-sync` for any vault page touched).

# Session log — NA1: the unused verbs priced, the cartridge played headless, the RNG seed found (2026-11-13)

## What happened
The player can now unify from every start (#48), so Chris turned to the features players skip: *most seem overpriced and not necessary, but let's try anyway; another is OP, and decides games on a die roll* (assassination, left for last). Each verb was priced from the ROM's formulas, tested where that was worth it, and written up in **`na1-decompiler/docs/synthesis-frontier.md` #49-#54**. Read those for the numbers; this is the map.

- **#49 Diplomacy.** A relation is one d100 roll in the AI's war commit, re-rolled every season. A pact (fief cell) decays 10 a year; a marriage (daimyo cell) 2 a year. Against a neighbour who attacks whenever he can, a pact buys about two seasons and a marriage about eight. Chris: diplomacy is army size in this game. A pact closes one border, and only Noto has one; the test on Hatakeyama is queued. Corrected `diplomacy.py` (said "never decays") and #20.
- **#50 Sabotage.** The Luck gate is a fixed compare (each pair of lords always open or never), and a failed mission also costs the lord 1 Charisma. Only Revolt moves outcomes: 25-100 ninjas every season toppled Uesugi in 32-67% of games (control 5.5%), at every command and 33-130 gold a season in 1560. Chris: *tying up one opponent is worse than making yourself better against everyone.* Not in the player.
- **#51 Bribe** (in battle). Nearly a stat check (morale + Charisma), and where it works the cheapest army in the game (about 8 gold a man turned, no season command). An attacker's purse is exactly his men, so his bribe budget starts at 0. Whole games on the #48 player: 154 vs 152, no effect; the gate was open on 1% of attacking days. The AI's own bribes took 13,540 of the player's men in 340 games.
- **#52 Morale over 100.** Shuts the AI's bribe at skill 1 (ROM `$A780`, as Chris plays it): bribe losses −84%, unified 150 vs 154, about a year sooner. A style, not a stronger player.
- **#53 Rice.** The merchant is present half the time at skill 1 (`$B8CC`); the sim never rolled him, and now does by default. It moved nothing (150 vs 155): the player bought rice 25 times in 1,448 player-years. In games the price sits at 1.1-1.9 gold 83% of seasons (the AI's trading), so no arbitrage. Chris's deadly case, a defence won by starving the attacker (his men come with no rice), happened in 1 of 329 won defences on the #48 player; it belongs to a turtling defender early (Saito's EV planner).
- **#54 Loans.** A one-time 10-100% fee, debt about equal to town, collected from all the gold at the next harvest before the upkeep. Chris's frame: *a CAPM planner's problem, is growth above the interest?* On paper yes, but the √ on gifts, the Spring command and the first-Fall collection take it back. Loan-first openings hurt every weak start (Hatakeyama 48.3% → 8.0%).
- **The low-water marks, checked in the cartridge.** Chris: the watermark has been misunderstood, and play seemed to show a Summer gift paying at once. The Summer copy is taken before the Summer command (`$A483` → `$A498`). Played headless in Mesen (Oda 1560, tax 55, then a Summer give vs train): the marks stayed 47/48 after the gift, and 20 seeded runs gave gold +36.0 vs +35.0 and rice +39.9 vs +39.5, the formula's range on 47/48. A Summer gift pays at the next harvest; the jumps were the tax and last year's gift.
- **The RNG is seeded once.** The first button press sets `skip_wallclock` `$89` from the button byte, and only reset clears it, so the clock that seeds `syscall_rng_next` runs on the title screen only. After that a roll depends only on the number of draws before it. Chris: *you can only RNG-manipulate by seeding*; good stat rolls may come from pure timing off a known list. Corrected ch.1-3 ("freezes while a button is held") and the TAS-idea memory.

## Tools
- **`na1sim.long_game`**: #48's whole-game runner, recovered from an old scratchpad. A rebuild from `deaths.play`'s defaults gave 27 of 340 instead of 150; its settings are the point.
- **`tools/na1_play.py`**: plays the real cartridge headless (emu-harness `NES`), never capturing the screen. It reads the screen as text, gives commands by name (with a guard against a lost key press landing on War), reads any fief and the marks, branches from saved states, and seeds the RNG. Chris: *the tool is good, will help solve problems.*
- In the sim: `policy.take_loan`, `game.roll_merchant` + `policy.MERCHANT`, and the Bribe verb in `tactical.human_command_loop`. Fixed: `OPENING` lacked a `shield_rice` default (`deaths --tail reader` crashed).

## Commits
na1-decompiler `main`, pushed: `6f27b05` (#49), `ac82a41` (#50), `580e0ca` (#51), `d4aed01` (#52), `d6b903a` (long_game), `6194cd5`/`a78c3ff` (#53), `f9ba737`/`e7fbf55` (#54), `a636881` (na1_play), `cf4add2` (`$89`). Vault: `72c2da8`, `7136919` ([dead verbs](../research/gaming/dead-verbs-mechanism-viability.md): Pact and sabotage measured). Memory: the runner lesson (`feedback_commit_result_runners`).

## Open
- **Assassination**: expected cost by circumstance (capital-only, the Luck gate, the Cha+IQ contest, health attrition); sometimes too dear, sometimes impossible.
- **The ability-roll screen**: does it draw while the numbers spin? If so the press frame picks the stats from a fixed list (Chris's timing idea), checkable with `na1_play.py`.
- The Hatakeyama pact test (#49), and whether a pact on Kaga survives Honganji's death.
- The dead-verbs page could cite Bribe (#51) and Loans (#54) too.
- The unexplained rice +56 in the first single Summer-gift pair (7 above the range; not in 40 runs).

**Continued in [assassination priced, the chain, skill 3 and the skill wall](./2026-11-13-na1-assassination-skill-wall.md)** (#55-#59; assassination, the ability-roll screen and the dead-verbs citations above are closed there).

# Session log — NA1: assassination priced, the chain mapped, skill 3 and the skill wall (2026-11-13)

Continues [the unused verbs priced](./2026-11-13-na1-verbs-priced.md). Chris: *we got most of the verbs down, let's finish this off.* The numbers are in **`na1-decompiler/docs/synthesis-frontier.md` #55-#59**; this is the map.

## What happened
- **#55 Assassination.** Three fixed gates (an AI capital; their Luck under yours + 30; their Charisma + IQ at or under yours) and one Charisma roll, rng(10·skill) a side. **A landed hit always kills**: `$9293` is `230 > health` (`cmp_sgt` is regA > regB), which overturns #1's "attrition, about two hits". Checked in the cartridge with `na1_play.py` (30/30 one-hit kills; 14/30 at even Charisma against 55% predicted; 27/60 against 38% at skill 2). One ninja does it (the defensive roll needs Luck ≥ 200), at 1-2 gold. Found on the way: **the AI's lords carry the ROM stats + 5·skill** (`$83E2`, seen at skills 1, 3, 5), and the ability-roll screen draws every frame while it spins. Chris wanted the formula priced, not the verb played: the cost of a success by every variable, closed form, in `na1sim/assassin.py`. Chris: *OP*. The fief comes with its army intact (`neutralize_fief` leaves the record alone) and can go to auction for 1 gold.
- **#56 The chain.** Chris: *if you win the fief, you can chain it to the next one; it is about finding the vulnerable ones and who sits near them.* The kill is not limited by the map, the purchase is (only bordering owners bid, two or more), and each fief bought is another assassin. At skill 1 with a perfect roll, Uesugi, Tokugawa or Takeda take 11 of 17 fiefs in 5-6 seasons; at skill 2, at most 5. Chris: *out of the spirit of good play.* `na1sim/chain.py`.
- **Dead-verbs page** completed: Bribe, rice, loans and the chain added; the drift paragraph corrected to Chris's reading (Bribe is *a fixed cost hiding behind a gate that gets harder each year*).
- **#57 Skill 3**, where assassination stops working: 0 of 340 unified (skill 1: 155). Survivors are outlived by their lord. `long_game --skill`, and `--ev` (#48's Saito opening, never committed; reproduces 11 vs 13 of 300). Saito at skill 3: dead, as Chris guessed.
- **#58 The predictors checked.** The gates do not move against you. The miss: `$9CF4` scales every human unit's strength by (115 − 15·skill)%, and the expander still priced 2.0× as 90% (the battle lab: 100% at skill 1, 21% at skill 3). Fixed from the ROM site (`expand.SKILL_AWARE`, a no-op at skill 1); it moved little. The stall was the hire rule: the army waits a decade for a topped economy.
- **#59 Gate hire** (hire to the gate line, half the gold, before topping out): 39 openings saved, expansion nearly doubled, no one unifies, and the economy falls further behind (0.46 → 0.37 of the AI's per fief at year 20), as Chris warned. The economy is the wall: the AI grows town and output one for one (`effect_send`), the player on a √ curve × (6 − skill). **The skill wall (Chris):** *the game relies on human advantages to carry logical play*; the dial removes them. Grant is no way round. **The greedy expander has met its limits.**

## Tools
- `na1sim/assassin.py` (cost of a success), `na1sim/chain.py` (the assassinate-and-buy chain), `na1sim/skill_lab.py` (the fought charge at each skill).
- `long_game`: `--skill`, `--ev`, `--gate-hire`; yearly rows carry the Economic Index per own fief and per AI fief.
- `expand.SKILL_AWARE` (on), `expand.GATE_HIRE` (off).

## Commits
na1-decompiler `main`, pushed: `7835e47`, `30ca11a` (#55), `01fd90a` (#56), `1d80048`, `fbb4a4f` (#57), `902ea90` (#58), `f7ddc2f`, `83d3097` (#59). Vault: `7ae3d9a`, `2649654`, `af7b39a` ([dead verbs](../research/gaming/dead-verbs-mechanism-viability.md)), and the [margin page](../research/gaming/margin-sets-player-intelligence.md)'s skill-wall section.

## Open
- **Next session: the backline planner.** Targeted expansion that turns your own fiefs into back line (no enemy neighbour, no army, all the gold into the economy) to out-develop the AI 2:1 on the cut curve. `army_bill` already prices back line at 0; `best_attack` is greedy; `expand.PLANNER` is the natural home, untried at skill 3.
- The skill-3 opening (Chris: no plan yet).
- The late war: attack from several fiefs or over several turns (a capped fief cannot be sent gold; you need not win on the first try), tied to the economy.
- The ev odds table (`odds_f8.json`) was measured at skill 1.
- Carried over: the Hatakeyama pact test (#49); the unexplained rice +56; the ability-roll timing (the screen draws every frame, so the press frame picks the value).
- Curiosity, not policy: how fast an assassinate-first game goes on `long_game` (the sim has no assassination verb, and its `natural_death` skips the auction).

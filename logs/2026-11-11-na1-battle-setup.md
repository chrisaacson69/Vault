# Session log — NA1 battle setup: the entry atlas, two sim fixes, Echigo and Mino plans (2026-11-11)

## What happened
Picked up the 2026-11-10 setup-RNG handoff (Chris: the *battle* setup; "abuse" = tendencies and forced paths). Everything is written up in **`na1-decompiler/docs/synthesis-frontier.md` #44**. Read that, not this, for numbers.

- **The setup variety is in the rules.** North/south/west: commander + 2 guards in one of two fixed blocks (a coin); east: all random; slots 3-4 always random. Terrain shifts the landing on 12 of 28 scanned entries.
- **Entry atlas** for all 17 fiefs, drawn with the game's own tiles: `tools/battle-entry-atlas.py` + `tools/render-battle-setup.py`, output in `assets/maps/battles/`. Published as a private artifact: https://claude.ai/artifact/TEuMX8R3trkK9nxzrtWNur
- **Two ROM rules the sim had wrong**, both oracle-checked (21/21):
  - A daimyo-led attacker that loses hands its faction to the defender.
  - AI daimyos never fled. The rule is his men ×2 under the adjacent enemy men, or rice under 2 days.
- Consequence: an AI attacker with 30 days of rice flees around day 28 and never reaches day 30; the faction comes only from a kill.
- **Echigo:** the defender fixes the attacker's whole setup. Strike is best at every attacker size; hold doubles the faction kills.
- **Mino:** three units force the far end of the spiral on both coins (north 20 days, south 18). (3,0) is the castle's one gate.
  - The starve plan alone doesn't beat strike at 20×5.
  - With 96/1/1/1/1 (one-man units as scan tokens) it holds 114 of 317, the best Saito battle figure (the AI holds 39).
- Whole games rerun on the fixed sim: Saito 1.7% default, 3.7% reader; all 17, skill 1, 68.1%.

## Commits (na1-decompiler `main`, pushed)
`b9fec1f` (sim fixes), `1094c86` (atlas, renderer, plans), `129e141` (Mino plan, gate mode, `--fief`/`--split`), `006228e` (#44 writeup; ch.21 corrected).

- **The Assign doesn't pay in whole games** (Chris called it). Saito starts with 29 gold and Assign costs 30, so turn 1 is impossible. Assigning as soon as he can afford it: 1.7% alive vs 5.0% without; all gold into men on turn 1: 1.0%. All 17 at skill 2: 63.3%. Commit `b3455e5`.

## Next (Chris)
1. **Later:** push Mino's random slots 3-4 back in the north; a decapitation chokepoint against Oda from the west; a hold rule that estimates a one-round kill; per-side run plans.

# Bribe — gold-for-spy peasant defection

> Rich walkthrough: **[bribe.html](./bribe.html)**. This file is the bytecode-shape + test-log companion.

**Bribe is NOT the sabotage menu.** That menu is Hire▸Ninja ([ninja.md](./ninja.md) / `$A2D2`). Bribe (`driver_bribe $AAAE` → `effect_bribe $8D4D`) is a separate, simpler command: pay a spy to bribe an enemy fief's peasants into defecting.

## Flow
1. `$AAC2` — gold gate: need `gold > 10`.
2. `$AAD8` — `"Bribe which?"` pick target fief.
3. `$AAF6` — `"Gold for spy?"` number entry.
4. `$8D74` — `bribe_success_check $8D02` decides the outcome.
5. Success → `ui_helper_e80c(26)`, output transfer, `"%d peasants have defected"`.
6. Failure → `"No peasants defected!"`, daimyo `−1` charisma, part of stake forfeit.

## The contest (`bribe_success_check $8D02`, bytecode-derived) — INTUITIVE direction
- `local11` (from the LAST-pushed call arg = **YOUR** fief) = `your_loyalty(+12) + your_daimyo_charisma(+4)`
- `local10` (from the first-pushed arg = **TARGET**) = `target_loyalty + target_charisma + rng%10 × const_two`
- `$8D3D SCMPGT` / `$8D3E JUMPF`: **success requires `local11 > local10`** = `YOUR(loy+cha) > TARGET(loy+cha) + rng%10`, *then* a 50% coin flip (`$8D41 rng%2`). Otherwise → fail.

**You bribe fiefs WEAKER (lower loy+cha) than you** — a loyal/charismatic lord peels away a disloyal enemy's peasants. (An earlier draft had this backwards: the VM passes call args into frame slots in **reverse** push order — the `$8BD0 DEREF` of the same slot, which only works on the pointer arg, independently confirms the reverse mapping. Field ids: loyalty@+12, daimyo charisma@+4.)

## The transfer (`effect_bribe $8D4D` → `compute_bribe_effect_value $8BC1`)
- Success: `defender.output(+8) -= value; your.output(+8) += value`. "Peasants" = the output/agricultural base.
- **`value = loyalty − (⌊(30 + rng%25) × (min(loyalty, √gold) + 1) ÷ 100⌋ + 1)`** — EMULATOR-CONFIRMED via `probe-espionage.py` (closed form reproduces every observed band: loy 80→63-76, loy 40→23-30, loy 10→4-6). Op-by-op trace: `T=30+rng%25`, `min(loyalty, √gold)`, `+1`, `pct_op(T, ·)`, `+1`, `word_sub_saturating(loyalty, ·)`. `√gold` = `sqrt_int` of the "Gold for spy?" amount (effect_bribe arg, confirmed from `driver_bribe $AB0F`). **NOT a % of output** (an earlier draft said ~30–55% — wrong).
- Failure: `your_daimyo[+4] -= 1` (charisma); part of the stake forfeit.
- Anim id **26**.

## Quirk (worth an in-game check)
More spy gold → larger `√gold` → larger subtracted resistance (until `√gold ≥ loyalty`) → **fewer** peasants. So minimal gold maximizes the transfer. Bytecode + emulator agree; the success roll (`$8D02`) is gold-independent, so confirm gold isn't buying something else in-game.

## Test log
_TBD — needs an in-game PRE/POST capture (snap protocol in [README](./README.md))._

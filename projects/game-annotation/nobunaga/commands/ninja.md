# Ninja (Hire ▸ Ninja) — sabotage subsystem

> Rich walkthrough: **[ninja.html](./ninja.html)**. This file is the bytecode-shape + test-log companion.

Reached from **Hire** (`driver_hire $A5F4`) via the `(Men/Ninja)?` prompt → **Ninja** = `effect_ninja_sabotage` (`$A2D2`, was mislabeled `effect_hire`). Recruit-men is the sibling `effect_hire_variant_pay $A553`.

## Flow (from `$A2D2` bytecode)
1. `"How many"` — gold-gated hire (cost via `hire_gold_rate $6E13`, re-rolls each turn).
2. `"Send where?"` — target fief (`$A31B`).
3. `"What mission"` → menu `$BD8F` `"1-Uprisng 2-Revolt 3-Dams 4-Assassin 5-Arson"`.
4. `ui_helper_e80c(12)` — mission-launch animation (`$A36D`).
5. **Ninja-skill gate** (`$A396`): proceeds only if `target_daimyo[+3] < your_daimyo[+3] + 30`.
6. `switch` at `$A39A` → per-mission effect; failure → `"Your ninja failed!"`, gold spent anyway (`effect_hire_pay_gold $A29B`).

## The five missions (switch `$A39A`)
| # | Mission | Target drains | Anim | Code |
|---|---|---|---|---|
| 1 | Uprising | loyalty + wealth | 28 | `$A3AB` |
| 2 | Revolt | morale | 27 | `$A45A` |
| 3 | Dams | dams + rice | 30 | `$A497` |
| 4 | Assassin | kills daimyo (gated by `$6DA2` present) via `ninja_mission_resolve_vs_defender $918D` | 1 | `$A508` |
| 5 | Arson | town | 29 | `$A510` |

Drain magnitude (from `hire_stat_drain_rng $A255` bytecode): `drain = (rng % max(1, ⌊field × √(your_skill+30) ÷ 100⌋) + 1) × 5` — multiple of 5, scales with the target field's value and your daimyo skill (record +3, +30 edge); clamped to the field. Arg roles resolved via the reverse-push frame convention (last-pushed → arg1 = the multiplied `field`). Result text: `"Fief %d's %s has declined by %d"` (`report_fief_stat_decline $A274`).

**Emulator-CONFIRMED** (`tools/probe-espionage.py`, after fixing the harness rng stub): observed drains matched `{5,10,…,X×5}` for every test vector.

## Open
- Assassination resolution detail (`$918D`): roll, counterattack/repel, `neutralize_fief`. Candidate source of Tokugawa's mystery health loss.
- The `(Men/Ninja)?` choice → which `d351` case is which (content is unambiguous; case-mapping is cosmetic).

## Test log
_TBD — needs an in-game PRE/POST capture per mission (snap protocol in [README](./README.md))._

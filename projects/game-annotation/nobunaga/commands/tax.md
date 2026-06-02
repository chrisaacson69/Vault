---
status: active
created: 2026-06-02
command: Tax
menu_index: 3
driver: $999A
effect: $82D6 (generic signed-pct primitive)
---
# 3. Tax — Set the Tax Rate

> **Rich walkthrough: [tax.html](./tax.html).** Set a province's tax rate. Symmetric and one-shot: raising it drains loyalty **and** wealth (and costs charisma); lowering it restores them.

**Links:** [commands README](./README.md) · [appendix §Tax](../appendix-formulas.md) · disasm/bank_01_vm.asm (driver $999A, primitive $82D6)

## Formula (bytecode-verified, $999A driver + $82D6 primitive)

```
Δ = new_tax − old_tax
stat_adjust(stat):  move = pct_op(stat, |Δ|);  stat = (Δ>0) ? stat−move : stat+move
loyalty  = stat_adjust(loyalty)      ; record +12
wealth   = stat_adjust(wealth)       ; record +14
charisma += (Δ>0) ? −1 : +1          ; daimyo record +4
tax[fief] = new_tax
```

- **Symmetric**: raise by |Δ| → both loyalty & wealth drop |Δ|%; lower → both rise the same %.
- **Scales with the CHANGE, not the level** → set tax high (50–60%) once, early, and never fiddle.
- Two animations: **id 19** ("The peasants are protesting", on a raise), **id 18** ("delighted", on a cut).
- `effect_tax` ($82D6) is a generic signed-percent primitive; the driver calls it twice (loyalty, wealth).
- Cap on the new rate: 100, or 30 under `tax_helper_db12`.

## Strategic

Set tax high turn one, leave it. **~55% is the sweet spot** (Chris, empirical). Every re-fiddle re-charges the loyalty/wealth penalty. Pushing past ~55–60% opens Riot vulnerability (see the event system).

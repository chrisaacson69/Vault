---
status: active
created: 2026-05-24
command: Build
menu_index: 13
driver: $A853
effect: $88A6
helper: $887D (helper_dam_rounding)
---
# 13. Build — Raise Town Infrastructure

> Sister of Grow but targets **town** instead of output. Structural diff against Grow:
> - Same sqrt + 32-bit math + flat-100 + headroom-clamp shape
> - Operates on **TOWN** (record+4) instead of OUTPUT
> - Drains **WEALTH** (record+14) instead of LOYALTY+DAMS
> - Has a **secondary TOWN bump** via `helper_dam_rounding` ($887D) on top of the main gain

**Links:** [commands README](./README.md) · [Chapter 10 — command families](../10-command-families.md) · [Chapter 11](../11-strategic-engine-complete.md) · [Grow analysis (the reference)](./grow.md) · disasm/bank_01_vm.asm (`effect_build` at $88A6)

## Fields touched (from bytecode)

| field | offset | change |
|---|---|---|
| `town` (record+4) | +4 | `town += gain` (main) AND `town += rounded_secondary` (helper) |
| `wealth` (record+14) | +14 | `wealth −= pct_op(wealth, pct)` |
| `gold` (record+0) | +0 | `gold −= amount` (driver) |

**Not touched** by `effect_build`: output, rice, loyalty, dams, men, morale, skill, arms, header, debt.

This is the meaningful distinction from Grow:
- Grow: 1 add (output), 2 drains (loyalty + dams)
- Build: 2 adds (town, town again), 1 drain (wealth)

## Silent preconditions (driver $A853)

- `if header < town: bail` — town already at development ceiling
- `if gold == 0: bail`
- Prompt is capped at current gold

## Effect formula (effect_build $88A6)

Structurally identical to `effect_grow` from `$87F0` through the flat-100 / `math32_2arg` branch, but with all field offsets shifted:

```
if amount < 1:  return 0
sqrt_val = sqrt(town + amount)                      ; field+4 now
gain_raw = math32_3arg(-const_two, sqrt_val, ???)
gain     = gain_raw << 1
if gain > (header - town): gain = header - town
if gain/2 > town: base = 100
else: base = math32_2arg(town, headroom)
pct = (div chain) of base
wealth -= pct_op(wealth, pct)                       ; field+14, not +12+10
town   += gain                                      ; main add
town   += helper_dam_rounding(town_ptr, gain*2)     ; secondary add
return gain (NOT gain/2 — Build returns the unscaled gain to the driver)
```

## Test runs

### Test 1: Build with all gold (PLANNED — next turn)

**Context**: Tokugawa, gold=70 (current), town=66, header=1640. Headroom = 1574 (vast — no clamp risk).

Prediction shape:
- `sqrt(66 + 70) = sqrt(136) = 11` (integer)
- `−const_two`: `11 − 1 = 10` (assuming const_two still reads as 1)
- `gain_raw = math32_3arg(-1, 11, ???)` — unknown until measured
- `gain = gain_raw << 1`
- gain/2 = gain_raw. If `gain_raw ≤ town = 66`, takes `math32_2arg` branch
- Main: `town += gain`
- Secondary: `town += helper_dam_rounding(town, gain*2)` — adds a smaller bonus
- Drain: `wealth −= pct_op(wealth, pct)` where pct comes from same chain as Grow

**Snap protocol**:
```
py capture-test.py build-all-gold pre               ; right before Build
(in-game: Build → enter all available gold → confirm)
(pause Mesen, save memory dump)
py capture-test.py build-all-gold post
py capture-test.py build-all-gold diff --fief 8
```

**Recording**:

| value | pre | post | Δ | notes |
|---|---:|---:|---:|---|
| gold | | | | should drop to ~0 |
| town | | | | both main + secondary add; Δ should be > sqrt-only |
| wealth | | | | the drain field |
| rice | | | | (sanity: 0) |
| output | | | | (sanity: 0) |
| dams | | | | (sanity: 0) |
| loyalty | | | | (sanity: 0; if not 0, tax/drift confound) |
| header | | | | (sanity: 0) |
| const_two ($6D63) | | | | watching |

### Test 2: (planned — smaller amount, to factor out secondary helper)

Doing two Builds at different amounts lets us separate the "main gain" from the "secondary helper bump." Specifically the helper is `town += (gain*2) / divisor + maybe rounding`, so the secondary delta should be small.

## Open questions

- **What's `helper_dam_rounding` actually doing?** It's called from both Dam and Build with `(field_ptr, value)`. Bytecode at $887D shows: integer-divide, increment-if-remainder, then `*ptr += quotient`, then call `helper_82AC`. Need to walk it carefully — see [dam.md](./dam.md) which also relies on this.
- **Does Build return `gain` (not `gain/2`)?** Read suggests so, vs Grow which returns `gain/2`. Easy to verify from the in-game display (the message the driver shows after the effect runs).
- **What `pct` value does Build use** vs Grow? Same `math32_2arg` chain but with different inputs (`town, headroom` vs `output, headroom`). Test result will reveal.

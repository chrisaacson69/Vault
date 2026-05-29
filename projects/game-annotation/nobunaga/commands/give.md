---
status: active
created: 2026-05-24
command: Give
menu_index: 14
driver: $AA1F
effects: $A93A (effect_give_a), $A95E (effect_give_b), $A9D5 (effect_give_c)
helper: $A91E (computes per-asset transfer)
---
# 14. Give — Charity

> "Touches the most province fields" of any command (Chapter 11). Two prompts: **(Gold/Rice)?** then **(Peasants/Men)?** → four sub-modes total. Used to raise loyalty/morale by spending an economic resource.

**Links:** [commands README](./README.md) · [Chapter 11 — all commands characterized](../11-strategic-engine-complete.md) · disasm/bank_01_vm.asm (driver $AA1F, effects $A93A / $A95E / $A9D5)

## The four sub-modes

|   | Peasants | Men |
|---|---|---|
| **Gold** | gold → peasant loyalty | gold → army morale |
| **Rice** | rice → peasant loyalty | rice → army morale |

The two prompts in the driver are: `"(Gold/Rice)? "` ($BE20, via `ui_helper_d351`) and `"(Peasnts/Men)? "` ($BE31, also via `ui_helper_d351`). Both are 2-choice prompts.

## Driver structure ($AA1F)

```
record = $7001 + selected_idx*26                ; standard province-access idiom
call effect_give_a (record_ptr)                 ; preliminary calc / validity check
call effect_give_c (record_ptr)                 ; main flow: prompts + transfer
if result == 0: bail with error message
if (frame[-4] AND frame[-2]) != 0:              ; combined-flag check
    ... success path ...
else:
    if (frame[-4] − 1) == 0:                    ; if was 1 (peasants chosen)
        msg = "You have no\npeasants!"
    else:                                       ; was 2 (men chosen)
        msg = "You have no\nsoldiers!"
    display(msg)
```

## The Give pipeline (CODE-DERIVED, 2026-05-25)

The full transfer logic lives in `$A8D3`, dispatched by `effect_give_c` / `effect_give_b`. `$A91E` (the helper called by `effect_give_a`) turned out to be a **no-op that always returns 0** — it's a vestigial/sentinel function. The actual transfer is in:

```
$A8D3 (record, asset_type, target_group):
    src_addr = (asset_type==1) ? record+0 (GOLD) : record+6 (RICE)
    amount   = number_input(cap = *src_addr)
    if amount == 0: return
    *src_addr -= amount                              ; ← 1:1 source drain

    if target_group == 1:                            ; PEASANTS
        $891D(record, amount)   → LOYALTY += gain
        $896F(record, amount)   → WEALTH += gain
    else:                                            ; MEN
        $89C1(record, amount)   → MORALE += gain
```

### The three target helpers — same Grow-template, different field pairs

All three follow the EXACT shape of `effect_grow` but with `sqrt(target_pair_avg + amount)` instead of `sqrt(field + amount)`:

| helper | code addr | field pair averaged | bumped |
|---|---|---|---|
| `$891D` | $891D | `(OUTPUT + LOYALTY) / 2 + amount` → sqrt → ... | **LOYALTY** (record+12) |
| `$896F` | $896F | `(TOWN + WEALTH) / 2 + amount` → sqrt → ... | **WEALTH** (record+14) |
| `$89C1` | $89C1 | `(MEN + MORALE) / 2 + amount` → sqrt → ... | **MORALE** (record+18) |

Each runs the standard pipeline: `sqrt(pair_avg + amount) − const_two → math32_3arg → << 1 → headroom-clamp → flat-100 → target_field += gain`.

**Thematic pairings**: each target is averaged with its "natural complement" before the sqrt — prevents runaway-pumping one stat. Loyalty (peasant satisfaction) ↔ output (peasant productivity); wealth (commerce) ↔ town (urban infra); morale (army spirit) ↔ men (army size).

## Re-interpretation of Test 1 (Rice → Peasants, amount=59)

Previously inferred: "Give is a 3-field command (rice, loyalty, wealth)." **Confirmed by code**: Give-Peasants calls $891D AND $896F, two separate target-helpers, each independently raising one of loyalty/wealth. The "3-field" finding is exactly what the bytecode does.

For Test 1's specific numbers (rice=130, loyalty=37, wealth=47, output=136, town=66, amount=59):
- $891D: `sqrt((136 + 37)/2 + 59) = sqrt(86 + 59) = sqrt(145) = 12` → math32_3arg etc. → LOYALTY +48
- $896F: `sqrt((66 + 47)/2 + 59) = sqrt(56 + 59) = sqrt(115) = 10` → math32_3arg etc. → WEALTH +58

Different sqrt inputs (12 vs 10) lead to different gains. This is why loyalty +48 ≠ wealth +58.

## Fields touched (empirical — Test 1 confirms a 3-field signature for Rice→Peasants)

| sub-mode | source field −= | target #1 += | target #2 += | confirmed |
|---|---|---|---|---|
| Gold → Peasants | `gold` | `loyalty`? | `wealth`? | not yet |
| Gold → Men | `gold` | `morale`? | ? | not yet |
| **Rice → Peasants** | **`rice`** | **`loyalty`** | **`wealth`** | **Test 1 ✓** |
| Rice → Men | `rice` | `morale`? | ? | not yet |

**Test 1 surprise**: Give doesn't just bump ONE target field — it bumps TWO. Rice→Peasants raises both `loyalty` AND `wealth`, with the wealth bump nearly matching the rice spent 1:1. This is consistent with the chapter-11 "touches the most province fields" characterization and the 3-effect call structure.

The transfer scaling is probably a function of **men** (recipient population) and/or **output** (province economic size) — `effect_give_a` ($A93A) reads exactly those two before calling `$A91E`.

## Test runs

### Test 1: 2026-05-25, Spring 1560, Tokugawa, Rice → Peasants, amount=59

**Context**: Tokugawa post-Grow + 60%-tax hit. Snap landed at start of Miyoshi's Spring turn (mid-Spring, before any harvest or season-end events) — **clean isolation of the Give effect** on Tokugawa.

| value | pre | post | Δ | notes |
|---|---:|---:|---:|---|
| gold | 70 | 70 | 0 | sanity ✓ (no cost in gold for Rice mode) |
| **rice** | **130** | **71** | **−59** | source field, 1:1 with amount |
| **loyalty** | **37** | **85** | **+48** | target field #1 |
| **wealth** | **47** | **105** | **+58** | target field #2 — UNEXPECTED but consistent |
| morale | 75 | 75 | 0 | sanity ✓ — Peasants mode doesn't touch morale (would be Men mode) |
| town | 66 | 66 | 0 | sanity ✓ |
| output | 136 | 136 | 0 | sanity ✓ |
| dams | 64 | 64 | 0 | sanity ✓ |
| men | 71 | 71 | 0 | sanity ✓ |
| skill | 74 | 74 | 0 | sanity ✓ |
| arms | 73 | 73 | 0 | sanity ✓ |
| header | 1640 | 1640 | 0 | sanity ✓ |
| const_two ($6D63) | 1 | 1 | 0 | watched |

**Derived observations**:
- `rice −= amount` is exactly 1:1 (no consumption-on-transit, no rounding).
- `wealth_gain = 58` ≈ `amount − 1 = 58`. Could be `pct_op(amount, 98) = 57` (off by 1), or `amount × X` with X ≈ 0.983, or some `amount * 100 / 101` formula. Needs second data point.
- `loyalty_gain = 48`. Doesn't pattern-match obvious formulas vs (amount=59, pre.loyalty=37, men=71, output=136):
  - `(100 − loyalty_pre) × amount / 100 = 63 × 59 / 100 = 37` → not 48
  - `pct_op(amount, X) = 48` → X = 81 (no obvious source)
  - `amount × 100 / (100 + something)` = 48 → divisor = 122.9
  - **One data point isn't enough** — same fitting problem as Grow.

**Cross-fief sanity**: Hojo also got `loyalty +23, wealth +23` (equal-and-equal pattern), suggesting AI also did Give-rice-to-peasants. Oda got `loyalty +20, wealth +23` (close). So Give is a frequent AI command — consistent with all-daimyo loyalty pressure.

Files: `traces/give-rice-to-peasants_PRE.dmp`, `traces/give-rice-to-peasants_POST.dmp`.

### Test 2 (planned): Rice → Peasants, different amount, same province

To fit `loyalty_gain` and `wealth_gain` formulas, do another Give-rice with a clearly different amount (e.g. 20 or 100). Same protocol.

### Test 3 (planned): Gold → Peasants

Different sub-mode. Predicts: `gold −= amount`, plus loyalty/wealth bumps. Will confirm whether the same `f(amount)` shape transfers across gold/rice modes.

### Test 2: Gold → Men (planned)

For when there's gold to spare; would isolate the "morale" target.

## Open questions

- **What does $A91E compute?** Probably the per-asset cap or the loyalty-yield-per-unit-rice. It receives `(record_ptr, men, output)` so the formula likely involves all three.
- **Does the loyalty/morale gain saturate?** Loyalty caps somewhere (probably 100 or higher per the 9999-ceiling pattern). Test with a small amount in a low-loyalty province.
- **Is rice→peasants linear, or does it have a diminishing-returns shape?** First test will tell.

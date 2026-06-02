---
status: active
created: 2026-05-24
command: Grow
menu_index: 7
driver: $9D3D
effect: $87F0
---
# 7. Grow

> Raises a province's **output** on a sqrt curve. Costs gold (debited from the province itself). Drains **loyalty** and **dams** as the silent cost of "extracting" output growth from soft infrastructure.

**Links:** [commands README](./README.md) · [Chapter 9 — Command System & Grow](../09-command-system-and-grow.md) · disasm/bank_01_vm.asm (`effect_grow` at $87F0)

## Fields touched (from bytecode)

| field | offset | change |
|---|---|---|
| `output` (record+8) | +8 | `output += gain` |
| `loyalty` (record+12) | +12 | `loyalty −= pct_op(loyalty, pct)` |
| `dams` (record+10) | +10 | `dams −= pct_op(dams, pct)` |
| `gold` (record+0) | +0 | `gold −= amount` (driver, before effect is called) |

**Not touched** by `effect_grow`: town, rice, wealth, men, morale, skill, arms, header, debt.

## Silent preconditions (driver $9D3D)

- `if header < output: bail`  ("We're at our limit") — output already at the development ceiling.
- `if gold == 0: bail` — nothing to spend.
- The number-input prompt is **capped at the province's current gold**, so you can't spend more than you have.

## Effect formula (effect_grow $87F0) — **VERIFIED 2026-05-26**

```
if amount < 1:  return 0
sqrt_val   = sqrt(output + amount)                  ; CBCD = integer sqrt (truncated)
math_arg1  = amount                                  ; gold spent
math_arg2  = 6 − const_two                           ; $8808: LOADL 6 / SUB const_two($6D63); = 5 when const_two=1
math_arg3  = sqrt_val
math_ret   = (amount × (6−const_two)) ÷ sqrt_val     ; math32_3arg, signed int divide
gain       = math_ret << 1                           ; aslA — doubled
if gain == 0: gain = 1                               ; min gain 1
if gain > (header - output): gain = header - output  ; headroom clamp (rarely fires)
; --- secondary-drain percentage, computed LIVE ($8833-$884E) — NOT a constant ---
if (gain / 2) > output:  pct = 100 / 2 = 50          ; flat 50% ceiling when gain > 2·output
else:                    pct = math32_2arg(gain, output) / 2 = ⌊100·gain ÷ (gain+output)⌋ / 2
loyalty   -= pct_op(loyalty, pct)                    ; secondary drain
dams      -= pct_op(dams, pct)                       ; secondary drain
output    += gain
return gain / 2                                      ; driver displays this
```

**Closed form**: `gain = 2 × ⌊(amount × 5) ÷ ⌊√(output + amount)⌋⌋`

**ROI**: `gain / amount ≈ 10 / √(output + amount)` — a pure inverse-sqrt diminishing-returns curve.

Where:
- `math32_3arg(a, b, c) = (a × b) ÷ c` (32-bit signed; verified by walking the 47 extended opcodes 2026-05-25)
- `pct_op(b, p)` = `b × p ÷ 100` (split-by-10 to avoid 16-bit overflow)
- The multiplier is `6 − const_two` (`$6D63`), computed at $8808 — **not** a literal 5. It equals 5 only because `const_two` is normally 1; `apply_two_grows_const1_override` proves it's mutable. Same template `(amount × (6−const_two)) ÷ sqrt` applies to Build/Give (verified) with the same `const_two`.

## Test runs

### Test 1: 2026-05-24, Spring 1560, Tokugawa, amount=69

| value | pre | post (Fall start) | Δ | notes |
|---|---:|---:|---:|---|
| gold | 69 | 70 | +1 | paid 69; harvested ~70 over 2 seasons |
| output | **80** | **136** | **+56** | clean Grow gain |
| dams | 80 | 64 | **−16** | clean (assuming tax doesn't touch dams) |
| loyalty | 76 | 37 | −39 | **mixed**: Grow drain + 60% tax loyalty hit |
| wealth | 77 | 47 | −30 | **all from tax** (Grow doesn't touch wealth) |
| header | 1640 | 1640 | 0 | unchanged as expected |
| rice | 75 | 130 | +55 | fall harvest from new output=136 |
| const_two ($6D63) | 1 | 1 | 0 | watched |

**Confounders**: tax raised to 60% in Summer, and snapshot is at start of Fall (after harvest).

**Derived numbers**:
- `gain = +56` ✓ matches bytecode model with `math32_3arg(−1, 12, ???) = 28`, then `28 << 1 = 56`
- `headroom = header − output = 1640 − 80 = 1560` — not clamped (vast)
- `gain/2 = 28 ≤ output = 80` → **flat-100 ceiling NOT hit**; took the `math32_2arg` branch
- Assuming dams Δ is purely Grow: `pct_op(80, P) = 16` → **P = 20** *(in THIS test)*
- ⚠️ **CORRECTED 2026-06-02 (bytecode validation):** `pct` is **NOT** a constant 20. The bytecode at `$8833-$884E` computes it live: `pct = (gain/2 > output) ? 50 : ⌊100·gain/(gain+output)⌋/2`. For Test 1 (gain=56, output=80): `⌊5600/136⌋/2 = 41/2 = 20` — so the "20" was a **coincidence of this single test** (the only one where drains were captured). The drain scales with how aggressive the grow is relative to output, capped at 50%. The old "`pct=20` is a real game constant" claim (and its Train cross-check, which happened to land on 20 too) is withdrawn — see [[project_nobunaga_grow_formula_corrected]]. Validated against `$87F0` bytecode + reproduced by `run-effect.py`.

Files: `traces/grow-test1-tokugawa-PRE.dmp` (Spring start), `traces/grow-test1-tokugawa-POST-fall-start.dmp` (Fall start).

### Tests 2-5: 2026-05-26 — formula derivation series (Mikawa, Tokugawa)

Five consecutive Grows on the same fief, varying `amount` each time. Captured arg values from VM trace during Test 5 (math32_3arg's loadA opcodes show frame contents directly).

| # | output_pre | amount | sqrt | predicted gain | actual gain | ✓ |
|---:|---:|---:|---:|---:|---:|:---:|
| 1 | 80 | 69 | 12 | 2×⌊69·5÷12⌋ = **56** | +56 | ✓ |
| 2 | 136 | 37 | 13 | 2×⌊37·5÷13⌋ = **28** | +28 | ✓ |
| 3 | 164 | 65 | 15 | 2×⌊65·5÷15⌋ = **42** | +42 | ✓ |
| 4 | 206 | 85 | 17 | 2×⌊85·5÷17⌋ = **50** | +50 | ✓ |
| 5 | 256 | 115 | 19 | 2×⌊115·5÷19⌋ = **60** | +60 | ✓ |

**Trace evidence (Test 5)**: VM trace at `pc=$E869` filtered through math32_3arg bytecode ($D6BD–$D6DD) showed loadA opcodes pulling:
- frame[+0xF] = $0013 = 19 (= arg3 = sqrt)
- frame[+0xD] = $0005 = 5 (= arg2, hardcoded constant)
- frame[+0xB] = $0073 = 115 (= arg1 = amount)

Then math32_3arg = (115 × 5) ÷ 19 = 30. Doubled → gain = 60. **Exact match.**

## Open questions (much narrower now)

- ~~**Loyalty/dams drain pct**~~ — **RESOLVED 2026-06-02**: `pct = (gain/2 > output) ? 50 : ⌊100·gain/(gain+output)⌋/2` (bytecode-validated, not a constant). The earlier "pct=20" was a coincidence of Test 1. A drain-only snap with `gain ≠ 0.49·output` would confirm empirically (predict drain from the live formula).
- **Does Grow's "5" change across game scenarios?** All 5 tests were the same starting save. A test from a fresh New Game on a different scenario would confirm the constant is truly hardcoded
- **Headroom clamp formula** — bytecode has the clamp but no test has ever triggered it (would need output very close to header=1640)

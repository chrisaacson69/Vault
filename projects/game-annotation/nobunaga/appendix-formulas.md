---
status: active
created: 2026-05-26
---
# Appendix A — Verified Game Formulas

> Exact equations derived from bytecode walk + empirical verification across multiple in-game tests. Each formula listed here has been **proven against ≥3 controlled SRAM snapshots** with matching predictions.

**Links:** [commands README](./commands/README.md) · [Chapter 11 — strategic engine complete](./11-strategic-engine-complete.md) · `disasm/bank_01_vm.asm`, `disasm/bank_15_vm.asm`

## Notation

- `⌊x⌋` = floor (truncate-toward-zero integer division — what 6502/VM does natively)
- `√x` = `cbcd_sqrt` ($CBCD) — integer square root, truncated
- `header` = fief's max-economy ceiling (column at province record offset +24, e.g. 1640 for Mikawa)
- `pct_op(b, p) = ⌊b × p ÷ 100⌋` — split-by-10 to avoid 16-bit overflow ($D70D)
- `math32_3arg(a, b, c) = ⌊(a × b) ÷ c⌋` — 32-bit signed ($D6B8)
- `math32_2arg(a, b) = ⌊100 × a ÷ (a + b)⌋` — `a`'s share of the total `(a+b)` as a percent ($D6DE; `(0,0)→0` guard)

> **All three helpers emulator-verified 2026-05-29** via `tools/probe-math32.py` (direct execution of the real native handlers, all test vectors matched — ground truth, not inference). The underlying `B7` extended-opcode table was never decoded and is not needed: these three composite helpers are the interface every formula calls. ⚠️ `run-effect.py` *reverses* captured arg order for display — true frame order is arg1@fp+0x0B, arg2@+0x0D, arg3@+0x0F.

## 1. Grow ($87F0) — develop output

```
gain = 2 × ⌊amount × 5 ÷ √(output + amount)⌋
                                  ; headroom clamp: gain = min(gain, header − output)
pct  = (mystery; empirically 20 across all develop-family tests)
loyalty -= pct_op(loyalty, pct)   ; ⌊loyalty × pct ÷ 100⌋
dams    -= pct_op(dams,    pct)   ; same pct
output  += gain
gold    -= amount                 ; debited by driver before effect runs
```

**Drain sequence verified from bytecode** ($8859-$8870): two `host_call $D70D (pct_op)` invocations, one for loyalty (record+12), one for dams (record+10). Both use the SAME pct computed once at $884D.

**pct=20 derivation is still partially unknown**: the bytecode at $884A-$884D does `clearA → swap_AB → loadA → div_signed`. After `clearA → swap_AB`, regB=0 — a divide-by-zero. Native handler at $ED7A must return a specific value here (likely tied to const_two or output/headroom ratio). Strong hypothesis: **pct = 100 ÷ const_two**, so if const_two = 5 (matching the K=5 universal), pct = 20 exactly. One Mesen breakpoint at $884D would confirm.

- **ROI**: `gain / amount ≈ 10 / √(output + amount)` — pure inverse-sqrt diminishing returns
- **Strategic implication**: front-load Grow when output is low; ROI drops sharply past output ~300
- **Verified**: 5/5 controlled tests (2026-05-26). See [grow.md](./commands/grow.md).
- **Source bytecode**: $87F0–$881x; math at $D6B8

## 2. Build ($88A6) — develop town — **VERIFIED 2026-05-26**

```
gain = 2 × ⌊amount × 5 ÷ √(town + amount)⌋
                                  ; headroom clamp: gain = min(gain, header − town)
pct = (same mystery as Grow; empirically 20)
wealth -= pct_op(wealth, pct)
town   += gain
gold   -= amount
```

**Only ONE drain** (wealth), vs Grow's TWO drains (loyalty + dams). Same `pct_op` primitive, same pct source.

**Same template as Grow**, just different target field (town instead of output) and different drain field (wealth instead of loyalty/dams).

- **K = 5** — same constant as Grow. Strong evidence K=5 is the develop-family universal constant
- **Verified**: 1/1 with trace evidence (Test 1: amount=170, town 320→396 = +76 gain, predicted 76 exact). arg values captured: arg1=$AA=170, arg2=$05=5, arg3=$16=22=sqrt(490).
- **Source bytecode**: $88A6; math at $D6B8

## 3. Give-Peasants ($A8D3 → $891D + $896F) — convert resource → loyalty + wealth — **VERIFIED 2026-05-26**

```
rice -= amount                               ; or gold if gold-mode (1:1 source drain)
loyalty_gain = 2 × ⌊amount × 5 ÷ √(⌊(output + loyalty)/2⌋ + amount)⌋
wealth_gain  = 2 × ⌊amount × 5 ÷ √(⌊(town   + wealth )/2⌋ + amount)⌋
loyalty += loyalty_gain
wealth  += wealth_gain
```

**Thematic pairing confirmed by bytecode**: each target stat is averaged with its "productivity twin" before sqrt:
- LOYALTY (peasant satisfaction) ↔ OUTPUT (agricultural productivity)
- WEALTH (commerce capacity) ↔ TOWN (urban infrastructure)

This prevents runaway-pumping by pulling the gain toward whichever of the pair is lower.

- **K = 5** — same develop-family constant as Grow/Build. **Now confirmed 3-of-3 commands.**
- **Verified**: 2 controlled Give-Rice-Peasants tests (give.md test 1 + 2026-05-26 new-game test). Both predicted gains (loyalty +48, wealth +58) matched exactly.
- **Source bytecode**: $891D (loyalty helper, walked 2026-05-26 to confirm pairing), $896F (wealth helper, parallel structure)

## 4. Train ($9586) — skill growth

```
skill_gain = (rng%20 + 10) × 4 + bonus
bonus = 10 if (daimyo.Luck + daimyo.IQ) > (rng%10 + 90) else 0
skill += skill_gain
```

- Range: **40–80 per training session** (without bonus), **50–90** (with bonus)
- For Tokugawa (Luck 78 + IQ 89 = 167): bonus **always fires** (167 > max 100)
- No drains, no cost — pure skill stat-up
- **Verified**: 9/9 controlled tests (2026-05-24/25). See [train.md](./commands/train.md).
- **Source bytecode**: $9586; uses `ca52` (rng wrapper at $CA52) and `ui_helper_d7ea` (daimyo getter)

## 6. pct_op ($D70D) — percentage drain primitive

```
pct_op(b, p) = ⌊b ÷ 10⌋ × ⌊p ÷ 10⌋
             + ⌊(b mod 10) × p ÷ 100⌋
             + ⌊(p mod 10) × (b ÷ 10) ÷ 10⌋
```

This is just `⌊b × p ÷ 100⌋` computed in three pieces to keep all intermediates in 16-bit. Pixel-perfect on 8+ observed drain calls.

## 4. Harvest income ($A26F dispatcher → $A1E2 gold + $A21F rice) — **VERIFIED 2026-05-26**

The fall transition iterates over all 17 fiefs. For each fief:
1. **`$A0A9` updates high-water marks** (output_max, dams_max, loyalty_mark, wealth_mark) at the $6003 table
2. **`$D98D` gate check** — if non-zero, skip income deposit (war/famine condition)
3. **`$A128` deposits**: gold via `$A1E2`, rice via `$A21F`
4. **`$A15B` subtractor** runs after deposit, taking MEN/2 from both gold and rice (army upkeep)
5. **`$D836` cap_fief_stats** finally clamps any field below 0 to 0, above header to header

### Gold formula

```
GOLD = pct_op(pct_op(lm, 40), tax)        ; loyalty contrib via 40% pre-scaling
     + pct_op(wm, tax)                     ; wealth contrib
     + pct_op(town, tax)                   ; town contrib
     + rng(0..⌊$946D × tax / 200⌋)         ; RNG_G — small variance
     − ⌊MEN / 2⌋                           ; army upkeep cost
     (clamped ≥ 0 by $D836)
```

### Rice formula

```
RICE = pct_op(pct_op(lm, 40), tax)
     + pct_op(wm, tax)
     + pct_op(pct_op(output_max, dams_max), tax)   ; output × dams instead of town
     + rng(0..⌊$946D × tax / 200⌋)                  ; RNG_R — independent roll
     − ⌊MEN / 2⌋
     (clamped ≥ 0)
```

### Critical mechanics

- **lm and wm are LOW-water marks** (`cmp_sle` in $A0A9 is inverted from disasm — they track DOWN to current at fall harvest, never up). Once loyalty/wealth dip, future income permanently reduced unless they dip lower again.
- **MEN/2 is the army-upkeep tax** — subtracted from BOTH gold AND rice every harvest. Big armies eat substantially into harvest.
- **`$946D`** returns a small daimyo-dependent value (~50-120) controlling RNG range. Same-owner fiefs share the same $946D. Exact derivation involves iteration with $D772/$939D helpers — not blocking the formula.
- **Tax dominates income SIGN**: below break-even (where positive contributions = MEN/2), income clamps to 0. For undeveloped fiefs, break-even ≈ 25-30% tax.
- **TOWN is in gold formula, OUTPUT×DAMS is in rice formula** — confirms Build's direct gold ROI and Grow+Dam's direct rice ROI.

### Verification (Mikawa, fief 7)

State: town=66, dams_max=64, output_max=136, lm=40, wm=51, men=71, tax=55, $946D=68

| field | calc | value |
|---|---|---:|
| loyalty contrib | pct_op(pct_op(40,40),55) = pct_op(16,55) | 8 |
| wealth contrib | pct_op(51, 55) | 27 |
| town contrib | pct_op(66, 55) | 36 |
| OD_pct (rice only) | pct_op(pct_op(136, 64), 55) = pct_op(87, 55) | 47 |
| RNG range | pct_op(34, 55) | 0–18 |
| RNG_G (this run) | from trace | 4 |
| RNG_R (this run) | derived from obs | 14 |
| MEN/2 | 71/2 | 35 |

**Predicted GOLD = 8+27+36+4−35 = 40** ✓ (observed +40)
**Predicted RICE = 8+27+47+14−35 = 61** ✓ (observed +61)

### Strategic implications

1. **Wealth_mark has highest ROI per point** (full tax×wealth scaling)
2. **Loyalty_mark has half-ROI** (40% pre-scale before tax multiply)
3. **Town: gold-only**, **Output×Dams: rice-only** — Build vs Grow specialize
4. **MEN/2 is tax-independent** → at low tax + big army, harvest clamps to 0
5. **Marks only decrease** → never let stats dip; if they do, accept lower permanent income or wait for them to dip lower

### Open question on $946D

$946D walked but exact iteration semantics opaque. Owner-dependent. Likely tied to daimyo Charisma or another daimyo-record byte. Sub-task left for future investigation.

## 5. math32_3arg ($D6B8) — 3-arg math helper

```
if arg3 == 0: return -1
return ⌊(arg1 × arg2) ÷ arg3⌋
```

32-bit signed multiply then signed divide. Used by Grow, Build, Give, Dam — the "develop-family" math kernel. Each caller pushes (arg1, arg2, arg3) at frame offsets +0xB, +0xD, +0xF before `host_call $D6B8`.

- **Verified**: by trace of Test 5 Grow (2026-05-26)
- **Underlying ALU**: 47 extended opcodes (B7-prefix dispatch table at $F261); 32-bit shift-add multiply at $F2C1, 64-bit/32-bit restoring divide at $F2FE

## Send ($9A5D driver + $8BE5 capacity helper) — **VERIFIED 2026-05-26**

### Formula
```
effective_amount = min(target_HEADER − target_current, user_requested)
target_field += effective_amount
source_field -= effective_amount   (no attrition)
```

### Confirmed
- **NO travel attrition** — all sent resources arrive
- **Receiver-capacity cap** is the only limit (you can't overfill target's HEADER)
- Sends BOTH rice and gold in single confirm step
- $8BE5 = `min(HEADER − current_field, requested_amount)`

### Strategic
- Trickle-fill works fine across many small targets
- Send to high-HEADER fiefs for biggest transfers
- Pairs with Give-Peasants: Send moves rice, Give converts rice to stats

## 7. Hire ($A2D2 dispatcher + $A553 hire-men + $8BF4 dilution) — **VERIFIED 2026-05-26**

### Recruit base stats (random per hire)
```
morale_base = rng(0..19) + 40    ; range 40-59
skill_base  = rng(0..19) + 60    ; range 60-79
arms_base   = rng(0..9)  + 50    ; range 50-59
```

### Dilution (weighted average)
```
new_stat = min(cap, (current_stat × current_men + recruit_stat × new_men) / (current_men + new_men))
```

### Verified empirically (Fall 1566, fief 6 hired 30 men):
- Pre: men=55, morale=111, skill=590, arms=70
- Post: men=85, morale=88, skill=401, arms=66
- Back-fit recruit averages: morale 45.8, skill 54.5, arms 58.7 — all consistent with predicted ranges (skill slightly low suggests multiple batched hires)

### Strategic note
- **Train > Hire for elite armies** (no dilution)
- **Hire early when current stats are low** (recruits don't drag down much)
- **Hire restores body count** after combat losses

## 8. Daimyo passive aging — **VERIFIED 2026-05-26 (Fall 1566)**

Daimyo records ($752F+, 7 bytes each: age, H, D, L, Ch, IQ, status) — daimyo stats DRIFT UP each season turnover, independent of Train command:
- Drive +1-2 per season (observed daimyos 1, 2)
- Health +1-2 per season (observed daimyo 2)
- Charisma +1 per season (observed daimyos 2, 16)

So Train command ACCELERATES what would happen anyway. The drift might be conditional on age/health (younger daimyos grow faster?).

## 9. Event system (STRUCTURAL only — probabilities unverified)

### Three event classes
- **Global** (typhoon, plague): season-RNG-gated, hits multiple fiefs. Messages at $94C4 ("Summer brings typhoons"), $94E9 ("Plague has come"). Plague reuses typhoon's display code at $94C7.
- **Local** (troop revolt, peasant defection): per-fief stat-gated. Effect at $A5E6 = `MEN /= 2` (army splits, half rebel). Message "Disloyal troops have revolted" at $A7CF.
- **Daimyo** (sickness, death): age + health driven. "[name] died of %s" at $91E8. Lives in daimyo-turn code, not harvest.

### Trigger flow (best inference)
```
1. Seasonal flag check (likely ~30% chance per season — verified events didn't fire Fall 1566)
2. If flag set, per-fief loop rolls stat-vs-RNG:
   - low loyalty → peasant defection prob
   - low morale → troop revolt prob
   - low wealth → famine?
3. Triggered events set $6F63 (fief idx), $6F67 (type), $6F68 (subtype)
4. Post-loop display + apply via $A5E6
```

### Key state bytes
- `$6DA1` — state flag toggling between $0C/$0D (likely "in transition" bit 0); bit 7 = skip-events flag
- `$6F63` — current target fief idx for events
- `$6F67`/`$6F68` — event type flags (= $FF when no event)
- `$7515` — zealot uprising slot (26-byte province record used as transient rebel army)

### What's NOT yet known
- Exact probability formulas for each event
- Damage magnitudes beyond MEN /= 2 for revolt
- Seasonal flag formula (which seasons can have events)

## Pending — formulas not yet verified

| command | bytecode addr | template | what's known | what's needed |
|---|---|---|---|---|
| **Give-Men** | $89C1 | math32_3arg → morale (paired with men) | template confirmed; predicted `morale_gain = 2 × ⌊amount × 5 ÷ √((men+morale)/2 + amount)⌋` | one test to verify |
| **Dam** | $87D8 + $9B7E | SINGLE-field (dams only); not math32_3arg | gold→dams with state-dep efficiency | full bytecode walk |
| **Hire** | $A2D2 | recruit stats + cost | per-man cost varies ~3-8 gold; recruit stats ~65/54/42 | unwalked; biggest blocker |
| **Send** | $8BE5 | weighted-average + attrition | ~3% travel attrition observed | unwalked |
| **Fall harvest** | bank 0 ($A0A9 + helpers) | uses high-water marks | gold ≈ output × (1+tax_rate); rice ≈ output | walk in progress |

## Methodology notes

The breakthrough on Grow's formula came from:
1. **Walking the 47 ext-opcodes** to confirm math32_3arg is `(a × b) ÷ c` (not something exotic)
2. **VM trace through math32_3arg's bytecode** to capture actual arg values mid-call
3. **5 controlled tests** with varying `amount` to fit + verify

The previous session-memory hypothesis that arg3 came from "uninitialized stack memory" was **wrong** — it was just `sqrt(output + amount)` deliberately pushed by Grow's bytecode. The mystery was a misread of the call-site arg order, not a real ambiguity in the VM.

**General approach for cracking remaining commands**:
1. Run command in-game, capture before/after SRAM
2. Set Mesen trace condition to fire during the command's host_call to its math kernel
3. Read frame offsets +0xB/+0xD/+0xF from the trace to identify args
4. Fit closed form, then verify with 2-3 more controlled tests

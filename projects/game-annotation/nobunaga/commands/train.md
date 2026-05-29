---
status: stub
created: 2026-05-24
command: Train
menu_index: 11
driver: $A637
effect: $9586
---
# 11. Train — Raise Lord's Skill

> Chapter 11: "Train raises skill against a header-derived cap." No-prompt command — just runs the effect. Chapter 10 grouped it with the "immediate-action" family.

**Links:** [commands README](./README.md) · disasm/bank_01_vm.asm (`effect_train` at $9586)

## Fields touched (CODE-DERIVED, not inferred)

- `skill` (record+20) — only field written
- **Zero cost in gold, rice, or anything**
- **No drains** — Train is a pure RNG-driven skill bump modulated by Luck+IQ

## The complete formula (walked from $9586 + $CA52 + $CA46)

```
effect_train:
    daimyo_ptr  = ui_helper_d7ea()                        ; &daimyo_record[current daimyo]
    skill_addr  = $7001 + selected_province_idx*26 + 20   ; = &province.skill
    X           = rng_next() mod 20                       ; 0..19
    skill      += (X + 10) * 4                            ; main gain: 40..116
    Y           = rng_next() mod 10                       ; 0..9
    if (daimyo.Luck + daimyo.IQ > Y + 90):
        skill += 10                                       ; +10 bonus
    return 0
```

Where:
- `rng_next()` = syscall #17 (`$C1C3` `syscall_rng_next`) — 48-bit-shift-and-add transform of wall-clock state
- `ui_helper_ca52(N)` = `rng_next() mod N` (a 6-instruction wrapper at $CA52)
- `$CA46` = RNG wrapper that fires syscall 17 (3 instructions)
- daimyo offsets per labels file: `+0=age, +1=Health, +2=Drive, +3=Luck, +4=Charisma, +5=IQ, +6=status`

**Min gain**: `40` (X=0, no bonus). **Max gain**: `126` (X=19, with bonus). **Bonus threshold**: `daimyo.Luck + daimyo.IQ > rng_next() mod 10 + 90` — fires almost always when Luck+IQ ≥ 100, never when Luck+IQ ≤ 90.

## Test runs

### Test 1: 2026-05-25, Summer 1560, Tokugawa (compound with Hire — both done same turn)

**Context**: Post-Oda-attack recovery. Tokugawa did **Hire Men** AND **Train** in the same turn, so this diff is a compound. The Hire portion is identifiable by the gold cost; everything else is Train.

| value | pre | post | Δ | likely command | notes |
|---|---:|---:|---:|---|---|
| gold | 77 | 3 | **−74** | Hire | recruited 9 men, ≈ 8.2 gold/man |
| men | 32 | 41 | **+9** | Hire | recruits |
| **skill** | **74** | **128** | **+54** | **Train** | the target field |
| **output** | **136** | **109** | **−27** | **Train** | `pct_op(136, 20) = 27` **EXACT MATCH** |
| morale | 71 | 63 | −8 | mixed | might be Hire (fresh recruits dilute) or Train drain |
| arms | 73 | 67 | −6 | mixed | might be Hire dilution or Train drain |
| (rice, dams, loyalty, wealth, town, header unchanged) | | | | | |

**MAJOR FINDING**: Train's output drain = `pct_op(output, 20)` exactly. This **confirms `pct = 20` is a real game constant** across the develop family (same value Grow Test 1 derived for its loyalty/dams drains).

**Working model — Train**:
- `skill += gain` where gain is sqrt-shaped (like Grow's output gain)
- `output −= pct_op(output, 20)`  ← drain of working-age population diverted to training
- Possibly `morale -= small_amount` and `arms -= small_amount` (TBD — split from Hire dilution)
- Costs nothing in gold (the −74 is all Hire)

**Working model — Hire** (companion finding from same diff):
- `gold −= ~8 × amount_recruited` (rate ≈ 8 gold/man here)
- `men += amount_recruited`
- Possibly dilutes morale/arms averages downward (fresh recruits)

### Test 2: 2026-05-25 (compound — Winter 1561 Hire + Asakura combat + Winter Train)

| value | pre (Fall 1561 start) | post (Spring 1562 start) | Δ | attribution |
|---|---:|---:|---:|---|
| gold | 111 | 2 | −109 | Hire (~13 men @ ~8/man) |
| men | 41 | 39 | −2 | net: +13 Hire, −15 Asakura combat |
| skill | 178 | 229 | **+51** | **Winter Train (clean reading)** |
| **output** | **109** | **109** | **0** | ⚠️ **Train did NOT drain output this time** (cf. Test 1's −27) |
| morale | 63 | 47 | −16 | Asakura combat morale hit |
| arms | 67 | 61 | −6 | combat or Hire dilution |

**Skill gain consistency**: Test 1 = +54, Test 2 = +51. Small variance suggests skill gain is mostly state-independent — possibly a fixed `gain ≈ 50-55` per Train.

**Output drain inconsistency**: This is the big puzzle.
- Test 1 (Summer 1561): `output 136 → 109 (−27)` = exact `pct_op(136, 20)` match
- Test 2 (Winter 1561, compound): `output 109 → 109 (0)` — no drain

Possible explanations:
1. The Winter drain happened but was replenished by intervening events (harvest? fall income?) between Winter Train and Spring snap. The Winter→Spring boundary has no harvest, so this is unlikely.
2. Train's drain field varies — maybe `output` is drained when output ≥ some threshold, otherwise drains a different field (`arms`? `morale`?).
3. The Test 1 "Train drained output −27" attribution was wrong — maybe that drain came from a non-Train source (a hidden event in the long Spring→Summer interval).

**Resolution required**: a CLEAN Train-only turn. No Hire, no combat. Snap immediately at start of next-fief turn. Spring 1562 Train coming up is the candidate.

### Test 3: 2026-05-25, Spring 1562, Tokugawa — CLEAN Train-only

**Context**: Solo Train, no Hire, no combat between snaps. Snap at start of next fief's turn after Tokugawa.

| value | pre | post | Δ | notes |
|---|---:|---:|---:|---|
| **skill** | **229** | **295** | **+66** | the only field that moved |
| gold | 2 | 2 | 0 | sanity ✓ (Train costs nothing) |
| output | 109 | 109 | 0 | **disproves pct=20 hypothesis for Train** |
| morale | 47 | 47 | 0 | sanity ✓ |
| arms | 61 | 61 | 0 | sanity ✓ |
| men | 39 | 39 | 0 | sanity ✓ |
| rice | 168 | 168 | 0 | sanity ✓ |
| (all other fields) | | | 0 | sanity ✓ |

**MAJOR FINDING — Train is a single-field command.** It raises `skill` and does nothing else. The Summer 1561 Test 1 "Train drained output −27" attribution was wrong. The actual cause of that output drop was something else in the Summer 1561 interval — most likely Oda-combat infrastructure damage (war damage to defender's productive capacity), since the Oda attack happened in the same interval.

**Skill gain across three tests**:
- Test 1 (Summer 1561, pre.skill=74): +54
- Test 2 (Winter 1561, pre.skill=178): +51
- Test 3 (Spring 1562, pre.skill=229): +66

The gain doesn't strictly diminish with rising skill (Test 3 was highest despite highest pre.skill). Variance suggests `gain = base + small_random` or `gain = f(some_state_not_skill)`. Possibly related to lord's leader stats (Charisma / IQ / Drive in daimyo_table_17).

**Implication for `pct=20`**: the Grow Test-1 dams match (`pct_op(80, 20) = 16`) may also be a coincidence from its confounded Spring→Fall diff. Needs a CLEAN isolated Grow test (see task #17).

## Open questions

- Does Train cost gold? The chapter-11 characterization says "Train raises skill against a header-derived cap" — no prompt for amount, so the cost (if any) is fixed.
- How is the cap derived from header? Likely `skill_max = f(header)` for some f.
- Is there per-Train diminishing returns?

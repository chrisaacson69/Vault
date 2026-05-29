---
status: active
created: 2026-05-24
---
# Lord Commands — Per-Command Test Logs

> One file per economic command. Each captures the effect-handler's bytecode shape, the inferred/derived formula, and a running log of test runs (input + observed deltas). Separating commands prevents cross-contamination as we accumulate empirical data.

**Links:** [README](../README.md) · [Chapter 9 (Grow reference decode)](../09-command-system-and-grow.md) · [Chapter 11 (all 21 commands characterized)](../11-strategic-engine-complete.md)

## Index

| # | Command | Effect handler(s) | Status |
|---|---|---|---|
| 5 | [Dam](./dam.md) | `effect_dam` ($87D8) + `helper_dam_rounding` ($887D) | stub |
| 7 | [Grow](./grow.md) | `effect_grow` ($87F0) | **1 test (gain confirmed; pct=20 provisional)** |
| 11 | [Train](./train.md) | `effect_train` ($9586) | stub |
| 13 | [Build](./build.md) | `effect_build` ($88A6) + `helper_dam_rounding` ($887D) | prepped (next-turn test) |
| 14 | [Give](./give.md) | `effect_give_a/b/c` ($A93A / $A95E / $A9D5) — 2 sub-modes (Gold/Rice × Peasants/Men) | **Test 1 logged (Rice→Peasants is 3-field, not 2-field)** |
| 17 | [Rest](./rest.md) | (no effect handler — pure turn-skip) | stub |
| 10 | [Hire](./hire.md) | `effect_hire` ($A2D2) — added because Oda forced the issue | **PRE captured, test pending** |
| 2 | (War — Oda's failed invasion captured cross-fief) | — | **combat data point #1** captured 2026-05-25 |

## The snap protocol

Mesen rewrites its live SRAM dump (`...NesSaveRam.dmp`) on every "Save Memory Dump" click. To capture pre/post snapshots:

```
py capture-test.py <tag> pre              ; immediately BEFORE issuing the command
(issue the command in-game)
(save memory dump in Mesen: Tools -> Memory Tools -> File -> Save)
py capture-test.py <tag> post             ; after the command applied
py capture-test.py <tag> diff --fief 8    ; show the diff for Tokugawa (or any --fief N)
```

Files land in `traces/<tag>_PRE.dmp` and `traces/<tag>_POST.dmp` so they survive the next overwrite.

## Isolating one command's effect

The cleanest experiment dumps **immediately after the command applies**, before any other action or season-turnover. In Mesen you can pause emulation (Pause / `F5`) at any point — pause **right after the in-game confirmation text appears** for the command, then save the memory dump.

**Confounders to expect if you can't pause mid-turn:**

| confounder | affects | mitigation |
|---|---|---|
| Fall harvest | rice (+), gold (+) | Ignore rice/gold deltas in fall snapshots |
| Tax collection | gold (+), loyalty (−), wealth (−) | Note current tax rate; if changed in the interval, the loyalty/wealth diff is mixed |
| Loyalty drift | loyalty | Small per-season drift independent of commands |
| Daimyo AI turns | every other fief's record | Don't compare other fiefs' deltas to your command's effect |

**Always note the snap context in each test row:** "snapped immediately after command" vs "snapped at start of next-N season."

## Per-fief field layout (chapter 9 §4)

Each province record is 26 bytes at `$7001 + idx*26`, all 16-bit little-endian:

| offset | field | offset | field |
|---:|---|---:|---|
| 0 | gold | 14 | wealth |
| 2 | debt | 16 | men |
| 4 | town | 18 | morale |
| 6 | rice | 20 | skill |
| 8 | output | 22 | arms |
| 10 | dams | 24 | header (base koku — development ceiling) |
| 12 | loyalty | | |

## Cross-fief data mining (16× more data points)

Each PRE/POST snap captures **all 17 fiefs**, not just Tokugawa. The AI daimyo are constantly issuing commands, and their record deltas leak their actions:

| signature pattern (Δ) | likely AI command |
|---|---|
| `loyalty +N, wealth +N` (equal) | Give-Rice-to-Peasants (Test 1 confirms this) |
| `loyalty +N, wealth +M` (close) | Give-Gold-to-Peasants? |
| `morale +N` only | Give-?-to-Men |
| `town +N` (sqrt-shape), `wealth -M` | Build |
| `output +N`, `loyalty -M, dams -K` | Grow |
| `output +N`, `debt +M` | Dam (loan-financed) |
| `skill +N` | Train |
| `men +N, gold -K` | Hire |
| `men -N, gold -N, rice -N` (equal) | War — your army marched out and was destroyed |
| `arms +1` (small) | combat winner — captured arms from defeated enemy |

So a single snap is 16 AI data points (+ 1 player). Over 4-5 turns of play, that's ~70 commands worth of (input, output) pairs to fit our formulas against.

**Caveat**: we don't know the AI's *input amount* for free, so each AI data point gives us `(pre_state, post_state)` not `(pre_state, amount, post_state)`. Use AI data to *verify* formulas, not derive them from scratch. The player snaps are still the cleanest because we control the amount.

## What we're learning, command by command

Each `effect_X` handler answers three questions:
1. **Which fields does it write?** (read directly from bytecode `loadA_ind_word` / `storeA_ind_word` sites with field offset = `record + N`)
2. **What's the formula?** (the arithmetic between sqrt, pct_op, and the 32-bit ext-op helpers)
3. **What are the silent preconditions and caps?** (the driver-level branches before the effect is even called)

Bytecode answers #1 and #3 directly from `disasm/bank_01_vm.asm`. #2 is a mix of bytecode (the operator sequence) and empirical fit (the constants math32_3arg/math32_2arg produce).

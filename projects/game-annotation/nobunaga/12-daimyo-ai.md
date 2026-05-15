---
status: active
created: 2026-05-14
---
# Chapter 12 — The Daimyo AI: A Cascade of Weighted Coin-Flips

> Chapter 11 mapped the 21 commands — the player's verbs. This chapter finds the engine that picks among them for the *other* daimyo. The static walk leads from the AI's effect-call sites up through a six-way command switch, a probabilistic decision primitive, and a decision-flag byte — and the model that emerges is strikingly simple: the daimyo AI is not a planner or a utility-maximiser. It is a **cascade of weighted coin-flips** — `RNG() mod 100` against thresholds computed from game state and tunable constants — accumulating into a flag byte that selects the action. For a 1986 strategy engine running in a bytecode VM, that is exactly the right amount of AI, and it fits the pattern this project keeps finding (Utopia's score-driven rebels, M.U.L.E.'s rubber-banded RNG).

**Links:** [Chapter 11 — The Strategic Engine](./11-strategic-engine-complete.md) · [Chapter 9 — Command System](./09-command-system-and-grow.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Nobunaga README](./README.md)

## The thread: the AI reuses the player's effects

The way in was a search, not a guess. The player's command *drivers* (the `$B9B2` table) have **zero literal callers** — the menu dispatches through the table by indirect call. But the command *effect* handlers do have callers, and they came in pairs: Grow's effect `$87F0` is called from the Grow driver `$9D95` **and** from `$B4C2`; Dam's `$87D8` from its driver **and** from `$B46C`/`$B481`. That second-caller cluster — bank 1 `$B4xx` — is the AI: **it reuses the player's effect handlers but supplies its own arguments**, because it doesn't need the "how much?" prompt — it sizes the spend itself.

From there the static walk climbed:

```
$B42B  AI develop-executor   — builds the $7001 record pointer for $6F5F,
                               reads output/dams/loyalty, sizes a spend,
                               calls the Dam/Grow/Build effect handlers
$B64B  develop sub-dispatcher — picks among $B3AA/$B42B/$B4D5 via $CA52 rolls
$B8A0  AI per-fief turn handler — announces "Turn %2d Fief %2d", runs the
                               decision cascade, dispatches via a switch
$B94C  the AI command switch  — 6 cases -> 6 executor subs
```

## The command switch — `$B94C`

`$B8A0` ends in a `$D5 switch` whose inline table decodes to a clean 6-way dispatch on an **action index** (0–5):

| action | executor | role |
|--:|---|---|
| 0 | `$B875` | executor (military / move — TBD) |
| 1 | `$B3AA` | executor |
| 2 | `$B4D5` | executor |
| 3 | `$B64B` | develop sub-dispatcher → `$B3AA`/`$B42B`/`$B4D5` |
| 4 | `$B42B` | develop executor (Dam/Grow/Build effects) |
| 5 | `$B79B` | executor (diplomacy — TBD) |
| ≥6 | `$B98D` | default — skip |

The six executors are the AI's *verbs*, and they bottom out in the same effect handlers the player's commands use. The open work here is naming `$B875`/`$B3AA`/`$B4D5`/`$B79B` by what they do — but the *shape* (one switch, six executors, shared effects) is settled.

## The decision primitive — `$CA52`

Everything upstream of the switch is built from one tiny subroutine. `$CA52` is ten instructions:

```
CA52(score, divisor):
    if score < 1:  return 0          ; a zero/negative score never fires
    return  RNG() mod divisor        ; RNG via $CA46 -> syscall_dispatch
```

`$CA46` is three instructions — it just fires the RNG syscall (`$F226`). So `$CA52` is a **guarded random roll**: a score gates whether the AI even considers an action, and if it does, the outcome is `RNG() mod divisor` — a number to compare against a threshold. This is the atom of the entire AI.

## The decision cascade — `$B8A0` before the switch

The pre-switch body of `$B8A0` is a sequence of these rolls, and it reads cleanly:

1. **Read state.** `$7FD3` (a game-phase flag), `$6001` (game-state word).
2. **Clear/seed the decision-flag byte `$6DA1`.** `regA AND $FE` clears bit 0; later `regA OR $xx` sets specific bits. `$6DA1` is the AI's working **decision bitmask** for this fief.
3. **Roll, with a state-derived threshold.** A representative gate:
   ```
   regA = word[$6D63] * 5            ; $6D63 = a config constant (= 2)
   regA = 55 - regA                  ; threshold = 55 - 2*5 = 45
   roll = CA52(45, 100)              ; RNG() mod 100
   if roll >= 45:  set a bit in $6DA1
   ```
   The threshold is **computed from game state and a tunable constant** — the AI's aggressiveness/tendency is not hard-coded, it is a parameter (`$6D63`) fed through a formula.
4. **More rolls and predicate checks.** `CA52(4, …)`, plus helpers: `$D982` is a bare predicate (`value < 8`), `$D628` is a scan-with-predicate over a `$6D9D`-bounded range. Each result writes another bit of `$6DA1`.
5. **The accumulated `$6DA1` flags + the state reads resolve to the action index**, and `$B94C` dispatches it.
6. **`$D609`** — *"Hit any key"* — pauses so the human can watch what the AI did.

## The model

Put together, the daimyo AI is:

> **a cascade of weighted coin-flips.** Each potential action is a `RNG() mod 100` roll against a threshold derived from the fief's state and a config constant; the roll outcomes accumulate as bits in a decision byte (`$6DA1`); the byte selects one of six executors; the executor reuses the player's own effect handlers with AI-chosen arguments.

What it is **not** is as informative as what it is. There is no search, no lookahead, no board evaluation, no minimax. The AI does not *plan* — it *reacts*, fief by fief, with biased randomness. The bias is the design: thresholds move with game state (a poor fief rolls differently from a rich one) and with tunable constants (the difficulty/personality knobs).

This is the third time the project has found this shape. Utopia (1981) drove its rebels off score deltas; M.U.L.E. (1983) rubber-banded its event RNG by player rank; Nobunaga (1986) gates its command choice on state-weighted rolls. **Era-appropriate AI is a probability budget, not a planner** — and decoding it means decoding *the thresholds and the constants*, because those, not any algorithm, are where the "intelligence" lives.

## What's open

- **The four un-named executors** — `$B875`, `$B3AA`, `$B4D5`, `$B79B`. `$B42B` (develop) is traced; the others are reached but not walked. Likely move, war, diplomacy, and one more — each a short walk.
- **The threshold formulas** — each `$CA52` site has its own `score` and `divisor` expression. Cataloguing them (and the constants `$6D63`, `$6D9D`, …) *is* cataloguing the AI's personality. This belongs in the effect-formula **appendix**.
- **The turn loop & the economy cycle** — `$B8A0` has no literal callers; it is reached per-daimyo, driven by the `$6F0B` turn-order permutation. The loop that sequences daimyos — and triggers the seasonal harvest/economy update between rounds — is the next structural piece, and the last big one before combat.
- **`$6DA1` bit semantics** — which bit means what. A short focused trace or a few more rolls decoded would finish this.

With the decision engine characterised, the project now has *both* halves of the strategic layer — the player's 21 commands (ch 9–11) and the AI that picks among the same verbs (ch 12). The turn loop stitches them together; combat and the synthesis counter-graph follow.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

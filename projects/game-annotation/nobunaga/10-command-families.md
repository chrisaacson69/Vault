---
status: active
created: 2026-05-14
---
# Chapter 10 — The Command Families: Eight Handlers for the Price of One

> Chapter 9 traced one menu command — Grow — all the way down, building the scaffolding (the command driver table, the calling convention, the province-access idiom, a control-flow-following disassembler) along the way. This chapter spends that scaffolding. It diffs the seven handlers that the `$B9B2` table grouped with Grow and shows that the "family" splits cleanly into **two real templates** — and that within each, the commands are the *same code parameterized by a province field offset, a set of message IDs, and an effect handler.* Eight commands, decoded for roughly the cost of two.

**Links:** [Chapter 9 — Command System & Grow](./09-command-system-and-grow.md) · [Chapter 8 — VM Instruction Set](./08-vm-instruction-set.md) · [Nobunaga README](./README.md)

## The signature was too coarse

`command-table.py` grouped table indices **4, 5, 6, 10, 12, 13, 14, 15** together because they share an eight-byte opening signature. That signature, decoded, is just the province-access idiom from chapter 9 — `regA = word[$6F5F] × 26 + $7001`, "pointer to the selected province's record." *Every* command opens that way. So the eight-byte grouping is real but shallow: it means "operates on the current province," not "is the same command."

Disassembling all eight with the flow-following tool splits them on a sharper line: **does the handler call `$D5E9`** — the number-input prompt?

- **Prompt-and-apply** (`$D5E9` present): indices **4, 6, 12, 14**.
- **Immediate-action** (no `$D5E9`): indices **5, 10, 13, 15**.

That single fact — "does it ask the player for an amount" — is the genuine family boundary.

> All field names below use the **confirmed `$7001` layout** (chapter 9 §5d, chapter 7 erratum): `gold@0 debt@2 town@4 rice@6 output@8 dams@10 loyalty@12 wealth@14 men@16 morale@18 skill@20 arms@22 header@24`, little-endian. Field *offsets* are read directly from the bytecode; field *names* are the verified mapping.

## Template A — prompt-and-apply (idx 4, 6, 12, 14)

These four are one piece of code. The driver skeleton, identical across all four:

```
record = $7001 + selectedProvince*26
precondition A : compare two record fields; on fail, show a message and return
precondition B : if word[record+24] (header) == 0, show a message and return
display the current value
amount = $D5E9(cap, 1)         ; number-input prompt, capped at a record field
if amount == 0: return         ; silent cancel
word[record+0] -= amount       ; deduct the cost from GOLD
result = <effect handler>(record, amount)
display result ; redraw ; return
```

And the effect skeleton (chapter 9 §5b/5d) is equally fixed: `amount < 1` guard → `$CBCD` integer square root of `field + amount` → `− word[$6D63]` (a global constant, **= 2**, grounded from the SRAM dump) → `$D6B8` 32-bit helper → clamp against `field@24` → the flat-100 branch → `$D70D` percentage redistribution out of other fields.

What varies — the entire content of the diff (command names confirmed from the in-game menu, item N = table index N+1):

| idx | command | driver / effect | grows (√ target) | redistributes from | notes |
|---:|---|---|---|---|---|
| 6 | **Grow** | `$9D3D` / `$87F0` | **output** (`@8`) | dams (`@10`), loyalty (`@12`) | fully traced in ch 9 |
| 12 | **Build** | `$A858` / `$88A6` | **town** (`@4`) | wealth (`@14`) | effect also chains `$887D` |
| 4 | **Dam** | `$9B83` / `$87D8` + `$887D` | **output** (`@8`) + **debt** (`@2`) | — | two effect handlers — a two-field command |
| 14 | **Bribe** | `$AAB3` / `$8D4D` | **town** (`@4`) + **debt** (`@2`) + **output** (`@8`) | — | largest; shares the `$E510/$879F/$804C` cluster with Pact (idx 5) |

So the readable picture: **Grow develops agricultural output, Build develops the town (commerce), Dam touches output and debt, Bribe is the compound diplomatic-spend command.** Every one costs **gold** (debited from `field@0`, the prompt capped at it) and every one is gated by **`header == 0`** and a development-ceiling precondition. The √-curve diminishing returns and the silent cross-field drain are universal to the template — they are not Grow-specific quirks, they are *how this whole class of command works.*

That Bribe rides the same template as Dam/Grow/Build is a small surprise worth noting: mechanically, "bribe a target" is built as "spend gold to move province fields" — the same shape as developing your own land, just pointed elsewhere. And Bribe sharing the `$E510/$879F/$804C` cluster with **Pact** (the immediate-action group, below) means that cluster is the **diplomacy subsystem** — the two diplomatic commands both invoke it.

That is a strong result for the counter-graph: four menu options that look independent are one mechanic with four parameterizations, and they share a cost model (gold), a curve (√), and a hidden tax (redistribution).

## Template B — immediate-action (idx 5, 10, 13, 15)

These four never call `$D5E9` — they take no amount from the player. They read the province's current state and act directly. They are *not* a single parameterized template the way Group A is; they share the province-access opening and not much else. Characterized from their field-touch and call patterns (names confirmed from the menu):

| idx | command | driver | touches | calls | reading |
|---:|---|---|---|---|---|
| 5 | **Pact** | `$9C54` | debt (`@2`, **byte** ops) | `$E510 $879F $CEC4 $804C $8B8F` | diplomacy — the `$E510/$879F/$804C` cluster is the diplomacy subsystem (shared with Bribe, idx 14) |
| 10 | **Train** | `$A63C` | header (`@24`), skill (`@20`), men (`@16`) | `$CEC4` | trains troops — reads men/skill against a header-derived cap, raises skill |
| 13 | **Give** | `$AA24` | header, morale (`@18`), loyalty (`@12`), wealth (`@14`), town (`@4`) | `$A93A $A9D5 $A95E` | charity to the people — touches the most fields (loyalty/morale up); three bank-1 helpers |
| 15 | **Assign** | `$AD6C` | men (`@16`) | `$AC11` | assign a retainer — a men-comparison gate then a single word store |

The names make these legible: **Pact** is diplomacy (and confirms the shared cluster's role), **Train** raises skill against a cap, **Give** is the loyalty/morale charity command, **Assign** moves a retainer. None prompts for a number because none *needs* one — they are state transitions, not investments.

Two things stand out. First, the immediate-action commands lean on **byte-level** field access (`loadA_ind_byte`/`storeA_ind_byte`, opcodes `$D3`/`$D4`) where Group A used word access — they are editing sub-fields or flags, not whole 16-bit stats. Second, the `$E510 / $879F / $804C` call cluster appears in **both idx 5 and idx 14**, which means there is a shared sub-system (cross-province? military?) those two commands both invoke — a thread worth pulling in a later chapter.

## What the diff bought us

Chapter 9 cost a full session and produced one decoded command plus a pile of reusable infrastructure. This chapter, on that infrastructure, decoded **seven more** — four of them (Group A) to full structural clarity, three of them (Group B) to a confident characterization — in a fraction of the time. That is the flywheel doing exactly what it was built to do.

The honest limits:

- **Menu names — resolved.** The full command menu, transcribed from the game: Move, War, Tax, Send, Dam, Pact, Grow, Marry, Trade, Hire, Train, View, Build, Give, Bribe, Assign, Rest, Map, Grant, Other (save), Pass. Item N = table index N−1; item 7 = Grow = index 6 matches the trace. So the 21 menu commands are indices 0–20; the remaining table entries (21–33) are sub-handlers, not top-level menu items.
- **Group B internals.** Pact, Train, Give, Assign are characterized, not fully traced. Each is a ~30-minute walk now that the convention is known.
- **The shared clusters.** `$E510/$879F/$804C` is the **diplomacy subsystem** (Pact + Bribe both call it); the bank-1 helpers `$A93A/$A9D5/$A95E` belong to Give. Named here, not yet opened.

## What's open

- **The display-command family** — table indices 20–32, the `8E xx / host_call $D326` group from chapter 9's command-table survey. Twelve commands, almost certainly status/info screens; a cheap sweep.
- **The unique commands** — indices 0, 1, 2, 3, 7, 8, 9, 11, 17, 19 — the special actions (war, move, cede, search…). Each is its own decode, but the calling convention and province idiom carry straight over.
- **The `$D5E9` prompt routine itself** — Group A's shared input primitive. Decoding it tells us exactly how the amount cap is computed and enforced.
- **Chapter 7's body rewrite** — still queued; the erratum at its head carries the corrected layout in the meantime.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

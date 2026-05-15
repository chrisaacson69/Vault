---
status: active
created: 2026-05-14
---
# Chapter 11 — The Strategic Engine, Complete: All 21 Lord Commands

> Chapters 9 and 10 traced Grow and diffed its family. This chapter walks the remaining thirteen menu commands and assembles the whole picture: every action a player can take on their turn, what it costs, what it touches, and what it tells us about the game's strategic design. With the flow-following disassembler and the in-game-text resolver from chapter 9, each command's *driver* gives up its structure on one pass — the strings it shows are, quite literally, the game narrating its own mechanics. By the end the **strategic engine is mapped end to end**: 21 commands, five functional groups, one shared UI substrate.

**Links:** [Chapter 9 — Command System & Grow](./09-command-system-and-grow.md) · [Chapter 10 — Command Families](./10-command-families.md) · [Chapter 7 — SRAM Save Layer](./07-sram-save-layer.md) · [Nobunaga README](./README.md)

## Method: the strings narrate the mechanics

Once `op_8E push_imm_word` operands resolve to text (chapter 9), a command driver reads almost like a screenplay. `"Tax is %d\nEnter new tax"` followed by `"The peasants are protesting!"` / `"The peasants are delighted!"` *is* the Tax mechanic — set a rate, the peasantry reacts. So this chapter characterizes each command from its driver: the prompts it shows, the preconditions that gate it, the cost it charges, and the helper subroutines it calls. This is **structural characterization, not formula tracing** — the per-command effect handlers (the exact numbers) are a later pass — but it is enough to lay out the complete action space.

## The thirteen remaining commands

### Military

**Move** (`$96D6`) — relocate troops between your own provinces. Prompts: *"Move where?"* (province select via `$804C`), *"How many men"* (`$D5E9` number input), *"Will you lead them personally"*. Success: *"They have arrived safely"*. Gated by capacity — *"That fief can't hold more men"*. The lead-personally choice matters because the lord's presence is a combat modifier (see Chris's offense/defense note — a thin-leader vs. castle-leader decision starts here).

**War** (`$9855`) — launch an attack. Heavy pre-roll setup (`$9368`/`$9351`/`$9323`/`$933A`/`$9814` — combat-prep subroutines), then *"Attack where?"*, blocked by *"They are your allies!"*. Prompts: *"How many men"*, *"How much rice will they take"* (supplies — the doughnut-fief attrition mechanic lives downstream of this), *"Will you lead them personally"*. War is the **front end to combat**; the battle resolution itself is elsewhere (a later chapter).

**Hire** (`$A5F9`) — recruit. *"Recruit which"* → *"(Men/Ninja)?"* — the type prompt routes through `$D351`, and the recruiting logic proper is `$A2D2`. A short driver; the substance is in the callee.

**Train** (`$A637`) and **Assign** (`$AD67`) — decoded in chapter 10 (the immediate-action group). Train raises skill against a header-derived cap; Assign places a retainer.

### Province development

**Dam, Grow, Build** — the prompt-and-apply template from chapter 10. Spend gold, get a √-curve gain in one province field (Dam→output+debt, Grow→output, Build→town), with a silent percentage drain from other fields and a `header`-gated development ceiling.

### Diplomacy

**Pact** (`$9C4F`) — chapter 10's immediate-action group; invokes the `$E510/$879F/$804C` cluster, now identifiable as the **diplomacy subsystem**.

**Bribe** (`$AAAE`) — chapter 10's prompt-and-apply group, but pointed at a *target's* fields rather than your own; shares the diplomacy cluster with Pact.

**Marry** (`$9DC9`) — alliance by marriage. Select a fief, and they name a price: *"Lord %s, %s wants %d gold. Pay"*. Pay → *"Your bride-to-be has arrived"*; can't afford → *"You have no gold!"*; they decline → *"Lord %s they've refused!"*. (Flavor: *"Don't you long to hear the pitter-patter of a li[ttle one]"*.) Costs gold, outcome not guaranteed.

### Resource & economy

**Tax** (`$999F`) — set the tax rate. *"Tax is %d\nEnter new tax"* (`$D5E9`), and the peasantry reacts immediately: *"The peasants are protesting!"* or *"The peasants are delighted!"* — the loyalty consequence of taxation, surfaced right in the command. `$82D6` (called twice) applies the result.

**Send** (`$9A62`) — transfer resources between your own provinces. *"Send where?"*, then *"Rice"* (`$D5E9`) and *"Gold"* (`$D5E9`), each capped (*"We're at our limit"*), then *"Is this OK"* → *"The supplies have arrived safely"*. The internal-logistics command — and the reason the turn-order randomization (`$6F0B`) bites: you may want to Send before you attack, but the receiving fief might act first.

**Trade** (`$A1BB`) — deal with a traveling merchant. *"Lord, how may I serve you?"* opens a buy/sell submenu (`$B1A6`); requires a merchant present (*"No merchant in the area"*). Closes with *"Let's do business again"* / *"Bye!"*.

**Give** (`$AA1F`) — chapter 10's immediate-action group; the loyalty/morale charity command, touches the most province fields.

### Information & administration

**View** (`$A6CC`) — inspect a fief. Free for your own; **spying on others costs gold** (*"You have no gold!"* gate) and can fail — *"Our spy was caught"*. A *"(99-view vassals)"* sub-option. View is both the information command and the **espionage** command.

**Map** (`$AF3D`) — render the strategic map. 18 instructions, no prompt, no cost — pure display (`$E5F2`/`$AF10`).

**Rest** (`$ADB8`) — *"Seasons"* (`$D5E9`: how many) → *"It will do you good"*. The lord skips turns to recover (health/age interplay).

**Grant** (`$AF6B`) — set a province's policy "state". *"Which fief"* → *"What are your orders?"* → a submenu (`$B1A6`); *"It's currently a %s state, OK to make it a %s state"*, confirmed with *"Lord, you are truly wise!"*. Already-set states are rejected (*"It's already a %s state"*).

**Other** (`$B243`) — the settings/save menu. *"Change which?"* + the `$B1A6` submenu.

**Pass** (`$B2A6`) — five instructions. Show one message, end the turn.

## The complete action space

| # | command | group | cost / gate | prompts | what it does |
|--:|---|---|---|---|---|
| 1 | Move | military | dest capacity | dest, #men, lead? | relocate troops between own fiefs |
| 2 | War | military | not vs. allies | target, #men, #rice, lead? | launch an attack (→ combat) |
| 3 | Tax | economy | — | new rate | set tax rate; peasants react (loyalty) |
| 4 | Send | economy | per-field caps | dest, rice, gold, confirm | transfer resources between own fiefs |
| 5 | Dam | development | gold; `header`≥field | amount | √-raise output (+debt), drain others |
| 6 | Pact | diplomacy | — | (diplomacy subsystem) | form a pact/ceasefire |
| 7 | Grow | development | gold; `header`≥output | amount | √-raise output, drain dams+loyalty |
| 8 | Marry | diplomacy | gold (demanded); refusable | which fief | alliance by marriage |
| 9 | Trade | economy | merchant present | buy/sell submenu | trade with a merchant |
| 10 | Hire | military | — | Men/Ninja | recruit troops or ninja |
| 11 | Train | military | `header`-derived cap | — | raise skill |
| 12 | View | information | gold (to spy); can fail | which fief | inspect own / spy on others |
| 13 | Build | development | gold; `header`≥town | amount | √-raise town, drain wealth |
| 14 | Give | economy | — | — | charity → loyalty/morale |
| 15 | Bribe | diplomacy | gold | amount | spend gold against a target |
| 16 | Assign | military | — | — | assign a retainer |
| 17 | Rest | misc | — | #seasons | lord rests (recover) |
| 18 | Map | information | — | — | show the strategic map |
| 19 | Grant | administration | — | which fief, policy | set a province's policy "state" |
| 20 | Other | misc | — | submenu | settings / save |
| 21 | Pass | misc | — | — | end the turn |

## Reviewing the mechanics

A few things the full picture makes clear:

**Gold is the master resource.** Of the 21 commands, the ones that *cost* anything cost **gold** — Dam, Grow, Build, Bribe, Marry, and the spying mode of View. There is no separate "action point" economy; your turn is bounded by your treasury (and by the per-province `header` development ceiling). Tax is the only command that *generates* gold, and it does so against a loyalty cost — the central economic tension of the game is the **tax↔loyalty tradeoff**, and it's surfaced literally ("protesting" / "delighted").

**Development is deliberately lossy.** Dam/Grow/Build don't just add — they add on a √ curve *and* silently subtract a percentage from other fields (chapter 10). Combined with the `header`-gated ceiling, province development is a game of **managed decline**, not free growth. A player optimizing one stat is always paying in another.

**Three of the 21 are pure information** (View, Map) **or pure pacing** (Rest, Pass) — the engine budgets real screen time for *looking* and *waiting*, not just acting. View doubles as espionage, which folds information-gathering into the same risk economy as everything else (it costs gold, the spy can be caught).

**The diplomacy subsystem is real and shared.** Pact and Bribe both route through `$E510/$879F/$804C`; Marry is adjacent. Diplomacy isn't flavor — it's a coherent subsystem with its own machinery, sitting alongside the military and economic ones.

**One UI substrate underneath all 21.** Every command is built from the same parts: `$804C` (province select), `$D5E9` (number input), `$CEC4` (confirm/yes-no), `$D326`/`$D134` (text / formatted text), `$B1A6` (generic option submenu), `$E80C` (commit & display result). The command drivers are thin orchestration over a fixed widget set — which is exactly why decoding one (Grow) made the other twenty cheap.

## What's open

The **command layer** is now mapped. What remains for the strategic engine:

- **The effect formulas.** Each command's effect handler (Grow's `$87F0` is the only one fully traced) holds the exact numbers — Tax's rate→loyalty curve, War's combat-strength roll, Marry's success probability, Send's caps. These are the per-command deep dives, each now a short walk.
- **The shared subsystems.** `$B1A6` (the submenu used by Trade/Grant/Other), the `$E510/$879F/$804C` diplomacy cluster, and `$D5E9` (the input primitive with its cap logic) — naming these opens several commands at once.
- **Combat resolution.** War is the front end; the battle itself — on the per-fief tactical maps Chris described (doughnut, chokepoint, the offense/defense leader tradeoff) — is the next major system.
- **The daimyo AI.** The 21 commands are the player's verbs; the AI uses the same verbs. The decision engine that chooses among them is the counterpart to this chapter.

With the command set complete, the project has the player's half of the strategic engine. Combat and AI are the other half — and then the synthesis chapter can draw the dominance-frontier counter-graph the project was built for.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)

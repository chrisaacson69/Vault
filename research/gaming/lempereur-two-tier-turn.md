---
status: active
created: 2026-07-05
---
# L'Empereur — the two-tier turn: KOEI's NES→SNES design hinge

> KOEI's **8th** NES strategy title (computer 1990 / NES 1991), decompiled to the bank. Read as
> *software*, L'Empereur is a **transitional specimen**: the same family engine and start-of-turn
> skeleton as the earlier NES conquest sims, but with a new **country→province two-tier turn** that
> the 16-bit titles would formalize. Grounded in `LEmp-decompiler` (all 18 code banks named).

**Links:** [How KOEI's NES AI & combat evolved](./koei-ai-combat-evolution.md) (the five-decompiler
study this extends structurally) · [The Hollow Opponent](./hollow-opponent-perceived-depth.md)
(the shallow-AI reading it sits beside) · repo `LEmp-decompiler` → `docs/03-completion.md`. Engine
finding reused: the [[project_koei_e2e3_native_trampoline]] native-call ABI.

## The finding: two command phases, not one

Every KOEI NES conquest sim opens a turn the same way — a start-of-turn **events + monthly upkeep**
pass (L'Empereur: bank 17 `advance_turn` → calendar roll → scheduled events → the seasonal per-country/
per-city batch: tax, food/materials, starvation, officer aging, disasters). That skeleton is
family-invariant; it is the shared spine every title in the line inherits.

What L'Empereur **adds** is a split in the *action* phase that follows. Bank 1 (the `$8000` turn/command
library) runs **two separate loops with two separate cursors**:

1. **Country / strategic phase** — iterate the 15 countries in turn order (table `$6FF2`, cursor
   `mem_6FF0`); for each whose ruler `general_can_command`, run **`sub_8039`** (`mem_76A2` = the
   *country*, `$7068+`). Here live the **country-scoped** commands: diplomacy (bank 5), national
   give / ceremony (bank 4's `distribute_food_all` / `cmd_hold_ceremony`), the info screens (bank 6).
2. **Province phase** — a *fresh* city turn-order table is built (`sub_90A4(0x7002, 46)`), then iterated
   (cursor `mem_6FF1`); for each city whose governor can command, run **`sub_80C0`** (`mem_7CD1` = the
   *city*, `$7176+`) — recruit / develop / arrange / etc.

Country phase first, province phase second — and the computer plays the same shape: **`sub_AC1C`**
(ai_run_country_turn) runs scripted-event → `ai_choose_diplomacy` (country) → `ai_run_turn_actions` →
`ai_run_domestic_loop` (cities). The earlier NES titles are *flatter*: you drop straight into
per-fief / per-officer orders with **no distinct national tier**. This country tier is the structural
move — a layer of decision *above* the map — that the SNES conquest sims (RoT3K III+, the 16-bit
Nobunaga titles) formalize. L'Empereur is where it first appears in the NES line.

> *[interpretation, flagged]* We have only decompiled the NES corpus; the SNES alignment is an informed
> read of the design lineage, not a decompiled comparison. What is **code-confirmed** is the two-phase
> loop itself (two cursors `mem_6FF0`/`mem_6FF1`, two order tables `$6FF2`/`$7002`, two dispatch subs).

## Simplifications and retentions

- **Tax is now a command, and thin.** *[confirmed]* It is a per-city **policy flag** (`+27`, bit `&32`)
  set by `cmd_set_policy` (bank 4); the turn engine's `collect_tax_income` (bank 17) reads that flag and
  auto-converts commerce → gold. No variable rate, no loyalty-penalty curve like Nobunaga's tax dial —
  a binary policy plus automatic collection. The knob became a switch.
- **Orders still ride on officers, not just provinces.** *[confirmed]* The officer-holds-an-army model
  is family-invariant back to ROTK1 (game 1): `cmd_arrange` distributes soldiers/horses/guns onto
  officers (`+9/+10/+11`), and a battle unit **is** an officer + army. So there are *two* allocation
  layers — the per-turn national **order budget** (`mem_705F = 2`, set at the top of each country turn)
  *and* the per-officer army — which is exactly the texture you feel: commanding generals, inside
  provinces, inside countries.

## Branding and setting

- **Dual branding, GemFire-era.** *[confirmed via ROM strings]* The title screen carries the ASCII
  company brand `**KOEI` (bank 0) and `Press Start Button` (bank 16); the **L'Empereur** production
  title itself is a CHR-tile logo (not ASCII). The opening is a scripted Napoleon cinematic — `Vive
  l'Empereur`, Josephine ("wife of Napoleon"), *"Brave soldiers, follow my command! I will lead you to
  victory and fame!"* This is the same present-the-company-brand-plus-the-localized-title packaging
  GemFire uses (US "Gemfire" ⟵ JP "Royal Blood"); by game 7–8 KOEI is fully into that dual-label habit.
- **The period is the run-up, not just the wars.** *[confirmed]* The engine's year base is **1790**
  (`age_in_officers` gates officers on `year − 1790`), so scenarios open in the **revolutionary window
  before Napoleon's ascent** — the game models the European conditions that *produced* him, which most
  players know far less well than Austerlitz or Waterloo. A deliberate, and unusually didactic, framing.

## Where it sits in the arc

The AI/combat study reads the five earlier decompilers and finds KOEI **experimenting**, not climbing a
single upgrade curve. L'Empereur adds a **structural** datapoint to that story: the studio was also
experimenting with the *turn container* — and here it lands on the two-tier country→province shape the
16-bit generation would keep. Same engine, same start-of-turn function, one new layer of decision above
the map. A hinge title: last of the NES conquest sims, first with the SNES-era turn architecture.

## Tags
[koei](../../tags/koei.md) · [reverse-engineering](../../tags/reverse-engineering.md) · [nes](../../tags/nes.md) · [game-design](../../tags/game-design.md)

---
status: draft
created: 2026-10-11
---
# MOO1 Random Events — Three-Way Cross-Check
> Stream (forced events on the v1.3 binary) × Official Strategy Guide ch.14–15 × 1oom source. Field map of the 822-byte events block, odds formula (year − last-event-year, scaled by difficulty, of 512), and the OSG numbers the binary contradicts. **Draft — verdicts marked OCR-SUSPECT / UNRESOLVED await Chris's rulings (Questions section).**

**Source:** [raw/videos/moo1-re/](../../../raw/videos/moo1-re/README.md) via the [stream digest](./zappatic-re-stream.md) — <https://www.youtube.com/playlist?list=PLZVzPYU15yts>
**Source:** [raw/books/moo1-osg/](../../../raw/books/moo1-osg/README.md) — OSG OCR text; `OSG:NNNN`/`LNNNN` cite its line numbers
**Source:** 1oom — <https://github.com/1oom-fork/1oom> at commit `42e9c0b` (no local capture; `file:line` cites are against that commit)

**Links:** [zappatic RE stream](./zappatic-re-stream.md) · [MOO1 Optimal Strategy](./optimal-strategy.md) · [Data-First RE](../../../method/data-first-re.md) · [Diplomacy cross-check](./xcheck-diplomacy.md)

**Sources and how they are cited**
- **STREAM**: `Vault/research/gaming/moo1/zappatic-stream/part06.md` / `part08.md`, cited as `p6 [H:MM:SS]` / `p8 [H:MM:SS]`. Struct offsets come from `Vault/raw/videos/moo1-re/zappatic-site/zapdebugger-moo.json` (`structs.events`, 332 fields, 0x336 = 822 bytes; offsets computed by summing the field types). A few items were checked against the raw caption file `raw/videos/moo1-re/part06-2m4pVDNvwOA.txt`, lines 56–60.
- **OSG**: `Vault/raw/books/moo1-osg/MasterOfOrionStrategyGuide_opt_djvu.txt`, cited as `OSG:<line>`.
- **1OOM**: `scratchpad/1oom/`. Paths are relative to `src/game/` unless they start with `doc/`. The authoritative byte map of the events block is `doc/format_gam.txt:292-378`. `game_save_moo13.c:376-430` loads only the persistent subset.

**Verdicts.** AGREE = all available sources agree. BUG-v1.3 = the binary (1oom code with no fix marker) differs from what the OSG documents; this does not decide which one is "wrong". STREAM-ERROR = the stream's reading conflicts with the byte map or the code. OCR-SUSPECT = an OSG number is probably garbled. 1OOM-CHANGE = 1oom deviates from v1.3, either always or as an option. UNRESOLVED = the sources conflict and nothing settles it. NEW = a fact that only one source has, or that the cross-check derived.

**Faithfulness assumption.** A 1oom code path counts as v1.3 behaviour unless it carries a `WASBUG` or `MOO1 ...` comment, or appears in `doc/list_gamediff.txt`, `doc/list_pbxnum.txt` or `doc/pbxin_fixbugs.txt`. None of these mention the event *generation* code except `accident_chk_factories` and `event_roll`.

---

## Summary

- **The stream's indexes are 1-based.** Stream "index N" is word **N−1** of the events block, not word N. In the JSON, field 26 (0-based) is `trigger-quake` at byte 0x34, while the notes call it "index 27". Every stream index lines up with `doc/format_gam.txt` under N−1. The block's RAM base is **DS:B8E0**: three RAM addresses the stream quoted give the same base (B914−0x34, B924−0x44, B92A−0x4A).
- **Field map.** The stream's events-block map matches 1oom/format_gam for all 16 event slots except one. The stream's "nova predicted vs averted" boolean (0x40) is really **`nova_years`**, the countdown. The "success" it saw on screen is explained by `nova_val` (0x42), which stays 0 when the event is forced by poking. Several stream "unknowns" now have names: comet/nova/accident "unused" words are the event's *player* field, 0xAC is `report_stars`, 0x206 is spies-caught, and 0x292 is a ceasefire countdown.
- **The stream's "unknown 87" and its 605/606 threshold** (0xAC, `report_stars`) come from **16-bit overflow** in the "X controls N% of the stars" news test `((rs+1)*half)/4 <= max_pl` (`game_event.c:1123`). On a huge map, half = 54. 607·54 = 32778 overflows a signed 16-bit value; 606·54 = 32724 does not. So the condition fires from rs ≥ 606, which is exactly what the stream measured by bisection. A negative value makes `ns.subtype` negative, so v1.3 indexes the news table backwards. That is why negative values fire unrelated GNN strings. (Derived here; 1oom stores this field as `uint8_t`, so it cannot show the effect.)
- **Event odds.** The binary uses `chance = (year − lastEventYear) × {1/2, 2/3, 3/4, 4/5, 1}` and fires an event when `rnd(1..512) ≤ chance` (`game_event.c:187-211`). The new-game value of "last event year" is **40** (`game_new.c:1029`), which is the stream's constant "40" header word. The OSG's difficulty *ratios* match (1 : 1⅓ : 1½ : 1⅗ : 2), but its absolute "percent" units and its "no events before turn 50" do not.
- **Victim selection (BUG-v1.3).** The OSG says victims are weighted by the square of gross production, with good events favouring the weak and players with 4 or fewer planets immune. The code does none of this. It weights by **planet count**, multiplies **human players' weight ×5**, makes no good/bad split, and gives everyone a minimum weight of 1 (`game_event.c:34-71`).
- **Many OSG numbers differ from the code.** Several of these look like documentation errors rather than OCR damage:
  - comet HP: OSG 400–600 vs code 275–475
  - pirate HP / trade damage: OSG 300–450 HP, 60–90% vs code 330–570 HP, 55–95%
  - plague cure cost: OSG 3–10× vs code (1–8 + 2·difficulty)×
  - nova timer and cost: OSG 5–15 vs code 7–15
  - quake minimum population: OSG 30 vs code 50
  - accident minimum factories: OSG 30 vs none in v1.3, confirmed explicitly by 1oom (`game_event.c:236-240`, `doc/list_pbxnum.txt:233-237`)
  - Guardian HP: OSG 6–10k vs code 2–10k; the stream observed 2000
  - monster rest: OSG 2–3 turns vs 4 in both the code and the stream
- **Eligibility gates the OSG never mentions** (`game_event.c:225-265`):
  - comet only from year 100, crystal/amoeba only from year 200, and only one monster at a time
  - Silicoids are immune to plague and industrial accident
  - derelict happens to **AI players only**; rebellion happens to **human players only**
  - pirates need the victim to have an active trade partner
  - assassination needs an AI that has a NAP or alliance with the victim
- **Disable cheat.** It is Alt + typing `EVENTS` on the Control screen; the stream's "hold Alt" is incomplete (OSG:33820, OSG:34590, `ui/classic/uistarmap.c:260,318`). The off-state is not saved (OSG:33826; `game.c:88`). Turning events off **cancels every in-progress event** (`game_event.c:169-186`) but does **not** clear the "already happened" list. This contradicts OSG:33836-33839, which says the list resets. The chance keeps accumulating while events are off (agrees with OSG:33840).
- **Guardian.** HP is 2000/4000/6000/8000/10000 by difficulty (`game_parsed.c:132-168`) against the OSG's 6000–10000. The kill gives the Death Ray plus up to 3 random techs of level 20–50, capped at your field percent + 25 (`game_tech.c:939-974`); the OSG agrees (OSG:34384-34400) and the stream saw 3–4 techs. The "Guardian defeated by" save word is `0xE68A`, with 1000 = none. The "win condition" word is `0xE686 end` (0 none, 1 exile, 2 won, 3 final war), which explains why the stream needed exactly 2.

---

## Field map — events block (save 0xDE80, RAM DS:B8E0, 0x336 bytes)

Stream "#N" is 1-based, so word = N−1 and byte offset = 2(N−1). 1oom names come from `game.h:197-269`. Offsets come from `doc/format_gam.txt:292-378`.

| Off (word) / RAM | Stream # / meaning | 1oom field + save offset | Match? |
|---|---|---|---|
| 0x00 (w0) / B8E0 | #1 "header 40" (p6 [2:10:00]) | `evn.year`, year of last event, @DE80. New game sets it to 40 (`game_new.c:1029`) | ✓ — explains the constant 40 |
| 0x02 (w1) | #2 "header 30" (p6 [2:10:00]) | "? always 30, never used" (`format_gam.txt:295`) | ✓ (both unknown) |
| 0x04–0x2B (w2–21) | not identified | `evn.done[20]`, event-has-happened flags (`format_gam.txt:296`; `game_event.c:226,272`) | NEW |
| 0x2C–0x33 (w22–25) | plague "not yet located" (p6 open Qs) | `have_plague` 0..3, `plague_player`, `plague_planet_i`, `plague_val` @DE AC–DEB3 | NEW |
| 0x34 / B914 | #27 trigger quake (p6 [3:05:00]) | `have_quake` | ✓ |
| 0x36 | #28 quake player, "only text" | `quake_player`; used only for human/AI wording (`game_event.c:485`); race is taken from `p->owner` (`:481`) | ✓ |
| 0x38 | #29 quake planet | `quake_planet_i` | ✓ |
| 0x3A | #30 nova state 0/1/2 | `have_nova` 0..3 (3 = resolved; reset to 0 the same turn, `:547`) | ✓ |
| 0x3C | #31 "unknown, unused" | `nova_player`; not read by `game_event_run`, which uses `p->owner` (`:493`) | ✓ explained |
| 0x3E | #32 nova planet | `nova_planet_i` | ✓ |
| 0x40 | #33 "nova predicted/averted" bool (p6 [3:40:00]–[3:50:00]) | **`nova_years`** countdown (`:310,502,505`) | ✗ STREAM-ERROR |
| 0x42 | (unnamed) | `nova_val`, cure cost remaining (`:311,498`) | NEW |
| 0x44 / B924 | #35 accident state | `have_accident` 0..2 | ✓ |
| 0x46 | #36 "unknown" | `accident_player`; sets news race and wording (`:562-578`) | NEW |
| 0x48 | #37 accident planet | `accident_planet_i` | ✓ |
| 0x4A / B92A | #38 assassination trigger | `have_assassin` | ✓ |
| 0x4C | #39 "target player (emperor)" | `assassin_player2`, the AI that declares war (`:333,592`) | ✓ |
| 0x4E | #40 "assassin player" | `assassin_player`, the event victim; news race (`:320,590`) | ✓ |
| 0x50/0x52/0x54 | #41–43 virus trigger/player/field | `have_virus`/`virus_player`/`virus_field` | ✓ |
| 0x56 | #44 comet state | `have_comet` 0..3 | ✓ |
| 0x58 | #45 "unknown, maybe success" | `comet_player`; not read by run, which uses `p->owner` (`:621`) | ✓ explained |
| 0x5A | #46 comet planet | `comet_planet_i` | ✓ |
| 0x5C | #47 years to collision | `comet_years` | ✓ |
| 0x5E | #48 destroy target; 0 crashes | `comet_hp`; it is the divisor in the news "%" (`:651`), so 0 divides by zero | ✓ explained |
| 0x60 | #49 destroy progress | `comet_dmg` | ✓ |
| 0x62 | #~50 pirate state | `have_pirates` 0..3 | ✓ |
| 0x64 | #51 "no effect" | "?" (`format_gam.txt:325`); no 1oom field | ✓ |
| 0x66 | #52 pirate planet | `pirates_planet_i` | ✓ |
| 0x68 | #53 pirate progress (signed; saw −20) | `pirates_hp` (uint16, saturating subtract, `:704`) | ~ see mechanics table |
| 0x6A/0x6C | #54/55 derelict trigger/player | `have_derelict`/`derelict_player` | ✓ |
| 0x6E | #56 crystal state | `crystal.exists` 0..3 | ✓ |
| 0x70/0x72 | #57/58 X/Y | `crystal.x/y` | ✓ |
| 0x74 | #59 wait counter | `crystal.counter` (int8) | ✓ |
| 0x76 | #60 "destroyed flag; credits human fleet" | `crystal.killer`, stored as 0 = none or killer id + 1 (`format_gam.txt:334`; `game_save_moo13.c:33-37`). Writing 1 means "player 0 killed it" | ✓ explained |
| 0x78 | #61 target planet | `crystal.dest` | ✓ |
| 0x7A | #62 planets visited | `crystal.nuked` (planets wrecked; >4 → leaves) | ✓ |
| 0x7C–0x88 | #63 amoeba state "+ same layout (assumed)" | `amoeba.*`, same layout (`format_gam.txt:337-343`) | ✓ (assumption confirmed) |
| 0x8A/0x8C | #70/71 fertile trigger/planet (p8 [2:05:00]) | `have_enviro`/`enviro_planet_i` | ✓ |
| 0x8E/0x90 | #72 deep-mining trigger/planet | `have_rich`/`rich_planet_i` | ✓ |
| 0x92/0x94 | donation trigger/recipient | `have_support`/`support_player` | ✓ |
| 0x96/0x98 | #76 depleted trigger/planet | `have_poor`/`poor_planet_i` | ✓ |
| 0x9A | #78 player-conquered-Orion bool (p8 [2:15:00]) | `have_orion_conquer`, 0 or player+1 | ✓ (it is an id, not a bool) |
| 0x9C | #79 Orion planet ID (p8 [5:30:00]) | `planet_orion_i` | ✓ |
| 0x9E | (unnamed) | `have_guardian` | NEW |
| 0xA0–0xAB | #81 home planet IDs[6] (p8 [4:55:00]) | `home[6]` (−1 = dead) | ✓ |
| 0xAC | #87 "news-event related", 606 threshold (p8 [4:45:00]) | `report_stars` 0..4 (`format_gam.txt:356`; `game_event.c:1105-1135`) | ✓ explained (see Summary) |
| 0xAE–0xEB | "40,30,30,13,7,−1" unidentified (p8 [2:20:00]) | "?" (`format_gam.txt:357`) | UNRESOLVED (both) |
| 0xEC | #119 = −1 (p6 [2:15:00]) | coup player (−1, 0..5) (`format_gam.txt:358`) | NEW |
| 0xEE | #120 breakthrough "trigger" → count (p8) | new-tech num | ✓ |
| 0xF0/0x10E | field[15] / tech id[15] | new-tech field / tech index | ✓ |
| 0x12C | researcher type: 0 scientist, 1 spy, 2 trooper; 3 crashes (p8 [4:40:00]) | source: 0 research, 1 spy, 2 found, 3 choose/AI spy, 4 trade (`format_gam.txt:362`) | ~ UNRESOLVED (3 crashes vs "choose/AI spy") |
| 0x14A | research planet id; −1000 values seen | val1: giver race / ruins planet (>0) / −artifact planet / **−1000 = Orion** | ✓ (explains −1000) |
| 0x168/0x186 | (unnamed) | val2 race stolen from / can-frame | NEW |
| 0x1A4 | fleet-production ships[6] (p8 [5:50:00]) | new ships[6] | ✓ |
| 0x206 / BAE6 | #260 toggled 1/2 near a rebellion (p6 [2:35:00]) | inside spies-caught (their)[6] @0x1FE → entry 4 | NEW (tentative) |
| 0x292 / BB72 | counted 16→5→0 (p6 [2:35:00]–[2:50:00]) | inside `ceasefire[6]` @0x28E (years) → entry 2 | NEW (strong) |
| 0x2E2–0x2F5 | master's-notes one-shot bools (u8) | `help_shown` 20 bytes | ✓ |
| 0x2F6 | info-panel click countdown | build-finished number | ✓ |
| 0x2F8/0x30C | panel planet u8[20] / panel type u8[20] | build-finished planet / type ("0=?,1=eco1,2=eco2,3=?") | ✓ (stream's enum is more complete) |
| 0x320–0x32B | six −1, never read next turn (p8 [3:45:00]) | `voted[6]`, only read at Council elections | ✓ |
| 0x32C–0x335 | "405/407/408 → 5 at research moments" (p8 [3:55:00]) | `best_ecorestore`, `best_wastereduce`, `best_roboctrl`, `best_terraform` | ~ plausible; exact words ambiguous |

**Save tail** (`format_gam.txt:50-53`):
- `0xE686 end` (0 none, 1 exile, 2 won, 3 final war) is the stream's "bigger win condition, needs 2" (p8 [0:50:00]). It matches the enum in `game_types.h:169-175`.
- `0xE688 winner`.
- `0xE68A guardian killer` (player id or 1000) is the stream's `guardian_defeated_by`, 1000 = unassigned ✓.
- `0xE68C election held`.

---

## Mechanics table

1oom line numbers are `game_event.c` unless another file is given.

| Event | Aspect | Stream | OSG | 1oom (v1.3-faithful?) | Verdict |
|---|---|---|---|---|---|
| All | Earliest year | silent; header word = 40 (p6 [2:10:00]) | none before turn 50; accumulation starts turn 51 (OSG:32998-32999) | `chance = year − evn.year`, with `evn.year` = 40 at new game (`:187-191`; `game_new.c:1029`). After the integer difficulty scaling, the first nonzero chance is year 41 (Impossible) or year 42 (other levels) | BUG-v1.3 (OSG 50 vs code 40) |
| All | Per-turn odds | silent | +1 / 1⅓ / 1½ / 1⅗? / 2 "percent" per turn (OSG:33044-33049, OCR); "+2% × modifier, d100" (OSG:35686-35688); Impossible averages 25–30 turns (OSG:33008) | `rnd_1_n(512) ≤ chance × {½, ⅔, ¾, ⅘, 1}` (`:193-211`); `event_roll` = 512 (`game_num.c:37`). At 1/512 per turn the mean wait on Impossible is about 28 turns, which matches OSG's 25–30; 2% per turn would give about 9 | BUG-v1.3 (OSG "percent" mis-scaled; ratios AGREE) |
| All | Reset | slots are one-at-a-time (p6 [3:20:00]) | probability resets to 0 when an event fires; each event happens once per game (OSG:33002-33016) | `evn.year = year` and `done[type] = 1` only when an event fires (`:271-272`). A failed pick does not reset the chance | AGREE |
| All | Victim | silent | weighted by gross production squared; good events favour weak players; players with ≤4 planets are immune (OSG:33054-33070) | weight = max(1, ⌊n′/D⌋), where n′ = planets (0 if fewer than 4; ×5 if human) and D = max(5, min over all 6 slots); always 5 with fewer than 6 players (`:34-71`, FIXME at `:52`). A random planet of the victim is picked next (`game_planet.c:87-101`); Orion aborts the event (`:218`) | BUG-v1.3 |
| All | Type pick | silent | "randomly selected from those not yet occurred", then target (OSG:35690-35692) | player and planet are picked first, then up to 5 tries at a type from 1..16. If all are ineligible there is no event that turn (`:223-270`) | BUG-v1.3 (order and failure mode) |
| All | Disable | "hold Alt on main screen" (p6 [4:35:00], from web search) | Alt + type EVENTS on the Control screen; shows "Events Off" (OSG:33820-33825) or "No Events" (OSG:34590-34596); off-state not saved (OSG:33826) | `uiobj_add_alt_str("events")` (`ui/classic/uistarmap.c:260,318`); overlay text "No Events" (`game_str.c:327`); flag cleared on load (`game.c:88`) | STREAM-ERROR (incomplete); OSG self-inconsistent on the label (code says "No Events") |
| All | While disabled | — | list resets when re-enabled; chance keeps building (OSG:33836-33846) | Clears every `have_*` flag, which cancels nova/comet/plague/pirates/monsters already in progress. Does **not** clear `done[]`. Chance keeps building because `evn.year` is untouched (`:169-186`) | Chance: AGREE. List reset: UNRESOLVED. Cancelling: NEW |
| All | News race when planet is unowned | defaults to "Human"; stream guesses a guard (p6 [3:50:00]–[4:00:00]) | silent | MOO1 reads `eto[-1]` (out of bounds); 1oom substitutes RACE_HUMAN (`:526,631,838,928,946,980` WASBUG) | BUG-v1.3 (stream's "guard" guess is wrong: it is an OOB read that happened to give 0) |
| Plague | Eligibility | not located | colony with ≥30 pop (OSG:33323) | no population check; Silicoids excluded (`:235`) | BUG-v1.3 |
| Plague | Cure cost | — | 3–10 × gross production (OSG:33331-33332) | `(rnd(1..8) + 2·diff) × prod_after_maint` (`:299`). Easy (diff 1) gives exactly 3–10 | BUG-v1.3, or the OSG documents Easy only |
| Plague | Pop loss | — | 5–10% per turn until cured (OSG:33325) | `(rnd(1..6)+4)% of pop`, applied only after the first turn (`:420`) | AGREE |
| Plague | Progress / end | — | cure paid via planet's tech spending; no research gained (OSG:33333-33339) | `plague_val −= planet tech output`; ends at ≤0; planet changing owner ends it (`:418-433,463`) | AGREE |
| Plague | Quarantine | — | no outbound transports (OSG:33346-33350) | `game_misc.c:231` | AGREE |
| Plague | News quirk | — | — | first-turn `num1` is an uninitialised stack variable in MOO1 (`:425` WASBUG); ongoing reminder shown to humans with 10% chance per turn (`:439`) | NEW |
| Quake | Eligibility | forced; works anywhere | random colony with ≥30 pop (OSG:33225) | `p->pop < 50` excluded (`:228`) | BUG-v1.3 / OCR-SUSPECT |
| Quake | Effect | random pop/factory loss applied directly, not stored (p6 [3:05:00]–[3:10:00]) | 21–30% pop, 31–80% factories, no waste (OSG:33227-33231) | `(rnd(1..10)+20)%` pop, `(rnd(1..50)+30)%` factories (`:473-476`) | AGREE |
| Nova | Eligibility | — | any star in the empire except home (OSG:33711-33712) | no home exclusion; only Orion excluded (`:218`) | BUG-v1.3 |
| Nova | Countdown | field 0x40 read as a bool (p6 [3:45:00]) | 5–15 turns (OSG:33713) | `rnd(1..5) + 10 − diff` = 11–15 (Simple) … 7–11 (Impossible) (`:310`); decrements only while the planet is owned (`:494-503`) | BUG-v1.3 / OCR-SUSPECT; stream field: STREAM-ERROR |
| Nova | Cure cost | — | 5–15 × gross production (OSG:33718-33720) | `(rnd(1..5) + 10 − diff) × prod_after_maint` (`:311`); paid by planet tech output (`:497-501`) | BUG-v1.3 / OCR-SUSPECT |
| Nova | Averted | "state 2 + 0x40 off = success" (p6 [3:45:00]) | reatomizer stabilises the star (OSG:33714-33721) | `nova_val ≤ 0` → state 3, no blast (`:499-501`). A poked event has `nova_val` = 0, so it always reads as "saved". At state 1 with years ≤ 0 the planet **blows up but the news says saved** (subtype 2, because `nova_val` is not > 0) (`:505-538`) | STREAM-ERROR (cause misattributed); NEW (predicted poke artefact) |
| Nova | Blast | — | max pop 11–20; survivors 1..max; 80–100% of factories lost; radiated (OSG:33724-33736; "1 1" = 11) | max_pop = `rnd(1..10)+10`; pop = min(pop, rnd(1..max)); factories keep `(rnd(1..3)+1)/20` (10/15/20%, so 80–90% lost); RADIATED, HOSTILE; unowned → pop 0 (`:507-518`) | AGREE except factory range (BUG-v1.3, minor) |
| Nova | News race | follows planet owner (p6 [3:50:00]) | — | `player = p->owner` (`:493`) | AGREE |
| Accident | Eligibility | forced anywhere | planet with ≥30 factories (OSG:33244) | no check in v1.3; optional fix `accident_chk_factories` (`:236-240`; `doc/list_pbxnum.txt:233-237`; `doc/pbxin_fixbugs.txt:31-32`); Silicoids excluded (`:235`) | BUG-v1.3 (1oom confirms explicitly); 1OOM-CHANGE when the option is on |
| Accident | Effect | planet becomes radiated/polluted (p6 [3:10:00]–[3:20:00]) | radiated permanently; waste = max pop − 10; max pop halved (OSG:33245-33259) | `max_pop3 /= 2`; `max_pop2 = min(…)`; `waste = max_pop3 − 10`; RADIATED, HOSTILE (`:567-571`) | AGREE |
| Accident | End | stays at 2 until cleaned, then 0 (p6) | cleanup is quick (OSG:33256) | when `waste == 0` → "cleaned" news, state 0 (`:576-581`) | AGREE |
| Assassin | Eligibility | — | silent | needs an AI with NAP..alliance with the victim; game not ended (`:232,250-265`) | NEW |
| Assassin | Effect | target race angry; no success path found (p6 [3:20:00]–[3:30:00]) | automatic war; perpetrator's relation set to −75 (OSG:33207-33215) | `game_diplo_start_war(player2, player)` sets relation to `−75 − rnd(1..25)` (`game_diplo.c:221`); human gets diplo msg type 13, value 100 (`:592-596`). No success branch exists | AGREE (OSG −75 vs −76..−100: minor BUG-v1.3) |
| Virus | Field | computers and force fields seen (p6 [3:30:00]) | random among computer, force field, weapons, propulsion (OSG:33180-33186) | `rnd(0..3)` → computer/force field/propulsion/weapon (`:341-348`) | AGREE |
| Virus | Effect | "subtracts RP"; e.g. 70 → 0 but news said "110" (p6 [3:30:00]–[3:35:00]) | investment becomes zero (OSG:33175-33179) | `investment = 0`; news shows the old value, clamped to 32000 and shown as 100 if 0 (`:609-611` comment) | AGREE on effect; news "110": UNRESOLVED |
| Comet | Eligibility | — | silent | year ≥ 100 (`:233`) | NEW |
| Comet | Timer | counts down 1 per turn (p6 [3:55:00]–[4:20:00]) | 10 − diff + rnd(1..5): Simple 11–15, Impossible 7–11 (OSG:33160-33168) | identical (`:355`); decrements only if the planet is owned (`:633-642`; "BUG?" at `:623`) | AGREE; unowned freeze: NEW |
| Comet | HP | target "about 500" (some captions "5,000") | random 400–600 (OSG:33114-33115, OSG:33157) | `(rnd(1..5) + 10 + diff) × 25` = 275–375 (Simple) … 375–475 (Impossible; difficulty is 0–4, `game_types.h:96-102`) (`:356`) | BUG-v1.3; stream "5,000": STREAM-ERROR |
| Comet | Damage | progress grows 3, 14, 37…; 499 vs ~500 still won (p6 [4:05:00]–[4:20:00]) | per ship 1/5/25/125 by hull if ≥⅓ of the hull is weapons, otherwise proportional (OSG:33116-33155) | Σ over designs of `rnd(1..hull_w[design0.hull]) × ships` with hull_w = {1,5,25,125} (`:626-628`; `game_num.c:75`). Random up to the hull weight, **no weapon check**, and the hull is always read from **design 0** (`sd` never advances) | BUG-v1.3 (weapon rule absent); NEW (design-0 hull quirk, no WASBUG marker) |
| Comet | Win / lose | progress ≥ target → destroyed | failure leaves the planet uninhabitable (OSG:33113-33114) | `dmg > hp` → stopped; years ≤ 0 → `game_planet_destroy`, NOT_HABITABLE (`:635-648`) | AGREE (strict >) |
| Comet | Map | not shown on map | — | no coordinates in the struct | AGREE |
| Pirates | Placement | forced on own planet | random system, excluding Orion while the Guardian lives (OSG:33276-33277) | `rnd(0..stars−1)`, Orion **not** excluded (`:361`). Needs the victim to have a trade partner (`:73-83,234`) | BUG-v1.3 |
| Pirates | HP | starts random positive (p6 [4:20:00]) | 300–450 (OSG:33283-33284) | `(rnd(1..5) + 10 + diff) × 30` = 330–450 (Simple) … 450–570 (Impossible) (`:362`) | BUG-v1.3 / OCR-SUSPECT |
| Pirates | Damage taken | drops each turn; two orbiting scouts cleared them; field went to −20 (p6 [4:25:00]) | same as comets; monsters passing through wipe them (OSG:33278-33281, OSG:33293) | ships of **all** players orbiting, by hull weight (same design-0 quirk); a living monster on the star does 32000; saturating subtract (`:690-704`) | AGREE; negative value: UNRESOLVED (1oom saturates at 0, uint16) |
| Pirates | Trade damage | "by 0%" text seen once (p6 [4:25:00]) | 60–90%, falls with HP; hits players in contact with the host race (OSG:33292-33308) | setback = hp/6 %. **Every turn**, `trade_percent` of each player with the star in fuel range is multiplied by (100 − setback)/100, both directions, so the loss compounds (`:706-723`). Ongoing news has a 10% chance per turn (`:730`). "0%" = hp < 6 | BUG-v1.3 (range and targeting); stream "0%" AGREE |
| Derelict | Eligibility | forced on human; worked (p6 [4:30:00]) | "the player who discovers" (OSG:33094) | **excluded when the victim is human** (`:231`) | UNRESOLVED (code vs OSG intent) |
| Derelict | Effect | "numerous weapon and shield secrets" | all weapon/force-field techs on own list up to +10 levels, max 10, random (OSG:33099-33108) | per field (weapon, force field): tier = percent/5; gets `researchlist[field][i][0]` for i < tier + 2 (`:758-767`) | BUG-v1.3 |
| Rebellion | Slot | not in events block (p6 [2:35:00]) | non-home planet; half pop becomes rebels (OSG:33354-33358) | no event fields: sets `p->rebels = pop/2`, `unrest = REBELLION` directly (`:368-372`); **human victims only**, home excluded (`:227`) | AGREE (explains stream); human-only: NEW |
| Rebellion | News | — | — | MOO1 counts other rebel planets with `i < players` (`:792` WASBUG) | NEW |
| Crystal / Amoeba | Eligibility | — | silent | year ≥ 200; only one monster at a time (`:229-230`) | NEW |
| Crystal / Amoeba | Spawn and speed | spawns at (0,0) if X/Y unset (p8 [5:05:00]) | random map edge; warp 1; ≥1 turn warning (OSG:33379-33387) | random edge, first dest = edge-cell star (`:85-118`); `counter = 2` (`:378`); moves 5+6 units per turn only while `counter ≤ 0` (`game_turn.c:836-852`) | AGREE |
| Crystal / Amoeba | Rest | waits about 4 turns after arriving (p6 [4:30:00]–[5:05:00]) | 2–3 turns (OSG:33392-33395) | `counter = 4` on arrival; decrements each turn (`:863,876`). Cannot be attacked while resting (`doc/list_pbxnum.txt:78-80`) | BUG-v1.3 (stream and code agree) |
| Crystal / Amoeba | Next target | — | random star within 6 parsecs (OSG:33396) | adjacent grid cell (±1 column/row), habitable, not Orion (`:120-150`) | UNRESOLVED (units) |
| Crystal / Amoeba | Leaves | visited ≥ 5 → "mysteriously disappeared" | after five planets (OSG:33399-33400) | `nuked > 4` → state 3 → subtype 2 (`:835,890`) | AGREE |
| Crystal / Amoeba | Killed | destroyed flag credits human (p6 [4:45:00]) | — | `killer = id+1` on disk; news names the killer's race (`:838-839`; `game_battle.c:116-121`) | AGREE (explained) |
| Amoeba | Effect | — | all pop, 90% of industry; radiated; max pop 10–25 (OSG:33404-33408) | pop 0, factories /10, RADIATED, max_pop = `rnd(1..3)×5 + 5` ∈ {10,15,20}, `game_planet_destroy` (`:851-857`) | BUG-v1.3 / OCR-SUSPECT (max pop) |
| Crystal | Effect | — | all pop killed; factories kept; waste = max − 10 (OSG:33455-33464, OSG:33513) | pop 0; `waste = max_pop3 − 10` (`:851,859`) | AGREE |
| Monsters | HP | — | amoeba 1000·(d+1); crystal 3000–7000 (OSG:33412-33416, OSG:33516-33525, OSG:34280-34302) | amoeba 1000..5000, crystal 3000..7000 (`game_parsed.c:38-121`) | AGREE |
| Monsters | Last planet | — | — | wrecking a player's last planet kills that player (`:866-874,904-909`) | NEW |
| Fertile | Eligibility | trigger + planet; slot not cleared afterwards (p8 [2:05:00]) | excludes fertile/Gaia (OSG:33235-33239) | also excludes types below Minimal and special > Normal (artifacts/rich/ultra-rich) (`:241-242`) | AGREE + NEW extra exclusions |
| Fertile | Effect | — | becomes fertile | `game_turn_soil_enrich(p, terraform_n, 0)` (`:929`; `game_misc.c:867-892`) | AGREE |
| Rich | Eligibility | "deep mining" | excludes rich/ultra-rich (OSG:33267-33272) | excludes special > Normal (incl. artifacts) (`:243-244`); can upgrade a Poor planet | AGREE |
| Poor | Eligibility | "depleted" | excludes poor/ultra-poor (OSG:33198-33203) | excludes special < Normal and artifacts; can downgrade Rich/Ultra-rich (`:245-246`) | AGREE |
| Donation | Amount | 500 BC both times (p8 [2:05:00]–[2:20:00]) | 10 × turn number (OSG:33219-33221) | `max(500, ⌊year·10/100⌋·100)` (`:960-961`) | BUG-v1.3 (floor and rounding missing from OSG); stream AGREE with code |
| Orion conquest | News | "race conquered Orion" string exists (p8 [4:45:00]–[5:35:00]); bool persists | — | MOO1 has the news item but never shows it (`doc/list_pbxnum.txt:52-54`); 1oom option `news_orion`; uses `done[17]` (`:1148-1158`; `game_turn.c:1015,1241`) | AGREE; 1OOM-CHANGE (option) |
| Guardian | HP | 2000 in combat UI (p8 [0:50:00]; difficulty unknown) | 6000–10000 (OSG:34119-34120, OSG:34304-34314) | 2000/4000/6000/8000/10000 (`game_parsed.c:132,141,150,159,168`) | BUG-v1.3 / OCR-SUSPECT (stream supports code if that game was Simple) |
| Guardian | Repair specials | — | Automated Repair at Hard, ADC at Impossible (OSG:34127-34129) | MOO1: ADC shown at Hard (with repair 15), nothing at Impossible; fixed by `pbxin_fixbugs` (`doc/pbxin_fixbugs.txt:9-16`; `game_parsed.c:156-168`) | BUG-v1.3 |
| Guardian | Weapons / shield | — | Scatter Pack X 5/25/45/65/85, Stellar Converter 5–45, Plasma Torpedo 6–18, Death Ray ×1; shield/defense 5–9 (OSG:34316-34362, OSG:34373-34377) | weapon counts identical; absorb 5..9 ✓; **beam/missile defense 1/3/5/7/9** (`game_parsed.c:128-170`) | AGREE except defense (UNRESOLVED) |
| Guardian | Reward | news + 3–4 techs; setting the killer word fires it (p8 [0:40:00]–[1:45:00]) | Death Ray + up to 3 random techs L20–50, ≤ +25 over current, off-list allowed (OSG:34384-34400) | `game_tech_get_orion_loot` (`game_tech.c:939-974`), triggered by `guardian_killer` (`:1137-1146`) | AGREE |
| Win | End word | 2 = "returns to Orion" ending; 1 semi-crash; 3 nothing; winner name always the player (p8 [0:50:00]–[1:00:00]) | — | `0xE686`: 1 exile, 2 won (Council), 3 final war (`game_types.h:169-175`); name = `emperor_names[g->winner]` (`game_turn.c:1336-1339`) | AGREE on enum; winner name: UNRESOLVED |
| Stars news | 0xAC | ≥606 increments +1/turn; negatives fire GNN strings (p8 [4:45:00]–[5:35:00]) | GNN reports who leads expansion (OSG:32981-32984) | `report_stars` test (`:1122-1134`); see Summary for the overflow derivation | NEW (derived; 1oom uint8 cannot reproduce) |

---

## Formulas (1oom; `game_event.c` unless noted)

- **Chance**: `c = max(0, year − evn.year)`, then c ×= ½, ⅔, ¾ or ⅘ (Simple…Hard; integer division), ×1 on Impossible. An event fires if `rnd_1_n(event_roll=512) ≤ c` (`:187-211`; `game_num.c:37`). `evn.year` starts at 40 (`game_new.c:1029`).
- **Victim**: `n_i` = planets owned; `n_i = 0` if `n_i < 4`; `n_i ×= 5` if human. `D = max(5, min over i=0..5 of n_i)`. Weight `w_i = max(1, ⌊n_i/D⌋)` for real players; pick with `rnd(0..Σw−1)` (`:34-71`).
- **Plague**: `cost = (rnd(1..8) + 2d) × prod_after_maint` (`:299`). Each later turn: `cost −= tech_prod(planet)`, `pop −= (rnd(1..6)+4)·pop/100` (`:418-422`).
- **Quake**: `Δpop = (rnd(1..10)+20)·pop/100`; `Δfact = (rnd(1..50)+30)·fact/100` (`:473-476`).
- **Nova**: `years = rnd(1..5) + 10 − d`; `cost = (rnd(1..5) + 10 − d) × prod_after_maint` (`:310-311`). Each turn while owned: `cost −= tech_prod`, `years−−`. Blast: `max_pop = rnd(1..10)+10`, `pop = min(pop, rnd(1..max_pop))`, `fact = min(fact, (rnd(1..3)+1)·fact/20)` (`:507-518`).
- **Accident**: `max_pop3 /= 2`; `max_pop2 = min(max_pop2, max_pop3)`; `waste = max_pop3 − 10` (`:567-569`).
- **Comet**: `years = rnd(1..5) + 10 − d`; `hp = (rnd(1..5) + 10 + d)·25`. Per turn: `dmg += Σ_designs rnd(1..hull_w[design0.hull]) · ships_in_orbit`; stopped if `dmg > hp`. News % = `dmg·100/hp` (`:355-357,626-651`). `hull_w = {1,5,25,125}` (`game_num.c:75`).
- **Pirates**: `hp = (rnd(1..5) + 10 + d)·30`; `hp = max(0, hp − Σ_all players damage)`, or −32000 if a living monster sits on the star. `setback = hp/6`; per turn for each player p1 with the star in fuel range, for every other player p2: `trade%[p1→p2] = trade%·(100−setback)/100`, and the same for p2→p1 (`:362,690-723`).
- **Derelict**: for field ∈ {weapon, force field}: `tier = percent/5`; grant the first tech of research-list tiers `0..min(tier+1, TIER_NUM−1)` (`:758-767`).
- **Rebellion**: `rebels = pop/2`, `unrest = REBELLION` (`:369-371`).
- **Monsters**: spawn `counter = 2` (`:378`). On arrival: pop 0. Amoeba: `fact /= 10`, RADIATED, `max_pop = rnd(1..3)·5 + 5`, planet destroyed. Crystal: `waste = max_pop3 − 10`. Then `nuked++`, `counter = 4`, new dest = random neighbour cell (`:846-864,120-150`). Leaves when `nuked > 4` (`:835`).
- **Donation**: `bc = max(500, (year·10/100)·100)` (`:960-961`).
- **Orion loot**: Death Ray; then 3 × (up to 200 tries): `field = rnd(0..5)`, `tech = rnd(1..31)+19`, accepted if `tech ≤ min(percent+25, 50)` and not already known (`game_tech.c:939-974`).
- **Stars news**: fires if `((rs+1)·⌊stars/2⌋)/4 ≤ max_planets`, or if `rs == 3 && half−2 ≤ max < half`; then `subtype = rs++`, shown if `< 4` (`:1122-1134`).

---

## Questions for Chris

Each one should be answerable in one line from the printed OSG or from play experience.

1. **OSG:33044-33049, Table 14-1** (OCR: "1 percent / IVs percent / iy 2 percent / 1% percent / 2 percent"). Are these 1, 1⅓, 1½, 1⅗ (or 1¾?), 2? The code's ratios (×½, ⅔, ¾, ⅘, 1, then ×2) predict 1⅓, 1½ and **1⅗** for Easy, Average and Hard.
2. **OSG:32998**: does the print say "turn 50"? The binary initialises "last event year" to 40, so events become possible from about year 41–42.
3. **OSG:33115 / OSG:33157**: is comet HP printed as "400 to 600"? The code gives (11..15 + d)·25 = 275–475 (d = difficulty 0–4).
4. **OSG:33284 / OSG:33292**: pirates "300 and 450" HP and "60 and 90 percent"? The code gives 330–570 HP and hp/6 = 55–95%.
5. **OSG:33332**: plague cure "3 to 10 times"? The code gives (1..8 + 2·difficulty)×, which is exactly 3–10 only on Easy.
6. **OSG:33713 and OSG:33719**: nova "5 to 15" turns and "5 to 15 times"? The code gives 7–15 for both, depending on difficulty.
7. **OSG:33734**: nova destroys "80 to 100 percent" of factories? The code gives 80/85/90%.
8. **OSG:33408**: amoeba leaves max pop "10 to 25"? The code gives 10, 15 or 20.
9. **OSG:33225**: earthquake needs "30 or more" pop? The code requires pop ≥ 50.
10. **OSG:34119 / OSG:34306-34314**: Guardian HP 6,000–10,000? The code gives 2,000 on Simple rising to 10,000. Do you remember the Guardian having 2,000 HP on Simple?
11. **OSG:34316-34326**: are Guardian beam/missile defense 5–9, or are only shields 5–9? The code has absorb 5–9 but defense 1/3/5/7/9.
12. In play, has a **human** player ever received the *Ancient Derelict* event? The code gives it to AIs only.
13. In play, has an **AI** empire ever had the *rebellion random event*, as opposed to unrest-driven rebellion? The code limits it to humans.
14. Have you seen **pirates base at Orion** while the Guardian was alive? The OSG says no; the code does not exclude it.
15. After toggling Alt-EVENTS off and back on, did events that had **already happened recur**? The OSG says the list resets; the code keeps `done[]`. Separately: did toggling off **cancel an in-progress nova or comet**?
16. Is the Alt-EVENTS overlay text "Events Off" (OSG:33824) or "No Events" (OSG:34594 and 1oom)?
17. Lore: what is the in-game name of the end state 2 ending that the stream calls "returns to Orion"? Is it the Council-win ending?
18. Lore: the OSG's "Why Me?" says good events go to weak players by production. Did that ever match your experience, or did events feel human-targeted? The code makes humans 5× as likely per planet.

---

## Gaps

- **v1.3 binary not read directly.** Every "BUG-v1.3" verdict rests on 1oom being faithful where it carries no marker. The stream's forcing tests confirm many outcomes (quake, accident, comet, crystal, donation 500, the 606 overflow) but never measured spawn odds, victim weights or eligibility gates.
- **Comet/pirate design-0 hull quirk** (`game_event.c:625-627`) has no WASBUG comment. Whether v1.3 really reads design 0 for every design is unverified.
- **Pirate HP going negative** (stream −20) vs 1oom's saturating unsigned subtraction. 1oom may have normalised this; unverified.
- **Virus news "110" vs investment 70**: not explained. It may be a caption mishearing of "100" (the 0 → 100 display rule) or a different value being read off the screen.
- **Researcher/source type 3**: crashes in the stream (SPIES.LBX), while format_gam calls it "choose/AI spy". Unresolved.
- **Winner name ignoring the adjacent word** (stream) vs 1oom using `emperor_names[winner]` at 0xE688. Which word the stream poked is unknown.
- **0xAE–0xEB** (stream's "40,30,30,13,7,−1") is unnamed in both sources.
- **0x206 spies-caught attribution** is inferred only from the offset (RAM base B8E0). The stream's "1/2 near a rebellion" observation is not explained.
- **The stream's Guardian game difficulty** is not stated, so its 2000 HP cannot yet confirm 1oom's Simple value.
- **Monster "6 parsecs" vs neighbour-cell targeting**: the unit conversion was not checked.
- **16-bit `plague_val` / `nova_val`** saves at 0x32 / 0x42: possible overflow for very productive planets was not checked.
- **OSG chapter 14** was read for lines 32945–33864 and the chapter 15 Guardian and cheat-key sections. The rest of the OSG may mention Silicoid event immunity or year gates; a grep for "Silicoid" found nothing in chapter 14.


> **Coordinator correction (2026-10-11):** comet/pirate HP maxima recomputed with difficulty 0–4 (report originally assumed 5 levels above Simple).


## Tags
[games](../../../tags/games.md) · [reverse-engineering](../../../tags/reverse-engineering.md)

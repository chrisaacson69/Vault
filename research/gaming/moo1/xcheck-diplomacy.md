---
status: draft
created: 2026-10-11
---
# MOO1 Diplomacy — Three-Way Cross-Check
> Stream (RAM pokes on the v1.3 binary) × Official Strategy Guide ch.5/11 × 1oom source, mechanic by mechanic. The four diplomat meters are the OSG's temporary modifiers (treaty/trade/tech/peace); threaten −220 and the trade ramp reproduce exactly in 1oom code; several OSG claims are v1.3 bugs. **Draft — verdicts marked OCR-SUSPECT / UNRESOLVED await Chris's rulings (Questions section).**

**Source:** [raw/videos/moo1-re/](../../../raw/videos/moo1-re/README.md) via the [stream digest](./zappatic-re-stream.md) — <https://www.youtube.com/playlist?list=PLZVzPYU15yts>
**Source:** [raw/books/moo1-osg/](../../../raw/books/moo1-osg/README.md) — OSG OCR text; `OSG:NNNN`/`LNNNN` cite its line numbers
**Source:** 1oom — <https://github.com/1oom-fork/1oom> at commit `42e9c0b` (no local capture; `file:line` cites are against that commit)

**Links:** [zappatic RE stream](./zappatic-re-stream.md) · [MOO1 Optimal Strategy](./optimal-strategy.md) · [Data-First RE](../../../method/data-first-re.md) · [Random events cross-check](./xcheck-events.md)

Citation keys:
- **S3/S4/S5/S6/S7/S8 [H:MM:SS]** = `Vault/research/gaming/moo1/zappatic-stream/partNN.md` (values as heard from auto-captions).
- **JSON +0xNN** = byte offset inside the `player` struct in `Vault/raw/videos/moo1-re/zappatic-site/zapdebugger-moo.json` (offsets computed by summing the field types; they line up exactly with 1oom's loader, see the field map below).
- **OSG L####** = line in `Vault/raw/books/moo1-osg/MasterOfOrionStrategyGuide_opt_djvu.txt`.
- **1oom file:line** = path under the scratchpad `1oom/` tree. `src/game/` is omitted for game files, so `game_diplo.c:24` means `1oom/src/game/game_diplo.c:24`.

Interpretation rule used: OSG = intent. Stream = measured v1.3 behaviour. 1oom = v1.3 except where `WASBUG`, `doc/list_gamediff.txt`, `doc/list_pbxnum.txt` or a Classic-vs-Classic+ branch says otherwise. 1oom's default AI is "Classic", which keeps the MOO1 bugs; "Classic+" fixes them (`doc/list_gamediff.txt:25-46`).

---

## Summary

- **Two variable families, not one.** Each player record holds, per opponent, the **relation** (`relation1`, the −100..+100 "love nub", JSON +0x18) and a **base relation** (`relation2`, JSON +0x24). The base starts at `tbl_orion_race_relation × 12` (`game_new.c:50-61,917`). The relation drifts toward the base by at most 1 point per turn, and only on turns with no diplomatic event (`game_turn.c:405-434`). This is the stream's "second copy of the mood values" (S4 [2:25:00]) and the OSG's "Natural Relations Gravitation" (OSG L25791-25800).
- **The stream's four "diplomat availability" meters are the OSG's temporary modifiers.** They are `mood_treaty`, `mood_trade`, `mood_tech` and `mood_peace` at +0xA8/+0xB4/+0xC0/+0xCC (`game_save_moo13.c:288-291`). There is **no fifth "Diplomat Gone" modifier**, although the OSG says there is (L26209). The diplomat is gone when `min(4 meters) ≤ −100`, or when `trust + min + personality_mod ≤ −100` (`game_diplo.c:441-473`). This confirms the stream's corrected "any meter ≤ −100" (S4 [3:25:00]) and explains the 120 ceiling (`game_diplo.c:412`). The retracted −55 may be the second clause firing for a negative-personality leader (Q16).
- **Per-turn meter recovery is not the OSG's flat 10.** Each turn every meter gains +10 if it is below 100 (`game_diplo.c:418-439`). Earlier in the same turn each meter also gains +1d5 if below 50, and another +1d5 if below 0 (`game_turn.c:89-122`). That explains the stream's "own rate / some double-step" (S3 [1:05:00]).
- **Audience costs (v1.3).** Every request costs −10 on all four meters (annoy 1). It also takes a random hit on the meter for that subject (−21..−50 treaty/trade, −21..−70 tech, −51..−100 peace) **whatever the answer** (`game_ai_classic.c:4053-4105`). Opening the Threaten/Break menu costs **−100 on all four meters even if you back out** (`game_audience.c:726`, WASBUG). Threaten also sets `mood_treaty = −120` first, which gives the stream's measured **−220** (S3). An exchange-tech session always ends with −30 on all four (`game_audience.c:887`), which matches the stream's "−30 per refused exchange".
- **Confirmed v1.3 bugs (OSG intent ≠ binary):**
  - Cash tribute gives +0 (`game_ai_classic.c:4304-4314`; stream S4 [3:25:00] agrees).
  - A successful threat hides *your* spies, not theirs (`:4268`).
  - Breaking a NAP or alliance *raises* trust by +10/+20 (`game_diplo.c:152-165`).
  - Both parties get blamed for the broken treaty (`:177`).
  - Bounties are never paid (`game_audience.c:284`).
  - The AI tests the wrong meter for peace (`game_ai_classic.c:4156`).
  - The AI-AI stop-war check uses a UI message index (`:3694`).
- **Trade.** Offers are capped at 25% of the smaller empire's production. Offers step in +25 BC units (and in 5ths when the headroom is ≥125 BC) (`game_audience.c:916-936`). This matches the OSG (L27117-27124) and the stream (S4 [2:45:00]).
  - The stream's "trade-agreement cooldown" (+0xF0) is really the **trade profitability %** (`trade_percent`). A new route starts at **−30**. It grows by `max(0,(d200+rel+25)/60)` per turn, capped at 100 (`game_turn.c:326-329`), exactly the OSG formula (L8892-8899).
  - Income = `bc × (pct + 25 if Human)/100` (`game_misc.c:194`).
  - The code's re-averaging when you enlarge a route does not match the OSG worked example (Q9).
- **Relation labels.** The label index is `relation/12 + 8` (C truncation), so the bands are 12 wide with Neutral = −11..+11 (`uiraces.c:206`, `game_str.c:516`). This agrees with the stream ("12 = relaxed") and with OSG Ch. 5 L8926 ("unease −12 to −23"). It **disagrees with OSG Table 11-1** (±7..±18). The love nub sits at `rel/2` px (`uiraces.c:201`), which agrees with OSG L25719.
- **Relation caps.** The relation is capped at +65 unless allied, and at −25 or below while at war (`game_diplo.c:131-136`). This cap does not appear in the OSG or the stream.
- **Enums** for treaty (0–4), personality (0–5), objective (0–5) and contact state (0/1/2) are identical in the stream JSON and 1oom `game_types.h:106-137`. First contact selects the greeting by personality: `dtype = trait1 + 14` (`game_ai_classic.c:4008`).

### Field map (stream JSON ↔ 1oom `game_save_moo13.c:270-312`)

| JSON +off | Stream name | 1oom name | Note |
|---|---|---|---|
| 0x04/0x06 | personality-type-1/2 | trait1/trait2 | AGREE (S6 [0:00:00]) |
| 0x08/0x0A | unknown5/6 | ai_p3_countdown/ai_p2_countdown | NEW |
| 0x0C | has-contact-with | contact (bitvec) | AGREE |
| 0x18 | opponent-mood-slider | relation1 | AGREE |
| 0x24 | unknown16–21 ("second copy of mood", S4) | relation2 (base) | NEW meaning |
| 0x30 | unknown-opponent-related (clears after audience) | diplo_type (pending AI message) | AGREE (`game_turn.c:1426` clears it) |
| 0x3C/0x48/0x54 | unknown | diplo_val / diplo_p1 / diplo_p2 | NEW |
| 0x6C | unknown | trust (OSG "permanent core modifiers") | NEW |
| 0x78/0x84 | unknown | broken_treaty / blunder | NEW |
| 0x90/0x9C | unknown (S4 "tribute counter?") | tribute_field / tribute_tech (last tech tribute) | NEW |
| 0xA8/0xB4/0xC0/0xCC | diplomat-availability 1–4 | mood_treaty / trade / tech / peace | AGREE (4 meters) |
| 0xD8 | treaty | treaty | AGREE |
| 0xE4 | trade-agreements | trade_bc | AGREE |
| 0xF0 | trade-agreement-cooldown | **trade_percent** | STREAM-ERROR (name) |
| 0xFC | unknown-opponent-related2 | spymode_next | NEW |
| 0x108, 0x114 | unknown-related3, trade-amount-proposals | not loaded by 1oom | UNRESOLVED |
| 0x1D4/0x1E0/0x1EC | inside unknown143 | offer_field/tech/bc (AI deal sweetener) | NEW |
| 0x21C/0x228 | inside unknown143 | attack_bounty / bounty_collect | NEW |
| 0x234–0x24C | inside unknown143 | attack_gift_field/tech/bc | NEW |
| 0x270 | inside unknown143 | hatred (threat strikes) | NEW |
| 0x27C | opponent-contact-made (0/1/2) | have_met | AGREE |
| 0x288 | accepted-trade-amount-proposals | trade_established_bc | AGREE |
| 0x2A4/0x2B0/0x2C8/0x2D4/0x2D6 | spy slider / progress / jobs / security / count | spying / spyfund / spymode / security / spies | AGREE |

---

## Mechanics table

| Mechanic | Stream | OSG | 1oom | Verdict |
|---|---|---|---|---|
| Relation range & symmetry | s16 −100..+100; A→B = B→A; edits stick only in the opponent's record (S3 [0:35:00], [1:45:00]; S4 [2:00:00]; S5 [3:20:00]) | −100..+100 DPs (L25735-25738) | SETRANGE −100..100 (`game_diplo.c:110`). The end-of-turn copy loop makes the **lower player index** the master (`game_turn.c:435-444`). `diplo_act` copies AI→actor (`game_diplo.c:137`). v1.3-faithful. | AGREE on range/symmetry. **UNRESOLVED** on which copy is master (stream says opponent; 1oom's end-of-turn loop says player 0). See Gaps. |
| Relation label bands | 12 = relaxed, −12 = unease, harmony at max (S3 [0:35:00]) | Table 11-1: Relaxed +7..+18, Neutral −6..+6 (L25618-25712). Ch. 5: unease "−12 to −23" (L8926) | `rel/12+8` → 17 labels, 12-wide, Neutral −11..+11 (`uiraces.c:206`; `game_str.c:516-520`) | **OCR-SUSPECT / OSG-internal** (Table 11-1 shifted ~5; Ch. 5 matches code). Q1 |
| Love-nub pixels | — | 1 px per 2 DP (L25719) | `rel/2`, clamp ±50 (`uiraces.c:201-202`) | AGREE (OSG+1oom) |
| Starting (base) relation | 12 / −12 heard (S3) | Table 11-3: ±7, −19, −31 (L25843-26084) | `table × 12` → ±12, −24, −36 (`game_new.c:50-61,917-919`). Every OSG entry is the inner edge of the band that holds the code value. **Except Klackon↔Silicoid**: OSG +7 both ways (L25974, L26074), 1oom −1×12. | AGREE (bands). Klackon/Silicoid **UNRESOLVED**, Q2 |
| Base relation −5 per new war | — | −5 immediate and −5 permanent on base (L26087-26091) | `relation2 −= 5` both sides (`game_diplo.c:219-220`). The immediate relation is set to −75−d25 (`:221`). | AGREE (permanent −5). The immediate value differs: **UNRESOLVED**, Q3 |
| Natural drift toward base | "recomputed each turn, pokes partly snap back" (S3 [2:05:00]) | 1 DP/turn toward base when no DP event (L25794-25800) | Only if `diplo_val==0` (no event): step 0/1 with prob `|r1|>d105`, toward relation2, AI rows only (`game_turn.c:405-434`) | AGREE (≤1/turn). Probabilistic in code. |
| DP modifier bands (Table 11-2) | — | Gains: full ≤+33, ⅔ 34–66, ⅓ 67–99. Losses: ⅓ ≤−67, ⅔ −66..−34, full −33..+50, ×2 ≥+51 (L25745-25788) | Gains: ×2 if rel<0 (capped so the result ≤ +10), else ÷(rel/25+1). Losses: ×2 if rel>0, else ÷(−rel/25+1) (`game_diplo.c:55-78`) | **UNRESOLVED** (shape differs). Q4 |
| Race/personality DP multipliers | — | Human gains ×2; AI-AI gains ×2 after turn 100; Xeno gains ½, losses ×2; Honorable losses ×2 (L25816-25827) | Human actor gains ×2 (`:89-91`) AGREE. AI-AI year>100 gains ×2 AGREE; losses ÷(difficulty/2+1) NEW (`:99-106`). Honorable losses ×2 AGREE (`:79-81`). **Xeno losses ×1.5, gains ×0.75** (`:82-87`). | AGREE except Xenophobic → **UNRESOLVED**, Q5 |
| Hostile acts while at war | — | silent | dtype 4–12 losses are zeroed at war; ¼ goes to mood_peace instead (`:92-98`) | NEW |
| Relation caps | — (pokes to 100 worked) | silent | ≤ +65 unless allied; ≤ −25 at war (`game_diplo.c:131-136`); tech-tribute cap +70 (`game_ai_classic.c:4360`) | NEW |
| Temporary modifiers (count) | 4 meters, +0xA8..+0xD7 (S4 [3:10:00]) | 5: Treaty, Peace, Trade, Exchange, Diplomat Gone (L26198-26210) | 4: mood_treaty/trade/tech/peace; "gone" = min of 4 (`game_diplo.c:441-457`) | **AGREE stream+1oom.** OSG's 5th modifier does not exist. |
| Meter ranges | Max ≈120 observed; −300 seen (S4 [3:25:00]) | Recover toward 0 (L26227-26230) | mood_treaty clamped −200..+120 (`game_diplo.c:412`); mood_peace −200..+200 (`game_turn.c:121`); trade/tech unbounded below | AGREE (stream+1oom) |
| Meter recovery per turn | Each meter its own rate, some twice per turn (S3 [1:05:00]; S4 [3:25:00]) | +10/turn toward 0 (L26229, L26637) | +1d5 if <50, +1d5 more if <0 (`game_turn.c:89-122`, turn start), then +10 if <100 (`game_diplo.c:418-439`, turn end). Positive values keep rising to 100+. | **BUG-v1.3/OSG simplification.** Stream matches code. |
| Diplomat gone | ≤ −100 on **any** meter; −55 retracted (S4 [3:25:00]; S3 [1:30:00]); UI-only flag (S2 [4:10:00]) | Core Reaction + DG modifier < −100 (L26269-26274) | `min ≤ −100` OR `trust + min + reldiff[trait1] ≤ −100`; base relation is added then subtracted (comment `game_diplo.c:467-468`), so it has no effect. Computed live for UI (`uiraces.c:264`). | AGREE (stream+1oom). The OSG's inclusion of base relation is **BUG-v1.3 or OSG error**, Q6 |
| "Ambassador recalled" mid-audience | Gift + recalled diplomat after threatening (S5 [3:20:00]) | — | `aud_later`: min mood < −100 → dtype 74 (`game_ai_classic.c:4430-4434`) | AGREE |
| Per-request penalty | — | −10 on all 5; −30 on the rejected area (L26214-26225) | annoy(1) = −10 on all 4 (`game_diplo.c:271-279`), plus area hit **regardless of outcome**: treaty/trade −(d30+20), peace −(d50+50), tech −(d50+20) (`game_ai_classic.c:4081-4097`) | AGREE on −10. Area hit **BUG-v1.3/OSG simplification**, Q7 |
| −100 overflow penalty | — | Half the excess below −100 → instant DP loss (L26299-26312, L27450-27453) | No such code found in game_diplo.c / game_audience.c / game_turn.c | **UNRESOLVED** (absent in 1oom). Q8 |
| Threaten — meter cost | One meter −220/−300; all four hit (S3 [0:55:00]-[1:40:00]; S4 [3:25:00]) | All temp −50 (L27444-27448) | `mood_treaty = −120` (`game_ai_classic.c:4256`) then annoy(10) = −100 on all four. In v1.3 the −100 applies **on merely opening the menu** (`game_audience.c:726` WASBUG; `doc/list_gamediff.txt:27`). | **BUG-v1.3**; −220 exactly matches code |
| Threaten — DP cost | — | −30 + personality modifier (L27458-27463) | relation −d15 (`game_ai_classic.c:4254`) | **UNRESOLVED**, Q10 |
| Threaten — outcome | Gift + recall, no war (S5 [3:20:00]) | relpower(0–100) + pers + d100: ≥100 bribe, 75–99 cower (peace 8–15), 25–74 ignore, <25 war (L27306-27434) | `v = d200 + mood_treaty/2 + 2·reldiff + 100·prod_you/prod_them`. If v<170: war when `d15 − reldiff > d100`, else ignore. Otherwise cower: ceasefire d15+5 turns; ≥200 cash `(d8+2)·year` rounded to 25; ≥275 tech (`:4239-4294`). Cower hides **your** spies (WASBUG `:4268`). | **BUG-v1.3** (spies). Formula **UNRESOLVED** vs OSG |
| Break trade | All four set to −300 (S4 [3:25:00]) | −12 DP + oath-breaker (L27238-27246) | `break_trade`: zeroes bc/est/pct; **no DP, no trust, no meter change** (`game_diplo.c:243-269`); only the −100 menu annoy | **BUG-v1.3** (no oath-break). Stream −300 is **UNRESOLVED** (= −200 break_treaty −100 annoy?), Q11 |
| Break NAP/alliance (player) | — | −12 DP, oath breaker (−5 core, −36 DP; Honorable ×2) (L27160-27185, L26417-26431, L28913-28921) | trust **−=** w where w = −10/−20 → **+10/+20 trust** in Classic (`game_diplo.c:152-165`); relation −d20; all 4 meters −200 both sides (`:189-196`); both blamed (`:177` WASBUG) | **BUG-v1.3** (`list_gamediff.txt:26,36`) |
| AI breaks treaty with you | — | Your DG modifier −200; never at Simple/Easy (L28355-28365) | Meters −200 (`game_diplo.c:189-196`); no break below Average (`game_ai_classic.c:3447-3448`) | AGREE |
| Oath-breaker −5 core | — | −5 permanent, combined cap +30 / unlimited negative (L26110-26136) | trust cap +30 on tribute (`game_ai_classic.c:4355`); breaking is +w (bug above) | Cap AGREE; sign **BUG-v1.3** |
| Treaty enum | 0 none, 1 NAP, 2 alliance, 3 war, 4 final war; 5 invalid (S3 [0:45:00]) | — | `game_types.h:106-111` | AGREE |
| Treaty storage | Must change both players; player 0's copy is overwritten (S6 [0:15:00]) | — | `game_diplo_set_treaty` writes both (`game_diplo.c:354-360`) | AGREE |
| NAP — player proposes | Neutral races refused; Sakkra accepted after tribute (S3 [0:20:00]) | Need rel ≥ +15; core + temp + d100: ≥75 accept, 50–74 counter (L26484-26507) | Need rel > 10. v = mood_treaty + trust + rel + 50·Human + reldiff + d100 − 50 (+40 if allied); ≥0 accept, −75..−1 counter (`game_ai_classic.c:4126-4138, 4053-4105`) | **UNRESOLVED** (different terms). Q12 |
| NAP/alliance signing bonus | — | +20 DP each (L26535, L26587-26589) | `game_diplo_set_treaty` has no relation change (`game_diplo.c:354-360`) | **UNRESOLVED** (likely BUG-v1.3 or OSG error), Q13 |
| Per-turn treaty DP | — | NAP +1..3, alliance +1..6 (L26536, L26589) | 50%/turn: NAP d3, alliance d6, trade d3 through `diplo_act` (`game_turn.c:340-351`) | AGREE (NAP/alliance). Trade: see below. |
| Alliance — player proposes | — | rel ≥ +50; ≥125 accept (L26542-26556) | rel > 50; a0 = 125 (`game_ai_classic.c:4140-4152`) | AGREE on gate; sum terms differ (Q12) |
| Peace — player proposes | — | Any rel; core + Temp Peace + war damage + d100 ≥ 0 (L26647-26664) | a0 = 60, uses **mood_treaty** in Classic (WASBUG? `game_ai_classic.c:4154-4160`; `list_gamediff.txt:29`) | **BUG-v1.3** (wrong meter) |
| Peace effects | — | +40 DP; their spies hide; enforced peace **8–15 turns** (L26670-26683, L27886); "wait full 16" (L27225) | +40 capped at 100 (`game_diplo.c:389`); ceasefire `rnd_0_nm1(6)+8` = **8–13** (`:392,395`); AI-offered peace also +20 if rel<80 (`game_audience.c:371-377`) | AGREE +40. Duration **UNRESOLVED**, Q14 |
| Counteroffer (sweetener) | — | Tech first; else 2d8 × turn rounded down to 25 if you can pay (L26355-26403) | bc = `(2d8·year/25)·25`, 0 if > your reserve; tech only when v ∈ −75..−51 or bc = 0 (`game_audience.c:463-503`; `game_ai_classic.c:4207-4237`) | AGREE on amount. Tech-vs-cash priority **UNRESOLVED** |
| Ask AI to declare war | — | rel ≥ +19; ≥150 (250 if pact with victim) (L26881-26918) | No rel gate; a0 = AI's relation to target + 150; Classic ignores pacts (unused treaty·30) (`game_ai_classic.c:4162-4183`). Allied & already at war → auto (7/8 accept). | **BUG-v1.3 / OSG error** (1oom: "no such code"), Q15 |
| Ask AI to break alliance | — | rel ≥ +19; ≥200 (L26969-26992); NAP listed too (L26948-26967) | rel > 24; a0 = rel(AI→victim) + 175; NAPs **not** listed unless `aud_ask_break_nap` (`game_audience.c:569-574`; `list_pbxnum.txt:56-59` "a filthy lie") | **BUG-v1.3/OSG error** on NAP; thresholds UNRESOLVED |
| Trade levels offered | +25 steps 25→50→75 (S4 [2:45:00], [3:20:00]) | Max = 25% of smaller economy; levels 20/15/10/5%, all but lowest rounded to 25 (L27117-27124); need ≥100 BC economy (L8775-8777) | `prod = min(prod)/4`; headroom <125 → cur+25/50/75/100; else 5ths, the lowest unrounded (`game_audience.c:916-936`) | AGREE (all three) |
| Trade greyed out early | Greyed out, cause unknown (S3 [0:50:00]) | Need ≥100 BC economy (L8775) | Disabled when headroom ≤ 0 or at war (`game_audience.c:905-922`) | NEW explanation, consistent |
| Trade acceptance | — | core + temp trade + d100 ≥100 accept, 75–99 counter (L27036-27042) | check_mood(a0 = 50, mood_trade); `si<3 → reject` (**no counteroffer**) (`game_audience.c:673-679`; `game_ai_classic.c:4200-4205`) | **UNRESOLVED** |
| Trade request side-cost | — | — | Trade menu: annoy(1) and mood_trade −d30 (`game_audience.c:668-669`), plus check_mood's own −(d30+20) | NEW |
| Trade profitability % | +0xF0 "cooldown": drops to ≈ −30 or −255 on agreement, then +1/turn to cap 100 (S4 [3:00:00]-[3:20:00]); income −7 → −6 at 25 BC (S8 [4:20:00]); 12 BC on a 50 BC deal (S4 [4:15:00]) | Starts −30%, grows `(d200 + rel + 25)/60` per turn, cap 100%, can go −1% (L8839-8899, Table 5-2 L8979-9282) | Fresh deal → −30 (`game_diplo.c:371`); growth `max(0, (d200+rel1+25)/60)`, cap 100 (`game_turn.c:326-329`) | **STREAM-ERROR** (name: it is the ramp, not a cooldown). Formula AGREE. Negative growth: **UNRESOLVED** (OSG −1%, code floors 0). "−255" likely mishearing |
| Trade enlarge averaging | — | (old·pct − Δ·30)/new → example 100@+8 + 50 → −4% (L9310-9349) | `(pct·est − new_total·30)/(est + new_total)` → same example gives −14% (`game_diplo.c:370-372`); dead "est += bc/10" ramp (`game_turn.c:318-323`, FIXME) | **BUG-v1.3?** (1oom only says FIXME), Q9 |
| Trade income | Total-income-trade s16 at +0x2E2 (S4 [4:15:00]) | Humans earn more (L27278-27280) | `Σ bc·(pct + 25·Human)/100` (`game_misc.c:194`) | AGREE; +25 points for Humans NEW |
| Trade DP gain | — | d(1 + %economy/5) per turn (L27076-27087); "+1 to +6" (L27049); "+1 to +5" (L27891) | 50%/turn d3 (`game_turn.c:348-349`) | **UNRESOLVED** (OSG self-inconsistent). Q17 |
| Trade lost on contact loss | Contact can break (S4 [2:25:00]) | No-contact modifiers (L28819-28849) | Contact lost → trade zeroed, mood_trade = 0, spies hide (`game_turn.c:1435-1452`, `:311-315`) | NEW |
| Cash tribute | No effect on meters (S4 [3:25:00]) | +12 DP per 100% of their gross economy (L27497-27508, L27933) | v = 0 in Classic (WASBUG divides by a far pointer, `game_ai_classic.c:4304-4314`); Classic+ = OSG formula | **BUG-v1.3** (stream + 1oom agree) |
| Tech tribute | Meter #4 (+0xCC) +10 per offer (S4 [3:25:00]; JSON comment) | +5 core, +~12 DP scaled by level (L27532-27550); Table 11-5 "+6 DPs" (L27934) | rel += v, mood_peace += v (≤200), trust += d8+2 (≤30). v = `((2d8 + tech/4)·k)/10`, k = 20 if rel<0 else (100−rel)/10, ×2 if Human. Relation caps not re-synced to the giver (BUG? `game_ai_classic.c:4336-4366`) | AGREE (meter #4 = mood_peace). Size UNRESOLVED; OSG self-inconsistent, Q18 |
| Tribute menu availability | "Tribute counter?" (S4 [3:00:00], [3:35:00]) | Need ≥25 BC (L27488-27492) | Greyed out if reserve <25 and no giftable tech (`game_audience.c:910-915`). +0x90/+0x9C store the last tech tribute, recalled 25% of the time as "accept because of tribute" (`game_ai_classic.c:4416-4423`). | NEW (no countdown) |
| Tech exchange cost | −30 per refused exchange; "odd drops" (S3 [1:00:00]; S4 [3:25:00]) | Refusal −30 on Exchange (L26222-26225) | annoy(1) −10 all + mood_tech −(d50+20) when a list is shown; **always** annoy(3) = −30 all at the end; mood_tech then capped at 50 (`game_audience.c:847-888`) | AGREE (−30). The "odd drops" are the random tech hit. |
| Tech exchange acceptance | — | core + rel + UTA + d100 ≥100 (L27622-27683) | Value-scaled lists via `aud_tech_scale` (`game_ai_classic.c:4368-4393`) | UNRESOLVED (different model) |
| AI-initiated: NAP | — | rel ≥ +7, asking check ≥50 (L28124-28132) | rel > 15, `v + d100 + mood_treaty > 50`, v = trust + rel + 50·Human + reldiff (`game_ai_classic.c:3745-3753`) | AGREE threshold; gate +15 vs +7 differs |
| AI-initiated: alliance | — | NAP & rel ≥ +50, ≥100 (L28137-28142) | NAP (or NAP offered now) & rel > 50, >100 (`:3755-3762`) | AGREE |
| AI-initiated: trade | — | d150 asking check ≥50, offers the **max** (L28215-28227, L27975) | d150 + mood_trade > 50; amount = **random** d(prod/25)·25 (`:3764-3780`) | AGREE check; amount **UNRESOLVED** |
| AI-initiated: tech | — | ≥125 (L28254-28262) | `v + d100 + mood_trade > 25` (uses mood_**trade**) (`:3816`) | UNRESOLVED |
| AI-initiated: peace | — | ≥50 and d8 = 1 (L28144-28155) | `v + d100 + mood_peace ≥ 50` and 1/8 (`:3963`) | AGREE |
| Asking-check modifiers | — | 2× personality, + difficulty 50/40/30/20/10% (L28058-28080) | 1× reldiff; no difficulty bonus in p2_sub1 (`:3745`) | UNRESOLVED |
| Bounty offer | — | Free tech for 30 damage (L28264-28284) | Offered (`:3786-3812`); 30-pt trigger (`game_diplo.c:336`); **never paid** in v1.3 (`game_audience.c:284`; pbx `aud_bounty_give`) | **BUG-v1.3** |
| Threat / atta-boy messages | — | 2% per net DP lost/gained; 2 strikes → war; break treaty 50% (L28290-28365) | `diplo_val` = largest event; roll < 2·|dv| → `p2_sub3`: rel ≤ −95 → war; hatred counter → threat (+38) then break (+46) then war (`game_ai_classic.c:3929-3979, 4024-4033`) | AGREE (2%/DP) |
| AI war: hate | Mood −100 → feud next turn (S5 [3:20:00]) | ≤ −90 → war (L28424-28429) | ≤ −95 inside the threat path (`:3940`) | AGREE approx |
| AI war: erratic | Mrrshan declared war unprompted after cheat contact (S5 [2:45:00]) | Straight 2%/turn (L28557-28561, L28959) | `d300 ≤ difficulty` per check (0–1.33%) (`:3502-3509`) | **UNRESOLVED**, Q19 |
| AI war: fleet superiority | — | Ratio 3:1 … 7:1 by difficulty; hull weights 1–4 (L28481-28507) | 1/20, militarist/expansionist non-honourable: `rel − rnd(fleet ratio%) + reldiff + trust < −150`; same with production for all; humans: rel < −30 and war count < difficulty (`:3510-3575`) | UNRESOLVED |
| Assassination event | — | War, relation reset to −75 (L28537-28551) | `start_war` → relation −75−d25 (`game_event.c:592`; `game_diplo.c:221`) | AGREE approx (Q3) |
| Personality enum & modifiers | 0 xeno, 1 ruthless, 2 aggressive, 3 erratic, 4 honorable, 5 pacifistic (S6 [0:00:00]) | Pacifist +20, Honorable +10, Erratic ±40 per turn, **Aggressive −10**, Ruthless −30, Xeno −50 (L26143-26177) | `{−50, −30, −20, 0, +10, +20}` (`game_diplo.c:18`) | Enum AGREE. Aggressive/Erratic **UNRESOLVED**, Q20 |
| Objective enum | 0 diplomat … 5 ecologist (S6 [0:00:00]) | Spending/spy tables (L29045-29530) | `game_types.h:131-136`. In diplomacy, only militarist/expansionist (war checks) and expansionist (treaty breaking) are used (`game_ai_classic.c:3452-3453, 3513`) | AGREE enum; diplomacy use NEW |
| Contact | has-contact bool; contact state 0/1/2, 1 = intro next turn (S4 [2:25:00]-[2:45:00]) | Contact always announced; re-contact silent (L28035-28041) | `have_met` 1→2 shows intro dtype trait1+14 (`game_ai_classic.c:4006-4008`); start_war sets have_met = 1 (`game_diplo.c:207-212`) | AGREE |
| Council votes | — | +24 for, −12 opponent, −6 each on abstain (L28582-28594) | `diplo_act` +24 / −12 / −6 (`game_election.c:204-258`) | AGREE |
| Espionage: caught spying | Spy jobs enum 0 hide/1 esp/2 sab (JSON) | −2×d12 (L28604-28609) | Caught stealing: **−5d12** (`game_spy.c:235-239, 609`); caught sabotage −(d20+20) (`:277, 340`); framed: −2d12 (`game_diplo.c:399-404`; `game_spy.c:738-740`) | **UNRESOLVED** (5d12 vs 2d12), Q21 |
| Espionage: AI frames you in AI sabotage | — | framed = −2d12 | `r = −(2d16)` then `diplo_act(−r)` → **positive** (`game_spy.c:343-346`) | NEW (code-path sign oddity; possibly a 1oom transcription bug) |
| Incite revolt / coup | ≥100% → new leader; treaty and trade reset; relations neutral (S3 [1:10:00]-[1:30:00]) | Personality changes; treaties/trade broken; nubs halve toward 0 (L29550-29584) | New random trait1/2; relation1 := relation2 (base); breaks treaty+trade with **humans** only, via a WASBUG uninitialised read (`game_turn.c:1280-1300`) | **BUG-v1.3** (relations reset to base, not halved) |
| Genocide | — | −36 with all (L28691-28762) | `diplo_act −36` with all others (`game_event.c:1039`) | AGREE |
| Biological weapons | — | −12 with every race (L28765-28775) | −10 to every AI except the bomber; victim −max(5·pop, app ≤50, 10·bio) (`game_diplo.c:313-335`) | UNRESOLVED (−10 vs −12) |
| Enemy-of-enemy bonus | — | +1 per 4 damage points (L28793-28813) | Offense ≥30 → +offense to AIs at war with the victim (`game_diplo.c:336-350`) | UNRESOLVED |
| Too many planets | — | >25% of stars → −1/planet/turn (L28621-28640) | Even years, 1/4 chance: planets with prod ≥100 above `(galaxy_size+1)·3`, scaled by difficulty, halved for humans; applied to **allied** AIs only (`game_turn.c:374-404`) | UNRESOLVED |
| Fleet massing | — | Up to −12/turn (L28642-28669) | 1/20 chance −10 when AI fleet < human fleet (`game_turn.c:355-373`) | UNRESOLVED |
| Final War | Treaty 4 = Final War (S3 [0:45:00]) | Diplomacy ends (L28865-28882) | Treaty FINAL_WAR for refusers vs the rest, refusers ↔ others relation −100, same side alliance +100 (`game_turn.c:1600-1613`); `get_mood` returns 0 (`game_diplo.c:443-444`); `diplo_act` no-op except message (`:29-38`) | AGREE |
| AI-AI peace check | — | — | v1.3 uses `diplo_msg_subtype` (−1..13) as v (WASBUG `game_ai_classic.c:3688-3695`) | BUG-v1.3 (NEW) |
| AI-AI NAP/alliance oscillation | — | — | "BUG ignores Alliance" (`game_ai_classic.c:3663`) | BUG-v1.3 (NEW) |

---

## Formulas (1oom, Classic AI = v1.3 unless noted)

**Relation event, `game_diplo_act(dv, actor pi, judge pi2)`** (`game_diplo.c:24-138`). The judge must be an AI and not in the Final War.
```
if dv>0: if rel<0: dv*=2, clamp so rel+dv ≤ 10 ; else dv /= (rel/25 + 1)
if dv<0: if rel>0: dv*=2                     ; else dv /= (-rel/25 + 1)
Honorable judge & dv<0: dv*=2 ; Xenophobic: dv<0 → dv*3/2, dv>0 → dv*3/4
v1 = dv ; Human actor & dv>0: dv*=2
at WAR & dtype 4..12 & dv<0: dv=0 (¼ shifted to mood_peace if actor human)
AI-AI & year>100: dv>0 → ×2 ; dv<0 → ÷(difficulty/2+1)
rel = clamp(rel+dv, -100, 100); mood_treaty/trade/tech += dv (both copies)
mood_peace: v1<0 → judge += v1/4, actor −= v1/4 ; v1>0 → judge += v1
rel ≤ −25 if at war; rel ≤ 65 if not allied
```
Note that dv also raises or lowers three of the meters 1:1. That ties the meters to events, not only to audiences.

**Meters per turn.** At turn start: `if m<0: m+=d5; if m<50: m+=d5` (mood_peace clamped ±200) (`game_turn.c:89-122`). At turn end: `if m<100: m+=10` (`game_diplo.c:418-439`). mood_treaty is clamped to [−200,120] before AI diplomacy and audiences (`:406-416`). These confirm the stream's "recover at own rate / twice per turn / max ≈120".

**Diplomat gone** (`game_diplo.c:459-473`): `min4 = min(treaty,trade,tech,peace)`; gone if `min4 ≤ −100 || trust + min4 + reldiff[trait1] ≤ −100`, with `reldiff = {−50,−30,−20,0,10,20}`. This confirms the stream's −100. With trust = 0, a Xenophobic leader (−50) goes at min4 ≤ −50, Ruthless at ≤ −70 and Aggressive at ≤ −80. That is the likely source of the stream's original −55 reading.

**Audience acceptance** `check_mood(a0, meter)` (`game_ai_classic.c:4053-4105`):
```
v = meter + trust + rel + (50 if player is Human) + reldiff + d100 − a0 (+40 if allied)
side-effects: all 4 meters −10; chosen meter −(d30+20) | peace −(d50+50) | tech −(d50+20)
v<−75 → 0 reject ; −75..−51 → 1 ; −50..−1 → 2 (1,2 = counteroffer) ; ≥0 → 3 accept
a0: NAP 50 (rel>10), Alliance 125 (rel>50), Peace 60 (Classic uses mood_treaty), Trade 50 (no counter),
    Declare war rel(AI→target)+150, Break alliance rel(AI→victim)+175 (rel>24)
```

**Threaten** (`game_ai_classic.c:4239-4294` + `game_audience.c:683-731`):
```
v = d200 + mood_treaty/2 + 2·reldiff + 100·prod_player/prod_AI ; rel −= d15 ; mood_treaty = −120
then (v1.3, even on Cancel) all 4 meters −100   → mood_treaty = −220   [stream S3: −220 ✔]
v<170: war if (d15 − reldiff) > d100 else "ignore"
v≥170: cower — YOUR spies → hide (v1.3 bug); ceasefire d15+5; v≥275 tech gift; 200≤v<275 cash (d8+2)·year →25
```

**Break treaty** (`game_diplo.c:140-197`). w = −10 for NAP or −20 for alliance (×2 if the breaker is Honorable). `trust[breaker→victim] −= w`, so in v1.3 trust **rises**. Relation −d20. All 4 meters = −200 on both sides. **Start war** (`:199-232`): base −5 both sides; rel = −75−d25; meters −200, peace −130.

**Trade** (`game_diplo.c:362-382`, `game_turn.c:303-333`, `game_misc.c:194`):
```
new/enlarge (est<bc): pct = (pct·est − 30·bc)/(est + bc)   (fresh: −30 ✔ stream "≈ −30")
per turn: pct += max(0, (d200 + rel + 25)/60), cap 100      (= OSG formula ✔)
income  = Σ bc·(pct + 25·[Human])/100                       (stream 25 BC: −28%→−7, −26%→−6 ✔)
offer menu: prod=min(prodA,prodB)/4; head=floor25(prod)−cur; head<125 → cur+25k (k≤head/25); else cur+head·{1/5 (unrounded),2/5,3/5,4/5 (→25),1}
```

**Tech tribute** (`game_ai_classic.c:4336-4366`): `k = rel<0 ? 20 : (100−rel)/10`; `v = ((d8+d8+tech/4)·k)/10`, ×2 if Human. `rel += v` (cap 100, then ≤70 unless allied, ≤ −25 at war, AI copy only). `mood_peace += v` (cap 200). `trust += d8+2` (cap 30). This confirms the stream's meter-4 increase. "+10" fits rel ≈ 0 with a typical roll.

**Cash tribute** (`game_ai_classic.c:4296-4334`): Classic v = 0 (bug). Classic+ v = `12·bc/AI_production` (= OSG).

**Sweetener** (`game_ai_classic.c:4207-4237`): `bc = ((d8+d8)·year/25)·25`, dropped if larger than your reserve (= OSG L26366-26403).

**Peace/ceasefire** (`game_diplo.c:384-397`): rel +40 (≤100); ceasefire = 8 + rnd(0..5) turns, counted down at turn start (`game_turn.c:63-72`).

**Espionage relation hits.** Caught stealing: −5d12 (`game_spy.c:235-239, 609`). Caught sabotaging: −(d20+20) (`:277, 340`). Framed: −2d12 (`game_diplo.c:402`; `game_spy.c:738`). AI framing you for AI theft: −(d20+20) (`game_spy.c:264`).

---

## Questions for Chris

1. **Relation band edges.** OSG Table 11-1 (L25662-25675) prints "Relaxed +7 to +18 … Neutral −6 to +6 … Unease −7 to −18". Ch. 5 (L8926) says unease is "from −12 to −23", and the code labels by `rel/12` (Neutral −11..+11). Is Table 11-1 a known OSG error (the bands should start at ±12)?
2. **Klackon ↔ Silicoid base relation.** OSG Table 11-3 shows +7 both ways (Klackon row L25974, Silicoid row L26074). 1oom's table has −1 (−12) both ways (`game_new.c:53,57`). Is this an OSG typo, or did the patch change it? Every other cell matches.
3. **War-start relation.** OSG says a new war gives −5 immediately plus −5 permanent (L26089-26091). Code sets the relation to −75−d25 and the base to −5 (`game_diplo.c:219-221`). Does the "immediate −5" in the OSG really mean the base hit only?
4. **Table 11-2 bands** (L25752-25788: full/⅔/⅓ on gains, ⅓/⅔/full/×2 on losses). Code divides by `|rel|/25 + 1` and doubles when the sign is opposite. Have you seen the OSG bands confirmed in play, or are they a simplification?
5. **Xenophobic multipliers.** OSG says gains ½ and losses ×2 (L25823-25825, L28984-28985). Code gives gains ×¾ and losses ×1.5 (`game_diplo.c:82-87`). Was this tuned in a patch?
6. **Diplomat Gone.** OSG says Core Reaction (which includes base relation) + DG modifier < −100 (L26272-26274). Code ignores the base relation and uses the minimum of the 4 meters. Is the OSG example "Alkari vs Xeno Mrrshan, −81 core, gone on the second parlay" (L26286-26297) something you've reproduced?
7. **Rejection penalty.** OSG says −30 on the refused area and −10 if they agree (L26222-26225). v1.3 takes −21..−50 (−51..−100 for peace) whatever the answer. Was the "−10 if they agree" wording ever corrected in an errata?
8. **The "−100 overflow" DP penalty** (half the excess below −100 hits the relation; L26302-26306, L27450-27453). 1oom has no such code. Is this an OSG invention, or a pre-1.3 mechanic?
9. **Trade averaging.** OSG's worked example (L9310-9349: 100 BC @ +8% plus 50 BC → −4%) assumes the −30% applies to the increase only. 1oom's v1.3 formula charges −30% on the whole new total, divided by old+new (→ −14%). Do you know which one v1.3 really shows on screen?
10. **Threat DP cost.** OSG says −30 + personality modifier (L27458-27463). Code takes −d15 from the relation. Have you seen −80 with a xenophobe?
11. **"Breaking trade set all four meters to −300"** (stream S4 [3:25:00]). Code: breaking trade alone leaves the meters as they are, and only the −100 menu tax applies; −300 = break NAP/alliance (−200) + menu (−100). Do you recall whether a pact was broken at the same time in that test? (Answerable from the transcript if not from memory.)
12. **NAP acceptance threshold.** OSG says ≥75 accept, 50–74 counter, gate +15 (L26484-26507). Code is "≥ a0 = 50" with the current relation and +50 Human inside the sum, gate >10. Do you treat the OSG thresholds as reliable in play?
13. **Signing bonus +20** for NAP and alliance (L26535, L26587). 1oom's `set_treaty` adds nothing. Did NAPs visibly jump the nub ~+20 in your games?
14. **Peace duration.** OSG says 8–15 turns (L26680, L27886, and the cower case L27388) and "wait the full 16" (L27225). 1oom says 8–13 (`rnd_0_nm1(6)+8`). Is OSG "15" an error, or is 1oom's constant off?
15. **Declare-war request.** OSG says the threshold rises to 250 if the AI has a pact with the victim (L26909-26918). 1oom says MOO1 computes `treaty·30` but never uses it (`game_ai_classic.c:4171-4177`). Lore check: is the OSG's 250 known to be wrong?
16. **Personality of the stream's −55 race.** The stream's original −55 diplomat-gone threshold (S3 [1:30:00]) fits code clause 2 for a Xenophobic leader with trust ≈ +5. Any lore on whether diplomats leave earlier for xenophobes? (Otherwise the transcript needs checking.)
17. **Trade DP per turn.** OSG gives three versions: 1..(1+%/5) (L27079-27087), "+1 to +6" (L27049) and "+1 to +5" (L27891). Code gives d3 at 50%. Which one is the OSG's intent?
18. **Tech tribute DP.** OSG text says ~12 DP scaled by tech level (L27542-27550). Table 11-5 says "+6 DPs" (L27934). OCR or OSG inconsistency? (Code: `(2d8 + tech/4)·k/10`.)
19. **Erratic war chance.** OSG says a straight 2%/turn (L28557-28561). Code says `d300 ≤ difficulty`, so 0% on Simple and 1.3% on Impossible. Known?
20. **Aggressive modifier.** OSG says −10 three times (L26166, L28967, Table 11-7 L29105). Code says −20. The OSG also says Erratic rolls ±40 each turn (L26162), while the code is a constant 0. Are both known OSG errors?
21. **Caught-spy penalty.** OSG says 2×d12 (L28606). Code gives 5d12 for caught thieves (2d12 is only for framing). Plausible?
22. **Human diplomacy bonus.** OSG says +60 (L26344). Code says +50 (`game_ai_classic.c:4075`, `:3745`). Could this be OCR (6/5), or is it a real difference?
23. **OCR sanity (trivial).** "-1-91 to -1-100" (L25627) = +91 to +100. "-i30" (L26130) = +30, which the code's trust cap of 30 confirms. "-40 to -h 40" (L26162) = −40 to +40. "8 to 1 5" (L27886) = 8 to 15. No answer needed unless one is wrong.

---

## Gaps

- **Which copy is master.** The stream twice says the opponent's record overwrites player 0's (S4 [2:00:00]; S5 [3:20:00]; S6 [0:15:00]). 1oom's end-of-turn copy (`game_turn.c:435-444`) makes the lower index master. If that is v1.3-faithful, the AI→human drift would be discarded every turn. **Probe:** poke player 0's relation, end the turn with no events, and watch which side survives.
- **Unmapped bytes JSON +0x108/+0x114.** 1oom does not load them. The stream calls +0x114 "trade amount proposal". By 1oom's struct order this region likely holds au_want_trade/field/tech and the tech-trade lists. Unverified.
- **The OSG's war-damage peace modifier** (Table 11-6 accumulating into Temporary Peace, L26599-26643). In code, the only war-damage link is ¼ of dtype 4–12 losses going into mood_peace (`game_diplo.c:92-98`). No source quantifies it end to end.
- **AI attack-launch probability** (OSG Table 11-7, 50% + −personality). It sits outside the diplomacy code read here, and the stream did not probe it.
- **Council vote AI logic.** Votes are in `game_ai_classic.c:3333-3412`. Only the DP effects were checked.
- **Spy-wars warning count** (OSG L27977, L28332-28340) versus `hatred`/`blunder`. The mapping is plausible but unverified.
- **None of the three sources measures** the AI-AI relation matrix as stored (stream open question S3 [1:40:00]). It is the same `relation1` table, but no in-game test was done.
- **Stream never located:** `trust` (+0x6C), `relation2` semantics, `broken_treaty`/`blunder`, `hatred`, the bounty fields, or `offer_*`. These are all NEW from 1oom and need a poke test to confirm.
- **Not confirmed in any source:** whether v1.3's "−255" heard for the trade ramp (S4 [3:00:00]) is real. The code can only produce it through the averaging formula with a very large new_total relative to est. In practice it is ≥ −30 for a fresh route.


## Tags
[games](../../../tags/games.md) · [reverse-engineering](../../../tags/reverse-engineering.md)

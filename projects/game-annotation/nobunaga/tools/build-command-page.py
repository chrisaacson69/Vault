"""
build-command-page.py — generate the per-command HTML walkthrough pages from a
structured spec, embedding each command's ROM-pulled animation.

Two page types (Chris's design):
  - ATOMIC    — a command with a self-contained formula (Grow/Build/Give/Train/
                Dam/Hire/Send/Tax). Full walkthrough: driver flow + bytecode-
                validated formula + validation table + embedded animation.
  - FUNCTIONAL — a command that delegates into a big subsystem (War->combat,
                Move->unit system, Bribe->sabotage). A SIMPLE page: what it does,
                what it triggers, and a "rabbit hole" callout linking to the
                (future) deep page. We do NOT inline a formula we don't have.

The `classify` command is the RABBIT-HOLE DETECTOR: it reads driver-call-index
(every EFFECT a command's driver reaches) and warns when a command typed `atomic`
actually fans out past the econ sandbox — so we don't author a formula page for a
command that's really a subsystem entry point.

Usage:
    py -3 tools/build-command-page.py build <cmd>|all      # write commands/<cmd>.html
    py -3 tools/build-command-page.py classify <cmd>|all   # rabbit-hole detector
    py -3 tools/build-command-page.py animid <driver_hex>  # the $E80C arg = anim id
    py -3 tools/build-command-page.py list

The GIF for a command is `commands/assets/<cmd>.gif` (produce it with
`tools/run-animation.py <anim_id> --out atlas/anim` then copy). If present it is
base64-embedded so each page is a single portable file.
"""
import sys, base64, subprocess, re
from pathlib import Path

try:
    sys.stdout.reconfigure(encoding="utf-8")   # Windows console defaults to cp1252
except Exception:
    pass

ROOT = Path(__file__).resolve().parent.parent
CMD_DIR = ROOT / "commands"
ASSETS = CMD_DIR / "assets"

# ---- effects that carry a self-contained, bytecode-validated formula ----
ATOMIC_EFFECTS = {
    0x87F0: "effect_grow", 0x88A6: "effect_build", 0x87D8: "effect_dam",
    0x9586: "effect_train", 0x82D6: "effect_tax", 0x8BE5: "send_capacity",
    0xA553: "effect_hire_men",   # $A2D2 is the Ninja/sabotage path (animid 12), NOT recruit-men
    0x87D8: "dam_sqrt_output",   # Dam math is inline in driver $9B7E; $87D8 is just sqrt(output)
    0x891D: "give_loyalty", 0x896F: "give_wealth",
    0x89C1: "give_men", 0xA93A: "give_a", 0xA95E: "give_b", 0xA9D5: "give_c",
}
# ---- effect addrs that mean "this command dives into a subsystem" ----
SUBSYSTEM_EFFECTS = {
    0x9323: "combat", 0x933A: "combat", 0x9351: "combat", 0x9368: "combat",
    0x9814: "combat", 0x81FC: "combat",          # War's ravage/resolve cluster
    0x8CA5: "unit-movement",                      # Move
}

# ---- full lord-command roster (name -> (menu#, driver)); from driver-call-index ----
ROSTER = {
  "move":(1,0x96D1), "war":(2,0x9850), "tax":(3,0x999A), "send":(4,0x9A5D), "dam":(5,0x9B7E),
  "pact":(6,0x9C4F), "grow":(7,0x9D3D), "marry":(8,0x9DC4), "trade":(9,0xA1B6), "hire":(10,0xA5F4),
  "train":(11,0xA637), "view":(12,0xA6C7), "build":(13,0xA853), "give":(14,0xAA1F), "bribe":(15,0xAAAE),
  "assign":(16,0xAD67), "rest":(17,0xADB3), "map":(18,0xAF38), "grant":(19,0xAF66),
  "other":(20,0xB23E), "pass":(21,0xB2A1),
}

# =====================================================================
#  COMMAND REGISTRY  — one spec per command. Atomic specs carry the full
#  content; functional specs stay deliberately thin (+ rabbit_holes links).
#  Fill these in as each command is walked.
# =====================================================================
COMMANDS = {
  "grow": {
    "type": "atomic", "no": 7, "name": "Grow",
    "driver": 0x9D3D, "effect": 0x87F0, "anim_id": 9,
    "tagline": "Spend gold to raise a province's agricultural <b>output</b> — on a "
               "diminishing-returns curve, at the cost of loyalty and flood-control.",
    "anim_cap": "A peasant works the field while the <b>output meter</b> climbs beside him.",
    "flow": [
      (0x9D4C, 'Select <b>Grow</b> from the command menu, then the province.'),
      (0x9D57, '<b>Limit check.</b> If <code>output ≥ header</code> (development ceiling) → '
               '<span class="scr">"We’re at our limit."</span> and the command aborts.'),
      (0x9D68, '<b>Gold check.</b> If the province has no gold → '
               '<span class="scr">"You have no gold."</span>'),
      (0x9D7C, 'Prompt: <span class="scr">"Output is <i>N</i>. Spend how much on it?"</span>'),
      (0x9D88, '<b>Number entry</b>, capped at the province’s current gold.'),
      (0x9D99, '<code>effect_grow</code> applies the formula (below).'),
      (0x9D9B, '<b>The animation plays</b> — <code>ui_helper_e80c(9)</code> hands id 9 to the '
               'bank-14 animation VM.'),
      (0x9DAD, '<span class="scr">"Output is now <i>N</i>."</span> → confirm.'),
    ],
    "formula": (
'<span class="c">// gain — inverse-sqrt diminishing returns</span>\n'
'sqrt   = <span class="k">int_sqrt</span>(output + amount)\n'
'gain   = 2 &times; &lfloor;amount &times; (6 &minus; const_two) &divide; sqrt&rfloor;   '
'<span class="c">// const_two=$6D63 ≈ 1, so ×5</span>\n'
'gain   = <span class="k">max</span>(gain, 1)\n'
'gain   = <span class="k">min</span>(gain, header &minus; output)            '
'<span class="c">// headroom clamp (rarely fires)</span>\n\n'
'<span class="c">// secondary drains — pct is computed LIVE, scaling with grow aggressiveness</span>\n'
'pct    = (gain/2 &gt; output) ? <b>50</b> : &lfloor;100 &times; gain &divide; (gain + output)&rfloor; &divide; 2\n'
'loyalty &minus;= <span class="k">pct_op</span>(loyalty, pct)              '
'<span class="c">// ⌊loyalty × pct ÷ 100⌋</span>\n'
'dams    &minus;= <span class="k">pct_op</span>(dams,    pct)              <span class="c">// same pct</span>\n\n'
'output &plus;= gain\n'
'gold   &minus;= amount                            <span class="c">// debited by the driver</span>'),
    "roi": "ROI ≈ <code>10 / √(output + amount)</code> — front-load Grow while output is "
           "low; returns fall off sharply past output ≈ 300.",
    "callout": (
"<b>Correction (2026-06-02).</b> The secondary-drain percentage is <b>not the constant 20</b> the "
"earlier docs reported. The bytecode at <code>$8833–$884E</code> computes it live from the "
"gain-to-output ratio, capped at 50%. The “20” was a coincidence of the one test where drains "
"were measured (gain&nbsp;56, output&nbsp;80 → ⌊5600/136⌋/2&nbsp;=&nbsp;20). Likewise the "
"“5” multiplier is really <code>6&nbsp;&minus;&nbsp;const_two</code>, not a literal constant."),
    "validation": {
      "caption": "Five controlled Grows on one province — predicted gain vs. observed, exact every time.",
      "headers": ["#", "output", "amount", "√", "predicted gain", "actual", "✓"],
      "rows": [
        ["1","80","69","12","2×⌊69·5÷12⌋ = 56","56","ok"],
        ["2","136","37","13","2×⌊37·5÷13⌋ = 28","28","ok"],
        ["3","164","65","15","2×⌊65·5÷15⌋ = 42","42","ok"],
        ["4","206","85","17","2×⌊85·5÷17⌋ = 50","50","ok"],
        ["5","256","115","19","2×⌊115·5÷19⌋ = 60","60","ok"],
      ],
      "note": "Args captured mid-call from the VM trace (Test&nbsp;5): <code>amount=115</code>, "
              "<code>mult=5</code>, <code>sqrt=19</code> at frame offsets +0xB/+0xD/+0xF → "
              "<code>math32_3arg(115,5,19)=30</code>, doubled = 60.",
    },
    "fields": "<code>output</code>&nbsp;(+gain) · <code>loyalty</code>&nbsp;(−drain) · "
              "<code>dams</code>&nbsp;(−drain) · <code>gold</code>&nbsp;(−amount)",
  },

  "build": {
    "type": "atomic", "no": 13, "name": "Build",
    "driver": 0xA853, "effect": 0x88A6, "anim_id": 24,
    "tagline": "Spend gold to raise a province's <b>town</b> infrastructure — the gold-income "
               "engine — on the same diminishing-returns curve as Grow, at the cost of wealth.",
    "anim_cap": "A carpenter raises scaffolding and lumber as the <b>town</b> grows around him.",
    "flow": [
      (0xA858, 'Select <b>Build</b> from the command menu, then the province.'),
      (0xA863, '<b>Limit check.</b> If <code>town ≥ header</code> (development ceiling) → '
               '<span class="scr">"We’re at our limit."</span> and the command aborts.'),
      (0xA87C, '<b>Gold check.</b> If the province has no gold → '
               '<span class="scr">"You have no gold."</span>'),
      (0xA881, 'Prompt: <span class="scr">"Town is <i>N</i>. Spend how much on it?"</span>'),
      (0xA896, '<b>Number entry</b>, capped at the province’s current gold.'),
      (0xA8A2, '<code>gold −= amount</code> — the driver debits gold <i>before</i> the effect runs.'),
      (0xA8A9, '<code>effect_build</code> applies the formula (below).'),
      (0xA8B0, '<b>The animation plays</b> — <code>ui_helper_e80c(24)</code> hands id 24 to the '
               'bank-14 animation VM.'),
      (0xA8B6, '<span class="scr">"Town value is now <i>N</i>."</span> → confirm.'),
    ],
    "formula": (
'<span class="c">// gain — inverse-sqrt diminishing returns (Grow’s kernel, on TOWN)</span>\n'
'sqrt = <span class="k">int_sqrt</span>(town + amount)\n'
'g    = &lfloor;amount &times; (6 &minus; const_two) &divide; sqrt&rfloor;       '
'<span class="c">// const_two=$6D63 ≈ 1, so ×5</span>\n'
'g    = <span class="k">max</span>(g, 1)\n'
'g    = <span class="k">min</span>(g, header &minus; town)             '
'<span class="c">// headroom clamp (rarely fires)</span>\n\n'
'<span class="c">// secondary drain — ONE field (wealth); pct computed LIVE, capped 50%</span>\n'
'pct  = (g &gt; town) ? <b>50</b> : &lfloor;100 &times; g &divide; (g + town)&rfloor; &divide; 2\n'
'wealth &minus;= <span class="k">pct_op</span>(wealth, pct)              '
'<span class="c">// ⌊wealth × pct ÷ 100⌋</span>\n\n'
'<span class="c">// town write — routed through helper_dam_rounding(town_ptr, 2g)</span>\n'
'town &plus;= 2 &times; g                             '
'<span class="c">// full add in peacetime; halved if the province is at war</span>\n'
'gold &minus;= amount                           <span class="c">// debited by the driver</span>\n'
'return g                                <span class="c">// (un-doubled) for the confirm screen</span>'),
    "roi": "ROI ≈ <code>10 / √(town + amount)</code> — the identical curve to Grow, but Build feeds "
           "<b>gold</b> income (town is in the gold-harvest formula) where Grow feeds rice. "
           "Front-load Build while town is low.",
    "callout": (
"<b>Two corrections to the earlier notes (2026-06-02, full bytecode walk + ROM re-execution).</b> "
"<b>(1)</b> The wealth-drain percentage is <b>not the constant 20</b> — exactly like Grow, the bytecode "
"at <code>$88E4–$88FF</code> computes it live from the gain-to-town ratio, capped at 50%. "
"<b>(2)</b> There is <b>no separate “main + secondary” town add</b>. The whole gain (<code>2g</code>) is "
"added <i>once</i>, through <code>helper_dam_rounding</code> (<code>$887D</code>), which only halves the "
"amount when the province is at war (<code>war_helper_d972</code>), then calls <code>helper_82AC</code> to "
"cap town at its <code>header</code> ceiling. The “secondary bump” in the old draft was a misread of that "
"single routed write."),
    "validation": {
      "caption": "Five Builds run through the real ROM effect handler (one province, town=176, "
                 "wealth=235) — predicted vs. observed, exact every time.",
      "headers": ["amount", "√(town+amt)", "g", "town += 2g", "wealth −", "✓"],
      "rows": [
        ["30","14","10","+20","−4","ok"],
        ["50","15","16","+32","−9","ok"],
        ["80","16","25","+50","−13","ok"],
        ["120","17","35","+70","−18","ok"],
        ["200","19","52","+104","−25","ok"],
      ],
      "note": "Args captured mid-call from the VM (amount&nbsp;200): "
              "<code>math32_3arg(200,5,19)=52</code> → <code>town += 104</code>; "
              "<code>math32_2arg(52,176)=22</code> → <code>pct=11</code> → "
              "<code>pct_op(235,11)=25</code> drained from wealth. The earlier in-game Test&nbsp;1 "
              "(town 320→396, amount 170) also fits: <code>√490=22</code>, "
              "<code>g=⌊850/22⌋=38</code>, <code>town += 76</code> ✓.",
    },
    "fields": "<code>town</code>&nbsp;(+2g) · <code>wealth</code>&nbsp;(−drain) · "
              "<code>gold</code>&nbsp;(−amount)",
  },

  "give": {
    "type": "atomic", "no": 14, "name": "Give",
    "driver": 0xAA1F, "effect": 0xA8D3, "anim_id": 6,
    "tagline": "Spend a resource (gold or rice) on the people or the army to buy <b>loyalty</b>, "
               "<b>wealth</b> or <b>morale</b> — the widest command, touching the most fields.",
    "anim_cap": "A lord distributes largesse to kneeling peasants — loyalty rising with each bow.",
    "flow": [
      (0xAA2F, 'Select <b>Give</b> and the province; prompt <span class="scr">"(Peasnts/Men)?"</span> '
               '(<code>effect_give_a</code>) picks the recipient group.'),
      (0xAA35, '<b>Eligibility check</b> (<code>effect_give_c</code>).'),
      (0xAA44, 'If you have no peasants / no soldiers → '
               '<span class="scr">"You have no peasants!"</span> / '
               '<span class="scr">"You have no soldiers!"</span> and abort.'),
      (0xAA5C, '<b>Limit check.</b> If the target stat is already at the <code>header</code> ceiling → '
               '<span class="scr">"We’re at our limit."</span>'),
      (0xAA8A, 'Prompt <span class="scr">"(Gold/Rice)?"</span> then "how much" '
               '(<code>effect_give_b</code> → <code>give_transfer_apply</code>).'),
      (0xA8D3, '<b>Transfer applies</b> — the source resource drains 1:1, then the target helper(s) run.'),
      (0xAA93, '<b>The animation plays</b> — <code>ui_helper_e80c(6)</code> hands id 6 to the '
               'bank-14 animation VM.'),
      (0xAA98, 'The giving daimyo gains <b>+1 charisma</b> (<code>$AA98</code>).'),
      (0xAAA0, '<span class="scr">"Thank you, my lord."</span> → confirm.'),
    ],
    "formula": (
'<span class="c">// SOURCE drain — 1:1, no attrition   (give_transfer_apply $A8D3)</span>\n'
'src    = (asset == Gold) ? gold : rice\n'
'amount = <span class="k">number_input</span>(cap = src)\n'
'src   &minus;= amount\n\n'
'<span class="c">// TARGET gain — Grow’s kernel, but “current” = the average of a thematic PAIR</span>\n'
'<span class="c">// Peasants mode runs BOTH of:</span>\n'
'loyalty &plus;= give( pair = (output &plus; loyalty)&divide;2 )    '
'<span class="c">// give_loyalty $891D</span>\n'
'wealth  &plus;= give( pair = (town   &plus; wealth )&divide;2 )    '
'<span class="c">// give_wealth  $896F</span>\n'
'<span class="c">// Men mode runs only:</span>\n'
'morale  &plus;= give( pair = (men    &plus; morale )&divide;2 )    '
'<span class="c">// give_morale  $89C1</span>\n\n'
'<span class="k">where</span> give(pair):\n'
'   g     = &lfloor;amount &times; (6 &minus; const_two) &divide; &radic;(pair + amount)&rfloor;   '
'<span class="c">// ×5</span>\n'
'   g     = <span class="k">max</span>(g, 1);  g = <span class="k">min</span>(g, header &minus; field)\n'
'   field &plus;= 2 &times; g                            '
'<span class="c">// NO drain — pure benefit</span>'),
    "roi": "Best loyalty/morale ROI when the partner stat is high and the target is low (the "
           "<code>pair + amount</code> denominator stays small). Rice→Peasants is the staple loyalty "
           "pump — pair it with <b>Send</b> to convert a maxed fief’s rice surplus into frontier loyalty.",
    "callout": (
"<b>The widest command.</b> Peasants mode raises <b>two</b> fields (loyalty <i>and</i> wealth); Men mode "
"raises morale. Each target is averaged with its <b>thematic complement</b> before the curve — "
"loyalty↔output, wealth↔town, morale↔men — which pulls a pumped stat back toward its neglected twin and "
"blocks runaway single-stat stacking. Unlike Grow and Build there is <b>no secondary drain</b>: the only "
"cost is the source resource (1:1), and the giving daimyo even gains <b>+1 charisma</b>. The earlier "
"“3-field” observation was exactly right — Rice→Peasants really does bump loyalty + wealth together."),
    "validation": {
      "caption": "Give Rice→Peasants in-game (Tokugawa, amount=59) — one command, both target helpers, "
                 "predicted vs. observed.",
      "headers": ["helper", "pair-avg → √", "g", "field += 2g", "observed", "✓"],
      "rows": [
        ["give_loyalty","(out 136 + loy 37)/2 = 86 → √145 = 12","⌊295/12⌋ = 24","loyalty +48","+48","ok"],
        ["give_wealth","(town 66 + wlth 47)/2 = 56 → √115 = 10","⌊295/10⌋ = 29","wealth +58","+58","ok"],
      ],
      "note": "Source: <code>rice 130 → 71</code> (−59, exactly 1:1). A second new-game Give-Rice test "
              "(2026-05-26) matched as well. Men-mode instead runs <code>give_morale</code> on "
              "<code>(men + morale)/2</code>.",
    },
    "fields": "<code>loyalty</code>&nbsp;+2g · <code>wealth</code>&nbsp;+2g (Peasants) / "
              "<code>morale</code>&nbsp;+2g (Men) · source <code>rice</code>/<code>gold</code>&nbsp;−amount · "
              "daimyo <code>charisma</code>&nbsp;+1",
  },

  "train": {
    "type": "atomic", "no": 11, "name": "Train",
    "driver": 0xA637, "effect": 0x9586, "anim_id": 10,
    "tagline": "Drill a province’s garrison to raise its <b>skill</b> — the combat-damage multiplier. "
               "The only free stat-up in the game: no gold, no rice, no drains.",
    "anim_cap": "Two samurai spar with spears as the garrison’s <b>skill</b> climbs.",
    "flow": [
      (0xA63C, 'Select <b>Train</b>, then the province.'),
      (0xA647, '<b>Skill-ceiling guard</b> — proceeds while <code>skill &lt; header</code> (effectively always).'),
      (0xA655, '<b>Soldier check.</b> If the province has no men → '
               '<span class="scr">"You have no soldiers!"</span> — you can’t drill an empty garrison.'),
      (0xA671, '<b>The animation plays first</b> — <code>ui_helper_e80c(10)</code> hands id 10 to the '
               'bank-14 animation VM (note: Train animates <i>before</i> applying, unlike Grow/Build).'),
      (0xA676, '<code>effect_train</code> rolls the skill gain (formula below).'),
      (0xA679, '<code>skill</code> is clamped to its ceiling, then the new value is shown.'),
    ],
    "formula": (
'<span class="c">// skill drill — pure RNG stat-up, NO cost, NO drain   (effect_train $9586)</span>\n'
'skill_gain = (<span class="k">rng</span>%20 + 10) &times; 4              '
'<span class="c">// 40 .. 116   ((roll+10) << 2)</span>\n\n'
'<span class="c">// aptitude bonus — a gifted daimyo drills his men harder</span>\n'
'<span class="k">if</span> daimyo[+3] + daimyo[+5] &gt; <span class="k">rng</span>%10 + 90:    '
'<span class="c">// (Luck + IQ) vs 90..99</span>\n'
'    skill_gain &plus;= 10                       '
'<span class="c">// → 50 .. 126</span>\n\n'
'skill &plus;= skill_gain                          '
'<span class="c">// capped at the fief ceiling</span>'),
    "roi": "Free skill, but RNG-variable (a session swings 40–116 on the d20 roll). Drill idle "
           "garrisons between wars — high skill feeds straight into the combat damage multiplier. "
           "There is never a reason <i>not</i> to Train an army that has soldiers and time.",
    "callout": (
"<b>The cleanest command in the game.</b> No gold, no rice, no drains — Train is the only free stat-up, "
"which is exactly why elite armies are <b>trained, not hired</b> (Hire dilutes the average; see hire.html). "
"The price is variance: the d20 roll swings a session 40–116. The aptitude bonus rewards a smart, lucky "
"daimyo — for Tokugawa (aptitude pair = 167, always above the 90–99 threshold) the +10 always fires, so "
"his floor is 50. The <code>40–80</code> range in the earlier notes was a misread — the bytecode "
"<code>$959A–$95A2</code> shifts <code>(roll+10)</code> left twice (×4)."),
    "validation": {
      "caption": "Train is RNG-driven — validated by range, not by point. The d20 roll sets the band; "
                 "9/9 in-game Tokugawa sessions landed inside it.",
      "headers": ["rng%20 roll", "base = (roll+10)×4", "+ aptitude bonus"],
      "rows": [
        ["0 (min)", "40", "50"],
        ["9 (mid)", "76", "86"],
        ["19 (max)", "116", "126"],
      ],
      "note": "Tokugawa’s daimyo aptitude (record +3 + +5 = 167) always clears the "
              "<code>rng%10 + 90</code> threshold (max 99), so his +10 bonus always fires → effective "
              "band 50–126. Confirmed across 9 controlled sessions (2026-05-24/25).",
    },
    "fields": "<code>skill</code>&nbsp;(+40–126) — that’s all. No cost, no drain, no other field touched.",
  },

  "tax": {
    "type": "atomic", "no": 3, "name": "Tax",
    "driver": 0x999A, "effect": 0x82D6, "anim_id": 19,
    "tagline": "Set a province’s tax rate. Raising it drains loyalty <i>and</i> wealth (and costs "
               "charisma); lowering it restores them. Symmetric, one-shot — and scales with the CHANGE.",
    "anim_cap": "Peasants sit amid the koku they owe — then the coins are taken and discontent sets in "
                "(the tax-<i>raised</i> animation, id 19).",
    "flow": [
      (0x999F, 'Select <b>Tax</b> and the province; the window shows the current rate.'),
      (0x99BC, 'Prompt: <span class="scr">"Tax is <i>N</i>. Enter new tax."</span> (capped at 100, '
               'or 30 under <code>tax_helper_db12</code>).'),
      (0x99DB, '<b>Number entry</b> → the new rate. Cancel or no-change → bail.'),
      (0x99EF, '<b>Direction branch.</b> If raised → animation <b>19</b> + '
               '<span class="scr">"The peasants are protesting."</span> '
               'If lowered → animation <b>18</b> + <span class="scr">"The peasants are delighted."</span>'),
      (0x9A1C, '<b>Daimyo charisma:</b> <code>−1</code> if you raised tax, <code>+1</code> if you lowered it.'),
      (0x9A3B, 'The province’s tax byte is set to the new rate.'),
      (0x9A42, '<code>loyalty ±= pct_op(loyalty, |Δtax|)</code> via <code>effect_tax</code> '
               '($82D6) — drops on a raise, recovers on a cut.'),
      (0x9A4C, '<code>wealth ±= pct_op(wealth, |Δtax|)</code> — same magnitude. → confirm.'),
    ],
    "formula": (
'<span class="c">// Tax is symmetric: the hit scales with the CHANGE, not the level</span>\n'
'&Delta;      = new_tax &minus; old_tax            <span class="c">// signed</span>\n\n'
'<span class="c">// effect_tax ($82D6) applied to BOTH loyalty and wealth:</span>\n'
'<span class="k">stat_adjust</span>(stat):\n'
'    move = <span class="k">pct_op</span>(stat, |&Delta;|)        '
'<span class="c">// ⌊stat × |Δ| ÷ 100⌋</span>\n'
'    stat = (&Delta; &gt; 0) ? stat &minus; move    '
'<span class="c">// raise tax → people sour</span>\n'
'                  : stat &plus; move    '
'<span class="c">// lower tax → people warm</span>\n\n'
'loyalty  = stat_adjust(loyalty)        <span class="c">// record +12</span>\n'
'wealth   = stat_adjust(wealth)         <span class="c">// record +14</span>\n'
'charisma &plus;= (&Delta; &gt; 0) ? &minus;1 : &plus;1        '
'<span class="c">// daimyo record +4</span>\n'
'tax[fief] = new_tax'),
    "roi": "Set tax high — <b>~55% is the sweet spot</b> — on turn one and <b>leave it</b>. Every "
           "re-fiddle re-charges the loyalty/wealth penalty, so a province whose rate you keep flipping "
           "bleeds far more than its harvest gains. Pushing past ~55–60% also opens Riot vulnerability "
           "(see the event system).",
    "callout": (
"<b>Symmetric and one-shot — the key strategic property.</b> Raising the rate by |Δ| points immediately "
"drains <b>both</b> loyalty and wealth by |Δ|% (and costs the daimyo 1 charisma); lowering it <b>restores</b> "
"the same percentage (and earns 1 charisma). Because the penalty scales with the <b>change</b> and not the "
"level, the optimal play is to set tax high <i>once</i>, early, and never touch it again — every adjustment "
"is a fresh tax on your own people. Note the underlying <code>effect_tax</code> ($82D6) is a generic "
"signed-percent primitive; the driver $999A calls it twice (loyalty, then wealth) with the tax delta."),
    "validation": {
      "caption": "A tax change of |Δ| points moves BOTH loyalty and wealth by pct_op(stat, |Δ|), "
                 "opposite the tax direction. Worked from the unit-verified pct_op primitive.",
      "headers": ["stat (pre)", "|Δtax|", "pct_op(stat,|Δ|)", "raise tax →", "lower tax →"],
      "rows": [
        ["loyalty 80","10","8","72","88"],
        ["loyalty 80","20","16","64","96"],
        ["wealth 120","20","24","96","144"],
        ["wealth 50","40","20","30","70"],
      ],
      "note": "<code>pct_op</code> is verified to the unit across 8+ observed drain calls "
              "(appendix §6). Charisma moves the <i>other</i> way: <code>+1</code> when you lower "
              "tax, <code>−1</code> when you raise it. In-game verified — see "
              "<a href='../appendix-formulas.md'>the tax-penalty formula</a>.",
    },
    "fields": "<code>loyalty</code>&nbsp;±pct · <code>wealth</code>&nbsp;±pct (same %, opposite the tax "
              "move) · province <code>tax</code>&nbsp;:= new rate · daimyo <code>charisma</code>&nbsp;∓1",
  },

  "send": {
    "type": "atomic", "no": 4, "name": "Send",
    "driver": 0x9A5D, "effect": 0x8BE5, "anim_id": 17,
    "tagline": "Ship rice <i>and</i> gold to one of your other provinces. Zero attrition — the only "
               "limit is the receiver’s headroom. The snowball engine.",
    "anim_cap": "A porter hauls a cart of koku and goods overland to the receiving province.",
    "flow": [
      (0x9A67, 'Select <b>Send</b>, then the destination — <span class="scr">"Send where?"</span>'),
      (0x9A9C, '<b>Rice capacity</b> = min(target.header − target.rice, source rice available).'),
      (0x9AB2, 'Prompt <span class="scr">"Rice"</span> → number entry (capped at capacity). '
               'Zero capacity → <span class="scr">"We’re at our limit."</span>'),
      (0x9AE6, '<b>Gold capacity</b> = min(target.header − target.gold, source gold available).'),
      (0x9AFB, 'Prompt <span class="scr">"Gold"</span> → number entry (capped at capacity).'),
      (0x9B34, '<span class="scr">"Is this OK?"</span> confirmation.'),
      (0x9B41, '<b>Apply:</b> target gold/rice += amounts; source gold/rice −= amounts — exactly 1:1.'),
      (0x9B6A, '<b>The animation plays</b> — <code>ui_helper_e80c(17)</code> hands id 17 to the '
               'bank-14 animation VM.'),
      (0x9B70, '<span class="scr">"The supplies have arrived safely."</span> → confirm.'),
    ],
    "formula": (
'<span class="c">// per resource (rice, then gold) — capacity helper effect_send ($8BE5)</span>\n'
'capacity = <span class="k">min</span>( target.header &minus; target.field,   '
'<span class="c">// receiver headroom</span>\n'
'                source.available )      '
'<span class="c">// can’t send what you lack</span>\n'
'amount   = <span class="k">number_input</span>(cap = capacity)\n\n'
'<span class="c">// applied at confirm — NO attrition, exactly 1:1</span>\n'
'target.rice &plus;= rice_amt;   source.rice &minus;= rice_amt\n'
'target.gold &plus;= gold_amt;   source.gold &minus;= gold_amt'),
    "roi": "Send from a maxed donor whose output you can no longer use — those fiefs are worth more as "
           "<b>pumps</b> than as producers. Doctrine: when a donor’s surplus exceeds ~3–4× a recipient’s, "
           "ship it; when the donor is capped, <i>always</i> ship.",
    "callout": (
"<b>The snowball engine.</b> Two properties make Send the backbone of a runaway economy: "
"<b>(1) zero attrition</b> — every koku and gold piece arrives — and <b>(2)</b> the only limit is the "
"<b>receiver’s</b> headroom (<code>header − current</code>). A maxed-out fief can therefore act as a pure "
"pump, shovelling its whole surplus to the frontier each turn at no loss. Pair it with <b>Give</b> "
"(which converts shipped rice into loyalty/morale) and Grow/Build on the receiving end. Send moves rice "
"<i>and</i> gold in one command — two capacity checks, two number entries, one cart."),
    "validation": {
      "caption": "effect_send caps each transfer at the receiver’s headroom and the sender’s stock — "
                 "min(header − current, available). No attrition.",
      "headers": ["target.header", "target.current", "headroom", "requested", "→ sent"],
      "rows": [
        ["1640","1400","240","100","100"],
        ["1640","1400","240","500","240"],
        ["1640","1640","0","100","0 (“at our limit”)"],
      ],
      "note": "Verified in-game (2026-05-26): all sent resources arrive — no travel loss. The binding "
              "cap is whichever is smaller — the receiver’s remaining capacity or the requested amount "
              "(itself further capped at what the sender actually holds).",
    },
    "fields": "target <code>rice</code>/<code>gold</code>&nbsp;+amount · "
              "source <code>rice</code>/<code>gold</code>&nbsp;−amount (1:1, no attrition)",
  },

  "hire": {
    "type": "atomic", "no": 10, "name": "Hire",
    "driver": 0xA5F4, "effect": 0xA553, "anim_id": 33,
    "tagline": "Spend gold to recruit <b>men</b> into a garrison. Recruits arrive at mediocre stats and "
               "are blended into the army by a men-weighted average — so Hire <i>dilutes</i> quality.",
    "anim_cap": "Fresh spearmen fall into formation as the garrison’s headcount climbs.",
    "flow": [
      (0xA5FC, 'Select <b>Hire</b>; validate the province.'),
      (0xA615, 'Prompt <span class="scr">"(Men/Ninja)?"</span> — <b>Men</b> recruits soldiers (this page); '
               '<b>Ninja</b> opens the sabotage-mission menu (→ <code>$A2D2</code>, see '
               '<a href="./ninja.html">ninja.html</a>).'),
      (0xA558, '(Men path, <code>effect_hire_men</code> $A553) army headroom = <code>header − men</code>.'),
      (0xA564, '<b>Affordability:</b> max men = f(gold, hire rate). No gold → '
               '<span class="scr">"You have no gold."</span>'),
      (0xA573, 'Prompt <span class="scr">"How many?"</span> → number entry (capped).'),
      (0xA584, '<code>gold −= amount × hire_rate</code> (the per-man rate re-rolls each turn).'),
      (0xA593, '<code>apply_hire_unit_stats</code>: roll recruit morale/skill/arms, dilute into the army, '
               '<code>men += amount</code>.'),
      (0xA5AE, '<b>The animation plays</b> — <code>ui_helper_e80c(33)</code> hands id 33 to the '
               'bank-14 animation VM.'),
      (0xA5C7, '<span class="scr">"Lord, we now have <i>N</i> men."</span> → confirm.'),
    ],
    "formula": (
'<span class="c">// COST   (effect_hire_men $A553)</span>\n'
'headroom = header &minus; men                          <span class="c">// army cap</span>\n'
'max_buy  = <span class="k">affordable</span>(gold, gold_men_hire_rate, headroom)\n'
'amount   = <span class="k">number_input</span>(cap = max_buy)\n'
'gold    &minus;= amount &times; gold_men_hire_rate          '
'<span class="c">// rate $6E11 — RE-ROLLS each turn</span>\n\n'
'<span class="c">// RECRUIT STATS — random per batch   (apply_hire_unit_stats $8BF4)</span>\n'
'morale_base = <span class="k">rng</span>%20 + 40                    <span class="c">// 40 .. 59</span>\n'
'skill_base  = <span class="k">rng</span>%20 + 60                    <span class="c">// 60 .. 79</span>\n'
'arms_base   = <span class="k">rng</span>%10 + 50                    <span class="c">// 50 .. 59</span>\n\n'
'<span class="c">// DILUTION — men-weighted average, capped at header (morale, skill, arms)</span>\n'
'new_stat = <span class="k">min</span>( header, (stat &times; men + base &times; amount) &divide; (men + amount) )\n'
'men &plus;= amount'),
    "roi": "Hire when current stats are low (recruits don’t drag much) or to refill after combat losses. "
           "<b>Never</b> hire into a small high-skill army — you’ll wreck its average. Watch the per-turn "
           "hire rate; it fluctuates, so some seasons recruiting is markedly cheaper.",
    "callout": (
"<b>Two commands behind one prompt.</b> “(Men/Ninja)?” — <b>Men</b> recruits soldiers (this page); "
"<b>Ninja</b> opens the sabotage-mission menu (Uprising / Revolt / Dams / Assassin / Arson at "
"<code>$A2D2</code>, animation 12) — its own page, <a href=\"./ninja.html\">ninja.html</a>. "
"<i>(The earlier docs labeled <code>$A2D2</code> “effect_hire” and filed this menu under <b>Bribe</b>; the "
"bytecode shows it is the Hire▸Ninja path — now <code>effect_ninja_sabotage</code> — recruit-men lives in "
"<code>$A553</code>, and Bribe is a separate gold-for-spy command.)</i> For recruiting, the catch is "
"<b>dilution</b>: "
"fresh recruits (morale 40–59, skill 60–79, arms 50–59) are blended in by a men-weighted average, so "
"hiring into a small elite garrison drags its skill <b>down</b>. That is exactly why elite armies are "
"<b>trained</b> (no dilution — see train.html) and Hire is for restoring body-count or staffing a new fief."),
    "validation": {
      "caption": "In-game (Fall 1566, fief 6 hired 30 men into 55) — the post-state matches the "
                 "men-weighted dilution of the recruit bases.",
      "headers": ["stat", "pre (55 men)", "recruit base", "post (85 men)", "implied base"],
      "rows": [
        ["morale","111","40–59","88","46 ✓"],
        ["skill","590","60–79","401","55 ✓*"],
        ["arms","70","50–59","66","59 ✓"],
      ],
      "note": "Dilution: <code>new = (stat×55 + base×30) / 85</code>. E.g. arms "
              "<code>(70×55 + 59×30)/85 = 66</code> ✓. *Skill’s implied 55 sits just below the 60–79 band — "
              "consistent with the session being multiple batched hires. men: 55 → 85 (+30).",
    },
    "fields": "<code>men</code>&nbsp;+amount · <code>morale</code>/<code>skill</code>/<code>arms</code> "
              "diluted toward recruit bases · <code>gold</code>&nbsp;−(amount × hire rate)",
  },

  "dam": {
    "type": "atomic", "no": 5, "name": "Dam",
    "driver": 0x9B7E, "effect": 0x9B7E, "anim_id": 21,
    "tagline": "Spend gold on flood-control to raise <b>dams</b> (0–100) — a rice-harvest multiplier. "
               "The only capped stat, and the gain shrinks as the fief’s output grows.",
    "anim_cap": "A laborer drives stakes along the riverbank, holding back the blue water below.",
    "flow": [
      (0x9B83, 'Select <b>Dam</b>, the province. If <code>output == 0</code> → '
               '<span class="scr">"You have no peasants!"</span> (you can’t dam undeveloped land).'),
      (0x9BAA, '<b>Limit check.</b> If <code>dams ≥ 100</code> → '
               '<span class="scr">"We’re at our limit."</span> (dams is the only 0–100-capped stat).'),
      (0x9BBE, '<b>Gold check.</b> No gold → <span class="scr">"You have no gold."</span>'),
      (0x9BCF, '<b>Spend cap</b> = min(gold, (100 − dams) × √output ÷ 2).'),
      (0x9BEA, 'Prompt: <span class="scr">"Dams is <i>N</i>. Spend how much on it?"</span> → number entry.'),
      (0x9C08, '<code>gold −= amount</code>.'),
      (0x9C0F, '<code>gain = ⌊2 × amount ÷ √output⌋</code> (min 1); '
               '<code>dams += gain</code> via <code>helper_dam_rounding</code> (war-halves).'),
      (0x9C26, '<b>The animation plays</b> — <code>ui_helper_e80c(21)</code> hands id 21 to the '
               'bank-14 animation VM.'),
      (0x9C2C, '<code>dams</code> clamped to 100; <span class="scr">"Dams value is now <i>N</i>."</span> → confirm.'),
    ],
    "formula": (
'<span class="c">// preconditions (driver $9B7E)</span>\n'
'<span class="k">if</span> output == 0:  <span class="c">// "you have no peasants" — can’t dam undeveloped land</span>\n'
'<span class="k">if</span> dams  &gt;= 100: <span class="c">// "we’re at our limit" — dams is the ONLY 0–100-capped stat</span>\n'
'<span class="k">if</span> gold  == 0:   <span class="c">// "you have no gold"</span>\n\n'
'sqrt = <span class="k">int_sqrt</span>(output)                       '
'<span class="c">// via $87D8 (the real "effect_dam" is just this)</span>\n\n'
'<span class="c">// spend cap — couples to output AND remaining dam headroom</span>\n'
'max_spend = <span class="k">min</span>( gold, (100 &minus; dams) &times; sqrt &divide; 2 )\n'
'amount    = <span class="k">number_input</span>(cap = max_spend)\n'
'gold     &minus;= amount\n\n'
'<span class="c">// gain — INVERSELY proportional to √output</span>\n'
'gain  = <span class="k">max</span>(1, &lfloor; 2 &times; amount &divide; sqrt &rfloor;)\n'
'dams &plus;= gain                            '
'<span class="c">// helper_dam_rounding $887D: war-halves, caps at 100</span>'),
    "roi": "Dam multiplies with output in the rice harvest (<code>rice += pct_op(output × dams, tax)</code>), "
           "so its ROI <i>rises</i> with output even as the gold cost does. Rule of thumb: Dam beats Grow "
           "for rice once <code>output² &gt; ~38 × dams</code> — i.e. dam your already-high-output rice fiefs.",
    "callout": (
"<b>The last open formula — and it never lived where the labels said.</b> <code>$87D8</code> (tagged "
"“effect_dam”) is merely a <code>sqrt(output)</code> helper; the real dam math is computed <b>inline in the "
"driver $9B7E</b> and applied through <code>helper_dam_rounding</code> (<code>$887D</code>, shared with "
"Build). Two defining properties: dams is the <b>only</b> province stat capped at 0–100, and the gain is "
"<b>inversely proportional to √output</b> — a developed fief pays far more gold per dam point. The spend cap "
"<code>(100−dams)×√output÷2</code> is exactly the amount that lifts dams to 100, so “spend the max” always "
"tops out the dam. Dams matter because the rice harvest multiplies <b>output × dams</b> (appendix §4)."),
    "validation": {
      "caption": "Dam at Tokugawa’s state (output 254 → √=15, dams 39). The +56 row is the in-game "
                 "capture; the others apply the validated formula at the same state.",
      "headers": ["amount", "gain = ⌊2·amount/15⌋", "dams →", "note"],
      "rows": [
        ["100","⌊200/15⌋ = 13","52",""],
        ["250","⌊500/15⌋ = 33","72",""],
        ["424 (all gold)","⌊848/15⌋ = 56","95","in-game ✓"],
        ["457 (cap)","⌊914/15⌋ = 60","99","max spend"],
      ],
      "note": "Spend cap = min(gold, (100−dams)×√output÷2) = min(424, 61×15/2 = 457) = 424 → all gold "
              "spent. Validated against the <code>dam-mikawa</code> capture: dams 39 → 95 (+56), exact. "
              "Gain is inversely proportional to √output — a high-output fief pays MORE gold per dam point.",
    },
    "fields": "<code>dams</code>&nbsp;+gain (capped 0–100) · <code>gold</code>&nbsp;−amount",
  },

  # ---- War: the gateway INTO the battle engine (the command itself is short) ----
  "war": {
    "type": "functional", "no": 2, "name": "War",
    "driver": 0x9850, "effect": None, "anim_id": 13,
    "tagline": "Declare war and march an army at an adjacent enemy province. The command itself is "
               "short — it stages the attack and hands the whole battle to the tactical combat engine.",
    "anim_cap": "The march-out / battle-intro animation (id 13) — the army setting out for the front.",
    "summary": (
      "War (<code>driver_war $9850</code>) is the <b>gateway into the battle engine</b>, and by design "
      "the command’s own logic is brief: it <b>raises and dispatches</b> an army, then steps aside. "
      "After a chain of preconditions (<code>effect_war_combat_prep_a/b/c/d</code> — you need an army, "
      "an adjacent valid target, and — if your daimyo is in the fief — his clearance to march), it asks "
      "<span class=\"scr\">Attack where?</span> (allies are rejected: <span class=\"scr\">They are your "
      "allies.</span>), then <span class=\"scr\">How many men?</span> and "
      "<span class=\"scr\">How much rice will they take?</span> — the army carries its own <b>supply</b>, "
      "which is the lever behind the rice-exhaustion siege. If your daimyo is present you may "
      "<span class=\"scr\">lead them personally</span> (sets bit 7 of <code>war_side_state_flag</code> — "
      "he joins the battle, and its risk). The driver then <b>debits the attacking fief</b> (men, rice "
      "and gold), <b>declares war</b> — <code>effect_war_a</code> zeroes the two daimyo’s relations "
      "cells, breaking any pact — stages the force in the <code>war_attacker_men/rice/gold</code> + "
      "<code>battle_defending_province</code> globals, plays the march animation "
      "(<code>ui_helper_e80c(13)</code>), flags the turn loop to redispatch "
      "(<code>ai_turn_loop_redispatch_flag = 1</code>), and returns. <b>Everything after that</b> — the "
      "tactical map, daily damage, morale, pursuit and the commander-resolution loop — runs in the "
      "separate bank-2 combat engine."),
    "flow": [
      (0x985F, '<b>Preconditions</b> — daimyo clearance + army/target/adjacency checks '
               '(<code>effect_war_combat_prep_a/b/c/d</code>).'),
      (0x98A5, '<span class="scr">"Attack where?"</span> — select an adjacent enemy province '
               '(an ally → <span class="scr">"They are your allies."</span> and abort).'),
      (0x98F1, '<b>Force size</b> capped at <code>min(gold, men)</code> (quartered if already at war).'),
      (0x9909, '<span class="scr">"How many men?"</span> → <code>war_attacker_men</code>.'),
      (0x991C, '<span class="scr">"How much rice will they take?"</span> → <code>war_attacker_rice</code> '
               '(the army’s <b>supply</b>), capped at <code>min(men, fief rice)</code>.'),
      (0x994A, '<b>If the daimyo is here:</b> <span class="scr">"Will you lead them personally?"</span> '
               '→ sets bit 7 of <code>war_side_state_flag</code> (he marches with the army).'),
      (0x9967, '<b>Debit the attacking fief:</b> gold, rice and men all subtracted.'),
      (0x9993, '<b>Declare war + hand off:</b> <code>effect_war_a</code> clears the relations cells; '
               'march animation <code>13</code>; <code>ai_turn_loop_redispatch_flag = 1</code> → the '
               'bank-2 engine takes over.'),
    ],
    "callout": (
      "<b>Deliberately a thin page — the depth is the engine, not the command.</b> War’s own driver just "
      "raises a force, charges its supply, declares the war, and flips a redispatch flag; the actual "
      "fight — tactical map, the 4-quadrant <code>{1,2,4,7}</code> damage model, the up-to-31-day loop "
      "that ends on <b>commander resolution</b> (not attrition), pursuit, and post-battle ravage / arms "
      "capture / ownership transfer — all lives in the <b>bank-2 combat engine</b>, which gets its own "
      "treatment. Two things the command <i>does</i> own are strategically load-bearing: the "
      "<b>rice-as-supply</b> prompt (an attacker with too little rice loses the siege to starvation) and "
      "the <b>lead-personally</b> choice (your daimyo can win a battle outright — or die in it)."),
    "rabbit_holes": [
      ("The bank-2 combat engine", "<code>battle_init_driver $AFE1</code> → the tactical battle: "
       "4-quadrant damage from attacker/defender geometry (<code>{1,2,4,7}</code> magnitudes via "
       "<code>select_quadrant_damage_by_direction $9675</code>), applied over a 31-day loop; the battle "
       "ends on COMMANDER resolution, not attrition. <b>Its own page/epic — intentionally not inlined "
       "here.</b>", "../12-combat-engine.md"),
      ("Rice-exhaustion siege", "the <span class=\"scr\">How much rice will they take?</span> supply is "
       "the rice-exhaustion mechanic — a coordinated assault can force a conquest by starving the "
       "defender’s stockpile rather than by killing the garrison.", None),
      ("Post-combat ravage / spoils", "the <code>$9323–$9368</code> ravage cluster + arms capture + "
       "<code>set_fief_ownership_record</code> — what happens to the province when the battle ends "
       "(part of the combat-engine epic).", None),
    ],
  },

  # ---- Hire ▸ Ninja: the sabotage subsystem (the "buy → ninja" path) ----
  "ninja": {
    "type": "functional", "no": 10, "name": "Ninja (Hire ▸ Ninja)",
    "driver": 0xA5F4, "effect": 0xA2D2, "anim_id": 12,
    "tagline": "Buy a ninja and send him on a sabotage mission against an enemy fief — "
               "uprising, revolt, flood, assassination or arson. The covert half of the Hire command.",
    "anim_cap": "The hired ninja steals out toward the target province (the shared mission-launch "
                "animation, id 12) — each mission then plays its own effect animation.",
    "summary": (
      "Reached from the <b>Hire</b> command’s <span class=\"scr\">(Men/Ninja)?</span> prompt — pick "
      "<b>Ninja</b> and you leave the recruiting sandbox for an offensive espionage subsystem "
      "(<code>effect_ninja_sabotage $A2D2</code>). You pay gold to hire the ninja (rate "
      "<code>hire_gold_rate $6E13</code>, which re-rolls every turn), choose a target fief "
      "(<span class=\"scr\">Send where?</span>), then choose one of five missions. A <b>ninja-skill "
      "contest</b> gates the outcome: the run proceeds only when your daimyo’s skill stat "
      "(<code>record +3</code>) <b>+ 30</b> beats the target daimyo’s — otherwise "
      "<span class=\"scr\">Your ninja failed!</span> and you forfeit the gold anyway "
      "(<code>effect_hire_pay_gold $A29B</code>). On success the target loses the mission’s fields and "
      "you see <span class=\"scr\">Fief X’s &lt;stat&gt; has declined by N</span>. <i>This is the "
      "system the old notes mis-filed under “Bribe” — see the correction below; the genuinely separate "
      "Bribe command gets its own page.</i>"),
    "flow": [
      (0xA615, 'From <b>Hire</b>, answer <span class="scr">(Men/Ninja)?</span> with <b>Ninja</b> '
               '(<code>ui_helper_d351</code>) → <code>effect_ninja_sabotage $A2D2</code>.'),
      (0xA2ED, 'Prompt <span class="scr">"How many"</span> — number entry (gated by affordability vs '
               '<code>hire_gold_rate</code>; no gold → <span class="scr">"You have no gold."</span>).'),
      (0xA31B, 'Prompt <span class="scr">"Send where?"</span> — pick the target province.'),
      (0xA335, 'Prompt <span class="scr">"What mission"</span> → the menu '
               '<span class="scr">"1-Uprisng 2-Revolt 3-Dams 4-Assassin 5-Arson"</span> '
               '(<code>$BD8F</code>).'),
      (0xA36D, '<b>The ninja sets out</b> — <code>ui_helper_e80c(12)</code> plays the mission-launch '
               'animation (each mission then has its own effect animation; see the table).'),
      (0xA396, '<b>Ninja-skill contest.</b> Proceeds only if <code>target_daimyo[+3] &lt; '
               'your_daimyo[+3] + 30</code> — a fixed +30 attacker edge on the skill stat.'),
      (0xA39A, '<b>Mission switch</b> — dispatch to the chosen sabotage effect (drains via '
               '<code>hire_stat_drain_rng</code>, clamped so a field never goes below 0).'),
      (0xA2AD, '<b>On failure</b> → <span class="scr">"Your ninja failed!"</span>; gold is spent '
               'regardless (<code>effect_hire_pay_gold</code>).'),
    ],
    "table_heading": "The five missions",
    "table": {
      "caption": "Each mission drains specific fields of the TARGET fief and plays its own animation. "
                 "Read straight from the <code>switch</code> at <code>$A39A</code>.",
      "headers": ["#", "Mission", "Drains on the target fief", "Anim", "Code"],
      "rows": [
        ["1", "Uprising", "loyalty + wealth", "28", "$A3AB"],
        ["2", "Revolt", "morale", "27", "$A45A"],
        ["3", "Dams", "dams + rice (flood)", "30", "$A497"],
        ["4", "Assassin", "kills the enemy daimyo — gated by “daimyo present” ($6DA2); resolves in "
         "ninja_mission_resolve_vs_defender", "1*", "$A508"],
        ["5", "Arson", "town", "29", "$A510"],
      ],
      "note": "Drain magnitude (from <code>hire_stat_drain_rng $A255</code> bytecode): "
              "<code>drain = (rng % max(1, ⌊field × √(your_skill+30) ÷ 100⌋) + 1) × 5</code> — always a "
              "multiple of 5 (max 5×the cap), scaling with the target field’s value and your daimyo’s "
              "skill (record +3, with a +30 edge). Each drain is clamped to the field (can zero a stat, "
              "never negative). <b>Emulator-confirmed</b> across the full RNG band "
              "(<code>tools/probe-espionage.py</code> — the observed drains matched "
              "<code>{5,10,…,X×5}</code> for every test vector). *Assassin has no field-drain "
              "animation of its own — it runs the resolution sub, which plays animation 1.",
    },
    "callout": (
      "<b>This is the “buy → ninja” system — and it is NOT Bribe.</b> The toml long labeled "
      "<code>$A2D2</code> <code>effect_hire</code>, and an earlier note filed the whole "
      "Uprising/Revolt/Dams/Assassin/Arson menu under the <b>Bribe</b> command. The bytecode says "
      "otherwise: this menu hangs off <b>Hire ▸ Ninja</b> (<code>driver_hire $A5F4</code>), while the "
      "recruit-men path is <code>effect_hire_variant_pay $A553</code> and the real <b>Bribe</b> command "
      "(<code>$8D4D</code>) is a separate gold-for-spy peasant-defection. The label is now "
      "<code>effect_ninja_sabotage</code>. The sabotage mechanics the old note described were all real — "
      "only the command attribution was wrong."),
    "rabbit_holes": [
      ("Assassination resolution", "<code>ninja_mission_resolve_vs_defender $918D</code> — the "
       "daimyo-kill path: a skill/luck roll that can be <span class=\"scr\">counterattacked</span> / "
       "<span class=\"scr\">you have repelled</span>, and on success neutralizes the fief "
       "(<code>neutralize_fief</code>). Plausibly the source of Tokugawa’s mystery health loss.", None),
      ("Drain magnitude", "<code>hire_stat_drain_rng $A255</code> — the per-mission "
       "<code>(rng·scaled+1)×5</code> drain; the scaling term needs an emulator probe to pin exactly.",
       None),
    ],
  },

  # ---- Bribe: the separate gold-for-spy peasant-defection (NOT the ninja menu) ----
  "bribe": {
    "type": "functional", "no": 15, "name": "Bribe",
    "driver": 0xAAAE, "effect": 0x8D4D, "anim_id": 26,
    "tagline": "Pay a spy to bribe an enemy fief’s peasants into defecting to you — the gold-for-spy "
               "command. A loyalty/charisma contest, not a sabotage menu.",
    "anim_cap": "A spy (blue) approaches a banner-waving peasant — the defection scene (id 26). "
                "A thin 2-frame clip (the un-seeded-CHR caveat the develop animations also hit).",
    "summary": (
      "Bribe (<code>driver_bribe $AAAE → effect_bribe $8D4D</code>) is the <b>separate</b> espionage "
      "command — distinct from Hire▸Ninja’s sabotage menu (see <a href=\"./ninja.html\">ninja.html</a>). "
      "You need more than 10 gold; you pick a target fief (<span class=\"scr\">Bribe which?</span>) and "
      "answer <span class=\"scr\">Gold for spy?</span> with how much to spend. A contest "
      "(<code>bribe_success_check $8D02</code>) then decides the outcome. On <b>success</b> a slice of the "
      "target’s <b>output</b> — its peasant/agricultural base — defects to your fief "
      "(<span class=\"scr\">%d peasants have defected</span>); on <b>failure</b> "
      "(<span class=\"scr\">No peasants defected!</span>) your daimyo loses a charisma point and part of "
      "the spent gold is forfeit. The number of peasants moved is "
      "<code>loyalty − (⌊(30 + rng%25) × (min(loyalty, √gold) + 1) ÷ 100⌋ + 1)</code> — it scales with "
      "the <b>target’s loyalty</b> (emulator: loyalty 80 → 63–76, loyalty 40 → 23–30, loyalty 10 → 4–6), "
      "<i>not</i> a flat percentage of output (<code>compute_bribe_effect_value $8BC1</code>, "
      "emulator-confirmed)."),
    "flow": [
      (0xAAC2, '<b>Gold gate.</b> Need <code>gold &gt; 10</code>, else '
               '<span class="scr">"You have no gold."</span>'),
      (0xAAD8, 'Prompt <span class="scr">"Bribe which?"</span> — pick the target province.'),
      (0xAAF6, 'Prompt <span class="scr">"Gold for spy?"</span> → number entry (your gold, less the '
               'base stake).'),
      (0x8D74, '<b>The contest</b> (<code>bribe_success_check $8D02</code>) — see the table below.'),
      (0x8D9D, '<b>On success</b> the defection animation plays — <code>ui_helper_e80c(26)</code> — and '
               'a slice of the target’s output moves to your fief: '
               '<span class="scr">"%d peasants have defected."</span>'),
      (0x8DBF, '<b>On failure</b> → <span class="scr">"No peasants defected!"</span>, daimyo '
               '<code>−1</code> charisma, part of the stake forfeit.'),
    ],
    "table_heading": "The contest — who wins",
    "table": {
      "caption": "The success roll, read straight from <code>bribe_success_check</code> bytecode "
                 "(<code>$8D3D SCMPGT</code> → <code>$8D3E JUMPF</code>).",
      "headers": ["Outcome", "Condition", "Effect on the fiefs"],
      "rows": [
        ["Success", "<b>your</b>(loyalty + daimyo charisma) &gt; <b>target</b>(loyalty + charisma) + "
         "rng%10, <i>then</i> a 50% coin flip", "peasants (<b>output</b>) transfer to your fief: "
         "<code>loyalty − (⌊(30+rng%25)·(min(loyalty,√gold)+1)/100⌋ + 1)</code>"],
        ["Failure", "otherwise", "nothing transfers; your daimyo <b>−1 charisma</b>; part of the spent "
         "gold is forfeit"],
      ],
      "note": "The win condition is the <b>intuitive</b> one — a loyal, charismatic lord bribes a "
              "<i>weaker</i> enemy fief’s peasants away. The direction was settled from the bytecode: "
              "<code>bribe_success_check</code> compares <code>local11</code> (built from the "
              "LAST-pushed arg = <b>your</b> fief) against <code>local10</code> (the target + rng), and "
              "the VM passes call args into frame slots in <b>reverse</b> push order (the same convention "
              "probe-math32 documented). The <code>$8BD0 DEREF</code> of that same slot — only the pointer "
              "arg can be dereferenced — independently confirms the reverse mapping. (Field identities: "
              "loyalty@+12, daimyo charisma@+4.)",
    },
    "callout": (
      "<b>Bribe is NOT the sabotage menu.</b> An earlier note filed the "
      "Uprising/Revolt/Dams/Assassin/Arson menu under “Bribe”; the bytecode shows that menu belongs to "
      "<b>Hire▸Ninja</b> (<a href=\"./ninja.html\">ninja.html</a>). Bribe (<code>$8D4D</code>) is its own, "
      "simpler thing: <b>gold-for-spy peasant defection</b> — one contested effect that steals a chunk of "
      "the target’s peasant output. Both are gold-funded espionage, which is why they blurred together; "
      "the code keeps them firmly apart."),
    "rabbit_holes": [
      ("The spy-gold quirk", "the closed form is settled, but it has a counter-intuitive twist: "
       "<b>more</b> spy gold raises <code>√gold</code>, which raises the subtracted resistance (until "
       "<code>√gold ≥ loyalty</code>) — so <i>minimal</i> gold maximizes the peasant transfer. "
       "Bytecode + emulator agree; worth an in-game sanity check that gold isn’t buying something else "
       "(success odds are gold-independent in <code>$8D02</code>).", None),
    ],
  },

  # ---- Diplomacy: pay a rival daimyo for an alliance / non-aggression pact ----
  "pact": {
    "type": "functional", "no": 6, "name": "Pact",
    "driver": 0x9C4F, "effect": None, "anim_id": 3,
    "tagline": "Pay gold to a rival daimyo to broker an alliance — a diplomatic command, "
               "not an economic one. He names the price; you pay or you don’t.",
    "anim_cap": "The two houses’ banners meet — the pact-sealing scene (id 3).",
    "summary": (
      "Pact (<code>driver_pact $9C4F</code>) is a <b>diplomacy</b> command. You pick a target "
      "daimyo (<span class=\"scr\">Which fief?</span>), and a relations helper "
      "(<code>diplomacy_helper $9C9C</code>) sets the gold he demands to agree. The game shows "
      "<span class=\"scr\">Lord &lt;you&gt;: &lt;him&gt; wants &lt;N&gt; gold. Pay?</span> — answer "
      "yes (<code>ui_helper_d3a7</code>) and, if your selected fief holds the gold, it is debited and "
      "the alliance is recorded (<code>diplomacy_helper2 $9CF3</code>); the pact animation plays "
      "(<code>ui_helper_e80c(3)</code>) and you’re reminded "
      "<span class=\"scr\">War is inevitable, so don’t let your guard down.</span> If you can’t (or "
      "won’t) pay, you get <span class=\"scr\">You have no gold.</span> or — if <i>he</i> refuses — "
      "<span class=\"scr\">They’ve refused.</span> / <span class=\"scr\">Who needs him anyway.</span> "
      "No formula: the cost is set by the diplomacy state, and the only effect is gold spent + a "
      "relation flipped."),
    "flow": [
      (0x9C6E, 'Select <b>Pact</b>; pick the target — <span class="scr">"Which fief?"</span>.'),
      (0x9C9C, 'A diplomacy helper sets the gold the target daimyo demands to ally.'),
      (0x9CBC, 'Prompt <span class="scr">"Lord &lt;you&gt;: &lt;him&gt; wants &lt;N&gt; gold. Pay?"</span>'),
      (0x9CCA, '<b>Gold check.</b> Your fief lacks the gold → <span class="scr">"You have no gold."</span>'),
      (0x9CE2, '<b>Pay:</b> gold is debited and the alliance recorded (<code>diplomacy_helper2</code>).'),
      (0x9CF7, '<b>Animation</b> (<code>ui_helper_e80c(3)</code>), then '
               '<span class="scr">"War is inevitable, so don’t let your guard down."</span>'),
      (0x9D19, '<b>If he refuses:</b> <span class="scr">"They’ve refused."</span> / '
               '<span class="scr">"Who needs him anyway."</span> — no gold spent.'),
    ],
    "callout": (
      "<b>A diplomacy command, not an econ formula.</b> The price isn’t a curve you can solve — it’s "
      "read out of the relations state by <code>diplomacy_helper</code>, and the whole effect is "
      "<i>gold spent → relation set</i>. That’s why Pact gets a functional page: the depth is in the "
      "diplomacy/relations subsystem (the relations matrix the AI decays each turn), not in Pact itself."),
    "rabbit_holes": [
      ("Relations matrix", "the per-daimyo relations grid Pact writes and the AI reads — "
       "<code>normalize_relations_matrix_lower/upper</code> decay it each turn; "
       "<code>relations_matrix_cell_addr</code> ($8C35 = arg1·54 + arg2 + $6193) indexes it.", None),
    ],
  },

  # ---- Diplomacy: political marriage (pay a dowry to bind a house) ----
  "marry": {
    "type": "functional", "no": 8, "name": "Marry",
    "driver": 0x9DC4, "effect": None, "anim_id": 16,
    "tagline": "Bind a rival house by marriage — pay a dowry to wed into it. The strongest "
               "diplomatic tie in the game, and the only command that paints a bride’s portrait.",
    "anim_cap": "The wedding scene (id 16); the bride’s face is a randomly-rolled composite portrait "
                "(<code>rng%22 + 53</code>).",
    "summary": (
      "Marry (<code>driver_marry $9DC4</code>) is a <b>diplomacy</b> command gated on your daimyo "
      "being present in the fief (<code>$6DA2</code>). You choose a target house "
      "(<span class=\"scr\">Which fief?</span>); the game rolls a bride and draws her portrait "
      "(<code>active_province_idx_copy = rng%22 + 53 → draw_daimyo_portrait</code>), then names the "
      "dowry: <span class=\"scr\">Lord &lt;you&gt;: &lt;him&gt; wants &lt;N&gt; gold. Pay?</span> Pay "
      "it (and hold the gold) and the marriage alliance is recorded "
      "(<code>diplomacy_helper3 $9E6F</code>), the wedding animation plays "
      "(<code>ui_helper_e80c(16)</code>), and you’re told <span class=\"scr\">Your bride-to-be has "
      "arrived.</span> / <span class=\"scr\">Don’t you long to hear the pitter-patter…</span> If the "
      "house <b>refuses</b> (<span class=\"scr\">They’ve refused.</span>) your daimyo’s standing takes "
      "the snub — records <code>+2</code>, <code>+3</code> (skill) and <code>+4</code> (charisma) each "
      "drop by one."),
    "flow": [
      (0x9DD7, '<b>Daimyo-present gate</b> (<code>$6DA2</code>) — you must be in the fief to court.'),
      (0x9DEA, 'Select the target house — <span class="scr">"Which fief?"</span>.'),
      (0x9E22, '<b>The bride is rolled</b> — <code>rng%22 + 53</code> picks a composite face, drawn via '
               '<code>draw_daimyo_portrait</code>.'),
      (0x9E51, 'Prompt the dowry: <span class="scr">"&lt;him&gt; wants &lt;N&gt; gold. Pay?"</span>'),
      (0x9E6C, '<b>Gold check</b> — your fief must hold the dowry.'),
      (0x9E6F, '<b>Wed:</b> alliance recorded (<code>diplomacy_helper3</code>), dowry debited, '
               'animation <code>16</code>, <span class="scr">"Your bride-to-be has arrived."</span>'),
      (0x9EC6, '<b>If refused:</b> <span class="scr">"They’ve refused."</span> and your daimyo loses '
               '1 each from records +2 / +3 (skill) / +4 (charisma).'),
    ],
    "callout": (
      "<b>The only command that snubs you back.</b> Most refusals just cost a turn; a rejected marriage "
      "proposal actually <b>drains three of your daimyo’s own stats</b> (records +2/+3/+4) — the public "
      "loss of face. The reward is the tightest diplomatic bond in the game (a marriage alliance, "
      "<code>diplomacy_helper3</code>), and a one-off bit of flavor: the bride gets a real, randomly "
      "generated portrait through the same composite face system the replacement-daimyo generator uses."),
    "rabbit_holes": [
      ("Composite portrait system", "the bride’s face is built by the base-5 composite renderer "
       "(<code>$6EB1 → bank-8 part tables</code>) — the same path generated/replacement daimyo use, "
       "distinct from the historical roster’s preset CHR.", None),
      ("Relations matrix", "marriage writes the strongest tie into the same relations grid Pact uses "
       "and the AI decays each turn.", None),
    ],
  },

  # ---- Rest: a multi-season self-imposed command lock to recuperate ----
  "rest": {
    "type": "functional", "no": 17, "name": "Rest",
    "driver": 0xADB3, "effect": None, "anim_id": 32,
    "tagline": "Stand your daimyo down for several seasons to recuperate. Not a turn-skip — a "
               "<i>multi-turn</i> commitment that locks the daimyo out of every command until it ends.",
    "anim_cap": "The resting/recuperation scene (id 32) — a short 2-frame clip.",
    "summary": (
      "Rest (<code>driver_rest $ADB3</code>) is the only command that spends <b>more than one turn</b>. "
      "It is gated on your daimyo being present (<code>$6DA2</code>); you’re prompted "
      "<span class=\"scr\">Seasons</span> and enter a count (<code>number_input</code>, <b>1–10</b>), "
      "which is written to that daimyo’s slot in <code>rest_turns_remaining</code> "
      "(<code>$6D67</code>, a per-daimyo counter). The game replies "
      "<span class=\"scr\">It will do you good.</span> and plays the recuperation animation "
      "(<code>ui_helper_e80c(32)</code>). While the counter is non-zero the daimyo <b>sits out</b>: "
      "the per-turn logic checks <code>rest_turns_remaining</code> in at least five places across the "
      "AI, event and combat banks and skips the daimyo’s action when it’s set. The cost is pure "
      "<b>tempo</b> — you trade action-slots (the binding constraint of the game) for recovery."),
    "flow": [
      (0xADC0, '<b>Daimyo-present gate</b> (<code>$6DA2</code>) — only a daimyo in the fief can rest; '
               'otherwise bail.'),
      (0xADD8, 'Prompt <span class="scr">"Seasons"</span> → <code>number_input(1..10)</code> → '
               '<code>rest_turns_remaining[daimyo]</code>.'),
      (0xADDF, '<span class="scr">"It will do you good."</span> + animation <code>32</code>.'),
      (0x902B, '<b>Each following turn</b>, the AI/event/combat logic sees the non-zero counter and '
               '<b>skips this daimyo’s action</b> until it ticks back to zero.'),
    ],
    "callout": (
      "<b>The action-economy command.</b> Everything else in the game spends one of your four "
      "seasons-per-year slots; Rest spends <i>several</i> at once, voluntarily. That only pays off "
      "because the daimyo is recuperating — the multi-season lock is the price of recovery. It also "
      "explains a subtle interaction: a resting daimyo can’t be made to act, so the AI-side checks "
      "(<code>is_battleside_province_aistate5_and_not_resting</code>, the rebellion and natural-death "
      "passes) all special-case the rest counter before doing anything to that lord."),
    "rabbit_holes": [
      ("What recovery restores", "the seasons lock is read straight from the driver; the recuperation "
       "it buys (the daimyo health/condition the Rest is <i>for</i>) is applied in the per-turn tick, "
       "not the driver — pinning that exact write is a small open thread.", None),
    ],
  },

  # ---- Grant: delegate a province to the AI with a governance policy ----
  "grant": {
    "type": "functional", "no": 19, "name": "Grant",
    "driver": 0xAF66, "effect": None, "anim_id": 11,
    "tagline": "Hand a province over to AI governance and tell it what to prioritize — develop, arm, "
               "farm, or balance. Delegation, so you can spend your slots elsewhere.",
    "anim_cap": "The orders-given scene (id 11).",
    "summary": (
      "Grant (<code>driver_grant $AF66</code>) sets a province’s <b>AI governance policy</b> "
      "(<code>province_ai_state</code>). Gated on your daimyo being present, you pick the fief "
      "(<span class=\"scr\">Which fief?</span>), the game asks "
      "<span class=\"scr\">What are your orders?</span>, and you choose one of six stances from the "
      "menu. The chosen value (1–5) is written to <code>province_ai_state[fief]</code> "
      "(<code>$B050</code>); the game confirms <span class=\"scr\">It’s currently a &lt;X&gt; "
      "state. OK to…?</span> (or <span class=\"scr\">It’s already a &lt;X&gt; state.</span>), plays "
      "the animation (<code>ui_helper_e80c(11)</code>), and replies "
      "<span class=\"scr\">Lord, you are truly wise.</span> State <b>0 = “Home fief”</b> means you keep "
      "controlling it by hand; the other five hand the wheel to the AI with a focus. The AI’s per-fief "
      "command driver then issues that province’s commands each turn according to the policy."),
    "flow": [
      (0xAF73, '<b>Daimyo-present gate</b> (<code>$6DA2</code>).'),
      (0xAFA0, 'Select the fief — <span class="scr">"Which fief?"</span> — then '
               '<span class="scr">"What are your orders?"</span>.'),
      (0xAFCC, 'The six-option policy menu is drawn (from the <code>$F7D4</code> name table).'),
      (0xAFFB, '<code>submenu_prompt(6)</code> → pick a policy; option 6 backs out.'),
      (0xB00B, 'Already that policy → <span class="scr">"It’s already a &lt;X&gt; state."</span>'),
      (0xB050, '<b>Set</b> <code>province_ai_state[fief] = policy</code>; animation <code>11</code>; '
               '<span class="scr">"Lord, you are truly wise."</span>'),
    ],
    "table_heading": "The six governance policies",
    "table": {
      "caption": "The menu, read straight from the name table <code>effect_view_a_data_f7d4</code> "
                 "(<code>$F7D4</code> → strings at <code>$F7E0…</code>). Index = the stored "
                 "<code>province_ai_state</code> value.",
      "headers": ["state", "Policy", "What the AI prioritizes"],
      "rows": [
        ["0", "Home fief", "you keep direct manual control — not delegated"],
        ["1", "Industrial", "Build — grow the town / gold-income engine"],
        ["2", "Military", "Train &amp; Hire — raise soldiers and skill"],
        ["3", "Balanced", "spread effort across economy and army"],
        ["4", "Farming", "Grow / Dam — raise agricultural output &amp; rice"],
        ["5", "Direct", "the most hands-off / aggressive delegated mode"],
      ],
      "note": "The same six labels appear in the <b>View</b> screen "
              "(<code>effect_view_a</code> reads the identical table), which is how you read back a "
              "delegated fief’s current policy. Delegation is the late-game tempo play: once you hold "
              "more fiefs than you have action-slots to micromanage, Grant lets the AI run the rear "
              "provinces on a sensible focus while you spend your four seasons on the frontier.",
    },
    "callout": (
      "<b>Genuinely a mechanic, not a UI screen.</b> Grant writes <code>province_ai_state</code>, the "
      "very field the AI command driver reads each turn to decide that fief’s actions — and the same "
      "field the conquest/neutralize code resets (<code>neutralize_fief</code> forces it to −1). It is "
      "the player’s hook into the AI economy: hand a rear fief a <i>Farming</i> or <i>Industrial</i> "
      "policy and it develops itself for free, no slot spent."),
  },

  # ---- Map: read-only strategic-map view (no state change, no turn spent) ----
  "map": {
    "type": "functional", "no": 18, "name": "Map",
    "driver": 0xAF38, "effect": None, "anim_id": None,
    "tagline": "Open the strategic map. A read-only view — it changes nothing and costs no turn. "
               "The one command you can use as often as you like.",
    "summary": (
      "Map (<code>driver_map $AF38</code>) is a pure <b>view</b>. It redraws the strategic map "
      "(<code>ui_helper_cd20</code>), branches on scenario size "
      "(<code>scenario_fief_count == 50</code>) to choose the 17- or 50-fief layout, looks each "
      "fief’s map-id up in <code>battle_init_driver_data_fed8</code>, and paints it via "
      "<code>map_helper_e5f2</code> / <code>map_helper_af10</code>. It writes <b>no</b> game state and "
      "<b>returns 0</b> — i.e. it does not consume your action for the season. There is no animation "
      "and no effect handler. The illustrated map is a <b>9-section pannable</b> picture (arrows change "
      "sections, A returns to the menu) blitted from <b>bank 4</b> — section tilemaps at "
      "<code>map_helper_data_8d5c</code> (448 B each), attributes at <code>map_helper_data_9d1c</code>, "
      "CHR via <code>ui_helper_cd20</code>. The same render core is reached from the kernel "
      "<code>dispatch_map_helper_e694 ($E694)</code> standalone viewer and the "
      "<a href=\"./view.html\">View command</a>’s map sub-screen."),
    "callout": (
      "<b>Why it’s a one-paragraph page.</b> Map touches nothing — no province field, no daimyo "
      "record, no relations matrix — and unlike every other entry on the menu it doesn’t end your "
      "turn. Two different map artifacts exist in this project: the <i>schematic</i> node-link "
      "adjacency atlases (<code>tools/render-strategic-atlas.py</code> / "
      "<code>render-strategic-50.py</code>, built from the adjacency table + fief coordinates) — "
      "useful, but <b>not</b> the game’s art — and the actual <b>illustrated</b> map this command "
      "blits from bank 4, a separate from-ROM render still to be pulled (tracked in the ROADMAP) for "
      "both the 17- and 50-fief layouts."),
  },

  # ---- Other: the system / options menu (settings + Save) ----
  "other": {
    "type": "functional", "no": 20, "name": "Other",
    "driver": 0xB23E, "effect": None, "anim_id": None,
    "tagline": "The system menu — sound, animation and message-speed toggles, plus Save and the "
               "end-turn / quit options. Settings, not strategy.",
    "summary": (
      "Other (<code>driver_other $B23E</code>) opens a <b>seven-entry system menu</b> "
      "(<span class=\"scr\">Change which?</span>). Each pick is dispatched through a jump table "
      "(<code>jumptab_b9e8</code>) to its own handler, and the menu loops until a handler signals exit "
      "or you choose <b>End</b>. The labels come straight from <code>driver_other_data_ff1a</code>. "
      "Most entries just flip a preference; <b>Save</b> writes the battery-backed game; and only "
      "<b>End</b> (option index 5) returns true to actually conclude the turn."),
    "table_heading": "The seven options",
    "table": {
      "caption": "Read from the label table <code>$FF1A</code> and the dispatch table "
                 "<code>jumptab_b9e8</code> ($B9E8).",
      "headers": ["#", "Option", "What it does"],
      "rows": [
        ["1", "Sound", "toggle / select background music"],
        ["2", "Animat(ion)", "turn command &amp; battle animations on or off"],
        ["3", "Wait", "message / text-advance speed"],
        ["4", "Save", "write the game to battery-backed SRAM (with checksum)"],
        ["5", "Battle", "auto- vs. manual battle resolution preference"],
        ["6", "End", "conclude the turn (the only option that returns true)"],
        ["7", "Menu", "back out to the command menu"],
      ],
      "note": "These are the same preferences the engine reads elsewhere — e.g. the <b>Animat</b> "
              "toggle is what gates every <code>ui_helper_e80c</code> command animation the other "
              "pages show, and <b>Save</b> routes through the checksummed SRAM writer "
              "(<code>syscall_sram_block_with_checksum</code>).",
    },
    "callout": (
      "<b>A settings command that quietly controls the rest of the game.</b> Nothing here touches a "
      "province or a daimyo, but two entries matter: <b>Save</b> is the only persistence path, and the "
      "<b>Animat</b> toggle is the master switch for the command-animation VM every other page on this "
      "site renders. The seven handlers behind <code>jumptab_b9e8</code> are small, self-contained UI "
      "routines — a settings panel, not a subsystem."),
  },

  # ---- Pass: spend the turn doing nothing ----
  "pass": {
    "type": "functional", "no": 21, "name": "Pass",
    "driver": 0xB2A1, "effect": None, "anim_id": None,
    "tagline": "Skip the season. Spend an action slot on nothing — and the game lets you know how it "
               "feels about that.",
    "summary": (
      "Pass (<code>driver_pass $B2A1</code>) is the whole function: it prints "
      "<span class=\"scr\">What a waste.</span>, waits for a confirm "
      "(<code>confirm_prompt</code>), and <b>returns 1</b> — consuming the action so the turn advances. "
      "No province field, no daimyo record, no roll. It exists because the turn structure needs an "
      "explicit “do nothing” when you’ve no good move (or want to bank gold/rice into the harvest "
      "without developing)."),
    "callout": (
      "<b>The shortest driver in the game — and a strategic statement.</b> With only four action-slots "
      "a year, deliberately spending one on Pass is almost always wrong; the game agrees "
      "(<span class=\"scr\">What a waste.</span>). It’s here for completeness — the one command whose "
      "entire decompiled body is three lines."),
  },

  # ---- Move: relocate troops between your own provinces (logistics) ----
  "move": {
    "type": "functional", "no": 1, "name": "Move",
    "driver": 0x96D1, "effect": 0x8CA5, "anim_id": 8,
    "tagline": "March soldiers from one of your provinces to another — internal logistics, not an "
               "attack. Optionally ride along and relocate your daimyo with the army.",
    "anim_cap": "The march-out animation (id 8, shared with War) — the army moving overland.",
    "summary": (
      "Move (<code>driver_move $96D1</code>) is your <b>internal troop-logistics</b> command — it "
      "shifts men between fiefs <i>you already own</i> (the destination list is "
      "<code>deduped_owner_list</code>, your provinces), distinct from <b>War</b> (attack an enemy) and "
      "<b>Send</b> (ship gold/rice). You pick a destination (<span class=\"scr\">Move where?</span>); "
      "the capacity is <code>min(dest.header − dest.men, source.men)</code> — you can’t exceed the "
      "destination’s army ceiling or send more than you have. After <span class=\"scr\">How many "
      "men?</span> the transfer applies through <code>effect_move ($8CA5)</code>, which moves the men "
      "and <b>blends the destination’s unit stats</b> (a men-weighted average over three fields, "
      "<code>scaled_transfer_da24</code>) — the same anti-stacking averaging Hire uses, so pouring "
      "raw troops into a crack garrison dilutes it. The march animation plays "
      "(<code>ui_helper_e80c(8)</code>) and <span class=\"scr\">They have arrived safely.</span>"),
    "flow": [
      (0x96E9, 'Select <b>Move</b>; the destination list is built from <i>your own</i> fiefs.'),
      (0x96FB, '<span class="scr">"Move where?"</span> — pick the destination province.'),
      (0x9741, '<b>Capacity</b> = <code>min(dest.header − dest.men, source.men)</code>; zero → '
               '<span class="scr">"That fief can’t hold more men."</span>'),
      (0x9749, '<span class="scr">"How many men?"</span> → number entry (capped at capacity).'),
      (0x976F, '<b>If your daimyo is here</b> (<code>$6DA2</code>): <span class="scr">"Will you lead '
               'them personally?"</span> — yes <b>relocates the daimyo</b> to the destination and sets '
               'its policy to <i>Direct</i> (<code>province_ai_state = 5</code>).'),
      (0x9798, 'March animation <code>8</code>, then <span class="scr">"They have arrived safely."</span>'),
      (0x97A7, '<code>effect_move</code> applies: men transferred, destination stats men-weighted-blended.'),
    ],
    "callout": (
      "<b>Three commands move things — keep them straight.</b> <b>Move</b> shifts <i>men</i> between "
      "<i>your</i> fiefs; <b>Send</b> ships <i>gold/rice</i> between your fiefs; <b>War</b> marches men "
      "at an <i>enemy</i> fief. Move’s quiet power is the <b>“lead them personally”</b> option: it "
      "physically relocates your daimyo (clearing <code>$6DA2</code> at the source, setting it at the "
      "destination) and flips the new fief to direct control — that’s how you reposition your lord to "
      "the front before a campaign, or pull him out of a fief that’s about to fall. The stat-blend on "
      "arrival means Move is for massing bodies, not preserving an elite unit’s average."),
    "rabbit_holes": [
      ("Unit-stat blend", "<code>effect_move $8CA5 → scaled_transfer_da24</code> men-weighted-averages "
       "three destination fields (morale / skill / arms) — the same dilution math as Hire, in reverse.",
       None),
    ],
  },

  # ---- Assign: reorganize a garrison's unit-type composition ----
  "assign": {
    "type": "functional", "no": 16, "name": "Assign",
    "driver": 0xAD67, "effect": 0xAC11, "anim_id": None,
    "tagline": "Reorganize a garrison — interactively reallocate its soldiers across the unit types. "
               "An editor screen, not a one-shot effect. Costs a flat 30 gold.",
    "summary": (
      "Assign (<code>driver_assign $AD67</code>) opens an <b>interactive arms-allocation editor</b> "
      "for the selected province. It requires soldiers (else <span class=\"scr\">You have no "
      "soldiers.</span>) and a flat <b>30 gold</b> (else <span class=\"scr\">You have no gold.</span>), "
      "which is debited up front. <code>effect_assign ($AC11)</code> then draws the arms-edit screen "
      "(<code>render_arms_edit_screen</code> over the province’s arms region at <code>$7017</code>) and "
      "runs an input loop: the d-pad moves a cursor across the rows and adjusts each, A/B "
      "(<code>poll_input</code> cases) commit or cancel. The five rows are the army’s <b>unit-type "
      "composition</b> — the foot / cavalry / musket mix that feeds straight into the combat damage "
      "model (different unit types carry different damage multipliers). Unlike the econ commands there "
      "is no formula and no animation: it’s a UI editor that writes the arms fields directly."),
    "flow": [
      (0xAD7D, '<b>Soldier check</b> — no men → <span class="scr">"You have no soldiers."</span>'),
      (0xAD91, '<b>Gold check</b> — a flat <b>30 gold</b> is required and debited.'),
      (0xAC26, '<code>effect_assign</code> draws the arms-edit screen over <code>$7017</code> '
               '(the province arms region).'),
      (0xAC36, '<b>Input loop:</b> d-pad moves the cursor over the five unit-type rows and adjusts '
               'the allocation; A/B commit or cancel.'),
    ],
    "callout": (
      "<b>The army-composition command.</b> Where Train raises <i>skill</i> and Hire adds <i>bodies</i>, "
      "Assign decides <b>what kind</b> of soldiers they are — the foot/cavalry/musket split that the "
      "combat engine multiplies into damage (foot ×1, cavalry ×2, musket ×3 in the damage model). It’s "
      "an editor rather than a formula, which is why it gets a functional page: the depth is the combat "
      "model the composition feeds, not Assign itself. The flat 30-gold fee is a small reorganization "
      "tax — cheap, but it still spends one of your four action-slots."),
    "rabbit_holes": [
      ("Unit types & damage", "the five-row composition feeds the tactical damage model — unit-type "
       "multipliers, the 4-quadrant <code>{1,2,4,7}</code> selector, and arms in the casualty math "
       "(see the combat engine).", "../12-combat-engine.md"),
    ],
  },

  # ---- View: the intelligence / inspection command (spying + map) ----
  "view": {
    "type": "functional", "no": 12, "name": "View",
    "driver": 0xA6C7, "effect": 0x83FA, "anim_id": 14,
    "tagline": "Inspect any province — your own for free, an enemy’s for gold (and the risk of a caught "
               "spy). The information hub: fief stats, vassals, and the strategic map.",
    "anim_cap": "The view/inspection animation (id 14).",
    "summary": (
      "View (<code>driver_view $A6C7</code>) is the game’s <b>intelligence command</b>, and the widest "
      "of the non-econ commands — it’s a loop over several screens. <span class=\"scr\">View which "
      "fief?</span> lets you inspect any province’s stats (<code>effect_view_a</code>); your own fiefs "
      "are free, but <b>spying on an enemy costs 10 gold</b> per look (no gold → <span class=\"scr\">You "
      "have no gold.</span>). Spying is a <b>contest</b>: <code>effect_view_d</code> compares your "
      "daimyo against the target and, on a bad roll, <span class=\"scr\">Our spy was caught.</span> "
      "(animation 14). From the same command you can list a daimyo’s vassals "
      "(<span class=\"scr\">View vassals</span>, <code>effect_view_b/c</code>) and open the strategic "
      "<b>map</b> (<code>map_helper_e5f2 / map_helper_af10</code> — the very same render path the Map "
      "command uses, branched on <code>scenario_fief_count</code>)."),
    "flow": [
      (0xA716, '<span class="scr">"View which fief?"</span> — pick any province.'),
      (0xA6EE, '<b>Own fief:</b> view its full stats free (<code>effect_view_a</code>).'),
      (0xA7AA, '<b>Enemy fief:</b> costs <b>10 gold</b> to spy; debited on the attempt.'),
      (0xA80A, '<b>Spy contest</b> (<code>effect_view_d</code>): your daimyo vs the target + an RNG roll.'),
      (0xA843, '<b>Caught</b> → <span class="scr">"Our spy was caught."</span> (animation 14).'),
      (0xA743, '<b>Map sub-screen</b> — opens the strategic map (<code>map_helper_e5f2/af10</code>, '
               'the same renderer as the Map command).'),
    ],
    "callout": (
      "<b>The information hub — and a second door to the map.</b> View bundles three things the other "
      "commands keep separate: province inspection, vassal lists, and the strategic map. Reading your "
      "own holdings is free; reading an <i>enemy’s</i> is espionage — 10 gold a look and a "
      "skill-vs-skill roll that can get your spy caught. The map sub-screen calls the identical "
      "<code>map_helper_e5f2</code> path as the <a href=\"./map.html\">Map command</a> (and the kernel "
      "<code>$E694</code> standalone viewer), which is why all three share one render core — and why "
      "pulling that illustrated map from ROM is filed as its own task."),
    "rabbit_holes": [
      ("Spy-contest math", "<code>effect_view_d ($A6B3)</code> — the daimyo-vs-daimyo skill roll that "
       "decides whether an enemy inspection succeeds or the spy is caught; not yet pinned to a closed "
       "form.", None),
      ("The illustrated strategic map", "<code>map_helper_e5f2</code> blits a 9-section map from bank 4 "
       "— rendering it from ROM (both 17 & 50 fief) is an open task (ROADMAP Inbox).", None),
    ],
  },

  # ---- Trade: the merchant subsystem (credit + a fluctuating two-good market) ----
  "trade": {
    "type": "functional", "no": 9, "name": "Trade",
    "driver": 0xA1B6, "effect": 0x8A15, "anim_id": 0,
    "tagline": "Do business with a travelling merchant — borrow and repay gold, sell and buy rice, and "
               "buy weapons. A whole commodity market behind one menu — when the merchant shows up.",
    "anim_cap": "The merchant-deal animation (id 0) — plays after each completed transaction "
                "(<span class=\"scr\">Let’s do business again.</span>).",
    "summary": (
      "Trade (<code>driver_trade $A1B6</code>) is the game’s <b>merchant subsystem</b> — by far the "
      "richest of the non-combat commands. It is the one command that <b>may not be available on a "
      "given turn</b>: it opens with a presence check (<code>effect_trade $8A15</code>) and, if it "
      "fails, you only get <span class=\"scr\">No merchant in the area.</span> The merchant is "
      "<b>always</b> in the two commercial capitals — <b>fief 13 (Kyoto / Yamashiro)</b> and <b>14 "
      "(Sakai / Settsu)</b> — and <b>everywhere else only when a per-turn flag bit is set</b> "
      "(<code>ai_turn_flags &amp; 1</code>), so roughly half your turns elsewhere have no merchant. "
      "When he is present you’re greeted with <span class=\"scr\">Lord, how may I serve you?</span> and "
      "a six-option menu; each completed deal plays animation 0 and offers "
      "<span class=\"scr\">Let’s do business again.</span> Every price comes from the <b>market rate "
      "table</b> (<code>loan_rate</code> / <code>gold_rice_exchange_rate</code> / "
      "<code>arms_buy_price_rate</code> at <code>$6E0B…</code>), which <b>re-rolls every turn</b> — so "
      "<i>when</i> and <i>where</i> you trade is itself a lever."),
    "flow": [
      (0xA1BE, '<b>Merchant-presence gate</b> (<code>effect_trade $8A15</code>): fief 13/14 always pass; '
               'else <code>ai_turn_flags &amp; 1</code>. Fail → <span class="scr">"No merchant in the '
               'area."</span>'),
      (0xA1C8, 'The six-option menu is drawn (labels from <code>$FF4F</code>: '
               'Loan / Repay / Sell / Buy / Arms / Menu).'),
      (0xA1F3, '<span class="scr">"Lord, how may I serve you?"</span> → <code>submenu_prompt(6)</code> '
               'dispatches through <code>jumptab_b9dc</code>.'),
      (0xA216, '<b>On a completed deal:</b> animation <code>0</code> + '
               '<span class="scr">"Let’s do business again."</span> (the menu loops).'),
      (0xA23A, 'Pick <b>Menu</b> → <span class="scr">"Bye."</span> and exit.'),
    ],
    "table_heading": "The six services",
    "table": {
      "caption": "Read from <code>jumptab_b9dc</code> ($B9DC → $9F04/$9FAF/$A003/$A068/$A113/$A1AF) and "
                 "the label table <code>$FF4F</code>. Every quantity cap is computed by the shared "
                 "<code>helper_8357(headroom, rate, stock)</code>; every cost by "
                 "<code>math32_muladddiv(N, rate)</code>.",
      "headers": ["#", "Service", "Code", "What it does", "Rate"],
      "rows": [
        ["1", "Loan", "$9F04", "borrow gold; collateral is <code>town − debt</code>; gold += N, debt "
         "+= N. Treasury already full → <span class='scr'>“…already full”</span>; no collateral → "
         "<span class='scr'>“You can’t borrow”</span>", "<code>loan_rate</code> (+10)"],
        ["2", "Repay", "$9FAF", "pay down debt 1:1, <code>N = min(gold, debt)</code>; gold −= N, debt "
         "−= N. No debt → <span class='scr'>“Debt? What debt?”</span>", "—"],
        ["3", "Sell", "$A003", "rice → gold; capped by rice held + treasury headroom. No rice → "
         "<span class='scr'>“No rice”</span>", "<code>gold_rice_exchange_rate</code>"],
        ["4", "Buy", "$A068", "gold → rice, <b>cash only</b>; gold −= N×rate, rice += N. Can’t afford → "
         "<span class='scr'>“Sorry, no credit”</span>", "<code>gold_rice_exchange_rate</code>"],
        ["5", "Arms", "$A113", "gold → weapons; <b>needs soldiers</b> (else <span class='scr'>“Weapons "
         "for who?”</span>); gold −= N×rate, arms += N", "<code>arms_buy_price_rate</code>"],
        ["6", "Menu", "$A1AF", "<span class='scr'>“Bye.”</span> — leave the merchant", "—"],
      ],
      "note": "The three rates live in the per-turn market table (<code>$6E0B…$6E13</code>) and "
              "<b>re-roll every turn</b> — the same table that prices Hire and the loan system — so the "
              "buy-low/sell-high timing is real. Exact price = <code>math32_muladddiv(N, rate)</code> "
              "(a ⌊·⌋ of N×rate over a fixed divisor; the Arms “minimum to afford one” check "
              "<code>(rate+9)/10</code> implies ≈ rate/10 gold per unit). Pinning the precise divisor "
              "per good is a clean emulator-probe follow-up.",
    },
    "callout": (
      "<b>The one command you can’t always use — and that’s the point.</b> Trade fuses three systems: a "
      "<b>credit market</b> (Loan/Repay — borrow against your town, the only way to spend beyond your "
      "treasury, at interest baked into <code>loan_rate</code>), a <b>commodity market</b> (Sell/Buy "
      "rice — convert between your two liquid resources at a fluctuating exchange rate), and an "
      "<b>arms market</b> (buy weapons for gold). Two design choices give it depth: the merchant is "
      "<b>always</b> in Kyoto and Sakai but only <i>sometimes</i> elsewhere — a concrete reason to hold "
      "the commercial capitals — and the rates <b>change every turn</b>, so a patient lord buys arms "
      "when they’re cheap and sells rice when it’s dear. This is why Trade gets a full subsystem page, "
      "not a thin one."),
    "rabbit_holes": [
      ("Loan / debt mechanic", "borrowing capacity = <code>town − debt</code>, priced at "
       "<code>loan_rate</code>; debt is province field +2 and is repaid via Repay (or bleeds you each "
       "harvest). The fuller credit model is its own thread.", None),
      ("Per-turn market rates", "<code>gold_rice_exchange_rate</code> / <code>arms_buy_price_rate</code> "
       "/ <code>loan_rate</code> re-roll every turn in <code>$6E0B…</code> — quantifying the "
       "distribution (and the exact price divisor per good) wants an emulator probe.", None),
    ],
  },
}

# =====================================================================
#  HTML
# =====================================================================
CSS = """
  :root{
    --bg:#15151c; --panel:#1f1f2b; --ink:#e8e6df; --dim:#9a97a8;
    --gold:#f0b429; --red:#e8431f; --blue:#3a6ee8; --green:#5ad05a;
    --line:#33303f; --mono:"SFMono-Regular",Consolas,"Liberation Mono",monospace;
  }
  *{box-sizing:border-box}
  body{margin:0;background:var(--bg);color:var(--ink);
    font:16px/1.55 -apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;}
  .wrap{max-width:860px;margin:0 auto;padding:32px 20px 80px}
  header{border-bottom:2px solid var(--gold);padding-bottom:14px;margin-bottom:8px}
  .cmdno{color:var(--gold);font:600 13px/1 var(--mono);letter-spacing:.18em;text-transform:uppercase}
  h1{margin:.18em 0 .1em;font-size:38px;letter-spacing:.01em}
  .tag{color:var(--dim);font-style:italic}
  .skills{display:flex;flex-wrap:wrap;gap:6px;margin:16px 0 28px}
  .skills span{font:600 11px/1 var(--mono);letter-spacing:.06em;color:var(--dim);
    border:1px solid var(--line);border-radius:999px;padding:6px 11px;text-transform:uppercase}
  h2{margin:38px 0 4px;font-size:22px;border-left:4px solid var(--gold);padding-left:12px}
  .sub{color:var(--dim);margin:0 0 16px;padding-left:16px;font-size:14px}
  .anim{display:flex;gap:24px;align-items:center;flex-wrap:wrap;
    background:var(--panel);border:1px solid var(--line);border-radius:12px;padding:20px;margin-top:14px}
  .anim img{image-rendering:pixelated;width:256px;height:240px;background:#6b6b6b;border-radius:6px}
  .anim .cap{flex:1;min-width:240px}
  .anim .cap b{color:var(--gold)}
  .pill{display:inline-block;font:600 11px/1 var(--mono);color:var(--bg);background:var(--green);
    border-radius:4px;padding:3px 7px;margin-left:6px;vertical-align:middle}
  ol.flow{counter-reset:step;list-style:none;padding:0;margin:14px 0}
  ol.flow li{position:relative;padding:12px 0 12px 52px;border-bottom:1px solid var(--line)}
  ol.flow li:before{counter-increment:step;content:counter(step);position:absolute;left:0;top:10px;
    width:34px;height:34px;border-radius:50%;background:var(--panel);border:1px solid var(--gold);
    color:var(--gold);font:700 15px/34px var(--mono);text-align:center}
  ol.flow .scr{color:var(--green);font-family:var(--mono);font-size:14px}
  ol.flow .addr{color:var(--dim);font-family:var(--mono);font-size:12px;float:right}
  pre{background:#101019;border:1px solid var(--line);border-left:3px solid var(--blue);
    border-radius:8px;padding:16px;overflow:auto;font:13.5px/1.5 var(--mono);color:#d6e4ff}
  pre .c{color:#6f7b96}
  pre .k{color:var(--gold)}
  .callout{background:#241a12;border:1px solid #6b4a1e;border-left:4px solid var(--red);
    border-radius:8px;padding:14px 18px;margin:18px 0}
  .callout b{color:var(--red)}
  .rabbit{background:#1a1426;border:1px solid #4a2e6b;border-left:4px solid #9a6ef0;
    border-radius:8px;padding:14px 18px;margin:14px 0}
  .rabbit b{color:#b89af0}
  .rabbit a{color:var(--blue);text-decoration:none}
  table{border-collapse:collapse;width:100%;margin:14px 0;font-size:14px}
  th,td{border:1px solid var(--line);padding:7px 10px;text-align:right}
  th:first-child,td:first-child{text-align:left}
  th{background:var(--panel);color:var(--gold);font-weight:600}
  td .ok{color:var(--green)}
  code{font-family:var(--mono);color:var(--gold);font-size:.92em}
  footer{margin-top:48px;padding-top:18px;border-top:1px solid var(--line);color:var(--dim);font-size:13px}
  footer a{color:var(--blue);text-decoration:none}
  .roi{color:var(--dim);font-style:italic;margin-top:6px}
"""

def _gif_src(cmd):
    p = ASSETS / f"{cmd}.gif"
    if p.exists():
        b64 = base64.b64encode(p.read_bytes()).decode()
        return f"data:image/gif;base64,{b64}"
    return ""

def _anim_block(s, cmd):
    src = _gif_src(cmd)
    if not src:
        return ('<div class="anim"><div class="cap"><i>animation not yet rendered — '
                f'run <code>tools/run-animation.py {s.get("anim_id","?")}</code></i></div></div>')
    aid = s.get("anim_id", "?")
    return (
      '<div class="anim">\n'
      f'  <img src="{src}" alt="{s["name"]} animation">\n'
      '  <div class="cap">\n'
      f'    {s["anim_cap"]}\n    <span class="pill">FROM ROM</span><br><br>\n'
      f'    Produced headless by <code>tools/run-animation.py {aid}</code>, which runs the game’s\n'
      f'    own <b>animation scripting VM</b> (bank&nbsp;14 <code>$80AD</code>, id <code>{aid}</code> from\n'
      '    the descriptor table at <code>$AF80</code>) and intercepts every CHR upload, palette write\n'
      '    and sprite placement to reconstruct each frame — real NES palette.\n'
      '  </div>\n</div>')

def _page(title, body):
    return (f'<!DOCTYPE html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n'
            f'<meta name="viewport" content="width=device-width, initial-scale=1">\n'
            f'<title>{title}</title>\n<style>{CSS}</style>\n</head>\n<body>\n<div class="wrap">\n'
            f'{body}\n</div>\n</body>\n</html>\n')

def render_atomic(cmd, s):
    flow = "\n".join(f'  <li><span class="addr">${a:04X}</span>{html}</li>' for a, html in s["flow"])
    v = s.get("validation")
    vtable = ""
    if v:
        head = "".join(f"<th>{h}</th>" for h in v["headers"])
        rows = ""
        for r in v["rows"]:
            cells = ""
            for i, c in enumerate(r):
                cells += f'<td><span class="ok">✓</span></td>' if c == "ok" else f"<td>{c}</td>"
            rows += f"  <tr>{cells}</tr>\n"
        vtable = (f'<h2>Validated against the ROM</h2>\n<p class="sub">{v["caption"]}</p>\n'
                  f'<table>\n  <tr>{head}</tr>\n{rows}</table>\n'
                  f'<p class="sub">{v["note"]}</p>')
    callout = f'<div class="callout">{s["callout"]}</div>\n' if s.get("callout") else ""
    roi = f'<p class="roi">{s["roi"]}</p>\n' if s.get("roi") else ""
    body = (
      f'<header>\n  <div class="cmdno">Lord Command · No. {s["no"]}</div>\n'
      f'  <h1>{s["name"]}</h1>\n  <div class="tag">{s["tagline"]}</div>\n</header>\n\n'
      '<div class="skills">\n  <span>① decompiler → C</span>\n  <span>② data-walk labels</span>\n'
      '  <span>③ bytecode-validated formula</span>\n  <span>④ animation VM → ROM render</span>\n</div>\n\n'
      f'<h2>What you see</h2>\n<p class="sub">The in-game {s["name"]} animation, rendered '
      '<b>purely from ROM bytes</b> — no emulator capture.</p>\n'
      f'{_anim_block(s, cmd)}\n\n'
      f'<h2>How it works</h2>\n<p class="sub">The driver <code>${s["driver"]:04X}</code> reads as a '
      'step-by-step script:</p>\n'
      f'<ol class="flow">\n{flow}\n</ol>\n\n'
      f'<h2>The formula</h2>\n<p class="sub">Read directly from <code>${s["effect"]:04X}</code> bytecode '
      f'and execution-verified.</p>\n<pre>{s["formula"]}</pre>\n{roi}{callout}\n'
      f'{vtable}\n\n'
      f'<footer>\n  <b>Fields touched:</b> {s["fields"]}. &nbsp;·&nbsp;\n'
      f'  Sources: <code>decompiled/bank_01.c</code> · <code>tools/run-animation.py</code> ·\n'
      f'  <a href="../appendix-formulas.md">appendix-formulas.md</a> · <a href="./{cmd}.md">{cmd}.md</a>.\n'
      f'</footer>')
    return _page(f'{s["name"]} — Nobunaga’s Ambition Command Reference', body)

def _table_html(t, heading):
    """Optional structured table for functional/subsystem pages (mission grids etc.)."""
    if not t:
        return ""
    head = "".join(f"<th>{h}</th>" for h in t["headers"])
    rows = ""
    for r in t["rows"]:
        cells = "".join(
            f'<td><span class="ok">✓</span></td>' if c == "ok" else f"<td>{c}</td>" for c in r)
        rows += f"  <tr>{cells}</tr>\n"
    cap = f'<p class="sub">{t["caption"]}</p>\n' if t.get("caption") else ""
    note = f'<p class="sub">{t["note"]}</p>\n' if t.get("note") else ""
    return f'<h2>{heading}</h2>\n{cap}<table>\n  <tr>{head}</tr>\n{rows}</table>\n{note}'

def render_functional(cmd, s):
    rabbits = ""
    for label, desc, link in s.get("rabbit_holes", []):
        tgt = f' <a href="{link}">→ deep page</a>' if link else ' <i>(deep page TBD)</i>'
        rabbits += f'<div class="rabbit"><b>\U0001f573️ {label}.</b> {desc}{tgt}</div>\n'
    flow = ""
    if s.get("flow"):
        items = "\n".join(f'  <li><span class="addr">${a:04X}</span>{h}</li>' for a, h in s["flow"])
        flow = ('<h2>How it works</h2>\n<p class="sub">The driver reads as a step-by-step '
                f'script:</p>\n<ol class="flow">\n{items}\n</ol>\n\n')
    table = _table_html(s.get("table"), s.get("table_heading", "The options"))
    callout = f'<div class="callout">{s["callout"]}</div>\n' if s.get("callout") else ""
    # Some commands are instant (no ui_helper_e80c → no animation): skip the "What you see" block.
    if s.get("anim_id") is None:
        skills = ('<div class="skills">\n  <span>① decompiler → C</span>\n  '
                  '<span>② data-walk labels</span>\n  <span>⚡ instant — no animation</span>\n</div>\n\n')
        seen = ''
    else:
        skills = ('<div class="skills">\n  <span>① decompiler → C</span>\n  '
                  '<span>④ animation VM → ROM render</span>\n  <span>⚠ subsystem entry point</span>\n</div>\n\n')
        seen = (f'<h2>What you see</h2>\n<p class="sub">The {s["name"]} animation, '
                f'rendered from ROM bytes.</p>\n{_anim_block(s, cmd)}\n\n')
    body = (
      f'<header>\n  <div class="cmdno">Lord Command · No. {s["no"]}</div>\n'
      f'  <h1>{s["name"]}</h1>\n  <div class="tag">{s["tagline"]}</div>\n</header>\n\n'
      f'{skills}'
      f'{seen}'
      f'<h2>What it does</h2>\n<p>{s["summary"]}</p>\n\n'
      f'{flow}'
      f'{table}\n{callout}\n'
      + ('<h2>Where it goes — the rabbit holes</h2>\n'
         '<p class="sub">This command is a simple page on purpose: the depth lives in the subsystem it '
         'hands off to. Those get their own pages.</p>\n'
         f'{rabbits}\n' if s.get("rabbit_holes") else "")
      + (f'<footer>\n  Driver <code>${s["driver"]:04X}</code> · '
      f'<code>tools/run-animation.py</code> · <a href="./README.md">commands index</a>.\n</footer>'))
    return _page(f'{s["name"]} — Nobunaga’s Ambition Command Reference', body)

INDEX_CSS = CSS + """
  .title{margin:.18em 0 .12em}
  .title img{image-rendering:pixelated;height:54px;width:auto;display:block}
  .menu{margin:22px 0 8px;border:1px solid var(--line);border-radius:12px;overflow:hidden;background:var(--panel)}
  .row{display:flex;align-items:center;gap:16px;padding:13px 18px;border-bottom:1px solid var(--line);
    text-decoration:none;color:inherit;transition:background .12s}
  .row:last-child{border-bottom:none}
  .row:hover{background:#262633}
  .num{flex:none;width:50px;height:46px;border:2px solid var(--gold);border-radius:8px;
    display:flex;align-items:center;justify-content:center;background:#101019}
  .num img{image-rendering:pixelated;height:22px;width:auto}
  .rname{flex:none;width:130px;display:flex;align-items:center}
  .rname img{image-rendering:pixelated;height:20px;width:auto}
  .gnum-fb,.gname-fb{font:700 18px/1 var(--mono);color:var(--ink)}
  .gtitle-fb{font:800 38px/1 var(--mono);color:var(--gold)}
  .rtag{flex:1;color:var(--dim);font-size:13.5px;min-width:160px}
  .rtype{flex:none;font:600 10px/1 var(--mono);letter-spacing:.06em;text-transform:uppercase;
    border:1px solid var(--line);border-radius:999px;padding:5px 9px}
  .t-atomic{color:var(--green);border-color:#2c5a2c}
  .t-functional{color:var(--blue);border-color:#2a3f6b}
  .t-sub{color:#b89af0;border-color:#4a2e6b}
  .sub-row{padding-left:50px;background:#191922}
  .sub-row .num{width:40px;height:38px;border-color:#4a2e6b}
  .sub-row .num img{height:16px}
  .sub-row .rname img{height:16px}
  .legend{display:flex;gap:14px;flex-wrap:wrap;margin:10px 2px 0;color:var(--dim);font-size:12.5px}
  .fontnote{background:#1a1426;border:1px solid #4a2e6b;border-left:4px solid #9a6ef0;border-radius:8px;
    padding:12px 16px;margin:22px 0;font-size:13.5px;color:var(--dim)}
  .fontnote b{color:#b89af0}
"""

def _font_png(text, fg=(240, 180, 41), scale=4):
    """Render text in the game's own font (via render-text.py) -> base64 data-URI, or '' on failure."""
    try:
        sys.path.insert(0, str(ROOT / "tools"))
        import importlib
        rt = importlib.import_module("render-text") if "render-text" not in sys.modules else sys.modules["render-text"]
    except Exception:
        try:
            import importlib.util
            spec = importlib.util.spec_from_file_location("render_text", ROOT / "tools" / "render-text.py")
            rt = importlib.util.module_from_spec(spec); spec.loader.exec_module(rt)
        except Exception:
            return ""
    try:
        import io
        img = rt.render_text(text, scale=scale, fg=fg, bg=None, tracking=1)
        buf = io.BytesIO(); img.save(buf, "PNG")
        return "data:image/png;base64," + base64.b64encode(buf.getvalue()).decode()
    except Exception:
        return ""

def index_page():
    """The command-reference landing page: the in-game 21-command menu, every entry linked."""
    have = {p.stem for p in CMD_DIR.glob("*.html")}
    by_no = sorted((s for s in COMMANDS.values() if s.get("no") and s["name"] != "Ninja (Hire ▸ Ninja)"),
                   key=lambda s: s["no"])
    GOLD, INK, PURPLE = (240, 180, 41), (232, 230, 223), (184, 154, 240)
    def fontimg(text, fg, scale, cls):
        src = _font_png(text, fg=fg, scale=scale)
        return f'<img class="{cls}" src="{src}" alt="{text}">' if src else f'<span class="{cls}-fb">{text}</span>'
    rows = ""
    for s in by_no:
        cmd = next(k for k, v in COMMANDS.items() if v is s)
        link = f"./{cmd}.html" if cmd in have else "#"
        t = s["type"]
        tag = re.sub(r"</?(b|i|code|span)[^>]*>", "", s["tagline"]).split(". ")[0].rstrip(".") + "."
        rows += (f'<a class="row" href="{link}">'
                 f'<div class="num">{fontimg(str(s["no"]), GOLD, 4, "gnum")}</div>'
                 f'<div class="rname">{fontimg(s["name"], INK, 4, "gname")}</div>'
                 f'<div class="rtag">{tag}</div>'
                 f'<div class="rtype t-{t}">{t}</div></a>\n')
        if cmd == "hire" and "ninja" in have:
            n = COMMANDS["ninja"]
            ntag = re.sub(r"</?(b|i|code|span)[^>]*>", "", n["tagline"]).split(". ")[0].rstrip(".") + "."
            rows += (f'<a class="row sub-row" href="./ninja.html">'
                     f'<div class="num">{fontimg("+", PURPLE, 4, "gnum")}</div>'
                     f'<div class="rname">{fontimg("Ninja", PURPLE, 4, "gname")}</div>'
                     f'<div class="rtag">{ntag}</div>'
                     f'<div class="rtype t-sub">sub</div></a>\n')
    title = fontimg("LORD COMMANDS", GOLD, 7, "gtitle")
    body = (
      '<header>\n  <div class="cmdno">Nobunaga’s Ambition (NES) · Reverse-Engineering Atlas</div>\n'
      f'  <div class="title">{title}</div>\n'
      '  <div class="tag">All 21 commands of the daimyo’s turn menu — every one decoded from the '
      'ROM bytecode, with its driver flow, formula or subsystem, and its in-game animation pulled '
      'straight from the cartridge. <b>The numbers and names below are rendered in the game’s own '
      'built-in font, pulled from the ROM.</b></div>\n</header>\n\n'
      '<div class="menu">\n' + rows + '</div>\n'
      '<div class="legend">'
      '<span><b style="color:var(--green)">atomic</b> = self-contained, bytecode-validated formula</span>'
      '<span><b style="color:var(--blue)">functional</b> = gateway into a subsystem</span>'
      '<span><b style="color:#b89af0">sub</b> = nested command</span>'
      '</div>\n'
      '<div class="fontnote"><b>□ That font is the cartridge’s own.</b> Every number and command name '
      'above is rendered in Nobunaga’s Ambition’s built-in font, extracted straight from the ROM by '
      '<code>tools/render-text.py</code>. The text pipeline was decoded — <code>format_string</code> '
      '→ <code>redraw_window</code> → <code>char_classify</code> (tile&nbsp;=&nbsp;ascii&nbsp;−&nbsp;offset, '
      'piecewise per character range) — and the glyph bitmaps live at <code>$B2BA</code> in bank&nbsp;0 '
      '(2bpp CHR uploaded to CHR-RAM by <code>render_boot_title_screens</code>). The renderer reuses '
      'that exact mapping, so any string can be drawn in-engine.</div>\n'
      '<footer>\n  Generated by <code>tools/build-command-page.py index</code> · font via '
      '<code>tools/render-text.py</code> · '
      '<a href="./README.md">test logs &amp; field maps</a> · '
      '<a href="../ROADMAP.md">project roadmap</a>.\n</footer>')
    html = (f'<!DOCTYPE html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n'
            f'<meta name="viewport" content="width=device-width, initial-scale=1">\n'
            f'<title>Lord Commands — Nobunaga’s Ambition Command Reference</title>\n'
            f'<style>{INDEX_CSS}</style>\n</head>\n<body>\n<div class="wrap">\n{body}\n</div>\n</body>\n</html>\n')
    out = CMD_DIR / "index.html"
    out.write_text(html, encoding="utf-8")
    print(f"  wrote {out.relative_to(ROOT)}  (index, {len(by_no)} commands, {len(html)} bytes)")

def build(cmd):
    s = COMMANDS[cmd]
    # rabbit-hole guard: an atomic page whose driver fans into a subsystem is suspect
    warn = classify(cmd, quiet=True)
    if s["type"] == "atomic" and warn["subsystems"]:
        print(f"  ⚠ WARNING: '{cmd}' typed atomic but reaches {warn['subsystems']} — verify it isn't a rabbit hole")
    html = render_atomic(cmd, s) if s["type"] == "atomic" else render_functional(cmd, s)
    out = CMD_DIR / f"{cmd}.html"
    out.write_text(html, encoding="utf-8")
    print(f"  wrote {out.relative_to(ROOT)}  ({s['type']}, {len(html)} bytes)")

# ---------- rabbit-hole detector ----------
def _driver_effects(driver):
    """EFFECT targets a command driver reaches, via driver-call-index."""
    try:
        out = subprocess.run([sys.executable, str(ROOT/"tools"/"driver-call-index.py")],
                             capture_output=True, text=True, timeout=120).stdout
    except Exception:
        return []
    effects, cur = [], False
    for line in out.splitlines():
        m = re.match(r"\$([0-9A-F]{4})\s+\S", line)
        if m:
            cur = (int(m.group(1), 16) == driver)
        elif cur and "[EFFECT]" in line:
            em = re.search(r"\$([0-9A-F]{4})", line)
            if em:
                effects.append(int(em.group(1), 16))
    return effects

def classify(cmd, quiet=False):
    driver = COMMANDS[cmd]["driver"] if cmd in COMMANDS else ROSTER[cmd][1]
    declared = COMMANDS[cmd]["type"] if cmd in COMMANDS else "—"
    eff = _driver_effects(driver)
    subs = sorted({SUBSYSTEM_EFFECTS[e] for e in eff if e in SUBSYSTEM_EFFECTS})
    atomic_hits = [ATOMIC_EFFECTS[e] for e in eff if e in ATOMIC_EFFECTS]
    unknown = [e for e in eff if e not in ATOMIC_EFFECTS and e not in SUBSYSTEM_EFFECTS]
    if subs:
        verdict = "RABBIT-HOLE → functional"
    elif len(atomic_hits) == 1 and not unknown:
        verdict = "ATOMIC → full page"
    elif atomic_hits:
        verdict = "ATOMIC? (verify)"
    elif not eff:
        verdict = "NO EFFECT (turn-skip / UI-only → functional)"
    else:
        verdict = "REVIEW (unknown effects)"
    if not quiet:
        line = f"{cmd:8s} ${driver:04X}  decl={declared:10s}  {verdict}"
        if atomic_hits: line += f"  [{', '.join(atomic_hits)}]"
        if subs:        line += f"  [{', '.join(subs)}]"
        if unknown:     line += f"  unk={', '.join(f'${e:04X}' for e in unknown)}"
        print(line)
    return {"verdict": verdict, "subsystems": subs, "atomic": atomic_hits, "unknown": unknown}

def anim_id_of(driver_hex):
    """Extract the $E80C (ui_helper_e80c) argument = animation id for a driver."""
    asm = subprocess.run([sys.executable, str(ROOT/"tools"/"vm-disasm.py"), "1", "--stdout"],
                         capture_output=True, text=True).stdout
    lines = asm.splitlines()
    driver = int(driver_hex, 16)
    in_sub, last_push = False, None
    for ln in lines:
        sm = re.match(r"; sub \$([0-9A-F]{4})", ln)
        if sm:
            in_sub = (int(sm.group(1), 16) == driver)
        if not in_sub:
            continue
        pm = re.search(r"(?:PUSH_qimm|BYTE_PUSH_imm1).*?(?:operand =|\+)\s*(\d+)", ln)
        if pm:
            last_push = int(pm.group(1))
        if "E80C" in ln and last_push is not None:
            return last_push
    return None

def main():
    a = sys.argv[1:]
    if not a:
        print(__doc__); return
    op = a[0]
    if op == "list":
        for c, s in COMMANDS.items():
            print(f"  {c:8s} {s['type']:10s} #{s['no']:<2} driver ${s['driver']:04X} anim {s.get('anim_id')}")
    elif op == "build":
        targets = list(COMMANDS) if a[1:] == ["all"] else a[1:]
        for c in targets: build(c)
        if a[1:] == ["all"]:
            index_page()
    elif op == "index":
        index_page()
    elif op == "classify":
        targets = list(COMMANDS) if a[1:] == ["all"] else a[1:]
        for c in targets: classify(c)
    elif op == "plan":
        # rabbit-hole detector across the whole roster = the walk plan
        for c in ROSTER: classify(c)
    elif op == "animid":
        print(anim_id_of(a[1]))
    else:
        print(__doc__)

if __name__ == "__main__":
    main()

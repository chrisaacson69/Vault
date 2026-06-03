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

  # ---- functional example (thin until War's deep page exists) ----
  "war": {
    "type": "functional", "no": 2, "name": "War",
    "driver": 0x9850, "effect": None, "anim_id": 8,
    "tagline": "March an army into an adjacent enemy province and resolve a battle. "
               "Not an economic command — it hands off to the tactical combat engine.",
    "anim_cap": "The march-out / battle-intro animation.",
    "summary": "War is a <b>subsystem entry point</b>, not a formula. The driver "
               "(<code>$9850</code>) validates the target, debits the marching army, plays the "
               "animation, then transfers control to the bank-2 tactical combat engine "
               "(<code>battle_init_driver $AFE1</code>) where damage, morale, pursuit and the "
               "commander-resolution loop play out over up to 31 in-battle days.",
    "rabbit_holes": [
      ("Tactical combat engine", "4-quadrant damage from attacker/defender geometry, "
       "<code>{1,2,4,7}</code> magnitudes, applied over a 31-day loop; battle ends on "
       "COMMANDER resolution, not attrition.", "../12-combat-engine.md"),
      ("Post-combat ravage / spoils", "the <code>$9323–$9368</code> cluster the driver reaches: "
       "province ravage sweep, arms capture, ownership transfer.", None),
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
    body = (
      f'<header>\n  <div class="cmdno">Lord Command · No. {s["no"]}</div>\n'
      f'  <h1>{s["name"]}</h1>\n  <div class="tag">{s["tagline"]}</div>\n</header>\n\n'
      '<div class="skills">\n  <span>① decompiler → C</span>\n  '
      '<span>④ animation VM → ROM render</span>\n  <span>⚠ subsystem entry point</span>\n</div>\n\n'
      f'<h2>What you see</h2>\n<p class="sub">The {s["name"]} animation, rendered from ROM bytes.</p>\n'
      f'{_anim_block(s, cmd)}\n\n'
      f'<h2>What it does</h2>\n<p>{s["summary"]}</p>\n\n'
      f'{flow}'
      f'{table}\n{callout}\n'
      f'<h2>Where it goes — the rabbit holes</h2>\n'
      '<p class="sub">This command is a simple page on purpose: the depth lives in the subsystem it '
      'hands off to. Those get their own pages.</p>\n'
      f'{rabbits}\n'
      f'<footer>\n  Driver <code>${s["driver"]:04X}</code> · '
      f'<code>tools/run-animation.py</code> · <a href="./README.md">commands index</a>.\n</footer>')
    return _page(f'{s["name"]} — Nobunaga’s Ambition Command Reference', body)

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

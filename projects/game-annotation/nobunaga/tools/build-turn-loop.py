#!/usr/bin/env python3
"""
build-turn-loop.py — generate turn-loop.html, the MAP of Nobunaga's Ambition's
main game loop.

This is the project SPINE: `vm_bootstrap $A778` is the per-season driver every
other subsystem hangs off. The command palette (commands/*.html) is the
"command-pass" branch; the battle engine (combat.html, TBD) is the "resolve
combat" branch. This page is the index above both.

Source-of-truth = the NODES / SEASONS / KEYSTONES registries below (edit these,
regen the HTML — same relationship as mesen-labels.toml -> decompiled/*.c, and
the COMMANDS registry -> commands/*.html). HTML is a DERIVED artifact; never
hand-edit turn-loop.html.

Each node carries a STATUS that doubles as the remaining-work tracker:
  inline : small/straightforward — explained right here on the hub
  page   : meaty — has (or will have) its own deep-dive page; we link out
  stub   : known entry point, not yet dived — the to-do list

Usage:
    py -3 tools/build-turn-loop.py            # write turn-loop.html
    py -3 tools/build-turn-loop.py --print    # dump HTML to stdout

Walk that produced this: main-turn-loop decode 2026-06-02
(see [[project_nobunaga_main_turn_loop]]).
"""
import argparse
import importlib.util
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# --- reuse the command-page generator's CSS + page shell (single style source) ---
_spec = importlib.util.spec_from_file_location(
    "build_command_page", Path(__file__).resolve().parent / "build-command-page.py")
_bcp = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_bcp)
BASE_CSS = _bcp.CSS

# Hub-only additions: status pills, the at-a-glance map list, phase cards.
HUB_CSS = BASE_CSS + """
  .lead{color:var(--ink);font-size:16px;margin:6px 0 26px}
  .lead b{color:var(--gold)}
  .map{list-style:none;counter-reset:step;padding:0;margin:14px 0 8px}
  .map li{position:relative;padding:11px 0 11px 52px;border-bottom:1px solid var(--line)}
  .map li:before{counter-increment:step;content:counter(step);position:absolute;left:0;top:9px;
    width:34px;height:34px;border-radius:50%;background:var(--panel);border:1px solid var(--gold);
    color:var(--gold);font:700 15px/34px var(--mono);text-align:center}
  .map a{color:var(--ink);text-decoration:none;font-weight:600}
  .map a:hover{color:var(--gold)}
  .map .addr{color:var(--dim);font-family:var(--mono);font-size:12px;float:right;margin-top:3px}
  .map .gloss{display:block;color:var(--dim);font-size:13.5px;font-weight:400;margin-top:2px}
  .st{display:inline-block;font:700 10px/1 var(--mono);letter-spacing:.05em;border-radius:4px;
    padding:4px 7px;margin-right:8px;vertical-align:middle;text-transform:uppercase}
  .st-inline{background:var(--green);color:var(--bg)}
  .st-page{background:var(--blue);color:#fff}
  .st-stub{background:var(--panel);color:var(--dim);border:1px solid var(--line)}
  .phase{background:var(--panel);border:1px solid var(--line);border-radius:12px;
    padding:18px 20px;margin:16px 0}
  .phase h3{margin:0 0 4px;font-size:19px}
  .phase h3 .addr{color:var(--dim);font-family:var(--mono);font-size:12px;font-weight:400}
  .phase .bank{color:var(--dim);font-family:var(--mono);font-size:11px;text-transform:uppercase;
    letter-spacing:.08em}
  .phase p{margin:10px 0 0}
  .phase a{color:var(--blue);text-decoration:none}
  .branch{background:#10131f;border:1px solid #2a3358;border-left:4px solid var(--blue);
    border-radius:8px;padding:14px 18px;margin:12px 0}
  .branch b{color:#9ab8ff}
  .branch a{color:#9ab8ff;text-decoration:none;font-weight:600}
  .find{background:#241a12;border:1px solid #6b4a1e;border-left:4px solid var(--gold);
    border-radius:8px;padding:14px 18px;margin:14px 0}
  .find b{color:var(--gold)}
"""

# ── The loop, in execution order. status ∈ {inline, page, stub} ───────────────
# 'detail' is HTML shown in the per-phase card; 'link'/'link_text' add a button.
NODES = [
  dict(id="init", no="0", title="init_new_game_state", addr=0x89A3, bank=0, status="page",
       page="turn-loop-init.html",
       gloss="One-time new-game setup — the front-end wizard: scenario, players, daimyo, skill level.",
       detail="Runs once before the loop proper: boot/title, save check, scenario size, board seeding "
              "(<code>daimyo_turn_order[i]=i</code>, all fiefs manual, market rates randomized), the "
              "how-many-players / character-creation wizard, and the skill-level pick. "
              "<b>Notable:</b> the skill level lands in <code>const_two</code> — the same value the Grow/Build "
              "gain formula subtracts — so difficulty is partly an economy knob (full writeup on the page)."),
  dict(id="planner", no="1", title="ai_strategic_turn_planner", addr=0xA455, bank=0, status="page",
       page="turn-loop-planner.html",
       gloss="The per-season tick — save, calendar, the season-phased economy update, and the random-event engine.",
       detail="The densest node in the loop, and an epic in its own right: it runs the season save and calendar, "
              "the season-phased economy update (drift, the tax→income harvest, aging &amp; natural death), and "
              "the <b>random-event engine</b> (floods, quakes, riots, revolts) before any daimyo acts. This is "
              "<b>turn setup + events</b> — the whole world ticks here. Its deep-dive page has the formulas; the "
              "season table below is the quick view."),
  dict(id="uprising", no="2", title="spawn_zealot_uprising_force_from_province", addr=0xA5E6, bank=0, status="inline",
       gloss="Ikkō-ikki / zealot uprising — builds a one-off attacking army in the $7515 slot.",
       detail="When an uprising fires, this constructs a full 26-byte province-record army in "
              "<code>zealot_uprising_slot $7515</code> (so it drops straight into the combat engine with no "
              "special-casing): each stat field seeded as <code>pct_op(rng%20+40, source_field)</code>, plus "
              "men/rice drawn from the host province. The marker values (header 9999, extreme loyalty/morale, "
              "tiny skill/arms) are what make it recognisable in a save dump."),
  dict(id="combat", no="3", title="resolve staged combat", addr=0xAFE1, bank=2, status="stub",
       gloss="call_bank_wrap(2) → the bank-2 battle engine. The other big branch — its own epic.",
       detail="Any battle staged this season (a war declared during the previous command pass, or the uprising "
              "above) is resolved by handing control to the bank-2 combat engine "
              "(<code>battle_init_driver $AFE1</code>): tactical map, the 4-quadrant {1,2,4,7} damage model, the "
              "31-day commander-resolution loop, ravage &amp; spoils. This is the second large branch off the "
              "spine and gets its own deep-dive page.",
       branch=("The combat engine", "combat.html", "deep page TBD")),
  dict(id="shuffle", no="4", title="shuffle_fief_turn_order_array", addr=0xA742, bank=0, status="inline",
       gloss="Re-randomize who acts when this season — Fisher-Yates-style over $6F1B.",
       detail="Each season the turn order is reshuffled: <code>scenario_fief_count</code> random transpositions "
              "(<code>swap_byte(rng%count + $6F1B, rng%count + $6F1B)</code>). <b>“Random beats initiative”</b> — "
              "there is no fixed seating; a fief’s position in the order is re-rolled every season. The array lives "
              "at <code>daimyo_turn_order $6F1B</code> (see the find below — it is <i>not</i> at $6F0B as the "
              "labels long claimed)."),
  dict(id="command", no="5", title="ai_per_fief_command_driver", addr=0xB89B, bank=1, status="page",
       gloss="The command pass — each fief, in turn order, picks and executes one command.",
       detail="Walks <code>daimyo_turn_order</code> in order; for each fief, "
              "<code>selected_province_idx = daimyo_turn_order[ai_per_fief_loop_index]</code>, then dispatches on "
              "<code>province_ai_state</code> (the six Grant policies — Home / Industrial / Military / Balanced / "
              "Farming / Direct) into the matching AI econ handler, and finally "
              "<code>issue_province_command</code> executes it. Resting daimyo are skipped via "
              "<code>rest_turns_remaining</code>. <b>This is the “command palette” branch</b> — all 21 command "
              "pages are the leaves of this one node.",
       branch=("The command palette — 21 command pages", "commands/index.html", "branch complete")),
  dict(id="gameover", no="6", title="display_fullscreen_graphic_sequence", addr=0x8003, bank=0, status="page",
       page="turn-loop-gameover.html",
       gloss="Win/lose screen, then restart — reached when the abort bit (ai_turn_flags &amp; 128) is set.",
       detail="When any phase sets the abort gate (<code>ai_turn_flags &amp; 128</code> — unification or player "
              "elimination), the loop falls out to the full-screen end sequence: a victory/defeat branch on "
              "<code>count_6da2_set</code>, the “You united Japan!” / “Game Over.” art + music, then a button-wait "
              "and a restart at <code>init_new_game_state</code>. The bank-6 end-screen art is a static-render target."),
]

# ── The season-phased economy update (per_period_fief_daimyo_update_driver $A30D) ──
SEASONS = dict(
  caption="<code>per_period_fief_daimyo_update_driver $A30D</code> does a <code>switch(current_season)</code>. "
          "The right column runs <b>every</b> season; the middle column is the season’s special economic phase.",
  rows=[
    ("0", "— (nothing extra)", ""),
    ("1", "Reset high-water marks <span class='addr'>init_province_highwater_from_records</span>", ""),
    ("2", "<b>HARVEST — gold &amp; rice income</b> <span class='addr'>harvest_income_sweep_all_fiefs</span>", ""),
    ("3", "Relations-matrix decay <span class='addr'>normalize_relations_matrix_lower</span>", ""),
  ],
  every="Stat drift · loyalty decay toward 90% · aging + health decay · natural-death roll",
)

# ── The keystone findings (the mechanics that were hinted-at but never explained) ──
KEYSTONES = [
  ("The command pass resumes across combat.",
   "<code>ai_per_fief_loop_index $6001</code> is a <i>persistent global</i>, restored into the frame at entry "
   "(<code>$B8A4</code>). When a daimyo declares war mid-pass, the index is saved (<code>$B996</code>), control "
   "loops out through the bank-2 combat engine, then re-enters and continues at the <b>next</b> fief — the season’s "
   "command pass is interruptible and resumable, not restarted."),
  ("4 seasons = 1 year, and each season has a job.",
   "<code>config_block $6D5F</code> was a misnomer — at runtime it is the season counter (0–3), renamed "
   "<code>current_season</code>. It increments each period; the year ticks only on its wrap to 0. The "
   "<code>switch</code> on it is what gives each season a distinct economic phase (above) — the harvest is "
   "specifically a season-2 event, confirming the long-standing “fall harvest” reading from the other direction."),
  ("The turn order lives at $6F1B, not $6F0B.",
   "The <code>daimyo_turn_order</code> label had been mis-addressed by 16 bytes — <code>$6F0B</code> has "
   "<b>zero</b> references anywhere. The real array (shuffled by <code>$A742</code>, read by the command driver at "
   "<code>$B918</code>) is <code>$6F1B</code>. The label was relocated and a latent bug in "
   "<code>sram-decode-province.py</code> (which dumped the wrong address) was fixed — exactly the "
   "drift-as-re-derivation this project exists to kill."),
]

ST_LABEL = {"inline": "dived", "page": "has page", "stub": "to do"}

# ── Phase deep-dive pages (turn-loop-<id>.html). Keyed by NODE id. ─────────────
# Each is a multi-step walkthrough of one phase. Add a node here, set its NODE
# status to "page" + page="turn-loop-<id>.html", and it gets its own deep dive.
PHASE_PAGES = {
  "init": dict(
    no="0", title="New Game", sub="init_new_game_state $89A3 — the front-end wizard that builds a fresh game.",
    intro=(
      "Before the season loop can run, the board has to exist. <code>init_new_game_state</code> is the "
      "setup wizard: it boots the title, checks for a save, then walks the player through scenario, "
      "player count, daimyo creation, and skill level — seeding every fief, the turn order, and the market "
      "before handing off to the main loop. Most of it we’d glimpsed in earlier walks; reading it end-to-end "
      "turned up the answer to a question the game never explains: <b>what does the skill level actually do?</b>"),
    steps=[
      (0x89B1, "<b>Boot &amp; title.</b> <code>render_boot_title_screens</code> plays the KOEI / Nobunaga title "
               "sequence; audio is reset (<code>call_bank10_entry(0)</code>)."),
      (0x89CC, "<b>Save check.</b> <code>verify_sram_save_integrity</code> — if a valid save is present the routine "
               "bails out here (the load path takes over). New-game proceeds only on no / invalid save."),
      (0x89EB, "<b>Choose the scenario.</b> <code>prompt_select_scenario_size</code> — 17-fief or 50-fief — sets "
               "<code>scenario_fief_count</code>, which every later loop bound reads."),
      (0x89F9, "<b>Seed the board.</b> <code>daimyo_turn_order[i] = i</code> (identity — later reshuffled each "
               "season); <code>province_ai_state[i] = 0</code> (every fief starts under manual/AI-default control); "
               "the five market rates <code>$6E0B..$6E13</code> are randomized to <code>rng%10 + 8</code>."),
      (0x8A22, "<b>How many players?</b> <code>newgame_player_count = number_input(1..8)</code>."),
      (0x8A91, "<b>Character creation</b> (per human player). <code>prompt_select_player_daimyo</code> picks the "
               "house; <code>daimyo_creation_stat_roll_screen</code> rolls its stats and <b>marks that fief "
               "<code>province_ai_state = 5</code> (Direct / player-controlled)</b> — the flag that later excludes "
               "it from the AI starting boost."),
      (0x8AD6, "<b>Skill level.</b> “Please select skill level.” → <code>const_two = number_input(1..5)</code>. "
               "This one input is the whole difficulty system (see below)."),
      (0x8ADF, "<b>Confirm.</b> “Is everything OK so far?” — yes proceeds; no loops all the way back to the "
               "scenario step and starts the selection over."),
      (0x8B50, "<b>Finalize.</b> <code>ai_player_count = 8 − humans</code>; "
               "<code>apply_scenario_starting_stat_boosts</code> buffs the AI; “Then, on with the game!”"),
    ],
    sections=[
      ("What skill level actually does",
       "<p>The skill level isn’t a separate difficulty system — it’s written straight into "
       "<code>const_two ($6D63)</code>, a single value the engine reads in <b>~35 places across all four "
       "banks</b>. The headline: all five development commands use <code>(6 − skill)</code> as the gain "
       "multiplier, so:</p>"
       "<pre>Grow gain = 2 · <span class='k'>floor</span>( amount · (6 − skill) / sqrt(output + amount) )</pre>"
       "<p class='sub'>Emulator-confirmed on one fief (amount = 100), via <code>tools/probe-skill-impact.py</code>:</p>"
       "<table>\n  <tr><th>skill level</th><th>Grow gain (amount 100)</th><th>vs skill 1</th></tr>\n"
       "  <tr><td>1 (easiest)</td><td>76</td><td>—</td></tr>\n"
       "  <tr><td>2 (default)</td><td>60</td><td>0.79×</td></tr>\n"
       "  <tr><td>3</td><td>46</td><td>0.61×</td></tr>\n"
       "  <tr><td>4</td><td>30</td><td>0.39×</td></tr>\n"
       "  <tr><td>5 (hardest)</td><td>14</td><td>0.18×</td></tr>\n</table>\n"
       "<p>That also explains the mystery “×5” in every early Grow/Build derivation: those tests ran at "
       "skill 1, where <code>6 − 1 = 5</code>. The cracked formulas were all implicitly the default-skill case.</p>"),
      ("One dial, three pressures",
       "<p>Picking a higher skill level doesn’t just make the AI “smarter” — the same value leans on three "
       "subsystems at once, all against the player:</p>"
       "<table>\n  <tr><th>Pressure</th><th>Mechanism</th><th>Effect of higher skill</th></tr>\n"
       "  <tr><td>Your economy</td><td><code>(6 − skill)</code> develop multiplier</td><td>up to ~5× slower growth</td></tr>\n"
       "  <tr><td>AI head start</td><td><code>apply_scenario_starting_stat_boosts</code>: AI daimyo stats "
       "<code>+ skill×5</code>, province fields <code>+ skill×10</code> — applied only to "
       "<code>province_ai_state == 0</code> (i.e. <b>not</b> your Direct fiefs)</td><td>stronger opponents from turn 1</td></tr>\n"
       "  <tr><td>World volatility</td><td>uprising size <code>(skill+1)×10</code>, combat casualty rolls "
       "<code>rng(6 − skill)</code> / <code>−skill</code> damage</td><td>bigger rebellions, harsher battles</td></tr>\n</table>\n"
       "<p class='sub'>The boost loop’s <code>province_ai_state == 0</code> gate is the key: character creation "
       "sets your own fief to state 5, so the buff lands on every AI house but never on you.</p>"),
    ],
    finds=[
      ("Skill level = const_two, the economy throttle.",
       "“Please select skill level.” writes 1–5 to <code>const_two</code> — the very value the development "
       "formulas divide the field-root into. Difficulty is, first and foremost, an economy dial."),
      ("The starting boost targets the AI, confirmed.",
       "<code>apply_scenario_starting_stat_boosts</code> only buffs fiefs with <code>province_ai_state == 0</code>; "
       "your daimyo-creation step marks your fief state 5 (Direct), so you are excluded. Higher skill = bigger AI "
       "head start, never a player one."),
    ],
    sources="<code>decompiled/bank_00.c</code> ($89A3, $83E2) · <code>tools/probe-skill-impact.py</code> · "
            "memory <code>project_nobunaga_main_turn_loop</code> · label <code>const_two $6D63</code>.",
  ),
  "gameover": dict(
    no="6", title="Game Over", sub="display_fullscreen_graphic_sequence $8003 — the win / lose sequence and restart.",
    intro=(
      "The season loop only ever exits one way: a phase sets the abort gate "
      "<code>ai_turn_flags &amp; 128</code> — either a daimyo has unified Japan, or the player has been wiped "
      "out. <code>vm_bootstrap</code> falls through to <code>display_fullscreen_graphic_sequence</code>, which "
      "plays the appropriate end screen, waits for a button, and returns — and the loop restarts at "
      "<code>init_new_game_state</code> for a fresh game. It’s almost pure presentation: graphics, music, and "
      "two strings. The one decision is victory vs defeat."),
    steps=[
      (0x800B, "<b>Quiet down.</b> Silence all audio (<code>syscall_audio_control(0,0)</code>), refresh the UI."),
      (0x8015, "<b>Victory or defeat?</b> Branch on <code>count_6da2_set()</code> — it counts the flagged entries "
               "in the per-fief array <code>$6DA2</code>. Flagged &gt; 0 takes the <b>victory</b> path; 0 takes "
               "<b>defeat</b>. (The exact meaning of the <code>$6DA2</code> flag is still open — it also gates the "
               "per-pass abort and AI targeting; flagged as a data-walk.)"),
      (0x8019, "<b>Victory.</b> Upload the triumph graphic (<code>ppu_upload_block_wrap(…, $9054, bank 6)</code> + "
               "the <code>$9D04</code> full screen), then “Congratulations, my lord!” → “In the year %d” "
               "(<code>current_game_year</code>) → <b>“You united Japan!”</b>, with the victory fanfare "
               "(<code>call_bank10_entry(5)</code>)."),
      (0x811D, "<b>Defeat.</b> The defeat music (<code>call_bank10_entry(6)</code>), <b>“Game Over.”</b>, a "
               "6×64-step palette-fade animation (the screen dims out), and the defeat graphic "
               "(<code>$AF64</code>)."),
      (0x81C5, "<b>Wait &amp; restart.</b> Spin until a controller press (<code>syscall_read_controller</code>), "
               "then return. <code>vm_bootstrap</code> loops back to <code>init_new_game_state</code> — a new game."),
    ],
    sections=[
      ("Where the art lives",
       "<p>The victory and defeat full-screens are static CHR uploaded from <b>bank 6</b> "
       "(<code>$9D04</code> victory, <code>$AF64</code> defeat) and blitted via the usual "
       "<code>ppu_upload_block_wrap</code> / <code>ppu_blit_from_bank_wrap</code> pair. They’re prime targets for "
       "the “render graphics bits from code” frontier — the same code-driven extraction that pulled the title and "
       "portrait art — so both screens could be rendered to PNG straight from ROM without ever reaching the "
       "ending in-game.</p>"),
    ],
    finds=[
      ("Game-over is a discriminator, not a computation.",
       "The whole sequence is two presentation branches selected by one boolean "
       "(<code>count_6da2_set</code> over <code>$6DA2</code>). No formula — the interesting state was decided "
       "earlier (whoever set the abort bit); this phase just announces it."),
      ("$6DA2 is an unresolved per-fief flag array — queued for a data-walk.",
       "It’s the victory/defeat discriminator here, but it’s also read in 10+ AI / combat sites and gates the "
       "command-pass abort. That breadth means it deserves a real data-walk rather than a guessed name."),
    ],
    sources="<code>decompiled/bank_00.c</code> ($8003) · <code>count_6da2_set $D628</code> · "
            "<code>appendix-asset-extraction.md</code> (for the bank-6 end-screen art).",
  ),
  "planner": dict(
    no="1", title="The Season Tick", sub="ai_strategic_turn_planner $A455 — turn setup and the random-event engine.",
    intro=(
      "Before any daimyo picks a command, the whole world advances one season. "
      "<code>ai_strategic_turn_planner</code> is that tick: it saves, rolls the calendar forward, re-prices the "
      "market, runs the per-fief economy update (drift, the harvest, aging and death), and then fires the "
      "<b>random-event engine</b> — floods, earthquakes, riots, revolts. It’s the densest routine in the game, "
      "and walking it turned up two long-standing unknowns: what <code>$6D2D</code> is, and what the disaster "
      "events actually do."),
    steps=[
      (0xA45B, "<b>Save &amp; UI.</b> Show the strategic map; if a save is pending, "
               "<code>write_sram_save_checksum_and_signature</code> commits SRAM (a checksum over the live "
               "regions — the game saves at season end)."),
      (0xA47F, "<b>Calendar.</b> <code>current_season = (season+1)&amp;3</code>; the <b>year</b> ticks only when "
               "that wraps to 0 — four seasons to a year."),
      (0xA495, "<b>Re-price the market.</b> <code>roll_period_rate_table_6e0b</code> re-rolls the five market "
               "rates, so buy-low / sell-high timing genuinely matters period to period."),
      (0xA498, "<b>The per-fief economy update</b> (<code>per_period_fief_daimyo_update_driver $A30D</code>) — "
               "drift, the season-phased work (incl. the harvest), and the death sweep. See below."),
      (0xA4C3, "<b>The random-event engine.</b> Pick an event family, roll each fief for eligibility, then apply "
               "the disaster / riot / revolt to the affected provinces. See below."),
      (0xA55F, "<b>Illness pass.</b> Each daimyo (health ≤ 99, not resting) is weakness-marked with probability "
               "<code>(100 − health) / 400</code>; a freshly-marked one gets “… has taken ill.”"),
    ],
    sections=[
      ("Turn setup — the per-fief economy update",
       "<p><code>per_period_fief_daimyo_update_driver $A30D</code> sweeps every fief, then does work that "
       "depends on the season:</p>"
       "<ul>"
       "<li><b>Daimyo luck drifts.</b> <code>drift_daimyo_luck</code> nudges each daimyo’s <b>Luck</b> stat "
       "(record +3) by <code>rng%11 − 5</code> = <b>−5…+5 every season</b> — a literal random walk, which is "
       "exactly why a daimyo’s fortunes swing from year to year.</li>"
       "<li><b>Tax drives loyalty.</b> A fief whose <code>fief_tax_rate ($6D2D)</code> is below "
       "<code>90 − skill</code> has its loyalty multiplied by 0.9 that season. (Direction reads "
       "counterintuitively — flagged for a bytecode recheck — but the dependency on the tax rate is real.)</li>"
       "</ul>"
       "<p>Then one season-specific job, on top of the universal aging + natural-death roll:</p>"
       "<table>\n  <tr><th>current_season</th><th>The season’s job</th></tr>\n"
       "  <tr><td>0</td><td>— (aging + death only)</td></tr>\n"
       "  <tr><td>1</td><td>Reset the economic high-water marks</td></tr>\n"
       "  <tr><td>2</td><td><b>HARVEST</b> — gold &amp; rice income = <code>tax% × economic base</code></td></tr>\n"
       "  <tr><td>3</td><td>Relations-matrix decay</td></tr>\n</table>\n"
       "<p class='sub'>The big <code>$6D2D</code> find lives here: it’s the per-fief <b>tax rate</b> "
       "(<code>driver_tax</code> writes the player’s 1–100 input straight into it), and the harvest reads it as "
       "the income multiplier — <code>income = pct_op(tax, wealth) + pct_op(tax, 40%·town)</code>. So “raise tax” "
       "literally scales every fief’s gold/rice yield.</p>"),
      ("The random-event engine",
       "<p>Each season the planner may fire a world event. First it <b>selects a family</b> (season-gated and "
       "RNG-weighted — floods skew to one season, the political events to others), then it rolls <b>every fief "
       "for eligibility</b>: <code>square_over_2025_probability_roll</code> compares a stat² against "
       "<code>rng%2025</code> (the stat capped at 50), tested against <b>loyalty, (100 − tax), and the daimyo’s "
       "charisma</b>. Low loyalty, high tax, and weak leadership are what make a province a target. The eligible "
       "fiefs go on a list, and the handler hits each one:</p>"
       "<table>\n  <tr><th>Event</th><th>Anim</th><th>What it does to each affected fief</th></tr>\n"
       "  <tr><td><b>Flood</b></td><td>20</td><td>wealth −1…4; <b>output cut to <code>(0.9 × dams)%</code></b> — "
       "so dams are <b>flood insurance</b>: a maxed fief keeps ~90% of output, an undammed one loses almost all</td></tr>\n"
       "  <tr><td><b>Quake / plague</b></td><td>31</td><td>men ×(50–99)% and output ×(50–99)%; if the daimyo is "
       "present in the fief, a health hit + weakness mark on top</td></tr>\n"
       "  <tr><td><b>Riot</b></td><td>23</td><td>unrest across high-tension provinces (no ownership change)</td></tr>\n"
       "  <tr><td><b>Revolt</b></td><td>25</td><td><code>revolt_spread_sweep_flip_fief_ownership</code> — a fief "
       "<b>changes hands</b> to the rebels; the harshest outcome</td></tr>\n"
       "  <tr><td><b>Boon</b></td><td>—</td><td><code>event_boost_province_wealth_loyalty</code>: wealth + "
       "(<code>rng%10 + charisma/10</code>), loyalty up — the rare good news</td></tr>\n</table>\n"
       "<p class='sub'>Every event has a from-ROM animation (the ids above) pullable with "
       "<code>tools/run-animation.py</code>. The exact family-selection probabilities live in goto-heavy "
       "bytecode and are the next depth increment — but the <b>effects</b> above are read straight from the "
       "handlers.</p>"),
    ],
    finds=[
      ("$6D2D is the per-fief tax rate — confirmed.",
       "<code>driver_tax</code> displays it as “Tax is %d” and writes the player’s 1–100 input into it; the "
       "harvest reads it as the income multiplier. The old harvest-formula “od_pct” was this. Labeled "
       "<code>fief_tax_rate</code> (regen-guard clean)."),
      ("Dams are flood insurance.",
       "Flood output loss is <code>(0.9 × dams)%</code> retained — a third strategic reason to build dams, "
       "alongside rice yield and the Dam-vs-Grow crossover. Undammed fiefs are wiped by a single flood."),
      ("Daimyo Luck is a random walk.",
       "Every season each daimyo’s <b>Luck</b> (record +3) drifts <code>−5…+5</code> — so a rival’s fortunes "
       "genuinely wander over a campaign, and the field-+3 swings seen across save dumps are just this walk, not "
       "a hidden depletion mechanic. The 7 stats: Age, Health, Drive, Luck, Charisma, IQ, + a portrait flag."),
      ("Events target the disloyal, over-taxed, and poorly-led.",
       "Eligibility rolls on loyalty, (100 − tax), and charisma — the same three levers you manage with Give, "
       "Tax, and which daimyo governs. The event system is the feedback loop on bad governance."),
    ],
    sources="<code>decompiled/bank_00.c</code> ($A455, $A30D, $9CB3, $9D00, $9ED9) · "
            "<code>driver_tax $99A6</code> · <code>fief_tax_rate $6D2D</code> · "
            "memory <code>project_nobunaga_main_turn_loop</code> · <code>tools/run-animation.py</code> (event anims).",
  ),
}


def render_phase_page(pid):
    p = PHASE_PAGES[pid]
    steps = "\n".join(f'  <li><span class="addr">${a:04X}</span>{h}</li>' for a, h in p["steps"])
    secs = "".join(
        f'<h2>{head}</h2>\n{html}\n' for head, html in p.get("sections", []))
    finds = "".join(
        f'<div class="find"><b>{t}</b> {b}</div>\n' for t, b in p.get("finds", []))
    body = (
      f'<header>\n  <div class="cmdno">Turn-loop phase {p["no"]} · deep dive</div>\n'
      f'  <h1>{p["title"]}</h1>\n  <div class="tag">{p["sub"]}</div>\n</header>\n\n'
      '<div class="skills">\n  <span>① decompiler → C</span>\n  <span>② data-walk labels</span>\n'
      '  <span>③ bytecode-verified flow</span>\n  <span>④ emulator-probed formula</span>\n</div>\n\n'
      f'<p class="lead">{p["intro"]}</p>\n\n'
      f'<h2>The steps</h2>\n<p class="sub">The wizard, in order — each step grounded in the '
      f'<code>$89A3</code> bytecode:</p>\n<ol class="flow">\n{steps}\n</ol>\n\n'
      f'{secs}'
      f'<h2>What it pinned down</h2>\n{finds}\n'
      f'<footer>\n  ← <a href="./turn-loop.html">back to the turn-loop map</a> &nbsp;·&nbsp; '
      f'Sources: {p["sources"]}\n  Generated by <code>tools/build-turn-loop.py {pid}</code>.\n</footer>')
    return _bcp._page(f'{p["title"]} — Nobunaga’s Ambition Turn Loop', body).replace(
        f"<style>{_bcp.CSS}</style>", f"<style>{HUB_CSS}</style>")


def _map_list():
    items = ""
    for n in NODES:
        st = f'<span class="st st-{n["status"]}">{ST_LABEL[n["status"]]}</span>'
        items += (f'  <li><span class="addr">${n["addr"]:04X} · bank {n["bank"]}</span>'
                  f'{st}<a href="#{n["id"]}">{n["title"]}</a>'
                  f'<span class="gloss">{n["gloss"]}</span></li>\n')
    return f'<ol class="map">\n{items}</ol>'


def _phase_cards():
    out = ""
    for n in NODES:
        st = f'<span class="st st-{n["status"]}">{ST_LABEL[n["status"]]}</span>'
        branch = ""
        if n.get("branch"):
            label, link, note = n["branch"]
            exists = (ROOT / link).exists()
            tgt = (f'<a href="./{link}">→ {label}</a>' if exists
                   else f'<span style="color:var(--dim);font-weight:600">{label}</span>')
            branch = f'<div class="branch"><b>Branch:</b> {tgt} <span class="bank">— {note}</span></div>\n'
        season = ""
        if n["id"] == "planner":
            season = _season_table()
        page = ""
        if n.get("page") and (ROOT / n["page"]).exists():
            page = (f'<div class="branch"><b>Deep dive:</b> '
                    f'<a href="./{n["page"]}">→ {n["title"]} — full page</a></div>\n')
        out += (f'<div class="phase" id="{n["id"]}">\n'
                f'  <div class="bank">Phase {n["no"]} · bank {n["bank"]}</div>\n'
                f'  <h3>{st}{n["title"]} <span class="addr">${n["addr"]:04X}</span></h3>\n'
                f'  <p>{n["detail"]}</p>\n{season}{page}{branch}</div>\n')
    return out


def _season_table():
    head = "<th>current_season</th><th>The season’s economic phase</th>"
    rows = ""
    for s, mid, _ in SEASONS["rows"]:
        rows += f"  <tr><td>{s}</td><td>{mid}</td></tr>\n"
    return (f'<h2 style="font-size:18px;border-left-width:3px">The season-phased economy</h2>\n'
            f'<p class="sub">{SEASONS["caption"]}</p>\n'
            f'<table>\n  <tr>{head}</tr>\n{rows}</table>\n'
            f'<p class="sub"><b>Every season, regardless:</b> {SEASONS["every"]}.</p>\n')


def _keystones():
    out = ""
    for title, body in KEYSTONES:
        out += f'<div class="find"><b>{title}</b> {body}</div>\n'
    return out


def render():
    body = (
      '<header>\n  <div class="cmdno">Nobunaga’s Ambition · NES · The Engine</div>\n'
      '  <h1>The Main Turn Loop</h1>\n'
      '  <div class="tag">vm_bootstrap $A778 — the per-season driver every other subsystem hangs off.</div>\n'
      '</header>\n\n'
      '<div class="skills">\n  <span>① decompiler → C</span>\n  <span>② data-walk labels</span>\n'
      '  <span>③ bytecode-verified control flow</span>\n  <span>⑤ the spine / map</span>\n</div>\n\n'
      '<p class="lead">This is the <b>spine</b> of the game. One routine — '
      '<code>vm_bootstrap $A778</code> — sequences every season: it runs the per-season tick, reshuffles who '
      'acts, and hands each fief to the command driver, looping out to the combat engine whenever a war is '
      'declared. The <b>command palette</b> (21 pages) and the <b>battle engine</b> are its two big branches; '
      'this page is the index above them, and the status badges are the remaining-work map.</p>\n\n'
      '<h2>The loop at a glance</h2>\n'
      '<p class="sub">One pass = one season. After <code>init</code> (once), phases 1–6 repeat. '
      '<span class="st st-inline">dived</span> = explained here · '
      '<span class="st st-page">has page</span> = its own deep dive · '
      '<span class="st st-stub">to do</span> = known entry point, not yet walked.</p>\n'
      f'{_map_list()}\n\n'
      '<h2>The phases</h2>\n'
      f'{_phase_cards()}\n'
      '<h2>The mechanics it explains</h2>\n'
      '<p class="sub">Behaviours that had been hinted at across the project but never pinned to code, '
      'now ground-truth from the bytecode:</p>\n'
      f'{_keystones()}\n'
      '<footer>\n  <b>Entry:</b> <code>vm_bootstrap $A778</code> (bank 0). &nbsp;·&nbsp;\n'
      '  Sources: <code>decompiled/bank_00.c</code> · <code>decompiled/bank_01.c</code> · '
      '<code>disasm/bank_0{0,1}_vm.asm</code> · <a href="./commands/index.html">command palette</a> · '
      'memory <code>project_nobunaga_main_turn_loop</code>.\n  Generated by '
      '<code>tools/build-turn-loop.py</code> — do not hand-edit; edit the registry and regen.\n</footer>')
    return _bcp._page("The Main Turn Loop — Nobunaga’s Ambition", body).replace(
        f"<style>{_bcp.CSS}</style>", f"<style>{HUB_CSS}</style>")


def _write_phase(pid):
    out = ROOT / f"turn-loop-{pid}.html"
    out.write_text(render_phase_page(pid), encoding="utf-8")
    print(f"  wrote {out.relative_to(ROOT)}  ({out.stat().st_size} bytes, phase '{pid}')")


def _write_hub():
    out = ROOT / "turn-loop.html"
    out.write_text(render(), encoding="utf-8")
    print(f"  wrote {out.relative_to(ROOT)}  ({out.stat().st_size} bytes, {len(NODES)} phases)")


def main():
    ap = argparse.ArgumentParser(
        description="Generate turn-loop.html (the hub) and turn-loop-<phase>.html deep dives.")
    ap.add_argument("target", nargs="?", default="all",
                    help="'hub', a phase id (e.g. init), or 'all' (default = hub + every phase page)")
    ap.add_argument("--print", action="store_true", help="dump HTML to stdout instead of writing")
    args = ap.parse_args()
    if args.print:
        print(render() if args.target in ("hub", "all") else render_phase_page(args.target))
        return
    if args.target in PHASE_PAGES:           # a single phase page
        _write_phase(args.target)
        _write_hub()                         # regen hub so its link/badge reflect the page
    elif args.target == "hub":
        _write_hub()
    else:                                    # 'all'
        for pid in PHASE_PAGES:
            _write_phase(pid)
        _write_hub()


if __name__ == "__main__":
    main()

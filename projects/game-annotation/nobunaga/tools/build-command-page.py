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
    0xA2D2: "effect_hire", 0x891D: "give_loyalty", 0x896F: "give_wealth",
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

def render_functional(cmd, s):
    rabbits = ""
    for label, desc, link in s.get("rabbit_holes", []):
        tgt = f' <a href="{link}">→ deep page</a>' if link else ' <i>(deep page TBD)</i>'
        rabbits += f'<div class="rabbit"><b>\U0001f573️ {label}.</b> {desc}{tgt}</div>\n'
    body = (
      f'<header>\n  <div class="cmdno">Lord Command · No. {s["no"]}</div>\n'
      f'  <h1>{s["name"]}</h1>\n  <div class="tag">{s["tagline"]}</div>\n</header>\n\n'
      '<div class="skills">\n  <span>① decompiler → C</span>\n  '
      '<span>④ animation VM → ROM render</span>\n  <span>⚠ subsystem entry point</span>\n</div>\n\n'
      f'<h2>What you see</h2>\n<p class="sub">The {s["name"]} animation, rendered from ROM bytes.</p>\n'
      f'{_anim_block(s, cmd)}\n\n'
      f'<h2>What it does</h2>\n<p>{s["summary"]}</p>\n\n'
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

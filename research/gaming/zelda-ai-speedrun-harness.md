---
status: active
created: 2026-10-01
discussion: folded-in
---
# An AI Speedruns NES Zelda — the Harness, the Journal, and What Transfers
> A creator had Claude Code, working as a coding agent, build a bot that beats *The Legend of Zelda* (NES) from power-on: **37:02, glitchless, replay-verified**, after ten days, ~25,000 lines of Python and a **46-entry journal** the agent kept as it went. The AI never plays live (it thinks in seconds; Link needs a decision every frame). It **writes the player**, a deterministic program that does. This page is about **technique**: the source is the closest external specimen yet to the vault's own RE-and-build-with-LLMs method, on a **real-time** game, from the *consumer* side of a disassembly.

**Date:** reviewed 2026-10-01
**Source (video):** [YouTube — "AI learns to beat Zelda"](https://www.youtube.com/watch?v=mBalZml520o) (48:16; ~11 min narrated, then the 37-min run, no commentary) — [transcript](../../raw/videos/transcript-mBalZml520o.txt) · [clean](../../raw/videos/transcript-mBalZml520o-clean.txt)
**Source (primary, much richer):** [bearsgaming-ui/AIBeatsZelda](https://github.com/bearsgaming-ui/AIBeatsZelda) @ `e0c705e` (2026-09-23): `release.zip` holds the harness, `journal/` (46 entries), `knowledge/` (playbook, routes, decoded ROM tables), and the run's input log + `VERIFICATION.txt`. **Read in full for this review**; cited below as *J-nn* (journal entry). Third-party code, not copied into the vault.
**Vault relevance:** [Oracles Are Objective Functions](../oracles-as-objective-functions.md), [Slay — Evaluation](./slay-evaluation.md) (eval beats depth), [Contract vs. Substrate](../contract-vs-substrate.md), [Jevons for Software §4a](../economics/jevons-software-demand.md) (gating the criteria), [LLM Agents Across Games](./llm-agents-across-games.md), [Pluto on the Brood War Ladder](./pluto-broodwar-apm-over-strategy.md), [Variance Is Not Luck](../economics/variance-is-not-luck.md)

---

## The architecture (what was actually built)
1. **Hands.** A Lua script inside BizHawk (the TAS community's emulator) listening on a socket, with **four verbs**: hold buttons for *n* frames, read state, save a bookmark, load a bookmark (plus screenshot). Everything else is built from those (J-01).
2. **Eyes = RAM, not pixels.** All game state comes from 2 KB of RAM: positions, hearts, the 12 monster slots' types and positions, the decoded tile grid. Addresses came from fan memory maps, **several wrong** (the wiki's game-mode table had two values swapped), found by testing (J-01, J-04).
3. **Lockstep invariant.** *"Every frame of the run must be one the script explicitly asked for."* Learned when the bridge's 50 ms yield let the emulator run ~300 unrequested frames whenever Python paused. Same state and same inputs gave different results, which looked like nondeterminism (J-08).
4. **Learned terrain.** BFS over 8-px steps; unknown tiles assumed walkable; a failed step with **exactly one** unknown tile marks it solid *forever* (a persistent knowledge file). Two unknowns teach nothing (J-02, J-03).
5. **Segment search.** The game is cut into **341 segments** (roughly one per room). From the bookmark at each door: 60–90 **seeded** attempts across six emulators, each scored to **one number** (frames, plus prices for hearts and bombs: a bomb in hand = 220 frames). Keep the best, bookmark its end, move on. A lossless `OverBudget` cutoff kills attempts that can no longer win (J-05, J-06, J-40).
6. **Lookahead fighter.** Every 8 frames: snapshot, try **9 macros** (4 walks, 4 swings, wait), roll each forward ~14 frames, score (death −100,000; half-heart −800; enemy HP +60; kill +150; facing a Darknut's shield −60; a pull toward strike spots), play the best. It beat the five-Darknut room **first try** after hand-written reactive fighters failed hundreds of times (J-11). *"Those prices are Link's personality"* (narration).
7. **Survey tool** (`tactics.py`, `secrets.py`). Snapshot a room, replay a few seconds once per (weapon × position), or try every item from every reachable square, and print a ranked table. *"It costs about two minutes. It cannot be wrong"* (J-20, J-22, J-23).
8. **Reading the cartridge and the disassembly.** The ROM's door tables decoded (0 open, 1 wall, 4 bombable, 5 locked, 7 shutter). A **flood-fill over the door graph** found each dungeon's boss wing as an orphan component joined by a staircase (J-20). Ganon's exact rules, the whirlwind counter and the kill-cycle drop table came from the community disassembly (J-31, J-32, J-41). The overworld decoder matches **98/98** walked screens.
9. **A calibrated route model.** A Dijkstra router plus an errand-order planner, calibrated on run 3's 110 crossings. It **reproduced run 3 at 41.33 min vs. 41.26 real**, then **predicted run 4 at 39.24; it came in at 39.25** (J-41, J-42).
10. **Verification.** The whole input log is replayed from power-on in a fresh emulator with a wiped battery save, and the final 2 KB of RAM is compared by SHA-1. Every run is "MATCH" or it isn't a run (J-01, J-15, J-46).

**Trajectory:** 1:43 → 57:40 → 41:15 → 39:15 → 37:19 → **37:02** (human glitched record 27:40). Final split: 16:31 scrolls/menus/fanfares, 12:05 fights, 7:34 walking empty rooms (J-45).

## Lessons the journal states in its own words
- **"Research first, experiment second."** The emulator confirms facts and finds the fastest execution; it does not rediscover what the community wrote down twenty years ago (J-10).
- **"The instrument, not the game."** Seven times the bot's *own check* was what was broken: a projectile counted as boss HP, a boss that left the room read as dead, a whirlwind taken as evidence, a 360-frame timeout on a 380-frame ride, a rupee counter read **at the first instant it moved instead of when it settled** (J-17, J-21, J-24, J-26).
- **"Test your instrument on a question you already know the answer to before you believe its 'no'"** (J-25).
- **"Reaching for it is the discipline, not building it."** The survey tool existed a day before the Pols Voice fight it would have solved in two minutes (J-24).
- **Poisoned memory.** A knockback or an old man's text freeze got recorded as "this move is impossible" *permanently*. 37 of 40 failures came from one wrong memory. Fix: a clean slate per attempt; a failure caused by a hit or a blocker is not scenery (J-15, J-29, J-40).
- **Search hides bugs.** For ten days about half of all perpendicular swings went out **sideways** (an 8-px grid slide). The search quietly filtered the failures, so nothing "broke"; the planner just *learned that flank attacks don't work* and circled. Found only by printing every decision of one fight. After the fix, **an average first try beat what fifty rehearsals used to find** (J-43).
- **Path-dependent residue.** Detours "rational at the moment written … none of them rational from the finished map": three dungeons entered twice. Removed by re-planning from the finished map (J-37, J-39).
- **"When a change makes things worse, revert it before reasoning about it"** (J-36).
- **A run is one draw.** Boss variance swamps tightening; the agent stops rolling rather than chase noise (J-40, J-45).

## Discussion seeds
1. **Same method, opposite end of the disassembly.** Our projects *produce* decompiled source; this bot *consumed* one (aldonunez's Zelda disassembly) and that is what cracked Ganon, the drop table and the whirlwind. Is "a bot or route planner that runs on our decompiled source" the demo that makes our architecture visible (*structure over demos*), e.g. NA1's verified econ sim already being half of one? (NA1 already has the *survey* pattern in manual form: `capture-test.py` pre → move → post → diff, and `run-effect.py` running a handler from an SRAM dump. The Zelda bot automates that sweep: every option from one snapshot, ranked.)
2. **Architecture-first, confirmed from outside.** The vault's rule: classify the game first (turn-based = walkable call tree; real-time = data plus dispatch). This is the real-time case, and the method that fell out (savestate search plus lookahead plus RAM reading) is exactly what that classification predicts. Mappy is our real-time specimen. Would a lookahead harness on Mappy be a **behavioral oracle** for its decompiled logic: same inputs, compare RAM?
3. **"The instrument, not the game" sharpens two vault rules.** The common-mode-error page says a checker with no failure mode for an error class reports zero errors forever. The journal adds two operational tests: **read a value when it settles, not when it changes**, and **calibrate the detector on a known positive before trusting its "no."** Promote to the RE-method rules?
4. **Search hides bugs: an optimizer as a bug-masker.** [Oracles Are Objective Functions](../oracles-as-objective-functions.md) has "all-pass = a standard optimised against." The sideways sword is the mirror image: **selection filters out a systematic error instead of exposing it**, and the behavior adapts around it. Our multi-pass label walks also keep "what passes." Do we have a sideways-sword anywhere? (The KOEI `$D8` bug two passes shared is the nearest cousin.)
5. **The human held the criteria, not the code.** Every big correction came from the owner watching: the boomerang sitting in the B slot during the Dodongo fight, "that orange thing needs to be whistled," "go through them," "passive is losing." He wrote no code. That is [Jevons §4a](../economics/jevons-software-demand.md)'s "gating the criteria" observed in the wild. Specimen for the thesis?
6. **Lookahead depth vs. evaluation.** A three-step lookahead was "no better than two, costs more" (J-43); the big gains came from fixing *what was scored* and *what was simulated* (the facing fix). That is [Slay's](./slay-evaluation.md) *eval beats depth*, independently. Add as a specimen?
7. **The journal is a scar ledger, and a better one than ours?** Every entry: problem, tried, wrong, changed. It is the scar-ledger pattern (specimen: [Hangman](./hangman-solving-both-sides.md)) written as narrative, and it doubled as the documentary's script. Our session logs vs. per-project journals: is there something to adopt?

## Discussion

### "No cheats" isn't well defined, and that's fine
> **Chris:** *"I find it interesting that he said 'no cheats', but I am not sure this is well defined! A good example is actually NA1 from our vault: we can read RAM and know the state of all fiefs on the map, something a human can't do. Is reading all of Zelda RAM the same? If the AI learns how to screen scroll, is this cheating? To be honest, I don't think this is a problem. TAS runs exploit anything they can about the code to find a faster way."*

The run's rules (README) constrain **inputs** (controller only, no memory writes) and **techniques** (no screen scrolling, no block clips). They say nothing about **information**: the bot sees all of RAM, a superhuman view, exactly like our NA1 tools seeing every fief. So "no cheats" means *"no writes, no glitches,"* not *"human information."* The TAS tradition draws the line only at the input log. Chris will describe screen scrolling later.

### Data first: the bot took the long way round
> **Chris:** *"What I find amusing is that the first try to figure out how to move, the engine enumerated all of the directions in-game to build its map. Only later on did it find the data that builds the maps and use it to confirm its pre-built map was accurate. I would jump straight to the data! And to this: yes, it took way too long to read the source code. This would have answered many questions upfront, and is the main reason I started the disassembly projects!"*

The journal's order was **experiment → ROM tables → disassembly** (J-02/03 bump-mapping, J-07/J-20 door tables, J-31 Ganon's code, J-41 overworld decoder: 98/98). Chris's order is the reverse: **read the data and code first, then experiment to confirm.** The bot's own late rule (*"research first, experiment second,"* J-10) is the same lesson, learned by paying for it. This is also the vault's *label data earlier in the pipeline* rule (strings, schemas and RAM globals before the code walk), now from a consumer of a disassembly instead of a producer.

**Correction on provenance (Chris asked).** Chris had the impression the bot found the map data in the ROM itself, and **for the maps, it did**: the dungeon door/room tables (J-07, J-20) and all 128 overworld screens (J-41) were decoded *by the bot from the ROM*, and the overworld decoder was trusted only after matching **98/98** screens it had walked. What was borrowed was (a) the **RAM address map** (fan-made, several entries wrong, J-01/J-04), (b) the community **disassembly** for game logic (Ganon, drops, the whirlwind), and (c) community **maps and cave lists**, wrong at least five times (J-23, J-35). Chris: *"this does explain it, and I think we 'fact-check' the oracle because of it. If the bot found ROM and could draw screens, this is better grounding."* Ranked by grounding: **self-decoded ROM, verified against play** > the community disassembly > fan RAM maps > community maps and walkthroughs. Only the first was never wrong in the journal.

**Glitches.** Chris: controller glitches are fine (*"TAS runs exploit anything they can"*), but the run's glitchless rules force a different route, one he knows less well. So the comparison with the 27:40 record is between two categories, not one.

**Screen scrolling, as Chris described it.**
> **Chris:** *"Screen scrolling is a controller glitch that takes advantage of the input buffer in the game. Basically you are feeding the controller multiple inputs before they are read, and this will allow things such as block clipping and screen scrolling. Screen scrolling is an input buffer trick done on the edge of the screen where you give opposing inputs. The game takes these inputs into the screen change (scroll) routine and thinks the player is scrolling the screen in the opposite direction. Because of this, it puts Link on the opposite side of the screen and allows him to continue that way. So this can be used to skip screens very quickly, or even better, get over boundaries that are normally there, such as a wall, or even wrapping to the other side of the map. This trick only works left/right in practice, as up/down gets blocked by the game interface at the top: Link still appears in that interface, but he gets stuck, as the scroll routine doesn't expect him there."*

Read as RE, a glitch is a **precondition the game's code never checks**. The scroll routine trusts the input direction without checking it against where Link actually is. That is the bot's *"the instrument, not the game"* turned around: there the bot's own checks had no failure mode for a class of error; here the **game's** check has none for a class of input. It also bears on "data first": a glitch like this is a fact about the code, so it is in principle readable from the scroll routine in the disassembly, and a frame-level savestate search over input combinations is the empirical way to find it. Both of those were tools the bot already had; its rules, not its method, kept it off this path. *(Mechanism as described by Chris; not verified against the disassembly here.)*

**Two rules promoted** to the project SDK (`projects/CLAUDE.md`), 2026-10-01: *zero yield is a wrong-path signal* (from J-22 and Chris's ghost-chasing) and *a learned fact records its cause, or it isn't recorded* (from J-29 and Chris's carried-state warning).

### Speedrunning is avoiding gameplay: the avoid/fight toggle
> **Chris:** *"Speedrunners learn fairly early that avoiding as much gameplay as possible is the key to fast runs. It is fine to build a good combat engine, but most of the time you avoid combat, only doing it when required. The ability to toggle between avoid and combat is a key component. And when I watched the run, I noticed the pathing wasn't the same as the top runners, so even as the author admitted, there is much improvement to be had."*

The bot did arrive at a toggle (the playbook's per-room tag: *avoid unless the route says fight*; J-39's door-table audit: "rooms whose exit is open or locked are crossed, not cleared"). But it reached it late, and the route still differs from the human record's (J-41: the 27:40 route is 3-4-1-5-2-7-MS-6-8-9 and uses glitches this run forbids, but its pathing is not only glitches).

### The five lessons, against our own projects
1. **The instrument, not the game.** *"Yes, we ran into this a lot... still running into it with the latest decompile! And this is fine: we don't know what we don't know. But we learned the lesson that an 'oracle' is only the best we know so far."* This is the [contract-vs-substrate](../contract-vs-substrate.md) point: the floor is adopted, not discovered.
2. **Search hides bugs.** *"Also something we ran into with the decompiler: we chased after ghosts and the space just constantly grew because of it. Knowing when you are going down a wrong path is a big deal."* The journal has a wrong-path detector worth keeping: *"a segment grinding for many minutes with zero successes means the room contains something the sword cannot touch"* (J-22). Persistent zero yield is a signal about the **search space**, not about effort.
3. **Errors compound early; the landscape clears them.** *"This is something we need to deal with more. The first decompile I ended up doing 3x. Errors early on did compound, and this is fine. We didn't know what we were doing, so of course there was error, but as the landscape became clearer, those errors were eliminated and we got better results."* (Same arc as J-37's "rational at the moment written, not from the finished map," and the vault's ROTK2 re-walk.)
4. **Carried state carries mistakes.** *"This is something I still have to warn against. If the agent is keeping state from the beginning, they are carrying mistakes forward. I advocated for fresh sessions to avoid this issue, but this didn't stop issues in memory and such. I think we get better at this, but being able to purge context/memory of bugs is something to watch for."* The bot's version: one knockback written as a permanent fact poisoned 37 of 40 attempts, and the fix was a **clean slate per attempt** (J-29). Fresh sessions purge *context*; they don't purge *memory files*, which is exactly where the bot's poison lived (its persistent knowledge base).
5. **The human held the criteria.** *"Yup, cyborg model."* → [The Cyborg Model](../cyborg-model.md).

## The toolset gap, and what to add
> **Chris:** *"What I wanted for this page last is the toolset. We seem to do everything that this experiment did except for being able to feed inputs into the emulator itself. We never explored this, though we did explore Lua scripts, and these might not have the resolution we would need for clean gameplay. So maybe we can add some tools to our toolset?"*

**What we have vs. what the bot had:**

| Capability | AIBeatsZelda | Our toolset today |
|---|---|---|
| Read RAM / state | bridge `read` | ✅ Mesen Lua `emu.read`, `.dmp` dumps (`capture-test.py`) |
| Watch writes / exec | — | ✅ `addMemoryCallback` loggers (`na1-decompiler/nobunaga/tools/lua/`) |
| Run game logic offline | — | ✅ (stronger) the validated Python VM (`run-effect.py`), run on SRAM dumps |
| Decode ROM tables / read the code | community disassembly + own decoders | ✅ (stronger) we *produce* the disassembly and decompiled C |
| **Inject controller input** | bridge `hold buttons n frames` | ❌ never built |
| **Programmatic savestates** | bridge `save`/`load` (~1 ms) | ❌ (manual GUI dumps only) |
| **Lockstep control from Python** | socket, blocking per command | ❌ |
| **Headless, parallel instances** | six BizHawk scouts | ❌ |
| **Replay verification** | input log from power-on → RAM SHA-1 | ❌ (our verifier is bytecode-level, not behavioral) |
| Automated survey sweep | `tactics.py`, `secrets.py` | ◐ manual: `capture-test.py` pre → act → post → diff |

**Resolution is not the problem. Verified 2026-10-01 against Mesen 2's own source** (`SourMesen/Mesen2` master: `Core/Debugger/LuaApi.cpp`, `ScriptingContext.cpp`, `UI/Utilities/CommandLineHelper.cs`):
- `emu.setInput(buttons, port, subport)` sets controller bits, and the event list includes **`inputPolled`**, which fires *each time the game reads the pad*. That is finer than per-frame.
- `emu.createSavestate()` returns the whole state as a string, and `emu.loadSavestate(s)` restores it. **Catch:** both must be called *inside an exec memory callback for the main CPU* (the source errors otherwise), so the bridge saves/loads from an exec hook on an address the game runs every frame (e.g. its NMI handler, from the ROM vector).
- **LuaSocket** is built in, but disabled by default: enable *Script → Settings → Restrictions → Allow I/O & OS access* and *Allow network access*.
- **`--testRunner [lua script] [rom]`** runs headless. That gives the parallel scouts.

So Mesen 2, which we already use, can do everything BizHawk did for the bot. No second emulator is needed. *(Our installed build's version is unchecked; step 0 is confirming it has these.)*

**Proposed tools** (target-agnostic, one home, with the journal's scars built in from day one):
1. **`bridge.lua`**: a socket server inside Mesen with the four verbs (hold buttons for *n* frames / read RAM ranges / save state / load state, plus a RAM hash). **Blocks between commands, so no frame runs that Python didn't ask for** (J-08).
2. **`harness.py`**: the Python client. **Every frame goes through one input recorder** (J-19). `replay(log)` runs from power-on with a **wiped battery save** (J-15, J-46) and compares the RAM SHA-1.
3. **`survey.py`**: the automated `capture-test`. From one savestate, run N variants, read a RAM predicate **when it settles** (J-23), and print a ranked table. Each attempt starts from a **clean slate** (J-29).
4. **`scouts.py`**: N `--testRunner` instances on N ports for parallel search.

**What it would buy us:**
- **NA1 / the KOEI titles:** turn `capture-test`'s manual pre/post into a sweep (every command × every fief from one save). It also gives a **behavioral oracle** for the decompiled sim: the same inputs into Mesen and into the Python VM should give the same SRAM.
- **Mappy (real-time):** the lookahead harness is the method the architecture-first rule predicts for a real-time game.
- **Zelda itself:** needs a ROM (Chris: *"at best we might try to get the Zelda ROM"*). With it, the 37:02 input log in the AIBeatsZelda repo is a ready **acceptance test** for our harness: replay it and see whether it reaches Zelda. *(A cross-emulator replay may desync. Mesen and BizHawk can differ on power-on RAM contents and timing, so their RAM hash is not expected to match. A desync is itself a finding about emulator equivalence.)*

### Decision (2026-10-01): build it as layered projects, Zelda first as the oracle
> **Chris:** *"This harness can be shared with at least all NES games, and parts of it might work with any Mesen game, so we seem to have a similar split as KOEI/NES. So probably this will be multiple projects. Let's see if we can port this to Zelda first so we have an oracle :) Then we can try Mappy as a test bed (we discovered it already has a move list to run the attract mode), and then we can move on to the strategy games. This will also hide a layer for now, but the idea will be to keep it modular, so when we do need to plug in KOEI, it isn't a complete restructure."*

**Layering** (the same dependency shape as `snes-decompiler` → `koei-snes` → title repos):
1. **Mesen-generic core** (any console Mesen runs): `bridge.lua` socket server, lockstep, save/load via an exec hook, RAM read/hash; the Python client and its input recorder; `--testRunner` scouts.
2. **NES layer:** the controller button map, battery-save wiping for replay, the NMI vector as the per-frame exec hook (read from the ROM).
3. **Game adapters:** Zelda (oracle), Mappy (real-time test bed), then a KOEI adapter. That adapter is the layer "hidden for now," so the core must not assume anything game-specific.

**Order and why:**
1. **Zelda = the oracle.** The AIBeatsZelda run's `runs/run6/inputs.txt` is plain text, one line per frame from power-on (136,526 frames; header `valid_from_poweron=True`), and the run ends in a known state (`VERIFICATION.txt`: Level 9 room 32, 8.5/13 hearts, 29 rupees, Magical Sword). If our harness replays it to that ending, input injection and lockstep are proven. A cross-emulator desync is the expected failure to understand, not a bug to hide. Note: `VERIFICATION.txt` reports **23,406 lag frames** (frames where the game never polls the pad), so input must be applied **per emulated frame**, not per poll, to line up with a BizHawk movie. Needs Chris's own ROM dump: *Legend of Zelda, The (USA) (Rev 1)*. The repo has no license file, so its log is a **local test input only**, never vendored.
2. **Mappy = the test bed:** a real-time game whose attract mode already carries a move list.
3. **The strategy games:** the KOEI adapter, the survey sweep, and the Mesen-vs-Python-VM behavioral oracle.

### Decision 2 (2026-10-02): one repo, emulators and machines as plug-ins (supersedes the repo split above)
The first build replayed run 6 in Mesen but needed **BizHawk as a second emulator**: for the drift test, BizHawk was the more faithful reference (the run was recorded in it) and it ran faster, which matters for search. *(This revises "no second emulator is needed" in the toolset section above.)* A second emulator broke the layering's premise: Decision 1 stacked the emulator at the bottom (`mesen-harness` → `nes-harness` → adapters), but the NES layer is true on any emulator and a game adapter needs the machine, not the emulator. Emulator and machine are **orthogonal axes**, and a repo per cell multiplies.
> **Chris:** *"I think 1 is good too.. for instance mesen can support SNES and other machines, and I am not sure Bizhawk can.. so the combinitorics you mention will probably need some configuration glue anyway.. so let's merge and clean up, and make sure we keep good directory habits too."*

**Result:** [emu-harness](../../projects/game-annotation/emu-harness/README.md), with `backends/{mesen,bizhawk}` × `machines/nes`. Game adapters still live in each game's repo. The SDK's "factor out a shared lib when a second consumer needs it" rule cuts the same way: the only outside consumers are the adapters, so the parts inside are plugins, not packages. Modularity is held by import rules and a shared replay test, not by repo walls. A second lesson from the same session: the agent judged runs by whether the emulator window was visible, so minimizing it caused retry loops and, eventually, a desktop screen capture that work security flagged. Now a run reports itself (exit code plus output file), and screen capture is blocked by a hook.

### Replay result (2026-10-02): BizHawk is bit-exact; Mesen is frame-exact for 42%, then one RNG step apart
Checked against the run's own `VERIFICATION.txt` (final RAM SHA-1 `3115e31f…668ff`), using the per-frame 2 KB RAM traces in `emu-harness`:
- **BizHawk 2.11.1 / quickerNES replaying the `.bk2`: exact.** The last trace record's RAM SHA-1 equals the recorded one, all 2,048 bytes. This is a confirmed per-frame reference for the whole run.
- **Mesen replaying `inputs.txt` (`--offset -1`): all 2,048 bytes identical to BizHawk on every frame through record 57,317** (about 42% of the run, Level 8 room 63). The only earlier differences are zero-page temporaries and the stack, which resync within 1–3 frames. At **57,318** two bytes split first (`$0FF` bit 7, `$328`). On the next frame the block at `$018–$024` differs by what looks like **one extra shift** (e.g. `16/2c`, `1a/34`). That fits Zelda's RNG advancing once more in one emulator, i.e. a one-frame timing or lag difference at that moment. Lag flags then disagree on 12.5k frames, and Link dies about 600 frames later.
- **So "more accurate" here means "the emulator that recorded the movie."** quickerNES is the core the bot ran. Whether Mesen or quickerNES is closer to real hardware at frame 57,318 is open (see below). For replaying another emulator's movie, bit-exactness to the *recording* emulator is the criterion that matters.
- Unverified readings, still to check against the disassembly: `$0FF` as the PPUCTRL shadow (bit 7 = NMI enable) and `$018–$024` as the RNG.

### Direction (2026-10-02): a search-based TAS generator, Mappy first
**Run 6 is a replay, not the AI.** The `.bk2` and `inputs.txt` are the *output*. The AI is the release's `zelda/` package plus `fullgame.py` (about 7,300 lines, *"the player the AI wrote for itself"*) and its `knowledge/` files. It plays **341 segments**, each a randomly seeded input search across six BizHawk instances, keeping the best success. So the player is itself a **TAS generator**, and runs are not reproducible by design (README: *"expect a time near 37 minutes, not exactly this one"*). The repo has no license, so its code, like its log, is local-only: anything in `emu-harness` is our own.

**Decision:** put the general search loop in `emu-harness` (from a savestate: N variants → score → keep best → record → checkpoint) and the per-game parts in an adapter in the game's repo (RAM map, segment boundaries, success, objective). First target: **Mappy, in Mesen** (headless).
> **Chris:** *"It has been shown that Mappy repeats after a given number of levels, so I think a high score bot is "free" if we can get it to play without dying, and "most rounds" should be infinite. I think the speedruns are based on time to level X, so this would be it's goal. but maybe we start, as you say, jsut trying to replicate attract mode in a real game. Mesen is probably best for this as it is headless."*

**Step 1, the adapter's oracle:** feed Mappy's own attract-mode script into a *real* game and see if it clears the stage. The script (`$FFE1`) was decoded from `$D9C7` and **verified** against a headless Mesen attract run: 22 commands, frame-exact (details in `game-annotation` Mappy chapter 6). Open before running it:
- Which pad button produces the door action in real play: the real path writes `$22` to `$040E`, the demo path pulses it with `inc`. Read `read_and_decode_input` (`$C258`).
- Which frame after Start lines up with the demo's first command.
- Whether the cats' behavior (and any RNG) matches the demo's, or the script dies once real play diverges. That divergence would be the first finding.

**Step 1 result (2026-10-02): remote control works.** `game-annotation`'s `mappy/demo_in_real_game.py` presses Start in headless Mesen, then plays the 25-byte script through the pad from the frame after the player goes live. Player x, y, movement and state match attract on every one of the demo's 1,259 frames, and the cats match too. The open items above resolved:
- **Door action:** an A (or B) press for one frame. Real play copies the "A or B pressed" history `$22` into `$040E`.
- **Alignment:** script byte 0 lines up with the frame after the player goes live.
- **The demo is not a stage clear.** It ends when a cat catches Mappy (state `$08`, `$4B`=1) with 5 of 10 items left. In the real game this costs a life. That corrects a static-read claim in ch6.

So the attract script is a frame-exact *seed*, not a solution: surviving round 1 is the search loop's first job.

## Vault Connections
- **The build:** [emu-harness](../../projects/game-annotation/emu-harness/README.md): backends (Mesen 2, BizHawk) × machines (NES); began 2026-10-01 as `mesen-harness` + `nes-harness`, merged 2026-10-02 (Decision 2)
- [Oracles Are Objective Functions](../oracles-as-objective-functions.md) — the scoring loopholes (walked out and called the room "cleared"; never attacked) are the *wrong objective* box
- [Slay — Evaluation](./slay-evaluation.md) — eval beats depth
- [Contract vs. Substrate](../contract-vs-substrate.md) — the knowledge files and decoded tables as substrate; the replay hash as the adopted floor
- [Jevons for Software §4a](../economics/jevons-software-demand.md) — the human gating criteria
- [LLM Agents Across Games](./llm-agents-across-games.md) — LLMs *playing* fail on mechanics; here the LLM *builds* the player and never plays
- [Pluto on the Brood War Ladder](./pluto-broodwar-apm-over-strategy.md) — another machine player in a real-time game
- [Variance Is Not Luck](../economics/variance-is-not-luck.md) — "a run is one draw"

## Open Questions
- ~~**Mappy's demo script in a real game:** does the 22-command attract track clear round 1 when fed through the pad?~~ **Resolved 2026-10-02:** it replays frame-exact, but neither run clears the stage: the demo ends when a cat catches Mappy (see Step 1 result above).
- **Frame 57,318:** what makes Mesen and quickerNES disagree there (an NMI-enable edge, `$0FF` bit 7)? Which one matches real hardware? Can a Mesen setting close it, or do search loops have to stay on one emulator?
- **Verify screen scrolling against the disassembly:** find the scroll routine's input read and the missing position check. Could the bot's harness have discovered it by search, given a rule set that allowed it?
- **Specimens not yet filed:** eval-beats-depth (→ [Slay](./slay-evaluation.md)), search-hides-bugs (→ [Oracles](../oracles-as-objective-functions.md)), the cyborg split (→ [Cyborg Model](../cyborg-model.md)).
- **A bot on our decompiled source** (seed 1): NA1's sim plus the capture-test survey, or a Mappy lookahead harness as a behavioral oracle?

## Tags
[game-ai](../../tags/game-ai.md) · [agents](../../tags/agents.md) · [reverse-engineering](../../tags/reverse-engineering.md) · [nes](../../tags/nes.md) · [methodology](../../tags/methodology.md)

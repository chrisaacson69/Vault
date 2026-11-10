# Handoff — NA1 setup RNG deep dive (2026-11-10)

## Goal
Find out how predictable NA1's "setup" random draws really are and how far they can be abused, and bring the sim's RNG to match whatever turns out to be true.

## First: which setup? (ask Chris before digging)
Chris said "the setup RNG seems much less predictable than it first appeared." That came right after the battle-deployment findings, so it may mean either:
- **(a) The battle setup:** deployment dice. #42 called these "the setup's dice decide most of it".
- **(b) The game setup:** `apply_scenario_starting_stat_boosts` $83E2, which rolls the coin-doubled fiefs, the headers and stat caps, the exchange rate, and the AI's `init_daimyo_arms_record`.

Both may be in scope. Ask which first; don't guess.

## Read first (pointers)
- **`na1-decompiler/docs/synthesis-frontier.md`:**
  - **#43** (today): the battle harness, the corrected 20×5 unit split, the doctrine, and Assign.
  - **#42:** deployment from the ROM.
  - **#41:** "Saito is decided at T1".
  - **#36:** Echigo's ring, the coin-doubled neighbours.
- **Commits** (all on `main`, pushed): `7ea0a83`, `e281470`, `174cdf3`, `c525554`.
- **Memory `project_nobunaga_tas_idea`** (vault memory dir): **the real RNG is frame-driven**. `syscall_rng_next` (task 17, $C1C3) is a 48-bit shift-and-add over the wall-clock state at $0083–$0088. The NMI adds 2 each frame, the reset seed is $04D2, and input timing selects the rolls. That memory also has an ordered plan: model the real RNG and confirm it on one Mesen trace first.
- **The sim's RNGs (verify, they may disagree):**
  - `tools/na1sim/memmap.py` `Memory.rng`: Python `random.Random`, a stand-in, drives all in-game and battle `rng_mod`.
  - `tools/na1sim/setup.py` `_run_boost`: runs $83E2 in the na1dream VM with `vm.rom_rng`. Its docstring claims "the ROM's own generator", while the memory says na1dream is a stand-in LCG seeded 0x1234. Check which one is current.
  - `tools/na1sim/oracle_vm.py` `DreamRNG`: an exact copy of na1dream's LCG.
- **Battle-deployment draws, in order:**
  - `rng_mod(4)` in `battle_init_driver`.
  - The defender's random drops (2 draws per unit, y before x).
  - The attacker's `flip_x` and `flip_y` (one forced by the approach edge).
  - The attacker's random drops.
  - All in `tools/na1sim/tactical.py` (`run_tactical_battle`, `ai_place_combat_units_random_or_smart`, `rng_search_combat_rect_for_unit_cell`).
- **SRAM dumps:** `traces/*.dmp`, each 8 KB of $6000–$7FFF. They were the ground truth that caught the split bug.

## Current state (built today, all committed)
- **`na1sim.battles`:** captures every human-defended battle start as a pickle of (Memory, game rng), then replays and verifies it.
  - The Saito capture is `tools/_battles/f8-k1-y3-expand-s3000x300.pkl.gz` (gitignored; regenerate with `py -3.14 -m na1sim.battles capture`). It holds 357 battles, and 357 of 357 replay bit for bit.
  - Records are self-contained, so a battle generator ("headless battles") can produce them without a game.
- **`na1sim.strike`:** the human combat player (arms: control, single, contact, pocket, lead).
  - `--split` applies an Assign at battle start.
  - `strike.Doctrine` is wired into whole games via `deaths.py --combat doctrine`. It is smoke-tested only; Chris said no reruns were needed.
- **Fixed today:**
  - The scenario's unit split is 20×5, not 50/5/5/5/5.
  - The conquest path now applies the musket cap.
  - Assign exists in the sim (`vmprims.driver_assign`).
  - `oracle_vm`: 20 of 20 routines match.
- **Results** (Saito's 299 invasions held; the AI defender holds 18):
  - Even 20×5 with the doctrine: 53.
  - 60/10/10/10/10: 76.
  - 96/1/1/1/1 with one striker: 96.
  - **100/0/0/0/0, the commander alone in the castle: 91** (every arm is identical).
  - Decapitation pays up to about 2:1 in men and is gone past 3:1.
- **Deployment predictability (measured):**
  - An eastern attacker always lands by random drop.
  - North, South, and West commanders land on one of two corner cells.
  - Details in #43.

## Open questions (Chris)
1. Battle setup, game setup, or both (see above)?
2. **What "abuse" means here:** sim-side (choose the seeds or boards that favour a start), or ROM-side (frame-timed inputs, the TAS direction)? ROM-side needs `syscall_rng_next` modelled exactly first.
3. **Chris's parameter ideas** (not built):
   - **The AI's unit split as a measurable doctrine signal**, like days of food. The AI reshapes unstrategically, but the shape could set the battle plan.
   - **A player split parameter.** On turn 1 it's always the even 20×5.
4. **Still parked:** a policy that spends the Assign (when, and what split), and Bribe.

## Where to start
1. Ask open questions 1–2.
2. Inventory the generators: confirm which RNG each sim path uses (`Memory.rng`, `setup._run_boost`'s `vm.rom_rng`, `DreamRNG`) against the ROM's `syscall_rng_next` $C1C3. A failed or empty tool result is not data.
3. **For the game setup:** measure the spread of what $83E2 rolls across seeds; the coin-doubled set alone is worth tabulating. **For the battle setup:** use the harness. Replay each saved start under reseeded `m.rng` to measure how much of the outcome the deployment dice decide.

## Skills to invoke
- `/grill-me` once the scope is clear, if the abuse model (sim vs ROM) needs pinning down.
- `/handoff` at the end. Push `na1-decompiler`, and log to the vault if significant.

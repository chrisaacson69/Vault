# CivRev — data

Structured game data for the [tools](../tools/README.md) to consume. **Nothing built here yet** — this
folder is scaffolding.

## Source of truth
The raw Tier-1 captures live in the vault's `raw/` (NOT here), per the ingestion workflow and the
raw-immutability rule:
- [`raw/civrev-civilopedia-tables.md`](../../../../raw/civrev-civilopedia-tables.md) — techs (cost / prereq / unlocks / first-discover bonus), wonders, units (A/D/M), buildings, civilizations (start + 4 age bonuses + UUs)
- [`raw/civrev-civilopedia-great-people-relics.md`](../../../../raw/civrev-civilopedia-great-people-relics.md) — 6 Great-People types (immediate + settle effects), 6 relics
- [`raw/civrev-terrain.md`](../../../../raw/civrev-terrain.md) — terrain yields/defense + the food-XOR-production-XOR-trade rule
- [`raw/civrev-combat-and-mechanics.md`](../../../../raw/civrev-combat-and-mechanics.md) — combat modifier structure, victory conditions
- [`raw/civrev-resources.md`](../../../../raw/civrev-resources.md) — resource→tech unlock map (bonus magnitudes mostly unconfirmed)

## Planned (when tools need it)
- `techs.json`, `wonders.json`, `units.json`, `buildings.json`, `civs.json`, `great-people.json`,
  `terrain.json`, `resources.json` — structured from the captures above, with a `confidence` field per
  value (confirmed-from-table vs inferred vs measured).
- Keep provenance: every value cites its `raw/` source so the data stays grounded, not re-keyed by hand.

## Caveats
All current data is **Tier-1 community** (CivFanatics/StrategyWiki/Fandom), treated as *base* values; the
live game may scale costs by era/difficulty. Hidden formulas (city growth, governments, combat win-%) are
gaps **parked** pending a usable measurement oracle (not CivRev2 — a reskin with a too-weak tablet UI;
a handheld ROM is the better-but-deferred path) — see the [project README](../README.md).

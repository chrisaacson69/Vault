# Civilization Revolution (original) — Combat & core mechanics (raw capture)

**Game:** Sid Meier's Civilization Revolution (2008), the ORIGINAL.
**Sources (Tier-1, community):** CivFanatics CivRev Info Center + Fandom/StrategyWiki, via WebSearch
summary on 2026-06-22 (GameFAQs HeroicHylian guide and StrategyWiki return 403 to direct fetch).
The MODIFIER STRUCTURE below is well-attested; the exact per-round win-probability is NOT documented
(it's the hidden part → measure on live CivRev2, with the caveat that CivRev2 may differ).
**Provenance:**
- https://civfanatics.com/civrev/infocenter/
- https://civilization.fandom.com/wiki/Combat
- https://gamefaqs.gamespot.com/boards/941684-sid-meiers-civilization-revolution/51991192 (Battle Odds thread)

---

## Combat — modifier structure (grounded)
- Each side's strength = **base Attack (attacker) vs base Defense (defender)**, then modified.
- **Veteran/Elite:** a non-veteran upgraded to **Veteran = +50% combat**; a Veteran upgraded to
  **Elite = +1 Special Ability**. (Barracks/Great Leader produce Veterans directly.)
- **Stacking rule:** all **percentage** bonuses are **summed first, then applied** to the base; then
  **absolute** bonuses are added after. (So veteran +50%, terrain +50%, fortify +50%, walls +100%
  add into one percentage multiplier.)
- **Fortify:** ordering Defend = **+50% defense**; left defending → **Heavily Fortified = +100%**.
- **Terrain defense:** Forest +50%, Hills +50% (Hills ALSO grant an *offensive* bonus); Walls +100%.
- **Auto-resolve shortcut:** battles at **7:1 odds or greater are automatically won**.
- Combat shows **odds before the attack** (Oracle of Delphi wonder reveals the actual result early).
- Resolution is a hitpoints + "strikes"/rounds system (exact round math undocumented).

## Victory conditions (4)
- **Domination** (military — control/capitalize; Palace required), **Technology/Space Race**
  (Apollo + spaceship), **Cultural** (United Nations wonder; 20 culture events feed it),
  **Economic** (World Bank wonder; 20,000 gold). Exact thresholds undocumented here.

## Empire management (from Info Center, not yet extracted in detail)
- City citizens are assigned as **Laborers (food) / Vendors (gold) / Traders (trade-science?) / etc.**
  — the worker-allocation model; exact yields not captured.
- **Governments** table is embedded in the Info Center (Despotism/Monarchy/Republic/Democracy/
  Communism/Fundamentalism) — effects not yet extracted.
- **Four Ages** with per-civ Age bonuses (see civ table); the advancement *trigger* is undocumented here.

## STILL HIDDEN — measure on live CivRev2 (Tier-2) or find a deeper guide
1. Exact combat win-probability for close (sub-7:1) fights — the round/hitpoint resolution.
2. City yield math: food→growth thresholds; how "trade" splits into science vs gold; production rules.
3. Governments: exact numeric effects.
4. Age-advancement trigger; city-count/population MILESTONE bonus thresholds.
5. Victory thresholds (culture-event count, domination %).

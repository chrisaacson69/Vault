# Civilization Revolution (original) — Civilopedia tables (raw capture)

**Game:** Sid Meier's Civilization Revolution (2008; Xbox 360 / PS3 / DS / iOS). This is the
ORIGINAL CivRev, not CivRev2.
**Source:** CivFanatics CivRev civilopedia — Tier-1 community data, NOT binary-extracted.
Treat costs as *base* values; the live game likely scales research cost by era/difficulty
(the source itself notes era data is incomplete and the tech page is "under construction").
Verify magnitudes against a live oracle (Chris's CivRev2, with the caveat that CivRev2 is a
different game) before trusting exact numbers.
**Fetched:** 2026-06-22 via WebFetch.
**Provenance URLs:**
- https://civfanatics.com/civrev/civilopedia/technologies/
- https://civfanatics.com/civrev/civilopedia/wonders/
- https://civfanatics.com/civrev/civilopedia/units/
- https://civfanatics.com/civrev/civilopedia/buildings/
- https://civfanatics.com/civrev/civilopedia/civilizations/
**Still missing (fetch slugs returned wrong-game content):** governments, terrain.

---

## Technologies
Cost = beakers. "First bonus" = reward to the FIRST civ to research it.

| Technology | Cost | Prerequisites | Makes Available | First-to-Discover Bonus |
|---|---|---|---|---|
| Alphabet | 20 | none | Oracle of Delphi, Library | none |
| Bronze Working | 20 | none | Fish, Colossus, Archer, Barracks | none |
| Horseback Riding | 20 | none | Oxen, Horseman | none |
| Pottery | 20 | none | Wine, Hanging Gardens, Granary | none |
| Ceremonial Burial | 30 | Pottery | Incense, Pyramids, Temple | none |
| Iron Working | 30 | Bronze Working | Iron, Legion | Free Legion |
| Masonry | 30 | Pottery | Marble, Great Wall, Walls | Free Wall |
| Writing | 40 | Alphabet | Great Library, Spy | Free Spy |
| Code of Laws | 60 | Writing, Alphabet | Cattle, Trading Post, Republic | Free Trading Post |
| Construction | 60 | Masonry, Iron Working | Oak, Workshop | Free Workshop |
| Irrigation | 60 | Pottery, Masonry | Wheat, +1 Food on river tiles | +1 population in every city |
| Literacy | 60 | Alphabet, Writing | Silk, Shakespeare's Theatre, Courthouse | +1 science in every city |
| Mathematics | 70 | Writing, Masonry | Catapult | Free Catapult |
| Currency | 80 | Bronze Working, Code of Laws | Gold, Trade Fair, Caravan, Market | Free Caravan, Market |
| Navigation | 110 | Writing, Mathematics | Whale, East India Company, Galleon, Harbor | Free Galleon |
| Democracy | 120 | Literacy, Code of Laws | Magna Carta, Pikeman, Democracy | Free Pikeman |
| Monarchy | 120 | Code of Laws, Writing, Ceremonial Burial | Dye, Himeji Castle, Monarchy | Free Great Person |
| Engineering | 130 | Construction, Mathematics | Aqueduct | +1 production in every city |
| Feudalism | 140 | Horseback Riding, Monarchy | Game, Knight | Free Knight |
| Religion | 150 | Ceremonial Burial, Monarchy | Cathedral, Fundamentalism | +1 culture in every city |
| Banking | 190 | Currency, Code of Laws, Literacy | Bank | 100 gold |
| Invention | 190 | Literacy, Engineering | Leonardo's Workshop | Free Great Person |
| University | 240 | Literacy, Mathematics, Democracy | Oxford University, University | +1 science in every city |
| Gunpowder | 330 | Invention, Feudalism | Sulfur, Rifleman | Free Rifleman |
| Steam Power | 340 | Iron Working, Invention, Engineering | Coal, Cruiser | Free Cruiser |
| Railroad | 350 | Steam Power | Iron Mine | +2 production in every city |
| Metallurgy | 390 | Engineering, Iron Working, University | Cannon | Free Cannon |
| Printing Press | 390 | University, Religion | none | +1 culture in every city |
| Industrialization | 710 | Steam Power, Banking | Factory | +5 gold in every city |
| The Corporation | 720 | Banking, Industrialization | Military-Industrial Complex | +5 gold in every city |
| Steel | 730 | Metallurgy, Steam Power | Battleship | Free Battleship |
| Communism | 770 | Industrialization, University | Communism | -33% factory cost |
| Electricity | 850 | Metallurgy, Engineering, Steam Power | Submarine | Free Submarine |
| Mass Media | 880 | Printing Press, The Corporation | Hollywood | +1 population in every city |
| Mass Production | 880 | Railroad, Industrialization | Modern Infantry, Aluminum | Free Modern Infantry |
| Combustion | 1050 | Steam Power, Gunpowder, Metallurgy | Oil, Tank | Free Tank |
| Atomic Theory | 1270 | University, Invention, Electricity | Manhattan Project | +2 science in every city |
| Electronics | 1570 | Electricity, The Corporation | none | +2 trade in every city |
| Flight | 1620 | Combustion, Metallurgy, Invention | Fighters | Free Fighter |
| The Automobile | 1780 | Combustion, Steel | Rubber, Artillery | Free Artillery |
| Advanced Flight | 2150 | Flight, Industrialization | Bomber | Free Bomber |
| Nuclear Power | 2150 | Atomic Theory, Mass Production | Uranium | +2 production in every city |
| Networking | 2290 | Electronics, The Corporation | Internet | Reduced University Cost |
| Globalization | 3400 | Mass Media, Networking | none | 500 gold |
| Space Flight | 5860 | Advanced Flight, Electronics, Nuclear Power | Apollo Program, SS components | Entire map revealed |
| Superconductor | 6740 | Mass Production, Space Flight | SDI Defense | Free SDI in a city |

## Wonders
Cost = production. Obsolete-by = the tech that disables the wonder.

| Wonder | Era | Prereq Tech | Cost | Effect | Obsolete By |
|---|---|---|---|---|---|
| Stonehenge | Ancient | none | 50 | Temple effects +50% | Literacy |
| Hanging Gardens of Babylon | Ancient | Pottery | 100 | +50% population in the city | Never |
| Colossus of Rhodes | Ancient | Bronze Working | 100 | Doubles Trade production in the city | Invention |
| Oracle of Delphi | Ancient | Alphabet | 125 | See battle results before the battle | Religion |
| Great Library of Alexandria | Ancient | Writing | 150 | Receive any tech ≥2 other civs discovered | University |
| Great Pyramid | Ancient | Ceremonial Burial | 150 | Access to all forms of government | Monarchy |
| Great Wall | Ancient | Masonry | 150 | Forces all civs to make peace with owner | Engineering |
| Shakespeare's Theatre | Medieval | Literacy | 150 | Doubles Culture production in the city | Mass Media |
| Himeji Samurai Castle | Medieval | Monarchy | 150 | +1 Attack strength to all units | Communism |
| Magna Carta | Medieval | Democracy | 150 | Courthouses produce culture | Never |
| Oxford University | Medieval | University | 150 | Acquire an advanced technology | Never |
| East India Company | Medieval | Navigation | 200 | +1 Trade in all sea squares (civ-wide) | Flight |
| Leonardo's Workshop | Medieval | Invention | 200 | Upgrade all units to current best in lineage | Never |
| Trade Fair of Troyes | Medieval | Currency | 250 | Doubles Gold production in the city | Globalization |
| Military-Industrial Complex | Modern | The Corporation | 500 | Reduces cost of all units | Never |
| United Nations | Modern | 20 cultural events | 500 | Enables Cultural Victory | Never |
| World Bank | Modern | 20,000 gold | 500 | Enables Economic Victory | Never |
| Hollywood | Modern | Mass Media | 600 | Enemy walls no longer stop city-flipping | Never |
| Apollo Program | Modern | Space Flight | 750 | Access to all un-researched technologies | Never |
| Internet | Modern | Networking | 750 | Gold production in all cities doubled | Never |
| Manhattan Project | Modern | Atomic Theory | 750 | Obtain the only ICBM in the game | Never |

## Units
A/D/M = Attack / Defense / Movement.

| Unit | Tech | Cost | A | D | M | Upgrades To | Notes |
|---|---|---|---|---|---|---|---|
| Warrior | none | 10 | 1 | 1 | 1 | Legion | |
| Legion | Iron Working | 10 | 2 | 1 | 1 | Knight | |
| Horseman | Horseback Riding | 20 | 2 | 1 | 2 | Knight | |
| Knight | Feudalism | 25 | 4 | 2 | 2 | Tank | |
| Tank | Combustion | 50 | 10 | 6 | 3 | none | |
| Archer | Bronze Working | 10 | 1 | 2 | 1 | Pikeman | |
| Pikeman | Democracy | 15 | 1 | 3 | 1 | Rifleman | |
| Rifleman | Gunpowder | 20 | 3 | 5 | 1 | Modern Infantry | |
| Modern Infantry | Mass Production | 30 | 4 | 8 | 1 | none | |
| Catapult | Mathematics | 20 | 4 | 1 | 1 | Cannon | |
| Cannon | Metallurgy | 30 | 6 | 2 | 1 | Artillery | |
| Artillery | The Automobile | 50 | 16 | 2 | 2 | none | |
| Galley | none | 30 | 1 | 1 | 2 | Galleon | |
| Galleon | Navigation | 30 | 2 | 2 | 3 | Cruiser | |
| Cruiser | Steam Power | 40 | 6 | 6 | 5 | none | |
| Battleship | Steel | 80 | 12 | 18 | 4 | none | |
| Submarine | Electricity | 25 | 12 | 2 | 2 | none | |
| Fighter | Flight | 30 | 6 | 4 | 8 | none | |
| Bomber | Advanced Flight | 60 | 18 | 3 | 6 | none | Must land in city every 4 moves |
| Settler | none | 20 | 0 | 0 | 2 | none | founds cities |
| Caravan | Currency | 30 | 0 | 0 | 3 | none | |
| Spy | Writing | 25 | 0 | 0 | 2 | none | |
| Great People | none | none | 0 | 0 | 2 | none | |
| ICBM | none | 40 | — | — | — | none | from Manhattan Project |
| Militia | none | none | 0 | 1 | 1 | none | emergency defender |

## Buildings
Cost = production. (Source lists no maintenance/upkeep.)

| Building | Tech | Cost | Effect |
|---|---|---|---|
| Warrior/Militia (n/a) | | | |
| Granary | Pottery | 40 | Plains tiles give +2 food |
| Temple | Ceremonial Burial | 40 | +1 culture per citizen |
| Barracks | Bronze Working | 40 | New units are Veterans (+3 exp) |
| Library | Alphabet | 40 | Doubles city science production |
| Market | Currency | 60 | Doubles city gold production |
| Trading Post | Code of Laws | 60 | +2 trade from desert tiles |
| Workshop | Construction | 60 | +2 production from hills |
| Courthouse | Literacy | 80 | Increases workable tile region |
| Iron Mine | Railroad | 80 | Mountain tiles give +4 production |
| Harbor | Navigation | 100 | +1 food in sea tiles |
| Walls | Masonry | 100 | +100% defense; prevents culture-flipping |
| Aqueduct | Engineering | 120 | City growth +50% |
| Bank | Banking | 120 | Replaces Market; x4 gold production |
| University | University | 160 | Replaces Library; x4 science production |
| Cathedral | Religion | 160 | Replaces Temple; +2 culture per citizen |
| Factory | Industrialization | 200 | Doubles city production |
| SDI | Superconductor | 200 | Stops ICBMs aimed at city |
| Palace | — | — | Required for Domination victory; provides culture |

## Civilizations
Each civ has a unique starting bonus + four age bonuses (Ancient → Medieval → Industrial → Modern).

| Civ | Leader | Starting Bonus | Ancient | Medieval | Industrial | Modern | Unique Units |
|---|---|---|---|---|---|---|---|
| America | Lincoln | Begin with a Great Person | 2% gold interest | half-price unit rushing | +1 food from plains | 3x factory production | Sherman Tank, Flying Fortress, Mustang Fighter |
| Arabia | Saladin | Begin with Religion | +50% caravan gold | free Mathematics | +1 attack Horsemen/Knights | 2% gold interest | — |
| Aztec | Montezuma | Begin with a wealth of gold | units heal after combat | +3 science from temples | half-price roads | +50% gold production | Jaguar Warrior |
| China | Mao | Begin with Writing | +1 pop in new cities | free Literacy | half-price libraries | no Anarchy effects | — |
| England | Elizabeth | Begin with Monarchy | +1 Longbow defense | +1 naval combat | +1 hammer on hills | doubled naval support | Longbow Archer, Lancaster Bomber, Spitfire Fighter |
| Egypt | Cleopatra | Begin with a Wonder | +1 food/trade from deserts | free Irrigation | +1 Rifleman movement | +50% caravan gold | — |
| France | Napoleon | Begin with a Cathedral | free Pottery | half-price roads | +2 cannon attack | +1 Rifleman movement | Trebuchet, Howitzer |
| Germany | Bismarck | Auto-upgrades for Elite units | Warriors begin as Veterans | +1 forest production | half-price barracks | 2% gold interest | Panzer Tank, 85mm Gun, Heinkel Bomber, ME109 Fighter |
| Greece | Alexander | Begin with a Courthouse | knowledge of Democracy | more Great People | half-price library | +1 food from sea tiles | Trireme, Hoplite |
| India | Gandhi | Begin with access to all resources | no Anarchy effects | free Religion | half-price Settlers | half-price Courthouse | — |
| Japan | Tokugawa | Begin with Ceremonial Burial | +1 food from sea regions | +1 Samurai Knight attack | no Anarchy | Loyalty upgrade for defensive units | Samurai Knight, Ashigaru Pikemen, Val Bomber, Zero Fighter |
| Mongolia | Genghis Khan | +50% trade from captured cities | Barbarian villages join | +1 Cavalry movement | +2 food from mountains | free Communism | Keshik |
| Rome | Julius Caesar | Begin with Code of Laws + Republic | half-price roads | half-price wonders | more Great People | +1 pop in new cities | Cataphract |
| Russia | Catherine | Begin with more map visible | +1 food from plains | Loyalty upgrade for defensive units | half-price Riflemen | half-price Spies | Cossack Horseman, T34 Tank |
| Spain | Isabella | Begin with Navigation | doubled exploration cash | +1 naval combat | +50% gold production | +1 hill production | Conquistador |
| Zulu | Shaka | Overrun enemies more easily | +1 Warrior movement | faster city growth | +50% gold production | half-price Riflemen | Impi Warrior |

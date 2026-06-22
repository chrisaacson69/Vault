"""
civrev_data.py -- the shared GROUNDED data for the CivRev tools (single source of truth).
All values verbatim from raw/civrev-civilopedia-tables.md (Tier-1 community capture);
treat costs as base values (the live game may scale by era/difficulty). Tools import from
here so the grounded tables aren't re-keyed per tool.
"""

# (name, beaker cost, [prerequisite techs], first-discover bonus)
TECHS = [
    ("Alphabet", 20, [], "none"),
    ("Bronze Working", 20, [], "none"),
    ("Horseback Riding", 20, [], "none"),
    ("Pottery", 20, [], "none"),
    ("Ceremonial Burial", 30, ["Pottery"], "none"),
    ("Iron Working", 30, ["Bronze Working"], "Free Legion"),
    ("Masonry", 30, ["Pottery"], "Free Walls"),
    ("Writing", 40, ["Alphabet"], "Free Spy"),
    ("Code of Laws", 60, ["Writing", "Alphabet"], "Free Trading Post"),
    ("Construction", 60, ["Masonry", "Iron Working"], "Free Workshop"),
    ("Irrigation", 60, ["Pottery", "Masonry"], "+1 population in every city"),
    ("Literacy", 60, ["Alphabet", "Writing"], "+1 science in every city"),
    ("Mathematics", 70, ["Writing", "Masonry"], "Free Catapult"),
    ("Currency", 80, ["Bronze Working", "Code of Laws"], "Free Caravan, Market"),
    ("Navigation", 110, ["Writing", "Mathematics"], "Free Galley"),
    ("Democracy", 120, ["Literacy", "Code of Laws"], "Free Pikeman"),
    ("Monarchy", 120, ["Code of Laws", "Writing", "Ceremonial Burial"], "Free Great Person"),
    ("Engineering", 130, ["Construction", "Mathematics"], "+1 production in every city"),
    ("Feudalism", 140, ["Horseback Riding", "Monarchy"], "Free Knight"),
    ("Religion", 150, ["Ceremonial Burial", "Monarchy"], "+1 culture in every city"),
    ("Banking", 190, ["Currency", "Code of Laws", "Literacy"], "100 gold"),
    ("Invention", 190, ["Literacy", "Engineering"], "Free Great Person"),
    ("University", 240, ["Literacy", "Mathematics", "Democracy"], "+1 science in every city"),
    ("Gunpowder", 330, ["Invention", "Feudalism"], "Free Rifleman"),
    ("Steam Power", 340, ["Iron Working", "Invention", "Engineering"], "Free Cruiser"),
    ("Railroad", 350, ["Steam Power"], "+2 production in every city"),
    ("Metallurgy", 390, ["Engineering", "Iron Working", "University"], "Free Cannon"),
    ("Printing Press", 390, ["University", "Religion"], "+1 culture in every city"),
    ("Industrialization", 710, ["Steam Power", "Banking"], "+5 gold in every city"),
    ("The Corporation", 720, ["Banking", "Industrialization"], "+5 gold in every city"),
    ("Steel", 730, ["Metallurgy", "Steam Power"], "Free Battleship"),
    ("Communism", 770, ["Industrialization", "University"], "other"),
    ("Electricity", 850, ["Metallurgy", "Engineering", "Steam Power"], "Free Submarine"),
    ("Mass Media", 880, ["Printing Press", "The Corporation"], "+1 population in every city"),
    ("Mass Production", 880, ["Railroad", "Industrialization"], "Free Modern Infantry"),
    ("Combustion", 1050, ["Steam Power", "Gunpowder", "Metallurgy"], "Free Tank"),
    ("Atomic Theory", 1270, ["University", "Invention", "Electricity"], "+2 science in every city"),
    ("Electronics", 1570, ["Electricity", "The Corporation"], "+2 trade in every city"),
    ("Flight", 1620, ["Combustion", "Metallurgy", "Invention"], "Free Fighter"),
    ("The Automobile", 1780, ["Combustion", "Steel"], "Free Artillery"),
    ("Advanced Flight", 2150, ["Flight", "Industrialization"], "Free Bomber"),
    ("Nuclear Power", 2150, ["Atomic Theory", "Mass Production"], "+2 production in every city"),
    ("Networking", 2290, ["Electronics", "The Corporation"], "other"),
    ("Globalization", 3400, ["Mass Media", "Networking"], "500 gold"),
    ("Space Flight", 5860, ["Advanced Flight", "Electronics", "Nuclear Power"], "Entire map revealed"),
    ("Superconductor", 6740, ["Mass Production", "Space Flight"], "Free SDI"),
]

# (name, unlocking tech, attack, defense, movement, production cost, domain)
# domain groups units that substitute for the same job; "none" = non-combat (skipped in trap analysis)
UNITS = [
    ("Warrior", "none", 1, 1, 1, 10, "land_atk"),
    ("Legion", "Iron Working", 2, 1, 1, 10, "land_atk"),
    ("Horseman", "Horseback Riding", 2, 1, 2, 20, "land_atk"),
    ("Knight", "Feudalism", 4, 2, 2, 25, "land_atk"),
    ("Tank", "Combustion", 10, 6, 3, 50, "land_atk"),
    ("Archer", "Bronze Working", 1, 2, 1, 10, "land_def"),
    ("Pikeman", "Democracy", 1, 3, 1, 15, "land_def"),
    ("Rifleman", "Gunpowder", 3, 5, 1, 20, "land_def"),
    ("Modern Infantry", "Mass Production", 4, 8, 1, 30, "land_def"),
    ("Catapult", "Mathematics", 4, 1, 1, 20, "siege"),
    ("Cannon", "Metallurgy", 6, 2, 1, 30, "siege"),
    ("Artillery", "The Automobile", 16, 2, 2, 50, "siege"),
    ("Galley", "none", 1, 1, 2, 30, "naval"),
    ("Galleon", "Navigation", 2, 2, 3, 30, "naval"),
    ("Cruiser", "Steam Power", 6, 6, 5, 40, "naval"),
    ("Battleship", "Steel", 12, 18, 4, 80, "naval"),
    ("Submarine", "Electricity", 12, 2, 2, 25, "naval"),
    ("Fighter", "Flight", 6, 4, 8, 30, "air"),
    ("Bomber", "Advanced Flight", 18, 3, 6, 60, "air"),
]

# production costs (units + buildings) -- for valuing "Free X" first-discover bonuses
PROD_COST = {u[0]: u[5] for u in UNITS}
PROD_COST.update({
    "Settler": 20, "Caravan": 30, "Spy": 25,
    "Granary": 40, "Temple": 40, "Barracks": 40, "Library": 40, "Market": 60,
    "Trading Post": 60, "Workshop": 60, "Courthouse": 80, "Iron Mine": 80, "Harbor": 100,
    "Walls": 100, "Aqueduct": 120, "Bank": 120, "University": 160, "Cathedral": 160,
    "Factory": 200, "SDI": 200,
})

# --- derived helpers (graph over the tech DAG) ---------------------------------
COST = {n: c for n, c, pre, b in TECHS}
PRE = {n: pre for n, c, pre, b in TECHS}


def ancestors(tech, _memo={}):
    """transitive prerequisite set of `tech`."""
    if tech in _memo:
        return _memo[tech]
    s = set()
    for p in PRE.get(tech, []):
        s.add(p)
        s |= ancestors(p)
    _memo[tech] = s
    return s


def cum_cost(tech):
    """total beakers to unlock `tech` from scratch (own + all unique prereqs)."""
    if tech == "none" or tech not in COST:
        return 0
    return COST[tech] + sum(COST[a] for a in ancestors(tech))


def required_by():
    """tech -> set of techs that DIRECTLY require it (in-edges of the DAG)."""
    rb = {n: set() for n, c, pre, b in TECHS}
    for n, c, pre, b in TECHS:
        for p in pre:
            rb.setdefault(p, set()).add(n)
    return rb


def is_leaf(tech):
    """True if no other tech requires `tech` (a dead-end -- researched only for its own unlocks)."""
    return len(required_by().get(tech, set())) == 0

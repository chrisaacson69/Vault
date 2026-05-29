-- nobunaga_dashboard.lua
-- Live econ/army dashboard for Nobunaga's Ambition (NES)
-- Load in Mesen 2: Debug -> Script Window -> Open

-- ===== CONFIG =====
local SHOW_NEIGHBORS = true
local SHOW_HARVEST_PRED = true
local SHOW_BREAKEVEN = false
local MAX_NEIGHBOR_LINES = 8
local LINE_H = 9              -- line height (font is ~8px)
local PANEL_X = 1
local PANEL_Y = 16            -- start below the game's top status bar (year:season:fief#)
local FG = 0xFFFFFF           -- 24-bit white (Mesen 2 uses 24-bit RGB, NOT 32-bit ARGB —
                              -- 0xFFFFFFFF overflows and renders as inverse/black)
local BG = 0x000000           -- 24-bit black

-- ===== MEMORY ADDRESSES =====
local PROV_TABLE  = 0x7001
local FMAP        = 0x6E15
local TAX_TABLE   = 0x6D2D
local HW_TABLE    = 0x6003
local SELECTED_FIEF = 0x6F5F

local DAIMYO_NAMES = {
    [0]="Hatakeyam", [1]="Asakura", [2]="Asai", [3]="Honganji",
    [4]="Saito", [5]="Sasaki", [6]="Oda", [7]="Tokugawa",
    [8]="Imagawa", [9]="Takeda", [10]="Uesugi", [11]="Hojo",
    [12]="Satake", [13]="Date", [14]="Mogami", [15]="Souma", [16]="Ashina"
}

-- Verified develop/give-family unified template (2026-05-28):
-- gain = M * floor(5*amount / int_sqrt((paired + target)/2 + amount))
--   Grow:    M=2, paired=target=output    → +output, drains loyalty/dams %
--   Build:   M=2, paired=target=town      → +town, drains wealth %
--   Give-Peas-Loy: M=2, paired=output, target=loyalty
--   Give-Peas-Wlt: M=2, paired=town,   target=wealth
--   Give-Men: M=1?, paired=men, target=morale
-- Tax change: stat -= stat * |delta_tax|/100 (loyalty AND wealth), -1 charisma

-- ===== MEMORY HELPERS =====
local function rd8(addr)
    return emu.read(addr, emu.memType.nesMemory)
end
local function rd16(addr)
    return emu.read(addr, emu.memType.nesMemory) + emu.read(addr+1, emu.memType.nesMemory) * 256
end

-- ===== FIEF READER =====
local function readFief(idx)
    local base = PROV_TABLE + idx * 26
    local hwb = HW_TABLE + idx * 8
    return {
        idx     = idx,
        gold    = rd16(base + 0),
        town    = rd16(base + 4),
        rice    = rd16(base + 6),
        output  = rd16(base + 8),
        dams    = rd16(base + 10),
        loyalty = rd16(base + 12),
        wealth  = rd16(base + 14),
        men     = rd16(base + 16),
        morale  = rd16(base + 18),
        skill   = rd16(base + 20),
        arms    = rd16(base + 22),
        header  = rd16(base + 24),
        owner   = rd8(FMAP + idx),
        tax     = rd8(TAX_TABLE + idx),
        om      = rd16(hwb + 0),
        dm      = rd16(hwb + 2),
        lm      = rd16(hwb + 4),
        wm      = rd16(hwb + 6),
    }
end

-- ===== FORMULAS =====
local function pct_op(b, p)
    if b < 0 or p < 0 then return 0 end
    return math.floor(b/10) * math.floor(p/10)
         + math.floor((b % 10) * p / 100)
         + math.floor((p % 10) * math.floor(b/10) / 10)
end

local function predictHarvest(f)
    local loy_contrib  = pct_op(pct_op(f.lm, 40), f.tax)
    local wlth_contrib = pct_op(f.wm, f.tax)
    local town_contrib = pct_op(f.town, f.tax)
    local od_contrib   = pct_op(pct_op(f.om, f.dm), f.tax)
    local rng_max      = pct_op(35, f.tax)
    local men_cost     = math.floor(f.men / 2)
    local gold_base    = loy_contrib + wlth_contrib + town_contrib
    local rice_base    = loy_contrib + wlth_contrib + od_contrib
    return {
        gold_min  = math.max(0, gold_base - men_cost),
        gold_max  = math.max(0, gold_base + rng_max - men_cost),
        rice_min  = math.max(0, rice_base - men_cost),
        rice_max  = math.max(0, rice_base + rng_max - men_cost),
        men_cost  = men_cost,
        rng_max   = rng_max,
    }
end

local function breakEvenTax(f)
    for t = 0, 100 do
        local loy  = pct_op(pct_op(f.lm, 40), t)
        local wlth = pct_op(f.wm, t)
        local town = pct_op(f.town, t)
        local rng  = pct_op(35, t)
        if loy + wlth + town + math.floor(rng/2) >= math.floor(f.men/2) then
            return t
        end
    end
    return 100
end

local function combatPower(f)
    if f.men == 0 then return 0 end
    return math.floor(f.men * (f.skill + f.arms * 10) / 1000)
end

-- ===== DRAW =====
local function line(x, y, text)
    -- omit frame_count: with 1 the text flickers; default behavior is stable
    emu.drawString(x, y, text, FG, BG)
end

local function draw()
    local sel = rd8(SELECTED_FIEF)
    if sel > 16 then sel = 0 end
    local f = readFief(sel)
    local owner_name = DAIMYO_NAMES[f.owner] or ("?"..f.owner)
    local x = PANEL_X
    local y = PANEL_Y

    -- Harvest prediction
    if SHOW_HARVEST_PRED then
        y = y + 2
        local pred = predictHarvest(f)
        line(x, y, "--harvest--"); y = y + LINE_H
        line(x, y, string.format("g:%d-%d", pred.gold_min, pred.gold_max)); y = y + LINE_H
        line(x, y, string.format("r:%d-%d", pred.rice_min, pred.rice_max)); y = y + LINE_H
        line(x, y, string.format("army eats:%d", pred.men_cost)); y = y + LINE_H
        if SHOW_BREAKEVEN then
            local be = breakEvenTax(f)
            line(x, y, string.format("BE tax:%d%%", be)); y = y + LINE_H
        end
    end

    -- Neighbor armies
    if SHOW_NEIGHBORS then
        y = y + 2
        line(x, y, "--armies--"); y = y + LINE_H
        local list = {}
        for i = 0, 16 do
            local ff = readFief(i)
            if ff.men > 0 and i ~= sel then
                table.insert(list, {idx=i, f=ff, pow=combatPower(ff)})
            end
        end
        table.sort(list, function(a, b) return a.pow > b.pow end)
        for i = 1, math.min(MAX_NEIGHBOR_LINES, #list) do
            local entry = list[i]
            local nm = DAIMYO_NAMES[entry.f.owner] or "?"
            line(x, y, string.format("%s m%d s%d", nm:sub(1,6), entry.f.men, entry.f.skill)); y = y + LINE_H
        end
    end
end

emu.addEventCallback(draw, emu.eventType.endFrame)
emu.displayMessage("Lua", "Nobunaga dashboard")

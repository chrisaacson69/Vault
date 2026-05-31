-- ai-war-target5.lua  —  Nobunaga's Ambition (USA), Mesen 2  (17-FIEF, player=Miyoshi d14)
-- ============================================================================
-- COMBAT-keyed battle logger. v3/v4 used $6F63 stability, which fired on non-
-- battles: the player's own fief while navigating (f14/Settsu), and twice per
-- battle ("before/after"). Chris confirmed f13->f14 never happened yet fired.
-- FIX: a real battle makes the DEFENDER lose men. So watch province men-fields
-- and report a battle only when the fief that is battle_defending_province
-- ($6F63) loses men. Fires once per real combat; no idle/menu false positives.
-- Excludes the player (d14) and dedups. Each line carries the min-men analysis
-- + attacker men so we can confirm "weakest adjacent enemy".
-- In-game fief numbers are 1-based; this log is 0-based (in-game N = N-1).
-- TO RUN: load -> Run; play; copy the BATTLE lines (should be ~1 per real fight).
-- ============================================================================
local MT = emu.memType.nesMemory
local DEF, ATK = 0x6F63, 0x6F5F
local MAP, DMY, WK, PR, FC = 0x6E15, 0x752F, 0x6DD4, 0x7001, 0x6D9D
local PLAYER = 14
local STRIDE, MEN_OFF = 26, 16

local ADJ = {  -- 17-fief province adjacency (0-based), ROM bank-4 $8300
  [0]={3}, [1]={2,3,15}, [2]={1,6,15}, [3]={0,1,4,5,15}, [4]={3,5,8,10},
  [5]={3,4,8,15}, [6]={2,7,15}, [7]={6,8,15,16}, [8]={4,5,7,10,12,15,16},
  [9]={11,12,13,14}, [10]={4,8,11,12,13}, [11]={9,10,12,13}, [12]={8,9,10,11,16},
  [13]={9,10,11,14}, [14]={9,13}, [15]={1,2,3,5,6,7,8}, [16]={7,8,12},
}

local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return emu.read(a, MT) + emu.read(a + 1, MT) * 256 end
local function owner(f) return rd(MAP + f) end
local function men(f)   return rd16(PR + f * STRIDE + MEN_OFF) end

local FN = rd16(FC)
local cache = {}
for f = 0, FN - 1 do cache[f] = men(f) end

local frame, lastFrame, n = 0, {}, 0
emu.addEventCallback(function() frame = frame + 1 end, emu.eventType.endFrame)

local function reportBattle(def, before, after)
  local atk = rd(ATK)
  local ao = owner(atk)
  local nb = ADJ[atk] or {}
  local parts, minm, minf = {}, 1e9, -1
  local adj = false
  for _, x in ipairs(nb) do
    if x == def then adj = true end
    if owner(x) ~= ao then
      local m = (x == def) and before or men(x)   -- defender's PRE-battle men
      parts[#parts + 1] = string.format("f%d=%d", x, m)
      if m < minm then minm = m; minf = x end
    end
  end
  if ao == PLAYER or owner(def) == PLAYER then return end   -- skip player battles
  n = n + 1
  local tag = (not adj) and " (NON-ADJ?!)" or (def == minf and " <==MIN" or " (NOTmin)")
  emu.log(string.format("BATTLE#%-3d f%d(d%d,men=%d) -> f%d(d%d) men %d->%d (lost %d) | enemies[%s] min=f%d%s",
    n, atk, ao, men(atk), def, owner(def), before, after, before - after,
    table.concat(parts, ","), minf, tag))
end

emu.addMemoryCallback(function(addr)
  local rel = addr - PR
  if rel < 0 then return end
  local f = math.floor(rel / STRIDE)
  if f >= FN then return end
  if rel % STRIDE ~= MEN_OFF then return end   -- only the men low-byte
  local new = men(f)
  local old = cache[f] or new
  cache[f] = new
  if new >= old then return end                -- only DECREASES = combat casualties
  if f ~= rd(DEF) then return end              -- only the current battle's defender
  if lastFrame[f] and frame - lastFrame[f] < 120 then return end
  lastFrame[f] = frame
  reportBattle(f, old, new)
end, emu.callbackType.write or emu.callbackType.cpuWrite, PR, PR + FN * STRIDE)

if FN ~= 17 then emu.log("!!! WARNING: not 17-fief — adjacency WRONG. !!!") end
emu.displayMessage("Lua", "ai-war-target5 armed (combat-keyed, player=d14)")
emu.log("=== ai-war-target5: logs a battle when the $6F63 defender LOSES men. ~1 line per real fight. ===")

-- ai-war-target.lua  —  Nobunaga's Ambition (USA), Mesen 2
-- ============================================================================
-- PINS THE AI's TARGET PREFERENCE (the "why Oda->Mino, not random" question).
-- The candidate FILTER (driver_war -> sub_8172 -> sub_D9B7) is adjacency+enemy-
-- ownership only; the PICK among candidates is a separate scorer we haven't
-- located statically. So measure it: every time a battle target is committed
-- (battle_defending_province $6F63), log the chosen target's weakness signals.
-- Over several AI wars, see if the target is systematically the lowest-MEN,
-- the lowest owner-HEALTH, the weakness-MARKED one, or none of these.
--   dumpboard()  (call from the Script console) prints all fiefs' signals so you
--   can compare the chosen target against the attacker's OTHER neighbors.
-- Hypothesis under test: target = the weakness-marked ($6DD4) defender.
-- Write callback only (confirmed working).
-- TO RUN: load -> Run; play, let AI declare wars. Copy the WAR lines + a dumpboard().
-- ============================================================================
local MT  = emu.memType.nesMemory
local TGT = 0x6F63   -- battle_defending_province (the chosen target fief)
local ATK = 0x6F5F   -- selected_province_idx (attacker / acting province)
local MAP = 0x6E15   -- fief_to_daimyo_map[fief] = owner daimyo idx
local DMY = 0x752F   -- daimyo records (7 bytes); +1 = health
local WK  = 0x6DD4   -- daimyo_weakness_flag[daimyo]
local PR  = 0x7001   -- province records (26 bytes); +16 = men
local FC  = 0x6D9D   -- scenario_fief_count

local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return emu.read(a, MT) + emu.read(a + 1, MT) * 256 end

-- Full-board snapshot of every fief's weakness signals (call from console).
function dumpboard()
  local n = rd16(FC)
  emu.log("=== BOARD  fief  owner  men  ownerHP  wk ===")
  for f = 0, n - 1 do
    local o = rd(MAP + f)
    emu.log(string.format("  fief%2d  owner=d%-2d  men=%4d  ownerHP=%3d  wk=%d",
      f, o, rd16(PR + f * 26 + 16), rd(DMY + o * 7 + 1), rd(WK + o)))
  end
end

local last, nWar = -1, 0
local function onTarget(addr, value)
  local n = rd16(FC)
  if value >= n then return end          -- 0xFF / out-of-range = not a real target
  if value == last then return end       -- skip immediate duplicate writes
  last = value
  nWar = nWar + 1
  local atk, tO = rd(ATK), rd(MAP + value)
  local atkO = rd(MAP + atk)
  emu.log(string.format("WAR#%d  attacker=fief%2d(d%-2d) -> TARGET=fief%2d(d%-2d)  men=%4d  ownerHP=%3d  wk=%d",
    nWar, atk, atkO, value, tO, rd16(PR + value * 26 + 16), rd(DMY + tO * 7 + 1), rd(WK + tO)))
end

local WRITE = emu.callbackType.write or emu.callbackType.cpuWrite
assert(WRITE ~= nil, "no write callback type in emu.callbackType")
emu.addMemoryCallback(onTarget, WRITE, TGT, TGT)
emu.displayMessage("Lua", "ai-war-target armed ($6F63)")
emu.log("=== ai-war-target: play, let AI wage wars. Each target logs men/ownerHP/wk. dumpboard() = full board. ===")

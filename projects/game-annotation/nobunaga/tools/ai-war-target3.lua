-- ai-war-target3.lua  —  Nobunaga's Ambition (USA), Mesen 2  (17-FIEF ONLY)
-- ============================================================================
-- Isolates COMMITTED battles from the evaluation scan. v2 logged every
-- adjacent-enemy $6F63 write — but most are the AI iterating its neighbors, not
-- attacking (e.g. f9 "considers" all of {11,12,13,14} incl. its strongest).
-- KEY: a real battle holds battle_defending_province ($6F63) FIXED for hundreds
-- of frames (tactical map stays loaded); the scan flips it every frame or two.
-- So: only report when $6F63 has been STABLE for ~30 frames = a real commit.
-- Each BATTLE line shows the attacker's adjacent-enemy set with men + MIN flag,
-- plus wk + ownerHP, so the target preference reads straight off.
-- NOTE: in-game fief numbers are 1-based; this log is 0-based (in-game N = N-1).
-- 17-FIEF adjacency hardcoded; warns if the game isn't 17-fief.
-- TO RUN: load -> Run; play, let AI wars resolve; copy the BATTLE lines.
-- ============================================================================
local MT = emu.memType.nesMemory
local TGT, ATK = 0x6F63, 0x6F5F
local MAP, DMY, WK, PR, FC = 0x6E15, 0x752F, 0x6DD4, 0x7001, 0x6D9D

local ADJ = {  -- 17-fief province adjacency (0-based), ROM bank-4 $8300
  [0]={3}, [1]={2,3,15}, [2]={1,6,15}, [3]={0,1,4,5,15}, [4]={3,5,8,10},
  [5]={3,4,8,15}, [6]={2,7,15}, [7]={6,8,15,16}, [8]={4,5,7,10,12,15,16},
  [9]={11,12,13,14}, [10]={4,8,11,12,13}, [11]={9,10,12,13}, [12]={8,9,10,11,16},
  [13]={9,10,11,14}, [14]={9,13}, [15]={1,2,3,5,6,7,8}, [16]={7,8,12},
}

local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return emu.read(a, MT) + emu.read(a + 1, MT) * 256 end
local function owner(f) return rd(MAP + f) end
local function men(f)   return rd16(PR + f * 26 + 16) end

local n = 0
local function report(tgt)
  local atk = rd(ATK)
  local nb = ADJ[atk]
  local ao = owner(atk)
  local parts, minm, minf = {}, 1e9, -1
  local adj = false
  if nb then
    for _, x in ipairs(nb) do
      if x == tgt then adj = true end
      if owner(x) ~= ao then
        local m = men(x)
        parts[#parts + 1] = string.format("f%d=%d", x, m)
        if m < minm then minm = m; minf = x end
      end
    end
  end
  local tag = (not adj) and "  (NON-ADJACENT?!)" or (tgt == minf and "  <== MIN-MEN" or "  (NOT min)")
  n = n + 1
  emu.log(string.format("BATTLE#%-3d f%d(d%d) -> f%d(d%d) men=%d wk=%d ownerHP=%d | enemies[%s] min=f%d%s",
    n, atk, ao, tgt, owner(tgt), men(tgt), rd(WK + owner(tgt)),
    rd(DMY + owner(tgt) * 7 + 1), table.concat(parts, ","), minf, tag))
end

local cur, stable, done = -1, 0, true
emu.addEventCallback(function()
  local v = rd(TGT)
  if v ~= cur then cur = v; stable = 0; done = false; return end
  stable = stable + 1
  -- 30 stable frames + a valid fief = a battle is loaded (not a scan flip / idle 0xFF)
  if stable == 30 and not done and v < rd16(FC) then done = true; report(v) end
end, emu.eventType.endFrame)

if rd16(FC) ~= 17 then
  emu.log("!!! WARNING: scenario is NOT 17-fief — embedded adjacency is WRONG. !!!")
end
emu.displayMessage("Lua", "ai-war-target3 armed (commit-only, 17-fief)")
emu.log("=== ai-war-target3: logs only COMMITTED battles ($6F63 stable >=30 frames) with min-men analysis. ===")

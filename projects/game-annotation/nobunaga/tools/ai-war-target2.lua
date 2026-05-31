-- ai-war-target2.lua  —  Nobunaga's Ambition (USA), Mesen 2  (17-FIEF ONLY)
-- ============================================================================
-- Refined target-preference probe. v1 ($6F63 raw) was overloaded: it caught the
-- self-resets (attacker==target) AND the all-fief evaluation sweep. This version
-- FILTERS to the attacker's ADJACENT-ENEMY candidates only (using the embedded
-- 17-fief adjacency), and for each it prints the WHOLE adjacent-enemy set with
-- their men, flagging the MIN-men one. So when the AI commits an attack you can
-- read straight off the line whether it picked the weakest-troop neighbor.
-- Self-analyzing — no console calls needed.
-- HYPOTHESES the line lets you check at a glance:
--   * weakest-men neighbor  -> committed target has "<== MIN-MEN"
--   * weakness-marked        -> wk=1 on the target
--   * owner-health           -> ownerHP lowest among neighbors
-- 17-FIEF adjacency is hardcoded; a banner warns if the game isn't 17-fief.
-- TO RUN: load -> Run; play, let the AI wage wars; copy the CAND# lines.
-- ============================================================================
local MT = emu.memType.nesMemory
local TGT, ATK = 0x6F63, 0x6F5F
local MAP, DMY, WK, PR, FC = 0x6E15, 0x752F, 0x6DD4, 0x7001, 0x6D9D

-- 17-fief province adjacency (0-based), decoded from ROM bank-4 $8300.
local ADJ = {
  [0]={3}, [1]={2,3,15}, [2]={1,6,15}, [3]={0,1,4,5,15}, [4]={3,5,8,10},
  [5]={3,4,8,15}, [6]={2,7,15}, [7]={6,8,15,16}, [8]={4,5,7,10,12,15,16},
  [9]={11,12,13,14}, [10]={4,8,11,12,13}, [11]={9,10,12,13}, [12]={8,9,10,11,16},
  [13]={9,10,11,14}, [14]={9,13}, [15]={1,2,3,5,6,7,8}, [16]={7,8,12},
}

local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return emu.read(a, MT) + emu.read(a + 1, MT) * 256 end
local function owner(f) return rd(MAP + f) end
local function men(f)   return rd16(PR + f * 26 + 16) end

local frame = 0
emu.addEventCallback(function() frame = frame + 1 end, emu.eventType.endFrame)

local seen, n = {}, 0    -- seen[atk*100+tgt] = last frame logged (light debounce)
local function onTarget(addr, value)
  local atk = rd(ATK)
  local nb = ADJ[atk]
  if not nb then return end
  local adj = false
  for _, x in ipairs(nb) do if x == value then adj = true break end end
  if not adj then return end                 -- not an adjacent target -> sweep/self noise
  local ao = owner(atk)
  if owner(value) == ao then return end       -- same owner -> not an enemy
  local key = atk * 100 + value
  if seen[key] and frame - seen[key] < 120 then return end   -- debounce repeats
  seen[key] = frame

  -- Build the attacker's full adjacent-ENEMY set with men; find the min.
  local parts, minm, minf = {}, 1e9, -1
  for _, x in ipairs(nb) do
    if owner(x) ~= ao then
      local m = men(x)
      parts[#parts + 1] = string.format("f%d=%d", x, m)
      if m < minm then minm = m; minf = x end
    end
  end
  n = n + 1
  local flag = (value == minf) and "  <== MIN-MEN" or ""
  emu.log(string.format("CAND#%-3d f%d(d%d) -> f%d(d%d) men=%d wk=%d ownerHP=%d | enemies[%s] min=f%d%s",
    n, atk, ao, value, owner(value), men(value), rd(WK + owner(value)),
    rd(DMY + owner(value) * 7 + 1), table.concat(parts, ","), minf, flag))
end

local WRITE = emu.callbackType.write or emu.callbackType.cpuWrite
assert(WRITE ~= nil, "no write callback type in emu.callbackType")
emu.addMemoryCallback(onTarget, WRITE, TGT, TGT)
if rd16(FC) ~= 17 then
  emu.log("!!! WARNING: scenario is NOT 17-fief — embedded adjacency is WRONG. Re-run on a 17-fief game. !!!")
end
emu.displayMessage("Lua", "ai-war-target2 armed (17-fief)")
emu.log("=== ai-war-target2: adjacent-enemy targets only, with neighbor men + MIN flag. Note which one the AI actually fights. ===")

-- ai-war-target4.lua  —  Nobunaga's Ambition (USA), Mesen 2  (17-FIEF, player=Miyoshi d14)
-- ============================================================================
-- Commit-only battle logger, cleaned. v3 caught real AI battles but also player-
-- turn artifacts ($6F63 holding on the player's own fief while deliberating) and
-- self/non-adjacent stable states. v4:
--   * reports only when target is an ADJACENT ENEMY of the attacker (drops self
--     + non-adjacent idle noise),
--   * TAGS battles involving the player (d14) so they can be set aside,
--   * adds the ATTACKER's men, so we can test "attacks where it outnumbers the
--     defender (winnability)" vs "attacks the absolute weakest (argmin)".
-- Open question this targets: v1-3 showed ~3/4 AI attacks hit the min-men
-- neighbor, but one (f7->f8 over weaker f16) did not -> prefer-weak, not strict
-- argmin. The atk_men column + ratio should reveal the real rule.
-- In-game fief numbers are 1-based; this log is 0-based (in-game N = N-1).
-- TO RUN: load -> Run; play, let AI wars resolve; copy the BATTLE lines.
-- ============================================================================
local MT = emu.memType.nesMemory
local TGT, ATK = 0x6F63, 0x6F5F
local MAP, DMY, WK, PR, FC = 0x6E15, 0x752F, 0x6DD4, 0x7001, 0x6D9D
local PLAYER = 14   -- Miyoshi in this 17-fief game

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
  if not nb then return end
  local ao = owner(atk)
  local adj = false
  for _, x in ipairs(nb) do if x == tgt then adj = true break end end
  if not adj then return end                 -- not an adjacent target -> idle/self noise
  if owner(tgt) == ao then return end          -- same owner -> not a battle
  -- attacker's adjacent-ENEMY set with men; find min
  local parts, minm, minf = {}, 1e9, -1
  for _, x in ipairs(nb) do
    if owner(x) ~= ao then
      local m = men(x)
      parts[#parts + 1] = string.format("f%d=%d", x, m)
      if m < minm then minm = m; minf = x end
    end
  end
  local am = men(atk)
  local tm = men(tgt)
  n = n + 1
  local who = (ao == PLAYER or owner(tgt) == PLAYER) and " [PLAYER]" or ""
  local flag = (tgt == minf) and " <==MIN" or " (NOTmin)"
  emu.log(string.format("BATTLE#%-3d f%d(d%d,men=%d) -> f%d(d%d,men=%d) ratio=%.2f wk=%d | enemies[%s] min=f%d%s%s",
    n, atk, ao, am, tgt, owner(tgt), tm, (tm > 0) and (am / tm) or 9.99,
    rd(WK + owner(tgt)), table.concat(parts, ","), minf, flag, who))
end

local cur, stable, done = -1, 0, true
emu.addEventCallback(function()
  local v = rd(TGT)
  if v ~= cur then cur = v; stable = 0; done = false; return end
  stable = stable + 1
  if stable == 30 and not done and v < rd16(FC) then done = true; report(v) end
end, emu.eventType.endFrame)

if rd16(FC) ~= 17 then
  emu.log("!!! WARNING: scenario is NOT 17-fief — embedded adjacency is WRONG. !!!")
end
emu.displayMessage("Lua", "ai-war-target4 armed (commit-only, player=d14)")
emu.log("=== ai-war-target4: committed adjacent-enemy battles, with attacker men + ratio + MIN flag + [PLAYER] tag. ===")

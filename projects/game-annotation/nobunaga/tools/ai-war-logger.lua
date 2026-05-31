-- ai-war-logger.lua  —  Nobunaga's Ambition (USA), Mesen 2 Lua  (v2, write-based)
-- ============================================================================
-- WHY v2: the v1 EXEC-callback hook on the VM dispatcher ($E867) never fired in
-- this Mesen build (exec-callback support/spelling differs; write callbacks DO
-- work — proven by spiiin's Log Parallax sample). And we no longer need the
-- dispatcher: the static decode already gave the AI war-target formula
--   ai_war_target_flags[$6DD4][D] |= ( rng_mod(400) < (100 - daimyo[D].health) )
-- so instead of inferring at the dispatcher, we WATCH THE WRITE to $6DD4. Every
-- write is one trial of the formula; logging the daimyo's health at that instant
-- lets us validate P(flag set) = (100 - health) / 400 empirically.
--
-- TO RUN: Mesen 2 -> Debug -> Script Window -> load -> Run, then play AI turns.
--         Copy the log out. The "histogram" lines at the bottom are the result.
-- ============================================================================
local MT    = emu.memType.nesMemory
local FLAGS = 0x6DD4        -- ai_war_target_flags[daimyo idx]   (per-daimyo)
local DMY   = 0x752F        -- daimyo_table_17 base; record stride 7, +1 = health
local DSTRIDE = 7
local NMAX  = 50            -- cover 50-fief scenario; 17-fief uses the low slots

local function rd(a)   return emu.read(a, MT) end
local function vmpc()  return rd(0x06) + rd(0x07) * 256 end

-- One-time introspection: dump the callback-type names this build actually has,
-- so we can also repair the exec-based tools (vm-trace.lua) with the real name.
emu.log("--- emu.callbackType keys in this build: ---")
pcall(function()
  for k, v in pairs(emu.callbackType) do emu.log(string.format("    %s = %s", k, tostring(v))) end
end)
emu.log(string.format("    (.write=%s  .cpuWrite=%s  .exec=%s  .cpuExec=%s)",
  tostring(emu.callbackType.write), tostring(emu.callbackType.cpuWrite),
  tostring(emu.callbackType.exec), tostring(emu.callbackType.cpuExec)))

-- Robust write-type resolution (cpuWrite vs write across Mesen builds).
local WRITE = emu.callbackType.write or emu.callbackType.cpuWrite
assert(WRITE ~= nil, "no write callback type in emu.callbackType")

-- Accumulators for the validation histogram: per 10-pt health bucket,
--   trials  = writes whose VM PC is the probabilistic set ($A59C),
--   sets    = those that wrote a nonzero flag.
local trials, sets = {}, {}
for b = 0, 10 do trials[b] = 0; sets[b] = 0 end
local nWrite = 0

-- VM PC of the planner's probabilistic store. CONFIRMED 2026-05-30: the store
-- opcode is $A59C ($D4 BYTE_POPSTORE) and $06/$07 reads $A59D at write time (PC
-- advanced one byte into the handler). The $A4AB init (vmpc ~$A4AC) and the
-- sub_9D00 devastation writer (vmpc ~$9D79) fall outside this window, so the
-- histogram counts only the formula's Bernoulli trials.
local SET_LO, SET_HI = 0xA59C, 0xA59E

local function onFlagWrite(address, value)
  nWrite = nWrite + 1
  local d  = address - FLAGS
  local hp = rd(DMY + d * DSTRIDE + 1)          -- that daimyo's health
  local pc = vmpc()
  local pred = (hp <= 100) and (100 - hp) / 400 or 0
  emu.log(string.format("FLAG w#%d  daimyo=%d  val=%d  health=%d  vmpc=$%04X  P_pred=%.3f",
    nWrite, d, value, hp, pc, pred))
  -- Only the probabilistic store ($A59C) is a Bernoulli trial of the formula;
  -- the $A4AB init (val 0) and the sub_9D00 devastation writer are not.
  if pc >= SET_LO and pc <= SET_HI and hp <= 100 and value <= 1 then
    local b = math.floor(hp / 10); if b > 10 then b = 10 end
    trials[b] = trials[b] + 1
    if value ~= 0 then sets[b] = sets[b] + 1 end
  end
end

-- Print the running histogram on demand (call dumphist() from the console, or it
-- auto-prints every 200 trials).
function dumphist()
  emu.log("=== health-bucket validation:  bucket  trials  sets  observed  predicted ===")
  for b = 0, 10 do
    if trials[b] > 0 then
      local lo, hi = b * 10, b * 10 + 9
      local obs  = sets[b] / trials[b]
      local pred = (100 - (lo + 5)) / 400          -- predicted at bucket midpoint
      if pred < 0 then pred = 0 end
      emu.log(string.format("   h%2d-%2d   %5d   %4d   %.3f     %.3f",
        lo, hi, trials[b], sets[b], obs, pred))
    end
  end
end

local nT = 0
emu.addMemoryCallback(function(a, v)
  onFlagWrite(a, v)
  nT = nT + 1
  if nT % 200 == 0 then dumphist() end
end, WRITE, FLAGS, FLAGS + NMAX)

emu.displayMessage("Lua", "ai-war-logger v2 armed (write-based, $6DD4)")
emu.log("=== ai-war-logger v2 — watching ai_war_target_flags writes; play AI turns ===")

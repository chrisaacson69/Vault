-- ai-war-logger.lua  —  Nobunaga's Ambition (USA), Mesen 2 Lua
-- ============================================================================
-- Purpose: measure the daimyo AI's WAR decision empirically, to settle two
-- hypotheses the static walk could not (the scorer sits behind the ext-op wall):
--
--   H1  TARGET = WEAKEST NEIGHBOR.  When the AI declares war, is the target the
--       lowest-army adjacent enemy, or not?
--   H2  DAIMYO PERSONALITY.  Does War get chosen more by high-DRIVE daimyo, and
--       develop/internal commands more by high-IQ daimyo?
--
-- Method: hook the VM dispatcher ($E867) and fire on specific VM PCs (read from
-- zero-page $06, exactly as tools/vm-trace.lua does). No game logic is changed;
-- this only reads memory and logs to the Script Window.
--
-- TO RUN:  Mesen 2 -> Debug -> Script Window -> load this file -> Run, then play
--          one full round (let the AI take its turns). Copy the log out.
--
-- ============================================================================
-- ADDRESS CONFIDENCE
--   CONFIRMED : $E867 dispatcher; VM PC @ ZP $06; $6F5F selected_province_idx;
--               command-driver entry addresses (command-table.txt); live
--               province record table $7001 stride 26 (men+18, morale+20, arms+24).
--   VERIFY    : which var holds the WAR TARGET ($6F4F vs $6F63 vs $6F57/$6F7D) —
--               the logger prints all candidates; on run 1 confirm which one is a
--               neighbor of the attacker. Daimyo live record base/stride/offsets
--               ($752F + fief*7) — the logger dumps all 7 bytes; on run 1 match
--               them against 50Diamyo.txt to pin which offset is drive / iq.
--   => RUN 1 IS A CALIBRATION RUN.  Confirm the VERIFY items, then trust runs 2+.
-- ============================================================================

local DISPATCHER = 0xE867
local MT = emu.memType.nesMemory

-- VM PCs we trigger on -------------------------------------------------------
local AI_ISSUER = 0xB79B   -- $B79B: AI command-issuer (gates CMD/WAR to the AI)
-- command-driver entry addresses (bank-1 $B9B2 table; see command-table.txt)
local DRIVER_NAME = {
  [0x96D1]="Move",  [0x9850]="War",   [0x999A]="Tax",   [0x9A5D]="Send",
  [0x9B7E]="Dam",   [0x9C4F]="Pact",  [0x9D3D]="Grow",  [0x9DC4]="Marry",
  [0xA1B6]="Trade", [0xA5F4]="Hire",  [0xA637]="Train", [0xA853]="Build",
  [0xAA1F]="Give",  [0xAAAE]="Bribe", [0xB2A1]="Pass",
}

-- 50-fief adjacency + names (generated from ROM bank 4 $8004) -----------------
local ADJ = {
  [0]={1},[1]={0,2,4},[2]={1,3,4},[3]={2,4,5},[4]={1,2,3,5,6},[5]={3,4,6,7},
  [6]={4,5,7,8,9},[7]={5,6,8,10,11},[8]={6,7,9,11},[9]={6,8,11,13,14,16},
  [10]={7,11,13},[11]={7,8,9,10,13},[12]={13},[13]={9,10,11,12,14,19},
  [14]={9,13,16,17,18,19},[15]={16,20},[16]={9,14,15,17,20},[17]={14,16,18,20,21,22},
  [18]={14,17,19,22,23},[19]={13,14,18,23},[20]={15,16,17,21},[21]={17,20,22,26,28},
  [22]={17,18,21,23,24,25,26},[23]={18,19,22,24},[24]={22,23,25},[25]={22,24,26,27,31,33},
  [26]={21,22,25,27,28,29,30},[27]={25,26,30,31},[28]={21,26,29,34},[29]={26,28,30,32,34,35},
  [30]={26,27,29,31,32},[31]={25,27,30,32,33},[32]={29,30,31,33,35},[33]={25,31,32},
  [34]={28,29,35,36,37},[35]={29,32,34,37,40},[36]={34,37,38},[37]={34,35,36,38},
  [38]={36,37,44},[39]={40,41},[40]={35,39,41,42},[41]={39,40,42,43,46},[42]={40,41,43},
  [43]={41,42},[44]={38,45,46},[45]={44,46,47},[46]={41,44,45,47,48},[47]={45,46,48,49},
  [48]={46,47,49},[49]={47,48},
}
local NAME = {[0]="Ezo",[1]="Mutsu",[2]="Morioka",[3]="Iwasaki",[4]="Ugo",[5]="Rikuzen",
  [6]="Uzen",[7]="Iwaki",[8]="Iwashiro",[9]="Echigo",[10]="Hitachi",[11]="Shimotsu",
  [12]="Awa(E)",[13]="Musashi",[14]="Shinano",[15]="Noto",[16]="Ecchu",[17]="Hida",
  [18]="Kiso",[19]="Suruga",[20]="Kaga",[21]="Echizen",[22]="Mino",[23]="Mikawa",
  [24]="Owari",[25]="Iseshima",[26]="Omi",[27]="Iga",[28]="Tango",[29]="Tanba",
  [30]="Yamashir",[31]="Yamato",[32]="Settsu",[33]="Kii",[34]="Inaba",[35]="Harima",
  [36]="Izumo",[37]="Sanbi",[38]="Aki",[39]="Sanuki",[40]="Awa(S)",[41]="Iyo",
  [42]="Tosa",[43]="Nakamura",[44]="Buzen",[45]="Chikuhi",[46]="Bungo",[47]="Higo",
  [48]="Hiyuga",[49]="Satuma"}

-- live province record ($7001 + fief*26), 16-bit LE fields -------------------
local PROV_BASE, PROV_STRIDE = 0x7001, 26
local OFF_MEN, OFF_MORALE, OFF_ARMS = 18, 20, 24
-- live daimyo record (VERIFY base/stride/offsets on run 1)
local DMY_BASE, DMY_STRIDE = 0x752F, 7

local function rd(a)   return emu.read(a, MT) end
local function rd16(a) return emu.read(a, MT) + emu.read(a+1, MT)*256 end
local function vmpc()  return rd(0x06) + rd(0x07)*256 end

local function prec(f) return PROV_BASE + f*PROV_STRIDE end
local function army(f)
  local r = prec(f)
  local m, mo, a = rd16(r+OFF_MEN), rd16(r+OFF_MORALE), rd16(r+OFF_ARMS)
  local g = 0
  if m>0 and mo>0 and a>0 then g = math.floor((m*mo*a)^(1/3) + 0.5) end
  return g, m, mo, a
end

-- AI gating: $B79B marks "an AI command is being issued for this fief" --------
local aiPending, actingFief = false, -1
local nWar, nCmd = 0, 0

local function dumpDaimyo(f)
  local s = "    daimyo[" .. f .. "] raw:"
  for k=0,DMY_STRIDE-1 do s = s .. string.format(" +%d=%d", k, rd(DMY_BASE + f*DMY_STRIDE + k)) end
  emu.log(s .. "   (VERIFY: match vs 50Diamyo.txt to pin drive/iq offset)")
end

local function logWar(attacker)
  nWar = nWar + 1
  local ga = army(attacker)
  emu.log(string.format("WAR #%d  attacker=%d %s (army~%d)  [via %s]",
    nWar, attacker, NAME[attacker] or "?", ga, aiPending and "AI" or "PLAYER?"))
  -- target candidate vars (VERIFY which one is the real target on run 1)
  emu.log(string.format("    target?  $6F4F=%d  $6F63=%d  $6F57=%d  $6F7D=%d",
    rd16(0x6F4F), rd16(0x6F63), rd16(0x6F57), rd16(0x6F7D)))
  -- live army of every neighbor — H1 reads straight off this line
  local nbrs = ADJ[attacker] or {}
  local line = "    neighbors(army): "
  local weakest, wv = -1, 1e9
  for _,n in ipairs(nbrs) do
    local g = army(n)
    line = line .. string.format("%s=%d  ", NAME[n] or "?", g)
    if g < wv then wv, weakest = g, n end
  end
  emu.log(line)
  emu.log(string.format("    weakest neighbor = %s (army~%d)  <-- H1: did the AI pick this one?",
    NAME[weakest] or "?", wv))
end

local function onDispatch()
  local pc = vmpc()

  if pc == AI_ISSUER then
    aiPending  = true
    actingFief = rd16(0x6F5F)
    emu.log(string.format("ISSUE  fief=%d %s", actingFief, NAME[actingFief] or "?"))
    dumpDaimyo(actingFief)             -- H2: daimyo stats of the acting clan
    return
  end

  local name = DRIVER_NAME[pc]
  if name then
    if aiPending then
      nCmd = nCmd + 1
      emu.log(string.format("CMD #%d  fief=%d %s  ->  %s", nCmd, actingFief,
        NAME[actingFief] or "?", name))
      if name == "War" then logWar(actingFief) end
      aiPending = false               -- consume one command per ISSUE
    elseif name == "War" then
      logWar(rd16(0x6F5F))            -- also catch wars not gated (likely player)
    end
  end
end

emu.addMemoryCallback(onDispatch, emu.callbackType.exec, DISPATCHER, DISPATCHER)
emu.displayMessage("Lua", "ai-war-logger armed (run 1 = calibration)")
emu.log("=== ai-war-logger started — play one AI round ===")

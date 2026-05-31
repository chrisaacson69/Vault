-- ai-turn-trace.lua  —  Nobunaga's Ambition (USA), Mesen 2
-- ============================================================================
-- PINS THE PLAYER-vs-AI FORK in the turn processor.
-- Chain (decoded): vm_bootstrap -> call_bank(1) -> sub_B89B (turn root) loops
--   provinces, writing selected_province_idx ($6F5F) for each, then CALL $B79B
--   (command issuer) -> sub_B6B4 -> sub_D14E (cursor engine; read_controller).
-- QUESTION: does the loop process AI-owned provinces through the SAME path
--   (fork is internal to the menu engine), or only the player's?
-- METHOD: log every write to $6F5F with the province's OWNER (fief_to_daimyo_map)
--   and a FRAME-GAP since the last selection. Player provinces should show large
--   gaps (game waits for your input); AI provinces should resolve in ~0 frames.
-- Uses only WRITE + endFrame callbacks (both confirmed working in this build).
--
-- TO RUN: load -> Run, then play a FULL round: take your turn, hit End Turn, and
--   let the AI daimyo act. Copy the log. Then tell me the sequence.
-- ============================================================================
local MT     = emu.memType.nesMemory
local SEL    = 0x6F5F   -- selected_province_idx (low byte = 0-based province index)
local MAP    = 0x6E15   -- fief_to_daimyo_map[fief] = owning daimyo idx
local PLAYER = 0        -- YOUR daimyo index (Kakizaki=0 last game; change if different)

local NAME = {[0]="Ezo",[1]="Mutsu",[2]="Morioka",[3]="Iwasaki",[4]="Ugo",[5]="Rikuzen",
  [6]="Uzen",[7]="Iwaki",[8]="Iwashiro",[9]="Echigo",[10]="Hitachi",[11]="Shimotsu",
  [12]="AwaE",[13]="Musashi",[14]="Shinano",[15]="Noto",[16]="Ecchu",[17]="Hida",
  [18]="Kiso",[19]="Suruga",[20]="Kaga",[21]="Echizen",[22]="Mino",[23]="Mikawa",
  [24]="Owari",[25]="Iseshima",[26]="Omi",[27]="Iga",[28]="Tango",[29]="Tanba",
  [30]="Yamashir",[31]="Yamato",[32]="Settsu",[33]="Kii",[34]="Inaba",[35]="Harima",
  [36]="Izumo",[37]="Sanbi",[38]="Aki",[39]="Sanuki",[40]="AwaS",[41]="Iyo",
  [42]="Tosa",[43]="Nakamura",[44]="Buzen",[45]="Chikuhi",[46]="Bungo",[47]="Higo",
  [48]="Hiyuga",[49]="Satuma"}

local function rd(a) return emu.read(a, MT) end

local frame, last = 0, 0
emu.addEventCallback(function() frame = frame + 1 end, emu.eventType.endFrame)

local n = 0
local function onSel(addr, value)
  n = n + 1
  local owner = rd(MAP + value)        -- daimyo who owns this province
  local gap = frame - last; last = frame
  local tag = (owner == PLAYER) and "   <== PLAYER" or ""
  emu.log(string.format("#%-4d f%-6d (+%4d)  prov=%2d %-9s owner=d%-2d%s",
    n, frame, gap, value, NAME[value] or "?", owner, tag))
end

local WRITE = emu.callbackType.write or emu.callbackType.cpuWrite
assert(WRITE ~= nil, "no write callback type in emu.callbackType")
emu.addMemoryCallback(onSel, WRITE, SEL, SEL)
emu.displayMessage("Lua", "ai-turn-trace armed ($6F5F selected_province_idx)")
emu.log("=== ai-turn-trace: play a FULL round (your turn -> End Turn -> AI turns). ===")
emu.log("=== Watch: do AI-owned provinces get selected (gap~0)? Player provinces have big gaps. ===")

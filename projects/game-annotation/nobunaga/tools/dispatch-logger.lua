-- dispatch-logger.lua
-- Hooks the BRK-VM dispatch site at $F239 in Nobunaga's Ambition (NES)
-- and logs each dispatch event. Two output modes:
--
--   v1 (default below): logs to Mesen's Script Console. Lightweight first test.
--   v2 (commented out): writes a CSV file.
--
-- To run:
--   1. Open Mesen 2, load the ROM
--   2. Debug -> Script Window (or similar, depending on Mesen version)
--   3. Load this file, click Run
--   4. Play the game; events appear in the script log
--
-- API references (Mesen 2 Lua):
--   emu.addMemoryCallback(fn, callbackType, startAddr [, endAddr])
--     callbackType values: emu.callbackType.cpuRead / cpuWrite / cpuExec
--   emu.read(addr, memType)         -- 8-bit read
--   emu.read16(addr, memType)       -- 16-bit read (if available)
--   memType: emu.memType.cpuDebug   -- read CPU memory bus without side effects
--   emu.getState()                  -- returns table with .cpu.*, .ppu.*, etc.
--   emu.log("string")               -- writes a line to the script log

local dispatchCount = 0
local stateDumped = false

-- One-shot introspection helper: on the first hit, dump the shape of
-- emu.getState() so we know the exact field names for this Mesen build.
local function dumpKeys(t, prefix, depth)
    prefix = prefix or ""
    depth = depth or 0
    if depth > 2 then return end
    for k, v in pairs(t) do
        local kind = type(v)
        if kind == "table" then
            emu.log(string.format("  %s%s = { ... }", prefix, tostring(k)))
            dumpKeys(v, prefix .. "  ", depth + 1)
        else
            emu.log(string.format("  %s%s = (%s) %s",
                prefix, tostring(k), kind, tostring(v)))
        end
    end
end

local function onDispatch()
    dispatchCount = dispatchCount + 1

    local state = emu.getState()

    -- DEBUG: first time through, log the whole structure so we can see field names.
    if not stateDumped then
        stateDumped = true
        emu.log("--- emu.getState() structure (first call) ---")
        dumpKeys(state)
        emu.log("--- end structure dump ---")
    end

    -- Try several plausible field paths for frame count + stack pointer.
    -- Comment / uncomment lines below once we know which actually has data.
    local frame =
        (type(state.ppu) == "table" and state.ppu.frameCount) or
        (type(state.ppu) == "table" and state.ppu.frameNumber) or
        state.frameCount or
        state.frameNumber or
        -1
    local sp =
        state.sp or
        (type(state.cpu) == "table" and state.cpu.sp) or
        0

    local taskId = emu.read(0x0050, emu.memType.cpuDebug)

    -- Caller's JSR return PC lives on the stack:
    --   stack[sp+1] = P (already pushed by PHP one instruction ago)
    --   stack[sp+2] = $3C  (fake-return low for the dispatched routine)
    --   stack[sp+3] = $F2  (fake-return high)
    --   stack[sp+4] = caller return-1 low (pushed by JSR syscall_dispatch)
    --   stack[sp+5] = caller return-1 high
    -- JSR pushes PC-1, so add 1 to recover the actual call site.
    local callerLo = emu.read(0x0100 + ((sp + 4) % 256), emu.memType.cpuDebug)
    local callerHi = emu.read(0x0100 + ((sp + 5) % 256), emu.memType.cpuDebug)
    local caller = (callerHi * 256) + callerLo + 1

    emu.log(string.format("[#%d  fr=%d  sp=$%02X]  task=$%02X  caller=$%04X",
        dispatchCount, frame, sp, taskId, caller))
end

-- Hook execution of the JMP ($FFFE) instruction at $F239.
-- This fires after the parameter-copy loop has populated $0050-$0065.
emu.addMemoryCallback(onDispatch, emu.callbackType.cpuExec, 0xF239)

emu.log("dispatch-logger: armed on PC=$F239 (syscall_dispatch JMP indirect)")


-------------------------------------------------------------------------------
-- v2: CSV file output (uncomment when v1 has been verified to fire correctly)
-------------------------------------------------------------------------------
-- local logFile = io.open("dispatch-events.csv", "w")
-- logFile:write("seq,frame,task_id,caller_pc,p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,pA,pB,pC,pD,pE,pF,p10,p11,p12,p13,p14\n")
-- logFile:flush()
--
-- local function onDispatchCsv()
--     dispatchCount = dispatchCount + 1
--     local state = emu.getState()
--     local frame = (state.ppu and state.ppu.frameCount) or state.frameCount or -1
--     local taskId = emu.read(0x0050, emu.memType.cpuDebug)
--     local sp = state.cpu.sp
--     local callerLo = emu.read(0x0100 + ((sp + 4) % 256), emu.memType.cpuDebug)
--     local callerHi = emu.read(0x0100 + ((sp + 5) % 256), emu.memType.cpuDebug)
--     local caller = (callerHi * 256) + callerLo + 1
--     local params = {}
--     for i = 0x51, 0x65 do
--         params[#params + 1] = string.format("$%02X", emu.read(i, emu.memType.cpuDebug))
--     end
--     logFile:write(string.format("%d,%d,$%02X,$%04X,%s\n",
--         dispatchCount, frame, taskId, caller, table.concat(params, ",")))
--     logFile:flush()
-- end

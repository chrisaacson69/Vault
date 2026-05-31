-- VM differential-trace harness.
--
-- When CPU PC enters the dispatcher ($E867), reads the VM PC + opcode about
-- to execute, and logs ONE line per VM opcode with full VM register state.
--
-- We trigger on VM PC entering the selector at $967A (Hida v Shinano combat
-- selector body) and continue until the VM call depth returns past the entry
-- point (outermost RETURN). That produces a clean, finite trace.
--
-- Output goes to the Mesen Script Window log — copy/paste it back to the
-- Python project and diff against our Python emulator's trace.

local DISPATCHER = 0xE867
local TRIGGER_VM_PC = 0x967A     -- selector body entry
local CALL_OPS = {[0xAC]=1, [0xDD]=1, [0xE9]=1, [0xEA]=1}
local RETURN_OP = 0xCF

local active = false
local depth  = 0
local count  = 0
local MAX_LOG = 5000

local function read_word(addr)
    return emu.read(addr, emu.memType.nesMemory)
         + emu.read(addr + 1, emu.memType.nesMemory) * 256
end

local function log_state(label, vmpc, op)
    local sp   = read_word(0x02)
    local fp   = read_word(0x04)
    local regL = read_word(0x08)
    local regR = read_word(0x0C)
    local b1 = emu.read(vmpc + 1, emu.memType.nesMemory)
    local b2 = emu.read(vmpc + 2, emu.memType.nesMemory)
    local b3 = emu.read(vmpc + 3, emu.memType.nesMemory)
    emu.log(string.format(
        "%s VMPC=$%04X op=$%02X+(%02X %02X %02X)  L=$%04X R=$%04X SP=$%04X FP=$%04X  d=%d",
        label, vmpc, op, b1, b2, b3, regL, regR, sp, fp, depth
    ))
end

local function on_dispatcher(addr)
    local vmpc = read_word(0x06)
    local op   = emu.read(vmpc, emu.memType.nesMemory)

    if not active then
        if vmpc == TRIGGER_VM_PC then
            active = true
            depth  = 0
            count  = 0
            emu.log("=== TRIGGER: VM entered $" .. string.format("%04X", TRIGGER_VM_PC) .. " ===")
        else
            return
        end
    end

    log_state("  ", vmpc, op)

    if CALL_OPS[op] then
        depth = depth + 1
    elseif op == RETURN_OP then
        depth = depth - 1
        if depth < 0 then
            emu.log("=== OUTERMOST RETURN reached ===")
            active = false
            return
        end
    end

    count = count + 1
    if count > MAX_LOG then
        emu.log("=== MAX_LOG reached ===")
        active = false
    end
end

-- Mesen 2's exec enum is `cpuExec`; `exec` is nil and the callback never fires.
local EXEC = emu.callbackType.cpuExec or emu.callbackType.exec
assert(EXEC ~= nil, "no exec callback type in emu.callbackType (cpuExec/exec)")
emu.addMemoryCallback(on_dispatcher, EXEC, DISPATCHER, DISPATCHER)
emu.displayMessage("Lua", "Waiting for VM PC=$967A")

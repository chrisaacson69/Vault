-- Mesen 2 overlay diagnostic round 2.
-- Round 1 found: only "no bg arg" worked, and the color appeared INVERTED.
-- Hypothesis: Mesen 2 uses 24-bit RGB (0xRRGGBB), not 32-bit ARGB.
-- So our 0xFFFFFFFF (4 bytes) overflows or sign-extends, ending up as "black".

local frame = 0

local function draw()
    frame = frame + 1

    -- v1: 24-bit white text, no bg
    emu.drawString(8, 8,  "v1: white24",   0xFFFFFF)

    -- v2: 24-bit white text, 24-bit black bg
    emu.drawString(8, 18, "v2: w24 + bg24", 0xFFFFFF, 0x000000)

    -- v3: 24-bit white text, 24-bit black bg, frame_count=1
    emu.drawString(8, 28, "v3: w24 + bg + f1", 0xFFFFFF, 0x000000, 1)

    -- v4: Yellow text to be obvious
    emu.drawString(8, 38, "v4: YELLOW",     0xFFFF00)

    -- v5: 0x80 alpha (might mean half-opaque in some encodings)
    emu.drawString(8, 48, "v5: 0x80white",  0x80FFFFFF)

    -- v6: omit bg, larger y for visibility
    emu.drawString(8, 58, "v6 NO BG",       0xFFFFFF)

    if frame % 60 == 0 then emu.log("frame " .. frame) end
end

emu.addEventCallback(draw, emu.eventType.endFrame)
emu.displayMessage("Test", "round 2 — check which variants are visible")

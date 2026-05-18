# External tools used by the Nobunaga annotation work

Third-party tools used in disassembly live outside the vault in `~/source/repos/`, with their own git history. This file is the pointer so future-you (and future Claude) knows where to find them.

## nes-disasm6

NES ROM disassembler. Used to produce the initial bytecode walk that the chapter pages build on.

- **Location:** `C:\Users\Chris.Isaacson\source\repos\nes-disasm6\`
- **Upstream:** https://github.com/mcgrew/nes-disasm6
- **Entry point:** `disasm.py`
- **Install:** `git clone https://github.com/mcgrew/nes-disasm6.git ~/source/repos/nes-disasm6`

Local tools in this folder (`tools/`) — `dispatch-logger.lua`, `zp-harvest.py`, etc. — are project-specific and stay tracked in the vault. External tooling stays outside.

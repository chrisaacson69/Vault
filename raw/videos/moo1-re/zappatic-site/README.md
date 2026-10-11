---
source: https://zappatic.net/moo
author: zappatic
title: Master of Orion Savegame Editor — struct/symbol definitions
clipped: 2026-10-11
type: web-artifact
---
# zappatic MOO savegame editor — captured definitions

The editor at https://zappatic.net/moo is a generic binary viewer ("zapdebugger" `Project` +
`TreeView`) driven by two JSON files. Local copies here are **gitignored** (third-party work, public
vault); re-fetch from the URLs below.

| File | URL | Bytes | Role |
|---|---|---|---|
| `zapbinanalysis-moo.json` | https://zappatic.net/js/moo/zapbinanalysis-moo.json | 5,836 | **Savegame (`SAVEn.GAM`) block order** — 16 blocks, e.g. `planet[108]`, `ship-en-route[260]`, `ship-transport[100]`, `player[6]`, then `u16[108]` pop/base/factory arrays. Imports the struct library below. |
| `zapdebugger-moo.json` | https://zappatic.net/js/moo/zapdebugger-moo.json | 107,305 | **RAM symbol file** for his debugger: `crc32` `0xBF0B8580`; symbols as segment base + offset (e.g. seg `6813`: `planets`@`2C60`, `ships-and-research`@`7A40`, `ship-transports`@`94F0`, `ships-en-route`@`9C30`; seg `3813`: `players`@`A01E`, `gamestate`@`F396`); 16 structs (`planet` 86 fields, `player` 193, `events` 332, `gamestate-RAM` 86); 40 enums (races, techs, ship parts, events, personalities…). |
| `moo.js` (imported by the above) | https://zappatic.net/js/moo/moo.js | — | 404 on 2026-10-11 |

Struct field types: `u8/u16/u32/s8/s16/s32/bool8/16/32/char`; near pointers are 2 bytes
(`project.js`, https://zappatic.net/js/zapdebugger/project.js). Many fields still `unknownN`.

**Open:** the `crc32` does not match the Steam v1.3 binaries (ORION.EXE `0x6237FE7B`,
STARMAP.EXE `0x63B00693`) — likely computed over something else (loaded image? different build?).
Unresolved; check the VODs (Part 1 opens with "I've already gotten the CRC").

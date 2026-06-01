export const meta = {
  name: 'data-walk',
  description: 'Name a batch of anonymous DATA elements (ROM tables / RAM-SRAM vars): propose from the referencing named subs -> independent verify at the bytes/bytecode. The variable-side twin of label-walk. Returns verified survivors for root to write.',
  phases: [
    { title: 'Propose', detail: 'one agent per data addr reads its referencing named subs + decompiled C -> proposes what the data IS + a name' },
    { title: 'Verify', detail: 'one independent agent per proposal drops to the raw bytes + the referencing bytecode to confirm/amend/refute the data role' },
  ],
}

// ── args (from the data-walk skill) ──────────────────────────────────────────
//   region  : "rom" | "ram"          — ROM table/blob ($8000+, [prg.bankN]) vs RAM/SRAM var ($6000-$7FFF, [ram])
//   targets : [{addr, refsubs?, preview?, rw?}]
//              addr    : 4-hex, no $ (e.g. B0BA)
//              refsubs : the NAMED subs that read/write it (from `rom-xref refs`/`data-xref refs`) — the provenance
//              preview : first bytes (rom) or R/W counts (ram) — a cheap shape hint
//              rw      : "R"/"W"/"RW" for ram vars
//   seeds   : string?  — extra context (field maps, the region's known structure)
// Returns { region, verified:[{addr, final_name, verdict, confidence, summary, evidence}] }.
// ROOT (the skill, single writer) writes survivors to mesen-labels.toml + runs the regen guard.
// The workflow NEVER writes files — verification flows lateral (independent, lower altitude), not up.

const A = typeof args === 'string' ? JSON.parse(args) : (args || {})
const region = (A.region || 'rom').toLowerCase()
const targets = A.targets || []
const seeds = A.seeds ? `\n\nKNOWN CONTEXT / region structure (anchors):\n${A.seeds}` : ''
const isRom = region === 'rom'

const CAVEATS = `
PROJECT CAVEATS (do not re-trip):
- The DATA-WALK PREMISE: a data element's meaning is inferred from the NAMED sub(s) that reference it. A 'play_growth_animation' sub that reads blob_X => blob_X is the growth animation. Name from the referencer, not from squinting at bytes.
- VAGUE-BUT-CORRECT BEATS SPECIFIC-BUT-WRONG. If the exact semantics aren't earned, a domain+pattern name (e.g. <refsub>_data_<addr>, or "..._rate_table") with the shape in the COMMENT is the right answer, NOT a confident guess. There is ALWAYS an honest provenance name available for data (unlike code), so REFUTED -> <refsub>_data_<addr>, never an invented purpose.
- Province record is the LIVE $7001 map: gold@+0 ... output@+8 (anchored by verified effect_grow) ... header@+24. 26 bytes, idx*26, 16-bit LE. Do NOT confuse with the ROM scenario-DEFAULTS table (header-first @+0) dump-defaults.py reads — two REPRESENTATIONS of one record (endianness + field order differ). If an offset/value conflicts, suspect a representation mismatch first.
- ROM strings are an ORACLE (the decoded ASCII IS the bytes) — they are handled deterministically by 'rom-xref strings --toml', NOT by this workflow. You only see the analytical residue (numeric tables / opaque vars).
- Launcher is 'py -3' (NOT 'python' — not on PATH; silent failure). Run all tools from the project root.`

const PROPOSE_SCHEMA = {
  type: 'object', additionalProperties: false, required: ['proposals'],
  properties: {
    proposals: {
      type: 'array',
      items: {
        type: 'object', additionalProperties: false,
        required: ['addr', 'name', 'evidence', 'confidence'],
        properties: {
          addr: { type: 'string', description: '4-hex address, no $' },
          name: { type: 'string', description: 'snake_case name for the DATA: what it holds (noun), e.g. strategic_map_fief_x, gold_rice_exchange_rate, combat_map_palette. Fall back to <refsub>_data_<addr> if the role is not earned.' },
          evidence: { type: 'string', description: 'which named sub references it and HOW (index expr, field, count), + the byte/value shape — the basis for the name' },
          confidence: { enum: ['HIGH', 'MED', 'LOW'] },
        },
      },
    },
  },
}

const VERDICT_SCHEMA = {
  type: 'object', additionalProperties: false,
  required: ['addr', 'final_name', 'verdict', 'confidence', 'summary', 'evidence'],
  properties: {
    addr: { type: 'string' },
    final_name: { type: 'string', description: 'the name to write; on REFUTED use <refsub>_data_<addr> (the honest provenance name)' },
    verdict: { enum: ['CONFIRMED', 'AMENDED', 'REFUTED'] },
    confidence: { enum: ['HIGH', 'MED', 'LOW'] },
    summary: { type: 'string', description: 'ONE line (<=220 chars), the CONCLUSION: what the data holds + its shape (length/stride/encoding) + which sub uses it. Written verbatim as the toml comment — clean human description, no "Bytes @ ..." preamble.' },
    evidence: { type: 'string', description: 'the full basis: the referencing bytecode/index math + the raw bytes/value range (kept in the run log, not the toml)' },
  },
}

const proposePrompt = (t) => `You are STAGE 2 (symbol-table) of the DATA-WALK for Nobunaga's Ambition (NES) — the variable-side twin of the code label-walk. Propose a name for the ${isRom ? 'ROM data element (table/blob)' : 'RAM/SRAM variable'} at $${t.addr} by reading the NAMED sub(s) that reference it.

Project root is the cwd.
Provenance (named referencers): ${t.refsubs || '(run the xref tool yourself)'}
Shape hint: ${t.preview || '(unknown)'}${t.rw ? `   access: ${t.rw}` : ''}

For $${t.addr}:
1. Find its referencers: ${isRom
    ? `py -3 tools/rom-xref.py refs ${t.addr}`
    : `py -3 tools/data-xref.py refs ${t.addr}`}   (groups by NAMED sub — this is the provenance).
2. Read those subs in decompiled/bank_NN.c — HOW is $${t.addr} used? The index expression (idx*stride, fief_to_mapid(x)+base => per-fief table), the field it feeds, the loop count, whether it's a rate/coord/palette/flag.
3. ${isRom
    ? `Inspect the bytes: py -3 tools/rom-xref.py refs ${t.addr} shows a preview; note length (distance to the next labeled addr) + value range + encoding (ASCII? LE ptrs? small ints?).`
    : `Note R vs W sites: where it is WRITTEN sets its meaning, where READ shows consumers. A turn-rolled value, a cursor, a bitfield, a resource triple?`}
4. Propose a NOUN name for what it HOLDS (not what it is near). HIGH only if the referencer makes the role unambiguous; else MED with a domain+pattern name; LOW falls back to <refsub>_data_$${t.addr}. Do NOT inflate — the verifier arbitrates.
${seeds}
${CAVEATS}

Return ONLY the structured proposals. Your output IS data for the verifier, not prose.`

const verifyPrompt = (p) => `You are STAGE 3 (the independent verifier / typecheck) for the DATA-WALK of Nobunaga's Ambition. A PROPOSER named $${p.addr} "${p.name}" (confidence ${p.confidence}). INDEPENDENTLY confirm, amend, or refute by dropping to a LOWER altitude than the proposer — the RAW BYTES + the referencing BYTECODE (ground truth; the C is lossy). Be skeptical; the name must be earned by how the data is actually used.

Project root is the cwd. Do NOT trust the proposer's reading. Instead:
1. Re-derive the referencers yourself: ${isRom ? `py -3 tools/rom-xref.py refs $${p.addr}` : `py -3 tools/data-xref.py refs $${p.addr}`}
2. Read the referencing sub's BYTECODE (disasm/bank_NN_vm.asm, the '; sub $ADDR' block) — confirm the index math / access pattern that the name claims. ${isRom ? 'Confirm the table length (where does it end? next labeled addr) and the value encoding from the raw bytes.' : 'Confirm WRITE vs READ direction (the $A8 store family renders subtly) and what value it is assigned.'}
3. Optional cross-check: py -3 tools/vm_decompile.py disasm/bank_NN_vm.asm $<refsub>.

If a HIGH claim maps to a known struct/formula (province field map, a verified econ rate, a map-coordinate table), that is a deterministic ORACLE match — say so, highest confidence. A strong extra check for a claimed coordinate/index table: cross-reference an independent ground truth (e.g. adjacency, known counts) and report whether it agrees.

Verdicts:
- CONFIRMED: bytes + referencing bytecode support the name as-is.
- AMENDED: real role but wrong/imprecise name -> give the correct final_name.
- REFUTED: role not earned -> final_name = "<refsub>_data_${p.addr.toLowerCase()}" (the honest provenance name; data ALWAYS has one).
Return a one-line 'summary' (the CONCLUSION) — written verbatim as the toml comment; clean human description (what it holds + shape + user sub), no preamble.
Proposer evidence (reference, NOT authority): ${p.evidence}
${seeds}
${CAVEATS}

Return ONLY the structured verdict.`

// ── run: pipeline so each target verifies as soon as its propose returns ──────
phase('Propose')
const perTarget = await pipeline(
  targets,
  (t) => agent(proposePrompt(t), { label: `propose:${t.addr}`, phase: 'Propose', schema: PROPOSE_SCHEMA }),
  (res) => parallel(((res && res.proposals) || []).map(p => () =>
    agent(verifyPrompt(p), { label: `verify:${p.addr}`, phase: 'Verify', schema: VERDICT_SCHEMA }))),
)

const verified = perTarget.flat().filter(Boolean)
const tally = verified.reduce((m, v) => (m[v.verdict] = (m[v.verdict] || 0) + 1, m), {})
log(`data-walk ${region}: ${verified.length} verified (${JSON.stringify(tally)})`)
return { region, verified }

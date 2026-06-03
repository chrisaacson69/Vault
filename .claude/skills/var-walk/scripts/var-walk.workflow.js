export const meta = {
  name: 'var-walk',
  description: 'Name a batch of subs\' frame slots (arg1..arg4 / localN): propose-by-role@C -> independent verify@bytecode + caller-propagation. Returns per-slot verdicts for root to write.',
  phases: [
    { title: 'Propose', detail: 'one agent per sub reads its decompiled C + callers -> proposes a role name for each positional slot' },
    { title: 'Verify', detail: 'one independent agent per sub drops to bytecode + caller pushes to confirm/amend/refute each slot' },
  ],
}

// ── args (from the var-walk skill / var-walk-prep.py) ────────────────────────
//   bank  : int                          — code bank (0,1,2,15)
//   subs  : [{addr, name, slots:[...]}]   — a BATCH of NAMED subs with positional slots
//   seeds : string?                       — role-inference vocabulary (province fields, helper
//                                           arg semantics, the conservatism rule)
// Returns { bank, verified:[{addr, name, slots:[{slot,final_name,verdict,confidence,summary}]}] }.
// ROOT (var-walk-apply.py, single writer) writes [vars.bankN."0xADDR"] sections + runs the regen
// guard. The workflow NEVER writes files — verification flows lateral (lower-altitude bytecode).

const A = typeof args === 'string' ? JSON.parse(args) : (args || {})
const bank = A.bank
const bb = String(bank).padStart(2, '0')
const subs = A.subs || []
const seeds = A.seeds ? `\n\n${A.seeds}` : ''
// single=true -> ONE fused agent per sub (propose+verify in one) instead of the
// 2-agent propose->verify pipeline. Halves agent count + token pressure (use when
// rate-limited); trades the independent-verifier altitude for economy, per Chris.
const single = !!A.single

const CAVEATS = `
PROJECT CAVEATS (do not re-trip):
- A frame slot is named by its ROLE, not its number. The SAME slot number means different things in different subs.
- Province record (LIVE $7001 map): gold@+0, output@+8 (verified anchor), header@+24 (dev ceiling). 26 bytes, idx*26, 16-bit LE. NOT the ROM defaults table (header-first) dump-defaults.py reads.
- Launcher is 'py -3' (NOT 'python'). Run all tools from the project root (cwd).`

const PROPOSE_SCHEMA = {
  type: 'object', additionalProperties: false, required: ['addr', 'slots'],
  properties: {
    addr: { type: 'string', description: '4-hex stub address, no $' },
    slots: {
      type: 'array',
      items: {
        type: 'object', additionalProperties: false, required: ['slot', 'name', 'role', 'confidence'],
        properties: {
          slot: { type: 'string', description: 'the positional token being named: arg1..arg4 or localN' },
          name: { type: 'string', description: 'snake_case role name (fief, amount, gain, idx, drain_pct). Leave as the SAME positional token (e.g. "local10") if it is reused scratch with no single role.' },
          role: { type: 'string', description: 'the usage that justifies the name: fields deref\'d, helper args, caller-pushed expression, loop/accumulator pattern' },
          confidence: { enum: ['HIGH', 'MED', 'LOW'] },
        },
      },
    },
  },
}

const VERDICT_SCHEMA = {
  type: 'object', additionalProperties: false, required: ['addr', 'name', 'slots'],
  properties: {
    addr: { type: 'string' },
    name: { type: 'string', description: 'the sub\'s function name (echo from input, for the section comment)' },
    slots: {
      type: 'array',
      items: {
        type: 'object', additionalProperties: false, required: ['slot', 'final_name', 'verdict', 'confidence', 'summary'],
        properties: {
          slot: { type: 'string' },
          final_name: { type: 'string', description: 'the name to write for this slot; on REFUTED this is ignored (slot stays positional)' },
          verdict: { enum: ['CONFIRMED', 'AMENDED', 'REFUTED'], description: 'REFUTED = leave positional (reused scratch / not enough evidence)' },
          confidence: { enum: ['HIGH', 'MED', 'LOW'] },
          summary: { type: 'string', description: 'ONE short line (<=140 chars): what this slot holds + the evidence. Becomes the toml comment verbatim.' },
        },
      },
    },
  },
}

const proposePrompt = (s) => `You are STAGE 2 (symbol-table, variable side) of a multi-pass decompiler labeling bank_${bb} of Nobunaga's Ambition (NES). The sub $${s.addr} is "${s.name}" — already understood. Propose a ROLE NAME for each of its positional frame slots by READING ITS DECOMPILED C and its CALLERS.

Project root is the cwd. Slots to name in $${s.addr}: ${s.slots.join(', ')}

Steps:
1. Read the body in decompiled/bank_${bb}.c — find the '${s.name}(' definition and read it.
2. For each slot, infer its role from HOW it is used:
   - args: what fields/helpers consume it; AND run  py -3 tools/native-call-index.py callers ${s.addr}  then read those call sites in decompiled/bank_${bb}.c to see the EXPRESSION each caller pushes into that arg (caller-propagation — strong evidence).
   - locals: how it is computed and consumed across the whole body.
3. Give a snake_case role name (fief, amount, gain, idx, drain_pct, total, ...).
CONSERVATISM: if a slot is REUSED for two disjoint roles (e.g. headroom THEN a drain%), DO NOT name it — set name to the same positional token (e.g. "local10"). That is correct, not a miss.
${seeds}
${CAVEATS}

Return ONLY the structured proposals. Your output IS data for the verifier.`

const verifyPrompt = (s, p) => `You are STAGE 3 (independent verifier / typecheck, variable side) for $${s.addr} "${s.name}" in bank_${bb} of Nobunaga's Ambition. A PROPOSER named its frame slots from the decompiled C. INDEPENDENTLY confirm/amend/refute EACH slot by dropping to a LOWER altitude — the raw BYTECODE (ground truth; the C is lossy) — and by checking caller-propagation yourself. Be skeptical; a slot name must be EARNED by its actual use.

Project root is the cwd. Do NOT trust the proposer's C reading. Instead:
1. Read the sub's BYTECODE: disasm/bank_${bb}_vm.asm, find '; sub $${s.addr}', read the instruction block — which frame offsets ($00-$3F quick slots, $81-$A3 frame ops) are loaded/stored/pushed, and into what (province field via $7001+idx*26, a host_call arg, a loop counter).
2. Caller-propagation: py -3 tools/native-call-index.py callers ${s.addr} — read the pushes at each call site in decompiled/bank_${bb}.c. The expression a caller pushes into an arg slot is strong evidence of its role.
3. Optionally re-derive the C: py -3 tools/vm_decompile.py disasm/bank_${bb}_vm.asm ${s.addr}

Per slot verdict:
- CONFIRMED: bytecode + callers support the proposed name.
- AMENDED: real role, wrong/imprecise name -> give the correct final_name.
- REFUTED: reused scratch (two disjoint roles) OR not enough evidence -> the slot STAYS POSITIONAL (final_name ignored; say why in summary).
Each slot's 'summary' (<=140 chars) is written verbatim as the toml comment.
Proposer's proposals (reference, NOT authority): ${JSON.stringify(p && p.slots || [])}
${seeds}
${CAVEATS}

Return ONLY the structured verdict.`

// Fused single-agent prompt: propose AND self-verify against bytecode in one pass.
const fusedPrompt = (s) => `You name the positional frame slots of sub $${s.addr} "${s.name}" in bank_${bb} of Nobunaga's Ambition (NES) — you are BOTH proposer and verifier in one pass (token-economy mode). Give each slot a role name backed by BYTECODE + caller evidence, not a guess.

Project root is the cwd. Slots to name in $${s.addr}: ${s.slots.join(', ')}

Steps (be efficient — one tool pass each):
1. Read the body in decompiled/bank_${bb}.c — find '${s.name}(' and read it.
2. Confirm against bytecode where a slot's role is non-obvious: disasm/bank_${bb}_vm.asm, find '; sub $${s.addr}' (which frame offset each slot is, how loaded/stored/pushed).
3. Caller-propagation: py -3 tools/native-call-index.py callers ${s.addr} — the expression each caller pushes into an arg slot is strong evidence.

Name each slot by its ROLE (fief, amount, gain, idx, rate, total, ...). Verdict per slot:
- CONFIRMED: bytecode/callers clearly support a role name (give it as final_name).
- AMENDED: real role, refined name (final_name = the better name).
- REFUTED: REUSED scratch (two disjoint roles) OR not enough evidence -> stays positional (final_name ignored; say why in summary).
Each slot's 'summary' (<=140 chars) becomes the toml comment verbatim.
${seeds}
${CAVEATS}

Return ONLY the structured verdict.`

// ── run ──────────────────────────────────────────────────────────────────────
if (single) {
  phase('Name')
  const out = await pipeline(
    subs,
    (s) => agent(fusedPrompt(s), { label: `name:${s.addr}`, phase: 'Name', schema: VERDICT_SCHEMA }),
  )
  const verified = out.filter(Boolean)
  const slotTally = verified.reduce((m, v) => {
    for (const sl of (v.slots || [])) m[sl.verdict] = (m[sl.verdict] || 0) + 1
    return m
  }, {})
  log(`bank_${bb} (single-agent): ${verified.length} subs, slot verdicts ${JSON.stringify(slotTally)}`)
  return { bank, verified }
}

// ── run: pipeline so each sub verifies as soon as its propose returns ─────────
phase('Propose')
const out = await pipeline(
  subs,
  (s) => agent(proposePrompt(s), { label: `propose:${s.addr}`, phase: 'Propose', schema: PROPOSE_SCHEMA })
           .then(p => ({ s, p })),
  ({ s, p }) => agent(verifyPrompt(s, p), { label: `verify:${s.addr}`, phase: 'Verify', schema: VERDICT_SCHEMA }),
)

const verified = out.filter(Boolean)
const slotTally = verified.reduce((m, v) => {
  for (const sl of (v.slots || [])) m[sl.verdict] = (m[sl.verdict] || 0) + 1
  return m
}, {})
log(`bank_${bb}: ${verified.length} subs verified, slot verdicts ${JSON.stringify(slotTally)}`)
return { bank, verified }

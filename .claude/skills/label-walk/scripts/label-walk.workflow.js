export const meta = {
  name: 'label-walk',
  description: 'Name a batch of a bank\'s anonymous decompiled subs: propose@C -> independent verify@bytecode. Returns verified survivors for root to write.',
  phases: [
    { title: 'Propose', detail: 'one agent per cluster reads decompiled C bodies + call-graph -> proposes functional names' },
    { title: 'Verify', detail: 'one independent agent per proposal drops to bytecode to confirm/amend/refute' },
  ],
}

// ── args (from the label-walk skill) ─────────────────────────────────────────
//   bank     : int            — code bank (0,1,2,15)
//   clusters : [{name,addrs}]  — a BATCH from `cluster-anon-subs.py <bank> --json`
//                                (pass a slice; regen between batches is the fixpoint loop)
//   seeds    : string?         — known named callees / context to inject (OPTIONAL,
//                                degrades gracefully; bank_00 has almost none)
//   oracle   : string?         — formula/data-struct hints for the deterministic-match
//                                lane (OPTIONAL; oracle-rich banks like 01 only)
// Returns { bank, verified:[{addr,final_name,verdict,confidence,evidence}] }.
// ROOT (the skill, single writer) writes survivors to mesen-labels.toml + runs the
// regen guard. The workflow NEVER writes files — verification flows lateral, not up.

// args may arrive as an object OR a JSON string (the harness sometimes stringifies it) — normalize.
const A = typeof args === 'string' ? JSON.parse(args) : (args || {})
const bank = A.bank
const bb = String(bank).padStart(2, '0')
const clusters = A.clusters || []
const seeds = A.seeds ? `\n\nKNOWN SEEDS / already-named callees (use as anchors; leaves-first means many callees are named):\n${A.seeds}` : ''
const oracle = A.oracle ? `\n\nORACLE HINTS (if a sub's behavior maps to one of these known formulas/structs, say so — that is a deterministic match, highest confidence):\n${A.oracle}` : ''

// caveats every agent must hold (ROADMAP step 3) ─────────────────────────────
const CAVEATS = `
PROJECT CAVEATS (do not re-trip):
- Province record is the LIVE $7001 map: gold@+0, ... output@+8 (anchored by verified effect_grow), ... header@+24 (base koku/dev ceiling). 26 bytes, idx*26, 16-bit LE.
- Do NOT confuse it with the ROM scenario-DEFAULTS table (header-first @+0) that dump-defaults.py reads. ROM and SRAM are TWO REPRESENTATIONS of one record (endianness + field order differ); boot init transforms ROM->SRAM. If an offset/value seems to conflict, first ask which representation it is — usually a representation mismatch, not a contradiction.
- Launcher is 'py -3' (NOT 'python' — not on PATH; silent failure). Run all tools from the project root.`

const PROPOSE_SCHEMA = {
  type: 'object',
  additionalProperties: false,
  required: ['proposals'],
  properties: {
    proposals: {
      type: 'array',
      items: {
        type: 'object',
        additionalProperties: false,
        required: ['addr', 'name', 'evidence', 'confidence'],
        properties: {
          addr: { type: 'string', description: '4-hex address, no $ (e.g. 8003)' },
          name: { type: 'string', description: 'snake_case functional name (verb_noun); what it DOES, not what it is near' },
          evidence: { type: 'string', description: 'fields touched / host_calls / callers — the basis for the name' },
          confidence: { enum: ['HIGH', 'MED', 'LOW'] },
        },
      },
    },
  },
}

const VERDICT_SCHEMA = {
  type: 'object',
  additionalProperties: false,
  required: ['addr', 'final_name', 'verdict', 'confidence', 'evidence'],
  properties: {
    addr: { type: 'string' },
    final_name: { type: 'string', description: 'the name to write; on REFUTED use helper_<addr>' },
    verdict: { enum: ['CONFIRMED', 'AMENDED', 'REFUTED'] },
    confidence: { enum: ['HIGH', 'MED', 'LOW'] },
    evidence: { type: 'string', description: 'what the BYTECODE showed; cite opcodes/ext_ops/callers' },
  },
}

const proposePrompt = (cluster) => `You are STAGE 2 (symbol-table) of a multi-pass decompiler labeling bank_${bb} of Nobunaga's Ambition (NES). Propose functional names for these anonymous bytecode subs by READING THEIR DECOMPILED C.

Project root is the cwd. Subs to name (addresses): ${cluster.addrs.map(a => '$' + a).join(', ')}

For EACH address:
1. Read its body in decompiled/bank_${bb}.c — find 'word sub_<ADDR>(' and read the function.
2. Run: py -3 tools/native-call-index.py callers <ADDR>   and   py -3 tools/native-call-index.py calls <ADDR>
   (who calls it = its purpose; what it calls = named callees give it meaning).
3. Propose a snake_case verb_noun name describing what it DOES (e.g. ai_calc_men_surplus, province_window_redraw). NOT what it sits near. Cite the province fields it touches (->output etc.), host_calls, and callers as evidence. Confidence HIGH only if the body + call-graph make the function unambiguous; MED if plausible; LOW if a structural guess (the verifier will arbitrate, so don't inflate).
${seeds}${oracle}
${CAVEATS}

Return ONLY the structured proposals. Your output IS data for the verifier, not prose for a human.`

const verifyPrompt = (p) => `You are STAGE 3 (the independent verifier / typecheck) for bank_${bb} of Nobunaga's Ambition. A PROPOSER named sub_$${p.addr} "${p.name}" (confidence ${p.confidence}) from the decompiled C. Your job is to INDEPENDENTLY confirm, amend, or refute it by dropping to a LOWER altitude than the proposer used — the raw BYTECODE, which is ground truth (the C is lossy: host_calls/ext_ops can render as ?). Be skeptical; default to demanding the name be earned.

Project root is the cwd. Do NOT trust the C the proposer read. Instead:
1. Read the sub's BYTECODE: open disasm/bank_${bb}_vm.asm, find the '; sub $${p.addr}' marker, read its instruction block (opcodes, ext_ops, host_calls, frame locals).
2. Cross-check the call-graph independently: py -3 tools/native-call-index.py callers $${p.addr}  and  calls $${p.addr}
3. Optionally confirm against C: py -3 tools/vm_decompile.py disasm/bank_${bb}_vm.asm $${p.addr}

Verdicts:
- CONFIRMED: bytecode supports the proposed name as-is.
- AMENDED: the function is real but the name is wrong/imprecise -> give the correct final_name.
- REFUTED: not enough evidence to name by purpose -> final_name = "helper_${p.addr}".
Proposer evidence (for reference, NOT authority): ${p.evidence}
${seeds}
${CAVEATS}

Return ONLY the structured verdict.`

// ── run: pipeline so each cluster verifies as soon as its propose returns ─────
phase('Propose')
const perCluster = await pipeline(
  clusters,
  (cluster) => agent(proposePrompt(cluster), { label: `propose:${cluster.name}`, phase: 'Propose', schema: PROPOSE_SCHEMA }),
  (res, cluster) => parallel(((res && res.proposals) || []).map(p => () =>
    agent(verifyPrompt(p), { label: `verify:${p.addr}`, phase: 'Verify', schema: VERDICT_SCHEMA }))),
)

const verified = perCluster.flat().filter(Boolean)
const tally = verified.reduce((m, v) => (m[v.verdict] = (m[v.verdict] || 0) + 1, m), {})
log(`bank_${bb}: ${verified.length} verified (${JSON.stringify(tally)})`)
return { bank, verified }

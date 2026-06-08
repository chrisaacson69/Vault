---
status: active
created: 2026-06-08
---
# Author Web, Derive Hierarchy
> Exploratory work **discovers** its structure — you cannot file a shape you don't yet know. So keep the substrate **write-optimized** (a web: forward links, flat-ish folders, cheap to add in unknown directions) and **derive** the read-optimized hierarchy — indexes, two-way ledgers, the orphan audit — with tooling, *after* the shape emerges. Never tax the exploration to pay for the tidiness. A sprawling vault that's hard to manage *because it has covered so much* is succeeding: the difficulty is the **cost of compounding generativity**, paid down by deriving, not by suppressing.

**Links:** [The Anchor Method](./anchor-method.md) (grounding is a maturity axis — projects start "ohh neat" because *you* aren't grounded in what the thing is yet), [Specimen & Thesis — The Two-Altitude Ledger](./specimen-and-thesis.md) (the ledger this principle says to *generate*, not hand-maintain), [NA1 — A Game-Design Crucible](../research/gaming/nobunaga-crucible.md) (the worked "let it sprawl, then index" instance)

## The tradeoff is read vs write

This is the data-structures tradeoff: *index vs log*, *B-tree vs LSM-tree*, *normalized vs denormalized*. **Hierarchy** is a read-optimized index — cheap retrieval, small working set, expensive to modify (you pay the reorg). **Web** is a write-optimized log — append-cheap, direct-access if you hold the pointer, but unindexed it forces a full scan. The instinct to build hierarchy is the instinct to make *retrieval* cheap; the cost is paid at every *edit*.

## The false binary, resolved the way search engines resolved it

Nobody actually chooses. Google didn't make authors file the web into a tree — it let the web stay a write-optimized mess and **derived** a read-optimized index over it (inverted index + PageRank, which is *literally deriving a hierarchy from the link graph*). Databases keep the table as truth and let the engine maintain the index. **Keep the web as source of truth AND have the hierarchy — but derive it, don't author it.** The mistake is hand-maintaining the index: every reciprocal link, ledger entry, and INDEX/tag update is a deterministic function of forward-links + frontmatter. That's index maintenance — the engine's job, not the author's.

## Why exploratory work *forces* the web

You cannot author a hierarchy for a shape you haven't discovered. NA1 began ambitious-but-tractable and **radiated** into agent design, LLM grounding, and bytecode-transpilation — none planned. pygone is the miniature: "ohh neat" → grows → covers ground nobody scoped. The structure is found by walking (*epic decomposition is discovered*). A tree demands the branches up front; exploration can't pay that, so its only fit is the substrate cheap to extend in unknown directions.

## Lateral radiation — why a tree actively *fails*

The management pain isn't depth, it's **lateral radiation**: one project spawns theses in *other* domains. NA1's randomness-termination is game design; its transpilation-as-grounding is LLM architecture; its multi-pass-RE is methodology. A **tree can't hold this** — each thesis lives in exactly one branch, so the cross-domain edges (the valuable part) get severed; that severing is *why a sprawling project feels untrackable*. A **web holds it natively** — the thesis links back to every source that fed it. The lived difficulty is proof a tree would be *worse*, not the cure. The **crucible pattern** is the answer: let the project sprawl, then build a hub that radiates *outward* to wherever the theses landed — you index a crucible after it's done being one.

## Exploration and derivation are both required

- **Exploration** grounds the operator — you start "ohh neat" because you don't yet know what the thing *is*; the walk is how you find out. Write-optimized, unpredictable, generative.
- **Derivation** extracts the portable thesis once grounded, and the organization that ties it back. Read-optimized, mechanical.

The friction is fast-exploration vs slow-manual-organization. Resolve it by making organization **deferred and derived** — never a gate on the next exploration.

## What derives, what doesn't (the load-bearing split)

- **Derive (tooling, deterministic):** backlinks / the two-way ledger, INDEX + tag indexes, the orphan + one-way-edge audit. A function of forward-links + frontmatter. The hierarchy becomes a **cache over the web** — rebuilt, not hand-edited. (Drift here is *reciprocity-without-regeneration* — the cache half of the [context-cache-hierarchy] lesson.)
- **Judge (human/LLM, genuine read):** what's portable enough to **promote**, and *what each specimen contributes*. This is the value; everything else is tax. (*Mechanical-vs-analytical*: function-of-an-artifact → generate it; genuine read → spend the judgment.)
- **Search the rest:** "I have the content but lost the link" is a search problem, not a filing problem — the failure that usually makes you reach for hierarchy in the first place.

## The difficulty is abundance

A vault hard to manage because it covered so much is doing its job. The compounding *is* the point — accumulated frameworks make each new analysis sharper (the Colorado-v-Trump argument that satisfied all parties and none, sharper than the court's, is the [verification-layer thesis] in action). That compounding is **inseparable from the sprawl.** So the move is never "cover less / tidy more"; it's **explore freely, derive the index, spend judgment on promotion.**

## Specimens & the build it specs

- This session's vault reorg — ~35 files of *mechanical* reciprocal-link/ledger/index wiring done by hand. That hand-work is exactly what this principle says to generate.
- [NA1 crucible](../research/gaming/nobunaga-crucible.md) and pygone — projects that radiated theses across domains; the lived case for web-over-tree.
- **The build:** a derive-the-ledger generator + audit gate — reads forward-links/frontmatter, emits backlinks + the two-way ledger, regenerates INDEX/tag indexes, and flags orphans / one-way edges (turning the agent-audits run this session into a deterministic check, Anchor-Method-style).

## Tags
[methodology](../tags/methodology.md)

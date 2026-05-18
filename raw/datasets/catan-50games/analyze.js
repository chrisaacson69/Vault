#!/usr/bin/env node
// analyze.js — empirical proof-of-method for the board-frontier theory against
// the lumins/settlers-of-catan-games dataset (50 four-player games, 200 rows).
//
// Source: https://github.com/DevinRS/Settlers_of_Catan_Analysis (mirror of the
// Kaggle dataset by user lumins). Original Kaggle URL:
// https://www.kaggle.com/datasets/lumins/settlers-of-catan-games
//
// Tests, as far as N=50 allows:
//   - Prediction 1: conditional on board archetype, winners cluster on
//     predicted strategy
//   - Prediction 3: classifier accuracy improves when board archetype is a
//     feature (vs Roman's placement-only 27% ceiling)
//   - Prediction 4 (partial): snake-position win-rate gap varies by board
//     archetype skew
//
// Outputs a summary report to stdout.

const fs = require('fs');
const path = require('path');

const CSV = path.join(__dirname, 'catanstats.csv');

// Pip weight (dice combinations) per number token. 7 = robber (no production).
const PIPS = { 2:1, 3:2, 4:3, 5:4, 6:5, 7:0, 8:5, 9:4, 10:3, 11:2, 12:1 };

// Resource letter → canonical name.
// Roads use Lumber (L) + Clay/Brick (C); cities use Wheat (W) + Ore (O);
// dev cards use Wheat + Sheep (S) + Ore. The "city engine" combines W+O+S;
// the "road engine" combines L+C.
const RES_NAME = { L:'wood', C:'brick', W:'wheat', S:'sheep', O:'ore', D:'desert' };
const CITY_ENGINE = new Set(['W','O','S']);
const ROAD_ENGINE = new Set(['L','C']);

// ---------- parse CSV ----------

const lines = fs.readFileSync(CSV, 'utf8').trim().split(/\r?\n/);
const rows = lines.slice(1).map(l => l.split(','));

// Per the inspected header: 11 cols of pre-settlement data + 6 cols
// settlement1 (num,res × 3) + 6 cols settlement2 + tail stats.
// Layout (0-indexed): gameNum, player, points, me, [roll counts 2..12],
//   s1: t1num,t1res,t2num,t2res,t3num,t3res,  s2: same,  then production..totalAvailable.
const COL = {
  game: 0, player: 1, points: 2, me: 3,
  s1: [15, 16, 17, 18, 19, 20],   // num,res,num,res,num,res
  s2: [21, 22, 23, 24, 25, 26],
  production: 27, tradeGain: 28, robberGain: 29, totalGain: 30,
  tradeLoss: 31, robberLoss: 32, tribute: 33, totalLoss: 34, totalAvailable: 35
};

// ---------- helpers ----------

function tileExposures(r, cols) {
  // Returns array of { res, num, pip } for the 3 hexes adjacent to a settlement.
  const out = [];
  for (let i = 0; i < 6; i += 2) {
    const numRaw = r[cols[i]];
    const resRaw = r[cols[i + 1]];
    const num = parseInt(numRaw, 10);
    const res = (resRaw || '').trim();
    out.push({ res, num: isNaN(num) ? null : num, pip: isNaN(num) ? 0 : (PIPS[num] || 0) });
  }
  return out;
}

function playerProfile(r) {
  const game = parseInt(r[COL.game], 10);
  const player = parseInt(r[COL.player], 10);
  const points = parseInt(r[COL.points], 10);
  const tiles = [...tileExposures(r, COL.s1), ...tileExposures(r, COL.s2)];

  // Per-resource pip-weighted exposure (only counts standard resources).
  const expo = { wood:0, brick:0, wheat:0, sheep:0, ore:0 };
  let totalPip = 0;
  for (const t of tiles) {
    if (!RES_NAME[t.res] || t.res === 'D') continue;
    expo[RES_NAME[t.res]] += t.pip;
    totalPip += t.pip;
  }

  // Engine split.
  const cityEnginePip = expo.wheat + expo.ore + expo.sheep;
  const roadEnginePip = expo.wood + expo.brick;

  // Port adjacency flags.
  const ports = tiles.filter(t => t.res && (t.res === '3G' || /^2[LCWSO]$/.test(t.res)));

  return {
    game, player, points,
    production: parseInt(r[COL.production], 10) || 0,
    expo,
    totalPip,
    cityEnginePip,
    roadEnginePip,
    cityShare: totalPip ? cityEnginePip / totalPip : 0,
    portCount: ports.length
  };
}

const players = rows.map(playerProfile);

// Group by game.
const games = {};
for (const p of players) {
  if (!games[p.game]) games[p.game] = [];
  games[p.game].push(p);
}

// ---------- board-level features ----------
// We never see the full 19-tile board — only the 6 hex-adjacencies per
// player × 4 players = 24 hex-touches (with overlap). Aggregating these
// gives the "exposed board": what resources the *placements collectively
// reached*. This is a proxy for what the board's high-value resources are
// (good vertices for those resources got picked, low-value ones didn't).
// It's endogenous (players chose what to touch) but still informative.

for (const g of Object.values(games)) {
  const boardExpo = { wood:0, brick:0, wheat:0, sheep:0, ore:0 };
  for (const p of g) {
    for (const k of Object.keys(boardExpo)) boardExpo[k] += p.expo[k];
  }
  const total = Object.values(boardExpo).reduce((a,b)=>a+b, 0);
  const cityEnginePip = boardExpo.wheat + boardExpo.ore + boardExpo.sheep;
  const roadEnginePip = boardExpo.wood + boardExpo.brick;
  const cityShare = total ? cityEnginePip / total : 0;

  // Archetype: city-rich if cityShare > 0.62 (>62% of pips on W/O/S);
  // road-rich if cityShare < 0.55; balanced otherwise.
  // Thresholds chosen so each bin has at least a few games.
  let archetype;
  if (cityShare >= 0.62) archetype = 'city-rich';
  else if (cityShare <= 0.55) archetype = 'road-rich';
  else archetype = 'balanced';

  for (const p of g) p.boardArchetype = archetype;
  // attach to first player for game-level lookups
  g.archetype = archetype;
  g.cityShare = cityShare;
}

// ---------- outcomes ----------

const gameList = Object.values(games);
for (const g of gameList) {
  const maxPts = Math.max(...g.map(p => p.points));
  const winners = g.filter(p => p.points === maxPts);
  // Treat all max-points players as winners (rare ties; standard scoring still
  // a single winner because the player who reaches 10 first wins — but the
  // dataset only stores final-point totals, so multi-winner-by-points is
  // possible. We split credit equally.)
  for (const p of g) p.winCredit = winners.includes(p) ? 1 / winners.length : 0;
}

// ---------- summary stats ----------

function avg(xs) { return xs.length ? xs.reduce((a,b)=>a+b,0)/xs.length : 0; }

// (a) Aggregate replication of Roman: win rate by snake position.
const byPos = [1,2,3,4].map(pos => {
  const ps = players.filter(p => p.player === pos);
  return { position: pos, n: ps.length, winRate: avg(ps.map(p => p.winCredit)) };
});

// (b) Aggregate: winners' average city-share vs losers'.
const winners = players.filter(p => p.winCredit > 0);
const losers = players.filter(p => p.winCredit === 0);

const aggCityShareW = avg(winners.map(p => p.cityShare));
const aggCityShareL = avg(losers.map(p => p.cityShare));
const aggRoadShareW = avg(winners.map(p => 1 - p.cityShare));
const aggRoadShareL = avg(losers.map(p => 1 - p.cityShare));

// (c) Prediction 1: conditional on board archetype, do winners cluster on
//     the predicted strategy?
//     - On city-rich boards, winners should have HIGHER cityShare than losers.
//     - On road-rich boards, winners should have LOWER cityShare than losers.
//     - On balanced boards, the gap should be small.
const archStats = {};
for (const arch of ['city-rich','balanced','road-rich']) {
  const w = winners.filter(p => p.boardArchetype === arch);
  const l = losers.filter(p => p.boardArchetype === arch);
  archStats[arch] = {
    games: gameList.filter(g => g.archetype === arch).length,
    winners: w.length,
    losers: l.length,
    winnerCityShare: avg(w.map(p => p.cityShare)),
    loserCityShare: avg(l.map(p => p.cityShare)),
    winnerProduction: avg(w.map(p => p.production)),
    loserProduction: avg(l.map(p => p.production))
  };
}

// (d) Prediction 4 (partial): snake-position win-rate gap by board archetype.
const positionByArch = {};
for (const arch of ['city-rich','balanced','road-rich']) {
  positionByArch[arch] = [1,2,3,4].map(pos => {
    const ps = players.filter(p => p.player === pos && p.boardArchetype === arch);
    return { position: pos, n: ps.length, winRate: avg(ps.map(p => p.winCredit)) };
  });
}

// (e) Prediction 3 (simple): a 1-feature classifier that predicts the winner
//     of each game from per-player features.
//     - "placement-only": pick the player whose totalPip is highest.
//     - "placement + archetype": pick the player whose ALIGNMENT with the
//       board archetype is highest (cityEnginePip on city boards;
//       roadEnginePip on road boards; totalPip on balanced).
function evalClassifier(scoreFn) {
  let correct = 0;
  for (const g of gameList) {
    const scored = g.map(p => ({ p, s: scoreFn(p, g) }));
    const maxS = Math.max(...scored.map(x => x.s));
    const predicted = scored.filter(x => x.s === maxS).map(x => x.p);
    // Credit the prediction proportional to overlap with actual winners.
    let credit = 0;
    for (const pp of predicted) credit += pp.winCredit / predicted.length;
    // To compare against Roman's classifier (which is single-winner accuracy),
    // we treat the prediction as correct iff any predicted player has positive
    // win credit. Equivalent to "did the model pick a winner?"
    if (predicted.some(pp => pp.winCredit > 0)) correct += 1;
  }
  return correct / gameList.length;
}

const accPlacementOnly = evalClassifier(p => p.totalPip);
const accCitySharePure = evalClassifier(p => p.cityEnginePip); // bias toward city engine universally
const accArchetypeAware = evalClassifier((p, g) => {
  if (g.archetype === 'city-rich') return p.cityEnginePip;
  if (g.archetype === 'road-rich') return p.roadEnginePip;
  return p.totalPip;
});
// Baseline: random pick among 4 players = 0.25.

// ---------- print report ----------

function pct(x) { return (100*x).toFixed(1) + '%'; }
function f(x, n=2) { return Number(x).toFixed(n); }

console.log('# Catan 50-game empirical proof-of-method (board-frontier theory)\n');
console.log(`Dataset: 50 four-player games, ${players.length} player-rows.`);
console.log(`Boards classified by aggregate pip-share to city-engine resources (W+O+S):`);
const archCount = { 'city-rich':0, balanced:0, 'road-rich':0 };
for (const g of gameList) archCount[g.archetype]++;
console.log(`  city-rich  (cityShare ≥ 0.62): ${archCount['city-rich']} games`);
console.log(`  balanced   (0.55 < cityShare < 0.62): ${archCount.balanced} games`);
console.log(`  road-rich  (cityShare ≤ 0.55): ${archCount['road-rich']} games`);

console.log('\n## (a) Win rate by snake position (replicates Roman directionally)');
console.log('position  n   win-rate');
for (const b of byPos) console.log(`  P${b.position}     ${b.n}   ${pct(b.winRate)}`);

console.log('\n## (b) Aggregate winners vs losers (no conditioning)');
console.log(`  winner mean cityShare = ${f(aggCityShareW)}`);
console.log(`  loser  mean cityShare = ${f(aggCityShareL)}`);
console.log(`  Δ = ${f(aggCityShareW - aggCityShareL, 3)}   (Roman: aggregate slight winner bias toward city engine)`);

console.log('\n## (c) PREDICTION 1 — board-conditional winner archetype');
console.log('Expected: winners outperform on the engine that matches the board.');
console.log('archetype     games  win-cityShare  loser-cityShare  Δ(winner-loser)');
for (const arch of ['city-rich','balanced','road-rich']) {
  const s = archStats[arch];
  console.log(`  ${arch.padEnd(11)} ${String(s.games).padStart(3)}    ${f(s.winnerCityShare).padStart(5)}          ${f(s.loserCityShare).padStart(5)}           ${f(s.winnerCityShare - s.loserCityShare, 3).padStart(6)}`);
}
console.log('Direction-of-fit check:');
console.log(`  city-rich Δ should be POSITIVE: ${(archStats['city-rich'].winnerCityShare - archStats['city-rich'].loserCityShare > 0) ? '✅ yes' : '❌ no'}`);
console.log(`  road-rich Δ should be NEGATIVE: ${(archStats['road-rich'].winnerCityShare - archStats['road-rich'].loserCityShare < 0) ? '✅ yes' : '❌ no'}`);

console.log('\n## (d) PREDICTION 4 (partial) — snake-position by board archetype');
console.log('Expected: position-1-vs-position-4 gap WIDENS on archetype-skewed boards.');
console.log('archetype     P1     P2     P3     P4    range(P1-P4)');
for (const arch of ['city-rich','balanced','road-rich']) {
  const ps = positionByArch[arch];
  const range = ps[0].winRate - ps[3].winRate;
  console.log(`  ${arch.padEnd(11)} ${pct(ps[0].winRate).padStart(6)} ${pct(ps[1].winRate).padStart(6)} ${pct(ps[2].winRate).padStart(6)} ${pct(ps[3].winRate).padStart(6)}   ${f(range, 3).padStart(6)}`);
}

console.log('\n## (e) PREDICTION 3 — classifier ceiling lift');
console.log('Baseline (random pick among 4 players) = 25.0%');
console.log(`  placement-only (pick max totalPip):         ${pct(accPlacementOnly)}`);
console.log(`  city-engine-only (pick max cityEnginePip):  ${pct(accCitySharePure)}`);
console.log(`  archetype-aware (city/road engine by board): ${pct(accArchetypeAware)}`);
console.log(`Δ over placement-only: ${pct(accArchetypeAware - accPlacementOnly)} ${(accArchetypeAware > accPlacementOnly) ? '✅' : '❌'}`);

console.log('\n--- end report ---');

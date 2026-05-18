#!/usr/bin/env node
// scorecard.js — per-game deep-dive analyzer for the lumins/settlers-of-catan-games
// dataset. The CSV only has end-of-game aggregates (not per-turn), so this
// produces a per-player scorecard for each game.
//
// Usage:
//   node scorecard.js                    # all 50 games + cross-game summary
//   node scorecard.js 1 5 12             # specific game IDs
//   node scorecard.js --summary-only     # skip per-game cards, just the table
//   node scorecard.js --top 5            # 5 most-extreme games (lucky/unlucky boards)

const fs = require('fs');
const path = require('path');

const CSV = path.join(__dirname, 'catanstats.csv');

// ---------- dice pip weights ----------
// Number of dice combinations that produce each sum (out of 36).
const PIPS = { 2:1, 3:2, 4:3, 5:4, 6:5, 7:0, 8:5, 9:4, 10:3, 11:2, 12:1 };
const PIP_TOTAL = 36; // sum of all PIPS for production rolls (excluding 7)

const RES = { L:'wood', C:'brick', W:'wheat', S:'sheep', O:'ore', D:'desert' };
const CITY_ENGINE = new Set(['W','O','S']);

// Port adjacency markers (3:1 generic and 2:1 resource-specific).
const PORT_3G = '3G';
const PORT_2 = {
  '2L': 'wood', '2C': 'brick', '2W': 'wheat', '2S': 'sheep', '2O': 'ore'
};

// ---------- parse CSV ----------
const lines = fs.readFileSync(CSV, 'utf8').trim().split(/\r?\n/);
const rows = lines.slice(1).map(l => l.split(','));

const COL = {
  game: 0, player: 1, points: 2, me: 3,
  rollCounts: [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], // roll values 2..12
  s1: [15, 16, 17, 18, 19, 20],
  s2: [21, 22, 23, 24, 25, 26],
  production: 27, tradeGain: 28, robberGain: 29, totalGain: 30,
  tradeLoss: 31, robberLoss: 32, tribute: 33, totalLoss: 34, totalAvailable: 35
};

const ROLL_VALUES = [2,3,4,5,6,7,8,9,10,11,12];

function tileExposures(r, cols) {
  const out = [];
  for (let i = 0; i < 6; i += 2) {
    const numRaw = r[cols[i]];
    const resRaw = (r[cols[i + 1]] || '').trim();
    const num = parseInt(numRaw, 10);
    out.push({ res: resRaw, num: isNaN(num) ? null : num, pip: isNaN(num) ? 0 : (PIPS[num] || 0) });
  }
  return out;
}

function profile(r) {
  const game = parseInt(r[COL.game], 10);
  const player = parseInt(r[COL.player], 10);
  const points = parseInt(r[COL.points], 10);
  const tiles = [...tileExposures(r, COL.s1), ...tileExposures(r, COL.s2)];

  // Pip-weighted exposure per resource.
  const expo = { wood:0, brick:0, wheat:0, sheep:0, ore:0 };
  let pipTotal = 0;
  for (const t of tiles) {
    if (RES[t.res] && t.res !== 'D') {
      expo[RES[t.res]] += t.pip;
      pipTotal += t.pip;
    }
  }

  // Ports.
  const ports = {
    generic: tiles.filter(t => t.res === PORT_3G).length,
    specific: {} // resource → count
  };
  for (const t of tiles) {
    const portRes = PORT_2[t.res];
    if (portRes) ports.specific[portRes] = (ports.specific[portRes] || 0) + 1;
  }

  return {
    game, player, points,
    production: parseInt(r[COL.production], 10) || 0,
    tradeGain: parseInt(r[COL.tradeGain], 10) || 0,
    tradeLoss: parseInt(r[COL.tradeLoss], 10) || 0,
    robberGain: parseInt(r[COL.robberGain], 10) || 0,
    robberLoss: parseInt(r[COL.robberLoss], 10) || 0,
    totalGain: parseInt(r[COL.totalGain], 10) || 0,
    totalLoss: parseInt(r[COL.totalLoss], 10) || 0,
    totalAvailable: parseInt(r[COL.totalAvailable], 10) || 0,
    expo, pipTotal, ports,
    cityEnginePip: expo.wheat + expo.ore + expo.sheep,
    roadEnginePip: expo.wood + expo.brick
  };
}

const players = rows.map(profile);

// Group by game, attach game-level data.
const games = {};
for (const p of players) {
  if (!games[p.game]) games[p.game] = { players: [], rolls: {} };
  games[p.game].players.push(p);
}

// Roll counts are the same row-for-row within a game (recorded per player but same value).
// Use the first row of each game to get the histogram.
for (const r of rows) {
  const game = parseInt(r[COL.game], 10);
  if (!games[game].rolled) {
    const rolled = {};
    for (let i = 0; i < ROLL_VALUES.length; i++) {
      const v = ROLL_VALUES[i];
      rolled[v] = parseInt(r[COL.rollCounts[i]], 10) || 0;
    }
    games[game].rolled = rolled;
    games[game].totalRolls = Object.values(rolled).reduce((a,b)=>a+b, 0);
  }
}

// ---------- derived game metrics ----------
function gameMetrics(g) {
  // Board luck — how much did high-pip rolls (6, 8) come up vs. expectation?
  // Expected fraction of rolls = PIPS[v] / 36 for each value.
  // Productive-roll fraction expected = 30/36 = 83.3% (everything except 7).
  const totalRolls = g.totalRolls;
  const sevens = g.rolled[7];
  const productive = totalRolls - sevens;
  const expectedProductive = totalRolls * 30/36;
  const sevenLuck = sevens - totalRolls * 6/36; // > 0 = more 7s than expected (bad)

  // High-pip rolls (6,8 = 5 pips each) — expected 10/36 = 27.8%.
  const highPip = g.rolled[6] + g.rolled[8];
  const expectedHighPip = totalRolls * 10/36;

  // For each player, expected production given their pipTotal and total rolls.
  // Expected production per roll = pipTotal / 36 (their pip share of dice space).
  for (const p of g.players) {
    p.expectedProduction = p.pipTotal * totalRolls / 36;
    p.productionLuck = p.production - p.expectedProduction;
    p.productionRatio = p.expectedProduction > 0 ? p.production / p.expectedProduction : 0;
    p.tradeNet = p.tradeGain - p.tradeLoss;
    p.robberNet = p.robberGain - p.robberLoss;
  }

  // Winner.
  const maxPts = Math.max(...g.players.map(p => p.points));
  const winners = g.players.filter(p => p.points === maxPts);
  g.winner = winners.length === 1 ? winners[0].player : winners.map(p => p.player);
  g.winnerPoints = maxPts;
  g.totalRolls = totalRolls;
  g.sevens = sevens;
  g.sevenLuck = sevenLuck;
  g.highPip = highPip;
  g.highPipLuck = highPip - expectedHighPip;
  return g;
}

for (const g of Object.values(games)) gameMetrics(g);

// ---------- per-game scorecard rendering ----------

function fmt(n, d=1) { return Number(n).toFixed(d); }
function fmtSigned(n, d=1) { const s = fmt(n, d); return n >= 0 ? `+${s}` : s; }
function pad(s, w, right=false) { s = String(s); return right ? s.padStart(w) : s.padEnd(w); }

function renderGame(gameId) {
  const g = games[gameId];
  if (!g) return `Game ${gameId} not found.`;
  const lines = [];

  lines.push(`\n## Game ${gameId}`);
  lines.push(`Rolls: ${g.totalRolls} total; ${g.sevens} sevens (luck ${fmtSigned(g.sevenLuck)} vs. expected); 6+8 = ${g.highPip} (luck ${fmtSigned(g.highPipLuck)})`);
  lines.push(`Roll histogram: ${ROLL_VALUES.map(v => `${v}:${g.rolled[v]}`).join('  ')}`);
  lines.push(`Winner: P${Array.isArray(g.winner) ? g.winner.join(',') : g.winner}  with  ${g.winnerPoints} VP`);
  lines.push('');

  // Per-player columns. Building a compact table.
  const header = ['Player', 'VP', 'Pips', 'ExpProd', 'ActProd', 'Gap', 'Ratio', 'TrdNet', 'RobHit', 'RobUse', 'City%'];
  lines.push(`  ${header.map(h => pad(h, 8, true)).join(' ')}`);
  for (const p of g.players) {
    const cityShare = p.pipTotal ? (p.cityEnginePip / p.pipTotal * 100) : 0;
    const cells = [
      `P${p.player}${p.player === g.winner ? '*' : ''}`,
      p.points,
      p.pipTotal,
      fmt(p.expectedProduction),
      p.production,
      fmtSigned(p.productionLuck),
      fmt(p.productionRatio, 2),
      fmtSigned(p.tradeNet, 0),
      p.robberLoss,   // how many times THIS player got hit by robber-steal
      p.robberGain,   // how many times THIS player used the robber to steal from others
      fmt(cityShare, 0) + '%'
    ];
    lines.push(`  ${cells.map(c => pad(c, 8, true)).join(' ')}`);
  }
  lines.push('  Legend: Gap = ActProd − ExpProd (negative = under-produced; includes robber-block + dice variance).');
  lines.push('          RobHit = cards stolen from this player via robber events (≈ count of robber-on-you placements).');
  lines.push('          RobUse = cards this player stole by placing the robber.');

  // Per-resource pip breakdown.
  lines.push('');
  lines.push('  Pip exposure by resource:');
  const resOrder = ['wood','brick','wheat','sheep','ore'];
  const resHeader = ['Player', ...resOrder.map(r => r.slice(0,4))];
  lines.push(`    ${resHeader.map(h => pad(h, 7, true)).join(' ')}`);
  for (const p of g.players) {
    const cells = [`P${p.player}${p.player === g.winner ? '*' : ''}`, ...resOrder.map(r => p.expo[r])];
    lines.push(`    ${cells.map(c => pad(c, 7, true)).join(' ')}`);
  }

  // Ports.
  const hasAnyPort = g.players.some(p => p.ports.generic > 0 || Object.keys(p.ports.specific).length > 0);
  if (hasAnyPort) {
    lines.push('');
    lines.push('  Port adjacencies (and matching resource production):');
    for (const p of g.players) {
      const portStrs = [];
      if (p.ports.generic) portStrs.push(`3:1×${p.ports.generic}`);
      for (const [res, n] of Object.entries(p.ports.specific)) {
        const matchingPip = p.expo[res] || 0;
        portStrs.push(`2:1-${res.slice(0,4)}×${n} (pip ${matchingPip})`);
      }
      if (portStrs.length) lines.push(`    P${p.player}${p.player === g.winner ? '*' : ''}: ${portStrs.join(', ')}`);
    }
  }

  return lines.join('\n');
}

// ---------- cross-game summary ----------

function pearson(xs, ys) {
  const n = xs.length;
  const mx = xs.reduce((a,b)=>a+b, 0) / n;
  const my = ys.reduce((a,b)=>a+b, 0) / n;
  let num = 0, dx2 = 0, dy2 = 0;
  for (let i = 0; i < n; i++) {
    const dx = xs[i] - mx, dy = ys[i] - my;
    num += dx * dy;
    dx2 += dx * dx;
    dy2 += dy * dy;
  }
  const denom = Math.sqrt(dx2 * dy2);
  return denom ? num / denom : 0;
}

function summary() {
  // Aggregate across all player-rows.
  const ps = [];
  for (const g of Object.values(games)) for (const p of g.players) ps.push(p);

  const isWinner = ps.map(p => (p.player === games[p.game].winner ? 1 : 0));
  const pts = ps.map(p => p.points);

  const corr = {
    pipTotal_pts: pearson(ps.map(p => p.pipTotal), pts),
    pipTotal_win: pearson(ps.map(p => p.pipTotal), isWinner),
    cityPip_pts: pearson(ps.map(p => p.cityEnginePip), pts),
    cityPip_win: pearson(ps.map(p => p.cityEnginePip), isWinner),
    production_pts: pearson(ps.map(p => p.production), pts),
    production_win: pearson(ps.map(p => p.production), isWinner),
    productionLuck_pts: pearson(ps.map(p => p.productionLuck), pts),
    productionLuck_win: pearson(ps.map(p => p.productionLuck), isWinner),
    tradeNet_pts: pearson(ps.map(p => p.tradeNet), pts),
    tradeNet_win: pearson(ps.map(p => p.tradeNet), isWinner),
    robberNet_pts: pearson(ps.map(p => p.robberNet), pts),
    robberNet_win: pearson(ps.map(p => p.robberNet), isWinner),
    productionRatio_pts: pearson(ps.map(p => p.productionRatio), pts),
    productionRatio_win: pearson(ps.map(p => p.productionRatio), isWinner)
  };

  const lines = [];
  lines.push('\n## Cross-game correlations (N=200 player-rows, 50 games)');
  lines.push('Pearson r between each metric and (final VP, win-binary).');
  lines.push('');
  lines.push('  metric                          r vs VP    r vs win');
  for (const [k, v] of Object.entries(corr)) {
    const [mFull, target] = k.split('_');
    if (target === 'pts') {
      const winR = corr[`${mFull}_win`];
      lines.push(`  ${pad(mFull, 30)} ${pad(fmt(v, 3), 8, true)}   ${pad(fmt(winR, 3), 8, true)}`);
    }
  }

  // Port-leverage analysis: for each player-port pair, is matching pip > 4
  // and is the player a winner?
  const portRows = [];
  for (const p of ps) {
    for (const [res, n] of Object.entries(p.ports.specific)) {
      const matchingPip = p.expo[res] || 0;
      portRows.push({
        game: p.game, player: p.player, res, n,
        matchingPip,
        leveraged: matchingPip >= 5, // "good port leverage" threshold
        winner: p.player === games[p.game].winner ? 1 : 0,
        points: p.points
      });
    }
  }
  const leveragedPorts = portRows.filter(r => r.leveraged);
  const unleveragedPorts = portRows.filter(r => !r.leveraged);
  lines.push('');
  lines.push('## Port leverage (2:1 specific ports)');
  lines.push(`  Total 2:1 ports across all player-settlements: ${portRows.length}`);
  lines.push(`  Leveraged (matching pip ≥ 5):   ${leveragedPorts.length} → win rate ${fmt(leveragedPorts.reduce((a,b)=>a+b.winner,0) / Math.max(1,leveragedPorts.length) * 100)}%  / mean VP ${fmt(leveragedPorts.reduce((a,b)=>a+b.points,0) / Math.max(1,leveragedPorts.length), 1)}`);
  lines.push(`  Unleveraged (matching pip < 5): ${unleveragedPorts.length} → win rate ${fmt(unleveragedPorts.reduce((a,b)=>a+b.winner,0) / Math.max(1,unleveragedPorts.length) * 100)}%  / mean VP ${fmt(unleveragedPorts.reduce((a,b)=>a+b.points,0) / Math.max(1,unleveragedPorts.length), 1)}`);
  lines.push(`  Baseline win rate (random player): 25%`);

  // Lucky-vs-unlucky board summary.
  lines.push('');
  lines.push('## Board luck (vs. expected dice distribution)');
  const games2 = Object.values(games).sort((a,b) => b.highPipLuck - a.highPipLuck);
  lines.push(`  Luckiest board (most 6/8): game ${games2[0].players[0].game}, highPip ${games2[0].highPip} vs. expected ${fmt(games2[0].totalRolls * 10/36)} (Δ ${fmtSigned(games2[0].highPipLuck)})`);
  lines.push(`  Unluckiest board (fewest 6/8): game ${games2[games2.length-1].players[0].game}, highPip ${games2[games2.length-1].highPip} (Δ ${fmtSigned(games2[games2.length-1].highPipLuck)})`);
  lines.push(`  Most sevens: game ${[...games2].sort((a,b)=>b.sevens-a.sevens)[0].players[0].game}, ${[...games2].sort((a,b)=>b.sevens-a.sevens)[0].sevens} sevens`);

  return lines.join('\n');
}

// ---------- main ----------

const args = process.argv.slice(2);
let summaryOnly = args.includes('--summary-only');
const topIdx = args.indexOf('--top');
let topN = topIdx >= 0 ? parseInt(args[topIdx+1], 10) || 0 : 0;
let gameIds = args.filter(a => /^\d+$/.test(a)).map(Number);

if (topN > 0) {
  // Pick the most-extreme N games by abs(highPipLuck).
  const sorted = Object.values(games).sort((a,b) => Math.abs(b.highPipLuck) - Math.abs(a.highPipLuck));
  gameIds = sorted.slice(0, topN).map(g => g.players[0].game);
}

if (gameIds.length === 0 && !summaryOnly) {
  // No args → all games + summary
  gameIds = Object.values(games).map(g => g.players[0].game).sort((a,b)=>a-b);
}

const out = [];
out.push('# Catan 50-Game Scorecard Report');
out.push(`Generated ${new Date().toISOString().slice(0,10)}`);
out.push(`Dataset: lumins/settlers-of-catan-games (mirror at DevinRS/Settlers_of_Catan_Analysis)`);

if (!summaryOnly) {
  for (const id of gameIds) out.push(renderGame(id));
}
out.push(summary());

console.log(out.join('\n'));

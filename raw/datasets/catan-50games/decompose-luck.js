#!/usr/bin/env node
// decompose-luck.js — decompose "production luck" into board-level RNG
// vs. per-player expansion-success.
//
// productionLuck = actual - expected (expected from STARTING pips only).
// If RNG-driven: lucky-roll boards lift all 4 players together → low
// per-game variance, strong board-luck × player-luck correlation.
// If expansion-driven: a single player out-builds others on the same board
// → high per-game variance, weak correlation with board luck.

const fs = require('fs');
const path = require('path');

const CSV = path.join(__dirname, 'catanstats.csv');
const PIPS = { 2:1, 3:2, 4:3, 5:4, 6:5, 7:0, 8:5, 9:4, 10:3, 11:2, 12:1 };

const lines = fs.readFileSync(CSV, 'utf8').trim().split(/\r?\n/);
const rows = lines.slice(1).map(l => l.split(','));

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

const COL_S1 = [15, 16, 17, 18, 19, 20];
const COL_S2 = [21, 22, 23, 24, 25, 26];

const players = rows.map(r => {
  const game = parseInt(r[0], 10);
  const player = parseInt(r[1], 10);
  const points = parseInt(r[2], 10);
  const tiles = [...tileExposures(r, COL_S1), ...tileExposures(r, COL_S2)];
  let pipTotal = 0;
  for (const t of tiles) if (t.res && t.res !== 'D' && 'LCWSO'.includes(t.res)) pipTotal += t.pip;
  return {
    game, player, points,
    pipTotal,
    production: parseInt(r[27], 10) || 0
  };
});

const games = {};
for (const p of players) {
  if (!games[p.game]) games[p.game] = { players: [], rolled: {} };
  games[p.game].players.push(p);
}
for (const r of rows) {
  const game = parseInt(r[0], 10);
  if (!games[game].rolled[2]) {
    for (let i = 0; i < ROLL_VALUES.length; i++) {
      games[game].rolled[ROLL_VALUES[i]] = parseInt(r[4 + i], 10) || 0;
    }
    games[game].totalRolls = ROLL_VALUES.reduce((a,v)=>a+games[game].rolled[v], 0);
  }
}

// Compute per-player and per-game stats.
for (const g of Object.values(games)) {
  const totalRolls = g.totalRolls;
  // Board-level RNG luck: how much did high-pip rolls (5+ pip values: 6,8) over/under come up?
  const expectedHighPip = totalRolls * 10/36;
  const actualHighPip = g.rolled[6] + g.rolled[8];
  g.boardHighPipLuck = actualHighPip - expectedHighPip;
  // Alt: total productive-roll surplus (any non-7)
  const expectedProductive = totalRolls * 30/36;
  const actualProductive = totalRolls - g.rolled[7];
  g.boardProductiveLuck = actualProductive - expectedProductive;

  // Per-player expected production given starting pips + game's total roll count.
  for (const p of g.players) {
    p.expectedProd = p.pipTotal * totalRolls / 36;
    p.productionLuck = p.production - p.expectedProd;
    p.productionRatio = p.expectedProd > 0 ? p.production / p.expectedProd : 0;
  }

  // Per-game "team luck" = sum of all players' productionLuck. If RNG-driven,
  // this should correlate strongly with boardProductiveLuck (more producing rolls
  // → more production for everyone).
  g.teamLuck = g.players.reduce((a,p)=>a+p.productionLuck, 0);

  // Per-game variance in productionLuck across the 4 players.
  // If RNG-driven: low variance (everyone tracks the board's luck).
  // If expansion-driven: high variance (one player soars, others stagnate).
  const m = g.teamLuck / 4;
  g.luckVariance = g.players.reduce((a,p)=>a + Math.pow(p.productionLuck - m, 2), 0) / 4;
  g.luckStdDev = Math.sqrt(g.luckVariance);
}

// ---------- correlations ----------

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

const gameList = Object.values(games);
const allPlayers = players;

console.log('# Decomposing productionLuck — RNG vs. expansion');
console.log(`Dataset: 50 games, 200 player-rows.`);
console.log('');

// (1) Does board-level luck correlate with team-level luck?
const r_board_team = pearson(
  gameList.map(g => g.boardHighPipLuck),
  gameList.map(g => g.teamLuck)
);
const r_board_productive = pearson(
  gameList.map(g => g.boardProductiveLuck),
  gameList.map(g => g.teamLuck)
);
console.log('## (1) Board RNG luck → team total productionLuck');
console.log(`  r(boardHighPipLuck, teamLuck)    = ${r_board_team.toFixed(3)}`);
console.log(`  r(boardProductiveLuck, teamLuck) = ${r_board_productive.toFixed(3)}`);
console.log('  Reading: if RNG-driven, both should be HIGH (board luck lifts everyone).');
console.log('           if expansion-driven, both should be LOW.');
console.log('');

// (2) Per-game variance: if RNG, low variance; if expansion, high variance.
// Compute average within-game stddev vs. between-game stddev.
const allLucks = allPlayers.map(p => p.productionLuck);
const grand_mean = allLucks.reduce((a,b)=>a+b,0) / allLucks.length;
const grand_var = allLucks.reduce((a,l)=>a + Math.pow(l-grand_mean, 2), 0) / allLucks.length;

const avg_within_game_var = gameList.reduce((a,g)=>a+g.luckVariance, 0) / gameList.length;
const between_game_var = gameList.reduce((a,g)=>a + Math.pow(g.teamLuck/4 - grand_mean, 2), 0) / gameList.length;

console.log('## (2) Variance decomposition');
console.log(`  Grand variance of productionLuck across all 200 player-rows: ${grand_var.toFixed(1)}`);
console.log(`  Avg within-game variance (between players, same game):       ${avg_within_game_var.toFixed(1)}`);
console.log(`  Between-game variance (game means, between games):           ${between_game_var.toFixed(1)}`);
console.log(`  Within-game share of total variance: ${(avg_within_game_var / (avg_within_game_var + between_game_var) * 100).toFixed(1)}%`);
console.log('  Reading: if RNG-driven, within-game variance is small (everyone tracks the board).');
console.log('           if expansion-driven, within-game variance is large (players diverge on same board).');
console.log('');

// (3) Decompose each player's luck into board-level + residual.
// Per-player residual = productionLuck - (game's mean productionLuck).
// This is the per-player deviation from the team's collective luck.
for (const g of gameList) {
  const m = g.teamLuck / 4;
  for (const p of g.players) {
    p.personalLuck = p.productionLuck - m;  // residual after removing board effect
  }
}

const r_total_vp = pearson(allPlayers.map(p=>p.productionLuck), allPlayers.map(p=>p.points));
const r_personal_vp = pearson(allPlayers.map(p=>p.personalLuck), allPlayers.map(p=>p.points));

console.log('## (3) Production-luck split: board component vs. personal residual');
console.log(`  r(productionLuck, VP)         = ${r_total_vp.toFixed(3)}    (total, what we reported before)`);
console.log(`  r(personalLuck, VP)           = ${r_personal_vp.toFixed(3)}    (residual after removing board mean)`);
console.log('  Reading: if total ≈ personal residual, the win-correlation lives in player-level (expansion).');
console.log('           if personal ≪ total, the win-correlation lives in board-level (RNG).');
console.log('');

// (4) Average productionRatio — is the typical player producing 1x, 2x, 3x their starting pip exposure?
const ratios = allPlayers.map(p => p.productionRatio).filter(r => r > 0);
ratios.sort((a,b)=>a-b);
const avgRatio = ratios.reduce((a,b)=>a+b,0) / ratios.length;
const medianRatio = ratios[Math.floor(ratios.length/2)];
console.log('## (4) How much do players exceed starting-pip-only expectation?');
console.log(`  Mean ratio:    ${avgRatio.toFixed(2)}x`);
console.log(`  Median ratio:  ${medianRatio.toFixed(2)}x`);
console.log(`  Min / Max:     ${ratios[0].toFixed(2)}x / ${ratios[ratios.length-1].toFixed(2)}x`);
console.log('  Reading: a ratio of 1.0 means starting pips are explaining all production.');
console.log('           ratio >> 1.0 means expansion (cities/settlements built mid-game) is dominant.');

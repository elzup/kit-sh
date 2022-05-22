#!/usr/bin/env zx

const baseDir = argv._[1];

function repoDirReport(dir) {}

function main() {
  const repoDirs = $`ls ${baseDir}`;
  if (repoDirs.length === 0) return;
  const initPath = repoDirs[0];
  cd(initPath);

  for (const repoDir of repoDirs) {
    const dir = `../${repoDir}`;
    cd(dir);
    repoDirReport();
  }
}

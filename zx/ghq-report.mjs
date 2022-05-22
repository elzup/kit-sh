#!/usr/bin/env zx

const dirExists = (dir) => $`[[ -d ${dir} ]]`.exitCode === 0;

async function repoDirReport(dir) {
  console.log(dir);
  const gitExists = await dirExists(".git");
  console.log(gitExists);
}

async function main() {
  const baseDir = argv._[1];

  const repoDirs = (await $`ls ${baseDir}`).stdout.split("\n");
  console.log(repoDirs);
  if (repoDirs.length === 0) return;
  const initPath = `${baseDir}/${repoDirs[0]}`;
  cd(initPath);

  for (const repoDir of repoDirs) {
    const dir = `../${repoDir}`;
    if (!(await dirExists(dir))) continue;
    cd(dir);
    await repoDirReport(dir);
  }
}

await main();

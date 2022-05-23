#!/usr/bin/env zx

const dirExists = async (dir) => (await $`[[ -d ${dir} ]]`.exitCode) === 0;
const get = async (p) => (await p).stdout.trim();

async function repoDirReport(dir) {
  const repo = { dir, hasGit: true };

  repo.branch = await get(
    quiet($`git branch --contains | cut -d " " -f 2`)
  ).catch(() => {
    repo.hasGit = false;
    return false;
  });

  if (!repo.hasGit) {
    return repo;
  }
  // await $`git fetch`;

  repo.up = false;
  try {
    repo.up = await get(
      quiet($`git rev-parse --abbrev-ref --symbolic-full-name @{u}`)
    );
  } catch {}
  if (!repo.up) {
    return repo;
  }

  repo.remotes = await get(quiet($`git remote`));
  repo.gitLocal = await get(quiet($`git rev-parse @`));
  repo.gitRemote = await get(quiet($`git rev-parse "${repo.up}"`));
  repo.gitBase = await get(quiet($`git merge-base @ "${repo.up}"`));
  repo.wip = await get(quiet($`git status --porcelain`));

  repo.sync =
    repo.gitLocal === repo.gitRemote
      ? "up-to-date"
      : repo.gitLocal === repo.gitBase
      ? "need-pull"
      : repo.gitRemote === repo.gitBase
      ? "need-push"
      : "none";

  return repo;
}

async function main() {
  const baseDir = argv._[1];

  const repoDirs = (await $`ls ${baseDir}`).stdout.split("\n");
  // console.log(repoDirs);
  if (repoDirs.length === 0) return;
  const initPath = `${baseDir}/${repoDirs[0]}`;
  cd(initPath);

  const nogitRepos = [];
  const nsyncRepos = [];
  const wipssRepos = [];
  const cleanRepos = [];
  const localRepos = [];
  for (const repoDir of repoDirs) {
    const dir = `../${repoDir}`;
    if (!(await dirExists(dir))) {
      console.warn("skipping", dir);
      continue;
    }
    cd(dir);
    const repo = await repoDirReport(dir);

    if (!repo.hasGit) {
      nogitRepos.push(repo);
    } else if (!repo.up) {
      localRepos.push(repo);
    } else if (repo.sync !== "up-to-date" || repo.wip !== "") {
      if (repo.sync !== "up-to-date") nsyncRepos.push(repo);
      if (repo.wip !== "") wipssRepos.push(repo);
    } else {
      cleanRepos.push(repo);
    }
  }

  console.log("");
  console.log("## nogit");
  nogitRepos.forEach((repo) => {
    console.log(repo.dir);
  });

  console.log("");
  console.log("## clean");
  cleanRepos.forEach((repo) => {
    console.log(repo.dir);
  });

  console.log("");
  console.log("## no remote");
  localRepos.forEach((repo) => {
    console.log(repo.dir, repo.branch);
  });

  console.log("");
  console.log("## no sync");
  nsyncRepos.forEach((repo) => {
    console.log(repo.dir, repo.sync);
  });

  console.log("");
  console.log("## wip");
  wipssRepos.forEach((repo) => {
    console.log(repo.dir);
  });
}

await main();

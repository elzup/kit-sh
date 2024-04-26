#!/usr/bin/env bash

BASE_DIR="$HOME/.ghq/github.com/elzup/"

for repo_dir in "$BASE_DIR"/*/; do
  cd "$repo_dir"
  repo_name="$(basename "$repo_dir")"
  if [ -d "${repo_dir}.git" ]; then
    # コミットされていない変更があるかチェック
    if ! git diff --quiet; then
      uncommitted_changes="uncommitted"
    else
      uncommitted_changes=""
    fi

    # プッシュされていないコミットがあるかチェック
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ "$current_branch" == "HEAD" ]]; then
      # HEADがブランチとして認識されない場合（例：まだコミットがない場合）
      unpushed_commits="No commits"
    else
      # origin/<branch> と比較する
      if git fetch --quiet && [ "$(git log origin/$current_branch..HEAD)" != "" ]; then
        unpushed_commits="Unpushed"
      else
        unpushed_commits=""
      fi
    fi

    # result
    echo "$repo_name: $uncommitted_changes, $unpushed_commits"
	else
    echo "$repo_name: non git"
  fi
done

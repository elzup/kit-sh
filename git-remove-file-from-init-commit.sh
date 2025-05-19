#!/usr/bin/env bash

set -euo pipefail

# 引数チェック
if [ "$#" -eq 0 ]; then
  echo "Usage: $0 <file1> [file2 ...]" >&2
  exit 1
fi

# Git リポジトリか確認
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "Error: ここは Git リポジトリではありません。" >&2
  exit 1
fi

# 各ファイルが tracked されているか確認
for f in "$@"; do
  if ! git ls-files --error-unmatch -- "$f" > /dev/null 2>&1; then
    echo "Error: ファイルが tracked されていません → \"$f\"" >&2
    exit 1
  fi
done

# ファイルを削除（作業ツリーとインデックスから）
git rm -- "$@"

git commit -m "Remove specified files"
echo "Removed and committed: $*"

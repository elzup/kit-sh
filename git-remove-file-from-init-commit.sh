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

if ! command -v git-filter-repo > /dev/null 2>&1; then
  echo "Error: git-filter-repo が見つかりません。インストールしてください。" >&2
  exit 1
fi

git filter-repo --force --invert-paths \
  $(printf -- '--path %q ' "$@")

echo "Successfully removed all history of: $*"

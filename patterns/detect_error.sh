#!/bin/bash

output=$(git status 2>&1)

object_file_empty="error: object file"

if [[ $output == *"$object_file_empty"* ]] ; then
  echo "エラーが検出されました。修復が必要です。"
else
  echo "Gitリポジトリは正常です。"
fi

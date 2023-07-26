#!/bin/bash

function map {
  local func=$1
  shift
  local transformed=()
  local index=0

  for item in "$@"; do
    transformed+=("$("$func" "$index" "$item")")
    ((index++))
  done

  echo "${transformed[@]}"
}

# 変換関数を定義
function transform {
  local index=$1
  local item=$2
  echo "[$index: $item]"
}

# リスト変数を定義
fruits=("apple" "orange" "banana" "grape" "kiwi")

# map
ress=($(map transform "${fruits[@]}"))
echo $ress

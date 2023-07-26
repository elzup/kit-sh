#!/bin/bash

function map {
  local func=$1  # 変換関数を受け取る変数
  shift          # 最初の引数を削除して残りの引数を取得
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
  # ここでは要素の長さとインデックスを組み合わせて表示する例とします
  local index=$1
  local item=$2
  echo "Index: $index, Item: $item, Length: ${#item}"
}

# リスト変数を定義
fruits=("apple" "orange" "banana" "grape" "kiwi")

function join_by { local IFS="$1"; shift; echo "$*"; }
# map
ress=$(map transform "${fruits[@]}")

result=$(join_by "__" "${ress[@]}")
echo "$result"
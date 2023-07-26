#!/usr/bin/env bash

function join_by { local IFS="$1"; shift; echo "$*"; }

fruits=("apple" "orange" "banana" "grape" "kiwi")

result=$(join_by "," "${fruits[@]}")
echo "$result"
#!/usr/bin/env bash

DIR="${1:-.}"
find "$DIR" -type f | awk -F/ '{
  path=""
  for (i=1; i<NF; i++) {
    path = (path ? path "/" : "") $i
    count[path]++
  }
}
END {
  for (p in count) print count[p], p
}' | sort -nr | head -30


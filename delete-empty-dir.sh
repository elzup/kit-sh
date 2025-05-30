#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <path>" 1>&2
  exit 1
fi

target=$1

# Find empty files recursively
mapfile -t empty_files < <(find "$target" -type f -empty)
count=${#empty_files[@]}

if [ "$count" -eq 0 ]; then
  echo "No empty files found."
  exit 0
fi

echo "The following empty files will be deleted (showing up to 20):"
for f in "${empty_files[@]:0:20}"; do
  echo "  $f"
done
if [ "$count" -gt 20 ]; then
  echo "There are another $((count - 20)) files."
fi

echo -n "Proceed? [y/N]: "
read ans
if [[ ! "$ans" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 0
fi

# Delete files
for f in "${empty_files[@]}"; do
  rm -f "$f"
done

echo "Deletion complete: Removed $count files."
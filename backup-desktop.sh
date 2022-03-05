#!/bin/bash

dir_default=$HOME/Desktop/
prefix_default=$HOME/backup/desktop

dir="${1:-$dir_default}"
prfix="${2:-$prefix_default}"

today=$(date "+%Y%m%d")
target=$prfix$today/

\mkdir $target
\mv $dir* $target

echo "packed $target"
echo "mv $dir* $target"

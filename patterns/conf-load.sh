#!/usr/bin/env bash

PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

echo $PARENT_PATH
source $PARENT_PATH/confs.sh
for v in "${KEYWORDS[@]}"
do
    echo "$v"
done
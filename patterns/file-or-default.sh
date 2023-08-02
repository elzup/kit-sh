#!/usr/bin/env bash


v=$(cat "a.txt" 2>/dev/null || echo "b")

echo $v

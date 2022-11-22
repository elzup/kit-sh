#!/usr/bin/env bash

outfile=todo.txt
echo -e "[new text]"$"\n$(cat $outfile)" > $outfile
echo "[new text]" | echo -e "$(cat)\n$(cat $outfile)" > $outfile

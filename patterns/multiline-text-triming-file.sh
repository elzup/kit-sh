#!/usr/bin/env bash

DATA1="AAA\nBBB\nCCC\nDDD\nEEE\nFFF\nGGG\n"
OUT_FILE=out/mld.txt

mkdir -p out

echo -e $DATA1 > $OUT_FILE

LINE_BGN=$(sed -n '/BBB/=' $OUT_FILE)
LINE_END=$(sed -n '/EEE/=' $OUT_FILE)
echo $LINE_BGN
echo $LINE_END

cat $OUT_FILE |awk "$LINE_BGN<=NR && NR<=$LINE_END{print \$0}"


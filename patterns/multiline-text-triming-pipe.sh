#!/bin/bash

DATA1="AAA\nBBB\nCCC\nDDD\nEEE\nFFF\nGGG\n"

LINE_BGN=$(echo -e $DATA1 |sed -n '/BBB/=')
LINE_END=$(echo -e $DATA1 |sed -n '/EEE/=')
echo $LINE_BGN
echo $LINE_END

echo -e $DATA1 |awk "$LINE_BGN<=NR && NR<=$LINE_END{print \$0}"


#!/usr/bin/env bash

ESC_BO="\e[1;m"
ESC_UL="\e[4;m"
ESC_END="\e[m"

echo -e "hello ${ESC_BO}deco sample${ESC_END} normal ${ESC_BO}bold${ESC_BO} ${ESC_UL}underline${ESC_BO}"

#!/usr/bin/env bash

git branch -m main
git push origin HEAD -u
REPO=$(git config --get remote.origin.url |sed -e 's/.*:\(.*\).git/\1/')

ESC_BO="\e[1;m"
ESC_UL="\e[4;m"
ESC_END="\e[m"

echo -e "open ${ESC_UL}https://github.com/$REPO/settings/branches${ESC_END} and"
echo -e "change default branch from ${ESC_BO}master$ESC_END to ${ESC_BO}main$ESC_END"

read -p "git push origin --delete master ? (Y/n)" ANSWER_YN
ANSWER_YN=${ANSWER_YN:-"y"}

if [ "${ANSWER_YN}" == "y" ]; then
  git push origin --delete master
fi

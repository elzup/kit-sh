#!/bin/bash

git branch -m main
git push origin HEAD -u
REPO=$(git config --get remote.origin.url |sed -e 's/.*:\(.*\).git/\1/')

echo "open https://github.com/$REPO/settings/branches and"
echo "change default branch to main"

read -p "git push origin --delete master ? (Y/n)" ANSWER_YN
ANSWER_YN=${ANSWER_YN:-"y"}

if [ "${ANSWER_YN}" == "y" ]; then
  git push origin --delete master
fi
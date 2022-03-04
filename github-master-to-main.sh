#!/bin/bash

git branch -m main
git push origin HEAD -u
REPO=$(git config --get remote.origin.url |sed -e 's/.*:\(.*\).git/\1/')

echo "open https://github.com/$REPO/settings/branches and"
echo "change default branch to main"

read -p "git push origin --delete master ? (y/n)" YN_LOADSETTING

if [ "${YN_LOADSETTING}" != "y" ]; then
  git push origin --delete master
fi
#!/bin/bash

git branch -m main
git push origin HEAD -u
REPO=$(git config --get remote.origin.url |sed -e 's/.*:\(.*\).git/\1/')

echo "change default branch to main"
open github.com/$REPO/settings/branches

read -p "git push origin --delete master ? (y/n)" YN_LOADSETTING

if [ "${YN_LOADSETTING}" != "y" ]; then
  git push origin --delete master
fi
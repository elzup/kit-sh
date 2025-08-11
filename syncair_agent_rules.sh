#!/usr/bin/env bash

# ~/.clinerules/* を現在のディレクトリの適切な位置にコピーする

# Roo Code global
# ln -s ~/.clinerules ~/.roo/rules

# check .git
if [ ! -d .git ]; then
  echo "Not project root or .git directory not found"
  exit 1
fi

mkdir -p .cursor/rules
rsync -av ~/.clinerules/ .cursor/rules/ --exclude=.git --exclude=README.md

# CLAUDE.md
# ~/.clinerules/\*.md の README.md 以外を参照してください。
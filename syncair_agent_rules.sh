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

append_unique_line() {
  local file=$1
  local msg=$2

  touch "$file"
  if ! grep -Fxq "$msg" "$file"; then
    printf '%s\n' "$msg" >> "$file"
  fi
}

msg="~/.clinerules/\*.md の README.md 以外を参照してください。"

# CLAUDE.md
append_unique_line CLAUDE.md "$msg"

# GEMINI.md
append_unique_line GEMINI.md "$msg"

# Codex
append_unique_line AGENTS.md "$msg"
#!/usr/bin/env bash

FILE_PATH="$HOME/Library/Application Support/Code/User/settings.json"
# FILE_PATH="./vscode/test.json5.txt"
today=$(LC_TIME=en_US.UTF-8 date +%a)
echo $today

# comment out all @theme-auto-change config
sed -i '' -E 's/^[[:space:]]*([^/][^/]*)("workbench.colorTheme": ".*@theme-auto-change)/\/\/ \2/' "$FILE_PATH"
# enabled todays theme
sed -i '' -E 's/^([[:space:]]*)\/\/([[:space:]]*"workbench.colorTheme": ".*",.*@theme-auto-change '$today'.*)/\1\2/' "$FILE_PATH"

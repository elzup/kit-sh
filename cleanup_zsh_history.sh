#!/usr/bin/env bash

# バックアップ格納ディレクトリ
KEEP_DAYS=90
BACKUPDIR=~/Dropbox/backup

# 古いファイルのうち、月日の末尾が「01」でないものを削除
find "$BACKUPDIR" \
  -type f \
  -name '.zsh_history_[0-9]*' \
  -mtime +$KEEP_DAYS \
  ! -name '*.zsh_history_*01' \
  -print \
  -delete

#!/usr/bin/env bash
set -euo pipefail

readonly DESKTOP_DIR="$HOME/Desktop"
readonly BACKUP_PARENT_DIR="$HOME/backup/desktop"

if [ -z "$(ls -A "$DESKTOP_DIR")" ]; then
  exit 0
fi

readonly today=$(date "+%Y%m%d")
readonly archive_name="desktop$today.zip"
readonly archive_path="$BACKUP_PARENT_DIR/$archive_name"

if [ -e "$archive_path" ]; then
  # Silently exit with error code if backup already exists.
  exit 1
fi

command mkdir -p "$BACKUP_PARENT_DIR"

# Directly zip the desktop contents, then delete them.
(command cd "$DESKTOP_DIR" && command zip -qr "$archive_path" . -x ".DS_Store")
command find "$DESKTOP_DIR" -mindepth 1 -delete

echo "date: $today"
echo "backuppath: $archive_path"

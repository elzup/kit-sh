#!/usr/bin/env bash
set -euo pipefail

readonly DOWNLOADS_DIR="$HOME/Downloads"
readonly BACKUP_PARENT_DIR="$HOME/backup/downloads"
readonly today=$(date "+%Y%m%d")
readonly archive_dir_name="downloads_$today"
readonly archive_dir_path="$BACKUP_PARENT_DIR/$archive_dir_name"

# Check if there are any files to archive first
if [ -z "$(find "$DOWNLOADS_DIR" -mindepth 1 -maxdepth 1 -mtime +180)" ]; then
  echo "No files older than 6 months to archive."
  exit 0
fi

# Exit if another archive has been created today
if [ -e "$archive_dir_path" ]; then
  echo "Archive directory for today already exists: $archive_dir_path"
  exit 1
fi

mkdir -p "$archive_dir_path"

# Find files older than 180 days and move them to the archive directory
find "$DOWNLOADS_DIR" -mindepth 1 -maxdepth 1 -mtime +180 -exec mv {} "$archive_dir_path" \;

readonly archive_zip_name="downloads_$today.zip"
readonly archive_zip_path="$BACKUP_PARENT_DIR/$archive_zip_name"

# Zip the archive directory. The zip will contain the 'downloads_YYYYMMDD' folder.
(command cd "$BACKUP_PARENT_DIR" && command zip -qr "$archive_zip_name" "$archive_dir_name")

# Count files
readonly backed_up_count=$(ls -1A "$archive_dir_path" | wc -l | tr -d ' ')
readonly remaining_count=$(ls -1A "$DOWNLOADS_DIR" | wc -l | tr -d ' ')


echo "date: $today"
echo "refreshed dir: ~/Downloads (files: $remaining_count)"
echo "backup dir: $archive_dir_path (files: $backed_up_count)"
echo "zip path: $archive_zip_path"

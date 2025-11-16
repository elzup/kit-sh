#!/usr/bin/env bash

set -euo pipefail

# 設定
REMOTE_HOST="target"
REMOTE_USER="role"
REMOTE_DIR="/path/to/remote/dir"
REMOTE_PATTERN="*"
COPY_USER="user"
LOCAL_DEST_DIR="./output"

echo "=== Connecting to remote server... ==="

ssh -o StrictHostKeyChecking=accept-new -tt "$REMOTE_HOST" "

sudo -u $REMOTE_USER bash -lc '
set -euo pipefail
echo \"[Remote] Running as: \$(whoami)\"

echo \"[Remote] Finding latest file: pattern $REMOTE_PATTERN\"

latest_file=\$(ls -t \"$REMOTE_DIR\"/$REMOTE_PATTERN 2>/dev/null | head -n1)

if [[ -z \"\$latest_file\" ]]; then
  echo \"[Remote] No file matched: $REMOTE_PATTERN\"
  exit 1
fi

filename=\$(basename \"\$latest_file\")
target=\"$COPY_USER\"

sudo cp \"\$latest_file\" \"/home/\$target/\$filename\"
sudo chown \"\$target:\$target\" \"/home/\$target/\$filename\"

echo \"[Remote] Copy completed\"
echo \"FILENAME:\$filename\"
'
" > /tmp/fetch_ad_output.txt 2>&1

remote_filename=$(grep "^FILENAME:" /tmp/fetch_ad_output.txt | cut -d: -f2 | tr -d '\r\n')

grep -v "^FILENAME:" /tmp/fetch_ad_output.txt

echo "=== Remote filename: $remote_filename ==="
echo "=== Downloading to local... ==="

scp "$REMOTE_HOST:/home/$COPY_USER/$remote_filename" "$LOCAL_DEST_DIR/"

local_path="$LOCAL_DEST_DIR/$remote_filename"

echo "=== Download completed ==="
echo "File path: $local_path"

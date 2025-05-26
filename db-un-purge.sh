#!/usr/bin/env bash
#
# dumpfile.sql 中の GTID／SQL_LOG_BIN 周りの SET 文をコメントアウトする
#
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <dumpfile.sql>"
  exit 1
fi

infile="$1"
outfile="${infile%.sql}_no_gtid.sql"

sed -E \
  -e 's|^(SET @MYSQLDUMP_TEMP_LOG_BIN.*)$|-- \1|' \
  -e 's|^(SET @@SESSION\.SQL_LOG_BIN[[:space:]]*=.*)$|-- \1|' \
  -e 's|^(SET @@GLOBAL\.GTID_PURGED=.*)$|-- \1|' \
  "$infile" > "$outfile"

echo "copied $infile"
echo "to $outfile"

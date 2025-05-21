#!/usr/bin/env bash

if [ "$#" -gt 1 ]; then
  echo "Usage: $0 [<target_url>]"
  exit 1
fi

TARGET_URL="${1:-http://example.com}"

mitmproxy \
  --mode reverse:"$TARGET_URL" \
  --listen-port 8081 \
  -s proxy-stub.py
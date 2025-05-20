#!/usr/bin/env bash

mitmproxy \
  --mode reverse:https://www.example.net/ \
  --listen-port 8081 \
  -s proxy-stub.py
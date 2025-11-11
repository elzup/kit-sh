#!/bin/bash
# Setup SSH authorized_keys with proper permissions

set -e

SSH_DIR="~/.ssh"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"

if [ ! -d "$SSH_DIR" ]; then
    mkdir -p "$SSH_DIR"
    created_dir=" (created)"
fi
chmod 700 "$SSH_DIR"
echo "0700 $SSH_DIR$created_dir"

if [ ! -f "$AUTHORIZED_KEYS" ]; then
    touch "$AUTHORIZED_KEYS"
    created_file=" (created)"
fi
chmod 600 "$AUTHORIZED_KEYS"
echo "0600 $AUTHORIZED_KEYS$created_file"

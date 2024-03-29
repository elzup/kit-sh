#!/usr/bin/env bash
name="${NAME:-$1}"

[ -z "$name" ] && echo "usage: ./ssh-make-key.sh <key-name>" && exit 1
file=~/.ssh/${name}
ssh-keygen -t ed25519 -C $name -N "" -f $file
# chmod 700 ~/.ssh
# chmod 600 $file
# chmod 644 $file.pub
echo "
Host github.com
    Hostname github.com
    IdentityFile $file
    User git
" >> ~/.ssh/config
chmod 600 ~/.ssh/config

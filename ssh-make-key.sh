#!/bin/bash
name=$1
[ -z "$name" ] && echo "usage: ./ssh-make-key.sh <key-name>" && exit 1
file=~/.ssh/${name}
ssh-keygen -t rsa -N "" -f $file -b 4096
# chmod 700 ~/.ssh
# chmod 600 $file
# chmod 644 $file.pub

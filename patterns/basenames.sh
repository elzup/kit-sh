#!/usr/bin/env bash

url1=git@github.com:A/B.git
url2=https://github.com/A/B.git


url=$(git config --get remote.origin.url)
echo $url

id=$(echo $url |sed -e 's/.*github.com.\(.*\).git/\1/')

echo $id
echo '[owner]' ${id#*/}
echo '[repo ]' ${id%/*}


#!/bin/bash

file=$1
ip=$2
args=${@:3:100}

whitelist="_1.1.1.1_2.2.2.2_" # split by underber

if [ "`echo $whitelist | grep _${ip}_`" ]; then
  echo "check IP $ip ok"
  echo "$ ${file} ${ip} ${args}"
  echo `${file} ${ip} ${args}`
else
  echo "Error: ip not in white list [${ip}]"
fi

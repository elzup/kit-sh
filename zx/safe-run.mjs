#!/usr/bin/env zx

const WHITE_LIST = ["red", "green", "blue"];
const validates = [(color) => WHITE_LIST.includes(color)];

// whitelist="_1.1.1.1_2.2.2.2_" # split by underber
//
// if [ "`echo $whitelist | grep _${ip}_`" ]; then
//   echo "check IP $ip ok"
//   echo "$ ${file} ${ip} ${args}"
//   echo `${file} ${ip} ${args}`
// else
//   echo "Error: ip not in white list [${ip}]"
// fi
//

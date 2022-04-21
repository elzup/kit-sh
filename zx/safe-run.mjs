#!/usr/bin/env zx

const WHITE_LIST = ["red", "green", "blue"];
const validColor = (color) => WHITE_LIST.includes(color);

const color = argv._[1];

if (!validColor(color)) {
  console.error(`Error: color not in list [${color}]`);
} else {
  $`echo ${color}`;
}

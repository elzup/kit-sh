#!/bin/bash

read -p "any question ? (Y/n)" ANSWER_YN
ANSWER_YN=${ANSWER_YN:-"y"}


if [ "${ANSWER_YN}" == "y" ]; then
  echo "yes"
else
  echo "no"
fi

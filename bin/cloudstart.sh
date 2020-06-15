#!/bin/bash

if [ ! "$mem" = "" ]; then
  if [ $mem -le 512 ]; then
    NODE_FLAGS="--max_semi_space_size=2 --max_old_space_size=256 --max_executable_size=192"
  elif [ $mem -le 768 ]; then
    NODE_FLAGS="--max_semi_space_size=8 --max_old_space_size=512 --max_executable_size=384"
  elif [ $mem -le 1024 ]; then
    NODE_FLAGS="--max_semi_space_size=16 --max_old_space_size=1024 --max_executable_size=512"
  fi
fi

echo "Executing node with flags: ${NODE_FLAGS}"
echo "Arguments passed to cloudstart: ${@}"
ts-node $NODE_FLAGS "$@"
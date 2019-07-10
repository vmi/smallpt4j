#!/bin/bash

mvn="$(which mvn)"
if [ ! -f "$mvn.cmd" ]; then
  echo "Missing mvn.cmd. Abort."
  exit 1
fi

{
  echo -n "@$(cygpath -aw "$mvn.cmd") %*"
  echo -e "\r"
} > mvn.cmd

#!/bin/bash

GREEN="\033[92m"
DEFAULT="\033[0m"

success_print() {
  echo -en "[+]$GREEN $1 $DEFAULT"
  echo
}

cd $(dirname "$0")
CWD=$(pwd -L)
cd - > /dev/null
FILES=$(ls | grep -v $(basename $0))

for dir in $FILES; do
  success_print "working on $dir"
  ln -rsf $CWD/$dir ~/.$dir
done



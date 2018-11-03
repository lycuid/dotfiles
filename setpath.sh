#!/bin/bash

GREEN="\033[92m"
DEFAULT="\033[0m"

success_print() {
  echo -en "[+]$GREEN $1 $DEFAULT"
  echo
}

cd $(dirname $0)/config-files
CWD=$(pwd -L)
cd - > /dev/null
FILES=$(ls config-files)

for file in $FILES; do
  success_print "working on $file"
  ln -rsf $CWD/$file ~/.$file
done



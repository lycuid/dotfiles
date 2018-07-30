#!/bin/bash

cd $(dirname "$0")
CWD=$(pwd -L)
cd - > /dev/null
FILES=$(ls | grep -v $(basename $0))

for dir in $FILES; do
  ln -rsf $CWD/$dir ~/.$dir
done


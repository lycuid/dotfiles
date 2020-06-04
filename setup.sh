#!/bin/bash

DEFAULT="\033[0m"
GREEN="\033[92m"
YELLOW="\033[93m"
BLUE="\033[94m"

echo_success() {
  echo -e "$GREEN$1$DEFAULT"
}

echo_info() {
  echo -e "$BLUE$1$DEFAULT"
}

echo_warning() {
  echo -e "$YELLOW$1$DEFAULT"
}

ROOT="$HOME"
CWD="./files"
PATHS=$(tree $CWD -iaf --noreport | cut -s -d \/ -f 3-)

for path in $PATHS; do
  # if file, create a symlink.
  if [ -f "$CWD/$path" ]; then
    echo_success "[+] Linking: $path"
    ln -rsf $CWD/$path $ROOT/$path
  else
    # else if directory, mkdir if doesn't exist already.
    if [ -d $ROOT/$path ]; then
      echo_warning "[?] Ignoring directory: $path"
    else
      echo_info "[+] Creating directory: $path"
      mkdir $ROOT/$path
    fi
  fi
done



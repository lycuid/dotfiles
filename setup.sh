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

cwd="./config-files"
paths=$(tree config-files -iaf --noreport | cut -s -d \/ -f 2-)
CONFIG="$HOME"

for path in $paths; do
  # if file, create a symlink.
  if [ -f "$cwd/$path" ]; then
    echo_success "[+] Linking: $path"
    ln -rsf $cwd/$path $CONFIG/$path
  else
    # else if directory, mkdir if doesn't exist already.
    if [ -d $CONFIG/$path ]; then
      echo_warning "[?] Ignoring directory: $path"
    else
      echo_info "[+] Creating directory: $path"
      mkdir $CONFIG/$path
    fi
  fi
done



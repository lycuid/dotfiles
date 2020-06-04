#!/bin/bash

DEFAULT="\033[0m"
GREEN="\033[92m"
YELLOW="\033[93m"

echo_success() {
  echo -e "$GREEN$1$DEFAULT"
}

echo_warning() {
  echo -e "$YELLOW$1$DEFAULT"
}


cwd="./config-files"
files=$(tree config-files -iaf --noreport | cut -s -d \/ -f 2-)

for file in $files; do
  if [ -f "$cwd/$file" ]; then
    echo_success "[+] Linking: $file"
    ln -rsf $cwd/$file ~/.$file
  else
    echo_warning "[*] Ignoring directory: $file"
  fi
done



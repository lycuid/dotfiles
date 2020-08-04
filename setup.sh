#!/bin/sh


if [ $# -lt 2 ]; then
  echo "Not enough arguments."
  exit 1
fi

getRelativePath() {
  echo $(cd $(dirname $1); pwd)/$(basename $1)
}

query=$1
src=$(getRelativePath $2)
[ $3 ] && dest=$(getRelativePath $3) || dest=$HOME

DEFAULT="\033[0m"
GREEN="\033[92m"
YELLOW="\033[93m"
BLUE="\033[94m"


link() {
  paths=$(
    cd $(dirname $src) && tree -iaf --noreport $(basename $src) \
      | sed "1d" \
      | cut -d \/ -f 2-
  )

  for path in $paths; do
    s=$src/$path
    d=$dest/$path

    if [ -f $s ]; then
      echo "$GREEN[+] Linking: $path$DEFAULT"
      ln -rsf $s $d
    else
      if [ -d $d ]; then
        echo "$YELLOW[?] Ignoring directory: $path$DEFAULT"
      else
        echo "$BLUE[+] Creating directory: $path$DEFAULT"
        mkdir $d
      fi
    fi
  done
}

delink() {
  paths=$(
    cd $(dirname $src) && tree --dirsfirst -iaf --noreport $(basename $src) \
      | sed "1d" \
      | cut -d \/ -f 2- \
      | sed '1!G;h;$!d'
  )

  for path in $paths; do
    d=$dest/$path
    if [ -f $d ]; then
      echo "$GREEN[+] Delinking: $path$DEFAULT"
      rm $d
    fi

    if [ -d $d ] && [ $(ls $d | wc -l) -eq 0 ]; then
      echo "$BLUE[+] Removing Empty Directory: $path$DEFAULT"
      rm -rf $d
    fi
  done
}

case $query in
  "link")
    link
    ;;
  "delink")
    delink
    ;;
  *)
    echo "Invalid Query."
    exit 1
    ;;
esac

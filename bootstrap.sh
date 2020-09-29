#!/bin/sh

IGNORE_EXTENSIONS="hi o"
IGNORE_PATTERN=$(echo $IGNORE_EXTENSIONS | tr ' ' '|' | xargs -i echo "\.{}$")

if [ $# -lt 2 ]; then
  echo "Not enough arguments."
  exit 1
fi

getRelativePath() {
  echo "$(cd $(dirname $1); pwd)/$(basename $1)"
}

query=$1
SRC=$(getRelativePath $2)
[ $3 ] && DEST=$(getRelativePath $3) || DEST=$HOME

DEFAULT="\033[0m"
GREEN="\033[92m"
YELLOW="\033[93m"
BLUE="\033[94m"


link() {
  paths=$(
    cd $(dirname $SRC) && tree -iaf --noreport $(basename $SRC) \
      | sed "1d" \
      | cut -d \/ -f 2-
  )

  for path in $paths; do
    s=$SRC/$path
    d=$DEST/$path

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

unlink() {
  paths=$(
    cd $(dirname $SRC) && tree --dirsfirst -iaf --noreport $(basename $SRC) \
      | sed "1d" \
      | cut -d \/ -f 2- \
      | sed '1!G;h;$!d'
  )

  for path in $paths; do
    d=$DEST/$path
    if [ -f $d ]; then
      echo "$GREEN[+] Unlinking: $path$DEFAULT"
      rm $d
    fi

    if [ -d $d ] && [ $(ls $d | egrep -v $IGNORE_PATTERN | wc -l) -eq 0 ]; then
      echo "$BLUE[+] Removing Empty Directory: $path$DEFAULT"
      rm -rf $d
    fi
  done
}

case $query in
  "link"    ) link ;;
  "unlink"  ) unlink ;;
  *         ) echo "Invalid Query."; exit 1 ;;
esac


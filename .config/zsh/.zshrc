[ -f "$XDG_CONFIG_HOME/aliases" ] && . "$XDG_CONFIG_HOME/aliases"

SCRIPTS_DIR="$ZDOTDIR/.zshrc.d"
if [ -d $SCRIPTS_DIR ]; then
  for FILE in "$SCRIPTS_DIR/"*.sh; do
    [ -f "$FILE" ] && . "$FILE"
  done
  unset SCRIPTS_DIR FILE
fi

# inspired from my favourite angry, insatiable linux baldster on yt - luke smith.
function lfcd() {
  local dir=$(lf -last-dir-path=/dev/stdout | more)
  [ -d "$dir" ] && cd $dir
}
bindkey -s '^o' "lfcd\n"


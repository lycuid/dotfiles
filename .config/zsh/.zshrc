[ -f "$XDG_CONFIG_HOME/aliases" ] && . "$XDG_CONFIG_HOME/aliases"
[ -f "$XDG_CONFIG_HOME/functions" ] && . "$XDG_CONFIG_HOME/functions"

SCRIPTS_DIR="$ZDOTDIR/.zshrc.d"
if [ -d $SCRIPTS_DIR ]; then
  for FILE in "$SCRIPTS_DIR/"*.sh; do
    [ -f "$FILE" ] && . "$FILE"
  done
  unset SCRIPTS_DIR FILE
fi


[ -f ${XDG_CONFIG_HOME}/aliases ] && . ${XDG_CONFIG_HOME}/aliases

# optional (maybe temporary) env variables to set, without messing up my dotfiles.
[ -f ~/opt/env ] && . ~/opt/env

SCRIPTS_DIR=${ZDOTDIR}/.zshrc.d
if [ -d $SCRIPTS_DIR ]; then
  for FILE in "$SCRIPTS_DIR/"*.sh; do
    [ -f "$FILE" ] && . "$FILE"
  done
  unset SCRIPTS_DIR FILE
fi

export GPG_TTY=$(tty)

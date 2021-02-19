#!/bin/sh

if [ $(fgconsole 2>/dev/null) -eq 1 ]; then
  read -k "zen?Start Zen Mode? [y/n]"
  [ x"$zen" = x"y" ] && wm=dwm || wm=xmonad

  exec startx $XINITRC $wm -- vt1 &>/dev/null
fi

# vim: filetype=sh

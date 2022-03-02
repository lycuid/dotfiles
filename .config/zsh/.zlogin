#!/bin/sh

if [[ $(fgconsole 2>/dev/null) -eq 1 ]]; then
  exec startx $XINITRC -- vt1 &>/dev/null
fi

# vim:ft=sh

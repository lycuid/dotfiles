#!/bin/sh

xrdb $XDG_CONFIG_HOME/X11/Xresources &

xset r rate 300 50 &              # increase x rate.
xsetroot -cursor_name left_ptr &  # good'ol left arrow.

dunst &                           # notification daemon.
compton &                         # compositior (for transparency).
$HOME/.fehbg &                    # setting wallpaper.

exec xmonad                       # window manager.


#!/bin/sh

xrdb -merge ${XDG_CONFIG_HOME:-$HOME/.config}/X11/Xresources &
xset r rate 300 50 &
xsetroot -cursor_name left_ptr &

exec xmonad


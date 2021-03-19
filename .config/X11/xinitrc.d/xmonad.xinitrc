# vim: ft=sh

picom -b &      # compositior (for transparency).
$HOME/.fehbg &  # setting wallpaper.

# This is a fix for https://github.com/xmonad/xmonad/issues/164
[ -d "$HOME/.xmonad" ] && rm -rf $HOME/.xmonad
exec xmonad

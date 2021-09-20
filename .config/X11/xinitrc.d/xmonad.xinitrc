# vim: ft=sh

picom -b &
$HOME/.fehbg &

# This is a fix for https://github.com/xmonad/xmonad/issues/164
rm -rf $HOME/.xmonad
exec xmonad

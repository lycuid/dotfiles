#!/bin/sh
# vim: filetype=sh

[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &>/dev/null || return 0;


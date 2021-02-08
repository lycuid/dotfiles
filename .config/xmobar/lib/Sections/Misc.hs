module Sections.Misc where

import Xmobar

templateSound :: String
templateSound = "<fc=white>\
                \<action=`pactl set-sink-mute @DEFAULT_SINK@ toggle` button=1>\
                \ %sound% \
                \</action></fc>"

templateTmuxls :: String
templateTmuxls =  "<fn=1><fc=#9b59b6>\
                  \<action=`notify_tmux_ls` button=1>\
                  \ \xf120 %tmuxls% \
                  \</action></fc></fn>"

commandDate :: Runnable
commandDate = Run $ Date "\xf073  %a, %b %d %H:%M" "date" 600

commandSound :: Runnable
commandSound = Run $ Com "sh" ["/home/lycuid/.config/xmobar/scripts/sound.sh"] "sound" 1

commandTmuxls :: Runnable
commandTmuxls = Run $ Com "sh" ["/home/lycuid/.config/xmobar/scripts/tmuxls.sh"] "tmuxls" 50

module Sections.Misc where

import Xmobar

templateTmuxls :: String
templateTmuxls =  "<fn=1><fc=#9b59b6>\
                  \<action=`notify_tmux_ls` button=1>\
                  \ \xf120 %tmuxls% \
                  \</action></fc></fn>"

templateVolume :: String
templateVolume =  "<fn=1>\
                  \<action=`volume toggle` button=1>\
                  \ %volume% \
                  \</action></fn>"

commandDate :: Runnable
commandDate = Run $ Date "\xf073  %a, %b %d %H:%M:%S" "date" 10

commandTmuxls :: Runnable
commandTmuxls = Run $ Com "sh" ["/home/lycuid/.config/xmobar/scripts/tmuxls.sh"] "tmuxls" 10

commandVolume :: Runnable
commandVolume = Run $ PipeReader "?:$XDG_RUNTIME_DIR/pipe/volume" "volume"


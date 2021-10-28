module Sections where

import Xmobar
import System.FilePath.Posix ((</>))

templateDate :: String
templateDate = "<fc=white>%date%</fc>"

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
commandDate = Run $ Date "<fn=1>\xf073  %a, %b %d %H:%M:%S</fn> " "date" 10

commandTmuxls :: FilePath -> Runnable
commandTmuxls bin = Run $ Com "sh" [bin </> "tmuxls.sh"] "tmuxls" 10

commandVolume :: Runnable
commandVolume = Run $ PipeReader "?:$XDG_RUNTIME_DIR/pipe/volume" "volume"

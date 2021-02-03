module Sections.Network where

import Xmobar

templateNetwork :: String
templateNetwork = "<fc=white,#292929>\
                  \<action=`xdotool key super+ctrl+n` button=1>\
                  \<box type=Bottom width=2 color=white>\
                  \ %dynnetwork% \
                  \</box></action></fc> "

commandNetwork :: Runnable
commandNetwork = Run $ DynNetwork
  [ "--template" , "<dev>: \xf063 <rx>kb/s \xf062 <tx>kb/s"
  , "--Low"      , "1000"
  , "--High"     , "5000"
  , "--low"      , "#4cd137,#292929"
  , "--normal"   , "#ffdd59,#292929"
  , "--high"     , "#cc6666,#292929"
  ] 30

module Sections.Network where

import Xmobar

templateNetwork :: String
templateNetwork = "<fc=white>\
                  \<action=`xdotool key super+ctrl+n` button=1>\
                  \ %dynnetwork% \
                  \</action></fc>"

commandNetwork :: Runnable
commandNetwork = Run $ DynNetwork
  [ "--template" , "<dev>: \xf0d7 <rx> KiB/s \xf0d8 <tx> KiB/s"
  , "--Low"      , "10000"
  , "--High"     , "50000"
  , "--low"      , "#4cd137"
  , "--normal"   , "#ffdd59"
  , "--high"     , "#cc6666"
  ] 10

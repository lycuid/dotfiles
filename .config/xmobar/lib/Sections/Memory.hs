module Sections.Memory where

import Xmobar

templateMemory :: String
templateMemory = "<fc=white,#292929><action=`notify_max_mem` button=1>\
                  \<box type=Bottom width=2 color=#787878>\
                  \ %memory% \
                  \</box></action></fc> "

commandMemory :: Runnable
commandMemory = Run $ Memory
  [ "--template" ,"\xf233  <usedratio>%"
  , "--Low"      , "25"
  , "--High"     , "65"
  , "--low"      , "#4cd137,#292929"
  , "--normal"   , "#ffdd59,#292929"
  , "--high"     , "#cc6666,#292929"
  ] 10

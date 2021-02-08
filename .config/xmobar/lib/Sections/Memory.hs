module Sections.Memory where

import Xmobar

templateMemory :: String
templateMemory = "<fc=white><action=`notify_max_mem` button=1>\
                  \ %memory% \
                  \</action></fc>"

commandMemory :: Runnable
commandMemory = Run $ Memory
  [ "--template" ,"\xf233  <usedratio>%"
  , "--Low"      , "25"
  , "--High"     , "65"
  , "--low"      , "#4cd137"
  , "--normal"   , "#ffdd59"
  , "--high"     , "#cc6666"
  ] 10

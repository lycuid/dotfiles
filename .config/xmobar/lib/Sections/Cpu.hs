module Sections.Cpu where

import Xmobar

templateCpu :: String
templateCpu = "<fc=white><action=`notify_max_cpu` button=1>\
              \ %cpu% \
              \</action></fc>"

commandCpu :: Runnable
commandCpu = Run $ Cpu
  [ "--template" , "\xf108  <total>%"
  , "--Low"      , "25"
  , "--High"     , "65"
  , "--low"      , "#4cd137"
  , "--normal"   , "#ffdd59"
  , "--high"     , "#cc6666"
  ] 10


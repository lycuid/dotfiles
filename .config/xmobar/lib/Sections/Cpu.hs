module Sections.Cpu where

import Xmobar

templateCpu :: String
templateCpu = "<fc=white,#292929><action=`notify_max_cpu` button=1>\
              \<box type=Bottom width=2 color=#787878> %cpu% </box>\
              \</action></fc> "

commandCpu :: Runnable
commandCpu = Run $ Cpu
  [ "--template" , "\xf108  <total>%"
  , "--Low"      , "25"
  , "--High"     , "65"
  , "--low"      , "#4cd137,#292929"
  , "--normal"   , "#ffdd59,#292929"
  , "--high"     , "#cc6666,#292929"
  ] 10


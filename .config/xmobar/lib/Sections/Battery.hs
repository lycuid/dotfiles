module Sections.Battery where

import Xmobar

templateBattery :: String
templateBattery = "<fc=white,#292929>\
                  \<box type=Bottom width=2 color=#4cd137>\
                  \ %battery% \
                  \</box></fc> "

commandBattery :: Runnable
commandBattery = Run $ Battery
  [ "--template" , "<acstatus>"
  , "--Low"      , "22"
  , "--High"     , "80"
  , "--low"      , "#cc6666,#292929"
  , "--normal"   , "#ffdd59,#292929"
  , "--high"     , "#4cd137,#292929"
  , "--"
  , "-o", "<left>% <fc=#ffdd59,#292929>(<timeleft>)</fc>"
  , "-O", "<left>% <fc=#ffdd59,#292929>\xf0e7</fc>"
  , "-i", "<left>% <fc=#4cd137,#292929>\xf0e7</fc>"
  ] 60


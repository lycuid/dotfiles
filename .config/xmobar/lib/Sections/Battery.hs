module Sections.Battery where

import Xmobar

templateBattery :: String
templateBattery = "<fc=white>\
                  \<box type=Bottom width=1 color=#4cd137>\
                  \ %battery% \
                  \</box></fc>"

commandBattery :: Runnable
commandBattery = Run $ Battery
  [ "--template" , "<acstatus>"
  , "--Low"      , "22"
  , "--High"     , "80"
  , "--low"      , "#cc6666"
  , "--normal"   , "#ffdd59"
  , "--high"     , "#4cd137"
  , "--"
  , "-o", "<left>% <fc=#ffdd59>(<timeleft>)</fc>"
  , "-O", "<left>% <fc=#ffdd59>\xf0e7</fc>"
  , "-i", "<left>% <fc=#4cd137>\xf0e7</fc>"
  ] 10


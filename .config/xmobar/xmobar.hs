import Xmobar

import Sections.Misc
import Sections.Battery
import Sections.Cpu
import Sections.Memory
import Sections.Network

config :: Config
config
  = defaultConfig
  { font              = "xft:FiraCode Nerd Font-8,monospace-14"
  , additionalFonts   = ["xft:FiraCode Nerd Font-8:style=Bold,monospace-14"]
  , overrideRedirect  = True
  , bgColor           = "#191919"
  , fgColor           = "#bdc3c7"
  , alpha             = 255
  , position          = Bottom
  , textOffset        = -1
  , iconOffset        = -1
  , lowerOnStart      = True
  , pickBroadest      = False
  , persistent        = False
  , hideOnStart       = False
  , iconRoot          = "."
  , allDesktops       = True
  , sepChar           = "%"
  , alignSep          = "}{"
  , template          = "%UnsafeStdinReader%}<fc=white>%date%</fc>{"
                      ++ templateNetwork
                      ++ templateCpu
                      ++ templateMemory
                      ++ templateSound
                      ++ templateTmuxls
                      ++ templateBattery
  , commands          = [ commandNetwork
                        , commandCpu
                        , commandMemory
                        , commandBattery
                        , commandDate
                        , commandTmuxls
                        , commandSound
                        , Run $ UnsafeStdinReader
                        ]
}

main :: IO ()
main = xmobar config

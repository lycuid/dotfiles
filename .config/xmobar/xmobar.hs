import Xmobar

import Sections.Misc
import Sections.Battery
import Sections.Cpu
import Sections.Memory
import Sections.Network

import Data.List (intercalate)


tmplLeft :: String
tmplLeft = "%UnsafeStdinReader%"

tmplCenter :: String
tmplCenter = "<fc=white>%date%</fc>"

tmplRight :: String
tmplRight = intercalate " <box type=Left width=2 color=#303030> </box>"
          [ templateNetwork
          , templateCpu
          , templateMemory
          , templateTmuxls
          , templateBattery
          ]

config :: Config
config
  = defaultConfig
  { font              = "xft:FiraCode Nerd Font-8,monospace-14"
  , additionalFonts   = ["xft:FiraCode Nerd Font-8:style=Bold,monospace-14"]
  , overrideRedirect  = True
  , bgColor           = "#191919"
  , fgColor           = "#bdc3c7"
  , alpha             = 225
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
  , template          = tmplLeft ++ "}" ++ tmplCenter ++ "{" ++ tmplRight
  , commands          = [ commandNetwork
                        , commandCpu
                        , commandMemory
                        , commandBattery
                        , commandDate
                        , commandTmuxls
                        , Run $ UnsafeStdinReader
                        ]
}

main :: IO ()
main = xmobar config

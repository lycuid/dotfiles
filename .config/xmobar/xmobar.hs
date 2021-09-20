import Xmobar

import Sections
import Sections.Battery
import Sections.Cpu
import Sections.Memory
import Sections.Network

import System.Directory   (getCurrentDirectory)
import Data.List          (intercalate)

tmplLeft :: String
tmplLeft = "%UnsafeStdinReader%"

tmplCenter :: String
tmplCenter = "<fc=white>%date%</fc>"

tmplRight :: String
tmplRight = intercalate " <box type=Left width=2 color=#171717> </box>"
          [ templateNetwork
          , templateCpu
          , templateMemory
          , templateVolume
          , templateTmuxls
          , templateBattery
          ]

config :: IO Config
config = do
  pwd <- getCurrentDirectory
  return defaultConfig
    { font              = "xft:TerminessTTF Nerd Font-10,monospace-11"
    , additionalFonts   = ["xft:TerminessTTF Nerd Font-10:style=Bold,monospace-11"]
    , overrideRedirect  = True
    , bgColor           = "#090909"
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
    , template          = tmplLeft ++ "}" ++ tmplCenter ++ "{" ++ tmplRight
    , commands          = [ commandNetwork
                          , commandCpu
                          , commandMemory
                          , commandVolume
                          , commandTmuxls pwd
                          , commandBattery
                          , commandDate
                          , Run $ UnsafeStdinReader
                          ]
  }

main :: IO ()
main = do
  conf <- config
  xmobar conf

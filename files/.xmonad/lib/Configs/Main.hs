module Configs.Main where

import XMonad

myTerminal              = "$TERMINAL"
myEditor                = "$EDITOR"
myBrowser               = "$BROWSER"
myTerminalWithResource  = unwords [myTerminal, "-n"]
myProjectsDir           = "$HOME/xkcd/scm"

myBrowsers = ["Brave-browser", "Firefox"]
myFloating = ["MPlayer", "Gimp", "mpv", "vlc"]

myFocusFollowsMouse     = False
myClickJustFocuses      = False
myBorderWidth           = 1 :: Dimension
myModMask               = mod4Mask
myFocusedBorderColor    = "#9b59b6"
myNormalBorderColor     = "#000000"

runScript :: String -> [String] -> String
runScript comm args =  unwords (comm : args)


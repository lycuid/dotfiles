module Configs.Main where

import XMonad

myTerminal              = "$TERMINAL"
myTerminalWithResource  = unwords [myTerminal, "-n"]
myEditor                = "$EDITOR"

myBrowsers              = ["Brave-browser", "Firefox"]
myFloating              = ["Gimp", "mpv", "vlc"]

myFocusFollowsMouse     = False
myClickJustFocuses      = False
myBorderWidth           = 2 :: Dimension
myModMask               = mod4Mask
myFocusedBorderColor    = "#9b59b6"
myNormalBorderColor     = "#000000"


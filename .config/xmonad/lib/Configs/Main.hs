module Configs.Main where

import XMonad
import XMonad.Hooks.DynamicLog  (wrap, xmobarColor)
import Configs.Colors           (Colors(..))

myTerminal              = "$TERMINAL"
myTerminalWithResource  = unwords [myTerminal, "-n"]
myEditor                = "$EDITOR"

myBrowsers              = ["Brave-browser", "Firefox"]
myFloating              = ["Gimp", "mpv", "vlc"]

myFocusFollowsMouse     = False
myClickJustFocuses      = False
myBorderWidth           = 1 :: Dimension
myModMask               = mod4Mask
myFocusedBorderColor    = "#9b59b6"
myNormalBorderColor     = "#000000"

myXmobarLayoutStyle = cycleLayoutAction . whiteColor . greenBox
  where
    cycleLayoutAction = wrap "<action=xdotool key super+space>" "</action>"
    whiteColor = xmobarColor "white" ""
    greenBox = wrap ("<box type=Bottom width=1 color=" ++ (green def) ++ "> ") " </box>"


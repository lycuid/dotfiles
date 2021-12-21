module Configs where

import           Configs.Colors          (Colors (..))
import           XMonad
import           XMonad.Hooks.DynamicLog (wrap)

myTerminal :: String
myTerminal = "$TERMINAL"

myTerminalWithResource :: String
myTerminalWithResource = unwords [myTerminal, "-n"]

myEditor :: String
myEditor = "$EDITOR"

myBrowsers :: [String]
myBrowsers = ["Brave-browser"]

myFloating :: [String]
myFloating = ["Gimp", "mpv", "vlc"]

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth :: Dimension
myBorderWidth = 2

myModMask :: KeyMask
myModMask = mod4Mask

myFocusedBorderColor :: String
myFocusedBorderColor = "#9b59b6"

myNormalBorderColor :: String
myNormalBorderColor = "#000000"

xdbarFg       :: String -> String -> String
xdbarFg ""    = id
xdbarFg color = wrap ("<Fg=" ++ color ++ ">") "</Fg>"

myXdbarLayoutStyle :: String -> String
myXdbarLayoutStyle = cycleLayoutAction . greenBox
  where
    cycleLayoutAction = wrap "<BtnL=xdotool key super+space>" "</BtnL>"
    greenBox          = wrap ("<Box:Bottom=" ++ cyan def ++ ":1> ") " </Box>"

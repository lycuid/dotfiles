module Configs.Main where

import XMonad

myTerminal              = "alacritty"
myTerminalWithClass     = unwords [myTerminal, "--class"]
myProjectsDir           = "$HOME/xkcd/scm"
myFocusFollowsMouse     = False
myClickJustFocuses      = False
myBorderWidth           = 1 :: Dimension
myModMask               = mod4Mask
myFocusedBorderColor    = "#9b59b6"
myNormalBorderColor     = "#d0d0d0"

runScript :: String -> [String] -> String
runScript comm args =  unwords (comm : args)


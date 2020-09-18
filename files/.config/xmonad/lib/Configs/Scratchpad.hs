module Configs.Scratchpad where

import XMonad
import XMonad.Util.NamedScratchpad  ( customFloating
                                    , NamedScratchpad(..)
                                    )
import qualified XMonad.StackSet as W

import Configs.Main

myScratchpads = [ NS "term" spawnTerminal (resource =? "scratchpad-term") centerFloating
                , NS "fm" spawnFileManager (resource =? "scratchpad-fm") centerFloating
                ]
  where
    spawnTerminal     = unwords [myTerminalWithResource, "scratchpad-term"]
    spawnFileManager  = unwords [myTerminalWithResource, "scratchpad-fm", "-e", "vifm", "$HOME"]
    centerFloating    = customFloating $ W.RationalRect (1/10) (1/10) (4/5) (4/5)


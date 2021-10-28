module Configs.Scratchpad where

import           Configs

import           XMonad
import qualified XMonad.StackSet             as W
import           XMonad.Util.NamedScratchpad (NamedScratchpad (..),
                                              customFloating)

myScratchpads = [ NS "term" spawnTerminal (resource =? "scratchpad-term") centerFloating
                , NS "fm" spawnFileManager (resource =? "scratchpad-fm") centerFloating
                , NS "nm" spawnNetworkManager (resource =? "scratchpad-nm") centerFloating
                ]
  where
    spawnTerminal       = unwords [myTerminalWithResource, "scratchpad-term"]
    spawnFileManager    = unwords [myTerminalWithResource, "scratchpad-fm", "-e", "vifm"]
    spawnNetworkManager = unwords [myTerminalWithResource, "scratchpad-nm", "-e", "nmtui"]
    centerFloating      = customFloating $ W.RationalRect (1/10) (1/10) (4/5) (4/5)

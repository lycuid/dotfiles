module Configs.XPrompt
  ( shellXPrompt
  , nvimXPrompt
  ) where

import XMonad
import XMonad.Prompt
import XMonad.Prompt.Shell      (shellPrompt, getShellCompl)
import XMonad.Util.Run          (unsafeSpawn)

import Data.List                (isInfixOf)

import Configs.Main             (myTerminal)
import Configs.Colors   (Colors(..), defColors, nvimColors)


xpConfig :: XPConfig
xpConfig = def  { font                  = "xft:BlexMono Nerd Font:size=9"
                , fgColor               = light defColors
                , bgColor               = dark defColors
                , fgHLight              = light defColors
                , bgHLight              = blue defColors
                , promptBorderWidth     = 0
                , position              = CenteredAt 0.3 0.5
                , alwaysHighlight       = False
                , height                = 25
                , promptKeymap          = emacsLikeXPKeymap
                , historySize           = 128
                , searchPredicate       = isInfixOf
                , maxComplRows          = Just 5
                -- , historyFilter :: [String] -> [String]
                -- , completionKey :: (KeyMask, KeySym)
                -- , changeModeKey :: KeySym
                -- , defaultText :: String
                -- , autoComplete :: Maybe Int
                -- , showCompletionOnTab :: Bool
                -- , searchPredicate :: String -> String -> Bool
                }

shellXPrompt :: X ()
shellXPrompt = shellPrompt xpConfig

data Nvim = Nvim

instance XPrompt Nvim where
  showXPrompt Nvim = "edit: "

nvimXPConfig = xpConfig { bgColor  = blue nvimColors
                        , bgHLight = green nvimColors
                        , fgHLight = dark nvimColors
                        }

{- @TODO: write a custom 'getShellCompl' function. -}
nvimXPrompt :: X ()
nvimXPrompt = mkXPrompt Nvim nvimXPConfig (getShellCompl [cmd] $ searchPredicate nvimXPConfig) run
    where
      run a   = unsafeSpawn $ cmd ++ " " ++ a
      cmd     = unwords [myTerminal, "-e", "nvim"]


module Configs.XPrompt
  ( shellXPrompt
  , nvimXPrompt
  ) where

import XMonad
import XMonad.Prompt
import XMonad.Prompt.Shell      (shellPrompt, getShellCompl)
import XMonad.Util.Run          (unsafeSpawn)

import Data.List                (isInfixOf)

import Configs.Colors   (Colors(..), defColors)


xpConfig :: XPConfig
xpConfig =
    def
      { font                  = "xft:TerminessTTF NF:size=12"
      , fgColor               = white defColors
      , bgColor               = black defColors
      , bgHLight              = cyan defColors
      , fgHLight              = black defColors
      , borderColor           = blue defColors
      , promptBorderWidth     = 2
      , position              = CenteredAt 0.2 0.5
      , alwaysHighlight       = False
      , height                = 30
      , promptKeymap          = emacsLikeXPKeymap
      , historySize           = 64
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

nvimXPConfig = xpConfig

{- @TODO: write a custom 'getShellCompl' function. -}
nvimXPrompt :: XConfig Layout -> X ()
nvimXPrompt conf = mkXPrompt Nvim nvimXPConfig (getShellCompl [cmd] $ searchPredicate nvimXPConfig) run
    where
      run a  = unsafeSpawn $ cmd ++ " " ++ a
      cmd    = unwords [XMonad.terminal conf, "-e", "nvim"]


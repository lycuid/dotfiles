module Configs.XPrompt
  ( shellXPrompt
  , editorXPrompt
  ) where

import XMonad
import XMonad.Prompt
import XMonad.Prompt.Shell      (shellPrompt, getShellCompl)
import XMonad.Util.Run          (unsafeSpawn)

import Data.List                (isInfixOf)

import Configs.Main             (myEditor)
import Configs.Colors           (Colors(..))


xpConfig :: XPConfig
xpConfig =
  def
    { font                  = "xft:monospace-11"
    , fgColor               = white def
    , bgColor               = black def
    , bgHLight              = cyan def
    , fgHLight              = black def
    , borderColor           = blue def
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

data Editor = Editor

instance XPrompt Editor where
  showXPrompt Editor = "edit: "

editorXPConfig = xpConfig

{- @TODO: write a custom 'getShellCompl' function. -}
editorXPrompt :: XConfig Layout -> X ()
editorXPrompt conf = mkXPrompt Editor editorXPConfig (getShellCompl [cmd] $ searchPredicate editorXPConfig) run
  where
    run a  = unsafeSpawn $ cmd ++ " " ++ a
    cmd    = unwords [XMonad.terminal conf, "-e", myEditor]


{-# LANGUAGE FlexibleContexts #-}

module Configs.KeyBindings where

import XMonad
import XMonad.Util.NamedScratchpad  (namedScratchpadAction)

import Configs.XPrompt              (editorXPrompt)
import Configs.Scratchpad           (myScratchpads)

keymod m = (\x -> ((m, fst x), snd x))

myCustomKeyBindings conf@(XConfig {XMonad.modMask = modm}) =
  -- prompt keybindings.
  [ ((modm,                   xK_o),  editorXPrompt conf)

  -- named scratchpads keybindings.
  , ((modm .|. controlMask,   xK_Return), scratchpad "term")
  , ((modm .|. controlMask,   xK_f),      scratchpad "fm")
  , ((modm .|. controlMask,   xK_n),      scratchpad "nm")
  ]
    where
      ws = XMonad.workspaces conf
      scratchpad = namedScratchpadAction myScratchpads


{-# LANGUAGE FlexibleContexts #-}

module Configs.KeyBindings where

import XMonad
import XMonad.Util.NamedScratchpad  (namedScratchpadAction)
import XMonad.Layout.Spacing        ( incWindowSpacing
                                    , decWindowSpacing
                                    , incScreenSpacing
                                    , decScreenSpacing
                                    )

import Configs.XPrompt              (editorXPrompt)
import Configs.Scratchpad           (myScratchpads)


keymod m = (\x -> ((m, fst x), snd x))

myCustomKeyBindings conf@(XConfig {XMonad.modMask = modm}) =
  -- prompt keybindings.
  [ ((modm,                   xK_o),  editorXPrompt conf)

  -- layout spacing update keybindings.
  , ((modm .|. controlMask,   xK_k),  incWindowSpacing 1)
  , ((modm .|. controlMask,   xK_j),  decWindowSpacing 1)
  , ((modm .|. controlMask,   xK_l),  incScreenSpacing 1)
  , ((modm .|. controlMask,   xK_h),  decScreenSpacing 1)

  -- named scratchpads keybindings.
  , ((modm .|. controlMask,   xK_Return), scratchpad "term")
  , ((modm .|. controlMask,   xK_f),      scratchpad "fm")
  ]
    where
      ws = XMonad.workspaces conf
      scratchpad = namedScratchpadAction myScratchpads


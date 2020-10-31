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
  -- , ((modm .|. shiftMask,   xK_k),  incWindowSpacing 1)
  -- , ((modm .|. shiftMask,   xK_j),  decWindowSpacing 1)
  -- , ((modm .|. shiftMask,   xK_l),  incScreenSpacing 1)
  -- , ((modm .|. shiftMask,   xK_h),  decScreenSpacing 1)

  -- named scratchpads keybindings.
  , ((modm .|. controlMask,   xK_Return), scratchpad "term")
  , ((modm .|. controlMask,   xK_f),      scratchpad "fm")
  , ((modm .|. controlMask,   xK_n),      scratchpad "nm")
  ]
    where
      ws = XMonad.workspaces conf
      scratchpad = namedScratchpadAction myScratchpads


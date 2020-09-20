{-# LANGUAGE FlexibleContexts #-}

module Configs.KeyBindings where

import XMonad
import XMonad.Util.NamedScratchpad  (namedScratchpadAction)
import XMonad.Layout.Spacing        ( incWindowSpacing
                                    , decWindowSpacing
                                    , incScreenSpacing
                                    , decScreenSpacing
                                    )

import Configs.Main
import Configs.XPrompt              (editorXPrompt)
import Configs.Scratchpad           (myScratchpads)

import Data.List                    (elemIndex)
import Data.Maybe                   (fromMaybe)

import qualified XMonad.StackSet as W

keymod m = (\x -> ((m, fst x), snd x))

nextWorkspace ws adder = ws !! nextIndex
  where
    nextIndex   = fromMaybe 0 . fmap (adder . flip mod (length ws)) $ maybeIndex
    maybeIndex  = elemIndex W.currentTag ws

myCustomKeyBindings conf@(XConfig {XMonad.modMask = modm}) =
  -- screen lock keybinding.
  [ ((modm .|. shiftMask, xK_l), spawn "slock")

  -- prompt keybindings.
  , ((modm,                       xK_p),   spawn "dmenu_run")
  , ((modm,                       xK_o),   editorXPrompt conf)
  , ((controlMask .|. shiftMask,  xK_o),   spawn
      . runScript "dmenu_vim_edit" $
      [ "--dirmode"
      , "--embed"
      , "--prompt", "\"open project :\""
      , myProjectsDir
      ])

  -- layout spacing update keybindings.
  , ((modm .|. controlMask,   xK_k),      incWindowSpacing 1)
  , ((modm .|. controlMask,   xK_j),      decWindowSpacing 1)
  , ((modm .|. controlMask,   xK_l),      incScreenSpacing 1)
  , ((modm .|. controlMask,   xK_h),      decScreenSpacing 1)

  -- Master Volume Control keybindings.
  , ((modm ,                  xK_equal),  spawn "amixer set Master 1%+")
  , ((modm ,                   xK_plus),  spawn "amixer set Master 1%+")
  , ((modm ,                  xK_minus),  spawn "amixer set Master 1%-")

  -- equal and plus are the same key on tkl/60% keyboards.
  , ((modm .|. controlMask,   xK_equal),  spawn "amixer set Master 5%+")
  , ((modm .|. controlMask,   xK_plus),   spawn "amixer set Master 5%+")
  , ((modm .|. controlMask,   xK_minus),  spawn "amixer set Master 5%-")
  , ((modm ,                  xK_m),      spawn "amixer set Master toggle")

  -- named scratchpads keybindings.
  , ((modm .|. controlMask,   xK_Return), namedScratchpadAction myScratchpads "term")
  , ((modm .|. controlMask,   xK_f),      namedScratchpadAction myScratchpads "fm")

  -- , ((modm,                   xK_Left),   windows . W.view $ (nextWorkspace ws (-1)))
  -- , ((modm,                   xK_Right),  windows . W.view $ (nextWorkspace ws (+1)))

  -- , ((modm,                   xK_Left),   windows . W.greedyView . W.currentTag $ ws)
  -- , ((modm,                   xK_Right),  windows . W.view $ (nextWorkspace ws (+1)))
  ]
    where
      ws = XMonad.workspaces conf


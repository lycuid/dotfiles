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


keymod m = (\x -> ((m, fst x), snd x))

myCustomKeyBindings conf@(XConfig {XMonad.modMask = modm}) =
  -- screen lock keybinding.
  [ ((modm .|. shiftMask, xK_l), spawn "slock")

  -- prompt keybindings.
  , ((modm,                      xK_p), spawn "dmenu_run")
  , ((modm,                      xK_o), editorXPrompt conf)
  , ((controlMask .|. shiftMask, xK_o), spawn
      . runScript "dmenu_vim_edit" $
      [ "--dirmode"
      , "--embed"
      , "--prompt", "\"open project :\""
      , myProjectsDir
      ])

  -- layout spacing update keybindings.
  , ((modm .|. controlMask,       xK_k), incWindowSpacing 1)
  , ((modm .|. controlMask,       xK_j), decWindowSpacing 1)
  , ((modm .|. controlMask,       xK_l), incScreenSpacing 1)
  , ((modm .|. controlMask,       xK_h), decScreenSpacing 1)

  -- Master Volume Control keybindings.

  -- equal and plus are the same key on tkl/60% keyboards.
  , ((modm .|. controlMask,   xK_equal), spawn "amixer set Master 5%+")
  , ((modm .|. controlMask,    xK_plus), spawn "amixer set Master 5%+")
  , ((modm .|. controlMask,   xK_minus), spawn "amixer set Master 5%-")

  -- inc/dec by 1% for left/right, (hence 2% inc/dec total).
  , ((modm ,                  xK_equal), spawn "amixer set Master 2%+")
  , ((modm ,                   xK_plus), spawn "amixer set Master 2%+")
  , ((modm ,                  xK_minus), spawn "amixer set Master 2%-")
  , ((modm ,                      xK_m), spawn "amixer set Master toggle")

  -- named scratchpads keybindings.
  , ((modm .|. controlMask,   xK_Return), namedScratchpadAction myScratchpads "term")
  , ((modm .|. controlMask,   xK_f),      namedScratchpadAction myScratchpads "fm")
  ]


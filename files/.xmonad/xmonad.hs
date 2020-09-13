import XMonad

import XMonad.Util.Run                (spawnPipe, hPutStrLn)
import XMonad.Util.SpawnOnce          (spawnOnce)
import XMonad.Util.NamedScratchpad    (namedScratchpadManageHook)

import XMonad.Hooks.ManageDocks       (docks, avoidStruts)
import XMonad.Hooks.DynamicLog        ( dynamicLogWithPP
                                      , wrap
                                      , shorten
                                      , xmobarColor
                                      , PP(..)
                                      )

import XMonad.Layout.LimitWindows     (limitWindows)
import XMonad.Layout.Magnifier        (magnifier)
import XMonad.Layout.ResizableTile    (ResizableTall(..))
import XMonad.Layout.Renamed          (renamed, Rename(Replace))
import XMonad.Layout.NoBorders        (noBorders)
import XMonad.Layout.Tabbed           ( tabbedBottom
                                      , shrinkText
                                      , Theme(..))
import XMonad.Layout.Spacing          (spacingRaw, Border(..))

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Data.Monoid
import Text.Printf                    (printf)
import System.Exit
import Data.List                      (isInfixOf)

import Configs.Main
import Configs.KeyBindings            (keymod, myCustomKeyBindings)
import Configs.Scratchpad             (myScratchpads)
import Configs.Colors                 (Colors(..))

{- Making the workspace tabs on xmobar, clickable. -}
myWorkspaces :: [String]
myWorkspaces  = clickAction ["I", "II", "III", "IV", "V"]
  where
    clickAction = map (uncurry action) . zip (map show [1..])
    action = printf "<action=xdotool key super+%s> %s </action>"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.

modMaps conf@(XConfig {XMonad.modMask = modm}) = map (keymod modm)
  -- launch a terminal
  [ (xK_Return  , spawn $ XMonad.terminal conf)
  -- Move focus to the next window
  , (xK_j       , windows W.focusDown)
  -- Move focus to the previous window
  , (xK_k       , windows W.focusUp  )
  -- Rotate through the available layout algorithms
  , (xK_space   , sendMessage NextLayout)
  -- Resize viewed windows to the correct size
  , (xK_n       , refresh)
  -- Move focus to the next window
  , (xK_Tab     , windows W.focusDown)
  -- Move focus to the master window
  , (xK_m       , windows W.focusMaster  )
  -- Shrink the master area
  , (xK_h       , sendMessage Shrink)
  -- Expand the master area
  , (xK_l       , sendMessage Expand)
  -- Push window back into tiling
  , (xK_t       , withFocused $ windows . W.sink)
  -- Increment the number of windows in the master area
  , (xK_comma   , sendMessage (IncMasterN 1))
  -- Deincrement the number of windows in the master area
  , (xK_period  , sendMessage (IncMasterN (-1)))
  -- Restart xmonad
  , (xK_q       , spawn "xmonad --recompile; xmonad --restart")
  -- Toggle the status bar gap
  -- Use this binding with avoidStruts from Hooks.ManageDocks.
  -- See also the statusBar function from Hooks.DynamicLog.
  -- , (xK_b, sendMessage ToggleStruts)
  ]

modShiftMaps conf@(XConfig {XMonad.modMask = modm}) = map (keymod (modm .|. shiftMask))
  -- close focused window
  [ (xK_c       , kill)
  --  Reset the layouts on the current workspace to default
  , (xK_space   , setLayout $ XMonad.layoutHook conf)
  -- Swap the focused window and the master window
  , (xK_Return  , windows W.swapMaster)
  -- Swap the focused window with the next window
  , (xK_j       , windows W.swapDown  )
  -- Swap the focused window with the previous window
  , (xK_k       , windows W.swapUp    )
  -- Quit xmonad
  , (xK_q       , io (exitWith ExitSuccess))
  ]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  modMaps             conf ++
  modShiftMaps        conf ++
  myCustomKeyBindings conf ++
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++
  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  --
  [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
  -- mod-button1, Set the window to floating mode and move by dragging
  [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                     >> windows W.shiftMaster))
  -- mod-button2, Raise the window to the top of the stack
  , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
  -- mod-button3, Set the window to floating mode and resize by dragging
  , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                     >> windows W.shiftMaster))
  -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]

------------------------------------------------------------------------
-- Layouts:

myLayout  = avoidStruts $ customSpacing
          $ master_slave
          ||| tabbed_bottom
          ||| full
          ||| mirrored
          ||| magnify
  where
    customSpacing = spacingRaw True (Border 3 3 3 3) True (Border 3 3 3 3) True

    master_slave  = renamed [Replace "MasterSlave"] $ Tall 1 (3/100) (1/2)
    tabbed_bottom = renamed [Replace "BottomTabbed"]
                  $ noBorders $ tabbedBottom shrinkText def
                  { activeColor           = highlight def
                  , inactiveColor         = black def
                  , activeBorderColor     = black def
                  , inactiveBorderColor   = black def
                  , fontName              = "xft:Liberation Mono-9"
                  }
    full          = renamed [Replace "Full"] $ noBorders Full
    mirrored      = renamed [Replace "Mirrored"] $ Mirror master_slave
    magnify       = renamed [Replace "Magnify"]
                  $ magnifier
                  $ limitWindows 12
                  $ ResizableTall 1 (3/100) (1/2) []

------------------------------------------------------------------------
-- Window rules:

myManageHook = (composeAll . concat $
  [ [fmap (isInfixOf x) className --> doFloat | x <- myFloating]
  , [fmap (isInfixOf x) className --> doShift (myWorkspaces !! 2) | x <- myBrowsers]
  , [fmap (isInfixOf x) className <&&> resource =? "Dialog" --> doFloat | x <- myBrowsers]
  ]) <+> namedScratchpadManageHook myScratchpads

------------------------------------------------------------------------
-- Event handling

myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

myLogHook proc = dynamicLogWithPP
  def
    { ppCurrent           = xmobarColor (white def) (highlight def)
                          . wrap ("<box type=Bottom width=2 color=" ++ (cyan def) ++ ">") "</box>"
    , ppHidden            = xmobarColor (white def) ""
    , ppHiddenNoWindows   = xmobarColor "#353535" ""
    , ppVisibleNoWindows  = Just (xmobarColor "red" "")
    , ppUrgent            = xmobarColor (red def) ""
    , ppTitle             = xmobarColor (green def) "" . shorten 30
    , ppSep               = "<fc=" ++ (white def) ++ "> | </fc>"
    , ppOrder             = take 3
    , ppOutput            = hPutStrLn proc
    }

------------------------------------------------------------------------
-- Startup hook

myStartupHook = do
 spawnOnce (runScript "session_init" [])

main = do
  xmobarProc <- spawnPipe "xmobar"
  xmonad $ docks $ def
    { terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , clickJustFocuses   = myClickJustFocuses
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , keys               = myKeys
    , mouseBindings      = myMouseBindings
    , layoutHook         = myLayout
    , manageHook         = myManageHook
    , handleEventHook    = myEventHook
    , logHook            = myLogHook xmobarProc
    , startupHook        = myStartupHook
    }


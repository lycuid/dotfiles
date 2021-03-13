import XMonad
import XMonad.Util.Run                (spawnPipe, hPutStrLn)
import XMonad.Util.SpawnOnce          (spawnOnce)
import XMonad.Util.NamedScratchpad    (namedScratchpadManageHook)

import XMonad.Hooks.ManageDocks       ( docks
                                      , avoidStruts
                                      , ToggleStruts(..))
import XMonad.Hooks.DynamicLog        ( dynamicLogWithPP
                                      , wrap
                                      , shorten
                                      , xmobarColor
                                      , PP(..)
                                      )

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Layouts.
import XMonad.Layout.Renamed          (renamed, Rename(Replace))
import XMonad.Layout.NoBorders        (noBorders)
import XMonad.Layout.Spacing          (spacingRaw, Border(..))

-- User Configs.
import Configs.Main
import Configs.KeyBindings            (keymod, myCustomKeyBindings)
import Configs.Scratchpad             (myScratchpads)
import Configs.Colors                 (Colors(..))

-- misc.
import Data.Monoid
import Text.Printf                    (printf)
import System.Exit
import Data.List                      (isInfixOf)

------------------------------------------------------------------------
-- Workspaces.
myWorkspaces :: [String]
myWorkspaces  = clickAction . map show $ [1..5]
  -- Making the workspace tabs on xmobar, clickable.
  where
    clickAction = map (uncurry action) . zip (map show [1..])
    action = printf "<action=xdotool key super+%s> %s </action>"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
modMaps conf@(XConfig {XMonad.modMask = modm}) = map (keymod modm)
  -- Move focus to the next window
  [ (xK_j       , windows W.focusDown)
  -- Move focus to the previous window
  , (xK_k       , windows W.focusUp)
  -- Rotate through the available layout algorithms
  , (xK_space   , sendMessage NextLayout)
  -- Resize viewed windows to the correct size
  , (xK_n       , refresh)
  -- Move focus to the next window
  , (xK_Tab     , windows W.focusDown)
  -- Move focus to the master window
  , (xK_m       , windows W.focusMaster)
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
  , (xK_b       , sendMessage ToggleStruts)
  ]

modShiftMaps conf@(XConfig {XMonad.modMask = modm}) = map (keymod (modm .|. shiftMask))
  -- close focused window
  [ (xK_c       , kill)
  --  Reset the layouts on the current workspace to default
  , (xK_space   , setLayout $ XMonad.layoutHook conf)
  -- Swap the focused window and the master window
  , (xK_Return  , windows W.swapMaster)
  -- Swap the focused window with the next window
  , (xK_j       , windows W.swapDown)
  -- Swap the focused window with the previous window
  , (xK_k       , windows W.swapUp)
  -- Quit xmonad
  , (xK_q       , io (exitWith ExitSuccess))
  ]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  modMaps             conf ++
  modShiftMaps        conf ++
  myCustomKeyBindings conf ++
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((modm .|. mask, key), windows $ f i)
    | (i, key)  <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, mask) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++
  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((modm .|. mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    , (f, mask) <- [(W.view, 0), (W.shift, shiftMask)]]

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
myLayout  = avoidStruts $ tall ||| full ||| mirrored
  where
    spacing = spacingRaw False (Border 3 3 3 3) True (Border 3 3 3 3) True

    tall      = renamed [Replace "T"] . spacing $ Tall 1 (3/100) (1/2)
    full      = renamed [Replace "F"] $ noBorders Full
    mirrored  = renamed [Replace "M"] . spacing $ Mirror tall

------------------------------------------------------------------------
-- Window rules:
myManageHook = (composeAll . concat $
  [ [fmap (isInfixOf x) className --> doFloat | x <- myFloating]
  , [fmap (isInfixOf x) className --> doShift (myWorkspaces !! 2) | x <- myBrowsers]
  , [fmap (isInfixOf x) className <&&> resource =? "Dialog" --> doFloat | x <- myBrowsers]
  ])

------------------------------------------------------------------------
-- Event handling
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging
myLogHook proc = do
  noOfWs' <- gets $ show . length . W.integrate' . W.stack . W.workspace . W.current . windowset
  dynamicLogWithPP $ def
    { ppCurrent           = xmobarColor (white def) ""
                          . wrap ("<box type=Bottom width=1 color=" ++ (cyan def) ++ ">") "</box>"
    , ppHidden            = xmobarColor (white def) ""
    , ppHiddenNoWindows   = xmobarColor "#353535" ""
    , ppVisibleNoWindows  = Just (xmobarColor "red" "")
    , ppUrgent            = xmobarColor (red def) ""
    , ppTitle             = xmobarColor (green def) "" . shorten 30
    , ppSep               = " <box type=Left width=2 color=#303030> </box>"
    , ppLayout            = myXmobarLayoutStyle . flip (++) (wrap " [" "]" noOfWs')
    , ppOrder             = take 3
    , ppOutput            = hPutStrLn proc
    }

------------------------------------------------------------------------
-- Startup hook
myStartupHook = do
  spawnOnce "notify_welcome"

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
    , handleEventHook    = myEventHook
    , logHook            = myLogHook xmobarProc
    , startupHook        = myStartupHook
    , manageHook         = myManageHook <+> namedScratchpadManageHook myScratchpads
    }


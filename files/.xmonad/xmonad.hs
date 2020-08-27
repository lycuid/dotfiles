import XMonad

import XMonad.Util.Run                (spawnPipe, hPutStrLn)
import XMonad.Util.SpawnOnce          (spawnOnce)
import XMonad.Util.NamedScratchpad    ( namedScratchpadAction
                                      , namedScratchpadManageHook
                                      , customFloating
                                      , NamedScratchpad(..)
                                      )

import XMonad.Hooks.ManageDocks       (docks, avoidStruts)
import XMonad.Hooks.DynamicLog        ( dynamicLogWithPP
                                      , wrap
                                      , shorten
                                      , xmobarPP
                                      , xmobarColor
                                      , PP(..)
                                      )

import XMonad.Layout.LimitWindows     (limitWindows)
import XMonad.Layout.Magnifier        (magnifier)
import XMonad.Layout.ResizableTile    (ResizableTall(..))
import XMonad.Layout.Renamed          (renamed, Rename(Replace))
import XMonad.Layout.NoBorders        (noBorders)

import Data.Monoid
import Text.Printf                    (printf)
import System.Exit
import Data.List                      (isInfixOf)

import Configs.Main
import Configs.XPrompt                (nvimXPrompt)
import Configs.Colors                 (Colors(..), defColors)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M


{- Making the workspace tabs on xmobar, clickable. -}
myWorkspaces :: [String]
myWorkspaces  = map clickAction [1..5]
  where
    clickAction = (uncurry action) . (\x -> (x, x)) . show
    action = printf "<action=xdotool key super+%s> %s </action>"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  -- launch a terminal
  --
  [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

  -- close focused window
  , ((modm .|. shiftMask, xK_c     ), kill)

   -- Rotate through the available layout algorithms
  , ((modm,               xK_space ), sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default
  , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size
  , ((modm,               xK_n     ), refresh)

  -- Move focus to the next window
  , ((modm,               xK_Tab   ), windows W.focusDown)

  -- Move focus to the next window
  , ((modm,               xK_j     ), windows W.focusDown)

  -- Move focus to the previous window
  , ((modm,               xK_k     ), windows W.focusUp  )

  -- Move focus to the master window
  , ((modm,               xK_m     ), windows W.focusMaster  )

  -- Swap the focused window and the master window
  , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

  -- Swap the focused window with the next window
  , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

  -- Swap the focused window with the previous window
  , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

  -- Shrink the master area
  , ((modm,               xK_h     ), sendMessage Shrink)

  -- Expand the master area
  , ((modm,               xK_l     ), sendMessage Expand)

  -- Push window back into tiling
  , ((modm,               xK_t     ), withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area
  , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

  -- Deincrement the number of windows in the master area
  , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

  -- Toggle the status bar gap
  -- Use this binding with avoidStruts from Hooks.ManageDocks.
  -- See also the statusBar function from Hooks.DynamicLog.
  --
  -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

  -- Quit xmonad
  , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

  -- Restart xmonad
  , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
  ]
  ++

  --
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  --
  [((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  --
  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  --
  [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
  ++

  -- screen lock keybinding.
  [ ((modm .|. shiftMask, xK_l), spawn "slock")

  -- prompt keybindings.
  , ((modm, xK_p), spawn "dmenu_run")
  , ((modm, xK_o), nvimXPrompt conf)
  , ((controlMask .|. shiftMask, xK_o)
    , spawn . runScript "dmenu_vim_edit" $
            [ "--dirmode"
            , "--embed"
            , "--prompt", "\"open project :\""
            , myProjectsDir
            ])

  -- named scratchpads keybindings.
  , ((modm .|. controlMask, xK_Return), namedScratchpadAction myScratchpads "term")
  , ((modm .|. controlMask, xK_f),      namedScratchpadAction myScratchpads "fm")
  ]

-- Named Scratchpads.
myScratchpads = [ NS "term" spawnTerminal (resource =? "scratchpad-term") centerFloating
                , NS "fm" spawnFileManager (resource =? "scratchpad-fm") centerFloating
                ]
  where
    spawnTerminal     = unwords [myTerminalWithResource, "scratchpad-term"]
    spawnFileManager  = unwords [myTerminalWithResource, "scratchpad-fm", "-e", "ranger"]
    centerFloating    = customFloating $ W.RationalRect (1/10) (1/10) (4/5) (4/5)


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

magnify = renamed [Replace "magnify"]
        $ magnifier
        $ limitWindows 12
        $ ResizableTall 1 (3/100) (1/2) []

myLayout = avoidStruts $ tiled ||| noBorders Full ||| Mirror tiled ||| magnify
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

myManageHook = (composeAll . concat $
  [ [fmap (isInfixOf x) className --> doFloat | x <- myFloating]
  , [fmap (isInfixOf x) className --> doShift (myWorkspaces !! 2) | x <- myBrowsers]
  , [fmap (isInfixOf x) className <&&> resource =? "Dialog" --> doFloat | x <- myBrowsers]
  ]) <+> namedScratchpadManageHook myScratchpads
    where
      myBrowsers = ["Brave-browser", "Firefox"]
      myFloating = ["MPlayer", "Gimp"]

------------------------------------------------------------------------
-- Event handling

myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging


myLogHook proc = dynamicLogWithPP
  def
    { ppCurrent           = xmobarColor (white defColors) (highlight defColors)
                          . wrap ("<box type=Bottom width=2 color=" ++ (cyan defColors) ++ ">") "</box>"
    , ppHidden            = xmobarColor (white defColors) ""
    , ppHiddenNoWindows   = xmobarColor "#353535" ""
    , ppVisibleNoWindows  = Just (xmobarColor "red" "")
    , ppUrgent            = xmobarColor (red defColors) ""
    , ppTitle             = xmobarColor (green defColors) "" . shorten 30
    , ppSep               = "<fc=" ++ (white defColors) ++ "> | </fc>"
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



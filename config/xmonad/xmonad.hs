    -- Base
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
    -- Actions
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextWS, prevWS)
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown, rotAllUp)
    -- Hooks
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.WorkspaceHistory
    -- Layouts / Layout modifiers
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.WindowNavigation
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.CustomFullscreen (fullscreenManageHook, fullscreenSupport)
    -- Utilities
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP, additionalMouseBindings)

myModMask     = mod4Mask    -- Sets modkey to super/windows key
myBorderWidth = 4           -- Sets border width for windows
myNormColor   = "#282c34"   -- Border color of normal windows
myFocusColor  = "#88c0d0"   -- Border color of focused windows
myXBins       = "~/.local/bin/x/"
myStartupHook = do setWMName "LG3D"
mySpacing i   = spacingRaw False (Border i i i i) True (Border i i i i) True
tall     = renamed [Replace "tall"]
           $ windowNavigation
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"] $ windowNavigation Full
myLayoutHook = avoidStruts $ mouseResize $ windowArrange
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
                 where myDefaultLayout = tall ||| noBorders monocle
myWorkspaces = ["\63180", "\62057", "\63545", "\62513", "\61805", "\61910"]
myManageHook = fullscreenManageHook <+> manageDocks <+> composeAll
               [ className =? "mpv"     --> doFloat
               , className =? "fmenu"   --> doFloat
               , className =? "htop"    --> doFloat
               , className =? "Emacs"   --> doShift ( myWorkspaces !! 0 )
               , className =? "Gimp"    --> doShift ( myWorkspaces !! 5 )
               , className =? "Gimp"    --> doFloat
               , isFullscreen --> doFullFloat
               ]
myLogHook = fadeInactiveLogHook fadeAmount where fadeAmount = 1.0
myRemoveKeys = ["M-S-" ++ [n] | n <- ['1'..'9'] ++ ['a'..'z']]
               ++ ["M-" ++ [n] | n <- ['a'..'z'] ++ ['1'..'9'] ++ [',', '.']]
               ++ ["M-<Tab>","M-<Space>","M-<Return>"]
myKeys = [ ("M-p", spawn (myXBins ++ "emacs-x up"))
         , ("M-n", spawn (myXBins ++ "emacs-x down"))
         , ("M-s", spawn ("bravectl start"))
         , ("M-q", spawn (myXBins ++ "emacs-x close"))
         , ("M-t", spawn ("alacritty"))
         , ("M-<Tab>", sendMessage NextLayout)        -- Cycle layout
         , ("M-<Left>", prevWS)                       -- Previous workspace
         , ("M-<Right>", nextWS)                      -- next workspace
         , ("M-<Down>", windows W.swapDown)           -- Swap focused window with next window
         , ("M-<Up>", windows W.swapUp)               -- Swap focused window with prev window
         , ("M3-<Left>", sendMessage Shrink)          -- Shrink horiz window width
         , ("M3-<Right>", sendMessage Expand)         -- Expand horiz window width
         , ("M3-<Down>", sendMessage MirrorShrink)    -- Shrink vert window width
         , ("M3-<Up>", sendMessage MirrorExpand)      -- Exoand vert window width
         , ("M3-<Backspace>", rotAllDown)             -- Rotate all the windows in the current stack
         , ("M3-<Space>", promote)                    -- Focused window become master, others maintain order
         , ("M3-f", windows W.focusMaster)            -- Focus master window
         , ("M3-h", spawn ("floatwin -t -d 1920x2160+0+0 htop"))
         , ("M3-i", spawn ("bravectl inco"))
         , ("M3-m", spawn ("floatwin -t -d 1500x600+10+60 ncmpcpp"))
         , ("M3-n", spawn ("nautilus"))
         , ("M3-o", spawn ("floatwin -t -d 1920x1080+1900+1060 -n 1 fmenu 1"))
         , ("M3-s", spawn ("flameshot full -p ~/Pictures/screenshots"))
         , ("M3-t", withFocused toggleFloat)  -- Toggle window floating/tiling
         , ("M3-v", spawn ("murl toggle"))
         , ("M3-u", spawn ("murl main"))
         , ("<Insert>", spawn ("rofi -show run -theme ~/.config/rofi/themes/dmenu.rasi"))
         , ("<Delete>", spawn (myXBins ++ "powermenu"))
         , ("<F7>", spawn ("playerctl -p mpd previous"))
         , ("<F8>", spawn ("playerctl -p mpd play-pause"))
         , ("<F9>", spawn ("playerctl -p mpd next"))
         , ("<F10>", spawn (myXBins ++ "eww_vol mute"))
         , ("<F11>", spawn (myXBins ++ "eww_vol down"))
         , ("<F12>", spawn (myXBins ++ "eww_vol up"))
         , ("M3-p", spawn ("xvkbd -xsendevent -text '\\[Up]'"))
         , ("M3-n", spawn ("xvkbd -xsendevent -text '\\[Down]'"))
         , ("M-<F6>", spawn (myXBins ++ "smartpaste"))
         , ("M-<F10>", spawn ("xvkbd -xsendevent -text '\\[F10]'"))
         , ("M-<F11>", spawn ("xvkbd -xsendevent -text '\\[F11]'"))
         , ("M-<F12>", spawn ("xvkbd -xsendevent -text '\\[F12]'"))
        ] ++
        [ (otherModMasks ++ [key], action tag) | (tag, key)  <- zip myWorkspaces "123456"
          , (otherModMasks, action) <- [ ("M-", windows . W.view) , ("M3-", windows . W.shift) ]
        ] where toggleFloat w = windows (\s -> if M.member w (W.floating s)
                                then W.sink w s
                                else (W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s))
myMouseBindings = [ ((mod4Mask, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
                  , ((mod4Mask, button2), (\w -> focus w >> windows W.shiftMaster))
                  , ((mod4Mask, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
                  , ((0, 8), (\_ -> spawn ("xvkbd -xsendevent -text '\\Ax'")))
                  , ((0, 9), (\_ -> spawn ("xvkbd -xsendevent -text '\\Aa'")))
                  ]

main = do
      spawnPipe "polybar bar &"
      xmonad $ fullscreenSupport $ docks $ ewmh def {
      manageHook         = (isFullscreen --> doFullFloat) <+> myManageHook <+> manageDocks
    , handleEventHook    = serverModeEventHookCmd
                           <+> ewmhDesktopsEventHook
                           <+> serverModeEventHook
                           <+> docksEventHook
                           <+> swallowEventHook (className =? "Alacritty" <||> className =? "fmenu") (return True)
    , modMask            = myModMask
    , startupHook        = myStartupHook
    , layoutHook         = myLayoutHook
    , workspaces         = myWorkspaces
    , terminal           = "alacritty"
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormColor
    , focusedBorderColor = myFocusColor
    , logHook            = workspaceHistoryHook <+> myLogHook
    } `removeKeysP` myRemoveKeys `additionalKeysP` myKeys `additionalMouseBindings` myMouseBindings

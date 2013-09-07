import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import System.IO
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Hooks.FadeInactive
import XMonad.Layout.Spacing
import XMonad.Actions.GridSelect
import XMonad.Layout.Tabbed
import XMonad.Actions.FloatKeys
import XMonad.Hooks.ServerMode

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
	where fadeAmount = 0.9

myManageHook = composeAll
	[ className =? "Gimp"   --> doFloat
        ]
myLayoutHook = tiled ||| Mirror tiled ||| simpleTabbedBottomAlways ||| Full
	where
           tiled = spacing 2 $  Tall nmaster delta ratio
	   nmaster = 1
	   ratio = 1/2
	   delta = 10/100
myGridColorizer = orangeNavyColorizer;

gsconfig2 colorizer = (buildDefaultGSConfig myGridColorizer) { gs_cellheight = 50, gs_cellwidth = 160 }
--colorizers

orangeNavyColorizer = colorRangeFromClassName
	blue
	(0x00, 0x10, 0x55)
        white
	white
	blue
   where blue = minBound
         white = maxBound

main =  xmonad =<< xmobar myConfig 

myConfig = defaultConfig
          { terminal = "terminator"
          , manageHook = myManageHook <+> manageHook defaultConfig <+> manageDocks
          , layoutHook = myLayoutHook
          , logHook = myLogHook
          , modMask = mod4Mask --Mod key is windows key
	  , borderWidth = 0
          , focusedBorderColor = "#FAFAFA"
          , normalBorderColor = "#453632"
           } `additionalKeys`
           [  ((mod4Mask, xK_g), goToSelected $ gsconfig2 orangeNavyColorizer)
           --  ,((mod4Mask, xK_o), spawnSelected  gsconfig2 $ orangeNavyColorizer ["urxvt -e ncmpcpp", "chromium", "gimp", "firefox"])
             ,((mod4Mask,               xK_d), withFocused (keysResizeWindow (0,-10)(1,1)))
             ,((mod4Mask .|. shiftMask, xK_d), withFocused (keysResizeWindow (0, 10)(0,0)))
             ,((mod4Mask              , xK_s), withFocused (keysResizeWindow ( 10,0)(1,1)))
             ,((mod4Mask .|. shiftMask, xK_s), withFocused (keysResizeWindow (-10,0)(1,1)))
			 ,((mod4Mask              , xK_r), spawn "xdotool click  --clearmodifiers 3")
			 ,((mod4Mask .|. shiftMask, xK_r), spawn "xdotool click --repeat 2 --clearmodifiers 3")
			 ,((mod4Mask              , xK_f), spawn "scrot")
           ]


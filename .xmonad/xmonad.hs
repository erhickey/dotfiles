import XMonad
  ( Full(Full), Tall(Tall), borderWidth, className, composeAll, def, doFloat, focusFollowsMouse
  , layoutHook , manageHook, spawn , startupHook, terminal, workspaces, xmonad, (-->), (=?), (|||), (<+>)
  )
import XMonad.Hooks.InsertPosition (Focus(Newer), Position(Below), insertPosition)
import XMonad.Hooks.ManageHelpers (isDialog)
import XMonad.Layout.Spacing (spacingWithEdge)
import XMonad.Util.Cursor (setDefaultCursor, xC_left_ptr)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Ungrab (unGrab)

myWorkspaces = ["1", "2", "3"]

myLayout = spacingWithEdge 6 $
  tiled ||| Full
  where
    tiled = Tall mpNum ratioIncrement ratio
    -- number of windows in master pane
    mpNum = 1
    -- proportion of screen occupied by master pane
    ratio = 1 / 2
    -- percent of screen to increment by when resizing panes
    ratioIncrement = 3 / 100

myManageHook = insertPosition Below Newer <+> composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog --> doFloat
    ]

myStartupHook = setDefaultCursor xC_left_ptr

myConfig = def
    { terminal = "st"
    , borderWidth = 0
    , focusFollowsMouse = False
    , manageHook = myManageHook
    , workspaces = myWorkspaces
    , layoutHook = myLayout
    , startupHook = myStartupHook
    }
    `additionalKeysP`
    [ ("M-b", spawn "qutebrowser")
    , ("M-s", unGrab *> spawn "maim -slDc 0.8,0.8,0.2,0.5 ~/tmp/$(date +%Y_%m_%d__%H_%M_%S_maim).png")
    , ("M-S-s", unGrab *> spawn "maim -slDc 0.8,0.8,0.2,0.5 | xclip -selection clipboard -t image/png")
    ]

main = xmonad myConfig

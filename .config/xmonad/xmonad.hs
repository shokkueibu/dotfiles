    -- Base
import XMonad
import XMonad.Config.Desktop
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Utilities
import XMonad.Util.EZConfig
import XMonad.Util.Run (safeSpawn, unsafeSpawn, runInTerm, spawnPipe)
import XMonad.Util.SpawnOnce

    -- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks -- dock/tray mgmt  
import XMonad.Hooks.ManageHelpers

    -- Actions
import XMonad.Actions.SpawnOn
import qualified Data.Map as M

    -- Layout modifiers
import XMonad.Layout.PerWorkspace (onWorkspace) 
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.Spacing (spacing) 
import XMonad.Layout.NoBorders
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.Reflect (reflectVert, reflectHoriz, REFLECTX(..), REFLECTY(..))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))


    -- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.OneBig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.ZoomRow (zoomRow, zoomIn, zoomOut, zoomReset, ZoomMessage(ZoomFullToggle))
import XMonad.Layout.IM (withIM, Property(Role))


myModMask   = mod4Mask  -- Super key
myTerminal  = "kitty"
myEditor    = "nvim"

main = do
    xmonad $ ewmh   desktopConfig
        { modMask          = myModMask
        , terminal         = myTerminal
        , borderWidth        = 1
        , normalBorderColor  = "#a4a6ab"
        , focusedBorderColor = "#9b8a4b"
        , manageHook = myManageHook
        , layoutHook = desktopLayoutModifiers $ myLayoutHook ||| layoutHook desktopConfig
        , logHook = logHook desktopConfig
        , handleEventHook = handleEventHook desktopConfig 
        , startupHook = startupHook desktopConfig
        }
        `additionalKeysP`    myKeys


-- KEYS
myKeys =
    [ 
      ("M-r", spawn "rofi -show drun")
    , ("M-a", sendMessage NextLayout >> (curLayout >>= \d->spawn $"notify-send "++d))
    ]

-- RULES
myManageHook = composeAll
    [
      manageDocks
    , isFullscreen --> doFullFloat
    , isDialog --> doFloat
    , manageHook defaultConfig
    -- , className =? "plasma" --> doFloat
    -- , className =? "Plasma" --> doFloat
    , className =? "plasmashell" --> doIgnore
    , className =? "krunner" --> doFloat
    , title =? "Desktop" --> doIgnore
    ]


-- LAYOUTS
myLayoutHook = tall ||| grid ||| threeCol ||| threeRow ||| oneBig ||| noBorders monocle ||| space ||| floats 

tall       = renamed [Replace "tall"]     $ limitWindows 12 $ spacing 6 $ ResizableTall 1 (3/100) (1/2) []
grid       = renamed [Replace "grid"]     $ limitWindows 12 $ spacing 6 $ mkToggle (single MIRROR) $ Grid (16/10)
threeCol   = renamed [Replace "threeCol"] $ limitWindows 3  $ ThreeCol 1 (3/100) (1/2) 
threeRow   = renamed [Replace "threeRow"] $ limitWindows 3  $ Mirror $ mkToggle (single MIRROR) zoomRow
oneBig     = renamed [Replace "oneBig"]   $ limitWindows 6  $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (5/9) (8/12)
monocle    = renamed [Replace "monocle"]  $ limitWindows 20 $ Full
space      = renamed [Replace "space"]    $ limitWindows 4  $ spacing 4 $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (2/3) (2/3)
floats     = renamed [Replace "floats"]   $ limitWindows 20 $ simplestFloat


curLayout :: X String
curLayout = gets windowset >>= return . description . W.layout . W.workspace . W.current

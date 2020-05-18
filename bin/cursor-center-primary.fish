#!/usr/bin/env fish
# Dependencies: xdotool, xrandr, rg

# Gets the dimensions and offset of the primary monitor into $data array (width, height, offsetx, offsety)
set data (xrandr | rg -e " connected primary" | sed -rn "s/.* connected primary ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+).*/\1\n\2\n\3\n\4/p")

# Moves the mouse cursor to the center of the screen
xdotool mousemove (math "($data[1]+$data[3])/2") (math "($data[2]+$data[4])/2")

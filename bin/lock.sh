#!/usr/bin/env bash

settings="-mag 1 -boffset 2"
tmpbg="/tmp/screen.png"
scrot "$tmpbg"; corrupter -mag 2 -boffset 20 "$tmpbg" "$tmpbg"
i3lock -i "$tmpbg" -t; rm "$tmpbg"


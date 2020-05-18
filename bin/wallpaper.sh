#!/usr/bin/env bash

file=$(find /archive/pictures/wallpapers -type f | shuf -n 1)
feh --bg-fill "$file" &

#!/bin/sh

keyboard.sh
mxergo_remap.sh

picom --daemon
nitrogen --restore &

xbanish -b -s -t 5000 -i control -i shift -i mod1

keepassxc &


exit 0

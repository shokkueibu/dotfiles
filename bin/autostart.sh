#!/bin/sh

keyboard.sh
mxergo_remap.sh

picom --daemon
nitrogen --restore &

keepassxc &

exit 0

#!/bin/sh

#turn off left monitor
xrandr --output HDMI2 --off


# start VM
sudo virsh start win10-work
sleep 5


# turn monitors back on 
#xrandr --output HDMI1 --off
xrandr --output HDMI1 --auto --primary --output HDMI2 --left-of HDMI1 --auto

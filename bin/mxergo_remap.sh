#!/bin/sh

id=$(xinput list --id-only 'pointer:Logitech MX Ergo')

# Map middle mouse to back button; forward and back to wheel tilt
xinput set-button-map $id 1 2 3 4 5 8 9 2


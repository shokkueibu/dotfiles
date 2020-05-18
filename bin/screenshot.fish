#!/bin/env fish

maim --format png /dev/stdout | xclip -selection clipboard -t image/png -i

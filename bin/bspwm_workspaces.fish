#!/usr/bin/env fish

# Get array of active monitors
set -l monitors (/home/shock/bin/active_monitors)

# Number of desktops per monitor
set desktop_count 3

set c (count $monitors)
set desktops 0

for m in $monitors
    set desktops (seq (math "($desktops[-1]+1)") (math "$desktops[-1]+$desktop_count"))
    bspc monitor $m -d $desktops
end

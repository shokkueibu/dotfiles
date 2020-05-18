#!/bin/fish

# Terminate running instances
killall -q polybar

# Wait until the processes shut down
while pgrep -x polybar >/dev/null
    sleep 1
end

# Create array of active monitors
set -l monitors (xrandr --listactivemonitors | tail -n +2 | awk '{print $4}')
set -l mon_status (xrandr --listactivemonitors | tail -n +2 | awk '{print $2 ~ "*"}')



# Launch bars based on active monitors
for i in (seq (count $monitors))
    set --export POLYBAR_MON $monitors[$i]

    if test $mon_status[$i] -eq 1
        set bar primary
    else
        set bar secondary
    end

    polybar $bar &
    disown
end



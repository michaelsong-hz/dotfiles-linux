#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=DP-2 polybar main &
MONITOR=HDMI-0 polybar main &

echo "Bars launched..."

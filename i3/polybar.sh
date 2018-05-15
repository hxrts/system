#!/usr/bin/env sh

# Terminate already running bar instances
pkill -x polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar --config=/home/hxrts/.config/i3/polybar.conf bottom &

#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

MONITOR=DVI-D-0 polybar main &

# for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1); do
# 	MONITOR=${monitor} polybar --reload main&
# 	echo ${monitor}
# done


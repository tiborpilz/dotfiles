#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

if [ "$HOSTNAME" = workyMcWorkstation ]; then
    #MONITOR=DVI-D-0 polybar secondary &
    MONITOR=HDMI-0 polybar top &
else
	MONITOR=LVDS-1 polybar main &
fi

# for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1); do
# 	MONITOR=${monitor} polybar --reload main&
# 	echo ${monitor}
# done


#!/bin/bash
xmodmap ~/.Xmodmap
exec bspwm
# Set up the keyboard
# xmodmap ~/.Xmodmap

# Set up environment variables
# env DISPLAY_PRIMARY=$(xrandr | grep "primary" | awk '{$1}')
# env DISPLAY_SECONDARY=$(xrandr | grep " connected" | grep --invert-match "primary")
# env TERMINAL=$(which alacritty)
# env EDITOR=$(which vim)

# set bell-style none

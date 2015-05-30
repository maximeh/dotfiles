#!/bin/sh

# Small fix to make the backlight work on MacBook 11,3
# Put that into /etc/rc.local
#setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0
# Keyboard ligthing
# echo 0 > /sys/devices/platform/applesmc.768/leds/smc::kbd_backlight/brightness
# Startup ligther.pl also in rc.local

# Start with no dead keys.
setxkbmap dvorak -variant "nodeadkeys"
setxkbmap -option compose:rwin
setxkbmap -option compose:lwin
setxkbmap -option compose:ralt
xset r rate 350 45

# Check if we are on external display or not
# If we have an external display, scale the display
if (xrandr | grep 'DP-4 connected'); then
        xrandr --output DP-2 --auto --output DP-4 --auto --scale 1.7x1.7 --right-of DP-2
fi
if (xrandr | grep 'DP-3 connected'); then
        xrandr --output DP-2 --auto --output DP-3 --auto --scale 1.7x1.7 --right-of DP-2
fi

xrdb -merge ~/.Xresources

xcalib -s DP-2 "$HOME/.dotfiles/Macbook Pro Retina.icc"
xss-lock -- i3lock -d -c ff0000 &
xautolock -time 10 -locker "i3lock -d -c ff0000" &

feh --randomize --bg-scale /home/maxime/Documents/wallpaper/*

#!/bin/sh

# Small fix to make the backlight work on MacBook 11,3
# Put that into /etc/rc.local
#setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0
# Keyboard ligthing
# echo 0 > /sys/devices/platform/applesmc.768/leds/smc::kbd_backlight/brightness

if [ -f /tmp/firstboot ]; then
        firstboot=1
else
        firstboot=0
        touch "/tmp/firstboot"
fi

if [ $firstboot -eq 0 ]; then
        xmodmap -e "remove lock = Caps_Lock"
        setxkbmap -option ctrl:nocaps

        # Start with no dead keys.
        setxkbmap dvorak -variant "nodeadkeys"
        setxkbmap -option compose:rwin
        setxkbmap -option compose:lwin
        setxkbmap -option compose:ralt
        xset r rate 175 35
fi

connected=0
if xrandr | grep 'DP-3 connected' && xrandr | grep 'DP-3 connected'; then
        connected=1
fi

if [ $connected -eq 0 ]; then
        xrandr --output DP-2 --auto
        xcalib -s DP-2 "$HOME/.dotfiles/Macbook Pro Retina.icc"
else
        screen=$(xrandr | grep -w connected | grep -v DP-2 | awk '{print $1}')
        xrandr --output "${screen}" --auto --right-of DP-2
fi

dpi=180
pixelsize=20
fontsize=6
dmenu_fontsize=24
if [ $connected -eq 1 ]; then
        dpi=96
        pixelsize=12
        fontsize=4
        dmenu_fontsize=12
        # Kill main screen
        xrandr --output DP-2 --off
fi
# Set the correct value
sed -i "s/^Xft.dpi.*/Xft.dpi: ${dpi}/g" ~/.Xresources
sed -i "s/^URxvt.font:.*/URxvt.font: xft:DejaVu Sans Mono:pixelsize=${pixelsize}:Regular/g" ~/.Xresources
xrdb -merge ~/.Xresources

# Change i3 config's size font
sed -i "s/^set \$fontsize.*/set \$fontsize ${fontsize}/g" ~/.i3/config
sed -i "s/^set \$dmenu_fontsize.*/set \$dmenu_fontsize ${dmenu_fontsize}/g" ~/.i3/config
i3-msg reload

if [ $firstboot -eq 0 ]; then
        xautolock -time 10 -locker "i3lock --ignore-empty-password -c 000000" &
        feh --randomize --bg-scale /home/maxime/Documents/wallpaper/*
fi

#!/bin/sh

# Put that into /etc/rc.local
# Force enable ASPM for Thunderbolt (PCIE)
# setpci -s 06:00.0 0xd0.B=0x43
# setpci -s 07:06.0 0xd0.B=0x43
# Small fix to make the backlight work on MacBook 11,3
# setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0
# Keyboard ligthing
# echo 0 > /sys/devices/platform/applesmc.768/leds/smc::kbd_backlight/brightness
# grep . -r /sys/firmware/acpi/interrupts
# echo disable > /sys/firmware/acpi/interrupts/gpe17

# Setup screens, kill the laptop screen if external screen is connected.
# Adjust DPI and other stuff.
screen_connected=0
if xrandr | grep 'DP-3 connected' || xrandr | grep 'DP-4 connected'; then
	screen_connected=1
fi

if [ $screen_connected -eq 0 ]; then
	xrandr --output DP-2 --auto &
	xcalib -s DP-2 "${HOME}/.dotfiles/Macbook Pro Retina.icc" &
else
	# Kill main screen
	xrandr --output DP-2 --off &

	screen=$(xrandr | grep -w connected | grep -v DP-2 | awk '{print $1}')
	xrandr --output "${screen}" \
		--rotate left \
		--auto \
		--panning 0x0+0+0/0x0+0+0/0/0/0/0 \
		--right-of DP-2 &
fi

dpi=220
pixelsize=20
fontsize=8
dmenu_fontsize=24
if [ $screen_connected -eq 1 ]; then
	dpi=96
	pixelsize=12
	fontsize=4
	dmenu_fontsize=12
fi

# Set the correct DPI value
sed -i "s/^Xft.dpi.*/Xft.dpi: ${dpi}/g" ~/.Xresources
sed -i "s/^URxvt.font:.*/URxvt.font: xft:DejaVu Sans Mono:pixelsize=${pixelsize}:Regular/g" ~/.Xresources
xrdb -merge ~/.Xresources &

# Change i3 config's size font
sed -i "s/^set \$fontsize.*/set \$fontsize ${fontsize}/g" ~/.i3/config
sed -i "s/^set \$dmenu_fontsize.*/set \$dmenu_fontsize ${dmenu_fontsize}/g" ~/.i3/config
i3-msg restart &

# Setup keyboard
xmodmap -e "remove lock = Caps_Lock"
setxkbmap -option ctrl:nocaps

# Start with no dead keys.
setxkbmap dvorak -variant "nodeadkeys"
setxkbmap -option compose:rwin
setxkbmap -option compose:lwin
setxkbmap -option compose:ralt
xset r rate 175 35

FEH_ARGS="--randomize"
if [ $screen_connected -eq 0 ]; then
	FEH_ARGS="${FEH_ARGS} --bg-scale"
else
	FEH_ARGS="${FEH_ARGS} --bg-max"
fi
eval feh "${FEH_ARGS}" /home/maxime/Documents/perso/wallpaper/ &

wait

#!/bin/sh

# Start with no dead keys.
setxkbmap -variant "nodeadkeys"
setxkbmap -option compose:rwin
setxkbmap -option compose:lwin
xset r rate 250

xrdb -merge ~/.Xresources
feh --randomize --bg-fill /home/maxime/Documents/wallpaper/*
acpi_listen -t 2 &
i3

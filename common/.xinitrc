#!/bin/sh

PATH=$PATH:$HOME/.bin:$HOME/.$(uname -n)_bin:/usr/sbin:/sbin

multihead &

sudo $HOME/.bin/powertop_tuned &

sudo $HOME/.bin/mbp_thunderbolt &

# Wait for multihead to create this file before starting wallpapers
while [ ! -f /tmp/screen ]; do
	sleep 0.1
done

keyboard &

wallpapers &

wait

/usr/bin/unclutter -idle 1 -root &
/usr/bin/xautolock \
	-corners ---- -cornersize 30 \
	-locker "slock" &

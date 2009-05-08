#!/bin/sh
ck-launch-session &
~/bin/load_abnt2_keymap &
~/.fehbg &
conky -c ~/.conky/clock &
conky -c ~/.conky/weather &
conky -c ~/.conky/sys &
conky -c ~/.conky/disk &
conky -c ~/.conky/mpd &
thunar --daemon &
pypanel &
parcellite &
nm-applet &
exit 0

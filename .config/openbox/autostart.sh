#!/bin/sh
/home/seed/bin/load_abnt2_keymap &
/home/seed/.fehbg &
conky -c /home/seed/.conky/clock &
conky -c /home/seed/.conky/weather &
conky -c /home/seed/.conky/sys &
conky -c /home/seed/.conky/disk &
conky -c /home/seed/.conky/mpd &
thunar --daemon &
(tint2 &
sleep 1s
parcellite &
wicd-client) &

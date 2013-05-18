#!/bin/bash

SESSION=i3

source /etc/X11/xinit/xinitrc.d/*
/usr/bin/start-pulseaudio-x11
eval $(/usr/bin/gnome-keyring-daemon -s -d -c pkcs11,secrets,ssh,gpg| sed 's/^/export /g')
xrdb -load ~/.Xresources

export HOSTD_PATH="${DOTFILES_DIR}/host.d/$(hostname)"

for f in "${HOSTD_PATH}"/*.sh; do
    test -f "$f" && . "$f"
done
test -f "${HOSTD_PATH}/Xresources" && xrdb -merge "${HOSTD_PATH}/Xresources"
test -f "${HOSTD_PATH}/Xmodmap" && xmodmap "${HOSTD_PATH}/Xmodmap"

exec $SESSION

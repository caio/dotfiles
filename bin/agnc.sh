#!/bin/bash

set -e

logd=/etc/rc.d/agnLogd
clientd=/etc/rc.d/agnclientd

do_rcexec() {
    sudo ${logd} ${1}
    sudo ${clientd} ${1}
}

if pgrep -f agnclient 2>&1 >/dev/null; then
    do_rcexec "stop"
else
    do_rcexec "start"
fi

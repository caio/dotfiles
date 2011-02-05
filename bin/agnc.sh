#!/bin/bash

set -e

logd=/etc/rc.d/agnLogd
clientd=/etc/rc.d/agnclientd

do_rcexec() {
    sudo ${logd} ${1}
    sudo ${clientd} ${1}
}

pgrep -f agnclient 2>&1 >/dev/null && do_rcexec "stop" || do_rcexec "start"

#!/bin/bash

USERID="rcaio@br.ibm.com"
SERVER="rcxasa.watson.ibm.com"

start() {
    echo ">>> Starting openconnect..."
    sudo openconnect -u $USERID --background --syslog \
        --script=/etc/vpnc/vpnc-script $SERVER
}

stop() {
    echo ">>> Stopping openconnect..."
    sudo pkill openconnect
}

if pgrep openconnect >/dev/null; then
    stop
else
    start
fi

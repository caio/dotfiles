#!/bin/bash

__services() {
    local cur
    local IFS=$'\n'
    cur=${COMP_WORDS[COMP_CWORD]};

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $(compgen -W "$(find /etc/rc.d -type f -printf '%P\n')" -- ${cur}) )
    elif [ $COMP_CWORD -eq 2 ]; then
        COMPREPLY=( $(compgen -W "$(echo -e 'start\nstatus\nstop\nrestart')" -- ${cur}) )
    else
        COMPREPLY=()
    fi
}

service() {
    [ ${#} -ne 2 ] && return 1;
    sudo /etc/rc.d/$1 $2
}

complete -F __services service

#!/bin/bash
# http://sixohthree.com/867/bash-completion

jk() { cd ~/src/$1; }
__proj() {
    local cur len wrkdir
    wrkdir=$(readlink -f ~/src)
    cur=${COMP_WORDS[COMP_CWORD]}
    len=$((${#wrkdir} + 2))
    COMPREPLY=( $(compgen -S/ -d $wrkdir/$cur| cut -b $len-) )
}
complete -o nospace -F __proj jk


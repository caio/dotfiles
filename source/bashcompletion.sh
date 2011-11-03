#!/bin/bash

__load_bashcompletion() {
    local bashcomp="/etc/bash_completion"
    test ! -r ${bashcomp} && return 0
    . ${bashcomp}
}

__load_bashcompletion

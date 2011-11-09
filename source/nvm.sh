#!/bin/bash

__load_nvm() {
    local nvmdir="${HOME}/.nvm"
    test ! -d ${nvmdir} && return 0
    . ${nvmdir}/nvm.sh
}

__load_nvm

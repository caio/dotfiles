#!/bin/bash

__load_rvm() {
    local rvm_path="${HOME}/.rvm"
    test ! -d ${rvm_path} && return 0
    . ${rvm_path}/scripts/rvm
    . ${rvm_path}/scripts/completion
}

__load_rvm

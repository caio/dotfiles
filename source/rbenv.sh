#!/bin/bash

__load_rbenv() {
    test -d ~/.rbenv || return 0
    pathprepend ~/.rbenv/bin
    eval "$(rbenv init -)"
}

__load_rbenv

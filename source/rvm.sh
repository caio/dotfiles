#!/bin/bash

__load_rvm() {
    test ! -d ~/.rvm && return 0
    . ~/.rvm/scripts/rvm
}

__load_rvm

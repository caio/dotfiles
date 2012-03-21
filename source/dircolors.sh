#!/bin/bash

dirfile=${HOME}/.dircolors
test -f ${dirfile} && eval $(dircolors $dirfile) || true

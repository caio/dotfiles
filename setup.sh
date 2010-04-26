#!/bin/bash
# Dirty symlink setup for common dotfiles
# This won't remove anything, instead, it'll print the name
# of the existing file so you can script your way to remove it.
# Example:
# >>> ./setup.sh | awk '{ print $1 }'| xargs rm -rf; ./setup.sh
# >>> # This will remove every conflicting file and start again.

WORKDIR=$(pwd)
DESTDIR=${HOME}

BASHFILES="bashrc source"
VCSFILES="gitconfig hgrc bazaar"
BASEFILES="Xdefaults fonts pythonrc.py ipython irbrc screenrc"

function setup_symlinks
{
    for file in $*
    do
        dest="${DESTDIR}/.$file"
        [ -e $dest ] &&
        echo "$dest exists. " &&
        continue
        ln -fs ${WORKDIR}/$file $dest
    done
}

setup_symlinks $BASHFILES
setup_symlinks mplayer
setup_symlinks $VCSFILES
setup_symlinks $BASEFILES

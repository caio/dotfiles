#!/bin/bash
# Syncs current repo files with home dir
# This is too damn dirty, I know

############
# WARNING! #
############

# This WILL overwrite every existing file

RM=/bin/rm
CP=/bin/cp

# Removing files
${RM} -rf ~/.vim* ~/.bashrc ~/.hgrc ~/.mplayer ~/.source ~/.Xdefaults ~/.pythonrc.py ~/.gitconfig ~/.screenrc

# Copying new ones
${CP} -R .vim* .bashrc .mplayer .source .Xdefaults .pythonrc.py .gitconfig .screenrc ~
${CP} hgrc ~/.hgrc


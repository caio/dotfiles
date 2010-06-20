# Custom commands to be sourced on unicamp shells
# @author Caio Romão <caioromao@gmail.com>

[[ "$(whoami)" != "ra059467" ]] && return 0

# Unicamp network is NOT secure
umask 0077

# Setting up local python libs
# This is needed by a Mercurial home install
if [[ -d ${HOME}/lib/python ]]
then
    export PYTHONPATH=${HOME}/lib/python
fi

# GPSL config script
if [ -e ${HOME}/.config_area.sh ]
then
    . ${HOME}/.config_area.sh
fi

# Create a tmp directory
DIRECTORY=/tmp/home-ra059467
mkdir -p $DIRECTORY

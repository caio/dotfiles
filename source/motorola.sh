# Custom commands to be sourced on motorola shells
# @author Caio Romão <caioromao@gmail.com>

[[ "$(whoami)" != "wxmp34" ]] && return 0

HOSTNAME=$(hostname)

# Setting up proxy
http_proxy="wxmp34@wwwgate0.mot.com:1080"
ftp_proxy="wxmp34@wwwgate0.mot.com:1080"
export http_proxy ftp_proxy

# Path env as pre-configured
PATH=/usr/bin:/usr/ucb:/etc:.
export PATH=${PATH}:/bin:/usr/atria/bin:/usr/local/bin:/usr/openwin/bin:/usr/X11R6/bin:/usr/local2/bin:/usr/local_linux/cpptest7/eclipse:/usr/local_linux/cpptest/insure/bin.linux2/:/home/sw/wxmp34/bin:/vobs/local_tools/unix_tools/
export MANPATH=${MANPATH}:/usr/atria/doc/man
export CLEARCASE_BLD_UMASK=2

# Fixing aliases on Unix machines
if [[ "$HOSTNAME" = "${HOSTNAME/linux/FIXIT}" ]]
then
    unalias ls
    unalias l
    unalias la
    unalias a
    unalias ad
    alias ls='ls -F'
    alias a='ls -A'
    alias l='ls -lh'
    alias la='ls -lAh'
fi

# Setting DISPLAY to interface with XMing server
if [[ "$HOSTNAME" != "${HOSTNAME/linux/FIXIT}" ]]
then
    REMOTEIP="$(who am i| grep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"
    if [[ "$REMOTEIP" != "" ]]
    then
        export DISPLAY="$REMOTEIP:0.0"
    fi
fi

# Clearcase aliases
alias ct='cleartool'
alias ci='ct checkin'
alias co='ct checkout -nc'
alias unco='ct unco'
alias pwv='ct pwv'
alias sv='ct setview -exec bash'
alias lsco='ct lsco -all -cview -me'
alias vedcs='WINEDITOR=vim ct edcs'
alias edcs='WINEDITOR=gvim ct edcs'
alias gedcs='WINEDITOR=gedit ct edcs'
alias nedcs='WINEDITOR=nedit ct edcs'
# For C++Test
alias ec='eclipse -vm /usr/local_linux/java/jdk1.6.0/bin/java -vmargs -Xms512m -Xmx2000m &'
alias e='kwrite'
alias ctdiff='ct diff -g -pre'
alias v='ct lsview | grep wxmp34'
# For MSGG P2K
alias msgg='cd /vobs/synergy_core_apps/code/msgg/src/'

# Finds files that need to be merged given a label
function findmerge()
{
    if [[ "${#}" = "2" ]]
    then
        ct findmerge $1 -fver $2 -print
    elif [[ "${#}" = "1" ]]
    then
        ct findmerge . -fver $1 -print
    else
        echo "usage: findmerge [PATH] Label"
    fi
}

# Do a three-way merge of a given file to a given label
function domerge()
{
    if [[ "${#}" == "2" ]]
    then
        ct findmerge $1 -fver $2 -merge -gmerge -nc
    else
        echo "usage domerge <FILE> Label"
    fi
}

# searches for a definition
function dgrep()
{
    if [ -z $2 ]
    then
        grep -R "${1}*;" * 2>/dev/null
    else
        grep -R "${1}*;" ${2}/* 2>/dev/null
    fi
}

# searches for a word
function wgrep()
{
    if [ -z $2 ]
    then
        grep -R "\<${1}\>" * 2>/dev/null
    else
        grep -R "\<${1}\>" ${2}/* 2>/dev/null
    fi
}

# Easy BR script
alias ezbr=/vobs/linuxjava/common_tools/bin/ezbr
#element * EZBR_N_00.00.XXR_LATEST
# uncomment to run EzBR only if tool returns library error
#element * TOOLS_N_00.00.XXR_ATOOLS

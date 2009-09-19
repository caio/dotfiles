# plain .bashrc - should work on any Linux environment
# assembled by: Caio Romão <caioromao@gmail.com>

pathremove () {
    local IFS=':'
    local NEWPATH
    local DIR
    local PATHVARIABLE=${2:-PATH}
    for DIR in ${!PATHVARIABLE} ; do
        if [ "$DIR" != "$1" ] ; then
            NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
        fi
    done
    export $PATHVARIABLE="$NEWPATH"
}

pathprepend () {
    pathremove $1 $2
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend () {
    pathremove $1 $2
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}

alias pwdappend='pathappend $(pwd)'

# disabling flow control
stty -ixon -ixoff

# setting up custom bin-dir
[ -d ${HOME}/bin ] && pathprepend ${HOME}/bin

# google appengine
[ -d /opt/google-appengine ] && pathappend /opt/google-appengine

# Git custom PS1 command
[ -f ~/.source/gitrc ] && . ~/.source/gitrc && GITRC_OK="True"

# Bash completion
[ -e /etc/bash_completion ] && . /etc/bash_completion

# EXPORTS
export GWT_EXTERNAL_BROWSER="firefox"
export EDITOR="vim"
export PYTHONSTARTUP="$HOME/.pythonrc.py"

# PROMPT
# credits to B-Con from ArchLinux forums for this :)
bash_prompt_cmd() {
    local RETVAL=$?
    local CY="\[\e[0;37m\]" # Each is 12 chars long
    local BL="\[\e[1;34m\]"
    local WH="\[\e[1;37m\]"
    local BR="\[\e[0;33m\]"
    local OR="\[\e[1;33m\]"
    local RE="\[\e[1;31m\]"
    local OT="\[\e[1;35m\]"

    local ps_len=0
    local RET=""
    if [ $RETVAL -ne 0 ]; then
        CNT=${#RETVAL}
        ps_len=$((ps_len + CNT + 2))
        RET="${RE}${RETVAL}! "
    fi

    local LPROM="${CY}$"
    [ $UID -eq "0" ] && LPROM="${RE}#"
    ps_len=$((ps_len + 1))

    local VENVSTATUS=""
    if [ ${#envname} -gt 0 ]
    then
        VENVSTATUS="${OR}·${envname} "
        ps_len=$((ps_len + ${#envname} - 12 - 1))
    fi

    local SCMSTATUS=""
    [ `which hg_ps1.py 2>/dev/null` ] && SCMSTATUS="$(hg_ps1.py)"
    [ -n "$GITRC_OK" ] && SCMSTATUS="$(parse_git_branch)"
    [ ${#SCMSTATUS} -gt 12 ] && ps_len=$((ps_len + ${#SCMSTATUS} - 12))

    local PROMPT="${RET}${VENVSTATUS}${SCMSTATUS}${LPROM}"
    local PROMPT_PWD=""
    local PS1_T1=" $CY"
    local PS1_T2="$BL${PROMPT} \[\e[0m\]"
    ps_len=$((ps_len + 2))
    local startpos=""

    PROMPT_PWD="${PWD/#$HOME/~}"
    local overflow_prefix="..."
    local pwdlen=${#PROMPT_PWD}
    local maxpwdlen=$(( COLUMNS - ps_len ))
    # Sometimes COLUMNS isn't initiliased, if it isn't, fall back on 80
    [ $maxpwdlen -lt 0 ] && maxpwdlen=$(( 80 - ps_len ))

    if [ $pwdlen -gt $maxpwdlen ] ; then
        startpos=$(( $pwdlen - maxpwdlen + ${#overflow_prefix} ))
        PROMPT_PWD="${overflow_prefix}${PROMPT_PWD:$startpos:$maxpwdlen}"
    fi

    export PS1="${BL}${PROMPT_PWD}${PS1_T1}${PS1_T2}"
}
PROMPT_COMMAND=bash_prompt_cmd


###########
# Aliases #
###########

alias c='clear'
alias mv='mv -i'
alias cp=' cp -i'
alias rm='rm -i'
alias j='jobs'
alias h='history'
alias grep='egrep'
alias ls='ls --color=always --time-style=iso -h -F --quoting-style=escape'
alias l='ls -lh'
alias la='ls -lhA'
alias ad='ls -A -d */'
alias a='ls -d .*'
alias dc=popd
alias d='dirs -v'

# This makes pushd behave like cd when no argument is passed
function cdpushd()
{
    if [ -n "$1" ]
    then
        [[ $1 != "." ]] && pushd "$*"
    else
        [ "$(pwd)" != "$HOME" ] && pushd ~
    fi
}

alias cd=cdpushd
alias cdd='cd -'
alias cpptags='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'


###########
# History #
###########

export HISTSIZE=4000
export HISTFILESIZE=4000
export HISTIGNORE="ls:l:c:clear:d:cd:dc:bg:fg"
export HISTCONTROL=erasedups
export HISTTIMEFORMAT='%m%d %H%M: '


#############
# Mercurial #
#############

# Opens vim in diff mode comparing the current version with
# the one versioned
function hgdiff()
{
    hg cat $1 | gvim - -c  ":vert diffsplit $1" -c "map q :qa!<CR>";
}

##########################################################################
# Add sources bellow this comment to avoid replacing of the new commands #
##########################################################################

# Virtualenv wrapper
WORKON_HOME=${HOME}/.virtualenvs
if [ -f ~/.source/virtualenvwrapper_bashrc ] && [ -d $WORKON_HOME ]
then
    export WORKON_HOME
    . ~/.source/virtualenvwrapper_bashrc
fi

# KDE's development script
[ -f ~/.source/kdedevrc ] && [ -d ~/src/kde ] && . ~/.source/kdedevrc

# load Motorola config file
if [[ "$(whoami)" = "wxmp34" ]] && [[ -f ~/.source/motorolarc ]]
then
    . ~/.source/motorolarc
fi

# load Unicamp config file
if [[ "$(whoami)" = "ra059467" ]] && [[ -f ~/.source/unicamprc ]]
then
    . ~/.source/unicamprc
fi


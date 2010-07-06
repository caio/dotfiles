# plain .bashrc - should work on any Linux environment
# assembled by: Caio Romão <caioromao@gmail.com>

# {{{ *PATH variables helpers
pathremove() {
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

pathprepend() {
    pathremove $1 $2
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend() {
    pathremove $1 $2
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}

do_append() {
    [ -d $1 ] && pathappend $*
}

do_prepend() {
    [ -d $1 ] && pathprepend $*
}

alias pwdappend='pathappend $(pwd)'
# }}}

# {{{ Source scripts helper
do_source() {
    [ -r $1 ] && . $1
}
# }}}

# disabling flow control if stdin is a terminal
[ -t 0 ] && stty -ixon -ixoff

# setting up custom bin-dir
do_prepend ~/bin

# google appengine
do_append /opt/google-appengine

# VCS PS1 Command
do_source ~/.source/vcsinfo.sh

# Bash completion
do_source /etc/bash_completion
# Custom completion for '~/src'
do_source ~/.source/projects_complete.sh

# {{{ EXPORTS
export GWT_EXTERNAL_BROWSER="firefox"
export EDITOR="vim"
export PYTHONSTARTUP="$HOME/.pythonrc.py"
# }}}

# {{{ Bash Prompt
# credits to B-Con from ArchLinux forums for this :)
bash_prompt_cmd() {
    local RETVAL=$?
    local CY="\[\e[0;37m\]" # Each is 12 chars long
    local BL="\[\e[1;34m\]"
    local RE="\[\e[1;31m\]"
    local OR="\[\e[33;40m\]"
    local PK="\[\e[35;40m\]"
    local GR="\[\e[32;40m\]"
    local WH="\[\e[37;40m\]"
    local GR="\[\e[1;32m\]"

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
    local envname=$(basename $VIRTUAL_ENV 2>/dev/null)
    if [ -n "$envname" ]
    then
        VENVSTATUS="${OR}·${envname}· "
        ps_len=$((ps_len + ${#envname} - 12 - 2))
    fi

    local REMOTE=""
    if [ -n "$SSH_CLIENT" ]; then
        REMOTE="${GR}$(hostname -s) "
        ps_len=$((ps_len + ${#REMOTE} - 12))
    fi

    __vcs_dir
    local SCMSTATUS=""
    [ "$__vcs_prefix" != "" ] && SCMSTATUS="${WH}${__vcs_prefix}:${__vcs_ref} "
    [ ${#SCMSTATUS} -gt 1 ] && ps_len=$((ps_len + ${#SCMSTATUS} - 12))

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

    export PS1="${REMOTE}${BL}${PROMPT_PWD}${PS1_T1}${PS1_T2}"
}
PROMPT_COMMAND=bash_prompt_cmd
# }}}

# {{{ Aliases
alias c='clear'
alias mv='mv -i'
alias cp=' cp -i'
alias rm='rm -I'
alias j='jobs'
alias h='history'
alias grep='egrep'
alias ls='ls --color=tty --time-style=iso -h -F --quoting-style=escape --group-directories-first'
alias l='ls -lh'
alias la='ls -lhA'
alias ad='ls -A -d */'
alias a='ls -d .*'
alias d='dirs -v'
alias cpptags='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'
alias -- -='cd -'
# }}}

# {{{ History
export HISTSIZE=4000
export HISTFILESIZE=4000
export HISTIGNORE="ls:l:c:clear:d:cd:dc:bg:fg"
export HISTCONTROL=erasedups
export HISTTIMEFORMAT='%m%d %H%M: '
# }}}

# {{{ Mercurial

# Opens vim in diff mode comparing the current version with
# the one versioned
function hgdiff()
{
    hg cat $1 | gvim - -c  ":vert diffsplit $1" -c "map q :qa!<CR>";
}
# }}}

##########################################################################
# Add sources bellow this comment to avoid replacing of the new commands #
##########################################################################

# {{{ Virtualenv wrapper
export WORKON_HOME=${HOME}/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
mkdir -p $WORKON_HOME
pathappend ~/.source/ PYTHONPATH
do_source ~/.source/virtualenvwrapper/virtualenvwrapper.sh
# }}}

for script in ~/.source/*
do
    [ -f $script ] && do_source $script
done

true # avoid carrying over test status

export EDITOR=vim
export PYTHONSTARTUP="${HOME}/.pythonrc.py"

# {{{ Shell options
shopt -s checkjobs
shopt -s checkwinsize
shopt -s cmdhist
shopt -s extglob
shopt -s histappend
shopt -s no_empty_cmd_completion
# }}}

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

unckecked_pathappend() {
    pathremove "$1" "$2"
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}

pathprepend() {
    test ! -d "${1}" && return 0
    pathremove "$1" "$2"
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend() {
    test ! -d "${1}" && return 0
    unckecked_pathappend "$1" "$2"
}

alias pwdappend='pathappend $(pwd)'
# }}}

# {{{ Source scripts helper
do_source() {
    for file in ${@}; do
        test ! -f ${file} -o ! -x ${file} && continue
        . ${file} || echo ">>> Error loading ${file}" 1>&2
    done
}
# }}}

# Custom bin-dir
pathprepend ~/bin

# Load custom scripts
do_source ~/.source/*

# Load custom non-versioned scripts
do_source ~/.source.local.d/*

[ -f ~/.dircolors ] && eval $(dircolors ~/.dircolors)

# Disable flow control if stdin is a terminal
[ -t 0 ] && stty -ixon -ixoff

# {{{ Colors
col_txtblk='\[\e[0;30m\]' # Black - Regular
col_txtred='\[\e[0;31m\]' # Red
col_txtgrn='\[\e[0;32m\]' # Green
col_txtylw='\[\e[0;33m\]' # Yellow
col_txtblu='\[\e[0;34m\]' # Blue
col_txtpur='\[\e[0;35m\]' # Purple
col_txtcyn='\[\e[0;36m\]' # Cyan
col_txtwht='\[\e[0;37m\]' # White
col_bldblk='\[\e[1;30m\]' # Black - Bold
col_bldred='\[\e[1;31m\]' # Red
col_bldgrn='\[\e[1;32m\]' # Green
col_bldylw='\[\e[1;33m\]' # Yellow
col_bldblu='\[\e[1;34m\]' # Blue
col_bldpur='\[\e[1;35m\]' # Purple
col_bldcyn='\[\e[1;36m\]' # Cyan
col_bldwht='\[\e[1;37m\]' # White
col_unkblk='\[\e[4;30m\]' # Black - Underline
col_undred='\[\e[4;31m\]' # Red
col_undgrn='\[\e[4;32m\]' # Green
col_undylw='\[\e[4;33m\]' # Yellow
col_undblu='\[\e[4;34m\]' # Blue
col_undpur='\[\e[4;35m\]' # Purple
col_undcyn='\[\e[4;36m\]' # Cyan
col_undwht='\[\e[4;37m\]' # White
col_bakblk='\[\e[40m\]'   # Black - Background
col_bakred='\[\e[41m\]'   # Red
col_badgrn='\[\e[42m\]'   # Green
col_bakylw='\[\e[43m\]'   # Yellow
col_bakblu='\[\e[44m\]'   # Blue
col_bakpur='\[\e[45m\]'   # Purple
col_bakcyn='\[\e[46m\]'   # Cyan
col_bakwht='\[\e[47m\]'   # White
col_txtrst='\[\e[0m\]'    # Text Reset
# }}}

# {{{ Bash Prompt
bash_prompt_cmd() {
    local RETVAL=$?
    PS1=""

    append_ps1() {
        PS1="${PS1}${1}"
    }

    transform_pwd() {
        curdir="$@"
        curdir=${curdir/#~\/src\//:}
        curdir=${curdir/#:personal\//${col_undcyn}➤${col_txtblu}}
        curdir=${curdir/#:work\//${col_undred}⚒${col_txtblu}}
        echo $curdir
    }

    # Add hostname if connected through SSH
    if [ -n "$SSH_CLIENT" ]; then
        append_ps1 "${col_bldgrn}$(hostname -s) "
    fi

    # CWD
    CUR_DIR=${PWD/$HOME/\~}
    append_ps1 "${col_txtblu}$(transform_pwd ${CUR_DIR})"

    # Return-code
    if [ $RETVAL -ne 0 ]; then
        append_ps1 " ${col_bldred}${RETVAL}!"
    fi

    # Virtualenv
    local envname=$(basename $VIRTUAL_ENV 2>/dev/null)
    if [ -n "$envname" ]; then
        append_ps1 " ${col_txtylw}·${envname}·"
    fi

    # Pythonbrew
    local PYBREW="$(echo $(which python 2>/dev/null)|sed -n 's/.*Python-\([0-9].[0-9]\).*/\1/p')"
    if [ ! -z "$PYBREW" ]; then
        append_ps1 " ${col_txtpur}∝${PYBREW}"
    fi

    # RVM
    if [ ! -z $RUBY_VERSION ]; then
        append_ps1 " ${col_txtgrn}∼$(echo $RUBY_VERSION |sed 's/.*-\(.\+\)-.*/\1/g')"
    fi

    # Source-controlled directories
    __vcs_dir
    if [ ! -z "$__vcs_prefix" ]; then
        append_ps1 " ${col_bldwht}${__vcs_prefix}${__vcs_ref}"
    fi

    # Super-user identification
    if [ "$UID" -eq "0" ]; then
        append_ps1 " ${col_txtred}#"
    else
        append_ps1 " ${col_txtwht}$"
    fi

    # Reset colors
    append_ps1 "${col_txtrst} "

    export PS1
}
PROMPT_COMMAND=bash_prompt_cmd
# }}}

# {{{ Aliases
alias mv='mv -i'
alias cp=' cp -i'
alias rm='rm -I'
alias j='jobs'
alias grep='egrep'
alias ls='ls --color --time-style=iso -h --group-directories-first'
alias l='ls -lh'
alias la='ls -lhA'
alias a='ls -d .*'
alias cpptags='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'
alias -- -='cd -'
alias beep="echo -ne '\a'"
alias S="screen -S"
alias t=task
alias v=viewnior
alias e='/usr/bin/gvim --remote-silent'
alias p='ps -eo pid,ruser,cmd| grep -i'
alias gg='git grep'
alias G='grep -i'
# }}}

# {{{ History
_hist_ignore_fullcmd() {
    for arg in ${@}; do
        unckecked_pathappend "${arg} *" HISTIGNORE
    done
}
export HISTSIZE=40000
export HISTFILESIZE=40000
export HISTIGNORE="ls:l:c:clear:d:cd:bg:fg:wnext:wprev:alsamixer:history"
export HISTCONTROL="erasedups:ignorespace"
export HISTTIMEFORMAT='%m%d %H%M: '
_hist_ignore_fullcmd ls l cd jk h dl unpack cp mv mplayer
# }}}

# avoid carrying over test status
true

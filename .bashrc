# plain .bashrc - should work on any Linux environment
# assembled by: Caio Romão <caioromao@gmail.com>

# disabling flow control
stty -ixon -ixoff

# setting up custom bin-dir
if [ -d ${HOME}/bin ]
then
    export PATH=${HOME}/bin:$PATH
fi

# Git custom PS1 command
if [[ -f ~/.source/gitrc ]]
then
    source ~/.source/gitrc
fi

# Bash completion
# The username restriction is due to network weirdness
if [ -e /etc/bash*completion ] && [ "`whoami`" != "ra059467" ]
then
    . /etc/bash*completion
fi

# EXPORTS
export GWT_EXTERNAL_BROWSER="firefox"
export EDITOR="vim"

# PROMPT
# credits to B-Con from ArchLinux forums for this :)
bash_prompt_cmd() {
        local CY="\[\e[0;37m\]" # Each is 12 chars long
        local BL="\[\e[1;34m\]"
        local WH="\[\e[1;37m\]"
        local BR="\[\e[0;33m\]"
        local RE="\[\e[0;31m\]"
        local RET="${CY}${?}${BL}| "
        local PROMPT="${RET}${CY}$"
        [ $UID -eq "0" ] && PROMPT="${RET}${RE}#"
        [ -n "$CLEARCASE_ROOT" ] && PROMPT="${RET}${BL}(${RE}$(basename $CLEARCASE_ROOT)${BL}) ${CY}$"
        [ -n "$(__git_custom_ps1)" ] && PROMPT="${RET}${BL}(${RE}$(__git_custom_ps1)${BL}) ${CY}$"

        # Add the first part of the prompt: username,host, and time
        local PROMPT_PWD=""
        local PS1_T1="$BL[$CY`whoami`@`hostname`$BL:$CY\t$BL:$CY "
        local ps_len=$(( ${#PS1_T1} - 12 * 6 + 6 + 4 )) #Len adjust for colors, time and var
        local PS1_T2=" $BL]\n${PROMPT} \[\e[0m\]"
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
        export PS1="${PS1_T1}${PROMPT_PWD}${PS1_T2}"
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
alias l='ls -lhG'
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
        if [[ $1 != "." ]]
        then
            pushd "$*"
        fi
    else
        if [ "$(pwd)" != "$HOME" ]
        then
            pushd ~
        fi
    fi
}

alias cd=cdpushd
alias ctags='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'


###########
# History #
###########

export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTIGNORE="ls:l:c:clear:d:cd:dc:bg:fg"
export HISTCONTROL=ignoredups


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

# load Motorola config file
if [[ "$(whoami)" = "wxmp34" ]] && [[ -f ~/.source/motorolarc ]]
then
    source ~/.source/motorolarc
fi

# load Unicamp config file
if [[ "$(whoami)" = "ra059467" ]] && [[ -f ~/.source/unicamprc ]]
then
    source ~/.source/unicamprc
fi


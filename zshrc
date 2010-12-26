export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="caioromao"
export CASE_SENSITIVE="true"
export DISABLE_AUTO_UPDATE="true"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git make-dir-complete fabric gem task)

source $ZSH/oh-my-zsh.sh


# Customizations (Backported from bashrc)

# {{{ Helpers
pathremove() {
    local NEWPATH
    local DIR
    local PATHVARIABLE=${2:-PATH}
    local PATHCONTENT=$(eval echo \$$PATHVARIABLE)
    for DIR in ${(s/:/)PATHCONTENT}; do
        if [ "$DIR" != "$1" ] ; then
            NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
        fi
    done
    export $PATHVARIABLE="$NEWPATH"
}

pathprepend() {
    pathremove $1 $2
    local PATHVARIABLE=${2:-PATH}
    local PATHCONTENT=$(eval echo \$$PATHVARIABLE)
    export $PATHVARIABLE="${1}:${PATHCONTENT}"
}

pathappend() {
    pathremove $1 $2
    local PATHVARIABLE=${2:-PATH}
    local PATHCONTENT=$(eval echo \$$PATHVARIABLE)
    export $PATHVARIABLE="${PATHCONTENT}:${1}"
}

do_append() {
    [ -d $1 ] && pathappend $*
}

do_prepend() {
    [ -d $1 ] && pathprepend $*
}

do_source() {
    [ -r $1 ] && source $1
}
# }}}

# Exports
export EDITOR=vim
export WORKON_HOME=${HOME}/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME

# make-dir-complete settings
make_dir_complete dl ~/download/
make_dir_complete jk ~/src/
make_dir_complete h ~/

# setup *PATH variables
do_prepend ~/bin
do_append /opt/google-appengine
do_append ~/.source/ PYTHONPATH

# load virtualenvwrapper
SCRIPTS=(
~/.source/virtualenvwrapper/virtualenvwrapper.sh
~/.pythonbrew/etc/bashrc
~/.rvm/scripts/rvm
~/.source/virtualenvwrapper/virtualenvwrapper.sh
)

for script in $SCRIPTS; do
    source $script
done


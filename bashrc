# vim:ft=sh
test ! -t 0 && return 0

export VIRTUALENVWRAPPER_PYTHON="python"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export DOTFILES_DIR="${HOME}/src/personal/dotfiles"
export BASHD_DIR="${DOTFILES_DIR}/bash.d"
export PYTHONSTARTUP="${DOTFILES_DIR}/pythonrc.py"

export EDITOR='mvim -v'
export BROWSER=firefox
export HISTIGNORE="ls:l:clear:d:cd:bg:fg:history"
export HISTTIMEFORMAT='[%Y-%m-%d %H:%M]  '

BASHD_THEME=default

. $BASHD_DIR/bashd.bash

bashd_source ${DOTFILES_DIR}/custom.d/*

make_dir_complete jk ~/src
make_dir_complete h ~/etc
make_dir_complete dl /download/errado/

alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -I'
alias j='jobs'
alias grep='egrep'
alias ls='ls --color -h --group-directories-first'
alias l='ls -lh'
alias la='ls -lhA'
alias a='ls -d .*'
alias -- -='cd -'
alias beep="echo -ne '\a'"
alias p='ps -eo pid,ruser,command| grep -v grep| grep -i'
alias o='xdg-open'
alias vim='mvim -v'

pathprepend "$(/usr/libexec/java_home -R -v 1.6)/bin"
pathprepend /bin
pathprepend /usr/bin
pathprepend /usr/local/bin
pathprepend /usr/local/opt/coreutils/libexec/gnubin
pathprepend /usr/local/opt/coreutils/libexec/gnuman MANPATH
pathprepend /usr/local/opt/go/libexec/bin

bashd_source -f /usr/local/git/contrib/completion/git-completion.bash

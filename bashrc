# vim:ft=sh
test ! -t 0 && return 0

export DOTFILES_DIR="${HOME}/src/personal/dotfiles"
export BASHD_DIR="${DOTFILES_DIR}/bash.d"
export PYTHONSTARTUP="${DOTFILES_DIR}/pythonrc.py"

export EDITOR=vim
export BROWSER=chromium
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
alias p='ps -eo pid,ruser,cmd| grep -i'

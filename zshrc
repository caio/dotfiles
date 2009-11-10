#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

###########
# Aliases #
###########

alias c='clear'
alias mv='nocorrect mv -i'
alias cp='nocorrect cp -i'
alias rm='rm -i'
alias mkdir='nocorrect mkdir'
alias j='jobs'
alias h='history'
alias grep='egrep'
alias top='htop'
alias ls='ls --color=always'
alias l='ls -l'
alias la='ls -lA'
alias ad='ls -A -d */'
# List only directories and symbolic
# links that point to directories
alias d='ls -ld *(-/DN)'
# List only file beginning with "."
alias a='ls -d .*'

# |less simplified
alias -g L='|less'
# |grepp simplified
alias -g G='|grep'
alias dc=popd

alias dir='dirs -v'

###########
# General #
###########

# prompt
PROMPT='%B%m%b (%?) %# '    # default prompt
RPROMPT=' %~ %U%T%u'     # prompt for right side of screen


# shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word 
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line
bindkey '\e[2~' overwrite-mode
bindkey '\e[5~' beginning-of-buffer-or-history
bindkey '\e[6~' end-of-buffer-or-history

##############
# completion #
##############

autoload -U compinit
compinit

zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
## one error for each three characters allowed
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
## insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
## formats
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
## match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
## ignore .o .c~ .old .pro .h~ .cpp~
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro' '*?.cpp~' '*?.h~'
## ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt hist_ignore_all_dups
## for sharing history between zsh processes
setopt SHARE_HISTORY
export HISTSIZE=500
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

## never ever beep ever
setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
MAILCHECK=0

autoload -U colors
colors


# Keys fix

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '[1;5D' vi-backward-blank-word
bindkey '[1;5B' vi-backward-word
bindkey '[1;5C' vi-forward-blank-word
bindkey '[1;5A' vi-forward-word
bindkey '^R' history-incremental-search-backward
bindkey '[3~' delete-char

# Hosts completion

local _myhosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*' hosts $_myhosts


export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="caioromao"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git make-dir-complete)

source $ZSH/oh-my-zsh.sh

# make-dir-complete settings
make_dir_complete dl ~/download/
make_dir_complete jk ~/src/
make_dir_complete h ~/

# load virtualenvwrapper
source ~/.source/virtualenvwrapper/virtualenvwrapper.sh

# load pythonbrew
source ~/.pythonbrew/etc/bashrc

# load rvm
source ~/.rvm/scripts/rvm

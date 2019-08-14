stty discard undef

set -g fish_color_cwd blue --bold
set -g fish_color_error red --bold

fish_vi_key_bindings

set -U fish_user_paths \
    {$GOPATH}/bin \
    {$HOME}/.cargo/bin \
    {$HOME}/.poetry/bin \
    {$HOME}/.node_modules/bin \
    {$HOME}/bin

set -x npm_config_prefix {$HOME}/.node_modules

abbr -a -- - 'cd -'
alias ls=exa


stty discard undef

set -g fish_color_cwd blue --bold
set -g fish_color_error red --bold

fish_vi_key_bindings

set -U fish_user_paths \
    {$HOME}/.cargo/bin \
    {$HOME}/bin

set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
set -gx EDITOR nvim

abbr -a -- - 'cd -'
alias ls=exa


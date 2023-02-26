stty discard undef

set fish_greeting
set -g fish_color_cwd blue --bold
set -g fish_color_error red --bold

fish_vi_key_bindings

set -U fish_user_paths \
    {$HOME}/.cargo/bin \
    {$HOME}/bin

set -gx EDITOR nvim

abbr -a -- - 'cd -'
abbr --add gh --set-cursor 'cd ~/src/github/%'
abbr --add p --set-cursor 'cd ~/src/personal/%'

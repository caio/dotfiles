stty discard undef

set fish_greeting
set -g fish_color_cwd blue --bold
set -g fish_color_error red --bold

set -g fish_key_bindings fish_vi_key_bindings

set -U fish_user_paths \
    {$HOME}/.cargo/bin \
    {$HOME}/bin

abbr -a -- - 'cd -'
abbr --add c --set-cursor 'cd ~/src/contrib/%'
abbr --add p --set-cursor 'cd ~/src/caio.co/%'

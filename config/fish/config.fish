stty discard undef

set -g fish_color_cwd blue --bold
set -g fish_color_error red --bold

fish_vi_key_bindings

set -U fish_user_paths {$HOME}/bin {$GOPATH}/bin {$HOME}/.cargo/bin {$HOME}/.poetry/bin

abbr -a -- - 'cd -'


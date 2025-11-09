function t --argument session --description "tmux attach/new-session wrapper"
    if test -z $session
        set session scratch
    end
    tmux new-session -A -s $session
end

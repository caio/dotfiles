#!/bin/bash

tmux new-session -d -s mail -n MAIL ". ~/.rvm/scripts/rvm; rvm use 1.9.2; sup"
tmux split-window -p 7 -t mail:0 'offlineimap'
tmux select-pane -U -t mail:0
tmux attach-session -d -t mail

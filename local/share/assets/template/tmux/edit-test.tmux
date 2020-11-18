#!/bin/sh
if tmux has-session -t=DOTFILES 2>/dev/null; then
  tmux a -t DOTFILES; exit
fi
tmux new -s DOTFILES -d
tmux rename-window -t DOTFILES:1 editor
tmux send-keys -t DOTFILES:1 nvim Enter
tmux new-window -t DOTFILES:2 -n test
tmux split-window -h -t DOTFILES:2
tmux send-keys -t DOTFILES:2.right "git st" Enter
tmux select-window -t DOTFILES:1
tmux a -t DOTFILES; exit

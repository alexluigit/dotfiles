#!/bin/sh
if !( tmux has-session -t DOTFILES ); then
  tmux new -s DOTFILES -d
  tmux rename-window -t DOTFILES:1 editor 
  tmux send-keys -t DOTFILES:1 v Enter
  tmux split-window -h -t DOTFILES:1
  tmux select-pane -L; tmux resize-pane -Z
  tmux new-window -t DOTFILES:2 -n ref
  tmux new-window -t DOTFILES:3 -n test
  tmux select-window -t DOTFILES:1.1
fi
tmux a -t DOTFILES

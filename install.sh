#!/bin/sh
echo "pwd: $PWD"
echo "Please confirm your pwd before installation."
read -p "Press y to continue, otherwise to quit: " REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  [[ ! -d $HOME/.config ]] && mkdir ~/.config
  echo "Creating symlink..."
  ln -s $PWD/zsh/.zshenv ~/.zshenv
  ln -s $PWD/zsh ~/.config/zsh
  ln -s $PWD/nvim ~/.config/nvim
  ln -s $PWD/karabiner ~/.config/karabiner
  ln -s $PWD/tmux ~/.config/tmux
  ln -s $PWD/tmux/tmux.conf ~/.tmux.conf
  ln -s $PWD/vifm ~/.config/vifm
  ln -s $PWD/scripts ~/bin/scripts
fi
if [[ $USER == "simon" ]]; then
  ln -s $PWD/shadowsocks ~/.ShadowsocksX-NG
  ln -s $PWD/ssh ~/.ssh
  ln -s $PWD/rime ~/Library/Rime
  ln -s $PWD/git ~/.config/git
fi
git submodule init && git submodule update
echo "Done."

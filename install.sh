#!/bin/zsh
echo "Current Directory: $PWD"
CFGDIR="$HOME/.config"
SCRIPTDIR="$HOME/.local/bin"

check-dir(){
  [[ ! -d $CFGDIR ]] && mkdir $CFGDIR || echo "$HOME/.config exists"
}

dotconfig() {
  find $CFGDIR -maxdepth 1 -type l -delete
  for i in $(du -d 1 "$PWD/config" | cut -f2); ln -s "$i" "$CFGDIR"
  rm $CFGDIR/config
}

scripts() {
  find $SCRIPTDIR -maxdepth 1 -type l -delete
  for i in $(find "$PWD/local/bin" -type f -executable); ln -s $i $SCRIPTDIR
}

zsh() {
  ln -s $PWD/zsh $CFGDIR
}

nvim() {
  ln -s $PWD/nvim $CFGDIR
}

"$@"
# git submodule init && git submodule update && echo "Done."

# Keybinding
# ln -s $PWD/sxhkd ~/.config/sxhkd
# Configure shadowsocks
# ln -s $PWD/shadowsocks ~/.config/shadowsocks

# ssh config
# ln -s $PWD/ssh ~/.ssh

# Rime input
# ln -s $PWD/rime ~/.config/ibus/rime

# Git
# ln -s $PWD/git ~/.config/git

# Auto start program
# ln -s $PWD/.xprofile ~/.xprofile

# Karabiner
# ln -s $PWD/karabiner ~/.config/karabiner

# rm nvim/pack/bundle/opt/fzf
# ln -s $PWD/zsh/plugins/fzf ~/.config/nvim/pack/bundle/opt/fzf

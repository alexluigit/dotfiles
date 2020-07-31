#!/bin/sh
CFGDIR="$HOME/.config"
SCRIPTDIR="$HOME/.local/bin"
APPDIR="$HOME/.local/apps"

checkdir() {
  echo "Current Directory: $PWD"
  [[ ! -d $CFGDIR ]] && mkdir $CFGDIR || echo "$HOME/.config exists"
}

config() {
  find $CFGDIR -maxdepth 1 -type l -delete
  for i in $(du -d 1 "$PWD/config" | cut -f2)
    do ln -s "$i" "$CFGDIR"
  done
  rm $CFGDIR/config
}

scripts() {
  find $SCRIPTDIR -maxdepth 1 -type l -delete
  for i in $(find "$PWD/local/bin" -type f -executable)
    do ln -s $i $SCRIPTDIR
  done
}

zshenv() {
  rm ~/.zshenv
  ln -s $PWD/config/zsh/.zshenv $HOME/.zshenv
}

apps() {
  find $APPDIR -maxdepth 1 -type l -delete
  for i in $(du -d 1 "$PWD/local/apps" | cut -f2)
    do ln -s "$i" "$APPDIR"
  done
  rm $APPDIR/apps
}

"$@"
# git submodule init && git submodule update && echo "Done."

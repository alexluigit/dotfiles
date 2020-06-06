# Locale
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"
# Default programs:
export EDITOR="nvim"
export TERM="xterm-256color"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# ~/ clean-up
export GOPATH=$HOME/bin/go
export CARGO_HOME=~/bin/.cargo
export RUSTUP_HOME=~/bin/.rustup
export RBENV_ROOT=~/bin/.rbenv
export ZSH_CACHE_DIR=$ZDOTDIR/cache
export HISTFILE=$ZSH_CACHE_DIR/history
export LESSHISTFILE=$ZSH_CACHE_DIR/.lesshst
export PATH=$PATH:$HOME/bin/scripts:$GOPATH/bin:/usr/local/opt/fzf/bin:/Library/Frameworks/Python.framework/Versions/3.8/bin
# dealwith GFW
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
export PUPPETEER_DOWNLOAD_HOST=https://npm.taobao.org/mirrors
export FZF_DEFAULT_COMMAND='fd -t f -H -E .git'

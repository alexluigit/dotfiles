# Place this file to $HOME dir or create a symlink there.
# Locale
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"
# Default programs:
export EDITOR="nvim"
export TERM="xterm-256color"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# ~/ clean-up
export GOPATH=$HOME/Dev/go
export CARGO_HOME=~/Dev/.cargo
export RUSTUP_HOME=~/Dev/.rustup
export ZDOTDIR=$HOME/.config/zsh
export ZSH_CACHE_DIR=$ZDOTDIR/cache
export HISTFILE=$ZSH_CACHE_DIR/history
export LESSHISTFILE=$ZSH_CACHE_DIR/.lesshst
export PATH=$PATH:$HOME/bin:$GOPATH/bin:/Library/Frameworks/Python.framework/Versions/3.8/bin
# dealwith GFW
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
export npm_config_registry=https://registry.npm.taobao.org/
export PUPPETEER_DOWNLOAD_HOST=https://npm.taobao.org/mirrors
export PATH=$PATH:/usr/local/opt/fzf/bin
export FZF_DEFAULT_COMMAND='fd -t f -H -E .git'

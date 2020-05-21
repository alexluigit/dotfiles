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
export PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# dealwith GFW
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
export npm_config_registry=https://registry.npm.taobao.org/
export PUPPETEER_DOWNLOAD_HOST=https://npm.taobao.org/mirrors


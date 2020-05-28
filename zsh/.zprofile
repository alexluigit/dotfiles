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
export PATH="${PATH}:/Library/Frameworks/Python.framework/Versions/3.8/bin"
export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"
# dealwith GFW
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
export npm_config_registry=https://registry.npm.taobao.org/
export PUPPETEER_DOWNLOAD_HOST=https://npm.taobao.org/mirrors
# Setup fzf
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
export FZF_DEFAULT_OPTS="--no-mouse --height 40% -1 --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind 'f4:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept'"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules}"'

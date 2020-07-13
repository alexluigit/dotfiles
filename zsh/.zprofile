# Clean-up ~/
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export ZSH_CACHE_DIR=$ZDOTDIR/cache
export HISTFILE=$ZSH_CACHE_DIR/history
export HISTSIZE=10000
export SAVEHIST=10000
export LESSHISTFILE=$ZSH_CACHE_DIR/.lesshst
# export GNUPGHOME=$XDG_DATA_HOME/gnupg; export __GL_SHADER_DISK_CACHE_PATH=$XDG_CACHE_HOME/nv

# $PATH
export GOPATH=$XDG_DATA_HOME/go
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export RBENV_ROOT=$XDG_DATA_HOME/rbenv
export PATH=$PATH:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin

# Default programs
export FILES="gio open $HOME"
export TERMINAL=alacritty
export BROWSER=chromium
export EDITOR="nvim"
# export TERM="xterm-256color"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FZF_DEFAULT_COMMAND="fd -t f -H --ignore-file ~/.fdignore"

# App Scale (4k monitor)
export GDK_SCALE=2
export GDK_DPI_SCALE=0.6
export QT_SCREEN_SCALE_FACTORS=1

# Input
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# Dealwith GFW
export http_proxy=http://127.0.0.1:1088
export https_proxy=http://127.0.0.1:1088

# Start graphical interface (check if Xsession exists first)
[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx \
"$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1

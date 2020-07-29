# Clean-up ~/
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export ZSH_CACHE_DIR=$ZDOTDIR/cache
export _Z_DATA=$ZSH_CACHE_DIR/.z
export HISTFILE=$ZSH_CACHE_DIR/history
export HISTSIZE=10000
export SAVEHIST=10000
export LESSHISTFILE=$ZSH_CACHE_DIR/lesshst
# export GNUPGHOME=$XDG_DATA_HOME/gnupg # export __GL_SHADER_DISK_CACHE_PATH=$XDG_CACHE_HOME/nv

# $PATH
export GOPATH=$XDG_DATA_HOME/go
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export RBENV_ROOT=$XDG_DATA_HOME/rbenv
export PATH=$PATH:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin

# Default programs
export EDITOR="nvim"
export MANPAGER="nvim +set\ filetype=man -"
export FZF_DEFAULT_COMMAND="fd -t f -L --ignore-file $XDG_CONFIG_HOME/fd/fdignore"

# App Scale (4k monitor)
export GDK_SCALE=2
export GDK_DPI_SCALE=0.6
export QT_SCREEN_SCALE_FACTORS=1

# Input
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# Dealwith GFW
export http_proxy=http://127.0.0.1:1088
export https_proxy=http://127.0.0.1:1088

# Start graphical interface (check if Xsession exists first)
[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx \
"$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1

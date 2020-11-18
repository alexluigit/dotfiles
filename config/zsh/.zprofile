# Clean-up ~/
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export HISTFILE=$XDG_DATA_HOME/zsh/history
export HISTSIZE=100000; export SAVEHIST=100000
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export _Z_DATA=$XDG_DATA_HOME/z/.z
export LESSHISTFILE=$XDG_CACHE_HOME/less/lesshst
export GOPATH=$XDG_DATA_HOME/go
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export RBENV_ROOT=$XDG_DATA_HOME/rbenv
export FNM_DIR=$XDG_DATA_HOME/fnm; eval $(fnm env)
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export PATH=$PATH:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin
# Defaults
export EDITOR="nvim"
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonrc
export MANPAGER='nvim -c "let g:manpager = 1" +set\ filetype=man -'
export GDK_SCALE=2 GDK_DPI_SCALE=0.6
export QT_SCREEN_SCALE_FACTORS=1 QT_AUTO_SCREEN_SCALE_FACTOR=true
export GTK_IM_MODULE=fcitx5 QT_IM_MODULE=fcitx5 XMODIFIERS=@im=fcitx5
export FZF_DEFAULT_OPTS="--ansi --height 50% --layout=reverse --border --bind=ctrl-r:toggle-sort,ctrl-e:up"
# StartX
[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx \
"$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1

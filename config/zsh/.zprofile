export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

export HISTFILE=$XDG_DATA_HOME/zsh/history
export HISTSIZE=100000 SAVEHIST=100000
export LESSHISTFILE=$XDG_CACHE_HOME/less/lesshst
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export GNUPGHOME=$XDG_DATA_HOME/gnupg

export EDITOR="nvim"
export MANPAGER='nvim -c "let g:manpager = 1" +set\ filetype=man -'
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonrc

export GOPATH=$XDG_DATA_HOME/go
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export RBENV_ROOT=$XDG_DATA_HOME/rbenv
export FNM_DIR=$XDG_DATA_HOME/fnm FNM_MULTISHELL_PATH=/tmp/fnm_node
export NODE_PATH=$FNM_MULTISHELL_PATH/lib/node_modules
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export PATH=$PATH:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin:$FNM_MULTISHELL_PATH/bin

export GDK_SCALE=2 GDK_DPI_SCALE=0.6
export QT_SCREEN_SCALE_FACTORS=1 QT_AUTO_SCREEN_SCALE_FACTOR=true
export GTK_IM_MODULE=fcitx5 QT_IM_MODULE=fcitx5 XMODIFIERS=@im=fcitx5

source $ZDOTDIR/user/variable.zsh

test -e $FNM_MULTISHELL_PATH || fnm use default >/dev/null
pgrep aria2c >/dev/null || aria2c -i ~/.cache/aria2/aria2.session &
pgrep privoxy >/dev/null || privoxy --no-daemon ~/.config/privoxy/config &
pgrep ss-local >/dev/null || ss-local -c ~/.config/shadowsocks/config.json &
pgrep mpd >/dev/null || { mpd & mpDris2 & }
pgrep emacs >/dev/null || emacs --daemon &

# only startx in tty1
[ $(tty) = "/dev/tty1" ] && ! pgrep X && exec ssh-agent startx \
$XDG_CONFIG_HOME/x11/xinitrc -- $XDG_CONFIG_HOME/x11/xserverrc vt1

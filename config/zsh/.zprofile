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
export _Z_DATA=$XDG_DATA_HOME/z/.z

export EDITOR="nvim"
export MANPAGER='nvim +set\ filetype=man -'

export FNM_MULTISHELL_PATH="/tmp/fnm_multishells"
export FNM_DIR="$XDG_DATA_HOME/fnm"; fnm use default
export GOPATH=$XDG_DATA_HOME/go
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export RBENV_ROOT=$XDG_DATA_HOME/rbenv
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# if encounter cmd not found (eg. perl pkg), try replace /usr/bin with $PATH
export PATH=$FNM_MULTISHELL_PATH/bin:/usr/bin:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin

export GDK_SCALE=2 GDK_DPI_SCALE=0.6
export QT_SCREEN_SCALE_FACTORS=1 QT_AUTO_SCREEN_SCALE_FACTOR=true
export GTK_IM_MODULE=fcitx5 QT_IM_MODULE=fcitx5 XMODIFIERS=@im=fcitx5
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border
--bind=ctrl-s:toggle-sort --bind=ctrl-e:up --bind=f3:end-of-line
--bind=down:preview-down,up:preview-up"

_running() { pgrep $1 >/dev/null 2>&1; }
_startx() { exec ssh-agent startx ~/.config/x11/xinitrc -- ~/.config/x11/xserverrc vt1; }

_running privoxy  || privoxy --no-daemon ~/.config/privoxy/config &
_running ss-local || ss-local -c ~/.config/shadowsocks/config.json &
_running emacs    || emacs --daemon &
_running udevmon  || doas nice -n -20 udevmon -c ~/.config/interception/udevmon.yaml &
_running aria2c   || aria2c -i ~/.cache/aria2/aria2.session >/dev/null &
_running X        && return
[[ $(tty) = '/dev/tty1' ]] && _startx || exec zsh


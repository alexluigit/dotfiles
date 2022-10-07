export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

export HISTFILE=$XDG_DATA_HOME/zsh/history
export HISTSIZE=100000 SAVEHIST=100000
export LESSHISTFILE=$XDG_CACHE_HOME/less/lesshst
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export PASSWORD_STORE_DIR=$XDG_DATA_HOME/pass
export EDITOR="emacs -nw"

export CONDARC=$XDG_CONFIG_HOME/conda/condarc
export IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export GOPATH=$XDG_DATA_HOME/go
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export PATH=/usr/bin:$XDG_DATA_HOME/miniconda/bin:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin
export EMACSNATIVELOADPATH=$XDG_CACHE_HOME/emacs/eln-cache/
export GRANDVIEW_HOME=$XDG_CONFIG_HOME/emacs/

export GDK_SCALE=2 GDK_DPI_SCALE=0.6
export QT_SCREEN_SCALE_FACTORS=1 QT_AUTO_SCREEN_SCALE_FACTOR=true
export GTK_IM_MODULE=fcitx5 QT_IM_MODULE=fcitx5 XMODIFIERS=@im=fcitx5

_running() { pgrep $1 >/dev/null 2>&1; }
_running xray     || xray run -confdir $XDG_CONFIG_HOME/xray/ &
_running udevmon  || sudo nice -n -20 udevmon &
_running aria2c   || aria2c -i ~/.cache/aria2/aria2.session >/dev/null &
_running crond    || sudo crond -n &
_running X        && return
[[ $(tty) = '/dev/tty1' ]] && exec startx || exec zsh

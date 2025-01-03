export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export LESSHISTFILE=$XDG_CACHE_HOME/less/lesshst
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export PASSWORD_STORE_DIR=$XDG_DATA_HOME/pass
export EDITOR="emacs -nw"
export IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export GOPATH=$XDG_DATA_HOME/go
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$PATH:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin
[[ -d /opt/homebrew ]] && {
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"
  export HOMEBREW_NO_AUTO_UPDATE=1
  export PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
}
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent >/dev/null && gpg-connect-agent updatestartuptty /bye >/dev/null

_running() { pgrep $1 >/dev/null 2>&1; }

_running aria2c  || aria2c -i ~/.cache/aria2/aria2.session >/dev/null &
_running xray    || xray run -config $XDG_CONFIG_HOME/xray/config.json 2>/dev/null &

case $(uname) in
  Linux)
    export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
    export GDK_SCALE=2 GDK_DPI_SCALE=0.6
    export QT_SCREEN_SCALE_FACTORS=1 QT_AUTO_SCREEN_SCALE_FACTOR=true
    export GTK_IM_MODULE=fcitx5 QT_IM_MODULE=fcitx5 XMODIFIERS=@im=fcitx5
    _running udevmon || command -v udevmon >/dev/null 2>&1 && sudo nice -n -20 udevmon &
    _running crond   || command -v crond >/dev/null 2>&1 && sudo crond -n &
    _running X && return
    [[ $(tty) = '/dev/tty1' ]] && exec startx || exec zsh;;
  Darwin)
    disown 2>/dev/null;;
esac

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
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
export EMACSNATIVELOADPATH=$XDG_CACHE_HOME/emacs/eln-cache/
export GRANDVIEW_HOME=$XDG_CONFIG_HOME/emacs/

_running() { pgrep $1 >/dev/null 2>&1; }

[[ $(uname) == 'Linux' ]] && {
  export GDK_SCALE=2 GDK_DPI_SCALE=0.6
  export QT_SCREEN_SCALE_FACTORS=1 QT_AUTO_SCREEN_SCALE_FACTOR=true
  export GTK_IM_MODULE=fcitx5 QT_IM_MODULE=fcitx5 XMODIFIERS=@im=fcitx5
  export PATH=/usr/bin:$XDG_DATA_HOME/miniconda/bin:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  _running xray      || xray run -confdir $XDG_CONFIG_HOME/xray/ &
  _running udevmon   || sudo nice -n -20 udevmon &
  _running aria2c    || aria2c -i ~/.cache/aria2/aria2.session >/dev/null &
  _running crond     || sudo crond -n &
  _running gpg-agent || gpgconf --launch gpg-agent && gpg-connect-agent updatestartuptty /bye &
  # If the password prompt doesn't popup execute this:
  # gpg-connect-agent updatestartuptty /bye &
  _running X         && return
  [[ $(tty) = '/dev/tty1' ]] && exec startx || exec zsh
} || { # for macOS
  export PATH=/usr/bin:/bin:/usr/sbin:/sbin:$XDG_DATA_HOME/miniconda/bin:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
}


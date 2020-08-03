# Clean-up ~/
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export _Z_DATA=$XDG_DATA_HOME/z/.z
export LESSHISTFILE=$XDG_CACHE_HOME/less/lesshst
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export __GL_SHADER_DISK_CACHE_PATH=$XDG_CACHE_HOME/nv
export GOPATH=$XDG_DATA_HOME/go
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export RBENV_ROOT=$XDG_DATA_HOME/rbenv
export PATH=$PATH:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin
# Devices
export SOUND_DEVICE=alsa_output.usb-Focusrite_Scarlett_2i4_USB-00.analog-surround-40
# Programs
export EDITOR="nvim"
export MANPAGER="nvim +set\ filetype=man -"
# Scale (DPI)
export GDK_SCALE=2
export GDK_DPI_SCALE=0.6
export QT_SCREEN_SCALE_FACTORS=1
export QT_DEVICE_PIXEL_RATIO=2
export QT_AUTO_SCREEN_SCALE_FACTOR=true
# Input
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
# Proxy
export http_proxy=http://127.0.0.1:1088
export https_proxy=http://127.0.0.1:1088

# Start graphical interface (check if Xsession exists first)
[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx \
"$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1

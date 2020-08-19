#!/bin/sh

# TODO pacman cmd
ARCH_INSTALL=(
  base
  base-devel
  efibootmgr
  grub
  linux
  linux-firmware
  linux-headers
  networkmanager
)

PACMAN=(
  aria2
  bashtop
  bat
  bc
  bluez
  bluez-utils
  bspwm
  cifs-utils
  cronie
  fcitx
  fcitx-configtool
  fcitx-qt5
  fcitx-rime
  fd
  ffmpegthumbnailer
  flameshot
  fzf
  gcolor2
  gimp
  git
  go
  httpie
  jq
  kdenlive
  mediainfo
  mpv
  neofetch
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  nvidia
  nvidia-utils
  opencl-nvidia
  openssh
  pavucontrol
  playerctl
  privoxy
  pulseaudio
  pulseaudio-alsa
  python
  python-gobject
  python-pip
  ripgrep
  rofi
  shadowsocks-libev
  sxhkd
  sxiv
  thunar
  tmux
  tree
  ueberzug
  unrar
  unzip
  vifm
  xcape
  xclip
  xdg-user-dirs
  xdg-utils
  xdo
  xdotool
  xorg-fonts-encodings
  xorg-server
  xorg-xinit
  xorg-xsetroot
  youtube-dl
  zsh
)

# TODO build yay
YAY=(
  alacritty-git
  betterlockscreen-git
  brave-bin
  deadd-notification-center
  easystroke-git
  hfsprogs
  hid-apple-patched-git-dkms
  netease-cloud-music-gtk
  neovim-nightly
  otf-san-francisco-compact
  picom-ibhagwan-git
  polybar
  redshift-minimal
  surfn-arc-breeze-icons-git
  xidlehook
  xvkbd
  xwallpaper-git
)

# Using localectl to map 1. caps -> ctrl; 2. left+right shift -> caps
# This approach is much persistent than execute setxkbmap in ~/.xinitrc
# Settings below will not lost during bluetooth reconnection or plug/unplug keyboard
# See: https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration
localectl --no-convert set-x11-keymap us "" "" caps:ctrl_modifier,shift:both_capslock_cancel

curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash -s -- --install-dir $HOME/.local/bin --skip-shell

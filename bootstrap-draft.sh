#!/bin/sh
PACMAN=(
  alacritty-git
  aria2
  awesome-git
  base-devel
  bat
  betterlockscreen
  bluez-utils
  bpython
  bridge-utils
  cmake
  cronie
  deno
  exa
  fastjar
  fcitx5-gtk-git
  fcitx5-pinyin-moegirl-rime
  fcitx5-pinyin-zhwiki-rime
  fcitx5-qt6-git
  fcitx5-rime-git
  fd
  ffmpegthumbnailer
  flameshot-git
  font-victor-mono
  fzf
  gcolor2
  git-delta
  github-cli
  go
  htop
  httpie
  interception-dual-function-keys
  jq
  kdenlive
  nautilus
  neofetch
  nerd-fonts-victor-mono
  nvidia
  obs-studio
  openssh
  paru
  pass
  playerctl
  posix
  privoxy
  pulsemixer
  python-pyxdg
  python-qrcode
  python-qtconsole
  qliveplayer-git
  redis
  ripgrep
  rofi
  rustup
  screenkey
  shadowsocks-libev
  shadowsocks-v2ray-plugin
  smbnetfs
  socat
  sxiv
  ttf-fira-code
  ttf-sarasa-gothic
  unrar
  unzip
  wmctrl
  xdo
  xwallpaper
  yarn
  you-get
  youtube-dl
  z
  zip
  zsh-autosuggestions
  zsh-syntax-highlighting
)

AUR=(
  brave-nightly-bin
  danmaku2ass-git
  easystroke-git
  epub-thumbnailer-git
  fcitx5-skin-materia-exp
  fnm-bin
  picom-jonaburg-git
  pup
  python-ytmusicapi
  redshift-minimal
  wudao-dict-git
  xidlehook
  xvkbd
)

# Using localectl to map ctrl_alt_bksp -> kill X session
# This approach is much persistent than execute setxkbmap in ~/.xinitrc
# Settings below will not lost during bluetooth reconnection or plug/unplug keyboard
# See: https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration
localectl --no-convert set-x11-keymap us pc105 colemak terminate:ctrl_alt_bksp

timedatectl set-timezone "$(curl --fail https://ipapi.co/timezone)"

cd ~/Code/alex.files
git submodule init; git pull --recurse-submodules
~/Code/alex.files/local/bin/system/dothelper

sudo pacman -S --noconfirm reflector
sudo reflector --protocol https --age 2 --sort rate --country China --latest 5 --save /etc/pacman.d/mirrorlist
sudo pacman -S --noconfirm archlinuxcn-keyring
sudo pacman -Syu

cd ~/Code/alex.files/config/hid-apple-patched
./install.sh

sudo pacman -S --noconfirm ${PACMAN[@]}

[[ -n $(pidof privoxy) ]] || privoxy --no-daemon ~/.config/privoxy/config &
[[ -n $(pidof ss-local) ]] || ss-local -c ~/.config/shadowsocks/config.json &
export {HTTP_PROXY,HTTPS_PROXY}=http://127.0.0.1:1088

paru -S --noconfirm ${AUR[@]}

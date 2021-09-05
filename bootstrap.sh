#!/bin/sh
[[ $(whoami) == "root" ]] && {
  pacman -S base-devel zsh
  useradd -m -G wheel -s /bin/zsh alex
  mkdir /home/alex/Code
  mv ./alex.files /home/alex/Code/alex.files
  chown -R alex /home/alex/Code
  echo "Set password for user alex..."
  passwd alex
  read -p "Login as alex and run this script again. Logout now? (y/n)" reply
  [[ $reply == "y" ]] && logout
  exit 0
}

PACMAN=(
  alacritty-git
  aria2
  awesome-git
  bat
  betterlockscreen
  bluez
  bluez-utils
  cmake
  cronie
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
  interception-dual-function-keys
  jq
  nautilus
  neofetch
  nerd-fonts-victor-mono
  openssh
  paru
  pass
  playerctl
  posix
  privoxy
  pulseaudio
  python-pip
  qliveplayer-git
  ripgrep
  rofi
  rustup
  shadowsocks-libev
  shadowsocks-v2ray-plugin
  smbnetfs
  ttf-sarasa-gothic
  unrar
  unzip
  xdo
  xdotool
  xorg-server
  xorg-xinit
  xorg-xwininfo
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
  redshift-minimal
  xidlehook
  xvkbd
)

# Using localectl to map ctrl_alt_bksp -> kill X session
# This approach is much persistent than execute setxkbmap in ~/.xinitrc
# Settings below will not lost during bluetooth reconnection or plug/unplug keyboard
# See: https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration
[[ $COLEMAK == 1 ]] && { localectl --no-convert set-x11-keymap us pc105 colemak terminate:ctrl_alt_bksp; }

timedatectl set-timezone "$(curl --fail https://ipapi.co/timezone)"

systemctl enable bluetooth.service

cd ~/Code/alex.files
git submodule init; git pull --recurse-submodules
~/Code/alex.files/local/bin/system/dothelper

sudo pacman -S --noconfirm reflector
sudo reflector --protocol https --age 2 --sort rate --country China --latest 5 --save /etc/pacman.d/mirrorlist
sudo pacman -S --noconfirm archlinuxcn-keyring
sudo pacman -Syu

[[ $HID_APPLE_PATCH == 1 ]] && { cd ~/Code/alex.files/etc/hid-apple-patched; ./install.sh; }

sudo pacman -S --noconfirm ${PACMAN[@]}

read -p "Setup proxy now? (y/n)" reply
[[ $reply == "y" ]] && {
  cp ~/.config/shadowsocks/config.example.json ~/.config/shadowsocks/config.json
  read -p "Input your host name (eg. xxx.com): " HOST
  read -p "Input your password: " PASS
  sed -i "s/YOURHOST/$HOST/;s/YOURPASS/$PASS/" ~/.config/shadowsocks/config.json
  [[ -n $(pidof privoxy) ]] || privoxy --no-daemon ~/.config/privoxy/config &
  [[ -n $(pidof ss-local) ]] || ss-local -c ~/.config/shadowsocks/config.json &
  export {HTTP_PROXY,HTTPS_PROXY}=http://127.0.0.1:1088
}

paru -S --noconfirm ${AUR[@]}

read -p "Installation completed. Reboot now? (y/n)" reply
[[ $reply == "y" ]] && reboot

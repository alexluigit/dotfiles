#!/bin/sh
. /etc/vconsole

create_user() {
  read -p "Creating new user, input your username: " NEW_USER
  useradd -m -G wheel -s /bin/zsh $NEW_USER
  chown -R $NEW_USER /home/$NEW_USER/Code
  echo "Set password for user $NEW_USER..."
  passwd $NEW_USER
}

enable_services() {
  echo "Enabling essential services..."
  timedatectl set-timezone "$(curl --fail https://ipapi.co/timezone)"
  pacman -S bluez bluez-utils
  mv /etc/bluetooth/main.conf /etc/bluetooth/main.conf.old
  cp ./dotfiles/etc/bluetooth/main.conf /etc/bluetooth/main.conf
  systemctl enable bluetooth.service
}

setup_xkb() {
  echo "Setting up X keyboard..."
  localectl --no-convert set-x11-keymap us pc105 ${KEYMAP:-""} terminate:ctrl_alt_bksp
  mv /usr/share/X11/xkb/symbols/pc /usr/share/X11/xkb/symbols/pc.old
  cp ./local/share/X11/xkb/symbols/pc /usr/share/X11/xkb/symbols/pc
  cp ./local/share/X11/xkb/symbols/pc /usr/share/X11/xkb/symbols/pc-custom
}

mirrorlist() {
  echo "Refreshing mirrorlist..."
  pacman -S --noconfirm reflector
  reflector --protocol https --age 2 --sort rate --country China --latest 5 --save /etc/pacman.d/mirrorlist
  pacman -S --noconfirm archlinuxcn-keyring
  pacman -Syu
}

copy_repo() {
  echo "Creating dotfiles folder..."
  mkdir /home/$NEW_USER/Code
  mv ./dotfiles /home/$NEW_USER/Code/$NEW_USER.files
  echo "'/home/$NEW_USER/Code/$NEW_USER.files' created."
  echo "The folder '/home/$NEW_USER/Code/$NEW_USER.files' contains all the dotfiles, DO NOT delete it."
}

fetch_submodules() {
  cd ~/Code/$USER.files
  git submodule init; git pull --recurse-submodules
  ~/Code/$USER.files/local/bin/system/dothelper
  [[ $HID_APPLE_PATCH == 1 ]] && { cd ~/Code/$USER.files/etc/hid-apple-patched; ./install.sh; }
}

install_packages() {
  local packages_file=/home/$USER/Code/$USER.files/packages.csv
  sed '/^#/d' $packages_file > /tmp/pkgs.csv
  local pacman_pkgs=()
  local aur_pkgs=()
  while IFS=, read -r tag program comment; do
    case "$tag" in
      "A") aur_pkgs+=($program);;
      *) pacman_pkgs+=($program);;
    esac
  done < /tmp/pkgs.csv
  sudo pacman -S --noconfirm ${pacman_pkgs[@]}
  setup_proxy
  paru -S --noconfirm ${aur_pkgs[@]}
}

setup_proxy() {
  read -p "Setup proxy now? (y/n) " reply
  [[ $reply == "y" ]] && {
    cp ~/.config/shadowsocks/config.example.json ~/.config/shadowsocks/config.json
    read -p "Input your host name (eg. xxx.com): " HOST
    read -p "Input your password: " PASS
    sed -i "s/YOURHOST/$HOST/;s/YOURPASS/$PASS/" ~/.config/shadowsocks/config.json
    [[ -n $(pidof privoxy) ]] || privoxy --no-daemon /etc/privoxy/config &
    [[ -n $(pidof ss-local) ]] || ss-local -c ~/.config/shadowsocks/config.json &
    export {HTTP_PROXY,HTTPS_PROXY}=http://127.0.0.1:1088
  }
}

[[ $(whoami) == "root" ]] && {
  NEW_USER=
  pacman -S base-devel zsh xorg-server xorg-xinit
  create_user
  enable_services
  setup_xkb
  mirrorlist
  copy_repo
  read -p "Please login as $NEW_USER and run this script again. Logout now? (y/n) " reply
  [[ $reply == "y" ]] && logout
  exit 0
} || {
  install_packages
}

read -p "Installation completed. Reboot now? (y/n) " reply
[[ $reply == "y" ]] && reboot

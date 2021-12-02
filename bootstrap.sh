#!/bin/sh
. /etc/vconsole.conf
DOTPATH=${DOTPATH:-"/opt/dotfiles"}
[[ -d $(dirname $DOTPATH) ]] || mkdir -p $DOTPATH
CURR_USER=$(whoami)
NEW_USER=

create_user() {
  read -p "Creating new user, input your username: " NEW_USER
  useradd -m -G wheel -s /bin/zsh $NEW_USER
  echo "Creating dotfiles folder..."
  mv /root/dotfiles $DOTPATH
  chown -R $NEW_USER $DOTPATH
  echo "'$DOTPATH' created."
  echo "The folder $DOTPATH contains all the dotfiles, DO NOT delete it."
  echo "Set password for user $NEW_USER..."
  passwd $NEW_USER
}

enable_services() {
  echo "Enabling essential services..."
  timedatectl set-timezone "$(curl --fail https://ipapi.co/timezone)"
  pacman -S --asdeps --noconfirm bluez bluez-utils
  mv /etc/bluetooth/main.conf /etc/bluetooth/main.conf.old
  cp $DOTPATH/etc/bluetooth/main.conf /etc/bluetooth/main.conf
  systemctl enable bluetooth.service
}

setup_xkb() {
  echo "Setting up X keyboard..."
  localectl --no-convert set-x11-keymap us pc105 ${KEYMAP:-""} terminate:ctrl_alt_bksp
  mv /usr/share/X11/xkb/symbols/pc /usr/share/X11/xkb/symbols/pc.old
  cp ./local/share/X11/xkb/symbols/pc /usr/share/X11/xkb/symbols/pc
}

setup_zsh() {
  echo "Setting up zsh..."
  cp $DOTPATH/etc/zsh/.zshenv /etc/zsh/zshenv
  sudo sed -i "s|\\(export DOTPATH=\\).*|\1$DOTPATH|" /etc/zsh/zshenv
}

mirrorlist() {
  echo "Refreshing mirrorlist..."
  pacman -S --asdeps --noconfirm reflector
  reflector --protocol https --age 2 --sort rate --country China --latest 5 --save /etc/pacman.d/mirrorlist
  pacman -S --asdeps --noconfirm archlinuxcn-keyring
  pacman -Syu
}

fetch_submodules() {
  cd $DOTPATH
  git submodule init; git pull --recurse-submodules
  DOTPATH=$DOTPATH $DOTPATH/local/bin/system/dothelper
  [[ $HID_APPLE_PATCH == 1 ]] && { cd $DOTPATH/etc/hid-apple-patched; ./install.sh; }
}

install_packages() {
  local packages_file=$DOTPATH/packages.csv
  local local_pkg_dir="$DOTPATH"/local/share/paru/pkgs
  sed '/^#/d' $packages_file > /tmp/pkgs.csv
  local pacman_pkgs=(gcc rust paru miniconda)
  local aur_pkgs=() conda_pkgs=() cargo_pkgs=() local_pkgs=()
  while IFS=, read -r tag program comment; do
    case "$tag" in
      "AUR") aur_pkgs+=($program);;
      "CON") conda_pkgs+=($program);;
      "CAR") cargo_pkgs+=($program);;
      "LOC") local_pkgs+=($program);;
      "") pacman_pkgs+=($program);;
    esac
  done < /tmp/pkgs.csv
  sudo pacman -S --noconfirm ${pacman_pkgs[@]}
  setup_proxy
  setup_conda_base "${conda_pkgs[@]}"
  for pkg in ${cargo_pkgs[@]}; do
    cargo install ${pkg//_SPC_/ }
  done
  paru -S --noconfirm ${aur_pkgs[@]}
  for pkg in ${local_pkgs[@]}; do
    cp $local_pkg_dir/$pkg ~/.cache/paru/
    cd ~/.cache/paru/clone/$pkg
    makepkg -si --noconfirm
  done
  cd $DOTPATH
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

setup_conda_base() {
  sudo chown -R $CURR_USER /opt/miniconda
  source "/opt/miniconda/etc/profile.d/conda.sh"
  conda install -y -q -c conda-forge -n base ${@}
  conda list -n base
}

init_root() {
  pacman -S --asdeps --noconfirm zsh xorg-server xorg-xinit posix
  pacman -D --asdeps base linux linux-firmware linux-headers efibootmgr
  create_user
  enable_services
  setup_xkb
  mirrorlist
  setup_zsh
  read -p "Please login as $NEW_USER and run this script again. Logout now? (y/n) " reply
  [[ $reply == "y" ]] && logout
  exit 0
}

init_user() {
  fetch_submodules
  install_packages
  read -p "Setup conda base environment? (y/n) " reply
  [[ $reply == "y" ]] && setup_dev
}

[[ $CURR_USER == "root" ]] && init_root || init_user

read -p "Installation completed. Reboot now? (y/n) " reply
[[ $reply == "y" ]] && reboot

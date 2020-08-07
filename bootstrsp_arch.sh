#!/bin/sh
# TODO:
pacman -S balabala
PACMAN=(
  zsh
  networkmanager
  privoxy
  shadowsocks-libev

  xorg
  xserver
  xinit

  rofi
  bspwm
  sxhkd
  polybar
  easystroke
  cronie
)

YAY=(
  pixom
  xwallpaper
  xcape
)

# Using localectl to map 1. caps -> ctrl; 2. left+right shift -> caps
# This approach is much persistent than execute setxkbmap in ~/.xinitrc
# Settings below will not lost during bluetooth reconnection or plug/unplug keyboard
# See: https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration
localectl --no-convert set-x11-keymap us "" "" caps:ctrl_modifier,shift:both_capslock_cancel

# TODO: fnm, rust, golang, etc.
curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash -s -- --install-dir $HOME/.local/bin --skip-shell
# Bluetooth setting
# Privoxy config

#!/bin/sh
# Since almost all cmds in this script need root access, you have to run it as root
# TODO:
pacman -S balabala
PACKAGES=(
  zsh
  networkmanager
  privoxy
  shadowsocks-libev

  xorg
  xserver
  xinit

  rofi
  dunst
  bspwm
  sxhkd
  polybar
  easystroke
)

BUILDS=(
  pixom
  xwallpaper
  xcape
)

# Using localectl to map 1. caps -> ctrl; 2. left+right shift -> caps
# This approach is much persistent than execute setxkbmap in ~/.xinitrc
# Settings below will not lost during bluetooth reconnection or plug/unplug keyboard
# See: https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration
localectl --no-convert set-x11-keymap us "" "" caps:ctrl_modifier,shift:both_capslock

# Bluetooth setting
# Privoxy config

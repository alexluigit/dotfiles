#!/bin/sh
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

PACMAN=($(pacman -Qetq))
YAY=($(pacman -Qmq))

# Using localectl to map ctrl_alt_bksp -> kill X session
# This approach is much persistent than execute setxkbmap in ~/.xinitrc
# Settings below will not lost during bluetooth reconnection or plug/unplug keyboard
# See: https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration
# localectl --no-convert set-x11-keymap us pc105 colemak terminate:ctrl_alt_bksp
# localectl --no-convert set-keymap colemak

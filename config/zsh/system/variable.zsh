export DISPLAY_DEVICE=$(xrandr | awk '/ connected/{print $1}')
export SOUND_DEVICE=alsa_output.usb-Focusrite_Scarlett_2i4_USB-00.analog-surround-40
export WALLPAPER=/home/alex/Pictures/wallpaper/landscape-mountain-scenery-uhdpaper.com-4K-8.1485.jpg
export {HTTP_PROXY,HTTPS_PROXY}=http://127.0.0.1:1088

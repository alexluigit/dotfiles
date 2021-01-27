source $ZDOTDIR/system/const.zsh
source $ZDOTDIR/user/variable.zsh
source $ZDOTDIR/system/services.zsh

# only startx in tty1
[ $(tty) = "/dev/tty1" ] && ! pgrep X && \
exec ssh-agent startx ~/.config/x11/xinitrc -- ~/.config/x11/xserverrc vt1

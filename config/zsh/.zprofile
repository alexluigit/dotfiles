source $ZDOTDIR/system/const.zsh
source $ZDOTDIR/user/variable.zsh
test -e $FNM_MULTISHELL_PATH || fnm use default >/dev/null &

running() { pgrep $1 >/dev/null 2>&1; }
running aria2c   || aria2c -i ~/.cache/aria2/aria2.session &
running privoxy  || privoxy --no-daemon ~/.config/privoxy/config &
running ss-local || ss-local -c ~/.config/shadowsocks/config.json &
running mpd      || mpd &
running emacs    || emacs --daemon &
running udevmon  || sudo nice -n -20 udevmon -c ~/.config/interception/udevmon.yaml &

# only startx in tty1
[ $(tty) = "/dev/tty1" ] && ! pgrep X && \
exec ssh-agent startx ~/.config/x11/xinitrc -- ~/.config/x11/xserverrc vt1

source $ZDOTDIR/system/const.zsh
source $ZDOTDIR/user/variable.zsh
test -e $FNM_MULTISHELL_PATH || fnm use default >/dev/null &

pgrep aria2c   || aria2c -i ~/.cache/aria2/aria2.session &
pgrep privoxy  || privoxy --no-daemon ~/.config/privoxy/config &
pgrep ss-local || ss-local -c ~/.config/shadowsocks/config.json &
pgrep mpd      || mpd &
pgrep emacs    || emacs --daemon &
pgrep udevmon  || sudo nice -n -20 udevmon -c ~/.config/interception/udevmon.yaml &

# only startx in tty1
[ $(tty) = "/dev/tty1" ] && ! pgrep X && \
exec ssh-agent startx ~/.config/x11/xinitrc -- ~/.config/x11/xserverrc vt1

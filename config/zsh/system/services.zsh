test -e $FNM_MULTISHELL_PATH || fnm use default >/dev/null &
running() { pgrep $1 >/dev/null 2>&1; }
running aria2c   || aria2c -i ~/.cache/aria2/aria2.session &
running privoxy  || privoxy --no-daemon ~/.config/privoxy/config &
running ss-local || ss-local -c ~/.config/shadowsocks/config.json &
running mpd      || mpd &
running emacs    || emacs --daemon &
running udevmon  || doas nice -n -20 udevmon -c ~/.config/interception/udevmon.yaml &

runx() {
  if [ $(tty) = '/dev/tty1' ] && ! pgrep X; then
    exec ssh-agent startx ~/.config/x11/xinitrc -- ~/.config/x11/xserverrc vt1
  fi
}
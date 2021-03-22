_running() { pgrep $1 >/dev/null 2>&1; }
_startx() { exec ssh-agent startx ~/.config/x11/xinitrc -- ~/.config/x11/xserverrc vt1; }

system_init() {
  _running privoxy  || privoxy --no-daemon ~/.config/privoxy/config &
  _running ss-local || ss-local -c ~/.config/shadowsocks/config.json &
  _running mpd      || mpd &
  _running emacs    || emacs --daemon &
  _running udevmon  || doas nice -n -20 udevmon -c ~/.config/interception/udevmon.yaml &
  _running aria2c   || aria2c -i ~/.cache/aria2/aria2.session >/dev/null &
  _running X        && return
  [[ $(tty) = '/dev/tty1' ]] && _startx || exec zsh
}

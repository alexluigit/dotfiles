_set_title() { echo -ne "\e]2;$1\007"; }
_reset_title() { echo -ne "\e]2;Terminal\007"; }
_italic() { echo -ne "\e[3m$@\e[23m"; }
_inside_git_repo() { git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
_exec_if_exist() { command -v $1 &>/dev/null && "$1" || exit 0; }

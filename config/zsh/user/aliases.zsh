alias d="gio trash"
alias sn="sudoedit"
alias yd="youtube-dl --write-sub --write-auto-sub -o '~/Downloads/%(title)s-%(id)s.%(ext)s'"
alias ydl="youtube-dl --yes-playlist --write-sub --write-auto-sub -o '~/Downloads/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ls='exa -a --color=always --group-directories-first' # all files and dirs
alias la='exa -al --color=always --group-directories-first' # my preferred listing
alias ll='exa -lu --color=always --group-directories-first --no-user --no-permissions -@'  # long format
alias lt='exa -aT --color=always --git-ignore -I=.git --group-directories-first B' # tree listing
alias tls="exa -la --no-permissions --no-user $XDG_DATA_HOME/Trash/files"
alias tcl="rm -rf $XDG_DATA_HOME/Trash/{files,info}/*"
alias nope='node --experimental-repl-await ~/.config/node/repl.js'
alias pxon="export http_proxy=http://127.0.0.1:1088; export https_proxy=http://127.0.0.1:1088"
alias nopx="unset http_proxy; unset https_proxy"
alias -g B="| bat"
alias -g F="| fzf"
alias -g G="| rg"
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"
alias -g S="| sort -n -r"
alias -g W="| wc -l"

m() { _set_title nvim; man $@; _reset_title; } # make man page navigatable with xvimux
n() { _set_title nvim; nvim $@; _reset_title; } # samething for xvimux
g() {  [[ -z $@ ]] && _inside_git_repo && _fugitive || git $@; }
t() { _tmux_auto "$@"; }
mc() { mkdir -p $@ && cd ${@:$#}; } # make a dir and cd into it
pas() { pxon; _fzf_paru_S; }
pau() { pxon; paru "$@"; }
pal() { _fzf_paru_Rns; }

# general
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
alias proxyon="export http_proxy=http://127.0.0.1:1088; export https_proxy=http://127.0.0.1:1088"
alias noproxy="unset http_proxy; unset https_proxy"
alias -g B="| bat"
alias -g F="| fzf"
alias -g G="| rg"
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"
alias -g S="| sort -n -r"
alias -g W="| wc -l"

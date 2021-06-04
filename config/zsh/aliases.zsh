alias d="gio trash"
alias m="man"
alias n="nvim"
alias dh="~/Dev/alex.files/local/bin/system/dothelper"
alias yd="youtube-dl --write-sub --write-auto-sub -o '~/Downloads/%(title)s-%(id)s.%(ext)s'"
alias ydl="youtube-dl --yes-playlist --write-sub --write-auto-sub -o '~/Downloads/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ka="killall"
alias ls='exa -a --color=always --group-directories-first' # all files and dirs
alias la='exa -al --color=always --group-directories-first' # my preferred listing
alias ll='exa -lu --color=always --group-directories-first --no-user --no-permissions -@'  # long format
alias lt='exa -aT --color=always --git-ignore -I=.git --group-directories-first B' # tree listing
alias sudo="doas"
alias tcl="rm -rf {$XDG_DATA_HOME/Trash,/media/HDD/.Trash-1000}/{files,info}/{*,.*}"
alias px="export {HTTP_PROXY,HTTPS_PROXY}=http://127.0.0.1:1088"
alias nope='node --experimental-repl-await ~/.config/node/repl.js'
alias -g B="| bat"
alias -g F="| fzf"
alias -g G="| rg"
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"
alias -g S="| sort -n -r"
alias -g W="| wc -l"

g() { [[ -z $@ ]] && _inside_git_repo && _fugitive || git $@; }
mc() { mkdir -p $@ && cd ${@:$#}; } # make a dir and cd into it
sn() { _sudo_edit "$1"; }
pas() { _fzf_paru_S $@; }
pal() { _fzf_paru_Rns; }

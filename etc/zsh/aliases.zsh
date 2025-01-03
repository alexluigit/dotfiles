alias n="nvim"
alias yd="yt-dlp --write-sub --write-auto-sub -o '~/Downloads/%(title)s-%(id)s.%(ext)s'"
alias ydl="yt-dlp --yes-playlist --write-sub --write-auto-sub -o '~/Downloads/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ls='eza -a --color=always --group-directories-first' # all files and dirs
alias la='eza -al --color=always --group-directories-first' # my preferred listing
alias ll='eza -lu --color=always --group-directories-first --no-user --no-permissions -@'  # long format
alias tcl="sudo rm -rf {$XDG_DATA_HOME/Trash,/media/HDD/.Trash}/{files,info}/{*,.*}"
alias ka="killall"
alias np="unset {HTTP_PROXY,HTTPS_PROXY}"
alias sn="sudoedit"
alias rs="rsync"
alias rsa="rsync -avz"
alias vv="__venv_activate_current"
alias vvb="__venv_activate_base"
alias -g B="| bat"
alias -g F="| fzf"
alias -g G="| rg"
alias -g S="| sort -n -r"
alias -g W="| wc -l"
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"
showtime() { $_prompt_timer_enabled && _prompt_timer_enabled=false || _prompt_timer_enabled=true; }
mc() { mkdir -p $@ && cd ${@:$#}; } # make a dir and cd into it
man() { emacsclient -n -e "(man \"$1\")"; }

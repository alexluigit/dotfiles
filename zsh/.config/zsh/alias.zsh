# Use neovim for vim if present.
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d"
# Todo: use sshhost and fzf
alias md="mkdir -p"
alias rd="rmdir"
alias yd="youtube-dl --write-sub --write-auto-sub -o '~/Desktop/%(title)s-%(id)s.%(ext)s'"
alias ydl="youtube-dl --write-sub --write-auto-sub -o '~/Desktop/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ls="ls --group-directories-first --color=auto"
alias la="ls -Flha --group-directories-first --color=auto"
alias t="tmux -f ~/.config/tmux/tmux.conf new -A -s MAIN \; split-window -h \; select-pane -L \; resize-pane -Z"
alias ka="killall"
alias v='nvim -c "let g:tty='\''$(tty)'\''"'
# alias ssh='TERM=xterm ssh'
# Git


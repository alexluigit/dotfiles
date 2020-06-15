# Use neovim for vim if present.
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d"
# Todo: use sshhost and fzf
alias md="mkdir -p"
alias rd="rmdir"
alias yd="youtube-dl --write-sub --write-auto-sub -o '~/Desktop/%(title)s-%(id)s.%(ext)s'"
alias ydl="youtube-dl --yes-playlist --write-sub --write-auto-sub -o '~/Desktop/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ls="gls --group-directories-first --color=auto"
alias la="gls -Flha --group-directories-first --color=auto"
alias t="tmux-automation"
alias ka="killall"
alias v='nvim -c "let g:tty='\''$(tty)'\''"'
alias c="fzf-cd"
alias f="vifm"

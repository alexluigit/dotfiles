# Use neovim for vim if present.
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d"
# Todo: use sshhost and fzf
alias yd="youtube-dl --write-sub --write-auto-sub"
alias ytl="youtube-dl --write-sub --write-auto-sub -o '~/Desktop/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ls="gls --group-directories-first --color=auto"
alias la="gls -Flha --group-directories-first --color=auto"
# alias grep="grep --color=auto"
# alias xargs="gxargs"
alias tmux="tmux -f ~/.config/tmux/tmux.conf new -A -s MAIN \; split-window -h \; select-pane -L \; resize-pane -Z"
# alias diff="gdiff --color=auto"
alias ka="killall"
alias v='nvim -c "let g:tty='\''$(tty)'\''"'
# Change Dir
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
# Git
# alias g="git"
# function gc { git commit -m "$@"; }
# alias gco="git checkout"
# alias gcm="git checkout master";
# alias gs="git status";
# alias gpull="git pull";
# alias gf="git fetch";
# alias gfa="git fetch --all";
# alias gf="git fetch origin";
# alias gpush="git push";
# alias gd="git diff";
# alias ga="git add .";
# alias gb="git branch";
# alias gbr="git branch remote"
# alias gfr="git remote update"
# alias gbn="git checkout -B "
# alias grf="git reflog";
# alias grh="git reset HEAD~" # last commit
# alias gac="git add . && git commit -a -m "
# alias gsu="git gpush --set-upstream origin "
# alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"
# alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
# personal


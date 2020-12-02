# general
alias d="gio trash"
alias n='nvim -c "let g:tty='\''$(tty)'\''"'
alias sn="sudoedit"
alias ka="killall"
alias yd="youtube-dl --write-sub --write-auto-sub -o '~/Downloads/%(title)s-%(id)s.%(ext)s'"
alias ydl="youtube-dl --yes-playlist --write-sub --write-auto-sub -o '~/Downloads/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ls='exa -a --color=always --group-directories-first' # all files and dirs
alias la='exa -al --color=always --group-directories-first' # my preferred listing
alias ll='exa -lu --color=always --group-directories-first --no-user --no-permissions -@'  # long format
alias lt='exa -aT --color=always --git-ignore -I=.git --group-directories-first B' # tree listing
alias tls="exa -la --no-permissions --no-user $XDG_DATA_HOME/Trash"
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
mc() { mkdir -p $@ && cd ${@:$#} } # make a dir and cd into it

# git
alias g="inside-worktree && nvim -c Gstatus -c bd# || return 1"
alias fgb="fzf-git-branch"
alias fgl="fzf-git-log"
alias fgd="fzf-git-diff"
alias fgs="fzf-git-stash"

# pacman
pas() { local res=$(pacman -Ssq | fzf -m --preview="pacman -Si {}"); [[ -n $res ]] && sudo pacman -Syy $res }
yas() { proxyon; local res=$(cat ~/.config/yay/aurlist.txt | fzf -m --preview="yay -Si {}"); [[ -n $res ]] && yay -Syy $res }
pal() { local res=$(pacman -Qeq | fzf -m --preview="pacman -Si {}"); [[ -n $res ]] && sudo pacman -Rns $res }

# tmux automation
t() {
  # https://gist.github.com/lann/6771001
  local SOCK_SYMLINK=~/.config/ssh/ssh_auth_sock
  [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ] && ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
  _switch() { tmux switch -t $1 2>/dev/null || tmux a -t $1 }
  [[ -n $@ ]] && { env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux $@; return }
  local S_NAME=$(basename "${PWD//[.:]/_}")
  HAS_SESSION=$(tmux has-session -t=$S_NAME 2>/dev/null)
  [ $? -eq 0 ] && _switch $S_NAME || { [ -x .tmux ] && { tmux new -s $S_NAME -d && ./.tmux $S_NAME && _switch $S_NAME } \
  || env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -s $S_NAME -d && _switch $S_NAME }
}

# general
alias d="gio trash"
alias g="inside-worktree && nvim -c Gstatus -c bd# || return 1"
alias n='nvim -c "let g:tty='\''$(tty)'\''"'
alias sn="sudoedit"
alias ka="killall"
alias md="mkdir -p"
alias yd="youtube-dl --write-sub --write-auto-sub -o '~/Downloads/%(title)s-%(id)s.%(ext)s'"
alias ydl="youtube-dl --yes-playlist --write-sub --write-auto-sub -o '~/Downloads/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ls='exa -a --color=always --group-directories-first' # all files and dirs
alias la='exa -al --color=always --group-directories-first' # my preferred listing
alias ll='exa -lu --color=always --group-directories-first --no-user --no-permissions -@'  # long format
alias lt='exa -aT --color=always --git-ignore -I=.git --group-directories-first B' # tree listing
alias ssh="ssh -F $XDG_CONFIG_HOME/ssh/config"
alias ldot='ls -ld .*'
alias lsize='ls -1FSsh'
alias lart='ls -1aFcrt'
alias ssh-copy-id="ssh-copy-id -i $XDG_CONFIG_HOME/ssh/id_rsa"
alias nope='node --experimental-repl-await ~/.config/node/repl.js'
alias tls="exa -la --no-permissions --no-user $XDG_DATA_HOME/Trash"
alias tcl="rm -rf $XDG_DATA_HOME/Trash/{files,info}/*"
alias proxyon="export http_proxy=http://127.0.0.1:1088; export https_proxy=http://127.0.0.1:1088"
alias noproxy="unset http_proxy; unset https_proxy"
alias -g B="| bat"
alias -g F="| fzf"
alias -g G="| rg"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g S="| sort -n -r"
alias -g W="| wc -l"

# git
alias gaa="git commit --amend -v" # amend both msg and commit
alias gaf="git commit --amend --no-edit" # amend just commit
alias gam="git commit --amend --only -v --" #amend just msg
alias gco="git checkout"
alias gcm="git checkout master"
alias gcv="git commit -v"
alias get="git remote update --prune && git merge --ff-only" # updating all remotes and fast-forwarding to a specific one: eg. `git get upstream/master`
alias gfu="git fixup"
alias ghd="GIT_NO_PAGER=1 git loghelpers pretty_git_log -1" # just head
alias gnb="git checkout -b"
alias grw="git rewind"
alias gss="git status -s"
alias gst="git stash --keep-index" # stsh
alias gsa="git stash --include-untracked" # staash
alias gup="git loghelpers pretty_git_log --all origin/master..master" # unpushed
alias gbo="git loghelpers pretty_git_graph --all --simplify-by-decoration" # bone
alias gcp="git cherry-pick"
alias gct="git --no-pager log --oneline | wc -l" #count
alias gdp="git ls-tree -r HEAD | cut -c 13- | sort | uniq -D -w 40" # http://stackoverflow.com/questions/224687/git-find-duplicate-blobs-files-in-this-tree/8408640#8408640
alias gff="git merge --ff-only"
alias gfr="git remote update --prune"
alias glp="git loghelpers pretty_git_log --all" # log grep, in case forgit::log omit something
alias gra="git loghelpers pretty_git_graph --all"
alias gre="GIT_NO_PAGER=1 git loghelpers pretty_git_log --all -30" # recent
alias gwd="git --paginate diff --dirstat=cumulative,files,0"
alias fgb="fzf-git-branch"
alias fgl="fzf-git-log"
alias fgd="fzf-git-diff"
alias fgs="fzf-git-stash"

# pacman
pas() { local res=$(pacman -Ssq | fzf -m --preview="pacman -Si {}"); [[ -n $res ]] && sudo pacman -Syy $res }
yas() { proxyon; local res=$(cat ~/.config/yay/aurlist.txt | fzf -m --preview="yay -Si {}"); [[ -n $res ]] && yay -Syy $res }
pal() { local res=$(pacman -Qeq | fzf -m --preview="pacman -Si {}"); [[ -n $res ]] && sudo pacman -Rns $res }
mc() { mkdir -p $@ && cd ${@:$#} } # make a dir and cd into it

# tmux automation
t() {
  # https://gist.github.com/lann/6771001
  local SOCK_SYMLINK=~/.config/ssh/ssh_auth_sock
  [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ] && ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
  [[ -n "$@" ]] && { env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"; return }
  [ -x .tmux ] && { ./.tmux; return }
  local SESSION_NAME=$(basename "${$(pwd)//[.:]/_}")
  env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -A -s "$SESSION_NAME"
}

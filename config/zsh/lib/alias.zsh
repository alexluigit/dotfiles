# general
alias c="fzf-cd"
alias d="gio trash"
alias f="vifmrun ."
alias t="tmux-automation"
alias v='nvim -c "let g:tty='\''$(tty)'\''"'
alias ka="killall"
alias md="mkdir -p"
alias sv="sudoedit"
alias yd="youtube-dl --write-sub --write-auto-sub -o '~/Desktop/%(title)s-%(id)s.%(ext)s'"
alias ydl="youtube-dl --yes-playlist --write-sub --write-auto-sub -o '~/Desktop/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ls="ls --group-directories-first --color=auto"
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias ldot='ls -ld .*'
alias lsize='ls -1FSsh'
alias lart='ls -1aFcrt'
alias -g B="| bat"
alias -g F="| fzf"
alias -g G="| rg"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g S="| sort -n -r"
alias -g W="| wc -l"

# git
alias gap="git add -p"
alias gab="git abv"
alias gaa="git commit --amend -v" # amend both msg and commit
alias gaf="git commit --amend --no-edit" # amend just commit
alias gam="git commit --amend --only -v --" #amend just msg
alias gco="git checkout"
alias gcm="git checkout master"
alias gcv="git commit -v"
alias get="git remote update --prune && git merge --ff-only" # updating all remotes and fast-forwarding to a specific one: eg. `git get upstream/master`
alias gfu="git fixup"
alias ghd="GIT_NO_PAGER=1 git loghelpers pretty_git_log -1" # just head
alias gnb="git checkout -b" # new branch
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

# pacman
alias pas="fzf-pac-sync"
alias pal="fzf-pac-local"
alias pacupg="sudo pacman -Syu"
alias pacaur="pacman -Qm"
alias pacorp="pacman -Qdt"
alias pacrmo="sudo pacman -Rns $(pacman -Qtdq)" # remove orphan

# functions
mkcd() { mkdir -p $@ && cd ${@:$#} }

tmux-automation() {
  # https://gist.github.com/lann/6771001
  local SOCK_SYMLINK=~/.ssh/ssh_auth_sock
  [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ] && ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
  [[ -n "$@" ]] && { env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"; return }
  [ -x .tmux ] && { ./.tmux; return }
  local SESSION_NAME=$(basename "${$(pwd)//[.:]/_}")
  env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -A -s "$SESSION_NAME"
}

ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else; echo "'$1' is not a valid file"; fi
}

fzf-pac-sync() { sudo pacman -Syy $(pacman -Ssq | fzf -m --preview="pacman -Si {}") }
fzf-pac-local() { sudo pacman -Rns $(pacman -Qeq | fzf -m --preview="pacman -Si {}") }

z() {
  [[ -z "$*" ]] && cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')" \
  || { _last_z_args="$@"; _z "$@" }
}
zz() { cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")" }
alias j=z; alias jj=zz
